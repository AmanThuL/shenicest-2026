using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// Gives the interface its voice: one flat cue, played whenever any of the listened channels
    /// raises. Point it at the string channels and the report channel that already drive the HUD —
    /// a monologue line arriving, a notice, an accepted report entry — and those events sound
    /// without a single line of gameplay code learning about audio.
    /// <para>
    /// String channels and the report channel are handled by one component on purpose. They are
    /// the same idea from the audio side ("the interface said something"), and splitting them
    /// would mean two components, two cue assets and two places to keep the mix consistent.
    /// </para>
    /// </summary>
    public class ChannelAudioCue : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("Text channels — Monologue, Notice, InvestigationResult, InteractionPrompt. An "
            + "empty string is a hide request and is ignored.")]
        [SerializeField] private StringEventChannelSO[] m_textChannels;

        [Tooltip("Optional: the official report's update channel, for the 报告已更新 sting.")]
        [SerializeField] private ReportUpdateEventChannelSO m_reportUpdated;

        [Tooltip("Optional: void channels, for anything that just happened.")]
        [SerializeField] private VoidEventChannelSO[] m_voidChannels;

        [Header("Broadcasts on")]
        [SerializeField] private AudioCueEventChannelSO m_channel;

        [Header("What")]
        [Tooltip("Played flat — these are interface sounds, they have no position in the world.")]
        [SerializeField] private AudioCueSO m_cue;

        private void OnEnable()
        {
            if (m_textChannels != null)
            {
                for (int i = 0; i < m_textChannels.Length; i++)
                {
                    if (m_textChannels[i] != null)
                    {
                        m_textChannels[i].EventRaised += OnTextRaised;
                    }
                }
            }

            if (m_voidChannels != null)
            {
                for (int i = 0; i < m_voidChannels.Length; i++)
                {
                    if (m_voidChannels[i] != null)
                    {
                        m_voidChannels[i].EventRaised += OnVoidRaised;
                    }
                }
            }

            if (m_reportUpdated != null)
            {
                m_reportUpdated.EventRaised += OnReportUpdated;
            }
        }

        private void OnDisable()
        {
            if (m_textChannels != null)
            {
                for (int i = 0; i < m_textChannels.Length; i++)
                {
                    if (m_textChannels[i] != null)
                    {
                        m_textChannels[i].EventRaised -= OnTextRaised;
                    }
                }
            }

            if (m_voidChannels != null)
            {
                for (int i = 0; i < m_voidChannels.Length; i++)
                {
                    if (m_voidChannels[i] != null)
                    {
                        m_voidChannels[i].EventRaised -= OnVoidRaised;
                    }
                }
            }

            if (m_reportUpdated != null)
            {
                m_reportUpdated.EventRaised -= OnReportUpdated;
            }
        }

        private void OnTextRaised(string text)
        {
            // An empty line is the agreed "hide the subtitle" signal, not something being said.
            if (!string.IsNullOrEmpty(text))
            {
                Fire();
            }
        }

        private void OnVoidRaised()
        {
            Fire();
        }

        private void OnReportUpdated(ReportUpdate update)
        {
            Fire();
        }

        private void Fire()
        {
            if (m_cue == null || m_channel == null)
            {
                return;
            }

            m_channel.RaiseEvent(new AudioCueRequest(m_cue));
        }
    }
}
