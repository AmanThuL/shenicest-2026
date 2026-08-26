using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// Drives the five-phase boot sequence of docs/effects/低保真终端式UI规范.md §7 on one screen:
    /// P1 Open (raster bands, stage at 80.2%), P2 Acquire (hard jump to full size, caption block
    /// complete in one frame), P3-P4 Resolve/Stabilize (the image reconstructs, the headline writes,
    /// the backdrop starts drifting), P5 Lock (the tagline writes; everything else is still).
    /// <para>
    /// Everything it drives lives in the low-resolution buffer that TerminalComposite blits to the
    /// screen, so the chrome, the text and the stage share one signal.
    /// </para>
    /// <para>
    /// Motion: no eases, no fades, no intermediate sizes. Size changes are jumps and the chrome — the
    /// rails, the title bar and the caption block — never moves once it is present. The one exception
    /// is the backdrop parallax, a single slow shallow-angle drift inside the stage image.
    /// </para>
    /// </summary>
    public class BootScreenPresenter : MonoBehaviour
    {
        /// <summary>The stage's opening size as a fraction of its final size. Measured, not chosen.</summary>
        private const float k_CollapsedFraction = 0.802f;

        [Header("Stage")]
        [Tooltip("The window that jumps 80.2% -> 100%. Holds the border layers and the stage image.")]
        [SerializeField] private RectTransform m_stageWindow;

        [Tooltip("The stage bitmap inside the window, drawn through the TerminalStage material.")]
        [SerializeField] private RawImage m_stage;

        [SerializeField] private CanvasGroup m_stageGroup;

        [Tooltip("The one element allowed to move: the backdrop inside the stage image.")]
        [SerializeField] private RectTransform m_backdrop;

        [Header("Text")]
        [SerializeField] private CanvasGroup m_captionGroup;

        [SerializeField] private DotMatrixText m_headline;

        [SerializeField] private DotMatrixText m_tagline;

        [Tooltip("Replaces the reference sequence's wordmark. Never a placeholder trademark.")]
        [SerializeField] private string m_headlineText = "ROOTS";

        [SerializeField] private string m_taglineText = string.Empty;

        [Header("Phase timing (authored starting values, not measurements)")]
        [SerializeField] private float m_openSeconds = 0.4f;

        [SerializeField] private float m_acquireSeconds = 0.25f;

        [SerializeField] private float m_resolveSeconds = 0.8f;

        [SerializeField] private float m_stabilizeSeconds = 0.9f;

        [Header("Backdrop parallax")]
        [Tooltip("Net drift over the sequence: measured -131 px across against +20 px down.")]
        [SerializeField] private Vector2 m_parallaxOffset = new Vector2(-131f, 20f);

        [SerializeField] private float m_parallaxSeconds = 6f;

        [Header("Motion")]
        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private Material m_stageMaterial;

        private Vector2 m_stageFullSize;

        private Vector2 m_backdropHome;

        private Sequence m_sequence;

        private void Awake()
        {
            if (m_stageWindow != null)
            {
                m_stageFullSize = m_stageWindow.sizeDelta;
            }

            if (m_backdrop != null)
            {
                m_backdropHome = m_backdrop.anchoredPosition;
            }

            // The verbs write shader properties, so each screen needs its own material instance or
            // one boot screen would drive every other RawImage sharing the asset.
            if (m_stage != null && m_stage.material != null)
            {
                m_stageMaterial = new Material(m_stage.material);
                m_stage.material = m_stageMaterial;
            }
        }

        private void OnEnable()
        {
            Play();
        }

        private void OnDisable()
        {
            KillMotion();
            ApplyLockedState();
        }

        private void OnDestroy()
        {
            if (m_stageMaterial != null)
            {
                Destroy(m_stageMaterial);
            }
        }

        /// <summary>
        /// Restarts the sequence from P1. Called on enable, and by whatever replays the boot screen.
        /// </summary>
        public void Play()
        {
            KillMotion();

            // P1 Open — stage present at 80.2%, raster bands only, no caption block.
            SetStageSize(k_CollapsedFraction);
            TerminalMotion.Snap(m_stageGroup);
            TerminalMotion.HardCut(m_captionGroup);
            SetHeadline(string.Empty);
            SetTagline(string.Empty);

            if (m_backdrop != null)
            {
                m_backdrop.anchoredPosition = m_backdropHome;
            }

            m_sequence = DOTween.Sequence().SetTarget(this);
            m_sequence.AppendCallback(() => TerminalMotion.RasterHold(m_stageMaterial, m_motion));
            m_sequence.AppendInterval(m_openSeconds);

            // P2 Acquire — the size change is a jump, and the caption block is complete in one frame
            // and never unstable again.
            m_sequence.AppendCallback(() =>
            {
                SetStageSize(1f);
                TerminalMotion.Snap(m_captionGroup);
            });
            m_sequence.AppendInterval(m_acquireSeconds);

            // P3-P4 Resolve / Stabilize — the image reconstructs out of coarse blocks while the
            // headline writes; the backdrop starts its drift.
            m_sequence.AppendCallback(() =>
            {
                TerminalMotion.Reconstruct(m_stageMaterial, m_motion);
                TerminalMotion.TerminalWrite(m_headline, m_headlineText, m_motion);
                StartParallax();
            });
            m_sequence.AppendInterval(m_resolveSeconds + m_stabilizeSeconds);

            // P5 Lock — the tagline is the last thing to resolve, in reverse order of importance.
            m_sequence.AppendCallback(() => TerminalMotion.TerminalWrite(m_tagline, m_taglineText, m_motion));
        }

        private void StartParallax()
        {
            if (m_backdrop == null || m_parallaxSeconds <= 0f)
            {
                return;
            }

            TerminalMotion.Kill(m_backdrop);

            m_backdrop.DOAnchorPos(m_backdropHome + m_parallaxOffset, m_parallaxSeconds)
                .SetEase(Ease.Linear)
                .SetTarget(m_backdrop);
        }

        private void SetStageSize(float fraction)
        {
            if (m_stageWindow == null)
            {
                return;
            }

            m_stageWindow.sizeDelta = m_stageFullSize * fraction;
        }

        /// <summary>
        /// The P5 state, applied whenever the sequence is cancelled so an interrupted boot screen is
        /// left readable rather than half-written.
        /// </summary>
        private void ApplyLockedState()
        {
            SetStageSize(1f);
            TerminalMotion.Snap(m_stageGroup);
            TerminalMotion.Snap(m_captionGroup);
            SetHeadline(m_headlineText);
            SetTagline(m_taglineText);
        }

        private void SetHeadline(string text)
        {
            if (m_headline != null)
            {
                m_headline.VisibleCharacters = int.MaxValue;
                m_headline.Text = text;
            }
        }

        private void SetTagline(string text)
        {
            if (m_tagline != null)
            {
                m_tagline.VisibleCharacters = int.MaxValue;
                m_tagline.Text = text;
            }
        }

        private void KillMotion()
        {
            if (m_sequence != null)
            {
                m_sequence.Kill();
                m_sequence = null;
            }

            TerminalMotion.Kill(this);
            TerminalMotion.Kill(m_stageMaterial);
            TerminalMotion.Kill(m_headline);
            TerminalMotion.Kill(m_tagline);
            TerminalMotion.Kill(m_backdrop);
        }
    }
}
