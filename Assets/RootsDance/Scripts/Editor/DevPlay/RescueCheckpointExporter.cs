using System;
using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using UnityEditor;
using UnityEditor.Build;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>Exports runtime-only checkpoint data and rejects stale or unusable enabled build catalogs.</summary>
    public sealed class RescueCheckpointExporter : BuildPlayerProcessor
    {
        public const string k_CatalogPath = "Assets/RootsDance/Data/Config/RescueCheckpoints.asset";
        private const string k_SourceFolder = "Assets/RootsDance/Data/DevPlay";

        public override int callbackOrder => 0;

        public override void PrepareForBuild(BuildPlayerContext buildPlayerContext)
        {
            RescueCheckpointCatalogSO catalog = AssetDatabase.LoadAssetAtPath<RescueCheckpointCatalogSO>(k_CatalogPath);
            List<string> errors = ValidateCatalog(catalog, buildPlayerContext.BuildPlayerOptions.scenes);
            if (errors.Count > 0)
            {
                throw new BuildFailedException("Rescue checkpoints are not ready:\n" + string.Join("\n", errors));
            }
        }

        [MenuItem("Tools/RootsDance/Dev Play/Refresh Rescue Checkpoints")]
        public static void RefreshFromMenu()
        {
            RefreshCatalog();
        }

        /// <summary>Saves only the generated catalog, never other dirty project assets.</summary>
        public static RescueCheckpointCatalogSO RefreshCatalog()
        {
            RescueCheckpointCatalogSO catalog = AssetDatabase.LoadAssetAtPath<RescueCheckpointCatalogSO>(k_CatalogPath);
            if (catalog == null)
            {
                catalog = ScriptableObject.CreateInstance<RescueCheckpointCatalogSO>();
                AssetDatabase.CreateAsset(catalog, k_CatalogPath);
            }

            catalog.ReplaceCheckpoints(BuildSnapshot());
            EditorUtility.SetDirty(catalog);
            AssetDatabase.SaveAssetIfDirty(catalog);
            return catalog;
        }

        /// <summary>Copies every source checkpoint in stable label/path order without any asset writes.</summary>
        public static List<RescueCheckpoint> BuildSnapshot()
        {
            string[] guids = AssetDatabase.FindAssets("t:DevCheckpointSO", new[] { k_SourceFolder });
            var sources = new List<DevCheckpointSO>(guids.Length);
            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                DevCheckpointSO source = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(path);
                if (source != null)
                {
                    sources.Add(source);
                }
            }

            sources.Sort(CompareSources);
            var result = new List<RescueCheckpoint>(sources.Count);
            foreach (DevCheckpointSO source in sources)
            {
                string id = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(source));
                result.Add(ExportCheckpoint(source, id));
            }

            return result;
        }

        public static RescueCheckpoint ExportCheckpoint(DevCheckpointSO source, string id)
        {
            if (source == null)
            {
                throw new ArgumentNullException(nameof(source));
            }

            bool overrideTimeOfDay = DevCheckpointSeed.TryToRuntime(source.TimeOfDay, out TimeOfDay timeOfDay);
            return new RescueCheckpoint(
                id, source.Label, source.Level, source.AnchorName, source.Position, source.Yaw,
                overrideTimeOfDay, timeOfDay, source.Flags, source.RecordedTargets, source.SnapToGround,
                source.GroundLayers.value, source.GroundClearance, source.UseAnchorHeight);
        }

        /// <summary>Uses the actual build's scene paths, including custom BuildPlayerOptions scene lists.</summary>
        public static List<string> ValidateCatalog(
            RescueCheckpointCatalogSO catalog, IReadOnlyList<string> includedScenes)
        {
            var errors = new List<string>();
            if (catalog == null)
            {
                errors.Add("Missing rescue catalog. Run Tools > RootsDance > Dev Play > Refresh Rescue Checkpoints.");
                return errors;
            }

            if (!catalog.EnabledInPlayer)
            {
                return errors;
            }

            string[] bootstrapDependencies = AssetDatabase.GetDependencies(ScenePaths.k_Bootstrap, true);
            if (Array.IndexOf(bootstrapDependencies, k_CatalogPath) < 0)
            {
                errors.Add("Bootstrap does not reference the rescue catalog. "
                    + "Run RootsDance > Dev Play > Install Build Checkpoint Rescue.");
            }

            List<RescueCheckpoint> expected = BuildSnapshot();
            if (!MatchesSnapshot(catalog.Checkpoints, expected))
            {
                errors.Add("Rescue catalog is stale. Run Tools > RootsDance > Dev Play > Refresh Rescue Checkpoints.");
            }

            errors.AddRange(ValidateCheckpoints(catalog.Checkpoints, includedScenes));
            return errors;
        }

        public static bool MatchesSnapshot(
            IReadOnlyList<RescueCheckpoint> actual, IReadOnlyList<RescueCheckpoint> expected)
        {
            if (actual == null || expected == null || actual.Count != expected.Count)
            {
                return false;
            }

            for (int i = 0; i < actual.Count; i++)
            {
                if (actual[i] == null || expected[i] == null
                    || JsonUtility.ToJson(actual[i]) != JsonUtility.ToJson(expected[i]))
                {
                    return false;
                }
            }

            return true;
        }

        public static List<string> ValidateCheckpoints(
            IReadOnlyList<RescueCheckpoint> checkpoints, IReadOnlyList<string> includedScenes)
        {
            var errors = new List<string>();
            var ids = new HashSet<string>(StringComparer.Ordinal);
            var scenes = new HashSet<string>(StringComparer.Ordinal);
            if (includedScenes != null)
            {
                for (int i = 0; i < includedScenes.Count; i++)
                {
                    scenes.Add(includedScenes[i]);
                }
            }

            if (checkpoints == null || checkpoints.Count == 0)
            {
                errors.Add("Enabled rescue catalog has no checkpoints.");
                return errors;
            }

            foreach (RescueCheckpoint checkpoint in checkpoints)
            {
                if (checkpoint == null)
                {
                    errors.Add("Rescue catalog contains an empty checkpoint.");
                    continue;
                }

                if (!RescueCheckpoint.IsValidId(checkpoint.Id) || !ids.Add(checkpoint.Id))
                {
                    errors.Add($"{checkpoint.Label}: invalid or duplicate checkpoint ID.");
                }

                if (checkpoint.Level == null || checkpoint.Level.ScenePaths == null
                    || checkpoint.Level.ScenePaths.Count == 0)
                {
                    errors.Add($"{checkpoint.Label}: no target level scenes.");
                    continue;
                }

                foreach (string scene in checkpoint.Level.ScenePaths)
                {
                    if (string.IsNullOrWhiteSpace(scene) || !scenes.Contains(scene))
                    {
                        errors.Add($"{checkpoint.Label}: target scene is not included in this build: {scene}");
                    }
                    else if (AssetDatabase.LoadAssetAtPath<SceneAsset>(scene) == null)
                    {
                        errors.Add($"{checkpoint.Label}: target scene asset does not exist: {scene}");
                    }
                }

                foreach (RootsDance.Investigation.InvestigationTargetSO target in checkpoint.RecordedTargets)
                {
                    if (target == null)
                    {
                        errors.Add($"{checkpoint.Label}: a recorded investigation target is missing.");
                    }
                }
            }

            return errors;
        }

        private static int CompareSources(DevCheckpointSO left, DevCheckpointSO right)
        {
            int byLabel = StringComparer.Ordinal.Compare(left.Label, right.Label);
            return byLabel != 0 ? byLabel : StringComparer.Ordinal.Compare(
                AssetDatabase.GetAssetPath(left), AssetDatabase.GetAssetPath(right));
        }
    }
}
