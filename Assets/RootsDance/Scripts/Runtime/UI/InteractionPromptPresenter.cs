using RootsDance.Events;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// The "press to investigate" hint for whatever is currently in reach.
    /// <para>
    /// Motion: hard reveal, plus a one-off border flash on the frame the target changes. The prompt
    /// must never make the player wait, so it snaps rather than flickering in.
    /// </para>
    /// </summary>
    public class InteractionPromptPresenter : MonoBehaviour
    {
        private const float k_PromptHeight = 100f;
        private const float k_VerticalOffset = -150f;

        [Header("Listens to")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [SerializeField] private VoidEventChannelSO m_conversationStarted;

        [SerializeField] private VoidEventChannelSO m_conversationEnded;

        [Header("Widgets")]
        [SerializeField] private TextMeshProUGUI m_label;

        [Tooltip("Optional frame around the prompt. Falls back to flashing the label itself.")]
        [SerializeField] private Graphic m_border;

        [Header("Motion")]
        [SerializeField] private Color m_flashColor = Color.white;

        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private CanvasGroup m_labelGroup;
        private string m_currentPrompt = string.Empty;
        private bool m_isConversationActive;

        private void Awake()
        {
            if (m_label != null)
            {
                RectTransform labelTransform = m_label.rectTransform;
                labelTransform.anchoredPosition += Vector2.up * k_VerticalOffset;
                labelTransform.sizeDelta = new Vector2(labelTransform.sizeDelta.x, k_PromptHeight);
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

            if (m_conversationStarted != null)
            {
                m_conversationStarted.EventRaised += OnConversationStarted;
            }

            if (m_conversationEnded != null)
            {
                m_conversationEnded.EventRaised += OnConversationEnded;
            }
        }

        private void OnDisable()
        {
            if (m_promptChanged != null)
            {
                m_promptChanged.EventRaised -= OnPromptChanged;
            }

            if (m_conversationStarted != null)
            {
                m_conversationStarted.EventRaised -= OnConversationStarted;
            }

            if (m_conversationEnded != null)
            {
                m_conversationEnded.EventRaised -= OnConversationEnded;
            }

            TerminalMotion.Kill(m_labelGroup);
            TerminalMotion.Kill(FlashTarget());
        }

        private void OnPromptChanged(string text)
        {
            m_currentPrompt = text;

            if (!m_isConversationActive)
            {
                Show(text);
            }
        }

        private void OnConversationStarted()
        {
            m_isConversationActive = true;
            Show(string.Empty);
        }

        private void OnConversationEnded()
        {
            m_isConversationActive = false;
            Show(m_currentPrompt);
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
