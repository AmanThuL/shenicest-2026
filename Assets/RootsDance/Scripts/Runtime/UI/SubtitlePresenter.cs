using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.UIElements;

namespace RootsDance.UI
{
    /// <summary>
    /// Shows one line of text at a time — radio, inner monologue, device notices — by listening to
    /// any number of string channels. An empty string hides the element.
    /// UXML contract: a Label named "subtitle__text". The art side owns the styling; this name is not
    /// theirs to rename.
    /// </summary>
    [RequireComponent(typeof(UIDocument))]
    public class SubtitlePresenter : MonoBehaviour
    {
        private const string k_TextElementName = "subtitle__text";

        [Header("Listens to")]
        [Tooltip("Every channel whose text should appear here, in no particular order.")]
        [SerializeField] private StringEventChannelSO[] m_channels;

        [Tooltip("Seconds a line stays up when the sender does not clear it. 0 = never auto-hide.")]
        [SerializeField] private float m_autoHideSeconds = 4f;

        private UIDocument m_document;
        private Label m_label;
        private float m_remaining;

        private void Awake()
        {
            m_document = GetComponent<UIDocument>();
        }

        private void OnEnable()
        {
            VisualElement root = m_document.rootVisualElement;

            if (root == null)
            {
                Log.Error("SubtitlePresenter has no root visual element.", this);
                return;
            }

            m_label = root.Q<Label>(k_TextElementName);

            if (m_label == null)
            {
                Log.Error($"UXML is missing a Label named '{k_TextElementName}'.", this);
            }

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
            if (m_label == null)
            {
                return;
            }

            m_label.text = text;
            m_label.style.display = string.IsNullOrEmpty(text) ? DisplayStyle.None : DisplayStyle.Flex;
        }
    }
}
