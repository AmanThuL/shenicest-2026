using UnityEngine;

namespace RootsDance.Cameras
{
    /// <summary>
    /// How much of the panic <em>run</em> cycle is playing, from how fast the player is actually
    /// moving. The chase design splits the effect in two: the footfall bob, sway, roll and pitch are
    /// locomotion — they exist because a body is running — while the 7 Hz jitter is the fear, and
    /// only the first half belongs to the feet.
    /// <para>
    /// Without this the whole layer rode on the panic envelope alone, so a player who stopped
    /// dead still had a camera bobbing at 2.9 footfalls per second: a head running on the spot.
    /// </para>
    /// <para>
    /// The ramp is smooth for the same reason the free-fall wind is: a threshold the player can
    /// feel switching is worse than either state on its own. Pure maths, EditMode-tested.
    /// </para>
    /// </summary>
    public static class PanicRunGate
    {
        /// <summary>
        /// 0 at or below <paramref name="onsetSpeed"/> — a walk is not a run and must not bob —
        /// 1 at or above <paramref name="fullStrideSpeed"/>, eased between. Degenerate or reversed
        /// bounds read as "not running".
        /// </summary>
        public static float StrideFactor(float horizontalSpeed, float fullStrideSpeed, float onsetSpeed)
        {
            if (fullStrideSpeed <= onsetSpeed)
            {
                return horizontalSpeed > onsetSpeed ? 1f : 0f;
            }

            float t = Mathf.InverseLerp(onsetSpeed, fullStrideSpeed, horizontalSpeed);

            // Mathf.SmoothStep(from, to, t) eases between from and to — with 0 and 1 that is the
            // usual smoothstep of t, not a threshold test.
            return Mathf.SmoothStep(0f, 1f, t);
        }
    }
}
