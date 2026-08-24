using System;
using System.Threading;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Narrative
{
    /// <summary>
    /// Plays a radio sequence when its trigger flag is raised (node 00-03) and raises a finish flag
    /// afterwards. Listens to a channel asset rather than to the world state directly, so it does not
    /// care whether the bootstrap has arrived yet.
    /// </summary>
    public class RadioSequencePlayer : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("Flag channel pumped by GameBootstrap.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Flag id that starts this sequence.")]
        [SerializeField] private string m_startOnFlag = WorldFlags.k_RadioBriefingStarted;

        [Header("Broadcasts on")]
        [Tooltip("Line channel the radio HUD listens to.")]
        [SerializeField] private StringEventChannelSO m_lineShown;

        [Header("Content")]
        [SerializeField] private RadioSequenceSO m_sequence;

        [Tooltip("Flag raised once the last line finished.")]
        [SerializeField] private string m_flagOnFinished = WorldFlags.k_RadioBriefingFinished;

        private bool m_hasStarted;

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
            if (m_hasStarted || flagId != m_startOnFlag)
            {
                return;
            }

            m_hasStarted = true;
            PlayEntryAsync(destroyCancellationToken);
        }

        private async void PlayEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                await PlayAsync(cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Object destroyed or Play mode exited: nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private async Awaitable PlayAsync(CancellationToken cancellationToken)
        {
            if (m_sequence == null)
            {
                Log.Error("RadioSequencePlayer has no sequence assigned.", this);
                return;
            }

            await Awaitable.WaitForSecondsAsync(m_sequence.StartDelay, cancellationToken);

            RadioLine[] lines = m_sequence.Lines;

            for (int i = 0; i < lines.Length; i++)
            {
                if (m_lineShown != null)
                {
                    m_lineShown.RaiseEvent(lines[i].Text);
                }

                await Awaitable.WaitForSecondsAsync(lines[i].HoldSeconds, cancellationToken);
            }

            if (m_lineShown != null)
            {
                m_lineShown.RaiseEvent(string.Empty);
            }

            if (!string.IsNullOrEmpty(m_flagOnFinished))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(m_flagOnFinished), this);
            }
        }
    }
}
