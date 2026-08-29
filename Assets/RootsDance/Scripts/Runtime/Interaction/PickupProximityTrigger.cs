using System.Collections.Generic;
using RootsDance.Core;
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
        private string m_lastPrompt = string.Empty;

        /// <summary>What the pick button would take right now, or null.</summary>
        public GroundPickup InReach => m_inReach;

        /// <summary>What the hand is holding, as a pickup, or null.</summary>
        public GroundPickup Held => m_held;

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

            if (m_socket == null)
            {
                Log.Error("PickupProximityTrigger found no HandSocket; nothing can be picked up.",
                    this);
                enabled = false;
            }
        }

        private void OnDisable()
        {
            m_inReach = null;
            Broadcast(string.Empty);
        }

        private void Update()
        {
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

        /// <summary>Puts the right hint on the channel for the state the hand is actually in.</summary>
        private void Offer()
        {
            if (!m_socket.IsCarrying)
            {
                Broadcast(m_inReach == null
                    ? string.Empty
                    : string.Format(m_pickPromptFormat, m_inReach.DisplayName));
                return;
            }

            string holding = m_held != null ? m_held.DisplayName : m_socket.Carried.name;

            Broadcast(m_inReach == null
                ? string.Format(m_dropPromptFormat, holding)
                : string.Format(m_swapPromptFormat, m_inReach.DisplayName, holding));
        }

        private void TryPick()
        {
            if (m_inReach == null || m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            CarriedItem item = m_inReach.Item;

            if (item == null)
            {
                return;
            }

            m_held = m_inReach;
            m_inReach.EnterCarried();
            m_socket.Attach(item);
            m_inReach = null;

            Log.Info($"PickupProximityTrigger: picked up '{m_held.DisplayName}'.", this);
            Broadcast(string.Empty);
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
                m_points.Add(active[i] == null ? Vector3Far() : active[i].GrabPosition);
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
            if (m_promptChanged == null || prompt == m_lastPrompt)
            {
                return;
            }

            m_lastPrompt = prompt;
            m_promptChanged.RaiseEvent(prompt);
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(1f, 0.8f, 0.2f, 0.5f);
            Gizmos.DrawWireSphere((m_player == null ? transform : m_player).position, m_range);
        }
    }
}
