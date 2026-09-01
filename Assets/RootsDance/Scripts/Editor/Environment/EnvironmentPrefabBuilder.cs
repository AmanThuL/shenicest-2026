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

        private const float k_GroundCoverCullDistance = 50f;
        private const float k_SmallVegetationCullDistance = 60f;
        private const float k_RootRockCullDistance = 100f;
        private const float k_TreeCullDistance = 180f;
        private const float k_AssumedVerticalFieldOfView = 60f;

        private static readonly HashSet<string> k_RootScanLodKeys = new HashSet<string>
        {
            "pine_roots", "root_cluster_01", "root_cluster_02"
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
            BuildEntries(null, "environment", EnvironmentPalette.EnsureAll());
        }

        /// <summary>Rebuilds only the three photogrammetry root prefabs that own generated LODs.</summary>
        [MenuItem("RootsDance/Environment/Build Root Scan LOD Prefabs")]
        public static void BuildRootScanLods()
        {
            BuildEntries(k_RootScanLodKeys, "root-scan LOD", LoadExistingPalette(k_RootScanLodKeys));
        }

        private static void BuildEntries(HashSet<string> includedKeys, string label,
            Dictionary<string, Material> palette)
        {

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
                    if (includedKeys != null && !includedKeys.Contains(entries[i].Key))
                    {
                        continue;
                    }

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
            Debug.Log($"EnvironmentPrefabBuilder: built {built} {label} prefabs under {k_PrefabRoot} "
                + $"({failed} failed).");
        }

        private static Dictionary<string, Material> LoadExistingPalette(HashSet<string> includedKeys)
        {
            Dictionary<string, Material> palette = new Dictionary<string, Material>();

            foreach (PrefabEntry entry in EnvironmentPrefabTable.Entries)
            {
                if (!includedKeys.Contains(entry.Key))
                {
                    continue;
                }

                AddExistingMaterial(palette, entry.DefaultMaterial);

                if (entry.Materials == null)
                {
                    continue;
                }

                foreach (MaterialRule rule in entry.Materials)
                {
                    AddExistingMaterial(palette, rule.MaterialKey);
                }
            }

            return palette;
        }

        private static void AddExistingMaterial(Dictionary<string, Material> palette, string key)
        {
            if (palette.ContainsKey(key))
            {
                return;
            }

            Material material = EnvironmentPalette.Get(key);

            if (material != null)
            {
                palette.Add(key, material);
            }
        }

        /// <summary>
        /// Applies the current outdoor rendering budget to already-built prefabs without rebuilding their
        /// materials, colliders or nested model instances.
        /// </summary>
        [MenuItem("RootsDance/Environment/Apply Outdoor Prefab Performance Settings")]
        public static void ApplyPerformanceSettingsToBuiltPrefabs()
        {
            ApplyPerformanceSettingsToBuiltPrefabs(0, EnvironmentPrefabTable.Entries.Length);
        }

        /// <summary>Batch-friendly range overload for projects with expensive nested-prefab reimports.</summary>
        public static void ApplyPerformanceSettingsToBuiltPrefabs(int startIndex, int count)
        {
            PrefabEntry[] entries = EnvironmentPrefabTable.Entries;
            int updated = 0;
            int endIndex = Mathf.Min(startIndex + count, entries.Length);

            for (int i = Mathf.Max(startIndex, 0); i < endIndex; i++)
            {
                PrefabEntry entry = entries[i];

                if (entry.RenderClass == EnvironmentRenderClass.Default)
                {
                    continue;
                }

                string path = PrefabPath(entry.Key);
                GameObject root = PrefabUtility.LoadPrefabContents(path);

                if (root == null)
                {
                    Debug.LogWarning($"EnvironmentPrefabBuilder: could not load '{path}' for performance tuning.");
                    continue;
                }

                try
                {
                    MeshRenderer[] renderers = root.GetComponentsInChildren<MeshRenderer>(true);
                    Bounds local = LocalBounds(root.transform, renderers);
                    ApplyRenderPerformanceSettings(entry, root, renderers, local);
                    PrefabUtility.SaveAsPrefabAsset(root, path);
                    updated++;
                }
                finally
                {
                    PrefabUtility.UnloadPrefabContents(root);
                }
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"EnvironmentPrefabBuilder: applied performance settings to {updated} outdoor prefabs "
                + $"in table range [{startIndex}, {endIndex}).");
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

                if (!string.IsNullOrEmpty(entry.SubObject) && !CutOutSubObject(entry, instance, modelInstance))
                {
                    return false;
                }

                MeshRenderer[] lod0Renderers = instance.GetComponentsInChildren<MeshRenderer>(true);
                MeshRenderer[][] lodRenderers = null;

                if (HasLods(entry)
                    && !TryAddLodModels(entry, instance, modelInstance, preview, out lodRenderers))
                {
                    return false;
                }

                MeshRenderer[] renderers = instance.GetComponentsInChildren<MeshRenderer>(true);
                string mapping = ApplyMaterials(entry, palette, renderers);

                Bounds local = LocalBounds(instance.transform, lod0Renderers);
                AddCollider(entry, instance, local);

                if (lodRenderers != null)
                {
                    AddLodGroup(instance, lodRenderers, entry.LodTransitionHeights);
                }

                ApplyRenderPerformanceSettings(entry, instance, renderers, local);

                ApplyStaticFlags(instance, StaticFlagsFor(entry));

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

        private static bool HasLods(PrefabEntry entry)
        {
            return entry.LodModelPaths != null && entry.LodModelPaths.Length > 0;
        }

        private static bool TryAddLodModels(PrefabEntry entry, GameObject instance, GameObject lod0,
            Scene preview, out MeshRenderer[][] lodRenderers)
        {
            int lodCount = entry.LodModelPaths.Length + 1;
            lodRenderers = new MeshRenderer[lodCount][];

            if (!string.IsNullOrEmpty(entry.SubObject))
            {
                Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: LOD entries cannot cut out a sub-object.");
                return false;
            }

            if (entry.LodTransitionHeights == null || entry.LodTransitionHeights.Length != lodCount)
            {
                Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: expected {lodCount} LOD transitions.");
                return false;
            }

            lod0.name = "LOD0";
            lodRenderers[0] = lod0.GetComponentsInChildren<MeshRenderer>(true);

            for (int i = 0; i < entry.LodModelPaths.Length; i++)
            {
                string path = entry.LodModelPaths[i];
                GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(path);

                if (model == null)
                {
                    Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: no LOD model at '{path}'.");
                    return false;
                }

                GameObject lod = (GameObject)PrefabUtility.InstantiatePrefab(model, preview);

                if (lod == null)
                {
                    Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: could not instantiate '{path}'.");
                    return false;
                }

                lod.name = "LOD" + (i + 1);
                lod.transform.SetParent(instance.transform, false);
                lodRenderers[i + 1] = lod.GetComponentsInChildren<MeshRenderer>(true);
            }

            return true;
        }

        private static void AddLodGroup(GameObject instance, MeshRenderer[][] renderers,
            float[] transitionHeights)
        {
            LOD[] lods = new LOD[renderers.Length];

            for (int i = 0; i < renderers.Length; i++)
            {
                lods[i] = new LOD(transitionHeights[i], renderers[i]);
            }

            LODGroup group = instance.AddComponent<LODGroup>();
            group.fadeMode = LODFadeMode.CrossFade;
            group.animateCrossFading = true;
            group.SetLODs(lods);
            group.RecalculateBounds();
        }

        /// <summary>
        /// Replaces the whole vendor model under <paramref name="instance"/> with a single plain child holding
        /// the one renderer named by <see cref="PrefabEntry.SubObject"/>, keeping the vendor transform (the
        /// axis/unit conversion lives there) and shifting the piece so the wrapper's origin sits at the centre
        /// of the piece's footprint, on its lowest point. Kit FBXs lay every piece out side by side, so without
        /// this a piece would carry the whole kit and a pivot metres away from itself.
        /// </summary>
        /// <remarks>
        /// The nested model-prefab instance is dropped for these entries: the piece keeps a direct reference to
        /// the FBX's mesh sub-asset, so a re-export that only changes geometry still flows through, while one
        /// that renames or re-parents the piece needs a rebuild — the same caveat the colliders already carry.
        /// </remarks>
        private static bool CutOutSubObject(PrefabEntry entry, GameObject instance, GameObject modelInstance)
        {
            MeshRenderer source = null;

            foreach (MeshRenderer candidate in modelInstance.GetComponentsInChildren<MeshRenderer>(true))
            {
                if (candidate.gameObject.name == entry.SubObject)
                {
                    source = candidate;
                    break;
                }
            }

            if (source == null)
            {
                Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: '{entry.SubObject}' is not a renderer "
                    + $"inside '{entry.ModelPath}'.");
                return false;
            }

            MeshFilter sourceFilter = source.GetComponent<MeshFilter>();

            if (sourceFilter == null || sourceFilter.sharedMesh == null)
            {
                Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: '{entry.SubObject}' has no mesh.");
                return false;
            }

            GameObject piece = new GameObject(entry.SubObject);
            piece.transform.SetParent(instance.transform, false);
            piece.transform.localPosition = instance.transform.InverseTransformPoint(source.transform.position);
            piece.transform.localRotation = Quaternion.Inverse(instance.transform.rotation) * source.transform.rotation;
            piece.transform.localScale = source.transform.lossyScale / Mathf.Max(entry.Scale, 0.0001f);

            piece.AddComponent<MeshFilter>().sharedMesh = sourceFilter.sharedMesh;
            piece.AddComponent<MeshRenderer>().sharedMaterials = source.sharedMaterials;

            UnityEngine.Object.DestroyImmediate(modelInstance);

            Bounds local = LocalBounds(instance.transform, instance.GetComponentsInChildren<MeshRenderer>(true));
            piece.transform.localPosition -= new Vector3(local.center.x, local.min.y, local.center.z);
            return true;
        }

        private static StaticEditorFlags StaticFlagsFor(PrefabEntry entry)
        {
            if (entry.Category == EnvironmentPrefabTable.k_Vegetation)
            {
                return k_SoftStaticFlags;
            }

            if (entry.Category == EnvironmentPrefabTable.k_Heroes || HasLods(entry))
            {
                return k_HeroStaticFlags;
            }

            return k_SolidStaticFlags;
        }

        private static string ApplyMaterials(PrefabEntry entry, Dictionary<string, Material> palette,
            MeshRenderer[] renderers)
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
                    string paletteKey = ResolveMaterialKey(entry, vendorName, renderer.gameObject.name);
                    Material material;

                    if (!palette.TryGetValue(paletteKey, out material))
                    {
                        Debug.LogError($"EnvironmentPrefabBuilder: {entry.Key}: palette key '{paletteKey}' "
                            + $"does not exist (vendor material '{vendorName}').");
                        material = vendor[i];
                    }

                    replaced[i] = material;

                    if (seen.Add(vendorName + "|" + paletteKey))
                    {
                        if (mapping.Length > 0)
                        {
                            mapping.Append(", ");
                        }

                        mapping.Append(vendorName).Append("->").Append(paletteKey);
                    }
                }
                renderer.sharedMaterials = replaced;
            }

            return mapping.ToString();
        }

        private static void ApplyRenderPerformanceSettings(PrefabEntry entry, GameObject instance,
            MeshRenderer[] renderers, Bounds local)
        {
            if (entry.RenderClass == EnvironmentRenderClass.Default)
            {
                return;
            }

            bool castShadows = entry.RenderClass == EnvironmentRenderClass.Tree;

            for (int i = 0; i < renderers.Length; i++)
            {
                renderers[i].shadowCastingMode = castShadows ? ShadowCastingMode.On : ShadowCastingMode.Off;
                renderers[i].motionVectorGenerationMode = MotionVectorGenerationMode.Camera;
            }

            float cullDistance = CullDistanceFor(entry.RenderClass);
            float size = Mathf.Max(local.size.x, Mathf.Max(local.size.y, local.size.z));

            float largestScale = Mathf.Max(Mathf.Abs(instance.transform.lossyScale.x),
                Mathf.Max(Mathf.Abs(instance.transform.lossyScale.y), Mathf.Abs(instance.transform.lossyScale.z)));
            float worldSize = size * largestScale;
            float halfFovRadians = k_AssumedVerticalFieldOfView * Mathf.Deg2Rad * 0.5f;
            float cullHeight = worldSize / (2f * cullDistance * Mathf.Tan(halfFovRadians));
            cullHeight = Mathf.Clamp(cullHeight, 0.001f, 0.99f);

            LODGroup nested = NestedLodGroup(instance);

            if (nested != null)
            {
                // The vendor model ships its own LOD chain. A group on the wrapper as well would register
                // the same renderers with two LODGroups — which Unity warns about and which makes LOD
                // selection and culling non-deterministic — so the model's group stays authoritative and
                // only takes the cull distance on its last LOD.
                RaiseCullHeight(nested, cullHeight);
                return;
            }

            LODGroup group = instance.GetComponent<LODGroup>();

            if (group == null)
            {
                group = instance.AddComponent<LODGroup>();
            }

            group.localReferencePoint = local.center;
            group.size = size;

            if (HasLods(entry))
            {
                RaiseCullHeight(group, cullHeight);
            }
            else
            {
                group.fadeMode = LODFadeMode.None;
                group.animateCrossFading = false;
                group.SetLODs(new[] { new LOD(cullHeight, renderers) });
            }
        }

        /// <summary>
        /// The first <see cref="LODGroup"/> below <paramref name="instance"/>'s own root — the one the vendor
        /// model prefab brings with it. Null when the model has no LODs of its own.
        /// </summary>
        private static LODGroup NestedLodGroup(GameObject instance)
        {
            foreach (LODGroup candidate in instance.GetComponentsInChildren<LODGroup>(true))
            {
                if (candidate.gameObject != instance)
                {
                    return candidate;
                }
            }

            return null;
        }

        /// <summary>Pushes <paramref name="group"/>'s last LOD out to <paramref name="cullHeight"/>.</summary>
        private static void RaiseCullHeight(LODGroup group, float cullHeight)
        {
            LOD[] lods = group.GetLODs();

            if (lods.Length == 0)
            {
                return;
            }

            int finalIndex = lods.Length - 1;
            lods[finalIndex].screenRelativeTransitionHeight =
                Mathf.Max(lods[finalIndex].screenRelativeTransitionHeight, cullHeight);
            group.SetLODs(lods);
        }

        private static float CullDistanceFor(EnvironmentRenderClass renderClass)
        {
            switch (renderClass)
            {
                case EnvironmentRenderClass.GroundCover:
                    return k_GroundCoverCullDistance;
                case EnvironmentRenderClass.SmallVegetation:
                    return k_SmallVegetationCullDistance;
                case EnvironmentRenderClass.RootRock:
                    return k_RootRockCullDistance;
                case EnvironmentRenderClass.Tree:
                    return k_TreeCullDistance;
                default:
                    return 0f;
            }
        }

        /// <summary>
        /// First rule whose fragment appears in the vendor material name, then in the renderer's GameObject
        /// name (vendor packs that share one material between trunk and crown split them by mesh name), else
        /// the entry's default key.
        /// </summary>
        private static string ResolveMaterialKey(PrefabEntry entry, string vendorName, string rendererName)
        {
            string loweredMaterial = vendorName.ToLowerInvariant();
            string loweredRenderer = rendererName.ToLowerInvariant();

            if (entry.Materials != null)
            {
                foreach (MaterialRule rule in entry.Materials)
                {
                    if (string.IsNullOrEmpty(rule.NameContains))
                    {
                        continue;
                    }

                    if (loweredMaterial.Contains(rule.NameContains) || loweredRenderer.Contains(rule.NameContains))
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
