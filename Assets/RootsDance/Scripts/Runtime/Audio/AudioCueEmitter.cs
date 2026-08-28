using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// Puts a cue into a scene. The general-purpose way for a designer to make something audible
    /// without a programmer: drop this on an object, pick a cue, pick when it fires.
    /// <para>
    /// It raises a channel rather than playing anything itself, so the voice comes from the pooled
    /// director in the bootstrap scene and obeys the same voice cap as everything else.
    /// </para>
    /// </summary>
    public class AudioCueEmitter : MonoBehaviour
    {
        /// <summary>What makes this emitter fire.</summary>
        public enum Moment
        {
            /// <summary>Only when another component calls <see cref="Play"/>.</summary>
            Manual,

            /// <summary>Once, when the object becomes active.</summary>
            OnEnable,

            /// <summary>Every time the player walks into the trigger on this object.</summary>
            OnPlayerEnter
        }

        [Header("What")]
        [SerializeField] private AudioCueSO m_cue;

        [Tooltip("The channel the one-shot director listens to. Data/Events/AudioCueRequested.")]
        [SerializeField] private AudioCueEventChannelSO m_channel;

        [Header("When and where")]
        [SerializeField] private Moment m_playOn = Moment.Manual;

        [SerializeField] private AudioCuePlacement m_placement = AudioCuePlacement.AtPoint;

        [Tooltip("Optional: sound from here instead of this object. Useful when the trigger volume "
            + "is a room and the sound comes from one corner of it.")]
        [SerializeField] private Transform m_source;

        private void OnEnable()
        {
            if (m_playOn == Moment.OnEnable)
            {
                Play();
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

        /// <summary>Fires the cue now. Safe to call with nothing wired.</summary>
        public void Play()
        {
            if (m_cue == null || m_channel == null)
            {
                return;
            }

            Transform origin = m_source == null ? transform : m_source;

            switch (m_placement)
            {
                case AudioCuePlacement.Flat:
                    m_channel.RaiseEvent(new AudioCueRequest(m_cue));
                    break;

                case AudioCuePlacement.Following:
                    m_channel.RaiseEvent(new AudioCueRequest(m_cue, origin));
                    break;

                default:
                    m_channel.RaiseEvent(new AudioCueRequest(m_cue, origin.position));
                    break;
            }
        }
    }
}
