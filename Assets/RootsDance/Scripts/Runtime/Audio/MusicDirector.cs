using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// Holds the one piece of music that is playing and crossfades to the next one. Lives on the
    /// bootstrap root so a track survives an additive level load.
    /// <para>
    /// Two sources rather than one: a cut between tracks is audible as a click, and fading one
    /// source down and up cannot overlap the tail of the outgoing track with the head of the
    /// incoming one. The pair is created here rather than serialized so the prefab cannot be
    /// half-wired.
    /// </para>
    /// A request carrying no cue is a stop, which is how the ending's silence is asked for.
    /// </summary>
    public class MusicDirector : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("Data/Events/MusicRequested. A request with no cue fades the current track out.")]
        [SerializeField] private AudioCueEventChannelSO m_musicRequested;

        [Header("Motion")]
        [Min(0f)]
        [Tooltip("Seconds of overlap between the outgoing and incoming track.")]
        [SerializeField] private float m_crossfadeSeconds = 2f;

        private AudioSource m_current;
        private AudioSource m_previous;
        private float m_currentTarget;
        private AudioCueSO m_playing;

        /// <summary>The cue that is playing, or null. Lets a caller avoid restarting a track.</summary>
        public AudioCueSO Playing => m_playing;

        private void Awake()
        {
            m_current = CreateSource("MusicA");
            m_previous = CreateSource("MusicB");
        }

        private void OnEnable()
        {
            if (m_musicRequested != null)
            {
                m_musicRequested.EventRaised += OnMusicRequested;
            }
        }

        private void OnDisable()
        {
            if (m_musicRequested != null)
            {
                m_musicRequested.EventRaised -= OnMusicRequested;
            }
        }

        private void Update()
        {
            float step = m_crossfadeSeconds <= 0f ? 1f : Time.deltaTime / m_crossfadeSeconds;

            m_current.volume = Mathf.MoveTowards(m_current.volume, m_currentTarget, step);
            m_previous.volume = Mathf.MoveTowards(m_previous.volume, 0f, step);

            if (m_previous.volume <= 0f && m_previous.isPlaying)
            {
                m_previous.Stop();
                m_previous.clip = null;
            }
        }

        /// <summary>Crossfades to <paramref name="cue"/>. The same cue twice is ignored.</summary>
        public void Play(AudioCueSO cue)
        {
            if (cue == null)
            {
                Stop();
                return;
            }

            if (cue == m_playing && m_current.isPlaying)
            {
                return;
            }

            AudioClip[] clips = cue.Clips;

            if (clips == null || clips.Length == 0)
            {
                return;
            }

            // The outgoing track keeps sounding on the other source while it fades.
            AudioSource incoming = m_previous;
            m_previous = m_current;
            m_current = incoming;

            cue.ApplyTo(m_current);
            m_current.loop = true;
            m_current.spatialBlend = 0f;
            m_currentTarget = m_current.volume;
            m_current.volume = 0f;
            m_current.clip = clips[0];
            m_current.Play();

            m_playing = cue;
        }

        /// <summary>Fades the current track out and plays nothing after it.</summary>
        public void Stop()
        {
            m_currentTarget = 0f;
            m_playing = null;
        }

        private void OnMusicRequested(AudioCueRequest request)
        {
            Play(request.Cue);
        }

        private AudioSource CreateSource(string sourceName)
        {
            GameObject holder = new GameObject(sourceName);
            holder.transform.SetParent(transform, worldPositionStays: false);

            AudioSource source = holder.AddComponent<AudioSource>();
            source.playOnAwake = false;
            source.loop = true;
            source.spatialBlend = 0f;
            source.volume = 0f;

            return source;
        }
    }
}
