using System.Text;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Reports the arms hierarchy as it actually stands in the scene on disk. Written because the
    /// height anchor's damage was invisible from any single component: the arms looked correctly
    /// parented, the view bob looked correctly wired, and nobody was reading the one fact that
    /// mattered — that the transform between them was not the head.
    /// </summary>
    public static class ArmsRigProbe
    {
        private const string k_Environment =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_Gameplay =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";

        /// <summary>
        /// Reimports the arms models, then reports. The loop flag on a clip is written by
        /// BlenderModelPostprocessor from the import profile, so it only changes on an import —
        /// which is also why editing the .meta appears to work and then silently reverts.
        /// </summary>
        public static void ReimportAndReport()
        {
            foreach (string guid in AssetDatabase.FindAssets(
                "t:Model", new[] { "Assets/RootsDance/Meshes/Characters" }))
            {
                AssetDatabase.ImportAsset(AssetDatabase.GUIDToAssetPath(guid),
                    ImportAssetOptions.ForceUpdate);
            }

            AssetDatabase.SaveAssets();
            Report();
        }

        public static void Report()
        {
            if (!EditorSceneManager.GetSceneByPath(k_Environment).isLoaded)
            {
                EditorSceneManager.OpenScene(k_Environment, OpenSceneMode.Single);
            }

            if (!EditorSceneManager.GetSceneByPath(k_Gameplay).isLoaded)
            {
                EditorSceneManager.OpenScene(k_Gameplay, OpenSceneMode.Additive);
            }

            var sb = new StringBuilder("ARMS RIG\n");

            ArmsViewOffset offset = Object.FindFirstObjectByType<ArmsViewOffset>(FindObjectsInactive.Include);

            if (offset == null)
            {
                Debug.LogError("ArmsRigProbe: no ArmsViewOffset in the open scenes.");
                return;
            }

            Transform arms = offset.transform;
            sb.Append("  arms            : ").AppendLine(Path(arms));
            sb.Append("  arms parent     : ").AppendLine(arms.parent == null ? "<none>" : arms.parent.name);

            // The whole point of the change: no object may sit between the arms and the head.
            int anchors = 0;

            foreach (Transform t in Object.FindObjectsByType<Transform>(FindObjectsInactive.Include,
                FindObjectsSortMode.None))
            {
                if (t.name == "ArmsHeightAnchor")
                {
                    anchors++;
                    sb.Append("  LEFTOVER ANCHOR : ").AppendLine(Path(t));
                }
            }

            sb.Append("  height anchors  : ").Append(anchors)
                .AppendLine(anchors == 0 ? "  (removed)" : "  (STILL PRESENT)");

            ArmsHeightRig rig = offset.GetComponent<ArmsHeightRig>();
            sb.Append("  height rig      : ")
                .AppendLine(rig == null ? "MISSING" : Path(rig.transform) + "   drop=" + rig.CurrentDrop.ToString("F3"));

            // Which transform the drop lands on is the whole of the crawl bug: on the arms it is
            // invisible to the camera, on the view target it moves both.
            CameraBoneViewBob dropOwner = offset.GetComponent<CameraBoneViewBob>();
            sb.Append("  drop applied to : ").AppendLine(dropOwner == null
                ? "nothing — no CameraBoneViewBob"
                : "the view target, by CameraBoneViewBob");
            sb.Append("  rig on the arms : ").AppendLine(
                rig != null && rig.transform == arms ? "yes" : "NO — it should live on the arms");

            CameraBoneViewBob bob = Object.FindFirstObjectByType<CameraBoneViewBob>(FindObjectsInactive.Include);

            if (bob == null)
            {
                sb.AppendLine("  view bob        : NOT IN SCENE");
            }
            else
            {
                Transform target = Field<Transform>(bob, "m_viewTarget");
                Transform bone = Field<Transform>(bob, "m_cameraBone");
                sb.Append("  view bob drives : ").AppendLine(target == null ? "NOT WIRED" : Path(target));
                sb.Append("  camera bone     : ").AppendLine(bone == null ? "NOT WIRED" : bone.name);
                sb.Append("  bob target is the arms' parent : ").AppendLine(
                    target != null && target == arms.parent ? "yes" : "NO");
            }

            ReportClipLooping(sb);
            Debug.Log(sb.ToString());
        }

        /// <summary>
        /// Every action clip's loop flag, read off the imported clip. The flag is authored in
        /// Tools/unity/model_import_profiles.json and written by BlenderModelPostprocessor on every
        /// import, so fixing it on the .meta fixes nothing: the next reimport puts it back. Crawl
        /// came back as a loop three times that way. This prints the end state, which is the only
        /// thing worth trusting.
        /// </summary>
        private static void ReportClipLooping(StringBuilder sb)
        {
            sb.AppendLine("  action clips (loop flag as imported):");

            foreach (string guid in AssetDatabase.FindAssets("t:ArmsActionSO",
                new[] { "Assets/RootsDance/Data/Arms/Actions" }))
            {
                var action = AssetDatabase.LoadAssetAtPath<ArmsActionSO>(AssetDatabase.GUIDToAssetPath(guid));

                if (action == null)
                {
                    continue;
                }

                sb.Append("    ").Append(action.name.PadRight(22))
                    .AppendLine(action.Clip == null
                        ? "no clip"
                        : (action.Clip.isLooping ? "LOOPS" : "one-shot"));
            }
        }

        private static T Field<T>(Object owner, string name) where T : Object
        {
            var serialized = new SerializedObject(owner);
            SerializedProperty property = serialized.FindProperty(name);
            return property == null ? null : property.objectReferenceValue as T;
        }

        private static string Path(Transform t)
        {
            var sb = new StringBuilder(t.name);

            for (Transform p = t.parent; p != null; p = p.parent)
            {
                sb.Insert(0, p.name + "/");
            }

            return sb.ToString();
        }
    }
}
