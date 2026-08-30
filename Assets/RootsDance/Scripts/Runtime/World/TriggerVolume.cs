using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.World
{
    /// <summary>
    /// Raises one world flag when the player's trigger probe enters. It only *queues* the change —
    /// everything that reacts (radio, HUD, zone view) listens to the flag channel instead, so a
    /// callback raised during the physics step never races the input read in Update.
    /// Re-entering is harmless: flags are idempotent, and there is deliberately no exit rollback.
    /// </summary>
    [RequireComponent(typeof(Collider))]
    public class TriggerVolume : MonoBehaviour
    {
        [Tooltip("World flag to raise. Constants that code reacts to live in RootsDance.Core.WorldFlags.")]
        [SerializeField] private string m_flagId;

        private void OnTriggerEnter(Collider other)
        {
            if (string.IsNullOrEmpty(m_flagId))
            {
                Log.Warning("TriggerVolume has no flag id.", this);
                return;
            }

            if (other.GetComponentInParent<PlayerTriggerProbe>() == null)
            {
                return;
            }

            WorldAccess.Enqueue(new RaiseFlagCommand(m_flagId), this);
        }

        private void Reset()
        {
            GetComponent<Collider>().isTrigger = true;
        }
    }
}
