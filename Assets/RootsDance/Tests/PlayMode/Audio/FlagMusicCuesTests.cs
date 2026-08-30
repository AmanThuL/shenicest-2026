using System;
using System.Collections;
using System.Reflection;
using NUnit.Framework;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Audio
{
    /// <summary>
    /// The music chain end to end: a flag goes out on a channel and a track is playing a frame
    /// later. In Play mode because the two things this can get wrong are both about frames — the
    /// opening request is raised in <c>Start</c> precisely because a sibling component's
    /// <c>OnEnable</c> may not have subscribed yet, and no EditMode call can observe that order.
    /// </summary>
    public class FlagMusicCuesTests
    {
        private GameObject m_root;
        private MusicDirector m_director;
        private FlagMusicCues m_cues;
        private StringEventChannelSO m_flagRaised;
        private AudioCueEventChannelSO m_musicRequested;
        private AudioCueSO m_opening;
        private AudioCueSO m_beat;

        [SetUp]
        public void SetUp()
        {
            m_flagRaised = ScriptableObject.CreateInstance<StringEventChannelSO>();
            m_musicRequested = ScriptableObject.CreateInstance<AudioCueEventChannelSO>();
            m_opening = Cue("opening");
            m_beat = Cue("beat");

            m_root = new GameObject("MusicUnderTest");
            m_root.SetActive(false);

            m_director = m_root.AddComponent<MusicDirector>();
            m_cues = m_root.AddComponent<FlagMusicCues>();

            Set(m_director, "m_musicRequested", m_musicRequested);
            Set(m_cues, "m_flagRaised", m_flagRaised);
            Set(m_cues, "m_musicRequested", m_musicRequested);
            Set(m_cues, "m_openingMusic", m_opening);
            SetBindings(m_cues, ("flow.test_beat", m_beat, false), ("flow.test_silence", null, true),
                ("flow.test_unfinished", null, false));
        }

        [TearDown]
        public void TearDown()
        {
            UnityEngine.Object.DestroyImmediate(m_root);
            UnityEngine.Object.DestroyImmediate(m_flagRaised);
            UnityEngine.Object.DestroyImmediate(m_musicRequested);
            UnityEngine.Object.DestroyImmediate(m_opening);
            UnityEngine.Object.DestroyImmediate(m_beat);
        }

        [UnityTest]
        public IEnumerator OpeningTrack_IsPlayingAfterTheFirstFrame()
        {
            m_root.SetActive(true);
            yield return null;

            Assert.AreSame(m_opening, m_director.Playing);
        }

        [UnityTest]
        public IEnumerator FlagWithABeat_CrossfadesToThatTrack()
        {
            m_root.SetActive(true);
            yield return null;

            m_flagRaised.RaiseEvent("flow.test_beat");

            Assert.AreSame(m_beat, m_director.Playing);
        }

        [UnityTest]
        public IEnumerator FlagMarkedAsSilence_StopsTheMusic()
        {
            m_root.SetActive(true);
            yield return null;

            m_flagRaised.RaiseEvent("flow.test_silence");

            Assert.IsNull(m_director.Playing);
        }

        [UnityTest]
        public IEnumerator RowWithNoCueAndNoSilenceTick_LeavesTheTrackAlone()
        {
            m_root.SetActive(true);
            yield return null;

            m_flagRaised.RaiseEvent("flow.test_unfinished");

            Assert.AreSame(m_opening, m_director.Playing);
        }

        [UnityTest]
        public IEnumerator FlagWithNoRow_LeavesTheTrackAlone()
        {
            m_root.SetActive(true);
            yield return null;

            m_flagRaised.RaiseEvent("flow.some_other_thing");

            Assert.AreSame(m_opening, m_director.Playing);
        }

        [UnityTest]
        public IEnumerator RestoreAfterRescue_MultipleHistoricalBeats_RequestsOnlyFinalTrack()
        {
            m_root.SetActive(true);
            yield return null;
            int requests = 0;
            Action<AudioCueRequest> count = request => requests++;
            m_musicRequested.EventRaised += count;

            try
            {
                RescueCheckpoint checkpoint = new RescueCheckpoint("test", "Test", null,
                    string.Empty, Vector3.zero, 0f, false, TimeOfDay.Day,
                    new[] { "flow.test_silence", "flow.test_beat", "flow.test_unfinished" }, null);
                m_director.ResetForRescue();
                m_cues.RestoreAfterRescue(checkpoint);

                Assert.That(requests, Is.EqualTo(1));
                Assert.That(m_director.Playing, Is.SameAs(m_beat));
            }
            finally
            {
                m_musicRequested.EventRaised -= count;
            }
        }

        [UnityTest]
        public IEnumerator ResetForRescue_TrackPlaying_ClearsBothAudioSourcesImmediately()
        {
            m_root.SetActive(true);
            yield return null;
            m_flagRaised.RaiseEvent("flow.test_beat");

            m_director.ResetForRescue();

            Assert.That(m_director.Playing, Is.Null);

            foreach (AudioSource source in m_root.GetComponentsInChildren<AudioSource>())
            {
                Assert.That(source.clip, Is.Null);
                Assert.That(source.isPlaying, Is.False);
            }
        }

        /// <summary>A cue with one second of silence in it — the director refuses a clipless cue.</summary>
        private static AudioCueSO Cue(string name)
        {
            AudioCueSO cue = ScriptableObject.CreateInstance<AudioCueSO>();
            cue.name = name;
            Set(cue, "m_clips", new[] { AudioClip.Create(name, 44100, 1, 44100, stream: false) });
            Set(cue, "m_loop", true);

            return cue;
        }

        private static void Set(object target, string field, object value)
        {
            FieldInfo info = target.GetType().GetField(field,
                BindingFlags.Instance | BindingFlags.NonPublic);

            Assert.IsNotNull(info, $"{target.GetType().Name} has no field {field}.");
            info.SetValue(target, value);
        }

        /// <summary>
        /// Fills the private table. The row type is private to the component on purpose — a row is
        /// authored in the Inspector, not from code — so the test builds them by reflection rather
        /// than widening the component's surface for a test's sake.
        /// </summary>
        private static void SetBindings(FlagMusicCues target,
            params (string flagId, AudioCueSO cue, bool stops)[] rows)
        {
            FieldInfo field = typeof(FlagMusicCues).GetField("m_bindings",
                BindingFlags.Instance | BindingFlags.NonPublic);
            Assert.IsNotNull(field, "FlagMusicCues has no field m_bindings.");

            Type rowType = field.FieldType.GetElementType();
            Array table = Array.CreateInstance(rowType, rows.Length);

            for (int i = 0; i < rows.Length; i++)
            {
                object row = Activator.CreateInstance(rowType);
                rowType.GetField("m_flagId").SetValue(row, rows[i].flagId);
                rowType.GetField("m_cue").SetValue(row, rows[i].cue);
                rowType.GetField("m_stopsMusic").SetValue(row, rows[i].stops);
                table.SetValue(row, i);
            }

            field.SetValue(target, table);
        }
    }
}
