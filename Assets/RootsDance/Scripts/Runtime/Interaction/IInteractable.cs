using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>Anything the centre-screen ray can act on.</summary>
    public interface IInteractable
    {
        /// <summary>Line shown while this object is focused, for example "调查".</summary>
        string PromptText { get; }

        /// <summary>False hides the prompt and blocks the interaction (already investigated, locked).</summary>
        bool CanInteract { get; }

        void Interact(GameObject interactor);
    }
}
