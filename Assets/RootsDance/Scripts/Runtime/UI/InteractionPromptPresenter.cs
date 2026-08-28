using RootsDance.Events;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// The "press to investigate" hint under the crosshair.
    /// <para>
    /// Motion: hard reveal, plus a one-off border flash on the frame the target changes. The prompt
    /// must never make the player wait, so it snaps rather than flickering in.
    /// </para>
    /// </summary>
    public class InteractionPromptPresenter : MonoBehaviour
    {
        [Header("Listens to")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Widgets")]
        [SerializeField] private TextMeshProUGUI m_label;

        [Tooltip("Optional frame around the prompt. Falls back to flashing the label itself.")]
        [SerializeField] private Graphic m_border;

        [Header("Motion")]
        [SerializeField] private Color m_flashColor = Color.white;

        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private CanvasGroup m_labelGroup;

        private void Awake()
        {
            if (m_label != null)
            {
                m_labelGroup = TerminalMotion.EnsureCanvasGroup(m_label.gameObject);
            }
        }

        private void OnEnable()
        {
            Show(string.Empty);

            if (m_promptChanged != null)
            {
                m_promptChanged.EventRaised += OnPromptChanged;
            }
        }

        private void OnDisable()
        {
            if (m_promptChanged != null)
            {
                m_promptChanged.EventRaised -= OnPromptChanged;
            }

            TerminalMotion.Kill(m_labelGroup);
            TerminalMotion.Kill(FlashTarget());
        }

        private void OnPromptChanged(string text)
        {
            Show(text);
        }

        private void Show(string text)
        {
            bool isVisible = !string.IsNullOrEmpty(text);

            m_label.text = text;
            m_label.gameObject.SetActive(isVisible);

            if (isVisible)
            {
                TerminalMotion.Snap(m_labelGroup);
                TerminalMotion.Flash(FlashTarget(), m_flashColor, m_motion);
            }
            else
            {
                TerminalMotion.Kill(FlashTarget());
                TerminalMotion.HardCut(m_labelGroup);
            }
        }

        private Graphic FlashTarget()
        {
            return m_border != null ? m_border : m_label;
        }
    }
}
