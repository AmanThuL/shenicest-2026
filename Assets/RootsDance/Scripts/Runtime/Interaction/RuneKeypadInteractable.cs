using System;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using RootsDance.Player.Arms;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The wall-mounted rune lock and its close-up interaction. A keypad-owned Cinemachine camera
    /// flies the player's view squarely onto the fixed model, while the pointer selects its real
    /// key colliders.
    /// </summary>
    [DisallowMultipleComponent]
    public class RuneKeypadInteractable : MonoBehaviour, IInteractable, IRescueResetParticipant
    {
        private const string k_DropActionId = "drop";
        private const string k_HoldActionId = "hold";
        private const string k_KeypadPokeActionId = "keypadPoke";
        private const float k_ConfirmContactSeconds = 0.84f;
        private const float k_ActionTimeoutPaddingSeconds = 0.75f;
        private const float k_MinActionTimeoutSeconds = 1.5f;

        private static readonly RuneSymbol[] k_Password =
        {
            RuneSymbol.Ansuz,
            RuneSymbol.Raidho,
            RuneSymbol.Berkana,
            RuneSymbol.Dagaz
        };

        private enum InspectState
        {
            Idle = 0,
            Preparing = 1,
            Raising = 2,
            Reading = 3,
            ShowingError = 4,
            Confirming = 5,
            Lowering = 6,
            Transitioning = 7
        }

        [Header("Interaction")]
        [SerializeField] private string m_promptText = "[E] 使用密码锁";

        [Tooltip("Broad collider hit by the normal centre-screen interaction ray.")]
        [SerializeField] private Collider m_worldCollider;

        [Tooltip("Only the close-up key colliders belong to these layers.")]
        [SerializeField] private LayerMask m_buttonLayers;

        [SerializeField] private RuneKeypadButton[] m_buttons = new RuneKeypadButton[0];

        [Tooltip("Four neutral screen markers showing how many symbols have been entered.")]
        [SerializeField] private GameObject[] m_entryIndicators = new GameObject[0];

        [Tooltip("The four authored screen runes, revealed only after the code is solved.")]
        [SerializeField] private GameObject[] m_solvedRunes = new GameObject[0];

        [SerializeField] private RuneKeypadButton m_clearButton;

        [SerializeField] private RuneKeypadButton m_confirmButton;

        [Header("Close-up camera")]
        [Tooltip("Inactive camera parked squarely in front of this wall-mounted keypad.")]
        [SerializeField] private CinemachineCamera m_inspectCamera;

        [Tooltip("Camera-local-to-keypad pose that aligns the confirm key with the poke animation.")]
        [SerializeField] private Vector3 m_confirmCameraPosition =
            new Vector3(-1.105714f, 0.581429f, 0.222857f);

        [SerializeField] private Vector3 m_confirmCameraEuler = new Vector3(0f, 90f, 0f);

        [SerializeField] private int m_activeCameraPriority = 30;

        [Range(0.05f, 2f)]
        [SerializeField] private float m_raiseSeconds = 0.4f;

        [Range(0.05f, 2f)]
        [SerializeField] private float m_lowerSeconds = 0.3f;

        [Range(0.05f, 1f)]
        [SerializeField] private float m_buttonPressSeconds = 0.1f;

        [Range(0.1f, 2f)]
        [SerializeField] private float m_errorSeconds = 0.65f;

        [Header("Scene transition")]
        [SerializeField] private LevelEventChannelSO m_loadLevelRequested;

        [SerializeField] private LevelSO m_destinationLevel;

        [Header("Broadcasts on")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        private RuneKeypadSequence m_sequence;
        private InspectState m_state;
        private PlayerInputReader m_input;
        private Camera m_camera;
        private ArmsDirector m_armsDirector;
        private HandSocket m_rightSocket;
        private CarriedItem m_stowedItem;
        private RuneKeypadButton m_hoveredButton;
        private Behaviour[] m_suspendedBehaviours = new Behaviour[0];
        private bool[] m_suspendedEnabledStates = new bool[0];
        private CinemachineBrain m_brain;
        private CinemachineBlendDefinition m_previousBlend;
        private bool m_hasStoredBlend;
        private Vector3 m_inspectCameraPosition;
        private Quaternion m_inspectCameraRotation;
        private CursorLockMode m_originCursorLock;
        private bool m_originCursorVisible;
        private bool m_isButtonAnimating;
        private string m_waitingActionId;
        private bool m_didActionFinish;
        private CancellationTokenSource m_inspectionCancellation;

        public string PromptText => m_promptText;

        public bool CanInteract => m_state == InspectState.Idle;

        private void Awake()
        {
            ResetSequence();
            SetEntryIndicators(0);
            SetSolvedRunes(false);

            if (m_inspectCamera != null)
            {
                m_inspectCameraPosition = m_inspectCamera.transform.localPosition;
                m_inspectCameraRotation = m_inspectCamera.transform.localRotation;
            }
        }

        private void Update()
        {
            if (m_state != InspectState.Reading || m_input == null || m_camera == null)
            {
                return;
            }

            UpdateHoveredButton();

            if (m_input.InteractPressedThisFrame)
            {
                LowerEntryAsync(m_inspectionCancellation.Token);
                return;
            }

            if (!m_isButtonAnimating && m_input.ClickPressedThisFrame && m_hoveredButton != null)
            {
                PressButtonEntryAsync(m_hoveredButton, m_inspectionCancellation.Token);
            }
        }

        private void OnDisable()
        {
            UnsubscribeFromArms();
            StopInspectCamera();

            if (m_hoveredButton != null)
            {
                m_hoveredButton.SetHovered(false);
                m_hoveredButton = null;
            }
        }

        private void OnDestroy()
        {
            CancelInspection();
        }

        public void Interact(GameObject interactor)
        {
            if (m_state != InspectState.Idle || interactor == null)
            {
                return;
            }

            CancelInspection();
            m_inspectionCancellation = CancellationTokenSource.CreateLinkedTokenSource(destroyCancellationToken);
            BeginInspectEntryAsync(interactor, m_inspectionCancellation.Token);
        }

        /// <summary>Ends a close-up without completing the puzzle.</summary>
        public void ResetForRescue()
        {
            CancelInspection();
            if (m_state == InspectState.Idle)
            {
                return;
            }

            UnsubscribeFromArms();
            ClearHover();
            StopInspectCamera();

            // The outgoing player will be unloaded. Do not play a return animation or change the
            // cursor here: the rescue modal owns input and the camera until loading finishes.
            m_stowedItem = null;
            m_isButtonAnimating = false;
            m_state = InspectState.Idle;
        }

        private void CancelInspection()
        {
            CancellationTokenSource cancellation = m_inspectionCancellation;
            m_inspectionCancellation = null;
            if (cancellation != null)
            {
                cancellation.Cancel();
                cancellation.Dispose();
            }
        }

        /// <summary>Editor construction hook used by the idempotent prefab builder.</summary>
        public void Configure(Collider worldCollider, LayerMask buttonLayers,
            RuneKeypadButton[] buttons, GameObject[] entryIndicators, GameObject[] solvedRunes,
            RuneKeypadButton clearButton, RuneKeypadButton confirmButton,
            CinemachineCamera inspectCamera, Vector3 confirmCameraPosition,
            Vector3 confirmCameraEuler,
            LevelEventChannelSO loadLevelRequested, LevelSO destinationLevel,
            StringEventChannelSO promptChanged)
        {
            m_worldCollider = worldCollider;
            m_buttonLayers = buttonLayers;
            m_buttons = buttons;
            m_entryIndicators = entryIndicators;
            m_solvedRunes = solvedRunes;
            m_clearButton = clearButton;
            m_confirmButton = confirmButton;
            m_inspectCamera = inspectCamera;
            m_confirmCameraPosition = confirmCameraPosition;
            m_confirmCameraEuler = confirmCameraEuler;
            m_loadLevelRequested = loadLevelRequested;
            m_destinationLevel = destinationLevel;
            m_promptChanged = promptChanged;
        }

        private async void BeginInspectEntryAsync(GameObject interactor,
            CancellationToken cancellationToken)
        {
            try
            {
                m_state = InspectState.Preparing;

                if (!ResolvePlayer(interactor))
                {
                    m_state = InspectState.Idle;
                    return;
                }

                SuspendPlayer(true);
                SaveCursor();
                SetCursorForInspect(false);
                SetWorldCollider(false);

                // Start putting the torch away before the close-up, but do not leave the player
                // waiting on an unmoving view while the arms action runs. The camera blend gives
                // immediate feedback and overlaps the first part of the stow animation.
                Awaitable<bool> stowOperation = StowTorchAsync(cancellationToken);

                m_state = InspectState.Raising;
                ActivateInspectCamera(m_raiseSeconds);
                await WaitUnscaledAsync(m_raiseSeconds, cancellationToken);

                if (!await stowOperation)
                {
                    AbortInspect();
                    return;
                }

                m_state = InspectState.Reading;
                SetCursorForInspect(true);
                PublishPrompt("[鼠标] 选择符文  [左键] 输入  [E] 退出");
            }
            catch (OperationCanceledException)
            {
                // Scene unload or Play mode exit owns cleanup from this point.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
                AbortInspect();
            }
        }

        private async void LowerEntryAsync(CancellationToken cancellationToken)
        {
            if (m_state != InspectState.Reading)
            {
                return;
            }

            try
            {
                m_state = InspectState.Lowering;
                SetCursorForInspect(false);
                ClearHover();
                PublishPrompt(string.Empty);
                DeactivateInspectCamera(m_lowerSeconds);
                await WaitUnscaledAsync(m_lowerSeconds, cancellationToken);

                FinishInspectCamera();
                RestoreStowedItem();
                RestoreCursor();
                SuspendPlayer(false);
                SetWorldCollider(true);
                ResetSequence();
                SetEntryIndicators(0);
                SetSolvedRunes(false);
                m_state = InspectState.Idle;
            }
            catch (OperationCanceledException)
            {
                // Scene unload or Play mode exit owns cleanup from this point.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
                AbortInspect();
            }
        }

        private async void PressButtonEntryAsync(RuneKeypadButton button,
            CancellationToken cancellationToken)
        {
            try
            {
                m_isButtonAnimating = true;
                await PulseButtonAsync(button, cancellationToken);

                if (button.Kind == RuneKeypadButton.ButtonKind.Clear)
                {
                    m_sequence.Clear();
                    SetEntryIndicators(0);
                    m_isButtonAnimating = false;
                    return;
                }

                if (button.Kind == RuneKeypadButton.ButtonKind.Confirm)
                {
                    m_sequence.Clear();
                    SetEntryIndicators(0);
                    m_state = InspectState.ShowingError;
                    await ShowErrorAsync(cancellationToken);
                    m_state = InspectState.Reading;
                    m_isButtonAnimating = false;
                    return;
                }

                RuneKeypadInputResult result = m_sequence.Enter(button.Symbol);
                SetEntryIndicators(m_sequence.EnteredCount);

                if (result == RuneKeypadInputResult.Incorrect)
                {
                    m_state = InspectState.ShowingError;
                    await ShowErrorAsync(cancellationToken);
                    m_sequence.AcknowledgeError();
                    m_state = InspectState.Reading;
                }
                else if (result == RuneKeypadInputResult.Solved)
                {
                    m_state = InspectState.Confirming;
                    SetSolvedRunes(true);
                    ClearHover();
                    SetCursorForInspect(false);
                    await ConfirmAndTransitionAsync(cancellationToken);
                }

                m_isButtonAnimating = false;
            }
            catch (OperationCanceledException)
            {
                // Scene unload or Play mode exit owns cleanup from this point.
            }
            catch (Exception exception)
            {
                m_isButtonAnimating = false;
                Log.Exception(exception, this);
                AbortInspect();
            }
        }

        private bool ResolvePlayer(GameObject interactor)
        {
            m_input = interactor.GetComponentInParent<PlayerInputReader>();
            m_camera = Camera.main;

            Transform playerRoot = m_input == null ? null : m_input.transform;

            if (m_input == null || m_camera == null || playerRoot == null
                || m_inspectCamera == null)
            {
                Log.Error("Rune keypad could not resolve the player's input, main camera or "
                    + "fixed inspect camera.", this);
                return false;
            }

            ArmsDirector director = playerRoot.GetComponentInChildren<ArmsDirector>(true);
            m_armsDirector = director;

            HandSocket[] sockets = playerRoot.GetComponentsInChildren<HandSocket>(true);
            m_rightSocket = null;

            for (int i = 0; i < sockets.Length; i++)
            {
                if (sockets[i].Hand == HandSide.Right)
                {
                    m_rightSocket = sockets[i];
                    break;
                }
            }

            m_suspendedBehaviours = new Behaviour[]
            {
                playerRoot.GetComponentInChildren<PlayerLook>(true),
                playerRoot.GetComponentInChildren<FirstPersonController>(true),
                playerRoot.GetComponentInChildren<InteractionRaycaster>(true)
            };
            m_suspendedEnabledStates = new bool[m_suspendedBehaviours.Length];

            return true;
        }

        private async Awaitable<bool> StowTorchAsync(CancellationToken cancellationToken)
        {
            if (m_armsDirector == null)
            {
                Log.Error("Rune keypad requires the player's ArmsDirector.", this);
                return false;
            }

            if (m_rightSocket == null || m_rightSocket.Carried == null)
            {
                return true;
            }

            CarriedItem carried = m_rightSocket.Carried;

            if (carried.Kind != CarriedKind.Torch)
            {
                PublishPrompt("请先放下手中的物品");
                return false;
            }

            m_stowedItem = carried;
            m_stowedItem.gameObject.SetActive(false);

            // The torch stays hidden for the close-up either way; RestoreStowedItem puts it back
            // when it ends.
            await PlayArmsActionAsync(k_DropActionId, cancellationToken, false);

            return true;
        }

        private void RestoreStowedItem()
        {
            if (m_stowedItem == null || m_rightSocket == null)
            {
                return;
            }

            m_stowedItem.gameObject.SetActive(true);

            if (m_rightSocket.Carried != m_stowedItem)
            {
                m_rightSocket.Attach(m_stowedItem);

                if (m_armsDirector != null)
                {
                    m_armsDirector.TryPlay(k_HoldActionId);
                }
            }

            m_stowedItem = null;
        }

        private async Awaitable ConfirmAndTransitionAsync(CancellationToken cancellationToken)
        {
            PublishPrompt("密码正确");
            await TweenInspectCameraAsync(
                m_confirmCameraPosition,
                Quaternion.Euler(m_confirmCameraEuler),
                m_buttonPressSeconds * 2f,
                cancellationToken);

            bool didPlay = await PlayArmsActionAsync(k_KeypadPokeActionId,
                cancellationToken, true);

            if (!didPlay)
            {
                PublishPrompt("手臂动作暂时不可用，请重试");
                await TweenInspectCameraAsync(
                    m_inspectCameraPosition,
                    m_inspectCameraRotation,
                    m_buttonPressSeconds * 2f,
                    cancellationToken);
                ResetSequence();
                SetEntryIndicators(0);
                SetSolvedRunes(false);
                SetCursorForInspect(true);
                m_state = InspectState.Reading;
                return;
            }

            m_state = InspectState.Transitioning;
            PublishPrompt("访问授权");

            if (m_loadLevelRequested == null || m_destinationLevel == null)
            {
                Log.Error("Rune keypad is missing its load channel or destination level.", this);
                AbortInspect();
                return;
            }

            LevelEventChannelSO loadLevelRequested = m_loadLevelRequested;
            LevelSO destinationLevel = m_destinationLevel;
            PrepareForSceneUnload();
            loadLevelRequested.RaiseEvent(destinationLevel);
        }

        private void PrepareForSceneUnload()
        {
            ClearHover();
            SetCursorForInspect(false);
            StopInspectCamera();
            SetWorldCollider(false);
            gameObject.SetActive(false);
        }

        private async Awaitable<bool> PlayArmsActionAsync(string actionId,
            CancellationToken cancellationToken, bool showConfirmContact)
        {
            if (m_armsDirector == null)
            {
                return false;
            }

            m_waitingActionId = actionId;
            m_didActionFinish = false;
            m_armsDirector.ActionFinished += OnArmsActionFinished;

            try
            {
                if (!m_armsDirector.TryPlay(actionId))
                {
                    return false;
                }

                ArmsActionSO action = m_armsDirector.FindAction(actionId);
                float authoredDuration = action == null ? 0f : action.Duration;
                float timeoutSeconds = Mathf.Max(
                    k_MinActionTimeoutSeconds,
                    authoredDuration + k_ActionTimeoutPaddingSeconds);
                float elapsed = 0f;
                bool didShowContact = false;

                while (!m_didActionFinish)
                {
                    elapsed += Time.unscaledDeltaTime;

                    if (elapsed >= timeoutSeconds)
                    {
                        Log.Warning($"Rune keypad arms action '{actionId}' timed out after "
                            + $"{timeoutSeconds:F2} seconds; restoring interaction control.", this);
                        return false;
                    }

                    if (showConfirmContact && !didShowContact
                        && elapsed >= k_ConfirmContactSeconds)
                    {
                        didShowContact = true;

                        if (m_confirmButton != null)
                        {
                            m_confirmButton.SetPressed(true);
                            m_confirmButton.SetFeedback(true);
                        }
                    }

                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                return true;
            }
            finally
            {
                if (m_confirmButton != null)
                {
                    m_confirmButton.SetPressed(false);
                    m_confirmButton.SetFeedback(false);
                }

                UnsubscribeFromArms();
            }
        }

        private void OnArmsActionFinished(string actionId)
        {
            if (actionId == m_waitingActionId)
            {
                m_didActionFinish = true;
            }
        }

        private void UnsubscribeFromArms()
        {
            if (m_armsDirector != null)
            {
                m_armsDirector.ActionFinished -= OnArmsActionFinished;
            }

            m_waitingActionId = string.Empty;
        }

        private void UpdateHoveredButton()
        {
            Ray ray = m_camera.ScreenPointToRay(m_input.PointerPosition);
            RuneKeypadButton button = null;

            if (Physics.Raycast(ray, out RaycastHit hit, 2f, m_buttonLayers,
                QueryTriggerInteraction.Collide))
            {
                button = hit.collider.GetComponentInParent<RuneKeypadButton>();
            }

            if (button == m_hoveredButton)
            {
                return;
            }

            ClearHover();
            m_hoveredButton = button;

            if (m_hoveredButton != null)
            {
                m_hoveredButton.SetHovered(true);
            }
        }

        private void ClearHover()
        {
            if (m_hoveredButton != null)
            {
                m_hoveredButton.SetHovered(false);
                m_hoveredButton = null;
            }
        }

        private async Awaitable PulseButtonAsync(RuneKeypadButton button,
            CancellationToken cancellationToken)
        {
            button.SetHovered(false);
            button.SetPressed(true);
            await WaitUnscaledAsync(m_buttonPressSeconds, cancellationToken);
            button.SetPressed(false);
        }

        private async Awaitable ShowErrorAsync(CancellationToken cancellationToken)
        {
            SetEntryIndicators(0);
            PublishPrompt("密码错误");

            if (m_clearButton != null)
            {
                m_clearButton.SetFeedback(true);
                m_clearButton.SetPressed(true);
            }

            await WaitUnscaledAsync(m_errorSeconds, cancellationToken);

            if (m_clearButton != null)
            {
                m_clearButton.SetPressed(false);
                m_clearButton.SetFeedback(false);
            }

            PublishPrompt("[鼠标] 选择符文  [左键] 输入  [E] 退出");
        }

        private async Awaitable TweenInspectCameraAsync(
            Vector3 targetPosition,
            Quaternion targetRotation,
            float seconds,
            CancellationToken cancellationToken)
        {
            if (m_inspectCamera == null)
            {
                return;
            }

            Transform cameraTransform = m_inspectCamera.transform;
            Vector3 fromPosition = cameraTransform.localPosition;
            Quaternion fromRotation = cameraTransform.localRotation;

            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.unscaledDeltaTime)
            {
                float t = Smooth(elapsed / seconds);
                cameraTransform.localPosition = Vector3.Lerp(fromPosition, targetPosition, t);
                cameraTransform.localRotation = Quaternion.Slerp(fromRotation, targetRotation, t);
                await Awaitable.NextFrameAsync(cancellationToken);
            }

            cameraTransform.localPosition = targetPosition;
            cameraTransform.localRotation = targetRotation;
        }

        private void ActivateInspectCamera(float blendSeconds)
        {
            if (m_inspectCamera == null)
            {
                return;
            }

            m_brain = CinemachineCore.FindPotentialTargetBrain(m_inspectCamera);
            SetBlendDuration(blendSeconds);
            m_inspectCamera.Priority = m_activeCameraPriority;
            m_inspectCamera.gameObject.SetActive(true);
        }

        private void DeactivateInspectCamera(float blendSeconds)
        {
            if (m_inspectCamera == null)
            {
                return;
            }

            SetBlendDuration(blendSeconds);
            m_inspectCamera.gameObject.SetActive(false);
        }

        private void SetBlendDuration(float seconds)
        {
            if (m_brain == null)
            {
                return;
            }

            if (!m_hasStoredBlend)
            {
                m_previousBlend = m_brain.DefaultBlend;
                m_hasStoredBlend = true;
            }

            m_brain.DefaultBlend = new CinemachineBlendDefinition(
                CinemachineBlendDefinition.Styles.EaseInOut, seconds);
        }

        private void FinishInspectCamera()
        {
            if (m_inspectCamera != null)
            {
                m_inspectCamera.transform.localPosition = m_inspectCameraPosition;
                m_inspectCamera.transform.localRotation = m_inspectCameraRotation;
            }

            if (m_brain != null && m_hasStoredBlend)
            {
                m_brain.DefaultBlend = m_previousBlend;
            }

            m_hasStoredBlend = false;
            m_brain = null;
        }

        private void StopInspectCamera()
        {
            if (m_inspectCamera != null)
            {
                m_inspectCamera.gameObject.SetActive(false);
            }

            FinishInspectCamera();
        }

        private static async Awaitable WaitUnscaledAsync(float seconds,
            CancellationToken cancellationToken)
        {
            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.unscaledDeltaTime)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }
        }

        private void SuspendPlayer(bool isSuspended)
        {
            for (int i = 0; i < m_suspendedBehaviours.Length; i++)
            {
                Behaviour behaviour = m_suspendedBehaviours[i];

                if (behaviour == null)
                {
                    continue;
                }

                if (isSuspended)
                {
                    m_suspendedEnabledStates[i] = behaviour.enabled;
                    behaviour.enabled = false;
                }
                else
                {
                    behaviour.enabled = m_suspendedEnabledStates[i];
                }
            }
        }

        private void SetEntryIndicators(int count)
        {
            for (int i = 0; i < m_entryIndicators.Length; i++)
            {
                if (m_entryIndicators[i] != null)
                {
                    m_entryIndicators[i].SetActive(i < count);
                }
            }
        }

        private void SetSolvedRunes(bool isVisible)
        {
            for (int i = 0; i < m_solvedRunes.Length; i++)
            {
                if (m_solvedRunes[i] != null)
                {
                    m_solvedRunes[i].SetActive(isVisible);
                }
            }
        }

        private void SaveCursor()
        {
            m_originCursorLock = Cursor.lockState;
            m_originCursorVisible = Cursor.visible;
        }

        private static void SetCursorForInspect(bool isInteractive)
        {
            Cursor.lockState = isInteractive ? CursorLockMode.None : CursorLockMode.Locked;
            Cursor.visible = isInteractive;
        }

        private void RestoreCursor()
        {
            Cursor.lockState = m_originCursorLock;
            Cursor.visible = m_originCursorVisible;
        }

        private void SetWorldCollider(bool isEnabled)
        {
            if (m_worldCollider != null)
            {
                m_worldCollider.enabled = isEnabled;
            }
        }

        private void PublishPrompt(string prompt)
        {
            if (m_promptChanged != null)
            {
                m_promptChanged.RaiseEvent(prompt);
            }
        }

        private void AbortInspect()
        {
            StopInspectCamera();
            RestoreStowedItem();
            RestoreCursor();
            SuspendPlayer(false);
            SetWorldCollider(true);
            ResetSequence();
            SetEntryIndicators(0);
            SetSolvedRunes(false);
            PublishPrompt(string.Empty);
            m_state = InspectState.Idle;
        }

        private void ResetSequence()
        {
            m_sequence = new RuneKeypadSequence(k_Password);
        }

        private static float Smooth(float t)
        {
            float clamped = Mathf.Clamp01(t);

            return clamped * clamped * (3f - 2f * clamped);
        }
    }
}
