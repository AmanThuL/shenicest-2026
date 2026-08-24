namespace RootsDance.Core.Commands
{
    /// <summary>Appends one entry to the official report. Idempotent by entry id.</summary>
    public sealed class AddReportEntryCommand : IWorldCommand
    {
        private readonly ReportEntry m_entry;

        public AddReportEntryCommand(ReportEntry entry)
        {
            m_entry = entry;
        }

        public void Execute(WorldState state)
        {
            state.AddReportEntry(m_entry);
        }
    }
}
