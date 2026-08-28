using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// The gameplay half of a fluorescent mark: it decides when the player has actually found the
    /// marks with the flashlight, and says so once.
    /// </summary>
    /// <remarks>
    /// <para>
    /// The glow itself is entirely the shader's job — <c>RootsDance/Environment/FluorescentReveal</c>
    /// reacts to the beam per pixel, with no help from here, so the marks look right even with this
    /// component removed. What a shader cannot do is tell the rest of the game that the player has
    /// seen something, which is what this is for: it re-evaluates the same cone on the CPU through
    /// <see cref="FlashlightBeam.Energy"/> and raises a channel the first time the marks have been
    /// held in the beam long enough to count as read rather than swept past.
    /// </para>
    /// <para>
    /// The beam arrives through <see cref="FlashlightBeamBroadcaster.Beam"/>, a static, for the same
    /// reason the shader reads a global: the flashlight is in the gameplay scene and the marks are
    /// dressed into an environment scene, and no serialized reference crosses that boundary. The
    /// precedent in this project is <c>WorldAccess.State</c>, which the flashlight itself reads.
    /// </para>
    /// </remarks>
    public class FluorescentRevealMarks : MonoBehaviour
    {
        [Header("Wiring")]
        [Tooltip("The quad carrying the FluorescentReveal material. Its bounds centre is the point " +
                 "tested against the beam. Falls back to a Renderer on this object.")]
        [SerializeField] private Renderer m_marks;

        [Tooltip("Raised once, the first time the marks have been read. Optional.")]
        [SerializeField] private VoidEventChannelSO m_revealed;

        [Header("Reading")]
        [Tooltip("Beam energy at the marks, 0..1, that counts as lit. The shader's own falloff " +
                 "makes anything under about 0.2 too dim to read.")]
        [Range(0f, 1f)][SerializeField] private float m_threshold = 0.35f;

        [Tooltip("Seconds the marks must stay lit before they count as read, so sweeping the beam " +
                 "across them on the way past does not spend the discovery.")]
        [SerializeField] private float m_dwellSeconds = 0.6f;

        [Header("Line of sight")]
        [Tooltip("Reject the beam when something stands between the torch and the marks. Off by " +
                 "default: the beam starts at the eye, so anything blocking it also hides the marks.")]
        [SerializeField] private bool m_requireLineOfSight;

        [Tooltip("What counts as blocking. Only read while Require Line Of Sight is on.")]
        [SerializeField] private LayerMask m_blockers = ~0;

        private float m_litSeconds;
        private bool m_hasMarks;

        /// <summary>Beam energy at the marks on the last frame, 0..1.</summary>
        public float Energy { get; private set; }

        /// <summary>True once the marks have been held in the beam for the dwell time.</summary>
        public bool IsRevealed { get; private set; }

        private void Awake()
        {
            if (m_marks == null)
            {
                m_marks = GetComponent<Renderer>();
            }

            m_hasMarks = m_marks != null;

            if (!m_hasMarks)
            {
                Log.Error("FluorescentRevealMarks has no Renderer to test; it will never fire.", this);
            }
        }

        private void Update()
        {
            if (!m_hasMarks || IsRevealed)
            {
                return;
            }

            Vector3 point = m_marks.bounds.center;
            FlashlightBeam beam = FlashlightBeamBroadcaster.Beam;

            Energy = beam.Energy(point);

            if (Energy > 0f && m_requireLineOfSight && IsBlocked(beam.Origin, point))
            {
                Energy = 0f;
            }

            // Dwell only accumulates; a beam that slips off resets it, so the marks have to be held
            // rather than crossed. Nothing here fires more than once, hence the early return above.
            if (Energy < m_threshold)
            {
                m_litSeconds = 0f;
                return;
            }

            m_litSeconds += Time.deltaTime;

            if (m_litSeconds < m_dwellSeconds)
            {
                return;
            }

            IsRevealed = true;

            if (m_revealed != null)
            {
                m_revealed.RaiseEvent();
            }
        }

        private bool IsBlocked(Vector3 from, Vector3 to)
        {
            Vector3 offset = to - from;
            float distance = offset.magnitude;

            if (distance <= 1e-4f)
            {
                return false;
            }

            // Stop just short of the marks so their own quad is never the thing that blocks them.
            return Physics.Raycast(from, offset / distance, distance - 0.02f, m_blockers,
                QueryTriggerInteraction.Ignore);
        }
    }
}
