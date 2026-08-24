using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player
{
    /// <summary>
    /// The only place the project-wide input actions are resolved. Everything else reads these
    /// properties. Button properties use WasPressedThisFrame, so they must only be read from Update.
    /// </summary>
    public class PlayerInputReader : MonoBehaviour
    {
        private const string k_MoveAction = "Player/Move";
        private const string k_LookAction = "Player/Look";
        private const string k_SprintAction = "Player/Sprint";
        private const string k_InteractAction = "Player/Interact";

        private InputAction m_move;
        private InputAction m_look;
        private InputAction m_sprint;
        private InputAction m_interact;

        public Vector2 MoveInput => m_move == null ? Vector2.zero : m_move.ReadValue<Vector2>();

        public Vector2 LookInput => m_look == null ? Vector2.zero : m_look.ReadValue<Vector2>();

        public bool IsSprinting => m_sprint != null && m_sprint.IsPressed();

        /// <summary>True on the frame the interact button went down. Read from Update only.</summary>
        public bool InteractPressedThisFrame => m_interact != null && m_interact.WasPressedThisFrame();

        private void Awake()
        {
            m_move = Resolve(k_MoveAction);
            m_look = Resolve(k_LookAction);
            m_sprint = Resolve(k_SprintAction);
            m_interact = Resolve(k_InteractAction);
        }

        private void OnEnable()
        {
            // The project-wide asset is shared, so enable what we need and never disable it here —
            // disabling would also silence the UI map for whoever else is listening.
            Enable(m_move);
            Enable(m_look);
            Enable(m_sprint);
            Enable(m_interact);
        }

        private InputAction Resolve(string actionPath)
        {
            InputAction action = InputSystem.actions == null
                ? null
                : InputSystem.actions.FindAction(actionPath);

            if (action == null)
            {
                Log.Error($"Input action '{actionPath}' not found in the project-wide actions asset.", this);
            }

            return action;
        }

        private void Enable(InputAction action)
        {
            if (action != null && !action.enabled)
            {
                action.Enable();
            }
        }
    }
}
