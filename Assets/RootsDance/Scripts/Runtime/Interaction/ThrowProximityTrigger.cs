using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Offers a <see cref="ThrowTarget"/> and throws at it. The player-side half of the pair, laid
    /// out the same way <see cref="HarvestProximityTrigger"/> is: walk within range, the hint goes
    /// out on the prompt channel, the interact key acts.
    /// <para>
    /// The prop leaves the hand on the throw clip's own release frame, not on the key press. That
    /// is the whole reason this waits on <see cref="ArmsDirector.HandEventRaised"/> instead of
    /// launching the flask itself: the arm is mid-swing for a third of a second after the press,
    /// and a prop that departs at the press flies out of a hand that has not moved yet.
    /// </para>
    /// <para>
    /// This runs alongside <see cref="PickupProximityTrigger"/> rather than inside it, for the
    /// same reason the harvest trigger does — the two answer opposite questions about the hand.
    /// They do share one prompt channel, though, and two components taking turns writing to it
    /// leaves whichever wrote last on screen forever. So the pickup trigger asks this one whether
    /// it has an offer and stays quiet when it has; see <see cref="HasOfferNow"/>.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ThrowProximityTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The hand the prop leaves. Found on this object or a child when empty.")]
        [SerializeField] private HandSocket m_socket;

        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Supplies the interact button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Plays the throw. Found on this object or a parent when empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Tuning")]
        [Tooltip("Metres. The player must be at least this close for a throw to be offered.")]
        [Range(0.5f, 30f)]
        [SerializeField] private float m_range = 8f;

        [Tooltip("Arms action played to throw. Must be an id in the player's action set.")]
        [SerializeField] private string m_actionId = "throw";

        private readonly List<Vector3> m_points = new List<Vector3>();
        private ThrowTarget m_inReach;
        private ThrowTarget m_throwingAt;
        private CarriedItem m_thrown;
        private string m_lastPrompt = string.Empty;

        /// <summary>The target the interact key would throw at right now, or null.</summary>
        public ThrowTarget InReach => m_inReach;

        /// <summary>True from the key press until the throw animation has played through.</summary>
        public bool IsThrowing => m_throwingAt != null;

        public float Range
        {
            get { return m_range; }
            set { m_range = value; }
        }

        /// <summary>
        /// Whether a throw is on offer this instant, re-measured rather than read off last frame's
        /// answer. <see cref="PickupProximityTrigger"/> calls this before writing its own hint, and
        /// a stale answer there is not a flicker but a stuck prompt: both components only raise the
        /// channel when their own text changes, so one wrong frame leaves the loser's string on
        /// screen with nobody left to overwrite it.
        /// </summary>
        public bool HasOfferNow()
        {
            return m_throwingAt != null || !string.IsNullOrEmpty(ComputePrompt(out ThrowTarget _));
        }

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
                Log.Error("ThrowProximityTrigger has no ArmsDirector; nothing can be thrown.", this);
                enabled = false;
            }
        }

        private void OnEnable()
        {
            if (m_director != null)
            {
                m_director.ActionFinished += OnActionFinished;
                m_director.HandEventRaised += OnHandEvent;
            }
        }

        private void OnDisable()
        {
            if (m_director != null)
            {
                m_director.ActionFinished -= OnActionFinished;
                m_director.HandEventRaised -= OnHandEvent;
            }

            m_inReach = null;
            m_throwingAt = null;
            m_thrown = null;
            Broadcast(string.Empty);
        }

        private void Update()
        {
            if (m_throwingAt != null)
            {
                return;                                  // arm is mid-swing; the offer comes back or not
            }

            Broadcast(ComputePrompt(out m_inReach));

            if (m_inReach != null)
            {
                TryThrow(m_socket == null ? null : m_socket.Carried);
            }
        }

        /// <summary>
        /// This frame's hint, and the target the interact key would act on. The two are worked out
        /// together because they disagree: a target whose conditions are not met still writes a
        /// hint (that is what <see cref="ThrowTarget.BlockedPrompt"/> is for) but must not be
        /// throwable, so <paramref name="actionable"/> comes back null while the string does not.
        /// </summary>
        private string ComputePrompt(out ThrowTarget actionable)
        {
            actionable = null;

            ThrowTarget target = FindNearestInRange(WorldAccess.State);

            if (target == null)
            {
                return string.Empty;
            }

            CarriedItem carried = m_socket == null ? null : m_socket.Carried;

            if (!target.AcceptsHand(carried))
            {
                return target.BlockedPrompt;
            }

            actionable = target;

            return string.Format(target.PromptFormat, DisplayName(carried));
        }

        private void TryThrow(CarriedItem carried)
        {
            // A press while an exclusive interaction is up belongs to that interaction, not here.
            if (WorldAccess.IsInteractionLocked
                || m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            if (!m_director.TryPlay(m_actionId))
            {
                // A refusal, not an error — the arm is still mid-action. The offer stays up so the
                // next press can land.
                return;
            }

            m_throwingAt = m_inReach;
            m_thrown = carried;
            m_inReach = null;
            Broadcast(string.Empty);
        }

        /// <summary>
        /// The release frame. The director has already emptied the socket by the time this runs —
        /// it detaches first and raises second — which is why the prop was remembered at the press.
        /// </summary>
        private void OnHandEvent(HandSide hand, HandEventKind kind)
        {
            if (m_throwingAt == null || m_thrown == null
                || hand != HandSide.Right || kind != HandEventKind.Detach)
            {
                return;
            }

            ThrownItemFlight flight = m_thrown.GetComponent<ThrownItemFlight>();

            if (flight == null)
            {
                // Added rather than refused: without a flight the prop falls at the player's feet
                // and the target is never struck, which reads as a broken game rather than as a
                // missing component. The defaults are the same ones the prefab would carry.
                Log.Warning($"'{m_thrown.name}' has no ThrownItemFlight; adding one so the throw "
                    + "still lands. Put it on the prefab to tune the arc.", this);
                flight = m_thrown.gameObject.AddComponent<ThrownItemFlight>();
            }

            flight.Launch(m_throwingAt);
            m_thrown = null;
        }

        private void OnActionFinished(string actionId)
        {
            if (m_throwingAt == null || actionId != m_actionId)
            {
                return;
            }

            m_throwingAt = null;

            // Only if the release frame never came — a clip edited down past its own event, say.
            // The prop is already out of the hand and out of the registry, so leaving it lying in
            // mid-air is the one outcome with no way back.
            if (m_thrown != null)
            {
                Log.Warning($"Throw '{actionId}' finished without a Detach event; releasing "
                    + $"'{m_thrown.name}' at the end of the clip instead.", this);
                OnHandEvent(HandSide.Right, HandEventKind.Detach);
                m_thrown = null;
            }
        }

        /// <summary>Nearest offerable target in range, by the same rule the scanner uses.</summary>
        private ThrowTarget FindNearestInRange(IWorldStateReader state)
        {
            Transform origin = m_player == null ? transform : m_player;
            IReadOnlyList<ThrowTarget> active = ThrowTarget.Active;

            m_points.Clear();

            for (int i = 0; i < active.Count; i++)
            {
                // Unavailable targets are pushed out of range rather than skipped, so the index the
                // shared rule returns still lines up with the registry. Off screen is unavailable:
                // the same near-and-on-screen rule every other offer in the game uses, and you
                // cannot throw at something you are not looking at.
                bool offered = active[i] != null && active[i].IsAvailable(state)
                    && InteractionVisibility.IsOnScreen(active[i]);

                m_points.Add(offered
                    ? active[i].ReachPosition
                    : origin.position + Vector3.up * (m_range + 1000f));
            }

            int index = NearestInRange.Index(m_points, origin.position, m_range);

            return index < 0 ? null : active[index];
        }

        /// <summary>What the hint calls the thing in the hand.</summary>
        private static string DisplayName(CarriedItem carried)
        {
            if (carried == null)
            {
                return string.Empty;
            }

            GroundPickup pickup = carried.GetComponent<GroundPickup>();

            return pickup != null ? pickup.DisplayName : carried.name;
        }

        private void Broadcast(string prompt)
        {
            // Through the arbiter, never straight at the channel: several triggers share it, and a
            // private "only send on change" latch would let this one's empty frame wipe another's
            // live hint for good. See <see cref="RootsDance.Interaction.InteractionPrompts"/>.
            m_lastPrompt = prompt;
            InteractionPrompts.Set(this, m_promptChanged, prompt,
                InteractionPrompts.k_ThrowPriority);
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(0.2f, 0.6f, 1f, 0.5f);
            Gizmos.DrawWireSphere((m_player == null ? transform : m_player).position, m_range);
        }
    }
}
