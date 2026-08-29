using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Parks the inspect camera on the screen's normal, far enough back that the screen covers
    /// <see cref="m_screenFill"/> of the viewport. This is the knob the brief asks for: drag
    /// <c>Screen Fill</c> and the margin around the screen changes, in the Scene view, without
    /// entering play mode.
    /// <para>
    /// The camera is a child of the screen anchor, so it rides along with the hand for free and the
    /// pose is a purely local one. The anchor's forward is the reading direction — into the plate —
    /// so the camera stands back along -Z and needs no rotation of its own. The distance is in
    /// metres and the anchor's space is not, so it is divided by the anchor's scale on the way in.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public class ScannerInspectFraming : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("Transform at the centre of the lit screen area, forward = outward screen normal.")]
        [SerializeField] private Transform m_screenAnchor;

        [Tooltip("The camera parked in front of the screen. Must be a child of the anchor.")]
        [SerializeField] private CinemachineCamera m_camera;

        [Tooltip("Reads the physical size of the lit area. Empty falls back to the measured size.")]
        [SerializeField] private ScannerScreenSurface m_surface;

        [Header("Framing")]
        [Tooltip("How much of the viewport the screen covers on its tighter axis. 1 leaves no "
            + "margin at all; the brief asks for a thin border, so a little under 1.")]
        [Range(0.4f, 1f)]
        [SerializeField] private float m_screenFill = 0.86f;

        [Tooltip("Vertical field of view while reading. Narrow reads as a lens, wide as a lean-in.")]
        [Range(10f, 80f)]
        [SerializeField] private float m_fieldOfView = 34f;

        [Tooltip("Viewport aspect used while not playing, so the Scene view preview matches the "
            + "target build. In play mode the real screen aspect is used instead.")]
        [SerializeField] private float m_editorAspect = 16f / 9f;

        /// <summary>Fraction of the viewport the screen covers. Serialized; see the class summary.</summary>
        public float ScreenFill => m_screenFill;

        private void OnEnable()
        {
            Apply();
        }

        private void OnValidate()
        {
            Apply();
        }

        private void Update()
        {
            // Cheap, and it keeps the pose right while the anchor is dragged in the editor or the
            // game view is resized. Two float compares and a possible local-pose write.
            //
            // It also runs while the screen is actually up: the anchor rides the arm, and the arm
            // keeps animating during the read. Applying once on the way in would let the hand roll
            // the view back over as it settled.
            if (!Application.isPlaying || (m_camera != null && m_camera.gameObject.activeInHierarchy))
            {
                Apply();
            }
        }

        /// <summary>Recomputes and writes the camera's local pose and lens.</summary>
        public void Apply()
        {
            if (m_camera == null || m_screenAnchor == null)
            {
                return;
            }

            Vector2 size = m_surface == null
                ? ScannerScreenSurface.k_MeasuredActiveArea
                : m_surface.ActiveAreaMeters;

            float aspect = Application.isPlaying && Screen.height > 0
                ? (float)Screen.width / Screen.height
                : m_editorAspect;

            float distance = ScreenFraming.DistanceForFill(size, m_fieldOfView, aspect, m_screenFill);

            Transform camera = m_camera.transform;

            if (camera.parent != m_screenAnchor)
            {
                camera.SetParent(m_screenAnchor, false);
            }

            // Anchor forward is the reading direction, so standing back means -Z. The model's
            // transform chain carries a hundredfold scale, so a distance in metres has to be
            // converted before it is a local offset.
            float metresPerLocalUnit = Mathf.Max(Mathf.Abs(m_screenAnchor.lossyScale.x), 1e-9f);
            camera.localPosition = new Vector3(0f, 0f, -distance / metresPerLocalUnit);

            // Read the screen the way the screen is written: up on the report is up in the view.
            // Levelling against the world horizon instead was tried and is wrong — the anchor rides
            // the hand, the hand holds the scanner at an angle, and a camera that keeps the horizon
            // level therefore lands with the report turned on its side. What a player does with a
            // device in their hand is tilt their head to it, so the camera does the same.
            camera.localRotation = Quaternion.identity;

            LensSettings lens = m_camera.Lens;
            lens.FieldOfView = m_fieldOfView;
            m_camera.Lens = lens;
        }
    }
}
