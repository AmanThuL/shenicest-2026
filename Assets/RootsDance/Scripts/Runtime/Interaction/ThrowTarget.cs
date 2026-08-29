using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.App;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Environment;
using RootsDance.Player.Arms;
using UnityEngine;
using UnityEngine.Events;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Something the player throws a carried prop at, and what happens when it lands: the rune
    /// wall on the Briggs exit door, which the blue flask is broken against.
    /// <para>
    /// This is the third shape of proximity offer in the game, next to <see cref="GroundPickup"/>
    /// ("your hand is empty, take this") and <see cref="HarvestPoint"/> ("your hand is full of the
    /// right thing, scrape some off"). What makes it its own component rather than a flavour of
    /// either is where the prop ends up: a throw is the only interaction that consumes what the
    /// hand was holding, and the only one whose result plays out somewhere other than where the
    /// player is standing.
    /// </para>
    /// <para>
    /// The target owns the whole consequence — the sound, the shards, the flag, the door — rather
    /// than spreading it across the thrower and the prop. The prop is glass and the arm is an
    /// animation; neither of them knows that this particular wall opens a door, and the throw
    /// works the same whether it is answered by a door, a cutscene or nothing at all.
    /// </para>
    /// Targets register themselves in a static list rather than being found by a per-frame search,
    /// the same arrangement <see cref="GroundPickup"/> uses and for the same reason (guideline 05).
    /// </summary>
    [DisallowMultipleComponent]
    public class ThrowTarget : MonoBehaviour
    {
        private static readonly List<ThrowTarget> s_active = new List<ThrowTarget>();

        [Tooltip("Where the thrown prop is aimed, and where it breaks. Empty = this object's own "
            + "origin. On the exit door this sits on the face of the rune inlay, not at the "
            + "door's pivot on the floor.")]
        [SerializeField] private Transform m_impactPoint;

        [Tooltip("Where the player is measured to. Empty = the impact point.")]
        [SerializeField] private Transform m_reachPoint;

        [Header("Conditions")]
        [Tooltip("On: the hand must hold an item of the kind below. Off: anything in the hand "
            + "will do.")]
        [SerializeField] private bool m_requiresCarriedItem = true;

        [Tooltip("Kind the hand must hold. Only read while the box above is ticked.")]
        [SerializeField] private CarriedKind m_requiredKind = CarriedKind.Flask;

        [Tooltip("World flag that has to be up before this is offered at all. Empty = always.")]
        [SerializeField] private string m_requiredFlag = string.Empty;

        [Tooltip("Hint while the target is in reach and the hand holds the right thing. {0} is "
            + "what the hand is holding.")]
        [SerializeField] private string m_promptFormat = "[E] 将{0}砸向符文";

        [Tooltip("Shown instead of the hint when the hand is not holding the right thing. Empty "
            + "stays silent, which is right while the player has no reason to know about this.")]
        [SerializeField] private string m_blockedPrompt = string.Empty;

        [Header("Result")]
        [Tooltip("Raised once the prop has broken here. Also what marks this target as spent, so "
            + "leave it filled unless the target is meant to take throw after throw.")]
        [SerializeField] private string m_flagOnShattered = WorldFlags.k_BriggsExitRuneBroken;

        [Tooltip("On: takes throw after throw. Off: once the flag above is up, no more offer.")]
        [SerializeField] private bool m_repeatable;

        [Tooltip("The break. Played at the impact point.")]
        [SerializeField] private AudioCueSO m_shatterCue;

        [Tooltip("The channel the one-shot director listens to. Data/Events/AudioCueRequested.")]
        [SerializeField] private AudioCueEventChannelSO m_audioChannel;

        [Tooltip("Optional shards/splash spawned at the impact point. Destroyed after the "
            + "lifetime below.")]
        [SerializeField] private GameObject m_shatterEffect;

        [Min(0f)]
        [Tooltip("Seconds before the spawned effect is destroyed.")]
        [SerializeField] private float m_effectLifetimeSeconds = 4f;

        [Header("Scene change")]
        [Tooltip("Unlocked when something breaks here — the exit door. Optional.")]
        [SerializeField] private AutomaticSlidingDoor m_door;

        [Min(0f)]
        [Tooltip("Seconds between the break and the door answering, so the two read as cause and "
            + "effect rather than as one event.")]
        [SerializeField] private float m_openDelaySeconds = 0.45f;

        [Tooltip("Anything else the break sets off.")]
        [SerializeField] private UnityEvent m_shattered = new UnityEvent();

        private bool m_hasRestoredDoor;

        /// <summary>Every enabled throw target. Do not hold across frames.</summary>
        public static IReadOnlyList<ThrowTarget> Active => s_active;

        /// <summary>Hint format; {0} is the name of whatever the hand is holding.</summary>
        public string PromptFormat => m_promptFormat;

        public string BlockedPrompt => m_blockedPrompt;

        /// <summary>World point the prop is thrown at, and where it breaks.</summary>
        public Vector3 ImpactPosition =>
            m_impactPoint == null ? transform.position : m_impactPoint.position;

        /// <summary>World point the player's distance is measured against.</summary>
        public Vector3 ReachPosition =>
            m_reachPoint == null ? ImpactPosition : m_reachPoint.position;

        /// <summary>
        /// Empties the registry. Called once per play session by <see cref="PlaySessionReset"/>:
        /// with domain reload turned off this list is the same object across sessions, and an
        /// entry left behind is a destroyed component every later search has to step over.
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

            if (m_repeatable || string.IsNullOrEmpty(m_flagOnShattered))
            {
                return true;
            }

            return state == null || !state.HasFlag(m_flagOnShattered);
        }

        /// <summary>
        /// Whether the hand is carrying what this target accepts. Separate from
        /// <see cref="IsAvailable"/> so the trigger can say <em>why</em> it is refusing instead of
        /// going quiet in front of a wall the player is clearly meant to do something with.
        /// </summary>
        public bool AcceptsHand(CarriedItem carried)
        {
            if (!m_requiresCarriedItem)
            {
                return carried != null;
            }

            return carried != null && carried.Kind == m_requiredKind;
        }

        /// <summary>
        /// Breaks <paramref name="thrown"/> here: sound, shards, flag, then the door. Called by
        /// <see cref="ThrownItemFlight"/> when the arc lands, never by the thrower — whoever
        /// launched the prop is long since back at the neutral pose by the time it arrives.
        /// </summary>
        public void Shatter(GameObject thrown)
        {
            Vector3 point = ImpactPosition;

            if (m_shatterCue != null && m_audioChannel != null)
            {
                m_audioChannel.RaiseEvent(new AudioCueRequest(m_shatterCue, point));
            }

            if (m_shatterEffect != null)
            {
                GameObject effect = Instantiate(m_shatterEffect, point, transform.rotation);

                if (m_effectLifetimeSeconds > 0f)
                {
                    Destroy(effect, m_effectLifetimeSeconds);
                }
            }

            if (thrown != null)
            {
                // Destroyed rather than hidden: the flask is gone, and a disabled prop left in the
                // scene is one a later checkpoint reload would have to remember to keep hidden.
                Destroy(thrown);
            }

            if (!string.IsNullOrEmpty(m_flagOnShattered))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(m_flagOnShattered), this);
            }

            m_shattered.Invoke();

            Log.Info($"ThrowTarget '{name}': something broke against it.", this);

            OpenDoorEntryAsync(destroyCancellationToken);
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

        private void Update()
        {
            // The door is unlocked by the throw, but a session that starts from a checkpoint past
            // this beat never sees the throw. World state is the source of truth for both, so the
            // door catches up from the flag once the bootstrap has arrived — which is why this is
            // in Update and not in Start (WorldAccess is a frame late in a level-only Play).
            if (m_hasRestoredDoor || m_door == null || string.IsNullOrEmpty(m_flagOnShattered))
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_hasRestoredDoor = true;

            if (state.HasFlag(m_flagOnShattered))
            {
                m_door.Unlock();
            }
        }

        private async void OpenDoorEntryAsync(CancellationToken cancellationToken)
        {
            if (m_door == null)
            {
                return;
            }

            // Whatever happens next, Update must not also unlock it a frame later off the flag.
            m_hasRestoredDoor = true;

            try
            {
                if (m_openDelaySeconds > 0f)
                {
                    await Awaitable.WaitForSecondsAsync(m_openDelaySeconds, cancellationToken);
                }

                m_door.Unlock();
            }
            catch (OperationCanceledException)
            {
                // The level was unloaded mid-beat. The flag is already queued, so the next session
                // unlocks the door from Update above.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(0.2f, 0.6f, 1f, 0.8f);
            Gizmos.DrawWireSphere(ImpactPosition, 0.25f);
            Gizmos.DrawLine(ReachPosition, ImpactPosition);
        }
    }
}
