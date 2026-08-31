using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using RootsDance.Player;
using RootsDance.Player.Arms;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Decides what the hand is offered, and takes it.
    /// <para>
    /// Picking up is a proximity offer, not an aim: walk within <see cref="m_range"/> of a
    /// <see cref="GroundPickup"/> and the hint goes out on the prompt channel, the same way
    /// <see cref="Scanner.ScannerProximityTrigger"/> offers a scan. Among several in reach the
    /// nearest wins, through the shared <see cref="NearestInRange"/> rule.
    /// </para>
    /// <para>
    /// One hand, one thing. Picking up requires the hand to be empty; while it is full the offer
    /// becomes "drop this first", and the drop key frees the hand. That is a deliberate refusal to
    /// swap in one press — a silent swap loses track of what you were carrying, and a torch is
    /// exactly the thing you do not want to put down by accident in the dark.
    /// </para>
    /// <para>
    /// A pickup that names an arms action is taken by playing it: the prop stays exactly where it
    /// lies until the clip's own Attach frame, and only then jumps into the hand. Whether a prop is
    /// taken that way is the prop's decision, not this component's, because the clip has to match
    /// the thing — the blue flask is lifted with the tube grab, which closes the fingers around a
    /// cylinder. A pickup that names nothing goes straight into the hand, which is what the torch
    /// has always done.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class PickupProximityTrigger : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The hand that picks things up. Found on this object or a child when empty.")]
        [SerializeField] private HandSocket m_socket;

        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Supplies the pick button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Plays the grab for pickups that name one. Found on this object or a parent "
            + "when empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Tooltip("Optional. While that trigger offers a throw, this one keeps quiet: both write "
            + "to the prompt channel below, and both only write when their own text changes, so "
            + "two of them taking turns leaves the loser's string stuck on screen. Found on this "
            + "object when empty.")]
        [SerializeField] private ThrowProximityTrigger m_throwTrigger;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        [Header("Tuning")]
        [Tooltip("Metres. The player must be at least this close for a pick-up to be offered.")]
        [Range(0.5f, 20f)]
        [SerializeField] private float m_range = 3f;

        [Tooltip("Key that puts down what the hand is holding.")]
        [SerializeField] private Key m_dropKey = Key.G;

        [Tooltip("Hint while something is in reach and the hand is empty. {0} is its name.")]
        [SerializeField] private string m_pickPromptFormat = "[E] 拾取 {0}";

        [Tooltip("Hint while the hand is full and nothing else is in reach. {0} is what it holds.")]
        [SerializeField] private string m_dropPromptFormat = "[G] 放下 {0}";

        [Tooltip("Hint while the hand is full and something else is in reach. {0} is the thing "
            + "in reach, {1} is what the hand already holds.")]
        [SerializeField] private string m_swapPromptFormat = "[G] 先放下 {1} 才能拾取 {0}";

        private readonly List<Vector3> m_points = new List<Vector3>();
        private GroundPickup m_inReach;
        private GroundPickup m_held;
        private GroundPickup m_taking;
        private string m_lastPrompt = string.Empty;

        /// <summary>What the pick button would take right now, or null.</summary>
        public GroundPickup InReach => m_inReach;

        /// <summary>What the hand is holding, as a pickup, or null.</summary>
        public GroundPickup Held => m_held;

        /// <summary>True while a grab animation is playing and the hand has not closed yet.</summary>
        public bool IsTaking => m_taking != null;

        public float Range
        {
            get { return m_range; }
            set { m_range = value; }
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

            if (m_throwTrigger == null)
            {
                m_throwTrigger = GetComponent<ThrowProximityTrigger>();
            }

            if (m_socket == null)
            {
                Log.Error("PickupProximityTrigger found no HandSocket; nothing can be picked up.",
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
                return;                                  // the grab is playing; nothing to offer
            }

            // Found even while the hand is full: the hint has to be able to say what you would be
            // picking up if you put down what you are holding.
            m_inReach = FindNearestInRange();

            Offer();

            if (m_socket.IsCarrying)
            {
                TryDrop();
                return;
            }

            TryPick();
        }

        /// <summary>Whether the drop key has already been taught, so the standing hint can stop.</summary>
        private static bool HasLearnedDrop
        {
            get
            {
                IWorldStateReader state = WorldAccess.State;

                // No world state means a level-only Play session with no bootstrap: teach it, since
                // nothing can remember that it was taught.
                return state != null && state.HasFlag(WorldFlags.k_LearnedDrop);
            }
        }

        /// <summary>Puts the right hint on the channel for the state the hand is actually in.</summary>
        private void Offer()
        {
            if (m_throwTrigger != null && m_throwTrigger.HasOfferNow())
            {
                // The rune wall is right there and the hand is full of the thing it wants. "[G]
                // 放下" is true but useless next to it, so this one stands down. It must withdraw
                // its request rather than just skip writing: a request left registered still counts
                // as this trigger wanting the line, and the throw hint never gets it.
                Broadcast(string.Empty);
                return;
            }

            if (!m_socket.IsCarrying)
            {
                Broadcast(m_inReach == null
                    ? string.Empty
                    : string.Format(m_pickPromptFormat, m_inReach.DisplayName));
                return;
            }

            string holding = m_held != null ? m_held.DisplayName : m_socket.Carried.name;

            if (m_inReach != null)
            {
                // Still worth saying every time: this one is not teaching the key, it is explaining
                // why the thing in front of the player cannot be picked up.
                Broadcast(string.Format(m_swapPromptFormat, m_inReach.DisplayName, holding));
                return;
            }

            // "[G] 放下" teaches a key, and a key only needs teaching once. Left up permanently it
            // is on screen for most of the game saying nothing the player does not know, and it
            // crowds out the hints that do carry the level forward.
            Broadcast(HasLearnedDrop
                ? string.Empty
                : string.Format(m_dropPromptFormat, holding));
        }

        private void TryPick()
        {
            // A press while an exclusive interaction is up belongs to that interaction, not here.
            if (WorldAccess.IsInteractionLocked
                || m_inReach == null || m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            CarriedItem item = m_inReach.Item;

            if (item == null)
            {
                return;
            }

            string actionId = m_inReach.PickupActionId;

            if (!string.IsNullOrEmpty(actionId) && m_director != null)
            {
                TakeWithAnimation(actionId, item);
                return;
            }

            m_held = m_inReach;
            m_inReach.EnterCarried();
            m_socket.Attach(item);
            m_inReach = null;

            Log.Info($"PickupProximityTrigger: picked up '{m_held.DisplayName}'.", this);
            Broadcast(string.Empty);
        }

        /// <summary>
        /// Crouches, and lets the clip's own Attach frame close the hand. The prop is queued on the
        /// socket rather than parented now, so it stays on the floor for the reach down — which is
        /// the whole reason to play a clip instead of teleporting it.
        /// </summary>
        private void TakeWithAnimation(string actionId, CarriedItem item)
        {
            m_socket.SetPending(item);

            if (!m_director.TryPlay(actionId))
            {
                // A refusal, not an error — the arm is still mid-action. Take the queued item back
                // off the socket so a later, unrelated Attach frame cannot pick it up by surprise.
                m_socket.SetPending(null);
                return;
            }

            m_taking = m_inReach;
            m_held = m_inReach;

            // Off the floor registry now rather than at the Attach frame: for the second and a half
            // the arm is reaching down, this must not still be offered to anyone.
            m_inReach.EnterCarried();
            m_inReach = null;
            Broadcast(string.Empty);
        }

        private void OnActionFinished(string actionId)
        {
            if (m_taking == null || actionId != m_taking.PickupActionId)
            {
                return;
            }

            GroundPickup taken = m_taking;
            m_taking = null;

            if (m_socket.IsCarrying)
            {
                Log.Info($"PickupProximityTrigger: picked up '{taken.DisplayName}'.", this);
                return;
            }

            // The clip played through without its Attach frame ever firing. Put the prop back on
            // offer rather than leaving it in limbo — off the floor list and not in the hand.
            Log.Warning($"'{actionId}' finished without an Attach event; '{taken.DisplayName}' is "
                + "back on the floor.", this);
            m_socket.SetPending(null);
            taken.ExitCarried();
            m_held = null;
        }

        private void TryDrop()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null || !keyboard[m_dropKey].wasPressedThisFrame)
            {
                return;
            }

            CarriedItem dropped = m_socket.Detach();

            if (dropped == null)
            {
                return;
            }

            // The key has now been used, so the standing hint has done its job.
            if (!HasLearnedDrop)
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(WorldFlags.k_LearnedDrop), this);
            }

            if (m_held != null)
            {
                m_held.ExitCarried();
                Log.Info($"PickupProximityTrigger: dropped '{m_held.DisplayName}'.", this);
                m_held = null;
                return;
            }

            // Something else put an item in this hand — the helmet, say. It goes back on offer
            // only if it was ever a pickup to begin with.
            GroundPickup pickup = dropped.GetComponent<GroundPickup>();

            if (pickup != null)
            {
                pickup.ExitCarried();
            }
        }

        /// <summary>Nearest pickup in range, by the same rule the scanner uses.</summary>
        private GroundPickup FindNearestInRange()
        {
            Transform origin = m_player == null ? transform : m_player;
            IReadOnlyList<GroundPickup> active = GroundPickup.Active;

            m_points.Clear();

            for (int i = 0; i < active.Count; i++)
            {
                // Off-screen counts as out of reach, the same rule every other offer uses.
                bool offered = active[i] != null && InteractionVisibility.IsOnScreen(active[i]);

                m_points.Add(offered ? active[i].GrabPosition : Vector3Far());
            }

            int index = NearestInRange.Index(m_points, origin.position, m_range);

            return index < 0 ? null : active[index];
        }

        /// <summary>A point no range can reach, standing in for a destroyed entry.</summary>
        private static Vector3 Vector3Far()
        {
            return new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
        }

        /// <summary>Only raises the channel when the text actually changes.</summary>
        private void Broadcast(string prompt)
        {
            // Through the arbiter, never straight at the channel: several triggers share it, and a
            // private "only send on change" latch would let this one's empty frame wipe another's
            // live hint for good. See <see cref="RootsDance.Interaction.InteractionPrompts"/>.
            m_lastPrompt = prompt;
            RootsDance.Interaction.InteractionPrompts.Set(this, m_promptChanged, prompt);
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(1f, 0.8f, 0.2f, 0.5f);
            Gizmos.DrawWireSphere((m_player == null ? transform : m_player).position, m_range);
        }
    }
}
