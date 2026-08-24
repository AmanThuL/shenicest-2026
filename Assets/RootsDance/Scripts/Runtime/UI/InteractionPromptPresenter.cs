using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.UIElements;

namespace RootsDance.UI
{
    /// <summary>
    /// The "press to investigate" hint under the crosshair.
    /// UXML contract: a Label named "prompt__label".
    /// </summary>
    [RequireComponent(typeof(UIDocument))]
    public class InteractionPromptPresenter : MonoBehaviour
    {
        private const string k_LabelName = "prompt__label";

        [Header("Listens to")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        private UIDocument m_document;
        private Label m_label;

        private void Awake()
        {
            m_document = GetComponent<UIDocument>();
        }

        private void OnEnable()
        {
            VisualElement root = m_document.rootVisualElement;

            if (root == null)
            {
                Log.Error("InteractionPromptPresenter has no root visual element.", this);
                return;
            }

            m_label = root.Q<Label>(k_LabelName);

            if (m_label == null)
            {
                Log.Error($"UXML is missing a Label named '{k_LabelName}'.", this);
            }

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
        }

        private void OnPromptChanged(string text)
        {
            Show(text);
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
