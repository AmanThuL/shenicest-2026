using System;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// Sounds the story beats. One table of "when this flag is raised, play this cue", listening to
    /// the bootstrap's <c>FlagRaised</c> channel.
    /// <para>
    /// This is the presentation contract's D20 in its plainest form: gameplay code raises flags for
    /// its own reasons and has no idea audio exists, and every story sound in the game is a row in
    /// an Inspector table rather than a call somewhere in a gameplay script. Flags are raised once,
    /// so these cues fire once, which is what a story beat wants.
    /// </para>
    /// </summary>
    public class FlagAudioCues : MonoBehaviour
    {
        /// <summary>One row of the table.</summary>
        [Serializable]
        private struct Binding
        {
            [Tooltip("The flag id, exactly as the TriggerVolume or RootsDance.Core.WorldFlags spells it.")]
            public string m_flagId;

            public AudioCueSO m_cue;

            [Tooltip("Flat for a story sting; At Point to sound from a place in the scene.")]
            public AudioCuePlacement m_placement;

            [Tooltip("Only read for At Point. Empty sounds from this object.")]
            public Transform m_source;
        }

        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel. Data/Events/FlagRaised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Header("Broadcasts on")]
        [SerializeField] private AudioCueEventChannelSO m_channel;

        [Header("Table")]
        [SerializeField] private Binding[] m_bindings = new Binding[0];

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (m_channel == null || string.IsNullOrEmpty(flagId))
            {
                return;
            }

            for (int i = 0; i < m_bindings.Length; i++)
            {
                Binding binding = m_bindings[i];

                if (binding.m_cue == null || binding.m_flagId != flagId)
                {
                    continue;
                }

                if (binding.m_placement == AudioCuePlacement.Flat)
                {
                    m_channel.RaiseEvent(new AudioCueRequest(binding.m_cue));
                    continue;
                }

                Transform origin = binding.m_source == null ? transform : binding.m_source;

                m_channel.RaiseEvent(binding.m_placement == AudioCuePlacement.Following
                    ? new AudioCueRequest(binding.m_cue, origin)
                    : new AudioCueRequest(binding.m_cue, origin.position));
            }
        }
    }
}
