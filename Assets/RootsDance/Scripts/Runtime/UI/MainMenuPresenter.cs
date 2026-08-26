using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// Clicking Start requests the target level; GameBootstrap's SceneLoader then tears this scene
    /// down along with everything else non-Bootstrap and loads the target level's scenes.
    /// </summary>
    public class MainMenuPresenter : MonoBehaviour
    {
        [Header("Broadcasts on")]
        [SerializeField] private LevelEventChannelSO m_loadLevelRequested;

        [Header("Content")]
        [Tooltip("Level loaded when the player presses Start.")]
        [SerializeField] private LevelSO m_levelToLoad;

        [Header("Widgets")]
        [SerializeField] private Button m_startButton;

        private void OnEnable()
        {
            m_startButton.onClick.AddListener(OnStartClicked);
        }

        private void OnDisable()
        {
            m_startButton.onClick.RemoveListener(OnStartClicked);
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
