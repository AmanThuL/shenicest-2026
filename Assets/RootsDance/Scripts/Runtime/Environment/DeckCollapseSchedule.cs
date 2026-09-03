using System;
using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// The shape of a staged collapse, as pure arithmetic so it can be tested: which chunk goes
    /// when. <see cref="GreenhouseStairCollapse"/> plays it.
    /// </summary>
    public static class DeckCollapseSchedule
    {
        /// <summary>
        /// Release order: farthest from the player first, nearest last, so the deck goes out from
        /// under the far side and comes for the player, who falls with the last of it. Horizontal
        /// distance only — the ring is flat, and sorting by height would send the spiral's lower
        /// treads first for no reason a player could read.
        /// </summary>
        public static int[] Order(IReadOnlyList<Vector3> positions, Vector3 origin)
        {
            if (positions == null)
            {
                throw new ArgumentNullException(nameof(positions));
            }

            int[] order = new int[positions.Count];
            float[] distance = new float[positions.Count];

            for (int i = 0; i < positions.Count; i++)
            {
                order[i] = i;
                Vector3 flat = positions[i] - origin;
                flat.y = 0f;
                distance[i] = flat.sqrMagnitude;
            }

            Array.Sort(order, (a, b) => distance[b].CompareTo(distance[a]));
            return order;
        }

        /// <summary>
        /// Seconds after the first break at which each release happens, in release order. The
        /// first is at zero; each gap is the previous one times <paramref name="decay"/>, never
        /// shorter than <paramref name="minInterval"/> — the pace builds until the last of the
        /// deck goes as one avalanche.
        /// </summary>
        public static float[] ReleaseTimes(int count, float firstInterval, float decay, float minInterval)
        {
            if (count < 0)
            {
                throw new ArgumentOutOfRangeException(nameof(count));
            }

            float[] times = new float[count];
            float interval = Mathf.Max(firstInterval, minInterval);
            float time = 0f;

            for (int i = 0; i < count; i++)
            {
                times[i] = time;
                time += interval;
                interval = Mathf.Max(minInterval, interval * Mathf.Clamp01(decay));
            }

            return times;
        }
    }
}
