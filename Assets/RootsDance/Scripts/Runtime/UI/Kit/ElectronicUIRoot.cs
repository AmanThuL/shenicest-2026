using TMPro;
using UnityEngine;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Holds the theme for one screen and pushes it down the hierarchy (spec §6B). Changing the theme
    /// asset reference on this component restyles everything beneath it, which is the whole contract
    /// the kit rests on: no prefab is edited to change a palette.
    /// <para>
    /// Reapplied on enable and on validate, so the editor shows the result without entering play mode.
    /// The walk is a one-off over a screen's worth of objects, not per-frame work.
    /// </para>
    /// </summary>
    [ExecuteAlways]
    public class ElectronicUIRoot : MonoBehaviour
    {
        [SerializeField] private ElectronicUITheme m_theme;

        [Tooltip("Face for this screen only, in place of the theme's. Empty = the theme's face. "
            + "For a screen written in Chinese: the kit's face carries Latin, and TextMeshPro "
            + "reaches a CJK glyph through a fallback font — a second atlas on a second material "
            + "that a diegetic screen's own material never reaches. One face that carries both "
            + "settles it for that screen without moving the kit off its own.")]
        [SerializeField] private TMP_FontAsset m_fontOverride;

        /// <summary>The face this screen prints in, or null to use the theme's. See the tooltip.</summary>
        public TMP_FontAsset FontOverride => m_fontOverride;

        public ElectronicUITheme Theme
        {
            get { return m_theme; }
            set
            {
                m_theme = value;
                ApplyTheme();
            }
        }

        private void OnEnable()
        {
            ApplyTheme();
        }

        private void OnValidate()
        {
            ApplyTheme();
        }

        /// <summary>Repaints the whole subtree from the theme. Safe to call at any time.</summary>
        public void ApplyTheme()
        {
            if (m_theme == null)
            {
                return;
            }

            // Rows first: an alarm row rewrites its labels' ramp slots, and those slots have to be
            // settled before the text pass reads them.
            KitDataRow[] rows = GetComponentsInChildren<KitDataRow>(true);

            for (int i = 0; i < rows.Length; i++)
            {
                rows[i].Refresh();
            }

            ThemedGraphic[] graphics = GetComponentsInChildren<ThemedGraphic>(true);

            for (int i = 0; i < graphics.Length; i++)
            {
                graphics[i].Apply(m_theme);
            }

            ThemedText[] labels = GetComponentsInChildren<ThemedText>(true);

            for (int i = 0; i < labels.Length; i++)
            {
                labels[i].Apply(m_theme);
            }

            KitElement[] elements = GetComponentsInChildren<KitElement>(true);

            for (int i = 0; i < elements.Length; i++)
            {
                elements[i].Apply(m_theme);
            }

            KitDitherPlate[] plates = GetComponentsInChildren<KitDitherPlate>(true);

            for (int i = 0; i < plates.Length; i++)
            {
                plates[i].Apply(m_theme);
            }
        }
    }
}
