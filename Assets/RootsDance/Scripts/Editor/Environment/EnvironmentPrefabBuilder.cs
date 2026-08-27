using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Turns every vendor model listed in <see cref="EnvironmentPrefabTable"/> into a project prefab under
    /// <c>Assets/RootsDance/Prefabs/Environment/</c>: vendor sub-materials are remapped onto the
    /// <see cref="EnvironmentPalette"/>, the model is scaled to real-world size and gets its collider,
    /// shadow mode and static flags.
    /// </summary>
    /// <remarks>
    /// <para>
    /// <b>Wrapper root, not a model-prefab variant.</b> Each saved prefab is a <i>regular</i> prefab whose
    /// root is a plain <see cref="GameObject"/> created by this tool — identity position and rotation, one
    /// uniform scale — with the vendor model kept underneath as a nested model-prefab instance. The nested
    /// instance is what preserves vendor re-import propagation: a changed FBX still flows into every prefab
    /// that references it.
    /// </para>
    /// <para>
    /// The simpler recipe — instantiate the model prefab and reset its own root to identity rotation plus a
    /// uniform scale — cannot be used here. Most vendor FBXs park the axis/unit conversion on their root
    /// transform (rotation (270, 0, 0) and scale (100, 100, 100) for the Quaternius packs and the
    /// single-mesh Poly Haven scans; <c>pole.fbx</c> even carries a non-uniform (1.9963, 1.9963, 26.5)).
    /// Overwriting that root flattened and shrank those models by roughly 100x. The wrapper keeps the
    /// conversion where the vendor put it and gives placement code a root it can safely drive with
    /// <c>Quaternion.Euler(0, yaw, 0)</c> and a uniform scale.
    /// </para>
    /// <para>
    /// Colliders, shadow modes and static flags live on the generated wrapper and on the nested instance's
    /// objects, so a vendor re-export that changes the mesh hierarchy silently drops them: re-import means
    /// rebuild — run this tool again after any vendor model update.
    /// </para>
    /// <para>
    /// Idempotent — re-running writes the same assets at the same paths. Menu:
    /// RootsDance &gt; Environment &gt; Build Environment Prefabs.
    /// </para>
    /// </remarks>
    public static class EnvironmentPrefabBuilder
    {
        /// <summary>Root folder of every generated dressing prefab.</summary>
        public const string k_PrefabRoot = "Assets/RootsDance/Prefabs/Environment";

        private const float k_TrunkRadiusFactor = 0.08f;
        private const float k_TrunkRadiusMin = 0.15f;
        private const float k_TrunkRadiusMax = 0.5f;

        /// <summary><see cref="CapsuleCollider.direction"/> value for the Y axis.</summary>
        private const int k_CapsuleDirectionY = 1;

        // Vegetation: no batching (per-instance sway/cull later) and no occluder (foliage occludes nothing).
        private static readonly StaticEditorFlags k_SoftStaticFlags =
            StaticEditorFlags.OccludeeStatic | StaticEditorFlags.ReflectionProbeStatic;

        // Photogrammetry heroes occlude, but they are far too dense to be worth static batching.
        private static readonly StaticEditorFlags k_HeroStaticFlags =
            k_SoftStaticFlags | StaticEditorFlags.OccluderStatic;

        // Rocks and facility props: low-poly and never moved, so they take batching as well.
        private static readonly StaticEditorFlags k_SolidStaticFlags =
            k_HeroStaticFlags | StaticEditorFlags.BatchingStatic;

        // Anything painted with one of these palette keys is soft vegetation: it casts no shadow and stays
        // out of the batching/occluder sets so it can be swayed or culled per instance later.
        private static readonly HashSet<string> k_NoShadowMaterials = new HashSet<string>
        {
            "Niwl_Plants_General", "Niwl_Plants_Bunch"
        };

        private static Dictionary<string, string> s_categoryByKey;

        /// <summary>
        /// Asset path of the prefab for <paramref name="key"/> (the FBX file name without its extension).
        /// Returns null and logs an error when the key is not in <see cref="EnvironmentPrefabTable"/>.
        /// </summary>
        public static string PrefabPath(string key)
        {
            if (s_categoryByKey == null)
            {
                s_categoryByKey = BuildCategoryLookup();
            }

            string category;

            if (!s_categoryByKey.TryGetValue(key, out category))
            {
                Debug.LogError($"EnvironmentPrefabBuilder: '{key}' is not a known environment prefab key.");
                return null;
            }

            return $"{k_PrefabRoot}/{category}/{key}.prefab";
        }

        /// <summary>Builds (or rebuilds) every prefab in the table.</summary>
        [MenuItem("RootsDance/Environment/Build Environment Prefabs")]
        public static void BuildAll()
        {
            Dictionary<string, Material> palette = EnvironmentPalette.EnsureAll();

            if (palette.Count == 0)
            {
                Debug.LogError("EnvironmentPrefabBuilder: the palette is empty; nothing was built.");
                return;
            }

            PrefabEntry[] entries = EnvironmentPrefabTable.Entries;
            EnsureCategoryFolders(entries);

            Scene preview = EditorSceneManager.NewPreviewScene();
            int built = 0;
            int failed = 0;

            try
            {
                for (int i = 0; i < entries.Length; i++)
                {
                    if (BuildOne(entries[i], palette, preview))
                    {
                        built++;
                    }
                    else
                    {
                        failed++;
                    }
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            s_categoryByKey = null;
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"EnvironmentPrefabBuilder: built {built} prefabs under {k_PrefabRoot} ({failed} failed).");
        }

        private static bool BuildOne(PrefabEntry entry, Dictionary<string, Material> palette, Scene preview)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(entry.ModelPath);

            if (model == null)
            {
                Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: no model at '{entry.ModelPath}'.");
                return false;
            }

            GameObject modelInstance = (GameObject)PrefabUtility.InstantiatePrefab(model, preview);

            if (modelInstance == null)
            {
                Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: could not instantiate the model prefab.");
                return false;
            }

            // Most vendor FBXs keep the axis/unit conversion (rotation -90 X, scale 100) on their root
            // transform, so the prefab gets a clean wrapper root instead: identity rotation, +Y up and one
            // uniform scale that placement code can safely overwrite. The model stays a nested prefab
            // instance underneath, so re-importing the vendor mesh still flows through.
            GameObject instance = new GameObject(entry.Key);
            SceneManager.MoveGameObjectToScene(instance, preview);

            try
            {
                modelInstance.transform.SetParent(instance.transform, false);
                instance.transform.localPosition = Vector3.zero;
                instance.transform.localRotation = Quaternion.identity;
                instance.transform.localScale = Vector3.one * entry.Scale;

                MeshRenderer[] renderers = instance.GetComponentsInChildren<MeshRenderer>(true);
                bool castShadows = !k_NoShadowMaterials.Contains(entry.DefaultMaterial);
                string mapping = ApplyMaterials(entry, palette, renderers, castShadows);

                Bounds local = LocalBounds(instance.transform, renderers);
                AddCollider(entry, instance, local);

                ApplyStaticFlags(instance, StaticFlagsFor(entry.Category));

                string path = PrefabPath(entry.Key);
                bool saved;
                PrefabUtility.SaveAsPrefabAsset(instance, path, out saved);

                if (!saved)
                {
                    Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: SaveAsPrefabAsset failed for '{path}'.");
                    return false;
                }

                Vector3 worldSize = local.size * entry.Scale;
                Debug.Log($"EnvironmentPrefabBuilder: {entry.Key}: {renderers.Length} renderers, "
                    + $"materials [{mapping}], scale {entry.Scale:0.##}, bounds size {worldSize.ToString("F2")}.");
                return true;
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(instance);
            }
        }

        private static StaticEditorFlags StaticFlagsFor(string category)
        {
            if (category == EnvironmentPrefabTable.k_Vegetation)
            {
                return k_SoftStaticFlags;
            }

            if (category == EnvironmentPrefabTable.k_Heroes)
            {
                return k_HeroStaticFlags;
            }

            return k_SolidStaticFlags;
        }

        private static string ApplyMaterials(PrefabEntry entry, Dictionary<string, Material> palette,
            MeshRenderer[] renderers, bool castShadows)
        {
            HashSet<string> seen = new HashSet<string>();
            StringBuilder mapping = new StringBuilder();

            foreach (MeshRenderer renderer in renderers)
            {
                Material[] vendor = renderer.sharedMaterials;
                Material[] replaced = new Material[vendor.Length];

                for (int i = 0; i < vendor.Length; i++)
                {
                    string vendorName = vendor[i] == null ? "<none>" : vendor[i].name;
                    string paletteKey = ResolveMaterialKey(entry, vendorName);
                    Material material;

                    if (!palette.TryGetValue(paletteKey, out material))
                    {
                        Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: palette key '{paletteKey}' "
                            + $"does not exist (vendor material '{vendorName}').");
                        material = vendor[i];
                    }

                    replaced[i] = material;

                    if (seen.Add(vendorName))
                    {
                        if (mapping.Length > 0)
                        {
                            mapping.Append(", ");
                        }

                        mapping.Append(vendorName).Append("->").Append(paletteKey);
                    }
                }

                renderer.sharedMaterials = replaced;
                renderer.shadowCastingMode = castShadows ? ShadowCastingMode.On : ShadowCastingMode.Off;
            }

            return mapping.ToString();
        }

        private static string ResolveMaterialKey(PrefabEntry entry, string vendorName)
        {
            string lowered = vendorName.ToLowerInvariant();

            if (entry.Materials != null)
            {
                foreach (MaterialRule rule in entry.Materials)
                {
                    if (!string.IsNullOrEmpty(rule.NameContains) && lowered.Contains(rule.NameContains))
                    {
                        return rule.MaterialKey;
                    }
                }
            }

            return entry.DefaultMaterial;
        }

        private static void AddCollider(PrefabEntry entry, GameObject instance, Bounds local)
        {
            switch (entry.Collider)
            {
                case ColliderKind.None:
                    return;

                case ColliderKind.Box:
                {
                    BoxCollider box = instance.AddComponent<BoxCollider>();
                    box.center = local.center;
                    box.size = local.size;
                    return;
                }

                case ColliderKind.TrunkCapsule:
                {
                    CapsuleCollider capsule = instance.AddComponent<CapsuleCollider>();
                    float scale = Mathf.Max(entry.Scale, 0.0001f);
                    float worldRadius = Mathf.Clamp(local.size.x * scale * k_TrunkRadiusFactor,
                        k_TrunkRadiusMin, k_TrunkRadiusMax);
                    capsule.center = new Vector3(0f, local.size.y * 0.5f, 0f);
                    capsule.radius = worldRadius / scale;
                    capsule.height = local.size.y;
                    capsule.direction = k_CapsuleDirectionY;
                    return;
                }

                case ColliderKind.MeshConvex:
                {
                    MeshFilter largest = LargestMeshFilter(instance);

                    if (largest == null)
                    {
                        Debug.LogWarning($"EnvironmentPrefabBuilder: {entry.Key}: no mesh for a convex collider.");
                        return;
                    }

                    MeshCollider mesh = largest.gameObject.AddComponent<MeshCollider>();
                    mesh.sharedMesh = largest.sharedMesh;
                    mesh.convex = true;
                    return;
                }

                default:
                    Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: unhandled collider kind "
                        + $"'{entry.Collider}'; the prefab was saved without a collider.");
                    return;
            }
        }

        private static MeshFilter LargestMeshFilter(GameObject instance)
        {
            MeshFilter[] filters = instance.GetComponentsInChildren<MeshFilter>(true);
            MeshFilter largest = null;
            float largestVolume = -1f;

            foreach (MeshFilter filter in filters)
            {
                if (filter.sharedMesh == null)
                {
                    continue;
                }

                Vector3 size = filter.sharedMesh.bounds.size;
                float volume = size.x * size.y * size.z;

                if (volume > largestVolume)
                {
                    largestVolume = volume;
                    largest = filter;
                }
            }

            return largest;
        }

        /// <summary>
        /// Mesh bounds of the whole instance expressed in the root's local space. Built from
        /// <c>MeshFilter.sharedMesh.bounds</c> rather than <c>Renderer.bounds</c>: a renderer that lives in a
        /// preview scene has never been culled, so its world bounds are not filled in yet.
        /// </summary>
        private static Bounds LocalBounds(Transform root, MeshRenderer[] renderers)
        {
            Bounds local = new Bounds(Vector3.zero, Vector3.zero);
            bool started = false;

            foreach (MeshRenderer renderer in renderers)
            {
                MeshFilter filter = renderer.GetComponent<MeshFilter>();

                if (filter == null || filter.sharedMesh == null)
                {
                    continue;
                }

                Bounds meshBounds = filter.sharedMesh.bounds;
                Vector3 min = meshBounds.min;
                Vector3 max = meshBounds.max;

                for (int corner = 0; corner < 8; corner++)
                {
                    Vector3 point = new Vector3(
                        (corner & 1) == 0 ? min.x : max.x,
                        (corner & 2) == 0 ? min.y : max.y,
                        (corner & 4) == 0 ? min.z : max.z);
                    Vector3 localPoint = root.InverseTransformPoint(filter.transform.TransformPoint(point));

                    if (started)
                    {
                        local.Encapsulate(localPoint);
                    }
                    else
                    {
                        local = new Bounds(localPoint, Vector3.zero);
                        started = true;
                    }
                }
            }

            return local;
        }

        private static void ApplyStaticFlags(GameObject instance, StaticEditorFlags flags)
        {
            Transform[] transforms = instance.GetComponentsInChildren<Transform>(true);

            foreach (Transform child in transforms)
            {
                GameObjectUtility.SetStaticEditorFlags(child.gameObject, flags);
            }
        }

        private static void EnsureCategoryFolders(PrefabEntry[] entries)
        {
            HashSet<string> categories = new HashSet<string>();

            foreach (PrefabEntry entry in entries)
            {
                categories.Add(entry.Category);
            }

            EnsureFolder(k_PrefabRoot);

            foreach (string category in categories)
            {
                EnsureFolder($"{k_PrefabRoot}/{category}");
            }
        }

        private static Dictionary<string, string> BuildCategoryLookup()
        {
            PrefabEntry[] entries = EnvironmentPrefabTable.Entries;
            Dictionary<string, string> lookup = new Dictionary<string, string>(entries.Length);

            foreach (PrefabEntry entry in entries)
            {
                if (lookup.ContainsKey(entry.Key))
                {
                    Debug.LogError($"EnvironmentPrefabBuilder: duplicate prefab key '{entry.Key}' in the table.");
                    continue;
                }

                lookup.Add(entry.Key, entry.Category);
            }

            return lookup;
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path).Replace('\\', '/');
            string folderName = Path.GetFileName(path);

            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, folderName);
        }
    }
}
