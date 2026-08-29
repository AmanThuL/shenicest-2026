using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>One physical button on the rune keypad, including its hover and feedback pose.</summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Collider))]
    public class RuneKeypadButton : MonoBehaviour
    {
        public enum ButtonKind
        {
            Rune = 0,
            Clear = 1,
            Confirm = 2
        }

        [SerializeField] private ButtonKind m_kind;

        [SerializeField] private RuneSymbol m_symbol;

        [Tooltip("Meshes whose material brightens for error or confirmation feedback.")]
        [SerializeField] private Renderer[] m_feedbackRenderers = new Renderer[0];

        [Tooltip("Emissive material used while this button is flashing.")]
        [SerializeField] private Material m_feedbackMaterial;

        [Tooltip("Local direction the physical button travels into the keypad.")]
        [SerializeField] private Vector3 m_pressAxis = Vector3.right;

        [Min(0f)]
        [SerializeField] private float m_hoverDistance = 0.004f;

        [Min(0f)]
        [SerializeField] private float m_pressDistance = 0.014f;

        private Vector3 m_restPosition;
        private Material[] m_idleMaterials;

        public ButtonKind Kind => m_kind;

        public RuneSymbol Symbol => m_symbol;

        private void Awake()
        {
            m_restPosition = transform.localPosition;
            m_idleMaterials = new Material[m_feedbackRenderers.Length];

            for (int i = 0; i < m_feedbackRenderers.Length; i++)
            {
                Renderer feedbackRenderer = m_feedbackRenderers[i];

                if (feedbackRenderer != null)
                {
                    m_idleMaterials[i] = feedbackRenderer.sharedMaterial;
                }
            }
        }

        private void OnDisable()
        {
            SetHovered(false);
            SetFeedback(false);
        }

        public void SetHovered(bool isHovered)
        {
            float distance = isHovered ? -m_hoverDistance : 0f;
            transform.localPosition = m_restPosition + m_pressAxis.normalized * distance;
        }

        public void SetPressed(bool isPressed)
        {
            float distance = isPressed ? m_pressDistance : 0f;
            transform.localPosition = m_restPosition + m_pressAxis.normalized * distance;
        }

        public void SetFeedback(bool isActive)
        {
            for (int i = 0; i < m_feedbackRenderers.Length; i++)
            {
                Renderer feedbackRenderer = m_feedbackRenderers[i];

                if (feedbackRenderer == null)
                {
                    continue;
                }

                feedbackRenderer.sharedMaterial = isActive && m_feedbackMaterial != null
                    ? m_feedbackMaterial
                    : m_idleMaterials[i];
            }
        }

        /// <summary>Editor-only construction hook used by the idempotent keypad prefab builder.</summary>
        public void Configure(ButtonKind kind, RuneSymbol symbol, Renderer[] feedbackRenderers,
            Material feedbackMaterial)
        {
            m_kind = kind;
            m_symbol = symbol;
            m_feedbackRenderers = feedbackRenderers;
            m_feedbackMaterial = feedbackMaterial;
        }
    }
}
