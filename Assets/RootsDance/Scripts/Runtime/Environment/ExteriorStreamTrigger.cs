using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Environment
{
    /// <summary>
    /// A one-shot proximity trigger that starts streaming a distant scene in additively, without
    /// unloading or covering anything — placed at the corridor leading out of GreenhouseInterior so
    /// the real exterior geometry (Main_Environment) replaces the baked-sky backdrop seen through the
    /// windows before the player reaches it, instead of the whole hub loading the moment the level
    /// opens.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Collider))]
    public class ExteriorStreamTrigger : MonoBehaviour
    {
        [Tooltip("Data/Events/StreamSceneRequested — the bootstrap's additive-content channel.")]
        [SerializeField] private StringEventChannelSO m_streamSceneRequested;

        [Tooltip("Full asset path of the scene to stream in (see RootsDance.App.ScenePaths).")]
        [SerializeField] private string m_scenePath;

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

            if (m_streamSceneRequested == null || string.IsNullOrEmpty(m_scenePath))
            {
                Log.Warning("ExteriorStreamTrigger is missing its channel or scene path.", this);
                return;
            }

            m_hasFired = true;
            m_streamSceneRequested.RaiseEvent(m_scenePath);
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
