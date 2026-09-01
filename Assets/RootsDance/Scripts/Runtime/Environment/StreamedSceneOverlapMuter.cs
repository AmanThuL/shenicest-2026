using System.Collections.Generic;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Environment
{
    /// <summary>
    /// Mutes the parts of a streamed-in backdrop scene that this level already owns a copy of.
    /// Two things cannot coexist: a second shadow-casting directional light (HDRP allows one, and
    /// shadowless it would pour light through every interior wall), and the geometry this level
    /// duplicates at the same world position — two copies of the same building z-fight on every
    /// face. So the streamed sun goes out and the duplicated objects go inactive.
    /// <para>
    /// Lives in the scene whose copies must win. Everything muted is restored when this unloads,
    /// which is exactly the moment the streamed scene stops being a backdrop and becomes the level.
    /// </para>
    /// </summary>
    public class StreamedSceneOverlapMuter : MonoBehaviour
    {
        [Tooltip("Data/Events/AdditiveContentStreamed — raised by SceneLoader with the scene path "
            + "once a streamed scene has finished loading.")]
        [SerializeField] private StringEventChannelSO m_additiveContentStreamed;

        [Tooltip("Only react to this streamed scene (see RootsDance.App.ScenePaths).")]
        [SerializeField] private string m_awaitedScenePath;

        [Tooltip("Root-relative paths in the streamed scene of objects this level duplicates at the "
            + "same world position (e.g. _Geometry/ResearchFacility_GaiaV7/GreenHouse1_Textured). "
            + "They are deactivated while this level is loaded, so only this level's copy renders.")]
        [SerializeField] private string[] m_overlappingObjectPaths = System.Array.Empty<string>();

        private readonly List<Light> m_mutedLights = new List<Light>();
        private readonly List<GameObject> m_hiddenObjects = new List<GameObject>();

        private void OnEnable()
        {
            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.EventRaised += OnAdditiveContentStreamed;
            }

            // The echo arrives a frame or two after the streamed scene starts rendering, and a
            // heavy activation stalls exactly those frames — each one drawing both suns. sceneLoaded
            // fires the moment activation finishes, so the mute lands before the first stalled frame.
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

            for (int i = 0; i < m_hiddenObjects.Count; i++)
            {
                if (m_hiddenObjects[i] != null)
                {
                    m_hiddenObjects[i].SetActive(true);
                }
            }

            m_hiddenObjects.Clear();
        }

        private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
        {
            if (mode == LoadSceneMode.Additive && scene.path == m_awaitedScenePath)
            {
                MuteOverlap(scene);
            }
        }

        private void OnAdditiveContentStreamed(string scenePath)
        {
            if (scenePath != m_awaitedScenePath)
            {
                return;
            }

            Scene streamed = SceneManager.GetSceneByPath(scenePath);

            if (!streamed.IsValid() || !streamed.isLoaded)
            {
                return;
            }

            MuteOverlap(streamed);
        }

        private void MuteOverlap(Scene streamed)
        {
            MuteDirectionalLights(streamed);
            HideOverlappingObjects(streamed);
        }

        private void HideOverlappingObjects(Scene streamed)
        {
            GameObject[] roots = streamed.GetRootGameObjects();

            for (int i = 0; i < m_overlappingObjectPaths.Length; i++)
            {
                string path = m_overlappingObjectPaths[i];
                int slash = path.IndexOf('/');
                string rootName = slash < 0 ? path : path.Substring(0, slash);

                for (int j = 0; j < roots.Length; j++)
                {
                    if (roots[j].name != rootName)
                    {
                        continue;
                    }

                    Transform found = slash < 0
                        ? roots[j].transform
                        : roots[j].transform.Find(path.Substring(slash + 1));

                    if (found != null && found.gameObject.activeSelf)
                    {
                        found.gameObject.SetActive(false);
                        m_hiddenObjects.Add(found.gameObject);
                    }

                    break;
                }
            }
        }

        private void MuteDirectionalLights(Scene streamed)
        {
            GameObject[] roots = streamed.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                Light[] lights = roots[i].GetComponentsInChildren<Light>(true);

                for (int j = 0; j < lights.Length; j++)
                {
                    if (lights[j].type == LightType.Directional && lights[j].enabled)
                    {
                        lights[j].enabled = false;
                        m_mutedLights.Add(lights[j]);
                    }
                }
            }
        }
    }
}
