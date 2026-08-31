using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Offers the nearest <see cref="IInteractable"/> within reach and starts it on the confirm
    /// press. The single driver for every <see cref="IInteractable"/> in the game — sheets,
    /// terminals, signs, investigation targets, the rune keypad — so one rule decides what is on
    /// offer and one channel carries the hint. The separate verbs that are not interactables
    /// (scanning, picking up, harvesting, throwing) keep their own triggers and share only the
    /// visibility rule, through <see cref="InteractionVisibility"/>.
    /// <para>
    /// Two conditions, and neither is an aim: the thing is within reach, and any part of it is on
    /// screen. This game draws no crosshair, so an offer the player can only unlock by centring an
    /// invisible point on a collider is an offer they cannot see the rule for. Being near it and
    /// having it in frame is the whole condition — a corner of the bounds inside the frustum counts.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class InteractionProximityTrigger : MonoBehaviour
    {
        private const int k_MaxOverlaps = 32;

        [Header("Wiring")]
        [Tooltip("Measured from here — normally the player root or the head.")]
        [SerializeField] private Transform m_player;

        [Tooltip("Supplies the reach radius and the layers interactables live on.")]
        [SerializeField] private InteractionConfigSO m_config;

        [Tooltip("Decides what counts as on screen. Falls back to the main camera when empty.")]
        [SerializeField] private Camera m_camera;

        [Tooltip("Supplies the interact button. Found on this object or a parent when empty.")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Optional. While a tool performance is running the confirm press is swallowed.")]
        [SerializeField] private ToolUseController m_toolUse;

        [Header("Broadcasts on")]
        [Tooltip("Prompt text for the HUD. An empty string means 'hide the hint'.")]
        [SerializeField] private StringEventChannelSO m_promptChanged;

        private readonly Collider[] m_overlaps = new Collider[k_MaxOverlaps];
        private readonly List<IInteractable> m_candidates = new List<IInteractable>();
        private readonly List<Vector3> m_points = new List<Vector3>();

        private IInteractable m_inReach;
        private string m_lastPrompt = string.Empty;

        /// <summary>The interactable the confirm press would start right now, or null.</summary>
        public IInteractable InReach => m_inReach;

        /// <summary>
        /// The camera the on-screen test uses. Resolved every time it is missing rather than once
        /// in <c>Awake</c>: the camera lives in the bootstrap scene, so a level loaded on its own
        /// runs <c>Awake</c> before it exists, and caching the null there left the in-view half of
        /// the rule permanently switched off.
        /// </summary>
        private Camera ActiveCamera
        {
            get
            {
                if (m_camera == null)
                {
                    m_camera = Camera.main;
                }

                return m_camera;
            }
        }

        private void Awake()
        {
            if (m_input == null)
            {
                m_input = GetComponentInParent<PlayerInputReader>();
            }

            if (m_config == null)
            {
                Log.Error("InteractionProximityTrigger has no InteractionConfigSO.", this);
                enabled = false;
            }
        }

        private void OnDisable()
        {
            m_inReach = null;
            InteractionPrompts.Clear(this, m_promptChanged);
            m_lastPrompt = string.Empty;
        }

        private void Update()
        {
            bool blocked = WorldAccess.IsInteractionLocked || (m_toolUse != null && m_toolUse.IsBusy);

            m_inReach = blocked ? null : FindNearestInRange();

            // The interactable's own line, verbatim — no key prefix wrapped around it. What the
            // sign says is what the player reads.
            Broadcast(m_inReach == null ? string.Empty : m_inReach.PromptText);

            if (m_inReach == null || m_input == null || !m_input.InteractPressedThisFrame)
            {
                return;
            }

            m_inReach.Interact(gameObject);
            Broadcast(string.Empty);
        }

        /// <summary>Nearest interactable that can be started right now, or null.</summary>
        private IInteractable FindNearestInRange()
        {
            Transform origin = m_player == null ? transform : m_player;

            int count = Physics.OverlapSphereNonAlloc(
                origin.position,
                m_config.Range,
                m_overlaps,
                m_config.InteractableLayers,
                m_config.TriggerInteraction);

            m_candidates.Clear();
            m_points.Clear();

            for (int i = 0; i < count; i++)
            {
                Collider collider = m_overlaps[i];
                IInteractable candidate = collider.GetComponentInParent<IInteractable>();

                if (candidate == null || !candidate.CanInteract)
                {
                    continue;
                }

                // Tested against what the player can see of it, not against the interaction
                // collider — that box is often far bigger than the prop, and testing it puts the
                // hint up while the object itself is still off screen.
                if (!InteractionVisibility.IsOnScreen(ActiveCamera, candidate as Component))
                {
                    continue;
                }

                // Distance is measured to the collider that carries the interactable, not to its
                // root: a sign board hangs metres away from the pivot its script sits on, and
                // measuring to the pivot offers the sign from places the board is nowhere near.
                m_candidates.Add(candidate);
                m_points.Add(collider.bounds.center);
            }

            int index = NearestInRange.Index(m_points, origin.position, m_config.Range);

            return index < 0 ? null : m_candidates[index];
        }

        private void Broadcast(string prompt)
        {
            // Through the arbiter, never straight at the channel: several triggers share it, and a
            // private "only send on change" latch would let this one's empty frame wipe another's
            // live hint for good. See <see cref="InteractionPrompts"/>.
            m_lastPrompt = prompt;
            InteractionPrompts.Set(this, m_promptChanged, prompt);
        }
    }
}
