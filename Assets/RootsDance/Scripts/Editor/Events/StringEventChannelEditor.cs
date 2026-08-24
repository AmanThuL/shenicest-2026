using RootsDance.Events;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Events
{
    /// <summary>
    /// Raise button on the channel asset itself, following the pattern from "Use ScriptableObjects
    /// as Event Channels in Your Code" (docs/reference/design-patterns). Select the .asset in
    /// Data/Events/ and press Play — no separate window, no level, no player required.
    /// </summary>
    [CustomEditor(typeof(StringEventChannelSO))]
    public class StringEventChannelEditor : UnityEditor.Editor
    {
        private string m_testValue = "";

        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Test", EditorStyles.boldLabel);

            if (!Application.isPlaying)
            {
                EditorGUILayout.HelpBox("Enter Play Mode for a Raise to reach any listener.", MessageType.Info);
            }

            m_testValue = EditorGUILayout.TextField("Value", m_testValue);

            using (new EditorGUILayout.HorizontalScope())
            {
                if (GUILayout.Button("Raise"))
                {
                    ((StringEventChannelSO)target).RaiseEvent(m_testValue);
                }

                if (GUILayout.Button("Clear"))
                {
                    ((StringEventChannelSO)target).RaiseEvent(string.Empty);
                }
            }
        }
    }
}
