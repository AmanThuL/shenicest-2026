using System.IO;
using NUnit.Framework;
using RootsDance.Editor.DevPlay;
using RootsDance.Editor.Environment;
using RootsDance.Environment;
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
        private const string k_GameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_DoorPrefabPath =
            "Assets/RootsDance/Prefabs/Environment/BriggsAutomaticExitDoor.prefab";
        private const string k_WallsMeshPath =
            "Assets/RootsDance/Meshes/Environment/Garage/BriggsInteriorWalls.fbx";
        private const string k_ProfilePath =
            "Assets/RootsDance/Settings/VolumeProfiles/BriggsInteriorProfile.asset";
        private const string k_CeilingMaterialPath =
            "Assets/RootsDance/Materials/Environment/Garage/GarageCeiling.mat";
        private const string k_GarageShellPath =
            "Assets/RootsDance/Meshes/Environment/Garage/GarageShell.fbx";
        private const string k_PlayerPrefabPath = "Assets/RootsDance/Prefabs/Characters/Player.prefab";
        private const string k_FurnitureFolder = "Assets/RootsDance/Prefabs/Environment/LabFurniture";
        private const string k_ArtistModelFolder =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Models";
        private const string k_ArtistMetadataFolder =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Attribution";
        private const string k_ChemicalTableTexturePath =
            "Assets/ThirdParty/Environment/BriggsArtistPicks/Textures/ChemicalLabTable/verh_stola_albedo.jpg";
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
            "BI_CentralSet_Glassware_Main",
            "BI_CentralSet_OldTubes",
            "BI_CentralSet_IronStand_A",
            "BI_S7_SamplingSyringe",
            "BI_S9_NoticeBoard",
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
        public void BriggsEnvironmentScene_ContainsPwbDressingAnd006bGlobalInteriorVolume()
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
            StringAssert.Contains("value: IvyHanging", yaml,
                "The full hanging-ivy prefab must retain the 006b2dc ceiling state.");
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
        public void BriggsEnvironmentScene_FitsCeilingToRoomAndRetainsHangingVegetation()
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
                Transform assembly = geometry.Find("BriggsCeilingAssembly");
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
                Assert.IsTrue(assembly != null, "The room-scale ceiling assembly is missing.");
                Assert.IsTrue(ceiling != null && intactBeam != null && brokenBeam != null,
                    "The fitted ceiling mesh and both beams must remain present.");
                Assert.AreSame(assembly, ceiling.parent);
                Assert.AreSame(assembly, intactBeam.parent);
                Assert.AreSame(assembly, brokenBeam.parent);
                AssertWorldBounds(
                    ceiling.GetComponent<Renderer>().bounds,
                    new Vector3(0f, 5f, 0f),
                    new Vector3(18.8f, 0.26f, 14.8f),
                    0.01f,
                    "Ceiling");
                AssertWorldBounds(
                    intactBeam.GetComponent<Renderer>().bounds,
                    new Vector3(-6.45f, 4.82f, 0f),
                    new Vector3(0.34f, 0.30f, 14.6f),
                    0.01f,
                    "Ceiling_Beam");
                AssertWorldBounds(
                    brokenBeam.GetComponent<Renderer>().bounds,
                    new Vector3(1.27f, 4.82f, 0.26f),
                    new Vector3(0.42f, 0.34f, 14.6f),
                    0.01f,
                    "Ceiling_Beam_Broken");
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
        public void BriggsScenes_Retain647WallsAndBothDoors()
        {
            Scene environment = SceneManager.GetSceneByPath(k_EnvironmentPath);
            Scene gameplay = SceneManager.GetSceneByPath(k_GameplayPath);
            bool closeEnvironment = !environment.IsValid() || !environment.isLoaded;
            bool closeGameplay = !gameplay.IsValid() || !gameplay.isLoaded;

            if (closeEnvironment)
            {
                environment = EditorSceneManager.OpenScene(k_EnvironmentPath, OpenSceneMode.Additive);
            }

            if (closeGameplay)
            {
                gameplay = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
            }

            try
            {
                Transform geometry = FindRoot(environment, "_Geometry");
                Transform props = FindRoot(environment, "_Props");
                Transform interactables = FindRoot(gameplay, "_Interactables");
                Transform cameras = FindRoot(gameplay, "_Cameras");
                Transform roundWall = FindDescendant(geometry, "Briggs_Wall_North_RoundExit");
                Transform woodenDoor = props.Find("BriggsClosedEntranceDoor");
                Transform automaticDoor = interactables.Find("BriggsAutomaticExitDoor");

                Assert.IsTrue(roundWall != null && woodenDoor != null && automaticDoor != null);
                Assert.AreEqual(k_WallsMeshPath,
                    AssetDatabase.GetAssetPath(roundWall.GetComponent<MeshFilter>().sharedMesh));
                Assert.AreEqual(
                    "Assets/RootsDance/Materials/Environment/Garage/GarageWallWeathered.mat",
                    AssetDatabase.GetAssetPath(roundWall.GetComponent<MeshRenderer>().sharedMaterial));
                Assert.AreEqual(k_GarageShellPath,
                    AssetDatabase.GetAssetPath(
                        woodenDoor.Find("Wooden_Door_Panel").GetComponent<MeshFilter>().sharedMesh));
                Assert.IsTrue(woodenDoor.Find("EntranceLightSeal") != null);
                Assert.That(Vector3.Distance(
                        automaticDoor.localPosition,
                        new Vector3(0f, 0f, 7.15f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Quaternion.Angle(automaticDoor.localRotation, Quaternion.identity),
                    Is.LessThan(k_Tolerance));
                Assert.AreEqual(Vector3.one, automaticDoor.localScale);
                Assert.AreEqual(k_DoorPrefabPath,
                    PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(automaticDoor.gameObject));
                Assert.IsTrue(automaticDoor.GetComponent("AutomaticSlidingDoor") != null);
                Assert.IsTrue(automaticDoor.Find("RuneInlay_Outer") != null);
                Assert.IsTrue(automaticDoor.Find("RuneGlow_Outer") != null);
                Assert.IsTrue(automaticDoor.Find("RuneActivationLight") != null);
                Assert.IsTrue(automaticDoor.Find(
                    "DoorLeaf_Left/RuneInlay_Inner_LeftRoot/RuneInlay_Inner_Left") != null);
                Assert.IsTrue(automaticDoor.Find(
                    "DoorLeaf_Right/RuneInlay_Inner_RightRoot/RuneInlay_Inner_Right") != null);

                for (int band = 0; band < BriggsCorridorGateRuneBuilder.InnerBandCount; band++)
                {
                    Assert.IsTrue(automaticDoor.Find(
                        $"DoorLeaf_Left/RuneInlay_Inner_LeftRoot/RuneGlow_Inner_{band:00}_Left") != null);
                    Assert.IsTrue(automaticDoor.Find(
                        $"DoorLeaf_Right/RuneInlay_Inner_RightRoot/RuneGlow_Inner_{band:00}_Right") != null);
                }

                AutomaticSlidingDoor doorController = automaticDoor.GetComponent<AutomaticSlidingDoor>();
                GateFullscreenShake screenShake = FindDescendant(cameras, "FirstPersonCamera")
                    .GetComponent<GateFullscreenShake>();
                Assert.IsTrue(screenShake != null, "The Briggs camera needs the gate full-screen shake driver.");
                Assert.AreEqual(1, doorController.ActivationStarted.GetPersistentEventCount());
                Assert.AreSame(screenShake, doorController.ActivationStarted.GetPersistentTarget(0));
                Assert.AreEqual("Play", doorController.ActivationStarted.GetPersistentMethodName(0));
                Assert.AreEqual(1, doorController.OpeningFinished.GetPersistentEventCount());
                Assert.AreSame(screenShake, doorController.OpeningFinished.GetPersistentTarget(0));
                Assert.AreEqual("Stop", doorController.OpeningFinished.GetPersistentMethodName(0));
            }
            finally
            {
                if (closeGameplay)
                {
                    EditorSceneManager.CloseScene(gameplay, true);
                }

                if (closeEnvironment)
                {
                    EditorSceneManager.CloseScene(environment, true);
                }
            }
        }

        [Test]
        public void BriggsEnvironmentScene_Uses006bGarageCeilingHoleMeshAndMaterial()
        {
            Material ceilingMaterial = AssetDatabase.LoadAssetAtPath<Material>(k_CeilingMaterialPath);
            Assert.IsTrue(ceilingMaterial != null, k_CeilingMaterialPath);
            Assert.That(ceilingMaterial.GetFloat("_UVBase"), Is.EqualTo(0f).Within(k_Tolerance));

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
                            ceilingNames[i] + " must use the exact 006b2dc Garage ceiling material.");
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
        public void BriggsProfile_Matches006bDarkGreenLookAndLocalPsx()
        {
            VolumeProfile profile = AssetDatabase.LoadAssetAtPath<VolumeProfile>(k_ProfilePath);
            Assert.IsTrue(profile != null, k_ProfilePath);
            Assert.IsTrue(profile.TryGet(out Exposure exposure));
            Assert.AreEqual(ExposureMode.Fixed, exposure.mode.value);
            Assert.That(exposure.fixedExposure.value, Is.EqualTo(4.5f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out VisualEnvironment environment));
            Assert.AreEqual((int)SkyType.Gradient, environment.skyType.value);
            Assert.AreEqual(SkyAmbientMode.Dynamic, environment.skyAmbientMode.value);
            Assert.IsTrue(profile.TryGet(out GradientSky sky));
            Assert.That(sky.exposure.value, Is.EqualTo(-1.2f).Within(k_Tolerance));
            Assert.That(sky.gradientDiffusion.value, Is.EqualTo(1.4f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out Fog fog));
            Assert.IsTrue(fog.enableVolumetricFog.value);
            Assert.AreEqual(FogColorMode.SkyColor, fog.colorMode.value);
            Assert.That(fog.meanFreePath.value, Is.EqualTo(38f).Within(k_Tolerance));
            Assert.That(fog.anisotropy.value, Is.EqualTo(0.62f).Within(k_Tolerance));
            Assert.IsTrue(fog.tint.overrideState);
            Assert.IsTrue(profile.TryGet(out Bloom bloom));
            Assert.That(bloom.intensity.value, Is.EqualTo(0.08f).Within(k_Tolerance));
            Assert.That(bloom.threshold.value, Is.EqualTo(0f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out WhiteBalance whiteBalance));
            Assert.That(whiteBalance.temperature.value, Is.EqualTo(-6f).Within(k_Tolerance));
            Assert.That(whiteBalance.tint.value, Is.EqualTo(-12f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out ColorAdjustments color));
            Assert.That(color.saturation.value, Is.EqualTo(-20f).Within(k_Tolerance));
            Assert.That(color.contrast.value, Is.EqualTo(20f).Within(k_Tolerance));
            Assert.IsTrue(profile.TryGet(out PsxPostProcess psx));
            Assert.IsFalse(psx.grainMode.value);
            Assert.That(psx.intensity.value, Is.EqualTo(1f).Within(k_Tolerance));
            Assert.AreEqual(4, psx.pixelScale.value);
            Assert.AreEqual(32, psx.colorLevels.value);
            Assert.That(psx.ditherStrength.value, Is.EqualTo(0.6f).Within(k_Tolerance));
            Assert.IsFalse(profile.TryGet(out FilmGrain _));
        }

        [Test]
        public void BriggsEnvironmentScene_UsesRoomScaleVolumetricRoofLight()
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

                Assert.That(sun.intensity, Is.EqualTo(18000f).Within(1f));
                Assert.IsFalse(sun.useColorTemperature);
                Assert.That(sunData.volumetricDimmer, Is.EqualTo(0.12f).Within(k_Tolerance));
                Assert.That(sunData.angularDiameter, Is.EqualTo(8f).Within(k_Tolerance));
                Assert.That(roomFog.parameters.meanFreePath, Is.EqualTo(13.5f).Within(k_Tolerance));
                Assert.That(mainShaft.GetComponent<HDAdditionalLightData>().volumetricDimmer,
                    Is.EqualTo(8f).Within(k_Tolerance));
                Assert.That(westShaft.GetComponent<HDAdditionalLightData>().volumetricDimmer,
                    Is.EqualTo(5f).Within(k_Tolerance));
                Assert.That(mainShaft.spotAngle, Is.EqualTo(28f).Within(k_Tolerance));
                Assert.That(westShaft.spotAngle, Is.EqualTo(24f).Within(k_Tolerance));
                Assert.That(mainShaft.range, Is.EqualTo(9f).Within(k_Tolerance));
                Assert.That(westShaft.range, Is.EqualTo(9f).Within(k_Tolerance));
                Assert.That(mainShaft.intensity, Is.EqualTo(LightUnitUtils.ConvertIntensity(
                    mainShaft, 4200f, LightUnit.Lumen, LightUnit.Candela)).Within(0.1f));
                Assert.That(westShaft.intensity, Is.EqualTo(LightUnitUtils.ConvertIntensity(
                    westShaft, 2800f, LightUnit.Lumen, LightUnit.Candela)).Within(0.1f));
                Assert.AreEqual(LightShadows.None, mainShaft.shadows);
                Assert.AreEqual(LightShadows.None, westShaft.shadows);
                Assert.That(mainShaft.GetComponent<HDAdditionalLightData>().volumetricShadowDimmer,
                    Is.EqualTo(0f).Within(k_Tolerance));
                Assert.That(westShaft.GetComponent<HDAdditionalLightData>().volumetricShadowDimmer,
                    Is.EqualTo(0f).Within(k_Tolerance));
                Assert.That(Vector3.Distance(
                        mainShaft.transform.localPosition,
                        new Vector3(0.1f, 5.08f, 2.5f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Vector3.Distance(
                        westShaft.transform.localPosition,
                        new Vector3(-5.35f, 5.08f, 3.75f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Quaternion.Angle(mainShaft.transform.localRotation, Quaternion.Euler(70f, 180f, 0f)),
                    Is.LessThan(k_Tolerance));
                Assert.That(Quaternion.Angle(westShaft.transform.localRotation, Quaternion.Euler(74f, 165f, 0f)),
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

            GameObject islandInstance = PrefabUtility.InstantiatePrefab(island) as GameObject;

            try
            {
                Assert.IsTrue(islandInstance != null, islandPath + " must instantiate for bounds validation.");
                Transform deskHolder = islandInstance.transform.Find("ChemicalLab_AbandonedTable_Model");
                Assert.IsTrue(deskHolder != null,
                    islandPath + " must use the artist-selected ruined chemical table.");
                MeshRenderer deskRenderer = deskHolder.GetComponentInChildren<MeshRenderer>(true);
                Assert.IsTrue(deskRenderer != null, islandPath + " must retain the imported desk mesh.");
                Assert.That(deskRenderer.bounds.size.x, Is.EqualTo(5.2f).Within(0.02f));
                Assert.That(deskRenderer.bounds.size.z, Is.EqualTo(2f).Within(0.02f));
                Assert.That(deskRenderer.bounds.size.y, Is.InRange(1.25f, 1.5f),
                    islandPath + " must retain the faucet above its 0.92 m worktop. Actual: "
                    + deskRenderer.bounds.size);

                bool foundWorktopTexture = false;

                for (int materialIndex = 0; materialIndex < deskRenderer.sharedMaterials.Length; materialIndex++)
                {
                    Material material = deskRenderer.sharedMaterials[materialIndex];

                    if (material != null
                        && AssetDatabase.GetAssetPath(material.GetTexture("_BaseColorMap"))
                        == k_ChemicalTableTexturePath)
                    {
                        foundWorktopTexture = true;
                        break;
                    }
                }

                Assert.IsTrue(foundWorktopTexture,
                    islandPath + " must retain the ruined worktop base-color map.");
            }
            finally
            {
                Object.DestroyImmediate(islandInstance);
            }
        }

        [Test]
        public void BriggsChemicalTable_ImportsAsStaticAttributedSource()
        {
            string modelPath = k_ArtistModelFolder + "/ChemicalLab_AbandonedTable.fbx";
            string metadataPath = k_ArtistMetadataFolder + "/Chemical_Lab_Fallout_4.metadata.json";
            ModelImporter importer = AssetImporter.GetAtPath(modelPath) as ModelImporter;

            Assert.IsTrue(importer != null, modelPath);
            Assert.IsFalse(importer.addCollider, modelPath + " must not generate FBX colliders.");
            Assert.IsFalse(importer.importAnimation, modelPath + " is a static environment asset.");
            Assert.IsTrue(AssetDatabase.LoadAssetAtPath<TextAsset>(metadataPath) != null, metadataPath);
            Assert.IsTrue(AssetDatabase.LoadAssetAtPath<Texture2D>(k_ChemicalTableTexturePath) != null,
                k_ChemicalTableTexturePath);
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

        [Test]
        public void BriggsLegacyEntranceCheckpoint_AfterSetup_DoesNotExist()
        {
            const string path =
                "Assets/RootsDance/Data/DevPlay/BriggsInterior/02-01_LaboratoryEntrance.asset";

            Object asset = AssetDatabase.LoadMainAssetAtPath(path);

            Assert.That(asset, Is.Null);
        }

        [Test]
        public void BriggsGameplayScene_AfterSetup_UsesPlantLabSpawnAndThreeCheckpointAnchors()
        {
            Scene scene = SceneManager.GetSceneByPath(k_GameplayPath);
            bool closeWhenDone = !scene.IsValid() || !scene.isLoaded;

            if (closeWhenDone)
            {
                scene = EditorSceneManager.OpenScene(k_GameplayPath, OpenSceneMode.Additive);
            }

            try
            {
                Transform anchors = FindRoot(scene, "_Anchors");
                Transform spawns = FindRoot(scene, "_Spawns");
                Transform player = FindRoot(scene, "Player");
                Vector3 expectedPosition = new Vector3(3f, 1f, -5.5f);

                Assert.That(anchors, Is.Not.Null);
                Assert.That(spawns, Is.Not.Null);
                Assert.That(player, Is.Not.Null);
                Assert.That(anchors.childCount, Is.EqualTo(3));
                Assert.That(anchors.Find("Checkpoint_LaboratoryEntrance"), Is.Null);
                Assert.That(anchors.Find("Checkpoint_PlantResearchLab"), Is.Not.Null);
                Assert.That(anchors.Find("Checkpoint_SampleStorage"), Is.Not.Null);
                Assert.That(anchors.Find("Checkpoint_Greenhouse"), Is.Not.Null);
                Transform spawn = spawns.Find("PlayerSpawn");
                Assert.That(spawn, Is.Not.Null);
                Assert.That(Vector3.Distance(spawn.position, expectedPosition),
                    Is.LessThan(k_Tolerance));
                Assert.That(Vector3.Distance(player.position, expectedPosition), Is.LessThan(k_Tolerance));
                Assert.That(Mathf.Abs(Mathf.DeltaAngle(spawn.eulerAngles.y, 0f)), Is.LessThan(k_Tolerance));
                Assert.That(Mathf.Abs(Mathf.DeltaAngle(player.eulerAngles.y, 0f)), Is.LessThan(k_Tolerance));
            }
            finally
            {
                if (closeWhenDone)
                {
                    EditorSceneManager.CloseScene(scene, true);
                }
            }
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

        private static void AssertWorldBounds(
            Bounds actual,
            Vector3 expectedCenter,
            Vector3 expectedSize,
            float tolerance,
            string name)
        {
            Assert.That(Vector3.Distance(actual.center, expectedCenter), Is.LessThan(tolerance),
                name + " world center is not aligned to the laboratory roof.");
            Assert.That(Vector3.Distance(actual.size, expectedSize), Is.LessThan(tolerance),
                name + " world size is not fitted to the laboratory roof.");
            Assert.That(actual.size.x, Is.LessThan(20f), name + " must not wrap the laboratory.");
            Assert.That(actual.size.z, Is.LessThan(16f), name + " must not wrap the laboratory.");
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
