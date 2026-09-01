using System.Collections.Generic;
using RootsDance.Interaction;
using UnityEngine;

namespace RootsDance.World
{
    /// <summary>
    /// A second doorway into a terminal's read loop, standing away from the screen itself — the
    /// greenhouse console opens from the floor as well as from the platform, and both entrances
    /// land in the same screen UI.
    /// <para>
    /// The terminal is resolved through <see cref="WallTerminal.Active"/> at interact time, not a
    /// serialized field: this box lives in the gameplay scene and the terminal in an environment
    /// scene, so a serialized reference cannot cross (guideline 03). Nearest active terminal wins,
    /// which is the right answer for as long as a greenhouse has one.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class WallTerminalRemote : MonoBehaviour, IInteractable
    {
        [Tooltip("The hint offered while in reach.")]
        [SerializeField] private string m_promptText = "[E] 查看终端";

        public string PromptText => m_promptText;

        public bool CanInteract => Nearest() != null;

        public void Interact(GameObject interactor)
        {
            WallTerminal terminal = Nearest();

            if (terminal != null)
            {
                terminal.Interact(interactor);
            }
        }

        private WallTerminal Nearest()
        {
            IReadOnlyList<WallTerminal> active = WallTerminal.Active;
            WallTerminal best = null;
            float bestSqr = float.MaxValue;

            for (int i = 0; i < active.Count; i++)
            {
                WallTerminal candidate = active[i];

                if (candidate == null || !candidate.CanInteract)
                {
                    continue;
                }

                float sqr = (candidate.ScreenPosition - transform.position).sqrMagnitude;

                if (sqr < bestSqr)
                {
                    bestSqr = sqr;
                    best = candidate;
                }
            }

            return best;
        }
    }
}
