using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// The one owner of how high the arms rig sits. The clips are all authored against the standing
    /// baseline with no overall height displacement in the root bone (arms contract — "高度基准"),
    /// so the difference between crawling on the ground and standing up is applied here, once,
    /// instead of being baked into each clip.
    /// <para>
    /// Kept separate from <see cref="ArmsViewOffset"/> on purpose: that component decides where the
    /// arms sit relative to the eye (framing, taste, per-clip camera-bone correction); this one
    /// decides how high the whole body is. Adding them is fine, conflating them is not.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ArmsHeightRig : MonoBehaviour
    {
        [Tooltip("Local Y of the rig anchor when the character is standing.")]
        [SerializeField] private float m_standingLocalY;

        [Tooltip("Standing eye height of the character, in metres.")]
        [SerializeField] private float m_playerHeight = 1.75f;

        [Tooltip("Eye height while prone, in metres. The ground baseline is "
            + "standing − (player height − this).")]
        [SerializeField] private float m_groundOffset = 0.35f;

        [Tooltip("Shape of the ground-to-standing rise. Linear is fine; ease-out reads better.")]
        [SerializeField] private AnimationCurve m_riseCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

        private float m_from;
        private float m_to;
        private float m_elapsed;
        private float m_duration;
        private bool m_isBlending;

        /// <summary>Anchor height for a body lying on the ground.</summary>
        public float GroundLocalY => m_standingLocalY - (m_playerHeight - m_groundOffset);

        public float StandingLocalY => m_standingLocalY;

        /// <summary>Anchor height an action of this class is authored against.</summary>
        public float Resolve(ArmsHeightBase heightBase)
        {
            return heightBase == ArmsHeightBase.Ground ? GroundLocalY : m_standingLocalY;
        }

        /// <summary>
        /// Called by <see cref="ArmsDirector"/> when an action starts. A transition action rises
        /// across its own duration; anything else snaps to its baseline, which is a no-op whenever
        /// the rig is already there.
        /// </summary>
        public void Begin(ArmsHeightBase heightBase, float duration)
        {
            if (heightBase == ArmsHeightBase.GroundToStanding)
            {
                m_from = GroundLocalY;
                m_to = m_standingLocalY;
                m_elapsed = 0f;
                m_duration = Mathf.Max(duration, 0.0001f);
                m_isBlending = true;
                return;
            }

            m_isBlending = false;
            SetLocalY(Resolve(heightBase));
        }

        private void Update()
        {
            if (!m_isBlending)
            {
                return;
            }

            m_elapsed += Time.deltaTime;
            float t = Mathf.Clamp01(m_elapsed / m_duration);
            SetLocalY(Mathf.LerpUnclamped(m_from, m_to, m_riseCurve.Evaluate(t)));

            if (t >= 1f)
            {
                m_isBlending = false;
            }
        }

        private void SetLocalY(float y)
        {
            Vector3 p = transform.localPosition;

            if (Mathf.Approximately(p.y, y))
            {
                return;
            }

            p.y = y;
            transform.localPosition = p;
        }

        /// <summary>Captures the current height as the standing baseline.</summary>
        [ContextMenu("Capture Standing Height From Transform")]
        private void CaptureStanding()
        {
            m_standingLocalY = transform.localPosition.y;
        }
    }
}
