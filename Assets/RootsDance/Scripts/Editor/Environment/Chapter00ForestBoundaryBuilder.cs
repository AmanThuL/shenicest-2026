using System;
using RootsDance.App;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Builds the invisible collision shell behind the Chapter 00 forest perimeter.</summary>
    public static class Chapter00ForestBoundaryBuilder
    {
        private const string k_Menu = "RootsDance/Environment/Build Chapter 00 Forest Boundary (No Save)";
        private const string k_GroupName = "ForestBoundaryCollisionShell";
        private const string k_RouteBlockersName = "RouteBlockers";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/Environment/";
        private const float k_Height = 14f;
        private const float k_Thickness = 2f;
        private const float k_Overlap = 1.5f;

        private static readonly Vector2[] k_Perimeter =
        {
            new Vector2(-25f, -32f),
            new Vector2(25f, -32f),
            new Vector2(35f, -15f),
            new Vector2(39f, 10f),
            new Vector2(43f, 38f),
            new Vector2(51f, 66f),
            new Vector2(56f, 100f),
            new Vector2(55f, 136f),
            new Vector2(48f, 165f),
            new Vector2(24f, 174f),
            new Vector2(-30f, 171f),
            new Vector2(-41f, 142f),
            new Vector2(-45f, 106f),
            new Vector2(-42f, 72f),
            new Vector2(-36f, 42f),
            new Vector2(-34f, 14f),
            new Vector2(-31f, -8f),
        };

        [MenuItem(k_Menu)]
        public static void Build()
        {
            Scene scene = SceneManager.GetSceneByPath(ScenePaths.k_MainEnvironment);
            if (!scene.IsValid() || !scene.isLoaded)
            {
                Debug.LogError("Chapter00ForestBoundaryBuilder: Main Environment must be open.");
                return;
            }

            UnityEngine.Terrain terrain = FindTerrain(scene);
            Transform geometry = FindRoot(scene, "_Geometry");
            if (terrain == null || geometry == null)
            {
                Debug.LogError("Chapter00ForestBoundaryBuilder: Main Environment terrain or _Geometry is missing.");
                return;
            }

            Transform oldGroup = geometry.Find(k_GroupName);
            if (oldGroup != null)
            {
                Undo.DestroyObjectImmediate(oldGroup.gameObject);
            }

            GameObject groupObject = new GameObject(k_GroupName);
            Undo.RegisterCreatedObjectUndo(groupObject, "Build Chapter 00 Forest Boundary");
            groupObject.transform.SetParent(geometry, false);
            GameObjectUtility.SetStaticEditorFlags(groupObject, StaticEditorFlags.BatchingStatic);

            for (int i = 0; i < k_Perimeter.Length; i++)
            {
                Vector2 from = k_Perimeter[i];
                Vector2 to = k_Perimeter[(i + 1) % k_Perimeter.Length];
                CreateSegment(groupObject.transform, terrain, from, to, i);
            }

            BuildRouteBlockers(scene, terrain);

            EditorSceneManager.MarkSceneDirty(scene);
            Selection.activeGameObject = groupObject;
            Debug.Log($"Chapter00ForestBoundaryBuilder: built route blockers and {k_Perimeter.Length} "
                + "invisible wall segments. "
                + "Main Environment is dirty and has NOT been saved.");
        }

        private static void BuildRouteBlockers(Scene scene, UnityEngine.Terrain terrain)
        {
            Transform props = FindRoot(scene, "_Props");
            if (props == null)
            {
                return;
            }

            Transform oldGroup = props.Find(k_RouteBlockersName);
            if (oldGroup != null)
            {
                Undo.DestroyObjectImmediate(oldGroup.gameObject);
            }

            GameObject routeBlockers = new GameObject(k_RouteBlockersName);
            routeBlockers.transform.SetParent(props, false);
            Undo.RegisterCreatedObjectUndo(routeBlockers, "Build Chapter 00 Route Blockers");

            GameObject lab = new GameObject("LabPassageNaturalBlocker");
            lab.transform.SetParent(routeBlockers.transform, false);
            PlacePrefab(lab.transform, terrain, "Vegetation/M3D_bush-2.prefab", "Bush", 39.2f, 102.5f,
                18f, 1.35f, 0f);
            PlacePrefab(lab.transform, terrain, "Vegetation/M3D_fern-1.prefab", "Fern", 39.8f, 105.3f,
                212f, 1f, 0f);
            PlacePrefab(lab.transform, terrain, "Rocks/rock_moss_03.prefab", "MossRock", 40.1f, 101.4f,
                64f, 1.55f, -.08f);
            PlacePrefab(lab.transform, terrain, "Vegetation/M3D_alder_2.prefab", "Alder", 41.3f, 103.8f,
                28f, 7.2f, -.08f);
            PlacePrefab(lab.transform, terrain, "Rocks/single_root.prefab", "Root", 40.2f, 105.8f,
                116f, 1.45f, -.1f);
            PlacePrefab(lab.transform, terrain, "Vegetation/tree03_summer.prefab", "Tree", 41.2f, 107.3f,
                146f, 6.8f, -.08f);

            GameObject fence = new GameObject("GrassBeltRightFence");
            fence.transform.SetParent(routeBlockers.transform, false);
            Vector2[] nodes =
            {
                new Vector2(-9.8f, 29f),
                new Vector2(-8.6f, 32.6f),
                new Vector2(-7.8f, 36.2f),
            };
            int counter = 0;
            for (int i = 0; i + 1 < nodes.Length; i++)
            {
                counter = BuildFenceSegment(fence.transform, terrain, nodes[i], nodes[i + 1], counter, i > 0);
            }
        }

        private static int BuildFenceSegment(
            Transform parent,
            UnityEngine.Terrain terrain,
            Vector2 from,
            Vector2 to,
            int counter,
            bool skipFirstPost)
        {
            Vector2 direction = to - from;
            int modules = Mathf.CeilToInt(direction.magnitude / .9f);
            float yaw = Mathf.Atan2(-direction.y, direction.x) * Mathf.Rad2Deg;

            for (int i = 0; i <= modules; i++)
            {
                if (i > 0 || !skipFirstPost)
                {
                    Vector2 point = Vector2.Lerp(from, to, i / (float)modules);
                    string post = i == 0 || i == modules
                        ? "Facility/chainlink_post_end.prefab"
                        : "Facility/chainlink_post.prefab";
                    PlacePrefab(parent, terrain, post, $"FencePost_{counter:00}", point.x, point.y,
                        yaw + i * 37f, 0f, -.04f, (i % 3 - 1) * 4f);
                    counter++;
                }

                if (i == modules)
                {
                    continue;
                }

                Vector2 midpoint = Vector2.Lerp(from, to, (i + .5f) / modules);
                PlacePrefab(parent, terrain, "Facility/chainlink_panel.prefab", $"FencePanel_{counter:00}",
                    midpoint.x, midpoint.y, yaw, 0f, -.04f, (i % 3 - 1) * 4f);
                counter++;
            }

            return counter;
        }

        private static GameObject PlacePrefab(
            Transform parent,
            UnityEngine.Terrain terrain,
            string relativePath,
            string name,
            float x,
            float z,
            float yaw,
            float targetHeight,
            float sink,
            float lean = 0f)
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PrefabFolder + relativePath);
            if (prefab == null)
            {
                throw new InvalidOperationException("Missing route blocker prefab: " + relativePath);
            }

            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parent);
            if (instance == null)
            {
                throw new InvalidOperationException("Could not instantiate route blocker prefab: " + relativePath);
            }

            instance.name = name;
            instance.transform.position = new Vector3(x, 0f, z);
            instance.transform.rotation = Quaternion.Euler(0f, yaw, lean);

            if (targetHeight > 0f)
            {
                Bounds sourceBounds = RendererBounds(instance);
                if (sourceBounds.size.y > .001f)
                {
                    instance.transform.localScale *= targetHeight / sourceBounds.size.y;
                }
            }

            float groundHeight = terrain.SampleHeight(new Vector3(x, 0f, z)) + terrain.transform.position.y;
            Bounds bounds = RendererBounds(instance);
            instance.transform.position += Vector3.up * (groundHeight - bounds.min.y + sink);
            Undo.RegisterCreatedObjectUndo(instance, "Build Chapter 00 Route Blockers");
            return instance;
        }

        private static Bounds RendererBounds(GameObject instance)
        {
            Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);
            if (renderers.Length == 0)
            {
                return new Bounds(instance.transform.position, Vector3.one);
            }

            Bounds bounds = renderers[0].bounds;
            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static void CreateSegment(
            Transform parent,
            UnityEngine.Terrain terrain,
            Vector2 from,
            Vector2 to,
            int index)
        {
            Vector2 direction = to - from;
            Vector2 midpoint = (from + to) * .5f;
            float groundHeight = terrain.SampleHeight(new Vector3(midpoint.x, 0f, midpoint.y))
                + terrain.transform.position.y;

            GameObject segment = new GameObject($"BoundaryWall_{index:00}");
            segment.transform.SetParent(parent, false);
            segment.transform.position = new Vector3(midpoint.x, groundHeight + k_Height * .5f - 2f, midpoint.y);
            segment.transform.rotation = Quaternion.Euler(
                0f,
                Mathf.Atan2(direction.x, direction.y) * Mathf.Rad2Deg - 90f,
                0f);
            BoxCollider collider = segment.AddComponent<BoxCollider>();
            collider.size = new Vector3(direction.magnitude + k_Overlap, k_Height, k_Thickness);
            collider.isTrigger = false;
            GameObjectUtility.SetStaticEditorFlags(segment, StaticEditorFlags.BatchingStatic);
        }

        private static UnityEngine.Terrain FindTerrain(Scene scene)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                UnityEngine.Terrain terrain = root.GetComponentInChildren<UnityEngine.Terrain>(true);
                if (terrain != null)
                {
                    return terrain;
                }
            }

            return null;
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root.transform;
                }
            }

            return null;
        }
    }
}
