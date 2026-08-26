using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player
{
    /// <summary>
    /// TEST SCAFFOLDING — delete once node 00-05 drives removal for real (flag + Interact through
    /// <see cref="HelmetController"/>). Fires <see cref="IHelmetView.PlayRemove"/> straight from a
    /// key so the removal performance can be judged on its own, without the contamination flag.
    /// Deliberately reads the keyboard device instead of the project-wide action asset
    /// (guideline 04 / rule 5): a throwaway key must not add churn to the shared
    /// Input/RootsDance.inputactions that every teammate merges.
    /// </summary>
    public class HelmetDebugTrigger : MonoBehaviour
    {
        [Tooltip("Component implementing IHelmetView.")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        [SerializeField] private Key m_key = Key.H;

        private IHelmetView m_view;

        private void Awake()
        {
            m_view = m_viewBehaviour as IHelmetView;

            if (m_view == null)
            {
                Log.Error("HelmetDebugTrigger: assigned component does not implement IHelmetView.", this);
            }
        }

        private void Update()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null || m_view == null)
            {
                return;
            }

            if (keyboard[m_key].wasPressedThisFrame)
            {
                Log.Info($"HelmetDebugTrigger: {m_key} pressed, playing helmet removal.", this);
                m_view.PlayRemove();
            }
        }
    }
}
