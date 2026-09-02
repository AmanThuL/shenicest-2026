using System;
using System.Threading;
using RootsDance.Core;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The keypad's grip on the player: finding the input reader, camera and arms from whoever
    /// interacted, suspending and restoring their look/move/ray components, saving and restoring
    /// the cursor, stowing the torch for the close-up, and running one arms action to completion
    /// with a timeout.
    /// <para>
    /// A plain class built by <see cref="RuneKeypadInteractable"/>; it publishes nothing and shows
    /// nothing — what a stow refusal or a timed-out action means for the interaction is the state
    /// machine's decision.
    /// </para>
    /// </summary>
    public sealed class RuneKeypadPlayerRig
    {
        /// <summary>What became of a stow request; the state machine maps these to prompts.</summary>
        public enum StowResult
        {
            /// <summary>The hand is free; nothing needed stowing.</summary>
            HandsFree = 0,

            /// <summary>The torch is away and the close-up may proceed.</summary>
            Stowed = 1,

            /// <summary>The player carries something that is not the torch; refuse the close-up.</summary>
            Blocked = 2,

            /// <summary>No arms rig was found; refuse the close-up.</summary>
            NoArms = 3
        }

        private const string k_DropActionId = "drop";
        private const string k_HoldActionId = "hold";
        private const float k_ActionTimeoutPaddingSeconds = 0.75f;
        private const float k_MinActionTimeoutSeconds = 1.5f;

        private readonly UnityEngine.Object m_logContext;
        private PlayerInputReader m_input;
        private Camera m_camera;
        private ArmsDirector m_armsDirector;
        private HandSocket m_rightSocket;
        private CarriedItem m_stowedItem;
        private Behaviour[] m_suspendedBehaviours = new Behaviour[0];
        private bool[] m_suspendedEnabledStates = new bool[0];
        private CursorLockMode m_originCursorLock;
        private bool m_originCursorVisible;
        private string m_waitingActionId = string.Empty;
        private bool m_didActionFinish;

        public RuneKeypadPlayerRig(UnityEngine.Object logContext)
        {
            m_logContext = logContext;
        }

        /// <summary>The interactor's input reader, valid after a successful <see cref="TryResolve"/>.</summary>
        public PlayerInputReader Input => m_input;

        /// <summary>The main camera, valid after a successful <see cref="TryResolve"/>.</summary>
        public Camera Camera => m_camera;

        /// <summary>
        /// Finds the player's pieces from the interactor: input, camera, arms, right hand, and the
        /// components to suspend. Returns false (and logs) when the essentials are missing.
        /// </summary>
        public bool TryResolve(GameObject interactor)
        {
            m_input = interactor.GetComponentInParent<PlayerInputReader>();
            m_camera = Camera.main;

            Transform playerRoot = m_input == null ? null : m_input.transform;

            if (m_input == null || m_camera == null || playerRoot == null)
            {
                Log.Error("Rune keypad could not resolve the player's input or main camera.",
                    m_logContext);
                return false;
            }

            m_armsDirector = playerRoot.GetComponentInChildren<ArmsDirector>(true);

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
                playerRoot.GetComponentInChildren<InteractionProximityTrigger>(true)
            };
            m_suspendedEnabledStates = new bool[m_suspendedBehaviours.Length];

            return true;
        }

        /// <summary>Disables the look/move/interaction components, or puts them back how they were.</summary>
        public void Suspend(bool isSuspended)
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

        public void SaveCursor()
        {
            m_originCursorLock = Cursor.lockState;
            m_originCursorVisible = Cursor.visible;
        }

        public void RestoreCursor()
        {
            Cursor.lockState = m_originCursorLock;
            Cursor.visible = m_originCursorVisible;
        }

        /// <summary>Frees the pointer for the panel's keys, or locks it back to the view.</summary>
        public static void SetCursorForInspect(bool isInteractive)
        {
            Cursor.lockState = isInteractive ? CursorLockMode.None : CursorLockMode.Locked;
            Cursor.visible = isInteractive;
        }

        /// <summary>
        /// Puts the torch away for the close-up, playing the drop action. Anything else in the
        /// hand blocks the close-up instead.
        /// </summary>
        public async Awaitable<StowResult> StowTorchAsync(CancellationToken cancellationToken)
        {
            if (m_armsDirector == null)
            {
                Log.Error("Rune keypad requires the player's ArmsDirector.", m_logContext);
                return StowResult.NoArms;
            }

            if (m_rightSocket == null || m_rightSocket.Carried == null)
            {
                return StowResult.HandsFree;
            }

            CarriedItem carried = m_rightSocket.Carried;

            if (carried.Kind != CarriedKind.Torch)
            {
                return StowResult.Blocked;
            }

            m_stowedItem = carried;
            m_stowedItem.gameObject.SetActive(false);

            // The torch stays hidden for the close-up either way; RestoreStowedItem puts it back
            // when it ends.
            await PlayActionAsync(k_DropActionId, cancellationToken, 0f, null);

            return StowResult.Stowed;
        }

        /// <summary>Puts a stowed torch back in the hand and replays the hold pose.</summary>
        public void RestoreStowedItem()
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

        /// <summary>Drops the reference to a stowed item without restoring it (rescue teardown).</summary>
        public void ForgetStowedItem()
        {
            m_stowedItem = null;
        }

        /// <summary>
        /// Plays one arms action and waits for it to report finished, with a timeout derived from
        /// its authored duration. <paramref name="onContact"/>, when given, fires once
        /// <paramref name="contactSeconds"/> into the action — the moment the poke animation
        /// touches the key. Returns false when the action would not play or timed out.
        /// </summary>
        public async Awaitable<bool> PlayActionAsync(string actionId,
            CancellationToken cancellationToken, float contactSeconds, Action onContact)
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
                bool didContact = false;

                while (!m_didActionFinish)
                {
                    elapsed += Time.unscaledDeltaTime;

                    if (elapsed >= timeoutSeconds)
                    {
                        Log.Warning($"Rune keypad arms action '{actionId}' timed out after "
                            + $"{timeoutSeconds:F2} seconds; restoring interaction control.",
                            m_logContext);
                        return false;
                    }

                    if (onContact != null && !didContact && elapsed >= contactSeconds)
                    {
                        didContact = true;
                        onContact();
                    }

                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                return true;
            }
            finally
            {
                UnsubscribeFromArms();
            }
        }

        /// <summary>Detaches from the arms events; safe to call from any teardown path.</summary>
        public void UnsubscribeFromArms()
        {
            if (m_armsDirector != null)
            {
                m_armsDirector.ActionFinished -= OnArmsActionFinished;
            }

            m_waitingActionId = string.Empty;
        }

        private void OnArmsActionFinished(string actionId)
        {
            if (actionId == m_waitingActionId)
            {
                m_didActionFinish = true;
            }
        }
    }
}
