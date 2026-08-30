using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Something the player takes *from* rather than takes away: the algae in the lab corridor is
    /// scraped into the dead torch and the patch stays on the wall, glowing, exactly where it was.
    /// <para>
    /// This is deliberately not a <see cref="GroundPickup"/>. That path moves a
    /// <see cref="CarriedItem"/> into the hand, and <see cref="PickupProximityTrigger"/> refuses to
    /// do so while the hand is full — so an algae pickup would offer "put the torch down first",
    /// which is the exact opposite of what has to happen. Here the hand being full of the right
    /// thing is the *requirement*, and only the grab animation is shared.
    /// </para>
    /// <para>
    /// There is no local "already harvested" bool. Whether this has been taken is
    /// <see cref="FlagOnHarvested"/> in world state, which means a checkpoint reload gets the
    /// answer right for free instead of needing a restore call the way
    /// <see cref="Scanner.ScannableTarget"/> does.
    /// </para>
    /// Points register themselves in a static list rather than being found by a per-frame search,
    /// the same arrangement <see cref="GroundPickup"/> uses and for the same reason (guideline 05).
    /// </summary>
    [DisallowMultipleComponent]
    public class HarvestPoint : MonoBehaviour
    {
        private static readonly List<HarvestPoint> s_active = new List<HarvestPoint>();

        [Tooltip("Name shown in the hint while this is the nearest thing to harvest.")]
        [SerializeField] private string m_displayName = "荧光藻";

        [Tooltip("Where the player is measured to. Empty = this object's own origin.")]
        [SerializeField] private Transform m_reachPoint;

        [Header("Conditions")]
        [Tooltip("On: the hand must already hold an item of the kind below. This is what makes "
            + "the corridor beat readable — you cannot take the algae until you are carrying the "
            + "torch it goes into.")]
        [SerializeField] private bool m_requiresCarriedItem = true;

        [Tooltip("Kind the hand must hold. Only read while the box above is ticked.")]
        [SerializeField] private CarriedKind m_requiredKind = CarriedKind.Torch;

        [Tooltip("Shown instead of the harvest hint when the hand is not holding the right thing. "
            + "Empty stays silent, which is right for anything the player should not know about yet.")]
        [SerializeField] private string m_blockedPrompt = "需要先拿着手电筒";

        [Tooltip("World flag that has to be up before this is offered at all. Empty = always.")]
        [SerializeField] private string m_requiredFlag = string.Empty;

        [Header("Result")]
        [Tooltip("Raised once the grab animation has played through. Also what marks this point "
            + "as spent, so leave it filled unless the point is meant to be endless.")]
        [SerializeField] private string m_flagOnHarvested = WorldFlags.k_FlashlightPowered;

        [Tooltip("On: can be taken again and again. Off: once the flag above is up, no more offer.")]
        [SerializeField] private bool m_repeatable;

        /// <summary>Every enabled harvest point. Do not hold across frames.</summary>
        public static IReadOnlyList<HarvestPoint> Active => s_active;

        public string DisplayName => m_displayName;

        public string BlockedPrompt => m_blockedPrompt;

        public string FlagOnHarvested => m_flagOnHarvested;

        /// <summary>World point the player's distance is measured against.</summary>
        public Vector3 ReachPosition =>
            m_reachPoint == null ? transform.position : m_reachPoint.position;

        /// <summary>
        /// Empties the registry. Called once per play session by
        /// <see cref="RootsDance.App.PlaySessionReset"/>: with domain reload turned off this list
        /// is the same object across sessions, and an entry left behind is a destroyed component
        /// that every later search has to step over.
        /// </summary>
        public static void ResetRegistry()
        {
            s_active.Clear();
        }

        /// <summary>
        /// Whether this is worth offering at all right now — the gate that does not depend on what
        /// the hand holds. False hides it completely: no hint, not even a blocked one.
        /// </summary>
        public bool IsAvailable(IWorldStateReader state)
        {
            if (!string.IsNullOrEmpty(m_requiredFlag) && (state == null || !state.HasFlag(m_requiredFlag)))
            {
                return false;
            }

            if (m_repeatable || string.IsNullOrEmpty(m_flagOnHarvested))
            {
                return true;
            }

            return state == null || !state.HasFlag(m_flagOnHarvested);
        }

        /// <summary>
        /// Whether the hand is carrying what this point needs. Separate from
        /// <see cref="IsAvailable"/> so the trigger can say *why* it is refusing rather than going
        /// quiet — a silent refusal next to a glowing patch of algae reads as a broken game.
        /// </summary>
        public bool AcceptsHand(CarriedItem carried)
        {
            if (!m_requiresCarriedItem)
            {
                return true;
            }

            return carried != null && carried.Kind == m_requiredKind;
        }

        private void OnEnable()
        {
            if (!s_active.Contains(this))
            {
                s_active.Add(this);
            }
        }

        private void OnDisable()
        {
            s_active.Remove(this);
        }
    }
}
