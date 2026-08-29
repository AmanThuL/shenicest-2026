using System.Collections.Generic;
using System.IO;
using TheVisualEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the licensed greenhouse plant imports as TVE materials and placement-ready prefabs without
    /// touching the shared outdoor environment palette or any scene.
    /// </summary>
    public static class GreenhouseInteriorPropsBuilder
    {
        public const string k_PrefabRoot =
            "Assets/RootsDance/Prefabs/Environment/GreenhouseInteriorProps";

        private const string k_MaterialRoot =
            "Assets/RootsDance/Materials/Environment/GreenhouseInteriorProps";

        private const string k_SourceRoot =
            "Assets/ThirdParty/Environment/GreenhouseInteriorProps";

        private const string k_TextureRoot =
            "Assets/RootsDance/Textures/Environment/GreenhouseInteriorProps";

        private const string k_ShaderName =
            "BOXOPHOBIC/The Visual Engine/Geometry/General Subsurface Lit";

        private static readonly StaticEditorFlags k_StaticFlags =
            StaticEditorFlags.OccludeeStatic | StaticEditorFlags.ReflectionProbeStatic;

        private static readonly WholePrefabSpec[] k_WholePrefabs =
        {
            new WholePrefabSpec(
                "Greenhouse_RealisticBeechFern",
                k_SourceRoot + "/RealisticBeechFern/Beech Fern.fbx",
                "BeechFern",
                0.45f),
            new WholePrefabSpec(
                "Greenhouse_Fern01_Hero",
                k_SourceRoot + "/Fern01/fern1.fbx",
                "Fern01",
                1.2f),
            new WholePrefabSpec(
                "Greenhouse_FernGrass01_Patch",
                k_SourceRoot + "/FernGrass01/fern grass 01.obj",
                "FernGrass01",
                0.55f),
            new WholePrefabSpec(
                "Greenhouse_FernGrass02_Patch",
                k_SourceRoot + "/FernGrass02/fern grass 02.obj",
                "FernGrass02",
                0.5f),
            new WholePrefabSpec(
                "Greenhouse_FernsLowpoly",
                k_SourceRoot + "/FernsLowpoly/ferns fbx.fbx",
                "FernsLowpoly",
                0.7f),
            new WholePrefabSpec(
                "Greenhouse_BrackenFern",
                k_SourceRoot + "/BrackenFern/brackenFern.fbx",
                "BrackenFern",
                0.55f),
            new WholePrefabSpec(
                "Greenhouse_SwampFern",
                k_SourceRoot + "/SwampFern/swamp fern.fbx",
                "SwampFern",
                0.55f),
            new WholePrefabSpec(
                "Greenhouse_FernBush",
                k_SourceRoot + "/FernBush/Fern Bush .fbx",
                "FernBush",
                0.7f)
        };

        private static readonly TropicalPrefabSpec[] k_TropicalPrefabs =
        {
            new TropicalPrefabSpec("Greenhouse_TropicalPalm_B08_01", "SM_MZRa_Palm_B081", 2.6f),
            new TropicalPrefabSpec("Greenhouse_TropicalPalm_B08_02", "SM_MZRa_Palm_B082", 2.6f),
            new TropicalPrefabSpec("Greenhouse_TropicalPalm_B08_03", "SM_MZRa_Palm_B083", 2.6f),
            new TropicalPrefabSpec("Greenhouse_TropicalBanana_B09_01", "SM_MZRa_Banana_B091", 1.8f),
            new TropicalPrefabSpec("Greenhouse_TropicalBanana_B09_02", "SM_MZRa_Banana_B092", 1.8f),
            new TropicalPrefabSpec("Greenhouse_TropicalMonstera_B07_01", "tree.006SM_MZRa_Monstera_B071", 1.5f),
            new TropicalPrefabSpec("Greenhouse_TropicalMonstera_B07_02", "tree.007SM_MZRa_Monstera_B072", 1.5f),
            new TropicalPrefabSpec("Greenhouse_TropicalMonstera_B07_03", "tree.003SM_MZRa_Monstera_B073", 1.5f),
            new TropicalPrefabSpec("Greenhouse_TropicalMonstera_B07_04", "tree.002SM_MZRa_Monstera_B074", 1.5f),
            new TropicalPrefabSpec("Greenhouse_TropicalFern_B051_Large", "SM_MZRa_Fern_B051", 0.85f),
            new TropicalPrefabSpec("Greenhouse_TropicalFern_B051_Small", "SM_MZRa_Fern_B0512", 0.55f),
            new TropicalPrefabSpec("Greenhouse_TropicalFern_B052_Large", "SM_MZRa_Fern_B052", 0.8f),
            new TropicalPrefabSpec("Greenhouse_TropicalFern_B052_Small", "SM_MZRa_Fern_B0522", 0.5f),
            new TropicalPrefabSpec("Greenhouse_TropicalFern_B053_Large", "SM_MZRa_Fern_B053", 0.8f),
            new TropicalPrefabSpec("Greenhouse_TropicalFern_B053_Small", "SM_MZRa_Fern_B0532", 0.5f)
        };

        [MenuItem("RootsDance/Environment/Build Greenhouse Interior Props")]
        public static void Build()
        {
            AssetDatabase.Refresh();
            EnsureFolder(k_MaterialRoot);
            EnsureFolder(k_PrefabRoot);

            Dictionary<string, Material> materials = EnsureMaterials(true);
            BuildPrefabRange(0, 25, materials);
        }

        /// <summary>Creates only missing materials; intended for short Unity Pipeline calls.</summary>
        public static void EnsureMissingMaterials()
        {
            AssetDatabase.Refresh();
            EnsureFolder(k_MaterialRoot);
            EnsureMaterials(false);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        /// <summary>Builds a zero-based range of the 25 prefabs without rebuilding existing materials.</summary>
        public static void BuildPrefabBatch(int startIndex, int count)
        {
            AssetDatabase.Refresh();
            EnsureFolder(k_PrefabRoot);
            Dictionary<string, Material> materials = EnsureMaterials(false);
            BuildPrefabRange(startIndex, count, materials);
        }

        private static void BuildPrefabRange(
            int startIndex,
            int count,
            Dictionary<string, Material> materials)
        {
            Scene preview = EditorSceneManager.NewPreviewScene();
            int built = 0;
            int failed = 0;
            int endIndex = Mathf.Min(startIndex + count, 25);

            try
            {
                for (int i = Mathf.Max(startIndex, 0); i < Mathf.Min(endIndex, k_WholePrefabs.Length); i++)
                {
                    if (BuildWhole(k_WholePrefabs[i], materials, preview))
                    {
                        built++;
                    }
                    else
                    {
                        failed++;
                    }
                }

                if (startIndex <= 8 && endIndex > 8 && BuildLodPrefab(
                    "Greenhouse_MaleFern_LOD",
                    new[]
                    {
                        k_SourceRoot + "/MaleFern/Dryopteris filix-mas HD_Standard mat 50_LOD2.fbx",
                        k_SourceRoot + "/MaleFern/Dryopteris filix-mas HD_Standard mat 50_LOD4.fbx"
                    },
                    new[] { 0.42f, 0.06f },
                    "MaleFern",
                    0.85f,
                    materials,
                    preview))
                {
                    built++;
                }
                else if (startIndex <= 8 && endIndex > 8)
                {
                    failed++;
                }

                if (startIndex <= 9 && endIndex > 9 && BuildLodPrefab(
                    "Greenhouse_CommonPolypody_LOD",
                    new[]
                    {
                        k_SourceRoot + "/CommonPolypody/Polypodium vulgare HD_Groundcover 4 mat 50_LOD0.fbx",
                        k_SourceRoot + "/CommonPolypody/Polypodium vulgare HD_Groundcover 4 mat 50_LOD2.fbx",
                        k_SourceRoot + "/CommonPolypody/Polypodium vulgare HD_Groundcover 4 mat 50_LOD4.fbx"
                    },
                    new[] { 0.55f, 0.22f, 0.05f },
                    "CommonPolypody",
                    0.45f,
                    materials,
                    preview))
                {
                    built++;
                }
                else if (startIndex <= 9 && endIndex > 9)
                {
                    failed++;
                }

                GameObject tropicalModel = AssetDatabase.LoadAssetAtPath<GameObject>(
                    k_SourceRoot + "/TropicalPlantsM02P/MZRa_Pack_M02P.fbx");

                int tropicalStart = Mathf.Max(startIndex - 10, 0);
                int tropicalEnd = Mathf.Min(endIndex - 10, k_TropicalPrefabs.Length);

                for (int i = tropicalStart; i < tropicalEnd; i++)
                {
                    if (BuildTropicalPiece(tropicalModel, k_TropicalPrefabs[i], materials, preview))
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

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log($"GreenhouseInteriorPropsBuilder: built {built} prefabs ({failed} failed) under "
                + $"{k_PrefabRoot}.");
        }

        private static Dictionary<string, Material> EnsureMaterials(bool updateExisting)
        {
            Dictionary<string, Material> result = new Dictionary<string, Material>(32);
            string source = k_SourceRoot;
            string derived = k_TextureRoot;

            AddMaterial(result, "BeechFern", derived + "/BeechFern_AlbedoOpacity.png",
                source + "/RealisticBeechFern/vmkpdbeia_4K_Normal.jpg", true, updateExisting);
            AddMaterial(result, "Fern01", derived + "/Fern01_AlbedoOpacity.png",
                source + "/Fern01/Normal.jpg", true, updateExisting);
            AddMaterial(result, "FernGrass01", derived + "/FernGrass01_AlbedoOpacity.png",
                source + "/FernGrass01/2023-11-17T173153Z_NormalMap.png", true, updateExisting);
            AddMaterial(result, "FernGrass02", derived + "/FernGrass02_AlbedoOpacity.png",
                source + "/FernGrass02/generatedT113338Z_NormalMap.png", true, updateExisting);
            AddMaterial(result, "FernsLowpoly", source + "/FernsLowpoly/ferns_1.png",
                source + "/FernsLowpoly/NormalMap_(1).png", true, updateExisting);
            AddMaterial(result, "BrackenFern", derived + "/BrackenFern_AlbedoOpacity.png",
                source + "/BrackenFern/M_all_normal.png", true, updateExisting);
            AddMaterial(result, "SwampFern", source + "/SwampFern/swampbush_leaves_a.png",
                source + "/SwampFern/swampbush_leaves_n.png", true, updateExisting);
            AddMaterial(result, "FernBush", source + "/FernBush/PM3D_ZSphere_1_TXTR.png", null, false,
                updateExisting);

            AddMaterial(result, "TropicalFern051", derived + "/TropicalFern051_AlbedoOpacity.png", null, true,
                updateExisting);
            AddMaterial(result, "TropicalFern052", derived + "/TropicalFern052_AlbedoOpacity.png", null, true,
                updateExisting);
            AddMaterial(result, "TropicalFern053", derived + "/TropicalFern053_AlbedoOpacity.png", null, true,
                updateExisting);
            AddMaterial(result, "TropicalPalmA", source + "/TropicalPlantsM02P/T_MZRa_Palm_B08a_BC.png",
                null, true, updateExisting);
            AddMaterial(result, "TropicalPalmB", source + "/TropicalPlantsM02P/T_MZRa_Palm_B08b_BC.png",
                source + "/TropicalPlantsM02P/T_MZRa_Palm_B08b_N.png", false, updateExisting);
            AddMaterial(result, "TropicalMonsteraA1",
                source + "/TropicalPlantsM02P/MI_MZRa_Monstera_B07a1_BC.png", null, true, updateExisting);
            AddMaterial(result, "TropicalMonsteraA2",
                source + "/TropicalPlantsM02P/MI_MZRa_Monstera_B07a2_BC.png", null, true, updateExisting);
            AddMaterial(result, "TropicalMonsteraB",
                source + "/TropicalPlantsM02P/T_MZRa_Monstera_B07b_BC.png",
                source + "/TropicalPlantsM02P/T_MZRa_Monstera_B07b_N.png", false, updateExisting);
            AddMaterial(result, "TropicalBananaA",
                source + "/TropicalPlantsM02P/T_MZRa_Banana_B09a_BC.png",
                source + "/TropicalPlantsM02P/T_MZRa_Banana_B09_N.png", true, updateExisting);
            AddMaterial(result, "TropicalBananaB",
                source + "/TropicalPlantsM02P/T_MZRa_Banana_B09_BC.png",
                source + "/TropicalPlantsM02P/T_MZRa_Banana_B09_N.png", false, updateExisting);

            string commonNormal = source
                + "/CommonPolypody/Polypodium_vulgare_HD_Polypodium_01b_"
                + "Polypodium_vulgare_leaf_atlas_01_n_LOD0_Normal.png";
            AddMaterial(result, "CommonA", derived + "/CommonPolypody_A_AlbedoOpacity.png", commonNormal, true,
                updateExisting);
            AddMaterial(result, "CommonB", derived + "/CommonPolypody_B_AlbedoOpacity.png", commonNormal, true,
                updateExisting);
            AddMaterial(result, "CommonC", derived + "/CommonPolypody_C_AlbedoOpacity.png", commonNormal, true,
                updateExisting);

            string maleNormal = source
                + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_lf_left_2_"
                + "Dryopteris_filix_mas_leaflet_atlas_03_n_LOD4_Normal.png";
            AddMaterial(result, "MaleLeaf2L", derived + "/MaleFern_Leaf2L_AlbedoOpacity.png", maleNormal, true,
                updateExisting);
            AddMaterial(result, "MaleLeaf2R", derived + "/MaleFern_Leaf2R_AlbedoOpacity.png", maleNormal, true,
                updateExisting);
            AddMaterial(result, "MaleLeaf5", derived + "/MaleFern_Leaf5_AlbedoOpacity.png", maleNormal, true,
                updateExisting);
            AddMaterial(result, "MaleLeaf6", derived + "/MaleFern_Leaf6_AlbedoOpacity.png", maleNormal, true,
                updateExisting);
            AddMaterial(result, "MaleScale", derived + "/MaleFern_Scale_AlbedoOpacity.png",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_scale_Fern_scale_01_n_LOD4_Normal.png",
                true,
                updateExisting);
            AddMaterial(result, "MaleStalk",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_stalk_Fern_stalk_01_LOD4_Color.png",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_stalk_Fern_stalk_01_n_LOD4_Normal.png",
                false,
                updateExisting);
            AddMaterial(result, "MaleStalk1",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_stalk_1_Fern_stalk_01b_LOD4_Color.png",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_stalk_Fern_stalk_01_n_LOD4_Normal.png",
                false,
                updateExisting);
            AddMaterial(result, "MaleTrunk",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_trunk_Fern_trunk_02_LOD4_Color.png",
                source + "/MaleFern/Dryopteris_filix_mas_HD_Dryopteris_trunk_Fern_trunk_02_n_LOD4_Normal.png",
                false,
                updateExisting);

            return result;
        }

        private static void AddMaterial(
            Dictionary<string, Material> materials,
            string key,
            string albedoPath,
            string normalPath,
            bool cutout,
            bool updateExisting)
        {
            Shader shader = Shader.Find(k_ShaderName);

            if (shader == null)
            {
                Debug.LogError($"GreenhouseInteriorPropsBuilder: shader '{k_ShaderName}' was not found.");
                return;
            }

            string path = k_MaterialRoot + "/" + key + ".mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material != null && !updateExisting)
            {
                materials[key] = material;
                return;
            }

            if (material == null)
            {
                material = new Material(shader);
                material.name = key;
                AssetDatabase.CreateAsset(material, path);
            }
            else if (material.shader != shader)
            {
                material.shader = shader;
            }

            material.SetTexture("_MainAlbedoTex", AssetDatabase.LoadAssetAtPath<Texture2D>(albedoPath));
            material.SetTexture("_MainNormalTex", string.IsNullOrEmpty(normalPath)
                ? null
                : AssetDatabase.LoadAssetAtPath<Texture2D>(normalPath));
            material.SetColor("_MainColor", Color.white);
            material.SetFloat("_MainSmoothnessValue", 0.12f);
            material.SetFloat("_MainMetallicValue", 0f);
            material.SetFloat("_RenderClip", cutout ? 1f : 0f);
            material.SetFloat("_MainAlphaClipValue", cutout ? 0.35f : 0.5f);
            material.SetFloat("_RenderCull", 0f);
            material.SetFloat("_RenderNormal", 2f);
            material.SetFloat("_MotionIntensityValue", 1f);
            material.SetFloat("_MotionBaseIntensityValue", 0.45f);
            material.SetFloat("_MotionSmallIntensityValue", 0.3f);
            material.SetFloat("_MotionTinyIntensityValue", 0.4f);
            material.SetFloat("_MotionBaseMaskMode", 4f);
            material.SetFloat("_MotionSmallMaskMode", 4f);
            material.SetFloat("_MotionTinyMaskMode", 4f);
            material.SetFloat("_SubsurfaceIntensityValue", 1f);
            material.SetFloat("_FlattenIntensityValue", cutout && string.IsNullOrEmpty(normalPath) ? 0.55f : 0f);
            material.SetFloat("_FlattenSphereValue", cutout && string.IsNullOrEmpty(normalPath) ? 1f : 0f);
            material.SetFloat("_IsConverted", 1f);
            material.SetInt("_IsObjectType", 3);
            material.enableInstancing = true;

            TVEUtils.SetMaterialSettings(material);
            TVEUtils.SetLabel(path);
            EditorUtility.SetDirty(material);
            materials[key] = material;
        }

        private static bool BuildWhole(
            WholePrefabSpec spec,
            Dictionary<string, Material> materials,
            Scene preview)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(spec.ModelPath);

            if (model == null)
            {
                Debug.LogError($"GreenhouseInteriorPropsBuilder: model missing at '{spec.ModelPath}'.");
                return false;
            }

            GameObject root = NewRoot(spec.PrefabName, preview);
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model, preview);

            try
            {
                instance.transform.SetParent(root.transform, false);
                Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);
                ApplyMaterials(renderers, spec.MaterialKey, materials);
                GroundAndScale(root, instance.transform, renderers, spec.TargetHeight);
                FinalizeRenderers(root, renderers);
                return Save(root, spec.PrefabName);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        private static bool BuildLodPrefab(
            string prefabName,
            string[] modelPaths,
            float[] transitionHeights,
            string materialKey,
            float targetHeight,
            Dictionary<string, Material> materials,
            Scene preview)
        {
            GameObject root = NewRoot(prefabName, preview);
            LOD[] lods = new LOD[modelPaths.Length];
            float scale = 1f;

            try
            {
                for (int i = 0; i < modelPaths.Length; i++)
                {
                    GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(modelPaths[i]);

                    if (model == null)
                    {
                        Debug.LogError($"GreenhouseInteriorPropsBuilder: LOD model missing at '{modelPaths[i]}'.");
                        return false;
                    }

                    GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(model, preview);
                    instance.name = "LOD" + i;
                    instance.transform.SetParent(root.transform, false);
                    Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);
                    ApplyMaterials(renderers, materialKey, materials);
                    Bounds bounds = BoundsOf(renderers);
                    instance.transform.position -= new Vector3(bounds.center.x, bounds.min.y, bounds.center.z);

                    if (i == 0 && bounds.size.y > 0.0001f)
                    {
                        scale = targetHeight / bounds.size.y;
                    }

                    FinalizeRenderers(instance, renderers);
                    lods[i] = new LOD(transitionHeights[i], renderers);
                }

                root.transform.localScale = Vector3.one * scale;
                LODGroup group = root.AddComponent<LODGroup>();
                group.fadeMode = LODFadeMode.CrossFade;
                group.animateCrossFading = true;
                group.SetLODs(lods);
                group.RecalculateBounds();
                ApplyStaticFlags(root);
                return Save(root, prefabName);
            }
            finally
            {
                Object.DestroyImmediate(root);
            }
        }

        private static bool BuildTropicalPiece(
            GameObject model,
            TropicalPrefabSpec spec,
            Dictionary<string, Material> materials,
            Scene preview)
        {
            if (model == null)
            {
                Debug.LogError("GreenhouseInteriorPropsBuilder: Tropical Plants M02P model is missing.");
                return false;
            }

            GameObject source = (GameObject)PrefabUtility.InstantiatePrefab(model, preview);
            MeshRenderer[] sourceRenderers = source.GetComponentsInChildren<MeshRenderer>(true);
            MeshRenderer sourceRenderer = null;

            for (int i = 0; i < sourceRenderers.Length; i++)
            {
                if (sourceRenderers[i].name == spec.MeshName)
                {
                    sourceRenderer = sourceRenderers[i];
                    break;
                }
            }

            if (sourceRenderer == null)
            {
                Object.DestroyImmediate(source);
                Debug.LogError($"GreenhouseInteriorPropsBuilder: tropical mesh '{spec.MeshName}' was not found.");
                return false;
            }

            MeshFilter sourceFilter = sourceRenderer.GetComponent<MeshFilter>();

            if (sourceFilter == null || sourceFilter.sharedMesh == null)
            {
                Object.DestroyImmediate(source);
                Debug.LogError($"GreenhouseInteriorPropsBuilder: tropical mesh '{spec.MeshName}' has no MeshFilter.");
                return false;
            }

            GameObject root = NewRoot(spec.PrefabName, preview);
            GameObject child = new GameObject("Mesh");
            child.transform.SetParent(root.transform, false);
            child.transform.position = sourceRenderer.transform.position;
            child.transform.rotation = sourceRenderer.transform.rotation;
            child.transform.localScale = sourceRenderer.transform.lossyScale;

            MeshFilter filter = child.AddComponent<MeshFilter>();
            filter.sharedMesh = sourceFilter.sharedMesh;
            MeshRenderer renderer = child.AddComponent<MeshRenderer>();
            renderer.sharedMaterials = MapMaterials(sourceRenderer.sharedMaterials, "Tropical", materials);

            try
            {
                Renderer[] renderers = { renderer };
                GroundAndScale(root, child.transform, renderers, spec.TargetHeight);
                FinalizeRenderers(root, renderers);
                return Save(root, spec.PrefabName);
            }
            finally
            {
                Object.DestroyImmediate(root);
                Object.DestroyImmediate(source);
            }
        }

        private static void ApplyMaterials(
            Renderer[] renderers,
            string materialKey,
            Dictionary<string, Material> materials)
        {
            for (int i = 0; i < renderers.Length; i++)
            {
                renderers[i].sharedMaterials = MapMaterials(renderers[i].sharedMaterials, materialKey, materials);
            }
        }

        private static Material[] MapMaterials(
            Material[] vendorMaterials,
            string materialKey,
            Dictionary<string, Material> materials)
        {
            int count = vendorMaterials.Length == 0 ? 1 : vendorMaterials.Length;
            Material[] mapped = new Material[count];

            for (int i = 0; i < count; i++)
            {
                string vendorName = vendorMaterials.Length == 0 || vendorMaterials[i] == null
                    ? string.Empty
                    : vendorMaterials[i].name.ToLowerInvariant();
                string key = ResolveMaterialKey(materialKey, vendorName);
                Material material;

                if (!materials.TryGetValue(key, out material))
                {
                    materials.TryGetValue(materialKey, out material);
                }

                mapped[i] = material;
            }

            return mapped;
        }

        private static string ResolveMaterialKey(string group, string vendorName)
        {
            if (group == "CommonPolypody")
            {
                if (vendorName.Contains("01a")) return "CommonA";
                if (vendorName.Contains("01c")) return "CommonC";
                return "CommonB";
            }

            if (group == "MaleFern")
            {
                if (vendorName.Contains("stalk_1")) return "MaleStalk1";
                if (vendorName.Contains("stalk")) return "MaleStalk";
                if (vendorName.Contains("trunk")) return "MaleTrunk";
                if (vendorName.Contains("scale")) return "MaleScale";
                if (vendorName.Contains("right 2")) return "MaleLeaf2R";
                if (vendorName.Contains("left 2")) return "MaleLeaf2L";
                if (vendorName.Contains(" 5")) return "MaleLeaf5";
                return "MaleLeaf6";
            }

            if (group == "Tropical")
            {
                if (vendorName.Contains("fern_b051")) return "TropicalFern051";
                if (vendorName.Contains("fern_b052")) return "TropicalFern052";
                if (vendorName.Contains("fern_b053")) return "TropicalFern053";
                if (vendorName.Contains("palm_b08a")) return "TropicalPalmA";
                if (vendorName.Contains("palm_b08b")) return "TropicalPalmB";
                if (vendorName.Contains("monstera_b07a1")) return "TropicalMonsteraA1";
                if (vendorName.Contains("monstera_b07a2")) return "TropicalMonsteraA2";
                if (vendorName.Contains("monstera_b07b")) return "TropicalMonsteraB";
                if (vendorName.Contains("banana_b09a")) return "TropicalBananaA";
                if (vendorName.Contains("banana_b09b")) return "TropicalBananaB";
            }

            return group;
        }

        private static void GroundAndScale(
            GameObject root,
            Transform movable,
            Renderer[] renderers,
            float targetHeight)
        {
            Bounds bounds = BoundsOf(renderers);
            movable.position -= new Vector3(bounds.center.x, bounds.min.y, bounds.center.z);

            if (bounds.size.y > 0.0001f)
            {
                root.transform.localScale = Vector3.one * (targetHeight / bounds.size.y);
            }
        }

        private static Bounds BoundsOf(Renderer[] renderers)
        {
            Bounds bounds = default;
            bool initialized = false;

            for (int i = 0; i < renderers.Length; i++)
            {
                if (!initialized)
                {
                    bounds = renderers[i].bounds;
                    initialized = true;
                }
                else
                {
                    bounds.Encapsulate(renderers[i].bounds);
                }
            }

            return bounds;
        }

        private static void FinalizeRenderers(GameObject root, Renderer[] renderers)
        {
            for (int i = 0; i < renderers.Length; i++)
            {
                renderers[i].shadowCastingMode = ShadowCastingMode.Off;
                renderers[i].receiveShadows = true;
                renderers[i].lightProbeUsage = LightProbeUsage.BlendProbes;
            }

            ApplyStaticFlags(root);
        }

        private static void ApplyStaticFlags(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                GameObjectUtility.SetStaticEditorFlags(transforms[i].gameObject, k_StaticFlags);
            }
        }

        private static GameObject NewRoot(string name, Scene preview)
        {
            GameObject root = new GameObject(name);
            SceneManager.MoveGameObjectToScene(root, preview);
            return root;
        }

        private static bool Save(GameObject root, string prefabName)
        {
            string path = k_PrefabRoot + "/" + prefabName + ".prefab";
            bool success;
            PrefabUtility.SaveAsPrefabAsset(root, path, out success);

            if (!success)
            {
                Debug.LogError($"GreenhouseInteriorPropsBuilder: failed to save '{path}'.");
            }

            return success;
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

        private readonly struct WholePrefabSpec
        {
            public readonly string PrefabName;
            public readonly string ModelPath;
            public readonly string MaterialKey;
            public readonly float TargetHeight;

            public WholePrefabSpec(string prefabName, string modelPath, string materialKey, float targetHeight)
            {
                PrefabName = prefabName;
                ModelPath = modelPath;
                MaterialKey = materialKey;
                TargetHeight = targetHeight;
            }
        }

        private readonly struct TropicalPrefabSpec
        {
            public readonly string PrefabName;
            public readonly string MeshName;
            public readonly float TargetHeight;

            public TropicalPrefabSpec(string prefabName, string meshName, float targetHeight)
            {
                PrefabName = prefabName;
                MeshName = meshName;
                TargetHeight = targetHeight;
            }
        }
    }
}
