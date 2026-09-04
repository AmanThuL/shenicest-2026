using RootsDance.App;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// Arms the greenhouse exit branch. Walking out of the greenhouse — doors answering the
    /// player's approach, the exterior streaming in behind them — is not standing behavior; it is
    /// the branch the doomed circulation choice opens. The doors sit locked and the stream triggers
    /// inactive, and this component connects them once <see cref="WorldFlags.k_ChaseStarted"/> is up.
    /// <para>
    /// That flag, not <see cref="WorldFlags.k_ChaseEscaped"/>: the console's cue sequence raises it
    /// at the end of the whole beat — the wrong cycle chosen, the deck collapsed, the fall landed,
    /// the dialogue finished — which is the first moment the player is meant to head for the door.
    /// Escaped is the far end of the run, out at the car, and gating on it would keep the exits shut
    /// for the entire chase, leaving the player locked in with the boss.
    /// </para>
    /// <para>
    /// It polls <see cref="WorldAccess.State"/> instead of subscribing to the flag channel: a poll
    /// sees flags seeded by DevPlay checkpoints and flags restored by a rescue in the same way it
    /// sees a live raise, where a one-shot event check would miss the silent ones. It also works
    /// both ways — a rescue restoring a pre-chase snapshot re-locks the exits.
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
        private bool m_appliedArmed;

        private void Update()
        {
            // WorldAccess may not exist yet during scene bring-up; keep trying (see ChaseDirector).
            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            if (m_doors == null || m_streamTriggers == null)
            {
                Discover();

                if (m_doors == null || m_streamTriggers == null)
                {
                    return;
                }
            }

            bool armed = state.HasFlag(WorldFlags.k_ChaseStarted);
            bool justArmed = armed && !(m_hasApplied && m_appliedArmed);

            if (m_hasApplied && armed == m_appliedArmed)
            {
                return;
            }

            foreach (AutomaticSlidingDoor door in m_doors)
            {
                if (door == null)
                {
                    continue;
                }

                if (armed)
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
                    trigger.gameObject.SetActive(armed);
                }
            }

            if (justArmed)
            {
                RequestExteriorPreload();
            }

            m_hasApplied = true;
            m_appliedArmed = armed;
        }

        /// <summary>
        /// Starts loading the exterior in the background the moment the branch arms, instead of
        /// waiting for the player to physically reach a corridor trigger. The scene stays inactive —
        /// nothing appears and no frame is lost — so that when a trigger does fire, all that is left
        /// is activation behind the cover. One trigger is enough: SceneLoader dedupes preloads.
        /// </summary>
        private void RequestExteriorPreload()
        {
            if (m_streamTriggers == null)
            {
                return;
            }

            for (int i = 0; i < m_streamTriggers.Length; i++)
            {
                if (m_streamTriggers[i] != null)
                {
                    m_streamTriggers[i].RequestPreload();
                    return;
                }
            }
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

            // Either list being non-empty means the greenhouse scenes are up and the traversal
            // saw them; latching on the doors alone would leave the stream triggers unmanaged
            // whenever the environment scene is still loading or its doors have been renamed.
            if (doors.Count > 0 || triggers.Count > 0)
            {
                m_doors = doors.ToArray();
                m_streamTriggers = triggers.ToArray();
            }
        }
    }
}
