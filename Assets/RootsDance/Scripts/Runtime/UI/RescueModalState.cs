using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.UI
{
    /// <summary>Owns only the pause, cursor and input changes made by one rescue-menu opening.</summary>
    public sealed class RescueModalState
    {
        private readonly List<InputAction> m_actions = new List<InputAction>();
        private readonly List<bool> m_wasEnabled = new List<bool>();
        private readonly float m_timeScale;
        private readonly bool m_audioPaused;
        private readonly bool m_cursorVisible;
        private readonly CursorLockMode m_cursorLock;
        private bool m_isRestored;

        public RescueModalState(InputActionAsset actions)
        {
            m_timeScale = Time.timeScale;
            m_audioPaused = AudioListener.pause;
            m_cursorVisible = Cursor.visible;
            m_cursorLock = Cursor.lockState;

            if (actions != null)
            {
                foreach (InputActionMap map in actions.actionMaps)
                {
                    if (map.name == "UI" || map.name == "Debug")
                    {
                        continue;
                    }

                    foreach (InputAction action in map.actions)
                    {
                        m_actions.Add(action);
                        m_wasEnabled.Add(action.enabled);
                    }
                }
            }

            Enforce();
        }

        public void Enforce()
        {
            if (m_isRestored)
            {
                return;
            }

            Time.timeScale = 0f;
            AudioListener.pause = true;
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;

            for (int i = 0; i < m_actions.Count; i++)
            {
                m_actions[i].Disable();
            }
        }

        public void Restore()
        {
            if (m_isRestored)
            {
                return;
            }

            m_isRestored = true;
            Time.timeScale = m_timeScale;
            AudioListener.pause = m_audioPaused;
            Cursor.lockState = m_cursorLock;
            Cursor.visible = m_cursorVisible;

            for (int i = 0; i < m_actions.Count; i++)
            {
                if (m_wasEnabled[i])
                {
                    m_actions[i].Enable();
                }
                else
                {
                    m_actions[i].Disable();
                }
            }
        }
    }
}
