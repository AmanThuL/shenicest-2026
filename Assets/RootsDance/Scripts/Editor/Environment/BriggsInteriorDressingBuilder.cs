using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
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

        private const string k_MaterialRoot = "Assets/RootsDance/Materials/Environment";
        private const string k_MetalDarkMaterialPath = k_MaterialRoot + "/Metal_Dark.mat";
        private const string k_MetalRustMaterialPath = k_MaterialRoot + "/Metal_Rust.mat";
        private const string k_ConcreteMaterialPath = k_MaterialRoot + "/Concrete_Pale.mat";
        private const string k_LabPaletteMaterialPath = k_MaterialRoot + "/Lab_Palette.mat";
        private const string k_LabGlassMaterialPath = k_MaterialRoot + "/Lab_Glass.mat";

        private const string k_PropsRoot = k_PrefabRoot + "/Props";
        private const string k_VegetationRoot = k_PrefabRoot + "/Vegetation";
        private const string k_RocksRoot = k_PrefabRoot + "/Rocks";

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

            EnsureGeneratedFurniturePrefabs();
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
            AddEastRootWorkstation(placements);
            AddWestArchives(placements);
            AddNorthWestCultivation(placements);
            AddNorthEastEquipment(placements);
            AddEcologyIslands(placements);
            AddDebris(placements);

            return placements.ToArray();
        }

        private static void AddCentralIsland(List<Placement> placements)
        {
            float[] xPositions = { -0.55f, 0.55f };
            float[] zPositions = { -1.75f, 0f, 1.75f };
            int counterIndex = 1;

            for (int x = 0; x < xPositions.Length; x++)
            {
                for (int z = 0; z < zPositions.Length; z++)
                {
                    placements.Add(Furniture(
                        $"BI_CentralCounter_{counterIndex:00}",
                        k_CounterPrefabPath,
                        new Vector3(xPositions[x], 0f, zPositions[z]),
                        90f));
                    counterIndex++;
                }
            }

            placements.Add(Evidence("BI_S8A_Scale", "misc_scale", new Vector3(0.55f, 0.98f, -1.98f), 18f));
            placements.Add(Evidence(
                "BI_S8A_TestTubeRack",
                "bottle_test_tube_rack",
                new Vector3(0.45f, 0.98f, -1.35f),
                -12f));
            placements.Add(Evidence(
                "BI_S8A_PetriDish_01",
                "dish_petridish",
                new Vector3(0.3f, 0.98f, -0.35f),
                32f));
            placements.Add(Evidence(
                "BI_S8A_PetriDish_02",
                "dish_watch_glass",
                new Vector3(0.63f, 0.98f, 0.12f),
                -23f));
            placements.Add(Evidence(
                "BI_S8A_Thermometer",
                "heating_equipment_thermometer",
                new Vector3(0.45f, 0.98f, 1.05f),
                74f));
            placements.Add(Evidence(
                "BI_S8A_Forceps",
                "heating_equipment_forceps",
                new Vector3(0.7f, 0.98f, 1.55f),
                21f));

            placements.Add(Evidence(
                "BI_S8B_CentrifugeTube",
                "bottle_glassware_centrifuge_tube",
                new Vector3(-0.45f, 0.98f, -1.65f),
                -18f));
            placements.Add(Evidence(
                "BI_S8B_Dropper",
                "bottle_dropper",
                new Vector3(-0.68f, 0.98f, -0.92f),
                45f));
            placements.Add(Evidence(
                "BI_S8B_ReagentBottle_01",
                "bottle_glassware_reagent_bottle_medium",
                new Vector3(-0.42f, 0.98f, 0.25f),
                10f));
            placements.Add(Evidence(
                "BI_S8B_ReagentBottle_02",
                "bottle_glassware_reagent_bottle_small",
                new Vector3(-0.65f, 0.98f, 0.52f),
                -16f));
            placements.Add(Evidence(
                "BI_S8B_WashBottle",
                "misc_wash_bottle",
                new Vector3(-0.38f, 0.98f, 1.37f),
                -34f));
            placements.Add(Evidence(
                "BI_S8B_Vial",
                "bottle_glassware_vial_medium",
                new Vector3(-0.67f, 0.98f, 1.77f),
                24f));
        }

        private static void AddEastRootWorkstation(List<Placement> placements)
        {
            placements.Add(Furniture(
                "BI_S7_Workbench",
                k_CounterPrefabPath,
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
                k_TallCabinetPrefabPath,
                new Vector3(-4.75f, 0f, 5.85f),
                180f));
            placements.Add(Furniture(
                "BI_NW_ServiceCounter",
                k_CounterPrefabPath,
                new Vector3(-5.1f, 0f, 3.05f),
                8f));

            placements.Add(Evidence(
                "BI_NW_SampleBottle_01",
                "bottle_plastic_bottle_medium",
                new Vector3(-5.38f, 0.98f, 3.06f),
                14f));
            placements.Add(Evidence(
                "BI_NW_SampleBottle_02",
                "bottle_glassware_reagent_bottle_medium",
                new Vector3(-4.9f, 0.98f, 3.13f),
                -26f));
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
                k_TallCabinetPrefabPath,
                new Vector3(5.45f, 0f, 5.65f),
                180f));
            placements.Add(Furniture(
                "BI_NE_ServiceCounter",
                k_CounterPrefabPath,
                new Vector3(5.8f, 0f, 3.25f),
                8f));

            placements.Add(Evidence(
                "BI_NE_AbandonedRack",
                "bottle_test_tube_rack",
                new Vector3(5.6f, 0.98f, 3.22f),
                34f));
            placements.Add(Evidence(
                "BI_NE_EmptyBottle",
                "bottle_glassware_test_tube_medium",
                new Vector3(6.05f, 0.98f, 3.28f),
                -8f));
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

        private static Placement Furniture(string name, string path, Vector3 position, float yaw)
        {
            return new Placement(name, k_LabFurniturePalette, path, position, yaw, 1f, false);
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
                Quaternion.Euler(0f, placement.Yaw, 0f));
            instance.transform.localScale = prefab.transform.localScale * placement.Scale;
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

                    if (child.name.StartsWith(k_OwnedPrefix, StringComparison.Ordinal))
                    {
                        UnityEngine.Object.DestroyImmediate(child.gameObject);
                    }
                }
            }
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

        private static void EnsureGeneratedFurniturePrefabs()
        {
            EnsureFolder(k_FurnitureFolder);
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
            return new FurnitureMaterials(
                LoadMaterial(k_MetalDarkMaterialPath),
                LoadMaterial(k_MetalRustMaterialPath),
                LoadMaterial(k_ConcreteMaterialPath),
                LoadMaterial(k_LabPaletteMaterialPath),
                LoadMaterial(k_LabGlassMaterialPath));
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
            public FurnitureMaterials(Material metalDark, Material metalRust, Material concrete, Material labPalette,
                Material glass)
            {
                MetalDark = metalDark;
                MetalRust = metalRust;
                Concrete = concrete;
                LabPalette = labPalette;
                Glass = glass;
            }

            public Material MetalDark { get; }
            public Material MetalRust { get; }
            public Material Concrete { get; }
            public Material LabPalette { get; }
            public Material Glass { get; }
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
                bool disableColliders)
            {
                Name = name;
                Palette = palette;
                PrefabPath = prefabPath;
                Position = position;
                Yaw = yaw;
                Scale = scale;
                DisableColliders = disableColliders;
            }

            public string Name;
            public string Palette;
            public string PrefabPath;
            public Vector3 Position;
            public float Yaw;
            public float Scale;
            public bool DisableColliders;
        }
    }
}
