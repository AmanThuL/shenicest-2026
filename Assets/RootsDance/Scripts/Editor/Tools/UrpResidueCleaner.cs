using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Strips the objects the URP-to-HDRP migration left behind in scenes and materials.
    /// <para>
    /// The URP package is gone, so <c>UniversalAdditionalCameraData</c> and its siblings survive
    /// only as missing scripts — invisible in the Inspector but still written into the scene YAML,
    /// which is what <c>UrpResidueTests</c> catches. Removing them through
    /// <see cref="GameObjectUtility.RemoveMonoBehavioursWithMissingScript"/> is the only supported
    /// way: guideline 06 forbids hand-editing scene YAML, and there is no live type to remove.
    /// </para>
    /// <para>
    /// Materials authored in a URP project carry the same residue in a different shape: a hidden
    /// <c>UnityEditor.Rendering.Universal.AssetVersion</c> sidecar sub-asset. It has no live type
    /// either, and unlike a scene component it has no owning GameObject, so
    /// <see cref="AssetDatabase.LoadAllAssetsAtPath"/> hands it back as a plain <c>null</c> —
    /// nothing to pass to <see cref="AssetDatabase.RemoveObjectFromAsset"/>. The fix is to let
    /// Unity write the material out again from a clone, which carries no sub-assets, and put those
    /// bytes back under the original <c>.meta</c> so the GUID and every reference survive.
    /// </para>
    /// Menu: <c>RootsDance &gt; Clean URP Residue From Open Scenes</c> /
    /// <c>RootsDance &gt; Clean URP Residue From Materials</c>.
    /// </summary>
    public static class UrpResidueCleaner
    {
        /// <summary>MonoScript GUID of <c>UnityEditor.Rendering.Universal.AssetVersion</c>.</summary>
        private const string k_UrpAssetVersionGuid = "d0353a89b1f911e48b9e16bdc9f2e058";

        /// <summary>Scratch folder the rewritten material is serialized into before it replaces the original.</summary>
        private const string k_ScratchFolder = "Assets/UrpResidueCleanerScratch";

        /// <summary>The roots <c>UrpResidueTests</c> guards, so the cleaner covers exactly what the test does.</summary>
        private static readonly string[] k_Roots = { "Assets/RootsDance", "Assets/_Sandbox" };

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

        /// <summary>Rewrites every material under the guarded roots that still carries the URP sidecar.</summary>
        [MenuItem("RootsDance/Clean URP Residue From Materials")]
        public static void CleanMaterials()
        {
            var log = new StringBuilder("UrpResidueCleaner (materials)\n");
            List<string> paths = MaterialsWithUrpSidecar();

            if (paths.Count == 0)
            {
                Debug.Log(log.Append("  nothing to do").ToString());
                return;
            }

            int rewritten = 0;

            foreach (string path in paths)
            {
                log.Append("  ").Append(path).Append(": ");

                if (Rewrite(path, log))
                {
                    rewritten++;
                }
            }

            AssetDatabase.DeleteAsset(k_ScratchFolder);
            AssetDatabase.SaveAssets();
            log.Append("total: ").Append(rewritten).Append('/').Append(paths.Count).Append(" rewritten");
            Debug.Log(log.ToString());
        }

        /// <summary>Every material file under the guarded roots whose text still names the URP sidecar script.</summary>
        private static List<string> MaterialsWithUrpSidecar()
        {
            var paths = new List<string>();

            foreach (string root in k_Roots)
            {
                if (!Directory.Exists(root))
                {
                    continue;
                }

                foreach (string file in Directory.EnumerateFiles(root, "*.mat", SearchOption.AllDirectories))
                {
                    if (File.ReadAllText(file).Contains(k_UrpAssetVersionGuid))
                    {
                        paths.Add(file.Replace('\\', '/'));
                    }
                }
            }

            return paths;
        }

        /// <summary>
        /// Serializes a clone of the material — clones carry no sub-assets — and moves those bytes
        /// over the original file. The original <c>.meta</c> is never touched, so the GUID holds.
        /// The scratch file keeps the material's own name, because <see cref="AssetDatabase.CreateAsset"/>
        /// renames the object it writes after the file it writes it to.
        /// </summary>
        private static bool Rewrite(string path, StringBuilder log)
        {
            var original = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (original == null)
            {
                log.AppendLine("skipped, material would not load");
                return false;
            }

            if (original.shader == null)
            {
                log.AppendLine("skipped, shader is missing — rewriting would drop the reference");
                return false;
            }

            Shader shader = original.shader;
            string scratch = k_ScratchFolder + "/" + Path.GetFileName(path);
            AssetDatabase.DeleteAsset(scratch);

            if (!AssetDatabase.IsValidFolder(k_ScratchFolder))
            {
                AssetDatabase.CreateFolder("Assets", Path.GetFileName(k_ScratchFolder));
            }

            AssetDatabase.CreateAsset(Object.Instantiate(original), scratch);
            AssetDatabase.SaveAssets();

            File.Copy(scratch, path, true);
            AssetDatabase.DeleteAsset(scratch);
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);

            var rewritten = AssetDatabase.LoadAssetAtPath<Material>(path);
            bool clean = !File.ReadAllText(path).Contains(k_UrpAssetVersionGuid);

            if (!clean)
            {
                log.AppendLine("STILL carries the sidecar");
                return false;
            }

            if (rewritten == null || rewritten.shader != shader)
            {
                log.AppendLine("REWRITTEN BUT the shader reference did not survive");
                return false;
            }

            log.Append("rewritten without the sidecar, name '").Append(rewritten.name)
                .Append("', shader '").Append(rewritten.shader.name).AppendLine("'");
            return true;
        }
    }
}
