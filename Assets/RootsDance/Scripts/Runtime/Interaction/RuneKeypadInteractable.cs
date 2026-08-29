using System;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The wall-mounted rune lock and its close-up interaction. The physical prop travels to the
    /// camera like an archive page, while the pointer selects real key colliders on the model.
    /// </summary>
    [DisallowMultipleComponent]
    public class RuneKeypadInteractable : MonoBehaviour, IInteractable
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

        [Header("Close-up pose")]
        [Tooltip("Camera-local root pose aligned to the keypad-poke animation's finger contact.")]
        [SerializeField] private Vector3 m_inspectPosition = new Vector3(0.05f, -0.03f, 1.05f);

        [SerializeField] private Vector3 m_inspectEuler = new Vector3(0f, -90f, 0f);

        [Range(0.4f, 1f)]
        [SerializeField] private float m_inspectScale = 0.75f;

        [Tooltip("Camera-local pose that puts the confirm key under keypadPoke's fingertip.")]
        [SerializeField] private Vector3 m_confirmPosition = new Vector3(0.156f, -0.407f, 0.774f);

        [Range(0.4f, 1f)]
        [SerializeField] private float m_confirmScale = 0.7f;

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
        private Transform m_originParent;
        private Scene m_originScene;
        private Vector3 m_originWorldPosition;
        private Quaternion m_originWorldRotation;
        private Vector3 m_originLocalScale;
        private CursorLockMode m_originCursorLock;
        private bool m_originCursorVisible;
        private bool m_isButtonAnimating;
        private string m_waitingActionId;
        private bool m_didActionFinish;

        public string PromptText => m_promptText;

        public bool CanInteract => m_state == InspectState.Idle;

        private void Awake()
        {
            ResetSequence();
            SetEntryIndicators(0);
            SetSolvedRunes(false);
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
                LowerEntryAsync(destroyCancellationToken);
                return;
            }

            if (!m_isButtonAnimating && m_input.ClickPressedThisFrame && m_hoveredButton != null)
            {
                PressButtonEntryAsync(m_hoveredButton, destroyCancellationToken);
            }
        }

        private void OnDisable()
        {
            UnsubscribeFromArms();

            if (m_hoveredButton != null)
            {
                m_hoveredButton.SetHovered(false);
                m_hoveredButton = null;
            }
        }

        public void Interact(GameObject interactor)
        {
            if (m_state != InspectState.Idle || interactor == null)
            {
                return;
            }

            BeginInspectEntryAsync(interactor, destroyCancellationToken);
        }

        /// <summary>Editor construction hook used by the idempotent prefab builder.</summary>
        public void Configure(Collider worldCollider, LayerMask buttonLayers,
            RuneKeypadButton[] buttons, GameObject[] entryIndicators, GameObject[] solvedRunes,
            RuneKeypadButton clearButton, RuneKeypadButton confirmButton,
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

                m_originParent = transform.parent;
                m_originScene = gameObject.scene;
                m_originWorldPosition = transform.position;
                m_originWorldRotation = transform.rotation;
                m_originLocalScale = transform.localScale;

                // Start putting the torch away before the close-up, but do not leave the player
                // staring at an unmoving wall while the arms action runs. The keypad's raise gives
                // immediate feedback and overlaps the first part of the stow animation.
                Awaitable<bool> stowOperation = StowTorchAsync(cancellationToken);
                transform.SetParent(m_camera.transform, true);

                m_state = InspectState.Raising;
                await TweenToInspectPoseAsync(m_raiseSeconds, cancellationToken);

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
                await TweenToOriginAsync(m_lowerSeconds, cancellationToken);

                RestoreOriginTransform();
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

            if (m_input == null || m_camera == null || playerRoot == null)
            {
                Log.Error("Rune keypad could not resolve the player's input or main camera.", this);
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
                return m_armsDirector.LeftPose == ArmsPose.HangLow
                    && m_armsDirector.RightPose == ArmsPose.HangLow;
            }

            CarriedItem carried = m_rightSocket.Carried;

            if (carried.Kind != CarriedKind.Torch)
            {
                PublishPrompt("请先放下手中的物品");
                return false;
            }

            m_stowedItem = carried;
            m_stowedItem.gameObject.SetActive(false);

            // A carried torch can legitimately be present while the arms have already returned to
            // HangLow. In that state the authored drop action's ForearmRaised pose gate refuses the
            // animation. The keypad interaction must still proceed: keep the torch hidden and let
            // RestoreStowedItem put it back when the close-up ends.
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
            await TweenToCameraPoseAsync(
                m_confirmPosition,
                m_confirmScale,
                m_buttonPressSeconds * 2f,
                cancellationToken);

            bool didPlay = await PlayArmsActionAsync(k_KeypadPokeActionId,
                cancellationToken, true);

            if (!didPlay)
            {
                PublishPrompt("手臂动作暂时不可用，请重试");
                await TweenToCameraPoseAsync(
                    m_inspectPosition,
                    m_inspectScale,
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
            RestoreOriginTransform();
            SetWorldCollider(false);
            gameObject.SetActive(false);
        }

        private void RestoreOriginTransform()
        {
            transform.SetParent(m_originParent, true);

            if (m_originParent == null && m_originScene.IsValid() && m_originScene.isLoaded)
            {
                SceneManager.MoveGameObjectToScene(gameObject, m_originScene);
            }

            transform.SetPositionAndRotation(m_originWorldPosition, m_originWorldRotation);
            transform.localScale = m_originLocalScale;
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

        private async Awaitable TweenToInspectPoseAsync(float seconds,
            CancellationToken cancellationToken)
        {
            await TweenToCameraPoseAsync(
                m_inspectPosition,
                m_inspectScale,
                seconds,
                cancellationToken);
        }

        private async Awaitable TweenToCameraPoseAsync(
            Vector3 targetPosition,
            float targetUniformScale,
            float seconds,
            CancellationToken cancellationToken)
        {
            Vector3 fromPosition = transform.localPosition;
            Quaternion fromRotation = transform.localRotation;
            Vector3 fromScale = transform.localScale;
            Quaternion targetRotation = Quaternion.Euler(m_inspectEuler);
            Vector3 targetScale = Vector3.one * targetUniformScale;

            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.unscaledDeltaTime)
            {
                float t = Smooth(elapsed / seconds);
                transform.localPosition = Vector3.Lerp(fromPosition, targetPosition, t);
                transform.localRotation = Quaternion.Slerp(fromRotation, targetRotation, t);
                transform.localScale = Vector3.Lerp(fromScale, targetScale, t);
                await Awaitable.NextFrameAsync(cancellationToken);
            }

            transform.localPosition = targetPosition;
            transform.localRotation = targetRotation;
            transform.localScale = targetScale;
        }

        private async Awaitable TweenToOriginAsync(float seconds,
            CancellationToken cancellationToken)
        {
            Vector3 fromPosition = transform.localPosition;
            Quaternion fromRotation = transform.localRotation;
            Vector3 fromScale = transform.localScale;

            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.unscaledDeltaTime)
            {
                float t = Smooth(elapsed / seconds);
                Vector3 targetPosition = m_camera.transform.InverseTransformPoint(m_originWorldPosition);
                Quaternion targetRotation = Quaternion.Inverse(m_camera.transform.rotation)
                    * m_originWorldRotation;

                transform.localPosition = Vector3.Lerp(fromPosition, targetPosition, t);
                transform.localRotation = Quaternion.Slerp(fromRotation, targetRotation, t);
                transform.localScale = Vector3.Lerp(fromScale, m_originLocalScale, t);
                await Awaitable.NextFrameAsync(cancellationToken);
            }
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
            if (m_camera != null && transform.parent == m_camera.transform)
            {
                RestoreOriginTransform();
            }

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
