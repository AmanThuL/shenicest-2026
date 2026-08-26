using NUnit.Framework;
using RootsDance.Editor.Terrain;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Terrain
{
    public class TerrainHeightmapGeneratorTests
    {
        private const float k_Tolerance = 0.6f;

        [TestCase(0f, -10f, 3f, TestName = "wake lowland")]
        [TestCase(-12f, 39f, 6f, TestName = "grass platform")]
        [TestCase(0f, 80f, 7f, TestName = "main gate terrace")]
        [TestCase(44f, 105f, 4f, TestName = "service entrance pocket")]
        [TestCase(0f, 112f, 7f, TestName = "lab centre")]
        public void SampleWorldHeight_SpecAnchor_MatchesSpecHeight(float x, float z, float expected)
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Assert.AreEqual(expected, TerrainHeightmapGenerator.SampleWorldHeight(p, x, z), k_Tolerance);
        }

        [Test]
        public void SampleWorldHeight_AlongMainRoute_RidgeIsHigherThanValleyAndWake()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            float wake = TerrainHeightmapGenerator.SampleWorldHeight(p, 0f, -10f);
            float ridge = TerrainHeightmapGenerator.SampleWorldHeight(p, -7f, 4f);
            float valley = TerrainHeightmapGenerator.SampleWorldHeight(p, -15f, 18f);
            Assert.Greater(ridge, wake + 3f);
            Assert.Greater(ridge, valley + 2.5f);
        }

        [Test]
        public void SampleWorldHeight_InsideTerrace_IsExactlyTerraceHeight()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Assert.AreEqual(p.TerraceHeight, TerrainHeightmapGenerator.SampleWorldHeight(p, 10f, 120f), 1e-3f);
            Assert.AreEqual(p.TerraceHeight, TerrainHeightmapGenerator.SampleWorldHeight(p, -20f, 100f), 1e-3f);
        }

        /// <summary>
        /// Regression test for the sunken service bay that used to punch a 3 m pit through the terrace
        /// under the lab: nothing may disturb the terrace inside the building's world footprint.
        /// </summary>
        [Test]
        public void SampleWorldHeight_InsideLabFootprint_IsTerraceHeight()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            for (float x = -32f; x <= 32f; x += 5f)
            {
                for (float z = 86f; z <= 138f; z += 5f)
                {
                    Assert.AreEqual(p.TerraceHeight, TerrainHeightmapGenerator.SampleWorldHeight(p, x, z),
                        1e-3f, $"lab footprint sample ({x}, {z})");
                }
            }
        }

        [Test]
        public void Generate_DefaultParams_HasHeightmapResolutionAndStaysInsideBox()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            float[,] heights = TerrainHeightmapGenerator.Generate(p);
            Assert.AreEqual(p.HeightmapResolution, heights.GetLength(0));
            Assert.AreEqual(p.HeightmapResolution, heights.GetLength(1));
            float min = 1f;
            float max = 0f;

            foreach (float h in heights)
            {
                min = Mathf.Min(min, h);
                max = Mathf.Max(max, h);
            }

            Assert.GreaterOrEqual(min, 0f);
            Assert.LessOrEqual(max, 1f);
            Assert.Less(max, 0.999f, "heights must not saturate the +40 m ceiling");
        }

        [Test]
        public void Generate_LabCentre_NormalisedHeightMatchesTerraceFloor()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            float[,] heights = TerrainHeightmapGenerator.Generate(p);
            int ix = Mathf.RoundToInt((0f - p.TerrainPosition.x) / p.TerrainSize.x * (p.HeightmapResolution - 1));
            int iz = Mathf.RoundToInt((112f - p.TerrainPosition.z) / p.TerrainSize.z * (p.HeightmapResolution - 1));
            float expected = (p.TerraceHeight - p.TerrainPosition.y) / p.TerrainSize.y;
            Assert.AreEqual(expected, heights[iz, ix], 0.002f);
        }

        [Test]
        public void SampleWorldHeight_MainRouteSlope_StaysBelowLimit()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            PathNode[] nodes = p.Paths[0].Nodes;
            const float step = 0.5f;
            const float limitDegrees = 22f; // spec: aim < 15°, short pitches may be steeper
            for (int i = 0; i < nodes.Length - 1; i++)
            {
                Vector2 a = nodes[i].Position;
                Vector2 b = nodes[i + 1].Position;
                float length = Vector2.Distance(a, b);
                float previous = TerrainHeightmapGenerator.SampleWorldHeight(p, a.x, a.y);
                for (float s = step; s <= length; s += step)
                {
                    Vector2 q = Vector2.Lerp(a, b, s / length);
                    float h = TerrainHeightmapGenerator.SampleWorldHeight(p, q.x, q.y);
                    float degrees = Mathf.Atan2(Mathf.Abs(h - previous), step) * Mathf.Rad2Deg;
                    Assert.Less(degrees, limitDegrees, $"segment {i} at s={s}");
                    previous = h;
                }
            }
        }

        [Test]
        public void WarpedRadius_AtRingCentre_IsSmall()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            float maximumWarp = p.RingWarpAmplitude + p.RingWarpAmplitudeFine + 0.01f;
            Assert.Less(Mathf.Abs(TerrainHeightmapGenerator.WarpedRadius(p, 0f, 112f)), maximumWarp);
        }

        /// <summary>
        /// The world-to-terrace rotation must be the inverse of Unity's Y rotation, not its transpose.
        /// A terrace 40 m half-wide but only 10 m half-deep tells the two apart: 35 m along the terrace's
        /// own +X axis is inside, the same distance along world +Z is well outside.
        /// </summary>
        [Test]
        public void TerraceSignedDistance_YawedTerrace_LocalAxisFollowsUnityRotation()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            p.TerraceYawDegrees = 30f;
            p.TerraceHalfExtents = new Vector2(40f, 10f);

            // A terrace height far from the surrounding ground, so "inside" and "outside" cannot be confused.
            p.TerraceHeight = 30f;

            Vector3 localRight = Quaternion.Euler(0f, p.TerraceYawDegrees, 0f) * Vector3.right;
            float alongLocalX = TerrainHeightmapGenerator.SampleWorldHeight(
                p, p.TerraceCenter.x + 35f * localRight.x, p.TerraceCenter.y + 35f * localRight.z);
            float alongWorldZ = TerrainHeightmapGenerator.SampleWorldHeight(
                p, p.TerraceCenter.x, p.TerraceCenter.y + 35f);

            Assert.AreEqual(p.TerraceHeight, alongLocalX, 1e-3f,
                "35 m along the terrace's own +X axis must sit inside the 40 m half-extent");
            Assert.Greater(Mathf.Abs(alongWorldZ - p.TerraceHeight), 0.2f,
                "35 m along world +Z must sit outside the 10 m half-extent");
        }

        [Test]
        public void TerraceSignedDistance_AtCentre_IsMinusTheSmallerHalfExtent()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            float expected = -Mathf.Min(p.TerraceHalfExtents.x, p.TerraceHalfExtents.y);
            float actual = TerrainHeightmapGenerator.TerraceSignedDistance(
                p, p.TerraceCenter.x, p.TerraceCenter.y);
            Assert.AreEqual(expected, actual, 1e-3f);
        }

        [Test]
        public void TerraceSignedDistance_FarOutsideAlongX_IsTheDistanceToTheEdge()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            const float offset = 100f;
            float actual = TerrainHeightmapGenerator.TerraceSignedDistance(
                p, p.TerraceCenter.x + offset, p.TerraceCenter.y);
            Assert.AreEqual(offset - p.TerraceHalfExtents.x, actual, 1e-3f);
        }

        [Test]
        public void DistanceToPolyline_PointBesideSegment_IsPerpendicularDistanceAndInterpolatedHeight()
        {
            PathNode[] nodes =
            {
                new PathNode { Position = new Vector2(0f, 0f), Height = 0f },
                new PathNode { Position = new Vector2(10f, 0f), Height = 10f },
            };

            float height;
            float distance = TerrainHeightmapGenerator.DistanceToPolyline(nodes, new Vector2(4f, 3f), out height);

            Assert.AreEqual(3f, distance, 1e-4f);
            Assert.AreEqual(4f, height, 1e-4f);
        }

        [Test]
        public void DistanceToPolyline_PointBeyondTheEnd_IsDistanceToEndNodeAndEndHeight()
        {
            PathNode[] nodes =
            {
                new PathNode { Position = new Vector2(0f, 0f), Height = 0f },
                new PathNode { Position = new Vector2(10f, 0f), Height = 10f },
            };

            float height;
            float distance = TerrainHeightmapGenerator.DistanceToPolyline(nodes, new Vector2(16f, 0f), out height);

            Assert.AreEqual(6f, distance, 1e-4f);
            Assert.AreEqual(10f, height, 1e-4f);
        }

        [Test]
        public void DistanceToPolyline_SingleNode_IsDistanceToThatNodeAndItsHeight()
        {
            PathNode[] nodes = { new PathNode { Position = new Vector2(2f, 3f), Height = 4f } };

            float height;
            float distance = TerrainHeightmapGenerator.DistanceToPolyline(nodes, new Vector2(2f, 8f), out height);

            Assert.AreEqual(5f, distance, 1e-4f);
            Assert.AreEqual(4f, height, 1e-4f);
        }
    }
}
