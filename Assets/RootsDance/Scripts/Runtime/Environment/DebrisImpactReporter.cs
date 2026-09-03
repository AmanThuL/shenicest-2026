using System;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// Reports the first solid contact of a falling chunk — where and how hard — to whoever
    /// released it. One report per chunk: the sound and the camera care about the hit, not about
    /// the rubble grinding to a stop afterwards. Added at release time by
    /// <see cref="GreenhouseStairCollapse"/>, never authored.
    /// </summary>
    [DisallowMultipleComponent]
    public class DebrisImpactReporter : MonoBehaviour
    {
        /// <summary>Contact point in world space and closing speed in m/s.</summary>
        public event Action<Vector3, float> Impacted;

        private bool m_hasReported;

        private void OnCollisionEnter(Collision collision)
        {
            if (m_hasReported || collision.contactCount == 0)
            {
                return;
            }

            m_hasReported = true;
            Impacted?.Invoke(collision.GetContact(0).point, collision.relativeVelocity.magnitude);
        }
    }
}
