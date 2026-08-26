using RootsDance.Events;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Shows one line of text at a time — radio, inner monologue, device notices — by listening to
    /// any number of string channels. An empty string hides the element.
    /// </summary>
    public class SubtitlePresenter : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("Every channel whose text should appear here, in no particular order.")]
        [SerializeField] private StringEventChannelSO[] m_channels;

        [Tooltip("Seconds a line stays up when the sender does not clear it. 0 = never auto-hide.")]
        [SerializeField] private float m_autoHideSeconds = 4f;

        [Header("Widgets")]
        [SerializeField] private TextMeshProUGUI m_label;

        private float m_remaining;

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
        }

        private void OnTextRequested(string text)
        {
            Show(text);
            m_remaining = string.IsNullOrEmpty(text) ? 0f : m_autoHideSeconds;
        }

        private void Show(string text)
        {
            m_label.text = text;
            m_label.gameObject.SetActive(!string.IsNullOrEmpty(text));
        }
    }
}
