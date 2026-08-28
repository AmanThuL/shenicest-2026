using NUnit.Framework;
using RootsDance.Scanner;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Scanner
{
    /// <summary>
    /// The framing distance is what the brief's adjustable border ratio actually means, so it is
    /// worth pinning: the screen has to end up covering the asked-for fraction of the viewport on
    /// whichever axis is tighter, on any aspect.
    /// </summary>
    public class ScreenFramingTests
    {
        private const float k_Fov = 34f;

        /// <summary>Half the viewport's height in metres at a given distance.</summary>
        private static float HalfHeight(float distance, float fov)
        {
            return distance * Mathf.Tan(fov * 0.5f * Mathf.Deg2Rad);
        }

        [Test]
        public void DistanceForFill_FullFill_ScreenHeightMatchesViewportHeight()
        {
            Vector2 size = new Vector2(0.10594f, 0.07186f);

            // A 16:9 viewport is wider than the screen's 1.47:1, so height is the tight axis.
            float distance = ScreenFraming.DistanceForFill(size, k_Fov, 16f / 9f, 1f);

            Assert.That(HalfHeight(distance, k_Fov) * 2f, Is.EqualTo(size.y).Within(1e-5f));
        }

        [Test]
        public void DistanceForFill_HalfFill_ScreenCoversHalfTheViewport()
        {
            Vector2 size = new Vector2(0.10594f, 0.07186f);

            float distance = ScreenFraming.DistanceForFill(size, k_Fov, 16f / 9f, 0.5f);

            Assert.That(size.y / (HalfHeight(distance, k_Fov) * 2f), Is.EqualTo(0.5f).Within(1e-4f));
        }

        [Test]
        public void DistanceForFill_NarrowViewport_WidthBecomesTheTightAxis()
        {
            Vector2 size = new Vector2(0.10594f, 0.07186f);

            // 1:1 is narrower than the screen's aspect, so the width now decides the distance and
            // the result must be larger than the height-driven one.
            float square = ScreenFraming.DistanceForFill(size, k_Fov, 1f, 1f);
            float wide = ScreenFraming.DistanceForFill(size, k_Fov, 16f / 9f, 1f);

            Assert.That(square, Is.GreaterThan(wide));

            float halfWidth = HalfHeight(square, k_Fov) * 1f;
            Assert.That(halfWidth * 2f, Is.EqualTo(size.x).Within(1e-5f));
        }

        [Test]
        public void DistanceForFill_ZeroFill_IsClampedInsteadOfDividingByZero()
        {
            float distance = ScreenFraming.DistanceForFill(Vector2.one * 0.1f, k_Fov, 1.6f, 0f);

            Assert.That(distance, Is.GreaterThan(0f));
            Assert.That(float.IsInfinity(distance), Is.False);
        }

        [Test]
        public void DistanceForFill_SmallerFill_MovesTheCameraFurtherBack()
        {
            Vector2 size = ScannerScreenSurface.k_MeasuredActiveArea;

            float tight = ScreenFraming.DistanceForFill(size, k_Fov, 16f / 9f, 0.9f);
            float loose = ScreenFraming.DistanceForFill(size, k_Fov, 16f / 9f, 0.6f);

            Assert.That(loose, Is.GreaterThan(tight));
        }
    }
}
