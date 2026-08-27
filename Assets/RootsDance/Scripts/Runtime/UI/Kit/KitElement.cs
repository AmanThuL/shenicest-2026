using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Base for the kit's drawn primitives — the ones that generate their own mesh rather than tint a
    /// sprite. They are Graphics with no texture at all, which is what lets a rule stay exactly one
    /// pixel at any component size (spec §2B): a nine-sliced sprite border scales with the rect, and
    /// scaling the rule is the single fastest way to make this style read as a rounded card instead.
    /// </summary>
    [ExecuteAlways]
    public abstract class KitElement : MaskableGraphic
    {
        [SerializeField] private KitInk m_ink = KitInk.Ink4;

        protected ElectronicUITheme m_theme;

        /// <summary>Slot this element paints from.</summary>
        public KitInk Ink
        {
            get { return m_ink; }
            set
            {
                m_ink = value;
                SetVerticesDirty();
            }
        }

        /// <summary>The theme in force, or null before a root has pushed one down.</summary>
        protected ElectronicUITheme ActiveTheme
        {
            get { return m_theme; }
        }

        public override Texture mainTexture
        {
            get { return s_WhiteTexture; }
        }

        public void Apply(ElectronicUITheme theme)
        {
            m_theme = theme;

            if (theme != null)
            {
                color = theme.Ink(m_ink);
            }

            SetVerticesDirty();
        }

        /// <summary>Theme unit, or a sane default when the element is previewed with no root above it.</summary>
        protected float Unit
        {
            get { return m_theme != null ? m_theme.Unit : 4f; }
        }

        protected float RuleWidth
        {
            get { return m_theme != null ? m_theme.Rule : 1f; }
        }

        /// <summary>Appends an axis-aligned rectangle in local space.</summary>
        protected void AddRect(VertexHelper helper, float x, float y, float width, float height)
        {
            AddRect(helper, x, y, width, height, color);
        }

        protected void AddRect(VertexHelper helper, float x, float y, float width, float height,
            Color32 fill)
        {
            if (width <= 0f || height <= 0f)
            {
                return;
            }

            int index = helper.currentVertCount;

            UIVertex vertex = UIVertex.simpleVert;
            vertex.color = fill;
            vertex.uv0 = Vector2.zero;

            vertex.position = new Vector3(x, y);
            helper.AddVert(vertex);
            vertex.position = new Vector3(x, y + height);
            helper.AddVert(vertex);
            vertex.position = new Vector3(x + width, y + height);
            helper.AddVert(vertex);
            vertex.position = new Vector3(x + width, y);
            helper.AddVert(vertex);

            helper.AddTriangle(index, index + 1, index + 2);
            helper.AddTriangle(index + 2, index + 3, index);
        }

        /// <summary>
        /// Integer bit mix. The kit's generated content (chip mosaics, barcode rows, waveforms) has to
        /// look the same every rebuild and every session, so nothing here touches UnityEngine.Random.
        /// </summary>
        protected static float Hash01(int a, int b, int seed)
        {
            unchecked
            {
                uint n = (uint)(a * 1597334677) ^ (uint)(b * 3812015801) ^ (uint)seed;
                n = (n ^ (n >> 15)) * 2246822519u;
                n = (n ^ (n >> 13)) * 3266489917u;
                n ^= n >> 16;

                return (n & 0x00FFFFFFu) / 16777216f;
            }
        }
    }
}
