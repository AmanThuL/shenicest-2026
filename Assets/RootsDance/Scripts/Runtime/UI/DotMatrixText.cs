using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// A line of text drawn as lit dots into a texture, on the same raster as everything else on the
    /// screen. This is deliberately not TextMeshPro: the reference sequence's glyphs are three dots
    /// wide (see <see cref="DotMatrixGlyphs"/>), and an antialiased vector face at that size reads as
    /// a modern UI label no matter how the tracking is set. Project rule 18 (TMP for all text) still
    /// holds for ordinary HUD text; this screen is the documented exception.
    /// <para>
    /// The glyphs are drawn hard-edged and unglowed. All softness comes from the composite pass, so
    /// the text bleeds exactly like the rest of the signal instead of carrying its own effect.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [RequireComponent(typeof(RawImage))]
    public class DotMatrixText : MonoBehaviour
    {
        [Tooltip("Upper case only; unknown characters render as spaces.")]
        [SerializeField] private string m_text = string.Empty;

        [Tooltip("Screen pixels per dot, in the low-resolution buffer. Integer, or the grid breaks.")]
        [Min(1)]
        [SerializeField] private int m_dotScale = 1;

        [Tooltip("Dots of tracking between glyphs. The reference sits at 1; the title bar label at 2.")]
        [Min(0)]
        [SerializeField] private int m_tracking = 1;

        [SerializeField] private Color m_color = Color.white;

        private RawImage m_image;

        private Texture2D m_texture;

        private int m_visibleCharacters = int.MaxValue;

        /// <summary>The whole line, including characters currently hidden by a write.</summary>
        public string Text
        {
            get { return m_text; }
            set
            {
                m_text = value == null ? string.Empty : value;
                Rebuild();
            }
        }

        /// <summary>How many leading characters are lit. Drives TerminalMotion.TerminalWrite.</summary>
        public int VisibleCharacters
        {
            get { return m_visibleCharacters; }
            set
            {
                m_visibleCharacters = value;
                Rebuild();
            }
        }

        public int CharacterCount
        {
            get { return m_text.Length; }
        }

        /// <summary>The line's rect, sized to the generated texture on every rebuild.</summary>
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
            Rebuild();
        }

        private void OnDestroy()
        {
            ReleaseTexture();
        }

        private void OnValidate()
        {
            Rebuild();
        }

        /// <summary>
        /// Redraws the line. Called per terminal step while a line writes, which is a few times a
        /// second on textures a few hundred pixels wide — not per-frame work.
        /// </summary>
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

            int visible = Mathf.Clamp(m_visibleCharacters, 0, m_text.Length);
            int advance = (DotMatrixGlyphs.Width + m_tracking) * m_dotScale;
            int width = visible > 0 ? visible * advance - m_tracking * m_dotScale : 1;
            int height = DotMatrixGlyphs.Height * m_dotScale;

            ReleaseTexture();

            m_texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            m_texture.filterMode = FilterMode.Point;
            m_texture.wrapMode = TextureWrapMode.Clamp;

            Color32[] pixels = new Color32[width * height];
            Color32 lit = m_color;

            for (int i = 0; i < visible; i++)
            {
                string[] glyph = DotMatrixGlyphs.Rows[DotMatrixGlyphs.IndexOf(m_text[i])];
                int originX = i * advance;

                for (int row = 0; row < DotMatrixGlyphs.Height; row++)
                {
                    for (int column = 0; column < DotMatrixGlyphs.Width; column++)
                    {
                        if (glyph[row][column] != '1')
                        {
                            continue;
                        }

                        // Texture row 0 is the bottom, glyph row 0 is the top.
                        int baseX = originX + column * m_dotScale;
                        int baseY = height - (row + 1) * m_dotScale;

                        for (int dy = 0; dy < m_dotScale; dy++)
                        {
                            for (int dx = 0; dx < m_dotScale; dx++)
                            {
                                pixels[(baseY + dy) * width + baseX + dx] = lit;
                            }
                        }
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
