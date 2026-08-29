using RootsDance.Core;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// A thin segmented rule that fills left to right, drawn as lit dots into a texture on the same
    /// raster as <see cref="DotMatrixText"/> — so it lives inside the low-resolution buffer, and the
    /// composite pass gives it the same grain and bleed as every other line on the screen rather than
    /// letting it read as a modern UI widget pasted on top.
    /// <para>
    /// It carries no label, no percentage and no frame. It is chrome: the lit colour stays inside the
    /// spec's chrome ceiling (低保真终端式UI规范 §3, peak ≤ 158) so it never competes with the caption
    /// block above it or with the stage.
    /// </para>
    /// <para>
    /// Filling is discrete — a cell is lit or it is not. Nothing here interpolates, and the rule
    /// redraws only when the lit count actually changes, not once per frame.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [RequireComponent(typeof(RawImage))]
    public class TerminalProgressRule : MonoBehaviour
    {
        [Tooltip("Cells across the rule. 38 cells of 6 dots with a 2-dot gap spans 302 of the caption "
            + "block's 304 dots.")]
        [Min(1)]
        [SerializeField] private int m_segmentCount = 38;

        [Min(1)]
        [SerializeField] private int m_segmentDots = 6;

        [Min(0)]
        [SerializeField] private int m_gapDots = 2;

        [Tooltip("Rule height in dots. One is the spec's line core; two already reads as a bar.")]
        [Min(1)]
        [SerializeField] private int m_thicknessDots = 1;

        [Tooltip("Rule inner (#956D68). A lit cell.")]
        [SerializeField] private Color m_litColor = new Color32(149, 109, 104, 255);

        [Tooltip("Border channel (#76483F). Brighter than the ground, darker than a lit cell — the "
            + "rule's full length stays readable before anything fills it.")]
        [SerializeField] private Color m_dimColor = new Color32(118, 72, 63, 255);

        private RawImage m_image;

        private Texture2D m_texture;

        /// <summary>Cells currently drawn lit. -1 forces the first draw.</summary>
        private int m_litSegments = -1;

        private bool m_rebuildQueued;

        /// <summary>
        /// How far the rule is filled, 0..1. Setting it redraws only when it crosses a cell boundary,
        /// which is at most <see cref="m_segmentCount"/> redraws over a whole load.
        /// </summary>
        public float Progress
        {
            set
            {
                int lit = LoadProgress.LitSegments(value, m_segmentCount);

                if (lit == m_litSegments)
                {
                    return;
                }

                m_litSegments = lit;
                Rebuild();
            }
        }

        /// <summary>The rule's rect, sized to the generated texture on every rebuild.</summary>
        public RectTransform RectTransform
        {
            get { return (RectTransform)transform; }
        }

        private void Awake()
        {
            m_image = GetComponent<RawImage>();
        }

        private void OnEnable()
        {
            // Queued, not built here: Rebuild sizes the rect, and Unity refuses the resulting
            // OnRectTransformDimensionsChange on an object that is still being constructed.
            m_rebuildQueued = true;
        }

        private void OnDestroy()
        {
            ReleaseTexture();
        }

        private void OnValidate()
        {
            m_rebuildQueued = true;
        }

        private void Update()
        {
            if (!m_rebuildQueued)
            {
                return;
            }

            m_rebuildQueued = false;
            Rebuild();
        }

        public void Rebuild()
        {
            if (m_image == null)
            {
                m_image = GetComponent<RawImage>();
            }

            if (m_image == null)
            {
                return;
            }

            int advance = m_segmentDots + m_gapDots;
            int width = m_segmentCount * advance - m_gapDots;
            int height = m_thicknessDots;
            int lit = Mathf.Clamp(m_litSegments, 0, m_segmentCount);

            ReleaseTexture();

            m_texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            m_texture.filterMode = FilterMode.Point;
            m_texture.wrapMode = TextureWrapMode.Clamp;

            // Never serialized: the rule regenerates on enable, so letting Unity save the texture
            // would embed derived pixels in every prefab holding one.
            m_texture.hideFlags = HideFlags.HideAndDontSave;

            Color32[] pixels = new Color32[width * height];
            Color32 on = m_litColor;
            Color32 off = m_dimColor;

            for (int cell = 0; cell < m_segmentCount; cell++)
            {
                Color32 colour = cell < lit ? on : off;
                int originX = cell * advance;

                for (int y = 0; y < height; y++)
                {
                    for (int x = 0; x < m_segmentDots; x++)
                    {
                        pixels[y * width + originX + x] = colour;
                    }
                }
            }

            m_texture.SetPixels32(pixels);
            m_texture.Apply();

            m_image.texture = m_texture;
            m_image.color = Color.white;
            m_image.rectTransform.sizeDelta = new Vector2(width, height);
        }

        private void ReleaseTexture()
        {
            if (m_texture == null)
            {
                return;
            }

            if (Application.isPlaying)
            {
                Destroy(m_texture);
            }
            else
            {
                DestroyImmediate(m_texture);
            }

            m_texture = null;
        }
    }
}
