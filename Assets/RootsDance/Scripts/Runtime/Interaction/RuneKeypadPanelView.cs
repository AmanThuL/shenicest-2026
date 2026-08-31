using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// What the keypad panel shows: the entry indicators, the solved runes, which key the pointer
    /// is over, and the clear/confirm keys' feedback lights. Every setter is instantaneous —
    /// timing (how long a press or an error is held) belongs to the state machine in
    /// <see cref="RuneKeypadInteractable"/>, which drives this view.
    /// <para>
    /// A plain class built by the interactable in <c>Awake</c>: all references stay serialized on
    /// the interactable, so the prefab and its builder are unchanged.
    /// </para>
    /// </summary>
    public sealed class RuneKeypadPanelView
    {
        private readonly GameObject[] m_entryIndicators;
        private readonly GameObject[] m_solvedRunes;
        private readonly RuneKeypadButton m_clearButton;
        private readonly RuneKeypadButton m_confirmButton;
        private readonly LayerMask m_buttonLayers;
        private RuneKeypadButton m_hoveredButton;

        public RuneKeypadPanelView(GameObject[] entryIndicators, GameObject[] solvedRunes,
            RuneKeypadButton clearButton, RuneKeypadButton confirmButton, LayerMask buttonLayers)
        {
            m_entryIndicators = entryIndicators ?? new GameObject[0];
            m_solvedRunes = solvedRunes ?? new GameObject[0];
            m_clearButton = clearButton;
            m_confirmButton = confirmButton;
            m_buttonLayers = buttonLayers;
        }

        /// <summary>The key the pointer was over on the last <see cref="UpdateHover"/>, or null.</summary>
        public RuneKeypadButton Hovered => m_hoveredButton;

        /// <summary>Shows one lit marker per entered symbol.</summary>
        public void SetEntryIndicators(int count)
        {
            for (int i = 0; i < m_entryIndicators.Length; i++)
            {
                if (m_entryIndicators[i] != null)
                {
                    m_entryIndicators[i].SetActive(i < count);
                }
            }
        }

        /// <summary>Reveals or hides the authored screen runes shown once the code is solved.</summary>
        public void SetSolvedRunes(bool isVisible)
        {
            for (int i = 0; i < m_solvedRunes.Length; i++)
            {
                if (m_solvedRunes[i] != null)
                {
                    m_solvedRunes[i].SetActive(isVisible);
                }
            }
        }

        /// <summary>
        /// Raycasts the pointer against the key colliders and moves the hover highlight. Returns
        /// the key under the pointer, or null.
        /// </summary>
        public RuneKeypadButton UpdateHover(Camera camera, Vector2 pointerPosition)
        {
            if (camera == null)
            {
                return m_hoveredButton;
            }

            Ray ray = camera.ScreenPointToRay(pointerPosition);
            RuneKeypadButton button = null;

            if (Physics.Raycast(ray, out RaycastHit hit, 2f, m_buttonLayers,
                QueryTriggerInteraction.Collide))
            {
                button = hit.collider.GetComponentInParent<RuneKeypadButton>();
            }

            if (button == m_hoveredButton)
            {
                return m_hoveredButton;
            }

            ClearHover();
            m_hoveredButton = button;

            if (m_hoveredButton != null)
            {
                m_hoveredButton.SetHovered(true);
            }

            return m_hoveredButton;
        }

        /// <summary>Drops the hover highlight, e.g. before an error hold or the confirm close-up.</summary>
        public void ClearHover()
        {
            if (m_hoveredButton != null)
            {
                m_hoveredButton.SetHovered(false);
                m_hoveredButton = null;
            }
        }

        /// <summary>Lights the clear key's error feedback while a wrong code is being shown.</summary>
        public void SetErrorFeedback(bool isShowing)
        {
            if (m_clearButton == null)
            {
                return;
            }

            m_clearButton.SetPressed(isShowing);
            m_clearButton.SetFeedback(isShowing);
        }

        /// <summary>Lights the confirm key at the moment the poke animation makes contact.</summary>
        public void SetConfirmContact(bool isPressed)
        {
            if (m_confirmButton == null)
            {
                return;
            }

            m_confirmButton.SetPressed(isPressed);
            m_confirmButton.SetFeedback(isPressed);
        }
    }
}
