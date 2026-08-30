using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// Sizes the world-space report canvas onto the physical screen plate of the scanner prop.
    /// <para>
    /// The numbers are measured, not eyeballed: the plate was separated out of the Body mesh in
    /// <c>SourceArt/Blender/Scanner/Scanner.blend</c> as the object <c>Screen</c>, and the lit
    /// rectangle inside it (the amber area of the baked texture) is 105.94 x 71.86 mm. The canvas
    /// covers exactly that rectangle, which leaves the baked bezel strips — the icon row along the
    /// top and the button legends along the bottom — showing around the live UI. That overlap is
    /// the whole reason the UI reads as belonging to the prop.
    /// </para>
    /// <para>
    /// One canvas pixel is 0.1 mm, so the reference resolution and the physical size stay in an
    /// obvious relation and the kit's metrics (u = 4 px, Row = 40 px) land at a sane physical size.
    /// Runs with <c>[ExecuteAlways]</c> so the fit can be judged in the Scene view.
    /// </para>
    /// <para>
    /// Two things here are easy to get backwards and are both deliberate. The anchor's forward is
    /// the <i>reading</i> direction — from the viewer into the plate — because that is the direction
    /// a world-space uGUI canvas with an identity rotation is read from; pointing it out of the
    /// plate instead renders the whole screen mirrored. And every physical measurement is divided
    /// by the parent's scale before it is written, because the imported model carries a hundredfold
    /// scale on its transform chain and metres are not local units there.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Canvas))]
    [RequireComponent(typeof(RectTransform))]
    public class ScannerScreenSurface : MonoBehaviour
    {
        /// <summary>Measured lit area of the plate, in metres. See the class summary.</summary>
        public static readonly Vector2 k_MeasuredActiveArea = new Vector2(0.10594f, 0.07186f);

        [Tooltip("Measure the lit area from the plate mesh instead of trusting the number below. "
            + "Leave on: a typed-in size goes stale the moment the model is rescaled.")]
        [SerializeField] private bool m_measureFromPlate = true;

        [Tooltip("The lit plate. Its mesh is measured when the option above is on.")]
        [SerializeField] private Renderer m_plate;

        [Tooltip("Physical size of the lit screen area in metres. Used only when measuring is off, "
            + "or when no plate is assigned.")]
        [SerializeField] private Vector2 m_activeAreaMeters = k_MeasuredActiveArea;

        [Tooltip("Canvas size in reference pixels. 1060 x 719 keeps one pixel at 0.1 mm.")]
        [SerializeField] private Vector2Int m_referenceResolution = new Vector2Int(1060, 719);

        [Tooltip("How far out of the plate, towards the viewer, the canvas floats, in millimetres. "
            + "Enough to clear the baked surface without reading as a gap.")]
        [Range(0f, 5f)]
        [SerializeField] private float m_standoffMillimetres = 0.6f;

        /// <summary>Physical size of the lit area, in metres. What the camera framing measures.</summary>
        public Vector2 ActiveAreaMeters => ResolveActiveArea();

        private Canvas m_canvas;

        private void Awake()
        {
            m_canvas = GetComponent<Canvas>();
        }

        private void OnEnable()
        {
            Apply();
        }

        private void Update()
        {
            // A world-space Canvas needs an explicit worldCamera or GraphicRaycaster silently
            // finds no hits — there is no automatic fallback to Camera.main the way
            // ScreenSpaceCamera gets one. Polled rather than set once, because the scene's active
            // camera can change (the inspect camera taking over is exactly that) and Camera.main
            // is cheap (a tag lookup, not a scene search).
            if (Application.isPlaying && m_canvas != null && m_canvas.worldCamera == null)
            {
                m_canvas.worldCamera = Camera.main;
            }
        }

        private void OnValidate()
        {
            m_referenceResolution.x = Mathf.Max(1, m_referenceResolution.x);
            m_referenceResolution.y = Mathf.Max(1, m_referenceResolution.y);
            Apply();
        }

        /// <summary>
        /// Writes the canvas rect, scale and standoff. Safe to call at any time; it only touches
        /// this object's own RectTransform.
        /// </summary>
        public void Apply()
        {
            RectTransform rect = (RectTransform)transform;

            rect.sizeDelta = new Vector2(m_referenceResolution.x, m_referenceResolution.y);
            rect.anchorMin = new Vector2(0.5f, 0.5f);
            rect.anchorMax = new Vector2(0.5f, 0.5f);
            rect.pivot = new Vector2(0.5f, 0.5f);

            // Uniform scale from the width. The reference resolution is authored at the plate's
            // aspect, so deriving both axes separately would only hide an authoring mistake.
            float metresPerLocalUnit = ParentScale();
            float scale = ResolveActiveArea().x / m_referenceResolution.x / metresPerLocalUnit;
            rect.localScale = new Vector3(scale, scale, scale);

            // Forward is the reading direction, so floating clear of the plate means -Z.
            rect.localPosition = new Vector3(0f, 0f,
                -m_standoffMillimetres * 0.001f / metresPerLocalUnit);
            rect.localRotation = Quaternion.identity;
        }

        /// <summary>
        /// The lit area, measured off the plate when possible.
        /// <para>
        /// Measuring rather than trusting a constant matters because the constant has already gone
        /// stale once: it was taken off the model before the scanner master was resized, after
        /// which the canvas was half again too big and spilled past the bezel. A measured plate
        /// cannot drift from the art it is drawn on.
        /// </para>
        /// </summary>
        private Vector2 ResolveActiveArea()
        {
            if (!m_measureFromPlate || m_plate == null)
            {
                return m_activeAreaMeters;
            }

            var filter = m_plate.GetComponent<MeshFilter>();
            Mesh mesh = filter == null ? null : filter.sharedMesh;

            if (mesh == null)
            {
                return m_activeAreaMeters;
            }

            // The plate can sit at any orientation, so a world AABB would over-measure it. Project
            // the mesh corners onto this canvas's own right and up instead.
            Bounds local = mesh.bounds;
            Vector3 right = transform.right;
            Vector3 up = transform.up;
            float minX = float.MaxValue, maxX = float.MinValue;
            float minY = float.MaxValue, maxY = float.MinValue;

            for (int i = 0; i < 8; i++)
            {
                var corner = new Vector3(
                    (i & 1) == 0 ? local.min.x : local.max.x,
                    (i & 2) == 0 ? local.min.y : local.max.y,
                    (i & 4) == 0 ? local.min.z : local.max.z);

                Vector3 world = m_plate.transform.TransformPoint(corner);
                float x = Vector3.Dot(world, right);
                float y = Vector3.Dot(world, up);

                minX = Mathf.Min(minX, x);
                maxX = Mathf.Max(maxX, x);
                minY = Mathf.Min(minY, y);
                maxY = Mathf.Max(maxY, y);
            }

            Vector2 measured = new Vector2(maxX - minX, maxY - minY);

            return measured.x < 1e-5f || measured.y < 1e-5f ? m_activeAreaMeters : measured;
        }

        /// <summary>
        /// How many metres one local unit of the parent is worth. The FBX comes in with a scale of
        /// 100 on its transform chain, so writing a size in metres straight into localScale would
        /// make the screen a hundred times too big.
        /// </summary>
        private float ParentScale()
        {
            Transform parent = transform.parent;

            return parent == null ? 1f : Mathf.Max(Mathf.Abs(parent.lossyScale.x), 1e-9f);
        }
    }
}
