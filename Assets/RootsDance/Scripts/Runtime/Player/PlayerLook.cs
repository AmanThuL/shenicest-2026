using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Yaw on the player root, pitch on the head transform. The Cinemachine camera follows the head
    /// and must not drive the same axes — one owner per axis, or the view fights itself. Pointer
    /// delta directly rotates the view, while stick input represents a rotation rate in degrees per
    /// second. A locked gameplay cursor also accepts two-finger trackpad scroll as direct look input.
    /// Pointer delta can optionally be exponentially smoothed via PlayerConfigSO.
    /// </summary>
    [RequireComponent(typeof(PlayerInputReader))]
    public class PlayerLook : MonoBehaviour
    {
        [Tooltip("The transform the Cinemachine first-person camera follows.")]
        [SerializeField] private Transform m_head;

        [SerializeField] private PlayerConfigSO m_config;

        [Tooltip("The player's persisted mouse sensitivity and Y-axis preference.")]
        [SerializeField] private ControlSettingsSO m_controlSettings;

        [Tooltip("Lock and hide the cursor while this component is enabled.")]
        [SerializeField] private bool m_lockCursor = true;

        [Tooltip("Raised while dialogue choice buttons are on screen, so mouse movement picks an "
            + "option instead of swinging the view. Data/Events/DialogueChoicesShown.")]
        [SerializeField] private VoidEventChannelSO m_choicesShown;

        [Tooltip("Raised once the choice buttons come down. Data/Events/DialogueChoicesHidden.")]
        [SerializeField] private VoidEventChannelSO m_choicesHidden;

        private PlayerInputReader m_input;
        private float m_pitch;
        private Vector2 m_smoothedLook;
        private bool m_isChoiceActive;

        private void Awake()
        {
            m_input = GetComponent<PlayerInputReader>();
        }

        private void OnEnable()
        {
            if (m_lockCursor)
            {
                Cursor.lockState = CursorLockMode.Locked;
                Cursor.visible = false;
            }

            if (m_choicesShown != null)
            {
                m_choicesShown.EventRaised += OnChoicesShown;
            }

            if (m_choicesHidden != null)
            {
                m_choicesHidden.EventRaised += OnChoicesHidden;
            }
        }

        private void Update()
        {
            if (m_config == null || m_head == null || m_isChoiceActive)
            {
                return;
            }

            bool isDelta;
            Vector2 lookInput = m_input.ReadLookInput(out isDelta);
            Vector2 lookRotation = GetLookRotation(lookInput, isDelta);

            if (Cursor.lockState == CursorLockMode.Locked)
            {
                lookRotation += GetTrackpadLookRotation(m_input.TrackpadLookInput);
            }

            transform.Rotate(0f, lookRotation.x, 0f, Space.Self);

            m_pitch = Mathf.Clamp(m_pitch - lookRotation.y, -m_config.PitchLimitUp, m_config.PitchLimitDown);
            m_head.localRotation = Quaternion.Euler(m_pitch, 0f, 0f);
        }

        private void OnDisable()
        {
            if (m_lockCursor)
            {
                Cursor.lockState = CursorLockMode.None;
                Cursor.visible = true;
            }

            if (m_choicesShown != null)
            {
                m_choicesShown.EventRaised -= OnChoicesShown;
            }

            if (m_choicesHidden != null)
            {
                m_choicesHidden.EventRaised -= OnChoicesHidden;
            }

            m_isChoiceActive = false;
        }

        private void OnChoicesShown()
        {
            m_isChoiceActive = true;
        }

        private void OnChoicesHidden()
        {
            m_isChoiceActive = false;
        }

        private Vector2 GetLookRotation(Vector2 lookInput, bool isDelta)
        {
            if (m_controlSettings != null && m_controlSettings.IsYAxisInverted)
            {
                lookInput.y = -lookInput.y;
            }

            if (isDelta)
            {
                float multiplier = m_controlSettings == null
                    ? ControlSettingsSO.k_DefaultMouseSensitivityMultiplier
                    : m_controlSettings.MouseSensitivityMultiplier;
                return SmoothPointerLook(lookInput * (m_config.LookSensitivity * multiplier));
            }

            m_smoothedLook = Vector2.zero;
            return lookInput * (m_config.GamepadLookSpeed * Time.deltaTime);
        }

        private Vector2 GetTrackpadLookRotation(Vector2 trackpadInput)
        {
            if (m_controlSettings != null && m_controlSettings.IsYAxisInverted)
            {
                trackpadInput.y = -trackpadInput.y;
            }

            return trackpadInput * m_config.TrackpadLookSensitivity;
        }

        private Vector2 SmoothPointerLook(Vector2 rawLook)
        {
            // Pointer delta arrives in uneven per-frame steps when its polling cadence differs from
            // the render rate. The optional exponential average is framerate independent.
            float smoothTime = m_config.LookSmoothTime;
            float t = smoothTime <= 0f ? 1f : 1f - Mathf.Exp(-Time.deltaTime / smoothTime);
            m_smoothedLook = Vector2.Lerp(m_smoothedLook, rawLook, t);
            return m_smoothedLook;
        }
    }
}
