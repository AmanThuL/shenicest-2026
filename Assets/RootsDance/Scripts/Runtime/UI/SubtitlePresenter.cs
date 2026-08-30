using RootsDance.Core;
using RootsDance.Events;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Shows one line of text at a time — radio, inner monologue, device notices — by listening to
    /// any number of string channels. An empty string hides the element.
    /// <para>
    /// Motion: the line is written to the screen in chunks, the way a machine writes, rather than
    /// appearing whole or crawling out one character at a time.
    /// </para>
    /// </summary>
    public class SubtitlePresenter : MonoBehaviour, IRescueResetParticipant
    {
        [Header("Listens to")]
        [Tooltip("Every channel whose text should appear here, in no particular order.")]
        [SerializeField] private StringEventChannelSO[] m_channels;

        [Tooltip("Seconds a line stays up when the sender does not clear it. 0 = never auto-hide.")]
        [SerializeField] private float m_autoHideSeconds = 4f;

        [Header("Widgets")]
        [SerializeField] private TextMeshProUGUI m_label;

        [Header("Motion")]
        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private CanvasGroup m_labelGroup;
        private float m_remaining;

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

            for (int i = 0; i < m_channels.Length; i++)
            {
                if (m_channels[i] != null)
                {
                    m_channels[i].EventRaised += OnTextRequested;
                }
            }
        }

        private void Update()
        {
            if (m_remaining <= 0f)
            {
                return;
            }

            m_remaining -= Time.deltaTime;

            if (m_remaining <= 0f)
            {
                Show(string.Empty);
            }
        }

        private void OnDisable()
        {
            for (int i = 0; i < m_channels.Length; i++)
            {
                if (m_channels[i] != null)
                {
                    m_channels[i].EventRaised -= OnTextRequested;
                }
            }

            TerminalMotion.Kill(m_labelGroup);
            TerminalMotion.Kill(m_label);
        }

        private void OnTextRequested(string text)
        {
            Show(text);
            m_remaining = string.IsNullOrEmpty(text) ? 0f : m_autoHideSeconds;
        }

        /// <summary>Do not carry the previous scene's subtitle or typing tween into a rescue.</summary>
        public void ResetForRescue()
        {
            m_remaining = 0f;

            if (m_label != null)
            {
                Show(string.Empty);
            }
        }

        private void Show(string text)
        {
            bool isVisible = !string.IsNullOrEmpty(text);

            if (!isVisible)
            {
                TerminalMotion.Kill(m_label);
                TerminalMotion.HardCut(m_labelGroup);
                m_label.text = text;
                m_label.gameObject.SetActive(false);
                return;
            }

            m_label.gameObject.SetActive(true);
            TerminalMotion.Snap(m_labelGroup);
            TerminalMotion.TerminalWrite(m_label, text, m_motion);
        }
    }
}
