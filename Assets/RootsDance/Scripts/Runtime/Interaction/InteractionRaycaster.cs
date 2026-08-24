using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// One ray from the centre of the screen per frame. Focus changes drive the interactable's view;
    /// the confirm press is gated on <see cref="ToolUseController.IsBusy"/> so a single press can
    /// never start two interactions.
    /// </summary>
    public class InteractionRaycaster : MonoBehaviour
    {
        [Tooltip("Transform the ray starts from — normally the head the camera follows.")]
        [SerializeField] private Transform m_rayOrigin;

        [SerializeField] private InteractionConfigSO m_config;

        [SerializeField] private PlayerInputReader m_input;

        [SerializeField] private ToolUseController m_toolUse;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the prompt'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        private IInteractable m_focused;
        private IInteractableView m_focusedView;

        private void Update()
        {
            if (m_config == null || m_rayOrigin == null)
            {
                return;
            }

            UpdateFocus();

            if (m_focused == null || m_input == null)
            {
                return;
            }

            if (m_toolUse != null && m_toolUse.IsBusy)
            {
                return;
            }

            if (m_input.InteractPressedThisFrame && m_focused.CanInteract)
            {
                m_focused.Interact(gameObject);
            }
        }

        private void UpdateFocus()
        {
            IInteractable hitInteractable = null;
            IInteractableView hitView = null;

            // Physics.Raycast returns the CLOSEST hit and allocates nothing; RaycastNonAlloc with a
            // one-element buffer would return an arbitrary hit instead.
            bool didHit = Physics.Raycast(
                m_rayOrigin.position,
                m_rayOrigin.forward,
                out RaycastHit hit,
                m_config.Range,
                m_config.InteractableLayers,
                m_config.TriggerInteraction);

            if (didHit)
            {
                Collider hitCollider = hit.collider;
                hitInteractable = hitCollider.GetComponentInParent<IInteractable>();

                if (hitInteractable != null)
                {
                    hitView = hitCollider.GetComponentInParent<IInteractableView>();
                }
            }

            if (ReferenceEquals(hitInteractable, m_focused))
            {
                return;
            }

            if (m_focusedView != null)
            {
                m_focusedView.SetFocused(false);
            }

            m_focused = hitInteractable;
            m_focusedView = hitView;

            if (m_focusedView != null)
            {
                m_focusedView.SetFocused(true);
            }

            if (m_promptChanged != null)
            {
                bool showPrompt = m_focused != null && m_focused.CanInteract;
                m_promptChanged.RaiseEvent(showPrompt ? m_focused.PromptText : string.Empty);
            }
        }
    }
}
