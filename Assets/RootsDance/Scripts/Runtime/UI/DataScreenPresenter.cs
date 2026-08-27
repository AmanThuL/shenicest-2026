using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// Drives the six-phase data screen of docs/effects/低保真终端式UI规范.md §13 across three panels:
    /// D0 Idle (ground colour only), D1 Name (the centre label scatters in), D2 Fill (all three fields
    /// populate together), D3 Hold (full, and the centre panel changes what it calls itself), D4 Purge
    /// (only the centre field empties; the label stays lit and the side panels do not move), D5 Flood
    /// (the centre panel walks a hard ladder to full wash and back, which loops the sequence).
    /// <para>
    /// The whole run is a loop, not an opening: the reference's first frame is the tail of the
    /// previous flood. <see cref="m_loop"/> is on by default for that reason.
    /// </para>
    /// <para>
    /// The division of labour is the point of the composition. The centre panel is the narrative
    /// channel — it names itself, clears and washes out — and the side panels are environment: they
    /// fill once and stay. Animating all three the same way reads as three screens playing a video
    /// rather than one machine thinking.
    /// </para>
    /// </summary>
    public class DataScreenPresenter : MonoBehaviour
    {
        [Header("Centre panel")]
        [Tooltip("The panel ground. Flood drives its colour, so it must not be shared with the sides.")]
        [SerializeField] private Graphic m_centrePanel;

        [SerializeField] private TerminalDataField m_centreField;

        [SerializeField] private DotMatrixText m_centreLabel;

        [Header("Side panels")]
        [SerializeField] private TerminalDataField m_leftField;

        [SerializeField] private TerminalDataField m_rightField;

        [Header("Labels")]
        [Tooltip("What the centre panel calls itself while it boots. A generic status line, so usable.")]
        [SerializeField] private string m_bootLabel = "SYSTEM BOOT";

        [Tooltip("What it settles on. Never the reference's host name, which is a trademark.")]
        [SerializeField] private string m_hostLabel = "ROOT/NET 0447";

        [Header("Phase timing (authored starting values, not measurements)")]
        [Tooltip("D0: the panels sit at ground colour with nothing on them.")]
        [SerializeField] private float m_idleSeconds = 0.5f;

        [Tooltip("D1: the boot label scatters in before any field starts.")]
        [SerializeField] private float m_nameSeconds = 1.2f;

        [Tooltip("D2: all three fields fill. Measured at 1.7 s whatever the panel's cell count.")]
        [SerializeField] private float m_fillSeconds = 1.7f;

        [Tooltip("D3: full field, then the label changes over. Measured 1.7 s.")]
        [SerializeField] private float m_holdSeconds = 1.7f;

        [Tooltip("D4: the centre field empties. Measured 1.1 s.")]
        [SerializeField] private float m_purgeSeconds = 1.1f;

        [Header("Flood")]
        [Tooltip("D5 peak. Measured #18A8B5 — the whole B-roll ceiling, well short of white.")]
        [SerializeField] private Color m_floodColor = new Color32(0x18, 0xA8, 0xB5, 0xFF);

        [SerializeField] private bool m_loop = true;

        [Header("Motion")]
        [Tooltip("Step at the measured 6 Hz field tick, not the warm screen's 15 Hz.")]
        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private Sequence m_sequence;

        private void OnEnable()
        {
            Play();
        }

        private void OnDisable()
        {
            KillMotion();
            ApplyHeldState();
        }

        /// <summary>Restarts from D0. Called on enable, and by the loop at the end of D5.</summary>
        public void Play()
        {
            KillMotion();

            // D0 Idle — ground colour on all three panels, not one character anywhere.
            SetCoverage(0f);
            SetLabel(m_bootLabel, false);

            m_sequence = DOTween.Sequence().SetTarget(this);
            m_sequence.AppendInterval(m_idleSeconds);

            // D1 Name — the centre panel names itself first; the side panels are still empty.
            m_sequence.AppendCallback(
                () => TerminalMotion.ScatterWrite(m_centreLabel, m_bootLabel, m_motion));
            m_sequence.AppendInterval(m_nameSeconds);

            // D2 Fill — all three start on the same frame and finish together.
            m_sequence.AppendCallback(() =>
            {
                TerminalMotion.Populate(m_centreField, m_motion);
                TerminalMotion.Populate(m_leftField, m_motion);
                TerminalMotion.Populate(m_rightField, m_motion);
            });
            m_sequence.AppendInterval(m_fillSeconds);

            // D3 Hold — the change of name overlaps: the old one is still dropping characters while
            // the new one has started arriving, so the line is never empty and never doubled.
            m_sequence.AppendCallback(() => TerminalMotion.ScatterClear(m_centreLabel, m_motion));
            m_sequence.AppendInterval(m_holdSeconds * 0.5f);
            m_sequence.AppendCallback(
                () => TerminalMotion.ScatterWrite(m_centreLabel, m_hostLabel, m_motion));
            m_sequence.AppendInterval(m_holdSeconds * 0.5f);

            // D4 Purge — the centre field alone empties. The label stays lit through all of it, and
            // the side panels are not touched: data goes, the name remains.
            m_sequence.AppendCallback(() => TerminalMotion.Depopulate(m_centreField, m_motion));
            m_sequence.AppendInterval(m_purgeSeconds);

            // D5 Flood — hard ladder up and back, then round again.
            m_sequence.AppendCallback(
                () => TerminalMotion.Flood(m_centrePanel, m_floodColor, m_motion));
            m_sequence.AppendInterval(FloodSeconds());

            if (m_loop)
            {
                m_sequence.AppendCallback(Play);
            }
        }

        /// <summary>
        /// How long <c>Flood</c>'s ladder runs: three rungs up, the hold, one rung down and the return
        /// to ground. Kept in step with <c>TerminalMotion</c>'s ladders rather than serialized, so the
        /// sequence cannot drift out of sync with the measurement they encode.
        /// </summary>
        private float FloodSeconds()
        {
            return (5 + m_motion.FloodHoldSteps) * m_motion.StepSeconds;
        }

        private void SetCoverage(float coverage)
        {
            if (m_centreField != null)
            {
                m_centreField.Coverage = coverage;
            }

            if (m_leftField != null)
            {
                m_leftField.Coverage = coverage;
            }

            if (m_rightField != null)
            {
                m_rightField.Coverage = coverage;
            }
        }

        private void SetLabel(string text, bool visible)
        {
            if (m_centreLabel == null)
            {
                return;
            }

            m_centreLabel.Text = text;
            m_centreLabel.SetAllCharactersVisible(visible);
        }

        /// <summary>
        /// The D3 state, applied whenever the sequence is cancelled, so a screen that is switched off
        /// mid-run is left reading as a working terminal rather than a half-filled one.
        /// </summary>
        private void ApplyHeldState()
        {
            SetCoverage(1f);
            SetLabel(m_hostLabel, true);
        }

        private void KillMotion()
        {
            if (m_sequence != null)
            {
                m_sequence.Kill();
                m_sequence = null;
            }

            TerminalMotion.Kill(this);
            TerminalMotion.Kill(m_centreLabel);
            TerminalMotion.Kill(m_centreField);
            TerminalMotion.Kill(m_leftField);
            TerminalMotion.Kill(m_rightField);
            TerminalMotion.Kill(m_centrePanel);
        }
    }
}
