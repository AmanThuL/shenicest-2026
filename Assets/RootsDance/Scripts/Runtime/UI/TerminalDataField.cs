using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// A grid of dot-matrix character cells drawn into one texture: the data screen's background
    /// chatter (spec B-roll, sections 11-13). Every cell holds a fixed character at a fixed
    /// brightness from the moment the field is built; the only thing that animates is which cells are
    /// currently lit, which <see cref="Coverage"/> drives and <c>TerminalMotion.Populate</c> steps.
    /// <para>
    /// Two things measured off the reference decide how this looks, and both live here rather than in
    /// the composite pass. Per-cell brightness spans roughly 3:1 inside a single row - a field of
    /// evenly lit characters reads as a spreadsheet, and no other single parameter buys as much. And
    /// the glyph fills only about half its cell's height, so the leading is as tall as the type.
    /// </para>
    /// <para>
    /// Cells are hard on or off. Nothing here fades, and a cell that is lit never changes its
    /// character, its brightness or its hue until the field is cleared.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    [RequireComponent(typeof(RawImage))]
    public class TerminalDataField : MonoBehaviour
    {
        /// <summary>
        /// What the reference fills its panels with, adapted to the face this screen has. Two things
        /// shape it. The reference is overwhelmingly numeric, with runs of zeroes and ones and a thin
        /// tail of punctuation, and an even mix of letters and digits reads as garbled prose rather
        /// than a readout. And at 3x5 (see <see cref="DotMatrixGlyphs"/>) several capitals are
        /// indistinguishable from digits - D and N are the 0 box, B reads as 3, G as 6, E as 5 - so
        /// including them does not add letters to the field, it only makes the digits ambiguous.
        /// Only A and H, which collide with nothing, are kept.
        /// </summary>
        private const string k_DefaultCharset =
            "01010101010101230123456745678923456789.0101.01/01-01:0AH0011 ";

        [Tooltip("Cells across. The reference runs 39 on the centre panel, 14 on the side panels.")]
        [Min(1)]
        [SerializeField] private int m_columns = 39;

        [Tooltip("Cells down. 22 on the centre panel, 9 on the side panels.")]
        [Min(1)]
        [SerializeField] private int m_rows = 22;

        [Tooltip("Buffer pixels per dot. 1 on the centre panel, 2 on the side panels.")]
        [Min(1)]
        [SerializeField] private int m_dotScale = 1;

        [Tooltip("Cell pitch in buffer pixels. Y must leave the glyph at about half the cell height.")]
        [SerializeField] private Vector2Int m_cellPitch = new Vector2Int(4, 9);

        [Tooltip("Fraction of cells that ever hold a character. Measured 0.82 centre, 0.79 side.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_occupancy = 0.82f;

        [Tooltip("Cells of blank between runs of characters. Blanks come in runs, not scattered singly.")]
        [Min(1)]
        [SerializeField] private int m_maxGap = 4;

        [Tooltip("Cells kept permanently blank, so a label can sit in the field with room around it.")]
        [SerializeField] private RectInt m_blankRegion = new RectInt(0, 0, 0, 0);

        [Tooltip("Characters drawn from, with weighting by repetition.")]
        [SerializeField] private string m_charset = k_DefaultCharset;

        [Tooltip("Colour of the dimmest cell. Centre #113650, side #193454.")]
        [SerializeField] private Color m_dimColor = new Color32(0x11, 0x36, 0x50, 0xFF);

        [Tooltip("Colour of the brightest cell. Centre #98D3E6, side #7DC6EF.")]
        [SerializeField] private Color m_brightColor = new Color32(0x98, 0xD3, 0xE6, 0xFF);

        [Tooltip("Skews the brightness draw toward the dim end. 1 is uniform; the reference sits near 1.4.")]
        [Min(0.1f)]
        [SerializeField] private float m_brightnessBias = 1.4f;

        [Tooltip("Per-cell green/blue swing, trading one against the other. Secondary to brightness.")]
        [Range(0f, 0.5f)]
        [SerializeField] private float m_hueJitter = 0.12f;

        [Tooltip("Same seed, same field. Give each panel its own so they do not read as copies.")]
        [SerializeField] private int m_seed = 1;

        private RawImage m_image;

        private Texture2D m_texture;

        /// <summary>
        /// Set by <c>OnValidate</c> and consumed by <c>Update</c>. Rebuilding resizes the rect, and
        /// Unity forbids that from inside OnValidate - doing it there logs "SendMessage cannot be
        /// called during Awake, CheckConsistency, or OnValidate" once per field per inspector edit.
        /// </summary>
        private bool m_rebuildQueued;

        private float m_coverage = 1f;

        /// <summary>
        /// Occupied cells, in the order they light up. Shuffled once per build, so a Populate and the
        /// Depopulate that follows it walk the same order and the field empties the way it filled.
        /// </summary>
        private int[] m_order;

        /// <summary>How much of the field is lit, 0 to 1. Setting it redraws.</summary>
        public float Coverage
        {
            get { return m_coverage; }
            set
            {
                float clamped = Mathf.Clamp01(value);

                if (Mathf.Approximately(clamped, m_coverage) && m_texture != null)
                {
                    return;
                }

                m_coverage = clamped;
                Rebuild();
            }
        }

        /// <summary>Cells that hold a character at all, which is what Coverage is a fraction of.</summary>
        public int OccupiedCells
        {
            get { return m_order == null ? 0 : m_order.Length; }
        }

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
            m_order = null;
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
        /// Rerolls the field's contents. The layout, the characters and the brightnesses all come from
        /// <see cref="m_seed"/>, so this only matters when the seed itself changes.
        /// </summary>
        public void Reseed(int seed)
        {
            m_seed = seed;
            m_order = null;
            Rebuild();
        }

        /// <summary>
        /// Redraws the whole field. Called once per terminal step while a field populates - a few
        /// times a second on a texture a couple of hundred pixels wide, not per-frame work.
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

            int width = Mathf.Max(1, m_columns * m_cellPitch.x * m_dotScale);
            int height = Mathf.Max(1, m_rows * m_cellPitch.y * m_dotScale);

            BuildOrder();
            ReleaseTexture();

            m_texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            m_texture.filterMode = FilterMode.Point;
            m_texture.wrapMode = TextureWrapMode.Clamp;

            // Never serialized: the field regenerates from its seed on enable, so letting Unity save
            // the texture would embed a few hundred kilobytes of derived data in every scene holding
            // one, and churn it in the diff on every rebuild.
            m_texture.hideFlags = HideFlags.HideAndDontSave;

            Color32[] pixels = new Color32[width * height];
            int lit = Mathf.RoundToInt(m_coverage * m_order.Length);

            for (int i = 0; i < lit; i++)
            {
                DrawCell(pixels, width, height, m_order[i]);
            }

            m_texture.SetPixels32(pixels);
            m_texture.Apply();

            m_image.texture = m_texture;
            m_image.color = Color.white;
            m_image.rectTransform.sizeDelta = new Vector2(width, height);
        }

        /// <summary>
        /// Picks which cells are occupied and shuffles them into the order they arrive in. Both draws
        /// come off the seed, so the same field rebuilds identically however often Coverage moves.
        /// </summary>
        private void BuildOrder()
        {
            if (m_order != null)
            {
                return;
            }

            int total = m_columns * m_rows;
            int[] occupied = new int[total];
            int count = 0;

            // Blanks come in runs, not scattered one cell at a time. Testing each cell independently
            // against the occupancy gives a field pocked with single holes, which reads as damage; the
            // reference reads as words and columns of figures with gutters between them. Runs are
            // sized so the field still lands on the measured occupancy: with an average gap of
            // (maxGap + 1) / 2, the run that balances it is that gap times occupancy / (1 - occupancy).
            float averageGap = (m_maxGap + 1) * 0.5f;
            float averageRun = m_occupancy >= 1f
                ? m_columns
                : averageGap * m_occupancy / Mathf.Max(1f - m_occupancy, 1e-3f);

            for (int row = 0; row < m_rows; row++)
            {
                int column = 0;

                while (column < m_columns)
                {
                    int cell = row * m_columns + column;

                    column += 1 + (int)(Random01(cell, 11) * m_maxGap);

                    int run = Mathf.Max(1, Mathf.RoundToInt(averageRun * (0.5f + Random01(cell, 13))));

                    for (int i = 0; i < run && column < m_columns; i++, column++)
                    {
                        if (IsBlanked(column, row))
                        {
                            continue;
                        }

                        occupied[count] = row * m_columns + column;
                        count++;
                    }
                }
            }

            m_order = new int[count];
            System.Array.Copy(occupied, m_order, count);

            // Fisher-Yates off the same seed: the arrival order has to be stable across rebuilds, so
            // UnityEngine.Random (global state, and moved by anything else in the frame) is no use.
            for (int i = count - 1; i > 0; i--)
            {
                int j = (int)(Random01(i, 29) * (i + 1));
                j = Mathf.Clamp(j, 0, i);

                int swap = m_order[i];
                m_order[i] = m_order[j];
                m_order[j] = swap;
            }
        }

        /// <summary>
        /// Whether a cell falls in the reserved rectangle. The reference keeps a gutter of blank cells
        /// around the label so it reads as the panel's name rather than as another row of figures.
        /// </summary>
        private bool IsBlanked(int column, int row)
        {
            return m_blankRegion.width > 0 && m_blankRegion.height > 0
                && column >= m_blankRegion.xMin && column < m_blankRegion.xMax
                && row >= m_blankRegion.yMin && row < m_blankRegion.yMax;
        }

        private void DrawCell(Color32[] pixels, int width, int height, int cell)
        {
            int column = cell % m_columns;
            int row = cell / m_columns;

            char character = m_charset.Length == 0
                ? '0'
                : m_charset[(int)(Random01(cell, 47) * m_charset.Length) % m_charset.Length];

            if (character == ' ')
            {
                return;
            }

            // Biased draw: most cells sit near the dim end, a few run away to the top. This is the
            // 3:1 spread the reference shows inside one row, and it is the whole texture of the look.
            float level = Mathf.Pow(Random01(cell, 71), m_brightnessBias);
            Color color = Color.Lerp(m_dimColor, m_brightColor, level);

            float swing = (Random01(cell, 97) - 0.5f) * 2f * m_hueJitter;
            color.g = Mathf.Clamp01(color.g * (1f - swing));
            color.b = Mathf.Clamp01(color.b * (1f + swing));

            Color32 lit = color;
            string[] glyph = DotMatrixGlyphs.Rows[DotMatrixGlyphs.IndexOf(character)];

            int originX = column * m_cellPitch.x * m_dotScale;
            int originY = height - row * m_cellPitch.y * m_dotScale;

            for (int glyphRow = 0; glyphRow < DotMatrixGlyphs.Height; glyphRow++)
            {
                for (int glyphColumn = 0; glyphColumn < DotMatrixGlyphs.Width; glyphColumn++)
                {
                    if (glyph[glyphRow][glyphColumn] != '1')
                    {
                        continue;
                    }

                    // Texture row 0 is the bottom, glyph row 0 is the top.
                    int baseX = originX + glyphColumn * m_dotScale;
                    int baseY = originY - (glyphRow + 1) * m_dotScale;

                    for (int dy = 0; dy < m_dotScale; dy++)
                    {
                        for (int dx = 0; dx < m_dotScale; dx++)
                        {
                            int x = baseX + dx;
                            int y = baseY + dy;

                            if (x < 0 || x >= width || y < 0 || y >= height)
                            {
                                continue;
                            }

                            pixels[y * width + x] = lit;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Integer bit mix rather than sin() hashing: on a regular lattice sin() hashes correlate, and
        /// a field of characters would come out banded instead of random. <paramref name="channel"/>
        /// keeps the several draws per cell independent of one another.
        /// </summary>
        private float Random01(int cell, int channel)
        {
            unchecked
            {
                uint n = (uint)(cell * 1597334677) ^ (uint)(channel * 3812015801) ^ (uint)m_seed;
                n = (n ^ (n >> 15)) * 2246822519u;
                n = (n ^ (n >> 13)) * 3266489917u;
                n ^= n >> 16;

                return (n & 0x00FFFFFFu) / 16777216f;
            }
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
