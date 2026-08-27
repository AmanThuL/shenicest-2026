using NUnit.Framework;
using UnityEditor;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Tests.EditMode.Rendering
{
    /// <summary>
    /// Guards NightProfile.asset — the one profile that has to *add* to the opening atmosphere instead of
    /// replacing it. Skips with <c>Assert.Ignore</c> until RootsDance/Environment/Build Time Of Day (or the
    /// batch -executeMethod equivalent) has run, because that run is the content step of the feature.
    /// </summary>
    public sealed class NightProfileTests
    {
        private const string k_NightProfilePath = "Assets/RootsDance/Settings/VolumeProfiles/NightProfile.asset";

        private static VolumeProfile LoadOrIgnore()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_NightProfilePath);

            if (profile == null)
            {
                Assert.Ignore(k_NightProfilePath + " is missing — run RootsDance/Environment/Build Time Of Day.");
            }

            return profile;
        }

        [Test]
        public void NightProfile_Exposure_IsFixed()
        {
            VolumeProfile profile = LoadOrIgnore();

            Assert.IsTrue(profile.TryGet(out Exposure exposure), "NightProfile: Exposure override");
            Assert.AreEqual(ExposureMode.Fixed, exposure.mode.value, "NightProfile: Exposure must be Fixed");
        }

        [Test]
        public void NightProfile_VisualEnvironment_IsAbsent()
        {
            VolumeProfile profile = LoadOrIgnore();

            Assert.IsFalse(profile.TryGet(out VisualEnvironment _),
                "NightProfile must not carry a VisualEnvironment override — the sky type stays MainProfile's "
                    + "Gradient Sky, this profile only re-colours it.");
        }

        [Test]
        public void NightProfile_Fog_OverridesTheAlbedoButNotTheDensity()
        {
            VolumeProfile profile = LoadOrIgnore();

            Assert.IsTrue(profile.TryGet(out Fog fog), "NightProfile: Fog override");
            Assert.IsFalse(fog.meanFreePath.overrideState,
                "NightProfile must not override Fog Attenuation Distance — the opening volumes own the "
                    + "8 -> 22 -> 40 m density ramp and it has to survive at night.");
            Assert.IsTrue(fog.albedo.overrideState,
                "NightProfile must override the Fog albedo — the cold blue haze is the night look.");
        }
    }
}
