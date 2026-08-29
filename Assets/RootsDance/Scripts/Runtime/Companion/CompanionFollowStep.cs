using UnityEngine;

namespace RootsDance.Companion
{
    /// <summary>
    /// Where a trailing companion wants to be, as arithmetic over two positions. Split out of
    /// <see cref="FollowCompanion"/> so the two properties that actually decide whether the
    /// following reads well can be tested rather than eyeballed in Play mode:
    /// <b>she never crowds the player, and she never orbits them</b>.
    /// <para>
    /// The naive follow — stand a fixed distance behind the player's <em>forward</em> — fails the
    /// second one: turning on the spot drags the companion in a circle around the player, which
    /// nothing alive does. Holding a ring around the player's <em>position</em> instead means a
    /// player who turns around is simply looking at her, and only a player who walks makes her
    /// move.
    /// </para>
    /// </summary>
    public static class CompanionFollowStep
    {
        /// <summary>
        /// Where she appears when the meeting starts: behind the player, on the horizontal plane,
        /// far enough back to be in frame rather than in the lens once the view turns.
        /// </summary>
        public static Vector3 AppearPosition(Vector3 playerPosition, Vector3 playerForward,
            float standoff)
        {
            Vector3 back = Flatten(-playerForward);

            if (back.sqrMagnitude < 0.0001f)
            {
                back = Vector3.back;
            }

            return playerPosition + back.normalized * Mathf.Max(0f, standoff);
        }

        /// <summary>
        /// Where she wants to stand this frame. Inside <paramref name="followDistance"/> she has
        /// nowhere to go and holds still — this is what stops her shuffling into the player's back
        /// while they stand and read something. Outside it she closes to the ring, along the line
        /// she is already on, so the approach never swings sideways.
        /// </summary>
        public static Vector3 DesiredPosition(Vector3 playerPosition, Vector3 companionPosition,
            float followDistance)
        {
            followDistance = Mathf.Max(0f, followDistance);

            Vector3 toCompanion = Flatten(companionPosition - playerPosition);
            float distance = toCompanion.magnitude;

            if (distance <= followDistance)
            {
                return companionPosition;
            }

            // Degenerate only if she is exactly on top of the player, which the branch above
            // already covers for any sane follow distance; kept so a 0 distance cannot NaN.
            Vector3 direction = distance > 0.0001f ? toCompanion / distance : Vector3.back;

            return new Vector3(
                playerPosition.x + direction.x * followDistance,
                companionPosition.y,
                playerPosition.z + direction.z * followDistance);
        }

        /// <summary>
        /// True when she has been left so far behind that walking back is worse than cutting: a
        /// door closed between them, a level loaded under her, a player who sprinted a corridor
        /// she was never going to keep up with. Zero turns the cut off.
        /// </summary>
        public static bool ShouldCut(Vector3 playerPosition, Vector3 companionPosition, float leash)
        {
            if (leash <= 0f)
            {
                return false;
            }

            return Flatten(companionPosition - playerPosition).sqrMagnitude > leash * leash;
        }

        private static Vector3 Flatten(Vector3 value)
        {
            value.y = 0f;
            return value;
        }
    }
}
