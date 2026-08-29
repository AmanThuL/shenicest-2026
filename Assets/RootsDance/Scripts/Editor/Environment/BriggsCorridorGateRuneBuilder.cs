using System.Collections.Generic;
using System.IO;
using RootsDance.Environment;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Derives deterministic bronze, height, normal and radial glow textures from the authored corridor-gate
    /// rune PNGs, then installs the fixed outer ring and split inner inlay on the Briggs exit door prefab.
    /// </summary>
    public static class BriggsCorridorGateRuneBuilder
    {
        public const int InnerBandCount = 12;

        private const string k_SourceFolder = "SourceArt/corridor_gate_rune";
        private const string k_TextureFolder =
            "Assets/RootsDance/Textures/Environment/BriggsInterior/CorridorGate";
        private const string k_MaterialFolder =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/CorridorGate";
        private const string k_MeshFolder =
            "Assets/RootsDance/Meshes/Environment/BriggsInterior/CorridorGate";
        private const string k_InnerSourceName = "inner_rune.png";
        private const string k_OuterSourceName = "outer_rune.png";
        private const float k_InnerDiameter = 4.12f;
        private const float k_OuterDiameter = 6.42f;
        private const float k_BaseSurfaceZ = -0.148f;
        private const float k_GlowSurfaceZ = -0.158f;
        private const float k_OuterBaseZ = -0.172f;
        private const float k_OuterGlowZ = -0.182f;
        private const float k_DoorLeafWidth = 2.3f;
        private const float k_DoorLeafHeight = 4.6f;
        private const float k_DoorLeafDepth = 0.28f;

        private static readonly Color k_GlowColor = new Color(0.015f, 0.12f, 0.95f, 1f);

        /// <summary>Rebuilds the generated rune textures/materials and adds their visual hierarchy to a door.</summary>
        public static void AddRunes(
            GameObject root,
            Transform leftLeaf,
            Transform rightLeaf,
            AutomaticSlidingDoor door)
        {
            EnsureFolder(k_TextureFolder);
            EnsureFolder(k_MaterialFolder);
            EnsureFolder(k_MeshFolder);

            GeneratedTextures innerTextures = GenerateTextures(k_InnerSourceName, "InnerRune", InnerBandCount);
            GeneratedTextures outerTextures = GenerateTextures(k_OuterSourceName, "OuterRune", 0);
            Mesh leftMesh = EnsureHalfQuad("RuneQuad_Left", false);
            Mesh rightMesh = EnsureHalfQuad("RuneQuad_Right", true);
            Mesh fullMesh = EnsureFullQuad();
            Material innerBase = EnsureBaseMaterial("CorridorGateRune_Inner", innerTextures);
            Material outerBase = EnsureBaseMaterial("CorridorGateRune_Outer", outerTextures);
            Material outerGlow = EnsureGlowMaterial(
                "CorridorGateRune_OuterGlow",
                outerTextures.GlowPaths[0]);

            Transform leftInnerRoot = CreateInnerRuneRoot(leftLeaf, "RuneInlay_Inner_LeftRoot");
            Transform rightInnerRoot = CreateInnerRuneRoot(rightLeaf, "RuneInlay_Inner_RightRoot");

            CreateInnerVisual(
                leftInnerRoot,
                leftLeaf,
                "RuneInlay_Inner_Left",
                leftMesh,
                innerBase,
                -k_InnerDiameter * 0.25f,
                k_BaseSurfaceZ,
                false);
            CreateInnerVisual(
                rightInnerRoot,
                rightLeaf,
                "RuneInlay_Inner_Right",
                rightMesh,
                innerBase,
                k_InnerDiameter * 0.25f,
                k_BaseSurfaceZ,
                false);

            List<Renderer> innerGlowRenderers = new List<Renderer>(InnerBandCount * 2);

            for (int band = 0; band < InnerBandCount; band++)
            {
                Material glow = EnsureGlowMaterial(
                    $"CorridorGateRune_InnerGlow_{band:00}",
                    innerTextures.GlowPaths[band]);
                innerGlowRenderers.Add(CreateInnerVisual(
                    leftInnerRoot,
                    leftLeaf,
                    $"RuneGlow_Inner_{band:00}_Left",
                    leftMesh,
                    glow,
                    -k_InnerDiameter * 0.25f,
                    k_GlowSurfaceZ,
                    true));
                innerGlowRenderers.Add(CreateInnerVisual(
                    rightInnerRoot,
                    rightLeaf,
                    $"RuneGlow_Inner_{band:00}_Right",
                    rightMesh,
                    glow,
                    k_InnerDiameter * 0.25f,
                    k_GlowSurfaceZ,
                    true));
            }

            CreateFixedVisual(
                root.transform,
                "RuneInlay_Outer",
                fullMesh,
                outerBase,
                k_OuterDiameter,
                k_OuterBaseZ,
                false);
            Renderer outerGlowRenderer = CreateFixedVisual(
                root.transform,
                "RuneGlow_Outer",
                fullMesh,
                outerGlow,
                k_OuterDiameter,
                k_OuterGlowZ,
                true);
            Light runeLight = CreateRuneLight(root.transform);

            door.ConfigureRuneSequence(
                innerGlowRenderers.ToArray(),
                new[] { leftInnerRoot, rightInnerRoot },
                InnerBandCount,
                new[] { outerGlowRenderer },
                runeLight,
                0.9f,
                0.2f,
                0.24f,
                0.38f,
                0.12f);
        }

        private static GeneratedTextures GenerateTextures(string sourceName, string assetName, int bandCount)
        {
            string projectRoot = Directory.GetParent(Application.dataPath).FullName;
            string sourcePath = Path.Combine(projectRoot, k_SourceFolder, sourceName);

            if (!File.Exists(sourcePath))
            {
                throw new FileNotFoundException("Corridor gate rune source is missing: " + sourcePath);
            }

            Texture2D source = new Texture2D(2, 2, TextureFormat.RGBA32, false, false);

            try
            {
                if (!ImageConversion.LoadImage(source, File.ReadAllBytes(sourcePath), false))
                {
                    throw new InvalidDataException("Could not decode corridor gate rune: " + sourcePath);
                }

                int width = source.width;
                int height = source.height;
                Color32[] sourcePixels = source.GetPixels32();
                float[] heights = BuildHeightField(sourcePixels, width, height);
                string baseColorPath = $"{k_TextureFolder}/{assetName}_BaseColor.png";
                string heightPath = $"{k_TextureFolder}/{assetName}_Height.png";
                string normalPath = $"{k_TextureFolder}/{assetName}_Normal.png";
                WriteTexture(baseColorPath, width, height, BuildBronzePixels(sourcePixels, heights));
                WriteTexture(heightPath, width, height, BuildHeightPixels(heights));
                WriteTexture(normalPath, width, height, BuildNormalPixels(heights, width, height));
                ConfigureTexture(baseColorPath, TextureKind.Color);
                ConfigureTexture(heightPath, TextureKind.Linear);
                ConfigureTexture(normalPath, TextureKind.Normal);

                int glowCount = Mathf.Max(1, bandCount);
                string[] glowPaths = new string[glowCount];

                for (int band = 0; band < glowCount; band++)
                {
                    string suffix = bandCount > 0 ? $"_{band:00}" : string.Empty;
                    string glowPath = $"{k_TextureFolder}/{assetName}_Glow{suffix}.png";
                    Color32[] glowPixels = BuildGlowPixels(
                        sourcePixels,
                        width,
                        height,
                        band,
                        bandCount);
                    WriteTexture(glowPath, width, height, glowPixels);
                    ConfigureTexture(glowPath, TextureKind.Color);
                    glowPaths[band] = glowPath;
                }

                return new GeneratedTextures(baseColorPath, heightPath, normalPath, glowPaths);
            }
            finally
            {
                Object.DestroyImmediate(source);
            }
        }

        private static float[] BuildHeightField(Color32[] sourcePixels, int width, int height)
        {
            const float k_Infinity = 1000000f;
            const float k_Diagonal = 1.41421356f;
            const float k_BevelWidth = 13f;
            float[] distances = new float[sourcePixels.Length];

            for (int i = 0; i < sourcePixels.Length; i++)
            {
                distances[i] = sourcePixels[i].a > 8 ? k_Infinity : 0f;
            }

            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    int index = y * width + x;

                    if (distances[index] <= 0f)
                    {
                        continue;
                    }

                    float distance = distances[index];

                    if (x > 0)
                    {
                        distance = Mathf.Min(distance, distances[index - 1] + 1f);
                    }

                    if (y > 0)
                    {
                        distance = Mathf.Min(distance, distances[index - width] + 1f);

                        if (x > 0)
                        {
                            distance = Mathf.Min(distance, distances[index - width - 1] + k_Diagonal);
                        }

                        if (x + 1 < width)
                        {
                            distance = Mathf.Min(distance, distances[index - width + 1] + k_Diagonal);
                        }
                    }

                    distances[index] = distance;
                }
            }

            for (int y = height - 1; y >= 0; y--)
            {
                for (int x = width - 1; x >= 0; x--)
                {
                    int index = y * width + x;

                    if (distances[index] <= 0f)
                    {
                        continue;
                    }

                    float distance = distances[index];

                    if (x + 1 < width)
                    {
                        distance = Mathf.Min(distance, distances[index + 1] + 1f);
                    }

                    if (y + 1 < height)
                    {
                        distance = Mathf.Min(distance, distances[index + width] + 1f);

                        if (x + 1 < width)
                        {
                            distance = Mathf.Min(distance, distances[index + width + 1] + k_Diagonal);
                        }

                        if (x > 0)
                        {
                            distance = Mathf.Min(distance, distances[index + width - 1] + k_Diagonal);
                        }
                    }

                    distances[index] = distance;
                }
            }

            for (int i = 0; i < distances.Length; i++)
            {
                float alpha = sourcePixels[i].a / 255f;
                float distance = Mathf.Clamp01(distances[i] / k_BevelWidth);
                distances[i] = Mathf.SmoothStep(0f, 1f, distance) * alpha;
            }

            return distances;
        }

        private static Color32[] BuildBronzePixels(Color32[] sourcePixels, float[] heights)
        {
            Color32[] pixels = new Color32[sourcePixels.Length];

            for (int i = 0; i < sourcePixels.Length; i++)
            {
                Color32 source = sourcePixels[i];
                float detail = Mathf.Clamp01((source.r + source.g + source.b) / 80f);
                float height = heights[i];
                byte red = (byte)Mathf.RoundToInt(Mathf.Lerp(54f, 152f, detail) + 34f * height);
                byte green = (byte)Mathf.RoundToInt(Mathf.Lerp(20f, 72f, detail) + 16f * height);
                byte blue = (byte)Mathf.RoundToInt(Mathf.Lerp(7f, 28f, detail) + 5f * height);
                pixels[i] = new Color32(red, green, blue, source.a);
            }

            return pixels;
        }

        private static Color32[] BuildHeightPixels(float[] heights)
        {
            Color32[] pixels = new Color32[heights.Length];

            for (int i = 0; i < heights.Length; i++)
            {
                byte value = (byte)Mathf.RoundToInt(heights[i] * 255f);
                pixels[i] = new Color32(value, value, value, 255);
            }

            return pixels;
        }

        private static Color32[] BuildNormalPixels(float[] heights, int width, int height)
        {
            const float k_NormalStrength = 7f;
            Color32[] pixels = new Color32[heights.Length];

            for (int y = 0; y < height; y++)
            {
                int downY = Mathf.Max(0, y - 1);
                int upY = Mathf.Min(height - 1, y + 1);

                for (int x = 0; x < width; x++)
                {
                    int leftX = Mathf.Max(0, x - 1);
                    int rightX = Mathf.Min(width - 1, x + 1);
                    float dx = (heights[y * width + rightX] - heights[y * width + leftX]) * k_NormalStrength;
                    float dy = (heights[upY * width + x] - heights[downY * width + x]) * k_NormalStrength;
                    Vector3 normal = new Vector3(-dx, -dy, 1f).normalized;
                    pixels[y * width + x] = new Color32(
                        (byte)Mathf.RoundToInt((normal.x * 0.5f + 0.5f) * 255f),
                        (byte)Mathf.RoundToInt((normal.y * 0.5f + 0.5f) * 255f),
                        (byte)Mathf.RoundToInt((normal.z * 0.5f + 0.5f) * 255f),
                        255);
                }
            }

            return pixels;
        }

        private static Color32[] BuildGlowPixels(
            Color32[] sourcePixels,
            int width,
            int height,
            int band,
            int bandCount)
        {
            Color32[] pixels = new Color32[sourcePixels.Length];
            float centerX = (width - 1) * 0.5f;
            float centerY = (height - 1) * 0.5f;
            float radiusScale = Mathf.Min(width, height) * 0.5f * 1.04f;

            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    int index = y * width + x;
                    byte alpha = sourcePixels[index].a;

                    if (bandCount > 0)
                    {
                        float dx = x - centerX;
                        float dy = y - centerY;
                        float radius = Mathf.Sqrt(dx * dx + dy * dy) / radiusScale;
                        int pixelBand = Mathf.Min(bandCount - 1, Mathf.FloorToInt(radius * bandCount));

                        if (pixelBand != band)
                        {
                            alpha = 0;
                        }
                    }

                    pixels[index] = new Color32(180, 224, 255, alpha);
                }
            }

            return pixels;
        }

        private static void WriteTexture(string assetPath, int width, int height, Color32[] pixels)
        {
            Texture2D texture = new Texture2D(width, height, TextureFormat.RGBA32, false, false);

            try
            {
                texture.SetPixels32(pixels);
                texture.Apply(false, false);
                File.WriteAllBytes(assetPath, texture.EncodeToPNG());
                AssetDatabase.ImportAsset(assetPath, ImportAssetOptions.ForceUpdate);
            }
            finally
            {
                Object.DestroyImmediate(texture);
            }
        }

        private static void ConfigureTexture(string path, TextureKind kind)
        {
            TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;

            if (importer == null)
            {
                throw new FileNotFoundException("Generated corridor gate texture was not imported: " + path);
            }

            importer.textureType = kind == TextureKind.Normal
                ? TextureImporterType.NormalMap
                : TextureImporterType.Default;
            importer.sRGBTexture = kind == TextureKind.Color;
            importer.alphaSource = TextureImporterAlphaSource.FromInput;
            importer.alphaIsTransparency = kind == TextureKind.Color;
            importer.mipmapEnabled = true;
            importer.wrapMode = TextureWrapMode.Clamp;
            importer.filterMode = FilterMode.Bilinear;
            importer.maxTextureSize = 2048;
            importer.textureCompression = TextureImporterCompression.Compressed;
            importer.SaveAndReimport();
        }

        private static Material EnsureBaseMaterial(string name, GeneratedTextures textures)
        {
            Material material = EnsureMaterial(name, "HDRP/Lit");
            material.SetTexture("_BaseColorMap", LoadTexture(textures.BaseColorPath));
            material.SetTexture("_NormalMap", LoadTexture(textures.NormalPath));
            material.SetTexture("_HeightMap", LoadTexture(textures.HeightPath));
            material.SetColor("_BaseColor", Color.white);
            material.SetFloat("_Metallic", 0.68f);
            material.SetFloat("_Smoothness", 0.43f);
            material.SetFloat("_NormalScale", 1.15f);
            material.SetFloat("_DoubleSidedEnable", 1f);
            material.SetFloat("_DoubleSidedNormalMode", 1f);
            material.SetFloat("_DisplacementMode", 2f);
            material.SetFloat("_HeightPoMAmplitude", 0.035f);
            material.SetFloat("_DepthOffsetEnable", 1f);
            material.SetFloat("_DisplacementLockObjectScale", 1f);
            HDMaterial.SetSurfaceType(material, false);
            HDMaterial.SetAlphaClipping(material, true);
            HDMaterial.SetAlphaCutoff(material, 0.18f);
            HDMaterial.SetUseEmissiveIntensity(material, false);
            HDMaterial.SetEmissiveColor(material, new Color(0.018f, 0.0045f, 0.001f, 1f));
            material.enableInstancing = true;
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureGlowMaterial(string name, string glowTexturePath)
        {
            Material material = EnsureMaterial(name, "HDRP/Unlit");
            Texture2D glowTexture = LoadTexture(glowTexturePath);
            material.SetTexture("_UnlitColorMap", glowTexture);
            material.SetTexture("_EmissiveColorMap", glowTexture);
            material.SetColor("_UnlitColor", new Color(0.002f, 0.004f, 0.008f, 1f));
            material.SetFloat("_DoubleSidedEnable", 1f);
            material.SetFloat("_DoubleSidedNormalMode", 1f);
            HDMaterial.SetSurfaceType(material, false);
            HDMaterial.SetAlphaClipping(material, true);
            HDMaterial.SetAlphaCutoff(material, 0.16f);
            HDMaterial.SetUseEmissiveIntensity(material, false);
            HDMaterial.SetEmissiveColor(material, k_GlowColor.linear * 1400f);
            material.enableInstancing = true;
            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material EnsureMaterial(string name, string shaderName)
        {
            string path = $"{k_MaterialFolder}/{name}.mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material != null)
            {
                return material;
            }

            Shader shader = Shader.Find(shaderName);

            if (shader == null)
            {
                throw new System.InvalidOperationException(
                    "Required corridor gate shader was not found: " + shaderName);
            }

            material = new Material(shader);
            material.name = name;
            AssetDatabase.CreateAsset(material, path);
            return material;
        }

        private static Texture2D LoadTexture(string path)
        {
            Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(path);

            if (texture == null)
            {
                throw new FileNotFoundException("Generated corridor gate texture is missing: " + path);
            }

            return texture;
        }

        private static Mesh EnsureHalfQuad(string name, bool isRight)
        {
            float uvMin = isRight ? 0.5f : 0f;
            float uvMax = isRight ? 1f : 0.5f;
            return EnsureQuad(name, uvMin, uvMax);
        }

        private static Mesh EnsureFullQuad()
        {
            return EnsureQuad("RuneQuad_Full", 0f, 1f);
        }

        private static Mesh EnsureQuad(string name, float uvMin, float uvMax)
        {
            string path = $"{k_MeshFolder}/{name}.asset";
            Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(path);
            bool isNew = mesh == null;

            if (isNew)
            {
                mesh = new Mesh();
            }

            mesh.name = name;
            mesh.Clear();
            mesh.vertices = new[]
            {
                new Vector3(-0.5f, -0.5f, 0f),
                new Vector3(-0.5f, 0.5f, 0f),
                new Vector3(0.5f, 0.5f, 0f),
                new Vector3(0.5f, -0.5f, 0f),
            };
            mesh.uv = new[]
            {
                new Vector2(uvMin, 0f),
                new Vector2(uvMin, 1f),
                new Vector2(uvMax, 1f),
                new Vector2(uvMax, 0f),
            };
            mesh.normals = new[] { Vector3.back, Vector3.back, Vector3.back, Vector3.back };
            mesh.tangents = new[]
            {
                new Vector4(1f, 0f, 0f, -1f),
                new Vector4(1f, 0f, 0f, -1f),
                new Vector4(1f, 0f, 0f, -1f),
                new Vector4(1f, 0f, 0f, -1f),
            };
            mesh.triangles = new[] { 0, 1, 2, 0, 2, 3 };
            mesh.RecalculateBounds();

            if (isNew)
            {
                AssetDatabase.CreateAsset(mesh, path);
            }
            else
            {
                EditorUtility.SetDirty(mesh);
            }

            return mesh;
        }

        private static Transform CreateInnerRuneRoot(Transform leaf, string name)
        {
            Transform root = new GameObject(name).transform;
            root.SetParent(leaf, false);
            return root;
        }

        private static Renderer CreateInnerVisual(
            Transform parent,
            Transform leaf,
            string name,
            Mesh mesh,
            Material material,
            float rootSpaceCenterX,
            float rootSpaceZ,
            bool isGlow)
        {
            GameObject visual = new GameObject(name);
            visual.transform.SetParent(parent, false);
            float rootSpaceOffsetX = rootSpaceCenterX - leaf.localPosition.x;
            visual.transform.localPosition = new Vector3(
                rootSpaceOffsetX / k_DoorLeafWidth,
                0f,
                rootSpaceZ / k_DoorLeafDepth);
            visual.transform.localScale = new Vector3(
                (k_InnerDiameter * 0.5f) / k_DoorLeafWidth,
                k_InnerDiameter / k_DoorLeafHeight,
                1f);
            return AddRenderer(visual, mesh, material, isGlow);
        }

        private static Renderer CreateFixedVisual(
            Transform parent,
            string name,
            Mesh mesh,
            Material material,
            float diameter,
            float z,
            bool isGlow)
        {
            GameObject visual = new GameObject(name);
            visual.transform.SetParent(parent, false);
            visual.transform.localPosition = new Vector3(0f, 2.25f, z);
            visual.transform.localScale = new Vector3(diameter, diameter, 1f);
            return AddRenderer(visual, mesh, material, isGlow);
        }

        private static Renderer AddRenderer(GameObject visual, Mesh mesh, Material material, bool isGlow)
        {
            MeshFilter filter = visual.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;
            MeshRenderer renderer = visual.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = isGlow ? ShadowCastingMode.Off : ShadowCastingMode.On;
            renderer.receiveShadows = !isGlow;
            renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
            renderer.enabled = !isGlow;
            return renderer;
        }

        private static Light CreateRuneLight(Transform parent)
        {
            GameObject lightObject = new GameObject("RuneActivationLight");
            lightObject.transform.SetParent(parent, false);
            lightObject.transform.localPosition = new Vector3(0f, 2.25f, -0.8f);
            Light light = lightObject.AddComponent<Light>();
            light.type = LightType.Point;
            light.lightUnit = LightUnit.Lumen;
            light.color = k_GlowColor;
            light.range = 4f;
            light.intensity = 0f;
            light.shadows = LightShadows.None;
            light.enabled = false;
            HDAdditionalLightData data = lightObject.GetComponent<HDAdditionalLightData>();

            if (data == null)
            {
                data = lightObject.AddComponent<HDAdditionalLightData>();
            }

            data.EnableShadows(false);
            data.affectsVolumetric = true;
            data.volumetricDimmer = 0.35f;
            return light;
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path)?.Replace('\\', '/');

            if (!string.IsNullOrEmpty(parent) && !AssetDatabase.IsValidFolder(parent))
            {
                EnsureFolder(parent);
            }

            AssetDatabase.CreateFolder(parent, Path.GetFileName(path));
        }

        private sealed class GeneratedTextures
        {
            public readonly string BaseColorPath;
            public readonly string HeightPath;
            public readonly string NormalPath;
            public readonly string[] GlowPaths;

            public GeneratedTextures(
                string baseColorPath,
                string heightPath,
                string normalPath,
                string[] glowPaths)
            {
                BaseColorPath = baseColorPath;
                HeightPath = heightPath;
                NormalPath = normalPath;
                GlowPaths = glowPaths;
            }
        }

        private enum TextureKind
        {
            Color,
            Linear,
            Normal,
        }
    }
}
