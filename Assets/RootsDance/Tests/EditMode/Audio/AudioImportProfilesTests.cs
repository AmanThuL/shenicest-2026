using NUnit.Framework;
using RootsDance.Editor.Audio;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Audio
{
    public class AudioImportProfilesTests
    {
        [TestCase("Assets/RootsDance/Audio/Music/MainTheme.ogg", AudioAssetKind.Music)]
        [TestCase("Assets/RootsDance/Audio/Ambience/Greenhouse_Bed.ogg", AudioAssetKind.Ambience)]
        [TestCase("Assets/RootsDance/Audio/SFX/Footstep_Grass_01.wav", AudioAssetKind.Sfx)]
        [TestCase("Assets/RootsDance/Audio/Voice/Flower_Greeting.wav", AudioAssetKind.Voice)]
        [TestCase("Assets/RootsDance/Audio/SFX/Doors/Slide_01.wav", AudioAssetKind.Sfx)]
        public void KindForPath_UnderAnAudioFolder_ReturnsThatKind(string path, AudioAssetKind expected)
        {
            Assert.AreEqual(expected, AudioImportProfile.KindForPath(path));
        }

        [TestCase(null)]
        [TestCase("")]
        [TestCase("Assets/RootsDance/Audio/Loose.wav")]              // not in a kind folder
        [TestCase("Assets/RootsDance/Audio/Mixers/Main.mixer")]      // not a clip folder
        [TestCase("Assets/ThirdParty/SomePack/Audio/SFX/Hit.wav")]   // vendor audio is left alone
        [TestCase("Assets/RootsDance/Textures/Environment/Moss_BaseMap.png")]
        public void KindForPath_OutsideTheFourFolders_ReturnsUnknown(string path)
        {
            Assert.AreEqual(AudioAssetKind.Unknown, AudioImportProfile.KindForPath(path));
        }

        [Test]
        public void TryGet_Unknown_ReturnsFalseSoImportSettingsAreLeftAlone()
        {
            Assert.IsFalse(AudioImportProfile.TryGet(AudioAssetKind.Unknown, out _));
        }

        [Test]
        public void TryGet_Sfx_IsMonoAndDecompressedSoOneShotsStartOnTime()
        {
            Assert.IsTrue(AudioImportProfile.TryGet(AudioAssetKind.Sfx, out AudioImportProfile profile));
            Assert.IsTrue(profile.ForceToMono);
            Assert.AreEqual(AudioClipLoadType.DecompressOnLoad, profile.LoadType);
        }

        [TestCase(AudioAssetKind.Music)]
        [TestCase(AudioAssetKind.Ambience)]
        public void TryGet_LongFormKinds_AreStreamedAndKeepTheirStereoImage(AudioAssetKind kind)
        {
            Assert.IsTrue(AudioImportProfile.TryGet(kind, out AudioImportProfile profile));
            Assert.AreEqual(AudioClipLoadType.Streaming, profile.LoadType);
            Assert.IsFalse(profile.ForceToMono);
        }

        [Test]
        public void TryGet_Music_UsesVorbisQualityHalf()
        {
            AudioImportProfile profile;
            Assert.IsTrue(AudioImportProfile.TryGet(AudioAssetKind.Music, out profile));
            Assert.AreEqual(0.5f, profile.Quality, 0.0001f);
            Assert.AreEqual(AudioClipLoadType.Streaming, profile.LoadType);
        }

        [Test]
        public void TryGet_Voice_IsMonoAndStaysCompressedInMemory()
        {
            Assert.IsTrue(AudioImportProfile.TryGet(AudioAssetKind.Voice, out AudioImportProfile profile));
            Assert.IsTrue(profile.ForceToMono);
            Assert.AreEqual(AudioClipLoadType.CompressedInMemory, profile.LoadType);
        }
    }
}
