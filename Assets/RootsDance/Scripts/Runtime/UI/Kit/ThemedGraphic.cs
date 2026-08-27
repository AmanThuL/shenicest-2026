using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI.Kit
{
    /// <summary>
    /// Binds one Graphic's colour to a ramp slot instead of a literal (spec §2A, §6B). Every coloured
    /// element in the kit carries one of these; nothing sets a colour in the inspector.
    /// </summary>
    [ExecuteAlways]
    [RequireComponent(typeof(Graphic))]
    public class ThemedGraphic : MonoBehaviour
    {
        [SerializeField] private KitInk m_ink = KitInk.Ink4;

        [Tooltip("Multiplies the ramp colour's alpha. For the rare half-strength divider.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_opacity = 1f;

        public KitInk Ink
        {
            get { return m_ink; }
            set { m_ink = value; }
        }

        public void Apply(ElectronicUITheme theme)
        {
            if (theme == null)
            {
                return;
            }

            Graphic graphic = GetComponent<Graphic>();

            if (graphic == null)
            {
                return;
            }

            Color color = theme.Ink(m_ink);
            color.a *= m_opacity;
            graphic.color = color;
        }
    }
}
