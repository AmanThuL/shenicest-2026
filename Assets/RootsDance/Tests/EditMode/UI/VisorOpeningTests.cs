using NUnit.Framework;
using RootsDance.UI;
using UnityEngine;

namespace RootsDance.Tests.EditMode.UI
{
    /// <summary>
    /// The shape of the helmet's opening, and the one rule that follows from it: a widget clears
    /// the frame only if all of its width does.
    /// </summary>
    public class VisorOpeningTests
    {
        [Test]
        public void TopInset01_Centre_IsTheShallowestPoint()
        {
            float centre = VisorOpening.TopInset01(0.5f);

            for (int i = 0; i <= 20; i++)
            {
                Assert.GreaterOrEqual(VisorOpening.TopInset01(i / 20f), centre - 0.0001f);
            }
        }

        [Test]
        public void TopInset01_AtTheLobe_IsTheDeepestPoint()
        {
            // Where the frame dips furthest into the view. If this stops being the maximum, the
            // shape has been retuned into something the corner readouts no longer have to clear.
            float lobe = VisorOpening.TopInset01(0.5f - VisorOpening.k_LobeAt * 0.5f);

            for (int i = 0; i <= 40; i++)
            {
                Assert.LessOrEqual(VisorOpening.TopInset01(i / 40f), lobe + 0.0001f);
            }
        }

        [Test]
        public void TopInset01_IsSymmetric()
        {
            for (int i = 0; i <= 10; i++)
            {
                float x = i / 10f;
                Assert.AreEqual(VisorOpening.TopInset01(x), VisorOpening.TopInset01(1f - x), 0.0001f);
            }
        }

        [Test]
        public void TopInset01_OutsideTheCanvas_ClampsInsteadOfExtrapolating()
        {
            Assert.AreEqual(VisorOpening.TopInset01(0f), VisorOpening.TopInset01(-3f), 0.0001f);
            Assert.AreEqual(VisorOpening.TopInset01(1f), VisorOpening.TopInset01(4f), 0.0001f);
        }

        [Test]
        public void TopInsetOverSpan01_SpanCoveringTheLobe_TakesTheLobe()
        {
            // The bug this whole type exists for: a label anchored at the corner is measured under
            // its anchor, where the frame is shallow, while its far end hangs over the deepest dip.
            float lobeX = 0.5f - VisorOpening.k_LobeAt * 0.5f;
            float atAnchor = VisorOpening.TopInset01(0.05f);
            float overSpan = VisorOpening.TopInsetOverSpan01(0.05f, lobeX + 0.05f);

            Assert.Greater(overSpan, atAnchor);
            Assert.AreEqual(VisorOpening.k_TopInsetLobe, overSpan, 0.001f);
        }

        [Test]
        public void TopInsetOverSpan01_ReversedSpan_ReadsTheSame()
        {
            Assert.AreEqual(VisorOpening.TopInsetOverSpan01(0.1f, 0.4f),
                VisorOpening.TopInsetOverSpan01(0.4f, 0.1f), 0.0001f);
        }

        [Test]
        public void TopPixels_IncludesTheMargin()
        {
            float inset = VisorOpening.TopInsetOverSpan01(0.2f, 0.3f);

            Assert.AreEqual((inset + VisorOpening.k_Margin) * 1080f,
                VisorOpening.TopPixels(0.2f, 0.3f, 1080f), 0.01f);
        }

        [Test]
        public void SpanFor_LeftAnchoredLabel_RunsInwardFromTheLeftEdge()
        {
            VisorOpening.SpanFor(0f, 90f, 520f, 1920f, out float x0, out float x1);

            Assert.AreEqual(90f / 1920f, x0, 0.0001f);
            Assert.AreEqual(610f / 1920f, x1, 0.0001f);
        }

        [Test]
        public void SpanFor_RightAnchoredLabel_IsTheMirrorOfTheLeftOne()
        {
            VisorOpening.SpanFor(0f, 90f, 520f, 1920f, out float leftX0, out float leftX1);
            VisorOpening.SpanFor(1f, 90f, 520f, 1920f, out float rightX0, out float rightX1);

            Assert.AreEqual(1f - leftX1, rightX0, 0.0001f);
            Assert.AreEqual(1f - leftX0, rightX1, 0.0001f);
        }

        [Test]
        public void SpanFor_OverlongLabel_StaysInsideTheCanvas()
        {
            VisorOpening.SpanFor(0f, 90f, 4000f, 1920f, out float x0, out float x1);

            Assert.GreaterOrEqual(x0, 0f);
            Assert.LessOrEqual(x1, 1f);
        }

        [Test]
        public void TopPixels_ForACornerReadout_ClearsTheFrameItUsedToOverlap()
        {
            // The authored layout: 90 px in, 520 px wide, on a 1920x1080 reference canvas. The old
            // fixed -70 put the label's top inside the frame; whatever the shape is tuned to, the
            // answer has to be below the deepest dip its own width crosses.
            VisorOpening.SpanFor(0f, 90f, 520f, 1920f, out float x0, out float x1);
            float top = VisorOpening.TopPixels(x0, x1, 1080f);

            Assert.Greater(top, VisorOpening.TopInsetOverSpan01(x0, x1) * 1080f);
            Assert.Greater(top, 70f);
            Assert.Less(top, 1080f * 0.5f, "A readout pushed past mid-screen is not a HUD any more.");
        }
    }
}
