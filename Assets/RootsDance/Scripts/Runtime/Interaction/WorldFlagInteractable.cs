using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>An authored observation that records one world flag when the player examines it.</summary>
    [DisallowMultipleComponent]
    public class WorldFlagInteractable : MonoBehaviour, IInteractable
    {
        [Tooltip("Prompt shown while the object is focused.")]
        [SerializeField] private string m_promptText = "观察";

        [Tooltip("World-state flag raised by the observation.")]
        [SerializeField] private string m_flagId;

        [Tooltip("Allow the prompt after the flag has already been recorded.")]
        [SerializeField] private bool m_isRepeatable;

        private bool m_hasInteracted;

        public string PromptText => m_promptText;

        public bool CanInteract
        {
            get
            {
                if (m_isRepeatable)
                {
                    return true;
                }

                IWorldStateReader state = WorldAccess.State;
                return !m_hasInteracted && (state == null || !state.HasFlag(m_flagId));
            }
        }

        public void Interact(GameObject interactor)
        {
            if (!CanInteract || string.IsNullOrEmpty(m_flagId))
            {
                return;
            }

            m_hasInteracted = true;
            WorldAccess.Enqueue(new RaiseFlagCommand(m_flagId), this);
        }
    }
}
