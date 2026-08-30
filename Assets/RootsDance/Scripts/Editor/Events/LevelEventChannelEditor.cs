using RootsDance.Events;
using UnityEditor;

namespace RootsDance.Editor.Events
{
    /// <summary>
    /// No Raise button on purpose. GameBootstrap.OnLoadLevelRequested hands this straight to
    /// SceneLoader, which does a real, non-cancellable additive scene load — nothing here can
    /// undo that once it starts, and no current UI presenter subscribes to this channel, so
    /// there is nothing to test-drive from the Inspector. To exercise level loading, play the
    /// level; do not fake this event.
    /// </summary>
    [CustomEditor(typeof(LevelEventChannelSO))]
    public class LevelEventChannelEditor : UnityEditor.Editor
    {
        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            EditorGUILayout.Space();
            EditorGUILayout.HelpBox(
                "No Raise button here: this loads real scenes with no undo. To test level "
                    + "loading, play the level instead of faking this event.",
                MessageType.Warning);
        }
    }
}
