using RootsDance.Core;
using RootsDance.Data;
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
    /// <para>
    /// Every tunable lives in an <see cref="EnemyConfigSO"/> asset rather than on this component,
    /// so the pursuit is retuned without opening a scene.
    /// </para>
    /// </summary>
    public class ChaseMonster : MonoBehaviour
    {
        [Header("Config")]
        [Tooltip("Pursuit tuning. Data/Config/EnemyConfig.asset.")]
        [SerializeField] private EnemyConfigSO m_config;

        [Header("Body")]
        [Tooltip("Animator on the boss mesh, running the looping chase cycle. Held on its first "
            + "frame while the thing is still rooted, then released when the pursuit begins.")]
        [SerializeField] private Animator m_animator;

        private readonly RaycastHit[] m_groundHits = new RaycastHit[8];
        private ChaseTrail m_trail;
        private Transform m_target;

        /// <summary>True while it is following the trail.</summary>
        public bool IsPursuing { get; private set; }

        private void Awake()
        {
            if (m_config == null)
            {
                Log.Error("ChaseMonster has no EnemyConfig; it cannot pursue.", this);
                return;
            }

            m_trail = new ChaseTrail(m_config.TrailSpacing, m_config.MaxTrailPoints);
        }

        /// <summary>Holds the birth pose: on screen, but not yet moving and not yet animating.</summary>
        public void ShowRooted()
        {
            if (m_animator != null)
            {
                m_animator.speed = 0f;
            }
        }

        /// <summary>Releases the chase cycle and starts following the target's trail.</summary>
        public void BeginPursuit(Transform target)
        {
            if (target == null || m_trail == null)
            {
                return;
            }

            m_target = target;
            m_trail.Clear();
            m_trail.Record(transform.position);

            if (m_animator != null)
            {
                m_animator.speed = m_config.ChaseCycleSpeed;
            }

            IsPursuing = true;
        }

        /// <summary>Stops in place. The body stays where it stood until something hides it.</summary>
        public void StopPursuit()
        {
            IsPursuing = false;
            m_target = null;

            if (m_animator != null)
            {
                m_animator.speed = 0f;
            }
        }

        private void Update()
        {
            if (!IsPursuing || m_target == null)
            {
                return;
            }

            Vector3 head = m_target.position;
            m_trail.Record(head);

            float desiredGap = m_config.DesiredGapMeters;

            Vector3 pursuit;
            bool onTrail = m_trail.TryGetPursuitPoint(head, desiredGap, out pursuit);

            float gap = Vector3.Distance(transform.position, head);
            float speed = ChasePacing.SpeedForGap(
                gap, desiredGap, m_config.BaseSpeed, m_config.CatchupPerMeter, m_config.MaxSpeed);
            float step = ChasePacing.StepDistance(speed, Time.deltaTime, onTrail, gap, desiredGap);

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
                    transform.rotation, facing, m_config.TurnDegreesPerSecond * Time.deltaTime);
            }

            transform.position = next;

            // The chase cycle belongs to the creature, not the player's input. The transform may
            // briefly hold its theatrical gap, but the mutated body remains active and threatening.
        }

        /// <summary>The highest ground under the point, or its own height when nothing is hit.</summary>
        private float GroundHeightAt(Vector3 point)
        {
            Vector3 origin = point + Vector3.up * 3f;
            int count = Physics.RaycastNonAlloc(
                origin, Vector3.down, m_groundHits, 12f, m_config.GroundLayers,
                QueryTriggerInteraction.Ignore);

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
