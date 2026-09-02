using System;
using System.Threading;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The wall-mounted rune lock's state machine. What the close-up is made of lives in three
    /// collaborators, each with one job: <see cref="RuneKeypadCameraRig"/> flies the fixed camera,
    /// <see cref="RuneKeypadPanelView"/> shows the panel, <see cref="RuneKeypadPlayerRig"/> holds
    /// the player (input, cursor, suspended components, torch, arms actions). This facade owns the
    /// serialized wiring, the sequence, the prompts and the order things happen in — nothing else.
    /// </summary>
    [DisallowMultipleComponent]
    public class RuneKeypadInteractable : MonoBehaviour, IInteractable, IRescueResetParticipant
    {
        private const string k_KeypadPokeActionId = "keypadPoke";
        private const float k_ConfirmContactSeconds = 0.84f;
        private const string k_ReadingPrompt = "[鼠标] 选择符文  [左键] 输入  [E] 退出";

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
        private RuneKeypadCameraRig m_cameraRig;
        private RuneKeypadPanelView m_panel;
        private RuneKeypadPlayerRig m_playerRig;
        private bool m_isButtonAnimating;
        private CancellationTokenSource m_inspectionCancellation;

        public string PromptText => m_promptText;

        public bool CanInteract => m_state == InspectState.Idle;

        private void Awake()
        {
            m_cameraRig = new RuneKeypadCameraRig(m_inspectCamera, m_activeCameraPriority);
            m_panel = new RuneKeypadPanelView(m_entryIndicators, m_solvedRunes,
                m_clearButton, m_confirmButton, m_buttonLayers);
            m_playerRig = new RuneKeypadPlayerRig(this);

            ResetSequence();
            m_panel.SetEntryIndicators(0);
            m_panel.SetSolvedRunes(false);
        }

        private void Update()
        {
            if (m_state != InspectState.Idle)
            {
                RootsDance.Rendering.CloseUpFocus.HoldThisFrame();
            }

            if (m_state != InspectState.Reading || m_playerRig.Input == null)
            {
                return;
            }

            RuneKeypadButton hovered = m_panel.UpdateHover(
                m_playerRig.Camera, m_playerRig.Input.PointerPosition);

            if (m_playerRig.Input.InteractPressedThisFrame)
            {
                LowerEntryAsync(m_inspectionCancellation.Token);
                return;
            }

            if (!m_isButtonAnimating && m_playerRig.Input.ClickPressedThisFrame && hovered != null)
            {
                PressButtonEntryAsync(hovered, m_inspectionCancellation.Token);
            }
        }

        private void OnDisable()
        {
            if (m_playerRig != null)
            {
                m_playerRig.UnsubscribeFromArms();
            }

            if (m_cameraRig != null)
            {
                m_cameraRig.Stop();
            }

            if (m_panel != null)
            {
                m_panel.ClearHover();
            }
        }

        private void OnDestroy()
        {
            CancelInspection();
            WorldAccess.EndExclusiveInteraction(this);
        }

        public void Interact(GameObject interactor)
        {
            if (m_state != InspectState.Idle || interactor == null)
            {
                return;
            }

            if (!WorldAccess.TryBeginExclusiveInteraction(this))
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

            m_playerRig?.UnsubscribeFromArms();
            m_panel?.ClearHover();
            m_cameraRig?.Stop();

            // The outgoing player will be unloaded. Do not play a return animation or change the
            // cursor here: the rescue modal owns input and the camera until loading finishes.
            m_playerRig?.ForgetStowedItem();
            m_isButtonAnimating = false;
            m_state = InspectState.Idle;
            WorldAccess.EndExclusiveInteraction(this);
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

                if (m_inspectCamera == null)
                {
                    Log.Error("Rune keypad has no fixed inspect camera.", this);
                    m_state = InspectState.Idle;
                    WorldAccess.EndExclusiveInteraction(this);
                    return;
                }

                if (!m_playerRig.TryResolve(interactor))
                {
                    m_state = InspectState.Idle;
                    WorldAccess.EndExclusiveInteraction(this);
                    return;
                }

                m_playerRig.Suspend(true);
                m_playerRig.SaveCursor();
                RuneKeypadPlayerRig.SetCursorForInspect(false);
                SetWorldCollider(false);

                // Start putting the torch away before the close-up, but do not leave the player
                // waiting on an unmoving view while the arms action runs. The camera blend gives
                // immediate feedback and overlaps the first part of the stow animation.
                Awaitable<RuneKeypadPlayerRig.StowResult> stowOperation =
                    m_playerRig.StowTorchAsync(cancellationToken);

                m_state = InspectState.Raising;
                m_cameraRig.Activate(m_raiseSeconds);
                await WaitUnscaledAsync(m_raiseSeconds, cancellationToken);

                RuneKeypadPlayerRig.StowResult stowed = await stowOperation;

                if (stowed != RuneKeypadPlayerRig.StowResult.Stowed
                    && stowed != RuneKeypadPlayerRig.StowResult.HandsFree)
                {
                    AbortInspect();

                    // After the abort, or its empty-prompt publish would wipe the explanation.
                    if (stowed == RuneKeypadPlayerRig.StowResult.Blocked)
                    {
                        PublishPrompt("[G] 先放下手中的物品");
                    }

                    return;
                }

                m_state = InspectState.Reading;
                RuneKeypadPlayerRig.SetCursorForInspect(true);
                PublishPrompt(k_ReadingPrompt);
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
                RuneKeypadPlayerRig.SetCursorForInspect(false);
                m_panel.ClearHover();
                PublishPrompt(string.Empty);
                m_cameraRig.Deactivate(m_lowerSeconds);
                await WaitUnscaledAsync(m_lowerSeconds, cancellationToken);

                m_cameraRig.Finish();
                m_playerRig.RestoreStowedItem();
                m_playerRig.RestoreCursor();
                m_playerRig.Suspend(false);
                SetWorldCollider(true);
                ResetSequence();
                m_panel.SetEntryIndicators(0);
                m_panel.SetSolvedRunes(false);
                m_state = InspectState.Idle;
                WorldAccess.EndExclusiveInteraction(this);
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
                    m_panel.SetEntryIndicators(0);
                    m_isButtonAnimating = false;
                    return;
                }

                if (button.Kind == RuneKeypadButton.ButtonKind.Confirm)
                {
                    m_sequence.Clear();
                    m_panel.SetEntryIndicators(0);
                    m_state = InspectState.ShowingError;
                    await ShowErrorAsync(cancellationToken);
                    m_state = InspectState.Reading;
                    m_isButtonAnimating = false;
                    return;
                }

                RuneKeypadInputResult result = m_sequence.Enter(button.Symbol);
                m_panel.SetEntryIndicators(m_sequence.EnteredCount);

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
                    m_panel.SetSolvedRunes(true);
                    m_panel.ClearHover();
                    RuneKeypadPlayerRig.SetCursorForInspect(false);
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

        private async Awaitable ConfirmAndTransitionAsync(CancellationToken cancellationToken)
        {
            PublishPrompt("密码正确");
            await m_cameraRig.TweenToAsync(
                m_confirmCameraPosition,
                Quaternion.Euler(m_confirmCameraEuler),
                m_buttonPressSeconds * 2f,
                cancellationToken);

            bool didPlay;

            try
            {
                didPlay = await m_playerRig.PlayActionAsync(k_KeypadPokeActionId,
                    cancellationToken, k_ConfirmContactSeconds,
                    () => m_panel.SetConfirmContact(true));
            }
            finally
            {
                m_panel.SetConfirmContact(false);
            }

            if (!didPlay)
            {
                PublishPrompt("手臂动作暂时不可用，请重试");
                await m_cameraRig.TweenHomeAsync(m_buttonPressSeconds * 2f, cancellationToken);
                ResetSequence();
                m_panel.SetEntryIndicators(0);
                m_panel.SetSolvedRunes(false);
                RuneKeypadPlayerRig.SetCursorForInspect(true);
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
            m_panel.ClearHover();
            RuneKeypadPlayerRig.SetCursorForInspect(false);
            m_cameraRig.Stop();
            SetWorldCollider(false);
            gameObject.SetActive(false);
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
            m_panel.SetEntryIndicators(0);
            PublishPrompt("密码错误");
            m_panel.SetErrorFeedback(true);
            await WaitUnscaledAsync(m_errorSeconds, cancellationToken);
            m_panel.SetErrorFeedback(false);
            PublishPrompt(k_ReadingPrompt);
        }

        private static async Awaitable WaitUnscaledAsync(float seconds,
            CancellationToken cancellationToken)
        {
            for (float elapsed = 0f; elapsed < seconds; elapsed += Time.unscaledDeltaTime)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }
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
            m_cameraRig.Stop();
            m_playerRig.RestoreStowedItem();
            m_playerRig.RestoreCursor();
            m_playerRig.Suspend(false);
            SetWorldCollider(true);
            ResetSequence();
            m_panel.SetEntryIndicators(0);
            m_panel.SetSolvedRunes(false);
            PublishPrompt(string.Empty);
            m_state = InspectState.Idle;
            WorldAccess.EndExclusiveInteraction(this);
        }

        private void ResetSequence()
        {
            m_sequence = new RuneKeypadSequence(k_Password);
        }
    }
}
