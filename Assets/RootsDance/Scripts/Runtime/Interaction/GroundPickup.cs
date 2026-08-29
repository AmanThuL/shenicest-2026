using System.Collections.Generic;
using RootsDance.Core;
using RootsDance.Player.Arms;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Marks a prop lying in the world as something a hand can pick up.
    /// <para>
    /// Pickups register themselves in a static list rather than being found by a per-frame search:
    /// <see cref="PickupProximityTrigger"/> tests the player against every one each frame, and a
    /// <c>FindObjectsByType</c> there would allocate every frame (guideline 05). The same
    /// arrangement <see cref="Scanner.ScannableTarget"/> uses.
    /// </para>
    /// A carried prop takes itself out of the list, so the thing in your hand is never also an
    /// offer on the floor.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(CarriedItem))]
    public class GroundPickup : MonoBehaviour
    {
        private static readonly List<GroundPickup> s_active = new List<GroundPickup>();

        [Tooltip("Name shown in the hint while this is the nearest thing to pick up.")]
        [SerializeField] private string m_displayName = "手电筒";

        [Tooltip("Where the player is measured to. Empty = this object's own origin.")]
        [SerializeField] private Transform m_grabPoint;

        private CarriedItem m_item;
        private bool m_isCarried;

        /// <summary>Every pickup lying in the world. Do not hold across frames.</summary>
        public static IReadOnlyList<GroundPickup> Active => s_active;

        public string DisplayName => m_displayName;

        /// <summary>The item a socket takes hold of.</summary>
        public CarriedItem Item => m_item;

        /// <summary>World point the player's distance is measured against.</summary>
        public Vector3 GrabPosition => m_grabPoint == null ? transform.position : m_grabPoint.position;

        private void Awake()
        {
            m_item = GetComponent<CarriedItem>();

            if (m_item == null)
            {
                Log.Error($"GroundPickup on '{name}' has no CarriedItem; it cannot be picked up.",
                    this);
            }
        }

        private void OnEnable()
        {
            if (!m_isCarried && !s_active.Contains(this))
            {
                s_active.Add(this);
            }
        }

        private void OnDisable()
        {
            s_active.Remove(this);
        }

        /// <summary>Taken into a hand: stop offering itself off the floor.</summary>
        public void EnterCarried()
        {
            m_isCarried = true;
            s_active.Remove(this);
        }

        /// <summary>Put back down: on offer again, wherever it landed.</summary>
        public void ExitCarried()
        {
            m_isCarried = false;

            if (isActiveAndEnabled && !s_active.Contains(this))
            {
                s_active.Add(this);
            }
        }
    }
}
