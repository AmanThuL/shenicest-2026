using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// The observation deck's collapse: swaps the intact spiral stair for a pre-fractured twin
    /// (lower stair kept whole, the deck ring in chunks) and lets physics drop the chunks. Fired by
    /// the circulation ending flags, so choosing a doomed cycle at the console is what breaks the
    /// deck; the player standing on it falls with the debris, and <c>FreeFallView</c> owns what the
    /// camera does about that.
    /// <para>
    /// The intact stair lives in the Environment scene, which teammates edit, so it is found by
    /// name at collapse time instead of holding a cross-scene reference — additive loading forbids
    /// that reference anyway. Debris ignores the player's capsule: chunks may not wall the player
    /// in, whatever pile physics builds. A rescue restore where the flag is already up replays the
    /// swap immediately (<see cref="IRescueStateRestoredParticipant"/>), because the flag snapshot
    /// raises no events.
    /// </para>
    /// </summary>
    public class GreenhouseStairCollapse : MonoBehaviour, IRescueStateRestoredParticipant
    {
        [Header("Trigger")]
        [Tooltip("Data/Events/FlagRaised — the world-flag channel the endings raise on.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Any of these flags collapses the deck (the doomed circulation choices).")]
        [SerializeField] private string[] m_collapseFlags =
        {
            WorldFlags.k_CirculationCore,
            WorldFlags.k_CirculationRing
        };

        [Header("Scene pieces")]
        [Tooltip("The fractured twin, inactive until the collapse. Its children are the lower "
            + "stair (kept whole) and the deck chunks.")]
        [SerializeField] private GameObject m_collapseRig;

        [Tooltip("Name of the intact stair object in the Environment scene, found at collapse "
            + "time — a cross-scene reference cannot be serialized.")]
        [SerializeField] private string m_intactStairName = "GreenhouseSpiralStair";

        [Tooltip("Child of the rig that stays in one piece and only needs a static collider.")]
        [SerializeField] private string m_lowerPartName = "SpiralStair_Lower";

        [Header("Debris")]
        [Tooltip("Outward-and-down shove per chunk, in newton-seconds per kilogram — an initial "
            + "velocity, so the break reads as a snap rather than a slump.")]
        [Min(0f)]
        [SerializeField] private float m_impulse = 1.5f;

        [Tooltip("Random spin per chunk, radians per second at most.")]
        [Min(0f)]
        [SerializeField] private float m_maxSpin = 3f;

        [Tooltip("Seconds until the debris freezes where it lies. Physics has long settled by "
            + "then; freezing makes the pile deterministic afterwards.")]
        [Min(1f)]
        [SerializeField] private float m_settleSeconds = 10f;

        private readonly List<Rigidbody> m_debris = new List<Rigidbody>();
        private PhysicsMaterial m_slickMaterial;
        private bool m_hasCollapsed;

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
            if (m_hasCollapsed || WorldAccess.State == null)
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
            if (m_hasCollapsed)
            {
                return;
            }

            for (int i = 0; i < m_collapseFlags.Length; i++)
            {
                if (flag == m_collapseFlags[i])
                {
                    Collapse();
                    return;
                }
            }
        }

        [ContextMenu("Collapse")]
        public void Collapse()
        {
            if (m_hasCollapsed || m_collapseRig == null)
            {
                return;
            }

            m_hasCollapsed = true;
            Log.Info("[collapse] begin", this);

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

            Collider[] playerColliders = FindPlayerColliders();
            Vector3 deckCentre = m_collapseRig.transform.position;

            // Three things would hold the ring up that must not: the spiral's top treads carried
            // the deck and would carry the debris; and the chunks' convex hulls overlap their
            // neighbours' (an arc chunk's hull closes its chord), which locks the ring into a
            // self-supporting arch. So debris ignores the lower stair and other debris both, and
            // collides only with the world — at fall speed neither pass-through is readable.
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

                MeshCollider collider = filter.gameObject.AddComponent<MeshCollider>();

                collider.convex = true;
                collider.sharedMaterial = SlickMaterial();

                foreach (Collider playerCollider in playerColliders)
                {
                    Physics.IgnoreCollision(collider, playerCollider);
                }

                if (lowerCollider != null)
                {
                    Physics.IgnoreCollision(collider, lowerCollider);
                }

                Rigidbody body = filter.gameObject.AddComponent<Rigidbody>();
                body.mass = 80f;
                body.interpolation = RigidbodyInterpolation.Interpolate;
                body.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;

                // Inward, not outward: the ring overhangs the facility terrace on one side, and
                // an outward shove parks debris on it at deck height. The open stairwell is the
                // centre of the ring, so the collapse funnels down the well.
                Vector3 inward = deckCentre - filter.transform.position;
                inward.y = 0f;
                inward = inward.sqrMagnitude > 0.001f ? inward.normalized : Random.insideUnitSphere;
                Vector3 jitter = Vector3.Cross(inward, Vector3.up) * Random.Range(-0.3f, 0.3f);
                body.linearVelocity = (inward * 1.0f + jitter + Vector3.up * 0.3f + Vector3.down * 0.7f) * m_impulse;
                body.angularVelocity = Random.insideUnitSphere * m_maxSpin;

                m_debris.Add(body);
            }

            for (int i = 0; i < m_debris.Count; i++)
            {
                var a = m_debris[i].GetComponent<Collider>();

                for (int j = i + 1; j < m_debris.Count; j++)
                {
                    Physics.IgnoreCollision(a, m_debris[j].GetComponent<Collider>());
                }
            }

            // Slick only long enough to clear the terrace; with friction restored the debris
            // stops where it lands instead of gliding across the greenhouse floor.
            Invoke(nameof(RestoreDebrisFriction), 2.5f);
            Invoke(nameof(FreezeDebris), m_settleSeconds);
            Log.Info($"[collapse] armed: {m_debris.Count} debris, freeze in {m_settleSeconds}s", this);
        }

        /// <summary>
        /// Frictionless while falling, so a chunk born resting on the facility terrace (the ring
        /// overhangs it at deck height) slides off instead of being parked by friction after a
        /// hand's width. Debris freezes kinematic before anyone walks on it, so the slickness is
        /// never felt.
        /// </summary>
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

        private void RestoreDebrisFriction()
        {
            Log.Info("[collapse] friction restored", this);

            if (m_slickMaterial != null)
            {
                m_slickMaterial.dynamicFriction = 0.6f;
                m_slickMaterial.staticFriction = 0.6f;
                m_slickMaterial.frictionCombine = PhysicsMaterialCombine.Average;
            }
        }

        private void FreezeDebris()
        {
            Log.Info($"[collapse] freezing {m_debris.Count} debris", this);

            for (int i = 0; i < m_debris.Count; i++)
            {
                if (m_debris[i] != null)
                {
                    m_debris[i].isKinematic = true;
                }
            }
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

        private static Collider[] FindPlayerColliders()
        {
            var controller = Object.FindFirstObjectByType<RootsDance.Player.FirstPersonController>();

            return controller != null
                ? controller.GetComponentsInChildren<Collider>(true)
                : new Collider[0];
        }
    }
}
