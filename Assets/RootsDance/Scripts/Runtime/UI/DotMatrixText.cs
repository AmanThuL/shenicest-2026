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

        /// <summary>
        /// Set by <c>OnValidate</c> and consumed by <c>Update</c>. Rebuilding resizes the rect, and
        /// Unity forbids that from inside OnValidate - doing it there logs "SendMessage cannot be
        /// called during Awake, CheckConsistency, or OnValidate" once per line per inspector edit.
        /// </summary>
        private bool m_rebuildQueued;

        private int m_visibleCharacters = int.MaxValue;

        /// <summary>
        /// Per-character visibility, when a caller lights the line out of order rather than
        /// left to right. Null means <see cref="VisibleCharacters"/> decides instead.
        /// </summary>
        private bool[] m_visibleMask;

        /// <summary>The whole line, including characters currently hidden by a write.</summary>
        public string Text
        {
            get { return m_text; }
            set
            {
                m_text = value == null ? string.Empty : value;
                m_visibleMask = null;
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
                m_visibleMask = null;
                Rebuild();
            }
        }

        public int CharacterCount
        {
            get { return m_text.Length; }
        }

        /// <summary>
        /// Screen pixels per dot. Exposed so a line built from code — the loading screen, which has
        /// no prefab to author — can pick its size; authored lines set it in the Inspector.
        /// </summary>
        public int DotScale
        {
            get { return m_dotScale; }
            set
            {
                m_dotScale = Mathf.Max(1, value);
                Rebuild();
            }
        }

        /// <summary>Dots of tracking between glyphs. See <see cref="DotScale"/> for why it is public.</summary>
        public int Tracking
        {
            get { return m_tracking; }
            set
            {
                m_tracking = Mathf.Max(0, value);
                Rebuild();
            }
        }

        /// <summary>Lit-dot colour. See <see cref="DotScale"/> for why it is public.</summary>
        public Color Color
        {
            get { return m_color; }
            set
            {
                m_color = value;
                Rebuild();
            }
        }

        /// <summary>
        /// Lights or clears one character in place, leaving the rest of the line alone. This is how
        /// the data screen writes: the reference brings its labels up glyph by glyph in random order,
        /// each one already sitting at its final position holding its final character, so the line
        /// never shows a wrong letter and never slides (spec section 13).
        /// </summary>
        public void SetCharacterVisible(int index, bool visible)
        {
            if (index < 0 || index >= m_text.Length)
            {
                return;
            }

            EnsureMask(visible);
            m_visibleMask[index] = visible;
            Rebuild();
        }

        /// <summary>Lights or clears the whole line at once, and switches it to out-of-order mode.</summary>
        public void SetAllCharactersVisible(bool visible)
        {
            EnsureMask(visible);

            for (int i = 0; i < m_visibleMask.Length; i++)
            {
                m_visibleMask[i] = visible;
            }

            Rebuild();
        }

        private void EnsureMask(bool fill)
        {
            if (m_visibleMask != null && m_visibleMask.Length == m_text.Length)
            {
                return;
            }

            m_visibleMask = new bool[m_text.Length];

            if (!fill)
            {
                return;
            }

            for (int i = 0; i < m_visibleMask.Length; i++)
            {
                m_visibleMask[i] = true;
            }
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
            // Queued rather than built here for the same reason OnValidate queues: Rebuild sizes the
            // rect, and on a GameObject that is still being constructed Unity refuses the resulting
            // OnRectTransformDimensionsChange. Callers that need the texture immediately - the sandbox
            // builders, which have to save a prefab with the right size - call Rebuild themselves.
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

            if (m_visibleMask != null && m_visibleMask.Length != m_text.Length)
            {
                m_visibleMask = null;
            }

            int count = m_text.Length;
            int prefix = Mathf.Clamp(m_visibleCharacters, 0, count);
            int advance = (DotMatrixGlyphs.Width + m_tracking) * m_dotScale;

            // The texture always spans the whole line, lit or not, so a centred label keeps its
            // position while it writes instead of growing out from one edge.
            int width = count > 0 ? count * advance - m_tracking * m_dotScale : 1;
            int height = DotMatrixGlyphs.Height * m_dotScale;

            ReleaseTexture();

            m_texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            m_texture.filterMode = FilterMode.Point;
            m_texture.wrapMode = TextureWrapMode.Clamp;

            // Never serialized: the line regenerates on enable, so letting Unity save
            // the texture would embed derived pixels in every scene holding one, and churn it in the diff on every rebuild.
            m_texture.hideFlags = HideFlags.HideAndDontSave;

            Color32[] pixels = new Color32[width * height];
            Color32 lit = m_color;

            for (int i = 0; i < count; i++)
            {
                bool visible = m_visibleMask != null ? m_visibleMask[i] : i < prefix;

                if (!visible)
                {
                    continue;
                }

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
