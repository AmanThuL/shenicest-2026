using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.UIElements;

namespace RootsDance.UI
{
    /// <summary>
    /// UXML contract: a Button named "main-menu__start-button". Clicking it requests the target
    /// level; GameBootstrap's SceneLoader then tears this scene down along with everything else
    /// non-Bootstrap and loads the target level's scenes.
    /// </summary>
    [RequireComponent(typeof(UIDocument))]
    public class MainMenuPresenter : MonoBehaviour
    {
        private const string k_StartButtonName = "main-menu__start-button";

        [Header("Broadcasts on")]
        [SerializeField] private LevelEventChannelSO m_loadLevelRequested;

        [Header("Content")]
        [Tooltip("Level loaded when the player presses Start.")]
        [SerializeField] private LevelSO m_levelToLoad;

        private UIDocument m_document;
        private Button m_startButton;

        private void Awake()
        {
            m_document = GetComponent<UIDocument>();
        }

        private void OnEnable()
        {
            VisualElement documentRoot = m_document.rootVisualElement;

            if (documentRoot == null)
            {
                Log.Error("MainMenuPresenter has no root visual element.", this);
                return;
            }

            m_startButton = documentRoot.Q<Button>(k_StartButtonName);

            if (m_startButton == null)
            {
                Log.Error($"UXML is missing an element named '{k_StartButtonName}'.", this);
                return;
            }

            m_startButton.clicked += OnStartClicked;
        }

        private void OnDisable()
        {
            if (m_startButton != null)
            {
                m_startButton.clicked -= OnStartClicked;
            }
        }

        private void OnStartClicked()
        {
            if (m_loadLevelRequested == null || m_levelToLoad == null)
            {
                Log.Error("MainMenuPresenter is missing its channel or level assignment.", this);
                return;
            }

            m_loadLevelRequested.RaiseEvent(m_levelToLoad);
        }
    }
}
