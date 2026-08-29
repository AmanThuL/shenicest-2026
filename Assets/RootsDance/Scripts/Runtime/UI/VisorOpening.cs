using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Where the helmet's glass actually is, as a rough curve, so a readout can be placed inside the
    /// opening instead of on the frame.
    /// <para>
    /// The frame is modelled geometry sitting in front of the camera, not part of the HUD, so no
    /// layout rule can see it. Placing readouts at a fixed distance from the screen corner assumes
    /// the opening is a rectangle; it is not. Its lower edge dips deepest a little inboard of each
    /// side — exactly where the two corner readouts sit — which is why they were drawn over the
    /// frame while the middle of the screen stayed clear.
    /// </para>
    /// <para>
    /// Pure and static, and in the runtime assembly rather than the editor one, for the same reason
    /// <see cref="RootsDance.Archive.ArchivePageLayout"/> is: it is a description of the layout, it
    /// can be unit tested without a scene, and anything that later places a widget on the visor
    /// needs the same answer the builder needs.
    /// </para>
    /// <para>
    /// A widget is placed against <see cref="TopInsetOverSpan01"/>, the <em>worst</em> inset across
    /// the width it occupies, not the inset under its anchor: a label clears the frame only if all
    /// of it does.
    /// </para>
    /// The numbers below were read off the 2026-08-29 helmet capture and are deliberately coarse —
    /// "大致的曲线". Re-measure with <c>RootsDance/Probe/Visor Opening</c> after the helmet model
    /// changes; the shape is three samples and a lobe position, so correcting it is four numbers.
    /// </summary>
    public static class VisorOpening
    {
        /// <summary>Fraction of canvas height the frame covers at the middle of the screen.</summary>
        public const float k_TopInsetCentre = 0.12f;

        /// <summary>The same where the frame dips deepest, a little inboard of each side.</summary>
        public const float k_TopInsetLobe = 0.24f;

        /// <summary>And at the extreme left and right edges, where it rises again.</summary>
        public const float k_TopInsetEdge = 0.20f;

        /// <summary>
        /// Where the deepest dip sits, as |2x-1|: 0 is the centre of the screen, 1 is either side.
        /// 0.52 puts it around x=0.24 and x=0.76.
        /// </summary>
        public const float k_LobeAt = 0.52f;

        /// <summary>Clear air between a widget and the frame, so they never merely touch.</summary>
        public const float k_Margin = 0.022f;

        /// <summary>
        /// How much of the canvas height the frame covers at <paramref name="x01"/>, where 0 is the
        /// left edge of the canvas and 1 the right. Symmetric about the centre.
        /// </summary>
        public static float TopInset01(float x01)
        {
            // Distance from the centre, 0..1. Everything below is a function of this alone: the
            // helmet is symmetric, and pretending otherwise would invite tuning one side only.
            float u = Mathf.Abs(Mathf.Clamp01(x01) * 2f - 1f);

            if (u <= k_LobeAt)
            {
                // Centre out to the dip. SmoothStep rather than a straight line: the frame's edge
                // is a moulded curve, and a corner here would show up as a widget that clears at
                // one x and collides a few pixels away.
                return Mathf.SmoothStep(k_TopInsetCentre, k_TopInsetLobe,
                    k_LobeAt <= 0f ? 1f : u / k_LobeAt);
            }

            float remaining = 1f - k_LobeAt;

            return Mathf.SmoothStep(k_TopInsetLobe, k_TopInsetEdge,
                remaining <= 0f ? 1f : (u - k_LobeAt) / remaining);
        }

        /// <summary>
        /// The worst inset anywhere between <paramref name="x0"/> and <paramref name="x1"/> — what
        /// a widget of that width has to clear. Sampled rather than solved: the curve is cheap, this
        /// runs at build time, and a closed form would have to be re-derived every time the shape is
        /// tuned.
        /// </summary>
        public static float TopInsetOverSpan01(float x0, float x1)
        {
            const int k_Samples = 33;

            float low = Mathf.Min(x0, x1);
            float high = Mathf.Max(x0, x1);
            float worst = 0f;

            for (int i = 0; i < k_Samples; i++)
            {
                float t = k_Samples == 1 ? 0f : i / (float)(k_Samples - 1);
                worst = Mathf.Max(worst, TopInset01(Mathf.Lerp(low, high, t)));
            }

            return worst;
        }

        /// <summary>
        /// Distance in pixels from the top of the canvas at which a widget spanning
        /// <paramref name="x0"/>..<paramref name="x1"/> may start, margin included.
        /// </summary>
        public static float TopPixels(float x0, float x1, float canvasHeight)
        {
            return (TopInsetOverSpan01(x0, x1) + k_Margin) * canvasHeight;
        }

        /// <summary>
        /// The horizontal span a corner-anchored widget occupies, as canvas fractions.
        /// <paramref name="anchorX01"/> is its anchor (0 left, 1 right) and the widget is laid out
        /// away from that edge, which is what every readout on the visor does.
        /// </summary>
        public static void SpanFor(float anchorX01, float offsetPixels, float widthPixels,
            float canvasWidth, out float x0, out float x1)
        {
            float edge = anchorX01 * canvasWidth;
            float inward = anchorX01 < 0.5f ? 1f : -1f;
            float near = edge + offsetPixels * inward;
            float far = near + widthPixels * inward;

            x0 = Mathf.Clamp01(Mathf.Min(near, far) / canvasWidth);
            x1 = Mathf.Clamp01(Mathf.Max(near, far) / canvasWidth);
        }
    }
}
