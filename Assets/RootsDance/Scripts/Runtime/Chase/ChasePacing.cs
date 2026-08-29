using UnityEngine;

namespace RootsDance.Chase
{
    /// <summary>
    /// The rubber band that keeps the chase theatrical. The boss is not trying to win: it holds a
    /// desired gap behind the player — faster when it falls behind, slower when it gets close — so
    /// every shoulder check finds it exactly where a chase reads best. Pure maths, EditMode-tested.
    /// </summary>
    public static class ChasePacing
    {
        /// <summary>
        /// Speed for the current gap: the base speed at the desired gap, more per metre of deficit,
        /// less per metre of excess, never negative and never above <paramref name="maxSpeed"/>.
        /// </summary>
        public static float SpeedForGap(
            float gapMeters, float desiredGapMeters, float baseSpeed, float catchupPerMeter, float maxSpeed)
        {
            float speed = baseSpeed + (gapMeters - desiredGapMeters) * catchupPerMeter;
            return Mathf.Clamp(speed, 0f, Mathf.Max(0f, maxSpeed));
        }
    }
}
