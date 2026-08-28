using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Audio;

namespace RootsDance.Audio
{
    /// <summary>
    /// One sound the game can ask for, and everything about how it is played, in one asset under
    /// <c>Assets/RootsDance/Data/Audio/</c>.
    /// <para>
    /// This is the whole authoring surface for audio. Adding a sound to the game is importing a
    /// clip and filling in one of these — never writing a component, and never putting an
    /// <c>AudioSource</c> on a prop by hand. That is what keeps guideline 09's mixer rule true by
    /// construction: a cue cannot be played without naming the group it comes out of.
    /// </para>
    /// <para>
    /// A cue is deliberately not a sound *event*: it does not know when it happens. What triggers
    /// it is a channel asset the rest of the game already raises (a flag, a report update, a
    /// prompt), wired by the listeners in this folder. See the presentation contract's D20.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "AudioCue", menuName = "RootsDance/Audio/Cue")]
    [TypeInfoBox("One playable sound. Several clips make it a variation set — the same clip never "
        + "plays twice in a row. Looping cues belong to an Ambience Zone or the Music Director, "
        + "not to the one-shot pool.")]
    public class AudioCueSO : ScriptableObject
    {
        // ---- Clips ------------------------------------------------------------------------------
        [SerializeField, TitleGroup("Clips"), Required]
        [Tooltip("One clip, or several to vary between. Empty is a silent cue: wiring stays valid "
            + "while the audio is still being made.")]
        private AudioClip[] m_clips = new AudioClip[0];

        [SerializeField, TitleGroup("Clips"), Required]
        [Tooltip("Which mixer group this comes out of. Guideline 09: every source has one.")]
        private AudioMixerGroup m_outputGroup;

        // ---- Playback ---------------------------------------------------------------------------
        [SerializeField, TitleGroup("Playback"), Range(0f, 1f)]
        [Tooltip("Base volume before jitter. Mix here, not in the clip.")]
        private float m_volume = 1f;

        [SerializeField, TitleGroup("Playback"), Range(0f, 0.5f)]
        [Tooltip("How far the volume wanders either side of the base, 0 = never.")]
        private float m_volumeJitter;

        [SerializeField, TitleGroup("Playback"), Range(0.1f, 3f)]
        [Tooltip("Base pitch. Also stretches the clip, which is what the pool times a voice by.")]
        private float m_pitch = 1f;

        [SerializeField, TitleGroup("Playback"), Range(0f, 0.5f)]
        [Tooltip("How far the pitch wanders either side of the base. A little of this is what "
            + "stops repeated one-shots reading as one sample.")]
        private float m_pitchJitter = 0.05f;

        [SerializeField, TitleGroup("Playback")]
        [Tooltip("On: this is a bed, owned by an Ambience Zone or the Music Director. The one-shot "
            + "pool refuses looping cues — a pooled voice that never ends is a leaked voice.")]
        private bool m_loop;

        [SerializeField, TitleGroup("Playback"), Min(0f)]
        [Tooltip("Seconds before the same cue may sound again. Guards a trigger that fires every "
            + "frame; 0 lets every request through.")]
        private float m_cooldownSeconds;

        // ---- Space ------------------------------------------------------------------------------
        [SerializeField, TitleGroup("Space"), Range(0f, 1f)]
        [Tooltip("0 = flat, heard the same everywhere (UI, narration). 1 = fully positioned.")]
        private float m_spatialBlend = 1f;

        [SerializeField, TitleGroup("Space"), Min(0.01f)]
        [Tooltip("Inside this radius the cue is at full volume.")]
        private float m_minDistance = 1f;

        [SerializeField, TitleGroup("Space"), Min(0.02f)]
        [Tooltip("Beyond this it is inaudible. Keep interior cues tight — the greenhouse is one "
            + "room, and a 500 m default makes every source audible through every wall.")]
        private float m_maxDistance = 20f;

        [SerializeField, TitleGroup("Space")]
        [Tooltip("Logarithmic is physically right; Linear is easier to keep inside one room.")]
        private AudioRolloffMode m_rolloff = AudioRolloffMode.Linear;

        public AudioClip[] Clips => m_clips;
        public AudioMixerGroup OutputGroup => m_outputGroup;
        public bool Loop => m_loop;
        public float CooldownSeconds => m_cooldownSeconds;
        public float SpatialBlend => m_spatialBlend;
        public float MinDistance => m_minDistance;
        public float MaxDistance => m_maxDistance;
        public AudioRolloffMode Rolloff => m_rolloff;

        /// <summary>False while the clips have not been made yet; wiring is still valid.</summary>
        public bool HasClips => m_clips != null && m_clips.Length > 0;

        /// <summary>
        /// The next clip to play, avoiding an immediate repeat. <paramref name="lastIndex"/> is the
        /// caller's per-cue memory: the director keeps one per cue, so two objects playing the same
        /// cue share the variation history, which is what a listener hears anyway.
        /// </summary>
        public AudioClip PickClip(ref int lastIndex)
        {
            if (!HasClips)
            {
                lastIndex = AudioCuePicker.k_None;
                return null;
            }

            int index = AudioCuePicker.Next(m_clips.Length, lastIndex, Random.value);

            if (index == AudioCuePicker.k_None)
            {
                return null;
            }

            lastIndex = index;
            return m_clips[index];
        }

        public float PickVolume()
        {
            return Mathf.Clamp01(m_volume + Random.Range(-m_volumeJitter, m_volumeJitter));
        }

        public float PickPitch()
        {
            return Mathf.Max(0.01f, m_pitch + Random.Range(-m_pitchJitter, m_pitchJitter));
        }

        /// <summary>
        /// Copies everything but the clip onto a source. Used by the pool for one-shots and by the
        /// beds for their own long-lived sources, so both obey the same authored settings.
        /// </summary>
        public void ApplyTo(AudioSource source)
        {
            if (source == null)
            {
                return;
            }

            source.outputAudioMixerGroup = m_outputGroup;
            source.loop = m_loop;
            source.spatialBlend = m_spatialBlend;
            source.rolloffMode = m_rolloff;
            source.minDistance = m_minDistance;
            source.maxDistance = Mathf.Max(m_maxDistance, m_minDistance + 0.01f);
            source.volume = PickVolume();
            source.pitch = PickPitch();
        }

        private void OnValidate()
        {
            if (m_maxDistance <= m_minDistance)
            {
                m_maxDistance = m_minDistance + 0.01f;
            }
        }
    }
}
