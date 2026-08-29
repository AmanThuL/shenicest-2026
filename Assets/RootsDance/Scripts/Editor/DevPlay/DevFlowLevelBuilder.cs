using System.Collections.Generic;
using RootsDance.Data;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// Builds the flow-testing level: the same ground and the same light as Main, with none of its
    /// dressing.
    /// <para>
    /// <c>Main_Environment</c> holds 1072 prefab instances. Testing a trigger, a transmission or a
    /// report entry needs none of them, and paying for all of them on every Play is most of the
    /// wait. This produces a second level that loads <c>Main_Gameplay</c> over a bare terrain, so
    /// the flow can be played in a fraction of the time.
    /// </para>
    /// <para>
    /// The ground is the <em>same</em> <c>TerrainData</c> asset at the same transform, not a plane:
    /// the route climbs from roughly y=3 at the spawn to y=6.7 at the grass belt, and every trigger
    /// volume in <c>Main_Gameplay</c> is placed against that surface. A flat floor would leave the
    /// later ones hanging in the air, which is exactly the kind of difference that makes a
    /// dev-only shortcut untrustworthy.
    /// </para>
    /// <para>
    /// The light and the global volume are copied from Main for the same reason: exposure decides
    /// whether anything is readable at all, and a test level that looks nothing like the game
    /// stops being a test of the game.
    /// </para>
    /// Regenerating overwrites the scene — it is generated, not authored, and nothing should be
    /// dressed in it. Menu: RootsDance &gt; Dev &gt; Build Flow Level.
    /// </summary>
    public static class DevFlowLevelBuilder
    {
        private const string k_ScenePath = "Assets/RootsDance/Scenes/Levels/Main/Main_DevGround.unity";
        private const string k_LevelPath = "Assets/RootsDance/Data/Levels/Main_Flow.asset";
        private const string k_GameplayPath = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";

        // Read off Main_Environment. Kept as constants rather than by copying the objects across,
        // because copying would drag in whatever else got parented under them since.
        private const string k_TerrainDataPath = "Assets/RootsDance/Scenes/Levels/Main/Main_TerrainData.asset";
        private const string k_TerrainMaterialGuid = "372bd30721a404944bdd44c2c999bf20";
        private const string k_GlobalProfilePath = "Assets/RootsDance/Settings/VolumeProfiles/MainProfile.asset";

        private static readonly Vector3 k_TerrainPosition = new Vector3(-144f, -8f, -32f);
        private static readonly Quaternion k_SunRotation =
            new Quaternion(0.40821794f, -0.23456973f, 0.10938166f, 0.8754261f);
        /// <summary>Lux, straight out of <c>Data/Config/TimeOfDay/Day.asset</c>.</summary>
        private const float k_SunIntensity = 12000f;

        private static readonly Color k_SunColor = new Color(1f, 0.96f, 0.88f, 1f);

        [MenuItem("RootsDance/Dev/Build Flow Level")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("[Dev] Flow level cancelled: current scenes have unsaved changes.");
                return;
            }

            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();

            Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);

            BuildTerrain(scene);
            BuildSun(scene);
            BuildVolume(scene);

            EditorSceneManager.SaveScene(scene, k_ScenePath);

            LevelSO level = BuildLevel();
            RegisterScene();

            // Read what the log needs before restoring: opening a scene Single unloads unreferenced
            // assets, and nothing loaded references this one yet, so the object is destroyed by the
            // line below. DevPlaySession hit the same trap on 2026-08-27.
            string levelName = level.name;

            if (setup != null && setup.Length > 0)
            {
                EditorSceneManager.RestoreSceneManagerSetup(setup);
            }

            Debug.Log($"[Dev] Flow level ready: {k_LevelPath} loads {k_ScenePath} + Main_Gameplay. "
                + $"Pick '{levelName}' in the Dev Play window; the 1072 dressing instances in "
                + "Main_Environment are not loaded.");
        }

        private static void BuildTerrain(Scene scene)
        {
            TerrainData data = AssetDatabase.LoadAssetAtPath<TerrainData>(k_TerrainDataPath);

            if (data == null)
            {
                Debug.LogError($"[Dev] No terrain data at {k_TerrainDataPath}; the flow level has no "
                    + "ground and the player will fall through it.");
                return;
            }

            GameObject host = new GameObject("Terrain_Main");
            SceneManager.MoveGameObjectToScene(host, scene);
            host.transform.position = k_TerrainPosition;

            // Fully qualified: this file sits in RootsDance.Editor.DevPlay, and RootsDance.Editor
            // also has a Terrain namespace (the greybox generators), which wins the lookup over
            // UnityEngine.Terrain.
            UnityEngine.Terrain terrain = host.AddComponent<UnityEngine.Terrain>();
            terrain.terrainData = data;
            terrain.drawInstanced = true;
            terrain.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;

            string materialPath = AssetDatabase.GUIDToAssetPath(k_TerrainMaterialGuid);
            Material material = AssetDatabase.LoadAssetAtPath<Material>(materialPath);

            if (material != null)
            {
                terrain.materialTemplate = material;
            }

            // Same data, so the collider matches the visible surface exactly — which is the whole
            // point of reusing it.
            host.AddComponent<TerrainCollider>().terrainData = data;
        }

        /// <summary>
        /// A fixed daylight sun, matching the Day preset (12000 lux, 1/0.96/0.88).
        /// <para>
        /// Main drives its sun from <c>TimeOfDayController</c>, whose HD light data carries an
        /// intensity of 0 until the controller writes one. Copying that arrangement here would
        /// mean copying the controller and its two volumes as well, and a flow test does not
        /// change time of day — so this pins the value the Day preset would have produced.
        /// </para>
        /// <para>
        /// <c>HDAdditionalLightData</c> is added explicitly: a Light created from code does not get
        /// one, and HDRP reads shadows and every other HD-only setting off it.
        /// </para>
        /// </summary>
        private static void BuildSun(Scene scene)
        {
            GameObject host = new GameObject("Sun");
            SceneManager.MoveGameObjectToScene(host, scene);
            host.transform.rotation = k_SunRotation;

            Light light = host.AddComponent<Light>();
            light.type = LightType.Directional;
            light.lightUnit = LightUnit.Lux;
            light.intensity = k_SunIntensity;
            light.color = k_SunColor;
            light.shadows = LightShadows.Soft;

            host.AddComponent<HDAdditionalLightData>();
        }

        private static void BuildVolume(Scene scene)
        {
            GameObject host = new GameObject("Global Volume");
            SceneManager.MoveGameObjectToScene(host, scene);

            Volume volume = host.AddComponent<Volume>();
            volume.isGlobal = true;
            volume.priority = 0f;
            volume.sharedProfile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_GlobalProfilePath);
        }

        private static LevelSO BuildLevel()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_LevelPath);

            if (level == null)
            {
                level = ScriptableObject.CreateInstance<LevelSO>();
                AssetDatabase.CreateAsset(level, k_LevelPath);
            }

            SerializedObject serialized = new SerializedObject(level);
            SerializedProperty paths = serialized.FindProperty("m_scenePaths");
            paths.arraySize = 2;
            paths.GetArrayElementAtIndex(0).stringValue = k_ScenePath;
            paths.GetArrayElementAtIndex(1).stringValue = k_GameplayPath;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            EditorUtility.SetDirty(level);
            AssetDatabase.SaveAssets();

            return level;
        }

        /// <summary>
        /// Adds the ground scene to the build list, disabled — the same way the PlayerTest scenes
        /// are listed. Dev Play opens scenes through the Editor and does not need the entry, but a
        /// scene missing from the list cannot be loaded by the runtime loader either, and a
        /// disabled entry costs nothing in a build.
        /// </summary>
        private static void RegisterScene()
        {
            List<EditorBuildSettingsScene> scenes =
                new List<EditorBuildSettingsScene>(EditorBuildSettings.scenes);

            for (int i = 0; i < scenes.Count; i++)
            {
                if (scenes[i].path == k_ScenePath)
                {
                    return;
                }
            }

            scenes.Add(new EditorBuildSettingsScene(k_ScenePath, false));
            EditorBuildSettings.scenes = scenes.ToArray();
        }
    }
}
