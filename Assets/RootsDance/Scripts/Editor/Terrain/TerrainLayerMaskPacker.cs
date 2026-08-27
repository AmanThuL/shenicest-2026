using System.IO;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Packs the AmbientCG AO / Roughness / Displacement JPGs (kept un-imported under <c>Source~/</c>) into the
    /// HDRP TerrainLit mask layout — R metallic (0), G occlusion, B height, A smoothness (1 − roughness) — at
    /// <c>Assets/RootsDance/Textures/Environment/Terrain&lt;Name&gt;_Mask.png</c>.
    /// Menu: RootsDance &gt; Terrain &gt; Pack Terrain Layer Masks.
    /// </summary>
    /// <remarks>
    /// The output name follows the texture-pipeline convention <c>&lt;PascalCaseSet&gt;_&lt;MapKind&gt;.png</c>,
    /// so <c>TexturePipelinePostprocessor</c> imports it linear, compressed and mipmapped without any
    /// importer code here.
    /// </remarks>
    public static class TerrainLayerMaskPacker
    {
        private const string k_SourceRoot = "Assets/ThirdParty/Environment/AmbientCG";
        private const string k_OutputFolder = "Assets/RootsDance/Textures/Environment";
        private const int k_OutputSize = 1024;

        /// <summary>Layer name → AmbientCG asset id, in <c>TerrainSplatGenerator</c> layer order.</summary>
        public static readonly string[,] k_LayerSources =
        {
            { "AshDry", "Ground103" }, { "HumusDead", "Ground106" }, { "GrassBand", "Grass003" },
            { "StableSoil", "Ground037" }, { "ResearchGround", "Concrete044D" }, { "Trail", "Gravel043" },
        };

        /// <summary>Asset path of the packed mask of one layer.</summary>
        /// <param name="layerName">Layer stem, e.g. <c>AshDry</c>.</param>
        /// <returns>The project-relative PNG path the packer writes and the builder wires.</returns>
        public static string MaskPath(string layerName)
        {
            return $"{k_OutputFolder}/Terrain{layerName}_Mask.png";
        }

        /// <summary>Asset path of an AmbientCG set's imported colour (albedo) map.</summary>
        /// <param name="ambientCgId">AmbientCG asset id, e.g. <c>Ground103</c>.</param>
        /// <returns>The project-relative JPG path the builder wires as the layer's albedo.</returns>
        public static string ColorPath(string ambientCgId)
        {
            return $"{k_SourceRoot}/{ambientCgId}/{ambientCgId}_1K-JPG_Color.jpg";
        }

        /// <summary>Asset path of an AmbientCG set's imported tangent-space (OpenGL) normal map.</summary>
        /// <param name="ambientCgId">AmbientCG asset id, e.g. <c>Ground103</c>.</param>
        /// <returns>The project-relative JPG path the builder wires as the layer's normal map.</returns>
        public static string NormalPath(string ambientCgId)
        {
            return $"{k_SourceRoot}/{ambientCgId}/{ambientCgId}_1K-JPG_NormalGL.jpg";
        }

        /// <summary>Packs a mask for every layer in <see cref="k_LayerSources"/>.</summary>
        [MenuItem("RootsDance/Terrain/Pack Terrain Layer Masks")]
        public static void PackAll()
        {
            for (int i = 0; i < k_LayerSources.GetLength(0); i++)
            {
                Pack(k_LayerSources[i, 0], k_LayerSources[i, 1]);
            }

            AssetDatabase.Refresh();
        }

        /// <summary>Packs one layer's AO/Roughness/Displacement JPGs into its mask PNG.</summary>
        /// <param name="layerName">Layer stem, e.g. <c>AshDry</c>.</param>
        /// <param name="ambientCgId">AmbientCG asset id supplying the source maps, e.g. <c>Ground103</c>.</param>
        public static void Pack(string layerName, string ambientCgId)
        {
            string folder = $"{k_SourceRoot}/{ambientCgId}/Source~";
            Texture2D ao = LoadJpg($"{folder}/{ambientCgId}_1K-JPG_AmbientOcclusion.jpg");
            Texture2D rough = LoadJpg($"{folder}/{ambientCgId}_1K-JPG_Roughness.jpg");
            Texture2D disp = LoadJpg($"{folder}/{ambientCgId}_1K-JPG_Displacement.jpg");

            try
            {
                if (ao == null || rough == null || disp == null)
                {
                    Debug.LogError($"TerrainLayerMaskPacker: missing source channel for {ambientCgId} in {folder}.");
                    return;
                }

                Texture2D mask = new Texture2D(k_OutputSize, k_OutputSize, TextureFormat.RGBA32, false, true);
                Color[] pixels = new Color[k_OutputSize * k_OutputSize];

                for (int y = 0; y < k_OutputSize; y++)
                {
                    float v = (y + 0.5f) / k_OutputSize;

                    for (int x = 0; x < k_OutputSize; x++)
                    {
                        float u = (x + 0.5f) / k_OutputSize;
                        float occlusion = ao.GetPixelBilinear(u, v).r;
                        float smoothness = 1f - rough.GetPixelBilinear(u, v).r;
                        float height = disp.GetPixelBilinear(u, v).r;
                        pixels[y * k_OutputSize + x] = new Color(0f, occlusion, height, smoothness);
                    }
                }

                mask.SetPixels(pixels);
                mask.Apply();
                Directory.CreateDirectory(k_OutputFolder);
                string outputPath = MaskPath(layerName);
                File.WriteAllBytes(outputPath, mask.EncodeToPNG());
                Object.DestroyImmediate(mask);
                AssetDatabase.ImportAsset(outputPath, ImportAssetOptions.ForceSynchronousImport);
                Debug.Log($"TerrainLayerMaskPacker: wrote {outputPath}.");
            }
            finally
            {
                if (ao != null)
                {
                    Object.DestroyImmediate(ao);
                }

                if (rough != null)
                {
                    Object.DestroyImmediate(rough);
                }

                if (disp != null)
                {
                    Object.DestroyImmediate(disp);
                }
            }
        }

        /// <summary>Decodes a JPG that lives outside the AssetDatabase into a readable texture.</summary>
        private static Texture2D LoadJpg(string path)
        {
            if (!File.Exists(path))
            {
                return null;
            }

            Texture2D texture = new Texture2D(2, 2, TextureFormat.RGB24, false, true);
            return ImageConversion.LoadImage(texture, File.ReadAllBytes(path)) ? texture : null;
        }
    }
}
