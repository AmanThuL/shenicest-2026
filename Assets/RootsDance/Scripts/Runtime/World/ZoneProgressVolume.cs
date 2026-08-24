using RootsDance.Player;
using UnityEngine;

namespace RootsDance.World
{
    /// <summary>
    /// Projects the player's position onto a start→end axis and hands the 0..1 result to every
    /// registered zone view. No object lookups: the player finds us by walking into the volume.
    /// </summary>
    [RequireComponent(typeof(Collider))]
    public class ZoneProgressVolume : MonoBehaviour
    {
        [Tooltip("Where the contaminated zone is at its worst (progress 0).")]
        [SerializeField] private Transform m_start;

        [Tooltip("Where the grass belt begins (progress 1).")]
        [SerializeField] private Transform m_end;

        [Tooltip("Art-side components that visualise the gradient. Anything implementing IZoneView.")]
        [SerializeField] private MonoBehaviour[] m_viewBehaviours;

        private IZoneView[] m_views;
        private float m_lastProgress = -1f;

        private void Awake()
        {
            m_views = new IZoneView[m_viewBehaviours.Length];

            for (int i = 0; i < m_viewBehaviours.Length; i++)
            {
                m_views[i] = m_viewBehaviours[i] as IZoneView;
            }
        }

        private void OnTriggerStay(Collider other)
        {
            if (m_start == null || m_end == null)
            {
                return;
            }

            if (other.GetComponentInParent<PlayerTriggerProbe>() == null)
            {
                return;
            }

            Vector3 axis = m_end.position - m_start.position;
            float lengthSquared = axis.sqrMagnitude;

            if (lengthSquared < 0.0001f)
            {
                return;
            }

            float progress = Mathf.Clamp01(Vector3.Dot(other.transform.position - m_start.position, axis)
                / lengthSquared);

            // Only push when it actually moved; art views may run animation on every call.
            if (Mathf.Abs(progress - m_lastProgress) < 0.001f)
            {
                return;
            }

            m_lastProgress = progress;

            for (int i = 0; i < m_views.Length; i++)
            {
                if (m_views[i] != null)
                {
                    m_views[i].SetZoneProgress(progress);
                }
            }
        }

        private void Reset()
        {
            GetComponent<Collider>().isTrigger = true;
        }
    }
}
