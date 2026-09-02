using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// The greenhouse roof letting go of what hangs from it when the deck collapses: the moss and
    /// ivy under the glass come down with the structure, scattered through the collapse rather
    /// than all at once, so the whole building reads as shaken and not just the one deck.
    /// <para>
    /// The pieces live in the Environment scene, which teammates own, so they are found by the
    /// name of the object that groups them (<see cref="m_rootName"/>) at shed time, exactly as
    /// <see cref="GreenhouseStairCollapse"/> finds the intact stair. Nothing is authored on the
    /// pieces themselves: each gets a box collider from its renderer bounds and a light, draggy
    /// rigidbody at the moment it is let go, so a piece falls like a wet mat and not like a stone.
    /// Debris ignores the player's capsule the same way the deck chunks do, and freezes once it
    /// has settled so the pile is deterministic afterwards.
    /// </para>
    /// <para>
    /// Silent by design: the pieces make no sound of their own. What the collapse sounds like is
    /// the collapse's, and a rustle for the moss is a cue for the audio owner to name.
    /// </para>
    /// </summary>
    public class GreenhouseRoofShedding : MonoBehaviour
    {
        [Tooltip("Name of the object in the Environment scene whose children are the hanging "
            + "pieces, found at shed time — a cross-scene reference cannot be serialized.")]
        [SerializeField] private string m_rootName = "HangingMoss_RoofAdditions";

        [Tooltip("Fraction of the pieces that come down (1 = every one). Picked at random.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_fraction = 1f;

        [Tooltip("Earliest a piece may let go, seconds after the collapse's first break.")]
        [Min(0f)]
        [SerializeField] private float m_earliestSeconds = 0.4f;

        [Tooltip("Seconds added past the end of the deck's release for the last pieces to fall "
            + "in — the roof keeps shedding a moment after the deck has gone.")]
        [Min(0f)]
        [SerializeField] private float m_trailingSeconds = 2f;

        [Header("How it falls")]
        [Tooltip("Kilograms. Light: what matters is the drag, and a heavy mat would hit like a slab.")]
        [Min(0.1f)]
        [SerializeField] private float m_mass = 3f;

        [Tooltip("Linear damping. High enough that a piece drifts down instead of dropping.")]
        [Min(0f)]
        [SerializeField] private float m_drag = 1.1f;

        [Min(0f)]
        [SerializeField] private float m_angularDrag = 1.5f;

        [Tooltip("Random spin per piece, radians per second at most.")]
        [Min(0f)]
        [SerializeField] private float m_maxSpin = 1.2f;

        [Tooltip("Sideways drift per piece, metres per second at most, so the fall is not a plumb line.")]
        [Min(0f)]
        [SerializeField] private float m_maxDrift = 0.6f;

        [Tooltip("Seconds after the last piece lets go until the debris freezes where it lies.")]
        [Min(1f)]
        [SerializeField] private float m_settleSeconds = 12f;

        private readonly List<Rigidbody> m_debris = new List<Rigidbody>();
        private bool m_hasShed;

        /// <summary>
        /// Lets the pieces go, each at a random moment between <see cref="m_earliestSeconds"/> and
        /// the end of the window. <paramref name="windowSeconds"/> is how long the deck's own
        /// release takes; the roof trails it by <see cref="m_trailingSeconds"/>.
        /// </summary>
        public void Shed(float windowSeconds, IReadOnlyList<Collider> ignore)
        {
            if (m_hasShed)
            {
                return;
            }

            m_hasShed = true;
            ShedAsync(Mathf.Max(m_earliestSeconds, windowSeconds + m_trailingSeconds), ignore, destroyCancellationToken);
        }

        /// <summary>Every piece at once, silently: the rescue restore, where there is no beat to play.</summary>
        public void ShedInstantly()
        {
            if (m_hasShed)
            {
                return;
            }

            m_hasShed = true;
            List<Transform> pieces = CollectPieces();

            for (int i = 0; i < pieces.Count; i++)
            {
                Release(pieces[i], null);
            }

            FreezeLaterAsync(destroyCancellationToken);
        }

        private async void ShedAsync(float windowSeconds, IReadOnlyList<Collider> ignore, CancellationToken cancellationToken)
        {
            try
            {
                List<Transform> pieces = CollectPieces();

                if (pieces.Count == 0)
                {
                    Log.Warning($"No '{m_rootName}' with pieces found; the roof sheds nothing.", this);
                    return;
                }

                // Each piece draws its own moment in the window; sorted so the loop below can
                // release in order without scanning.
                Transform[] ordered = pieces.ToArray();
                float[] keys = new float[ordered.Length];

                for (int i = 0; i < keys.Length; i++)
                {
                    keys[i] = UnityEngine.Random.Range(m_earliestSeconds, windowSeconds);
                }

                Array.Sort(keys, ordered);
                Log.Info($"[roof] shedding {ordered.Length} pieces over {windowSeconds:0.0}s", this);

                float start = Time.time;
                int released = 0;

                while (released < ordered.Length)
                {
                    float elapsed = Time.time - start;

                    while (released < ordered.Length && keys[released] <= elapsed)
                    {
                        Release(ordered[released], ignore);
                        released++;
                    }

                    if (released < ordered.Length)
                    {
                        await Awaitable.NextFrameAsync(cancellationToken);
                    }
                }

                FreezeLaterAsync(cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Destroyed or Play mode exited: nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private void Release(Transform piece, IReadOnlyList<Collider> ignore)
        {
            if (piece == null)
            {
                return;
            }

            Renderer renderer = piece.GetComponentInChildren<Renderer>();

            if (renderer == null)
            {
                return;
            }

            // A box from the renderer's local bounds: the ivy meshes are open leaf cards, which a
            // convex hull would balloon and a mesh collider could not move.
            Bounds bounds = renderer.localBounds;
            BoxCollider box = renderer.gameObject.AddComponent<BoxCollider>();
            box.center = bounds.center;
            box.size = Vector3.Max(bounds.size, Vector3.one * 0.05f);

            if (ignore != null)
            {
                for (int i = 0; i < ignore.Count; i++)
                {
                    if (ignore[i] != null)
                    {
                        Physics.IgnoreCollision(box, ignore[i]);
                    }
                }
            }

            Rigidbody body = renderer.gameObject.AddComponent<Rigidbody>();
            body.mass = m_mass;
            body.linearDamping = m_drag;
            body.angularDamping = m_angularDrag;
            body.interpolation = RigidbodyInterpolation.Interpolate;
            body.collisionDetectionMode = CollisionDetectionMode.Continuous;

            Vector2 drift = UnityEngine.Random.insideUnitCircle * m_maxDrift;
            body.linearVelocity = new Vector3(drift.x, 0f, drift.y);
            body.angularVelocity = UnityEngine.Random.insideUnitSphere * m_maxSpin;

            m_debris.Add(body);
        }

        private async void FreezeLaterAsync(CancellationToken cancellationToken)
        {
            try
            {
                await Awaitable.WaitForSecondsAsync(m_settleSeconds, cancellationToken);

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

        /// <summary>The root's direct children, thinned to <see cref="m_fraction"/> at random.</summary>
        private List<Transform> CollectPieces()
        {
            var pieces = new List<Transform>();
            Transform root = FindRoot();

            if (root == null)
            {
                return pieces;
            }

            for (int i = 0; i < root.childCount; i++)
            {
                Transform child = root.GetChild(i);

                if (child.gameObject.activeInHierarchy && UnityEngine.Random.value <= m_fraction)
                {
                    pieces.Add(child);
                }
            }

            return pieces;
        }

        private Transform FindRoot()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded)
                {
                    continue;
                }

                foreach (GameObject sceneRoot in scene.GetRootGameObjects())
                {
                    foreach (Transform child in sceneRoot.GetComponentsInChildren<Transform>(true))
                    {
                        if (child.name == m_rootName)
                        {
                            return child;
                        }
                    }
                }
            }

            return null;
        }
    }
}
