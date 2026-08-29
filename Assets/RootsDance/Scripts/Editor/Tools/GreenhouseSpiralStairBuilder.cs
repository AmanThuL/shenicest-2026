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
    /// module afterwards. So the stair has to be re-registered against the building, and the two
    /// do not even share a unit: a source metre is about 0.60 world units through the building and
    /// about 0.01 through the stair, with a scaled instance on top of that.
    /// </para>
    /// <para>
    /// Rather than trusting any of those numbers, this tool measures them: it reads the world
    /// bounds of five objects inside the placed building whose coordinates in the source blend are
    /// known, solves the source-to-world map from them, and fits the stair's own bounding box onto
    /// the mapped one. Move or rescale the building, or re-export either mesh, and re-running this
    /// still lands the stair correctly.
    /// </para>
    /// Menu: RootsDance > Place Greenhouse Spiral Stair, over whichever scenes are open.
    /// Idempotent; marks the scene dirty and leaves saving to whoever ran it. <see cref="PlaceBatch"/>
    /// is the headless version and covers every scene in <see cref="k_BatchScenes"/>.
    /// </summary>
    public static class GreenhouseSpiralStairBuilder
    {
        private const string k_StairMesh =
            "Assets/RootsDance/Meshes/Environment/GreenHouse1SpiralStair.fbx";

        private const string k_StairMaterial =
            "Assets/RootsDance/Materials/Environment/GreenHouse1/GreenHouse1SpiralStair.mat";

        private const string k_BuildingName = "GreenHouse1_Textured";
        private const string k_ObjectName = "GreenhouseSpiralStair";

        /// <summary>
        /// Every scene that carries a copy of the greenhouse. The building is placed once per
        /// level (the interior level and the overworld each hold their own instance, at their own
        /// scale), so the stair has to be placed once per level too.
        /// </summary>
        private static readonly string[] k_BatchScenes =
        {
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment.unity",
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity",
        };

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
        /// How far the fitted stair box may differ in shape from the mapped source box before the
        /// placement is refused. Past this the mesh is not the object the source box was measured
        /// on, and no single scale will make it fit.
        /// </summary>
        private const float k_ShapeRefuseTolerance = 0.25f;

        /// <summary>
        /// Batch entry point: opens each scene holding the greenhouse in turn, places the stair
        /// and saves. The menu version deliberately leaves saving alone, but a headless run has
        /// nobody to press save. Exits non-zero if any scene fails, so a batch run cannot report
        /// success after quietly placing nothing.
        /// </summary>
        public static void PlaceBatch()
        {
            int failed = 0;

            for (int i = 0; i < k_BatchScenes.Length; i++)
            {
                Scene scene = EditorSceneManager.OpenScene(k_BatchScenes[i], OpenSceneMode.Single);

                if (TryPlace())
                {
                    EditorSceneManager.SaveScene(scene);
                    Debug.Log($"GreenhouseSpiralStairBuilder: saved '{k_BatchScenes[i]}'.");
                }
                else
                {
                    failed++;
                }
            }

            Debug.Log($"GreenhouseSpiralStairBuilder: batch placement finished, {failed} failed of "
                + $"{k_BatchScenes.Length}.");

            // Exit here rather than leaving it to -quit: batch mode otherwise spends five
            // minutes waiting on the overworld scene's async imports before it gives up.
            EditorApplication.Exit(failed > 0 ? 1 : 0);
        }

        [MenuItem("RootsDance/Place Greenhouse Spiral Stair")]
        public static void Place()
        {
            TryPlace();
        }

        /// <summary>Places the stair in whichever loaded scene holds the greenhouse.</summary>
        /// <returns>True when the stair was placed; false after any logged error.</returns>
        public static bool TryPlace()
        {
            GameObject building = FindBuilding();

            if (building == null)
            {
                Debug.LogError($"GreenhouseSpiralStairBuilder: no '{k_BuildingName}' in any loaded "
                    + "scene. Open a scene that holds the greenhouse — GreenhouseInterior_Environment "
                    + "or Main_Environment — and run this again.");
                return false;
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
                    return false;
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
                return false;
            }

            Vector3 sourceCentre = (k_StairSourceMin + k_StairSourceMax) * 0.5f;
            Vector3 targetCentre = landmarks[0]
                + axisX * (sourceCentre.x - k_LandmarkSource[0].x)
                + axisY * (sourceCentre.y - k_LandmarkSource[0].y)
                + axisZ * (sourceCentre.z - k_LandmarkSource[0].z);

            GameObject stair = GetOrCreateStair(building);

            if (stair == null)
            {
                return false;
            }

            // The stair FBX went through the same exporter as the building, so identity rotation
            // against the building's own rotation already aligns their axes. The scale does not
            // carry over though: the pipeline exports each module on its own, and this one arrives
            // roughly a hundredth of the building's metre. So measure the stair's own box while it
            // is unrotated and unscaled, and fit that box onto the mapped one. Comparing the box
            // diagonals rather than the axes keeps the fit independent of how the exporter
            // permuted X, Y and Z.
            stair.transform.rotation = Quaternion.identity;
            SetWorldScale(stair.transform, 1f);

            if (!TryWorldBounds(stair, out Bounds raw) || raw.size.magnitude <= Mathf.Epsilon)
            {
                Debug.LogError("GreenhouseSpiralStairBuilder: the instantiated stair has no "
                    + "renderer, or no size at all; the mesh import is broken.");
                return false;
            }

            Vector3 mapped = (k_StairSourceMax - k_StairSourceMin) * scale;
            float fit = mapped.magnitude / raw.size.magnitude;

            float shapeError = BoxMismatch(raw.size * fit, mapped);

            if (shapeError > k_ShapeRefuseTolerance)
            {
                Debug.LogError($"GreenhouseSpiralStairBuilder: the stair mesh is {raw.size * fit} "
                    + $"once fitted, against the mapped {mapped} — {shapeError:P0} off. That is a "
                    + "different shape, not a different scale; the export or the measured source "
                    + "box is stale. Refusing to place it.");
                return false;
            }

            if (shapeError > k_ScaleTolerance)
            {
                Debug.LogWarning($"GreenhouseSpiralStairBuilder: the fitted stair box "
                    + $"{raw.size * fit} is {shapeError:P0} off the mapped {mapped}. Placing it "
                    + "anyway, but the export and the measured source box have drifted apart.");
            }

            // Where the box centre sits relative to the pivot, in the stair's own space: the
            // pipeline re-origins every module, so the pivot is not the centre, and once the stair
            // is rotated its world bounding box no longer centres on the mesh's own centre either.
            Vector3 centreOffset = raw.center - stair.transform.position;
            SetWorldScale(stair.transform, fit);
            centreOffset *= fit;
            stair.transform.rotation = building.transform.rotation;

            // Land the box rather than the pivot: asset_prepare re-origins every module, so where
            // the pivot sits inside the mesh is the pipeline's business, not this tool's.
            stair.transform.position = targetCentre - stair.transform.rotation * centreOffset;

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

            Debug.Log($"GreenhouseSpiralStairBuilder: placed '{k_ObjectName}' in "
                + $"'{stair.scene.name}' at {stair.transform.position}, {scale:F4} world units per "
                + $"source metre, stair mesh fitted at {fit:F4}. Box {raw.size * fit} against the "
                + $"mapped {mapped}.", stair);

            return true;
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

        /// <summary>
        /// How far two axis-aligned box sizes disagree, as a fraction of the second one's largest
        /// disagreeing side. The FBX exporter is free to reorder the axes, so the sides are
        /// compared as a sorted set rather than one by one.
        /// </summary>
        private static float BoxMismatch(Vector3 a, Vector3 b)
        {
            float[] left = { a.x, a.y, a.z };
            float[] right = { b.x, b.y, b.z };
            System.Array.Sort(left);
            System.Array.Sort(right);
            float worst = 0f;

            for (int i = 0; i < left.Length; i++)
            {
                if (right[i] > Mathf.Epsilon)
                {
                    worst = Mathf.Max(worst, Mathf.Abs(left[i] - right[i]) / right[i]);
                }
            }

            return worst;
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
