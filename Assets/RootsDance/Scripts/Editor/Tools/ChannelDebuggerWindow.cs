using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Events;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Raises event channels by hand so UI can be built and tested without walking the level.
    /// Editor-only: it never ships, and it touches nothing but the channel assets' RaiseEvent.
    /// Window > RootsDance > Channel Debugger.
    /// </summary>
    public class ChannelDebuggerWindow : EditorWindow
    {
        private readonly List<StringEventChannelSO> m_stringChannels = new List<StringEventChannelSO>();
        private readonly List<ReportUpdateEventChannelSO> m_reportChannels = new List<ReportUpdateEventChannelSO>();
        private readonly List<VoidEventChannelSO> m_voidChannels = new List<VoidEventChannelSO>();
        private readonly Dictionary<StringEventChannelSO, string> m_drafts =
            new Dictionary<StringEventChannelSO, string>();

        private Vector2 m_scroll;
        private string m_reportId = "SO-001";
        private string m_reportTitle = "土壤";
        private ReportCategory m_reportCategory = ReportCategory.EnvironmentSample;
        private int m_reportCount = 1;

        [MenuItem("Window/RootsDance/Channel Debugger")]
        private static void Open()
        {
            ChannelDebuggerWindow window = GetWindow<ChannelDebuggerWindow>();
            window.titleContent = new GUIContent("Channels");
            window.Show();
        }

        private void OnEnable()
        {
            Refresh();
        }

        private void OnGUI()
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                EditorGUILayout.LabelField(
                    Application.isPlaying ? "Play mode — listeners are live." : "Edit mode — nothing is listening yet.",
                    EditorStyles.miniLabel);

                if (GUILayout.Button("Refresh", GUILayout.Width(70f)))
                {
                    Refresh();
                }
            }

            m_scroll = EditorGUILayout.BeginScrollView(m_scroll);

            DrawStringChannels();
            DrawReportChannels();
            DrawVoidChannels();

            EditorGUILayout.EndScrollView();
        }

        private void DrawStringChannels()
        {
            if (m_stringChannels.Count == 0)
            {
                return;
            }

            EditorGUILayout.LabelField("String channels", EditorStyles.boldLabel);

            for (int i = 0; i < m_stringChannels.Count; i++)
            {
                StringEventChannelSO channel = m_stringChannels[i];

                if (channel == null)
                {
                    continue;
                }

                EditorGUILayout.LabelField(channel.name, EditorStyles.miniBoldLabel);

                using (new EditorGUILayout.HorizontalScope())
                {
                    string draft = m_drafts.TryGetValue(channel, out string existing) ? existing : string.Empty;
                    m_drafts[channel] = EditorGUILayout.TextField(draft);

                    if (GUILayout.Button("Raise", GUILayout.Width(55f)))
                    {
                        channel.RaiseEvent(m_drafts[channel]);
                    }

                    if (GUILayout.Button("Clear", GUILayout.Width(55f)))
                    {
                        channel.RaiseEvent(string.Empty);
                    }
                }
            }

            EditorGUILayout.Space();
        }

        private void DrawReportChannels()
        {
            if (m_reportChannels.Count == 0)
            {
                return;
            }

            EditorGUILayout.LabelField("Report update channels", EditorStyles.boldLabel);

            m_reportId = EditorGUILayout.TextField("Id", m_reportId);
            m_reportTitle = EditorGUILayout.TextField("Title", m_reportTitle);
            m_reportCategory = (ReportCategory)EditorGUILayout.EnumPopup("Category", m_reportCategory);
            m_reportCount = EditorGUILayout.IntField("Category count", m_reportCount);

            for (int i = 0; i < m_reportChannels.Count; i++)
            {
                ReportUpdateEventChannelSO channel = m_reportChannels[i];

                if (channel == null)
                {
                    continue;
                }

                if (GUILayout.Button($"Raise {channel.name}"))
                {
                    ReportEntry entry = new ReportEntry(m_reportCategory, m_reportId, m_reportTitle, string.Empty);
                    channel.RaiseEvent(new ReportUpdate(entry, m_reportCount));
                }
            }

            EditorGUILayout.Space();
        }

        private void DrawVoidChannels()
        {
            if (m_voidChannels.Count == 0)
            {
                return;
            }

            EditorGUILayout.LabelField("Void channels", EditorStyles.boldLabel);

            for (int i = 0; i < m_voidChannels.Count; i++)
            {
                VoidEventChannelSO channel = m_voidChannels[i];

                if (channel == null)
                {
                    continue;
                }

                if (GUILayout.Button($"Raise {channel.name}"))
                {
                    channel.RaiseEvent();
                }
            }
        }

        private void Refresh()
        {
            m_drafts.Clear();
            Collect(m_stringChannels);
            Collect(m_reportChannels);
            Collect(m_voidChannels);
        }

        private static void Collect<T>(List<T> target) where T : ScriptableObject
        {
            target.Clear();
            string[] guids = AssetDatabase.FindAssets($"t:{typeof(T).Name}");

            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                T asset = AssetDatabase.LoadAssetAtPath<T>(path);

                if (asset != null)
                {
                    target.Add(asset);
                }
            }
        }
    }
}
