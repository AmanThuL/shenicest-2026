using RootsDance.Core;
using RootsDance.Events;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Events
{
    /// <summary>Raise button on the channel asset itself — see StringEventChannelEditor.</summary>
    [CustomEditor(typeof(ReportUpdateEventChannelSO))]
    public class ReportUpdateEventChannelEditor : UnityEditor.Editor
    {
        private string m_id = "SO-001";
        private string m_title = "土壤";
        private ReportCategory m_category = ReportCategory.EnvironmentSample;
        private int m_categoryCount = 1;

        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Test", EditorStyles.boldLabel);

            if (!Application.isPlaying)
            {
                EditorGUILayout.HelpBox("Enter Play Mode for a Raise to reach any listener.", MessageType.Info);
            }

            m_id = EditorGUILayout.TextField("Id", m_id);
            m_title = EditorGUILayout.TextField("Title", m_title);
            m_category = (ReportCategory)EditorGUILayout.EnumPopup("Category", m_category);
            m_categoryCount = EditorGUILayout.IntField("Category count", m_categoryCount);

            if (GUILayout.Button("Raise"))
            {
                ReportEntry entry = new ReportEntry(m_category, m_id, m_title, string.Empty);
                ((ReportUpdateEventChannelSO)target).RaiseEvent(new ReportUpdate(entry, m_categoryCount));
            }
        }
    }
}
