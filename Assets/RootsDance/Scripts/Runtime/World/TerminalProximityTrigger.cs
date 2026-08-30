using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.World
{
    /// <summary>
    /// Decides when a wall terminal is on offer, and steps the player up to it.
    /// <para>
    /// A copy of <see cref="RootsDance.Archive.ArchiveProximityTrigger"/> with the sheet swapped
    /// for a terminal, deliberately: the rule for "which of the things in reach is being offered"
    /// is shared (<see cref="NearestInRange"/>) and the two triggers differ only in what they are
    /// counting. The alternative — one trigger that knows about every kind of interactable — is the
    /// class every one of them would then have to be edited into.
    /// </para>
    /// <para>
    /// Range is measured to the screen rather than the object's pivot: the housing's pivot is on
    /// the wall behind it, and a hint that turns on a hand's width later than it looks like it
    /// should is a hint the player learns not to trust.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class TerminalProximityTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The read loop this starts. Found on this object or a parent when left empty.")]
        [SerializeField] private TerminalInspectController m_controller;

        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Supplies the interact button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Tuning")]
        [Tooltip("Metres from the screen. Wider than the archive's: this is a thing on a wall that "
            + "the player walks up to, not something they stand over.")]
        [Range(0.5f, 20f)]
        [SerializeField] private float m_range = 3f;

        [Tooltip("Hint shown while a terminal is in reach. {0} is its name.")]
        [SerializeField] private string m_promptFormat = "[E] 使用 {0}";

        private readonly List<Vector3> m_points = new List<Vector3>();
        private WallTerminal m_inReach;
        private string m_lastPrompt = string.Empty;

        /// <summary>The terminal the key would open right now, or null.</summary>
        public WallTerminal InReach => m_inReach;

        private void Awake()
        {
            if (m_controller == null)
            {
                m_controller = GetComponentInParent<TerminalInspectController>();
            }

            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }

            if (m_controller == null)
            {
                Log.Error("TerminalProximityTrigger found no TerminalInspectController.", this);
                enabled = false;
            }
        }

        private void OnDisable()
        {
            m_inReach = null;
            Broadcast(string.Empty);
        }

        private void Update()
        {
            // Nothing is offered while a terminal is already up: the read loop owns the same key
            // until the player steps back.
            m_inReach = m_controller.IsBusy ? null : FindNearestInRange();

            Broadcast(m_inReach == null
                ? string.Empty
                : string.Format(m_promptFormat, m_inReach.DisplayName));

            if (m_inReach == null || m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            m_inReach.Interact(gameObject);
            Broadcast(string.Empty);
        }

        private WallTerminal FindNearestInRange()
        {
            Transform origin = m_player == null ? transform : m_player;
            IReadOnlyList<WallTerminal> active = WallTerminal.Active;

            m_points.Clear();

            for (int i = 0; i < active.Count; i++)
            {
                WallTerminal terminal = active[i];

                // An unavailable terminal keeps its slot and is parked out of reach, so the
                // indices still line up with the list.
                m_points.Add(terminal != null && terminal.CanInteract
                    ? terminal.ScreenPosition
                    : origin.position + Vector3.one * (m_range * 1000f));
            }

            int index = NearestInRange.Index(m_points, origin.position, m_range);

            return index < 0 ? null : active[index];
        }

        private void Broadcast(string prompt)
        {
            if (m_promptChanged == null || prompt == m_lastPrompt)
            {
                return;
            }

            m_lastPrompt = prompt;
            m_promptChanged.RaiseEvent(prompt);
        }
    }
}
