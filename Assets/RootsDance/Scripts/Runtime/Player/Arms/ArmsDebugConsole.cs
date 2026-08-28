using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// TEST SCAFFOLDING — fires arms actions from the keyboard so a freshly exported animation can
    /// be judged in Play mode before it has a gameplay trigger.
    /// <para>
    /// Replaces the three one-clip trigger components that came before it. Those each held the
    /// Animator and parked it with <c>speed = 0</c>, so testing one animation stopped the rest;
    /// this one only calls <see cref="IArmsDirector.TryPlay"/>, which means every action is
    /// testable at once and in any order, and an illegal request is refused with a readable reason
    /// instead of playing a broken seam.
    /// </para>
    /// The key for each action lives on its own <see cref="ArmsActionSO"/>, so a new animation
    /// becomes testable by filling in a field — no edit here.
    /// Reads the keyboard device rather than the shared action asset (guideline 04 rule 5): a
    /// throwaway key must not add churn to a file every teammate merges.
    /// </summary>
    public class ArmsDebugConsole : MonoBehaviour
    {
        [Tooltip("The director to drive. Found on this object or a parent when left empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Tooltip("The same set the director uses. Read for each action's debug key.")]
        [SerializeField] private ArmsActionSetSO m_actions;

        private void Awake()
        {
            if (m_director == null)
            {
                m_director = GetComponentInParent<ArmsDirector>();
            }

            if (m_director == null || m_actions == null)
            {
                Log.Error("ArmsDebugConsole needs a director and an action set.", this);
                enabled = false;
            }
        }

        private void Update()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null)
            {
                return;
            }

            for (int i = 0; i < m_actions.Actions.Count; i++)
            {
                ArmsActionSO action = m_actions.Actions[i];

                if (action == null || action.DebugKey == Key.None
                    || !keyboard[action.DebugKey].wasPressedThisFrame)
                {
                    continue;
                }

                if (m_director.TryPlay(action.Id))
                {
                    Log.Info($"ArmsDebugConsole: {action.DebugKey} → '{action.Id}'.", this);
                }

                return;
            }
        }
    }
}
