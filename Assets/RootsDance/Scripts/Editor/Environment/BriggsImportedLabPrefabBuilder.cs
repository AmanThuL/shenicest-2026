using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds project-owned Briggs laboratory prefabs from the curated artist picks and the expanded CC0
    /// Lab Assets model set. Source FBXs remain nested model-prefab instances so a vendor mesh re-import can
    /// be picked up by rebuilding these assets.
    /// </summary>
    /// <remarks>
    /// The generated material assets are shared HDRP/Lit assets. Per-instance colour changes intentionally do
    /// not use MaterialPropertyBlock, keeping the prefabs compatible with this project's SRP Batcher rules.
    /// Re-running the builder overwrites the same project prefabs and material assets at stable paths.
    /// </remarks>
    public static class BriggsImportedLabPrefabBuilder
    {
        public const string k_PrefabRoot = "Assets/RootsDance/Prefabs/Environment";
        public const string k_CentralIslandKey = "AbandonedCentralLabIsland";
        public const string k_S7CounterKey = "AbandonedS7Counter";

        private const string k_LabModelRoot = "Assets/ThirdParty/Environment/LabAssetsCC0/Models";
        private const string k_ArtistPickRoot = "Assets/ThirdParty/Environment/BriggsArtistPicks/Models";
        private const string k_ChemicalTableModelPath =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Models/ChemicalLab_AbandonedTable.fbx";
        private const string k_ChemicalTableTextureRoot =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Textures/ChemicalLabTable";
        private const string k_MaterialRoot =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ImportedLab";

        private const string k_FurnitureCategory = "LabFurniture";
        private const string k_EquipmentCategory = "LabEquipment";
        private const string k_HeroCategory = "LabHeroProps";

        // Lab Assets are authored in centimetres. The model prefab retains Unity's FBX axis conversion on
        // its own root, while the clean wrapper supplies the centimetre-to-metre conversion.
        private const float k_LabScale = 0.01f;

        private static readonly StaticEditorFlags k_SolidStaticFlags =
            StaticEditorFlags.OccludeeStatic
            | StaticEditorFlags.ReflectionProbeStatic
            | StaticEditorFlags.BatchingStatic;

        private static readonly SourceSpec[] k_Sources =
        {
            Furniture("cabinet_cabinet"),
            Furniture("cabinet_cabinet_two_shelves"),
            Furniture("counter_counter"),
            Furniture("counter_counter_2_shelves"),
            Furniture("counter_counter_3_shelves"),
            Furniture("counter_counter_4_shelves"),
            Furniture("counter_counter_side_outlet"),
            Furniture("counter_counter_sink"),
            Furniture("counter_counter_top_outlet"),

            Equipment("machine_calculator_large"),
            Equipment("machine_calculator_small"),
            Equipment("machine_centrifuge"),
            Equipment("machine_centrifuge_tube"),
            Equipment("machine_desiccator"),
            Equipment("machine_electronic_scale"),
            Equipment("machine_hot_plate"),
            Equipment("machine_microscope"),

            ArtistPick("Astronomical_Quintant", MaterialRole.Oxide, true),
            ArtistPick("Chemistry_Old_Lab_Tubes", MaterialRole.Glass),
            ArtistPick("Lab_Glassware", MaterialRole.Glass),
            ArtistPick("PSX_Adrenaline_Syringe", MaterialRole.Metal)
        };

        private static Dictionary<string, SourceSpec> s_sourceByKey;

        /// <summary>
        /// Builds all imported lab prefabs and returns paths for the successfully generated assets. This is
        /// the composable entry point intended for <see cref="BriggsInteriorDressingBuilder"/>.
        /// </summary>
        public static IReadOnlyDictionary<string, string> EnsureAll()
        {
            MaterialSet materials = EnsureMaterials();
            EnsureOutputFolders();

            Dictionary<string, string> builtPaths = new Dictionary<string, string>(StringComparer.Ordinal);
            Scene preview = EditorSceneManager.NewPreviewScene();
            int failed = 0;

            try
            {
                for (int i = 0; i < k_Sources.Length; i++)
                {
                    SourceSpec source = k_Sources[i];

                    if (BuildSourcePrefab(source, materials, preview))
                    {
                        builtPaths[source.Key] = PrefabPath(source.Key);
                    }
                    else
                    {
                        failed++;
                    }
                }

                if (BuildCentralIsland(materials, preview))
                {
                    builtPaths[k_CentralIslandKey] = PrefabPath(k_CentralIslandKey);
                }
                else
                {
                    failed++;
                }

                if (BuildS7Counter(materials, preview))
                {
                    builtPaths[k_S7CounterKey] = PrefabPath(k_S7CounterKey);
                }
                else
                {
                    failed++;
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"BriggsImportedLabPrefabBuilder: built {builtPaths.Count} prefabs under "
                + $"{k_PrefabRoot} ({failed} failed).");
            return builtPaths;
        }

        /// <summary>Asset path for a generated prefab, or null when <paramref name="key"/> is unknown.</summary>
        public static string PrefabPath(string key)
        {
            if (key == k_CentralIslandKey || key == k_S7CounterKey)
            {
                return $"{k_PrefabRoot}/{k_FurnitureCategory}/{key}.prefab";
            }

            if (s_sourceByKey == null)
            {
                s_sourceByKey = BuildSourceLookup();
            }

            SourceSpec source;

            if (!s_sourceByKey.TryGetValue(key, out source))
            {
                Debug.LogError($"BriggsImportedLabPrefabBuilder: unknown prefab key '{key}'.");
                return null;
            }

            return $"{k_PrefabRoot}/{source.Category}/{source.Key}.prefab";
        }

        [MenuItem("RootsDance/Environment/Build Briggs Imported Lab Prefabs")]
        public static void BuildAll()
        {
            EnsureAll();
        }

        [MenuItem("RootsDance/Environment/Rebuild Briggs Abandoned Central Table")]
        public static void BuildCentralIslandOnly()
        {
            MaterialSet materials = EnsureMaterials();
            EnsureOutputFolders();
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                if (!BuildCentralIsland(materials, preview))
                {
                    throw new InvalidOperationException("Failed to rebuild the Briggs abandoned central desk.");
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        /// <summary>Batch entry point that only refreshes the stable central-island prefab.</summary>
        public static void BuildCentralIslandOnlyFromCommandLine()
        {
            BuildCentralIslandOnly();

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }

        private static bool BuildSourcePrefab(SourceSpec source, MaterialSet materials, Scene preview)
        {
            GameObject root = new GameObject(source.Key);
            SceneManager.MoveGameObjectToScene(root, preview);

            try
            {
                GameObject model = AddRecenteredModel(
                    root.transform,
                    source.ModelPath,
                    source.Scale,
                    source.DefaultMaterial,
                    materials,
                    preview);

                if (model == null)
                {
                    return false;
                }

                Bounds bounds = LocalBounds(root.transform, root.GetComponentsInChildren<MeshRenderer>(true));

                if (source.Collider == ColliderMode.Furniture)
                {
                    AddBoxCollider(root, bounds);
                }

                ApplyStaticFlags(root);
                return SavePrefab(root, PrefabPath(source.Key));
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static bool BuildCentralIsland(MaterialSet materials, Scene preview)
        {
            const float targetLength = 5.2f;
            const float targetDepth = 2.0f;
            const float targetWorktopHeight = 0.92f;
            const float sourceWorktopHeight = 0.6f;

            GameObject root = new GameObject(k_CentralIslandKey);
            SceneManager.MoveGameObjectToScene(root, preview);

            try
            {
                // The table shell, sink and faucet are isolated from the Chemical Lab source. Its bundled bottles,
                // first-aid kit and Fallout-labelled props are intentionally excluded; the dressing pass supplies
                // the separately licensed glassware set requested by art direction.
                GameObject desk = AddRecenteredModel(
                    root.transform,
                    k_ChemicalTableModelPath,
                    Vector3.one,
                    MaterialRole.Oxide,
                    materials,
                    preview);

                if (desk == null)
                {
                    return false;
                }

                // Bake this source's importer-owned unit node into the generated central prefab. Keeping this FBX
                // nested causes Unity to reapply its hidden 0.01 scale when the generated prefab is loaded.
                PrefabUtility.UnpackPrefabInstance(
                    desk,
                    PrefabUnpackMode.Completely,
                    InteractionMode.AutomatedAction);

                Bounds sourceBounds = LocalBounds(root.transform, root.GetComponentsInChildren<MeshRenderer>(true));

                if (sourceBounds.size.x < 0.001f
                    || sourceBounds.size.y < 0.001f
                    || sourceBounds.size.z < 0.001f)
                {
                    Debug.LogError("BriggsImportedLabPrefabBuilder: abandoned desk has invalid bounds.");
                    return false;
                }

                desk.transform.localScale = new Vector3(
                    targetLength / sourceBounds.size.x,
                    targetDepth / sourceBounds.size.z,
                    targetWorktopHeight / sourceWorktopHeight);

                // Non-uniform scaling also scales the imported model's initial recentering offset. Re-anchor the
                // resulting geometry so its feet remain on Y=0 and its silhouette stays centered on the collider.
                Bounds scaledBounds = LocalBounds(root.transform, root.GetComponentsInChildren<MeshRenderer>(true));
                desk.transform.localPosition += new Vector3(
                    -scaledBounds.center.x,
                    -scaledBounds.min.y,
                    -scaledBounds.center.z);

                // Three broad collision bands follow the island silhouette without creating small
                // seams that can catch the CharacterController.
                float bandLength = targetLength / 3f;

                for (int band = 0; band < 3; band++)
                {
                    BoxCollider collider = root.AddComponent<BoxCollider>();
                    collider.center = new Vector3(
                        -targetLength / 3f + band * bandLength,
                        targetWorktopHeight * 0.5f,
                        0f);
                    collider.size = new Vector3(
                        bandLength - 0.04f,
                        targetWorktopHeight,
                        targetDepth - 0.06f);
                }

                ApplyStaticFlags(root);
                return SavePrefab(root, PrefabPath(k_CentralIslandKey));
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static bool BuildS7Counter(MaterialSet materials, Scene preview)
        {
            GameObject root = new GameObject(k_S7CounterKey);
            SceneManager.MoveGameObjectToScene(root, preview);

            try
            {
                GameObject model = AddRecenteredModel(
                    root.transform,
                    $"{k_LabModelRoot}/counter_counter_3_shelves.fbx",
                    new Vector3(0.0125f, 0.0132f, 0.0125f),
                    MaterialRole.Enamel,
                    materials,
                    preview);

                if (model == null)
                {
                    return false;
                }

                Bounds bounds = LocalBounds(root.transform, root.GetComponentsInChildren<MeshRenderer>(true));
                AddBoxCollider(root, bounds);
                ApplyStaticFlags(root);
                return SavePrefab(root, PrefabPath(k_S7CounterKey));
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static GameObject AddRecenteredModel(
            Transform parent,
            string modelPath,
            float scale,
            MaterialRole defaultMaterial,
            MaterialSet materials,
            Scene preview)
        {
            return AddRecenteredModel(parent, modelPath, Vector3.one * scale, defaultMaterial, materials, preview);
        }

        private static GameObject AddRecenteredModel(
            Transform parent,
            string modelPath,
            Vector3 scale,
            MaterialRole defaultMaterial,
            MaterialSet materials,
            Scene preview)
        {
            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

            if (source == null)
            {
                Debug.LogError($"BriggsImportedLabPrefabBuilder: no model at '{modelPath}'.");
                return null;
            }

            GameObject holder = new GameObject(Path.GetFileNameWithoutExtension(modelPath) + "_Model");
            holder.transform.SetParent(parent, false);
            holder.transform.localScale = scale;

            GameObject model = (GameObject)PrefabUtility.InstantiatePrefab(source, preview);

            if (model == null)
            {
                Debug.LogError($"BriggsImportedLabPrefabBuilder: could not instantiate '{modelPath}'.");
                UnityEngine.Object.DestroyImmediate(holder);
                return null;
            }

            model.transform.SetParent(holder.transform, false);
            RemoveSourceColliders(model);
            ApplyMaterials(model, defaultMaterial, materials);

            MeshRenderer[] renderers = holder.GetComponentsInChildren<MeshRenderer>(true);
            Bounds bounds = LocalBounds(holder.transform, renderers);
            model.transform.localPosition += new Vector3(-bounds.center.x, -bounds.min.y, -bounds.center.z);
            return model;
        }

        private static void RemoveSourceColliders(GameObject model)
        {
            Collider[] colliders = model.GetComponentsInChildren<Collider>(true);

            for (int i = 0; i < colliders.Length; i++)
            {
                UnityEngine.Object.DestroyImmediate(colliders[i]);
            }
        }

        private static void ApplyMaterials(GameObject model, MaterialRole defaultRole, MaterialSet materials)
        {
            Renderer[] renderers = model.GetComponentsInChildren<Renderer>(true);

            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                Renderer renderer = renderers[rendererIndex];
                Material[] sourceMaterials = renderer.sharedMaterials;

                if (sourceMaterials.Length == 0)
                {
                    renderer.sharedMaterial = materials.ForRole(defaultRole);
                    renderer.shadowCastingMode = ShadowCastingMode.On;
                    renderer.receiveShadows = true;
                    continue;
                }

                Material[] replacements = new Material[sourceMaterials.Length];

                for (int materialIndex = 0; materialIndex < sourceMaterials.Length; materialIndex++)
                {
                    string sourceName = sourceMaterials[materialIndex] != null
                        ? sourceMaterials[materialIndex].name.ToLowerInvariant()
                        : string.Empty;
                    MaterialRole role = ResolveMaterialRole(sourceName, defaultRole);
                    replacements[materialIndex] = materials.ForSource(sourceName, role);
                }

                renderer.sharedMaterials = replacements;
                renderer.shadowCastingMode = ShadowCastingMode.On;
                renderer.receiveShadows = true;
            }
        }

        private static MaterialRole ResolveMaterialRole(string sourceName, MaterialRole fallback)
        {
            if (sourceName.Contains("glass")
                || sourceName.Contains("25%")
                || sourceName.Contains("transparent"))
            {
                return MaterialRole.Glass;
            }

            if (sourceName.Contains("rust")
                || sourceName.Contains("oxide")
                || sourceName.Contains("wood"))
            {
                return sourceName.Contains("kitchenlabdesk")
                    ? MaterialRole.WeatheredWood
                    : MaterialRole.Oxide;
            }

            if (sourceName.Contains("metal") || sourceName.Contains("steel"))
            {
                return MaterialRole.Metal;
            }

            return fallback;
        }

        private static MaterialSet EnsureMaterials()
        {
            EnsureFolder(k_MaterialRoot);
            Shader lit = Shader.Find("HDRP/Lit");

            if (lit == null)
            {
                throw new InvalidOperationException("HDRP/Lit shader was not found for Briggs imported lab prefabs.");
            }

            Material enamel = EnsureOpaqueMaterial(
                lit,
                "ImportedLab_AgedEnamel",
                new Color(0.27f, 0.34f, 0.32f, 1f),
                0.04f,
                0.2f);
            Material metal = EnsureOpaqueMaterial(
                lit,
                "ImportedLab_DarkMetal",
                new Color(0.14f, 0.18f, 0.17f, 1f),
                0.42f,
                0.24f);
            Material oxide = EnsureOpaqueMaterial(
                lit,
                "ImportedLab_Oxide",
                new Color(0.34f, 0.23f, 0.14f, 1f),
                0.15f,
                0.14f);
            Material weatheredWood = EnsureTexturedOpaqueMaterial(
                lit,
                "ImportedLab_WeatheredDesk",
                "Assets/ThirdParty/Environment/BriggsArtistPicks/Textures/Kitchen_Lab_Desk_BaseColor.png",
                new Color(0.76f, 0.72f, 0.62f, 1f),
                0.02f,
                0.12f);
            Dictionary<string, Material> chemicalTableMaterials = EnsureChemicalTableMaterials(lit);
            Material glass = EnsureGlassMaterial(lit);
            return new MaterialSet(enamel, metal, oxide, weatheredWood, glass, chemicalTableMaterials);
        }

        private static Dictionary<string, Material> EnsureChemicalTableMaterials(Shader lit)
        {
            Dictionary<string, Material> materials =
                new Dictionary<string, Material>(StringComparer.Ordinal);
            materials.Add("noshki_stola", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Legs", k_ChemicalTableTextureRoot + "/Noshki_stola_albedo.jpg",
                new Color(0.62f, 0.61f, 0.55f, 1f), 0.12f, 0.12f));
            materials.Add("bok_stola", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Sides", k_ChemicalTableTextureRoot + "/bok_stola_albedo.jpg",
                new Color(0.66f, 0.62f, 0.55f, 1f), 0.08f, 0.1f));
            materials.Add("verh_stola", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Worktop", k_ChemicalTableTextureRoot + "/verh_stola_albedo.jpg",
                new Color(0.7f, 0.66f, 0.58f, 1f), 0.16f, 0.12f));
            materials.Add("kran", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Faucet", k_ChemicalTableTextureRoot + "/kran_albedo.jpg",
                new Color(0.58f, 0.62f, 0.58f, 1f), 0.7f, 0.24f));
            materials.Add("ugolki_stola", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Corners", k_ChemicalTableTextureRoot + "/ugolki_stola_albedo.jpg",
                new Color(0.58f, 0.56f, 0.5f, 1f), 0.55f, 0.16f));
            materials.Add("rakovina", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Sink", k_ChemicalTableTextureRoot + "/rakovina_albedo.jpg",
                new Color(0.62f, 0.62f, 0.57f, 1f), 0.72f, 0.2f));
            materials.Add("boltiki_ugolkov", EnsureTexturedOpaqueMaterial(
                lit, "ChemicalTable_Bolts", k_ChemicalTableTextureRoot + "/boltiki_ugolkov_albedo.jpg",
                new Color(0.52f, 0.5f, 0.44f, 1f), 0.78f, 0.18f));
            return materials;
        }

        private static Material EnsureTexturedOpaqueMaterial(
            Shader lit,
            string name,
            string texturePath,
            Color tint,
            float metallic,
            float smoothness)
        {
            Texture2D baseMap = AssetDatabase.LoadAssetAtPath<Texture2D>(texturePath);

            if (baseMap == null)
            {
                throw new InvalidOperationException($"Briggs imported texture is missing at '{texturePath}'.");
            }

            Material material = EnsureOpaqueMaterial(lit, name, tint, metallic, smoothness);
            material.SetTexture("_BaseColorMap", baseMap);
            material.SetTextureScale("_BaseColorMap", Vector2.one);
            material.SetTextureOffset("_BaseColorMap", Vector2.zero);
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureOpaqueMaterial(
            Shader lit,
            string name,
            Color color,
            float metallic,
            float smoothness)
        {
            Material material = EnsureMaterialAsset(lit, name);
            HDMaterial.SetSurfaceType(material, false);
            material.SetColor("_BaseColor", color);
            material.SetFloat("_Metallic", metallic);
            material.SetFloat("_Smoothness", smoothness);
            material.enableInstancing = true;
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureGlassMaterial(Shader lit)
        {
            Material material = EnsureMaterialAsset(lit, "ImportedLab_DirtyGlass");
            HDMaterial.SetSurfaceType(material, true);
            material.SetColor("_BaseColor", new Color(0.28f, 0.43f, 0.37f, 0.34f));
            material.SetFloat("_Metallic", 0f);
            material.SetFloat("_Smoothness", 0.62f);
            material.SetFloat("_BlendMode", 0f);
            material.SetFloat("_TransparentZWrite", 0f);
            material.enableInstancing = true;
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureMaterialAsset(Shader lit, string name)
        {
            string path = $"{k_MaterialRoot}/{name}.mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(lit) { name = name };
                AssetDatabase.CreateAsset(material, path);
            }
            else if (material.shader != lit)
            {
                material.shader = lit;
            }

            return material;
        }

        private static void AddBoxCollider(GameObject root, Bounds bounds)
        {
            BoxCollider collider = root.AddComponent<BoxCollider>();
            collider.center = bounds.center;
            collider.size = bounds.size;
        }

        private static Bounds LocalBounds(Transform root, MeshRenderer[] renderers)
        {
            Bounds local = new Bounds(Vector3.zero, Vector3.zero);
            bool started = false;

            for (int rendererIndex = 0; rendererIndex < renderers.Length; rendererIndex++)
            {
                MeshFilter filter = renderers[rendererIndex].GetComponent<MeshFilter>();

                if (filter == null || filter.sharedMesh == null)
                {
                    continue;
                }

                Bounds meshBounds = filter.sharedMesh.bounds;
                Vector3 min = meshBounds.min;
                Vector3 max = meshBounds.max;

                for (int corner = 0; corner < 8; corner++)
                {
                    Vector3 meshPoint = new Vector3(
                        (corner & 1) == 0 ? min.x : max.x,
                        (corner & 2) == 0 ? min.y : max.y,
                        (corner & 4) == 0 ? min.z : max.z);
                    Vector3 localPoint = root.InverseTransformPoint(filter.transform.TransformPoint(meshPoint));

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

        private static void ApplyStaticFlags(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                GameObjectUtility.SetStaticEditorFlags(transforms[i].gameObject, k_SolidStaticFlags);
            }
        }

        private static bool SavePrefab(GameObject root, string path)
        {
            bool saved;
            PrefabUtility.SaveAsPrefabAsset(root, path, out saved);

            if (!saved)
            {
                Debug.LogError($"BriggsImportedLabPrefabBuilder: failed to save '{path}'.");
            }

            return saved;
        }

        private static void EnsureOutputFolders()
        {
            EnsureFolder(k_PrefabRoot);
            EnsureFolder($"{k_PrefabRoot}/{k_FurnitureCategory}");
            EnsureFolder($"{k_PrefabRoot}/{k_EquipmentCategory}");
            EnsureFolder($"{k_PrefabRoot}/{k_HeroCategory}");
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path).Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(path));
        }

        private static Dictionary<string, SourceSpec> BuildSourceLookup()
        {
            Dictionary<string, SourceSpec> lookup =
                new Dictionary<string, SourceSpec>(k_Sources.Length, StringComparer.Ordinal);

            for (int i = 0; i < k_Sources.Length; i++)
            {
                lookup.Add(k_Sources[i].Key, k_Sources[i]);
            }

            return lookup;
        }

        private static SourceSpec Furniture(string key)
        {
            return new SourceSpec(
                key,
                $"{k_LabModelRoot}/{key}.fbx",
                k_FurnitureCategory,
                k_LabScale,
                ColliderMode.Furniture,
                MaterialRole.Enamel);
        }

        private static SourceSpec Equipment(string key)
        {
            return new SourceSpec(
                key,
                $"{k_LabModelRoot}/{key}.fbx",
                k_EquipmentCategory,
                k_LabScale,
                ColliderMode.None,
                MaterialRole.Metal);
        }

        private static SourceSpec ArtistPick(string key, MaterialRole material, bool hasFloorCollider = false)
        {
            return new SourceSpec(
                key,
                $"{k_ArtistPickRoot}/{key}.fbx",
                k_HeroCategory,
                1f,
                hasFloorCollider ? ColliderMode.Furniture : ColliderMode.None,
                material);
        }

        private enum ColliderMode
        {
            None,
            Furniture
        }

        private enum MaterialRole
        {
            Enamel,
            Metal,
            Oxide,
            WeatheredWood,
            Glass
        }

        private readonly struct SourceSpec
        {
            public readonly string Key;
            public readonly string ModelPath;
            public readonly string Category;
            public readonly float Scale;
            public readonly ColliderMode Collider;
            public readonly MaterialRole DefaultMaterial;

            public SourceSpec(
                string key,
                string modelPath,
                string category,
                float scale,
                ColliderMode collider,
                MaterialRole defaultMaterial)
            {
                Key = key;
                ModelPath = modelPath;
                Category = category;
                Scale = scale;
                Collider = collider;
                DefaultMaterial = defaultMaterial;
            }
        }

        private readonly struct MaterialSet
        {
            private readonly Material m_Enamel;
            private readonly Material m_Metal;
            private readonly Material m_Oxide;
            private readonly Material m_WeatheredWood;
            private readonly Material m_Glass;
            private readonly IReadOnlyDictionary<string, Material> m_SourceMaterials;

            public MaterialSet(
                Material enamel,
                Material metal,
                Material oxide,
                Material weatheredWood,
                Material glass,
                IReadOnlyDictionary<string, Material> sourceMaterials)
            {
                m_Enamel = enamel;
                m_Metal = metal;
                m_Oxide = oxide;
                m_WeatheredWood = weatheredWood;
                m_Glass = glass;
                m_SourceMaterials = sourceMaterials;
            }

            public Material ForSource(string sourceName, MaterialRole fallback)
            {
                Material material;
                return m_SourceMaterials != null && m_SourceMaterials.TryGetValue(sourceName, out material)
                    ? material
                    : ForRole(fallback);
            }

            public Material ForRole(MaterialRole role)
            {
                switch (role)
                {
                    case MaterialRole.Enamel:
                        return m_Enamel;
                    case MaterialRole.Metal:
                        return m_Metal;
                    case MaterialRole.Oxide:
                        return m_Oxide;
                    case MaterialRole.WeatheredWood:
                        return m_WeatheredWood;
                    case MaterialRole.Glass:
                        return m_Glass;
                    default:
                        throw new ArgumentOutOfRangeException(nameof(role), role, null);
                }
            }
        }
    }
}
