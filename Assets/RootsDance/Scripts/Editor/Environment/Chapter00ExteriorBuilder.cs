using System;
using System.Collections.Generic;
using System.IO;
using RootsDance.Core;
using RootsDance.Editor.DevPlay;
using RootsDance.Editor.Terrain;
using RootsDance.Interaction;
using RootsDance.Investigation;
using RootsDance.Scanner;
using TheVisualEngine;
using Unity.Collections;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds the checkpoint-led Chapter-00 exterior from the anomalous grass belt to the maintenance entrance.
    /// </summary>
    /// <remarks>
    /// This pass is idempotent: generated assets are rewritten in place and only scene instances whose names begin
    /// with <c>C00M_</c> are replaced. Existing PWB palettes, the opening segment, and the Gaia facility group are
    /// preserved. This is an explicitly saving content tool and is also the batch-mode entry point.
    /// </remarks>
    public static class Chapter00ExteriorBuilder
    {
        private const string k_MenuPath = "RootsDance/Environment/Build Chapter 00 Mid-Late Exterior";
        private const string k_EnvironmentScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_GameplayScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_ConfigPath = "Assets/RootsDance/Data/Config/TerrainGreyboxConfig.asset";
        private const string k_PrefabFolder =
            "Assets/RootsDance/Prefabs/Environment/Chapter00MidLate";
        private const string k_MaterialFolder =
            "Assets/RootsDance/Materials/Environment/Chapter00MidLate";
        private const string k_InvestigationFolder = "Assets/RootsDance/Data/Investigation";
        private const string k_DressingFolder =
            "Assets/RootsDance/Prefabs/Environment/LabDressingVariants";
        private const string k_LabEcologyFolder = "Assets/RootsDance/Prefabs/Environment/LabEcology";
        private const string k_NoticeBoardPath =
            "Assets/RootsDance/Prefabs/Environment/LabArchives/LabNoticeBoard.prefab";
        private const string k_BarrierPath =
            "Assets/RootsDance/Prefabs/Environment/Facility/concrete_road_barrier.prefab";
        private const string k_OwnedPrefix = "C00M_";
        private const string k_PwbRootName = "Prefab World Builder";
        private const string k_PinName = "PIN";

        private const string k_AnomalousPalette = "AnomalousGrassBand";
        private const string k_FacilityEcologyPalette = "FacilityExteriorEcology";
        private const string k_WayfindingPalette = "ResearchWayfinding";
        private const string k_CluePalette = "ExteriorVineClues";
        private const string k_ServicePalette = "ServiceApproach";

        private const string k_BlockedEntrancePrefabPath = k_PrefabFolder + "/BlockedMainEntrance.prefab";
        private const string k_MainSignPrefabPath = k_PrefabFolder + "/MainEntranceSign.prefab";
        private const string k_PosterPrefabPath = k_PrefabFolder + "/ResearchPosterStand.prefab";
        private const string k_AshleafPrefabPath = k_PrefabFolder + "/AshleafVineCluster.prefab";
        private const string k_FineVinePrefabPath = k_PrefabFolder + "/FineVeinedVineCluster.prefab";
        private const string k_FanPrefabPath = k_PrefabFolder + "/GrowthDirectionFan.prefab";
        private const string k_MaintenancePrefabPath = k_PrefabFolder + "/MaintenanceEntrance.prefab";

        private const string k_AshleafTargetPath =
            k_InvestigationFolder + "/BOT-FL-118_AshleafVine.asset";
        private const string k_FineVineTargetPath =
            k_InvestigationFolder + "/BOT-FL-203_FineVeinedVine.asset";
        private const string k_LegacyTanmaoPath = k_InvestigationFolder + "/FL-001_Tanmao.asset";
        private const string k_TanmaoTargetPath = k_InvestigationFolder + "/BOT-FL-041_Tanmao.asset";

        private const string k_PlantSourceMaterialPath =
            "Assets/RootsDance/Materials/Environment/Niwl_Plants_General.mat";
        private const string k_AgedEnamelMaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ImportedLab/ImportedLab_AgedEnamel.mat";
        private const string k_DarkMetalMaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ImportedLab/ImportedLab_DarkMetal.mat";
        private const string k_OxideMaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ImportedLab/ImportedLab_Oxide.mat";
        private const string k_DirtyGlassMaterialPath =
            "Assets/RootsDance/Materials/Environment/BriggsInterior/ImportedLab/ImportedLab_DirtyGlass.mat";
        private const string k_CorridorRustMaterialPath =
            "Assets/RootsDance/Materials/Environment/LabCorridorRust.mat";
        private const string k_ConcreteMaterialPath =
            "Assets/RootsDance/Materials/Environment/Concrete_Pale.mat";

        private static readonly Vector2[][] k_Routes =
        {
            new[]
            {
                new Vector2(-16f, 28f),
                new Vector2(-12f, 39f),
                new Vector2(-6f, 52f),
                new Vector2(0f, 66f),
                new Vector2(1.5f, 73.5f),
                new Vector2(8f, 82f),
                new Vector2(16f, 88f),
                new Vector2(24f, 92.5f),
                new Vector2(30f, 96.2f),
            },
            new[]
            {
                new Vector2(30f, 96.2f),
                new Vector2(25.8f, 95.5f),
                new Vector2(23f, 97.8f),
            },
            new[]
            {
                new Vector2(30f, 96.2f),
                new Vector2(33.8f, 97.5f),
                new Vector2(35.8f, 100.8f),
                new Vector2(36.4f, 104f),
                new Vector2(37f, 106f),
            },
        };

        private static readonly Vector2[] k_CheckpointPositions =
        {
            new Vector2(-16f, 28f),
            new Vector2(-12f, 39f),
            new Vector2(1.5f, 73.5f),
            new Vector2(30f, 96.2f),
            new Vector2(25.8f, 95.5f),
            new Vector2(23f, 97.8f),
            new Vector2(33.8f, 97.5f),
            new Vector2(35.8f, 100.8f),
            new Vector2(36.4f, 104f),
            new Vector2(37f, 106f),
            new Vector2(37f, 106f),
        };

        private static readonly string[] k_GrassPrefabs =
        {
            k_DressingFolder + "/M3D_grass_patch_1_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_2_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_3_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_4_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_5_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_6_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_7_NoCollision.prefab",
            k_DressingFolder + "/M3D_grass_patch_8_NoCollision.prefab",
            k_DressingFolder + "/M3D_fern-1_NoCollision.prefab",
            k_DressingFolder + "/M3D_fern-2_NoCollision.prefab",
        };

        private static readonly string[] k_GroundEcologyPrefabs =
        {
            k_DressingFolder + "/rock_moss_02_NoCollision.prefab",
            k_DressingFolder + "/rock_moss_04_NoCollision.prefab",
            k_DressingFolder + "/rock_moss_05_NoCollision.prefab",
            k_DressingFolder + "/rock_moss_07_NoCollision.prefab",
            k_DressingFolder + "/rock_moss_09_NoCollision.prefab",
            k_DressingFolder + "/rock_moss_11_NoCollision.prefab",
            k_DressingFolder + "/root_cluster_01_NoCollision.prefab",
            k_DressingFolder + "/root_cluster_02_NoCollision.prefab",
            k_DressingFolder + "/pine_roots_NoCollision.prefab",
            k_DressingFolder + "/single_root_NoCollision.prefab",
            k_LabEcologyFolder + "/MossPatch.prefab",
            k_LabEcologyFolder + "/MossCarpet.prefab",
        };

        /// <summary>Builds terrain, generated assets, environment dressing, and aligned gameplay objects.</summary>
        [MenuItem(k_MenuPath)]
        public static void BuildAndSave()
        {
            ThrowIfAnyOpenSceneIsDirty();
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
                TerrainGreyboxConfigSO config = LoadRequired<TerrainGreyboxConfigSO>(k_ConfigPath);
                ConfigureTerrain(config);
                EnsureGeneratedAssets();
                DevCheckpointDefaults.ApplyChapter00Defaults();
                AssetDatabase.SaveAssets();

                Scene sourceEnvironment =
                    EditorSceneManager.OpenScene(k_EnvironmentScenePath, OpenSceneMode.Single);
                FacilitySnapshot facilitySnapshot = CaptureFacility(sourceEnvironment);
                // Saving dependent assets or opening this large scene can unload the config even while a
                // managed reference exists. Resolve it at the point of use, then again after the terrain
                // builder reloads the scene, so a fake-null Unity object cannot silently skip the build.
                config = LoadRequired<TerrainGreyboxConfigSO>(k_ConfigPath);
                TerrainGreyboxBuilder.Build(config);
                Scene environment = EditorSceneManager.OpenScene(k_EnvironmentScenePath, OpenSceneMode.Single);
                config = LoadRequired<TerrainGreyboxConfigSO>(k_ConfigPath);
                int environmentCount = BuildEnvironment(environment);
                EditorSceneManager.SaveScene(environment);

                Scene gameplay = EditorSceneManager.OpenScene(k_GameplayScenePath, OpenSceneMode.Additive);
                BuildGameplay(gameplay, FindTerrain(environment));
                ValidateBuiltState(environment, gameplay, config, facilitySnapshot, environmentCount);
                EditorSceneManager.SaveScene(gameplay);
                AssetDatabase.SaveAssets();

                Debug.Log($"Chapter00ExteriorBuilder: saved {environmentCount} PWB prefab instances, terrain, "
                    + "generated assets, and aligned Main gameplay objects.");
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        /// <summary>Batch-mode alias that makes the mandatory post-build validation explicit.</summary>
        public static void BuildAndValidate()
        {
            BuildAndSave();
        }

        private static void ConfigureTerrain(TerrainGreyboxConfigSO config)
        {
            TerrainGreyboxParams defaults = TerrainGreyboxParams.CreateDefault();
            TerrainGreyboxParams parameters = config.Params;
            parameters.TerraceCenter = defaults.TerraceCenter;
            parameters.TerraceHalfExtents = defaults.TerraceHalfExtents;
            parameters.TerraceYawDegrees = defaults.TerraceYawDegrees;
            parameters.TerraceCornerRadius = defaults.TerraceCornerRadius;
            parameters.TerraceHeight = defaults.TerraceHeight;
            parameters.TerraceBlend = defaults.TerraceBlend;
            parameters.FlatSpots = defaults.FlatSpots;
            parameters.Paths = defaults.Paths;

            SerializedObject serialized = new SerializedObject(config);
            serialized.FindProperty("m_deriveTerraceFromLab").boolValue = false;
            WriteAnchors(serialized.FindProperty("m_anchors"));
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(config);
        }

        private static void WriteAnchors(SerializedProperty anchors)
        {
            AnchorDefinition[] specs = TerrainGreyboxConfigSO.CreateDefaultAnchors();

            anchors.arraySize = specs.Length;

            for (int i = 0; i < specs.Length; i++)
            {
                SerializedProperty anchor = anchors.GetArrayElementAtIndex(i);
                anchor.FindPropertyRelative("m_name").stringValue = specs[i].Name;
                anchor.FindPropertyRelative("m_specPosition").vector3Value = specs[i].SpecPosition;
                anchor.FindPropertyRelative("m_useSpecHeight").boolValue = specs[i].UseSpecHeight;
            }
        }

        private static void EnsureGeneratedAssets()
        {
            EnsureFolder(k_PrefabFolder);
            EnsureFolder(k_MaterialFolder);
            EnsureFolder(k_InvestigationFolder);
            MigrateTanmaoTarget();

            InvestigationTargetSO ashleaf = EnsureInvestigationTarget(
                k_AshleafTargetPath,
                "BOT-FL-118",
                "灰叶藤",
                "识别",
                "叶片表面呈均匀灰白，常见于设施外围，根系会沿稳定水汽源扩展。",
                WorldFlags.k_AshleafVineScanned);
            InvestigationTargetSO fineVine = EnsureInvestigationTarget(
                k_FineVineTargetPath,
                "BOT-FL-203",
                "细脉藤",
                "识别",
                "叶脉更细且朝同一方向增密，生长向量指向地下检修口附近的潮湿空气。",
                WorldFlags.k_FineVeinedVineScanned);

            GeneratedMaterials materials = EnsureMaterials();
            Scene preview = EditorSceneManager.NewPreviewScene();

            try
            {
                BuildBlockedEntrancePrefab(preview, materials);
                BuildMainSignPrefab(preview, materials);
                BuildPosterPrefab(preview, materials);
                BuildVinePrefab(preview, k_AshleafPrefabPath, "AshleafVineCluster", materials.Ashleaf,
                    ashleaf, "灰叶藤", false);
                BuildVinePrefab(preview, k_FineVinePrefabPath, "FineVeinedVineCluster", materials.FineVine,
                    fineVine, "细脉藤", true);
                BuildFanPrefab(preview, materials);
                BuildMaintenancePrefab(preview, materials);
            }
            finally
            {
                EditorSceneManager.ClosePreviewScene(preview);
            }
        }

        private static void MigrateTanmaoTarget()
        {
            InvestigationTargetSO current =
                AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(k_TanmaoTargetPath);
            InvestigationTargetSO legacy =
                AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(k_LegacyTanmaoPath);

            if (current == null && legacy != null)
            {
                string error = AssetDatabase.MoveAsset(k_LegacyTanmaoPath, k_TanmaoTargetPath);

                if (!string.IsNullOrEmpty(error))
                {
                    throw new InvalidOperationException("Could not migrate the Tanmao target: " + error);
                }

                current = AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(k_TanmaoTargetPath);
            }

            if (current == null)
            {
                throw new FileNotFoundException(
                    "Neither the current nor legacy Tanmao investigation target exists.", k_TanmaoTargetPath);
            }

            SerializedObject serialized = new SerializedObject(current);
            serialized.FindProperty("m_id").stringValue = "BOT-FL-041";
            serialized.FindProperty("m_flagOnRecorded").stringValue = WorldFlags.k_FirstInvestigationDone;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(current);
        }

        private static InvestigationTargetSO EnsureInvestigationTarget(
            string path,
            string id,
            string title,
            string prompt,
            string body,
            string flag)
        {
            InvestigationTargetSO target = AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(path);

            if (target == null)
            {
                target = ScriptableObject.CreateInstance<InvestigationTargetSO>();
                AssetDatabase.CreateAsset(target, path);
            }

            SerializedObject serialized = new SerializedObject(target);
            serialized.FindProperty("m_id").stringValue = id;
            serialized.FindProperty("m_kind").enumValueIndex = (int)InvestigationKind.Identify;
            serialized.FindProperty("m_category").enumValueIndex = (int)ReportCategory.BiologicalRecord;
            serialized.FindProperty("m_title").stringValue = title;
            serialized.FindProperty("m_promptText").stringValue = prompt;
            serialized.FindProperty("m_resultBody").stringValue = body;
            serialized.FindProperty("m_flagOnRecorded").stringValue = flag;
            SerializedProperty monologue = serialized.FindProperty("m_monologueLines");
            monologue.arraySize = 1;
            monologue.GetArrayElementAtIndex(0).stringValue = title + "的生长方向不是随机的。";
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(target);
            return target;
        }

        private static GeneratedMaterials EnsureMaterials()
        {
            Material plant = LoadRequired<Material>(k_PlantSourceMaterialPath);
            Material aged = LoadRequired<Material>(k_AgedEnamelMaterialPath);
            Material dark = LoadRequired<Material>(k_DarkMetalMaterialPath);
            Material oxide = LoadRequired<Material>(k_OxideMaterialPath);
            Material glass = LoadRequired<Material>(k_DirtyGlassMaterialPath);
            Material rust = LoadRequired<Material>(k_CorridorRustMaterialPath);
            Material concrete = LoadRequired<Material>(k_ConcreteMaterialPath);

            return new GeneratedMaterials(
                EnsureTintMaterial("Grass_SilverBlue", plant, new Color(0.48f, 0.68f, 0.72f, 1f)),
                EnsureTintMaterial("Grass_Amber", plant, new Color(0.78f, 0.59f, 0.31f, 1f)),
                EnsureTintMaterial("Grass_Violet", plant, new Color(0.58f, 0.42f, 0.7f, 1f)),
                EnsureTintMaterial("Grass_PaleCyan", plant, new Color(0.54f, 0.78f, 0.68f, 1f)),
                EnsureTintMaterial("Vine_Ashleaf", plant, new Color(0.43f, 0.53f, 0.49f, 1f)),
                EnsureTintMaterial("Vine_FineVein", plant, new Color(0.3f, 0.64f, 0.55f, 1f)),
                aged,
                dark,
                oxide,
                glass,
                rust,
                concrete);
        }

        private static Material EnsureTintMaterial(string name, Material source, Color tint)
        {
            string path = k_MaterialFolder + "/" + name + ".mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (material == null)
            {
                material = new Material(source);
                material.name = name;
                AssetDatabase.CreateAsset(material, path);
            }
            else
            {
                material.CopyPropertiesFromMaterial(source);
                material.shader = source.shader;
            }

            SetColorIfPresent(material, "_BaseColor", tint);
            SetColorIfPresent(material, "_MainColor", tint);
            SetColorIfPresent(material, "_TintingColor", tint);
            material.enableInstancing = true;
            TVEUtils.SetMaterialSettings(material);
            TVEUtils.SetLabel(path);
            EditorUtility.SetDirty(material);
            return material;
        }

        private static void SetColorIfPresent(Material material, string property, Color value)
        {
            if (material.HasProperty(property))
            {
                material.SetColor(property, value);
            }
        }

        private static void BuildBlockedEntrancePrefab(Scene preview, GeneratedMaterials materials)
        {
            GameObject root = CreatePrefabRoot("BlockedMainEntrance", preview);

            try
            {
                AddNestedPrefab(root.transform, k_BarrierPath, "Barrier_Left",
                    new Vector3(-1.45f, 0f, 0f), new Vector3(0f, -8f, 0f), 0.9f);
                AddNestedPrefab(root.transform, k_BarrierPath, "Barrier_Right",
                    new Vector3(1.4f, 0f, 0.25f), new Vector3(0f, 10f, 0f), 0.9f);
                AddNestedPrefab(root.transform, k_DressingFolder + "/root_cluster_01_NoCollision.prefab",
                    "Roots_01", new Vector3(-0.35f, 0.1f, -0.3f), new Vector3(0f, 24f, 0f), 1.15f);
                AddNestedPrefab(root.transform, k_DressingFolder + "/root_cluster_02_NoCollision.prefab",
                    "Roots_02", new Vector3(0.75f, 0.18f, -0.2f), new Vector3(0f, -18f, 0f), 1.05f);
                AddCube(root.transform, "WarningCrossbar", new Vector3(0f, 1.15f, -0.15f),
                    new Vector3(4.6f, 0.16f, 0.18f), materials.Oxide, new Vector3(0f, 0f, -8f));
                AddRootBoxCollider(root, new Vector3(0f, 0.65f, 0f), new Vector3(5f, 1.3f, 1.15f));
                ConfigureWorldFlagInteractable(
                    root,
                    "正门被根系和路障封死",
                    WorldFlags.k_MainEntranceBlocked);
                SetLayerRecursively(root, InteractableLayer());
                SavePrefab(root, k_BlockedEntrancePrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildMainSignPrefab(Scene preview, GeneratedMaterials materials)
        {
            GameObject root = CreatePrefabRoot("MainEntranceSign", preview);

            try
            {
                AddCube(root.transform, "Post_Left", new Vector3(-0.85f, 0.85f, 0f),
                    new Vector3(0.12f, 1.7f, 0.12f), materials.DarkMetal);
                AddCube(root.transform, "Post_Right", new Vector3(0.85f, 0.85f, 0f),
                    new Vector3(0.12f, 1.7f, 0.12f), materials.DarkMetal);
                AddCube(root.transform, "Sign", new Vector3(0f, 1.45f, 0f),
                    new Vector3(2.1f, 0.82f, 0.12f), materials.AgedEnamel,
                    new Vector3(0f, 0f, -3f));
                AddCube(root.transform, "DownArrowStem", new Vector3(0f, 1.45f, -0.075f),
                    new Vector3(0.08f, 0.36f, 0.025f), materials.Oxide);
                AddCube(root.transform, "DownArrowHead_Left", new Vector3(-0.1f, 1.27f, -0.075f),
                    new Vector3(0.08f, 0.28f, 0.025f), materials.Oxide, new Vector3(0f, 0f, -42f));
                AddCube(root.transform, "DownArrowHead_Right", new Vector3(0.1f, 1.27f, -0.075f),
                    new Vector3(0.08f, 0.28f, 0.025f), materials.Oxide, new Vector3(0f, 0f, 42f));
                AddRootBoxCollider(root, new Vector3(0f, 1.35f, 0f), new Vector3(2.2f, 1.2f, 0.3f));
                ConfigureWorldFlagInteractable(
                    root,
                    "查看褪色的检修指示牌",
                    WorldFlags.k_MainEntranceSignRead);
                SetLayerRecursively(root, InteractableLayer());
                SavePrefab(root, k_MainSignPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildPosterPrefab(Scene preview, GeneratedMaterials materials)
        {
            GameObject root = CreatePrefabRoot("ResearchPosterStand", preview);

            try
            {
                AddCube(root.transform, "Plinth", new Vector3(0f, 0.18f, 0.08f),
                    new Vector3(2.5f, 0.36f, 0.7f), materials.Concrete);
                AddCube(root.transform, "BackBrace", new Vector3(0f, 1.35f, 0.25f),
                    new Vector3(2.35f, 2.7f, 0.12f), materials.DarkMetal);
                AddNestedPrefab(root.transform, k_NoticeBoardPath, "ResearchPoster",
                    new Vector3(0f, 1.35f, 0.12f), new Vector3(0f, 0f, 0f), 0.78f);
                AddRootBoxCollider(root, new Vector3(0f, 1.35f, 0f), new Vector3(2.5f, 2.7f, 0.55f));
                ConfigureWorldFlagInteractable(root, "查看设施外墙上的研究海报",
                    WorldFlags.k_ResearchFacilityPosterRead);
                SetLayerRecursively(root, InteractableLayer());
                SavePrefab(root, k_PosterPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildVinePrefab(
            Scene preview,
            string path,
            string name,
            Material material,
            InvestigationTargetSO target,
            string displayName,
            bool isFine)
        {
            GameObject root = CreatePrefabRoot(name, preview);

            try
            {
                string[] sources =
                {
                    k_DressingFolder + "/M3D_ivy_1_NoCollision.prefab",
                    k_DressingFolder + "/M3D_ivy_2_NoCollision.prefab",
                    k_DressingFolder + "/M3D_ivy_3_NoCollision.prefab",
                    k_DressingFolder + "/M3D_ivy_4_NoCollision.prefab",
                };
                int count = isFine ? 5 : 7;

                for (int i = 0; i < count; i++)
                {
                    float side = (i % 2 == 0 ? -1f : 1f) * (0.2f + i * 0.11f);
                    float forward = i * 0.34f;
                    GameObject ivy = AddNestedPrefab(root.transform, sources[i % sources.Length],
                        $"Vine_{i + 1:00}", new Vector3(side, 0.02f + i * 0.025f, forward),
                        new Vector3(0f, -24f + i * 17f, isFine ? 6f : 0f), isFine ? 0.78f : 1f);
                    AssignMaterial(ivy, material);
                }

                ScannableTarget scannable = root.AddComponent<ScannableTarget>();
                SetSerialized(scannable, "m_displayName", displayName);
                SetSerialized(scannable, "m_repeatable", false);
                ScannerWorldStateResult result = root.AddComponent<ScannerWorldStateResult>();
                SetSerialized(result, "m_reportTarget", target);
                SetLayerRecursively(root, ScannableLayer());
                SavePrefab(root, path);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildFanPrefab(Scene preview, GeneratedMaterials materials)
        {
            GameObject root = CreatePrefabRoot("GrowthDirectionFan", preview);

            try
            {
                AddCylinder(root.transform, "FanDrum", new Vector3(0f, 2.2f, 0f),
                    new Vector3(1.25f, 0.34f, 1.25f), new Vector3(90f, 0f, 0f), materials.DarkMetal);
                AddCylinder(root.transform, "Hub", new Vector3(0f, 2.2f, -0.42f),
                    new Vector3(0.22f, 0.12f, 0.22f), new Vector3(90f, 0f, 0f), materials.Oxide);

                for (int i = 0; i < 6; i++)
                {
                    AddCube(root.transform, $"Blade_{i + 1:00}", new Vector3(0f, 2.2f, -0.48f),
                        new Vector3(0.22f, 0.95f, 0.06f), materials.AgedEnamel,
                        new Vector3(0f, 0f, i * 60f + 18f));
                }

                AddCylinder(root.transform, "IntakePipe", new Vector3(0f, 0.8f, 0.25f),
                    new Vector3(0.3f, 1.4f, 0.3f), Vector3.zero, materials.CorridorRust);
                AddCylinder(root.transform, "SidePipe", new Vector3(0.85f, 1.1f, 0.2f),
                    new Vector3(0.18f, 0.95f, 0.18f), new Vector3(0f, 0f, 90f), materials.Oxide);
                AddRootBoxCollider(root, new Vector3(0f, 1.5f, 0f), new Vector3(2.7f, 3f, 1f));
                ConfigureWorldFlagInteractable(
                    root,
                    "观察藤蔓、管线与风扇的共同方向",
                    WorldFlags.k_VineGrowthDirectionObserved);
                SetLayerRecursively(root, InteractableLayer());
                SavePrefab(root, k_FanPrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static void BuildMaintenancePrefab(Scene preview, GeneratedMaterials materials)
        {
            GameObject root = CreatePrefabRoot("MaintenanceEntrance", preview);

            try
            {
                AddCube(root.transform, "Foundation", new Vector3(0f, 0.25f, 0.45f),
                    new Vector3(5.5f, 0.5f, 3.8f), materials.Concrete);
                AddCube(root.transform, "RetainingWall_Left", new Vector3(-2.35f, 1.45f, 0.55f),
                    new Vector3(0.45f, 2.9f, 3.5f), materials.CorridorRust);
                AddCube(root.transform, "RetainingWall_Right", new Vector3(2.35f, 1.45f, 0.55f),
                    new Vector3(0.45f, 2.9f, 3.5f), materials.CorridorRust);
                AddCube(root.transform, "Lintel", new Vector3(0f, 2.72f, 1.35f),
                    new Vector3(4.25f, 0.42f, 0.48f), materials.DarkMetal);
                AddCube(root.transform, "ServiceDoor", new Vector3(0f, 1.35f, 1.58f),
                    new Vector3(3.6f, 2.55f, 0.22f), materials.AgedEnamel);
                AddCube(root.transform, "DirtyWindow", new Vector3(0f, 1.75f, 1.44f),
                    new Vector3(1.25f, 0.55f, 0.06f), materials.DirtyGlass);
                AddCube(root.transform, "Threshold", new Vector3(0f, 0.38f, 1.25f),
                    new Vector3(4.15f, 0.2f, 0.8f), materials.Oxide);
                AddRootBoxCollider(root, new Vector3(0f, 0.25f, 0.45f), new Vector3(5.5f, 0.5f, 3.8f));
                AddRootBoxCollider(root, new Vector3(-2.35f, 1.45f, 0.55f), new Vector3(0.45f, 2.9f, 3.5f));
                AddRootBoxCollider(root, new Vector3(2.35f, 1.45f, 0.55f), new Vector3(0.45f, 2.9f, 3.5f));
                AddRootBoxCollider(root, new Vector3(0f, 2.72f, 1.35f), new Vector3(4.25f, 0.42f, 0.48f));
                // This chapter stops at the threshold: revealing the vine exposes the door but does not open it.
                AddRootBoxCollider(root, new Vector3(0f, 1.35f, 1.58f), new Vector3(3.6f, 2.55f, 0.22f));

                GameObject covered = new GameObject("CoveredVisual");
                SceneManager.MoveGameObjectToScene(covered, preview);
                covered.transform.SetParent(root.transform, false);
                GameObject revealed = new GameObject("RevealedVisual");
                SceneManager.MoveGameObjectToScene(revealed, preview);
                revealed.transform.SetParent(root.transform, false);

                for (int i = 0; i < 6; i++)
                {
                    GameObject ivy = AddNestedPrefab(covered.transform,
                        k_DressingFolder + $"/M3D_ivy_{i % 4 + 1}_NoCollision.prefab",
                        $"CoverVine_{i + 1:00}", new Vector3(-1.5f + i * 0.58f, 0.35f, 1.25f),
                        new Vector3(0f, 10f + i * 13f, -12f + i * 4f), 1.1f);
                    AssignMaterial(ivy, materials.Ashleaf);
                }

                for (int i = 0; i < 3; i++)
                {
                    GameObject ivy = AddNestedPrefab(revealed.transform,
                        k_DressingFolder + $"/M3D_ivy_{i + 1}_NoCollision.prefab",
                        $"PulledVine_{i + 1:00}", new Vector3(-2.05f + i * 2.05f, 0.2f, 1.05f),
                        new Vector3(0f, -20f + i * 24f, 18f), 0.8f);
                    AssignMaterial(ivy, materials.Ashleaf);
                }

                revealed.SetActive(false);
                BoxCollider blocker = root.AddComponent<BoxCollider>();
                blocker.center = new Vector3(0f, 1.35f, 1.05f);
                blocker.size = new Vector3(4f, 2.7f, 0.8f);
                VineCoverInteractable interactable = root.AddComponent<VineCoverInteractable>();
                SetSerialized(interactable, "m_coveredVisual", covered);
                SetSerialized(interactable, "m_revealedVisual", revealed);
                SetSerialized(interactable, "m_blocker", blocker);
                SetLayerRecursively(root, InteractableLayer());
                SavePrefab(root, k_MaintenancePrefabPath);
            }
            finally
            {
                UnityEngine.Object.DestroyImmediate(root);
            }
        }

        private static int BuildEnvironment(Scene scene)
        {
            UnityEngine.Terrain terrain = FindTerrain(scene);
            Dictionary<string, Transform> pins = EnsurePalettePins(scene);
            ClearOwnedInstances(pins);
            GeneratedMaterials materials = EnsureMaterials();
            int count = 0;

            // Vegetation moved to Chapter00ZoneVegetationBuilder. Keeping this builder focused on authored
            // interaction props prevents the legacy rectangular scatter from double-filling the A-E pass.
            count += PlaceHero(pins[k_WayfindingPalette], terrain, k_BlockedEntrancePrefabPath,
                "C00M_BlockedMainEntrance", new Vector2(30.7f, 99.1f), -24.47f, 1f);
            count += PlaceHero(pins[k_WayfindingPalette], terrain, k_MainSignPrefabPath,
                "C00M_MainEntranceSign", new Vector2(27f, 99f), 156f, 1f);
            count += PlaceHero(pins[k_WayfindingPalette], terrain, k_PosterPrefabPath,
                "C00M_ResearchPoster", new Vector2(23f, 99.2f), 165f, 1f);
            count += PlaceHero(pins[k_CluePalette], terrain, k_AshleafPrefabPath,
                "C00M_AshleafVine", new Vector2(33.7f, 97.2f), 335f, 1.15f);
            count += PlaceHero(pins[k_CluePalette], terrain, k_FineVinePrefabPath,
                "C00M_FineVeinedVine", new Vector2(36.5f, 101.3f), 335f, 1.1f);
            count += PlaceHero(pins[k_CluePalette], terrain, k_FanPrefabPath,
                "C00M_GrowthDirectionFan", new Vector2(33.5f, 104.8f), 155.5f, 1f);
            count += PlaceHero(pins[k_ServicePalette], terrain, k_MaintenancePrefabPath,
                "C00M_MaintenanceEntrance", new Vector2(34.2f, 108.8f), 155.5f, 1f);

            EditorSceneManager.MarkSceneDirty(scene);
            return count;
        }

        private static int FillRegion(
            Transform parent,
            UnityEngine.Terrain terrain,
            Rect region,
            float spacing,
            int seed,
            string[] prefabPaths,
            Material[] tints,
            float routeClearance,
            float minScale,
            float maxScale)
        {
            System.Random random = new System.Random(seed);
            int count = 0;
            int xCount = Mathf.CeilToInt(region.width / spacing);
            int zCount = Mathf.CeilToInt(region.height / spacing);

            for (int zIndex = 0; zIndex < zCount; zIndex++)
            {
                for (int xIndex = 0; xIndex < xCount; xIndex++)
                {
                    float x = region.xMin + (xIndex + 0.5f) * spacing
                        + ((float)random.NextDouble() - 0.5f) * spacing * 0.65f;
                    float z = region.yMin + (zIndex + 0.5f) * spacing
                        + ((float)random.NextDouble() - 0.5f) * spacing * 0.65f;
                    Vector2 point = new Vector2(x, z);

                    if (!IsPlacementClear(point, routeClearance, 2.7f))
                    {
                        continue;
                    }

                    string path = prefabPaths[random.Next(prefabPaths.Length)];
                    GameObject prefab = LoadRequired<GameObject>(path);
                    GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parent);
                    instance.name = $"{k_OwnedPrefix}Ecology_{seed}_{count + 1:000}";
                    instance.transform.position = new Vector3(x, 0f, z);
                    instance.transform.rotation = Quaternion.Euler(0f, (float)random.NextDouble() * 360f, 0f);
                    float scale = Mathf.Lerp(minScale, maxScale, (float)random.NextDouble());
                    instance.transform.localScale = prefab.transform.localScale * scale;

                    if (tints != null && tints.Length > 0)
                    {
                        AssignMaterial(instance, tints[random.Next(tints.Length)]);
                    }

                    SnapRendererBottomToTerrain(instance, terrain);
                    count++;
                }
            }

            return count;
        }

        private static int PlaceHero(
            Transform parent,
            UnityEngine.Terrain terrain,
            string prefabPath,
            string name,
            Vector2 xz,
            float yaw,
            float scale)
        {
            GameObject prefab = LoadRequired<GameObject>(prefabPath);
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, parent);
            instance.name = name;
            instance.transform.position = new Vector3(xz.x, 0f, xz.y);
            instance.transform.rotation = Quaternion.Euler(0f, yaw, 0f);
            instance.transform.localScale = prefab.transform.localScale * scale;
            SnapRendererBottomToTerrain(instance, terrain);
            return 1;
        }

        private static bool IsPlacementClear(Vector2 point, float routeClearance, float checkpointClearance)
        {
            for (int route = 0; route < k_Routes.Length; route++)
            {
                for (int i = 0; i < k_Routes[route].Length - 1; i++)
                {
                    if (DistanceToSegment(point, k_Routes[route][i], k_Routes[route][i + 1]) < routeClearance)
                    {
                        return false;
                    }
                }
            }

            for (int i = 0; i < k_CheckpointPositions.Length; i++)
            {
                if (Vector2.Distance(point, k_CheckpointPositions[i]) < checkpointClearance)
                {
                    return false;
                }
            }

            return true;
        }

        private static float DistanceToSegment(Vector2 point, Vector2 from, Vector2 to)
        {
            Vector2 segment = to - from;
            float lengthSquared = segment.sqrMagnitude;

            if (lengthSquared < 0.0001f)
            {
                return Vector2.Distance(point, from);
            }

            float t = Mathf.Clamp01(Vector2.Dot(point - from, segment) / lengthSquared);
            return Vector2.Distance(point, from + segment * t);
        }

        private static void BuildGameplay(Scene gameplay, UnityEngine.Terrain terrain)
        {
            GameObject grassBelt = FindInScene(gameplay, "GrassBelt");
            GameObject grassClump = FindInScene(gameplay, "GrassClump");
            GameObject soilPatch = FindInScene(gameplay, "SoilPatch");

            if (grassBelt == null || grassClump == null || soilPatch == null)
            {
                throw new InvalidOperationException(
                    "Main_Gameplay must contain GrassBelt, GrassClump, and SoilPatch before the exterior build.");
            }

            SetGroundedPosition(grassBelt.transform, terrain, new Vector2(-16f, 28f), 1.5f);
            grassBelt.transform.rotation = Quaternion.Euler(0f, 20f, 0f);
            BoxCollider beltCollider = grassBelt.GetComponent<BoxCollider>();

            if (beltCollider != null)
            {
                beltCollider.size = new Vector3(12f, 3f, 5.5f);
            }

            SetGroundedPosition(grassClump.transform, terrain, new Vector2(-13.54f, 39.71f), 0.45f);
            grassClump.transform.rotation = Quaternion.Euler(0f, 32f, 0f);
            // The visible C hero under Prefab World Builder now owns the scanner interaction. Keep this legacy
            // gameplay anchor for checkpoint compatibility, but disable its invisible collider/interaction.
            InvestigatableTarget legacyGrass = grassClump.GetComponent<InvestigatableTarget>();
            Collider legacyGrassCollider = grassClump.GetComponent<Collider>();
            if (legacyGrass != null) legacyGrass.enabled = false;
            if (legacyGrassCollider != null) legacyGrassCollider.enabled = false;
            SetGroundedPosition(soilPatch.transform, terrain, new Vector2(-10.46f, 38.29f), 0.2f);
            soilPatch.transform.rotation = Quaternion.Euler(0f, -18f, 0f);
            EditorSceneManager.MarkSceneDirty(gameplay);
        }

        private static FacilitySnapshot CaptureFacility(Scene scene)
        {
            GameObject facility = FindInScene(scene, "ResearchFacility_GaiaV7");

            if (facility == null)
            {
                throw new InvalidOperationException(
                    "Main_Environment has no ResearchFacility_GaiaV7 locked facility group.");
            }

            Transform[] transforms = facility.GetComponentsInChildren<Transform>(true);
            TransformSnapshot[] children = new TransformSnapshot[transforms.Length];

            for (int i = 0; i < transforms.Length; i++)
            {
                children[i] = new TransformSnapshot(
                    RelativePath(facility.transform, transforms[i]),
                    transforms[i].localPosition,
                    transforms[i].localRotation,
                    transforms[i].localScale);
            }

            return new FacilitySnapshot(
                facility.transform.position,
                facility.transform.rotation,
                facility.transform.localScale,
                children);
        }

        private static void ValidateBuiltState(
            Scene environment,
            Scene gameplay,
            TerrainGreyboxConfigSO config,
            FacilitySnapshot before,
            int expectedInstanceCount)
        {
            ValidateFacilityUnchanged(environment, before);
            int prefabInstanceCount = ValidatePwbOwnership(environment);
            ValidateTerrainContract(config);
            ValidateSceneAnchors(environment);
            float targetSeparation = ValidateRouteClearance(environment);
            ValidateGameplayAlignment(gameplay);

            if (prefabInstanceCount != expectedInstanceCount)
            {
                throw new InvalidOperationException(
                    $"Chapter-00 PWB count changed during validation: built {expectedInstanceCount}, "
                    + $"found {prefabInstanceCount}.");
            }

            Debug.Log("Chapter00ExteriorBuilder validation: {"
                + "\"facilityRootAndRelativeLayoutLocked\":true,"
                + "\"terrainRouteCount\":3,"
                + $"\"anchorCount\":{config.Anchors.Length},"
                + $"\"pwbPrefabInstances\":{prefabInstanceCount},"
                + $"\"vineTargetSeparationMeters\":{targetSeparation:F2},"
                + "\"grassBeltGateAligned\":true,"
                + "\"ecologyRouteClearanceMeters\":3.50}");
        }

        private static void ValidateFacilityUnchanged(Scene environment, FacilitySnapshot before)
        {
            GameObject facility = FindInScene(environment, "ResearchFacility_GaiaV7");

            if (facility == null)
            {
                throw new InvalidOperationException("The locked Gaia facility disappeared during the build.");
            }

            if (!Approximately(facility.transform.position, before.Position)
                || Quaternion.Angle(facility.transform.rotation, before.Rotation) > 0.001f
                || !Approximately(facility.transform.localScale, before.Scale))
            {
                throw new InvalidOperationException("The locked Gaia facility root transform changed.");
            }

            Transform[] transforms = facility.GetComponentsInChildren<Transform>(true);

            if (transforms.Length != before.Children.Length)
            {
                throw new InvalidOperationException("The locked Gaia facility hierarchy changed during the build.");
            }

            for (int i = 0; i < before.Children.Length; i++)
            {
                Transform current = transforms[i];

                if (RelativePath(facility.transform, current) != before.Children[i].Path
                    || !Approximately(current.localPosition, before.Children[i].Position)
                    || Quaternion.Angle(current.localRotation, before.Children[i].Rotation) > 0.001f
                    || !Approximately(current.localScale, before.Children[i].Scale))
                {
                    throw new InvalidOperationException(
                        "The locked Gaia facility relative layout changed at " + before.Children[i].Path);
                }
            }
        }

        private static int ValidatePwbOwnership(Scene environment)
        {
            Transform root = FindSceneRoot(environment, k_PwbRootName);

            if (root == null)
            {
                throw new InvalidOperationException("Main_Environment has no Prefab World Builder root.");
            }

            string[] paletteNames =
            {
                k_AnomalousPalette,
                k_FacilityEcologyPalette,
                k_WayfindingPalette,
                k_CluePalette,
                k_ServicePalette,
            };
            int count = 0;

            for (int paletteIndex = 0; paletteIndex < paletteNames.Length; paletteIndex++)
            {
                Transform palette = root.Find(paletteNames[paletteIndex]);
                Transform pin = palette == null ? null : palette.Find(k_PinName);

                if (pin == null)
                {
                    throw new InvalidOperationException(
                        "Missing Chapter-00 PWB palette/PIN: " + paletteNames[paletteIndex]);
                }

                for (int i = 0; i < pin.childCount; i++)
                {
                    GameObject child = pin.GetChild(i).gameObject;

                    if (!child.name.StartsWith(k_OwnedPrefix, StringComparison.Ordinal))
                    {
                        continue;
                    }

                    if (!PrefabUtility.IsPartOfPrefabInstance(child))
                    {
                        throw new InvalidOperationException(
                            "Chapter-00 visible prop is not a prefab instance under PWB: " + child.name);
                    }

                    count++;
                }
            }

            return count;
        }

        private static void ValidateTerrainContract(TerrainGreyboxConfigSO config)
        {
            TerrainGreyboxParams expected = TerrainGreyboxParams.CreateDefault();
            TerrainGreyboxParams actual = config.Params;

            if (!Approximately(actual.TerraceCenter, expected.TerraceCenter)
                || !Approximately(actual.TerraceHalfExtents, expected.TerraceHalfExtents)
                || Mathf.Abs(actual.TerraceYawDegrees - expected.TerraceYawDegrees) > 0.001f)
            {
                throw new InvalidOperationException("The Gaia facility terrace no longer matches the reviewed design.");
            }

            if (actual.Paths == null || expected.Paths == null || actual.Paths.Length != 3
                || actual.Paths.Length != expected.Paths.Length)
            {
                throw new InvalidOperationException("Chapter-00 terrain must contain exactly three reviewed routes.");
            }

            for (int pathIndex = 0; pathIndex < expected.Paths.Length; pathIndex++)
            {
                PathNode[] expectedNodes = expected.Paths[pathIndex].Nodes;
                PathNode[] actualNodes = actual.Paths[pathIndex].Nodes;

                if (actualNodes == null || actualNodes.Length != expectedNodes.Length)
                {
                    throw new InvalidOperationException(
                        $"Chapter-00 terrain route {pathIndex} has the wrong node count.");
                }

                for (int nodeIndex = 0; nodeIndex < expectedNodes.Length; nodeIndex++)
                {
                    if (!Approximately(actualNodes[nodeIndex].Position, expectedNodes[nodeIndex].Position)
                        || Mathf.Abs(actualNodes[nodeIndex].Height - expectedNodes[nodeIndex].Height) > 0.001f)
                    {
                        throw new InvalidOperationException(
                            $"Chapter-00 terrain route {pathIndex} node {nodeIndex} drifted from design.");
                    }
                }
            }

            AnchorDefinition[] expectedAnchors = TerrainGreyboxConfigSO.CreateDefaultAnchors();

            if (config.Anchors == null || config.Anchors.Length != expectedAnchors.Length)
            {
                throw new InvalidOperationException("Chapter-00 anchor count does not match the reviewed design.");
            }

            for (int i = 0; i < expectedAnchors.Length; i++)
            {
                AnchorDefinition anchor = config.Anchors[i];

                if (anchor.Name != expectedAnchors[i].Name
                    || !Approximately(anchor.SpecPosition, expectedAnchors[i].SpecPosition)
                    || anchor.UseSpecHeight != expectedAnchors[i].UseSpecHeight)
                {
                    throw new InvalidOperationException("Chapter-00 anchor drifted from design: " + anchor.Name);
                }
            }
        }

        private static void ValidateSceneAnchors(Scene environment)
        {
            AnchorDefinition[] expectedAnchors = TerrainGreyboxConfigSO.CreateDefaultAnchors();

            for (int i = 0; i < expectedAnchors.Length; i++)
            {
                AnchorDefinition expected = expectedAnchors[i];
                GameObject marker = FindInScene(environment, expected.Name);

                if (marker == null)
                {
                    throw new InvalidOperationException(
                        "Chapter-00 scene anchor is missing: " + expected.Name);
                }

                Vector3 actual = marker.transform.position;
                Vector3 spec = expected.SpecPosition;
                bool planarMismatch = Mathf.Abs(actual.x - spec.x) > .01f
                    || Mathf.Abs(actual.z - spec.z) > .01f;
                bool fixedHeightMismatch = expected.UseSpecHeight
                    && Mathf.Abs(actual.y - spec.y) > .01f;

                if (planarMismatch || fixedHeightMismatch)
                {
                    throw new InvalidOperationException(
                        $"Chapter-00 scene anchor drifted from design: {expected.Name}; "
                        + $"expected={spec}, actual={actual}");
                }
            }
        }

        private static float ValidateRouteClearance(Scene environment)
        {
            Transform root = FindSceneRoot(environment, k_PwbRootName);
            Transform anomalousPin = root.Find(k_AnomalousPalette + "/" + k_PinName);
            Transform facilityPin = root.Find(k_FacilityEcologyPalette + "/" + k_PinName);
            float minimumClearance = float.MaxValue;
            minimumClearance = Mathf.Min(minimumClearance, MinimumEcologyClearance(anomalousPin));
            minimumClearance = Mathf.Min(minimumClearance, MinimumEcologyClearance(facilityPin));

            if (minimumClearance < 3.5f)
            {
                throw new InvalidOperationException(
                    $"Generated ecology intrudes into a checkpoint route ({minimumClearance:F2} m clearance).");
            }

            GameObject blocked = FindInScene(environment, "C00M_BlockedMainEntrance");
            Vector2 blockedPosition = new Vector2(blocked.transform.position.x, blocked.transform.position.z);

            if (Vector2.Distance(blockedPosition, k_CheckpointPositions[3]) < 2.5f)
            {
                throw new InvalidOperationException("Blocked entrance leaves no safe 00-09 checkpoint landing area.");
            }

            GameObject ashleaf = FindInScene(environment, "C00M_AshleafVine");
            GameObject fineVine = FindInScene(environment, "C00M_FineVeinedVine");
            Vector2 ashleafPosition = new Vector2(ashleaf.transform.position.x, ashleaf.transform.position.z);
            Vector2 finePosition = new Vector2(fineVine.transform.position.x, fineVine.transform.position.z);
            float targetDistance = Vector2.Distance(ashleafPosition, finePosition);

            if (targetDistance <= 3f)
            {
                throw new InvalidOperationException(
                    $"00-12 and 00-13 scanner targets are only {targetDistance:F2} m apart.");
            }

            Vector2 ashleafCheckpoint = k_CheckpointPositions[6];
            Vector2 fineCheckpoint = k_CheckpointPositions[7];

            if (Vector2.Distance(ashleafPosition, ashleafCheckpoint) >= 3f
                || Vector2.Distance(ashleafPosition, fineCheckpoint) <= 3f
                || Vector2.Distance(finePosition, fineCheckpoint) >= 3f
                || Vector2.Distance(finePosition, ashleafCheckpoint) <= 3f)
            {
                throw new InvalidOperationException(
                    "00-12/00-13 scanner radii overlap or fail to contain their intended vine target.");
            }

            return targetDistance;
        }

        private static float MinimumEcologyClearance(Transform pin)
        {
            float minimum = float.MaxValue;

            for (int i = 0; i < pin.childCount; i++)
            {
                Transform child = pin.GetChild(i);

                if (!child.name.StartsWith(k_OwnedPrefix + "Ecology_", StringComparison.Ordinal))
                {
                    continue;
                }

                Vector2 point = new Vector2(child.position.x, child.position.z);

                for (int route = 0; route < k_Routes.Length; route++)
                {
                    for (int node = 0; node < k_Routes[route].Length - 1; node++)
                    {
                        minimum = Mathf.Min(
                            minimum,
                            DistanceToSegment(point, k_Routes[route][node], k_Routes[route][node + 1]));
                    }
                }
            }

            return minimum;
        }

        private static void ValidateGameplayAlignment(Scene gameplay)
        {
            GameObject grassBelt = FindInScene(gameplay, "GrassBelt");
            GameObject grassClump = FindInScene(gameplay, "GrassClump");
            GameObject soilPatch = FindInScene(gameplay, "SoilPatch");
            BoxCollider collider = grassBelt.GetComponent<BoxCollider>();
            Vector3 gateInLocalSpace = grassBelt.transform.InverseTransformPoint(
                new Vector3(-16f, grassBelt.transform.position.y, 28f));

            if (collider == null
                || Mathf.Abs(gateInLocalSpace.x - collider.center.x) > collider.size.x * 0.5f
                || Mathf.Abs(gateInLocalSpace.z - collider.center.z) > collider.size.z * 0.5f)
            {
                throw new InvalidOperationException("GrassBelt trigger does not cover the authored route gate.");
            }

            Vector2 grass = new Vector2(grassClump.transform.position.x, grassClump.transform.position.z);
            Vector2 soil = new Vector2(soilPatch.transform.position.x, soilPatch.transform.position.z);

            if (Vector2.Distance(grass, k_CheckpointPositions[1]) > 2f
                || Vector2.Distance(soil, k_CheckpointPositions[1]) > 2f
                || Vector2.Distance(grass, soil) < 1.5f)
            {
                throw new InvalidOperationException(
                    "First-investigation targets do not form a clear two-target station around 00-07.");
            }
        }

        private static string RelativePath(Transform root, Transform target)
        {
            if (target == root)
            {
                return string.Empty;
            }

            List<string> names = new List<string>();
            Transform current = target;

            while (current != null && current != root)
            {
                names.Add(current.name);
                current = current.parent;
            }

            names.Reverse();
            return string.Join("/", names);
        }

        private static bool Approximately(Vector3 left, Vector3 right)
        {
            return (left - right).sqrMagnitude < 0.000001f;
        }

        private static bool Approximately(Vector2 left, Vector2 right)
        {
            return (left - right).sqrMagnitude < 0.000001f;
        }

        private static void SetGroundedPosition(
            Transform target,
            UnityEngine.Terrain terrain,
            Vector2 xz,
            float heightOffset)
        {
            float y = terrain.SampleHeight(new Vector3(xz.x, 0f, xz.y)) + terrain.transform.position.y;
            target.position = new Vector3(xz.x, y + heightOffset, xz.y);
        }

        private static Dictionary<string, Transform> EnsurePalettePins(Scene scene)
        {
            Transform root = FindSceneRoot(scene, k_PwbRootName);

            if (root == null)
            {
                GameObject created = new GameObject(k_PwbRootName);
                SceneManager.MoveGameObjectToScene(created, scene);
                root = created.transform;
            }

            root.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.localScale = Vector3.one;
            string[] names =
            {
                k_AnomalousPalette,
                k_FacilityEcologyPalette,
                k_WayfindingPalette,
                k_CluePalette,
                k_ServicePalette,
            };
            Dictionary<string, Transform> pins = new Dictionary<string, Transform>(names.Length);

            for (int i = 0; i < names.Length; i++)
            {
                Transform palette = EnsureDirectChild(root, names[i]);
                palette.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
                palette.localScale = Vector3.one;
                Transform pin = EnsureDirectChild(palette, k_PinName);
                pin.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
                pin.localScale = Vector3.one;
                pins.Add(names[i], pin);
            }

            return pins;
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

        private static Transform EnsureDirectChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                return existing;
            }

            GameObject created = new GameObject(name);
            created.transform.SetParent(parent, false);
            return created.transform;
        }

        private static GameObject CreatePrefabRoot(string name, Scene preview)
        {
            GameObject root = new GameObject(name);
            SceneManager.MoveGameObjectToScene(root, preview);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;
            return root;
        }

        private static GameObject AddNestedPrefab(
            Transform parent,
            string path,
            string name,
            Vector3 position,
            Vector3 euler,
            float scale)
        {
            GameObject source = LoadRequired<GameObject>(path);
            GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(source, parent.gameObject.scene);
            instance.name = name;
            instance.transform.SetParent(parent, false);
            instance.transform.SetLocalPositionAndRotation(position, Quaternion.Euler(euler));
            instance.transform.localScale = source.transform.localScale * scale;
            return instance;
        }

        private static void AddCube(
            Transform parent,
            string name,
            Vector3 position,
            Vector3 scale,
            Material material,
            Vector3 euler = default(Vector3))
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

        private static void ConfigureWorldFlagInteractable(GameObject root, string prompt, string flag)
        {
            WorldFlagInteractable interactable = root.AddComponent<WorldFlagInteractable>();
            SetSerialized(interactable, "m_promptText", prompt);
            SetSerialized(interactable, "m_flagId", flag);
        }

        private static void SetSerialized(UnityEngine.Object target, string propertyName, object value)
        {
            SerializedObject serialized = new SerializedObject(target);
            SerializedProperty property = serialized.FindProperty(propertyName);

            if (property == null)
            {
                throw new InvalidOperationException(target.GetType().Name + " has no serialized " + propertyName);
            }

            if (value is string)
            {
                property.stringValue = (string)value;
            }
            else if (value is bool)
            {
                property.boolValue = (bool)value;
            }
            else if (value is UnityEngine.Object)
            {
                property.objectReferenceValue = (UnityEngine.Object)value;
            }
            else
            {
                throw new ArgumentException("Unsupported serialized value type for " + propertyName);
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void AssignMaterial(GameObject root, Material material)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                Material[] assigned = new Material[renderers[i].sharedMaterials.Length];

                for (int materialIndex = 0; materialIndex < assigned.Length; materialIndex++)
                {
                    assigned[materialIndex] = material;
                }

                renderers[i].sharedMaterials = assigned;
            }
        }

        private static void SnapRendererBottomToTerrain(GameObject instance, UnityEngine.Terrain terrain)
        {
            Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                throw new InvalidOperationException("Cannot terrain-snap a prefab with no renderers: " + instance.name);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            Vector3 position = instance.transform.position;
            float surface = terrain.SampleHeight(position) + terrain.transform.position.y;
            position.y += surface - bounds.min.y;
            instance.transform.position = position;

            float clearance = GroundClearance(instance, terrain);

            if (clearance > 0.002f)
            {
                instance.transform.position += Vector3.down * clearance;
            }
        }

        private static float GroundClearance(GameObject instance, UnityEngine.Terrain terrain)
        {
            float minimum = float.MaxValue;
            Vector3 terrainPosition = terrain.transform.position;
            Vector3 terrainSize = terrain.terrainData.size;

            foreach (MeshRenderer renderer in instance.GetComponentsInChildren<MeshRenderer>(true))
            {
                if (!IsLod0Renderer(renderer))
                {
                    continue;
                }

                MeshFilter filter = renderer.GetComponent<MeshFilter>();

                if (filter == null || filter.sharedMesh == null)
                {
                    continue;
                }

                using (Mesh.MeshDataArray meshDataArray = Mesh.AcquireReadOnlyMeshData(filter.sharedMesh))
                {
                    Mesh.MeshData meshData = meshDataArray[0];

                    if (!meshData.HasVertexAttribute(UnityEngine.Rendering.VertexAttribute.Position))
                    {
                        continue;
                    }

                    NativeArray<Vector3> vertices = new NativeArray<Vector3>(meshData.vertexCount,
                        Allocator.Temp, NativeArrayOptions.UninitializedMemory);

                    try
                    {
                        meshData.GetVertices(vertices);

                        for (int i = 0; i < vertices.Length; i++)
                        {
                            Vector3 world = filter.transform.TransformPoint(vertices[i]);
                            Vector3 terrainLocal = world - terrainPosition;

                            if (terrainLocal.x < 0f || terrainLocal.z < 0f
                                || terrainLocal.x > terrainSize.x || terrainLocal.z > terrainSize.z)
                            {
                                continue;
                            }

                            float terrainY = terrain.SampleHeight(world) + terrainPosition.y;
                            minimum = Mathf.Min(minimum, world.y - terrainY);
                        }
                    }
                    finally
                    {
                        vertices.Dispose();
                    }
                }
            }

            return minimum == float.MaxValue ? 0f : minimum;
        }

        private static bool IsLod0Renderer(MeshRenderer renderer)
        {
            LODGroup group = renderer.GetComponentInParent<LODGroup>();

            if (group == null)
            {
                return true;
            }

            LOD[] lods = group.GetLODs();

            if (lods.Length == 0)
            {
                return true;
            }

            Renderer[] renderers = lods[0].renderers;

            for (int i = 0; i < renderers.Length; i++)
            {
                if (renderers[i] == renderer)
                {
                    return true;
                }
            }

            return false;
        }

        private static void SavePrefab(GameObject root, string path)
        {
            SetStaticRecursively(root);
            bool saved;
            PrefabUtility.SaveAsPrefabAsset(root, path, out saved);

            if (!saved)
            {
                throw new InvalidOperationException("Could not save generated Chapter-00 prefab: " + path);
            }
        }

        private static void SetStaticRecursively(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);
            StaticEditorFlags flags = StaticEditorFlags.OccludeeStatic
                | StaticEditorFlags.ReflectionProbeStatic;

            for (int i = 0; i < transforms.Length; i++)
            {
                GameObjectUtility.SetStaticEditorFlags(transforms[i].gameObject, flags);
            }
        }

        private static void SetLayerRecursively(GameObject root, int layer)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.layer = layer;
            }
        }

        private static int InteractableLayer()
        {
            return RequireLayer("Interactable");
        }

        private static int ScannableLayer()
        {
            return RequireLayer("Scannable");
        }

        private static int RequireLayer(string name)
        {
            int layer = LayerMask.NameToLayer(name);

            if (layer < 0)
            {
                throw new InvalidOperationException("Required layer is missing: " + name);
            }

            return layer;
        }

        private static UnityEngine.Terrain FindTerrain(Scene scene)
        {
            GameObject terrainObject = FindInScene(scene, "Terrain_Main");
            UnityEngine.Terrain terrain = terrainObject == null
                ? null
                : terrainObject.GetComponent<UnityEngine.Terrain>();

            if (terrain == null)
            {
                throw new InvalidOperationException("Main_Environment has no Terrain_Main Terrain component.");
            }

            return terrain;
        }

        private static GameObject FindInScene(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Transform[] transforms = roots[i].GetComponentsInChildren<Transform>(true);

                for (int j = 0; j < transforms.Length; j++)
                {
                    if (transforms[j].name == name)
                    {
                        return transforms[j].gameObject;
                    }
                }
            }

            return null;
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

        private static T LoadRequired<T>(string path)
            where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new FileNotFoundException("Required Chapter-00 build asset is missing: " + path);
            }

            return asset;
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path).Replace('\\', '/');
            EnsureFolder(parent);
            AssetDatabase.CreateFolder(parent, Path.GetFileName(path));
        }

        private static void ThrowIfAnyOpenSceneIsDirty()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isDirty)
                {
                    throw new InvalidOperationException(
                        "Chapter-00 exterior build stopped because an open scene has unsaved changes: " + scene.path);
                }
            }
        }

        private struct TransformSnapshot
        {
            public TransformSnapshot(string path, Vector3 position, Quaternion rotation, Vector3 scale)
            {
                Path = path;
                Position = position;
                Rotation = rotation;
                Scale = scale;
            }

            public string Path;
            public Vector3 Position;
            public Quaternion Rotation;
            public Vector3 Scale;
        }

        private struct FacilitySnapshot
        {
            public FacilitySnapshot(
                Vector3 position,
                Quaternion rotation,
                Vector3 scale,
                TransformSnapshot[] children)
            {
                Position = position;
                Rotation = rotation;
                Scale = scale;
                Children = children;
            }

            public Vector3 Position;
            public Quaternion Rotation;
            public Vector3 Scale;
            public TransformSnapshot[] Children;
        }

        private sealed class GeneratedMaterials
        {
            public GeneratedMaterials(
                Material silverBlue,
                Material amber,
                Material violet,
                Material paleCyan,
                Material ashleaf,
                Material fineVine,
                Material agedEnamel,
                Material darkMetal,
                Material oxide,
                Material dirtyGlass,
                Material corridorRust,
                Material concrete)
            {
                GrassTints = new[] { silverBlue, amber, violet, paleCyan };
                Ashleaf = ashleaf;
                FineVine = fineVine;
                AgedEnamel = agedEnamel;
                DarkMetal = darkMetal;
                Oxide = oxide;
                DirtyGlass = dirtyGlass;
                CorridorRust = corridorRust;
                Concrete = concrete;
            }

            public Material[] GrassTints { get; }
            public Material Ashleaf { get; }
            public Material FineVine { get; }
            public Material AgedEnamel { get; }
            public Material DarkMetal { get; }
            public Material Oxide { get; }
            public Material DirtyGlass { get; }
            public Material CorridorRust { get; }
            public Material Concrete { get; }
        }
    }
}
