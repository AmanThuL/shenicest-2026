using System;
using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Marks an object the scanner can read, and carries what reading it produces.
    /// <para>
    /// Targets register themselves in a static list rather than being found by a per-frame search:
    /// <see cref="ScannerProximityTrigger"/> tests the player against every target each frame, and
    /// a <c>FindObjectsByType</c> there would allocate every frame (guideline 05).
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ScannableTarget : MonoBehaviour
    {
        private static readonly List<ScannableTarget> s_active = new List<ScannableTarget>();

        [Tooltip("Name shown in the hint while this is the nearest scannable object.")]
        [SerializeField] private string m_displayName = "未知样本";

        [Tooltip("Where the beam is aimed. Empty = this object's own origin.")]
        [SerializeField] private Transform m_aimPoint;

        [Tooltip("Report section this scan reveals. Optional — the flow runs without one.")]
        [SerializeField] private ScannerReportSectionSO m_revealedSection;

        [Tooltip("Off means the object can be scanned once and then stops offering the hint.")]
        [SerializeField] private bool m_repeatable = true;

        private bool m_hasBeenScanned;

        /// <summary>Every enabled target, in registration order. Do not hold across frames.</summary>
        public static IReadOnlyList<ScannableTarget> Active => s_active;

        public string DisplayName => m_displayName;

        public ScannerReportSectionSO RevealedSection => m_revealedSection;

        public bool HasBeenScanned => m_hasBeenScanned;

        /// <summary>False once a one-shot target has been read.</summary>
        public bool CanScan => m_repeatable || !m_hasBeenScanned;

        /// <summary>Raised once, when this target completes its first successful scan.</summary>
        public event Action<ScannableTarget> Scanned;

        /// <summary>World point the beam is pointed at.</summary>
        public Vector3 AimPosition => m_aimPoint == null ? transform.position : m_aimPoint.position;

        public void MarkScanned()
        {
            if (m_hasBeenScanned)
            {
                return;
            }

            m_hasBeenScanned = true;
            Scanned?.Invoke(this);
        }

        /// <summary>
        /// Restores a previously recorded one-shot target without replaying scan-result side effects.
        /// Checkpoint hydration uses this after WorldState becomes available.
        /// </summary>
        public void RestoreScannedState()
        {
            m_hasBeenScanned = true;
        }

        private void OnEnable()
        {
            if (!s_active.Contains(this))
            {
                s_active.Add(this);
            }
        }

        private void OnDisable()
        {
            s_active.Remove(this);
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(1f, 0.2f, 0.2f, 0.9f);
            Gizmos.DrawWireSphere(AimPosition, 0.15f);
        }
    }
}
