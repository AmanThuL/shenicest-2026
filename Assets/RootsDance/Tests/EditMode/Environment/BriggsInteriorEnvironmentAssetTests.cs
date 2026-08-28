using System.IO;
using NUnit.Framework;
using RootsDance.Editor.DevPlay;
using RootsDance.Rendering;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

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
        private const string k_ArtistModelFolder =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Models";
        private const string k_ArtistMetadataFolder =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Attribution";
        private const string k_ArtistPrefabFolder =
            "Assets/RootsDance/Prefabs/Environment/LabHeroProps";
        private const string k_DressingVariantFolder =
            "Assets/RootsDance/Prefabs/Environment/LabDressingVariants";
        private const float k_Tolerance = 1e-4f;

        private static readonly string[] k_PaletteNames =
        {
            "LabFurniture",
            "CampEvidence",
            "LabArchives",
            "LabEcology",
            "LabDebris",
        };

        private static readonly string[] k_SecondPassSceneNames =
        {
            "BI_CentralIsland_Abandoned",
            "BI_NE_OpticalCalibrator",
            "BI_S8A_ChemistryOldLabTubes",
            "BI_S8B_LabGlassware",
            "BI_S7_SamplingSyringe",
            "BI_S9_NoticeBoard",
            "BI_S9_BrokenClock",
        };

        private static readonly string[] k_ArtistPickNames =
        {
            "Astronomical_Quintant",
            "Chemistry_Old_Lab_Tubes",
            "Lab_Glassware",
            "PSX_Adrenaline_Syringe",
        };

        private static readonly string[] k_FurnitureNames =
        {
            "LabCounter",
            "ArchiveDesk",
            "ArchiveShelf",
            "TallCabinet",
            "EquipmentBank",
            "BrokenIncubator",
            "AbandonedCentralLabIsland",
        };

        private static readonly string[] k_ImportedClutterNames =
        {
            "machine_microscope",
            "bottle_glassware_beaker_large",
            "bottle_glassware_filtering_flask_large",
            "funnel_seperatory_funnel",
            "heating_equipment_bunsen_burner",
            "heating_equipment_iron_stand",
            "heating_equipment_ring_stand",
            "heating_equipment_crucible",
            "syringe_syringe",
            "dish_evaporating_dish",
            "misc_scoopula",
            "ppe_lab_gown_folded",
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

            Assert.AreEqual(0, CountOwnedObjectsWithPrefix(yaml, "BI_CentralCounter_"),
                "The superseded primitive central counters must not survive the rebuild.");

            for (int i = 0; i < k_SecondPassSceneNames.Length; i++)
            {
                Assert.AreEqual(1, CountOwnedObject(yaml, k_SecondPassSceneNames[i]),
                    k_SecondPassSceneNames[i] + " must exist exactly once.");
            }

            Assert.AreEqual(36, CountOwnedObjectsWithPrefix(yaml, "BI_Overgrowth_"));
            Assert.AreEqual(13, CountOwnedObjectsWithPrefix(yaml, "BI_Moss_"));
        }

        [Test]
        public void BriggsEnvironmentScene_OwnedPropsUsePwbPinsAndPreserveGroundAnchors()
        {
            Scene scene = SceneManager.GetSceneByPath(k_EnvironmentPath);
            bool closeWhenDone = !scene.IsValid() || !scene.isLoaded;

            if (closeWhenDone)
            {
                scene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            try
            {
                Transform pwb = FindRoot(scene, "Prefab World Builder");
                Assert.IsTrue(pwb != null, "Prefab World Builder root is missing.");

                for (int i = 0; i < k_PaletteNames.Length; i++)
                {
                    Transform palette = pwb.Find(k_PaletteNames[i]);
                    Assert.IsTrue(palette != null, k_PaletteNames[i] + " palette is missing.");
                    Assert.IsTrue(palette.Find("PIN") != null, k_PaletteNames[i] + "/PIN is missing.");
                    Assert.That(Vector3.Distance(palette.localPosition, Vector3.zero), Is.LessThan(k_Tolerance));
                    Assert.That(Quaternion.Angle(palette.localRotation, Quaternion.identity), Is.LessThan(k_Tolerance));
                    Assert.That(Vector3.Distance(palette.localScale, Vector3.one), Is.LessThan(k_Tolerance));
                }

                for (int i = 0; i < k_SecondPassSceneNames.Length; i++)
                {
                    Transform instance = FindDescendant(pwb, k_SecondPassSceneNames[i]);
                    Assert.IsTrue(instance != null, k_SecondPassSceneNames[i]);
                    Assert.AreEqual("PIN", instance.parent.name, k_SecondPassSceneNames[i]);
                    Assert.AreSame(pwb, instance.parent.parent.parent, k_SecondPassSceneNames[i]);
                    Assert.IsTrue(PrefabUtility.IsAnyPrefabInstanceRoot(instance.gameObject),
                        k_SecondPassSceneNames[i] + " must remain a prefab instance root for PWB editing.");
                }

                AssertGroundAnchor(pwb, "BI_Overgrowth_West_Grass_01", -8.55f, -5.75f, 0.58f);
                AssertGroundAnchor(pwb, "BI_Moss_Central_Patch_01", -2.4f, -3.65f, 0.58f);
            }
            finally
            {
                if (closeWhenDone)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }
            }
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
                Assert.AreEqual(0, prefab.GetComponentsInChildren<MeshCollider>(true).Length,
                    path + " must not introduce mesh collision.");
            }

            string islandPath = k_FurnitureFolder + "/AbandonedCentralLabIsland.prefab";
            GameObject island = AssetDatabase.LoadAssetAtPath<GameObject>(islandPath);
            Assert.AreEqual(3, island.GetComponents<BoxCollider>().Length,
                islandPath + " must retain the three seamless collision bands authored by the builder.");
        }

        [Test]
        public void BriggsArtistPicks_ImportWithoutGeneratedCollidersOrAnimation()
        {
            for (int i = 0; i < k_ArtistPickNames.Length; i++)
            {
                string name = k_ArtistPickNames[i];
                string modelPath = k_ArtistModelFolder + "/" + name + ".fbx";
                string metadataPath = k_ArtistMetadataFolder + "/" + name + ".metadata.json";
                string prefabPath = k_ArtistPrefabFolder + "/" + name + ".prefab";
                ModelImporter importer = AssetImporter.GetAtPath(modelPath) as ModelImporter;
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);

                Assert.IsTrue(importer != null, modelPath);
                Assert.IsFalse(importer.addCollider, modelPath + " must not generate FBX colliders.");
                Assert.IsFalse(importer.importAnimation, modelPath + " is a static environment asset.");
                Assert.IsTrue(AssetDatabase.LoadAssetAtPath<TextAsset>(metadataPath) != null, metadataPath);
                Assert.IsTrue(prefab != null, prefabPath);
                Assert.AreEqual(0, prefab.GetComponentsInChildren<MeshCollider>(true).Length, prefabPath);
            }

            string calibratorPath = k_ArtistPrefabFolder + "/Astronomical_Quintant.prefab";
            GameObject calibrator = AssetDatabase.LoadAssetAtPath<GameObject>(calibratorPath);
            Assert.AreEqual(1, calibrator.GetComponents<BoxCollider>().Length,
                calibratorPath + " needs one simplified floor collider.");

            string[] tabletopNames =
            {
                "Chemistry_Old_Lab_Tubes",
                "Lab_Glassware",
                "PSX_Adrenaline_Syringe",
            };

            for (int i = 0; i < tabletopNames.Length; i++)
            {
                string path = k_DressingVariantFolder + "/" + tabletopNames[i] + "_NoCollision.prefab";
                GameObject variant = AssetDatabase.LoadAssetAtPath<GameObject>(path);
                Assert.IsTrue(variant != null, path);
                AssertHasNoEnabledCollider(variant, path);
            }
        }

        [Test]
        public void BriggsWallProps_ExistWithoutWalkingColliders()
        {
            string[] paths =
            {
                "Assets/RootsDance/Prefabs/Environment/LabArchives/LabNoticeBoard.prefab",
                "Assets/RootsDance/Prefabs/Environment/LabArchives/BrokenVintageWallClock.prefab",
            };

            for (int i = 0; i < paths.Length; i++)
            {
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(paths[i]);
                Assert.IsTrue(prefab != null, paths[i]);
                Assert.AreEqual(0, prefab.GetComponentsInChildren<Collider>(true).Length, paths[i]);
            }
        }

        [Test]
        public void BriggsClutterAndMossPrefabs_ExistWithoutWalkingColliders()
        {
            const string props = "Assets/RootsDance/Prefabs/Environment/Props/";

            for (int i = 0; i < k_ImportedClutterNames.Length; i++)
            {
                string path = props + k_ImportedClutterNames[i] + ".prefab";
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(path);
                Assert.IsTrue(prefab != null, path);
                Assert.AreEqual(0, prefab.GetComponentsInChildren<Collider>(true).Length, path);
            }

            string[] mossPaths =
            {
                "Assets/RootsDance/Prefabs/Environment/LabEcology/MossPatch.prefab",
                "Assets/RootsDance/Prefabs/Environment/LabEcology/MossCarpet.prefab",
            };

            for (int i = 0; i < mossPaths.Length; i++)
            {
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(mossPaths[i]);
                Assert.IsTrue(prefab != null, mossPaths[i]);
                Assert.AreEqual(0, prefab.GetComponentsInChildren<Collider>(true).Length, mossPaths[i]);
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

        private static int CountOwnedObject(string yaml, string name)
        {
            return CountOccurrences(yaml, "value: " + name) + CountOccurrences(yaml, "m_Name: " + name);
        }

        private static int CountOwnedObjectsWithPrefix(string yaml, string prefix)
        {
            return CountOccurrences(yaml, "value: " + prefix) + CountOccurrences(yaml, "m_Name: " + prefix);
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }

        private static Transform FindDescendant(Transform root, string name)
        {
            Transform[] descendants = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < descendants.Length; i++)
            {
                if (descendants[i].name == name)
                {
                    return descendants[i];
                }
            }

            return null;
        }

        private static void AssertGroundAnchor(
            Transform pwb,
            string name,
            float expectedX,
            float expectedZ,
            float expectedScale)
        {
            Transform instance = FindDescendant(pwb, name);
            Assert.IsTrue(instance != null, name);
            Assert.That(instance.localPosition.x, Is.EqualTo(expectedX).Within(k_Tolerance), name);
            Assert.That(instance.localPosition.z, Is.EqualTo(expectedZ).Within(k_Tolerance), name);
            Assert.That(instance.localScale.x, Is.EqualTo(expectedScale).Within(k_Tolerance), name);
            Assert.That(instance.localScale.y, Is.EqualTo(expectedScale).Within(k_Tolerance), name);
            Assert.That(instance.localScale.z, Is.EqualTo(expectedScale).Within(k_Tolerance), name);
        }

        private static void AssertHasNoEnabledCollider(GameObject prefab, string path)
        {
            Collider[] colliders = prefab.GetComponentsInChildren<Collider>(true);

            for (int i = 0; i < colliders.Length; i++)
            {
                Assert.IsFalse(colliders[i].enabled, path + " has an enabled collider at " + colliders[i].name);
            }
        }
    }
}
