using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// Decides when a sheet is on offer to read, and starts reading it.
    /// <para>
    /// Reading is a <b>proximity offer, not an aim</b> — the same shape as
    /// <see cref="Scanner.ScannerProximityTrigger"/> and <see cref="PickupProximityTrigger"/>. Walk
    /// within <see cref="m_range"/> of a sheet and the hint goes out on the prompt channel; press
    /// the key and the nearest one comes up. Among several in reach the nearest wins, through the
    /// shared <see cref="NearestInRange"/> rule, so a crowd of documents resolves exactly the way a
    /// crowd of props or scan targets does.
    /// </para>
    /// <para>
    /// A sheet is still an <see cref="IInteractable"/> and the centre-screen ray still works, but
    /// the ray cannot be the only way in — which is what shipped, and it did not work. A document
    /// lies flat on a desk or the floor; a ray cast level from the eye passes clean over it. The
    /// player could stand directly on top of a sheet, press the key, and nothing happened at all,
    /// because the ray never touched the collider.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ArchiveProximityTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The read loop this starts. Found on this object or a parent when left empty.")]
        [SerializeField] private DocumentInspectController m_controller;

        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Supplies the interact button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Tuning")]
        [Tooltip("Metres. The player must be at least this close for a read to be offered.")]
        [Range(0.5f, 20f)]
        [SerializeField] private float m_range = 2.5f;

        [Tooltip("Hint shown while a sheet is in reach. {0} is the document's title.")]
        [SerializeField] private string m_promptFormat = "[E] 查看 {0}";

        private readonly List<Vector3> m_points = new List<Vector3>();
        private ArchiveDocumentPickup m_inReach;
        private string m_lastPrompt = string.Empty;

        /// <summary>The sheet the key would raise right now, or null.</summary>
        public ArchiveDocumentPickup InReach => m_inReach;

        private void Awake()
        {
            if (m_controller == null)
            {
                m_controller = GetComponentInParent<DocumentInspectController>();
            }

            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }

            if (m_controller == null)
            {
                Log.Error("ArchiveProximityTrigger found no DocumentInspectController.", this);
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
            // Nothing is offered while a sheet is already up: the same key puts that one down, and
            // the read loop owns it until then.
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

        /// <summary>Nearest readable sheet within range, or null.</summary>
        private ArchiveDocumentPickup FindNearestInRange()
        {
            Transform origin = m_player == null ? transform : m_player;
            IReadOnlyList<ArchiveDocumentPickup> active = ArchiveDocumentPickup.Active;

            m_points.Clear();

            for (int i = 0; i < active.Count; i++)
            {
                ArchiveDocumentPickup sheet = active[i];

                // A sheet that cannot be read right now is still in the list, so its point goes
                // somewhere the rule will never choose rather than being skipped — the indices
                // have to line up with the list.
                m_points.Add(sheet != null && sheet.CanInteract
                    ? sheet.transform.position
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
