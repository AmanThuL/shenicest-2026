using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Turns the boot screen into the cover shown <em>between</em> scenes. It owns nothing about how
    /// the screen looks — <see cref="BootScreenPresenter"/> still does all of that — it only decides
    /// when the screen is on, and feeds the load's progress to the rule under the caption block.
    /// <para>
    /// The first time it comes up (game start) the full five-phase sequence plays. Every later scene
    /// change brings the screen up already locked at P5, so a one-second load is not padded out to a
    /// 2.4-second title card; the rule is the only thing that moves.
    /// </para>
    /// <para>
    /// It is switched with <c>Canvas.enabled</c> and the signal camera rather than
    /// <c>SetActive</c>, so <see cref="BootScreenPresenter"/>'s <c>OnEnable</c> does not refire and
    /// replay the sequence behind this component's back.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class BootScreenCover : MonoBehaviour
    {
        [Header("Screen")]
        [SerializeField] private BootScreenPresenter m_screen;

        [Tooltip("The rule under the caption block. Optional: without one the cover still covers, it "
            + "just says nothing about how far along the load is.")]
        [SerializeField] private TerminalProgressRule m_progressRule;

        [Header("Switched with the cover")]
        [Tooltip("The screen's canvases — the low-resolution buffer canvas and the composite canvas.")]
        [SerializeField] private Canvas[] m_canvases;

        [Tooltip("The camera that renders the low-resolution buffer. Off while the cover is down, or "
            + "it keeps filling the render texture nobody is looking at.")]
        [SerializeField] private Camera m_signalCamera;

        /// <summary>False until the first Show, which is the one that plays the whole sequence.</summary>
        private bool m_hasPlayed;

        public bool IsVisible { get; private set; }

        /// <summary>
        /// How long the caller must keep the cover up for what it just started to finish: the whole
        /// sequence on the first show, nothing on the ones that come up already locked.
        /// </summary>
        public float HoldSeconds { get; private set; }

        private void Awake()
        {
            // Authored visible so the screen can be worked on in the prefab stage; a cover that is up
            // before anyone asked for it is exactly the mid-scene case this must never do.
            SetSwitchedOn(false);
            IsVisible = false;
        }

        public void Show()
        {
            SetSwitchedOn(true);
            IsVisible = true;
            SetProgress(0f);

            if (m_screen == null)
            {
                HoldSeconds = 0f;
                return;
            }

            if (m_hasPlayed)
            {
                HoldSeconds = 0f;
                m_screen.ShowLocked();
                return;
            }

            m_hasPlayed = true;
            HoldSeconds = m_screen.SequenceSeconds;
            m_screen.Play();
        }

        public void SetProgress(float fraction)
        {
            if (m_progressRule != null)
            {
                m_progressRule.Progress = fraction;
            }
        }

        public void Hide()
        {
            IsVisible = false;
            SetSwitchedOn(false);
        }

        private void SetSwitchedOn(bool on)
        {
            if (m_canvases != null)
            {
                for (int i = 0; i < m_canvases.Length; i++)
                {
                    if (m_canvases[i] != null)
                    {
                        m_canvases[i].enabled = on;
                    }
                }
            }

            if (m_signalCamera != null)
            {
                m_signalCamera.enabled = on;
            }
        }
    }
}
