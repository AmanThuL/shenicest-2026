using System.Collections.Generic;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// The arithmetic behind a time-of-day transition, kept out of the MonoBehaviour so it can be
    /// unit-tested without a scene. Pure functions only: nothing here touches a Volume or a Light.
    /// </summary>
    public static class TimeOfDayBlend
    {
        /// <summary>Lowest lux fed to the log-space lerp; log2(0) is undefined and a black sun is not a look.</summary>
        private const float k_MinLux = 0.001f;

        /// <summary>
        /// Smoothstepped 0..1 progress. A duration of zero or less means "no blend": the transition
        /// is already finished, so callers snap.
        /// </summary>
        public static float Weight01(float elapsed, float duration)
        {
            if (duration <= 0f)
            {
                return 1f;
            }

            float t = Mathf.Clamp01(elapsed / duration);
            return t * t * (3f - 2f * t);
        }

        /// <summary>
        /// Interpolates a light intensity in log2 space. Day and night are decades apart (12 000 lux
        /// against 8), and a linear lerp between them spends almost the whole blend looking like day.
        /// </summary>
        public static float LerpLux(float from, float to, float t)
        {
            float fromLog = Mathf.Log(Mathf.Max(from, k_MinLux), 2f);
            float toLog = Mathf.Log(Mathf.Max(to, k_MinLux), 2f);
            return Mathf.Pow(2f, Mathf.Lerp(fromLog, toLog, Mathf.Clamp01(t)));
        }

        /// <summary>
        /// First preset describing <paramref name="phase"/>, or null when the list has none. Indexed
        /// loop, no LINQ: the controller calls this on every phase change.
        /// </summary>
        public static TimeOfDayPresetSO Find(IReadOnlyList<TimeOfDayPresetSO> presets, TimeOfDay phase)
        {
            if (presets == null)
            {
                return null;
            }

            for (int i = 0; i < presets.Count; i++)
            {
                TimeOfDayPresetSO preset = presets[i];

                if (preset != null && preset.Phase == phase)
                {
                    return preset;
                }
            }

            return null;
        }
    }
}
