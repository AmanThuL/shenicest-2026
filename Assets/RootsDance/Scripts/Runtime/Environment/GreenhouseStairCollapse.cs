using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.App;
using RootsDance.Audio;
using RootsDance.Cameras;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// The observation deck's collapse, played as a beat rather than dropped as a physics event.
    /// <para>
    /// The doomed circulation choice starts it. The deck <b>holds</b>, still and silent, while
    /// the sprite's outburst (DLG-009) runs — the speech is long, and a floor that shakes through
    /// all of it has nothing left to say by the end. Only when her last lines raise
    /// <see cref="WorldFlags.k_WrongCycleOutburstPeak"/> does the <b>warning</b> begin: the floor
    /// trembles through the camera, the sub-bass groan comes, dust falls, the tremor climbs — and
    /// nothing moves yet. When the conversation raises
    /// <see cref="WorldFlags.k_WrongCycleOutburstDone"/> the deck starts to <b>go</b>: one chunk on the far side, a pause, a second, then faster and faster
    /// until the rest of the ring lets go as one avalanche that ends under the player's feet. The
    /// player falls with the last of it; <see cref="FreeFallView"/> owns what the camera does about
    /// that, and every chunk that lands near the player kicks it — so a player who was on the
    /// floor below, not on the deck, still stands inside the collapse. Once they are on the floor again — and only then — <see cref="m_flagOnLanded"/> goes
    /// up, which is the flag that wakes the boss, unlocks the exits and arms the exterior stream.
    /// </para>
    /// <para>
    /// The intact stair lives in the Environment scene, which teammates edit, so it is found by
    /// name at collapse time instead of holding a cross-scene reference — additive loading forbids
    /// that reference anyway. Until a chunk is released it is a kinematic body on the Ground layer,
    /// so the player is standing on the fractured deck itself, not on an invisible stand-in; a
    /// released chunk ignores the player's capsule, so debris can never wall the player in. A
    /// rescue restore where the flag is already up swaps straight to the static completed state
    /// (<see cref="IRescueStateRestoredParticipant"/>): the lower stair remains, the fallen upper
    /// pieces stay gone, and no debris physics is rebuilt after the fact.
    /// </para>
    /// </summary>
    public class GreenhouseStairCollapse : MonoBehaviour, IRescueStateRestoredParticipant
    {
        [Header("Trigger")]
        [Tooltip("Data/Events/FlagRaised — the world-flag channel the endings raise on.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Any of these flags starts the beat (the doomed circulation choices).")]
        [SerializeField] private string[] m_collapseFlags =
        {
            WorldFlags.k_CirculationCore,
            WorldFlags.k_CirculationRing
        };

        [Tooltip("The deck holds still and silent until this flag is up: the sprite reaching the "
            + "last lines of her outburst. Empty means the warning starts at once. If the release "
            + "flag arrives first the warning starts then instead, so the deck never goes without one.")]
        [SerializeField] private string m_warningOnFlag = WorldFlags.k_WrongCycleOutburstPeak;

        [Tooltip("Longest the deck may hold before warning anyway — a missing or skipped "
            + "conversation must not leave it standing forever.")]
        [Min(1f)]
        [SerializeField] private float m_maxHoldSeconds = 60f;

        [Tooltip("The deck trembles, groans and sheds dust until this flag is up: the sprite's "
            + "outburst finishing. Empty means the warning simply runs its Max Warning Seconds. "
            + "Either way the deck cannot go before the talking is done.")]
        [SerializeField] private string m_releaseOnFlag = WorldFlags.k_WrongCycleOutburstDone;

        [Tooltip("Seconds the tremor takes to climb from its start to its end. Sized to the lines "
            + "left after the warning flag — the view should be at its most unsteady as she stops.")]
        [Min(0.1f)]
        [SerializeField] private float m_warningRampSeconds = 8f;

        [Tooltip("Shortest the warning may run even if the release flag comes early — a deck that "
            + "goes with no warning at all reads as a bug, not a beat.")]
        [Min(0f)]
        [SerializeField] private float m_minWarningSeconds = 3f;

        [Tooltip("Longest the warning may last if the release flag never arrives.")]
        [Min(1f)]
        [SerializeField] private float m_maxWarningSeconds = 20f;

        [Tooltip("Breath between the outburst ending and the first chunk going.")]
        [Min(0f)]
        [SerializeField] private float m_releaseDelaySeconds = 0.8f;

        [Header("Scene pieces")]
        [Tooltip("The fractured twin, inactive until the collapse. Its children are the lower "
            + "stair (kept whole) and the deck chunks.")]
        [SerializeField] private GameObject m_collapseRig;

        [Tooltip("Name of the intact stair object in the Environment scene, found at collapse "
            + "time — a cross-scene reference cannot be serialized.")]
        [SerializeField] private string m_intactStairName = "GreenhouseSpiralStair";

        [Tooltip("Child of the rig that stays in one piece and only needs a static collider.")]
        [SerializeField] private string m_lowerPartName = "SpiralStair_Lower";

        [Tooltip("Physics layer the chunks take while they still hold the player up. The player's "
            + "ground check only trusts this layer.")]
        [SerializeField] private string m_groundLayerName = "Ground";

        [Header("Warning")]
        [Tooltip("Switched on when the warning starts: dust sifting down from the deck, the VFX "
            + "owner's. Empty is fine.")]
        [SerializeField] private GameObject[] m_warningEffects = Array.Empty<GameObject>();

        [Tooltip("Camera tremor (0..1) as the warning begins.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_tremorAtWarningStart = 0.25f;

        [Tooltip("Camera tremor (0..1) by the time the outburst is over.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_tremorAtWarningEnd = 0.75f;

        [Tooltip("Camera tremor (0..1) while the deck is going.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_tremorDuringCollapse = 1f;

        [Tooltip("Seconds the tremor holds after the last chunk goes before it is released — by "
            + "then the player is falling and the wind has taken over.")]
        [Min(0f)]
        [SerializeField] private float m_tremorHoldSeconds = 0.6f;

        [Header("Release")]
        [Tooltip("Switched on at the first break: the dust cloud, sparks, whatever the VFX owner "
            + "gives the collapse. Empty is fine.")]
        [SerializeField] private GameObject[] m_collapseEffects = Array.Empty<GameObject>();

        [Tooltip("Seconds between the first chunk and the second — the beat that says this is "
            + "really happening.")]
        [Min(0f)]
        [SerializeField] private float m_firstIntervalSeconds = 1.6f;

        [Tooltip("Each gap is the previous one times this. Under 1 the collapse accelerates.")]
        [Range(0.1f, 1f)]
        [SerializeField] private float m_intervalDecay = 0.72f;

        [Tooltip("Shortest gap, once the pace has built — the avalanche.")]
        [Min(0f)]
        [SerializeField] private float m_minIntervalSeconds = 0.04f;

        [Header("Sound")]
        [Tooltip("Data/Events/AudioCueRequested — the channel the director listens on. Leave the "
            + "cues empty and the collapse simply stays silent.")]
        [SerializeField] private AudioCueEventChannelSO m_audioChannel;

        [Tooltip("The sub-bass groan of the deck taking strain. Played at the start of the warning "
            + "and again every Warning Repeat Seconds while it lasts.")]
        [SerializeField] private AudioCueSO m_warningCue;

        [Min(1f)]
        [SerializeField] private float m_warningRepeatSeconds = 6.5f;

        [Tooltip("The structure coming apart — the long body of the collapse.")]
        [SerializeField] private AudioCueSO m_collapseCue;

        [Tooltip("Which release starts the collapse body (0 = the first chunk). One later than "
            + "the first, so the first break reads as a single snap before the roar.")]
        [Min(0)]
        [SerializeField] private int m_collapseCueRelease = 1;

        [Tooltip("A chunk hitting something. Played at the contact point of every chunk's first "
            + "impact, throttled by the cue's own cooldown — the sound lands where and when the "
            + "rubble does.")]
        [SerializeField] private AudioCueSO m_debrisCue;

        [Tooltip("Impacts closer than this to the player kick the camera; the kick scales with "
            + "closeness and closing speed.")]
        [Min(1f)]
        [SerializeField] private float m_impactKickRadius = 14f;

        [Tooltip("Closing speed, m/s, at which an impact right beside the player is a full kick.")]
        [Min(1f)]
        [SerializeField] private float m_fullKickSpeed = 9f;

        [Tooltip("The long tail of rubble still finding its place, after the last chunk goes.")]
        [SerializeField] private AudioCueSO m_debrisSettleCue;

        [Min(0f)]
        [SerializeField] private float m_debrisSettleDelaySeconds = 3.3f;

        [Header("Debris")]
        [Tooltip("Outward-and-down shove per chunk, in newton-seconds per kilogram — an initial "
            + "velocity, so the break reads as a snap rather than a slump.")]
        [Min(0f)]
        [SerializeField] private float m_impulse = 1.5f;

        [Tooltip("Random spin per chunk, radians per second at most.")]
        [Min(0f)]
        [SerializeField] private float m_maxSpin = 3f;

        [Tooltip("Seconds after the last release until the debris freezes where it lies. Physics "
            + "has long settled by then; freezing makes the pile deterministic afterwards.")]
        [Min(1f)]
        [SerializeField] private float m_settleSeconds = 10f;

        [Header("Roof")]
        [Tooltip("What the roof lets go of while the deck comes down — the hanging moss. Empty "
            + "and the roof keeps everything.")]
        [SerializeField] private GreenhouseRoofShedding m_roofShedding;

        [Header("After the fall")]
        [Tooltip("Raised once the player is back on the ground after the fall. This is what wakes "
            + "the boss, unlocks the exits and arms the exterior stream — nothing before this "
            + "moment may do any of that.")]
        [SerializeField] private string m_flagOnLanded = WorldFlags.k_ChaseStarted;

        [Tooltip("Beat between landing and the flag, so the landing dip is over before the chase "
            + "music and the boss arrive.")]
        [Min(0f)]
        [SerializeField] private float m_landedFlagDelaySeconds = 1f;

        [Tooltip("If the player has not left the ground this long after the last chunk went "
            + "(standing on the lower stair, say), the fall is treated as over.")]
        [Min(0f)]
        [SerializeField] private float m_leaveGroundTimeoutSeconds = 3f;

        [Tooltip("Longest a fall may take before the flag goes up regardless — the game must not "
            + "wedge on a player stuck mid-air.")]
        [Min(1f)]
        [SerializeField] private float m_landingTimeoutSeconds = 8f;

        /// <summary>Seconds a released chunk stays frictionless — long enough to clear the terrace.</summary>
        private const float k_SlickSeconds = 2.5f;

        private readonly List<Rigidbody> m_debris = new List<Rigidbody>();
        private readonly List<Collider> m_playerColliders = new List<Collider>();
        private PhysicsMaterial m_slickMaterial;
        private PhysicsMaterial m_grippyMaterial;
        private FreeFallView m_view;
        private FirstPersonController m_player;
        private bool m_hasCollapsed;
        private bool m_isPlaying;
        private bool m_releaseRequested;
        private bool m_warningRequested;
        private bool m_hasSoundPosition;
        private Vector3 m_soundPosition;

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        /// <summary>The flag snapshot in a rescue raises no events; replay the swap if it is up.</summary>
        public void RestoreAfterRescue(RescueCheckpoint checkpoint)
        {
            if (m_hasCollapsed || m_isPlaying || WorldAccess.State == null)
            {
                return;
            }

            for (int i = 0; i < m_collapseFlags.Length; i++)
            {
                if (WorldAccess.State.HasFlag(m_collapseFlags[i]))
                {
                    RestoreCollapsedState();
                    return;
                }
            }
        }

        private void OnFlagRaised(string flag)
        {
            if (!string.IsNullOrEmpty(m_releaseOnFlag) && flag == m_releaseOnFlag)
            {
                m_releaseRequested = true;
            }

            if (!string.IsNullOrEmpty(m_warningOnFlag) && flag == m_warningOnFlag)
            {
                m_warningRequested = true;
            }

            if (m_hasCollapsed || m_isPlaying)
            {
                return;
            }

            for (int i = 0; i < m_collapseFlags.Length; i++)
            {
                if (flag == m_collapseFlags[i])
                {
                    BeginCollapse();
                    return;
                }
            }
        }

        /// <summary>
        /// The played beat: warning, then the staged release, then the fall and its flag.
        /// <see cref="Collapse"/> stays callable on its own from the context menu, where there is
        /// no one to warn.
        /// </summary>
        public void BeginCollapse()
        {
            if (m_hasCollapsed || m_isPlaying || m_collapseRig == null)
            {
                return;
            }

            m_isPlaying = true;
            ChoreographyEntryAsync(destroyCancellationToken);
        }

        /// <summary>Instant and silent: everything released at once, no warning, no flag.</summary>
        [ContextMenu("Collapse")]
        public void Collapse()
        {
            if (m_hasCollapsed || m_collapseRig == null)
            {
                return;
            }

            m_hasCollapsed = true;
            Log.Info("[collapse] instant", this);

            List<Rigidbody> chunks = PrepareRig();

            for (int i = 0; i < chunks.Count; i++)
            {
                Release(chunks[i]);
            }

            if (m_roofShedding != null)
            {
                m_roofShedding.ShedInstantly();
            }

            FinishAsync(destroyCancellationToken);
        }

        /// <summary>
        /// Restores the aftermath without recreating the collapse simulation. The lower stair is
        /// the only surviving walkable piece; upper fragments already fell and therefore remain
        /// hidden instead of receiving runtime colliders and rigidbodies.
        /// </summary>
        public void RestoreCollapsedState()
        {
            if (m_hasCollapsed || m_collapseRig == null)
            {
                return;
            }

            m_hasCollapsed = true;
            Log.Info("[collapse] restored static aftermath", this);

            GameObject intact = FindIntactStair();

            if (intact != null)
            {
                intact.SetActive(false);
            }
            else
            {
                Log.Warning($"No '{m_intactStairName}' found to hide; the fractured twin will "
                    + "overlap it.", this);
            }

            AlignRigToIntactStair(intact);
            m_collapseRig.SetActive(true);

            int groundLayer = LayerMask.NameToLayer(m_groundLayerName);
            MeshFilter[] pieces = m_collapseRig.GetComponentsInChildren<MeshFilter>(true);

            for (int i = 0; i < pieces.Length; i++)
            {
                MeshFilter piece = pieces[i];

                if (piece.gameObject.name != m_lowerPartName)
                {
                    piece.gameObject.SetActive(false);
                    continue;
                }

                piece.gameObject.SetActive(true);

                if (groundLayer >= 0)
                {
                    piece.gameObject.layer = groundLayer;
                }

                MeshCollider lowerCollider = piece.GetComponent<MeshCollider>();

                if (lowerCollider == null)
                {
                    lowerCollider = piece.gameObject.AddComponent<MeshCollider>();
                }

                lowerCollider.sharedMesh = piece.sharedMesh;
                lowerCollider.convex = false;
            }

            SetActive(m_warningEffects, false);
            SetActive(m_collapseEffects, false);
            SetTremor(0f);

            if (m_roofShedding != null)
            {
                m_roofShedding.ShedInstantly();
            }
        }

        private async void ChoreographyEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                await ChoreographyAsync(cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Destroyed or Play mode exited: nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
            finally
            {
                m_isPlaying = false;
            }
        }

        private async Awaitable ChoreographyAsync(CancellationToken cancellationToken)
        {
            // Initialisation-time lookups: both live in the Gameplay scene, which this scene cannot
            // reference, and the beat happens once.
            m_view = FindFirstObjectByType<FreeFallView>();
            m_player = FindFirstObjectByType<FirstPersonController>();

            await HoldAsync(cancellationToken);
            await WarningAsync(cancellationToken);
            await Awaitable.WaitForSecondsAsync(m_releaseDelaySeconds, cancellationToken);

            m_hasCollapsed = true;
            Log.Info("[collapse] the deck goes. " + (m_player == null
                ? "No player found."
                : DescribeGround(m_player.transform.position)), this);

            List<Rigidbody> chunks = PrepareRig();
            await ReleaseStagedAsync(chunks, cancellationToken);
            await LandingAsync(cancellationToken);
        }

        /// <summary>
        /// The deck holds, still and silent, while the sprite talks. Nothing here is a beat: no
        /// tremor, no groan, no dust. It ends when her last lines raise the warning flag, when the
        /// outburst is already over, or when the hold has run as long as it is allowed to.
        /// </summary>
        private async Awaitable HoldAsync(CancellationToken cancellationToken)
        {
            if (string.IsNullOrEmpty(m_warningOnFlag))
            {
                return;
            }

            Log.Info("[collapse] holding for the outburst", this);
            float start = Time.time;

            while (!m_warningRequested && !m_releaseRequested && Time.time - start < m_maxHoldSeconds)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }
        }

        /// <summary>
        /// The deck takes strain and nothing gives. Tremor and sound build over the ramp until the
        /// outburst is over (but never shorter than the minimum), or until the warning has run as
        /// long as it is allowed to.
        /// </summary>
        private async Awaitable WarningAsync(CancellationToken cancellationToken)
        {
            Log.Info("[collapse] warning", this);
            SetActive(m_warningEffects, true);

            float start = Time.time;
            float nextWarning = start;

            while (true)
            {
                float elapsed = Time.time - start;

                if ((m_releaseRequested && elapsed >= m_minWarningSeconds) || elapsed >= m_maxWarningSeconds)
                {
                    break;
                }

                // Eased in rather than linear: the warning sits under her last two lines, and the
                // build has to stay out of the way of the line being delivered. Cubed, so most of
                // the growth lands in the last third — by the time the deck is about to go the
                // view is already unsteady, but it got there in the last few seconds, not through
                // the whole conversation.
                float progress = Mathf.Clamp01(elapsed / m_warningRampSeconds);
                progress = progress * progress * progress;
                SetTremor(Mathf.Lerp(m_tremorAtWarningStart, m_tremorAtWarningEnd, progress));

                if (Time.time >= nextWarning)
                {
                    Play(m_warningCue);
                    nextWarning = Time.time + m_warningRepeatSeconds;
                }

                await Awaitable.NextFrameAsync(cancellationToken);
            }

            Log.Info(m_releaseRequested
                ? "[collapse] outburst over, releasing"
                : "[collapse] warning ran out, releasing", this);
        }

        /// <summary>One chunk, a pause, a second, then faster and faster until the ring is gone.</summary>
        private async Awaitable ReleaseStagedAsync(List<Rigidbody> chunks, CancellationToken cancellationToken)
        {
            Vector3 origin = m_player != null ? m_player.transform.position : m_collapseRig.transform.position;
            var positions = new List<Vector3>(chunks.Count);

            for (int i = 0; i < chunks.Count; i++)
            {
                positions.Add(chunks[i].worldCenterOfMass);
            }

            int[] order = DeckCollapseSchedule.Order(positions, origin);
            float[] times = DeckCollapseSchedule.ReleaseTimes(
                order.Length, m_firstIntervalSeconds, m_intervalDecay, m_minIntervalSeconds);

            SetActive(m_collapseEffects, true);
            SetTremor(m_tremorDuringCollapse);

            // The roof sheds through the same window as the deck, and a little past it.
            if (m_roofShedding != null)
            {
                m_roofShedding.Shed(times.Length > 0 ? times[times.Length - 1] : 0f, m_playerColliders);
            }

            float start = Time.time;
            int released = 0;

            while (released < order.Length)
            {
                float elapsed = Time.time - start;

                // Everything due this frame goes this frame: once the gaps are shorter than a
                // frame, several chunks per frame is the avalanche, not a bug.
                while (released < order.Length && times[released] <= elapsed)
                {
                    Release(chunks[order[released]]);

                    if (released == m_collapseCueRelease)
                    {
                        Play(m_collapseCue);
                    }

                    released++;
                }

                if (released < order.Length)
                {
                    await Awaitable.NextFrameAsync(cancellationToken);
                }
            }

            Log.Info($"[collapse] {released} chunks released over {Time.time - start:0.0}s", this);
            PlayLaterAsync(m_debrisSettleCue, m_debrisSettleDelaySeconds, cancellationToken);
            FinishAsync(cancellationToken);

            await Awaitable.WaitForSecondsAsync(m_tremorHoldSeconds, cancellationToken);
            SetTremor(0f);
        }

        /// <summary>
        /// Waits for the player to leave the ground and come back to it, then raises the flag.
        /// Both waits are bounded: a player who never fell (standing on the lower stair) or never
        /// lands (stuck on debris) still gets the chase, because the alternative is a soft-lock.
        /// </summary>
        private async Awaitable LandingAsync(CancellationToken cancellationToken)
        {
            if (m_player != null)
            {
                float start = Time.time;

                while (m_player.IsGrounded && Time.time - start < m_leaveGroundTimeoutSeconds)
                {
                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                if (m_player.IsGrounded)
                {
                    Log.Warning("[collapse] the player never left the ground; carrying on. "
                        + DescribeGround(m_player.transform.position), this);
                }
                else
                {
                    float airborne = Time.time;

                    while (!m_player.IsGrounded && Time.time - airborne < m_landingTimeoutSeconds)
                    {
                        await Awaitable.NextFrameAsync(cancellationToken);
                    }

                    Log.Info(m_player.IsGrounded
                        ? $"[collapse] landed after {Time.time - airborne:0.0}s"
                        : "[collapse] landing timed out; carrying on", this);
                }
            }

            await Awaitable.WaitForSecondsAsync(m_landedFlagDelaySeconds, cancellationToken);

            if (!string.IsNullOrEmpty(m_flagOnLanded))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(m_flagOnLanded), this);
            }
        }

        /// <summary>
        /// Swaps the intact stair for the rig and gives every chunk a body that holds still. The
        /// player is standing on these — kinematic, on the Ground layer, colliding with the
        /// capsule — until each one is released.
        /// </summary>
        private List<Rigidbody> PrepareRig()
        {
            GameObject intact = FindIntactStair();

            if (intact != null)
            {
                intact.SetActive(false);
            }
            else
            {
                Log.Warning($"No '{m_intactStairName}' found to hide; the fractured twin will "
                    + "overlap it.", this);
            }

            AlignRigToIntactStair(intact);
            m_collapseRig.SetActive(true);
            CollectPlayerColliders();

            int groundLayer = LayerMask.NameToLayer(m_groundLayerName);
            var chunks = new List<Rigidbody>();
            Collider lowerCollider = null;

            foreach (MeshFilter filter in m_collapseRig.GetComponentsInChildren<MeshFilter>())
            {
                if (filter.gameObject.name == m_lowerPartName)
                {
                    lowerCollider = filter.gameObject.AddComponent<MeshCollider>();
                }
            }

            foreach (MeshFilter filter in m_collapseRig.GetComponentsInChildren<MeshFilter>())
            {
                if (filter.gameObject.name == m_lowerPartName)
                {
                    continue;
                }

                if (groundLayer >= 0)
                {
                    filter.gameObject.layer = groundLayer;
                }

                MeshCollider collider = filter.gameObject.AddComponent<MeshCollider>();
                collider.convex = true;
                collider.sharedMaterial = SlickMaterial();

                // The spiral's top treads carried the deck and would carry the debris, so debris
                // ignores the lower stair; at fall speed the pass-through is not readable.
                if (lowerCollider != null)
                {
                    Physics.IgnoreCollision(collider, lowerCollider);
                }

                Rigidbody body = filter.gameObject.AddComponent<Rigidbody>();
                body.mass = 80f;
                body.isKinematic = true;
                body.interpolation = RigidbodyInterpolation.Interpolate;
                body.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;

                chunks.Add(body);
            }

            // The chunks' convex hulls overlap their neighbours' (an arc chunk's hull closes its
            // chord), which would lock the ring into a self-supporting arch. Debris collides only
            // with the world.
            for (int i = 0; i < chunks.Count; i++)
            {
                var a = chunks[i].GetComponent<Collider>();

                for (int j = i + 1; j < chunks.Count; j++)
                {
                    Physics.IgnoreCollision(a, chunks[j].GetComponent<Collider>());
                }
            }

            m_debris.AddRange(chunks);
            return chunks;
        }

        /// <summary>Lets one chunk go: stops holding the player, gets its shove, starts falling.</summary>
        private void Release(Rigidbody body)
        {
            var collider = body.GetComponent<Collider>();

            for (int i = 0; i < m_playerColliders.Count; i++)
            {
                if (m_playerColliders[i] != null)
                {
                    Physics.IgnoreCollision(collider, m_playerColliders[i]);
                }
            }

            body.isKinematic = false;

            // Inward, not outward: the ring overhangs the facility terrace on one side, and an
            // outward shove parks debris on it at deck height. The open stairwell is the centre of
            // the ring, so the collapse funnels down the well.
            Vector3 inward = m_collapseRig.transform.position - body.transform.position;
            inward.y = 0f;
            inward = inward.sqrMagnitude > 0.001f ? inward.normalized : UnityEngine.Random.insideUnitSphere;
            Vector3 jitter = Vector3.Cross(inward, Vector3.up) * UnityEngine.Random.Range(-0.3f, 0.3f);
            body.linearVelocity = (inward * 1.0f + jitter + Vector3.up * 0.3f + Vector3.down * 0.7f) * m_impulse;
            body.angularVelocity = UnityEngine.Random.insideUnitSphere * m_maxSpin;

            body.gameObject.AddComponent<DebrisImpactReporter>().Impacted += OnDebrisImpact;
            RestoreFrictionLaterAsync(collider, destroyCancellationToken);
        }

        /// <summary>
        /// A chunk has landed: the hit sounds from where it hit, and if it was near the player the
        /// camera takes the blow — the closer and the faster, the harder.
        /// </summary>
        private void OnDebrisImpact(Vector3 point, float speed)
        {
            if (m_debrisCue != null && m_audioChannel != null)
            {
                m_audioChannel.RaiseEvent(new AudioCueRequest(m_debrisCue, point));
            }

            if (m_view == null || m_player == null)
            {
                return;
            }

            float distance = Vector3.Distance(point, m_player.transform.position);

            if (distance >= m_impactKickRadius)
            {
                return;
            }

            float closeness = 1f - distance / m_impactKickRadius;
            float hardness = Mathf.Clamp01(speed / m_fullKickSpeed);
            m_view.Kick(closeness * hardness);
        }

        /// <summary>
        /// Frictionless while falling, so a chunk born resting on the facility terrace (the ring
        /// overhangs it at deck height) slides off instead of being parked by friction after a
        /// hand's width; grippy again once it has had time to clear, so it stops where it lands
        /// instead of gliding across the greenhouse floor. Per chunk, because they go one by one.
        /// </summary>
        private async void RestoreFrictionLaterAsync(Collider collider, CancellationToken cancellationToken)
        {
            try
            {
                await Awaitable.WaitForSecondsAsync(k_SlickSeconds, cancellationToken);

                if (collider != null)
                {
                    collider.sharedMaterial = GrippyMaterial();
                }
            }
            catch (OperationCanceledException)
            {
                // Destroyed or Play mode exited: nothing to do.
            }
        }

        /// <summary>The pile freezes kinematic once physics has long settled; nobody walks on live debris.</summary>
        private async void FinishAsync(CancellationToken cancellationToken)
        {
            try
            {
                await Awaitable.WaitForSecondsAsync(m_settleSeconds, cancellationToken);
                Log.Info($"[collapse] freezing {m_debris.Count} debris", this);

                for (int i = 0; i < m_debris.Count; i++)
                {
                    if (m_debris[i] != null)
                    {
                        m_debris[i].isKinematic = true;
                    }
                }
            }
            catch (OperationCanceledException)
            {
                // Destroyed or Play mode exited: nothing to do.
            }
        }

        private async void PlayLaterAsync(AudioCueSO cue, float delaySeconds, CancellationToken cancellationToken)
        {
            if (cue == null)
            {
                return;
            }

            try
            {
                await Awaitable.WaitForSecondsAsync(delaySeconds, cancellationToken);
                Play(cue);
            }
            catch (OperationCanceledException)
            {
                // Destroyed or Play mode exited: nothing to do.
            }
        }

        /// <summary>
        /// Positional, at the deck: the collapse is a place in the room, and the player is falling
        /// through it. A null cue or channel is silence, not an error — the beat works without
        /// sound and the wiring is allowed to be half done.
        /// </summary>
        private void Play(AudioCueSO cue)
        {
            if (cue == null || m_audioChannel == null)
            {
                return;
            }

            m_audioChannel.RaiseEvent(new AudioCueRequest(cue, SoundPosition()));
        }

        /// <summary>
        /// Where the collapse sounds from: the middle of the rig's geometry, not its pivot. An
        /// imported rig's pivot is wherever the exporter left it, and these cues are 3D with a
        /// 25-45 m linear rolloff — a pivot parked at the scene origin puts the whole collapse far
        /// enough away to be inaudible while the player falls through it. Computed from the mesh
        /// bounds through each transform rather than from <see cref="Renderer.bounds"/>: the
        /// warning plays while the rig is still inactive, and an inactive renderer has no bounds
        /// to give — that is a collapse groaning from the origin, 130 m away, in silence.
        /// </summary>
        private Vector3 SoundPosition()
        {
            if (m_collapseRig == null)
            {
                return transform.position;
            }

            if (!m_hasSoundPosition)
            {
                MeshFilter[] filters = m_collapseRig.GetComponentsInChildren<MeshFilter>(true);
                bool any = false;
                Bounds bounds = default;

                for (int i = 0; i < filters.Length; i++)
                {
                    if (filters[i].sharedMesh == null)
                    {
                        continue;
                    }

                    Vector3 centre = filters[i].transform.TransformPoint(filters[i].sharedMesh.bounds.center);

                    if (!any)
                    {
                        bounds = new Bounds(centre, Vector3.zero);
                        any = true;
                    }
                    else
                    {
                        bounds.Encapsulate(centre);
                    }
                }

                m_soundPosition = any ? bounds.center : m_collapseRig.transform.position;
                m_hasSoundPosition = true;
            }

            return m_soundPosition;
        }

        private void SetTremor(float amount01)
        {
            if (m_view != null)
            {
                m_view.SetTremor(amount01);
            }
        }

        private static void SetActive(GameObject[] objects, bool active)
        {
            for (int i = 0; i < objects.Length; i++)
            {
                if (objects[i] != null)
                {
                    objects[i].SetActive(active);
                }
            }
        }

        private PhysicsMaterial SlickMaterial()
        {
            if (m_slickMaterial == null)
            {
                m_slickMaterial = new PhysicsMaterial("DeckDebrisSlick")
                {
                    dynamicFriction = 0f,
                    staticFriction = 0f,
                    frictionCombine = PhysicsMaterialCombine.Minimum,
                    bounceCombine = PhysicsMaterialCombine.Minimum
                };
            }

            return m_slickMaterial;
        }

        private PhysicsMaterial GrippyMaterial()
        {
            if (m_grippyMaterial == null)
            {
                m_grippyMaterial = new PhysicsMaterial("DeckDebrisGrippy")
                {
                    dynamicFriction = 0.6f,
                    staticFriction = 0.6f,
                    frictionCombine = PhysicsMaterialCombine.Average,
                    bounceCombine = PhysicsMaterialCombine.Minimum
                };
            }

            return m_grippyMaterial;
        }

        /// <summary>
        /// Snaps the fractured rig onto the intact stair it replaces, so the swap does not pop.
        /// The rig is authored in the same scene as the deck but a teammate owns that scene, and a
        /// hand's width of drift between the two — enough to read as the stair jumping the instant
        /// it breaks — is exactly the kind of thing an edit to either object introduces. Measured
        /// from bounds centres (mesh bounds for the rig, whose renderers are still inactive), on the
        /// flat only: the fall is vertical, and matching height would fight whatever the rig's own
        /// pivot height is. A drift beyond a metre is left alone — that is not drift, it is two
        /// different placements, and silently teleporting the rig across the room would be worse.
        /// </summary>
        private void AlignRigToIntactStair(GameObject intact)
        {
            if (intact == null)
            {
                return;
            }

            Renderer[] intactRenderers = intact.GetComponentsInChildren<Renderer>(true);

            if (intactRenderers.Length == 0)
            {
                return;
            }

            Bounds intactBounds = intactRenderers[0].bounds;

            for (int i = 1; i < intactRenderers.Length; i++)
            {
                intactBounds.Encapsulate(intactRenderers[i].bounds);
            }

            m_hasSoundPosition = false;
            Vector3 rigCentre = SoundPosition();
            Vector3 delta = intactBounds.center - rigCentre;
            delta.y = 0f;

            if (delta.sqrMagnitude > 1f)
            {
                Log.Warning($"Collapse rig is {delta.magnitude:F1} m from '{m_intactStairName}'; "
                    + "leaving it where it is rather than teleporting it.", this);
                return;
            }

            m_collapseRig.transform.position += delta;
            m_hasSoundPosition = false;
        }

        private GameObject FindIntactStair()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    foreach (Transform child in root.GetComponentsInChildren<Transform>(true))
                    {
                        if (child.name == m_intactStairName
                            && !child.IsChildOf(m_collapseRig.transform.parent))
                        {
                            return child.gameObject;
                        }
                    }
                }
            }

            return null;
        }

        /// <summary>
        /// Names whatever is holding the player up, for the one warning that needs it: a player
        /// who did not fall is standing on something, and the fix depends entirely on what.
        /// </summary>
        private static string DescribeGround(Vector3 playerPosition)
        {
            RaycastHit hit;

            if (!Physics.Raycast(playerPosition + Vector3.up * 0.5f, Vector3.down, out hit, 6f,
                Physics.DefaultRaycastLayers, QueryTriggerInteraction.Ignore))
            {
                return $"Player at {playerPosition:F2}; nothing within 6 m below.";
            }

            Transform ground = hit.collider.transform;
            Rigidbody body = hit.rigidbody;
            return $"Player at {playerPosition:F2}; standing on '{ground.name}' (scene '{ground.gameObject.scene.name}', "
                + $"layer {LayerMask.LayerToName(ground.gameObject.layer)}, {hit.distance - 0.5f:F2} m below, "
                + (body == null ? "static" : body.isKinematic ? "kinematic body" : "dynamic body") + ").";
        }

        private void CollectPlayerColliders()
        {
            m_playerColliders.Clear();

            if (m_player == null)
            {
                m_player = FindFirstObjectByType<FirstPersonController>();
            }

            if (m_player != null)
            {
                m_playerColliders.AddRange(m_player.GetComponentsInChildren<Collider>(true));
            }
        }
    }
}
