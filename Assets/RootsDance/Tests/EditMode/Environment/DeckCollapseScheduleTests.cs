using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// The deck collapse is a physics event wrapped in two pure decisions: which chunk goes when.
    /// Everything else is Rigidbody writes only a scene can check. These are the two.
    /// </summary>
    public class DeckCollapseScheduleTests
    {
        [Test]
        public void Order_FarChunksFirstNearestLast_ByHorizontalDistanceOnly()
        {
            var positions = new List<Vector3>
            {
                new Vector3(1f, 0f, 0f),    // near
                new Vector3(10f, 0f, 0f),   // far
                new Vector3(0f, 100f, 3f),  // near on the flat, high up — height must not count
                new Vector3(-6f, 0f, 0f)    // middle
            };

            int[] order = DeckCollapseSchedule.Order(positions, Vector3.zero);

            CollectionAssert.AreEqual(new[] { 1, 3, 2, 0 }, order);
        }

        [Test]
        public void Order_MeasuresFromTheGivenOrigin()
        {
            var positions = new List<Vector3> { new Vector3(0f, 0f, 0f), new Vector3(10f, 0f, 0f) };

            int[] order = DeckCollapseSchedule.Order(positions, new Vector3(10f, 5f, 0f));

            CollectionAssert.AreEqual(new[] { 0, 1 }, order);
        }

        [Test]
        public void ReleaseTimes_FirstAtZero_GapsShrinkToTheMinimum()
        {
            float[] times = DeckCollapseSchedule.ReleaseTimes(8, 1.6f, 0.5f, 0.1f);

            Assert.That(times[0], Is.EqualTo(0f));
            Assert.That(times[1] - times[0], Is.EqualTo(1.6f).Within(1e-5f));
            Assert.That(times[2] - times[1], Is.EqualTo(0.8f).Within(1e-5f));
            Assert.That(times[3] - times[2], Is.EqualTo(0.4f).Within(1e-5f));
            Assert.That(times[4] - times[3], Is.EqualTo(0.2f).Within(1e-5f));
            Assert.That(times[5] - times[4], Is.EqualTo(0.1f).Within(1e-5f));
            Assert.That(times[6] - times[5], Is.EqualTo(0.1f).Within(1e-5f), "floored at the minimum");
            Assert.That(times[7] - times[6], Is.EqualTo(0.1f).Within(1e-5f));
        }

        [Test]
        public void ReleaseTimes_AreNonDecreasing()
        {
            float[] times = DeckCollapseSchedule.ReleaseTimes(76, 1.6f, 0.72f, 0.04f);

            for (int i = 1; i < times.Length; i++)
            {
                Assert.That(times[i], Is.GreaterThanOrEqualTo(times[i - 1]), $"release {i}");
            }
        }

        [Test]
        public void ReleaseTimes_DefaultsBringTheWholeDeckDownInUnderTenSeconds()
        {
            // 76 chunks in the greenhouse rig; a warning that is already tens of seconds long
            // must not be followed by a collapse that dawdles.
            float[] times = DeckCollapseSchedule.ReleaseTimes(76, 1.6f, 0.72f, 0.04f);

            Assert.That(times[75], Is.LessThan(10f));
            Assert.That(times[75], Is.GreaterThan(5f), "but it is not instant either");
        }

        [Test]
        public void ReleaseTimes_ZeroCount_IsEmpty()
        {
            Assert.That(DeckCollapseSchedule.ReleaseTimes(0, 1f, 0.5f, 0.1f), Is.Empty);
        }
    }
}
