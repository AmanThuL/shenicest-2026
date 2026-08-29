using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// A looping bed that a story flag turns on and another turns off: the suit's breathing until
    /// the helmet comes off, the radio's carrier hiss until the signal is lost, the contamination
    /// zone's wind until the player is past it.
    /// <para>
    /// <see cref="AmbienceZone"/> answers "where the player is"; this answers "how far the story
    /// has got". The two are different questions — the breathing follows the helmet, not the room,
    /// and no trigger volume can express that — and keeping them in separate components means
    /// neither grows a mode switch.
    /// </para>
    /// <para>
    /// It reads the world state once in <c>Start</c> as well as listening to the flag channel, so
    /// that jumping straight to a dev checkpoint lands in the right acoustic state: a session that
    /// starts after the helmet is already off must not breathe.
    /// </para>
    /// </summary>
    [RequireComponent(typeof(AudioSource))]
    public class FlagAudioBed : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel. Data/Events/FlagRaised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Flag that fades this bed up. Empty starts it as soon as the object is enabled.")]
        [SerializeField] private string m_startOnFlag;

        [Tooltip("Flag that fades it back down for good. Empty leaves it running.")]
        [SerializeField] private string m_stopOnFlag;

        [Header("What")]
        [Tooltip("A looping cue. Its clip, mixer group and rolloff are copied onto this source.")]
        [SerializeField] private AudioCueSO m_cue;

        [Tooltip("Seconds to reach full volume, and to fall back to silence.")]
        [Min(0f)]
        [SerializeField] private float m_fadeSeconds = 1.5f;

        private AudioSource m_source;
        private float m_fullVolume = 1f;
        private float m_targetVolume;
        private bool m_hasStopped;

        private void Awake()
        {
            m_source = GetComponent<AudioSource>();
            m_source.playOnAwake = false;

            if (m_cue == null)
            {
                return;
            }

            m_cue.ApplyTo(m_source);
            m_fullVolume = m_source.volume;
            m_source.loop = true;
            m_source.volume = 0f;

            AudioClip[] clips = m_cue.Clips;

            if (clips != null && clips.Length > 0)
            {
                m_source.clip = clips[0];
            }
        }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void Start()
        {
            // After the bootstrap has had a frame to arrive, so a checkpoint's seeded flags count.
            IWorldStateReader state = WorldAccess.State;

            if (state != null && !string.IsNullOrEmpty(m_stopOnFlag) && state.HasFlag(m_stopOnFlag))
            {
                m_hasStopped = true;
                return;
            }

            bool alreadyStarted = string.IsNullOrEmpty(m_startOnFlag)
                || (state != null && state.HasFlag(m_startOnFlag));

            if (alreadyStarted)
            {
                Begin();
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }

            if (m_source != null)
            {
                m_source.Stop();
                m_source.volume = 0f;
            }

            m_targetVolume = 0f;
            m_hasStopped = false;
        }

        private void Update()
        {
            if (m_source == null)
            {
                return;
            }

            m_source.volume = AudioBedFade.Step(m_source.volume, m_targetVolume, m_fullVolume,
                Time.deltaTime, m_fadeSeconds);

            if (m_source.volume <= 0f && m_source.isPlaying && m_targetVolume <= 0f)
            {
                m_source.Stop();
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (string.IsNullOrEmpty(flagId))
            {
                return;
            }

            // Stop wins over start: a bed told to stop stays stopped even if its start flag is
            // raised again later, because the beat it belonged to is over.
            if (flagId == m_stopOnFlag)
            {
                m_hasStopped = true;
                m_targetVolume = 0f;
                return;
            }

            if (!m_hasStopped && flagId == m_startOnFlag)
            {
                Begin();
            }
        }

        private void Begin()
        {
            m_targetVolume = m_fullVolume;

            if (m_source != null && m_source.clip != null && !m_source.isPlaying)
            {
                m_source.Play();
            }
        }
    }
}
