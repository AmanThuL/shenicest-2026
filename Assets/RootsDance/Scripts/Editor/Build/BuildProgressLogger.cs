using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Build
{
    /// <summary>
    /// Logs one marker per scene while the player build serialises scenes, so
    /// Tools/build/build.py can show "scene 9/16" and switch to the "packing" phase on the
    /// last one. Silent outside command-line builds (the callback also fires when entering
    /// Play mode, with a null report).
    /// </summary>
    public sealed class BuildProgressLogger : IProcessSceneWithReport
    {
        private static int s_processed;

        public int callbackOrder => 0;

        public static void Reset()
        {
            s_processed = 0;
        }

        public void OnProcessScene(Scene scene, BuildReport report)
        {
            if (report == null || !BuildScript.IsCommandLineBuild)
            {
                return;
            }

            int total = 0;
            foreach (EditorBuildSettingsScene entry in EditorBuildSettings.scenes)
            {
                if (entry.enabled)
                {
                    total++;
                }
            }

            s_processed++;
            Debug.Log(string.Format("[BuildScript] scene {0}/{1} {2}", s_processed, total, scene.path));
            if (s_processed >= total)
            {
                Debug.Log("[BuildScript] scenes done");
            }
        }
    }
}
