using RootsDance.Core;
using RootsDance.Events;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Events
{
    /// <summary>Raise button on the channel asset itself — see StringEventChannelEditor.</summary>
    [CustomEditor(typeof(TimeOfDayEventChannelSO))]
    public class TimeOfDayEventChannelEditor : UnityEditor.Editor
    {
        private TimeOfDay m_phase = TimeOfDay.Night;

        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Test", EditorStyles.boldLabel);

            if (!Application.isPlaying)
            {
                EditorGUILayout.HelpBox("Enter Play Mode for a Raise to reach any listener.", MessageType.Info);
            }

            m_phase = (TimeOfDay)EditorGUILayout.EnumPopup("Phase", m_phase);

            if (GUILayout.Button("Raise"))
            {
                ((TimeOfDayEventChannelSO)target).RaiseEvent(m_phase);
            }
        }
    }
}
