using System;
using System.Linq;
using RootsDance.App;
using RootsDance.Data;
using RootsDance.Environment;
using RootsDance.Events;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Places the seam to the greenhouse behind chapel door D: a black transition surface and a
    /// <see cref="LevelPortal"/> volume the player can only reach after the door has swung open
    /// and they have stepped through the doorway. The door itself stays a plain
    /// <see cref="SwingDoor"/> in the environment scene — it only opens; this only travels.
    /// </summary>
    public static class ChapterHouseGreenhousePortalBuilder
    {
        private const string k_PrefabPath =
            "Assets/RootsDance/Prefabs/Environment/ChapterHouseGreenhousePortal.prefab";
        private const string k_PortalName = "ChapterHouseGreenhousePortal";

        /// <summary>The exit door. The other three chapel doors open but lead nowhere.</summary>
        public const string k_DoorName = "ChapterHouseDoor_D";

        [MenuItem("RootsDance/Environment/Apply Chapter House Greenhouse Portal")]
        public static void Apply()
        {
            if (EditorApplication.isPlaying)
            {
                throw new InvalidOperationException("Stop Play mode before placing the portal.");
            }
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                if (SceneManager.GetSceneAt(i).isDirty)
                {
                    throw new InvalidOperationException("Save pending scene edits before placing the portal.");
                }
            }

            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();
            try
            {
                ApplyToScenes();
            }
            finally
            {
                EditorSceneManager.RestoreSceneManagerSetup(setup);
            }
        }

        /// <summary>Also called by the level builder, so a geometry rebuild retains the transition.</summary>
        public static void ApplyToScenes()
        {
            Scene environment = GetOrOpenScene(ScenePaths.k_ChapterHouseInteriorEnvironment);
            Bounds doorway = MeasureDoorway(environment);
            Scene gameplay = GetOrOpenScene(ScenePaths.k_ChapterHouseInteriorGameplay);
            PlaceInScene(gameplay, doorway);
            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);
        }

        private static Scene GetOrOpenScene(string path)
        {
            Scene scene = SceneManager.GetSceneByPath(path);
            return scene.isLoaded ? scene : EditorSceneManager.OpenScene(path, OpenSceneMode.Additive);
        }

        /// <summary>
        /// The closed door leaf, in world space. Everything the portal needs — doorway centre,
        /// sill height, how far the opening leaf can reach — is derived from it, so the portal
        /// follows the door wherever the next blockout pass moves it. Not the door's approach
        /// trigger: that is sized for opening the door from metres away, not for the doorway.
        /// </summary>
        private static Bounds MeasureDoorway(Scene environment)
        {
            GameObject door = environment.GetRootGameObjects()
                .SelectMany(root => root.GetComponentsInChildren<Transform>(true))
                .Select(transform => transform.gameObject)
                .FirstOrDefault(candidate => candidate.name == k_DoorName);
            if (door == null)
            {
                throw new InvalidOperationException("The exit door was not found: " + k_DoorName);
            }
            if (door.transform.rotation != Quaternion.identity)
            {
                // The placement below offsets along world Z; a rotated door would need the offset
                // taken along its own forward axis instead.
                throw new InvalidOperationException(k_DoorName + " is no longer axis-aligned.");
            }

            Renderer leaf = door.GetComponentInChildren<Renderer>(true);
            if (leaf == null)
            {
                throw new InvalidOperationException(k_DoorName + " has no leaf renderer to measure.");
            }

            Bounds doorway = leaf.bounds;
            // The placement stands the black surface 1.5 m behind the closed plane; a leaf whose
            // 100° arc reaches further than 1 m would sweep through it.
            if (doorway.size.x + 0.5f > 1.45f)
            {
                throw new InvalidOperationException(k_DoorName + "'s leaf is too wide for the portal placement.");
            }

            return doorway;
        }

        private static void PlaceInScene(Scene gameplay, Bounds doorway)
        {
            LevelSO level = AssetDatabase.LoadAssetAtPath<LevelSO>(
                "Assets/RootsDance/Data/Levels/GreenhouseInterior.asset");
            LevelEventChannelSO channel = AssetDatabase.LoadAssetAtPath<LevelEventChannelSO>(
                "Assets/RootsDance/Data/Events/LoadLevelRequested.asset");
            int triggerLayer = LayerMask.NameToLayer("TriggerVolume");
            if (level == null || channel == null || triggerLayer < 0)
            {
                throw new InvalidOperationException("The greenhouse level, load channel and trigger layer are required.");
            }

            Material black = BriggsChapterHousePortalBuilder.EnsureBlackMaterial();
            Scene preview = EditorSceneManager.NewPreviewScene();
            GameObject prefab;
            try
            {
                var root = new GameObject(k_PortalName);
                SceneManager.MoveGameObjectToScene(root, preview);
                root.layer = triggerLayer;
                BoxCollider trigger = root.AddComponent<BoxCollider>();
                // With the root 1.45 m behind the door plane (see the placement below), this
                // volume's front face sits 0.5 m past the plane — beyond the probe's 0.45 m
                // radius, so it cannot fire from the corridor side of the doorway, only once the
                // player has stepped through. It reaches a metre below the sill so the load still
                // fires if the chapel side has no floor to stand on yet.
                trigger.center = new Vector3(0f, 1f, -0.7f);
                trigger.size = new Vector3(2.8f, 4f, 0.5f);
                trigger.isTrigger = true;
                root.AddComponent<LevelPortal>().Configure(channel, level);

                GameObject surface = GameObject.CreatePrimitive(PrimitiveType.Cube);
                surface.name = "BlackTransitionSurface";
                surface.transform.SetParent(root.transform, false);
                surface.transform.localPosition = new Vector3(0f, 1.7f, 0.05f);
                surface.transform.localScale = new Vector3(3.5f, 3.4f, 0.08f);
                UnityEngine.Object.DestroyImmediate(surface.GetComponent<Collider>());
                MeshRenderer renderer = surface.GetComponent<MeshRenderer>();
                renderer.sharedMaterial = black;
                renderer.shadowCastingMode = ShadowCastingMode.Off;
                renderer.receiveShadows = false;
                prefab = PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath);
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            Transform triggers = gameplay.GetRootGameObjects()
                .Single(root => root.name == "_Triggers").transform;
            Transform existing = triggers.Find(k_PortalName);
            if (existing != null)
            {
                UnityEngine.Object.DestroyImmediate(existing.gameObject);
            }
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, gameplay);
            instance.transform.SetParent(triggers, false);
            // The leaf swings 100° around a hinge at the doorway's edge, so its sweep can reach at
            // most the leaf's width past the closed plane — MeasureDoorway guarantees that width
            // leaves the black surface (at local Z 0.05) out of the arc.
            instance.transform.position = new Vector3(
                doorway.center.x,
                doorway.min.y,
                doorway.center.z + 1.45f);
            PrefabUtility.RecordPrefabInstancePropertyModifications(instance.transform);
        }
    }
}
