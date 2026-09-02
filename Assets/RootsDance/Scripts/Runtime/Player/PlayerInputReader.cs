using RootsDance.App;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Controls;

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
        private const string k_FlashlightAction = "Player/Flashlight";
        private const string k_LookBackAction = "Player/LookBack";
        private const string k_FlipAction = "Player/Attack";
        private const string k_PointAction = "UI/Point";
        private const string k_ClickAction = "UI/Click";

        private InputAction m_move;
        private InputAction m_look;
        private InputAction m_sprint;
        private InputAction m_interact;
        private InputAction m_flashlight;
        private InputAction m_lookBack;
        private InputAction m_flip;
        private InputAction m_point;
        private InputAction m_click;
        private bool m_isLastLookInputDelta;

        private bool IsBlocked => GameBootstrap.Instance != null
            && GameBootstrap.Instance.RescueService != null && GameBootstrap.Instance.RescueService.IsModalOpen;

        public Vector2 MoveInput => IsBlocked || m_move == null ? Vector2.zero : m_move.ReadValue<Vector2>();

        public Vector2 LookInput
        {
            get
            {
                bool isDelta;
                return ReadLookInput(out isDelta);
            }
        }

        /// <summary>Current screen-space pointer position, used by close-up physical interfaces.</summary>
        public Vector2 PointerPosition => IsBlocked || m_point == null ? Vector2.zero : m_point.ReadValue<Vector2>();

        public bool IsSprinting => !IsBlocked && m_sprint != null && m_sprint.IsPressed();

        /// <summary>True on the frame the interact button went down. Read from Update only.</summary>
        public bool InteractPressedThisFrame => !IsBlocked && m_interact != null && m_interact.WasPressedThisFrame();

        /// <summary>True on the frame the flashlight button went down. Read from Update only.</summary>
        public bool FlashlightPressedThisFrame => !IsBlocked && m_flashlight != null
            && m_flashlight.WasPressedThisFrame();

        /// <summary>True on the frame the look-back button went down. Read from Update only.</summary>
        public bool LookBackPressedThisFrame => !IsBlocked && m_lookBack != null
            && m_lookBack.WasPressedThisFrame();

        /// <summary>
        /// True on the frame the primary button went down. Read from Update only. Named for what it
        /// does rather than for the action it comes from: the project-wide asset ships an "Attack"
        /// action and this game has nothing to attack, so it is the turn-the-page button.
        /// </summary>
        public bool FlipPressedThisFrame => !IsBlocked && m_flip != null && m_flip.WasPressedThisFrame();

        /// <summary>True on the frame the UI pointer button went down. Read from Update only.</summary>
        public bool ClickPressedThisFrame => !IsBlocked && m_click != null && m_click.WasPressedThisFrame();

        private void Awake()
        {
            m_move = Resolve(k_MoveAction);
            m_look = Resolve(k_LookAction);
            m_sprint = Resolve(k_SprintAction);
            m_interact = Resolve(k_InteractAction);
            m_flashlight = Resolve(k_FlashlightAction);
            m_lookBack = Resolve(k_LookBackAction);
            m_flip = Resolve(k_FlipAction);
            m_point = Resolve(k_PointAction);
            m_click = Resolve(k_ClickAction);
        }

        private void OnEnable()
        {
            // The project-wide asset is shared, so enable what we need and never disable it here —
            // disabling would also silence the UI map for whoever else is listening.
            Enable(m_move);
            Enable(m_look);
            Enable(m_sprint);
            Enable(m_interact);
            Enable(m_flashlight);
            Enable(m_lookBack);
            Enable(m_flip);
            Enable(m_point);
            Enable(m_click);
        }

        /// <summary>
        /// Reads look input and reports whether its active binding produces a per-frame delta.
        /// Delta controls such as pointer movement must not be scaled by frame time, while sticks
        /// and other absolute Vector2 controls represent a rotation rate and must be.
        /// </summary>
        public Vector2 ReadLookInput(out bool isDelta)
        {
            if (IsBlocked || m_look == null)
            {
                isDelta = false;
                return Vector2.zero;
            }

            InputControl activeControl = m_look.activeControl;
            if (activeControl != null)
            {
                m_isLastLookInputDelta = activeControl is DeltaControl;
            }

            isDelta = m_isLastLookInputDelta;
            return m_look.ReadValue<Vector2>();
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
