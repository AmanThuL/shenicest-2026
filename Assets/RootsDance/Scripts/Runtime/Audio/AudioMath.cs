using UnityEngine;

namespace RootsDance.Audio
{
    /// <summary>
    /// The slider-to-mixer conversion, kept as pure arithmetic so it can be tested without an
    /// AudioMixer — which is the only part of a volume setting that is ever actually wrong.
    /// <para>
    /// A mixer's volume is in decibels and its usable range is roughly −80 dB (silence) to 0 dB
    /// (unity gain). A UI slider is linear 0..1. Mapping one onto the other linearly is the classic
    /// mistake: half-way on the slider would be −40 dB, which is inaudible, so the top half of the
    /// travel does nothing the player can hear. The perceptual mapping is logarithmic, hence
    /// <c>20 · log10(linear)</c>.
    /// </para>
    /// </summary>
    public static class AudioMath
    {
        /// <summary>The mixer's floor. Anything at or under this is treated as silence.</summary>
        public const float k_MinDecibels = -80f;

        /// <summary>Unity gain — the loudest a group is driven, so nothing clips on the master.</summary>
        public const float k_MaxDecibels = 0f;

        /// <summary>
        /// Linear 0..1 (a slider) to decibels for <c>AudioMixer.SetFloat</c>. 0 maps to the floor
        /// rather than to negative infinity, which the mixer would reject.
        /// </summary>
        public static float LinearToDecibels(float linear)
        {
            if (linear <= 0.0001f)
            {
                return k_MinDecibels;
            }

            return Mathf.Clamp(20f * Mathf.Log10(Mathf.Clamp01(linear)), k_MinDecibels, k_MaxDecibels);
        }

        /// <summary>Decibels back to linear 0..1, for showing a saved value on a slider.</summary>
        public static float DecibelsToLinear(float decibels)
        {
            if (decibels <= k_MinDecibels)
            {
                return 0f;
            }

            return Mathf.Clamp01(Mathf.Pow(10f, Mathf.Min(decibels, k_MaxDecibels) / 20f));
        }
    }
}
