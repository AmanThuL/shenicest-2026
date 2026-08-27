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
        /// <summary>Flags first (in the given order), then report entries. Blank flag ids are skipped.</summary>
        public static List<IWorldCommand> BuildCommands(
            IReadOnlyList<string> flags, IReadOnlyList<ReportEntry> reportEntries)
        {
            List<IWorldCommand> commands = new List<IWorldCommand>();

            if (flags != null)
            {
                for (int i = 0; i < flags.Count; i++)
                {
                    if (!string.IsNullOrEmpty(flags[i]))
                    {
                        commands.Add(new RaiseFlagCommand(flags[i]));
                    }
                }
            }

            if (reportEntries != null)
            {
                for (int i = 0; i < reportEntries.Count; i++)
                {
                    commands.Add(new AddReportEntryCommand(reportEntries[i]));
                }
            }

            return commands;
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
    }
}
