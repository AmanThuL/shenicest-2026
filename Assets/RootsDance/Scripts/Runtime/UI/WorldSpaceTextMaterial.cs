using System.Collections.Generic;
using RootsDance.Core;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Gives every label under a world-space canvas a text material HDRP will actually draw.
    /// <para>
    /// TextMeshPro's own SDF shaders derive their antialiasing width from the transform's scale.
    /// A diegetic screen maps a 1060-unit layout onto a 7 cm plate, so that scale is around 7e-5
    /// and the width collapses: the glyphs are laid out, batched and submitted, and come out fully
    /// transparent. Images on the same canvas are unaffected, so the screen renders its frames and
    /// panels and looks like the text was never written — which is how this read as lost content
    /// rather than as a rendering fault.
    /// </para>
    /// <para>
    /// The material is derived per font asset rather than assigned from one authored material, and
    /// that is the whole point. A TMP label resets its material to the font's default the moment
    /// its <c>font</c> changes, and <see cref="RootsDance.UI.Kit.ThemedText"/> assigns the theme's
    /// face on every apply — so a single authored material is thrown away the first time a themed
    /// label wakes up, and the screen goes blank again. Deriving the material from whatever font
    /// the label ended up with means the theme can change its face without taking the text with it;
    /// the assigned material is kept only as the template the derived ones are copied from, so its
    /// sharpness and colour still come from the asset a human tuned.
    /// </para>
    /// <para>
    /// Screen-space overlay canvases are fine as they are and must keep TMP's own material, so this
    /// only ever touches canvases that render in world space.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Canvas))]
    public class WorldSpaceTextMaterial : MonoBehaviour
    {
        [Tooltip("Template material using RootsDance/UI/WorldSpaceText. One material per font is "
            + "copied from it, with that font's atlas.")]
        [SerializeField] private Material m_textMaterial;

        private readonly List<TMP_Text> m_labels = new List<TMP_Text>();
        private readonly Dictionary<TMP_FontAsset, Material> m_derived =
            new Dictionary<TMP_FontAsset, Material>();

        private void OnEnable()
        {
            Apply();
        }

        private void OnDestroy()
        {
            foreach (KeyValuePair<TMP_FontAsset, Material> entry in m_derived)
            {
                if (entry.Value != null)
                {
                    Destroy(entry.Value);
                }
            }

            m_derived.Clear();
        }

        /// <summary>
        /// Re-applies the material to every label under this canvas. Call it after anything that
        /// can change a label's font or material — adding labels at runtime, or writing a page of
        /// the report, which runs the theme over every label it touches.
        /// </summary>
        public void Apply()
        {
            if (m_textMaterial == null)
            {
                Log.Warning("WorldSpaceTextMaterial: no material assigned; text will not render "
                    + "on this canvas.", this);
                return;
            }

            var canvas = GetComponent<Canvas>();

            if (canvas.renderMode != RenderMode.WorldSpace)
            {
                return;
            }

            m_labels.Clear();
            GetComponentsInChildren(true, m_labels);

            for (int i = 0; i < m_labels.Count; i++)
            {
                TMP_Text label = m_labels[i];

                if (label == null || label.font == null)
                {
                    continue;
                }

                Material material = MaterialFor(label.font);

                if (material != null && label.fontSharedMaterial != material)
                {
                    label.fontSharedMaterial = material;
                }
            }
        }

        /// <summary>
        /// The world-space material for one font, made once and kept. The atlas is taken off the
        /// font itself: a material pointed at another font's atlas draws the wrong glyphs, or none
        /// at all when that atlas is a dynamic one that has never been filled.
        /// </summary>
        private Material MaterialFor(TMP_FontAsset font)
        {
            if (m_derived.TryGetValue(font, out Material existing) && existing != null)
            {
                // A dynamic font fills its atlas as glyphs are asked for, and grows a new texture
                // when the first one is full, so the atlas a material was made against can stop
                // being the one the label reads from.
                if (existing.mainTexture != font.atlasTexture)
                {
                    existing.mainTexture = font.atlasTexture;
                }

                return existing;
            }

            var material = new Material(m_textMaterial)
            {
                name = m_textMaterial.name + " (" + font.name + ")",
                mainTexture = font.atlasTexture
            };

            m_derived[font] = material;

            return material;
        }
    }
}
