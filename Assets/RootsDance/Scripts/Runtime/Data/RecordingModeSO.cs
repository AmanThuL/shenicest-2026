using System;
using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>
    /// The developer's "clean footage" switch: when active, every <see cref="UI.RecordingModeHider"/>
    /// whose group is in <see cref="Hidden"/> takes its screen element away. Gameplay never reads
    /// this; only the hiders and the rescue panel that owns the toggles do.
    /// <para>
    /// One asset, referenced by the panel and by every hider, so the state is shared without a
    /// static. It is remembered between sessions in PlayerPrefs: a recording session spans many
    /// Play runs, and re-ticking five boxes each time is exactly the kind of chore that gets
    /// skipped. The panel shows the current state, so a switch left on is never a mystery.
    /// </para>
    /// </summary>
    public sealed class RecordingModeSO : ScriptableObject
    {
        private const string k_ActiveKey = "recording.active";
        private const string k_HiddenKey = "recording.hidden";

        [Tooltip("Which groups a fresh machine hides once recording mode is switched on.")]
        [SerializeField] private RecordingHiddenUi m_defaultHidden = RecordingHiddenUi.All;

        [NonSerialized] private bool m_isLoaded;
        [NonSerialized] private bool m_isActive;
        [NonSerialized] private RecordingHiddenUi m_hidden;

        /// <summary>Raised after any change to <see cref="IsActive"/> or <see cref="Hidden"/>.</summary>
        public event Action Changed;

        /// <summary>The master switch. Nothing is hidden while this is off, whatever the mask says.</summary>
        public bool IsActive
        {
            get
            {
                EnsureLoaded();
                return m_isActive;
            }
        }

        /// <summary>The groups that go away while <see cref="IsActive"/>.</summary>
        public RecordingHiddenUi Hidden
        {
            get
            {
                EnsureLoaded();
                return m_hidden;
            }
        }

        /// <summary>True when <paramref name="group"/> should be off the screen right now.</summary>
        public bool IsHidden(RecordingHiddenUi group)
        {
            EnsureLoaded();
            return m_isActive && (m_hidden & group) != 0;
        }

        public void SetActive(bool isActive)
        {
            EnsureLoaded();

            if (m_isActive == isActive)
            {
                return;
            }

            m_isActive = isActive;
            PlayerPrefs.SetInt(k_ActiveKey, isActive ? 1 : 0);
            Changed?.Invoke();
        }

        public void SetHidden(RecordingHiddenUi group, bool isHidden)
        {
            EnsureLoaded();
            RecordingHiddenUi next = isHidden ? m_hidden | group : m_hidden & ~group;

            if (next == m_hidden)
            {
                return;
            }

            m_hidden = next;
            PlayerPrefs.SetInt(k_HiddenKey, (int)next);
            Changed?.Invoke();
        }

        private void OnEnable()
        {
            // Re-read on every load so a domain reload or a re-imported asset never keeps a
            // stale copy of what PlayerPrefs actually says.
            m_isLoaded = false;
        }

        private void OnDisable()
        {
            m_isLoaded = false;
        }

        private void EnsureLoaded()
        {
            if (m_isLoaded)
            {
                return;
            }

            m_isLoaded = true;
            m_isActive = PlayerPrefs.GetInt(k_ActiveKey, 0) != 0;
            m_hidden = (RecordingHiddenUi)PlayerPrefs.GetInt(k_HiddenKey, (int)m_defaultHidden);
        }
    }
}
