using System.Collections.Generic;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// Keeps the sky this level owns when another scene is streamed in behind it as a backdrop.
    /// <para>
    /// Two things arriving with a streamed exterior fight the interior for the frame: a second
    /// directional light (HDRP hands the sun slot to one of them, and which one it picks can change
    /// between frames — that flicker is what reads as two suns fighting each other), and a global
    /// Volume, whose Visual Environment and sky overrides apply everywhere at once and so replace
    /// the interior's sky wholesale. Both are switched off for the duration; everything is restored
    /// when this component goes away, which is exactly the moment the streamed scene stops being a
    /// backdrop and becomes the level in its own right.
    /// </para>
    /// <para>
    /// The mute lands on <see cref="SceneManager.sceneLoaded"/> rather than on the channel echo:
    /// the echo arrives a frame or two after activation, and those are the expensive frames of a
    /// stream — every one of them drawn with both suns. Scenes belonging to this level are skipped
    /// by name, so the level's own additive parts keep their lighting.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class StreamedSunShadowMuter : MonoBehaviour
    {
        [Tooltip("Data/Events/StreamSceneRequested — the same channel SceneLoader echoes back once "
            + "the requested scene has finished streaming in. A backstop behind sceneLoaded.")]
        [SerializeField] private StringEventChannelSO m_additiveContentStreamed;

        private readonly List<Light> m_mutedLights = new List<Light>();
        private readonly List<Volume> m_mutedVolumes = new List<Volume>();

        /// <summary>Level prefix of this component's own scene, e.g. "GreenhouseInterior".</summary>
        private string m_ownLevelPrefix;

        private void OnEnable()
        {
            m_ownLevelPrefix = LevelPrefixOf(gameObject.scene.name);

            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised += OnAdditiveContentStreamed;
            }

            SceneManager.sceneLoaded += OnSceneLoaded;
        }

        private void OnDisable()
        {
            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised -= OnAdditiveContentStreamed;
            }

            SceneManager.sceneLoaded -= OnSceneLoaded;

            for (int i = 0; i < m_mutedLights.Count; i++)
            {
                if (m_mutedLights[i] != null)
                {
                    m_mutedLights[i].enabled = true;
                }
            }

            m_mutedLights.Clear();

            for (int i = 0; i < m_mutedVolumes.Count; i++)
            {
                if (m_mutedVolumes[i] != null)
                {
                    m_mutedVolumes[i].enabled = true;
                }
            }

            m_mutedVolumes.Clear();
        }

        private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
        {
            if (mode == LoadSceneMode.Additive)
            {
                Mute(scene);
            }
        }

        private void OnAdditiveContentStreamed(string scenePath)
        {
            Mute(SceneManager.GetSceneByPath(scenePath));
        }

        private void Mute(Scene streamed)
        {
            if (!streamed.IsValid() || !streamed.isLoaded || streamed == gameObject.scene)
            {
                return;
            }

            // Parts of this same level (…_Environment_2, …_Gameplay) are not backdrops.
            if (!string.IsNullOrEmpty(m_ownLevelPrefix)
                && LevelPrefixOf(streamed.name) == m_ownLevelPrefix)
            {
                return;
            }

            foreach (GameObject root in streamed.GetRootGameObjects())
            {
                foreach (Light light in root.GetComponentsInChildren<Light>(true))
                {
                    if (light.type == LightType.Directional && light.enabled)
                    {
                        light.enabled = false;
                        m_mutedLights.Add(light);
                    }
                }

                foreach (Volume volume in root.GetComponentsInChildren<Volume>(true))
                {
                    if (volume.isGlobal && volume.enabled)
                    {
                        volume.enabled = false;
                        m_mutedVolumes.Add(volume);
                    }
                }
            }
        }

        private static string LevelPrefixOf(string sceneName)
        {
            if (string.IsNullOrEmpty(sceneName))
            {
                return string.Empty;
            }

            int underscore = sceneName.IndexOf('_');
            return underscore < 0 ? sceneName : sceneName.Substring(0, underscore);
        }
    }
}
