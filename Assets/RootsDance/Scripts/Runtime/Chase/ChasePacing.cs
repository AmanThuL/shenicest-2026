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

        /// <summary>
        /// How far it may travel this frame.
        /// <para>
        /// While it is following the recorded route this is just speed by time. But the route only
        /// yields a point once it is longer than the gap being held, and at the start of a leg it
        /// is not: the trail hands back its oldest crumb, which is where the boss is already
        /// standing, and moving towards that is standing still — through the reveal and the first
        /// shoulder check, which is the whole chase as the player experiences it. Off the trail it
        /// aims at the player instead and this caps the step at the desired gap, so it closes to
        /// its mark and holds there rather than walking into them.
        /// </para>
        /// </summary>
        public static float StepDistance(
            float speed, float deltaTime, bool onTrail, float gapMeters, float desiredGapMeters)
        {
            float step = Mathf.Max(0f, speed) * Mathf.Max(0f, deltaTime);

            if (onTrail)
            {
                return step;
            }

            return Mathf.Min(step, Mathf.Max(0f, gapMeters - desiredGapMeters));
        }
    }
}
