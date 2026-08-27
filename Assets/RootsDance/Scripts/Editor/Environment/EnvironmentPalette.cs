using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using TheVisualEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Creates and maintains the material palette that every outdoor-dressing prefab is painted with.
    /// Vendor sub-materials are never used directly: <see cref="EnvironmentPrefabBuilder"/> maps each vendor
    /// material name onto one of the keys below so the whole chapter shares one look.
    /// <para>
    /// Two families live here. The vendor dressing (<see cref="k_TveSpecs"/>) is built on The Visual Engine
    /// shaders so wind, global tinting, seasons, wetness and player interaction are driven by the scene's
    /// <c>TVE Manager</c> instead of per-material tweaks (guideline 07 §10). The flat greybox colours and the
    /// lab blockout materials stay on HDRP/Lit because they are consumed by the terrain greybox tools.
    /// </para>
    /// Idempotent — existing <c>.mat</c> assets are updated in place, never duplicated.
    /// </summary>
    public static class EnvironmentPalette
    {
        /// <summary>Folder that holds every palette material.</summary>
        public const string k_MaterialFolder = "Assets/RootsDance/Materials/Environment";

        private const string k_LitShader = "HDRP/Lit";
        private const string k_TveStandardShader = "BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit";
        private const string k_TveSubsurfaceShader = "BOXOPHOBIC/The Visual Engine/Geometry/General Subsurface Lit";
        private const string k_ThirdPartyRoot = "Assets/ThirdParty/Environment";
        private const string k_PolyHavenRoot = k_ThirdPartyRoot + "/PolyHaven/Models";
        private const string k_RetroRoot = k_ThirdPartyRoot + "/RetroPSXNature";
        private const string k_NiwlRoot = k_ThirdPartyRoot + "/NiwlPlants";

        /// <summary>Derived textures (packed by hand from vendor maps) live with the project textures.</summary>
        private const string k_DerivedTextureRoot = "Assets/RootsDance/Textures/Environment";

        // Vendor scans keep their own albedo; the PSX/low-poly packs are pulled towards the cold grey-green
        // read of the dead ring with a tint (guideline: the source art is never the final look).
        private static readonly Color k_DeadTint = new Color(0.78f, 0.78f, 0.74f);
        private static readonly Color k_TransitionTint = new Color(0.50f, 0.60f, 0.54f);
        private const float k_ScanSmoothness = 0.15f;
        private const float k_PsxSmoothness = 0.05f;
        private const float k_MetalSmoothness = 0.45f;
        private const float k_GlassPaletteSmoothness = 0.6f;

        private const float k_FlatSmoothness = 0.05f;
        private const float k_GlassSmoothness = 0.8f;
        private const float k_ConcreteLabTiling = 0.25f;

        // The lab blockout FBX has no usable UVs, so Concrete_Lab's texture tiles into noise on it. A pale
        // warm base colour is what actually carries the "light concrete" read; the map only adds grain.
        private const float k_ConcreteLabSmoothness = 0.15f;

        private static readonly int k_BaseColorId = Shader.PropertyToID("_BaseColor");
        private static readonly int k_BaseColorMapId = Shader.PropertyToID("_BaseColorMap");
        private static readonly int k_NormalMapId = Shader.PropertyToID("_NormalMap");
        private static readonly int k_SmoothnessId = Shader.PropertyToID("_Smoothness");
        private static readonly int k_MetallicId = Shader.PropertyToID("_Metallic");
        private static readonly int k_BlendModeId = Shader.PropertyToID("_BlendMode");
        private static readonly int k_TransparentZWriteId = Shader.PropertyToID("_TransparentZWrite");

        // The Visual Engine "General * Lit" property block (Core/Shaders/Geometry/*.shader).
        private static readonly int k_TveAlbedoId = Shader.PropertyToID("_MainAlbedoTex");
        private static readonly int k_TveNormalId = Shader.PropertyToID("_MainNormalTex");
        private static readonly int k_TveColorId = Shader.PropertyToID("_MainColor");
        private static readonly int k_TveSmoothnessId = Shader.PropertyToID("_MainSmoothnessValue");
        private static readonly int k_TveMetallicId = Shader.PropertyToID("_MainMetallicValue");
        private static readonly int k_TveRenderClipId = Shader.PropertyToID("_RenderClip");
        private static readonly int k_TveAlphaClipId = Shader.PropertyToID("_MainAlphaClipValue");
        private static readonly int k_TveRenderCullId = Shader.PropertyToID("_RenderCull");
        private static readonly int k_TveRenderNormalId = Shader.PropertyToID("_RenderNormal");
        private static readonly int k_TveMotionId = Shader.PropertyToID("_MotionIntensityValue");
        private static readonly int k_TveMotionBaseId = Shader.PropertyToID("_MotionBaseIntensityValue");
        private static readonly int k_TveMotionSmallId = Shader.PropertyToID("_MotionSmallIntensityValue");
        private static readonly int k_TveMotionTinyId = Shader.PropertyToID("_MotionTinyIntensityValue");
        private static readonly int k_TveSubsurfaceId = Shader.PropertyToID("_SubsurfaceIntensityValue");
        private static readonly int k_TveIsConvertedId = Shader.PropertyToID("_IsConverted");
        private static readonly int k_TveFlattenId = Shader.PropertyToID("_FlattenIntensityValue");
        private static readonly int k_TveFlattenSphereId = Shader.PropertyToID("_FlattenSphereValue");

        // PSX card foliage: a 256 px sheet loses its thinnest twigs at the default 0.5 clip, and TVE's Flatten
        // block spherifies the shading normals so crossed cards read as one volume instead of flat planes.
        private const float k_CardAlphaClip = 0.35f;
        private const float k_CardFlatten = 0.8f;
        private static readonly int k_TveObjectTypeId = Shader.PropertyToID("_IsObjectType");

        // _IsObjectType values TVE's own converter writes (TVEUtility.SetMaterialUpgrade): the tools and the
        // debug views group materials by it; fresh materials would otherwise stay at 0 (unset).
        private const int k_ObjectProp = 1;
        private const int k_ObjectBark = 2;
        private const int k_ObjectLeaf = 3;

        // _RenderCull: 0 Both, 1 Back, 2 Front (shader default). _RenderNormal: 0 Flip, 1 Mirror, 2 Same.
        private const float k_CullBoth = 0f;
        private const float k_CullFront = 2f;
        private const float k_NormalFlip = 0f;
        private const float k_NormalSame = 2f;

        /// <summary>The flat-colour half of the palette: key plus its sRGB greybox colour.</summary>
        private static readonly FlatSpec[] k_FlatSpecs =
        {
            new FlatSpec("Bark_Dead", 0x6B, 0x62, 0x5A),
            new FlatSpec("Bark_Alive", 0x5A, 0x4E, 0x42),
            new FlatSpec("Leaf_Alive", 0x4A, 0x66, 0x47),
            new FlatSpec("Leaf_Half", 0x7E, 0x7A, 0x55),
            new FlatSpec("Leaf_Dead", 0x6E, 0x6A, 0x5E),
            new FlatSpec("Grass_Silver", 0x8F, 0xA8, 0x8C),
            new FlatSpec("Plant_Cold", 0x6F, 0x8C, 0x74),
            new FlatSpec("Mushroom_Tan", 0xA8, 0x97, 0x7A),
            new FlatSpec("Mushroom_Red", 0x8C, 0x5A, 0x4E),
            new FlatSpec("Rock_Grey", 0x6E, 0x6B, 0x66),
            new FlatSpec("Rock_Moss", 0x5C, 0x6B, 0x58),
            new FlatSpec("Wood_Log", 0x5E, 0x51, 0x48),
            new FlatSpec("Metal_Dark", 0x4A, 0x4E, 0x50),
            new FlatSpec("Metal_Rust", 0x6E, 0x4F, 0x3C),
            new FlatSpec("Concrete_Pale", 0x9A, 0x96, 0x8E),
            new FlatSpec("Sign_Face", 0xB8, 0xB4, 0xA6)
        };

        /// <summary>
        /// The textured HDRP/Lit half of the palette: only the lab blockout concrete, consumed by the terrain
        /// greybox tools. A spec may leave its base map empty, which makes it a flat colour with a normal map.
        /// </summary>
        private static readonly TexturedSpec[] k_TexturedSpecs =
        {
            // No base map on purpose: the lab blockout's vendor UVs have nothing to do with world scale,
            // so Concrete032's colour map lands as a dark, arbitrary crop and paints the whole building
            // charcoal. The normal map still adds surface break-up; the pale base colour carries the read.
            new TexturedSpec(
                "Concrete_Lab",
                null,
                k_ThirdPartyRoot + "/AmbientCG/Concrete032/Concrete032_1K-JPG_NormalGL.jpg",
                k_ConcreteLabTiling,
                new Color(0.62f, 0.60f, 0.56f),
                k_ConcreteLabSmoothness)
        };

        /// <summary>
        /// The Visual Engine half of the palette: one material per vendor texture set. The kind decides the
        /// shader (Standard vs Subsurface Lit), the cull/normal mode and how much of the global wind the
        /// material takes; everything else (tinting, seasons, wetness, interaction) is driven by the scene's
        /// TVE Manager and stays at the shader defaults here.
        /// </summary>
        private static readonly TveSpec[] k_TveSpecs =
        {
            // Retro PSX Nature (elegantcrow): 6 winter trees, 6 winter bushes, 2 plain bushes. One 256/128 px
            // card texture per model, no normal map. Trees are one material (trunk + crown in one sheet).
            TveSpec.Tree("Psx_Tree01_Winter", k_RetroRoot + "/Textures/Trees/tree01_winter.png", k_DeadTint),
            TveSpec.Tree("Psx_Tree02_Winter", k_RetroRoot + "/Textures/Trees/tree02_winter.png", k_DeadTint),
            TveSpec.Tree("Psx_Tree03_Winter", k_RetroRoot + "/Textures/Trees/tree03_winter.png", k_DeadTint),
            TveSpec.Tree("Psx_Tree04_Winter", k_RetroRoot + "/Textures/Trees/tree04_winter.png", k_DeadTint),
            TveSpec.Tree("Psx_Tree05_Winter", k_RetroRoot + "/Textures/Trees/tree05_winter.png", k_DeadTint),
            TveSpec.Tree("Psx_Tree06_Winter", k_RetroRoot + "/Textures/Trees/tree06_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush01_Winter", k_RetroRoot + "/Textures/Bushes/bush1_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush02_Winter", k_RetroRoot + "/Textures/Bushes/bush2_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush03_Winter", k_RetroRoot + "/Textures/Bushes/bush3_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush04_Winter", k_RetroRoot + "/Textures/Bushes/bush4_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush05_Winter", k_RetroRoot + "/Textures/Bushes/bush5_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush06_Winter", k_RetroRoot + "/Textures/Bushes/bush6_winter.png", k_DeadTint),
            TveSpec.Leaf("Psx_Bush07_Fall", k_RetroRoot + "/Textures/Bushes/bush7_fall.png", k_TransitionTint),
            TveSpec.Leaf("Psx_Bush08_Fall", k_RetroRoot + "/Textures/Bushes/bush8_fall.png", k_TransitionTint),

            // Niwl Plants (Khaleer, CC0): two shared 2K atlases — General (grass, ferns, bushes 1-3) and
            // General_Bunch (bush 4, ivy). Ground plants: subsurface, both faces, secondary wind only.
            TveSpec.Plant("Niwl_Plants_General", k_NiwlRoot + "/Textures/T_Plants_General.png", k_TransitionTint),
            TveSpec.Plant("Niwl_Plants_Bunch", k_NiwlRoot + "/Textures/T_Plants_General_Bunch.png", k_TransitionTint),

            // Poly Haven scans (CC0): photogrammetry props keep their own colour; no wind (they are dead wood,
            // roots and rocks), but the global tint/wetness/coat layers still apply through TVE.
            TveSpec.Scan("Scan_DeadTreeTrunk", k_PolyHavenRoot + "/dead_tree_trunk/dead_tree_trunk"),
            TveSpec.Scan("Scan_DeadTreeTrunk02", k_PolyHavenRoot + "/dead_tree_trunk_02/dead_tree_trunk_02"),
            TveSpec.Scan("Scan_DryBranchesMedium01",
                k_PolyHavenRoot + "/dry_branches_medium_01/dry_branches_medium_01"),
            TveSpec.Scan("Scan_PineRoots_A", k_PolyHavenRoot + "/pine_roots/pine_roots_a", ".png", ".png"),
            TveSpec.Scan("Scan_PineRoots_B", k_PolyHavenRoot + "/pine_roots/pine_roots_b", ".png", ".png"),
            TveSpec.Scan("Scan_RootCluster01", k_PolyHavenRoot + "/root_cluster_01/root_cluster_01"),
            TveSpec.Scan("Scan_RootCluster02", k_PolyHavenRoot + "/root_cluster_02/root_cluster_02"),
            TveSpec.Scan("Scan_SingleRoot", k_PolyHavenRoot + "/single_root/single_root"),
            TveSpec.Scan("Scan_RockMossSet01", k_PolyHavenRoot + "/rock_moss_set_01/rock_moss_set_01"),
            TveSpec.Scan("Scan_RockMossSet02", k_PolyHavenRoot + "/rock_moss_set_02/rock_moss_set_02"),
            TveSpec.Scan("Scan_ConcreteRoadBarrier",
                k_PolyHavenRoot + "/concrete_road_barrier/concrete_road_barrier"),
            TveSpec.Scan("Scan_Clipboard", k_PolyHavenRoot + "/clipboard/clipboard"),
            TveSpec.Scan("Scan_BinderNotebook", k_PolyHavenRoot + "/binder_notebook/binder_notebook"),
            TveSpec.Scan("Scan_ChainlinkFence_Posts",
                k_PolyHavenRoot + "/modular_chainlink_fence/modular_chainlink_fence_posts", ".png", ".png")
                .WithSmoothness(k_MetalSmoothness),
            // The wire albedo has its opacity in a separate _alpha map; ChainlinkFenceWire_BaseMap.png is the
            // two packed together (magick, see docs/third-party.md) so the TVE cutout can read albedo alpha.
            TveSpec.Prop("Scan_ChainlinkFence_Wire",
                k_DerivedTextureRoot + "/ChainlinkFenceWire_BaseMap.png",
                k_PolyHavenRoot + "/modular_chainlink_fence/modular_chainlink_fence_wire_nor_gl_1k.png",
                Color.white, k_MetalSmoothness, true),

            // Lab Assets (MilkAndBanana, CC0): every FBX embeds the same 256x1 palette strip, which Unity does
            // not expose as a sub-asset; LabPalette_BaseMap.png is that strip extracted verbatim from
            // bottle_test_tube_rack.fbx (docs/third-party.md). One opaque material for all the camp props.
            TveSpec.Prop("Lab_Palette", k_DerivedTextureRoot + "/LabPalette_BaseMap.png", null,
                k_DeadTint, k_GlassPaletteSmoothness, false)
        };

        /// <summary>Key of the transparent dome material, built separately because it needs the blend state.</summary>
        private const string k_GlassKey = "Lab_Glass";

        private static readonly Color k_GlassColor = new Color(0xA8 / 255f, 0xC4 / 255f, 0xC0 / 255f, 0.35f);

        /// <summary>Asset path of the palette material for <paramref name="key"/>.</summary>
        public static string MaterialPath(string key)
        {
            return $"{k_MaterialFolder}/{key}.mat";
        }

        /// <summary>
        /// Creates or updates every palette material and returns them keyed by palette key. Safe to call
        /// repeatedly: an existing asset keeps its GUID so prefabs and scenes never lose their reference.
        /// </summary>
        public static Dictionary<string, Material> EnsureAll()
        {
            Dictionary<string, Material> palette = new Dictionary<string, Material>(64);
            Shader lit = Shader.Find(k_LitShader);
            Shader tveStandard = Shader.Find(k_TveStandardShader);
            Shader tveSubsurface = Shader.Find(k_TveSubsurfaceShader);

            if (lit == null)
            {
                Debug.LogError($"EnvironmentPalette: shader '{k_LitShader}' not found; palette not built.");
                return palette;
            }

            if (tveStandard == null || tveSubsurface == null)
            {
                Debug.LogError("EnvironmentPalette: The Visual Engine shaders not found "
                    + $"('{k_TveStandardShader}', '{k_TveSubsurfaceShader}'); palette not built.");
                return palette;
            }

            EnsureFolder(k_MaterialFolder);

            foreach (FlatSpec spec in k_FlatSpecs)
            {
                palette[spec.Key] = EnsureFlat(lit, spec);
            }

            foreach (TexturedSpec spec in k_TexturedSpecs)
            {
                palette[spec.Key] = EnsureTextured(lit, spec);
            }

            palette[k_GlassKey] = EnsureGlass(lit);

            foreach (TveSpec spec in k_TveSpecs)
            {
                palette[spec.Key] = EnsureTve(spec.Subsurface ? tveSubsurface : tveStandard, spec);
            }

            AssetDatabase.SaveAssets();
            Debug.Log($"EnvironmentPalette: ensured {palette.Count} materials under {k_MaterialFolder}.");
            return palette;
        }

        /// <summary>Loads one palette material by key; logs an error and returns null when it is missing.</summary>
        public static Material Get(string key)
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath(key));

            if (material == null)
            {
                Debug.LogError($"EnvironmentPalette: no material for key '{key}'. Run EnsureAll() first.");
            }

            return material;
        }

        private static Material EnsureFlat(Shader lit, FlatSpec spec)
        {
            Material material = EnsureAsset(lit, spec.Key);

            material.SetColor(k_BaseColorId, spec.Color);
            material.SetFloat(k_SmoothnessId, k_FlatSmoothness);
            material.SetFloat(k_MetallicId, 0f);
            material.enableInstancing = true;
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureTextured(Shader lit, TexturedSpec spec)
        {
            Material material = EnsureAsset(lit, spec.Key);
            Texture2D baseMap = null;

            // An empty path is a deliberate "flat colour plus normal map" spec, not a missing asset.
            if (!string.IsNullOrEmpty(spec.BaseMapPath))
            {
                baseMap = AssetDatabase.LoadAssetAtPath<Texture2D>(spec.BaseMapPath);

                if (baseMap == null)
                {
                    Debug.LogWarning($"EnvironmentPalette: '{spec.Key}' base map missing at {spec.BaseMapPath}.");
                }
            }

            material.SetColor(k_BaseColorId, spec.Color);
            material.SetTexture(k_BaseColorMapId, baseMap);
            material.SetFloat(k_SmoothnessId, spec.Smoothness);
            material.SetFloat(k_MetallicId, 0f);

            if (!string.IsNullOrEmpty(spec.NormalMapPath))
            {
                Texture2D normalMap = AssetDatabase.LoadAssetAtPath<Texture2D>(spec.NormalMapPath);

                if (normalMap == null)
                {
                    Debug.LogWarning($"EnvironmentPalette: '{spec.Key}' normal map missing at {spec.NormalMapPath}.");
                }
                else
                {
                    material.SetTexture(k_NormalMapId, normalMap);
                }
            }

            // One tiling for the whole base UV set: HDRP Lit reads _BaseColorMap_ST for the base colour,
            // the normal map and the mask map alike, and ignores a per-map _ST.
            material.SetTextureScale(k_BaseColorMapId, new Vector2(spec.Tiling, spec.Tiling));
            material.enableInstancing = true;

            // Keywords (_NORMALMAP, _MASKMAP, ...) and the pass set are derived from the assigned maps,
            // so validation has to run after the textures are in place, never before.
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureTve(Shader shader, TveSpec spec)
        {
            Material material = EnsureAsset(shader, spec.Key);
            Texture2D albedo = LoadTexture(spec.AlbedoPath);

            if (albedo == null)
            {
                Debug.LogWarning($"EnvironmentPalette: '{spec.Key}' albedo missing at {spec.AlbedoPath}.");
            }

            material.SetTexture(k_TveAlbedoId, albedo);
            material.SetTexture(k_TveNormalId, LoadTexture(spec.NormalPath));
            material.SetColor(k_TveColorId, spec.Color);
            material.SetFloat(k_TveSmoothnessId, spec.Smoothness);
            material.SetFloat(k_TveMetallicId, 0f);
            material.SetFloat(k_TveRenderClipId, spec.Cutout ? 1f : 0f);
            material.SetFloat(k_TveAlphaClipId, spec.Cards ? k_CardAlphaClip : 0.5f);
            material.SetFloat(k_TveFlattenId, spec.Cards ? k_CardFlatten : 0f);
            material.SetFloat(k_TveFlattenSphereId, spec.Cards ? 1f : 0f);
            material.SetFloat(k_TveRenderCullId, spec.TwoSided ? k_CullBoth : k_CullFront);
            material.SetFloat(k_TveRenderNormalId, spec.TwoSided ? k_NormalSame : k_NormalFlip);
            material.SetFloat(k_TveMotionId, spec.Motion);
            material.SetFloat(k_TveMotionBaseId, spec.MotionPrimary);
            material.SetFloat(k_TveMotionSmallId, spec.MotionSecond);
            material.SetFloat(k_TveMotionTinyId, spec.MotionLeaves);
            material.SetFloat(k_TveSubsurfaceId, spec.Subsurface ? 1f : 0f);

            // Tells TVE the maps were assigned on purpose, so SetMaterialSettings does not go looking for
            // Unity Lit slots (_BaseMap/_BumpMap) that this material never had.
            material.SetFloat(k_TveIsConvertedId, 1f);
            material.SetInt(k_TveObjectTypeId, spec.ObjectType);
            material.enableInstancing = true;

            // Keywords, render queue, the HDRP diffusion profile (the package's Foliage profile, which the
            // default volume already lists) and the internal object-type flags are all derived by TVE from
            // the values above; the label is what TVEPostProcessor keys off to re-validate after upgrades.
            TVEUtils.SetMaterialSettings(material);
            TVEUtils.SetLabel(MaterialPath(spec.Key));
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Texture2D LoadTexture(string path)
        {
            return string.IsNullOrEmpty(path) ? null : AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        }

        private static Material EnsureGlass(Shader lit)
        {
            Material material = EnsureAsset(lit, k_GlassKey);

            material.SetColor(k_BaseColorId, k_GlassColor);
            material.SetFloat(k_SmoothnessId, k_GlassSmoothness);
            material.SetFloat(k_MetallicId, 0f);

            // HDRP owns the transparent blend state: SetSurfaceType writes _SurfaceType and the render
            // queue, and ValidateMaterial derives the blend factors, the keywords and the pass set from
            // _BlendMode (0 = Alpha) and _TransparentZWrite. Nothing here is set by hand.
            HDMaterial.SetSurfaceType(material, true);
            material.SetFloat(k_BlendModeId, 0f);
            material.SetFloat(k_TransparentZWriteId, 0f);
            material.enableInstancing = true;
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureAsset(Shader lit, string key)
        {
            string path = MaterialPath(key);
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(lit);
                material.name = key;
                HDMaterial.ValidateMaterial(material);
                AssetDatabase.CreateAsset(material, path);
                return material;
            }

            // A palette asset authored against another pipeline keeps its GUID and is re-shadered here;
            // validation then rebuilds the keywords and passes the new shader expects.
            if (material.shader != lit)
            {
                material.shader = lit;
                HDMaterial.ValidateMaterial(material);
                EditorUtility.SetDirty(material);
            }

            return material;
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

        /// <summary>One The Visual Engine material: texture set plus the kind-derived shader and wind settings.</summary>
        private struct TveSpec
        {
            public readonly string Key;
            public readonly string AlbedoPath;
            public readonly string NormalPath;
            public readonly Color Color;
            public readonly float Smoothness;
            public readonly bool Cutout;
            public readonly bool TwoSided;

            /// <summary>General Subsurface Lit (foliage) instead of General Standard Lit (bark, props, scans).</summary>
            public readonly bool Subsurface;

            /// <summary>Alpha-card foliage (PSX trees/bushes, Niwl plants): looser clip and spherified shading.</summary>
            public bool Cards { get { return Motion > 0f; } }

            /// <summary>TVE object type (<see cref="k_ObjectProp"/>, <see cref="k_ObjectBark"/>, <see cref="k_ObjectLeaf"/>).</summary>
            public readonly int ObjectType;

            /// <summary>_MotionIntensityValue: 0 = static prop, 1 = takes the global wind.</summary>
            public readonly float Motion;
            public readonly float MotionPrimary;
            public readonly float MotionSecond;
            public readonly float MotionLeaves;

            private TveSpec(string key, string albedoPath, string normalPath, Color color, float smoothness,
                bool cutout, bool twoSided, bool subsurface, int objectType, float motion, float primary,
                float second, float leaves)
            {
                ObjectType = objectType;
                Key = key;
                AlbedoPath = albedoPath;
                NormalPath = normalPath;
                Color = color;
                Smoothness = smoothness;
                Cutout = cutout;
                TwoSided = twoSided;
                Subsurface = subsurface;
                Motion = motion;
                MotionPrimary = primary;
                MotionSecond = second;
                MotionLeaves = leaves;
            }

            /// <summary>Static prop: opaque or cutout Standard Lit, no wind, front faces only.</summary>
            public static TveSpec Prop(string key, string albedoPath, string normalPath, Color color,
                float smoothness, bool cutout)
            {
                return new TveSpec(key, albedoPath, normalPath, color, smoothness, cutout, cutout, false,
                    k_ObjectProp, 0f, 0f, 0f, 0f);
            }

            /// <summary>
            /// Poly Haven scan: <c>&lt;prefix&gt;_diff_1k&lt;ext&gt;</c> + <c>&lt;prefix&gt;_nor_gl_1k&lt;ext&gt;</c>, own colour,
            /// no wind. Defaults to the JPG albedo and the PNG normal map the EXR maps were converted to.
            /// </summary>
            public static TveSpec Scan(string key, string prefix, string albedoExt = ".jpg", string normalExt = ".png")
            {
                return Prop(key, prefix + "_diff_1k" + albedoExt, prefix + "_nor_gl_1k" + normalExt, Color.white,
                    k_ScanSmoothness, false);
            }

            /// <summary>PSX tree sheet: one cutout Standard Lit material for trunk and crown; trunk bending plus a little flutter.</summary>
            public static TveSpec Tree(string key, string albedoPath, Color tint)
            {
                return new TveSpec(key, albedoPath, null, tint, k_PsxSmoothness, true, true, false,
                    k_ObjectBark, 1f, 1f, 0.5f, 0.3f);
            }

            /// <summary>Bush / crown cards: cutout Subsurface Lit, both faces, all three wind layers.</summary>
            public static TveSpec Leaf(string key, string albedoPath, Color tint)
            {
                return new TveSpec(key, albedoPath, null, tint, k_PsxSmoothness, true, true, true,
                    k_ObjectLeaf, 1f, 1f, 1f, 1f);
            }

            /// <summary>Grass / fern / ivy cards: cutout Subsurface Lit, both faces, bending plus flutter.</summary>
            public static TveSpec Plant(string key, string albedoPath, Color tint)
            {
                return new TveSpec(key, albedoPath, null, tint, k_PsxSmoothness, true, true, true,
                    k_ObjectLeaf, 1f, 1f, 0.5f, 0.5f);
            }

            public TveSpec WithSmoothness(float smoothness)
            {
                return new TveSpec(Key, AlbedoPath, NormalPath, Color, smoothness, Cutout, TwoSided, Subsurface,
                    ObjectType, Motion, MotionPrimary, MotionSecond, MotionLeaves);
            }
        }

        /// <summary>One flat greybox colour of the palette.</summary>
        private struct FlatSpec
        {
            public readonly string Key;
            public readonly Color Color;

            public FlatSpec(string key, byte r, byte g, byte b)
            {
                Key = key;
                Color = new Color32(r, g, b, 0xFF);
            }
        }

        /// <summary>One textured palette material built from a vendor colour map and optional normal map.</summary>
        private struct TexturedSpec
        {
            public readonly string Key;
            public readonly string BaseMapPath;
            public readonly string NormalMapPath;
            public readonly float Tiling;

            /// <summary>Base colour the map is multiplied by; white keeps the scan's own colour.</summary>
            public readonly Color Color;
            public readonly float Smoothness;

            public TexturedSpec(string key, string baseMapPath, string normalMapPath, float tiling)
                : this(key, baseMapPath, normalMapPath, tiling, Color.white, k_FlatSmoothness)
            {
            }

            public TexturedSpec(string key, string baseMapPath, string normalMapPath, float tiling,
                Color color, float smoothness)
            {
                Key = key;
                BaseMapPath = baseMapPath;
                NormalMapPath = normalMapPath;
                Tiling = tiling;
                Color = color;
                Smoothness = smoothness;
            }
        }
    }
}
