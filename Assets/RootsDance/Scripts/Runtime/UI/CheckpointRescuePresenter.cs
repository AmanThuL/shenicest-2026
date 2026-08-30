using System;
using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Data;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>Hidden build-safe checkpoint rescue screen. Never mutates progression directly.</summary>
    [DefaultExecutionOrder(-100)]
    [RequireComponent(typeof(Canvas))]
    public sealed class CheckpointRescuePresenter : MonoBehaviour
    {
        [SerializeField] private MonoBehaviour m_serviceBehaviour;
        [SerializeField] private GameObject m_panel;
        [SerializeField] private TextMeshProUGUI m_status;
        [SerializeField] private TextMeshProUGUI m_details;
        [SerializeField] private TextMeshProUGUI m_jumpLabel;
        [SerializeField] private Button m_close;
        [SerializeField] private Button m_jump;
        [SerializeField] private CanvasGroup m_listGroup;
        [SerializeField] private RectTransform m_list;
        [SerializeField] private CheckpointRescueRow m_rowTemplate;

        private ICheckpointRescueService m_service;
        private readonly List<CheckpointRescueRow> m_rows = new List<CheckpointRescueRow>();
        private InputAction m_toggle;
        private InputAction m_cancel;
        private RescueCheckpoint m_selected;
        private RescueModalState m_modalState;
        private bool m_isOpen;
        private bool m_isJumping;
        private bool m_hasBuiltList;
        private bool m_isConfirmationArmed;
        private int m_releaseInputAfterFrame = -1;
        private EventSystem m_eventSystem;
        private GameObject m_previousSelection;
        private bool m_restorePreviousSelection;

        public bool IsOpen => m_isOpen;

        private void Awake()
        {
            // The prefab's root Canvas cannot retain overrideSorting until it has a Canvas parent.
            GetComponent<Canvas>().overrideSorting = true;
            m_service = m_serviceBehaviour as ICheckpointRescueService;
            m_panel.SetActive(false);
            m_rowTemplate.gameObject.SetActive(false);
            InputActionAsset actions = InputSystem.actions;
            m_toggle = actions == null ? null : actions.FindAction("Debug/ToggleCheckpointRescue");
            m_cancel = actions == null ? null : actions.FindAction("Debug/CloseCheckpointRescue");
        }

        private void OnEnable()
        {
            m_close.onClick.AddListener(Hide);
            m_jump.onClick.AddListener(OnJumpClicked);
            m_toggle?.Enable();
            m_cancel?.Enable();

            if (m_service != null)
            {
                m_service.Changed += RefreshStatus;
            }
        }

        private void Update()
        {
            if (!m_isOpen && m_service != null && m_releaseInputAfterFrame >= 0
                && Time.frameCount > m_releaseInputAfterFrame)
            {
                m_service.IsModalOpen = false;
                m_releaseInputAfterFrame = -1;
                RestoreSelection();
            }

            KeepModalFocus();

            if (m_toggle != null && m_toggle.WasPressedThisFrame())
            {
                if (m_isOpen)
                {
                    Hide();
                }
                else
                {
                    Show();
                }

                return;
            }

            if (m_isOpen && m_cancel != null && m_cancel.WasPressedThisFrame())
            {
                Hide();
            }
        }

        private void LateUpdate()
        {
            if (!m_isOpen || m_isJumping)
            {
                return;
            }

            m_modalState?.Enforce();
            // During loading the new player owns its cursor baseline; do not overwrite it.
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
        }

        private void OnDisable()
        {
            m_close.onClick.RemoveListener(Hide);
            m_jump.onClick.RemoveListener(OnJumpClicked);

            if (m_service != null)
            {
                m_service.Changed -= RefreshStatus;
                m_service.IsModalOpen = false;
            }

            m_modalState?.Restore();
            m_modalState = null;
            m_isOpen = false;
            m_panel.SetActive(false);
            RestoreSelection();
        }

        public void Show()
        {
            if (m_isOpen || m_service == null || m_service.Catalog == null
                || (!Application.isEditor && !m_service.Catalog.EnabledInPlayer))
            {
                return;
            }

            BuildList();
            m_isOpen = true;
            m_service.IsModalOpen = true;
            m_modalState = new RescueModalState(InputSystem.actions);
            transform.SetAsLastSibling();
            m_panel.SetActive(true);
            m_eventSystem = EventSystem.current;
            m_previousSelection = m_eventSystem == null ? null : m_eventSystem.currentSelectedGameObject;
            m_restorePreviousSelection = true;
            if (m_eventSystem != null)
            {
                m_eventSystem.SetSelectedGameObject(m_close.gameObject);
            }

            m_isConfirmationArmed = false;
            RefreshSelection();
            RefreshStatus();
        }

        public void Hide()
        {
            if (!m_isOpen || m_isJumping || m_service.IsBusy)
            {
                return;
            }

            m_modalState?.Restore();
            m_modalState = null;
            // UI and world-space interactions can consume the same click later this frame.
            m_releaseInputAfterFrame = Time.frameCount;
            if (m_eventSystem != null)
            {
                m_eventSystem.SetSelectedGameObject(null);
            }

            m_isOpen = false;
            m_panel.SetActive(false);
        }

        private void BuildList()
        {
            if (m_hasBuiltList)
            {
                return;
            }

            var checkpoints = new List<RescueCheckpoint>(m_service.Catalog.Checkpoints);
            checkpoints.Sort((left, right) => string.CompareOrdinal(left.Label, right.Label));

            foreach (RescueCheckpoint checkpoint in checkpoints)
            {
                CheckpointRescueRow row = Instantiate(m_rowTemplate, m_list);
                row.Bind(checkpoint, SelectCheckpoint);
                row.gameObject.SetActive(true);
                m_rows.Add(row);
            }

            m_hasBuiltList = true;
            ConfigureNavigation();
        }

        private void ConfigureNavigation()
        {
            for (int i = 0; i < m_rows.Count; i++)
            {
                Selectable previous = i > 0 ? m_rows[i - 1].NavigationButton : m_close;
                Selectable next = i + 1 < m_rows.Count ? m_rows[i + 1].NavigationButton : m_close;
                SetNavigation(m_rows[i].NavigationButton, previous, next, m_close, m_jump);
            }

            Selectable first = m_rows.Count > 0 ? m_rows[0].NavigationButton : m_close;
            Selectable last = m_rows.Count > 0 ? m_rows[m_rows.Count - 1].NavigationButton : m_close;
            SetNavigation(m_close, last, first, m_jump, m_jump);
            SetNavigation(m_jump, last, first, m_close, m_close);
        }

        private static void SetNavigation(Selectable control, Selectable up, Selectable down,
            Selectable left, Selectable right)
        {
            control.navigation = new Navigation
            {
                mode = Navigation.Mode.Explicit,
                selectOnUp = up,
                selectOnDown = down,
                selectOnLeft = left,
                selectOnRight = right
            };
        }

        private void KeepModalFocus()
        {
            if (!m_isOpen || m_isJumping || m_eventSystem == null)
            {
                return;
            }

            GameObject selected = m_eventSystem.currentSelectedGameObject;
            if (selected == null || !selected.transform.IsChildOf(transform))
            {
                m_eventSystem.SetSelectedGameObject(m_close.gameObject);
            }
        }

        private void RestoreSelection()
        {
            if (m_eventSystem != null)
            {
                m_eventSystem.SetSelectedGameObject(m_restorePreviousSelection && m_previousSelection != null
                    ? m_previousSelection : null);
            }

            m_previousSelection = null;
            m_restorePreviousSelection = false;
        }

        private void SelectCheckpoint(RescueCheckpoint checkpoint)
        {
            if (m_isJumping)
            {
                return;
            }

            m_selected = checkpoint;
            foreach (CheckpointRescueRow row in m_rows)
            {
                row.SetSelected(checkpoint);
            }
            m_isConfirmationArmed = false;
            RefreshSelection();
        }

        private void RefreshSelection()
        {
            m_jumpLabel.text = "Reset and jump";
            m_jump.interactable = m_selected != null && !m_isJumping;
            m_details.text = m_selected == null
                ? "Select a checkpoint. Jumping clears current progress and reloads the entire target level."
                : m_selected.Label + "\nLevel: " + (m_selected.Level == null ? "Not configured" : m_selected.Level.name)
                    + "\nSpawn: " + (string.IsNullOrEmpty(m_selected.AnchorName)
                        ? "Preset coordinates" : m_selected.AnchorName)
                    + "\nReloads the level and restores checkpoint story / investigation progress.";
        }

        private void RefreshStatus()
        {
            if (!m_isOpen)
            {
                return;
            }

            m_status.text = "Current level: " + m_service.CurrentLevelName
                + "\nLast debug jump: " + (string.IsNullOrEmpty(m_service.LastCheckpointLabel)
                    ? "None" : m_service.LastCheckpointLabel);
            bool busy = m_isJumping || m_service.IsBusy;
            m_close.interactable = !busy;
            m_jump.interactable = !busy && m_selected != null;
            m_listGroup.interactable = !busy;
        }

        private void OnJumpClicked()
        {
            if (m_selected == null || m_isJumping || m_service.IsBusy)
            {
                return;
            }

            if (!m_service.TryValidate(m_selected, out string error))
            {
                m_details.text = "Cannot jump: " + error;
                return;
            }

            if (!m_isConfirmationArmed)
            {
                m_isConfirmationArmed = true;
                m_details.text = "Jump to '" + m_selected.Label
                    + "'?\nCurrent progress will be replaced by this checkpoint. This cannot be undone.";
                m_jumpLabel.text = "Confirm reset and jump";
                return;
            }

            JumpSelectedAsync();
        }

        private async void JumpSelectedAsync()
        {
            m_isJumping = true;
            m_details.text = "Resetting and loading. Please wait...";
            RefreshStatus();
            // Release the old world's snapshot. New scene locks must never be replaced by it.
            m_modalState?.Restore();
            m_modalState = null;

            try
            {
                await m_service.JumpAsync(m_selected, destroyCancellationToken);
                m_isJumping = false;
                m_restorePreviousSelection = false;
                Hide();
            }
            catch (OperationCanceledException)
            {
                if (this != null && isActiveAndEnabled)
                {
                    RestoreAfterFailure("Jump cancelled.");
                }
            }
            catch (Exception exception)
            {
                if (this != null && isActiveAndEnabled)
                {
                    RestoreAfterFailure(exception.Message);
                }
            }
        }

        private void RestoreAfterFailure(string error)
        {
            m_isJumping = false;
            m_isConfirmationArmed = false;
            m_modalState = new RescueModalState(InputSystem.actions);
            m_details.text = "Jump failed: " + error + "\nSelect a checkpoint and retry.";
            m_jumpLabel.text = "Reset and jump";
            RefreshStatus();
        }
    }
}
