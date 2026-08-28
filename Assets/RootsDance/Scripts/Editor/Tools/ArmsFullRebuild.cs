using System.Text;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Rebuilds the arms and scanner end to end and then measures the result, in one pass.
    /// <para>
    /// It exists because the same bug kept coming back: a fix would be verified in one project and
    /// the generated assets in another would stay stale, so the thing that was checked was never
    /// the thing that ran. Everything here happens in one project, and the report at the end reads
    /// the assets and the scene rather than restating what was asked for.
    /// </para>
    /// </summary>
    public static class ArmsFullRebuild
    {
        private const string k_Environment =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity";
        private const string k_Gameplay =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";

        public static void Run()
        {
            AssetDatabase.Refresh();

            foreach (string guid in AssetDatabase.FindAssets(
                "t:Model", new[] { "Assets/RootsDance/Meshes/Characters", "Assets/RootsDance/Meshes/Props" }))
            {
                AssetDatabase.ImportAsset(
                    AssetDatabase.GUIDToAssetPath(guid), ImportAssetOptions.ForceUpdate);
            }

            AssetDatabase.SaveAssets();

            ArmsControllerBuilder.CreateActionSet();
            ArmsControllerBuilder.BuildController();
            AssetDatabase.SaveAssets();

            EditorSceneManager.OpenScene(k_Environment, OpenSceneMode.Single);
            EditorSceneManager.OpenScene(k_Gameplay, OpenSceneMode.Additive);

            ArmsRigWiringBuilder.Wire();

            var offset = Object.FindFirstObjectByType<ArmsViewOffset>(FindObjectsInactive.Include);

            if (offset != null)
            {
                // The shared offset accumulated garbage from a feedback loop; it is taste-only, so
                // clearing it costs a re-tune and keeps a corrupt number out of the build.
                var so = new SerializedObject(offset);
                so.FindProperty("m_positionOffset").vector3Value = Vector3.zero;
                so.FindProperty("m_rotationOffset").vector3Value = Vector3.zero;
                so.ApplyModifiedPropertiesWithoutUndo();

                RootsDance.Editor.Tools.ArmsFramingBuilder.Refresh(offset.transform);
            }

            ScannerFlowBuilder.Build();
            EditorSceneManager.SaveOpenScenes();

            Debug.Log(Report());
        }

        private static string Report()
        {
            var sb = new StringBuilder("REBUILD REPORT\n");

            var set = AssetDatabase.LoadAssetAtPath<ArmsActionSetSO>(
                "Assets/RootsDance/Data/Arms/PlayerArmsActions.asset");

            sb.AppendLine("  actions — how each one is actually driven:");

            foreach (ArmsActionSO action in set.Actions)
            {
                if (action == null)
                {
                    continue;
                }

                bool clipLoops = action.Clip != null && action.Clip.isLooping;
                sb.Append("    ").Append(action.Id.PadRight(14))
                    .Append("key=").Append(action.DebugKey.ToString().PadRight(6))
                    .Append("clipLoops=").Append(clipLoops.ToString().PadRight(6))
                    .Append("hold=").Append(action.HoldAfterFinish.ToString().PadRight(6))
                    .AppendLine(clipLoops ? "runs forever" : action.HoldAfterFinish ? "once, holds" : "once, returns");
            }

            var offset = Object.FindFirstObjectByType<ArmsViewOffset>(FindObjectsInactive.Include);
            var bob = Object.FindFirstObjectByType<CameraBoneViewBob>(FindObjectsInactive.Include);

            if (offset != null)
            {
                Transform parent = offset.transform.parent;
                Transform cameraBone = null;

                foreach (Transform t in offset.GetComponentsInChildren<Transform>(true))
                {
                    if (t.name == "camera")
                    {
                        cameraBone = t;
                        break;
                    }
                }

                sb.Append("  arms parent   : ").AppendLine(parent == null ? "?" : parent.name);
                sb.Append("  sharedOffset  : ").AppendLine(offset.PositionOffset.ToString("F4"));

                if (cameraBone != null && parent != null)
                {
                    sb.Append("  eye vs head   : ")
                        .Append(parent.InverseTransformPoint(cameraBone.position).ToString("F4"))
                        .AppendLine("   (0,0,0) = aligned)");
                }
            }

            if (bob != null)
            {
                SerializedProperty target = new SerializedObject(bob).FindProperty("m_viewTarget");
                sb.Append("  view bob drives: ")
                    .AppendLine(target == null || target.objectReferenceValue == null
                        ? "NOTHING" : target.objectReferenceValue.name);
                sb.AppendLine("    (must be the Head — driving the height anchor moves the arms, not the camera)");
            }

            foreach (HandSocket socket in Object.FindObjectsByType<HandSocket>(
                FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                foreach (Transform child in socket.transform)
                {
                    Bounds b = new Bounds();
                    bool has = false;

                    foreach (Renderer r in child.GetComponentsInChildren<Renderer>(true))
                    {
                        if (!has) { b = r.bounds; has = true; } else { b.Encapsulate(r.bounds); }
                    }

                    if (has)
                    {
                        sb.Append("  held on ").Append(socket.name).Append(": ").Append(child.name)
                            .Append(" size=").Append(b.size.ToString("F4"))
                            .Append(" lossy=").AppendLine(child.lossyScale.ToString("F3"));
                    }
                }
            }

            return sb.ToString();
        }
    }
}
