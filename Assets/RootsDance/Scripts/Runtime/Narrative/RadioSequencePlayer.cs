using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.App;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Dialogue;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>
    /// The radio. One component owns every transmission in a level: the recordings, the subtitles
    /// under them, and the flag each one raises when it is over.
    /// <para>
    /// One component rather than one per transmission, because a helmet holds one radio. Separate
    /// players cannot see each other, and chapter 00's own layout makes them overlap — the
    /// departure briefing runs about fourteen seconds while the walk it covers takes five, so a
    /// second transmission triggered by distance would start talking over the first. Here a
    /// transmission that arrives during another is queued, not dropped: dropping it would strand
    /// whatever waits on its finish flag, which for node 00-04 is the carrier hiss itself.
    /// </para>
    /// <para>
    /// It listens to a channel asset rather than reading the world state directly, so it does not
    /// care whether the bootstrap has arrived yet.
    /// </para>
    /// <para>
    /// The carrier hiss under a transmission is not played here. It is a looping bed, and a bed
    /// belongs to a <see cref="FlagAudioBed"/> keyed to the same flags this player raises — which
    /// also means the hiss survives a checkpoint jump into the middle of the beat, and this
    /// component keeps exactly one job.
    /// </para>
    /// </summary>
    public class RadioSequencePlayer : MonoBehaviour
    {
        /// <summary>One transmission, and the flags that bracket it.</summary>
        [Serializable]
        private struct Transmission
        {
            [Tooltip("Flag id that puts this transmission on the air.")]
            public string m_startOnFlag;

            public RadioSequenceSO m_sequence;

            [Tooltip("Flag raised once its last line finished. Empty raises nothing.")]
            public string m_flagOnFinished;
        }

        [Header("Listens to")]
        [Tooltip("Flag channel pumped by GameBootstrap.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Optional: a channel any trigger may raise to play a transmission through this "
            + "player. Data/Events/RadioRequested.")]
        [SerializeField] private RadioEventChannelSO m_playRequested;

        [Header("Content")]
        [Tooltip("Every transmission in this level, each with the flag that starts it. Order does "
            + "not matter; the flags decide.")]
        [SerializeField] private Transmission[] m_transmissions = new Transmission[0];

        [Header("Broadcasts on")]
        [Tooltip("Line channel the radio subtitle listens to. Data/Events/RadioLine.")]
        [SerializeField] private StringEventChannelSO m_lineShown;

        [Tooltip("Optional: the English subtitle, on its own channel so the HUD can set it under "
            + "the Chinese in its own style. Empty drops the English.")]
        [SerializeField] private StringEventChannelSO m_englishShown;

        [Tooltip("Where the voice is played. Data/Events/AudioCueRequested.")]
        [SerializeField] private AudioCueEventChannelSO m_audioChannel;

        [Header("Stings")]
        [Tooltip("Optional: the carrier opening, played flat before the first line.")]
        [SerializeField] private AudioCueSO m_openCue;

        [Tooltip("Optional: the carrier closing — a squelch, or the signal being lost — played "
            + "flat after the last line.")]
        [SerializeField] private AudioCueSO m_closeCue;

        private readonly Queue<Transmission> m_pending = new Queue<Transmission>();
        private readonly HashSet<string> m_started = new HashSet<string>();

        /// <summary>True while a transmission is on the air. Others wait their turn behind it.</summary>
        public bool IsPlaying { get; private set; }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }

            if (m_playRequested != null)
            {
                m_playRequested.EventRaised += Play;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }

            if (m_playRequested != null)
            {
                m_playRequested.EventRaised -= Play;
            }
        }

        /// <summary>Puts a transmission on the air, behind whatever is already talking.</summary>
        public void Play(RadioSequenceSO sequence)
        {
            if (sequence == null)
            {
                return;
            }

            Enqueue(new Transmission { m_sequence = sequence });
        }

        private void OnFlagRaised(string flagId)
        {
            if (string.IsNullOrEmpty(flagId))
            {
                return;
            }

            for (int i = 0; i < m_transmissions.Length; i++)
            {
                Transmission transmission = m_transmissions[i];

                // Once each: flags are raised once, but a checkpoint seed can replay one, and a
                // transmission the player has already heard is not news.
                if (transmission.m_startOnFlag != flagId || !m_started.Add(flagId))
                {
                    continue;
                }

                Enqueue(transmission);
            }
        }

        private void Enqueue(Transmission transmission)
        {
            m_pending.Enqueue(transmission);

            if (!IsPlaying)
            {
                PumpAsync(destroyCancellationToken);
            }
        }

        /// <summary>
        /// Drains the queue one transmission at a time. Started only when nothing is on the air, so
        /// there is never a second pump: whatever is queued mid-transmission is picked up by the
        /// loop this one is already in.
        /// </summary>
        private async void PumpAsync(CancellationToken cancellationToken)
        {
            IsPlaying = true;

            try
            {
                while (m_pending.Count > 0)
                {
                    await PlayAsync(m_pending.Dequeue(), cancellationToken);
                }
            }
            catch (OperationCanceledException)
            {
                // Object destroyed or Play mode exited: nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
            finally
            {
                IsPlaying = false;
            }
        }

        private async Awaitable PlayAsync(Transmission transmission, CancellationToken cancellationToken)
        {
            RadioSequenceSO sequence = transmission.m_sequence;

            if (sequence == null)
            {
                Log.Error("A radio transmission has no sequence assigned.", this);
                return;
            }

            await Awaitable.WaitForSecondsAsync(sequence.StartDelay, cancellationToken);

            PlayCue(m_openCue);

            RadioLine[] lines = sequence.Lines;
            AudioCueSO voiceCue = sequence.VoiceCue;

            for (int i = 0; i < lines.Length; i++)
            {
                RadioLine line = lines[i];

                Show(m_lineShown, line.Text);
                Show(m_englishShown, line.English);

                AudioClip voice = line.Voice;

                if (voice != null && voiceCue != null && m_audioChannel != null)
                {
                    m_audioChannel.RaiseEvent(AudioCueRequest.Voice(voiceCue, voice));
                }

                // The same rule the conversations use: a recording is never cut off, an authored
                // hold wins when it is longer, and a line with neither is paced by its text.
                float hold = DialogueTiming.HoldSecondsForLine(line.HoldSeconds,
                    voice == null ? 0f : voice.length, line.Text, line.English);

                await Awaitable.WaitForSecondsAsync(hold, cancellationToken);
            }

            Show(m_lineShown, string.Empty);
            Show(m_englishShown, string.Empty);

            PlayCue(m_closeCue);

            if (!string.IsNullOrEmpty(transmission.m_flagOnFinished))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(transmission.m_flagOnFinished), this);
            }
        }

        private void PlayCue(AudioCueSO cue)
        {
            if (cue != null && m_audioChannel != null)
            {
                m_audioChannel.RaiseEvent(new AudioCueRequest(cue));
            }
        }

        private static void Show(StringEventChannelSO channel, string text)
        {
            if (channel != null)
            {
                channel.RaiseEvent(text);
            }
        }
    }
}
