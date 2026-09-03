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
    /// <see cref="GreenhouseStairCollapse"/> finds the intact stair. Each child of that object is
    /// one clump of leaf cards and falls as one thing.
    /// </para>
    /// <para>
    /// The fall is scripted, not simulated. A clump hangs inside the roof's frame grid, and any
    /// collider wide enough to stand for a mat of ivy lands on the first beam under it and stays
    /// there — half the roof "fell" a few centimetres and stopped. So a clump has no collider and
    /// no body: it drifts down under gravity with drag like a wet mat, a sphere cast from its
    /// centre finds what is under it, and the moment it reaches a surface wide enough to have
    /// caught it — floor, terrace or fallen deck, never a beam — it is gone, switched off where it
    /// hit. Nothing lies around afterwards: a mat of ivy on the floor of a collapse is not a thing
    /// the level wants to keep, and a mat parked on a strip of frame reads as floating. The player
    /// is never something it can land on.
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
        [Tooltip("Linear drag, per second. High enough that a clump drifts down instead of "
            + "dropping: terminal speed is gravity divided by this.")]
        [Min(0f)]
        [SerializeField] private float m_drag = 1.1f;

        [Tooltip("Random tumble per clump, degrees per second at most.")]
        [Min(0f)]
        [SerializeField] private float m_maxSpin = 40f;

        [Tooltip("Sideways drift per clump, metres per second at most, so the fall is not a plumb line.")]
        [Min(0f)]
        [SerializeField] private float m_maxDrift = 0.6f;

        [Tooltip("Radius of the cast that looks for the landing under a clump. Narrow enough to "
            + "slip between the roof's beams, wide enough not to thread a gap in the debris.")]
        [Min(0.05f)]
        [SerializeField] private float m_castRadius = 0.25f;

        [Tooltip("Steepest surface a clump may come to rest on, degrees off horizontal.")]
        [Range(0f, 89f)]
        [SerializeField] private float m_maxLandingSlope = 60f;

        [Tooltip("Seconds after which a clump still falling is put down wherever it is.")]
        [Min(1f)]
        [SerializeField] private float m_maxFallSeconds = 12f;

        /// <summary>
        /// Metres a released clump must drop to count as fallen — and, the same number, how far
        /// under where it hung the first possible landing is. Anything closer is what it hung from.
        /// </summary>
        private const float k_FellAtLeast = 1f;

        /// <summary>Height band, metres, within which the corner rays must agree with the centre's landing.</summary>
        private const float k_LandingBandMetres = 0.6f;

        /// <summary>How far in from the cards' bounds the corner rays are dropped; the bounds overstate the mat.</summary>
        private const float k_FootprintScale = 0.6f;

        /// <summary>Corner rays that must find the surface for it to count as carrying the clump.</summary>
        private const int k_CornersNeeded = 3;

        private readonly List<Transform> m_released = new List<Transform>();
        private readonly List<float> m_releasedFrom = new List<float>();
        private IReadOnlyList<Collider> m_ignore;
        private int m_falling;
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
            m_ignore = ignore;
            ShedAsync(Mathf.Max(m_earliestSeconds, windowSeconds + m_trailingSeconds), destroyCancellationToken);
        }

        /// <summary>Every piece gone at once, silently: the rescue restore, where there is no beat to play.</summary>
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
                if (pieces[i] != null)
                {
                    pieces[i].gameObject.SetActive(false);
                }
            }
        }

        /// <summary>
        /// One frame of the fall: gravity pulls, drag holds back, and the speed can never pass
        /// the terminal speed the two agree on. Pure so the drag model is testable on its own.
        /// </summary>
        public static float FallStep(float downwardSpeed, float gravity, float drag, float deltaTime)
        {
            float speed = downwardSpeed + gravity * deltaTime;
            speed /= 1f + drag * deltaTime;

            return drag > 0f ? Mathf.Min(speed, gravity / drag) : speed;
        }

        private async void ShedAsync(float windowSeconds, CancellationToken cancellationToken)
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
                        Release(ordered[released], cancellationToken);
                        released++;
                    }

                    if (released < ordered.Length)
                    {
                        await Awaitable.NextFrameAsync(cancellationToken);
                    }
                }

                while (m_falling > 0)
                {
                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                ReportStuck();
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

        private void Release(Transform piece, CancellationToken cancellationToken)
        {
            if (piece == null || !Footprint(piece, out _))
            {
                return;
            }

            m_released.Add(piece);
            m_releasedFrom.Add(piece.position.y);
            m_falling++;
            FallAsync(piece, cancellationToken);
        }

        /// <summary>
        /// The clump's descent, one frame at a time, until the cast under its centre meets a
        /// surface it can lie on. Nothing here touches PhysX state: the transform is moved, the
        /// world is only ever queried.
        /// </summary>
        private async void FallAsync(Transform piece, CancellationToken cancellationToken)
        {
            try
            {
                float gravity = -Physics.gravity.y;
                float speed = 0f;
                Vector2 drift2 = UnityEngine.Random.insideUnitCircle * m_maxDrift;
                Vector3 drift = new Vector3(drift2.x, 0f, drift2.y);
                Vector3 spinAxis = UnityEngine.Random.onUnitSphere;
                float spin = UnityEngine.Random.Range(0.3f, 1f) * m_maxSpin;
                float start = Time.time;
                bool landed = false;

                // Nothing within the first metre under where the clump hung is a landing: that is
                // the sill, beam or frame it grew against, and a clump that "falls" onto it has not
                // fallen. Fixed at release so the rule cannot chase the clump down.
                Footprint(piece, out Bounds hung);
                float ceiling = hung.min.y - k_FellAtLeast;

                while (piece != null && Time.time - start < m_maxFallSeconds)
                {
                    float deltaTime = Time.deltaTime;
                    speed = FallStep(speed, gravity, m_drag, deltaTime);
                    float step = speed * deltaTime;

                    if (!Footprint(piece, out Bounds bounds))
                    {
                        break;
                    }

                    // The cast reaches from the centre down past the clump's own bottom edge by
                    // this frame's step, so a landing is found before the bottom passes through it.
                    float reach = bounds.center.y - bounds.min.y + step;

                    if (FindLanding(bounds, ceiling, reach, out RaycastHit _))
                    {
                        piece.gameObject.SetActive(false);
                        landed = true;
                        break;
                    }

                    piece.position += Vector3.down * step + drift * deltaTime;
                    piece.Rotate(spinAxis, spin * deltaTime, Space.World);

                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                // Out of time and still in the air (a hole in the floor, a gap in the debris):
                // gone anyway, rather than left hanging where it stopped.
                if (!landed && piece != null)
                {
                    piece.gameObject.SetActive(false);
                }
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
                m_falling--;
            }
        }

        /// <summary>
        /// The first thing under the clump it could come to rest on: solid, not the player, facing
        /// up enough to hold it, <b>below <paramref name="ceiling"/></b>, and <b>wide enough to
        /// carry the whole mat</b>. The cast starts at the clump's centre, and a clump grows
        /// around the beam it hangs from, so the first thing the cast meets is often that beam —
        /// or a sill a hand's width under it, or a frame member metres down. A landing on any of
        /// those parks a two-metre mat on a strip of steel, which reads as the mat floating beside
        /// whoever just fell past it. So a candidate surface is only a landing if rays dropped from
        /// the corners of the clump's footprint mostly meet it too, at the same height: the floor
        /// and the debris pile pass, a beam or a glass edge does not, and the clump keeps falling.
        /// </summary>
        private bool FindLanding(Bounds footprint, float ceiling, float maxDistance, out RaycastHit landing)
        {
            Vector3 from = footprint.center;
            RaycastHit[] hits = Physics.SphereCastAll(from, m_castRadius, Vector3.down, maxDistance,
                Physics.DefaultRaycastLayers, QueryTriggerInteraction.Ignore);

            Array.Sort(hits, (a, b) => a.distance.CompareTo(b.distance));

            for (int i = 0; i < hits.Length; i++)
            {
                RaycastHit hit = hits[i];

                // A cast that starts inside a collider reports it at distance 0 with no useful
                // normal: that is the roof structure the clump grew in, not a landing.
                if (hit.distance <= 0f || hit.point.y > ceiling || IsIgnored(hit.collider))
                {
                    continue;
                }

                if (Vector3.Angle(hit.normal, Vector3.up) > m_maxLandingSlope)
                {
                    continue;
                }

                if (!CarriesTheWholeMat(footprint, hit.point.y, ceiling))
                {
                    continue;
                }

                landing = hit;
                return true;
            }

            landing = default;
            return false;
        }

        /// <summary>
        /// Whether a surface at <paramref name="surfaceY"/> is there under most of the clump, not
        /// just under its centre: rays from the four corners of the footprint (pulled in a little,
        /// since the cards' bounds overstate the mat) must find an up-facing surface within
        /// <see cref="k_LandingBandMetres"/> of that height. Three of four is enough — a mat may
        /// hang a corner over the edge of the pile.
        /// </summary>
        private bool CarriesTheWholeMat(Bounds footprint, float surfaceY, float ceiling)
        {
            Vector3 extents = footprint.extents * k_FootprintScale;
            float top = footprint.center.y;
            float reach = top - surfaceY + k_LandingBandMetres;
            int carried = 0;

            for (int i = 0; i < 4; i++)
            {
                float x = (i & 1) == 0 ? -extents.x : extents.x;
                float z = (i & 2) == 0 ? -extents.z : extents.z;
                Vector3 origin = new Vector3(footprint.center.x + x, top, footprint.center.z + z);

                RaycastHit[] hits = Physics.RaycastAll(origin, Vector3.down, reach,
                    Physics.DefaultRaycastLayers, QueryTriggerInteraction.Ignore);

                for (int j = 0; j < hits.Length; j++)
                {
                    RaycastHit hit = hits[j];

                    if (hit.point.y > ceiling || IsIgnored(hit.collider)
                        || Vector3.Angle(hit.normal, Vector3.up) > m_maxLandingSlope
                        || Mathf.Abs(hit.point.y - surfaceY) > k_LandingBandMetres)
                    {
                        continue;
                    }

                    carried++;
                    break;
                }
            }

            return carried >= k_CornersNeeded;
        }

        private bool IsIgnored(Collider collider)
        {
            if (m_ignore == null)
            {
                return false;
            }

            for (int i = 0; i < m_ignore.Count; i++)
            {
                if (m_ignore[i] == collider)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// World bounds of what the clump actually draws. The clump's own pivot is wherever the
        /// level author left it — metres below the cards on some — so nothing about the fall may be
        /// measured from the transform.
        /// </summary>
        private static bool Footprint(Transform piece, out Bounds bounds)
        {
            Renderer[] renderers = piece.GetComponentsInChildren<Renderer>();

            if (renderers.Length == 0)
            {
                bounds = new Bounds(piece.position, Vector3.zero);
                return false;
            }

            bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return true;
        }

        /// <summary>
        /// A clump that is still on after its fall was let go and never went — the one failure this
        /// beat has had, and one nothing else reports. Also names how far each one fell before it
        /// went, so a clump vanishing a metre under the roof shows up as a number, not a feeling.
        /// </summary>
        private void ReportStuck()
        {
            int stuck = 0;
            var drops = new System.Text.StringBuilder();

            for (int i = 0; i < m_released.Count; i++)
            {
                if (m_released[i] == null)
                {
                    continue;
                }

                if (m_released[i].gameObject.activeSelf)
                {
                    stuck++;
                }

                drops.Append(drops.Length > 0 ? ", " : "")
                    .Append(m_released[i].name).Append(' ')
                    .Append((m_releasedFrom[i] - m_released[i].position.y).ToString("0.0")).Append(" m");
            }

            if (stuck > 0)
            {
                Log.Warning($"[roof] {stuck} of {m_released.Count} pieces are still up after the fall. Drops: {drops}", this);
            }
            else
            {
                Log.Info($"[roof] all {m_released.Count} pieces down and gone. Drops: {drops}", this);
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
