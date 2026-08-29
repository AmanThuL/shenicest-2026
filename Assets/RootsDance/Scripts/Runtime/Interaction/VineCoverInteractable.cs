using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Two-state maintenance-entrance cover. Fixed structure stays put while the vine mesh and blocker
    /// switch from covered to revealed after the prerequisite ecological observation.
    /// </summary>
    [DisallowMultipleComponent]
    public class VineCoverInteractable : MonoBehaviour, IInteractable
    {
        [SerializeField] private string m_promptText = "检查 / 移开植物";

        [Tooltip("Fine-veined-vine knowledge required before the cover becomes actionable.")]
        [SerializeField] private string m_requiredFlag = WorldFlags.k_FineVeinedVineScanned;

        [SerializeField] private string m_revealedFlag = WorldFlags.k_MaintenanceEntranceRevealed;

        [Tooltip("Complete vine coverage shown before interaction.")]
        [SerializeField] private GameObject m_coveredVisual;

        [Tooltip("Vines pulled aside after interaction.")]
        [SerializeField] private GameObject m_revealedVisual;

        [Tooltip("Physical blockage disabled when the entrance is revealed.")]
        [SerializeField] private Collider m_blocker;

        private IWorldStateReader m_state;
        private bool m_isRevealed;

        public string PromptText => m_promptText;

        public bool CanInteract
        {
            get
            {
                if (m_isRevealed || m_state == null)
                {
                    return false;
                }

                return string.IsNullOrEmpty(m_requiredFlag) || m_state.HasFlag(m_requiredFlag);
            }
        }

        private void OnDisable()
        {
            if (m_state != null)
            {
                m_state.FlagRaised -= OnFlagRaised;
                m_state = null;
            }
        }

        private void Update()
        {
            if (m_state != null)
            {
                return;
            }

            m_state = WorldAccess.State;

            if (m_state == null)
            {
                return;
            }

            m_state.FlagRaised += OnFlagRaised;
            ApplyState(m_state.HasFlag(m_revealedFlag));
        }

        public void Interact(GameObject interactor)
        {
            if (!CanInteract)
            {
                return;
            }

            ApplyState(true);
            WorldAccess.Enqueue(new RaiseFlagCommand(m_revealedFlag), this);
        }

        private void OnFlagRaised(string flagId)
        {
            if (flagId == m_revealedFlag)
            {
                ApplyState(true);
            }
        }

        private void ApplyState(bool isRevealed)
        {
            m_isRevealed = isRevealed;

            if (m_coveredVisual != null)
            {
                m_coveredVisual.SetActive(!isRevealed);
            }

            if (m_revealedVisual != null)
            {
                m_revealedVisual.SetActive(isRevealed);
            }

            if (m_blocker != null)
            {
                m_blocker.enabled = !isRevealed;
            }
        }
    }
}
