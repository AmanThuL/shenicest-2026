namespace RootsDance.Core
{
    /// <summary>
    /// A request to change the world state. Commands are queued, never executed inline, so that
    /// physics-step callbacks and Update-step input cannot interleave unpredictably.
    /// Every command must be safe to execute more than once.
    /// </summary>
    public interface IWorldCommand
    {
        void Execute(WorldState state);
    }
}
