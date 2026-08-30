using NUnit.Framework;
using RootsDance.Archive;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Archive
{
    public class DocumentInspectMathTests
    {
        private static readonly Vector2 k_A5 = new Vector2(0.148f, 0.21f);

        [Test]
        public void HoldDistance_LargerFill_IsCloser()
        {
            float rest = DocumentInspectMath.HoldDistance(k_A5, 60f, 16f / 9f, 0.55f);
            float leanedIn = DocumentInspectMath.HoldDistance(k_A5, 60f, 16f / 9f, 0.92f);

            Assert.Less(leanedIn, rest);
        }

        [Test]
        public void HoldDistance_LargerSheet_IsHeldFurtherAway()
        {
            float small = DocumentInspectMath.HoldDistance(k_A5, 60f, 16f / 9f, 0.8f);
            float large = DocumentInspectMath.HoldDistance(k_A5 * 2f, 60f, 16f / 9f, 0.8f);

            Assert.AreEqual(small * 2f, large, 1e-4f);
        }

        [Test]
        public void Zoom_PositiveInput_PullsTheSheetCloser()
        {
            float moved = DocumentInspectMath.Zoom(0.40f, 1f, 0.30f, 0.1f, 0.20f, 0.50f);

            Assert.AreEqual(0.37f, moved, 1e-5f);
        }

        [Test]
        public void Zoom_NegativeInput_PushesTheSheetAway()
        {
            float moved = DocumentInspectMath.Zoom(0.40f, -1f, 0.30f, 0.1f, 0.20f, 0.50f);

            Assert.AreEqual(0.43f, moved, 1e-5f);
        }

        [TestCase(1f, 0.20f)]
        [TestCase(-1f, 0.50f)]
        public void Zoom_HeldAtFullDeflection_StopsAtTheLimit(float input, float expected)
        {
            float distance = 0.35f;

            for (int frame = 0; frame < 200; frame++)
            {
                distance = DocumentInspectMath.Zoom(distance, input, 0.30f, 1f / 60f, 0.20f, 0.50f);
            }

            Assert.AreEqual(expected, distance, 1e-5f);
        }

        [Test]
        public void Zoom_LimitsGivenInEitherOrder_ClampTheSame()
        {
            // The near end comes from the larger fill, so callers naturally hand it over first.
            float ascending = DocumentInspectMath.Zoom(0.40f, 5f, 0.30f, 1f, 0.20f, 0.50f);
            float descending = DocumentInspectMath.Zoom(0.40f, 5f, 0.30f, 1f, 0.50f, 0.20f);

            Assert.AreEqual(ascending, descending, 1e-6f);
            Assert.AreEqual(0.20f, ascending, 1e-6f);
        }

        [Test]
        public void Zoom_InputBeyondFullDeflection_TravelsNoFasterThanFullDeflection()
        {
            float clamped = DocumentInspectMath.Zoom(0.40f, 4f, 0.30f, 0.1f, 0.0f, 1f);
            float full = DocumentInspectMath.Zoom(0.40f, 1f, 0.30f, 0.1f, 0.0f, 1f);

            Assert.AreEqual(full, clamped, 1e-6f);
        }

        [Test]
        public void Tilt_PointerRight_TurnsTheSheetAboutItsUpAxis()
        {
            Vector2 tilt = DocumentInspectMath.Tilt(Vector2.zero, new Vector2(10f, 0f), 0.5f, 26f, 30f);

            Assert.AreEqual(0f, tilt.x, 1e-5f);
            Assert.AreEqual(5f, tilt.y, 1e-5f);
        }

        [Test]
        public void Tilt_PointerUp_TipsTheTopOfTheSheetAway()
        {
            Vector2 tilt = DocumentInspectMath.Tilt(Vector2.zero, new Vector2(0f, 10f), 0.5f, 26f, 30f);

            Assert.AreEqual(-5f, tilt.x, 1e-5f);
        }

        [Test]
        public void Tilt_PointerDraggedFar_StopsAtTheLimitSoThePageStaysReadable()
        {
            Vector2 tilt = DocumentInspectMath.Tilt(Vector2.zero, new Vector2(9000f, -9000f), 0.5f, 26f, 30f);

            Assert.AreEqual(26f, tilt.x, 1e-4f);
            Assert.AreEqual(30f, tilt.y, 1e-4f);
        }

        [Test]
        public void Tilt_NegativeLimits_AreTreatedAsMagnitudes()
        {
            Vector2 tilt = DocumentInspectMath.Tilt(Vector2.zero, new Vector2(9000f, 9000f), 0.5f, -26f, -30f);

            Assert.AreEqual(-26f, tilt.x, 1e-4f);
            Assert.AreEqual(30f, tilt.y, 1e-4f);
        }
    }
}
