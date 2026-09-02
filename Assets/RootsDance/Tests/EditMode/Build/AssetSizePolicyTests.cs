using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Build;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Build
{
    public class AssetSizePolicyTests
    {
        private static TextureSnapshot CompliantPropTexture()
        {
            return new TextureSnapshot
            {
                Path = "Assets/RootsDance/Textures/Props/Helmet_BaseMap.png",
                SourceWidth = 2048,
                SourceHeight = 2048,
                Compression = TextureImporterCompression.Compressed,
                NpotScale = TextureImporterNPOTScale.None,
                IsReadable = false,
                StandaloneOverridden = true,
                StandaloneMaxSize = 1024,
                StandaloneFormat = TextureImporterFormat.Automatic,
            };
        }

        private static List<AssetViolation> Run(TextureSnapshot snapshot)
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(snapshot, output);
            return output;
        }

        [Test]
        public void Check_CompliantPropTexture_NoViolations()
        {
            Assert.IsEmpty(Run(CompliantPropTexture()));
        }

        [Test]
        public void Check_NonMultipleOfFourWithNpotNone_ReportsFixableNpot4()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.SourceWidth = 1707;
            List<AssetViolation> violations = Run(snapshot);
            Assert.AreEqual(1, violations.Count);
            Assert.AreEqual(AssetRule.TextureNpot4.ToString(), violations[0].rule);
            Assert.IsTrue(violations[0].fixable);
        }

        [Test]
        public void Check_NonMultipleOfFourWithToNearest_IsCompliant()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.SourceWidth = 1707;
            snapshot.NpotScale = TextureImporterNPOTScale.ToNearest;
            Assert.IsEmpty(Run(snapshot));
        }

        [Test]
        public void Check_CubemapIgnoresNpotRule()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.SourceWidth = 1707;
            snapshot.IsCubemap = true;
            Assert.IsEmpty(Run(snapshot));
        }

        [Test]
        public void Check_MissingStandaloneOverride_ReportsStandaloneMax()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.StandaloneOverridden = false;
            List<AssetViolation> violations = Run(snapshot);
            Assert.AreEqual(AssetRule.TextureStandaloneMax.ToString(), violations[0].rule);
        }

        [Test]
        public void Check_StandaloneOverrideAbove1024_ReportsStandaloneMax()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.StandaloneMaxSize = 2048;
            Assert.AreEqual(1, Run(snapshot).Count);
        }

        [Test]
        public void Check_CharacterTexture_NeedsNoStandaloneOverride()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.Path = "Assets/RootsDance/Textures/Characters/FlowerSprite_BaseMap.png";
            snapshot.StandaloneOverridden = false;
            Assert.IsEmpty(Run(snapshot));
        }

        [Test]
        public void Check_ReadableTexture_ReportsReadable()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.IsReadable = true;
            Assert.AreEqual(AssetRule.TextureReadable.ToString(), Run(snapshot)[0].rule);
        }

        [Test]
        public void Check_UncompressedProjectTexture_WarnsWithoutFix()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.Compression = TextureImporterCompression.Uncompressed;
            List<AssetViolation> violations = Run(snapshot);
            Assert.AreEqual(AssetRule.TextureUncompressed.ToString(), violations[0].rule);
            Assert.IsFalse(violations[0].fixable);
        }

        [Test]
        public void Check_UncompressedPsxTexture_IsExempt()
        {
            var snapshot = new TextureSnapshot
            {
                Path = "Assets/ThirdParty/Environment/RetroPSXNature/Textures/Trees/Tree1.png",
                SourceWidth = 256, SourceHeight = 256,
                Compression = TextureImporterCompression.Uncompressed,
            };
            Assert.IsEmpty(Run(snapshot));
        }

        [Test]
        public void Check_UncompressedPsxNamedProjectTexture_IsExempt()
        {
            // The exemption is by name as well as by folder: a psx/lowrez map authored into the
            // project's own Textures/ tree is deliberately uncompressed, like the RetroPSXNature pack.
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.Path = "Assets/RootsDance/Textures/Props/Sign_psx_BaseMap.png";
            snapshot.SourceWidth = 256;
            snapshot.SourceHeight = 256;
            snapshot.Compression = TextureImporterCompression.Uncompressed;
            Assert.IsEmpty(Run(snapshot));
        }

        [Test]
        public void Check_TextureOutsideRoots_IsIgnored()
        {
            TextureSnapshot snapshot = CompliantPropTexture();
            snapshot.Path = "Assets/RootsDance/UI/Sprites/HelmetVisorShape.png";
            snapshot.SourceWidth = 1707;
            snapshot.IsReadable = true;
            Assert.IsEmpty(Run(snapshot));
        }

        [Test]
        public void TryGetStandaloneMaxSize_PropsAndEnvironmentAreCapped()
        {
            int size;
            Assert.IsTrue(AssetSizePolicy.TryGetStandaloneMaxSize(
                "Assets/RootsDance/Textures/Props/A_BaseMap.png", out size));
            Assert.AreEqual(1024, size);
            Assert.IsTrue(AssetSizePolicy.TryGetStandaloneMaxSize(
                "Assets/RootsDance/Textures/Environment/GreenHouse1Floor1_Normal.png", out size));
            Assert.IsFalse(AssetSizePolicy.TryGetStandaloneMaxSize(
                "Assets/RootsDance/Textures/Characters/X_BaseMap.png", out size));
        }

        [Test]
        public void Check_EnvironmentModelExtras_ReportsFixable()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new ModelSnapshot
            {
                Path = "Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouseCorridor.fbx",
                IsReadable = true, ImportBlendShapes = true, ImportCameras = false, ImportLights = false,
            }, output);
            Assert.AreEqual(2, output.Count);
            CollectionAssert.AreEquivalent(
                new[] { AssetRule.ModelReadable.ToString(), AssetRule.ModelExtras.ToString() },
                new[] { output[0].rule, output[1].rule });
            Assert.IsTrue(output[0].fixable && output[1].fixable);
        }

        [Test]
        public void Check_PipelineOwnedModel_IsReportedButNotFixable()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new ModelSnapshot
            {
                Path = "Assets/RootsDance/Meshes/Environment/ChapterHouse/MyceliumUndercroft.fbx",
                PipelineOwned = true, ImportBlendShapes = true,
            }, output);
            Assert.AreEqual(1, output.Count);
            Assert.IsFalse(output[0].fixable);
        }

        [Test]
        public void Check_CharacterModel_IsOutOfScope()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new ModelSnapshot
            {
                Path = "Assets/RootsDance/Meshes/Characters/FlowerSprite.fbx",
                ImportBlendShapes = true, IsReadable = true,
            }, output);
            Assert.IsEmpty(output);
        }

        [Test]
        public void Check_AudioMatchingProfile_NoViolation()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new AudioSnapshot
            {
                Path = "Assets/RootsDance/Audio/Music/Permafrost.mp3", ForceToMono = false,
                LoadType = AudioClipLoadType.Streaming, Format = AudioCompressionFormat.Vorbis, Quality = 0.5f,
                SampleRateSetting = AudioSampleRateSetting.OverrideSampleRate, SampleRateOverride = 44100,
            }, output);
            Assert.IsEmpty(output);
        }

        [Test]
        public void Check_AudioQualityDrift_ReportsFixable()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new AudioSnapshot
            {
                Path = "Assets/RootsDance/Audio/Music/Permafrost.mp3", ForceToMono = false,
                LoadType = AudioClipLoadType.Streaming, Format = AudioCompressionFormat.Vorbis, Quality = 0.7f,
                SampleRateSetting = AudioSampleRateSetting.OverrideSampleRate, SampleRateOverride = 44100,
            }, output);
            Assert.AreEqual(1, output.Count);
            Assert.AreEqual(AssetRule.AudioProfile.ToString(), output[0].rule);
            Assert.IsTrue(output[0].fixable);
        }

        [Test]
        public void Check_ScatterPrefabWithBatchingStatic_ReportsFixable()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new PrefabRendererSnapshot
            {
                PrefabPath = "Assets/RootsDance/Prefabs/Environment/Rocks/single_root.prefab",
                ObjectPath = "single_root/LOD0",
                Flags = StaticEditorFlags.BatchingStatic | StaticEditorFlags.OccluderStatic,
            }, output);
            Assert.AreEqual(1, output.Count);
            Assert.AreEqual(AssetRule.PrefabScatterBatching.ToString(), output[0].rule);
            StringAssert.Contains("LOD0", output[0].message);
        }

        [Test]
        public void Check_ScatterPrefabWithoutBatching_IsCompliant()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new PrefabRendererSnapshot
            {
                PrefabPath = "Assets/RootsDance/Prefabs/Environment/Rocks/single_root.prefab",
                ObjectPath = "single_root/LOD0",
                Flags = StaticEditorFlags.OccluderStatic | StaticEditorFlags.OccludeeStatic,
            }, output);
            Assert.IsEmpty(output);
        }

        [Test]
        public void Check_OtherPrefabWithBatching_IsOutOfScope()
        {
            var output = new List<AssetViolation>();
            AssetSizePolicy.Check(new PrefabRendererSnapshot
            {
                PrefabPath = "Assets/RootsDance/Prefabs/Environment/Lab/Wall.prefab",
                ObjectPath = "Wall", Flags = StaticEditorFlags.BatchingStatic,
            }, output);
            Assert.IsEmpty(output);
        }

        [TestCase(2048, 2048, true)]
        [TestCase(1707, 2048, false)]
        [TestCase(1200, 897, false)]
        [TestCase(1536, 1024, true)]
        public void IsMultipleOfFour(int width, int height, bool expected)
        {
            Assert.AreEqual(expected, AssetSizePolicy.IsMultipleOfFour(width, height));
        }
    }
}
