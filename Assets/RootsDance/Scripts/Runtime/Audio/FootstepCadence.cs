namespace RootsDance.Audio
{
    /// <summary>
    /// When the next footstep falls. Steps are counted by distance covered, not by a timer, so
    /// walking, sprinting and crouching all land a step every stride instead of needing a rate per
    /// speed. Pure arithmetic, testable without a player.
    /// </summary>
    public static class FootstepCadence
    {
        /// <summary>
        /// Never more than this many steps out of one call, however far the position jumped. A
        /// teleport, a checkpoint load or a very long frame would otherwise fire a burst of
        /// footsteps for ground the player never walked over.
        /// </summary>
        public const int k_MaxStepsPerCall = 2;

        /// <summary>
        /// Adds the distance covered to the running total and returns how many steps that completed,
        /// leaving the remainder in <paramref name="distanceSinceStep"/>.
        /// </summary>
        public static int Advance(ref float distanceSinceStep, float distanceTravelled, float strideLength)
        {
            if (strideLength <= 0f)
            {
                // Not configured. Silence is the right failure: a stride of zero would otherwise be
                // an unbounded number of steps per frame.
                distanceSinceStep = 0f;
                return 0;
            }

            if (distanceTravelled > 0f)
            {
                distanceSinceStep += distanceTravelled;
            }

            int steps = 0;

            while (distanceSinceStep >= strideLength && steps < k_MaxStepsPerCall)
            {
                distanceSinceStep -= strideLength;
                steps++;
            }

            if (distanceSinceStep >= strideLength)
            {
                // Capped: drop the backlog rather than paying it off over the following frames,
                // which would sound like footsteps continuing after the player has stopped.
                distanceSinceStep = 0f;
            }

            return steps;
        }
    }
}
