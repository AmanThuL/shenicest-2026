using RootsDance.Data;

namespace RootsDance.Core
{
    /// <summary>Reconciles persistent state once, without replaying historical flag events.</summary>
    public interface IRescueStateRestoredParticipant
    {
        void RestoreAfterRescue(RescueCheckpoint checkpoint);
    }
}
