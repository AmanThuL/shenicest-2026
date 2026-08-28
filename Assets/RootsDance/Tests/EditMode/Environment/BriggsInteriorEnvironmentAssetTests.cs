using System.IO;
using NUnit.Framework;
using RootsDance.Editor.DevPlay;
using RootsDance.Rendering;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>Guards the deterministic Briggs dressing, look and Dev Play alignment assets.</summary>
    public sealed class BriggsInteriorEnvironmentAssetTests
    {
        private const string k_EnvironmentPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_ProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/BriggsInteriorProfile.asset";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_FurnitureFolder = "Assets/RootsDance/Prefabs/Environment/LabFurniture";
        private const float k_Tolerance = 1e-4f;

        private static readonly string[] k_FurnitureNames =
        {
            "LabCounter",
            "ArchiveDesk",
            "ArchiveShelf",
            "TallCabinet",
            "EquipmentBank",
            "BrokenIncubator",
        };

        [Test]
        public void BriggsEnvironmentScene_ContainsPwbDressingAndGlobalVolume()
        {
            string yaml = File.ReadAllText(k_EnvironmentPath);
            StringAssert.Contains("m_Name: Prefab World Builder", yaml);
            StringAssert.Contains("m_Name: LabFurniture", yaml);
            StringAssert.Contains("m_Name: CampEvidence", yaml);
            StringAssert.Contains("m_Name: LabArchives", yaml);
            StringAssert.Contains("m_Name: LabEcology", yaml);
            StringAssert.Contains("m_Name: LabDebris", yaml);
            StringAssert.Contains("m_Name: Global Volume", yaml);
            StringAssert.Contains("m_IsGlobal: 1", yaml);
            Assert.AreEqual(62, CountOccurrences(yaml, "value: BI_") + CountOccurrences(yaml, "m_Name: BI_"));
        }

        [Test]
        public void BriggsProfile_ContainsReferenceLookAndPsxOverrides()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_ProfilePath);
            Assert.IsTrue(profile != null, k_ProfilePath);
            Assert.IsTrue(profile.TryGet(out Exposure exposure));
            Assert.AreEqual(ExposureMode.Fixed, exposure.mode.value);
            Assert.That(exposure.fixedExposure.value, Is.EqualTo(4.5f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out VisualEnvironment environment));
            Assert.AreEqual((int)SkyType.Gradient, environment.skyType.value);
            Assert.IsTrue(profile.TryGet(out GradientSky _));
            Assert.IsTrue(profile.TryGet(out Bloom bloom));
            Assert.That(bloom.intensity.value, Is.EqualTo(0.08f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out WhiteBalance _));
            Assert.IsTrue(profile.TryGet(out ColorAdjustments color));
            Assert.That(color.saturation.value, Is.EqualTo(-20f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out PsxPostProcess psx));
            Assert.IsFalse(psx.grainMode.value);
            Assert.That(psx.intensity.value, Is.EqualTo(1f).Within(k_Tolerance));
            Assert.AreEqual(4, psx.pixelScale.value);
            Assert.AreEqual(32, psx.colorLevels.value);
            Assert.That(psx.ditherStrength.value, Is.EqualTo(0.6f).Within(k_Tolerance));
            Assert.IsFalse(profile.TryGet(out FilmGrain _));
        }

        [Test]
        public void BriggsFurniturePrefabs_ExistWithSimpleRootColliders()
        {
            for (int i = 0; i < k_FurnitureNames.Length; i++)
            {
                string path = k_FurnitureFolder + "/" + k_FurnitureNames[i] + ".prefab";
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(path);
                Assert.IsTrue(prefab != null, path);
                Assert.IsTrue(prefab.GetComponent<BoxCollider>() != null, path + " needs one root BoxCollider");
            }
        }

        [Test]
        public void PlayerPrefab_UsesLegalStandingCapsule()
        {
            GameObject player = AssetDatabase.LoadAssetAtPath<GameObject>(k_PlayerPrefabPath);
            Assert.IsTrue(player != null, k_PlayerPrefabPath);
            CharacterController controller = player.GetComponent<CharacterController>();
            Assert.IsTrue(controller != null);
            Assert.That(controller.height, Is.EqualTo(1.8f).Within(k_Tolerance));
            Assert.That(controller.radius, Is.EqualTo(0.5f).Within(k_Tolerance));
        }

        [TestCase("02-01_LaboratoryEntrance.asset", 3f, 1f, -22.5f, 0f)]
        [TestCase("02-01_PlantResearchLab.asset", 3f, 1f, -5.5f, 0f)]
        [TestCase("02-02_SampleStorage.asset", -4.1f, 1f, -0.7f, 90f)]
        [TestCase("02-03_Greenhouse.asset", 6.8f, 1f, -3.2f, 180f)]
        public void BriggsCheckpoint_UsesAuthoredInteriorPlacement(
            string fileName,
            float x,
            float y,
            float z,
            float yaw)
        {
            const string folder = "Assets/RootsDance/Data/DevPlay/BriggsInterior/";
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(folder + fileName);
            Assert.IsTrue(checkpoint != null, fileName);
            Assert.That(Vector3.Distance(checkpoint.Position, new Vector3(x, y, z)), Is.LessThan(k_Tolerance));
            Assert.That(Mathf.Abs(Mathf.DeltaAngle(checkpoint.Yaw, yaw)), Is.LessThan(k_Tolerance));
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
    }
}
