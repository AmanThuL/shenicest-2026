using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// Puts a conversation into a scene: walking into a volume, a story flag going up, talking to
    /// something, or another component calling <see cref="Play"/>.
    /// <para>
    /// It raises a channel rather than holding the runner, because the runner lives with the player
    /// and this lives in a level scene — the same boundary the audio cues cross the same way.
    /// </para>
    /// </summary>
    public class DialogueTrigger : MonoBehaviour, IInteractable
    {
        /// <summary>What sets the conversation off.</summary>
        public enum Moment
        {
            /// <summary>Only when another component calls <see cref="Play"/>.</summary>
            Manual = 0,

            /// <summary>The player walks into the trigger collider on this object.</summary>
            OnPlayerEnter = 1,

            /// <summary>A world flag is raised.</summary>
            OnFlagRaised = 2,

            /// <summary>The player looks at this and presses interact.</summary>
            OnInteract = 3
        }

        [Header("What")]
        [SerializeField] private DialogueSO m_conversation;

        [Tooltip("Data/Events/DialogueRequested.")]
        [SerializeField] private DialogueEventChannelSO m_channel;

        [Header("When")]
        [SerializeField] private Moment m_playOn = Moment.OnPlayerEnter;

        [Tooltip("Only read for On Flag Raised.")]
        [SerializeField] private string m_flagId;

        [Tooltip("The bootstrap's FlagRaised channel. Only needed for On Flag Raised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Header("Interact")]
        [Tooltip("Prompt shown while this is focused. Only read for On Interact.")]
        [SerializeField] private string m_promptText = "[E] 交谈";

        [Tooltip("On: fires at most once, whatever the moment. The conversation asset has its own "
            + "plays-once switch; this one is about the trigger, not the writing.")]
        [SerializeField] private bool m_fireOnce = true;

        private bool m_hasFired;

        /// <inheritdoc />
        public string PromptText => m_promptText;

        /// <inheritdoc />
        public bool CanInteract => m_playOn == Moment.OnInteract && !(m_fireOnce && m_hasFired);

        private void OnEnable()
        {
            if (m_playOn == Moment.OnFlagRaised && m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
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

        /// <inheritdoc />
        public void Interact(GameObject interactor)
        {
            if (m_playOn == Moment.OnInteract)
            {
                Play();
            }
        }

        /// <summary>Asks for the conversation. Harmless with nothing wired, or when spent.</summary>
        public void Play()
        {
            if (m_conversation == null || m_channel == null || (m_fireOnce && m_hasFired))
            {
                return;
            }

            m_hasFired = true;
            m_channel.RaiseEvent(m_conversation);
        }

        private void OnFlagRaised(string flagId)
        {
            if (flagId == m_flagId)
            {
                Play();
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
