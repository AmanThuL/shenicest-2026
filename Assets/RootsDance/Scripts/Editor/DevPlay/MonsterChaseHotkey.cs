using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// One key straight into the monster chase: F9 starts Play from the 03-03 checkpoint —
    /// standing at the greenhouse terminal, wrong choice made, boss waking up. In Play mode it
    /// re-applies the checkpoint instead (switching levels if needed), so retuning a run is
    /// F9, watch, F9 again. The checkpoint asset comes from
    /// <see cref="RootsDance.Editor.Environment.MonsterChaseSetupBuilder"/>.
    /// </summary>
    public static class MonsterChaseHotkey
    {
        private const string k_CheckpointPath =
            "Assets/RootsDance/Data/DevPlay/GreenhouseInterior/03-03_MonsterChase.asset";

        [MenuItem("RootsDance/Dev Play/Play Monster Chase _F9")]
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
