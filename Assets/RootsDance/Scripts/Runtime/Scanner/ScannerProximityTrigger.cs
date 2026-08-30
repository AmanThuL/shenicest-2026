using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Interaction;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Decides when scanning is on offer, and starts it.
    /// <para>
    /// Scanning is not always available: the player has to be within <see cref="m_range"/> of a
    /// <see cref="ScannableTarget"/>. While one is in reach and the scanner is idle, the hint goes
    /// out on the prompt channel; pressing the key starts the read loop on that target. Walking
    /// away, or starting the loop, clears the hint again — the channel carries an empty string,
    /// which is how the HUD is told to hide it.
    /// </para>
    /// Distance is measured to the target's aim point, so a large object can put its aim point
    /// where the player actually approaches from.
    /// </summary>
    [DisallowMultipleComponent]
    public class ScannerProximityTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The read loop this starts. Found on this object or a parent when left empty.")]
        [SerializeField] private ScannerInspectController m_controller;

        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Tuning")]
        [Tooltip("Metres. The player must be at least this close for scanning to be offered.")]
        [Range(0.5f, 20f)]
        [SerializeField] private float m_range = 3f;

        [Tooltip("Key that starts the scan.")]
        [SerializeField] private Key m_key = Key.J;

        [Tooltip("Hint shown while a target is in reach. {0} is the target's display name.")]
        [SerializeField] private string m_promptFormat = "[J] 扫描 {0}";

        private readonly List<Vector3> m_points = new List<Vector3>();
        private ScannableTarget m_inReach;
        private string m_lastPrompt = string.Empty;

        /// <summary>The target the key would scan right now, or null.</summary>
        public ScannableTarget InReach => m_inReach;

        public float Range
        {
            get { return m_range; }
            set { m_range = value; }
        }

        private void Awake()
        {
            if (m_controller == null)
            {
                m_controller = GetComponentInParent<ScannerInspectController>();
            }

            if (m_controller == null)
            {
                Log.Error("ScannerProximityTrigger found no ScannerInspectController.", this);
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
            m_inReach = m_controller.IsBusy ? null : FindNearestInRange();

            Broadcast(m_inReach == null
                ? string.Empty
                : string.Format(m_promptFormat, m_inReach.DisplayName));

            if (m_inReach == null)
            {
                return;
            }

            Keyboard keyboard = Keyboard.current;

            if (keyboard == null || !keyboard[m_key].wasPressedThisFrame)
            {
                return;
            }

            if (m_controller.BeginInspect(m_inReach))
            {
                Log.Info($"ScannerProximityTrigger: scanning '{m_inReach.DisplayName}'.", this);
                Broadcast(string.Empty);
            }
        }

        /// <summary>
        /// Nearest scannable within range. Shares <see cref="NearestInRange"/> with picking things
        /// up, so a crowd of candidates resolves identically whichever offer the player is taking.
        /// </summary>
        private ScannableTarget FindNearestInRange()
        {
            Transform origin = m_player == null ? transform : m_player;
            IReadOnlyList<ScannableTarget> active = ScannableTarget.Active;

            m_points.Clear();

            for (int i = 0; i < active.Count; i++)
            {
                ScannableTarget target = active[i];

                // Out of reach by construction rather than filtered out, so the index the shared
                // rule returns still lines up with the live list.
                m_points.Add(target == null || !target.CanScan
                    ? new Vector3(float.MaxValue, float.MaxValue, float.MaxValue)
                    : target.AimPosition);
            }

            int index = NearestInRange.Index(m_points, origin.position, m_range);

            return index < 0 ? null : active[index];
        }

        /// <summary>Only raises the channel when the text actually changes.</summary>
        private void Broadcast(string prompt)
        {
            if (m_promptChanged == null || prompt == m_lastPrompt)
            {
                return;
            }

            m_lastPrompt = prompt;
            m_promptChanged.RaiseEvent(prompt);
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(0.2f, 0.9f, 1f, 0.5f);
            Gizmos.DrawWireSphere(
                (m_player == null ? transform : m_player).position, m_range);
        }
    }
}
