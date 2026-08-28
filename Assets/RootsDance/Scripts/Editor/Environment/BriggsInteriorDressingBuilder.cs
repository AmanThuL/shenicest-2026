using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the authored prop pass for Briggs Interior under the same PWB hierarchy used by Main Environment.
    /// </summary>
    /// <remarks>
    /// The pass is idempotent. It removes only direct PIN children whose names start with <c>BI_</c>, preserves
    /// hand-painted content, and recreates every owned object as a prefab instance. The north wall's central
    /// circular-door reserve and the four Dev Play checkpoint landing circles remain empty.
    /// </remarks>
    public static class BriggsInteriorDressingBuilder
    {
        private const string k_MenuPath = "RootsDance/Environment/Build Briggs Interior Dressing";
        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity";
        private const string k_PrefabRoot = "Assets/RootsDance/Prefabs/Environment";
        private const string k_FurnitureFolder = k_PrefabRoot + "/LabFurniture";
        private const string k_EcologyFolder = k_PrefabRoot + "/LabEcology";
        private const string k_DressingVariantFolder = k_PrefabRoot + "/LabDressingVariants";
        private const string k_OwnedPrefix = "BI_";
        private const string k_PwbRootName = "Prefab World Builder";
        private const string k_PinName = "PIN";

        private const string k_LabFurniturePalette = "LabFurniture";
        private const string k_CampEvidencePalette = "CampEvidence";
        private const string k_LabArchivesPalette = "LabArchives";
        private const string k_LabEcologyPalette = "LabEcology";
        private const string k_LabDebrisPalette = "LabDebris";

        private const string k_CounterPrefabPath = k_FurnitureFolder + "/LabCounter.prefab";
        private const string k_ArchiveDeskPrefabPath = k_FurnitureFolder + "/ArchiveDesk.prefab";
        private const string k_ArchiveShelfPrefabPath = k_FurnitureFolder + "/ArchiveShelf.prefab";
        private const string k_TallCabinetPrefabPath = k_FurnitureFolder + "/TallCabinet.prefab";
        private const string k_EquipmentBankPrefabPath = k_FurnitureFolder + "/EquipmentBank.prefab";
        private const string k_BrokenIncubatorPrefabPath = k_FurnitureFolder + "/BrokenIncubator.prefab";
        private const string k_NoticeBoardPrefabPath = k_PrefabRoot + "/LabArchives/LabNoticeBoard.prefab";
        private const string k_BrokenClockPrefabPath =
            k_PrefabRoot + "/LabArchives/BrokenVintageWallClock.prefab";
        private const string k_MossPatchPrefabPath = k_EcologyFolder + "/MossPatch.prefab";
        private const string k_MossCarpetPrefabPath = k_EcologyFolder + "/MossCarpet.prefab";

        private const string k_MaterialRoot = "Assets/RootsDance/Materials/Environment";
        private const string k_MetalDarkMaterialPath = k_MaterialRoot + "/Metal_Dark.mat";
        private const string k_MetalRustMaterialPath = k_MaterialRoot + "/Metal_Rust.mat";
        private const string k_ConcreteMaterialPath = k_MaterialRoot + "/Concrete_Pale.mat";
        private const string k_LabPaletteMaterialPath = k_MaterialRoot + "/Lab_Palette.mat";
        private const string k_LabGlassMaterialPath = k_MaterialRoot + "/Lab_Glass.mat";
        private const string k_BriggsMaterialRoot = k_MaterialRoot + "/BriggsInterior";
        private const string k_DustyEquipmentMaterialPath = k_BriggsMaterialRoot + "/LabEquipment_Dusty.mat";
        private const string k_OxideEquipmentMaterialPath = k_BriggsMaterialRoot + "/LabEquipment_Oxide.mat";
        private const string k_MossDarkMaterialPath = k_BriggsMaterialRoot + "/LabMoss_Dark.mat";
        private const string k_MossMidMaterialPath = k_BriggsMaterialRoot + "/LabMoss_Mid.mat";

        private const string k_PropsRoot = k_PrefabRoot + "/Props";
        private const string k_VegetationRoot = k_PrefabRoot + "/Vegetation";
        private const string k_RocksRoot = k_PrefabRoot + "/Rocks";
        private const string k_ThirdPartyLabModelRoot =
            "Assets/ThirdParty/Environment/LabAssetsCC0/Models";

        private static readonly Vector3[] k_CheckpointPositions =
        {
            new Vector3(3f, 0f, -22.5f),
            new Vector3(3f, 0f, -5.5f),
            new Vector3(-4.1f, 0f, -0.7f),
            new Vector3(6.8f, 0f, -3.2f),
        };

        [MenuItem(k_MenuPath)]
        public static void BuildAndSave()
        {
            ThrowIfAnyOpenSceneIsDirty();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
                Scene scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
                int placed = BuildLoadedScene(scene);
                EditorSceneManager.SaveScene(scene);
                AssetDatabase.SaveAssets();
                Debug.Log($"BriggsInteriorDressingBuilder: placed {placed} prefab instances and saved "
                    + $"'{k_ScenePath}'.");
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        /// <summary>
        /// Rebuilds the owned dressing in an already loaded Briggs Interior environment scene.
        /// </summary>
        public static int BuildLoadedScene(Scene scene)
        {
            if (!scene.IsValid() || !scene.isLoaded || scene.path != k_ScenePath)
            {
                throw new InvalidOperationException(
                    "BriggsInteriorDressingBuilder requires the loaded BriggsInterior_Environment scene.");
            }

            EnsureGeneratedDressingPrefabs();
            Placement[] placements = CreatePlacements();
            ValidatePlacements(placements);
            Dictionary<string, string> variants = EnsureColliderlessVariants(placements);
            Dictionary<string, GameObject> prefabs = LoadPrefabs(placements, variants);
            Dictionary<string, Transform> pins = EnsurePalettePins(scene);
            ClearOwnedInstances(pins);

            for (int i = 0; i < placements.Length; i++)
            {
                string prefabPath = ResolvePrefabPath(placements[i], variants);
                Place(placements[i], prefabs[prefabPath], pins[placements[i].Palette]);
            }

            EditorSceneManager.MarkSceneDirty(scene);
            return placements.Length;
        }

        private static Placement[] CreatePlacements()
        {
            List<Placement> placements = new List<Placement>(96);

            AddCentralIsland(placements);
            AddAbandonedTableClutter(placements);
            AddEastRootWorkstation(placements);
            AddWestArchives(placements);
            AddNorthWestCultivation(placements);
            AddNorthEastEquipment(placements);
            AddEcologyIslands(placements);
            AddDebris(placements);
            AddGroundOvergrowth(placements);

            return placements.ToArray();
        }

        private static void AddCentralIsland(List<Placement> placements)
        {
            placements.Add(Furniture(
                "BI_CentralIsland_Abandoned",
                BriggsImportedLabPrefabBuilder.PrefabPath("AbandonedCentralLabIsland"),
                new Vector3(0.1f, 0f, 0.1f),
                90f));

            // S8A, east workface: soil analysis and sample recording.
            placements.Add(ArtistEvidence("BI_S8A_ElectronicScale", "machine_electronic_scale",
                new Vector3(0.62f, 0.94f, -1.85f), new Vector3(0f, 15f, 0f), 0.62f));
            placements.Add(LooseEvidence("BI_S8A_Microscope", "machine_microscope",
                new Vector3(0.55f, 0.94f, -0.85f), new Vector3(0f, 205f, 0f), 0.68f, true));
            placements.Add(Evidence("BI_S8A_PetriDish", "dish_petridish",
                new Vector3(0.58f, 0.94f, -0.05f), 24f, 0.82f));
            placements.Add(Evidence("BI_S8A_WatchGlass", "dish_watch_glass",
                new Vector3(0.72f, 0.94f, 0.45f), -31f, 0.78f));
            placements.Add(ArtistEvidence("BI_S8A_ChemistryOldLabTubes", "Chemistry_Old_Lab_Tubes",
                new Vector3(0.55f, 0.94f, 1.35f), new Vector3(0f, -12f, 0f), 0.45f));
            placements.Add(Evidence("BI_S8A_Thermometer", "heating_equipment_thermometer",
                new Vector3(0.52f, 0.94f, 2.02f), 74f, 0.72f));
            placements.Add(Evidence("BI_S8A_Forceps", "heating_equipment_forceps",
                new Vector3(0.78f, 0.94f, 2.15f), 21f, 0.68f));

            // S8B, west workface: filtration and abandoned liquid analysis.
            placements.Add(ArtistEvidence("BI_S8B_Centrifuge", "machine_centrifuge",
                new Vector3(-0.58f, 0.94f, -1.75f), new Vector3(0f, 25f, 0f), 0.58f));
            placements.Add(LooseEvidence("BI_S8B_FilterFlask", "bottle_glassware_filtering_flask_large",
                new Vector3(-0.62f, 0.94f, -0.75f), new Vector3(0f, -19f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_S8B_RingStand", "heating_equipment_ring_stand",
                new Vector3(-0.55f, 0.94f, 0.15f), new Vector3(0f, 17f, 0f), 0.62f, true));
            placements.Add(ArtistEvidence("BI_S8B_LabGlassware", "Lab_Glassware",
                new Vector3(-0.58f, 0.94f, 1.18f), new Vector3(0f, 14f, 0f), 0.38f));
            placements.Add(ArtistEvidence("BI_S8B_HotPlate", "machine_hot_plate",
                new Vector3(-0.6f, 0.94f, 1.88f), new Vector3(0f, -22f, 0f), 0.55f));
            placements.Add(Evidence("BI_S8B_Dropper", "bottle_dropper",
                new Vector3(-0.76f, 0.94f, 2.22f), 61f, 0.72f));
        }

        private static void AddEastRootWorkstation(List<Placement> placements)
        {
            placements.Add(Furniture(
                "BI_S7_Workbench",
                BriggsImportedLabPrefabBuilder.PrefabPath("AbandonedS7Counter"),
                new Vector3(7.35f, 0f, -0.85f),
                90f));
            placements.Add(Furniture(
                "BI_S7_EquipmentCabinet",
                k_EquipmentBankPrefabPath,
                new Vector3(8.05f, 0f, 1.05f),
                0f));

            placements.Add(Evidence(
                "BI_S7_PetriDish_Normal",
                "dish_petridish",
                new Vector3(7.15f, 0.98f, -1.15f),
                -18f));
            placements.Add(Evidence(
                "BI_S7_PetriDish_Mutated",
                "dish_petridish",
                new Vector3(7.2f, 0.98f, -0.58f),
                26f));
            placements.Add(Evidence(
                "BI_S7_TubeClamp",
                "clamp_tube_clamp",
                new Vector3(7.48f, 0.98f, -0.08f),
                12f));
            placements.Add(Evidence(
                "BI_S7_Gloves",
                "ppe_rubber_gloves",
                new Vector3(7.08f, 0.98f, -0.1f),
                -32f));
            placements.Add(Evidence(
                "BI_S7_SafetyGlasses",
                "ppe_safety_glasses",
                new Vector3(7.38f, 0.98f, -1.48f),
                42f));
            placements.Add(LooseEvidence(
                "BI_S7_Microscope",
                "machine_microscope",
                new Vector3(7.05f, 0.94f, -1.78f),
                new Vector3(0f, 66f, 0f),
                0.58f,
                true));
            placements.Add(ArtistEvidence(
                "BI_S7_SamplingSyringe",
                "PSX_Adrenaline_Syringe",
                new Vector3(7.15f, 0.94f, -0.35f),
                new Vector3(3f, 55f, 78f),
                0.7f));

            placements.Add(Ecology(
                "BI_S7_RootCluster_Wall",
                "root_cluster_02",
                new Vector3(8.35f, 0.05f, -0.25f),
                204f,
                0.72f));
            placements.Add(Ecology(
                "BI_S7_RootCluster_Floor",
                "root_cluster_01",
                new Vector3(8.15f, 0.03f, -2.15f),
                153f,
                0.62f));
            placements.Add(Ecology(
                "BI_S7_SingleRoot",
                "single_root",
                new Vector3(7.85f, 0.04f, 0.62f),
                74f,
                0.58f));
        }

        private static void AddAbandonedTableClutter(List<Placement> placements)
        {
            const float worktop = 0.94f;

            placements.Add(LooseEvidence("BI_CentralClutter_Beaker", "bottle_glassware_beaker_large",
                new Vector3(-0.2f, worktop, -2.25f), new Vector3(0f, -18f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_CentralClutter_SeparatoryFunnel", "funnel_seperatory_funnel",
                new Vector3(0.78f, worktop, -1.28f), new Vector3(0f, -26f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_CentralClutter_IronStand", "heating_equipment_iron_stand",
                new Vector3(-0.78f, worktop, -0.25f), new Vector3(0f, 11f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_CentralClutter_Burner", "heating_equipment_bunsen_burner",
                new Vector3(-0.28f, worktop, 0.35f), new Vector3(0f, 17f, 0f), 0.68f, true));
            placements.Add(LooseEvidence("BI_CentralClutter_Crucible", "heating_equipment_crucible",
                new Vector3(0.28f, worktop, 0.62f), new Vector3(0f, 51f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_CentralClutter_FoldedGown", "ppe_lab_gown_folded",
                new Vector3(-0.72f, worktop, 0.72f), new Vector3(0f, -21f, 0f), 0.52f, true));
            placements.Add(Evidence("BI_CentralClutter_Vial", "bottle_glassware_vial_medium",
                new Vector3(0.25f, worktop, 1.02f), -28f, 0.72f));
            placements.Add(LooseEvidence("BI_CentralClutter_TippedReagent",
                "bottle_glassware_reagent_bottle_medium",
                new Vector3(0.76f, worktop, 1.62f), new Vector3(0f, 16f, 82f), 0.62f));
            placements.Add(LooseEvidence("BI_CentralClutter_WashBottle", "misc_wash_bottle",
                new Vector3(-0.2f, worktop, 1.55f), new Vector3(0f, 34f, 0f), 0.66f));
            placements.Add(Evidence("BI_CentralClutter_SafetyGlasses", "ppe_safety_glasses",
                new Vector3(0.05f, worktop, 2.28f), -62f, 0.62f));
            placements.Add(LooseEvidence("BI_CentralClutter_Scoopula", "misc_scoopula",
                new Vector3(0.25f, worktop, -1.22f), new Vector3(2f, 74f, 6f), 0.68f, true));
            placements.Add(LooseEvidence("BI_CentralClutter_Syringe", "syringe_syringe",
                new Vector3(-0.78f, worktop, -1.08f), new Vector3(4f, 36f, 78f), 0.68f, true));
            placements.Add(ArtistEvidence("BI_CentralClutter_Desiccator", "machine_desiccator",
                new Vector3(0.15f, worktop, -0.22f), new Vector3(0f, -14f, 0f), 0.48f));
            placements.Add(ArtistEvidence("BI_CentralClutter_CentrifugeTube", "machine_centrifuge_tube",
                new Vector3(-0.22f, worktop, 2.02f), new Vector3(0f, 18f, 0f), 0.52f));
        }

        private static void AddWestArchives(List<Placement> placements)
        {
            placements.Add(Furniture(
                "BI_S9_ArchiveDesk",
                k_ArchiveDeskPrefabPath,
                new Vector3(-6.25f, 0f, -2.35f),
                102f));
            placements.Add(Furniture(
                "BI_S9_Shelf_South",
                k_ArchiveShelfPrefabPath,
                new Vector3(-8.15f, 0f, -4.7f),
                90f));
            placements.Add(Furniture(
                "BI_S9_Shelf_North",
                k_ArchiveShelfPrefabPath,
                new Vector3(-8.15f, 0f, -2.95f),
                90f));
            placements.Add(Furniture(
                "BI_S9_FileCabinet",
                k_TallCabinetPrefabPath,
                new Vector3(-8.15f, 0f, -0.65f),
                90f));

            placements.Add(Archive(
                "BI_S9_Clipboard",
                "clipboard",
                new Vector3(-6.12f, 0.86f, -2.15f),
                115f));
            placements.Add(Archive(
                "BI_S9_Binder",
                "binder_notebook",
                new Vector3(-6.45f, 0.86f, -2.58f),
                82f));
            placements.Add(Archive(
                "BI_S9_MagnifyingGlass",
                "misc_magnifying_glass",
                new Vector3(-5.94f, 0.86f, -2.62f),
                28f));
            placements.Add(Archive(
                "BI_S9_HiddenBinder",
                "binder_notebook",
                new Vector3(-6.95f, 0.09f, -1.92f),
                168f,
                0.8f));
            placements.Add(ArtistEvidence(
                "BI_S9_Calculator",
                "machine_calculator_small",
                new Vector3(-6.62f, 0.83f, -2.05f),
                new Vector3(0f, 98f, 0f),
                0.55f));
            placements.Add(ArchivePrefab(
                "BI_S9_NoticeBoard",
                k_NoticeBoardPrefabPath,
                new Vector3(-8.88f, 1.85f, -1.85f),
                new Vector3(0f, 90f, 0f)));
            placements.Add(ArchivePrefab(
                "BI_S9_BrokenClock",
                k_BrokenClockPrefabPath,
                new Vector3(3.75f, 2.55f, 6.86f),
                new Vector3(0f, 180f, 0f)));
        }

        private static void AddNorthWestCultivation(List<Placement> placements)
        {
            placements.Add(Furniture(
                "BI_NW_BrokenIncubator",
                k_BrokenIncubatorPrefabPath,
                new Vector3(-7.25f, 0f, 4.55f),
                12f));
            placements.Add(Furniture(
                "BI_NW_ThermalCabinet",
                BriggsImportedLabPrefabBuilder.PrefabPath("cabinet_cabinet_two_shelves"),
                new Vector3(-4.75f, 0f, 5.85f),
                180f));
        }

        private static void AddNorthEastEquipment(List<Placement> placements)
        {
            placements.Add(Furniture(
                "BI_NE_EquipmentBank",
                k_EquipmentBankPrefabPath,
                new Vector3(7.45f, 0f, 4.35f),
                270f));
            placements.Add(Furniture(
                "BI_NE_DisusedCabinet",
                BriggsImportedLabPrefabBuilder.PrefabPath("cabinet_cabinet"),
                new Vector3(5.45f, 0f, 5.65f),
                180f));
            placements.Add(Furniture(
                "BI_NE_OpticalCalibrator",
                BriggsImportedLabPrefabBuilder.PrefabPath("Astronomical_Quintant"),
                new Vector3(5.65f, 0f, 4.15f),
                235f));
        }

        private static void AddEcologyIslands(List<Placement> placements)
        {
            placements.Add(Ecology(
                "BI_Ecology_NW_Root",
                "pine_roots",
                new Vector3(-6.2f, 0.03f, 5.05f),
                34f,
                0.62f));
            placements.Add(Ecology(
                "BI_Ecology_NW_Fern_01",
                "M3D_fern-1",
                new Vector3(-6.5f, 0f, 3.55f),
                18f,
                0.72f));
            placements.Add(Ecology(
                "BI_Ecology_NW_Fern_02",
                "M3D_fern-2",
                new Vector3(-7.75f, 0f, 3.4f),
                244f,
                0.58f));
            placements.Add(Ecology(
                "BI_Ecology_NW_Ivy",
                "M3D_ivy_3",
                new Vector3(-8.45f, 0.06f, 5.8f),
                144f,
                0.7f));
            placements.Add(Ecology(
                "BI_Ecology_NW_MossRock",
                "rock_moss_04",
                new Vector3(-7.85f, 0.02f, 5.55f),
                41f,
                0.5f));

            placements.Add(Ecology(
                "BI_Ecology_East_Fern",
                "M3D_fern-2",
                new Vector3(8.2f, 0f, 1.95f),
                202f,
                0.62f));
            placements.Add(Ecology(
                "BI_Ecology_East_Ivy",
                "M3D_ivy_1",
                new Vector3(8.45f, 0.02f, 2.75f),
                166f,
                0.72f));
            placements.Add(Ecology(
                "BI_Ecology_East_Grass",
                "M3D_grass_patch_4",
                new Vector3(7.65f, 0f, 2.5f),
                29f,
                0.7f));

            placements.Add(Ecology(
                "BI_Ecology_NE_MossRock",
                "rock_moss_09",
                new Vector3(7.9f, 0.02f, 5.55f),
                121f,
                0.48f));
            placements.Add(Ecology(
                "BI_Ecology_NE_Grass",
                "M3D_grass_patch_7",
                new Vector3(6.75f, 0f, 5.55f),
                258f,
                0.65f));

            placements.Add(Ecology(
                "BI_Ecology_WestSouth_Ivy",
                "M3D_ivy_4",
                new Vector3(-8.25f, 0.02f, -5.85f),
                68f,
                0.65f));
            placements.Add(Ecology(
                "BI_Ecology_WestSouth_Grass",
                "M3D_grass_patch_2",
                new Vector3(-7.25f, 0f, -5.75f),
                178f,
                0.62f));
        }

        private static void AddDebris(List<Placement> placements)
        {
            placements.Add(Debris(
                "BI_Debris_NW_Rock_01",
                "rock_moss_02",
                new Vector3(-8.05f, 0.02f, 2.85f),
                62f,
                0.36f));
            placements.Add(Debris(
                "BI_Debris_NW_Rock_02",
                "rock_moss_07",
                new Vector3(-7.45f, 0.02f, 2.65f),
                153f,
                0.28f));
            placements.Add(Debris(
                "BI_Debris_NE_Rock_01",
                "rock_moss_11",
                new Vector3(8.15f, 0.02f, 3.1f),
                246f,
                0.34f));
            placements.Add(Debris(
                "BI_Debris_NE_Rock_02",
                "rock_moss_05",
                new Vector3(8.4f, 0.02f, 4.05f),
                21f,
                0.25f));
        }

        private static void AddDenseLabClutter(List<Placement> placements)
        {
            const float counterTop = 0.94f;
            const float archiveTop = 0.83f;

            placements.Add(LooseEvidence("BI_Clutter_Central_Microscope", "machine_microscope",
                new Vector3(-0.72f, counterTop, -2.32f), new Vector3(0f, 24f, 0f), 0.75f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_Beaker_01", "bottle_glassware_beaker_large",
                new Vector3(-0.25f, counterTop, -2.12f), new Vector3(0f, -18f, 0f), 0.75f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_FilterFlask", "bottle_glassware_filtering_flask_large",
                new Vector3(0.25f, counterTop, -2.32f), new Vector3(0f, 42f, 0f), 0.7f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_SeparatoryFunnel", "funnel_seperatory_funnel",
                new Vector3(0.7f, counterTop, -2.05f), new Vector3(0f, -26f, 0f), 0.72f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_IronStand", "heating_equipment_iron_stand",
                new Vector3(-0.65f, counterTop, -1.35f), new Vector3(0f, 11f, 0f), 0.72f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_RingStand", "heating_equipment_ring_stand",
                new Vector3(-0.15f, counterTop, -1.55f), new Vector3(0f, -34f, 0f), 0.68f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_Burner", "heating_equipment_bunsen_burner",
                new Vector3(0.3f, counterTop, -1.35f), new Vector3(0f, 17f, 0f), 0.78f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_Crucible", "heating_equipment_crucible",
                new Vector3(0.7f, counterTop, -1.55f), new Vector3(0f, 51f, 0f), 0.75f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_Syringe", "syringe_syringe",
                new Vector3(-0.75f, counterTop, -0.65f), new Vector3(4f, 36f, 78f), 0.8f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_EvaporatingDish", "dish_evaporating_dish",
                new Vector3(-0.3f, counterTop, -0.55f), new Vector3(0f, -12f, 0f), 0.78f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_Scoopula", "misc_scoopula",
                new Vector3(0.15f, counterTop, -0.72f), new Vector3(2f, 74f, 6f), 0.75f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_Gown", "ppe_lab_gown_folded",
                new Vector3(0.65f, counterTop, -0.58f), new Vector3(0f, -21f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_Central_TestTube", "bottle_glassware_test_tube_small",
                new Vector3(-0.7f, counterTop, 0.08f), new Vector3(0f, 31f, 0f), 0.88f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Vial", "bottle_glassware_vial_medium",
                new Vector3(-0.3f, counterTop, -0.05f), new Vector3(0f, -28f, 0f), 0.82f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Dropper", "bottle_dropper",
                new Vector3(0.1f, counterTop, 0.12f), new Vector3(6f, 48f, 74f), 0.82f));
            placements.Add(LooseEvidence("BI_Clutter_Central_TippedReagent", "bottle_glassware_reagent_bottle_medium",
                new Vector3(0.55f, counterTop, -0.08f), new Vector3(0f, 16f, 82f), 0.72f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Petri", "dish_petridish",
                new Vector3(-0.7f, counterTop, 0.72f), new Vector3(0f, 13f, 0f), 0.82f));
            placements.Add(LooseEvidence("BI_Clutter_Central_WatchGlass", "dish_watch_glass",
                new Vector3(-0.25f, counterTop, 0.62f), new Vector3(0f, -46f, 0f), 0.76f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Forceps", "heating_equipment_forceps",
                new Vector3(0.2f, counterTop, 0.78f), new Vector3(2f, 62f, 5f), 0.72f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Thermometer", "heating_equipment_thermometer",
                new Vector3(0.7f, counterTop, 0.62f), new Vector3(0f, 102f, 7f), 0.72f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Clamp", "clamp_tube_clamp",
                new Vector3(-0.65f, counterTop, 1.32f), new Vector3(0f, -13f, 0f), 0.75f));
            placements.Add(LooseEvidence("BI_Clutter_Central_WashBottle", "misc_wash_bottle",
                new Vector3(-0.2f, counterTop, 1.48f), new Vector3(0f, 34f, 0f), 0.78f));
            placements.Add(LooseEvidence("BI_Clutter_Central_TippedPlastic", "bottle_plastic_bottle_medium",
                new Vector3(0.25f, counterTop, 1.3f), new Vector3(3f, -16f, 76f), 0.72f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Rack", "bottle_test_tube_rack",
                new Vector3(0.68f, counterTop, 1.48f), new Vector3(0f, -38f, 0f), 0.78f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Scale", "misc_scale",
                new Vector3(-0.5f, counterTop, 2.15f), new Vector3(0f, 19f, 0f), 0.72f));
            placements.Add(LooseEvidence("BI_Clutter_Central_SafetyGlasses", "ppe_safety_glasses",
                new Vector3(0.05f, counterTop, 2.25f), new Vector3(0f, -62f, 0f), 0.68f));
            placements.Add(LooseEvidence("BI_Clutter_Central_Beaker_02", "bottle_glassware_beaker_large",
                new Vector3(0.58f, counterTop, 2.12f), new Vector3(0f, 41f, 0f), 0.65f, true));

            placements.Add(LooseEvidence("BI_Clutter_S7_Microscope", "machine_microscope",
                new Vector3(7.08f, counterTop, -1.55f), new Vector3(0f, 66f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_Clutter_S7_Funnel", "funnel_seperatory_funnel",
                new Vector3(7.45f, counterTop, -1.42f), new Vector3(0f, -19f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_Clutter_S7_Beaker", "bottle_glassware_beaker_large",
                new Vector3(7.68f, counterTop, -1.12f), new Vector3(0f, 12f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_Clutter_S7_Syringe", "syringe_syringe",
                new Vector3(7.1f, counterTop, -0.84f), new Vector3(4f, 24f, 80f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_S7_Crucible", "heating_equipment_crucible",
                new Vector3(7.55f, counterTop, -0.75f), new Vector3(0f, -42f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_Clutter_S7_RingStand", "heating_equipment_ring_stand",
                new Vector3(7.18f, counterTop, -0.25f), new Vector3(0f, 18f, 0f), 0.56f, true));
            placements.Add(LooseEvidence("BI_Clutter_S7_WashBottle", "misc_wash_bottle",
                new Vector3(7.62f, counterTop, -0.28f), new Vector3(0f, -11f, 0f), 0.62f));

            placements.Add(LooseEvidence("BI_Clutter_NW_Microscope", "machine_microscope",
                new Vector3(-5.75f, counterTop, 3.25f), new Vector3(0f, -22f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_NW_Beaker", "bottle_glassware_beaker_large",
                new Vector3(-5.42f, counterTop, 2.82f), new Vector3(0f, 16f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_NW_FilterFlask", "bottle_glassware_filtering_flask_large",
                new Vector3(-5.02f, counterTop, 2.82f), new Vector3(0f, -39f, 0f), 0.58f, true));
            placements.Add(LooseEvidence("BI_Clutter_NW_Burner", "heating_equipment_bunsen_burner",
                new Vector3(-4.68f, counterTop, 2.95f), new Vector3(0f, 27f, 0f), 0.65f, true));
            placements.Add(LooseEvidence("BI_Clutter_NW_EvaporatingDish", "dish_evaporating_dish",
                new Vector3(-4.38f, counterTop, 3.28f), new Vector3(0f, -18f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_NW_Gown", "ppe_lab_gown_folded",
                new Vector3(-5.55f, counterTop, 2.98f), new Vector3(0f, 38f, 0f), 0.55f, true));

            placements.Add(LooseEvidence("BI_Clutter_NE_IronStand", "heating_equipment_iron_stand",
                new Vector3(5.05f, counterTop, 3.05f), new Vector3(0f, 14f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_NE_Reagent", "bottle_glassware_reagent_bottle_medium",
                new Vector3(5.45f, counterTop, 3.55f), new Vector3(0f, -18f, 0f), 0.72f));
            placements.Add(LooseEvidence("BI_Clutter_NE_Microscope", "machine_microscope",
                new Vector3(5.92f, counterTop, 3f), new Vector3(0f, 32f, 0f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_NE_Scoopula", "misc_scoopula",
                new Vector3(6.28f, counterTop, 3.55f), new Vector3(3f, 88f, 4f), 0.68f, true));
            placements.Add(LooseEvidence("BI_Clutter_NE_Syringe", "syringe_syringe",
                new Vector3(6.52f, counterTop, 3.2f), new Vector3(2f, -28f, 78f), 0.62f, true));
            placements.Add(LooseEvidence("BI_Clutter_NE_Crucible", "heating_equipment_crucible",
                new Vector3(6.25f, counterTop, 2.95f), new Vector3(0f, 25f, 0f), 0.6f, true));

            placements.Add(LooseEvidence("BI_Clutter_S9_Gown", "ppe_lab_gown_folded",
                new Vector3(-6.28f, archiveTop, -1.88f), new Vector3(0f, 84f, 0f), 0.55f, true));
            placements.Add(LooseEvidence("BI_Clutter_S9_SafetyGlasses", "ppe_safety_glasses",
                new Vector3(-6.12f, archiveTop, -2.78f), new Vector3(0f, -31f, 0f), 0.62f));
            placements.Add(LooseEvidence("BI_Clutter_S9_Syringe", "syringe_syringe",
                new Vector3(-6.43f, archiveTop, -2.24f), new Vector3(3f, 68f, 76f), 0.58f, true));
        }

        private static void AddGroundOvergrowth(List<Placement> placements)
        {
            placements.Add(Ecology("BI_Overgrowth_West_Grass_01", "M3D_grass_patch_1", new Vector3(-8.55f, 0f, -5.75f), 18f, 0.58f));
            placements.Add(Ecology("BI_Overgrowth_West_Grass_02", "M3D_grass_patch_3", new Vector3(-8.1f, 0f, -4.65f), 147f, 0.52f));
            placements.Add(Ecology("BI_Overgrowth_West_Grass_03", "M3D_grass_patch_5", new Vector3(-7.05f, 0f, -5.9f), 274f, 0.48f));
            placements.Add(Ecology("BI_Overgrowth_West_Grass_04", "M3D_grass_patch_8", new Vector3(-8.55f, 0f, -3.55f), 63f, 0.44f));
            placements.Add(Ecology("BI_Overgrowth_West_Ivy_01", "M3D_ivy_2", new Vector3(-8.45f, 0f, -1.75f), 188f, 0.5f));
            placements.Add(Ecology("BI_Overgrowth_West_Grass_05", "M3D_grass_patch_6", new Vector3(-8.5f, 0f, 0.75f), 26f, 0.48f));
            placements.Add(Ecology("BI_Overgrowth_West_Grass_06", "M3D_grass_patch_1", new Vector3(-8.25f, 0f, 1.85f), 211f, 0.46f));
            placements.Add(Ecology("BI_Overgrowth_West_Grass_07", "M3D_grass_patch_4", new Vector3(-6.65f, 0f, 2.2f), 102f, 0.4f));
            placements.Add(Ecology("BI_Overgrowth_NorthWest_Grass_01", "M3D_grass_patch_7", new Vector3(-5.75f, 0f, 5.92f), 317f, 0.56f));
            placements.Add(Ecology("BI_Overgrowth_NorthWest_Ivy_01", "M3D_ivy_4", new Vector3(-3.7f, 0f, 6.05f), 79f, 0.52f));

            placements.Add(Ecology("BI_Overgrowth_East_Grass_01", "M3D_grass_patch_2", new Vector3(8.55f, 0f, -5.85f), 34f, 0.55f));
            placements.Add(Ecology("BI_Overgrowth_East_Grass_02", "M3D_grass_patch_5", new Vector3(7.65f, 0f, -5.72f), 172f, 0.5f));
            placements.Add(Ecology("BI_Overgrowth_East_Grass_03", "M3D_grass_patch_8", new Vector3(8.5f, 0f, -4.45f), 247f, 0.48f));
            placements.Add(Ecology("BI_Overgrowth_East_Ivy_01", "M3D_ivy_2", new Vector3(8.5f, 0f, -1.78f), 94f, 0.52f));
            placements.Add(Ecology("BI_Overgrowth_East_Grass_04", "M3D_grass_patch_3", new Vector3(8.55f, 0f, 0.72f), 16f, 0.46f));
            placements.Add(Ecology("BI_Overgrowth_East_Grass_05", "M3D_grass_patch_6", new Vector3(7.72f, 0f, 1.72f), 201f, 0.43f));
            placements.Add(Ecology("BI_Overgrowth_NorthEast_Grass_01", "M3D_grass_patch_1", new Vector3(7.78f, 0f, 5.9f), 128f, 0.52f));
            placements.Add(Ecology("BI_Overgrowth_NorthEast_Ivy_01", "M3D_ivy_3", new Vector3(6.2f, 0f, 6.05f), 289f, 0.48f));
            placements.Add(Ecology("BI_Overgrowth_NorthEast_Grass_02", "M3D_grass_patch_4", new Vector3(4.25f, 0f, 5.95f), 57f, 0.4f));

            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_01", "M3D_grass_patch_7", new Vector3(-2.85f, 0f, -4.85f), 228f, 0.34f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_02", "M3D_grass_patch_2", new Vector3(-2.9f, 0f, 2.85f), 41f, 0.32f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_03", "M3D_grass_patch_6", new Vector3(2.85f, 0f, 2.9f), 163f, 0.3f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_04", "M3D_grass_patch_3", new Vector3(4.25f, 0f, 1.05f), 302f, 0.3f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_05", "M3D_grass_patch_5", new Vector3(-3.45f, 0f, 4.1f), 87f, 0.32f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_06", "M3D_grass_patch_1", new Vector3(1.2f, 0f, -4.2f), 212f, 0.28f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_07", "M3D_grass_patch_8", new Vector3(4.8f, 0f, -4.8f), 37f, 0.3f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_08", "M3D_grass_patch_4", new Vector3(-4.7f, 0f, -4.3f), 151f, 0.32f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_09", "M3D_grass_patch_7", new Vector3(-3.2f, 0f, -2.4f), 276f, 0.28f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_10", "M3D_grass_patch_2", new Vector3(-2.5f, 0f, 0.8f), 64f, 0.26f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_11", "M3D_grass_patch_6", new Vector3(2.5f, 0f, -2f), 186f, 0.28f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_12", "M3D_grass_patch_3", new Vector3(3.8f, 0f, 0.2f), 329f, 0.27f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_13", "M3D_grass_patch_5", new Vector3(4.6f, 0f, 2.3f), 93f, 0.3f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_14", "M3D_grass_patch_1", new Vector3(-4.4f, 0f, 2.2f), 238f, 0.29f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_15", "M3D_grass_patch_8", new Vector3(-5.5f, 0f, 1f), 14f, 0.3f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_16", "M3D_grass_patch_4", new Vector3(1.5f, 0f, 3.4f), 174f, 0.27f));
            placements.Add(Ecology("BI_Overgrowth_Crack_Grass_17", "M3D_grass_patch_7", new Vector3(-1.2f, 0f, 3.5f), 301f, 0.25f));

            placements.Add(EcologyPrefab("BI_Moss_West_Carpet_01", k_MossCarpetPrefabPath, new Vector3(-7.7f, 0f, -4.95f), 22f, 0.9f));
            placements.Add(EcologyPrefab("BI_Moss_West_Patch_01", k_MossPatchPrefabPath, new Vector3(-8.05f, 0f, -2.65f), 141f, 0.82f));
            placements.Add(EcologyPrefab("BI_Moss_West_Patch_02", k_MossPatchPrefabPath, new Vector3(-7.5f, 0f, 0.35f), 263f, 0.7f));
            placements.Add(EcologyPrefab("BI_Moss_NorthWest_Carpet", k_MossCarpetPrefabPath, new Vector3(-6.85f, 0f, 5.45f), 76f, 1.05f));
            placements.Add(EcologyPrefab("BI_Moss_NorthWest_Patch", k_MossPatchPrefabPath, new Vector3(-4.25f, 0f, 5.55f), 181f, 0.88f));
            placements.Add(EcologyPrefab("BI_Moss_East_Carpet_01", k_MossCarpetPrefabPath, new Vector3(8f, 0f, -4.95f), 318f, 0.86f));
            placements.Add(EcologyPrefab("BI_Moss_East_Patch_01", k_MossPatchPrefabPath, new Vector3(8.05f, 0f, -0.75f), 34f, 0.78f));
            placements.Add(EcologyPrefab("BI_Moss_East_Patch_02", k_MossPatchPrefabPath, new Vector3(7.75f, 0f, 2.45f), 117f, 0.76f));
            placements.Add(EcologyPrefab("BI_Moss_NorthEast_Carpet", k_MossCarpetPrefabPath, new Vector3(6.95f, 0f, 5.35f), 251f, 0.95f));
            placements.Add(EcologyPrefab("BI_Moss_Central_Patch_01", k_MossPatchPrefabPath, new Vector3(-2.4f, 0f, -3.65f), 69f, 0.58f));
            placements.Add(EcologyPrefab("BI_Moss_Central_Patch_02", k_MossPatchPrefabPath, new Vector3(2.35f, 0f, -2.35f), 192f, 0.55f));
            placements.Add(EcologyPrefab("BI_Moss_Central_Patch_03", k_MossPatchPrefabPath, new Vector3(-2.25f, 0f, 1.25f), 302f, 0.52f));
            placements.Add(EcologyPrefab("BI_Moss_Central_Patch_04", k_MossPatchPrefabPath, new Vector3(2.35f, 0f, 1.65f), 13f, 0.5f));
        }

        private static Placement Furniture(string name, string path, Vector3 position, float yaw)
        {
            return new Placement(name, k_LabFurniturePalette, path, position, yaw, 1f, false, false);
        }

        private static Placement Evidence(string name, string key, Vector3 position, float yaw, float scale = 1f)
        {
            return new Placement(
                name,
                k_CampEvidencePalette,
                $"{k_PropsRoot}/{key}.prefab",
                position,
                yaw,
                scale,
                true,
                true);
        }

        private static Placement Archive(string name, string key, Vector3 position, float yaw, float scale = 1f)
        {
            return new Placement(
                name,
                k_LabArchivesPalette,
                $"{k_PropsRoot}/{key}.prefab",
                position,
                yaw,
                scale,
                true,
                true);
        }

        private static Placement ArtistEvidence(
            string name,
            string key,
            Vector3 position,
            Vector3 euler,
            float scale)
        {
            return new Placement(
                name,
                k_CampEvidencePalette,
                BriggsImportedLabPrefabBuilder.PrefabPath(key),
                position,
                euler,
                scale,
                true,
                true);
        }

        private static Placement ArchivePrefab(
            string name,
            string path,
            Vector3 position,
            Vector3 euler)
        {
            return new Placement(
                name,
                k_LabArchivesPalette,
                path,
                position,
                euler,
                1f,
                false,
                false);
        }

        private static Placement LooseEvidence(
            string name,
            string key,
            Vector3 position,
            Vector3 euler,
            float scale = 1f,
            bool imported = false)
        {
            return new Placement(
                name,
                k_CampEvidencePalette,
                $"{k_PropsRoot}/{key}.prefab",
                position,
                euler,
                scale * (imported ? 1.25f : 1f),
                !imported,
                true);
        }

        private static Placement EcologyPrefab(
            string name,
            string path,
            Vector3 position,
            float yaw,
            float scale)
        {
            return new Placement(
                name,
                k_LabEcologyPalette,
                path,
                position,
                yaw,
                scale,
                false,
                true);
        }

        private static Placement Ecology(string name, string key, Vector3 position, float yaw, float scale)
        {
            string root = key.StartsWith("M3D_", StringComparison.Ordinal) ? k_VegetationRoot : k_RocksRoot;
            return new Placement(
                name,
                k_LabEcologyPalette,
                $"{root}/{key}.prefab",
                position,
                yaw,
                scale,
                true,
                true);
        }

        private static Placement Debris(string name, string key, Vector3 position, float yaw, float scale)
        {
            return new Placement(
                name,
                k_LabDebrisPalette,
                $"{k_RocksRoot}/{key}.prefab",
                position,
                yaw,
                scale,
                true,
                true);
        }

        private static void Place(Placement placement, GameObject prefab, Transform parent)
        {
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parent);

            if (instance == null)
            {
                throw new InvalidOperationException("Could not instantiate prefab: " + placement.PrefabPath);
            }

            instance.name = placement.Name;
            instance.transform.SetLocalPositionAndRotation(
                placement.Position,
                Quaternion.Euler(placement.Euler));
            instance.transform.localScale = prefab.transform.localScale * placement.Scale;

            if (placement.SnapToSurface)
            {
                SnapRendererBottomToSurface(instance, ResolveSurfaceY(placement.Position.y));
            }
        }

        private static float ResolveSurfaceY(float authoredY)
        {
            if (authoredY < 0.2f)
            {
                return 0f;
            }

            if (authoredY > 0.95f)
            {
                return 0.94f;
            }

            if (authoredY > 0.8f && authoredY < 0.9f)
            {
                return 0.83f;
            }

            return authoredY;
        }

        private static void SnapRendererBottomToSurface(GameObject instance, float surfaceY)
        {
            Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException("Cannot surface-snap a prefab with no renderers: " + instance.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            Vector3 position = instance.transform.position;
            position.y += surfaceY - bounds.min.y + 0.002f;
            instance.transform.position = position;
        }

        private static Dictionary<string, GameObject> LoadPrefabs(
            Placement[] placements,
            IReadOnlyDictionary<string, string> variants)
        {
            Dictionary<string, GameObject> prefabs = new Dictionary<string, GameObject>();

            for (int i = 0; i < placements.Length; i++)
            {
                string path = ResolvePrefabPath(placements[i], variants);

                if (prefabs.ContainsKey(path))
                {
                    continue;
                }

                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(path);

                if (prefab == null)
                {
                    throw new System.IO.FileNotFoundException("Briggs dressing prefab is missing: " + path);
                }

                prefabs.Add(path, prefab);
            }

            return prefabs;
        }

        private static Dictionary<string, string> EnsureColliderlessVariants(Placement[] placements)
        {
            EnsureFolder(k_DressingVariantFolder);
            Dictionary<string, string> variants = new Dictionary<string, string>();
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                for (int i = 0; i < placements.Length; i++)
                {
                    Placement placement = placements[i];

                    if (!placement.DisableColliders || variants.ContainsKey(placement.PrefabPath))
                    {
                        continue;
                    }

                    GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(placement.PrefabPath);

                    if (source == null)
                    {
                        throw new System.IO.FileNotFoundException(
                            "Briggs dressing source prefab is missing: " + placement.PrefabPath);
                    }

                    string sourceName = System.IO.Path.GetFileNameWithoutExtension(placement.PrefabPath);
                    string variantPath = k_DressingVariantFolder + "/" + sourceName + "_NoCollision.prefab";
                    GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(source, preview);

                    try
                    {
                        instance.name = sourceName + "_NoCollision";
                        Collider[] colliders = instance.GetComponentsInChildren<Collider>(true);

                        for (int colliderIndex = 0; colliderIndex < colliders.Length; colliderIndex++)
                        {
                            colliders[colliderIndex].enabled = false;
                        }

                        bool saved;
                        PrefabUtility.SaveAsPrefabAsset(instance, variantPath, out saved);

                        if (!saved)
                        {
                            throw new InvalidOperationException(
                                "Could not save Briggs colliderless prefab variant: " + variantPath);
                        }
                    }
                    finally
                    {
                        UnityEngine.Object.DestroyImmediate(instance);
                    }

                    variants.Add(placement.PrefabPath, variantPath);
                }
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }

            return variants;
        }

        private static string ResolvePrefabPath(
            Placement placement,
            IReadOnlyDictionary<string, string> variants)
        {
            if (placement.DisableColliders)
            {
                return variants[placement.PrefabPath];
            }

            return placement.PrefabPath;
        }

        private static Dictionary<string, Transform> EnsurePalettePins(Scene scene)
        {
            if (SceneManager.GetActiveScene() != scene)
            {
                SceneManager.SetActiveScene(scene);
            }

            Transform root = FindSceneRoot(scene, k_PwbRootName);

            if (root == null)
            {
                GameObject created = new GameObject(k_PwbRootName);
                SceneManager.MoveGameObjectToScene(created, scene);
                root = created.transform;
            }

            root.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.localScale = Vector3.one;

            string[] palettes =
            {
                k_LabFurniturePalette,
                k_CampEvidencePalette,
                k_LabArchivesPalette,
                k_LabEcologyPalette,
                k_LabDebrisPalette,
            };
            Dictionary<string, Transform> pins = new Dictionary<string, Transform>(palettes.Length);

            for (int i = 0; i < palettes.Length; i++)
            {
                Transform palette = EnsureDirectChild(root, palettes[i]);
                pins.Add(palettes[i], EnsureDirectChild(palette, k_PinName));
            }

            return pins;
        }

        private static Transform EnsureDirectChild(Transform parent, string name)
        {
            Transform child = parent.Find(name);

            if (child != null)
            {
                return child;
            }

            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            return created.transform;
        }

        private static Transform FindSceneRoot(Scene scene, string name)
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

        private static void ClearOwnedInstances(Dictionary<string, Transform> pins)
        {
            foreach (Transform pin in pins.Values)
            {
                for (int i = pin.childCount - 1; i >= 0; i--)
                {
                    Transform child = pin.GetChild(i);

                    if (IsOwnedInstance(child))
                    {
                        UnityEngine.Object.DestroyImmediate(child.gameObject);
                    }
                }
            }
        }

        private static bool IsOwnedInstance(Transform child)
        {
            if (child.name.StartsWith(k_OwnedPrefix, StringComparison.Ordinal))
            {
                return true;
            }

            PropertyModification[] modifications =
                PrefabUtility.GetPropertyModifications(child.gameObject);

            if (modifications == null)
            {
                return false;
            }

            for (int i = 0; i < modifications.Length; i++)
            {
                PropertyModification modification = modifications[i];

                if (modification.propertyPath == "m_Name"
                    && modification.value != null
                    && modification.value.StartsWith(k_OwnedPrefix, StringComparison.Ordinal))
                {
                    return true;
                }
            }

            return false;
        }

        private static void ValidatePlacements(Placement[] placements)
        {
            HashSet<string> names = new HashSet<string>();

            for (int i = 0; i < placements.Length; i++)
            {
                Placement placement = placements[i];

                if (!names.Add(placement.Name))
                {
                    throw new InvalidOperationException("Duplicate Briggs dressing object name: " + placement.Name);
                }

                if (!placement.Name.StartsWith(k_OwnedPrefix, StringComparison.Ordinal))
                {
                    throw new InvalidOperationException("Owned Briggs dressing names must start with BI_.");
                }

                if (Mathf.Abs(placement.Position.x) < 2.75f && placement.Position.z > 4.4f)
                {
                    throw new InvalidOperationException(
                        "A Briggs dressing prop intrudes into the north circular-door reserve: " + placement.Name);
                }

                for (int checkpoint = 0; checkpoint < k_CheckpointPositions.Length; checkpoint++)
                {
                    Vector2 delta = new Vector2(
                        placement.Position.x - k_CheckpointPositions[checkpoint].x,
                        placement.Position.z - k_CheckpointPositions[checkpoint].z);

                    if (delta.sqrMagnitude < 1.44f)
                    {
                        throw new InvalidOperationException(
                            "A Briggs dressing prop intrudes into a checkpoint landing circle: " + placement.Name);
                    }
                }
            }
        }

        private static void EnsureGeneratedDressingPrefabs()
        {
            EnsureFolder(k_FurnitureFolder);
            EnsureFolder(k_EcologyFolder);
            BriggsImportedLabPrefabBuilder.EnsureAll();
            BriggsInteriorWallPropPrefabBuilder.EnsureLabNoticeBoardPrefab();
            BriggsInteriorWallPropPrefabBuilder.EnsureBrokenVintageWallClockPrefab();
            FurnitureMaterials materials = LoadFurnitureMaterials();
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                BuildCounterPrefab(preview, materials);
                BuildArchiveDeskPrefab(preview, materials);
                BuildArchiveShelfPrefab(preview, materials);
                BuildTallCabinetPrefab(preview, materials);
                BuildEquipmentBankPrefab(preview, materials);
                BuildBrokenIncubatorPrefab(preview, materials);
                BuildMossPatchPrefab(preview, materials);
                BuildMossCarpetPrefab(preview, materials);
                BuildImportedLabPropPrefabs(preview, materials);
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }
        }

        private static void BuildCounterPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("LabCounter", preview);

            try
            {
                AddCube(root.transform, "Cabinet", new Vector3(0f, 0.43f, 0f),
                    new Vector3(1.7f, 0.78f, 0.68f), materials.MetalDark);
                AddCube(root.transform, "Worktop", new Vector3(0f, 0.88f, 0f),
                    new Vector3(1.78f, 0.12f, 0.76f), materials.Concrete);
                AddCube(root.transform, "ToeKick", new Vector3(0f, 0.09f, -0.02f),
                    new Vector3(1.58f, 0.18f, 0.58f), materials.MetalRust);
                AddCube(root.transform, "DrawerLine", new Vector3(0f, 0.67f, -0.348f),
                    new Vector3(1.48f, 0.05f, 0.025f), materials.LabPalette);
                AddRootBoxCollider(root, new Vector3(0f, 0.47f, 0f), new Vector3(1.78f, 0.94f, 0.76f));
                SavePrefab(root, k_CounterPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildArchiveDeskPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("ArchiveDesk", preview);

            try
            {
                AddCube(root.transform, "Desktop", new Vector3(0f, 0.78f, 0f),
                    new Vector3(1.65f, 0.1f, 0.72f), materials.Concrete);
                AddCube(root.transform, "LeftPedestal", new Vector3(-0.62f, 0.37f, 0f),
                    new Vector3(0.36f, 0.72f, 0.62f), materials.MetalDark);
                AddCube(root.transform, "RightPedestal", new Vector3(0.62f, 0.37f, 0f),
                    new Vector3(0.36f, 0.72f, 0.62f), materials.MetalDark);
                AddCube(root.transform, "BackBrace", new Vector3(0f, 0.39f, 0.3f),
                    new Vector3(1.25f, 0.08f, 0.08f), materials.MetalRust);
                AddRootBoxCollider(root, new Vector3(0f, 0.41f, 0f), new Vector3(1.65f, 0.82f, 0.72f));
                SavePrefab(root, k_ArchiveDeskPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildArchiveShelfPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("ArchiveShelf", preview);

            try
            {
                AddCube(root.transform, "LeftSide", new Vector3(-0.7f, 1.08f, 0f),
                    new Vector3(0.1f, 2.16f, 0.38f), materials.MetalDark);
                AddCube(root.transform, "RightSide", new Vector3(0.7f, 1.08f, 0f),
                    new Vector3(0.1f, 2.16f, 0.38f), materials.MetalDark);
                AddCube(root.transform, "Back", new Vector3(0f, 1.08f, 0.17f),
                    new Vector3(1.5f, 2.16f, 0.05f), materials.MetalRust);

                for (int i = 0; i < 5; i++)
                {
                    float y = 0.08f + i * 0.5f;
                    AddCube(root.transform, $"Shelf_{i + 1:00}", new Vector3(0f, y, 0f),
                        new Vector3(1.5f, 0.08f, 0.42f), materials.MetalDark);
                }

                AddRootBoxCollider(root, new Vector3(0f, 1.08f, 0f), new Vector3(1.5f, 2.16f, 0.42f));
                SavePrefab(root, k_ArchiveShelfPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildTallCabinetPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("TallCabinet", preview);

            try
            {
                AddCube(root.transform, "Body", new Vector3(0f, 1.02f, 0f),
                    new Vector3(1.05f, 2.04f, 0.56f), materials.MetalDark);
                AddCube(root.transform, "LeftDoor", new Vector3(-0.26f, 1.05f, -0.295f),
                    new Vector3(0.48f, 1.86f, 0.035f), materials.LabPalette);
                AddCube(root.transform, "RightDoor", new Vector3(0.26f, 1.05f, -0.295f),
                    new Vector3(0.48f, 1.86f, 0.035f), materials.LabPalette);
                AddCube(root.transform, "RustBand", new Vector3(0f, 0.24f, -0.318f),
                    new Vector3(0.92f, 0.08f, 0.025f), materials.MetalRust);
                AddRootBoxCollider(root, new Vector3(0f, 1.02f, 0f), new Vector3(1.05f, 2.04f, 0.6f));
                SavePrefab(root, k_TallCabinetPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildEquipmentBankPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("EquipmentBank", preview);

            try
            {
                AddCube(root.transform, "Body", new Vector3(0f, 0.86f, 0f),
                    new Vector3(1.35f, 1.72f, 0.72f), materials.MetalDark);
                AddCube(root.transform, "ControlPanel", new Vector3(0f, 1.22f, -0.39f),
                    new Vector3(1.15f, 0.58f, 0.08f), materials.LabPalette);
                AddCube(root.transform, "LowerVent", new Vector3(0f, 0.42f, -0.39f),
                    new Vector3(1.08f, 0.36f, 0.08f), materials.MetalRust);

                for (int i = 0; i < 3; i++)
                {
                    AddCylinder(root.transform, $"Gauge_{i + 1:00}", new Vector3(-0.4f + i * 0.4f, 1.3f, -0.45f),
                        new Vector3(0.12f, 0.04f, 0.12f), new Vector3(90f, 0f, 0f), materials.Concrete);
                }

                AddRootBoxCollider(root, new Vector3(0f, 0.86f, 0f), new Vector3(1.35f, 1.72f, 0.8f));
                SavePrefab(root, k_EquipmentBankPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildBrokenIncubatorPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("BrokenIncubator", preview);

            try
            {
                AddCube(root.transform, "Base", new Vector3(0f, 0.25f, 0f),
                    new Vector3(1.35f, 0.5f, 0.82f), materials.MetalDark);
                AddCube(root.transform, "Top", new Vector3(0f, 1.9f, 0f),
                    new Vector3(1.35f, 0.14f, 0.82f), materials.MetalRust);
                AddCube(root.transform, "LeftFrame", new Vector3(-0.61f, 1.15f, 0f),
                    new Vector3(0.12f, 1.5f, 0.82f), materials.MetalDark);
                AddCube(root.transform, "RightFrame", new Vector3(0.61f, 1.15f, 0f),
                    new Vector3(0.12f, 1.5f, 0.82f), materials.MetalDark);
                AddCube(root.transform, "BackGlass", new Vector3(0f, 1.18f, 0.36f),
                    new Vector3(1.12f, 1.34f, 0.04f), materials.Glass);
                AddCube(root.transform, "BrokenFrontGlass", new Vector3(-0.24f, 1.28f, -0.38f),
                    new Vector3(0.56f, 1.05f, 0.035f), materials.Glass, new Vector3(0f, 0f, -8f));
                AddRootBoxCollider(root, new Vector3(0f, 0.98f, 0f), new Vector3(1.35f, 1.96f, 0.82f));
                SavePrefab(root, k_BrokenIncubatorPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildMossPatchPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("MossPatch", preview);

            try
            {
                AddSphere(root.transform, "MossLobe_01", new Vector3(-0.28f, 0f, 0.02f),
                    new Vector3(0.72f, 0.018f, 0.48f), materials.MossDark);
                AddSphere(root.transform, "MossLobe_02", new Vector3(0.2f, 0.001f, -0.08f),
                    new Vector3(0.68f, 0.02f, 0.5f), materials.MossMid);
                AddSphere(root.transform, "MossLobe_03", new Vector3(0.05f, 0.002f, 0.22f),
                    new Vector3(0.58f, 0.016f, 0.4f), materials.MossDark);
                AddSphere(root.transform, "MossLobe_04", new Vector3(-0.42f, 0.002f, -0.22f),
                    new Vector3(0.38f, 0.014f, 0.28f), materials.MossMid);
                AddSphere(root.transform, "MossLobe_05", new Vector3(0.46f, 0.002f, 0.18f),
                    new Vector3(0.34f, 0.015f, 0.3f), materials.MossDark);
                SavePrefab(root, k_MossPatchPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildMossCarpetPrefab(Scene preview, FurnitureMaterials materials)
        {
            GameObject root = CreatePrefabRoot("MossCarpet", preview);

            try
            {
                AddSphere(root.transform, "MossLobe_01", new Vector3(-0.65f, 0f, -0.15f),
                    new Vector3(0.95f, 0.02f, 0.62f), materials.MossDark);
                AddSphere(root.transform, "MossLobe_02", new Vector3(0.05f, 0.001f, -0.25f),
                    new Vector3(1.05f, 0.018f, 0.58f), materials.MossMid);
                AddSphere(root.transform, "MossLobe_03", new Vector3(0.72f, 0.002f, -0.06f),
                    new Vector3(0.82f, 0.022f, 0.55f), materials.MossDark);
                AddSphere(root.transform, "MossLobe_04", new Vector3(-0.35f, 0.003f, 0.3f),
                    new Vector3(0.88f, 0.018f, 0.5f), materials.MossMid);
                AddSphere(root.transform, "MossLobe_05", new Vector3(0.38f, 0.001f, 0.32f),
                    new Vector3(0.92f, 0.02f, 0.48f), materials.MossDark);
                AddSphere(root.transform, "MossLobe_06", new Vector3(-0.96f, 0.002f, 0.18f),
                    new Vector3(0.42f, 0.015f, 0.34f), materials.MossMid);
                AddSphere(root.transform, "MossLobe_07", new Vector3(1.05f, 0.002f, 0.22f),
                    new Vector3(0.46f, 0.014f, 0.3f), materials.MossMid);
                SavePrefab(root, k_MossCarpetPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildImportedLabPropPrefabs(Scene preview, FurnitureMaterials materials)
        {
            string[] dustyProps =
            {
                "machine_microscope",
                "bottle_glassware_beaker_large",
                "bottle_glassware_filtering_flask_large",
                "funnel_seperatory_funnel",
                "heating_equipment_iron_stand",
                "heating_equipment_ring_stand",
                "syringe_syringe",
                "dish_evaporating_dish",
                "misc_scoopula",
                "ppe_lab_gown_folded",
            };

            for (int i = 0; i < dustyProps.Length; i++)
            {
                BuildImportedLabPropPrefab(preview, dustyProps[i], materials.EquipmentDusty);
            }

            BuildImportedLabPropPrefab(preview, "heating_equipment_bunsen_burner", materials.EquipmentOxide);
            BuildImportedLabPropPrefab(preview, "heating_equipment_crucible", materials.EquipmentOxide);
        }

        private static void BuildImportedLabPropPrefab(Scene preview, string key, Material material)
        {
            string modelPath = $"{k_ThirdPartyLabModelRoot}/{key}.fbx";
            string prefabPath = $"{k_PropsRoot}/{key}.prefab";
            GameObject source = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

            if (source == null)
            {
                throw new System.IO.FileNotFoundException("Imported Briggs lab model is missing: " + modelPath);
            }

            GameObject root = CreatePrefabRoot(key, preview);

            try
            {
                root.transform.localScale = Vector3.one * 0.01f;
                GameObject model = (GameObject)PrefabUtility.InstantiatePrefab(source, preview);
                model.name = key + "_Mesh";
                model.transform.SetParent(root.transform, false);
                model.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.Euler(-90f, 0f, 0f));
                model.transform.localScale = Vector3.one;

                Collider[] colliders = model.GetComponentsInChildren<Collider>(true);

                for (int i = 0; i < colliders.Length; i++)
                {
                    UnityEngine.Object.DestroyImmediate(colliders[i]);
                }

                Renderer[] renderers = model.GetComponentsInChildren<Renderer>(true);

                for (int i = 0; i < renderers.Length; i++)
                {
                    Material[] assigned = new Material[renderers[i].sharedMaterials.Length];

                    for (int materialIndex = 0; materialIndex < assigned.Length; materialIndex++)
                    {
                        assigned[materialIndex] = material;
                    }

                    renderers[i].sharedMaterials = assigned;
                }

                SavePrefab(root, prefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static GameObject CreatePrefabRoot(string name, Scene preview)
        {
            GameObject root = new GameObject(name);
            SceneManager.MoveGameObjectToScene(root, preview);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root;
        }

        private static void AddCube(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 scale,
            Material material,
            Vector3 euler = default)
        {
            GameObject part = GameObject.CreatePrimitive(PrimitiveType.Cube);
            part.name = name;
            SceneManager.MoveGameObjectToScene(part, parent.gameObject.scene);
            part.transform.SetParent(parent, false);
            part.transform.SetLocalPositionAndRotation(position, Quaternion.Euler(euler));
            part.transform.localScale = scale;
            UnityEngine.Object.DestroyImmediate(part.GetComponent<Collider>());
            part.GetComponent<MeshRenderer>().sharedMaterial = material;
        }

        private static void AddCylinder(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 scale,
            Vector3 euler,
            Material material)
        {
            GameObject part = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            part.name = name;
            SceneManager.MoveGameObjectToScene(part, parent.gameObject.scene);
            part.transform.SetParent(parent, false);
            part.transform.SetLocalPositionAndRotation(position, Quaternion.Euler(euler));
            part.transform.localScale = scale;
            UnityEngine.Object.DestroyImmediate(part.GetComponent<Collider>());
            part.GetComponent<MeshRenderer>().sharedMaterial = material;
        }

        private static void AddSphere(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 scale,
            Material material)
        {
            GameObject part = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            part.name = name;
            SceneManager.MoveGameObjectToScene(part, parent.gameObject.scene);
            part.transform.SetParent(parent, false);
            part.transform.SetLocalPositionAndRotation(position, Quaternion.identity);
            part.transform.localScale = scale;
            UnityEngine.Object.DestroyImmediate(part.GetComponent<Collider>());
            part.GetComponent<MeshRenderer>().sharedMaterial = material;
        }

        private static void AddRootBoxCollider(GameObject root, Vector3 center, Vector3 size)
        {
            BoxCollider collider = root.AddComponent<BoxCollider>();
            collider.center = center;
            collider.size = size;
        }

        private static void SavePrefab(GameObject root, string path)
        {
            SetStatic(root);
            bool saved;
            PrefabUtility.SaveAsPrefabAsset(root, path, out saved);

            if (!saved)
            {
                throw new InvalidOperationException("Could not save generated Briggs furniture prefab: " + path);
            }
        }

        private static void SetStatic(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }
        }

        private static FurnitureMaterials LoadFurnitureMaterials()
        {
            Material metalDark = LoadMaterial(k_MetalDarkMaterialPath);
            Material metalRust = LoadMaterial(k_MetalRustMaterialPath);
            Material concrete = LoadMaterial(k_ConcreteMaterialPath);
            Material labPalette = LoadMaterial(k_LabPaletteMaterialPath);
            Material glass = LoadMaterial(k_LabGlassMaterialPath);

            return new FurnitureMaterials(
                metalDark,
                metalRust,
                concrete,
                labPalette,
                glass,
                EnsureTintedMaterial(
                    k_DustyEquipmentMaterialPath,
                    labPalette,
                    new Color(0.44f, 0.50f, 0.43f, 1f),
                    0.18f,
                    false),
                EnsureTintedMaterial(
                    k_OxideEquipmentMaterialPath,
                    metalRust,
                    new Color(0.46f, 0.31f, 0.19f, 1f),
                    0.12f,
                    false),
                EnsureTintedMaterial(
                    k_MossDarkMaterialPath,
                    null,
                    new Color(0.17f, 0.28f, 0.14f, 1f),
                    0.08f,
                    true),
                EnsureTintedMaterial(
                    k_MossMidMaterialPath,
                    null,
                    new Color(0.26f, 0.4f, 0.2f, 1f),
                    0.1f,
                    true));
        }

        private static Material EnsureTintedMaterial(
            string path,
            Material source,
            Color tint,
            float smoothness,
            bool doubleSided)
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                EnsureFolder(System.IO.Path.GetDirectoryName(path).Replace('\\', '/'));
                Shader shader = source != null ? source.shader : Shader.Find("HDRP/Lit");

                if (shader == null)
                {
                    throw new InvalidOperationException("HDRP/Lit shader was not found for Briggs dressing.");
                }

                material = source != null ? new Material(source) : new Material(shader);
                material.name = System.IO.Path.GetFileNameWithoutExtension(path);
                AssetDatabase.CreateAsset(material, path);
            }
            else if (source != null)
            {
                material.CopyPropertiesFromMaterial(source);
                material.shader = source.shader;
            }

            if (material.HasProperty("_BaseColor"))
            {
                material.SetColor("_BaseColor", tint);
            }

            if (material.HasProperty("_Smoothness"))
            {
                material.SetFloat("_Smoothness", smoothness);
            }

            if (material.HasProperty("_DoubleSidedEnable"))
            {
                material.SetFloat("_DoubleSidedEnable", doubleSided ? 1f : 0f);
            }

            HDMaterial.ValidateMaterial(material);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static Material LoadMaterial(string path)
        {
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                throw new System.IO.FileNotFoundException("Briggs furniture material is missing: " + path);
            }

            return material;
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = System.IO.Path.GetDirectoryName(path).Replace('\\', '/');
            string name = System.IO.Path.GetFileName(path);
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, name);
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "Briggs dressing build stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private sealed class FurnitureMaterials
        {
            public FurnitureMaterials(
                Material metalDark,
                Material metalRust,
                Material concrete,
                Material labPalette,
                Material glass,
                Material equipmentDusty,
                Material equipmentOxide,
                Material mossDark,
                Material mossMid)
            {
                MetalDark = metalDark;
                MetalRust = metalRust;
                Concrete = concrete;
                LabPalette = labPalette;
                Glass = glass;
                EquipmentDusty = equipmentDusty;
                EquipmentOxide = equipmentOxide;
                MossDark = mossDark;
                MossMid = mossMid;
            }

            public Material MetalDark { get; }
            public Material MetalRust { get; }
            public Material Concrete { get; }
            public Material LabPalette { get; }
            public Material Glass { get; }
            public Material EquipmentDusty { get; }
            public Material EquipmentOxide { get; }
            public Material MossDark { get; }
            public Material MossMid { get; }
        }

        private struct Placement
        {
            public Placement(
                string name,
                string palette,
                string prefabPath,
                Vector3 position,
                float yaw,
                float scale,
                bool disableColliders,
                bool snapToSurface)
                : this(
                    name,
                    palette,
                    prefabPath,
                    position,
                    new Vector3(0f, yaw, 0f),
                    scale,
                    disableColliders,
                    snapToSurface)
            {
            }

            public Placement(
                string name,
                string palette,
                string prefabPath,
                Vector3 position,
                Vector3 euler,
                float scale,
                bool disableColliders,
                bool snapToSurface)
            {
                Name = name;
                Palette = palette;
                PrefabPath = prefabPath;
                Position = position;
                Euler = euler;
                Scale = scale;
                DisableColliders = disableColliders;
                SnapToSurface = snapToSurface;
            }

            public string Name;
            public string Palette;
            public string PrefabPath;
            public Vector3 Position;
            public Vector3 Euler;
            public float Scale;
            public bool DisableColliders;
            public bool SnapToSurface;
        }
    }
}
