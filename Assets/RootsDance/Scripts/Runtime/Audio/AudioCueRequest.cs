using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// "Play this, there." The payload of <see cref="AudioCueEventChannelSO"/>.
    /// <para>
    /// Position travels with the request rather than being read off the sender, because the sender
    /// is often not where the sound is: a trigger volume spans a room, and a flag has no position
    /// at all. A struct keeps the channel allocation-free, so a cue may be raised per footstep.
    /// </para>
    /// <para>
    /// A request may also carry its own clip, in which case the cue supplies only the settings —
    /// mixer group, volume, spatial blend. That is how spoken lines are played: a radio
    /// transmission or a conversation has one clip per line, and one cue asset per line would mean
    /// a folder of hundreds of assets that differ in nothing but the file they point at. The line
    /// holds the clip, the cue holds the mix, and the director still routes every voice through
    /// the same pool and the same group.
    /// </para>
    /// </summary>
    public readonly struct AudioCueRequest
    {
        private readonly AudioCueSO m_cue;
        private readonly AudioClip m_clipOverride;
        private readonly Vector3 m_position;
        private readonly Transform m_follow;
        private readonly bool m_isPositioned;

        private AudioCueRequest(AudioCueSO cue, AudioClip clipOverride, Vector3 position,
            Transform follow, bool isPositioned)
        {
            m_cue = cue;
            m_clipOverride = clipOverride;
            m_position = position;
            m_follow = follow;
            m_isPositioned = isPositioned;
        }

        /// <summary>Plays flat, wherever the listener is. For UI and narration.</summary>
        public AudioCueRequest(AudioCueSO cue)
            : this(cue, null, Vector3.zero, null, false)
        {
        }

        /// <summary>Plays at a fixed point in the world.</summary>
        public AudioCueRequest(AudioCueSO cue, Vector3 position)
            : this(cue, null, position, null, true)
        {
        }

        /// <summary>Plays at a moving object and keeps up with it while it sounds.</summary>
        public AudioCueRequest(AudioCueSO cue, Transform follow)
            : this(cue, null, follow == null ? Vector3.zero : follow.position, follow, follow != null)
        {
        }

        /// <summary>
        /// One spoken line: <paramref name="clip"/> is the recording, <paramref name="cue"/> is how
        /// it is mixed. Flat, because a radio in the helmet and a line of inner monologue are not
        /// anywhere in the world.
        /// </summary>
        public static AudioCueRequest Voice(AudioCueSO cue, AudioClip clip)
        {
            return new AudioCueRequest(cue, clip, Vector3.zero, null, false);
        }

        /// <summary>The same, but sounding from a speaker that is somewhere — an NPC, a terminal.</summary>
        public static AudioCueRequest Voice(AudioCueSO cue, AudioClip clip, Transform follow)
        {
            return new AudioCueRequest(cue, clip,
                follow == null ? Vector3.zero : follow.position, follow, follow != null);
        }

        public AudioCueSO Cue => m_cue;

        /// <summary>The clip to play instead of one of the cue's own, or null to use the cue's.</summary>
        public AudioClip ClipOverride => m_clipOverride;

        /// <summary>The moving object to track, or null for a fixed or flat cue.</summary>
        public Transform Follow => m_follow;

        /// <summary>False for a flat cue: the director leaves the voice on the listener.</summary>
        public bool IsPositioned => m_isPositioned;

        /// <summary>Where to put the voice now — the follow target's position if there is one.</summary>
        public Vector3 Position => m_follow == null ? m_position : m_follow.position;
    }
}
