using System;
using System.Collections.Generic;
using System.Linq;
using RootsDance.App;
using RootsDance.Cameras;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.Events;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Builds the player-free Chapter House part scenes loaded with Briggs Interior.</summary>
    public static class ChapterHouseConnectedLevelBuilder
    {
        private const string k_BriggsGameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_BriggsEnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_BriggsLevelPath = "Assets/RootsDance/Data/Levels/BriggsInterior.asset";
        private const string k_ConnectedProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/ChapterHouseConnectedProfile.asset";
        private const string k_FlagRaisedPath = "Assets/RootsDance/Data/Events/FlagRaised.asset";
        private const string k_LegacyPortalName = "BriggsChapterHousePortal";
        private const float k_LabDoorPlaneZ = 7.22f;

        /// <summary>Creates both part scenes and adds them to the Briggs level load set.</summary>
        public static void Build(ChapterHouseRoundEntranceBuilder.Placement placement)
        {
            Vector3 offset = new Vector3(
                -placement.OpeningCentre.x,
                -placement.FloorY,
                k_LabDoorPlaneZ - (placement.OpeningCentre.z - placement.CorridorLength));

            BuildEnvironment(offset);
            BuildGameplay(offset);
            ConfigureBriggsEnvironment();
            ConfigureBriggsGameplay();
            ConfigureBriggsLevel();
            ConfigureConnectedCheckpoints();
            RescueCheckpointExporter.RefreshCatalog();
            RegisterScenesInBuildSettings();
        }

        /// <summary>Removes the obsolete laboratory-to-Chapter-House teleport from a scene.</summary>
        public static void RemoveLegacyPortal(Scene gameplay)
        {
            GameObject[] roots = gameplay.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int j = 0; j < transforms.Length; j++)
                {
                    if (transforms[j].name == k_LegacyPortalName)
                    {
                        UnityEngine.Object.DestroyImmediate(transforms[j].gameObject);
                        return;
                    }
                }
            }
        }

        private static void BuildEnvironment(Vector3 offset)
        {
            Scene source = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorEnvironment, OpenSceneMode.Single);
            EditorSceneManager.SaveScene(source, ScenePaths.k_ChapterHouseConnectedEnvironment, true);
            Scene connected = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseConnectedEnvironment, OpenSceneMode.Single);

            DestroyByName(connected, "ClothLandscape_CorridorShell");
            OffsetRoots(connected, offset, new[] { "_Lighting", "_Geometry", "_Props", "_NavMesh" });
            ConfigureConnectedLighting(connected);

            EditorSceneManager.MarkSceneDirty(connected);
            EditorSceneManager.SaveScene(connected);
        }

        private static void ConfigureBriggsEnvironment()
        {
            Scene environment = EditorSceneManager.OpenScene(k_BriggsEnvironmentPath, OpenSceneMode.Single);
            Transform garageShell = FindTransform(environment, "GarageShell");
            Transform structure = FindTransform(environment, "PlanCollisionShell");

            if (garageShell == null || structure == null)
            {
                throw new InvalidOperationException(
                    "Briggs environment must contain GarageShell and PlanCollisionShell.");
            }

            Transform sourceFloor = FindDescendant(garageShell, "Floor");
            Renderer sourceRenderer = sourceFloor != null ? sourceFloor.GetComponent<Renderer>() : null;

            if (sourceRenderer == null || sourceRenderer.sharedMaterial == null)
            {
                throw new InvalidOperationException("Briggs GarageShell has no reusable floor surface.");
            }

            sourceRenderer.enabled = false;
            Transform existing = FindTransform(environment, "BriggsVisualFloor_18x14m");

            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }

            GameObject floor = GameObject.CreatePrimitive(PrimitiveType.Cube);
            floor.name = "BriggsVisualFloor_18x14m";
            SceneManager.MoveGameObjectToScene(floor, environment);
            floor.transform.SetParent(structure, false);
            floor.transform.localPosition = new Vector3(0f, -0.01f, 0f);
            floor.transform.localScale = new Vector3(18f, 0.02f, 14f);
            floor.GetComponent<Renderer>().sharedMaterial = sourceRenderer.sharedMaterial;
            UnityEngine.Object.DestroyImmediate(floor.GetComponent<BoxCollider>());
            floor.isStatic = true;

            EditorSceneManager.MarkSceneDirty(environment);
            EditorSceneManager.SaveScene(environment);
        }

        private static void ConfigureConnectedLighting(Scene connected)
        {
            GameObject lighting = connected.GetRootGameObjects()
                .FirstOrDefault(candidate => candidate.name == "_Lighting");

            if (lighting == null)
            {
                throw new InvalidOperationException("Chapter House connected scene has no _Lighting root.");
            }

            DestroyByName(connected, "Sun");

            Light[] lights = lighting.GetComponentsInChildren<Light>(true);
            Light[] fills = lights.Where(light =>
                light.name.StartsWith("ChapterHouseFill_", StringComparison.Ordinal)).ToArray();
            Light[] underglow = lights.Where(light =>
                light.name.StartsWith("ChapterHouseUnderglow_", StringComparison.Ordinal)).ToArray();

            if (fills.Length != 4 || fills.Any(light => light.type != LightType.Point)
                || underglow.Length != 4 || underglow.Any(light => light.type != LightType.Point)
                || lights.Length != fills.Length + underglow.Length)
            {
                throw new InvalidOperationException(
                    "Connected Chapter House lighting must keep four fill and four underglow lights only.");
            }

            Transform volumeTransform = FindTransform(connected, "Global Volume");
            Transform building = FindTransform(connected, "ChapterHouseRoot");

            if (volumeTransform == null || building == null)
            {
                throw new InvalidOperationException(
                    "Connected Chapter House local volume cannot find its source volume or building bounds.");
            }

            Volume volume = volumeTransform.GetComponent<Volume>();

            if (volume == null || volume.sharedProfile == null || volume.sharedProfile.name != "MainProfile")
            {
                throw new InvalidOperationException(
                    "Connected Chapter House must derive its local lighting volume from MainProfile.");
            }

            Bounds bounds = CalculateRendererBounds(building.gameObject);
            volume.sharedProfile = RebuildConnectedVolumeProfile(volume.sharedProfile);
            volumeTransform.name = "ChapterHouse Local Volume";
            volumeTransform.position = bounds.center;
            volume.isGlobal = false;
            volume.priority = 10f;
            volume.blendDistance = 4f;
            volume.weight = 1f;

            BoxCollider collider = volumeTransform.GetComponent<BoxCollider>();

            if (collider == null)
            {
                collider = volumeTransform.gameObject.AddComponent<BoxCollider>();
            }

            collider.center = Vector3.zero;
            collider.size = bounds.size;
            collider.isTrigger = true;
        }

        private static VolumeProfile RebuildConnectedVolumeProfile(VolumeProfile source)
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_ConnectedProfilePath);

            if (profile == null)
            {
                profile = ScriptableObject.CreateInstance<VolumeProfile>();
                profile.name = "ChapterHouseConnectedProfile";
                AssetDatabase.CreateAsset(profile, k_ConnectedProfilePath);
            }
            else
            {
                for (int i = profile.components.Count - 1; i >= 0; i--)
                {
                    UnityEngine.Object.DestroyImmediate(profile.components[i], true);
                }

                profile.components.Clear();
            }

            for (int i = 0; i < source.components.Count; i++)
            {
                VolumeComponent copy = UnityEngine.Object.Instantiate(source.components[i]);
                copy.name = source.components[i].name;
                copy.hideFlags = HideFlags.HideInInspector | HideFlags.HideInHierarchy;
                profile.components.Add(copy);
                AssetDatabase.AddObjectToAsset(copy, profile);
            }

            IndirectLightingController indirect = GetOrAddProfileComponent<IndirectLightingController>(profile);
            indirect.indirectDiffuseLightingMultiplier.Override(1f);
            indirect.reflectionLightingMultiplier.Override(1f);
            indirect.reflectionProbeIntensityMultiplier.Override(1f);

            ColorAdjustments colour = GetOrAddProfileComponent<ColorAdjustments>(profile);
            colour.postExposure.Override(0f);
            colour.contrast.Override(0f);
            colour.colorFilter.Override(Color.white);
            colour.hueShift.Override(0f);
            colour.saturation.Override(0f);

            Vignette vignette = GetOrAddProfileComponent<Vignette>(profile);
            vignette.intensity.Override(0f);

            WhiteBalance whiteBalance = GetOrAddProfileComponent<WhiteBalance>(profile);
            whiteBalance.temperature.Override(0f);
            whiteBalance.tint.Override(0f);

            profile.Reset();
            EditorUtility.SetDirty(profile);
            AssetDatabase.SaveAssetIfDirty(profile);
            return profile;
        }

        private static T GetOrAddProfileComponent<T>(VolumeProfile profile)
            where T : VolumeComponent
        {
            if (profile.TryGet(out T component))
            {
                return component;
            }

            component = profile.Add<T>(true);
            AssetDatabase.AddObjectToAsset(component, profile);
            return component;
        }

        private static Bounds CalculateRendererBounds(GameObject root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException("Cannot derive local volume bounds without renderers.");
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void BuildGameplay(Vector3 offset)
        {
            Scene source = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseInteriorGameplay, OpenSceneMode.Single);
            EditorSceneManager.SaveScene(source, ScenePaths.k_ChapterHouseConnectedGameplay, true);
            Scene connected = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseConnectedGameplay, OpenSceneMode.Single);

            DestroyRoot(connected, "_Cameras");
            DestroyRoot(connected, "_Spawns");
            DestroyRoot(connected, "Player");
            OffsetRoots(
                connected,
                offset,
                new[] { "_Anchors", "_Narrative", "_Triggers", "_Interactables" });

            EditorSceneManager.MarkSceneDirty(connected);
            EditorSceneManager.SaveScene(connected);
        }

        private static void ConfigureBriggsGameplay()
        {
            Scene gameplay = EditorSceneManager.OpenScene(k_BriggsGameplayPath, OpenSceneMode.Single);
            RemoveLegacyPortal(gameplay);
            Transform camera = FindTransform(gameplay, "FirstPersonCamera");

            if (camera == null)
            {
                throw new InvalidOperationException("Briggs gameplay has no FirstPersonCamera.");
            }

            PanicViewShake shake = camera.GetComponent<PanicViewShake>();

            if (shake == null)
            {
                shake = camera.gameObject.AddComponent<PanicViewShake>();
            }

            StringEventChannelSO flagRaised = AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_FlagRaisedPath);

            if (flagRaised == null)
            {
                throw new InvalidOperationException("The FlagRaised channel is missing: " + k_FlagRaisedPath);
            }

            using (SerializedObject serialized = new SerializedObject(shake))
            {
                serialized.FindProperty("m_flagRaised").objectReferenceValue = flagRaised;
                serialized.FindProperty("m_lookBackOnFlag").stringValue = WorldFlags.k_FlowerSpriteAppeared;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);
        }

        private static void ConfigureBriggsLevel()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_BriggsLevelPath);

            if (level == null)
            {
                throw new InvalidOperationException("Briggs level asset missing: " + k_BriggsLevelPath);
            }

            string[] scenePaths =
            {
                "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity",
                k_BriggsGameplayPath,
                "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment_2.unity",
                ScenePaths.k_ChapterHouseConnectedEnvironment,
                ScenePaths.k_ChapterHouseConnectedGameplay,
            };

            using (SerializedObject serialized = new SerializedObject(level))
            {
                SerializedProperty paths = serialized.FindProperty("m_scenePaths");
                paths.arraySize = scenePaths.Length;

                for (int i = 0; i < scenePaths.Length; i++)
                {
                    paths.GetArrayElementAtIndex(i).stringValue = scenePaths[i];
                }

                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            EditorUtility.SetDirty(level);
            AssetDatabase.SaveAssetIfDirty(level);
        }

        private static void ConfigureConnectedCheckpoints()
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(k_BriggsLevelPath);
            Scene gameplay = EditorSceneManager.OpenScene(
                ScenePaths.k_ChapterHouseConnectedGameplay, OpenSceneMode.Single);
            ConfigureCheckpoint(
                gameplay,
                "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/02-04A_CorridorEntrance.asset");
            ConfigureCheckpoint(
                gameplay,
                "Assets/RootsDance/Data/DevPlay/ChapterHouseInterior/02-04B_FlowerSpriteEncounter.asset");

            void ConfigureCheckpoint(Scene scene, string assetPath)
            {
                DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(assetPath);

                if (checkpoint == null)
                {
                    throw new InvalidOperationException("Connected checkpoint missing: " + assetPath);
                }

                Transform anchor = FindTransform(scene, checkpoint.AnchorName);

                if (anchor == null)
                {
                    throw new InvalidOperationException(
                        "Connected checkpoint anchor missing: " + checkpoint.AnchorName);
                }

                checkpoint.Configure(
                    checkpoint.Label,
                    level,
                    checkpoint.AnchorName,
                    anchor.position,
                    anchor.eulerAngles.y,
                    checkpoint.TimeOfDay,
                    checkpoint.Flags.ToArray(),
                    checkpoint.RecordedTargets.ToArray(),
                    false,
                    checkpoint.GroundLayers.value,
                    0f,
                    true);
                EditorUtility.SetDirty(checkpoint);
                AssetDatabase.SaveAssetIfDirty(checkpoint);
            }
        }

        private static void RegisterScenesInBuildSettings()
        {
            List<EditorBuildSettingsScene> scenes = EditorBuildSettings.scenes.ToList();
            AddSceneIfMissing(scenes, ScenePaths.k_ChapterHouseConnectedEnvironment);
            AddSceneIfMissing(scenes, ScenePaths.k_ChapterHouseConnectedGameplay);
            EditorBuildSettings.scenes = scenes.ToArray();
        }

        private static void AddSceneIfMissing(List<EditorBuildSettingsScene> scenes, string path)
        {
            if (scenes.Any(scene => scene.path == path))
            {
                return;
            }

            scenes.Add(new EditorBuildSettingsScene(path, true));
        }

        private static void OffsetRoots(Scene scene, Vector3 offset, string[] names)
        {
            HashSet<string> accepted = new HashSet<string>(names, StringComparer.Ordinal);
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (accepted.Contains(roots[i].name))
                {
                    roots[i].transform.position += offset;
                }
            }
        }

        private static void DestroyRoot(Scene scene, string name)
        {
            GameObject root = scene.GetRootGameObjects().FirstOrDefault(candidate => candidate.name == name);

            if (root != null)
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void DestroyByName(Scene scene, string name)
        {
            Transform target = FindTransform(scene, name);

            if (target != null)
            {
                UnityEngine.Object.DestroyImmediate(target.gameObject);
            }
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int j = 0; j < transforms.Length; j++)
                {
                    if (transforms[j].name == name)
                    {
                        return transforms[j];
                    }
                }
            }

            return null;
        }

        private static Transform FindDescendant(Transform root, string name)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                if (transforms[i].name == name)
                {
                    return transforms[i];
                }
            }

            return null;
        }
    }
}
