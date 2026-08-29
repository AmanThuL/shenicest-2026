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
        private const string k_CeilingMaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/BriggsCeiling_Triplanar.mat";
        private const string k_GarageShellPath =
            "Assets/RootsDance/Meshes/Environment/Garage/GarageShell.fbx";
        private const string k_CeilingBaseMapPath =
            "Assets/ThirdParty/Environment/AmbientCG/Concrete032/Concrete032_1K-JPG_Color.jpg";
        private const string k_CeilingNormalMapPath =
            "Assets/ThirdParty/Environment/AmbientCG/Concrete032/Concrete032_1K-JPG_NormalGL.jpg";
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
        public void BriggsEnvironmentScene_ContainsPwbDressingAndLocalInteriorVolume()
        {
            string yaml = File.ReadAllText(k_EnvironmentPath);
            StringAssert.Contains("m_Name: Prefab World Builder", yaml);
            StringAssert.Contains("m_Name: LabFurniture", yaml);
            StringAssert.Contains("m_Name: CampEvidence", yaml);
            StringAssert.Contains("m_Name: LabArchives", yaml);
            StringAssert.Contains("m_Name: LabEcology", yaml);
            StringAssert.Contains("m_Name: LabDebris", yaml);
            StringAssert.Contains("m_Name: LabInteriorLook", yaml);
            StringAssert.Contains("m_IsGlobal: 0", yaml);
            StringAssert.Contains("value: IvyHanging", yaml,
                "The full hanging-ivy prefab must retain the pre-dressing 64792d1 ceiling state.");
            StringAssert.Contains("m_Name: CeilingHoleVines", yaml);
            Assert.AreEqual(1, CountOwnedObject(yaml, "MainHoleVine_Left"));
            Assert.AreEqual(1, CountOwnedObject(yaml, "MainHoleVine_Right"));

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
        public void BriggsEnvironmentScene_Retains647CeilingAndHangingVegetation()
        {
            Scene scene = SceneManager.GetSceneByPath(k_EnvironmentPath);
            bool closeWhenDone = !scene.IsValid() || !scene.isLoaded;

            if (closeWhenDone)
            {
                scene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            try
            {
                Transform geometry = FindRoot(scene, "_Geometry");
                Transform props = FindRoot(scene, "_Props");
                Transform ivy = FindDescendant(geometry, "IvyHanging");
                Transform shell = FindDescendant(geometry, "GarageShell");
                Transform ceiling = FindDescendant(geometry, "Ceiling");
                Transform intactBeam = FindDescendant(geometry, "Ceiling_Beam");
                Transform brokenBeam = FindDescendant(geometry, "Ceiling_Beam_Broken");
                Transform vines = props.Find("CeilingHoleVines");

                Assert.IsTrue(ivy != null);
                Assert.AreEqual(
                    "Assets/RootsDance/Meshes/Environment/Garage/IvyHanging.fbx",
                    PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(ivy.gameObject));
                Assert.That(Vector3.Distance(ivy.localPosition, new Vector3(-0.373f, -0.16892f, -0.488f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Vector3.Distance(ivy.localScale, new Vector3(3.0177207f, 2.110111f, 3.7525582f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Vector3.Distance(
                        shell.localPosition,
                        new Vector3(0f, 0.0000011920929f, 0f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Vector3.Distance(
                        shell.localScale,
                        new Vector3(2.8658316f, 2.003904f, 3.563683f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Quaternion.Angle(
                        shell.localRotation,
                        new Quaternion(0f, 1f, 0f, -0.00000004371139f)),
                    Is.LessThan(k_Tolerance));
                Assert.IsTrue(ceiling != null && intactBeam != null && brokenBeam != null,
                    "The 64792d1 ceiling mesh and both beams must remain present.");
                AssertHistoricalTransform(
                    ceiling,
                    new Vector3(-0.000000000000001f, 2.28f, 0.201f),
                    new Vector3(183.52277f, 322.36707f, 322.36707f));
                AssertHistoricalTransform(
                    intactBeam,
                    new Vector3(2.2463758f, 2.2016478f, 0f),
                    new Vector3(10.94717f, 181.54106f, 10.94717f));
                AssertHistoricalTransform(
                    brokenBeam,
                    new Vector3(-0.443f, 2.412f, -0.073f),
                    new Vector3(10.94717f, 181.54106f, 10.94717f));
                Assert.IsTrue(vines != null);
                Assert.That(Vector3.Distance(vines.localPosition, Vector3.zero), Is.LessThan(k_Tolerance));

                Transform left = vines.Find("MainHoleVine_Left");
                Transform right = vines.Find("MainHoleVine_Right");
                Assert.IsTrue(left != null && right != null);
                Assert.That(Vector3.Distance(left.localPosition, new Vector3(-0.78f, 4.411204f, 2.5f)),
                    Is.LessThan(0.001f));
                Assert.That(Vector3.Distance(right.localPosition, new Vector3(0.98f, 4.4087205f, 2.5f)),
                    Is.LessThan(0.001f));
                Assert.AreEqual(0, vines.GetComponentsInChildren<Collider>(true).Length,
                    "Hanging vines are visual ceiling dressing and must not affect player collision.");
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
        public void BriggsEnvironmentScene_UsesGarageCeilingHoleMeshAndDedicatedTriplanarMaterial()
        {
            Material ceilingMaterial = AssetDatabase.LoadAssetAtPath<Material>(k_CeilingMaterialPath);
            Assert.IsTrue(ceilingMaterial != null, k_CeilingMaterialPath);
            Assert.That(ceilingMaterial.GetFloat("_UVBase"), Is.EqualTo(5f).Within(k_Tolerance),
                "HDRP UV mapping mode 5 is triplanar projection.");
            Assert.That(ceilingMaterial.GetFloat("_TexWorldScale"), Is.EqualTo(2.25f).Within(k_Tolerance));
            Assert.That(Vector4.Distance(
                    ceilingMaterial.GetVector("_UVMappingMask"),
                    new Vector4(1f, 0f, 0f, 0f)),
                Is.LessThan(k_Tolerance));
            Assert.AreEqual(k_CeilingBaseMapPath,
                AssetDatabase.GetAssetPath(ceilingMaterial.GetTexture("_BaseColorMap")));
            Assert.AreEqual(k_CeilingNormalMapPath,
                AssetDatabase.GetAssetPath(ceilingMaterial.GetTexture("_NormalMap")));

            Scene scene = SceneManager.GetSceneByPath(k_EnvironmentPath);
            bool closeWhenDone = !scene.IsValid() || !scene.isLoaded;

            if (closeWhenDone)
            {
                scene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            try
            {
                Transform geometry = FindRoot(scene, "_Geometry");
                string[] ceilingNames = { "Ceiling", "Ceiling_Beam", "Ceiling_Beam_Broken" };

                for (int i = 0; i < ceilingNames.Length; i++)
                {
                    Transform part = FindDescendant(geometry, ceilingNames[i]);
                    Assert.IsTrue(part != null, ceilingNames[i]);
                    MeshFilter filter = part.GetComponent<MeshFilter>();
                    Renderer renderer = part.GetComponent<Renderer>();
                    Assert.IsTrue(filter != null && filter.sharedMesh != null, ceilingNames[i]);
                    Assert.AreEqual(k_GarageShellPath, AssetDatabase.GetAssetPath(filter.sharedMesh),
                        ceilingNames[i] + " must use the authored GarageShell geometry, not a solid proxy plane.");
                    Assert.IsTrue(renderer != null, ceilingNames[i]);

                    for (int materialIndex = 0; materialIndex < renderer.sharedMaterials.Length; materialIndex++)
                    {
                        Assert.AreSame(ceilingMaterial, renderer.sharedMaterials[materialIndex],
                            ceilingNames[i] + " must use the room-specific world-mapped ceiling material.");
                    }
                }

                Mesh ceilingMesh = FindDescendant(geometry, "Ceiling").GetComponent<MeshFilter>().sharedMesh;
                Assert.AreEqual("Ceiling", ceilingMesh.name,
                    "The Garage Ceiling submesh contains the authored roof openings and must not be replaced.");
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
            Assert.That(exposure.fixedExposure.value, Is.EqualTo(9f).Within(k_Tolerance));
            Assert.IsFalse(profile.TryGet(out VisualEnvironment _),
                "The local laboratory profile must inherit MainProfile's sunny exterior sky.");
            Assert.IsFalse(profile.TryGet(out GradientSky _),
                "A local sky override would make the exterior inherit the abandoned-room palette.");
            Assert.IsTrue(profile.TryGet(out Fog fog));
            Assert.IsTrue(fog.enableVolumetricFog.value);
            Assert.AreEqual(FogColorMode.ConstantColor, fog.colorMode.value);
            Assert.That(fog.meanFreePath.value, Is.EqualTo(30f).Within(k_Tolerance));
            Assert.That(fog.anisotropy.value, Is.EqualTo(0.55f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out Bloom bloom));
            Assert.That(bloom.threshold.value, Is.EqualTo(1.2f).Within(k_Tolerance));
            Assert.That(bloom.intensity.value, Is.EqualTo(0.05f).Within(k_Tolerance));
            Assert.IsFalse(profile.TryGet(out WhiteBalance _));
            Assert.IsTrue(profile.TryGet(out ColorAdjustments color));
            Assert.That(color.saturation.value, Is.EqualTo(-8f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out PsxPostProcess psx));
            Assert.IsFalse(psx.grainMode.value);
            Assert.That(psx.intensity.value, Is.EqualTo(1f).Within(k_Tolerance));
            Assert.AreEqual(4, psx.pixelScale.value);
            Assert.AreEqual(32, psx.colorLevels.value);
            Assert.That(psx.ditherStrength.value, Is.EqualTo(0.6f).Within(k_Tolerance));
            Assert.IsFalse(profile.TryGet(out FilmGrain _));
        }

        [Test]
        public void BriggsEnvironmentScene_UsesSunnyVolumetricRoofLight()
        {
            Scene scene = SceneManager.GetSceneByPath(k_EnvironmentPath);
            bool closeWhenDone = !scene.IsValid() || !scene.isLoaded;

            if (closeWhenDone)
            {
                scene = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            try
            {
                Transform lighting = FindRoot(scene, "_Lighting");
                Transform atmosphere = FindRoot(scene, "_LabAtmosphere");
                Light sun = FindDescendant(lighting, "Sun").GetComponent<Light>();
                HDAdditionalLightData sunData = sun.GetComponent<HDAdditionalLightData>();
                LocalVolumetricFog roomFog = FindDescendant(atmosphere, "RoomSmoke_LocalVolumetricFog")
                    .GetComponent<LocalVolumetricFog>();
                Light mainShaft = FindDescendant(atmosphere, "RoofShaft_Main").GetComponent<Light>();
                Light westShaft = FindDescendant(atmosphere, "RoofShaft_West").GetComponent<Light>();

                Assert.That(sun.intensity, Is.EqualTo(100000f).Within(1f));
                Assert.That(sunData.volumetricDimmer, Is.EqualTo(0.22f).Within(k_Tolerance));
                Assert.That(sunData.angularDiameter, Is.EqualTo(0.5f).Within(k_Tolerance));
                Assert.That(roomFog.parameters.meanFreePath, Is.EqualTo(8.5f).Within(k_Tolerance));
                Assert.That(mainShaft.GetComponent<HDAdditionalLightData>().volumetricDimmer,
                    Is.EqualTo(5.5f).Within(k_Tolerance));
                Assert.That(westShaft.GetComponent<HDAdditionalLightData>().volumetricDimmer,
                    Is.EqualTo(3f).Within(k_Tolerance));
                Assert.That(mainShaft.spotAngle, Is.EqualTo(60f).Within(k_Tolerance));
                Assert.That(westShaft.spotAngle, Is.EqualTo(50f).Within(k_Tolerance));
                Assert.AreEqual(LightShadows.Soft, mainShaft.shadows);
                Assert.AreEqual(LightShadows.Soft, westShaft.shadows);
                Assert.That(mainShaft.GetComponent<HDAdditionalLightData>().volumetricShadowDimmer,
                    Is.EqualTo(1f).Within(k_Tolerance));
                Assert.That(westShaft.GetComponent<HDAdditionalLightData>().volumetricShadowDimmer,
                    Is.EqualTo(1f).Within(k_Tolerance));
                Assert.That(Vector3.Distance(
                        mainShaft.transform.localPosition,
                        new Vector3(0.77f, 7.5f, -2.20f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Vector3.Distance(
                        westShaft.transform.localPosition,
                        new Vector3(-4.70f, 7.5f, 0.23f)),
                    Is.LessThan(k_Tolerance));
                Assert.Greater(mainShaft.transform.localPosition.y, 4f);
                Assert.Greater(westShaft.transform.localPosition.y, 4f);
                Assert.That(Quaternion.Angle(mainShaft.transform.rotation, sun.transform.rotation),
                    Is.LessThan(k_Tolerance));
                Assert.That(Quaternion.Angle(westShaft.transform.rotation, sun.transform.rotation),
                    Is.LessThan(k_Tolerance));
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

        private static void AssertHistoricalTransform(
            Transform transform,
            Vector3 expectedPosition,
            Vector3 expectedScale)
        {
            Assert.That(Vector3.Distance(transform.localPosition, expectedPosition),
                Is.LessThan(k_Tolerance), transform.name + " position drifted from 64792d1.");
            Assert.That(Vector3.Distance(transform.localScale, expectedScale),
                Is.LessThan(k_Tolerance), transform.name + " scale drifted from 64792d1.");
            Assert.That(Quaternion.Angle(
                    transform.localRotation,
                    new Quaternion(0.7071069f, 0f, 0f, 0.7071067f)),
                Is.LessThan(k_Tolerance), transform.name + " rotation drifted from 64792d1.");
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
