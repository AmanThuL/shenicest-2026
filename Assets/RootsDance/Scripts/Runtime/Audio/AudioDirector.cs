using System.Collections.Generic;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.Pool;

namespace RootsDance.Audio
{
    /// <summary>
    /// The one place a one-shot is actually played. Lives on the bootstrap root beside the world
    /// state, listens to <see cref="AudioCueEventChannelSO"/> assets, and hands each request a
    /// pooled <c>AudioSource</c>.
    /// <para>
    /// Pooling is not premature here: guideline 05 forbids per-frame allocation, and the obvious
    /// alternative — <c>AudioSource.PlayClipAtPoint</c> — creates and destroys a GameObject per
    /// sound, which is exactly the garbage the rule is about. It also cannot route to a mixer
    /// group, so it would break guideline 09's mixer rule on every call.
    /// </para>
    /// <para>
    /// A voice is retired on a computed end time rather than by polling <c>isPlaying</c>. Both work,
    /// but the clock has no edge case on the frame a voice starts, and it costs one comparison
    /// instead of a call into the audio thread per voice per frame.
    /// </para>
    /// </summary>
    public class AudioDirector : MonoBehaviour, IRescueResetParticipant
    {
        /// <summary>A cue's memory between plays: what it played last, and when.</summary>
        private struct CueState
        {
            public int m_lastClipIndex;
            public float m_lastPlayTime;
        }

        /// <summary>A pooled source that is currently sounding.</summary>
        private struct ActiveVoice
        {
            public AudioSource m_source;
            public Transform m_follow;
            public float m_endTime;
        }

        [Header("Listens to")]
        [Tooltip("Every channel whose requests this director answers. Music has its own director.")]
        [SerializeField] private AudioCueEventChannelSO[] m_channels;

        [Header("Voices")]
        [Tooltip("How many one-shots may sound at once. Past this, new requests are dropped rather "
            + "than stealing an audible voice — a dropped footstep is cheaper than a cut one.")]
        [Min(1)]
        [SerializeField] private int m_maxVoices = 24;

        [Tooltip("Sources kept warm in the pool. Beyond this the pool lets extras go to the GC.")]
        [Min(1)]
        [SerializeField] private int m_pooledVoices = 12;

        [Tooltip("Seconds added to every voice's computed lifetime so a clip is never cut at its "
            + "own tail by a rounding difference between this clock and the audio thread's.")]
        [SerializeField] private float m_releaseMargin = 0.1f;

        private readonly Dictionary<AudioCueSO, CueState> m_cueStates = new Dictionary<AudioCueSO, CueState>();
        private readonly List<ActiveVoice> m_active = new List<ActiveVoice>();
        private ObjectPool<AudioSource> m_pool;

        private void Awake()
        {
            m_pool = new ObjectPool<AudioSource>(
                CreateVoice,
                OnVoiceTaken,
                OnVoiceReturned,
                OnVoiceDestroyed,
                collectionCheck: true,
                defaultCapacity: m_pooledVoices,
                maxSize: m_pooledVoices);
        }

        private void OnEnable()
        {
            if (m_channels == null)
            {
                return;
            }

            for (int i = 0; i < m_channels.Length; i++)
            {
                if (m_channels[i] != null)
                {
                    m_channels[i].EventRaised += OnCueRequested;
                }
            }
        }

        private void OnDisable()
        {
            if (m_channels != null)
            {
                for (int i = 0; i < m_channels.Length; i++)
                {
                    if (m_channels[i] != null)
                    {
                        m_channels[i].EventRaised -= OnCueRequested;
                    }
                }
            }

            StopAll();
        }

        private void Update()
        {
            float now = Time.time;

            // Backwards: releasing a voice removes it from the list.
            for (int i = m_active.Count - 1; i >= 0; i--)
            {
                ActiveVoice voice = m_active[i];

                if (now >= voice.m_endTime || voice.m_source == null)
                {
                    m_active.RemoveAt(i);

                    if (voice.m_source != null)
                    {
                        m_pool.Release(voice.m_source);
                    }

                    continue;
                }

                if (voice.m_follow != null)
                {
                    voice.m_source.transform.position = voice.m_follow.position;
                }
            }
        }

        /// <summary>
        /// Plays a request now. Public so a component holding a direct reference can call it, but
        /// the normal path is a channel — see <see cref="AudioCueEventChannelSO"/>.
        /// </summary>
        public void Play(AudioCueRequest request)
        {
            OnCueRequested(request);
        }

        /// <summary>Silences every one-shot at once, for a scene change or a cutscene.</summary>
        public void StopAll()
        {
            for (int i = m_active.Count - 1; i >= 0; i--)
            {
                AudioSource source = m_active[i].m_source;

                if (source != null)
                {
                    source.Stop();
                    m_pool.Release(source);
                }
            }

            m_active.Clear();
        }

        /// <summary>Old voices and cue cooldowns belong to the discarded playthrough.</summary>
        public void ResetForRescue()
        {
            StopAll();
            m_cueStates.Clear();
        }

        private void OnCueRequested(AudioCueRequest request)
        {
            AudioCueSO cue = request.Cue;

            if (cue == null)
            {
                return;
            }

            if (cue.Loop)
            {
                Log.Warning($"Audio cue '{cue.name}' loops, so it cannot be a one-shot. Put it on an "
                    + "AmbienceZone or the MusicDirector instead.", cue);
                return;
            }

            AudioClip requested = request.ClipOverride;

            // Not an error: wiring is authored before the clips exist, and a silent cue is how a
            // scene stays playable in the meantime. A request carrying its own clip is exempt: a
            // voice cue holds the mix for spoken lines and never holds the recordings themselves.
            if (requested == null && !cue.HasClips)
            {
                return;
            }

            CueState state;
            m_cueStates.TryGetValue(cue, out state);

            float now = Time.time;

            if (cue.CooldownSeconds > 0f && state.m_lastPlayTime > 0f
                && now - state.m_lastPlayTime < cue.CooldownSeconds)
            {
                return;
            }

            if (m_active.Count >= m_maxVoices)
            {
                return;
            }

            AudioClip clip = requested;

            if (clip == null)
            {
                int lastIndex = state.m_lastPlayTime > 0f ? state.m_lastClipIndex : AudioCuePicker.k_None;
                clip = cue.PickClip(ref lastIndex);
                state.m_lastClipIndex = lastIndex;
            }

            if (clip == null)
            {
                return;
            }

            state.m_lastPlayTime = now;
            m_cueStates[cue] = state;

            AudioSource source = m_pool.Get();
            cue.ApplyTo(source);
            source.clip = clip;
            source.transform.position = request.IsPositioned ? request.Position : transform.position;
            source.Play();

            m_active.Add(new ActiveVoice
            {
                m_source = source,
                m_follow = request.Follow,
                m_endTime = now + clip.length / Mathf.Max(0.01f, source.pitch) + m_releaseMargin
            });
        }

        private AudioSource CreateVoice()
        {
            GameObject voice = new GameObject("AudioVoice");
            voice.transform.SetParent(transform, worldPositionStays: false);

            AudioSource source = voice.AddComponent<AudioSource>();
            source.playOnAwake = false;

            return source;
        }

        private static void OnVoiceTaken(AudioSource source)
        {
            source.gameObject.SetActive(true);
        }

        private static void OnVoiceReturned(AudioSource source)
        {
            source.Stop();
            source.clip = null;
            source.outputAudioMixerGroup = null;
            source.gameObject.SetActive(false);
        }

        private static void OnVoiceDestroyed(AudioSource source)
        {
            if (source != null)
            {
                Destroy(source.gameObject);
            }
        }
    }
}
