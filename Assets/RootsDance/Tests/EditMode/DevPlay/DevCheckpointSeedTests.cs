using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Editor.DevPlay;
using UnityEngine;

namespace RootsDance.Tests.EditMode.DevPlay
{
    /// <summary>
    /// The seed logic is the only part of Dev Play that decides *what* a checkpoint means; the
    /// session code around it only moves a transform and enqueues. Keep the meaning pinned here.
    /// </summary>
    public class DevCheckpointSeedTests
    {
        private static readonly ReportEntry k_Soil =
            new ReportEntry(ReportCategory.EnvironmentSample, "SO-001", "土壤", "稳定");

        [Test]
        public void BuildCommands_FlagsAndEntries_LandInWorldStateAfterOneDrain()
        {
            List<IWorldCommand> commands = DevCheckpointSeed.BuildCommands(
                new[] { WorldFlags.k_LeftStartArea, WorldFlags.k_HelmetRemovable },
                new[] { k_Soil });
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();

            foreach (IWorldCommand command in commands)
            {
                queue.Enqueue(command);
            }

            queue.Drain(state);

            Assert.IsTrue(state.HasFlag(WorldFlags.k_LeftStartArea));
            Assert.IsTrue(state.HasFlag(WorldFlags.k_HelmetRemovable));
            Assert.IsTrue(state.HasReportEntry("SO-001"));
            Assert.AreEqual(0, queue.PendingCount);
        }

        [Test]
        public void BuildCommands_FlagsFirst_ThenEntries()
        {
            List<IWorldCommand> commands = DevCheckpointSeed.BuildCommands(
                new[] { WorldFlags.k_LeftStartArea },
                new[] { k_Soil });

            Assert.AreEqual(2, commands.Count);
            Assert.IsInstanceOf<RaiseFlagCommand>(commands[0]);
            Assert.IsInstanceOf<AddReportEntryCommand>(commands[1]);
        }

        [Test]
        public void BuildCommands_BlankFlag_IsSkipped()
        {
            List<IWorldCommand> commands = DevCheckpointSeed.BuildCommands(
                new[] { "", null, WorldFlags.k_HelmetRemoved },
                new ReportEntry[0]);

            Assert.AreEqual(1, commands.Count);
        }

        [Test]
        public void BuildCommands_NullInputs_GiveEmptyList()
        {
            Assert.AreEqual(0, DevCheckpointSeed.BuildCommands(null, null).Count);
        }

        [Test]
        public void ResolvePosition_GroundFound_StandsClearanceAboveGround()
        {
            Vector3 result = DevCheckpointSeed.ResolvePosition(new Vector3(3f, 99f, -7f), true, 4.2f, 1f);

            Assert.AreEqual(new Vector3(3f, 5.2f, -7f), result);
        }

        [Test]
        public void ResolvePosition_NoGround_KeepsBasePosition()
        {
            Vector3 result = DevCheckpointSeed.ResolvePosition(new Vector3(3f, 6f, -7f), false, 0f, 1f);

            Assert.AreEqual(new Vector3(3f, 6f, -7f), result);
        }
    }
}
