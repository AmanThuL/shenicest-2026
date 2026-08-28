using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Investigation;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// RootsDance > Dev Play > Create Default Checkpoints. Find-or-create one checkpoint per opening
    /// station (00章前段), each carrying the world state the route has produced by then. Existing
    /// assets are never touched, so tuned positions and yaws survive a re-run — which is why the
    /// second menu, Set All Checkpoints To Night, exists to migrate the committed assets in place.
    /// </summary>
    public static class DevCheckpointDefaults
    {
        private const string k_MenuPath = "RootsDance/Dev Play/Create Default Checkpoints";
        private const string k_NightMenuPath = "RootsDance/Dev Play/Set All Checkpoints To Night";
        private const string k_CheckpointFilter = "t:DevCheckpointSO";
        private const string k_ParentFolder = "Assets/RootsDance/Data";
        private const string k_FolderName = "DevPlay";
        private const string k_Folder = k_ParentFolder + "/" + k_FolderName;
        private const string k_MainLevelPath = "Assets/RootsDance/Data/Levels/Main.asset";
        private const string k_SoilPath = "Assets/RootsDance/Data/Investigation/SO-001_Soil.asset";
        private const string k_TanmaoPath = "Assets/RootsDance/Data/Investigation/FL-001_Tanmao.asset";

        private struct Spec
        {
            public string FileName;
            public string Label;
            public string AnchorName;
            public Vector3 Position;
            public CheckpointTimeOfDay TimeOfDay;
            public string[] Flags;
            public bool WithRecords;
        }

        [MenuItem(k_MenuPath)]
        public static void CreateMissing()
        {
            LevelSO main = AssetDatabase.LoadAssetAtPath<LevelSO>(k_MainLevelPath);
            InvestigationTargetSO soil = AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(k_SoilPath);
            InvestigationTargetSO tanmao = AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(k_TanmaoPath);

            if (main == null)
            {
                Debug.LogError("Dev Play: missing " + k_MainLevelPath);
                return;
            }

            if (!AssetDatabase.IsValidFolder(k_Folder))
            {
                AssetDatabase.CreateFolder(k_ParentFolder, k_FolderName);
            }

            InvestigationTargetSO[] records = { soil, tanmao };
            Spec[] specs = BuildSpecs();
            int created = 0;

            for (int i = 0; i < specs.Length; i++)
            {
                Spec spec = specs[i];
                string path = k_Folder + "/" + spec.FileName + ".asset";

                if (AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path) != null)
                {
                    continue;
                }

                DevCheckpointSO checkpoint = ScriptableObject.CreateInstance<DevCheckpointSO>();
                checkpoint.Configure(
                    spec.Label, main, spec.AnchorName, spec.Position, 0f, spec.TimeOfDay, spec.Flags,
                    spec.WithRecords ? records : new InvestigationTargetSO[0]);
                AssetDatabase.CreateAsset(checkpoint, path);
                created++;
            }

            AssetDatabase.SaveAssets();
            Debug.Log("Dev Play: " + created + " checkpoint(s) created, " + (specs.Length - created)
                + " already existed in " + k_Folder + ".");
        }

        /// <summary>
        /// Forces every committed checkpoint to Night. <see cref="CreateMissing"/> never overwrites an
        /// existing asset, so this is how the assets authored before time of day existed catch up with
        /// the defaults above. No dialogs — safe to call from a batch -executeMethod run.
        /// </summary>
        [MenuItem(k_NightMenuPath)]
        public static void SetAllTimeOfDayToNight()
        {
            if (!AssetDatabase.IsValidFolder(k_Folder))
            {
                Debug.LogWarning("Dev Play: no checkpoint folder at " + k_Folder + "; nothing to set.");
                return;
            }

            string[] guids = AssetDatabase.FindAssets(k_CheckpointFilter, new[] { k_Folder });
            int changed = 0;

            for (int i = 0; i < guids.Length; i++)
            {
                DevCheckpointSO checkpoint =
                    AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(AssetDatabase.GUIDToAssetPath(guids[i]));

                if (checkpoint == null)
                {
                    continue;
                }

                checkpoint.SetTimeOfDay(CheckpointTimeOfDay.Night);
                EditorUtility.SetDirty(checkpoint);
                changed++;
            }

            AssetDatabase.SaveAssets();
            Debug.Log("Dev Play: " + changed + " checkpoint(s) set to Night in " + k_Folder + ".");
        }

        private static Spec[] BuildSpecs()
        {
            string[] afterStart = { WorldFlags.k_LeftStartArea };
            string[] afterRadio =
            {
                WorldFlags.k_LeftStartArea, WorldFlags.k_RadioBriefingStarted, WorldFlags.k_RadioBriefingFinished,
                WorldFlags.k_HelmetRemovable,
            };
            string[] afterHelmet =
            {
                WorldFlags.k_LeftStartArea, WorldFlags.k_RadioBriefingStarted, WorldFlags.k_RadioBriefingFinished,
                WorldFlags.k_HelmetRemovable, WorldFlags.k_HelmetRemoved, WorldFlags.k_EnteredGrassBelt,
            };
            string[] afterInvestigation =
            {
                WorldFlags.k_LeftStartArea, WorldFlags.k_RadioBriefingStarted, WorldFlags.k_RadioBriefingFinished,
                WorldFlags.k_HelmetRemovable, WorldFlags.k_HelmetRemoved, WorldFlags.k_EnteredGrassBelt,
                WorldFlags.k_FirstInvestigationDone,
            };

            // The whole pre-lab route plays at night, so every default checkpoint forces Night rather
            // than trusting whatever the level happened to seed.
            return new[]
            {
                Make("00-01_Wake", "00-01 Wake", "",
                    new Vector3(0f, 3.8f, -10f), CheckpointTimeOfDay.Night, new string[0], false),
                Make("00-04_RadioBriefing", "00-04 Radio briefing", "",
                    new Vector3(0f, 5f, 0f), CheckpointTimeOfDay.Night, afterStart, false),
                Make("00-05_HelmetUnlock", "00-05 Helmet unlock", "",
                    new Vector3(0f, 5f, 15f), CheckpointTimeOfDay.Night, afterRadio, false),
                Make("00-06_GrassBelt", "00-06 Grass belt", "",
                    new Vector3(0f, 7f, 32f), CheckpointTimeOfDay.Night, afterHelmet, false),
                Make("00-07_FirstToolUse", "00-07 First tool use", "Anchor_00-07_FirstToolUse",
                    new Vector3(-12f, 6.285f, 39f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-08_ResearchFacilityView", "00-08 Research facility view", "Anchor_00-08_ResearchFacilityView",
                    new Vector3(0.473f, 7.289f, 85.366f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-09_BlockedMainEntrance", "00-09 Blocked main entrance", "Anchor_00-09_BlockedMainEntrance",
                    new Vector3(9.505f, 7.299f, 118.941f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-10_MainEntranceSign", "00-10 Main entrance sign", "Anchor_00-10_MainEntranceSign",
                    new Vector3(7.030f, 7.299f, 115.759f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-11_ResearchFacilityPoster", "00-11 Research facility poster", "Anchor_00-11_ResearchFacilityPoster",
                    new Vector3(-4.637f, 7.299f, 114.699f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-12_AshleafVine", "00-12 Ashleaf vine", "Anchor_00-12_AshleafVine",
                    new Vector3(12.334f, 7.299f, 123.184f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-13_FineVeinedVine", "00-13 Fine-veined vine", "Anchor_00-13_FineVeinedVine",
                    new Vector3(13.394f, 7.299f, 124.952f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-14_VineGrowthDirection", "00-14 Vine growth direction", "Anchor_00-14_VineGrowthDirection",
                    new Vector3(19.435f, 7.299f, 133.774f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-15_ClearAshleafVine", "00-15 Clear ashleaf vine", "Anchor_00-15_ClearAshleafVine",
                    new Vector3(23.538f, 7.299f, 139.749f), CheckpointTimeOfDay.Night, afterInvestigation, true),
                Make("00-16_MaintenanceEntrance", "00-16 Maintenance entrance", "Anchor_00-16_MaintenanceEntrance",
                    new Vector3(24.237f, 7.299f, 140.785f), CheckpointTimeOfDay.Night, afterInvestigation, true),
            };
        }

        private static Spec Make(
            string fileName, string label, string anchorName, Vector3 position,
            CheckpointTimeOfDay timeOfDay, string[] flags, bool withRecords)
        {
            return new Spec
            {
                FileName = fileName,
                Label = label,
                AnchorName = anchorName,
                Position = position,
                TimeOfDay = timeOfDay,
                Flags = flags,
                WithRecords = withRecords,
            };
        }
    }
}
