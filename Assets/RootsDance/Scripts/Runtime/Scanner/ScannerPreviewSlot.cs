using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// The turning model in the report's left-hand slot. The model is a real object standing a few
    /// millimetres in front of the world-space canvas, not a render-texture preview: the scanner's
    /// screen is already a surface in the world, so a small object hovering over it reads as a
    /// projection and costs no second camera, no extra layer and no render target.
    /// <para>
    /// Sizing is derived from the slot's own RectTransform, so moving or resizing the slot in the
    /// UI moves and resizes the model with it and nothing has to be re-tuned by hand.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ScannerPreviewSlot : MonoBehaviour
    {
        [Tooltip("The UI cell the model sits in front of. Its world size sets the model's size.")]
        [SerializeField] private RectTransform m_slot;

        [Tooltip("How far in front of the canvas the model floats, in millimetres.")]
        [Range(0f, 40f)]
        [SerializeField] private float m_depthMillimetres = 8f;

        [Tooltip("Fraction of the slot the model's largest dimension fills.")]
        [Range(0.2f, 1f)]
        [SerializeField] private float m_fill = 0.7f;

        [Tooltip("Turn rate, degrees per second, about the slot's up axis.")]
        [SerializeField] private float m_degreesPerSecond = 32f;

        [Tooltip("Tilt so the model is seen slightly from above, degrees.")]
        [Range(-45f, 45f)]
        [SerializeField] private float m_tiltDegrees = 12f;

        private Transform m_pivot;
        private GameObject m_instance;
        private GameObject m_source;
        private float m_angle;

        private void Awake()
        {
            EnsurePivot();
        }

        private void Update()
        {
            if (m_instance == null)
            {
                return;
            }

            m_angle += m_degreesPerSecond * Time.deltaTime;

            if (m_angle >= 360f)
            {
                m_angle -= 360f;
            }

            m_pivot.localRotation = Quaternion.Euler(m_tiltDegrees, m_angle, 0f);
        }

        /// <summary>
        /// Puts <paramref name="prefab"/> in the slot, scaled to fit. Passing the same prefab twice
        /// keeps the model turning rather than restarting it; passing null empties the slot.
        /// </summary>
        public void Show(GameObject prefab)
        {
            if (prefab == m_source)
            {
                return;
            }

            m_source = prefab;

            if (m_instance != null)
            {
                Destroy(m_instance);
                m_instance = null;
            }

            if (prefab == null)
            {
                return;
            }

            if (m_slot == null)
            {
                Log.Error("ScannerPreviewSlot has no slot RectTransform; nothing was shown.", this);
                return;
            }

            EnsurePivot();

            m_instance = Instantiate(prefab, m_pivot);
            m_instance.transform.localRotation = Quaternion.identity;
            Fit(m_instance);
        }

        private void EnsurePivot()
        {
            if (m_pivot != null)
            {
                return;
            }

            GameObject pivot = new GameObject("PreviewPivot");
            m_pivot = pivot.transform;
            m_pivot.SetParent(transform, false);
        }

        /// <summary>
        /// Centres the instance on the slot and scales it so its largest dimension covers
        /// <see cref="m_fill"/> of the slot's shorter side.
        /// </summary>
        private void Fit(GameObject instance)
        {
            Renderer[] renderers = instance.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                Log.Warning("ScannerPreviewSlot was given a model with no renderers.", this);
                return;
            }

            // Bounds in the instance's own space, not the world's: the pivot is tilted and turning,
            // and world bounds of a rotated object change size with the angle.
            Transform model = instance.transform;
            model.localPosition = Vector3.zero;
            model.localRotation = Quaternion.identity;
            model.localScale = Vector3.one;

            Matrix4x4 toLocal = model.worldToLocalMatrix;
            Bounds bounds = new Bounds(toLocal.MultiplyPoint3x4(renderers[0].bounds.center), Vector3.zero);

            for (int i = 0; i < renderers.Length; i++)
            {
                Bounds world = renderers[i].bounds;
                Vector3 min = world.min;
                Vector3 max = world.max;

                for (int corner = 0; corner < 8; corner++)
                {
                    Vector3 point = new Vector3(
                        (corner & 1) == 0 ? min.x : max.x,
                        (corner & 2) == 0 ? min.y : max.y,
                        (corner & 4) == 0 ? min.z : max.z);
                    bounds.Encapsulate(toLocal.MultiplyPoint3x4(point));
                }
            }

            // The slot is a UI rect on a scaled canvas, so its world size is the rect size times the
            // canvas scale. The shorter side is what has to hold the model.
            Vector3 canvasScale = m_slot.lossyScale;
            float slotWidth = m_slot.rect.width * canvasScale.x;
            float slotHeight = m_slot.rect.height * canvasScale.y;
            float slotSide = Mathf.Min(slotWidth, slotHeight);

            float modelSide = Mathf.Max(bounds.size.x, Mathf.Max(bounds.size.y, bounds.size.z));
            float scale = modelSide <= 0.0001f ? 1f : slotSide * m_fill / modelSide;

            // Park the pivot on the slot's centre, pushed out along the canvas normal.
            m_pivot.position = m_slot.TransformPoint(m_slot.rect.center);
            m_pivot.position += m_slot.forward * (m_depthMillimetres * 0.001f);
            m_pivot.rotation = m_slot.rotation;

            model.localScale = Vector3.one * scale;

            // Re-centre on the model's own middle, which is rarely where its pivot sits.
            model.localPosition = -bounds.center * scale;
        }
    }
}
