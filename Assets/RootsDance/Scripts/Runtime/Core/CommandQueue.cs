using System.Collections.Generic;

namespace RootsDance.Core
{
    /// <summary>
    /// Collects world-changing requests during a frame and applies them at one fixed point
    /// (<see cref="RootsDance.App.GameBootstrap"/>'s LateUpdate). Re-entrant calls are deferred to the
    /// next drain, so a command raised from inside a state-change handler cannot recurse.
    /// </summary>
    public sealed class CommandQueue
    {
        private readonly Queue<IWorldCommand> m_pending = new Queue<IWorldCommand>();
        private bool m_isDraining;
        private bool m_isDiscarding;

        public int PendingCount => m_pending.Count;

        public void Enqueue(IWorldCommand command)
        {
            if (command == null || m_isDiscarding)
            {
                return;
            }

            m_pending.Enqueue(command);
        }

        /// <summary>Discards pending and outgoing-scene teardown commands during a rescue reset.</summary>
        public void BeginReset()
        {
            m_isDiscarding = true;
            m_pending.Clear();
        }

        public void EndReset()
        {
            if (!m_isDiscarding)
            {
                return;
            }

            m_pending.Clear();
            m_isDiscarding = false;
        }

        public void Drain(WorldState state)
        {
            if (m_isDraining || m_isDiscarding)
            {
                // Commands raised from a handler wait for the next frame's drain.
                return;
            }

            m_isDraining = true;

            try
            {
                // Snapshot the count so commands queued during this drain run next frame instead.
                int budget = m_pending.Count;

                while (budget > 0 && m_pending.Count > 0)
                {
                    m_pending.Dequeue().Execute(state);
                    budget--;
                }
            }
            finally
            {
                m_isDraining = false;
            }
        }
    }
}
