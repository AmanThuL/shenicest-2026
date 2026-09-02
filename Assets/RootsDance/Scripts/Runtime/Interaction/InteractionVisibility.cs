using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// The "is it on screen" half of every interaction offer. Shared so that picking a prop up,
    /// reading a sheet, scanning a target and looking at a sign all answer the question the same
    /// way, and so the answer can be changed in one place.
    /// <para>
    /// Partially visible counts. The test is the object's bounding box against the camera frustum,
    /// which is deliberately generous: the player never sees a crosshair, so the rule they can
    /// actually learn is "it is near me and I can see it", not "a hidden point is on top of it".
    /// </para>
    /// </summary>
    public static class InteractionVisibility
    {
        private static readonly Plane[] s_planes = new Plane[6];

        private static Camera s_camera;
        private static int s_frame = -1;

        /// <summary>True when any part of <paramref name="bounds"/> is inside the camera frustum.</summary>
        /// <remarks>
        /// The planes are rebuilt at most once per camera per frame and kept in a shared buffer, so
        /// a screen full of candidates costs one frustum build, not one per candidate. A missing
        /// camera answers true: an offer that cannot be tested is better shown than silently
        /// withheld, which is the failure this whole rule exists to remove.
        /// </remarks>
        public static bool IsOnScreen(Camera camera, Bounds bounds)
        {
            if (camera == null)
            {
                camera = ResolveCamera();
            }

            if (camera == null)
            {
                // Nothing to test against. This is a broken scene, not a normal state, and it used
                // to pass silently — which switched the whole in-view rule off and put hints up for
                // anything in range no matter where the player was looking.
                Log.Warning("InteractionVisibility found no camera; the on-screen rule is not running.",
                    null);
                return true;
            }

            if (s_frame != Time.frameCount || s_camera != camera)
            {
                GeometryUtility.CalculateFrustumPlanes(camera, s_planes);
                s_camera = camera;
                s_frame = Time.frameCount;
            }

            return GeometryUtility.TestPlanesAABB(s_planes, bounds);
        }

        /// <summary>
        /// The camera the rule is judged against. <see cref="Camera.main"/> needs the MainCamera
        /// tag, and a level played without the bootstrap scene — or with the tag missing — has
        /// none, so the first live camera is taken instead rather than giving up.
        /// </summary>
        public static Camera ResolveCamera()
        {
            Camera main = Camera.main;

            if (main != null)
            {
                return main;
            }

            Camera best = null;

            for (int i = 0; i < Camera.allCamerasCount; i++)
            {
                Camera candidate = Camera.allCameras[i];

                if (candidate == null || !candidate.isActiveAndEnabled)
                {
                    continue;
                }

                // Highest depth is the one that ends up on screen last, so it is what the player
                // is actually looking through.
                if (best == null || candidate.depth > best.depth)
                {
                    best = candidate;
                }
            }

            return best;
        }

        /// <summary>
        /// What the player can actually see of <paramref name="target"/>: its renderers, falling
        /// back to its collider. The two are not interchangeable — an interaction collider is often
        /// a box far larger than the prop inside it, and testing that box puts the hint up while
        /// the visible object is still well off screen.
        /// </summary>
        public static bool TryGetVisualBounds(Component target, out Bounds bounds)
        {
            bounds = new Bounds();

            if (target == null)
            {
                return false;
            }

            bool found = false;

            foreach (Renderer renderer in target.GetComponentsInChildren<Renderer>())
            {
                if (renderer == null || !renderer.enabled)
                {
                    continue;
                }

                if (!found)
                {
                    bounds = renderer.bounds;
                    found = true;
                }
                else
                {
                    bounds.Encapsulate(renderer.bounds);
                }
            }

            if (found)
            {
                return true;
            }

            Collider collider = target.GetComponentInChildren<Collider>();

            if (collider == null)
            {
                return false;
            }

            bounds = collider.bounds;

            return true;
        }

        /// <summary>
        /// True when any part of <paramref name="target"/> is on screen to the main camera. The
        /// form the per-verb triggers use, so none of them has to carry a camera reference of its
        /// own just to answer a question the whole game answers the same way.
        /// </summary>
        public static bool IsOnScreen(Component target)
        {
            return IsOnScreen(Camera.main, target);
        }

        /// <summary>
        /// True when any part of <paramref name="target"/> is on screen, measured from whatever it
        /// has to measure: its collider first, then its renderers, and failing both its pivot.
        /// </summary>
        /// <remarks>
        /// The pivot fallback is a point, not a box, so an object with neither a collider nor a
        /// renderer is offered only when the pivot itself is in frame. That is the honest answer
        /// for a thing with no extent — and every interactable that matters has one of the two.
        /// </remarks>
        public static bool IsOnScreen(Camera camera, Component target)
        {
            if (target == null)
            {
                return false;
            }

            if (!TryGetVisualBounds(target, out Bounds bounds))
            {
                bounds = new Bounds(target.transform.position, Vector3.zero);
            }

            return IsOnScreen(camera, bounds);
        }
    }
}
