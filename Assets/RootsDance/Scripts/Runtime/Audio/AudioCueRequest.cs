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
    /// </summary>
    public readonly struct AudioCueRequest
    {
        private readonly AudioCueSO m_cue;
        private readonly Vector3 m_position;
        private readonly Transform m_follow;
        private readonly bool m_isPositioned;

        /// <summary>Plays flat, wherever the listener is. For UI and narration.</summary>
        public AudioCueRequest(AudioCueSO cue)
        {
            m_cue = cue;
            m_position = Vector3.zero;
            m_follow = null;
            m_isPositioned = false;
        }

        /// <summary>Plays at a fixed point in the world.</summary>
        public AudioCueRequest(AudioCueSO cue, Vector3 position)
        {
            m_cue = cue;
            m_position = position;
            m_follow = null;
            m_isPositioned = true;
        }

        /// <summary>Plays at a moving object and keeps up with it while it sounds.</summary>
        public AudioCueRequest(AudioCueSO cue, Transform follow)
        {
            m_cue = cue;
            m_position = follow == null ? Vector3.zero : follow.position;
            m_follow = follow;
            m_isPositioned = follow != null;
        }

        public AudioCueSO Cue => m_cue;

        /// <summary>The moving object to track, or null for a fixed or flat cue.</summary>
        public Transform Follow => m_follow;

        /// <summary>False for a flat cue: the director leaves the voice on the listener.</summary>
        public bool IsPositioned => m_isPositioned;

        /// <summary>Where to put the voice now — the follow target's position if there is one.</summary>
        public Vector3 Position => m_follow == null ? m_position : m_follow.position;
    }
}
