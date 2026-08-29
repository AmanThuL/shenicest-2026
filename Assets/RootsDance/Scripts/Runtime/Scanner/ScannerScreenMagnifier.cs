using System;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Makes the report readable by bringing the screen to the eye, not the eye to the screen.
    /// <para>
    /// The read used to fly a Cinemachine camera onto the plate, which moved the view off the
    /// player's head and read as a cutscene. It does not any more: the camera stays where it is,
    /// on the head, and this component lifts the world-space report canvas off the plate, squares
    /// it to the view and scales it up until it covers <see cref="m_screenFill"/> of the viewport.
    /// The player's head never moves; only the UI grows.
    /// </para>
    /// <para>
    /// The canvas is reparented to the eye for as long as the report is up, so it stops riding the
    /// hand — an arm that keeps animating under a magnified screen would swim the whole page around
    /// the view. Putting it back is <see cref="ScannerScreenSurface.Apply"/>'s job: the surface
    /// already owns the plate pose, measured off the plate mesh, so the home pose is never cached
    /// here and cannot go stale.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ScannerScreenMagnifier : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("Transform at the centre of the lit screen area — where the canvas lives when the "
            + "report is not being read.")]
        [SerializeField] private Transform m_screenAnchor;

        [Tooltip("The report canvas. Its own component writes the pose the canvas goes back to.")]
        [SerializeField] private ScannerScreenSurface m_surface;

        [Header("Reading pose")]
        [Tooltip("How much of the viewport the magnified report covers on its tighter axis. 1 "
            + "leaves no margin at all; a little under 1 keeps a border of the world around it.")]
        [Range(0.4f, 1f)]
        [SerializeField] private float m_screenFill = 0.86f;

        [Tooltip("How far in front of the eye the magnified report hangs, in metres. Only the "
            + "apparent size matters to the player, so this is really a depth-sorting knob: far "
            + "enough to clear the near clip plane and the helmet, near enough to sit in front of "
            + "the arm holding the scanner.")]
        [Range(0.2f, 2f)]
        [SerializeField] private float m_readDistanceMeters = 0.6f;

        [Tooltip("Fraction of the viewport the report is offset by, from the centre of the view. "
            + "Zero is dead centre.")]
        [SerializeField] private Vector2 m_viewOffset = Vector2.zero;

        [Tooltip("Seconds the screen takes to travel between the plate and the eye, each way. "
            + "Short on purpose: this is the player lifting something to look at it.")]
        [Range(0f, 1.5f)]
        [SerializeField] private float m_liftSeconds = 0.3f;

        private Camera m_eye;
        private bool m_isMagnified;

        /// <summary>True while the report is up at the eye rather than on the plate.</summary>
        public bool IsMagnified => m_isMagnified;

        /// <summary>Fraction of the viewport the magnified report covers. Serialized; see the class summary.</summary>
        public float ScreenFill => m_screenFill;

        /// <summary>
        /// The magnified canvas hangs off the camera, which outlives the scanner: a prop that is
        /// put away, unloaded with its level or destroyed mid-read would otherwise leave the report
        /// floating in front of the player with nothing left to close it.
        /// </summary>
        private void OnDisable()
        {
            if (m_isMagnified)
            {
                RestoreImmediate();
            }
        }

        /// <summary>
        /// Lifts the report to the eye over <see cref="m_liftSeconds"/>. Safe to call twice; the
        /// second call is dropped.
        /// </summary>
        public void Magnify()
        {
            if (m_isMagnified)
            {
                return;
            }

            Camera eye = ResolveEye();

            if (eye == null || !TryResolveCanvas(out RectTransform canvas))
            {
                return;
            }

            m_isMagnified = true;
            canvas.SetParent(eye.transform, true);
            _ = MoveAsync(canvas, MagnifiedPose(eye, canvas));
        }

        /// <summary>Puts the report back on the plate. Safe to call when it is already there.</summary>
        public void Restore()
        {
            if (!m_isMagnified)
            {
                return;
            }

            m_isMagnified = false;

            if (m_screenAnchor == null || !TryResolveCanvas(out RectTransform canvas))
            {
                return;
            }

            canvas.SetParent(m_screenAnchor, true);
            _ = MoveAsync(canvas, HomePose(canvas));
        }

        /// <summary>
        /// Writes the reading pose in one go, with no travel. The entry point for the headless
        /// capture tool and the tests, which have no frames to spend and no <c>Camera.main</c>.
        /// </summary>
        public void MagnifyImmediate(Camera eye)
        {
            if (eye == null || !TryResolveCanvas(out RectTransform canvas))
            {
                return;
            }

            m_isMagnified = true;
            m_eye = eye;
            canvas.SetParent(eye.transform, true);
            Write(canvas, MagnifiedPose(eye, canvas));
        }

        /// <summary>Puts the report back on the plate in one go, with no travel.</summary>
        public void RestoreImmediate()
        {
            m_isMagnified = false;

            if (m_screenAnchor == null || !TryResolveCanvas(out RectTransform canvas))
            {
                return;
            }

            canvas.SetParent(m_screenAnchor, false);
            m_surface.Apply();
        }

        /// <summary>
        /// Where the canvas sits while it is being read: squared to the view, centred on it, and
        /// scaled so it covers <see cref="m_screenFill"/> of the viewport at the reading distance.
        /// <para>
        /// The canvas is read from its forward — that is what a world-space uGUI canvas does — so
        /// facing the player means its forward matches the eye's, which in the eye's own space is
        /// an identity rotation. No look-at, and therefore nothing to go degenerate.
        /// </para>
        /// </summary>
        private LocalPose MagnifiedPose(Camera eye, RectTransform canvas)
        {
            float eyeScale = Mathf.Max(Mathf.Abs(eye.transform.lossyScale.x), 1e-9f);
            float distance = Mathf.Max(m_readDistanceMeters, eye.nearClipPlane * 1.5f);
            float aspect = eye.aspect;

            Vector2 viewport = ScreenFraming.ViewportSizeAt(distance, eye.fieldOfView, aspect);
            Vector2 reference = canvas.sizeDelta;
            float scale = ScreenFraming.ScaleForFill(reference, viewport, m_screenFill);

            var offset = new Vector3(
                m_viewOffset.x * viewport.x, m_viewOffset.y * viewport.y, distance);

            return new LocalPose
            {
                Position = offset / eyeScale,
                Rotation = Quaternion.identity,
                Scale = Vector3.one * (scale / eyeScale)
            };
        }

        /// <summary>
        /// Where the canvas sits when the report is down: whatever the surface writes for the
        /// plate. Read by asking the surface to write it and taking the result back off the
        /// transform, so the two can never drift apart.
        /// </summary>
        private LocalPose HomePose(RectTransform canvas)
        {
            Vector3 position = canvas.localPosition;
            Quaternion rotation = canvas.localRotation;
            Vector3 scale = canvas.localScale;

            m_surface.Apply();

            var home = new LocalPose
            {
                Position = canvas.localPosition,
                Rotation = canvas.localRotation,
                Scale = canvas.localScale
            };

            canvas.localPosition = position;
            canvas.localRotation = rotation;
            canvas.localScale = scale;

            return home;
        }

        /// <summary>
        /// Eases the canvas from where it is to <paramref name="target"/> in its current parent's
        /// space. A later call to <see cref="Magnify"/> or <see cref="Restore"/> reparents the
        /// canvas, which is what an in-flight travel checks for before it writes another frame.
        /// </summary>
        private async Awaitable MoveAsync(RectTransform canvas, LocalPose target)
        {
            Transform parent = canvas.parent;
            Vector3 fromPosition = canvas.localPosition;
            Quaternion fromRotation = canvas.localRotation;
            Vector3 fromScale = canvas.localScale;

            float elapsed = 0f;

            while (m_liftSeconds > 0f && elapsed < m_liftSeconds)
            {
                try
                {
                    await Awaitable.NextFrameAsync(destroyCancellationToken);
                }
                catch (OperationCanceledException)
                {
                    return;
                }

                if (canvas == null || canvas.parent != parent)
                {
                    return;
                }

                elapsed += Time.deltaTime;
                float t = Mathf.SmoothStep(0f, 1f, Mathf.Clamp01(elapsed / m_liftSeconds));

                canvas.localPosition = Vector3.Lerp(fromPosition, target.Position, t);
                canvas.localRotation = Quaternion.Slerp(fromRotation, target.Rotation, t);
                canvas.localScale = Vector3.Lerp(fromScale, target.Scale, t);
            }

            if (canvas != null && canvas.parent == parent)
            {
                Write(canvas, target);
            }
        }

        private static void Write(RectTransform canvas, LocalPose pose)
        {
            canvas.localPosition = pose.Position;
            canvas.localRotation = pose.Rotation;
            canvas.localScale = pose.Scale;
        }

        /// <summary>
        /// The player's eye. Looked up on demand rather than serialized because the camera lives in
        /// the bootstrap scene and the scanner in a level scene, so no reference can reach across.
        /// </summary>
        private Camera ResolveEye()
        {
            if (m_eye == null)
            {
                m_eye = Camera.main;
            }

            if (m_eye == null)
            {
                Log.Warning("ScannerScreenMagnifier found no main camera, so the report stays on "
                    + "the plate at plate size.", this);
            }

            return m_eye;
        }

        private bool TryResolveCanvas(out RectTransform canvas)
        {
            canvas = m_surface == null ? null : m_surface.transform as RectTransform;

            if (canvas == null)
            {
                Log.Error("ScannerScreenMagnifier has no report canvas to magnify.", this);
                return false;
            }

            return true;
        }

        /// <summary>A local transform, written in one go. Kept private: nothing else needs it.</summary>
        private struct LocalPose
        {
            public Vector3 Position;
            public Quaternion Rotation;
            public Vector3 Scale;
        }
    }
}
