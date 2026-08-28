using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Strips the components the URP-to-HDRP migration left behind in scenes.
    /// <para>
    /// The URP package is gone, so <c>UniversalAdditionalCameraData</c> and its siblings survive
    /// only as missing scripts — invisible in the Inspector but still written into the scene YAML,
    /// which is what <c>UrpResidueTests</c> catches. Removing them through
    /// <see cref="GameObjectUtility.RemoveMonoBehavioursWithMissingScript"/> is the only supported
    /// way: guideline 06 forbids hand-editing scene YAML, and there is no live type to remove.
    /// </para>
    /// Menu: <c>RootsDance &gt; Clean URP Residue From Open Scenes</c>.
    /// </summary>
    public static class UrpResidueCleaner
    {
        [MenuItem("RootsDance/Clean URP Residue From Open Scenes")]
        public static void Clean()
        {
            var log = new StringBuilder("UrpResidueCleaner\n");
            int total = 0;

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                int removed = 0;

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    foreach (Transform t in root.GetComponentsInChildren<Transform>(true))
                    {
                        removed += GameObjectUtility.RemoveMonoBehavioursWithMissingScript(t.gameObject);
                    }
                }

                if (removed > 0)
                {
                    EditorSceneManager.MarkSceneDirty(scene);
                }

                log.Append("  ").Append(scene.name).Append(": ").Append(removed)
                    .AppendLine(" missing-script component(s) removed");
                total += removed;
            }

            log.Append("total: ").Append(total);
            Debug.Log(log.ToString());
        }

        /// <summary>Batch entry: opens the sandbox scene the migration left residue in, cleans, saves.</summary>
        public static void CleanSandbox()
        {
            const string path = "Assets/_Sandbox/UISandboxDemo/Test_DataScreen.unity";

            EditorSceneManager.OpenScene(path, OpenSceneMode.Single);
            Clean();
            EditorSceneManager.SaveOpenScenes();
            Debug.Log("UrpResidueCleaner: sandbox scene saved.");
        }
    }
}
