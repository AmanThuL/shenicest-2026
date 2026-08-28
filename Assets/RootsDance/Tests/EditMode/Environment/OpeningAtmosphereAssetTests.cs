using System.IO;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using RootsDance.Rendering;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the assets OpeningAtmosphereBuilder produces. They fail until RootsDance/Environment/Build Opening
    /// Atmosphere has run (or the batch -executeMethod equivalent) — that run is the content step of the feature.
    /// </summary>
    public sealed class OpeningAtmosphereAssetTests
    {
        private const string k_MainProfilePath = "Assets/RootsDance/Settings/VolumeProfiles/MainProfile.asset";

        private static VolumeProfile LoadProfile(OpeningAtmosphereParams p, OpeningSegment s)
        {
            string path = OpeningAtmosphereBuilder.ProfilePath(p, s);
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(path);
            Assert.IsTrue(profile != null, path + " is missing — run the opening atmosphere builder");
            return profile;
        }

        [Test]
        public void OpeningProfiles_Exist_WithTheRequiredOverrides()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();

            foreach (OpeningSegment s in p.Segments)
            {
                VolumeProfile profile = LoadProfile(p, s);
                Assert.IsTrue(profile.TryGet(out Exposure exposure), s.ProfileName + ": Exposure");
                Assert.AreEqual(ExposureMode.Fixed, exposure.mode.value, s.ProfileName + ": Exposure must be Fixed");
                Assert.IsTrue(profile.TryGet(out Fog fog), s.ProfileName + ": Fog");
                Assert.IsTrue(fog.enabled.value, s.ProfileName + ": fog enabled");
                Assert.IsTrue(fog.enableVolumetricFog.value, s.ProfileName + ": volumetric fog");
                Assert.IsTrue(profile.TryGet(out VisualEnvironment environment), s.ProfileName + ": VisualEnvironment");
                Assert.AreEqual((int)SkyType.Gradient, environment.skyType.value, s.ProfileName + ": Gradient Sky");
                Assert.IsTrue(profile.TryGet(out GradientSky _), s.ProfileName + ": GradientSky");
                Assert.IsTrue(profile.TryGet(out Tonemapping tonemapping), s.ProfileName + ": Tonemapping");
                Assert.AreEqual(TonemappingMode.Neutral, tonemapping.mode.value, s.ProfileName + ": Neutral");
                Assert.IsTrue(profile.TryGet(out Bloom _), s.ProfileName + ": Bloom");
                Assert.IsTrue(profile.TryGet(out ColorAdjustments _), s.ProfileName + ": ColorAdjustments");
                Assert.IsTrue(profile.TryGet(out Vignette _), s.ProfileName + ": Vignette");
                Assert.IsFalse(profile.TryGet(out FilmGrain _),
                    s.ProfileName + ": HDRP Film Grain must be gone — the PSX grain is the only grain source");
                Assert.IsTrue(profile.TryGet(out PsxPostProcess psx), s.ProfileName + ": PsxPostProcess");
                Assert.Greater(psx.intensity.value, 0f, s.ProfileName + ": PSX intensity");
                Assert.IsFalse(psx.grainMode.value, s.ProfileName + ": PSX mode selected");
                AssertPsxMatches(s.Look.Psx, psx, s.ProfileName);
            }
        }

        [Test]
        public void MainProfile_CarriesThePsxBaseline_SoPsxModeIsAlwaysOn()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            VolumeProfile main = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_MainProfilePath);
            Assert.IsTrue(main != null, k_MainProfilePath);
            Assert.IsTrue(main.TryGet(out PsxPostProcess psx),
                "MainProfile must carry the PSX override — run RootsDance/Rendering/Apply PSX Baseline");
            Assert.IsFalse(psx.grainMode.value, "MainProfile must select PSX rather than grain");
            Assert.Greater(psx.interlaceStrength.value, 0f, "MainProfile interlacing must be on");
            AssertPsxMatches(p.PsxBaseline, psx, "MainProfile");
            Assert.IsFalse(main.TryGet(out FilmGrain _), "MainProfile must not carry HDRP Film Grain");
        }

        private const float k_Tolerance = 1e-4f;

        private static void AssertPsxMatches(PsxLook expected, PsxPostProcess actual, string name)
        {
            Assert.That(actual.intensity.value,
                Is.EqualTo(expected.Intensity).Within(k_Tolerance), name + " intensity");
            Assert.AreEqual(expected.GrainMode, actual.grainMode.value, name + " grainMode");
            Assert.AreEqual(expected.PixelScale, actual.pixelScale.value, name + " pixelScale");
            Assert.AreEqual(expected.ColorLevels, actual.colorLevels.value, name + " colorLevels");
            Assert.That(actual.ditherStrength.value, Is.EqualTo(expected.Dither).Within(k_Tolerance), name + " dither");
            Assert.That(actual.interlaceStrength.value,
                Is.EqualTo(expected.InterlaceStrength).Within(k_Tolerance), name + " interlaceStrength");
            Assert.AreEqual(expected.InterlaceSize, actual.interlaceSize.value, name + " interlaceSize");
            Assert.That(actual.grainIntensity.value, Is.EqualTo(expected.GrainIntensity).Within(k_Tolerance),
                name + " grainIntensity");
            Assert.AreEqual(expected.GrainSize, actual.grainSize.value, name + " grainSize");
            Assert.That(actual.grainRate.value,
                Is.EqualTo(expected.GrainRate).Within(k_Tolerance), name + " grainRate");
            Assert.That(actual.grainShadowBias.value, Is.EqualTo(expected.GrainShadowBias).Within(k_Tolerance),
                name + " grainShadowBias");
            Assert.IsTrue(actual.interlaceStrength.overrideState, name + " interlaceStrength override ticked");
            Assert.IsTrue(actual.interlaceSize.overrideState, name + " interlaceSize override ticked");
            Assert.IsTrue(actual.grainMode.overrideState, name + " grainMode override ticked");
            Assert.IsTrue(actual.grainIntensity.overrideState, name + " grainIntensity override ticked");
        }

        [Test]
        public void MainEnvironmentScene_NamesEveryOpeningVolumeAndEmitter()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            string yaml = File.ReadAllText(p.ScenePath);

            foreach (OpeningSegment s in p.Segments)
            {
                StringAssert.Contains("m_Name: " + s.Name, yaml);
            }

            foreach (OpeningVfxEmitter e in p.Emitters)
            {
                // Prefab instances carry their name as a PrefabInstance modification (`value: <name>`),
                // plain GameObjects as `m_Name: <name>`.
                bool named = yaml.Contains("m_Name: " + e.Name) || yaml.Contains("value: " + e.Name);
                Assert.IsTrue(named, e.Name + " is not in " + p.ScenePath);
            }

            StringAssert.Contains("m_Name: " + OpeningAtmosphereParams.k_VolumeRootName, yaml);
        }

        [Test]
        public void MainEnvironmentScene_OpeningVolumes_AreLocalTriggersWithTheirPriorities()
        {
            OpeningAtmosphereParams p = OpeningAtmosphereParams.CreateDefault();
            string yaml = File.ReadAllText(p.ScenePath);

            foreach (OpeningSegment s in p.Segments)
            {
                string priority = "priority: " + (int)s.Priority;
                StringAssert.Contains(priority, yaml, s.Name + " must serialize its priority");
            }

            const int k_MinLocalTriggerVolumes = 4;
            Assert.GreaterOrEqual(CountOccurrences(yaml, "m_IsGlobal: 0"), k_MinLocalTriggerVolumes,
                "expected at least one Volume per segment marked local (m_IsGlobal: 0)");
            Assert.GreaterOrEqual(CountOccurrences(yaml, "m_IsTrigger: 1"), k_MinLocalTriggerVolumes,
                "expected at least one BoxCollider per segment marked Is Trigger (m_IsTrigger: 1)");
        }

        private static int CountOccurrences(string haystack, string needle)
        {
            int count = 0;
            int index = 0;

            while ((index = haystack.IndexOf(needle, index, System.StringComparison.Ordinal)) >= 0)
            {
                count++;
                index += needle.Length;
            }

            return count;
        }

        [Test]
        public void VfxPrefabs_Exist_ForBothKinds()
        {
            Assert.IsTrue(File.Exists(OpeningVfxPrefabBuilder.PrefabPath(OpeningVfxKind.ContaminationMotes)));
            Assert.IsTrue(File.Exists(OpeningVfxPrefabBuilder.PrefabPath(OpeningVfxKind.AnomalousSpores)));
            Assert.IsTrue(File.Exists(OpeningVfxPrefabBuilder.MaterialPath(OpeningVfxKind.ContaminationMotes)));
            Assert.IsTrue(File.Exists(OpeningVfxPrefabBuilder.MaterialPath(OpeningVfxKind.AnomalousSpores)));
        }
    }
}
