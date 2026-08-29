using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Picks the nearest candidate within a radius. Shared so that every proximity offer in the
    /// game — picking a prop up, aiming the scanner — resolves a crowd the same way, and so the
    /// rule can be tested without a scene.
    /// </summary>
    public static class NearestInRange
    {
        /// <summary>
        /// Index of the closest point within <paramref name="range"/> of <paramref name="origin"/>,
        /// or -1 when nothing is in reach.
        /// </summary>
        /// <remarks>
        /// Compares squared distances, so nothing here takes a square root. Ties go to the earlier
        /// index: two props at exactly the same distance have to resolve to one of them, and
        /// picking the first keeps the choice stable frame to frame instead of flickering.
        /// </remarks>
        public static int Index(IReadOnlyList<Vector3> points, Vector3 origin, float range)
        {
            if (points == null || range <= 0f)
            {
                return -1;
            }

            // The reach limit and the running best are separate on purpose. Folding them into one
            // value makes the comparison do two jobs and it cannot do both: >= would reject a
            // candidate sitting exactly at the range limit, and > lets a tie overwrite the winner,
            // which flips the target between two equidistant props every frame.
            float limitSqr = range * range;
            float bestSqr = float.MaxValue;
            int best = -1;

            for (int i = 0; i < points.Count; i++)
            {
                float sqr = (points[i] - origin).sqrMagnitude;

                if (sqr > limitSqr || sqr >= bestSqr)
                {
                    continue;
                }

                bestSqr = sqr;
                best = i;
            }

            return best;
        }
    }
}
