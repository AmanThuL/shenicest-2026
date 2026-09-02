using System;
using System.Collections.Generic;
using RootsDance.Editor.Audio;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Build
{
    /// <summary>Which build-size rule an asset breaks. Names are serialised into asset-audit.json.</summary>
    public enum AssetRule
    {
        TextureNpot4,
        TextureStandaloneMax,
        TextureReadable,
        TextureUncompressed,
        ModelReadable,
        ModelExtras,
        AudioProfile,
        PrefabScatterBatching
    }

    /// <summary>One rule broken by one asset. Serialisable for the JSON report.</summary>
    [Serializable]
    public struct AssetViolation
    {
        public string assetPath;
        public string rule;
        public string message;
        public bool fixable;

        public AssetViolation(string assetPath, AssetRule rule, string message, bool fixable)
        {
            this.assetPath = assetPath;
            this.rule = rule.ToString();
            this.message = message;
            this.fixable = fixable;
        }
    }

    /// <summary>The importer facts the texture rules look at. Filled by the audit or by tests.</summary>
    public struct TextureSnapshot
    {
        public string Path;
        public int SourceWidth;
        public int SourceHeight;
        public bool IsCubemap;
        public TextureImporterCompression Compression;
        public TextureImporterNPOTScale NpotScale;
        public bool IsReadable;
        public bool StandaloneOverridden;
        public int StandaloneMaxSize;
        public TextureImporterFormat StandaloneFormat;
    }

    public struct ModelSnapshot
    {
        public string Path;
        /// <summary>Registered in Tools/unity/model_import_profiles.json: BlenderModelPostprocessor owns it.</summary>
        public bool PipelineOwned;
        public bool IsReadable;
        public bool ImportBlendShapes;
        public bool ImportCameras;
        public bool ImportLights;
    }

    public struct AudioSnapshot
    {
        public string Path;
        public bool ForceToMono;
        public AudioClipLoadType LoadType;
        public AudioCompressionFormat Format;
        public float Quality;
        public AudioSampleRateSetting SampleRateSetting;
        public uint SampleRateOverride;
    }

    public struct PrefabRendererSnapshot
    {
        public string PrefabPath;
        public string ObjectPath;
        public StaticEditorFlags Flags;
    }

    /// <summary>
    /// The project's build-size rules as pure functions over importer snapshots, so the audit,
    /// the import postprocessors and the tests all agree on one definition. Measured on the
    /// 2026-08-30 build: static-batched scatter prefabs were 57 % of the player, non-multiple-of-4
    /// textures shipped uncompressed at 3x the size, and 2048^2 prop maps cost ~500 MB.
    /// </summary>
    public static class AssetSizePolicy
    {
        public const int k_StandaloneMaxSize = 1024;
        public const string k_EnvironmentMeshRoot = "Assets/RootsDance/Meshes/Environment/";

        public static readonly string[] k_TextureRoots =
        {
            "Assets/RootsDance/Textures/",
            "Assets/ThirdParty/Environment/",
        };

        public static readonly string[] k_StandaloneCappedRoots =
        {
            "Assets/RootsDance/Textures/Props/",
            "Assets/RootsDance/Textures/Environment/",
        };

        /// <summary>Textures under a capped root that must keep their full resolution.</summary>
        public static readonly string[] k_FullResolutionTextures = { };

        public static readonly string[] k_ScatterPrefabRoots =
        {
            "Assets/RootsDance/Prefabs/Environment/Rocks/",
        };

        private const string k_ProjectTextureRoot = "Assets/RootsDance/Textures/";
        private const string k_PixelArtFolder = "Assets/ThirdParty/Environment/RetroPSXNature/";

        public static bool IsMultipleOfFour(int width, int height)
        {
            return width > 0 && height > 0 && width % 4 == 0 && height % 4 == 0;
        }

        public static bool StartsWithAny(string path, string[] roots)
        {
            foreach (string root in roots)
            {
                if (path.StartsWith(root, StringComparison.Ordinal))
                {
                    return true;
                }
            }

            return false;
        }

        public static bool IsPixelArtTexture(string path)
        {
            string name = System.IO.Path.GetFileNameWithoutExtension(path).ToLowerInvariant();
            return path.StartsWith(k_PixelArtFolder, StringComparison.Ordinal)
                || name.Contains("psx") || name.Contains("lowrez");
        }

        public static bool TryGetStandaloneMaxSize(string path, out int maxSize)
        {
            maxSize = 0;
            if (!StartsWithAny(path, k_StandaloneCappedRoots) || Array.IndexOf(k_FullResolutionTextures, path) >= 0)
            {
                return false;
            }

            maxSize = k_StandaloneMaxSize;
            return true;
        }

        public static void Check(TextureSnapshot texture, List<AssetViolation> output)
        {
            string path = texture.Path;
            if (!StartsWithAny(path, k_TextureRoots))
            {
                return;
            }

            if (!texture.IsCubemap && texture.Compression != TextureImporterCompression.Uncompressed
                && texture.SourceWidth > 0 && texture.SourceHeight > 0
                && !IsMultipleOfFour(texture.SourceWidth, texture.SourceHeight)
                && texture.NpotScale == TextureImporterNPOTScale.None)
            {
                output.Add(new AssetViolation(path, AssetRule.TextureNpot4, string.Format(
                    "{0}x{1} is not a multiple of 4, so it ships uncompressed; set Non Power of 2 = ToNearest",
                    texture.SourceWidth, texture.SourceHeight), true));
            }

            int cap;
            if (TryGetStandaloneMaxSize(path, out cap)
                && (!texture.StandaloneOverridden || texture.StandaloneMaxSize > cap
                    || texture.StandaloneFormat != TextureImporterFormat.Automatic))
            {
                output.Add(new AssetViolation(path, AssetRule.TextureStandaloneMax,
                    "needs a Standalone override with Max Size " + cap + " and Automatic format", true));
            }

            if (texture.IsReadable)
            {
                output.Add(new AssetViolation(path, AssetRule.TextureReadable, "Read/Write is enabled", true));
            }

            if (texture.Compression == TextureImporterCompression.Uncompressed
                && path.StartsWith(k_ProjectTextureRoot, StringComparison.Ordinal) && !IsPixelArtTexture(path))
            {
                output.Add(new AssetViolation(path, AssetRule.TextureUncompressed,
                    "compression is Uncompressed; confirm this is intended", false));
            }
        }

        public static void Check(ModelSnapshot model, List<AssetViolation> output)
        {
            if (!model.Path.StartsWith(k_EnvironmentMeshRoot, StringComparison.Ordinal))
            {
                return;
            }

            bool fixable = !model.PipelineOwned;
            if (model.IsReadable)
            {
                output.Add(new AssetViolation(model.Path, AssetRule.ModelReadable, "Read/Write is enabled", fixable));
            }

            if (model.ImportBlendShapes || model.ImportCameras || model.ImportLights)
            {
                output.Add(new AssetViolation(model.Path, AssetRule.ModelExtras,
                    "imports blend shapes, cameras or lights" + (model.PipelineOwned
                        ? " (pipeline-owned: change Tools/unity/model_import_profiles.json)" : ""), fixable));
            }
        }

        public static void Check(AudioSnapshot audio, List<AssetViolation> output)
        {
            AudioImportProfile profile;
            if (!AudioImportProfile.TryGet(AudioImportProfile.KindForPath(audio.Path), out profile))
            {
                return;
            }

            bool matches = audio.ForceToMono == profile.ForceToMono
                && audio.LoadType == profile.LoadType
                && audio.Format == profile.CompressionFormat
                && Mathf.Approximately(audio.Quality, profile.Quality)
                && audio.SampleRateSetting == AudioSampleRateSetting.OverrideSampleRate
                && audio.SampleRateOverride == AudioImportProfile.k_SampleRate;
            if (!matches)
            {
                output.Add(new AssetViolation(audio.Path, AssetRule.AudioProfile,
                    "import settings differ from the folder's AudioImportProfile; reimport applies them", true));
            }
        }

        public static void Check(PrefabRendererSnapshot renderer, List<AssetViolation> output)
        {
            if (!StartsWithAny(renderer.PrefabPath, k_ScatterPrefabRoots))
            {
                return;
            }

            if ((renderer.Flags & StaticEditorFlags.BatchingStatic) != 0)
            {
                output.Add(new AssetViolation(renderer.PrefabPath, AssetRule.PrefabScatterBatching,
                    "'" + renderer.ObjectPath + "' is Batching Static; scattered instances must not be " +
                    "(static batching copies every instance's mesh into the scene file)", true));
            }
        }
    }
}
