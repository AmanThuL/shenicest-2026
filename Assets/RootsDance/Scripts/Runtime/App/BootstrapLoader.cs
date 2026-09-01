using RootsDance.Core;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>
    /// Lets anyone press Play from a level scene: if Bootstrap is not loaded, add it additively.
    /// In a player build Bootstrap is build index 0, so this is a no-op.
    /// <para>
    /// The decision is taken a frame late on purpose. In the Editor every scene open in the
    /// Hierarchy is loaded when Play starts, but <c>AfterSceneLoad</c> fires once the <em>first</em>
    /// of them is in — the rest are still on their way. Bootstrap open as the last of four scenes
    /// answered "not loaded" here, was requested again, and arrived twice: two EventSystems, two
    /// AudioListeners, two Main Cameras drawing over each other. After a frame every open scene
    /// is in and the answer is honest.
    /// </para>
    /// </summary>
    public static class BootstrapLoader
    {
        /// <summary>Frames to give a Bootstrap that is listed but not yet loaded before giving up on it.</summary>
        private const int k_MaxWaitFrames = 10;

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        private static void EnsureBootstrapScene()
        {
            EnsureBootstrapSceneAsync();
        }

        /// <summary>
        /// The rule, kept free of scene objects so it can be tested: a Bootstrap that is already
        /// loaded, or whose <see cref="GameBootstrap"/> already exists, must not be loaded again.
        /// A Bootstrap that is listed but still loading is waited for by the caller, not decided on.
        /// </summary>
        public static bool NeedsLoad(bool bootstrapIsLoaded, bool bootstrapInstanceExists)
        {
            return !bootstrapIsLoaded && !bootstrapInstanceExists;
        }

        private static async void EnsureBootstrapSceneAsync()
        {
            Scene bootstrap = SceneManager.GetSceneByPath(ScenePaths.k_Bootstrap);

            // Listed but not loaded: it is one of the Editor's open scenes and still on its way.
            for (int frame = 0; frame < k_MaxWaitFrames && bootstrap.IsValid() && !bootstrap.isLoaded; frame++)
            {
                await Awaitable.NextFrameAsync();
                bootstrap = SceneManager.GetSceneByPath(ScenePaths.k_Bootstrap);
            }

            if (!NeedsLoad(bootstrap.isLoaded, GameBootstrap.Instance != null))
            {
                // Normal start: Bootstrap is build index 0, or the Editor had it open.
                return;
            }

            if (bootstrap.IsValid())
            {
                Log.Warning("Bootstrap is listed in the Hierarchy but never finished loading (a "
                    + "reference-only scene?); loading a fresh copy.", null);
            }

            SceneManager.LoadScene(ScenePaths.k_Bootstrap, LoadSceneMode.Additive);
        }
    }
}
