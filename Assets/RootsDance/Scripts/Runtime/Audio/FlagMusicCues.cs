using System;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// Scores the chapter: one table of "when this flag is raised, the music becomes this",
    /// listening to the bootstrap's <c>FlagRaised</c> channel and asking the
    /// <see cref="MusicDirector"/> for the change.
    /// <para>
    /// Separate from <see cref="FlagAudioCues"/>, which sounds one-shots, because music is not one
    /// more sound: there is exactly one track at a time, it crossfades rather than overlaps, it is
    /// never positioned, and "nothing plays from here" is a real story beat that a one-shot table
    /// has no way to express. Keeping them apart also keeps each table readable — a row here is a
    /// scene change, a row there is a noise.
    /// </para>
    /// <para>
    /// The whole point is that gameplay still knows nothing about audio: a flag is raised for its
    /// own reasons, and what music that means is a row in this table. Rows are matched in order and
    /// the first hit wins, so two beats on one flag is a mistake the table shows rather than a
    /// double crossfade.
    /// </para>
    /// Lives on the bootstrap root, next to the director. Wired by
    /// <c>RootsDance/Audio/Wire Music</c>.
    /// </summary>
    public class FlagMusicCues : MonoBehaviour, IRescueStateRestoredParticipant
    {
        /// <summary>One row of the table.</summary>
        [Serializable]
        private struct Binding
        {
            [Tooltip("The flag id, exactly as RootsDance.Core.WorldFlags spells it.")]
            public string m_flagId;

            [Tooltip("The track this beat changes to. Leave empty for a beat that stops the music, "
                + "and tick the box below so an unfinished row cannot silence the game by accident.")]
            public AudioCueSO m_cue;

            [Tooltip("On: this beat plays nothing at all. Off with no cue: the row does nothing.")]
            public bool m_stopsMusic;
        }

        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel. Data/Events/FlagRaised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Header("Broadcasts on")]
        [Tooltip("Data/Events/MusicRequested. The MusicDirector crossfades to whatever arrives.")]
        [SerializeField] private AudioCueEventChannelSO m_musicRequested;

        [Header("Table")]
        [Tooltip("What plays from the moment the game starts — the menu track. Empty starts silent.")]
        [SerializeField] private AudioCueSO m_openingMusic;

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

        /// <summary>
        /// The opening track is asked for here rather than in <c>OnEnable</c> on purpose: the
        /// director subscribes to the channel in its own <c>OnEnable</c>, and two components on one
        /// object have no guaranteed order between them. By <c>Start</c> every listener exists, so
        /// the first request of the run cannot be the one that is dropped.
        /// </summary>
        private void Start()
        {
            if (m_openingMusic != null)
            {
                Request(m_openingMusic);
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (string.IsNullOrEmpty(flagId))
            {
                return;
            }

            for (int i = 0; i < m_bindings.Length; i++)
            {
                Binding binding = m_bindings[i];

                if (binding.m_flagId != flagId)
                {
                    continue;
                }

                if (binding.m_cue == null && !binding.m_stopsMusic)
                {
                    return;
                }

                Request(binding.m_cue);
                return;
            }
        }

        /// <summary>Resolve the final track without replaying every historical music transition.</summary>
        public void RestoreAfterRescue(RescueCheckpoint checkpoint)
        {
            AudioCueSO selected = m_openingMusic;

            for (int i = 0; i < checkpoint.Flags.Count; i++)
            {
                for (int j = 0; j < m_bindings.Length; j++)
                {
                    Binding binding = m_bindings[j];

                    if (binding.m_flagId != checkpoint.Flags[i])
                    {
                        continue;
                    }

                    if (binding.m_cue != null || binding.m_stopsMusic)
                    {
                        selected = binding.m_cue;
                    }

                    break;
                }
            }

            Request(selected);
        }

        /// <summary>A request carrying no cue is how the director is asked for silence.</summary>
        private void Request(AudioCueSO cue)
        {
            if (m_musicRequested == null)
            {
                return;
            }

            m_musicRequested.RaiseEvent(new AudioCueRequest(cue));
        }
    }
}
