using RootsDance.Editor.Environment;
using RootsDance.Editor.Tools;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>Runs every deterministic asset and scene pass required by the rune-keypad hand-off.</summary>
    public static class RuneKeypadFeatureBuilder
    {
        [MenuItem("RootsDance/Build Rune Keypad Feature")]
        public static void BuildAll()
        {
            RuneKeypadBuilder.BuildAll();
            CorridorPostersBuilder.Build();
            CorridorVisibilityBuilder.ApplyToLoadedScene();
            BootScreenFadeOverlayBuilder.ApplyAndSave();
            BriggsInteriorGameplaySetupBuilder.ApplyAndSave();
            AssetDatabase.SaveAssets();
            Debug.Log("RuneKeypadFeatureBuilder: built keypad, clues, visibility, fade and lab spawn.");

            if (Application.isBatchMode)
            {
                EditorApplication.Exit(0);
            }
        }
    }
}
