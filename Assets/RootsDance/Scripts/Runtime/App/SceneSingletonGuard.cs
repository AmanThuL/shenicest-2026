using System.Text;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>
    /// Keeps exactly one EventSystem and one AudioListener alive, and says where the extras came
    /// from.
    /// <para>
    /// Both are scene singletons Unity complains about once per frame forever, which buries every
    /// other line in the console. Neither is ours to own: the bootstrap holds the pair the game
    /// plays with, and a second one only ever arrives with a scene. So rather than trying to
    /// prevent it, the duplicate is switched off the moment its scene lands, and logged once with
    /// its scene and hierarchy path — the console then names the scene that brought it instead of
    /// repeating that there are two.
    /// </para>
    /// <para>
    /// The bootstrap's own pair wins because it is the one that has been alive longest: the guard
    /// keeps whichever it saw first and disables everything after. Disabled, not destroyed — the
    /// object belongs to a scene that may be a level in its own right later, and a destroyed
    /// component would not come back when it is.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class SceneSingletonGuard : MonoBehaviour
    {
        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        private static void Install()
        {
            var host = new GameObject(nameof(SceneSingletonGuard));
            host.hideFlags = HideFlags.HideInHierarchy;
            DontDestroyOnLoad(host);
            host.AddComponent<SceneSingletonGuard>();
        }

        private void OnEnable()
        {
            SceneManager.sceneLoaded += OnSceneLoaded;
            Sweep();
        }

        private void OnDisable()
        {
            SceneManager.sceneLoaded -= OnSceneLoaded;
        }

        private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
        {
            Sweep();
        }

        private void Sweep()
        {
            Keep(FindObjectsByType<EventSystem>(FindObjectsInactive.Exclude, FindObjectsSortMode.None));
            Keep(FindObjectsByType<AudioListener>(FindObjectsInactive.Exclude, FindObjectsSortMode.None));
        }

        private static void Keep<T>(T[] found) where T : Behaviour
        {
            int kept = -1;

            for (int i = 0; i < found.Length; i++)
            {
                if (!found[i].enabled)
                {
                    continue;
                }

                if (kept < 0)
                {
                    kept = i;
                    continue;
                }

                Log.Warning($"A second {typeof(T).Name} came in with scene "
                    + $"'{found[i].gameObject.scene.name}' at {PathOf(found[i].transform)}; disabling it. "
                    + $"The one kept is in '{found[kept].gameObject.scene.name}'.", found[i]);
                found[i].enabled = false;
            }
        }

        private static string PathOf(Transform transform)
        {
            var path = new StringBuilder(transform.name);

            for (Transform parent = transform.parent; parent != null; parent = parent.parent)
            {
                path.Insert(0, '/').Insert(0, parent.name);
            }

            return path.ToString();
        }
    }
}
