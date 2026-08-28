using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Data;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// RootsDance > Dev Play > Window. Lists every <see cref="DevCheckpointSO"/>, starts Play from
    /// one click, jumps between checkpoints while playing, and shows the live world flags.
    /// </summary>
    public class DevPlayWindow : EditorWindow
    {
        private const string k_MenuPath = "RootsDance/Dev Play/Window";
        private const string k_CheckpointFilter = "t:DevCheckpointSO";

        private readonly List<DevCheckpointSO> m_checkpoints = new List<DevCheckpointSO>();
        private readonly List<LevelSO> m_levels = new List<LevelSO>();
        private Vector2 m_scroll;
        private bool m_showWorldState = true;

        [MenuItem(k_MenuPath)]
        public static void Open()
        {
            GetWindow<DevPlayWindow>("Dev Play");
        }

        private void OnEnable()
        {
            RefreshCheckpoints();
        }

        private void OnFocus()
        {
            RefreshCheckpoints();
        }

        private void OnProjectChange()
        {
            RefreshCheckpoints();
        }

        private void OnInspectorUpdate()
        {
            if (EditorApplication.isPlaying)
            {
                Repaint();
            }
        }

        private void OnGUI()
        {
            m_scroll = EditorGUILayout.BeginScrollView(m_scroll);
            DrawLevels();
            EditorGUILayout.Space();
            DrawCheckpoints();

            if (EditorApplication.isPlaying)
            {
                EditorGUILayout.Space();
                DrawWorldState();
            }

            EditorGUILayout.EndScrollView();
        }

        private void RefreshCheckpoints()
        {
            m_checkpoints.Clear();
            m_levels.Clear();
            string[] guids = AssetDatabase.FindAssets(k_CheckpointFilter);

            for (int i = 0; i < guids.Length; i++)
            {
                DevCheckpointSO checkpoint =
                    AssetDatabase.LoadAssetAtPath<DevCheckpointSO>(AssetDatabase.GUIDToAssetPath(guids[i]));

                if (checkpoint == null)
                {
                    continue;
                }

                m_checkpoints.Add(checkpoint);

                if (checkpoint.Level != null && !m_levels.Contains(checkpoint.Level))
                {
                    m_levels.Add(checkpoint.Level);
                }
            }

            m_checkpoints.Sort((a, b) => string.CompareOrdinal(a.Label, b.Label));
        }

        private void DrawLevels()
        {
            EditorGUILayout.LabelField("Level", EditorStyles.boldLabel);

            using (new EditorGUI.DisabledScope(EditorApplication.isPlayingOrWillChangePlaymode))
            {
                for (int i = 0; i < m_levels.Count; i++)
                {
                    LevelSO level = m_levels[i];
                    bool loaded = DevPlaySession.AreLevelScenesLoaded(level);

                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(level.name + (loaded ? "  (scenes open)" : ""));

                    if (!loaded && GUILayout.Button("Open scenes", GUILayout.Width(110f)))
                    {
                        DevPlaySession.OpenLevelScenes(level);
                    }

                    if (loaded && GUILayout.Button("Play as placed", GUILayout.Width(110f)))
                    {
                        EditorApplication.EnterPlaymode();
                    }

                    EditorGUILayout.EndHorizontal();
                }
            }

            if (EditorApplication.isPlaying)
            {
                EditorGUILayout.LabelField("Playing: " + DescribeLoadedScenes(), EditorStyles.miniLabel);
            }
        }

        private void DrawCheckpoints()
        {
            EditorGUILayout.LabelField("Checkpoints", EditorStyles.boldLabel);

            if (m_checkpoints.Count == 0)
            {
                EditorGUILayout.HelpBox("No DevCheckpointSO assets found.", MessageType.Info);

                if (GUILayout.Button("Create default checkpoints"))
                {
                    DevCheckpointDefaults.CreateMissing();
                    RefreshCheckpoints();
                }

                return;
            }

            bool playing = EditorApplication.isPlaying;
            string action = playing ? "Go here" : "Play here";

            using (new EditorGUI.DisabledScope(EditorApplication.isPlayingOrWillChangePlaymode && !playing))
            {
                for (int i = 0; i < m_checkpoints.Count; i++)
                {
                    DevCheckpointSO checkpoint = m_checkpoints[i];

                    if (checkpoint == null)
                    {
                        // Unloaded by a scene switch; the next focus/project change refreshes the list.
                        continue;
                    }

                    EditorGUILayout.BeginHorizontal(EditorStyles.helpBox);

                    if (GUILayout.Button(checkpoint.Label, EditorStyles.linkLabel, GUILayout.Width(170f)))
                    {
                        EditorGUIUtility.PingObject(checkpoint);
                    }

                    EditorGUILayout.LabelField(DescribeCheckpoint(checkpoint), EditorStyles.miniLabel);

                    if (GUILayout.Button(action, GUILayout.Width(80f)))
                    {
                        DevPlaySession.PlayFrom(checkpoint);
                    }

                    EditorGUILayout.EndHorizontal();
                }
            }
        }

        private void DrawWorldState()
        {
            m_showWorldState = EditorGUILayout.Foldout(m_showWorldState, "World state (live)", true);

            if (!m_showWorldState)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                EditorGUILayout.HelpBox("GameBootstrap has not arrived yet.", MessageType.Info);
                return;
            }

            DrawTimeOfDay(state.TimeOfDay);
            EditorGUILayout.Space();

            IReadOnlyList<string> flags = WorldFlagCatalog.All;

            for (int i = 0; i < flags.Count; i++)
            {
                bool raised = state.HasFlag(flags[i]);

                EditorGUILayout.BeginHorizontal();

                using (new EditorGUI.DisabledScope(true))
                {
                    EditorGUILayout.ToggleLeft(flags[i], raised);
                }

                using (new EditorGUI.DisabledScope(raised))
                {
                    if (GUILayout.Button("Raise", GUILayout.Width(60f)))
                    {
                        WorldAccess.Enqueue(new RaiseFlagCommand(flags[i]), null);
                    }
                }

                EditorGUILayout.EndHorizontal();
            }

            EditorGUILayout.LabelField("Report entries: " + state.Report.Count);
        }

        /// <summary>
        /// Time of day is not monotonic, so unlike the flags both directions get a button; the one that
        /// is already current is disabled because the command would be a no-op.
        /// </summary>
        private static void DrawTimeOfDay(TimeOfDay phase)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("Time of day: " + phase);

            using (new EditorGUI.DisabledScope(phase == TimeOfDay.Day))
            {
                if (GUILayout.Button("Day", GUILayout.Width(60f)))
                {
                    WorldAccess.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Day), null);
                }
            }

            using (new EditorGUI.DisabledScope(phase == TimeOfDay.Night))
            {
                if (GUILayout.Button("Night", GUILayout.Width(60f)))
                {
                    WorldAccess.Enqueue(new SetTimeOfDayCommand(TimeOfDay.Night), null);
                }
            }

            EditorGUILayout.EndHorizontal();
        }

        private static string DescribeCheckpoint(DevCheckpointSO checkpoint)
        {
            string where = string.IsNullOrEmpty(checkpoint.AnchorName)
                ? checkpoint.Position.ToString("F1")
                : checkpoint.AnchorName;
            string description = where + "  ·  " + checkpoint.Flags.Count + " flags, "
                + checkpoint.RecordedTargets.Count + " records";

            if (checkpoint.TimeOfDay != CheckpointTimeOfDay.LevelDefault)
            {
                description += "  ·  " + checkpoint.TimeOfDay;
            }

            return description;
        }

        private static string DescribeLoadedScenes()
        {
            List<string> names = new List<string>();

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isLoaded)
                {
                    names.Add(scene.name);
                }
            }

            return string.Join(", ", names);
        }
    }
}
