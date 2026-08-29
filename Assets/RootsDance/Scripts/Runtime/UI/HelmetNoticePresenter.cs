using RootsDance.Events;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// The line the suit writes on its own glass. Two channels, because the suit says two different
    /// kinds of thing: a <b>notice</b> stands until the sender takes it back ("the seal may be
    /// released", and it has to still be there when the player finally reaches for it), and a
    /// <b>warning</b> answers a button press ("contamination above threshold") and then gets out of
    /// the way again. A warning covers the notice for a few seconds; the notice comes back after.
    /// <para>
    /// It lives under the visor root, so the helmet coming off takes it away with the rest of the
    /// chrome — nothing here has to know about the removal.
    /// </para>
    /// <para>
    /// Motion: notices are written the way the rest of the terminal writes; warnings arrive whole,
    /// with a flash. A refusal that types itself out has already stopped being a refusal.
    /// </para>
    /// </summary>
    public class HelmetNoticePresenter : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("Standing suit notice; empty text clears it. Data/Events/HelmetNotice.")]
        [SerializeField] private StringEventChannelSO m_noticeRequested;

        [Tooltip("Refusals and alarms, shown over the notice. Data/Events/HelmetWarning.")]
        [SerializeField] private StringEventChannelSO m_warningRequested;

        [Tooltip("Seconds a warning holds the glass before the standing notice comes back.")]
        [Min(0.5f)]
        [SerializeField] private float m_warningSeconds = 2.5f;

        [Header("Widgets")]
        [SerializeField] private TextMeshProUGUI m_label;

        [Header("Look")]
        [Tooltip("Colour of a standing notice — the same green as the rest of the readouts.")]
        [SerializeField] private Color m_noticeColor = new Color(0.78f, 0.86f, 0.80f, 0.92f);

        [Tooltip("Colour of a warning. It is the only warm thing on the glass, on purpose.")]
        [SerializeField] private Color m_warningColor = new Color(1f, 0.72f, 0.25f, 0.95f);

        [Tooltip("The one-frame jump a warning arrives on, over the warning colour.")]
        [SerializeField] private Color m_flashColor = Color.white;

        [Header("Motion")]
        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private CanvasGroup m_labelGroup;
        private string m_notice = string.Empty;
        private float m_warningRemaining;

        private void Awake()
        {
            if (m_label != null)
            {
                m_labelGroup = TerminalMotion.EnsureCanvasGroup(m_label.gameObject);
            }
        }

        private void OnEnable()
        {
            Hide();

            if (m_noticeRequested != null)
            {
                m_noticeRequested.EventRaised += OnNoticeRequested;
            }

            if (m_warningRequested != null)
            {
                m_warningRequested.EventRaised += OnWarningRequested;
            }
        }

        private void Update()
        {
            if (m_warningRemaining <= 0f)
            {
                return;
            }

            m_warningRemaining -= Time.deltaTime;

            if (m_warningRemaining <= 0f)
            {
                ShowNotice();
            }
        }

        private void OnDisable()
        {
            if (m_noticeRequested != null)
            {
                m_noticeRequested.EventRaised -= OnNoticeRequested;
            }

            if (m_warningRequested != null)
            {
                m_warningRequested.EventRaised -= OnWarningRequested;
            }

            m_warningRemaining = 0f;

            TerminalMotion.Kill(m_labelGroup);
            TerminalMotion.Kill(m_label);
        }

        private void OnNoticeRequested(string text)
        {
            m_notice = text == null ? string.Empty : text;

            // A warning owns the glass while it lasts; the new notice is what it falls back to.
            if (m_warningRemaining <= 0f)
            {
                ShowNotice();
            }
        }

        private void OnWarningRequested(string text)
        {
            if (string.IsNullOrEmpty(text))
            {
                m_warningRemaining = 0f;
                ShowNotice();
                return;
            }

            m_warningRemaining = m_warningSeconds;

            Reveal(text, m_warningColor);
            TerminalMotion.Flash(m_label, m_flashColor, m_motion);
        }

        private void ShowNotice()
        {
            m_warningRemaining = 0f;

            if (string.IsNullOrEmpty(m_notice))
            {
                Hide();
                return;
            }

            Reveal(m_notice, m_noticeColor);
            TerminalMotion.TerminalWrite(m_label, m_notice, m_motion);
        }

        /// <summary>Puts the text up whole, in its colour, with the group snapped to full.</summary>
        private void Reveal(string text, Color color)
        {
            if (m_label == null)
            {
                return;
            }

            TerminalMotion.Kill(m_label);

            m_label.gameObject.SetActive(true);
            m_label.color = color;
            m_label.maxVisibleCharacters = int.MaxValue;
            m_label.text = text;

            TerminalMotion.Snap(m_labelGroup);
        }

        private void Hide()
        {
            if (m_label == null)
            {
                return;
            }

            TerminalMotion.Kill(m_label);
            TerminalMotion.HardCut(m_labelGroup);

            m_label.text = string.Empty;
            m_label.gameObject.SetActive(false);
        }
    }
}
