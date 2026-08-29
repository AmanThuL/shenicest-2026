using UnityEngine;

namespace RootsDance.Cameras
{
    /// <summary>
    /// The shapes of a first-person fall, as pure functions of time and speed so EditMode tests
    /// can hold them. Three beats: the stomach lift when the ground goes away (a transient — it
    /// rises fast and is gone within a second, exactly like the real sensation), the wind that
    /// grows with fall speed (this is what says "still falling" once the lift has faded), and the
    /// landing dip (sharp down, eased recovery — an impact is instant, standing back up is not).
    /// </summary>
    public static class FreeFallResponse
    {
        /// <summary>
        /// The weightless lift, 0..1: smoothsteps up over <paramref name="riseSeconds"/>, then back
        /// down over <paramref name="decaySeconds"/>. Zero before the fall starts and once the body
        /// has caught up with the drop. Non-positive durations are treated as instant.
        /// </summary>
        public static float Lift01(float airSeconds, float riseSeconds, float decaySeconds)
        {
            if (airSeconds <= 0f)
            {
                return 0f;
            }

            if (riseSeconds <= 0f)
            {
                riseSeconds = 0f;
            }

            if (airSeconds < riseSeconds)
            {
                return Mathf.SmoothStep(0f, 1f, airSeconds / riseSeconds);
            }

            if (decaySeconds <= 0f)
            {
                return 0f;
            }

            return 1f - Mathf.SmoothStep(0f, 1f, (airSeconds - riseSeconds) / decaySeconds);
        }

        /// <summary>
        /// How hard the air reads, 0..1 between the two speeds. Smoothstepped: the transition from
        /// "stepped off a kerb" to "falling" should not have a visible switch-on point.
        /// A degenerate range (max at or below min) snaps at the threshold instead of dividing by zero.
        /// </summary>
        public static float Wind01(float fallSpeed, float minSpeed, float maxSpeed)
        {
            if (maxSpeed <= minSpeed)
            {
                return fallSpeed >= minSpeed ? 1f : 0f;
            }

            return Mathf.SmoothStep(0f, 1f, Mathf.InverseLerp(minSpeed, maxSpeed, fallSpeed));
        }

        /// <summary>
        /// The landing dip, 0..1 over <paramref name="durationSeconds"/>: full depth a fifth of the
        /// way in, then an eased recovery. The knees give way faster than they straighten — a
        /// symmetric dip reads as a camera bounce, not a body landing. Zero outside the window.
        /// </summary>
        public static float LandingDip01(float sinceLandingSeconds, float durationSeconds)
        {
            if (durationSeconds <= 0f || sinceLandingSeconds < 0f || sinceLandingSeconds >= durationSeconds)
            {
                return 0f;
            }

            float peakTime = durationSeconds * 0.2f;

            if (sinceLandingSeconds < peakTime)
            {
                return Mathf.SmoothStep(0f, 1f, sinceLandingSeconds / peakTime);
            }

            return 1f - Mathf.SmoothStep(0f, 1f, (sinceLandingSeconds - peakTime) / (durationSeconds - peakTime));
        }

        /// <summary>
        /// How hard the landing is, 0..1 between the two impact speeds. Below the minimum a step
        /// off a kerb costs nothing; above the maximum the dip is already at full depth.
        /// </summary>
        public static float Impact01(float impactSpeed, float minSpeed, float maxSpeed)
        {
            if (maxSpeed <= minSpeed)
            {
                return impactSpeed >= minSpeed ? 1f : 0f;
            }

            return Mathf.Clamp01(Mathf.InverseLerp(minSpeed, maxSpeed, impactSpeed));
        }
    }
}
