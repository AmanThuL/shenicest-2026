using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// One looping bed — the corridor's hum, the greenhouse's leaves and water — that fades up while
    /// the player is inside a volume and back down when they leave.
    /// <para>
    /// A bed owns its own <c>AudioSource</c> instead of borrowing one from
    /// <see cref="AudioDirector"/>'s pool, because a pooled voice is retired when its clip ends and
    /// a loop never ends. It still takes its mixer group, volume and rolloff from an
    /// <see cref="AudioCueSO"/>, so beds and one-shots are mixed from the same assets.
    /// </para>
    /// <para>
    /// The fade is <see cref="AudioBedFade"/> in Update rather than a tween: it has to survive being
    /// interrupted half-way by the player stepping back over the threshold, which is the normal
    /// case at a doorway, and re-targeting a value is what a move-towards already does.
    /// </para>
    /// </summary>
    [RequireComponent(typeof(AudioSource))]
    public class AmbienceZone : MonoBehaviour
    {
        [Header("What")]
        [Tooltip("A looping cue. Its clip, mixer group and rolloff are copied onto this source.")]
        [SerializeField] private AudioCueSO m_cue;

        [Header("When")]
        [Tooltip("On: the bed plays for the whole scene. Off: it needs a trigger collider on this "
            + "object and follows the player in and out of it.")]
        [SerializeField] private bool m_alwaysOn;

        [Tooltip("Seconds to reach full volume, and to fall back to silence.")]
        [Min(0f)]
        [SerializeField] private float m_fadeSeconds = 1.5f;

        private AudioSource m_source;
        private float m_targetVolume;
        private float m_fullVolume = 1f;
        private int m_occupants;

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
            m_occupants = 0;
            m_targetVolume = m_alwaysOn ? m_fullVolume : 0f;

            if (m_alwaysOn)
            {
                StartIfNeeded();
            }
        }

        private void OnDisable()
        {
            if (m_source != null)
            {
                m_source.Stop();
                m_source.volume = 0f;
            }
        }

        private void Update()
        {
            if (m_source == null)
            {
                return;
            }

            m_source.volume = AudioBedFade.Step(m_source.volume, m_targetVolume, m_fullVolume,
                Time.deltaTime, m_fadeSeconds);

            // Silence costs nothing to leave running, but a bed that is out of earshot for a whole
            // level should not hold a voice; stopping it also resets the loop for the next entry.
            if (m_source.volume <= 0f && m_source.isPlaying && !m_alwaysOn)
            {
                m_source.Stop();
            }
        }

        private void OnTriggerEnter(Collider other)
        {
            if (m_alwaysOn || other.GetComponentInParent<PlayerTriggerProbe>() == null)
            {
                return;
            }

            m_occupants++;
            m_targetVolume = m_fullVolume;
            StartIfNeeded();
        }

        private void OnTriggerExit(Collider other)
        {
            if (m_alwaysOn || other.GetComponentInParent<PlayerTriggerProbe>() == null)
            {
                return;
            }

            m_occupants = Mathf.Max(0, m_occupants - 1);

            if (m_occupants == 0)
            {
                m_targetVolume = 0f;
            }
        }

        private void StartIfNeeded()
        {
            if (m_source != null && m_source.clip != null && !m_source.isPlaying)
            {
                m_source.Play();
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
