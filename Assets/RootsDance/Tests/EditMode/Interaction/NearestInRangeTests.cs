using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Interaction;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Interaction
{
    /// <summary>
    /// The rule that decides which of several candidates an offer targets. Both picking a prop up
    /// and aiming the scanner go through this, so these lock the behaviour for both at once.
    /// </summary>
    public class NearestInRangeTests
    {
        private static readonly Vector3 k_Origin = Vector3.zero;

        [Test]
        public void Index_NothingInRange_IsMinusOne()
        {
            List<Vector3> points = new List<Vector3> { new Vector3(9f, 0f, 0f) };

            Assert.That(NearestInRange.Index(points, k_Origin, 3f), Is.EqualTo(-1));
        }

        [Test]
        public void Index_EmptyList_IsMinusOne()
        {
            Assert.That(NearestInRange.Index(new List<Vector3>(), k_Origin, 3f), Is.EqualTo(-1));
        }

        [Test]
        public void Index_NullList_IsMinusOne()
        {
            Assert.That(NearestInRange.Index(null, k_Origin, 3f), Is.EqualTo(-1));
        }

        [Test]
        public void Index_SeveralInRange_IsTheClosest()
        {
            List<Vector3> points = new List<Vector3>
            {
                new Vector3(2.5f, 0f, 0f),
                new Vector3(0.4f, 0f, 0f),
                new Vector3(1.2f, 0f, 0f),
            };

            Assert.That(NearestInRange.Index(points, k_Origin, 3f), Is.EqualTo(1));
        }

        [Test]
        public void Index_ClosestIsOutOfRange_PicksTheNearestThatIsNot()
        {
            List<Vector3> points = new List<Vector3>
            {
                new Vector3(20f, 0f, 0f),
                new Vector3(2.9f, 0f, 0f),
            };

            Assert.That(NearestInRange.Index(points, k_Origin, 3f), Is.EqualTo(1));
        }

        [Test]
        public void Index_ExactlyAtRange_IsInReach()
        {
            List<Vector3> points = new List<Vector3> { new Vector3(3f, 0f, 0f) };

            Assert.That(NearestInRange.Index(points, k_Origin, 3f), Is.EqualTo(0));
        }

        [Test]
        public void Index_Ties_ResolveToTheEarlier()
        {
            List<Vector3> points = new List<Vector3>
            {
                new Vector3(1f, 0f, 0f),
                new Vector3(-1f, 0f, 0f),
            };

            Assert.That(NearestInRange.Index(points, k_Origin, 3f), Is.EqualTo(0),
                "a tie has to resolve to one of them, and stably");
        }

        [Test]
        public void Index_ZeroRange_IsMinusOne()
        {
            List<Vector3> points = new List<Vector3> { k_Origin };

            Assert.That(NearestInRange.Index(points, k_Origin, 0f), Is.EqualTo(-1));
        }

        [Test]
        public void Index_MeasuresFromTheGivenOrigin_NotWorldZero()
        {
            List<Vector3> points = new List<Vector3>
            {
                new Vector3(0f, 0f, 0f),
                new Vector3(10f, 0f, 0f),
            };

            Assert.That(NearestInRange.Index(points, new Vector3(9f, 0f, 0f), 3f), Is.EqualTo(1));
        }
    }
}
