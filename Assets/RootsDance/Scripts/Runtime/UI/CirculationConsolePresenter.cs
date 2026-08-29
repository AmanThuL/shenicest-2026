using System;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.UI.Kit;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// The central circulation terminal: three cycles, one choice, no way back.
    /// <para>
    /// This is the chapter's decision, and it is the one place the story is decided by a machine
    /// rather than by a conversation — so it is a device screen rather than the dialogue box. The
    /// three options carry the same flags they carried as <c>DialogueChoice</c>s
    /// (<see cref="WorldFlags.k_CirculationCore"/> / <c>_ring</c> / <c>_outer</c>), because
    /// everything downstream — the boss waking, the statue blooming, the music — listens to those
    /// and neither knows nor cares what drew the buttons.
    /// </para>
    /// <para>
    /// The choice does not repeat. Options elsewhere in the chapter come back so the player can ask
    /// everything; this one is spent the moment it is made, and the buttons go dead rather than
    /// disappear — a terminal that offered three cycles and now offers none has said something.
    /// </para>
    /// <para>
    /// Raises through <see cref="WorldAccess.Enqueue"/> rather than touching world state directly,
    /// the same as <see cref="RootsDance.World.TriggerVolume"/>: a flag raised inside a UI callback
    /// would otherwise land in the middle of whatever frame the click happened in.
    /// </para>
    /// </summary>
    public class CirculationConsolePresenter : MonoBehaviour
    {
        [Header("Screen")]
        [Tooltip("Switched off until the player opens the terminal.")]
        [SerializeField] private GameObject m_screen;

        [Header("Cycles")]
        [Tooltip("One per cycle, in the order they read down the screen.")]
        [SerializeField] private Button[] m_cycleButtons = Array.Empty<Button>();

        [Tooltip("The flag each cycle raises. Same length and order as the buttons.")]
        [SerializeField] private string[] m_cycleFlags = Array.Empty<string>();

        [Header("Status")]
        [Tooltip("The status readout's value — 'DORMANT' until a cycle is started.")]
        [SerializeField] private ThemedText m_statusValue;

        [SerializeField] private string m_dormantText = "休眠 DORMANT";

        [SerializeField] private string m_engagedText = "启动中 ENGAGING";

        [Tooltip("Seconds the started cycle stays on screen before the terminal closes itself.")]
        [Min(0f)]
        [SerializeField] private float m_closeDelay = 2.5f;

        private bool m_isSpent;
        private float m_closeAt;

        /// <summary>Raised when the terminal closes, whether or not a cycle was chosen.</summary>
        public event Action Closed;

        /// <summary>True once a cycle has been started. The terminal never offers another.</summary>
        public bool IsSpent => m_isSpent;

        private void Awake()
        {
            for (int i = 0; i < m_cycleButtons.Length; i++)
            {
                if (m_cycleButtons[i] == null)
                {
                    continue;
                }

                // Captured per iteration on purpose: one shared index would give every button the
                // last cycle.
                int index = i;
                m_cycleButtons[i].onClick.AddListener(() => OnCycleChosen(index));
            }

            SetStatus(m_dormantText);
            Close();
        }

        /// <summary>Opens the terminal. Harmless once it has been spent — it opens read-only.</summary>
        public void Open()
        {
            if (m_screen != null)
            {
                m_screen.SetActive(true);
            }

            m_closeAt = 0f;
        }

        /// <summary>Shuts the terminal without choosing anything.</summary>
        public void Close()
        {
            if (m_screen != null)
            {
                m_screen.SetActive(false);
            }

            m_closeAt = 0f;
            Closed?.Invoke();
        }

        private void Update()
        {
            if (m_closeAt <= 0f || Time.unscaledTime < m_closeAt)
            {
                return;
            }

            Close();
        }

        private void OnCycleChosen(int index)
        {
            if (m_isSpent || index < 0 || index >= m_cycleFlags.Length)
            {
                return;
            }

            string flag = m_cycleFlags[index];

            if (string.IsNullOrEmpty(flag))
            {
                Log.Warning($"Circulation cycle {index} has no flag; nothing will happen.", this);
                return;
            }

            m_isSpent = true;
            SetStatus(m_engagedText);

            // Dead, not gone. A terminal whose buttons vanished would read as a UI that finished;
            // three cycles greyed out with one of them started reads as a decision that was made.
            for (int i = 0; i < m_cycleButtons.Length; i++)
            {
                if (m_cycleButtons[i] != null)
                {
                    m_cycleButtons[i].interactable = false;
                }
            }

            WorldAccess.Enqueue(new RaiseFlagCommand(flag), this);

            m_closeAt = Time.unscaledTime + m_closeDelay;
        }

        private void SetStatus(string text)
        {
            if (m_statusValue == null)
            {
                return;
            }

            m_statusValue.Text = text;
        }
    }
}
