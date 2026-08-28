using System.Text;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Prints the live framing table from the open scene. The prefab holds the authored values and
    /// the scene instance holds the overrides, so reading the prefab file answers the wrong
    /// question — this reads what the game will actually run.
    /// </summary>
    public static class ArmsFramingDump
    {
        public static void Report()
        {
            UnityEditor.SceneManagement.EditorSceneManager.OpenScene(
                "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity",
                UnityEditor.SceneManagement.OpenSceneMode.Single);
            UnityEditor.SceneManagement.EditorSceneManager.OpenScene(
                "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity",
                UnityEditor.SceneManagement.OpenSceneMode.Additive);

            var offset = Object.FindFirstObjectByType<RootsDance.Player.ArmsViewOffset>(
                FindObjectsInactive.Include);

            if (offset == null)
            {
                Debug.LogError("ArmsFramingDump: no ArmsViewOffset in the open scenes.");
                return;
            }

            var so = new SerializedObject(offset);
            var sb = new StringBuilder("FRAMING TABLE (live scene)\n");
            sb.Append("  previewState  : ").AppendLine(so.FindProperty("m_previewState").stringValue);
            sb.Append("  basePosition  : ").AppendLine(so.FindProperty("m_basePosition").vector3Value.ToString("F4"));
            sb.Append("  positionOffset: ").AppendLine(so.FindProperty("m_positionOffset").vector3Value.ToString("F4"));
            sb.Append("  bindBone      : ").AppendLine(so.FindProperty("m_bindBonePosition").vector3Value.ToString("F4"));

            SerializedProperty clips = so.FindProperty("m_clips");

            for (int i = 0; i < clips.arraySize; i++)
            {
                SerializedProperty e = clips.GetArrayElementAtIndex(i);
                sb.Append("    ").Append(e.FindPropertyRelative("m_stateName").stringValue.PadRight(14))
                    .Append("correction=").Append(e.FindPropertyRelative("m_correction").vector3Value.ToString("F4"))
                    .Append("  tweak=").Append(e.FindPropertyRelative("m_tweak").vector3Value.ToString("F4"))
                    .Append("  drivesView=")
                    .AppendLine(e.FindPropertyRelative("m_animatesCameraBone").boolValue.ToString());
            }

            Debug.Log(sb.ToString());
        }
    }
}
