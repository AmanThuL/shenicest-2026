using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Core.Commands;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// Pure translation of a checkpoint into world commands and a spawn position. No scene access:
    /// <see cref="DevPlaySession"/> gathers the inputs and applies the outputs.
    /// </summary>
    public static class DevCheckpointSeed
    {
        /// <summary>
        /// Flags first (in the given order), then report entries; the checkpoint's time of day is left
        /// alone. Kept so callers and tests that predate time of day still compile.
        /// </summary>
        public static List<IWorldCommand> BuildCommands(
            IReadOnlyList<string> flags, IReadOnlyList<ReportEntry> reportEntries)
        {
            return BuildCommands(flags, reportEntries, CheckpointTimeOfDay.LevelDefault);
        }

        /// <summary>
        /// Time of day first (so the lighting is already right when the flags land), then flags in the
        /// given order, then report entries. Blank flag ids are skipped;
        /// <see cref="CheckpointTimeOfDay.LevelDefault"/> emits no time-of-day command at all.
        /// </summary>
        public static List<IWorldCommand> BuildCommands(
            IReadOnlyList<string> flags, IReadOnlyList<ReportEntry> reportEntries, CheckpointTimeOfDay timeOfDay)
        {
            List<IWorldCommand> commands = new List<IWorldCommand>();
            TimeOfDay phase;
            bool hasTimeOfDay = TryToRuntime(timeOfDay, out phase);

            // One snapshot, not one event per flag: a checkpoint's flags are history, and history
            // must not replay dialogue, stingers or cinematics on the way in (WorldState.
            // RestoreSnapshot's own contract). Whatever needs the spawn to sound right catches up
            // through IRescueStateRestoredParticipant, the same as after a rescue.
            commands.Add(new RestoreSnapshotCommand(flags, reportEntries, hasTimeOfDay, phase));

            // The snapshot sets the phase silently; lighting still wants the change event.
            if (hasTimeOfDay)
            {
                commands.Add(new SetTimeOfDayCommand(phase));
            }

            return commands;
        }

        /// <summary>
        /// Maps the checkpoint enum onto the runtime one. False for
        /// <see cref="CheckpointTimeOfDay.LevelDefault"/> — there is no runtime phase that means
        /// "say nothing", which is exactly why the checkpoint enum is a separate type.
        /// </summary>
        public static bool TryToRuntime(CheckpointTimeOfDay value, out TimeOfDay phase)
        {
            switch (value)
            {
                case CheckpointTimeOfDay.Day:
                    phase = TimeOfDay.Day;
                    return true;
                case CheckpointTimeOfDay.Night:
                    phase = TimeOfDay.Night;
                    return true;
                default:
                    phase = TimeOfDay.Day;
                    return false;
            }
        }

        /// <summary>
        /// Where the Player root goes: the base X/Z, standing <paramref name="clearance"/> above the
        /// ground that was found under it — or the base position untouched when nothing was hit.
        /// </summary>
        public static Vector3 ResolvePosition(Vector3 basePosition, bool groundFound, float groundY, float clearance)
        {
            if (!groundFound)
            {
                return basePosition;
            }

            return new Vector3(basePosition.x, groundY + clearance, basePosition.z);
        }

        /// <summary>
        /// Resolves an optional scene anchor without forcing its height. Fixed-height checkpoints can
        /// follow an anchor's X/Z while retaining the safety-tested Y stored in their asset.
        /// </summary>
        public static Vector3 ResolveBasePosition(
            Vector3 fallbackPosition, bool anchorFound, Vector3 anchorPosition, bool useAnchorHeight)
        {
            if (!anchorFound)
            {
                return fallbackPosition;
            }

            if (useAnchorHeight)
            {
                return anchorPosition;
            }

            return new Vector3(anchorPosition.x, fallbackPosition.y, anchorPosition.z);
        }
    }
}
