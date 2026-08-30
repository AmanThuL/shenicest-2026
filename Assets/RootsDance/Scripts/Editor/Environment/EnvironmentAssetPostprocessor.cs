using System.IO;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Import rules for the vendor outdoor-dressing assets (guidelines 05 §7.1 and 07 §10), applied
    /// automatically so a fresh clone imports the vendor files the same way on every machine.
    /// Scope: <c>Assets/ThirdParty/Environment/</c> only — everything under
    /// <c>Assets/RootsDance/Textures/</c> belongs to <c>TexturePipelinePostprocessor</c>, and two
    /// postprocessors fighting over one importer would make the result depend on their order.
    /// </summary>
    public class EnvironmentAssetPostprocessor : AssetPostprocessor
    {
        private const string k_ThirdPartyRoot = "Assets/ThirdParty/Environment/";
        private const int k_MaxTextureSize = 1024;

        // Packs whose textures are authored at PSX resolution (<= 256 px): keep every pixel.
        private static readonly string[] k_PixelArtFolders =
        {
            k_ThirdPartyRoot + "RetroPSXNature/"
        };

        // Niwl mixes card exports with incomplete/mismatched normal streams. Recalculate across grass, flowers
        // and trees for deterministic import; the selected materials carry no normal maps, so tangents are skipped.
        private const string k_RecalculateNormalsFolder = k_ThirdPartyRoot + "NiwlPlants/";

        private bool IsInScope()
        {
            return assetPath.StartsWith(k_ThirdPartyRoot);
        }

        private void OnPreprocessTexture()
        {
            if (!IsInScope())
            {
                return;
            }

            TextureImporter importer = (TextureImporter)assetImporter;
            string name = Path.GetFileNameWithoutExtension(assetPath).ToLowerInvariant();
            bool isNormal = name.Contains("normal") || name.Contains("_nor_");
            bool isMask = name.EndsWith("_mask") || name.Contains("_arm_") || name.Contains("_rough")
                || name.Contains("_ao_") || name.Contains("ambientocclusion") || name.Contains("displacement")
                || name.Contains("_disp_") || name.Contains("opacity") || name.Contains("_alpha_")
                || name.Contains("_metal_");
            bool isHdr = assetPath.EndsWith(".hdr") || assetPath.EndsWith(".exr");

            importer.maxTextureSize = k_MaxTextureSize;
            importer.isReadable = false;
            importer.mipmapEnabled = true;
            importer.streamingMipmaps = true;
            importer.wrapMode = TextureWrapMode.Repeat;
            importer.textureCompression = TextureImporterCompression.Compressed;

            if (isHdr)
            {
                importer.textureShape = TextureImporterShape.TextureCube;
                importer.generateCubemap = TextureImporterGenerateCubemap.AutoCubemap;
                importer.sRGBTexture = false;
                importer.wrapMode = TextureWrapMode.Clamp;
                return;
            }

            if (isNormal)
            {
                importer.textureType = TextureImporterType.NormalMap;
                // Poly Haven ships some scans with DirectX-convention normals (green channel inverted).
                // Unity samples OpenGL-convention normal maps in HDRP too, so those maps have to be
                // flipped on import.
                importer.flipGreenChannel = name.Contains("_nor_dx");
                importer.sRGBTexture = false;
                return;
            }

            importer.textureType = TextureImporterType.Default;
            importer.sRGBTexture = !isMask;
            // Card textures carry their cutout in alpha; dilating the colour under it stops dark fringes.
            importer.alphaIsTransparency = !isMask;

            // Vendor PSX textures (<= 256 px) keep their pixels: point filtering, no compression artefacts.
            if (name.Contains("lowrez") || name.Contains("psx") || IsPixelArtFolder())
            {
                importer.filterMode = FilterMode.Point;
                importer.textureCompression = TextureImporterCompression.Uncompressed;
                importer.mipmapEnabled = false;
                importer.streamingMipmaps = false;
            }
        }

        private bool IsPixelArtFolder()
        {
            foreach (string folder in k_PixelArtFolders)
            {
                if (assetPath.StartsWith(folder))
                {
                    return true;
                }
            }

            return false;
        }

        private void OnPreprocessModel()
        {
            if (!assetPath.StartsWith(k_ThirdPartyRoot))
            {
                return;
            }

            ModelImporter importer = (ModelImporter)assetImporter;
            importer.importAnimation = false;
            importer.animationType = ModelImporterAnimationType.None;
            importer.importCameras = false;
            importer.importLights = false;
            importer.isReadable = false;
            importer.meshCompression = ModelImporterMeshCompression.Off;
            importer.optimizeMeshPolygons = true;
            importer.optimizeMeshVertices = true;
            importer.importBlendShapes = false;
            importer.generateSecondaryUV = false;
            importer.addCollider = false;

            if (assetPath.StartsWith(k_RecalculateNormalsFolder))
            {
                importer.importNormals = ModelImporterNormals.Calculate;
                importer.importTangents = ModelImporterTangents.None;
            }

            // Keep vendor materials as sub-assets: EnvironmentPrefabBuilder remaps them by name.
            importer.materialImportMode = ModelImporterMaterialImportMode.ImportStandard;
            importer.materialLocation = ModelImporterMaterialLocation.InPrefab;
        }
    }
}
