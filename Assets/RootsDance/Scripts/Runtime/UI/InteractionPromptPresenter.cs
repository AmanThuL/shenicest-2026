using RootsDance.Events;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// The "press to investigate" hint under the crosshair.
    /// </summary>
    public class InteractionPromptPresenter : MonoBehaviour
    {
        [Header("Listens to")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Widgets")]
        [SerializeField] private TextMeshProUGUI m_label;

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
        }

        private void OnPromptChanged(string text)
        {
            Show(text);
        }

        private void Show(string text)
        {
            m_label.text = text;
            m_label.gameObject.SetActive(!string.IsNullOrEmpty(text));
        }
    }
}
