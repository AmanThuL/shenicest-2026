using NUnit.Framework;
using RootsDance.Editor.Terrain;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Terrain
{
    public class LabTerraceDerivationTests
    {
        private const float k_Margin = 6f;
        private const float k_LabYaw = 30f;

        // An 80 x 20 m footprint (half extents 40 x 10) whose centre is off the lab's origin, so the
        // tests also cover the builder's pivot convention (local centre mapped onto TerraceCenter).
        private static readonly Bounds k_LocalBounds =
            new Bounds(new Vector3(3f, 2f, -4f), new Vector3(80f, 4f, 20f));

        [Test]
        public void DeriveTerrace_RectangularBounds_HalfExtentsAreLocalExtentsPlusMargin()
        {
            Vector2 halfExtents;
            float terraceYaw;

            LabTerraceDerivation.DeriveTerrace(k_LocalBounds, k_LabYaw, k_Margin, out halfExtents, out terraceYaw);

            Assert.AreEqual(40f + k_Margin, halfExtents.x, 1e-4f);
            Assert.AreEqual(10f + k_Margin, halfExtents.y, 1e-4f);
        }

        [Test]
        public void LabPivot_ZeroOffset_IsFootprintCentreAtLowestPoint()
        {
            Vector3 pivot = LabTerraceDerivation.LabPivot(k_LocalBounds, 0f);

            Assert.AreEqual(new Vector3(3f, 0f, -4f), pivot);
        }

        [Test]
        public void LabPivot_PositiveOffset_RaisesPivotAboveLowestPointByOffset()
        {
            Vector3 pivot = LabTerraceDerivation.LabPivot(k_LocalBounds, 0.76f);

            Assert.AreEqual(k_LocalBounds.min.y + 0.76f, pivot.y, 1e-5f);
            Assert.AreEqual(k_LocalBounds.center.x, pivot.x, 1e-5f);
            Assert.AreEqual(k_LocalBounds.center.z, pivot.z, 1e-5f);
        }

        /// <summary>
        /// The builder places the lab at <c>target - rotation * pivot</c>; yaw is about Y, so the model's
        /// lowest point must end up exactly <c>floorOffset</c> below the terrace height.
        /// </summary>
        [Test]
        public void LabPivot_UsedAsBuilderPivot_LowestPointSitsOffsetBelowTerrace()
        {
            const float terraceHeight = 12f;
            const float floorOffset = 0.76f;
            Quaternion rotation = Quaternion.Euler(0f, k_LabYaw, 0f);
            Vector3 target = new Vector3(50f, terraceHeight, -30f);

            Vector3 position = target - rotation * LabTerraceDerivation.LabPivot(k_LocalBounds, floorOffset);
            float lowestWorldY = position.y + k_LocalBounds.min.y;

            Assert.AreEqual(terraceHeight - floorOffset, lowestWorldY, 1e-4f);
        }

        [Test]
        public void DeriveTerrace_YawedLab_TerraceYawMatchesLabYaw()
        {
            Vector2 halfExtents;
            float terraceYaw;

            LabTerraceDerivation.DeriveTerrace(k_LocalBounds, k_LabYaw, k_Margin, out halfExtents, out terraceYaw);

            Assert.AreEqual(k_LabYaw, terraceYaw, 1e-4f);
        }

        /// <summary>
        /// The builder rotates the lab with <c>Quaternion.Euler(0, labYaw, 0)</c> and puts its local
        /// footprint centre on <c>TerraceCenter</c>, so a lab-local point lands at
        /// <c>TerraceCenter + rotation * (localPoint - localCenter)</c>. 35 m along the lab's own +X axis
        /// lies inside the 40 m half-extent; 15 m along its +Z axis lies outside the 10 m one. The
        /// generator's signed distance must agree once the terrace is derived from the same numbers.
        /// </summary>
        [Test]
        public void DeriveTerrace_YawedLab_GeneratorAgreesWithLabWorldTransform()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            p.TerraceCornerRadius = 0f;

            Vector2 halfExtents;
            float terraceYaw;
            LabTerraceDerivation.DeriveTerrace(k_LocalBounds, k_LabYaw, 0f, out halfExtents, out terraceYaw);
            p.TerraceHalfExtents = halfExtents;
            p.TerraceYawDegrees = terraceYaw;

            Quaternion rotation = Quaternion.Euler(0f, k_LabYaw, 0f);
            Vector3 localCenter = k_LocalBounds.center;
            Vector3 insideLocal = localCenter + new Vector3(35f, 0f, 0f);
            Vector3 outsideLocal = localCenter + new Vector3(0f, 0f, 15f);

            Vector3 insideOffset = rotation * (insideLocal - localCenter);
            Vector3 outsideOffset = rotation * (outsideLocal - localCenter);

            float insideDistance = TerrainHeightmapGenerator.TerraceSignedDistance(
                p, p.TerraceCenter.x + insideOffset.x, p.TerraceCenter.y + insideOffset.z);
            float outsideDistance = TerrainHeightmapGenerator.TerraceSignedDistance(
                p, p.TerraceCenter.x + outsideOffset.x, p.TerraceCenter.y + outsideOffset.z);

            Assert.Less(insideDistance, 0f, "35 m along the lab's own +X must be inside the 40 m half-extent");
            Assert.Greater(outsideDistance, 0f, "15 m along the lab's own +Z must be outside the 10 m half-extent");
        }
    }
}
