using System.Collections.Generic;
using System.Reflection;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Editor.Audio;

namespace RootsDance.Tests.EditMode.Audio
{
    /// <summary>
    /// The music table names flags and cues as strings, and a wrong string is silent rather than
    /// broken: a misspelled flag never fires, and a beat pointing at a cue with no clip crossfades
    /// to nothing. Both are invisible in the Editor and obvious here.
    /// </summary>
    public class MusicWiringTests
    {
        [Test]
        public void Beats_EveryFlagIsAWorldFlagsConstant()
        {
            HashSet<string> known = KnownFlags();

            foreach (MusicWiring.MusicBeat beat in MusicWiring.k_Beats)
            {
                Assert.IsTrue(known.Contains(beat.m_flagId),
                    $"'{beat.m_flagId}' is not a flag WorldFlags declares.");
            }
        }

        [Test]
        public void Beats_NoFlagAppearsTwice_SoOneBeatIsOneChange()
        {
            HashSet<string> seen = new HashSet<string>();

            foreach (MusicWiring.MusicBeat beat in MusicWiring.k_Beats)
            {
                Assert.IsTrue(seen.Add(beat.m_flagId), $"{beat.m_flagId} carries two beats.");
            }
        }

        [Test]
        public void Beats_EveryCueIsAMusicCue()
        {
            Assert.IsTrue(MusicWiring.k_OpeningCue.StartsWith(AudioClipBinder.k_MusicPrefix));

            foreach (MusicWiring.MusicBeat beat in MusicWiring.k_Beats)
            {
                Assert.IsTrue(beat.m_cue.StartsWith(AudioClipBinder.k_MusicPrefix),
                    $"{beat.m_cue} is not a music cue.");
            }
        }

        /// <summary>A beat is only a beat if the cue it names actually has a track behind it.</summary>
        [Test]
        public void Beats_EveryCueHasClipsInTheBindingTable()
        {
            HashSet<string> bound = new HashSet<string>();

            foreach (AudioClipBinder.ClipBinding binding in AudioClipBinder.k_Bindings)
            {
                bound.Add(binding.m_cue);
            }

            Assert.IsTrue(bound.Contains(MusicWiring.k_OpeningCue),
                $"{MusicWiring.k_OpeningCue} has no clip.");

            foreach (MusicWiring.MusicBeat beat in MusicWiring.k_Beats)
            {
                Assert.IsTrue(bound.Contains(beat.m_cue), $"{beat.m_cue} has no clip.");
            }
        }

        private static HashSet<string> KnownFlags()
        {
            HashSet<string> flags = new HashSet<string>();

            foreach (FieldInfo field in typeof(WorldFlags).GetFields(BindingFlags.Public
                | BindingFlags.Static | BindingFlags.FlattenHierarchy))
            {
                if (field.IsLiteral && field.FieldType == typeof(string))
                {
                    flags.Add((string)field.GetRawConstantValue());
                }
            }

            return flags;
        }
    }
}
