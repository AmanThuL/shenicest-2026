using UnityEngine;

namespace RootsDance.Chase
{
    /// <summary>
    /// The boss during the chase: a prop that hangs behind the player, not an opponent. It replays
    /// the player's own breadcrumb trail (<see cref="ChaseTrail"/>) at a rubber-banded speed
    /// (<see cref="ChasePacing"/>), so it corners through doors without a NavMesh and is always in
    /// frame when the camera's shoulder check turns round. It never actually catches anyone —
    /// per the chase design, the fear is played by the camera, not by a fail state.
    /// <para>
    /// Movement is a kinematic transform write with a downward probe for the ground; there is no
    /// Rigidbody to fight and nothing else owns this transform.
    /// </para>
    /// </summary>
    public class ChaseMonster : MonoBehaviour
    {
        [Header("Bodies")]
        [Tooltip("The rooted form shown while it is still tearing itself out of the planter.")]
        [SerializeField] private GameObject m_rootedBody;

        [Tooltip("The uprooted form that runs. Swapped in when pursuit begins.")]
        [SerializeField] private GameObject m_uprootedBody;

        [Header("Pacing")]
        [Tooltip("Metres it tries to stay behind the player. The shoulder check reads best when "
            + "there is something to see at exactly this distance.")]
        [Min(1f)]
        [SerializeField] private float m_desiredGapMeters = 9f;

        [Tooltip("Speed at the desired gap, in m/s. The player sprints at 4.4.")]
        [Min(0f)]
        [SerializeField] private float m_baseSpeed = 4.2f;

        [Tooltip("Extra m/s per metre it has fallen behind the desired gap (and less per metre it "
            + "is too close).")]
        [Min(0f)]
        [SerializeField] private float m_catchupPerMeter = 0.35f;

        [Tooltip("Hard speed cap, in m/s.")]
        [Min(0f)]
        [SerializeField] private float m_maxSpeed = 6.5f;

        [Header("Trail")]
        [Tooltip("Metres between stored breadcrumbs. Coarser is cheaper; the pursuit point is "
            + "interpolated, so this does not make the motion steppy.")]
        [Min(0.1f)]
        [SerializeField] private float m_trailSpacing = 0.75f;

        [Tooltip("Oldest breadcrumbs are dropped past this count.")]
        [Min(16)]
        [SerializeField] private int m_maxTrailPoints = 256;

        [Header("Grounding")]
        [Tooltip("Layers the feet probe treats as ground. Keep in step with the level's Ground layer.")]
        [SerializeField] private LayerMask m_groundLayers = 1 << 8;

        [Tooltip("Degrees per second it can turn to face its motion.")]
        [Min(30f)]
        [SerializeField] private float m_turnDegreesPerSecond = 540f;

        private readonly RaycastHit[] m_groundHits = new RaycastHit[8];
        private ChaseTrail m_trail;
        private Transform m_target;

        /// <summary>True while it is following the trail.</summary>
        public bool IsPursuing { get; private set; }

        private void Awake()
        {
            m_trail = new ChaseTrail(m_trailSpacing, m_maxTrailPoints);
        }

        /// <summary>Shows the rooted form only: the birth pose, before pursuit begins.</summary>
        public void ShowRooted()
        {
            SetBodies(rooted: true);
        }

        /// <summary>Swaps to the uprooted form and starts following the target's trail.</summary>
        public void BeginPursuit(Transform target)
        {
            if (target == null)
            {
                return;
            }

            m_target = target;
            m_trail.Clear();
            m_trail.Record(transform.position);
            SetBodies(rooted: false);
            IsPursuing = true;
        }

        /// <summary>Stops in place. The body stays where it stood until something hides it.</summary>
        public void StopPursuit()
        {
            IsPursuing = false;
            m_target = null;
        }

        private void Update()
        {
            if (!IsPursuing || m_target == null)
            {
                return;
            }

            Vector3 head = m_target.position;
            m_trail.Record(head);

            Vector3 pursuit;
            bool onTrail = m_trail.TryGetPursuitPoint(head, m_desiredGapMeters, out pursuit);

            float gap = Vector3.Distance(transform.position, head);
            float speed = ChasePacing.SpeedForGap(
                gap, m_desiredGapMeters, m_baseSpeed, m_catchupPerMeter, m_maxSpeed);
            float step = ChasePacing.StepDistance(
                speed, Time.deltaTime, onTrail, gap, m_desiredGapMeters);

            if (!onTrail)
            {
                // Nothing on the route to aim at yet — head for the player; StepDistance is what
                // keeps it from closing past the gap it is supposed to hold.
                pursuit = head;
            }

            Vector3 next = Vector3.MoveTowards(transform.position, pursuit, step);
            next.y = GroundHeightAt(next);

            Vector3 motion = next - transform.position;
            motion.y = 0f;

            if (motion.sqrMagnitude > 0.000001f)
            {
                Quaternion facing = Quaternion.LookRotation(motion, Vector3.up);
                transform.rotation = Quaternion.RotateTowards(
                    transform.rotation, facing, m_turnDegreesPerSecond * Time.deltaTime);
            }

            transform.position = next;
        }

        private void SetBodies(bool rooted)
        {
            if (m_rootedBody != null)
            {
                m_rootedBody.SetActive(rooted);
            }

            if (m_uprootedBody != null)
            {
                m_uprootedBody.SetActive(!rooted);
            }
        }

        /// <summary>The highest ground under the point, or its own height when nothing is hit.</summary>
        private float GroundHeightAt(Vector3 point)
        {
            Vector3 origin = point + Vector3.up * 3f;
            int count = Physics.RaycastNonAlloc(
                origin, Vector3.down, m_groundHits, 12f, m_groundLayers, QueryTriggerInteraction.Ignore);

            float best = float.MinValue;

            for (int i = 0; i < count; i++)
            {
                if (m_groundHits[i].point.y > best)
                {
                    best = m_groundHits[i].point.y;
                }
            }

            return best > float.MinValue ? best : point.y;
        }
    }
}
