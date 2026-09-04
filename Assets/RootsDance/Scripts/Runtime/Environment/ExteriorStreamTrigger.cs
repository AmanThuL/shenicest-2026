using RootsDance.App;
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
    /// <para>
    /// Walking out is a branch, not standing behavior, so the trigger asks world state for
    /// <see cref="m_requiredFlag"/> before it fires. That check lives here rather than only in
    /// <see cref="GreenhouseExitArmer"/>, which switches the object off: an object left active by a
    /// stale scene, a prefab revert or a teammate's save would otherwise stream the exterior into
    /// a level that has no business showing it. Ground truth decides, not the scene file.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(Collider))]
    public class ExteriorStreamTrigger : MonoBehaviour
    {
        [Tooltip("Data/Events/StreamSceneRequested — the bootstrap's additive-content channel.")]
        [SerializeField] private StringEventChannelSO m_streamSceneRequested;

        [Tooltip("Data/Events/PreloadSceneRequested — asks the bootstrap to load the scene in the "
            + "background now and hold it inactive, so the stream request later only pays for "
            + "activation. Empty means no preload: the stream request loads everything itself.")]
        [SerializeField] private StringEventChannelSO m_preloadSceneRequested;

        [Tooltip("Full asset path of the scene to stream in (see RootsDance.App.ScenePaths).")]
        [SerializeField] private string m_scenePath;

        [Tooltip("World flag that must be up before this may fire. flow.chase_started is raised by "
            + "the circulation console's cue sequence only after the doomed choice, the deck "
            + "collapse, the fall and the dialogue that follows are all over — which is exactly "
            + "when leaving the greenhouse becomes a thing the player is allowed to do. Empty "
            + "means ungated.")]
        [SerializeField] private string m_requiredFlag = WorldFlags.k_ChaseStarted;

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

            // Not latched: the player may walk this corridor long before the branch opens, and the
            // trigger has to still work when they come back through it during the chase.
            if (!IsArmed())
            {
                return;
            }

            Fire();
        }

        /// <summary>
        /// Asks for the scene to be loaded in the background now, without activating it and without
        /// firing this trigger. Called by <see cref="GreenhouseExitArmer"/> the moment the branch arms,
        /// so that by the time the player reaches this corridor the only cost left is activation.
        /// Harmless to call more than once — <see cref="SceneLoader"/> dedupes preloads itself.
        /// </summary>
        public void RequestPreload()
        {
            if (m_hasFired || m_preloadSceneRequested == null || string.IsNullOrEmpty(m_scenePath))
            {
                return;
            }

            m_preloadSceneRequested.RaiseEvent(m_scenePath);
        }

        private void Fire()
        {
            if (m_streamSceneRequested == null || string.IsNullOrEmpty(m_scenePath))
            {
                Log.Warning("ExteriorStreamTrigger is missing its channel or scene path.", this);
                return;
            }

            m_hasFired = true;
            m_streamSceneRequested.RaiseEvent(m_scenePath);
        }

        private bool IsArmed()
        {
            if (string.IsNullOrEmpty(m_requiredFlag))
            {
                return true;
            }

            IWorldStateReader state = WorldAccess.State;

            // No bootstrap yet means no branch has been taken yet; stay shut rather than guess.
            return state != null && state.HasFlag(m_requiredFlag);
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
