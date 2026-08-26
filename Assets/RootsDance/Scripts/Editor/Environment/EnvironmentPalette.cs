using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Creates and maintains the small desaturated URP Lit palette that every outdoor-dressing prefab is
    /// painted with. Vendor sub-materials are never used directly: <see cref="EnvironmentPrefabBuilder"/>
    /// maps each vendor material name onto one of the keys below so the whole chapter shares one look.
    /// Idempotent — existing <c>.mat</c> assets are updated in place, never duplicated.
    /// </summary>
    public static class EnvironmentPalette
    {
        /// <summary>Folder that holds every palette material.</summary>
        public const string k_MaterialFolder = "Assets/RootsDance/Materials/Environment";

        private const string k_UrpLitShader = "Universal Render Pipeline/Lit";
        private const string k_ThirdPartyRoot = "Assets/ThirdParty/Environment";
        private const string k_PolyHavenRoot = k_ThirdPartyRoot + "/PolyHaven/Models";

        private const float k_FlatSmoothness = 0.05f;
        private const float k_GlassSmoothness = 0.8f;
        private const float k_ConcreteLabTiling = 0.25f;

        // The lab blockout FBX has no usable UVs, so Concrete_Lab's texture tiles into noise on it. A pale
        // warm base colour is what actually carries the "light concrete" read; the map only adds grain.
        private const float k_ConcreteLabSmoothness = 0.15f;

        // URP Lit surface-type plumbing: transparent needs the blend state written by hand from script.
        private const float k_SurfaceTransparent = 1f;
        private const float k_BlendAlpha = 0f;
        private const float k_SrcBlendSrcAlpha = 5f;
        private const float k_DstBlendOneMinusSrcAlpha = 10f;
        private const int k_TransparentQueue = 3000;

        private static readonly int k_BaseColorId = Shader.PropertyToID("_BaseColor");
        private static readonly int k_BaseMapId = Shader.PropertyToID("_BaseMap");
        private static readonly int k_BumpMapId = Shader.PropertyToID("_BumpMap");
        private static readonly int k_SmoothnessId = Shader.PropertyToID("_Smoothness");
        private static readonly int k_MetallicId = Shader.PropertyToID("_Metallic");
        private static readonly int k_SurfaceId = Shader.PropertyToID("_Surface");
        private static readonly int k_BlendId = Shader.PropertyToID("_Blend");
        private static readonly int k_SrcBlendId = Shader.PropertyToID("_SrcBlend");
        private static readonly int k_DstBlendId = Shader.PropertyToID("_DstBlend");
        private static readonly int k_ZWriteId = Shader.PropertyToID("_ZWrite");

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
        /// The textured half of the palette: the Poly Haven scans, the PSX barrier and the lab concrete.
        /// A spec may leave its base map empty, which makes it a flat colour with a normal map.
        /// </summary>
        private static readonly TexturedSpec[] k_TexturedSpecs =
        {
            new TexturedSpec(
                "Scan_DeadTreeTrunk",
                k_PolyHavenRoot + "/DeadTreeTrunk/dead_tree_trunk_diff_1k.jpg",
                k_PolyHavenRoot + "/DeadTreeTrunk/dead_tree_trunk_nor_gl_1k.jpg",
                1f),
            new TexturedSpec(
                "Scan_DryBranchesMedium01",
                k_PolyHavenRoot + "/DryBranchesMedium01/dry_branches_medium_01_diff_1k.jpg",
                k_PolyHavenRoot + "/DryBranchesMedium01/dry_branches_medium_01_nor_gl_1k.jpg",
                1f),
            new TexturedSpec(
                "Scan_PineRoots_A",
                k_PolyHavenRoot + "/PineRoots/pine_roots_a_diff_1k.jpg",
                k_PolyHavenRoot + "/PineRoots/pine_roots_a_nor_dx_1k.jpg",
                1f),
            new TexturedSpec(
                "Scan_PineRoots_B",
                k_PolyHavenRoot + "/PineRoots/pine_roots_b_diff_1k.jpg",
                k_PolyHavenRoot + "/PineRoots/pine_roots_b_nor_dx_1k.jpg",
                1f),
            new TexturedSpec(
                "Scan_RockMossSet02",
                k_PolyHavenRoot + "/RockMossSet02/rock_moss_set_02_diff_1k.jpg",
                k_PolyHavenRoot + "/RockMossSet02/rock_moss_set_02_nor_gl_1k.jpg",
                1f),
            new TexturedSpec(
                "Scan_TreeStump02",
                k_PolyHavenRoot + "/TreeStump02/tree_stump_02_diff_1k.jpg",
                k_PolyHavenRoot + "/TreeStump02/tree_stump_02_nor_dx_1k.jpg",
                1f),
            new TexturedSpec(
                "Psx_RoadBarrier",
                k_ThirdPartyRoot + "/Retroarchy/PsxRoadBarriers/roadbarrierLowRez.png",
                null,
                1f),
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
            Dictionary<string, Material> palette = new Dictionary<string, Material>(32);
            Shader lit = Shader.Find(k_UrpLitShader);

            if (lit == null)
            {
                Debug.LogError($"EnvironmentPalette: shader '{k_UrpLitShader}' not found; palette not built.");
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
            material.SetTexture(k_BaseMapId, baseMap);
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
                    material.SetTexture(k_BumpMapId, normalMap);
                    material.EnableKeyword("_NORMALMAP");
                }
            }

            Vector2 tiling = new Vector2(spec.Tiling, spec.Tiling);
            material.SetTextureScale(k_BaseMapId, tiling);
            material.SetTextureScale(k_BumpMapId, tiling);
            material.enableInstancing = true;
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureGlass(Shader lit)
        {
            Material material = EnsureAsset(lit, k_GlassKey);

            material.SetColor(k_BaseColorId, k_GlassColor);
            material.SetFloat(k_SmoothnessId, k_GlassSmoothness);
            material.SetFloat(k_MetallicId, 0f);
            material.SetFloat(k_SurfaceId, k_SurfaceTransparent);
            material.SetFloat(k_BlendId, k_BlendAlpha);
            material.SetFloat(k_SrcBlendId, k_SrcBlendSrcAlpha);
            material.SetFloat(k_DstBlendId, k_DstBlendOneMinusSrcAlpha);
            material.SetFloat(k_ZWriteId, 0f);
            material.EnableKeyword("_SURFACE_TYPE_TRANSPARENT");
            material.DisableKeyword("_ALPHATEST_ON");
            material.renderQueue = k_TransparentQueue;
            material.enableInstancing = true;
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
                AssetDatabase.CreateAsset(material, path);
                return material;
            }

            if (material.shader != lit)
            {
                material.shader = lit;
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
