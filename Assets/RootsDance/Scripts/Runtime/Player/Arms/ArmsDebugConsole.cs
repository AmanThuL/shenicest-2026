using System;
using System.Collections.Generic;
using System.Text;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// TEST SCAFFOLDING — fires arms actions from the keyboard so a freshly exported animation can
    /// be judged in Play mode before it has a gameplay trigger.
    /// <para>
    /// Replaces the three one-clip trigger components that came before it. Those each held the
    /// Animator and parked it with <c>speed = 0</c>, so testing one animation stopped the rest;
    /// this one only calls <see cref="IArmsDirector.TryPlay"/>, which means every action is
    /// testable at once and in any order, from whatever pose the arms happen to be in.
    /// </para>
    /// The key for each action lives on its own <see cref="ArmsActionSO"/>, so a new animation
    /// becomes testable by filling in a field — no edit here. The same table draws the on-screen
    /// key list, so what the overlay says and what the keys do cannot drift apart.
    /// Reads the keyboard device rather than the shared action asset (guideline 04 rule 5): a
    /// throwaway key must not add churn to a file every teammate merges.
    /// </summary>
    public class ArmsDebugConsole : MonoBehaviour
    {
        [Tooltip("The director to drive. Found on this object or a parent when left empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Tooltip("The same set the director uses. Read for each action's debug key.")]
        [SerializeField] private ArmsActionSetSO m_actions;

        [Header("On-screen key list")]
        [Tooltip("Draw the key list over the game view. Toggled in play with the key below.")]
        [SerializeField] private bool m_showOverlay = true;

        [Tooltip("Shows and hides the list.")]
        [SerializeField] private Key m_toggleKey = Key.F1;

        [Tooltip("Keys owned by other systems, which this component does not fire itself. The "
            + "scan is gameplay, not scaffolding, so it is listed rather than bound here.")]
        [SerializeField] private List<ExtraRow> m_extraRows = new List<ExtraRow>
        {
            new ExtraRow { m_key = "J", m_label = "scan  (needs a sample within range)" },
            new ExtraRow { m_key = "E", m_label = "interact / close the report" },
        };

        [Tooltip("Leave off so the list cannot reach a player build. The editor always shows it.")]
        [SerializeField] private bool m_showInBuilds;

        /// <summary>A key this overlay only advertises — something else actually handles it.</summary>
        [Serializable]
        public struct ExtraRow
        {
            [Tooltip("Shown as the key cap, for example \"J\".")]
            public string m_key;

            [Tooltip("What it does.")]
            public string m_label;
        }

        private GUIStyle m_boxStyle;
        private GUIStyle m_textStyle;
        private string m_cachedList;

        private void Awake()
        {
            if (m_director == null)
            {
                m_director = GetComponentInParent<ArmsDirector>();
            }

            if (m_director == null || m_actions == null)
            {
                Log.Error("ArmsDebugConsole needs a director and an action set.", this);
                enabled = false;
            }
        }

        private void Update()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null)
            {
                return;
            }

            if (m_toggleKey != Key.None && keyboard[m_toggleKey].wasPressedThisFrame)
            {
                m_showOverlay = !m_showOverlay;
            }

            for (int i = 0; i < m_actions.Actions.Count; i++)
            {
                ArmsActionSO action = m_actions.Actions[i];

                if (action == null || action.DebugKey == Key.None
                    || !keyboard[action.DebugKey].wasPressedThisFrame)
                {
                    continue;
                }

                if (m_director.TryPlay(action.Id))
                {
                    Log.Info($"ArmsDebugConsole: {action.DebugKey} → '{action.Id}'.", this);
                }

                return;
            }
        }
    
        /// <summary>
        /// Builds the list once and reuses it. The rows come from the action set, so an animation
        /// that gains or loses a key updates the overlay without anyone editing this text.
        /// </summary>
        private string BuildList()
        {
            var sb = new StringBuilder();
            sb.Append("ARMS TEST KEYS   (").Append(m_toggleKey).AppendLine(" hides)");

            for (int i = 0; i < m_actions.Actions.Count; i++)
            {
                ArmsActionSO action = m_actions.Actions[i];

                if (action == null || action.DebugKey == Key.None)
                {
                    continue;
                }

                sb.Append("  ").Append(action.DebugKey.ToString().PadRight(4))
                    .Append(action.Id).AppendLine();
            }

            if (m_extraRows != null && m_extraRows.Count > 0)
            {
                sb.AppendLine();

                for (int i = 0; i < m_extraRows.Count; i++)
                {
                    sb.Append("  ").Append((m_extraRows[i].m_key ?? string.Empty).PadRight(4))
                        .Append(m_extraRows[i].m_label).AppendLine();
                }
            }

            return sb.ToString().TrimEnd();
        }

        private void OnGUI()
        {
            if (!m_showOverlay || m_actions == null || (!Application.isEditor && !m_showInBuilds))
            {
                return;
            }

            if (m_boxStyle == null)
            {
                // Built here rather than in Awake: GUI styles may only be touched inside OnGUI.
                Texture2D background = new Texture2D(1, 1);
                background.SetPixel(0, 0, new Color(0.04f, 0.05f, 0.07f, 0.82f));
                background.Apply();

                m_boxStyle = new GUIStyle(GUIStyle.none);
                m_boxStyle.normal.background = background;
                m_boxStyle.padding = new RectOffset(12, 14, 10, 10);

                m_textStyle = new GUIStyle(GUIStyle.none);
                m_textStyle.font = Font.CreateDynamicFontFromOSFont("Menlo", 13);
                m_textStyle.fontSize = 13;
                m_textStyle.normal.textColor = new Color(0.85f, 0.89f, 0.94f);
                m_textStyle.richText = false;
            }

            m_cachedList = m_cachedList ?? BuildList();

            Vector2 size = m_textStyle.CalcSize(new GUIContent(m_cachedList));
            var area = new Rect(14f, Screen.height - size.y - 44f, size.x + 26f, size.y + 20f);

            GUI.Box(area, GUIContent.none, m_boxStyle);
            GUI.Label(new Rect(area.x + 13f, area.y + 10f, size.x + 2f, size.y), m_cachedList, m_textStyle);
        }

        /// <summary>Drops the cached text so an Inspector edit shows up straight away.</summary>
        private void OnValidate()
        {
            m_cachedList = null;
        }
    }
}
