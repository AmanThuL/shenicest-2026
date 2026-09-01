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
    /// The doomed circulation choice starts it. First the <b>warning</b>: the floor trembles
    /// through the camera, the sub-bass groan and the metal creaks come and go, dust falls — and
    /// nothing moves, for as long as the sprite's outburst (DLG-009) takes to finish. Only when
    /// that conversation raises <see cref="WorldFlags.k_WrongCycleOutburstDone"/> does the deck
    /// start to <b>go</b>: one chunk on the far side, a pause, a second, then faster and faster
    /// until the rest of the ring lets go as one avalanche that ends under the player's feet. The
    /// player falls with the last of it; <see cref="FreeFallView"/> owns what the camera does about
    /// that. Once they are on the floor again — and only then — <see cref="m_flagOnLanded"/> goes
    /// up, which is the flag that wakes the boss, unlocks the exits and arms the exterior stream.
    /// </para>
    /// <para>
    /// The intact stair lives in the Environment scene, which teammates edit, so it is found by
    /// name at collapse time instead of holding a cross-scene reference — additive loading forbids
    /// that reference anyway. Until a chunk is released it is a kinematic body on the Ground layer,
    /// so the player is standing on the fractured deck itself, not on an invisible stand-in; a
    /// released chunk ignores the player's capsule, so debris can never wall the player in. A
    /// rescue restore where the flag is already up replays the swap at once and silently
    /// (<see cref="IRescueStateRestoredParticipant"/>): there is nothing to warn about after the
    /// fact, and the flag snapshot raises no events.
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

        [Tooltip("The deck holds — trembling, groaning, shedding dust — until this flag is up: the "
            + "sprite's outburst finishing. Empty means the warning simply runs its Max Warning "
            + "Seconds. Either way the deck cannot go before the talking is done.")]
        [SerializeField] private string m_releaseOnFlag = WorldFlags.k_WrongCycleOutburstDone;

        [Tooltip("Longest the warning may last if the release flag never arrives — a missing or "
            + "skipped conversation must not leave the deck standing forever.")]
        [Min(1f)]
        [SerializeField] private float m_maxWarningSeconds = 45f;

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
        [SerializeField] private float m_tremorAtWarningStart = 0.12f;

        [Tooltip("Camera tremor (0..1) by the time the outburst is over.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_tremorAtWarningEnd = 0.55f;

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

        [Tooltip("A metal creak, scattered through the warning and used as the snap of the first "
            + "few breaks.")]
        [SerializeField] private AudioCueSO m_creakCue;

        [Tooltip("Mean seconds between creaks during the warning; each gap is randomised around it.")]
        [Min(0.2f)]
        [SerializeField] private float m_creakIntervalSeconds = 2.2f;

        [Tooltip("The structure coming apart — the long body of the collapse.")]
        [SerializeField] private AudioCueSO m_collapseCue;

        [Tooltip("Which release starts the collapse body (0 = the first chunk). One later than "
            + "the first, so the first break reads as a single snap before the roar.")]
        [Min(0)]
        [SerializeField] private int m_collapseCueRelease = 1;

        [Tooltip("First debris hit, after the first chunk has had time to reach anything.")]
        [SerializeField] private AudioCueSO m_debrisCue;

        [Min(0f)]
        [SerializeField] private float m_debrisDelaySeconds = 2.2f;

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
                    Collapse();
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
        /// <see cref="Collapse"/> stays callable on its own for the rescue restore and the context
        /// menu, where there is no one to warn.
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

            FinishAsync(destroyCancellationToken);
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

            await WarningAsync(cancellationToken);
            await Awaitable.WaitForSecondsAsync(m_releaseDelaySeconds, cancellationToken);

            m_hasCollapsed = true;
            Log.Info("[collapse] the deck goes", this);

            List<Rigidbody> chunks = PrepareRig();
            await ReleaseStagedAsync(chunks, cancellationToken);
            await LandingAsync(cancellationToken);
        }

        /// <summary>
        /// The deck takes strain and nothing gives. Tremor and sound build until the outburst is
        /// over, or until the warning has run as long as it is allowed to.
        /// </summary>
        private async Awaitable WarningAsync(CancellationToken cancellationToken)
        {
            Log.Info("[collapse] warning", this);
            SetActive(m_warningEffects, true);

            float start = Time.time;
            float nextWarning = start;
            float nextCreak = start + UnityEngine.Random.Range(0.4f, 1.2f);

            while (true)
            {
                float elapsed = Time.time - start;

                if (m_releaseRequested || elapsed >= m_maxWarningSeconds)
                {
                    break;
                }

                // Tremor grows with time, whatever the outburst's length turns out to be; the
                // cap keeps a long conversation from shaking the view flat before anything breaks.
                float progress = Mathf.Clamp01(elapsed / m_maxWarningSeconds * 2f);
                SetTremor(Mathf.Lerp(m_tremorAtWarningStart, m_tremorAtWarningEnd, progress));

                if (Time.time >= nextWarning)
                {
                    Play(m_warningCue);
                    nextWarning = Time.time + m_warningRepeatSeconds;
                }

                if (Time.time >= nextCreak)
                {
                    Play(m_creakCue);
                    nextCreak = Time.time + m_creakIntervalSeconds * UnityEngine.Random.Range(0.55f, 1.45f);
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
            PlayLaterAsync(m_debrisCue, m_debrisDelaySeconds, cancellationToken);

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

                    if (released < 3)
                    {
                        Play(m_creakCue);
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
                    Log.Warning("[collapse] the player never left the ground; carrying on", this);
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

            RestoreFrictionLaterAsync(collider, destroyCancellationToken);
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
        /// 30-45 m linear rolloff — a pivot parked at the scene origin puts the whole collapse far
        /// enough away to be inaudible while the player falls through it. Renderer bounds are in
        /// world space and cannot be wrong about where the deck actually is.
        /// </summary>
        private Vector3 SoundPosition()
        {
            if (m_collapseRig == null)
            {
                return transform.position;
            }

            Renderer[] renderers = m_collapseRig.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                return m_collapseRig.transform.position;
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds.center;
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
