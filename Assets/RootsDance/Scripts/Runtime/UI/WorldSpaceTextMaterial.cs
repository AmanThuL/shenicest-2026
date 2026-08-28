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
    /// A diegetic screen maps a 1060-unit layout onto a 10 cm plate, so that scale is around 1e-4
    /// and the width collapses: the glyphs are laid out, batched and submitted, and come out fully
    /// transparent. Images on the same canvas are unaffected, so the screen renders its frames and
    /// panels and looks like the text was never written — which is how this read as lost content
    /// rather than as a rendering fault.
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
        [Tooltip("Material using RootsDance/UI/WorldSpaceText, pointed at the font's atlas.")]
        [SerializeField] private Material m_textMaterial;

        private readonly List<TMP_Text> m_labels = new List<TMP_Text>();

        private void OnEnable()
        {
            Apply();
        }

        /// <summary>Re-applies the material. Call after adding labels at runtime.</summary>
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

                if (label == null || label.fontSharedMaterial == m_textMaterial)
                {
                    continue;
                }

                label.fontSharedMaterial = m_textMaterial;
            }
        }
    }
}
