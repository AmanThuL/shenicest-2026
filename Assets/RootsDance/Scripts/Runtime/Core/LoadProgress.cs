using UnityEngine;

namespace RootsDance.Core
{
    /// <summary>
    /// Turns "step 3 of 7, that step 40% done" into one 0..1 number for the loading screen. Kept as
    /// pure arithmetic away from <c>SceneLoader</c> so the part that is easy to get wrong —
    /// the bar jumping backwards, or sitting at 0 because the step count was counted before the
    /// unload list was built — is the part that has tests.
    /// <para>
    /// A load is modelled as equal-weight steps because that is the only honest weighting available:
    /// <c>AsyncOperation.progress</c> is the engine's own guess, and a scene's real cost is not
    /// known until it is loaded. An even bar that never stalls reads better than a weighted one that
    /// sits at 80% for two seconds.
    /// </para>
    /// </summary>
    public static class LoadProgress
    {
        /// <summary>
        /// Fraction of the whole load that is done. Out-of-range inputs are clamped rather than
        /// rejected: <c>AsyncOperation.progress</c> is allowed to report 0.9 and then jump, and a
        /// caller that miscounts its own steps should still get a bar that fills once.
        /// </summary>
        public static float Fraction(int completedSteps, int totalSteps, float currentStepProgress)
        {
            if (totalSteps <= 0)
            {
                // Nothing to wait for: the load is already over.
                return 1f;
            }

            int completed = Mathf.Clamp(completedSteps, 0, totalSteps);

            if (completed >= totalSteps)
            {
                return 1f;
            }

            float within = Mathf.Clamp01(currentStepProgress);

            return (completed + within) / totalSteps;
        }

        /// <summary>
        /// Snaps a fraction onto <paramref name="segmentCount"/> lit cells. The bar is discrete on
        /// purpose (低保真终端式UI规范 §13: every visible step is a hard cut), and rounding down
        /// rather than to nearest keeps the last cell honest — it lights only at a real 100%.
        /// </summary>
        public static int LitSegments(float fraction, int segmentCount)
        {
            if (segmentCount <= 0)
            {
                return 0;
            }

            return Mathf.Clamp(Mathf.FloorToInt(Mathf.Clamp01(fraction) * segmentCount), 0, segmentCount);
        }
    }
}
