namespace RootsDance.Core
{
    /// <summary>Persistent Bootstrap services discard outgoing-level activity before a rescue reload.</summary>
    public interface IRescueResetParticipant
    {
        void ResetForRescue();
    }
}
