using UnityEngine;

namespace RootsDance.Cameras
{
    /// <summary>
    /// The shape of one look-behind: turn out, hold, turn back. Pure arithmetic over elapsed time,
    /// so the one property that actually matters can be tested rather than eyeballed —
    /// <b>how long the view is close enough to fully turned for the player to read what is there</b>.
    /// <para>
    /// The failure this exists to prevent is a look back that is over before anything registers.
    /// Recognising that something is present takes on the order of 100 ms; finding it in the frame
    /// and judging how close it is takes 300-500. A turn that goes out and comes straight back,
    /// however fast and however far, shows the player nothing. The hold is the effect.
    /// </para>
    /// </summary>
    public static class ShoulderCheckCurve
    {
        /// <summary>
        /// Deflection at <paramref name="elapsed"/>, 0 = facing forward, 1 = fully turned.
        /// Past the end it returns 0.
        /// </summary>
        public static float Evaluate(float elapsed, float turnOutSeconds, float holdSeconds,
            float returnSeconds)
        {
            if (elapsed <= 0f)
            {
                return 0f;
            }

            turnOutSeconds = Mathf.Max(0f, turnOutSeconds);
            holdSeconds = Mathf.Max(0f, holdSeconds);
            returnSeconds = Mathf.Max(0f, returnSeconds);

            if (elapsed < turnOutSeconds)
            {
                // Smoothstep, not linear: it has to decelerate into the hold, or the image is still
                // moving when the player starts trying to read it.
                return Mathf.SmoothStep(0f, 1f, elapsed / turnOutSeconds);
            }

            float intoHold = elapsed - turnOutSeconds;

            if (intoHold < holdSeconds)
            {
                return 1f;
            }

            float intoReturn = intoHold - holdSeconds;

            if (intoReturn < returnSeconds)
            {
                return 1f - Mathf.SmoothStep(0f, 1f, intoReturn / returnSeconds);
            }

            return 0f;
        }

        /// <summary>How long the whole thing takes.</summary>
        public static float TotalSeconds(float turnOutSeconds, float holdSeconds, float returnSeconds)
        {
            return Mathf.Max(0f, turnOutSeconds) + Mathf.Max(0f, holdSeconds)
                + Mathf.Max(0f, returnSeconds);
        }

        /// <summary>
        /// Seconds spent at or above <paramref name="threshold"/> deflection — the readable window.
        /// It is longer than the hold, because the eased ends linger near full turn, and that
        /// margin is real: the last few degrees of a smoothstep are the slowest part of the move.
        /// </summary>
        public static float ReadableSeconds(float turnOutSeconds, float holdSeconds,
            float returnSeconds, float threshold = 0.95f)
        {
            float total = TotalSeconds(turnOutSeconds, holdSeconds, returnSeconds);

            if (total <= 0f)
            {
                return 0f;
            }

            // Sampled rather than solved: smoothstep inverts to a trigonometric form that is not
            // worth carrying for a number this coarse, and 1 ms steps are far finer than the
            // difference anyone can perceive.
            const float k_Step = 0.001f;
            float readable = 0f;

            for (float t = 0f; t < total; t += k_Step)
            {
                if (Evaluate(t, turnOutSeconds, holdSeconds, returnSeconds) >= threshold)
                {
                    readable += k_Step;
                }
            }

            return readable;
        }
    }
}
