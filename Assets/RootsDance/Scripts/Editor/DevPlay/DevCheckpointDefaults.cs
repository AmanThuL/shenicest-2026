using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Investigation;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// RootsDance > Dev Play > Create Default Checkpoints. Find-or-create one checkpoint per opening
    /// station (00章), each carrying only the world state produced before that station. Create Missing
    /// preserves existing assets; Apply Chapter 00 Checkpoint Defaults is the explicit route migration.
    /// </summary>
    public static class DevCheckpointDefaults
    {
        private const string k_MenuPath = "RootsDance/Dev Play/Create Default Checkpoints";
        private const string k_LevelDefaultMenuPath = "RootsDance/Dev Play/Set All Checkpoints To Level Default";
        private const string k_CheckpointFilter = "t:DevCheckpointSO";
        private const string k_ParentFolder = "Assets/RootsDance/Data";
        private const string k_FolderName = "DevPlay";
        private const string k_Folder = k_ParentFolder + "/" + k_FolderName;
        private const string k_MainLevelPath = "Assets/RootsDance/Data/Levels/Main.asset";
        private const string k_SoilPath = "Assets/RootsDance/Data/Investigation/SO-001_Soil.asset";
        private const string k_TanmaoPath = "Assets/RootsDance/Data/Investigation/BOT-FL-041_Tanmao.asset";
        private const string k_ApplyChapter00MenuPath =
            "RootsDance/Dev Play/Apply Chapter 00 Checkpoint Defaults";
        private const int k_GroundLayerMask = 1 << 8;

        private struct Spec
        {
            public string FileName;
            public string Label;
            public string AnchorName;
            public Vector3 Position;
            public float Yaw;
            public bool SnapToGround;
            public bool UseAnchorHeight;
            public CheckpointTimeOfDay TimeOfDay;
            public string[] Flags;
            public string[] RecordPaths;
        }

        [MenuItem(k_MenuPath)]
        public static void CreateMissing()
        {
            ApplyDefaults(false);
        }

        /// <summary>
        /// Reapplies the authored Chapter 00 route to committed checkpoints. Environment builders call this
        /// after moving anchors so fallback positions, facing and progressive world state stay in lockstep.
        /// </summary>
        [MenuItem(k_ApplyChapter00MenuPath)]
        public static void ApplyChapter00Defaults()
        {
            ApplyDefaults(true);
        }

        private static void ApplyDefaults(bool overwriteExisting)
        {
            LevelSO main = AssetDatabase.LoadAssetAtPath<LevelSO>(k_MainLevelPath);

            if (main == null)
            {
                Debug.LogError("Dev Play: missing " + k_MainLevelPath);
                return;
            }

            if (!AssetDatabase.IsValidFolder(k_Folder))
            {
                AssetDatabase.CreateFolder(k_ParentFolder, k_FolderName);
            }

            Spec[] specs = BuildSpecs();
            int created = 0;

            for (int i = 0; i < specs.Length; i++)
            {
                Spec spec = specs[i];
                string path = k_Folder + "/" + spec.FileName + ".asset";
                DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);

                if (checkpoint != null && !overwriteExisting)
                {
                    continue;
                }

                bool isNew = checkpoint == null;

                if (isNew)
                {
                    checkpoint = ScriptableObject.CreateInstance<DevCheckpointSO>();
                }

                checkpoint.Configure(
                    spec.Label, main, spec.AnchorName, spec.Position, spec.Yaw, spec.TimeOfDay, spec.Flags,
                    LoadRecords(spec.RecordPaths), spec.SnapToGround, k_GroundLayerMask, 1f,
                    spec.UseAnchorHeight);

                if (isNew)
                {
                    AssetDatabase.CreateAsset(checkpoint, path);
                    created++;
                }
                else
                {
                    EditorUtility.SetDirty(checkpoint);
                }
            }

            AssetDatabase.SaveAssets();
            string action = overwriteExisting ? "updated" : "already existed";
            Debug.Log("Dev Play: " + created + " checkpoint(s) created, " + (specs.Length - created)
                + " " + action + " in " + k_Folder + ".");
        }

        /// <summary>
        /// Restores every outdoor checkpoint to its level default. <see cref="CreateMissing"/> never overwrites an
        /// existing asset, so this is how the assets authored before time of day existed catch up with
        /// the defaults above. No dialogs — safe to call from a batch -executeMethod run.
        /// </summary>
        [MenuItem(k_LevelDefaultMenuPath)]
        public static void SetAllTimeOfDayToLevelDefault()
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
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);

                if (path.IndexOf("/BriggsInterior/", System.StringComparison.Ordinal) >= 0)
                {
                    continue;
                }

                DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);

                if (checkpoint == null)
                {
                    continue;
                }

                checkpoint.SetTimeOfDay(CheckpointTimeOfDay.LevelDefault);
                EditorUtility.SetDirty(checkpoint);
                changed++;
            }

            AssetDatabase.SaveAssets();
            Debug.Log("Dev Play: " + changed + " checkpoint(s) set to Level Default in " + k_Folder + ".");
        }

        private static Spec[] BuildSpecs()
        {
            string[] noRecords = new string[0];
            string[] investigationRecords = { k_TanmaoPath, k_SoilPath };
            string[] afterStart = { WorldFlags.k_LeftStartArea };
            string[] afterRadio =
            {
                WorldFlags.k_LeftStartArea, WorldFlags.k_RadioBriefingStarted, WorldFlags.k_RadioBriefingFinished,
                WorldFlags.k_HelmetRemovable,
            };
            string[] afterHelmet =
            {
                WorldFlags.k_LeftStartArea, WorldFlags.k_RadioBriefingStarted, WorldFlags.k_RadioBriefingFinished,
                WorldFlags.k_HelmetRemovable, WorldFlags.k_HelmetRemoved,
            };
            string[] afterGrassBelt = Append(afterHelmet, WorldFlags.k_EnteredGrassBelt);
            string[] afterInvestigation = Append(afterGrassBelt, WorldFlags.k_FirstInvestigationDone);
            string[] afterBlockedEntrance = Append(afterInvestigation, WorldFlags.k_MainEntranceBlocked);
            string[] afterEntranceSign = Append(afterBlockedEntrance, WorldFlags.k_MainEntranceSignRead);
            string[] afterFacilityPoster = Append(afterEntranceSign, WorldFlags.k_ResearchFacilityPosterRead);

            // Chapter 00 follows Main's authored polluted-day default. Keeping checkpoints on LevelDefault
            // prevents them from silently overriding later lighting revisions.
            return new[]
            {
                Make("00-01_Wake", "00-01 Wake", "",
                    new Vector3(0f, 3.8f, -10f), 0f, new string[0], noRecords),
                Make("00-04_RadioBriefing", "00-04 Radio briefing", "",
                    new Vector3(0f, 5f, 0f), 0f, afterStart, noRecords),
                Make("00-05_HelmetUnlock", "00-05 Helmet unlock", "",
                    new Vector3(0f, 5f, 15f), 0f, afterRadio, noRecords),
                Make("00-06_GrassBelt", "00-06 Grass belt", "Anchor_00-06_GrassBelt",
                    new Vector3(-16f, 7f, 28f), 20f, afterHelmet, noRecords),
                Make("00-07_FirstToolUse", "00-07 First tool use", "Anchor_00-07_FirstToolUse",
                    new Vector3(-12f, 6.285f, 39f), 20f, afterGrassBelt, noRecords),
                Make("00-08_ResearchFacilityView", "00-08 Facility reveal", "Anchor_00-08_ResearchFacilityView",
                    new Vector3(1.5f, 7.289f, 73.5f), 10f, afterInvestigation, investigationRecords),
                Make("00-09_BlockedMainEntrance", "00-09 Blocked main entrance", "Anchor_00-09_BlockedMainEntrance",
                    new Vector3(30f, 7.8f, 96.2f), 0f, afterInvestigation, investigationRecords),
                Make("00-10_MainEntranceSign", "00-10 Main entrance sign", "Anchor_00-10_MainEntranceSign",
                    new Vector3(25.8f, 7.8f, 95.5f), 70f, afterBlockedEntrance, investigationRecords),
                Make("00-11_ResearchFacilityPoster", "00-11 Research facility poster",
                    "Anchor_00-11_ResearchFacilityPoster",
                    new Vector3(23f, 7.8f, 97.8f), 75f, afterEntranceSign, investigationRecords),
            };
        }

        private static Spec Make(
            string fileName, string label, string anchorName, Vector3 position, float yaw, string[] flags,
            string[] recordPaths, bool snapToGround = true, bool useAnchorHeight = true)
        {
            return new Spec
            {
                FileName = fileName,
                Label = label,
                AnchorName = anchorName,
                Position = position,
                Yaw = yaw,
                SnapToGround = snapToGround,
                UseAnchorHeight = useAnchorHeight,
                TimeOfDay = CheckpointTimeOfDay.LevelDefault,
                Flags = flags,
                RecordPaths = recordPaths,
            };
        }

        private static string[] Append(string[] values, string value)
        {
            string[] result = new string[values.Length + 1];
            values.CopyTo(result, 0);
            result[values.Length] = value;
            return result;
        }

        private static InvestigationTargetSO[] LoadRecords(string[] paths)
        {
            List<InvestigationTargetSO> records = new List<InvestigationTargetSO>(paths.Length);

            for (int i = 0; i < paths.Length; i++)
            {
                InvestigationTargetSO target = AssetDatabase.LoadAssetAtPath<InvestigationTargetSO>(paths[i]);

                if (target == null)
                {
                    Debug.LogError("Dev Play: missing investigation target " + paths[i]);
                    continue;
                }

                records.Add(target);
            }

            return records.ToArray();
        }
    }
}
