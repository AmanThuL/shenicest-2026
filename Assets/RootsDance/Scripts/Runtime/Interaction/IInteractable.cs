using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>Anything the player can act on by standing near it with it on screen.</summary>
    public interface IInteractable
    {
        /// <summary>Line shown while this object is in reach, for example "调查".</summary>
        string PromptText { get; }

        /// <summary>False hides the prompt and blocks the interaction (already investigated, locked).</summary>
        bool CanInteract { get; }

        void Interact(GameObject interactor);
    }
}
