using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>
    /// Lets anyone press Play from a level scene: if Bootstrap is not loaded, add it additively.
    /// In a player build Bootstrap is build index 0, so this is a no-op.
    /// </summary>
    public static class BootstrapLoader
    {
        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        private static void EnsureBootstrapScene()
        {
            if (SceneManager.GetSceneByPath(ScenePaths.k_Bootstrap).isLoaded)
            {
                // Normal start: Bootstrap is build index 0.
                return;
            }

            SceneManager.LoadScene(ScenePaths.k_Bootstrap, LoadSceneMode.Additive);
        }
    }
}
