using RootsDance.App;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// Arms the greenhouse exit branch. Walking out of the greenhouse — doors answering the
    /// player's approach, the exterior streaming in behind them — is not standing behavior; it is
    /// the branch that only exists after the chase has run its course. The doors sit locked and the
    /// stream triggers inactive in their scenes, and this component connects them once
    /// <see cref="WorldFlags.k_ChaseEscaped"/> is up.
    /// <para>
    /// It polls <see cref="WorldAccess.State"/> instead of subscribing to the flag channel: a poll
    /// sees flags seeded by DevPlay checkpoints and flags restored by a rescue in the same way it
    /// sees a live raise, where a one-shot event check would miss the silent ones. It also works
    /// both ways — a rescue restoring a pre-escape snapshot re-locks the exits.
    /// </para>
    /// <para>
    /// Targets are discovered from the loaded GreenhouseInterior scenes rather than serialized,
    /// because the doors live in the environment scene and the triggers in the gameplay scene, and
    /// a scene object cannot reference across scenes.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class GreenhouseExitArmer : MonoBehaviour
    {
        private AutomaticSlidingDoor[] m_doors;
        private ExteriorStreamTrigger[] m_streamTriggers;
        private bool m_hasApplied;
        private bool m_appliedEscaped;

        private void Update()
        {
            // WorldAccess may not exist yet during scene bring-up; keep trying (see ChaseDirector).
            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            if (m_doors == null || m_doors.Length == 0)
            {
                Discover();

                if (m_doors == null || m_doors.Length == 0)
                {
                    return;
                }
            }

            bool escaped = state.HasFlag(WorldFlags.k_ChaseEscaped);

            if (m_hasApplied && escaped == m_appliedEscaped)
            {
                return;
            }

            foreach (AutomaticSlidingDoor door in m_doors)
            {
                if (door == null)
                {
                    continue;
                }

                if (escaped)
                {
                    door.Unlock();
                }
                else
                {
                    door.Lock();
                }
            }

            foreach (ExteriorStreamTrigger trigger in m_streamTriggers)
            {
                if (trigger != null)
                {
                    trigger.gameObject.SetActive(escaped);
                }
            }

            m_hasApplied = true;
            m_appliedEscaped = escaped;
        }

        private void Discover()
        {
            var doors = new System.Collections.Generic.List<AutomaticSlidingDoor>();
            var triggers = new System.Collections.Generic.List<ExteriorStreamTrigger>();

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (!scene.isLoaded || !scene.name.StartsWith("GreenhouseInterior"))
                {
                    continue;
                }

                foreach (GameObject root in scene.GetRootGameObjects())
                {
                    doors.AddRange(root.GetComponentsInChildren<AutomaticSlidingDoor>(true));
                    triggers.AddRange(root.GetComponentsInChildren<ExteriorStreamTrigger>(true));
                }
            }

            if (doors.Count > 0)
            {
                m_doors = doors.ToArray();
                m_streamTriggers = triggers.ToArray();
            }
        }
    }
}
