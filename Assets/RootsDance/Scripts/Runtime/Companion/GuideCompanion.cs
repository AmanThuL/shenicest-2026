using System;
using RootsDance.Core;
using RootsDance.Dialogue;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Companion
{
    /// <summary>
    /// The flower sprite leading the way: it waits ahead at a point, moves on once the player has
    /// caught up, and comes back if they fall too far behind.
    /// <para>
    /// Deliberately not a NavMesh agent and not a follow rig. The script asks for exactly one
    /// behaviour — "it knows where the greenhouse is and it goes there faster than the player" —
    /// and a list of points with a catch-up radius is the whole of it. A NavMesh would add a bake
    /// to every level change and buy nothing: the sprite flies, and the route is a corridor.
    /// </para>
    /// <para>
    /// The player is found once, in <c>Start</c>, rather than serialized, because the sprite is
    /// dressed into an environment scene and the player lives in the gameplay one — a serialized
    /// reference cannot cross that boundary, and this lookup runs once (guideline 04's rule about
    /// Find* is about per-frame use, not initialisation).
    /// </para>
    /// </summary>
    public class GuideCompanion : MonoBehaviour
    {
        /// <summary>One place the sprite waits, and what it says on arriving there.</summary>
        [Serializable]
        public class Stop
        {
            [Tooltip("Where the sprite goes and hovers.")]
            public Transform m_point;

            [Tooltip("Optional line played once the sprite reaches this point.")]
            public DialogueSO m_lineOnArrive;

            [Tooltip("How close the player has to get before the sprite moves on. 0 uses the "
                + "component's default.")]
            public float m_advanceRadius;
        }

        [Header("Route")]
        [SerializeField] private Stop[] m_stops = new Stop[0];

        [Tooltip("Default catch-up radius for a stop that does not set its own.")]
        [SerializeField] private float m_advanceRadius = 4f;

        [Tooltip("How close the sprite has to be to a point to count as arrived.")]
        [SerializeField] private float m_arriveDistance = 0.35f;

        [Header("Movement")]
        [SerializeField] private float m_moveSpeed = 2.6f;

        [Tooltip("Beyond this distance the sprite abandons its point and comes back to the player. "
            + "0 turns the leash off, and the sprite simply waits.")]
        [SerializeField] private float m_leashDistance = 14f;

        [Tooltip("How far in front of the player the sprite waits when it has come back for them.")]
        [SerializeField] private float m_returnStandoff = 2.5f;

        [Header("Hover")]
        [Tooltip("Vertical bob, in metres. It is what stops the sprite reading as a floating prop.")]
        [SerializeField] private float m_hoverAmplitude = 0.12f;

        [SerializeField] private float m_hoverFrequency = 1.4f;

        [Tooltip("Yaw between the rig's +Z and where her face actually is on the model, in "
            + "degrees. Matches FollowCompanion's offset for the same model.")]
        [Range(0f, 360f)]
        [SerializeField] private float m_modelYawOffset = FollowCompanion.k_ModelYawOffset;

        [Header("Broadcasts on")]
        [SerializeField] private DialogueEventChannelSO m_dialogueChannel;

        private Transform m_player;
        private Vector3 m_basePosition;
        private int m_stopIndex;
        private float m_hoverPhase;

        /// <summary>Which stop the sprite is heading for. Past the last one it simply waits.</summary>
        public int StopIndex => m_stopIndex;

        private void Awake()
        {
            m_basePosition = transform.position;

            // A per-instance phase so two sprites in one room do not bob in lockstep.
            m_hoverPhase = transform.position.x + transform.position.z;
        }

        private void Start()
        {
            PlayerTriggerProbe probe = FindFirstObjectByType<PlayerTriggerProbe>();

            if (probe == null)
            {
                Log.Warning("GuideCompanion found no player; it will hover in place.", this);
                return;
            }

            m_player = probe.transform;
        }

        private void Update()
        {
            Vector3 target = ResolveTarget();

            m_basePosition = Vector3.MoveTowards(m_basePosition, target, m_moveSpeed * Time.deltaTime);
            m_hoverPhase += Time.deltaTime * m_hoverFrequency;

            transform.position = m_basePosition + Vector3.up * (Mathf.Sin(m_hoverPhase) * m_hoverAmplitude);

            if (m_player != null)
            {
                Vector3 toPlayer = m_player.position - transform.position;
                toPlayer.y = 0f;

                if (toPlayer.sqrMagnitude > 0.0001f)
                {
                    transform.rotation = Quaternion.LookRotation(toPlayer)
                        * Quaternion.Euler(0f, m_modelYawOffset, 0f);
                }
            }

            TryAdvance();
        }

        private Vector3 ResolveTarget()
        {
            Stop stop = CurrentStop();

            if (m_player == null)
            {
                return stop == null || stop.m_point == null ? m_basePosition : stop.m_point.position;
            }

            // Too far behind: give up the point and go back for them, standing off so the sprite
            // does not end up inside the camera.
            if (m_leashDistance > 0f
                && Vector3.Distance(m_player.position, m_basePosition) > m_leashDistance)
            {
                Vector3 toSprite = m_basePosition - m_player.position;
                toSprite.y = 0f;

                Vector3 direction = toSprite.sqrMagnitude > 0.0001f
                    ? toSprite.normalized
                    : m_player.forward;

                return m_player.position + direction * m_returnStandoff + Vector3.up * 1.2f;
            }

            if (stop == null || stop.m_point == null)
            {
                return m_basePosition;
            }

            return stop.m_point.position;
        }

        private void TryAdvance()
        {
            Stop stop = CurrentStop();

            if (stop == null || stop.m_point == null || m_player == null)
            {
                return;
            }

            // Arrival is about the sprite; advancing is about the player. Both have to be true, or
            // the sprite either runs the whole route while the player reads a sign, or never moves.
            if (Vector3.Distance(m_basePosition, stop.m_point.position) > m_arriveDistance)
            {
                return;
            }

            float radius = stop.m_advanceRadius > 0f ? stop.m_advanceRadius : m_advanceRadius;

            if (Vector3.Distance(m_player.position, stop.m_point.position) > radius)
            {
                return;
            }

            if (stop.m_lineOnArrive != null && m_dialogueChannel != null)
            {
                m_dialogueChannel.RaiseEvent(stop.m_lineOnArrive);
            }

            m_stopIndex++;
        }

        private Stop CurrentStop()
        {
            return m_stopIndex >= 0 && m_stopIndex < m_stops.Length ? m_stops[m_stopIndex] : null;
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(0.62f, 0.90f, 0.55f, 0.9f);

            for (int i = 0; i < m_stops.Length; i++)
            {
                if (m_stops[i] == null || m_stops[i].m_point == null)
                {
                    continue;
                }

                Vector3 point = m_stops[i].m_point.position;
                float radius = m_stops[i].m_advanceRadius > 0f ? m_stops[i].m_advanceRadius : m_advanceRadius;

                Gizmos.DrawWireSphere(point, radius);

                if (i + 1 < m_stops.Length && m_stops[i + 1] != null && m_stops[i + 1].m_point != null)
                {
                    Gizmos.DrawLine(point, m_stops[i + 1].m_point.position);
                }
            }
        }
    }
}
