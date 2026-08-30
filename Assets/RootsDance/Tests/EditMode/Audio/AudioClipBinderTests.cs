using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Audio;

namespace RootsDance.Tests.EditMode.Audio
{
    /// <summary>
    /// The clip table is a list of file names, so nothing but a check keeps it honest: a typo in a
    /// folder gives the clip the wrong import settings, and a cue listed twice loses the first row
    /// without saying so. The binder itself needs the AssetDatabase; the table does not.
    /// </summary>
    public class AudioClipBinderTests
    {
        [Test]
        public void Bindings_EachCueAppearsOnce_SoNoRowIsSilentlyOverwritten()
        {
            HashSet<string> seen = new HashSet<string>();

            foreach (AudioClipBinder.ClipBinding binding in AudioClipBinder.k_Bindings)
            {
                Assert.IsTrue(seen.Add(binding.m_cue), $"{binding.m_cue} is bound twice.");
            }
        }

        [Test]
        public void Bindings_EveryRowHasClips()
        {
            foreach (AudioClipBinder.ClipBinding binding in AudioClipBinder.k_Bindings)
            {
                Assert.IsNotNull(binding.m_files, $"{binding.m_cue} has no clip list.");
                Assert.Greater(binding.m_files.Length, 0, $"{binding.m_cue} lists no clip.");
            }
        }

        [Test]
        public void Bindings_NoClipIsListedTwiceInOneCue_SoVariationStaysVariation()
        {
            foreach (AudioClipBinder.ClipBinding binding in AudioClipBinder.k_Bindings)
            {
                HashSet<string> seen = new HashSet<string>();

                foreach (string file in binding.m_files)
                {
                    Assert.IsTrue(seen.Add(file), $"{binding.m_cue} lists {file} twice.");
                }
            }
        }

        /// <summary>
        /// Music streams, a bed streams and stays stereo, a one-shot is mono and decompressed —
        /// and all of that is decided by the folder, so a cue's prefix and its clips' folder have
        /// to agree. See <see cref="AudioImportProfile.KindForPath"/>.
        /// </summary>
        [Test]
        public void Bindings_ClipFolderMatchesTheCuePrefix_SoImportSettingsFollowTheUse()
        {
            foreach (AudioClipBinder.ClipBinding binding in AudioClipBinder.k_Bindings)
            {
                AudioAssetKind expected = ExpectedKind(binding.m_cue);

                for (int i = 0; i < binding.m_files.Length; i++)
                {
                    string path = binding.ClipPath(i);

                    Assert.AreEqual(expected, AudioImportProfile.KindForPath(path),
                        $"{binding.m_cue} points at {path}.");
                }
            }
        }

        [Test]
        public void Bindings_EveryFileNameCarriesAnAudioExtension()
        {
            foreach (AudioClipBinder.ClipBinding binding in AudioClipBinder.k_Bindings)
            {
                foreach (string file in binding.m_files)
                {
                    Assert.IsTrue(file.EndsWith(".wav") || file.EndsWith(".ogg")
                        || file.EndsWith(".mp3"), $"{binding.m_cue} lists {file}.");
                }
            }
        }

        private static AudioAssetKind ExpectedKind(string cue)
        {
            if (cue.StartsWith("MUS_"))
            {
                return AudioAssetKind.Music;
            }

            return cue.StartsWith("AMB_") ? AudioAssetKind.Ambience : AudioAssetKind.Sfx;
        }
    }
}
