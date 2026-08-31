namespace RootsDance.Core
{
    /// <summary>
    /// The one gate for exclusive player interactions. Every loop that takes the player's hands,
    /// eyes or cursor — a tool performance, the scanner read, a document, a wall terminal, the rune
    /// keypad — acquires this before starting and releases it when the player is back in control.
    /// One owner at a time, so two such loops can never run over each other.
    /// <para>
    /// Pure C#, no UnityEngine: the lock knows nothing about what an owner is, only that the same
    /// reference that acquired it must release it. <see cref="ForceRelease"/> exists for the
    /// bootstrap alone, which clears the gate whenever the player object is about to be rebuilt
    /// (level load, checkpoint rescue) so a destroyed owner can never wedge it shut.
    /// </para>
    /// </summary>
    public sealed class InteractionLock
    {
        private object m_owner;

        /// <summary>True while any interaction holds the gate.</summary>
        public bool IsLocked => m_owner != null;

        /// <summary>Whoever holds the gate right now, or null.</summary>
        public object Owner => m_owner;

        /// <summary>
        /// Takes the gate. Returns false when someone else holds it. Idempotent for the current
        /// owner: asking again while already holding it succeeds and changes nothing.
        /// </summary>
        public bool TryAcquire(object owner)
        {
            if (owner == null)
            {
                return false;
            }

            if (m_owner != null && !ReferenceEquals(m_owner, owner))
            {
                return false;
            }

            m_owner = owner;
            return true;
        }

        /// <summary>
        /// Opens the gate, but only for the owner that closed it. A stranger's release is a safe
        /// no-op, so teardown code may always call this without checking first. Returns whether
        /// the gate actually opened.
        /// </summary>
        public bool Release(object owner)
        {
            if (m_owner == null || !ReferenceEquals(m_owner, owner))
            {
                return false;
            }

            m_owner = null;
            return true;
        }

        /// <summary>
        /// Opens the gate no matter who holds it. Bootstrap-only: called when the player object is
        /// about to be rebuilt and no interaction can legitimately still be running.
        /// </summary>
        public void ForceRelease()
        {
            m_owner = null;
        }
    }
}
