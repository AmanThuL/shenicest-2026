using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using RootsDance.Editor.Terrain;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    public sealed class OpeningAtmosphereParamsTests
    {
        private const float k_TerrainMinX = -144f;
        private const float k_TerrainMaxX = 144f;
        private const float k_TerrainMinZ = -32f;
        private const float k_TerrainMaxZ = 256f;
        private const float k_Tolerance = 1e-3f;

        [Test]
        public void CreateDefault_Segments_PrioritiesStrictlyIncreaseAndBeatTheGlobalVolume()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            Assert.Greater(p.Segments[0].Priority, 0f, "the level Global Volume has priority 0");

            for (int i = 1; i < p.Segments.Length; i++)
            {
                Assert.Greater(p.Segments[i].Priority, p.Segments[i - 1].Priority, p.Segments[i].Name);
            }
        }

        [Test]
        public void CreateDefault_RouteNodes_EachIsFullyInsideSomeSegment()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();

            for (int i = 0; i < p.RouteNodes.Length; i++)
            {
                bool inside = false;

                for (int s = 0; s < p.Segments.Length; s++)
                {
                    inside |= OpeningAtmosphereLayout.Weight(p.Segments[s], p.RouteNodes[i]) >= 1f;
                }

                Assert.IsTrue(inside, $"route node {i} at {p.RouteNodes[i]} is in no box");
            }
        }

        [Test]
        public void CreateDefault_RouteNodes_MatchTheGreyboxMainRoutePlusEyeHeight()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            TerrainGreyboxParams greybox = TerrainGreyboxParams.CreateDefault();
            PathNode[] mainRouteNodes = greybox.Paths[0].Nodes;

            Assert.LessOrEqual(p.RouteNodes.Length, mainRouteNodes.Length,
                "the opening only covers the first nodes of the greybox main route");

            for (int i = 0; i < p.RouteNodes.Length; i++)
            {
                PathNode greyboxNode = mainRouteNodes[i];
                Vector3 expected = new Vector3(
                    greyboxNode.Position.x, greyboxNode.Height + OpeningAtmosphereParams.k_EyeHeight,
                    greyboxNode.Position.y);

                Assert.That(p.RouteNodes[i].x, Is.EqualTo(expected.x).Within(k_Tolerance), $"node {i} x");
                Assert.That(p.RouteNodes[i].y, Is.EqualTo(expected.y).Within(k_Tolerance), $"node {i} y");
                Assert.That(p.RouteNodes[i].z, Is.EqualTo(expected.z).Within(k_Tolerance), $"node {i} z");
            }
        }

        [Test]
        public void CreateDefault_RouteSampledEveryHalfMetre_IsAlwaysCoveredBySomeSegment()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            List<Vector3> samples = OpeningAtmosphereLayout.SampleRoute(p, 0.5f);

            foreach (Vector3 sample in samples)
            {
                Assert.GreaterOrEqual(OpeningAtmosphereLayout.CountCovering(p, sample), 1, $"gap at {sample}");
            }
        }

        [Test]
        public void CreateDefault_Segments_StayInsideTheTerrainBox()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();

            foreach (OpeningSegment s in p.Segments)
            {
                Assert.GreaterOrEqual(s.Center.x - s.Size.x * 0.5f, k_TerrainMinX, s.Name);
                Assert.LessOrEqual(s.Center.x + s.Size.x * 0.5f, k_TerrainMaxX, s.Name);
                Assert.GreaterOrEqual(s.Center.z - s.Size.z * 0.5f, k_TerrainMinZ, s.Name);
                Assert.LessOrEqual(s.Center.z + s.Size.z * 0.5f, k_TerrainMaxZ, s.Name);
                Assert.Greater(s.BlendDistance, 0f, s.Name + " needs a blend zone");
            }
        }

        [Test]
        public void CreateDefault_Segments_NamesFollowTheProfileConvention()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();

            foreach (OpeningSegment s in p.Segments)
            {
                StringAssert.StartsWith("OpeningVolume_", s.Name);
                StringAssert.StartsWith("Opening", s.ProfileName);
                StringAssert.EndsWith("Profile", s.ProfileName);
            }
        }

        [Test]
        public void CreateDefault_Look_VisibilityAndColourRecoverAlongTheRoute()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();

            for (int i = 1; i < p.Segments.Length; i++)
            {
                OpeningLook previous = p.Segments[i - 1].Look;
                OpeningLook current = p.Segments[i].Look;
                Assert.Greater(current.FogAttenuationDistance, previous.FogAttenuationDistance, "fog thins");
                Assert.GreaterOrEqual(current.Saturation, previous.Saturation, "colour returns");
                Assert.GreaterOrEqual(current.PsxColorLevels, previous.PsxColorLevels, "quantisation relaxes");
            }

            OpeningLook last = p.Segments[p.Segments.Length - 1].Look;
            Assert.Greater(p.BeyondFog.AttenuationDistance, last.FogAttenuationDistance,
                "the level fog north of the opening stays milder than the threshold");
            Assert.Less(p.BeyondFog.AttenuationDistance, 100f, "but still hazy all the way to the lab");
        }

        [Test]
        public void CreateDefault_Look_ExposureStaysInTheOvercastRange()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();

            foreach (OpeningSegment s in p.Segments)
            {
                Assert.That(s.Look.FixedExposure, Is.InRange(12f, 13f), s.Name + " (guideline 07 §5.1 overcast)");
                Assert.That(s.Look.PsxIntensity, Is.InRange(0f, 1f), s.Name);
                Assert.That(s.Look.AmbientDimmer, Is.InRange(0f, 1f), s.Name);
                Assert.Greater(s.Look.PsxPixelScale, 0, s.Name);
            }
        }

        [Test]
        public void CreateDefault_Sun_IsOvercastLux()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            Assert.That(p.Sun.IntensityLux, Is.InRange(10000f, 25000f));
            Assert.That(p.Sun.ShadowDimmer, Is.InRange(0f, 1f));
        }

        private static OpeningSegment MakeSyntheticSegment()
        {
            return new OpeningSegment
            {
                Name = "SyntheticSegment", ProfileName = "SyntheticProfile",
                Center = Vector3.zero, Size = new Vector3(10f, 10f, 10f), BlendDistance = 4f, Priority = 1f,
                Look = new OpeningLook(),
            };
        }

        [Test]
        public void Weight_PositionInsideTheBox_IsOne()
        {
            OpeningSegment segment = MakeSyntheticSegment();
            Assert.That(OpeningAtmosphereLayout.Weight(segment, new Vector3(2f, 0f, 0f)), Is.EqualTo(1f));
        }

        [Test]
        public void Weight_HalfTheBlendDistancePastTheSurface_IsPointSeventyFive()
        {
            OpeningSegment segment = MakeSyntheticSegment();
            // Box half-extent 5 + half the 4 m blend distance = 7.
            float weight = OpeningAtmosphereLayout.Weight(segment, new Vector3(7f, 0f, 0f));
            Assert.That(weight, Is.EqualTo(0.75f).Within(k_Tolerance));
        }

        [Test]
        public void Weight_ExactlyOneBlendDistancePastTheSurface_IsZero()
        {
            OpeningSegment segment = MakeSyntheticSegment();
            // Box half-extent 5 + the full 4 m blend distance = 9.
            float weight = OpeningAtmosphereLayout.Weight(segment, new Vector3(9f, 0f, 0f));
            Assert.That(weight, Is.EqualTo(0f).Within(k_Tolerance));
        }

        [Test]
        public void Weight_BeyondTheBlendDistance_IsZero()
        {
            OpeningSegment segment = MakeSyntheticSegment();
            // Box half-extent 5 + 5 m, past the 4 m blend distance.
            float weight = OpeningAtmosphereLayout.Weight(segment, new Vector3(10f, 0f, 0f));
            Assert.That(weight, Is.EqualTo(0f));
        }

        [Test]
        public void CreateDefault_Emitters_MotesStopBeforeTheCampAndSporesOnlyAtTheThreshold()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            float campZ = p.RouteNodes[2].z;
            float thresholdZ = p.RouteNodes[3].z;
            int motes = 0;
            int spores = 0;

            foreach (OpeningVfxEmitter e in p.Emitters)
            {
                if (e.Kind == OpeningVfxKind.ContaminationMotes)
                {
                    motes++;
                    Assert.Less(e.Center.z, campZ, e.Name + " must sit before the camp");
                }
                else
                {
                    spores++;
                    Assert.GreaterOrEqual(e.Center.z, thresholdZ, e.Name + " must sit at the threshold");
                }

                Assert.Greater(e.RateOverTime, 0f, e.Name);
            }

            Assert.Greater(motes, 0);
            Assert.AreEqual(1, spores, "one spore emitter, the doc asks for 极少量孢子");
        }
    }
}
