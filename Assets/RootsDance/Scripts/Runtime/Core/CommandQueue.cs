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

        public int PendingCount => m_pending.Count;

        public void Enqueue(IWorldCommand command)
        {
            if (command == null)
            {
                return;
            }

            m_pending.Enqueue(command);
        }

        public void Drain(WorldState state)
        {
            if (m_isDraining)
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
