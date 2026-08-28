using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>Runs the complete deterministic Briggs Interior authoring pass.</summary>
    public static class BriggsInteriorEnvironmentBuildPipeline
    {
        [MenuItem("RootsDance/Environment/Build Complete Briggs Interior")]
        public static void BuildFromMenu()
        {
            BuildFromCommandLine();
        }

        /// <summary>Batch entry point used by CI and one-shot worktree builds.</summary>
        public static void BuildFromCommandLine()
        {
            BriggsInteriorGameplaySetupBuilder.ApplyAndSave();
            BriggsInteriorDressingBuilder.BuildAndSave();
            BriggsInteriorAtmosphereBuilder.ApplyFromCommandLine();
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Debug.Log("BriggsInteriorEnvironmentBuildPipeline: complete.");
        }
    }
}
