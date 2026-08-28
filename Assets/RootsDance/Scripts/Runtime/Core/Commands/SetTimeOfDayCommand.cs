namespace RootsDance.Core.Commands
{
    /// <summary>
    /// Switches the world's discrete time of day. Not monotonic, unlike <see cref="RaiseFlagCommand"/>:
    /// the same command may set the value back and forth. <see cref="WorldState.SetTimeOfDay"/> ignores
    /// a value that is already current, so re-entering a trigger volume costs nothing.
    /// </summary>
    public sealed class SetTimeOfDayCommand : IWorldCommand
    {
        private readonly TimeOfDay m_value;

        public SetTimeOfDayCommand(TimeOfDay value)
        {
            m_value = value;
        }

        public void Execute(WorldState state)
        {
            state.SetTimeOfDay(m_value);
        }
    }
}
