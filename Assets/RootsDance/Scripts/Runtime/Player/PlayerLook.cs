using RootsDance.Data;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Yaw on the player root, pitch on the head transform. The Cinemachine camera follows the head
    /// and must not drive the same axes — one owner per axis, or the view fights itself. Rotation
    /// applies either while the look-hold input is pressed or while a locked gameplay cursor receives
    /// two-finger trackpad scroll. Requiring cursor lock keeps trackpad input from moving the camera
    /// behind dialogue, menus and close-up interfaces. Raw input is exponentially smoothed before use.
    /// </summary>
    [RequireComponent(typeof(PlayerInputReader))]
    public class PlayerLook : MonoBehaviour
    {
        [Tooltip("The transform the Cinemachine first-person camera follows.")]
        [SerializeField] private Transform m_head;

        [SerializeField] private PlayerConfigSO m_config;

        [Tooltip("Lock and hide the cursor while this component is enabled.")]
        [SerializeField] private bool m_lockCursor = true;

        private PlayerInputReader m_input;
        private float m_pitch;
        private Vector2 m_smoothedLook;

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
        }

        private void Update()
        {
            if (m_config == null || m_head == null)
            {
                return;
            }

            Vector2 rawLook;
            if (m_input.IsLookHeld)
            {
                rawLook = m_input.LookInput * m_config.LookSensitivity;
            }
            else if (Cursor.lockState == CursorLockMode.Locked)
            {
                rawLook = m_input.TrackpadLookInput * m_config.TrackpadLookSensitivity;
                if (rawLook == Vector2.zero)
                {
                    return;
                }
            }
            else
            {
                return;
            }

            // A mouse reports movement at its own polling rate, not the render frame rate, so the
            // raw per-frame delta arrives in an uneven stair-step (some frames get none, the next
            // gets a double share). An exponential moving average removes that without adding
            // perceptible input lag; the dt-based factor keeps the smoothing framerate independent.
            float smoothTime = m_config.LookSmoothTime;
            float t = smoothTime <= 0f ? 1f : 1f - Mathf.Exp(-Time.deltaTime / smoothTime);
            m_smoothedLook = Vector2.Lerp(m_smoothedLook, rawLook, t);

            transform.Rotate(0f, m_smoothedLook.x, 0f, Space.Self);

            m_pitch = Mathf.Clamp(m_pitch - m_smoothedLook.y, -m_config.PitchLimitUp, m_config.PitchLimitDown);
            m_head.localRotation = Quaternion.Euler(m_pitch, 0f, 0f);
        }

        private void OnDisable()
        {
            if (m_lockCursor)
            {
                Cursor.lockState = CursorLockMode.None;
                Cursor.visible = true;
            }
        }
    }
}
