using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// One key straight into the monster chase: Cmd+Shift+M starts Play from the 03-03 checkpoint —
    /// standing at the greenhouse terminal, wrong choice made, boss waking up. In Play mode it
    /// re-applies the checkpoint instead (switching levels if needed), so retuning a run is
    /// one press to watch, another to go again. The checkpoint asset comes from
    /// <see cref="RootsDance.Editor.Environment.MonsterChaseSetupBuilder"/>.
    /// </summary>
    public static class MonsterChaseHotkey
    {
        private const string k_CheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-03_MonsterChase.asset";

        // Cmd+Shift+M, not an F-key: macOS owns the F row (media keys, Mission Control) and eats
        // bare F-key menu shortcuts unless the user rebinds their keyboard settings.
        [MenuItem("RootsDance/Dev Play/Play Monster Chase %#m")]
        public static void PlayMonsterChase()
        {
            DevCheckpointSO checkpoint = AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(k_CheckpointPath);

            if (checkpoint == null)
            {
                Debug.LogError("Monster chase checkpoint not found at " + k_CheckpointPath
                    + ". Run RootsDance > Chase > Build Monster Chase Setup first.");
                return;
            }

            DevPlaySession.PlayFrom(checkpoint);
        }
    }
}
