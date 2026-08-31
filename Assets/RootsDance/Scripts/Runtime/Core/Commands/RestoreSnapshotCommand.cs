using System.Collections.Generic;
using RootsDance.Data;
using UnityEngine;

namespace RootsDance.Core.Commands
{
    /// <summary>
    /// Seeds checkpoint progress the way the rescue flow does: the flags land as one
    /// <see cref="WorldState.RestoreSnapshot"/> rather than as one event per flag, so completed
    /// dialogue, sounds and cinematics are not replayed while seeding — a checkpoint says "this
    /// already happened", and a happened beat must not fire again. Components that need the
    /// spawn to sound and look right catch up through
    /// <see cref="IRescueStateRestoredParticipant"/>, exactly as they do after a rescue.
    /// <para>
    /// The participant callback receives a checkpoint that carries only the seeded flags — no
    /// level, no spawn data. Participants that want more than <c>Flags</c> have the world state
    /// itself to read.
    /// </para>
    /// </summary>
    public sealed class RestoreSnapshotCommand : IWorldCommand
    {
        private const string k_SeedId = "00000000000000000000000000000000";

        private readonly IReadOnlyList<string> m_flags;
        private readonly IReadOnlyList<ReportEntry> m_report;
        private readonly bool m_hasTimeOfDay;
        private readonly TimeOfDay m_timeOfDay;

        public RestoreSnapshotCommand(IReadOnlyList<string> flags, IReadOnlyList<ReportEntry> report,
            bool hasTimeOfDay, TimeOfDay timeOfDay)
        {
            m_flags = flags;
            m_report = report;
            m_hasTimeOfDay = hasTimeOfDay;
            m_timeOfDay = timeOfDay;
        }

        public void Execute(WorldState state)
        {
            state.RestoreSnapshot(m_flags, m_report, m_hasTimeOfDay, m_timeOfDay);

            RescueCheckpoint seeded = new RescueCheckpoint(
                k_SeedId, "Checkpoint seed", null, string.Empty, Vector3.zero, 0f,
                m_hasTimeOfDay, m_timeOfDay, m_flags, null);

            MonoBehaviour[] behaviours = Object.FindObjectsByType<MonoBehaviour>(
                FindObjectsInactive.Exclude, FindObjectsSortMode.None);

            for (int i = 0; i < behaviours.Length; i++)
            {
                if (behaviours[i] is IRescueStateRestoredParticipant participant)
                {
                    participant.RestoreAfterRescue(seeded);
                }
            }
        }
    }
}
