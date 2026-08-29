using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Chase
{
    /// <summary>
    /// The seam between the two legs of the chase: a trigger at the greenhouse exit that asks the
    /// bootstrap for the outdoor level. The chase itself survives the switch through the world
    /// flags — the next scene's <see cref="ChaseDirector"/> resumes from the ground truth.
    /// The object stays inactive until the director arms it, so walking in the door during normal
    /// play never fires it.
    /// </summary>
    [RequireComponent(typeof(Collider))]
    public class ChaseExitPortal : MonoBehaviour
    {
        [Tooltip("Data/Events/LoadLevelRequested — the bootstrap's level channel.")]
        [SerializeField] private LevelEventChannelSO m_loadLevelRequested;

        [Tooltip("The level the chase continues in.")]
        [SerializeField] private LevelSO m_level;

        private bool m_hasFired;

        private void OnTriggerEnter(Collider other)
        {
            if (m_hasFired)
            {
                return;
            }

            if (other.GetComponentInParent<PlayerTriggerProbe>() == null)
            {
                return;
            }

            if (m_loadLevelRequested == null || m_level == null)
            {
                Log.Warning("ChaseExitPortal is missing its channel or level.", this);
                return;
            }

            m_hasFired = true;
            m_loadLevelRequested.RaiseEvent(m_level);
        }

        private void Reset()
        {
            GetComponent<Collider>().isTrigger = true;
        }
    }
}
