using System;
using RootsDance.Data;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    public sealed class CheckpointRescueRow : MonoBehaviour
    {
        [SerializeField] private Button m_button;
        [SerializeField] private TextMeshProUGUI m_label;

        private RescueCheckpoint m_checkpoint;
        private Action<RescueCheckpoint> m_select;

        public Button NavigationButton => m_button;

        private void OnEnable()
        {
            m_button.onClick.AddListener(OnClicked);
        }

        private void OnDisable()
        {
            m_button.onClick.RemoveListener(OnClicked);
        }

        public void Bind(RescueCheckpoint checkpoint, Action<RescueCheckpoint> select)
        {
            m_checkpoint = checkpoint;
            m_select = select;
            m_label.text = checkpoint.Label;
        }

        public void SetSelected(RescueCheckpoint checkpoint)
        {
            bool selected = m_checkpoint == checkpoint;
            m_button.targetGraphic.color = selected
                ? new Color(0.18f, 0.42f, 0.38f, 1f) : new Color(0.13f, 0.21f, 0.24f, 1f);
            m_label.text = (selected ? "> " : string.Empty) + m_checkpoint.Label;
        }

        private void OnClicked()
        {
            m_select?.Invoke(m_checkpoint);
        }
    }
}
