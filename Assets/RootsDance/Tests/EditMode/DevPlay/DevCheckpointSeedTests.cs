using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Editor.DevPlay;
using RootsDance.Investigation;
using UnityEngine;
using UnityEngine.TestTools.Utils;

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
        public void BuildCommands_NightCheckpoint_SetsTimeOfDayFirst()
        {
            List<IWorldCommand> commands = DevCheckpointSeed.BuildCommands(
                new[] { WorldFlags.k_LeftStartArea },
                new[] { k_Soil },
                CheckpointTimeOfDay.Night);
            WorldState state = new WorldState();
            CommandQueue queue = new CommandQueue();

            foreach (IWorldCommand command in commands)
            {
                queue.Enqueue(command);
            }

            queue.Drain(state);

            Assert.IsInstanceOf<SetTimeOfDayCommand>(commands[0]);
            Assert.AreEqual(TimeOfDay.Night, state.TimeOfDay);
        }

        [Test]
        public void BuildCommands_LevelDefault_EmitsNoTimeOfDayCommand()
        {
            List<IWorldCommand> commands = DevCheckpointSeed.BuildCommands(
                new[] { WorldFlags.k_LeftStartArea },
                new ReportEntry[0],
                CheckpointTimeOfDay.LevelDefault);

            Assert.AreEqual(1, commands.Count);
            Assert.IsInstanceOf<RaiseFlagCommand>(commands[0]);
        }

        [Test]
        public void TryToRuntime_LevelDefault_ReturnsFalse()
        {
            TimeOfDay phase;

            Assert.IsFalse(DevCheckpointSeed.TryToRuntime(CheckpointTimeOfDay.LevelDefault, out phase));
        }

        [Test]
        public void ResolvePosition_GroundFound_StandsClearanceAboveGround()
        {
            Vector3 result = DevCheckpointSeed.ResolvePosition(new Vector3(3f, 99f, -7f), true, 4.2f, 1f);

            Assert.That(result, Is.EqualTo(new Vector3(3f, 5.2f, -7f))
                .Using(Vector3EqualityComparer.Instance));
        }

        [Test]
        public void ResolvePosition_NoGround_KeepsBasePosition()
        {
            Vector3 result = DevCheckpointSeed.ResolvePosition(new Vector3(3f, 6f, -7f), false, 0f, 1f);

            Assert.That(result, Is.EqualTo(new Vector3(3f, 6f, -7f))
                .Using(Vector3EqualityComparer.Instance));
        }

        [Test]
        public void ResolveBasePosition_AnchorHeightDisabled_KeepsFallbackHeight()
        {
            Vector3 result = DevCheckpointSeed.ResolveBasePosition(
                new Vector3(20.7f, 7.8f, 135.8f), true, new Vector3(21f, 20f, 136f), false);

            Assert.That(result, Is.EqualTo(new Vector3(21f, 7.8f, 136f))
                .Using(Vector3EqualityComparer.Instance));
        }

        [Test]
        public void ResolveBasePosition_AnchorHeightEnabled_UsesWholeAnchorPosition()
        {
            Vector3 anchorPosition = new Vector3(21f, 6f, 136f);
            Vector3 result = DevCheckpointSeed.ResolveBasePosition(
                new Vector3(20.7f, 7.8f, 135.8f), true, anchorPosition, true);

            Assert.That(result, Is.EqualTo(anchorPosition).Using(Vector3EqualityComparer.Instance));
        }

        [Test]
        public void ResolveBasePosition_AnchorMissing_UsesFallbackPosition()
        {
            Vector3 fallbackPosition = new Vector3(20.7f, 7.8f, 135.8f);
            Vector3 result = DevCheckpointSeed.ResolveBasePosition(
                fallbackPosition, false, new Vector3(21f, 20f, 136f), false);

            Assert.That(result, Is.EqualTo(fallbackPosition).Using(Vector3EqualityComparer.Instance));
        }

        [Test]
        public void Configure_FixedHeightCheckpoint_DisablesSnapAndAnchorHeight()
        {
            DevCheckpointSO checkpoint = ScriptableObject.CreateInstance<DevCheckpointSO>();

            try
            {
                checkpoint.Configure(
                    "Fixed height test", null, "FixedHeightAnchor",
                    new Vector3(20f, 7.8f, 135f), 32f, CheckpointTimeOfDay.Night,
                    new string[0], new InvestigationTargetSO[0], false, 1 << 8, 1f, false);

                Assert.IsFalse(checkpoint.SnapToGround);
                Assert.IsFalse(checkpoint.UseAnchorHeight);
                Assert.AreEqual(1 << 8, checkpoint.GroundLayers.value);
                Assert.AreEqual(7.8f, checkpoint.Position.y);
            }
            finally
            {
                Object.DestroyImmediate(checkpoint);
            }
        }
    }
}
