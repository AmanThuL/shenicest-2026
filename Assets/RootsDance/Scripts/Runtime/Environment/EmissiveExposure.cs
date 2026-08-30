using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// How much to scale an emissive value that was authored under one fixed exposure so it reads
    /// the same under another. Exposure is in EV100 stops: one stop up halves the recorded light,
    /// so an emitter authored at EV 12.5 must emit 2^(12.5 − 5) ≈ 181× less at EV 5 to look alike.
    /// </summary>
    public static class EmissiveExposure
    {
        public static float Scale(float authoredEv100, float currentEv100)
        {
            return Mathf.Pow(2f, currentEv100 - authoredEv100);
        }
    }
}
