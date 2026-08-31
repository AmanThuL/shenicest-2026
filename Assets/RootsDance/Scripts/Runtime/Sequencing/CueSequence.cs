using System;
using System.Threading;
using RootsDance.App;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Data;
using RootsDance.Dialogue;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Sequencing
{
    /// <summary>
    /// A scripted moment as a list of steps: wait, raise a flag, switch something on, play a sound,
    /// start a conversation. One component covers the greenhouse's two endings and the corridor's
    /// startle beats, which is the reason it is data and not three bespoke scripts.
    /// <para>
    /// The steps live on the component rather than in a ScriptableObject asset, and that is the
    /// whole design: a sequence's job is to switch on <em>this</em> light and <em>that</em> vine,
    /// and a scene reference cannot be serialized into an asset. What is reusable about a moment —
    /// the sound, the conversation — is already an asset the step points at.
    /// </para>
    /// <para>
    /// A sequence does not wait for a conversation to end. It fires and moves on, so a line can
    /// play over the ending rather than pausing it; where a beat has to land after the talking, the
    /// conversation raises a flag on completion and a second sequence starts on that flag.
    /// </para>
    /// </summary>
    public class CueSequence : MonoBehaviour, IRescueStateRestoredParticipant
    {
        /// <summary>What starts the sequence.</summary>
        public enum Moment
        {
            /// <summary>Only when another component calls <see cref="Play"/>.</summary>
            Manual = 0,

            /// <summary>Once, when the object becomes active.</summary>
            OnEnable = 1,

            /// <summary>A world flag is raised.</summary>
            OnFlagRaised = 2,

            /// <summary>The player walks into the trigger collider on this object.</summary>
            OnPlayerEnter = 3
        }

        [Header("When")]
        [SerializeField] private Moment m_playOn = Moment.OnFlagRaised;

        [Tooltip("Only read for On Flag Raised.")]
        [SerializeField] private string m_startOnFlag;

        [Tooltip("The bootstrap's FlagRaised channel. Only needed for On Flag Raised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("On: runs at most once. Off: may run again, and a second start is refused only "
            + "while the first is still going.")]
        [SerializeField] private bool m_playsOnce = true;

        [Header("Broadcasts on")]
        [Tooltip("Data/Events/AudioCueRequested, for the Play Audio steps.")]
        [SerializeField] private AudioCueEventChannelSO m_audioChannel;

        [Tooltip("Data/Events/DialogueRequested, for the Play Dialogue steps.")]
        [SerializeField] private DialogueEventChannelSO m_dialogueChannel;

        [Header("Steps")]
        [SerializeField] private CueStep[] m_steps = new CueStep[0];

        private bool m_hasPlayed;

        /// <summary>True while the sequence is running.</summary>
        public bool IsPlaying { get; private set; }

        private void OnEnable()
        {
            if (m_playOn == Moment.OnFlagRaised && m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }

            if (m_playOn == Moment.OnEnable)
            {
                Play();
            }
        }

        private void OnDisable()
        {
            if (m_playOn == Moment.OnFlagRaised && m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        private void OnTriggerEnter(Collider other)
        {
            if (m_playOn != Moment.OnPlayerEnter)
            {
                return;
            }

            if (other.GetComponentInParent<PlayerTriggerProbe>() == null)
            {
                return;
            }

            Play();
        }

        /// <summary>Runs the sequence. Harmless to call twice.</summary>
        public void Play()
        {
            if (IsPlaying || (m_playsOnce && m_hasPlayed))
            {
                return;
            }

            m_hasPlayed = true;
            PlayEntryAsync(destroyCancellationToken);
        }

        private void OnFlagRaised(string flagId)
        {
            if (flagId == m_startOnFlag)
            {
                Play();
            }
        }

        /// <summary>
        /// A checkpoint seed or a rescue lands its flags as one silent snapshot, so a sequence
        /// keyed to one of them never hears the event. Its beat still belongs to the state being
        /// restored — a wrong-cycle spawn owes the player its outburst, the good-cycle spawn its
        /// water — so a seeded start flag plays the sequence the same as a raised one would.
        /// </summary>
        public void RestoreAfterRescue(RescueCheckpoint checkpoint)
        {
            if (m_playOn != Moment.OnFlagRaised || string.IsNullOrEmpty(m_startOnFlag)
                || checkpoint == null)
            {
                return;
            }

            for (int i = 0; i < checkpoint.Flags.Count; i++)
            {
                if (checkpoint.Flags[i] == m_startOnFlag)
                {
                    Play();
                    return;
                }
            }
        }

        private async void PlayEntryAsync(CancellationToken cancellationToken)
        {
            IsPlaying = true;

            try
            {
                await RunAsync(cancellationToken);
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

        private async Awaitable RunAsync(CancellationToken cancellationToken)
        {
            for (int i = 0; i < m_steps.Length; i++)
            {
                CueStep step = m_steps[i];

                if (step == null)
                {
                    continue;
                }

                Execute(step);

                if (step.Delay > 0f)
                {
                    await Awaitable.WaitForSecondsAsync(step.Delay, cancellationToken);
                }
            }
        }

        private void Execute(CueStep step)
        {
            switch (step.Kind)
            {
                case CueStepKind.RaiseFlag:
                    if (!string.IsNullOrEmpty(step.FlagId))
                    {
                        WorldAccess.Enqueue(new RaiseFlagCommand(step.FlagId), this);
                    }

                    break;

                case CueStepKind.SetActive:
                    if (step.Target != null)
                    {
                        step.Target.SetActive(step.IsActive);
                    }

                    break;

                case CueStepKind.PlayAudio:
                    if (step.Cue != null && m_audioChannel != null)
                    {
                        m_audioChannel.RaiseEvent(step.CueSource == null
                            ? new AudioCueRequest(step.Cue)
                            : new AudioCueRequest(step.Cue, step.CueSource.position));
                    }

                    break;

                case CueStepKind.PlayDialogue:
                    if (step.Conversation != null && m_dialogueChannel != null)
                    {
                        m_dialogueChannel.RaiseEvent(step.Conversation);
                    }

                    break;
            }
        }

        private void Reset()
        {
            Collider trigger = GetComponent<Collider>();

            if (trigger != null)
            {
                trigger.isTrigger = true;
            }
        }
    }
}
