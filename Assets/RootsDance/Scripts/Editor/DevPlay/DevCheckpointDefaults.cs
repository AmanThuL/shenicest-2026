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
    /// assets are never touched, so tuned positions and yaws survive a re-run.
    /// </summary>
    public static class DevCheckpointDefaults
    {
        private const string k_MenuPath = "RootsDance/Dev Play/Create Default Checkpoints";
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
                    spec.Label, main, spec.AnchorName, spec.Position, 0f, spec.Flags,
                    spec.WithRecords ? records : new InvestigationTargetSO[0]);
                AssetDatabase.CreateAsset(checkpoint, path);
                created++;
            }

            AssetDatabase.SaveAssets();
            Debug.Log("Dev Play: " + created + " checkpoint(s) created, " + (specs.Length - created)
                + " already existed in " + k_Folder + ".");
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

            return new[]
            {
                Make("00-01_Wake", "00-01 Wake", "", new Vector3(0f, 3.8f, -10f), new string[0], false),
                Make("00-04_RadioBriefing", "00-04 Radio briefing", "", new Vector3(0f, 5f, 0f), afterStart, false),
                Make("00-05_HelmetUnlock", "00-05 Helmet unlock", "", new Vector3(0f, 5f, 15f), afterRadio, false),
                Make("00-06_GrassBelt", "00-06 Grass belt", "", new Vector3(0f, 7f, 32f), afterHelmet, false),
                Make("00-07_GrassPlatform", "00-07 Grass platform", "Anchor_00-07_GrassPlatform",
                    new Vector3(-12f, 6.5f, 39f), afterInvestigation, true),
                Make("00-09_MainGate", "00-09 Main gate", "Anchor_00-09_MainGate",
                    new Vector3(0f, 7.5f, 80f), afterInvestigation, true),
                Make("00-10_Sign", "00-10 Sign", "Anchor_00-10_Sign",
                    new Vector3(-12f, 7.5f, 83f), afterInvestigation, true),
                Make("00-11_Poster", "00-11 Poster", "Anchor_00-11_Poster",
                    new Vector3(-40f, 7.5f, 96f), afterInvestigation, true),
                Make("00-16_ServiceEntrance", "00-16 Service entrance", "Anchor_00-16_ServiceEntrance",
                    new Vector3(41f, 4.5f, 105f), afterInvestigation, true),
            };
        }

        private static Spec Make(
            string fileName, string label, string anchorName, Vector3 position, string[] flags, bool withRecords)
        {
            return new Spec
            {
                FileName = fileName,
                Label = label,
                AnchorName = anchorName,
                Position = position,
                Flags = flags,
                WithRecords = withRecords,
            };
        }
    }
}
