using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Chase
{
    /// <summary>
    /// A breadcrumb trail of where the player has been, so the boss can run the same route —
    /// through the door, round the shelves — without a NavMesh: the player's own path is walkable
    /// by construction. Pure data, no scene access, so the follow maths is EditMode-testable.
    /// <para>
    /// Points are only stored every <c>spacing</c> metres, and the pursuit point is measured from
    /// the <em>live</em> head position back along the stored points, so the pursuer's distance
    /// behind the player is continuous even though the trail itself is coarse.
    /// </para>
    /// </summary>
    public class ChaseTrail
    {
        private readonly List<Vector3> m_points = new List<Vector3>();
        private readonly float m_spacing;
        private readonly int m_maxPoints;

        public ChaseTrail(float spacingMeters, int maxPoints)
        {
            m_spacing = Mathf.Max(0.01f, spacingMeters);
            m_maxPoints = Mathf.Max(2, maxPoints);
        }

        public int Count => m_points.Count;

        /// <summary>Stores the position if it is at least one spacing from the last stored one.</summary>
        public void Record(Vector3 position)
        {
            if (m_points.Count > 0
                && (position - m_points[m_points.Count - 1]).sqrMagnitude < m_spacing * m_spacing)
            {
                return;
            }

            m_points.Add(position);

            if (m_points.Count > m_maxPoints)
            {
                m_points.RemoveAt(0);
            }
        }

        public void Clear()
        {
            m_points.Clear();
        }

        /// <summary>
        /// The point <paramref name="gapMeters"/> behind <paramref name="head"/>, walking back along
        /// the recorded route. False when the trail is still shorter than the gap — the pursuit
        /// point is then the oldest thing known, which is where the pursuer started from.
        /// </summary>
        public bool TryGetPursuitPoint(Vector3 head, float gapMeters, out Vector3 point)
        {
            Vector3 ahead = head;
            float remaining = gapMeters;

            for (int i = m_points.Count - 1; i >= 0; i--)
            {
                Vector3 behind = m_points[i];
                float segment = (ahead - behind).magnitude;

                if (segment >= remaining)
                {
                    point = segment <= 0.0001f
                        ? behind
                        : Vector3.Lerp(ahead, behind, remaining / segment);
                    return true;
                }

                remaining -= segment;
                ahead = behind;
            }

            point = ahead;
            return false;
        }
    }
}
