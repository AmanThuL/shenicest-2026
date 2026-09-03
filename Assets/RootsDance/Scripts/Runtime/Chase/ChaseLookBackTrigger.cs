using RootsDance.App;
using RootsDance.Events;
using RootsDance.Interaction;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Chase
{
    /// <summary>
    /// The one thing the player can do on purpose while being chased: look back at the boss, then
    /// turn back. Sits on the Player next to the other verbs and keeps its hint up for the whole
    /// run, so the player always knows how to check where she is.
    /// <para>
    /// A button and not the mouse, because the right-button look-around turns the player root:
    /// glancing behind mid-sprint bends the run. The shoulder check is a camera offset
    /// (<see cref="RootsDance.Cameras.PanicViewShake"/>) — the body keeps running exactly where it
    /// was going, and the view comes back on its own.
    /// </para>
    /// <para>
    /// It talks to whichever <see cref="ChaseDirector"/> is running the chase rather than holding a
    /// reference: the director lives in the level scene and the Player is a prefab, and the chase
    /// crosses more than one level.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ChaseLookBackTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("Supplies the look-back button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Tooltip("What the HUD says for as long as the chase is on. Write the real key in it.")]
        [SerializeField] private string m_hint = "[Q] 回头看";

        private void Awake()
        {
            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }
        }

        private void OnDisable()
        {
            InteractionPrompts.Clear(this, m_promptChanged);
        }

        private void Update()
        {
            ChaseDirector director = ChaseDirector.Active;
            bool offered = director != null && director.IsChasing && !WorldAccess.IsInteractionLocked;

            // Through the arbiter, at chase priority: this hint must outlive every proximity
            // offer the run passes, or the player loses the one control that shows the pursuer.
            InteractionPrompts.Set(this, m_promptChanged, offered ? m_hint : string.Empty,
                InteractionPrompts.k_ChaseHintPriority);

            if (!offered || m_input == null || !m_input.LookBackPressedThisFrame)
            {
                return;
            }

            director.LookBackAtMonster();
        }
    }
}
