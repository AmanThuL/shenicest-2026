using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// The uGUI half of a conversation: one line at a time, and a column of buttons when there is
    /// something to say back. One screen, one prefab, widget references serialized — the shape
    /// guideline 09 asks every screen to have.
    /// <para>
    /// The choice buttons are authored in the prefab and switched on as needed rather than spawned
    /// per conversation. The script never offers more than three options, and a fixed set of
    /// buttons is something a UI artist can lay out and style once.
    /// </para>
    /// </summary>
    public class DialoguePresenter : MonoBehaviour, IDialogueView
    {
        [Header("Line")]
        [Tooltip("Shown and hidden as a whole. Its alpha is what 'no conversation' looks like.")]
        [SerializeField] private CanvasGroup m_root;

        [SerializeField] private TextMeshProUGUI m_speakerLabel;

        [SerializeField] private TextMeshProUGUI m_chineseLabel;

        [Tooltip("The English subtitle, set smaller under the line.")]
        [SerializeField] private TextMeshProUGUI m_englishLabel;

        [Header("Speaker names")]
        [Tooltip("What each speaker is called on screen. Kept as data so the writer owns the names.")]
        [SerializeField] private string m_protagonistName = "我";

        [SerializeField] private string m_flowerName = "小花";

        [SerializeField] private string m_deviceName = "设备";

        [Header("Speaker colours")]
        [SerializeField] private Color m_protagonistColor = new Color(0.86f, 0.88f, 0.84f, 1f);

        [SerializeField] private Color m_flowerColor = new Color(0.62f, 0.90f, 0.55f, 1f);

        [SerializeField] private Color m_deviceColor = new Color(0.55f, 0.78f, 0.82f, 1f);

        [Header("Choices")]
        [Tooltip("Authored buttons, in the order they are offered. More options than buttons are "
            + "dropped, so keep at least as many as the longest set in the script.")]
        [SerializeField] private Button[] m_choiceButtons = new Button[0];

        [Tooltip("The Chinese label inside each button, index-matched to the buttons above.")]
        [SerializeField] private TextMeshProUGUI[] m_choiceChineseLabels = new TextMeshProUGUI[0];

        [Tooltip("The English label inside each button, index-matched. May be left empty.")]
        [SerializeField] private TextMeshProUGUI[] m_choiceEnglishLabels = new TextMeshProUGUI[0];

        private CursorLockMode m_cursorLockBeforeChoices;
        private bool m_cursorVisibleBeforeChoices;
        private bool m_hasChoiceCursor;

        /// <inheritdoc />
        public event Action<int> ChoiceSelected;

        private void Awake()
        {
            for (int i = 0; i < m_choiceButtons.Length; i++)
            {
                if (m_choiceButtons[i] == null)
                {
                    continue;
                }

                // Captured once, at wire-up: a listener added per conversation would stack up.
                int index = i;
                m_choiceButtons[i].onClick.AddListener(() => OnButtonClicked(index));
            }

            Hide();
        }

        private void OnDestroy()
        {
            RestoreChoiceCursor();

            for (int i = 0; i < m_choiceButtons.Length; i++)
            {
                if (m_choiceButtons[i] != null)
                {
                    m_choiceButtons[i].onClick.RemoveAllListeners();
                }
            }
        }

        /// <inheritdoc />
        public void ShowLine(DialogueSpeaker speaker, string chinese, string english)
        {
            SetRootVisible(true);
            HideChoiceButtons();

            if (m_speakerLabel != null)
            {
                m_speakerLabel.text = NameOf(speaker);
                m_speakerLabel.color = ColorOf(speaker);
            }

            if (m_chineseLabel != null)
            {
                m_chineseLabel.text = chinese;
            }

            if (m_englishLabel != null)
            {
                m_englishLabel.text = english;
                m_englishLabel.gameObject.SetActive(!string.IsNullOrEmpty(english));
            }
        }

        /// <inheritdoc />
        public void ShowChoices(string[] chinese, string[] english)
        {
            SetRootVisible(true);

            if (chinese == null)
            {
                HideChoiceButtons();
                return;
            }

            if (chinese.Length == 0)
            {
                HideChoiceButtons();
                return;
            }

            ReleaseChoiceCursor();

            if (chinese.Length > m_choiceButtons.Length)
            {
                Debug.LogWarning($"DialoguePresenter was offered {chinese.Length} options but has "
                    + $"{m_choiceButtons.Length} buttons; the rest cannot be chosen.", this);
            }

            for (int i = 0; i < m_choiceButtons.Length; i++)
            {
                bool used = i < chinese.Length;

                if (m_choiceButtons[i] != null)
                {
                    m_choiceButtons[i].gameObject.SetActive(used);
                }

                if (!used)
                {
                    continue;
                }

                if (i < m_choiceChineseLabels.Length && m_choiceChineseLabels[i] != null)
                {
                    m_choiceChineseLabels[i].text = chinese[i];
                }

                if (i < m_choiceEnglishLabels.Length && m_choiceEnglishLabels[i] != null)
                {
                    string subtitle = english != null && i < english.Length ? english[i] : string.Empty;
                    m_choiceEnglishLabels[i].text = subtitle;
                    m_choiceEnglishLabels[i].gameObject.SetActive(!string.IsNullOrEmpty(subtitle));
                }
            }
        }

        /// <inheritdoc />
        public void Hide()
        {
            SetRootVisible(false);
            HideChoiceButtons();
        }

        private void OnButtonClicked(int index)
        {
            // Cleared immediately so a second click before the runner reacts cannot answer twice.
            HideChoiceButtons();
            ChoiceSelected?.Invoke(index);
        }

        private void HideChoiceButtons()
        {
            for (int i = 0; i < m_choiceButtons.Length; i++)
            {
                if (m_choiceButtons[i] != null)
                {
                    m_choiceButtons[i].gameObject.SetActive(false);
                }
            }

            RestoreChoiceCursor();
        }

        private void ReleaseChoiceCursor()
        {
            if (m_hasChoiceCursor)
            {
                return;
            }

            m_cursorLockBeforeChoices = Cursor.lockState;
            m_cursorVisibleBeforeChoices = Cursor.visible;
            m_hasChoiceCursor = true;
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
        }

        private void RestoreChoiceCursor()
        {
            if (!m_hasChoiceCursor)
            {
                return;
            }

            m_hasChoiceCursor = false;
            Cursor.lockState = m_cursorLockBeforeChoices;
            Cursor.visible = m_cursorVisibleBeforeChoices;
        }

        private void SetRootVisible(bool isVisible)
        {
            if (m_root == null)
            {
                return;
            }

            m_root.alpha = isVisible ? 1f : 0f;
            m_root.blocksRaycasts = isVisible;
            m_root.interactable = isVisible;
        }

        private string NameOf(DialogueSpeaker speaker)
        {
            switch (speaker)
            {
                case DialogueSpeaker.Flower:
                    return m_flowerName;

                case DialogueSpeaker.Device:
                    return m_deviceName;

                default:
                    return m_protagonistName;
            }
        }

        private Color ColorOf(DialogueSpeaker speaker)
        {
            switch (speaker)
            {
                case DialogueSpeaker.Flower:
                    return m_flowerColor;

                case DialogueSpeaker.Device:
                    return m_deviceColor;

                default:
                    return m_protagonistColor;
            }
        }
    }
}
