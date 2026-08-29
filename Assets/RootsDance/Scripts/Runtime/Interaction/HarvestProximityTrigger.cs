using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Offers a <see cref="HarvestPoint"/> and takes from it. The player-side half of the pair, laid
    /// out the same way <see cref="PickupProximityTrigger"/> is: walk within
    /// <see cref="m_range"/>, the hint goes out on the prompt channel, the interact key acts.
    /// <para>
    /// The grab animation is the whole point — the fiction is "reach down, scrape some off, feed it
    /// to the torch", and that is <c>grabGround</c>, the same clip a real pickup plays. Nothing is
    /// attached to the hand: the flag goes up when the action plays through, and the patch stays
    /// where it is. If the arms refuse the action (busy, wrong pose) the flag does not go up and
    /// the offer stands, so a refused animation cannot silently skip the beat.
    /// </para>
    /// <para>
    /// This runs alongside <see cref="PickupProximityTrigger"/> rather than inside it. The two
    /// answer opposite questions about the hand — one needs it empty, one needs it full — and
    /// folding them together would put that contradiction inside a single prompt string.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class HarvestProximityTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The hand whose contents gate the offer. Found on this object or a child when empty.")]
        [SerializeField] private HandSocket m_socket;

        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Supplies the interact button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Plays the grab. Found on this object or a parent when empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Tuning")]
        [Tooltip("Metres. The player must be at least this close for a harvest to be offered.")]
        [Range(0.5f, 20f)]
        [SerializeField] private float m_range = 2.5f;

        [Tooltip("Arms action played while taking. Must be an id in the player's action set.")]
        [SerializeField] private string m_actionId = "grabGround";

        [Tooltip("Hint while a point is in reach and the hand holds the right thing. {0} is its name.")]
        [SerializeField] private string m_promptFormat = "[E] 采集 {0}";

        private readonly List<Vector3> m_points = new List<Vector3>();
        private HarvestPoint m_inReach;
        private HarvestPoint m_taking;
        private string m_lastPrompt = string.Empty;

        /// <summary>The point the interact key would take from right now, or null.</summary>
        public HarvestPoint InReach => m_inReach;

        /// <summary>True while the grab is playing and the flag has not gone up yet.</summary>
        public bool IsTaking => m_taking != null;

        private void Awake()
        {
            if (m_socket == null)
            {
                m_socket = GetComponentInChildren<HandSocket>();
            }

            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }

            if (m_director == null)
            {
                m_director = GetComponentInParent<ArmsDirector>();
            }

            if (m_director == null)
            {
                Log.Error("HarvestProximityTrigger has no ArmsDirector; nothing can be harvested.",
                    this);
                enabled = false;
            }
        }

        private void OnEnable()
        {
            if (m_director != null)
            {
                m_director.ActionFinished += OnActionFinished;
            }
        }

        private void OnDisable()
        {
            if (m_director != null)
            {
                m_director.ActionFinished -= OnActionFinished;
            }

            m_inReach = null;
            m_taking = null;
            Broadcast(string.Empty);
        }

        private void Update()
        {
            if (m_taking != null)
            {
                return;                                  // hands busy; the offer comes back or not
            }

            IWorldStateReader state = WorldAccess.State;
            m_inReach = FindNearestInRange(state);

            if (m_inReach == null)
            {
                Broadcast(string.Empty);
                return;
            }

            CarriedItem carried = m_socket == null ? null : m_socket.Carried;

            if (!m_inReach.AcceptsHand(carried))
            {
                Broadcast(m_inReach.BlockedPrompt);
                return;
            }

            Broadcast(string.Format(m_promptFormat, m_inReach.DisplayName));
            TryTake();
        }

        private void TryTake()
        {
            if (m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            if (!m_director.TryPlay(m_actionId))
            {
                // A refusal, not an error — the arm is mid-action or in the wrong pose. The offer
                // stays up so the next press can land.
                return;
            }

            m_taking = m_inReach;
            m_inReach = null;
            Broadcast(string.Empty);
        }

        private void OnActionFinished(string actionId)
        {
            if (m_taking == null || actionId != m_actionId)
            {
                return;
            }

            HarvestPoint point = m_taking;
            m_taking = null;

            if (!string.IsNullOrEmpty(point.FlagOnHarvested))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(point.FlagOnHarvested), this);
            }

            Log.Info($"HarvestProximityTrigger: harvested '{point.DisplayName}'.", this);
        }

        /// <summary>Nearest offerable point in range, by the same rule the scanner uses.</summary>
        private HarvestPoint FindNearestInRange(IWorldStateReader state)
        {
            Transform origin = m_player == null ? transform : m_player;
            IReadOnlyList<HarvestPoint> active = HarvestPoint.Active;

            m_points.Clear();

            for (int i = 0; i < active.Count; i++)
            {
                // Unavailable points are pushed out of range rather than skipped, so the index the
                // shared rule returns still lines up with the registry.
                m_points.Add(active[i].IsAvailable(state)
                    ? active[i].ReachPosition
                    : origin.position + Vector3.up * (m_range + 1000f));
            }

            int index = NearestInRange.Index(m_points, origin.position, m_range);

            return index < 0 ? null : active[index];
        }

        private void Broadcast(string prompt)
        {
            if (m_promptChanged == null || prompt == m_lastPrompt)
            {
                return;
            }

            m_lastPrompt = prompt;
            m_promptChanged.RaiseEvent(prompt);
        }
    }
}
