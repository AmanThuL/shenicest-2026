using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// A doorway that is also a seam between levels: walking into the trigger asks the bootstrap
    /// to load another level. It is the door-side half of a transition — the door itself only
    /// opens, and this only travels, so a door can be built, moved and re-skinned without touching
    /// where it goes.
    /// <para>
    /// It fires once. A level load unloads the scene this component lives in, so a second trigger
    /// enter can only come from a frame that slipped in between the request and the unload; that
    /// second request would restart the load and put the loading cover back up over a level the
    /// player is already standing in.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Collider))]
    public class LevelPortal : MonoBehaviour
    {
        [Tooltip("Data/Events/LoadLevelRequested — the bootstrap's level channel.")]
        [SerializeField] private LevelEventChannelSO m_loadLevelRequested;

        [Tooltip("The level this doorway leads to.")]
        [SerializeField] private LevelSO m_level;

        private bool m_hasFired;

        /// <summary>Editor-side wiring, so a builder does not have to reach in through serialization.</summary>
        public void Configure(LevelEventChannelSO loadLevelRequested, LevelSO level)
        {
            m_loadLevelRequested = loadLevelRequested;
            m_level = level;
        }

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
                Log.Warning("LevelPortal is missing its channel or level.", this);
                return;
            }

            m_hasFired = true;
            m_loadLevelRequested.RaiseEvent(m_level);
        }

        private void Reset()
        {
            GetComponent<Collider>().isTrigger = true;
        }

        private void OnValidate()
        {
            Collider trigger = GetComponent<Collider>();

            if (trigger != null)
            {
                trigger.isTrigger = true;
            }
        }
    }
}
