namespace RootsDance.Core.Commands
{
    /// <summary>
    /// A level's default time of day: applies only while nothing else has chosen one this session.
    /// The environment scene enqueues this on its first frame, while a Dev Play checkpoint or a story
    /// trigger enqueues <see cref="SetTimeOfDayCommand"/>; whichever order the two drain in, the
    /// explicit choice wins and the default never overwrites it.
    /// </summary>
    public sealed class SeedTimeOfDayCommand : IWorldCommand
    {
        private readonly TimeOfDay m_value;

        public SeedTimeOfDayCommand(TimeOfDay value)
        {
            m_value = value;
        }

        public void Execute(WorldState state)
        {
            if (state.IsTimeOfDaySet)
            {
                return;
            }

            state.SetTimeOfDay(m_value);
        }
    }
}
