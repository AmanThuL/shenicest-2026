using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Node 00-05. Once contamination drops below the suit threshold the device offers to release
    /// the seal; the player confirms, art plays the removal, and only then is the flag raised.
    /// The whole slice runs without any animation: leave the view empty and removal completes at once.
    /// <para>
    /// Reaching for the seal before then is not ignored — it is refused, in writing, on the visor.
    /// A button that does nothing reads as a broken build; a button that answers "contamination is
    /// above the threshold" teaches the rule the beat is about. The standing hint that follows the
    /// unlock is the other half of the same idea: from there the game will not let the player walk
    /// on (see <c>FlagGate</c>) until the helmet is actually off, so it has to say what it wants.
    /// </para>
    /// </summary>
    public class HelmetController : MonoBehaviour, IRescueStateRestoredParticipant
    {
        [Header("Listens to")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Flag that unlocks removal.")]
        [SerializeField] private string m_unlockFlag = WorldFlags.k_HelmetRemovable;

        [Tooltip("While a conversation is up, the interact button is skipping lines rather than "
            + "reaching for the seal. Data/Events/ConversationStarted.")]
        [SerializeField] private VoidEventChannelSO m_conversationStarted;

        [SerializeField] private VoidEventChannelSO m_conversationEnded;

        [Header("Broadcasts on")]
        [Tooltip("Device notice shown when removal becomes available.")]
        [SerializeField] private StringEventChannelSO m_noticeRequested;

        [TextArea(1, 4)]
        [SerializeField] private string m_noticeText = "外部污染浓度低于防护阈值。可解除环境隔离。";

        [Tooltip("Standing line on the visor, from the unlock until the helmet is off. "
            + "Data/Events/HelmetNotice.")]
        [SerializeField] private StringEventChannelSO m_hintRequested;

        [TextArea(1, 4)]
        [SerializeField] private string m_hintText = "[E] 解除环境隔离";

        [Tooltip("Refusal written on the visor when the seal is pressed too early. "
            + "Data/Events/HelmetWarning.")]
        [SerializeField] private StringEventChannelSO m_warningRequested;

        [TextArea(1, 4)]
        [SerializeField] private string m_warningText = "[ ! ]  外部污染浓度高于防护阈值。环境隔离已锁定。";

        [Header("Wiring")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("World helmet left behind by the removal — a pickup the hand can take again. "
            + "Leave EMPTY whenever the view hands the helmet over itself: HelmetArmsView puts the "
            + "real prop in the right hand at the clip's Attach frame, and a prefab here would put "
            + "a second one on the floor at the player's feet. Only a view that makes the helmet "
            + "vanish wants this filled.")]
        [SerializeField] private GameObject m_droppedHelmetPrefab;

        [Tooltip("Art component implementing IHelmetView. Empty = instant removal (placeholder).")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        private IHelmetView m_view;
        private bool m_isUnlocked;
        private bool m_isRemoving;
        private bool m_isRemoved;
        private bool m_isConversationActive;
        private bool m_checkedInitialState;

        public bool IsRemoved => m_isRemoved;

        private void Awake()
        {
            m_view = m_viewBehaviour as IHelmetView;
        }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }

            if (m_conversationStarted != null)
            {
                m_conversationStarted.EventRaised += OnConversationStarted;
            }

            if (m_conversationEnded != null)
            {
                m_conversationEnded.EventRaised += OnConversationEnded;
            }

            if (m_view != null)
            {
                m_view.RemoveFinished += OnRemoveFinished;
            }
        }

        private void Update()
        {
            RestoreInitialState();

            if (m_isRemoving || m_isRemoved || m_input == null)
            {
                return;
            }

            // The same button skips dialogue. A press that belongs to a line on screen is not a
            // player reaching for their helmet, and answering it with a contamination alarm would
            // be the game shouting at someone who was only turning a page.
            if (m_isConversationActive || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            if (m_isUnlocked)
            {
                BeginRemove();
                return;
            }

            Raise(m_warningRequested, m_warningText);
        }

        private void RestoreInitialState()
        {
            if (m_checkedInitialState)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_checkedInitialState = true;
            m_isUnlocked = state.HasFlag(m_unlockFlag);

            // A snapshot is already-completed history, not another removal performance or notice.
            if (state.HasFlag(WorldFlags.k_HelmetRemoved))
            {
                SetRemovedImmediately();
            }
            else if (m_isUnlocked)
            {
                Raise(m_hintRequested, m_hintText);
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }

            if (m_conversationStarted != null)
            {
                m_conversationStarted.EventRaised -= OnConversationStarted;
            }

            if (m_conversationEnded != null)
            {
                m_conversationEnded.EventRaised -= OnConversationEnded;
            }

            if (m_view != null)
            {
                m_view.RemoveFinished -= OnRemoveFinished;
            }

            m_isConversationActive = false;
        }

        private void OnConversationStarted()
        {
            m_isConversationActive = true;
        }

        private void OnConversationEnded()
        {
            m_isConversationActive = false;
        }

        private void OnFlagRaised(string flagId)
        {
            if (flagId == WorldFlags.k_HelmetRemoved)
            {
                SetRemovedImmediately();
                return;
            }

            if (m_isUnlocked || flagId != m_unlockFlag)
            {
                return;
            }

            m_isUnlocked = true;

            Raise(m_noticeRequested, m_noticeText);

            // Stands on the glass until the helmet is off: the gate ahead is closed until then, so
            // the player must be able to read what the game is waiting for at any moment, not only
            // in the seconds the subtitle was up.
            Raise(m_hintRequested, m_hintText);
        }

        /// <summary>
        /// A dev checkpoint or rescue seeds its flags silently after the one-shot
        /// <see cref="RestoreInitialState"/> has already run and concluded the helmet is still on
        /// — which left the player wearing the helmet at every post-removal node. Seeded history
        /// lands here instead, through the same participant path every other catch-up uses.
        /// </summary>
        public void RestoreAfterRescue(Data.RescueCheckpoint checkpoint)
        {
            bool removed = false;
            bool removable = false;

            for (int i = 0; i < checkpoint.Flags.Count; i++)
            {
                removed |= checkpoint.Flags[i] == WorldFlags.k_HelmetRemoved;
                removable |= checkpoint.Flags[i] == m_unlockFlag;
            }

            if (removed)
            {
                SetRemovedImmediately();
            }
            else if (removable && !m_isRemoved)
            {
                m_isUnlocked = true;
                Raise(m_hintRequested, m_hintText);
            }
        }

        private void SetRemovedImmediately()
        {
            if (m_isRemoved)
            {
                return;
            }

            m_isUnlocked = true;
            m_isRemoving = false;
            m_isRemoved = true;
            m_view?.SetRemovedImmediately();
            Raise(m_noticeRequested, string.Empty);
            Raise(m_hintRequested, string.Empty);
            Raise(m_warningRequested, string.Empty);
        }

        private void BeginRemove()
        {
            m_isRemoving = true;

            if (m_view == null)
            {
                OnRemoveFinished();
                return;
            }

            m_view.PlayRemove();
        }

        private void OnRemoveFinished()
        {
            if (m_isRemoved)
            {
                return;
            }

            m_isRemoved = true;
            m_isRemoving = false;

            Raise(m_noticeRequested, string.Empty);
            Raise(m_hintRequested, string.Empty);
            Raise(m_warningRequested, string.Empty);

            SpawnDroppedHelmet();

            WorldAccess.Enqueue(new RaiseFlagCommand(WorldFlags.k_HelmetRemoved), this);
        }

        /// <summary>
        /// The live removal leaves a real helmet at the player's feet instead of a vanished mesh —
        /// a ground pickup the hand can take again. Seeded checkpoints skip this: they have no
        /// removal spot to speak of, and the nodes past the helmet never needed one lying around.
        /// </summary>
        private void SpawnDroppedHelmet()
        {
            if (m_droppedHelmetPrefab == null)
            {
                return;
            }

            Vector3 probe = transform.position + transform.forward * 0.6f + Vector3.up * 0.5f;
            Vector3 place = probe;

            if (Physics.Raycast(probe, Vector3.down, out RaycastHit hit, 3f,
                    Physics.DefaultRaycastLayers, QueryTriggerInteraction.Ignore))
            {
                place = hit.point;
            }

            Quaternion facing = Quaternion.Euler(0f, transform.eulerAngles.y + 180f, 0f);
            Instantiate(m_droppedHelmetPrefab, place, facing);
        }

        private static void Raise(StringEventChannelSO channel, string text)
        {
            if (channel != null)
            {
                channel.RaiseEvent(text);
            }
        }
    }
}
