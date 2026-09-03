using RootsDance.Data;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Takes one screen element away while recording mode hides its group. Sits on the root of
    /// that element — the canvas, or the prefab root — and drives a <see cref="CanvasGroup"/> of
    /// its own there, so the presenters underneath keep writing to their own groups and never
    /// notice: a parent group at alpha 0 hides everything below it whatever the children do.
    /// <para>
    /// It must therefore never share a GameObject with a presenter-owned CanvasGroup; the
    /// installer only puts it on roots that have none.
    /// </para>
    /// </summary>
    public sealed class RecordingModeHider : MonoBehaviour
    {
        [Tooltip("Data/Config/RecordingMode.")]
        [SerializeField] private RecordingModeSO m_mode;

        [Tooltip("Which recording-mode group this element belongs to.")]
        [SerializeField] private RecordingHiddenUi m_group = RecordingHiddenUi.InteractionHints;

        [Tooltip("The group this hider owns. Added to this object when left empty.")]
        [SerializeField] private CanvasGroup m_canvasGroup;

        public RecordingHiddenUi Group => m_group;

        private void OnEnable()
        {
            if (m_canvasGroup == null)
            {
                m_canvasGroup = TerminalMotion.EnsureCanvasGroup(gameObject);
            }

            if (m_mode != null)
            {
                m_mode.Changed += Apply;
            }

            Apply();
        }

        private void OnDisable()
        {
            if (m_mode != null)
            {
                m_mode.Changed -= Apply;
            }

            SetShown(true);
        }

        private void Apply()
        {
            SetShown(m_mode == null || !m_mode.IsHidden(m_group));
        }

        private void SetShown(bool isShown)
        {
            if (m_canvasGroup == null)
            {
                return;
            }

            m_canvasGroup.alpha = isShown ? 1f : 0f;
            // Invisible buttons must not be clickable, or a recording could answer a choice the
            // viewer never saw.
            m_canvasGroup.blocksRaycasts = isShown;
            m_canvasGroup.interactable = isShown;
        }
    }
}
