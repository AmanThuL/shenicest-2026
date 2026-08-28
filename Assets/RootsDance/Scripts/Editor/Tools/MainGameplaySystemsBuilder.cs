using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Brings Main_Gameplay up to the player systems PlayerTest_Gameplay already had: the arms rig
    /// wiring, the scan flow and the helmet HUD.
    /// </summary>
    /// <remarks>
    /// <para>
    /// Main_Gameplay began as a copy of an older PlayerTest and then grew its own content — the
    /// triggers, the zone volume, the radio sequence, the investigation targets. What it never
    /// picked up is everything the player rig gained since: the arms director's own references sit
    /// on the *instance*, not on Player.prefab, so a scene that instantiated the prefab afterwards
    /// gets them null; there is no scan effect for the scanner to point at; and there is no HUD
    /// canvas at all. This runs the three owning builders against Main instead of PlayerTest, so
    /// the wiring stays defined in one place per system rather than copied between scenes.
    /// </para>
    /// <para>
    /// The scan flow's ScannableSample is dropped afterwards: it is a test cube, and Main has its
    /// own content to scan. Everything else the builders do is wanted as-is.
    /// </para>
    /// <para>
    /// Main_Environment is never opened. The gameplay scene is a part on its own and nothing here
    /// reads the terrain, so a shared scene stays out of it.
    /// </para>
    /// Menu: RootsDance > Build Main Gameplay Systems.
    /// </remarks>
    public static class MainGameplaySystemsBuilder
    {
        private const string k_Gameplay = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_FlowRoot = "ScannerFlow";
        private const string k_SampleName = "ScannableSample";

        [MenuItem("RootsDance/Build Main Gameplay Systems")]
        public static void Build()
        {
            Scene gameplay = EditorSceneManager.OpenScene(k_Gameplay, OpenSceneMode.Single);

            // Order matters. The HUD goes first because the scan flow hangs its proximity prompt
            // on the HUD's InteractPrompt label and silently skips the presenter when there is
            // none; the arms rig goes before the scan flow, which points a view at it.
            RootsDance.Editor.Tools.HelmetHudBuilder.BuildMain();
            ArmsRigWiringBuilder.Wire();
            RefreshArmsFraming(EditorSceneManager.GetSceneByPath(k_Gameplay));
            ScannerFlowBuilder.Build();
            DropTestSample(gameplay);

            gameplay = EditorSceneManager.GetSceneByPath(k_Gameplay);
            EditorSceneManager.MarkSceneDirty(gameplay);
            EditorSceneManager.SaveScene(gameplay);

            Debug.Log("MainGameplaySystemsBuilder: arms rig, scan flow and helmet HUD are in "
                + $"{k_Gameplay}.");
        }

        /// <summary>
        /// Rebuilds the arms framing table, which is also what points the view bob at the head. Its
        /// own menu item opens the PlayerTest level, so the public entry point is called directly
        /// with the arms found here instead.
        /// </summary>
        private static void RefreshArmsFraming(Scene gameplay)
        {
            foreach (GameObject root in gameplay.GetRootGameObjects())
            {
                foreach (Transform t in root.GetComponentsInChildren<Transform>(true))
                {
                    if (t.name != "Arms")
                    {
                        continue;
                    }

                    RootsDance.Editor.Tools.ArmsFramingBuilder.Refresh(t);
                    return;
                }
            }

            Debug.LogWarning("MainGameplaySystemsBuilder: no 'Arms' under the Player; the view bob "
                + "falls back to its parent instead of the head.");
        }

        /// <summary>
        /// Removes the scan flow's test cube. The builder always makes one, because in the test rig
        /// it is the only thing there is to scan; in the level it would be a grey box on the path.
        /// </summary>
        private static void DropTestSample(Scene gameplay)
        {
            foreach (GameObject root in gameplay.GetRootGameObjects())
            {
                if (root.name != k_FlowRoot)
                {
                    continue;
                }

                Transform sample = root.transform.Find(k_SampleName);

                if (sample != null)
                {
                    Object.DestroyImmediate(sample.gameObject);
                    Debug.Log($"MainGameplaySystemsBuilder: dropped the {k_SampleName} test cube.");
                }
            }
        }
    }
}
