using NUnit.Framework;
using RootsDance.Chase;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Chase
{
    public class ChaseTrailTests
    {
        [Test]
        public void Record_PointsCloserThanSpacing_AreNotStored()
        {
            ChaseTrail trail = new ChaseTrail(1f, 64);
            trail.Record(Vector3.zero);
            trail.Record(new Vector3(0.4f, 0f, 0f));
            trail.Record(new Vector3(0.8f, 0f, 0f));

            Assert.AreEqual(1, trail.Count);
        }

        [Test]
        public void Record_BeyondCapacity_DropsTheOldest()
        {
            ChaseTrail trail = new ChaseTrail(1f, 3);

            for (int i = 0; i < 6; i++)
            {
                trail.Record(new Vector3(i * 2f, 0f, 0f));
            }

            Assert.AreEqual(3, trail.Count);

            // The oldest surviving point is at x = 6; a long gap request lands on it.
            Vector3 point;
            trail.TryGetPursuitPoint(new Vector3(10f, 0f, 0f), 100f, out point);
            Assert.AreEqual(6f, point.x, 0.001f);
        }

        [Test]
        public void TryGetPursuitPoint_OnAStraightLine_LandsExactlyTheGapBehindTheHead()
        {
            ChaseTrail trail = new ChaseTrail(1f, 64);

            for (int i = 0; i <= 20; i++)
            {
                trail.Record(new Vector3(i, 0f, 0f));
            }

            Vector3 point;
            bool found = trail.TryGetPursuitPoint(new Vector3(20f, 0f, 0f), 7.5f, out point);

            Assert.IsTrue(found);
            Assert.AreEqual(12.5f, point.x, 0.001f);
        }

        [Test]
        public void TryGetPursuitPoint_MeasuresFromTheLiveHead_NotTheLastStoredPoint()
        {
            ChaseTrail trail = new ChaseTrail(1f, 64);
            trail.Record(Vector3.zero);
            trail.Record(new Vector3(10f, 0f, 0f));

            // The head has moved on 0.9 m since the last stored breadcrumb.
            Vector3 point;
            bool found = trail.TryGetPursuitPoint(new Vector3(10.9f, 0f, 0f), 2f, out point);

            Assert.IsTrue(found);
            Assert.AreEqual(8.9f, point.x, 0.001f);
        }

        [Test]
        public void TryGetPursuitPoint_TrailShorterThanTheGap_ReturnsFalseAndTheOldestPoint()
        {
            ChaseTrail trail = new ChaseTrail(1f, 64);
            trail.Record(new Vector3(5f, 0f, 0f));
            trail.Record(new Vector3(7f, 0f, 0f));

            Vector3 point;
            bool found = trail.TryGetPursuitPoint(new Vector3(8f, 0f, 0f), 50f, out point);

            Assert.IsFalse(found);
            Assert.AreEqual(5f, point.x, 0.001f);
        }

        [Test]
        public void TryGetPursuitPoint_FollowsCorners_InsteadOfCuttingThem()
        {
            ChaseTrail trail = new ChaseTrail(1f, 64);

            // 10 m along +X, then the route turns 90 degrees and runs 10 m along +Z.
            for (int i = 0; i <= 10; i++)
            {
                trail.Record(new Vector3(i, 0f, 0f));
            }

            for (int i = 1; i <= 10; i++)
            {
                trail.Record(new Vector3(10f, 0f, i));
            }

            // 12 m back along the path from (10, 10): 10 back down the Z leg to the corner,
            // then 2 along the X leg — not a straight-line point inside the corner.
            Vector3 point;
            trail.TryGetPursuitPoint(new Vector3(10f, 0f, 10f), 12f, out point);

            Assert.AreEqual(8f, point.x, 0.001f);
            Assert.AreEqual(0f, point.z, 0.001f);
        }

        [Test]
        public void Clear_ForgetsTheRoute()
        {
            ChaseTrail trail = new ChaseTrail(1f, 64);
            trail.Record(Vector3.zero);
            trail.Record(new Vector3(5f, 0f, 0f));
            trail.Clear();

            Assert.AreEqual(0, trail.Count);
        }
    }
}
