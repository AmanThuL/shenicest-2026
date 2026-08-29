using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Drops the marble spiral stair into the greenhouse interior at the place the source art
    /// puts it, rather than at a hand-dragged guess.
    /// <para>
    /// The assembled building (<c>GreenHouse1_Textured.fbx</c>) never carried the stair: the swap
    /// to the 782-face spiral happened in the ground truth
    /// (<c>GreenHouse1Glass_Preview_Whole.blend</c>) only, and the stair was exported as its own
    /// module afterwards. So the stair has to be re-registered against the building, and the
    /// building arrives in Unity through a different import scale (0.6045) than the stair (1.0)
    /// and under a scaled instance on top of that.
    /// </para>
    /// <para>
    /// Rather than trusting any of those numbers, this tool measures them: it reads the world
    /// bounds of four objects inside the placed building whose coordinates in the source blend are
    /// known, solves the source-to-world map from them, and lands the stair's bounding box on the
    /// mapped one. Move or rescale the building and re-running this still lands the stair correctly.
    /// </para>
    /// Menu: RootsDance > Place Greenhouse Spiral Stair. Idempotent; marks the scene dirty and
    /// leaves saving to whoever ran it.
    /// </summary>
    public static class GreenhouseSpiralStairBuilder
    {
        private const string k_StairMesh =
            "Assets/RootsDance/Meshes/Environment/GreenHouse1SpiralStair.fbx";

        private const string k_StairMaterial =
            "Assets/RootsDance/Materials/Environment/GreenHouse1/GreenHouse1SpiralStair.mat";

        private const string k_BuildingName = "GreenHouse1_Textured";
        private const string k_ObjectName = "GreenhouseSpiralStair";

        private const string k_EnvironmentScene =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment.unity";

        private const string k_PartScene =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment_2.unity";

        /// <summary>
        /// Landmark objects inside the building, with the bounding-box centre each one has in the
        /// source blend (Blender axes, Z up, metres). Measured off
        /// <c>GreenHouse1Glass_Preview_Whole.blend</c>; the assembled FBX sits in the same space
        /// shifted by a constant, which cancels out because every landmark carries the same shift.
        /// </summary>
        private static readonly string[] k_LandmarkNames =
        {
            "STAIR-M_T", "STAIR-R_T", "STAIR-L_T", "GROUD_T", "1F_T",
        };

        private static readonly Vector3[] k_LandmarkSource =
        {
            new Vector3(-15.8620f, -15.8622f, 0.6623f),
            new Vector3(15.8620f, -15.8622f, 0.6623f),
            new Vector3(-15.8620f, 15.8621f, 0.6623f),
            new Vector3(0.0000f, -0.0001f, 0.6623f),
            new Vector3(0.0001f, -0.0002f, 18.4833f),
        };

        /// <summary>Bounding box of <c>STAIR</c> in the same source space.</summary>
        private static readonly Vector3 k_StairSourceMin = new Vector3(-10.3880f, -10.6687f, 1.3716f);
        private static readonly Vector3 k_StairSourceMax = new Vector3(9.9747f, 9.3461f, 22.9314f);

        /// <summary>
        /// How far the three axis scales may disagree before the solve is treated as unusable.
        /// A non-uniformly scaled building would break the single-scale assumption below, and
        /// silently producing a squashed stair is worse than refusing.
        /// </summary>
        private const float k_ScaleTolerance = 0.02f;

        /// <summary>
        /// Batch entry point: opens the two interior scenes, places the stair and saves. The menu
        /// version deliberately leaves saving alone, but a headless run has nobody to press save.
        /// </summary>
        public static void PlaceBatch()
        {
            Scene environment = EditorSceneManager.OpenScene(k_EnvironmentScene, OpenSceneMode.Single);
            EditorSceneManager.OpenScene(k_PartScene, OpenSceneMode.Additive);
            Place();
            EditorSceneManager.SaveScene(environment);
            Debug.Log("GreenhouseSpiralStairBuilder: batch placement saved.");
        }

        [MenuItem("RootsDance/Place Greenhouse Spiral Stair")]
        public static void Place()
        {
            GameObject building = FindBuilding();

            if (building == null)
            {
                Debug.LogError($"GreenhouseSpiralStairBuilder: no '{k_BuildingName}' in any loaded "
                    + "scene. Open GreenhouseInterior_Environment (plus the part scene you want "
                    + "the stair in) and run this again.");
                return;
            }

            Vector3[] landmarks = new Vector3[k_LandmarkNames.Length];

            for (int i = 0; i < k_LandmarkNames.Length; i++)
            {
                Transform found = FindDescendant(building.transform, k_LandmarkNames[i]);

                if (found == null || !TryWorldBounds(found.gameObject, out Bounds bounds))
                {
                    Debug.LogError($"GreenhouseSpiralStairBuilder: landmark '{k_LandmarkNames[i]}' "
                        + $"not found under '{building.name}', or it has no renderer. The building "
                        + "export changed shape; re-measure the landmarks before trusting this tool.");
                    return;
                }

                landmarks[i] = bounds.center;
            }

            // The world images of the source X, Y and Z unit vectors, each measured across a pair
            // of landmarks that differ along that axis alone.
            Vector3 axisX = (landmarks[1] - landmarks[0])
                / (k_LandmarkSource[1].x - k_LandmarkSource[0].x);
            Vector3 axisY = (landmarks[2] - landmarks[0])
                / (k_LandmarkSource[2].y - k_LandmarkSource[0].y);
            Vector3 axisZ = (landmarks[4] - landmarks[3])
                / (k_LandmarkSource[4].z - k_LandmarkSource[3].z);

            float scale = (axisX.magnitude + axisY.magnitude + axisZ.magnitude) / 3f;

            if (scale <= Mathf.Epsilon
                || Mathf.Abs(axisX.magnitude - scale) > scale * k_ScaleTolerance
                || Mathf.Abs(axisY.magnitude - scale) > scale * k_ScaleTolerance
                || Mathf.Abs(axisZ.magnitude - scale) > scale * k_ScaleTolerance)
            {
                Debug.LogError("GreenhouseSpiralStairBuilder: the building is scaled non-uniformly "
                    + $"({axisX.magnitude:F4} / {axisY.magnitude:F4} / {axisZ.magnitude:F4} per "
                    + "source metre). Refusing to place the stair rather than squashing it.");
                return;
            }

            Vector3 sourceCentre = (k_StairSourceMin + k_StairSourceMax) * 0.5f;
            Vector3 targetCentre = landmarks[0]
                + axisX * (sourceCentre.x - k_LandmarkSource[0].x)
                + axisY * (sourceCentre.y - k_LandmarkSource[0].y)
                + axisZ * (sourceCentre.z - k_LandmarkSource[0].z);

            GameObject stair = GetOrCreateStair(building);

            if (stair == null)
            {
                return;
            }

            // The stair FBX went through the same exporter as the building, so identity rotation
            // against the building's own rotation already aligns their axes; only the scale and
            // the offset are unknown, and both were just measured.
            stair.transform.rotation = building.transform.rotation;
            SetWorldScale(stair.transform, scale);

            if (!TryWorldBounds(stair, out Bounds placed))
            {
                Debug.LogError("GreenhouseSpiralStairBuilder: the instantiated stair has no "
                    + "renderer; the mesh import is broken.");
                return;
            }

            // Land the box rather than the pivot: asset_prepare re-origins every module, so where
            // the pivot sits inside the mesh is the pipeline's business, not this tool's.
            stair.transform.position += targetCentre - placed.center;

            MeshCollider meshCollider = stair.GetComponentInChildren<MeshCollider>();

            if (meshCollider == null)
            {
                MeshFilter filter = stair.GetComponentInChildren<MeshFilter>();

                if (filter != null)
                {
                    meshCollider = Undo.AddComponent<MeshCollider>(filter.gameObject);
                    meshCollider.sharedMesh = filter.sharedMesh;
                }
            }

            AssignMaterial(stair);
            GameObjectUtility.SetStaticEditorFlags(stair, StaticEditorFlags.ContributeGI
                | StaticEditorFlags.OccluderStatic | StaticEditorFlags.OccludeeStatic
                | StaticEditorFlags.BatchingStatic | StaticEditorFlags.ReflectionProbeStatic);

            EditorSceneManager.MarkSceneDirty(stair.scene);
            Selection.activeGameObject = stair;

            TryWorldBounds(stair, out placed);
            Vector3 expected = (k_StairSourceMax - k_StairSourceMin) * scale;
            Debug.Log($"GreenhouseSpiralStairBuilder: placed '{k_ObjectName}' in "
                + $"'{stair.scene.name}' at {stair.transform.position}, {scale:F4} world units per "
                + $"source metre. Bounds {placed.size} against the mapped {expected} — save the "
                + "scene to keep it.", stair);
        }

        private static GameObject FindBuilding()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                GameObject[] roots = scene.GetRootGameObjects();

                for (int r = 0; r < roots.Length; r++)
                {
                    if (roots[r].name == k_BuildingName)
                    {
                        return roots[r];
                    }

                    Transform found = FindDescendant(roots[r].transform, k_BuildingName);

                    if (found != null)
                    {
                        return found.gameObject;
                    }
                }
            }

            return null;
        }

        private static Transform FindDescendant(Transform root, string name)
        {
            if (root.name == name)
            {
                return root;
            }

            for (int i = 0; i < root.childCount; i++)
            {
                Transform found = FindDescendant(root.GetChild(i), name);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        private static bool TryWorldBounds(GameObject go, out Bounds bounds)
        {
            Renderer[] renderers = go.GetComponentsInChildren<Renderer>();
            bounds = new Bounds();

            if (renderers.Length == 0)
            {
                return false;
            }

            bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return true;
        }

        private static GameObject GetOrCreateStair(GameObject building)
        {
            // A sibling of the building rather than a child of it: the building is a prefab
            // instance, and parenting into one turns every future re-import into a merge.
            Transform parent = building.transform.parent;
            Transform existing = parent == null
                ? FindRoot(building.scene, k_ObjectName)
                : FindDescendant(parent, k_ObjectName);

            if (existing != null)
            {
                Undo.RecordObject(existing.transform, "Place Greenhouse Spiral Stair");
                return existing.gameObject;
            }

            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(k_StairMesh);

            if (source == null)
            {
                Debug.LogError($"GreenhouseSpiralStairBuilder: '{k_StairMesh}' is missing. Run the "
                    + "pipeline for GreenHouse1SpiralStair first.");
                return null;
            }

            GameObject stair = (GameObject)PrefabUtility.InstantiatePrefab(source, building.scene);
            stair.name = k_ObjectName;
            stair.transform.SetParent(parent, true);
            Undo.RegisterCreatedObjectUndo(stair, "Place Greenhouse Spiral Stair");
            return stair;
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        private static void SetWorldScale(Transform transform, float worldScale)
        {
            Transform parent = transform.parent;
            Vector3 parentScale = parent == null ? Vector3.one : parent.lossyScale;

            transform.localScale = new Vector3(
                parentScale.x == 0f ? worldScale : worldScale / parentScale.x,
                parentScale.y == 0f ? worldScale : worldScale / parentScale.y,
                parentScale.z == 0f ? worldScale : worldScale / parentScale.z);
        }

        private static void AssignMaterial(GameObject stair)
        {
            Material marble = AssetDatabase.LoadAssetAtPath<Material>(k_StairMaterial);

            if (marble == null)
            {
                Debug.LogWarning($"GreenhouseSpiralStairBuilder: '{k_StairMaterial}' is missing. "
                    + "Run RootsDance > Build Prop Materials, then this tool again.");
                return;
            }

            Renderer[] renderers = stair.GetComponentsInChildren<Renderer>();

            for (int i = 0; i < renderers.Length; i++)
            {
                Material[] materials = renderers[i].sharedMaterials;
                bool changed = false;

                for (int m = 0; m < materials.Length; m++)
                {
                    if (materials[m] != marble)
                    {
                        materials[m] = marble;
                        changed = true;
                    }
                }

                if (changed)
                {
                    Undo.RecordObject(renderers[i], "Place Greenhouse Spiral Stair");
                    renderers[i].sharedMaterials = materials;
                }
            }
        }
    }
}
