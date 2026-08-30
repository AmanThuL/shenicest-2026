namespace RootsDance.Core.Commands
{
    /// <summary>Sets one exploration flag. Idempotent through <see cref="WorldState.RaiseFlag"/>.</summary>
    public sealed class RaiseFlagCommand : IWorldCommand
    {
        private readonly string m_flagId;

        public RaiseFlagCommand(string flagId)
        {
            m_flagId = flagId;
        }

        public void Execute(WorldState state)
        {
            state.RaiseFlag(m_flagId);
        }
    }
}
