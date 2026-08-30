using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Investigation;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Bridges a completed environmental scan into the shared report and world-state flag stream.
    /// The scanner owns the interaction; this component only records the authored result once.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(ScannableTarget))]
    public class ScannerWorldStateResult : MonoBehaviour
    {
        [Tooltip("Biological record appended when the target is scanned for the first time.")]
        [SerializeField] private InvestigationTargetSO m_reportTarget;

        private ScannableTarget m_target;
        private bool m_restoredFromWorldState;

        private void Awake()
        {
            m_target = GetComponent<ScannableTarget>();
        }

        private void OnEnable()
        {
            if (m_target != null)
            {
                m_target.Scanned += OnScanned;
            }
        }

        private void OnDisable()
        {
            if (m_target != null)
            {
                m_target.Scanned -= OnScanned;
            }
        }

        private void Update()
        {
            RestoreFromWorldState(WorldAccess.State);
        }

        /// <summary>Restores historical records without re-emitting the scan's completion commands.</summary>
        public void RestoreFromWorldState(IWorldStateReader state)
        {
            if (m_restoredFromWorldState || m_reportTarget == null || m_target == null)
            {
                return;
            }

            if (state == null)
            {
                return;
            }

            if (state.HasReportEntry(m_reportTarget.Id)
                || (!string.IsNullOrEmpty(m_reportTarget.FlagOnRecorded)
                    && state.HasFlag(m_reportTarget.FlagOnRecorded)))
            {
                m_restoredFromWorldState = true;
                m_target.RestoreScannedState();
            }
        }

        private void OnScanned(ScannableTarget target)
        {
            if (m_reportTarget == null)
            {
                return;
            }

            WorldAccess.Enqueue(new AddReportEntryCommand(m_reportTarget.ToReportEntry()), this);

            if (!string.IsNullOrEmpty(m_reportTarget.FlagOnRecorded))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(m_reportTarget.FlagOnRecorded), this);
            }
        }
    }
}
