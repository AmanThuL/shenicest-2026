using System.IO;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using RootsDance.Editor.Terrain;
using RootsDance.Rendering;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Tests.EditMode.Environment
{
    public sealed class Chapter00ZoneAtmosphereTests
    {
        private const float k_Tolerance = 1e-4f;

        [Test]
        public void Defaults_AreFiveOrderedZones_WithTheReviewedFogRamp()
        {
            Chapter00ZoneAtmosphereParams p = Chapter00ZoneAtmosphereParams.CreateDefault();
            float[] expectedMeanFreePaths = { 9f, 13.5f, 19f, 25.5f, 33f };

            Assert.AreEqual(5, p.Zones.Length);
            Assert.IsEmpty(Chapter00ZoneAtmosphereBuilder.CollectValidationErrors(p));

            for (int i = 0; i < p.Zones.Length; i++)
            {
                Chapter00ZoneDefinition zone = p.Zones[i];
                Assert.AreEqual((Chapter00ZoneId)i, zone.Id);
                Assert.That(zone.Look.MeanFreePath,
                    Is.EqualTo(expectedMeanFreePaths[i]).Within(k_Tolerance), zone.Id.ToString());
                Assert.That(zone.BlendDistance, Is.InRange(6f, 10f), zone.Id + " blend");
            }

            Assert.Less(expectedMeanFreePaths[0], expectedMeanFreePaths[4], "A must be denser than E");
            Assert.Less(expectedMeanFreePaths[4], 40f, "E must remain visibly foggy, not clear air");
        }

        [Test]
        public void Defaults_GeometryTracksTheReviewedTerrainRingsAndTerrace()
        {
            Chapter00ZoneAtmosphereParams p = Chapter00ZoneAtmosphereParams.CreateDefault();
            TerrainGreyboxParams terrain = TerrainGreyboxParams.CreateDefault();

            Assert.AreEqual(Chapter00ZoneVolumeShape.Global, p.Zones[0].Shape);
            AssertSphere(p.Zones[1], terrain.RingRadiusAB, terrain.RingCenter);
            AssertSphere(p.Zones[2], terrain.RingRadiusBC, terrain.RingCenter);
            AssertSphere(p.Zones[3], terrain.RingRadiusCD, terrain.RingCenter);

            Chapter00ZoneDefinition e = p.Zones[4];
            Assert.AreEqual(Chapter00ZoneVolumeShape.Box, e.Shape);
            Assert.That(e.Center.x, Is.EqualTo(terrain.TerraceCenter.x).Within(k_Tolerance));
            Assert.That(e.Center.z, Is.EqualTo(terrain.TerraceCenter.y).Within(k_Tolerance));
            Assert.That(e.BoxSize.x, Is.EqualTo(terrain.TerraceHalfExtents.x * 2f).Within(k_Tolerance));
            Assert.That(e.BoxSize.z, Is.EqualTo(terrain.TerraceHalfExtents.y * 2f).Within(k_Tolerance));
            Assert.That(e.YawDegrees, Is.EqualTo(terrain.TerraceYawDegrees).Within(k_Tolerance));
        }

        [Test]
        public void Defaults_PrioritiesLetOpeningWinAB_AndTimeOfDayRecolourEverything()
        {
            Chapter00ZoneAtmosphereParams zones = Chapter00ZoneAtmosphereParams.CreateDefault();
            OpeningAtmosphereParams opening = OpeningAtmosphereParams.CreateDefault();
            float firstOpeningPriority = opening.Segments[0].Priority;

            Assert.Less(zones.Zones[0].Priority, firstOpeningPriority);
            Assert.Less(zones.Zones[1].Priority, firstOpeningPriority);

            for (int i = 1; i < zones.Zones.Length; i++)
            {
                Assert.Greater(zones.Zones[i].Priority, zones.Zones[i - 1].Priority);
            }
        }

        [Test]
        public void InstalledProfiles_ContainRegionalOverridesButNoBaselineOwners()
        {
            Chapter00ZoneAtmosphereParams p = Chapter00ZoneAtmosphereParams.CreateDefault();

            foreach (Chapter00ZoneDefinition zone in p.Zones)
            {
                string path = Chapter00ZoneAtmosphereBuilder.ProfilePath(p, zone);
                VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(path);
                Assert.IsNotNull(profile, path + " is missing — run the Chapter 00 zone atmosphere builder");
                Assert.IsTrue(profile.TryGet(out Fog fog), zone.Id + ": Fog");
                Assert.IsTrue(fog.enableVolumetricFog.value, zone.Id + ": volumetric fog");
                Assert.IsTrue(profile.TryGet(out ColorAdjustments _), zone.Id + ": ColorAdjustments");
                Assert.IsFalse(profile.TryGet(out Exposure _), zone.Id + ": exposure belongs to baseline/time");
                Assert.IsFalse(profile.TryGet(out VisualEnvironment _), zone.Id + ": sky belongs to baseline");
                Assert.IsFalse(profile.TryGet(out GradientSky _), zone.Id + ": sky belongs to baseline");
                Assert.IsFalse(profile.TryGet(out Tonemapping _), zone.Id + ": tonemapping belongs to baseline");
                Assert.IsFalse(profile.TryGet(out FilmGrain _), zone.Id + ": stock grain must not stack");
                Assert.IsFalse(profile.TryGet(out PsxPostProcess _), zone.Id + ": PSX belongs to MainProfile");
            }
        }

        [Test]
        public void SavedScene_ContainsTheDedicatedRootAndAllZoneNames()
        {
            Chapter00ZoneAtmosphereParams p = Chapter00ZoneAtmosphereParams.CreateDefault();
            string yaml = File.ReadAllText(p.ScenePath);

            StringAssert.Contains("m_Name: " + Chapter00ZoneAtmosphereParams.k_RootName, yaml);

            foreach (Chapter00ZoneDefinition zone in p.Zones)
            {
                StringAssert.Contains("m_Name: " + zone.Name, yaml, zone.Id.ToString());
            }
        }

        private static void AssertSphere(Chapter00ZoneDefinition zone, float radius, Vector2 center)
        {
            Assert.AreEqual(Chapter00ZoneVolumeShape.Sphere, zone.Shape, zone.Id.ToString());
            Assert.That(zone.Radius, Is.EqualTo(radius).Within(k_Tolerance), zone.Id + " radius");
            Assert.That(zone.Center.x, Is.EqualTo(center.x).Within(k_Tolerance), zone.Id + " center x");
            Assert.That(zone.Center.z, Is.EqualTo(center.y).Within(k_Tolerance), zone.Id + " center z");
        }
    }
}
