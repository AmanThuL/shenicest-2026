using RootsDance.Events;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// Turns off shadow casting on every directional light of a scene streamed in behind this one.
    /// HDRP allows a single shadow-casting directional light; while the interior level is resident
    /// its own sun owns that slot, and a streamed exterior arriving with a second one floods the
    /// console with cascade-atlas failures. The exterior sun keeps lighting its geometry — only its
    /// shadows are muted. Lives in the scene whose sun should win.
    /// </summary>
    [DisallowMultipleComponent]
    public class StreamedSunShadowMuter : MonoBehaviour
    {
        [Tooltip("Data/Events/StreamSceneRequested — the same channel SceneLoader echoes back once "
            + "the requested scene has finished streaming in.")]
        [SerializeField] private StringEventChannelSO m_additiveContentStreamed;

        private void OnEnable()
        {
            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised += OnAdditiveContentStreamed;
            }
        }

        private void OnDisable()
        {
            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised -= OnAdditiveContentStreamed;
            }
        }

        private void OnAdditiveContentStreamed(string scenePath)
        {
            Scene streamed = SceneManager.GetSceneByPath(scenePath);

            if (!streamed.IsValid() || !streamed.isLoaded)
            {
                return;
            }

            foreach (GameObject root in streamed.GetRootGameObjects())
            {
                foreach (Light light in root.GetComponentsInChildren<Light>(true))
                {
                    if (light.type != LightType.Directional || light.shadows == LightShadows.None)
                    {
                        continue;
                    }

                    if (light.TryGetComponent(out HDAdditionalLightData hdLight))
                    {
                        hdLight.EnableShadows(false);
                    }
                    else
                    {
                        light.shadows = LightShadows.None;
                    }
                }
            }
        }
    }
}
