using RootsDance.Events;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Events
{
    /// <summary>Raise button on the channel asset itself — see StringEventChannelEditor.</summary>
    [CustomEditor(typeof(VoidEventChannelSO))]
    public class VoidEventChannelEditor : UnityEditor.Editor
    {
        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            EditorGUILayout.Space();

            if (!Application.isPlaying)
            {
                EditorGUILayout.HelpBox("Enter Play Mode for a Raise to reach any listener.", MessageType.Info);
            }

            if (GUILayout.Button("Raise"))
            {
                ((VoidEventChannelSO)target).RaiseEvent();
            }
        }
    }
}
