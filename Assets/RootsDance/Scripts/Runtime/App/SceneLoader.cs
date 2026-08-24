using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>
    /// The only component allowed to talk to <see cref="SceneManager"/>. Lives on the GameBootstrap
    /// root in Bootstrap.unity; gameplay code raises a level event channel instead of calling this.
    /// </summary>
    public class SceneLoader : MonoBehaviour
    {
        private bool m_isLoading;

        public bool IsLoading => m_isLoading;

        // Fire-and-forget entry point (called by the LoadLevelRequested channel listener).
        public void RequestLoad(LevelSO level)
        {
            LoadLevelEntryAsync(level, destroyCancellationToken);
        }

        public async Awaitable LoadLevelAsync(LevelSO level, CancellationToken cancellationToken)
        {
            if (m_isLoading)
            {
                Log.Warning("Scene load already in progress; request ignored.", this);
                return;
            }

            if (level == null)
            {
                Log.Error("SceneLoader received a null level.", this);
                return;
            }

            m_isLoading = true;

            try
            {
                // Unload every loaded scene except Bootstrap — including a level adopted from the Editor.
                List<Scene> scenesToUnload = new List<Scene>();

                for (int i = 0; i < SceneManager.sceneCount; i++)
                {
                    Scene scene = SceneManager.GetSceneAt(i);

                    if (scene.isLoaded && scene.path != ScenePaths.k_Bootstrap)
                    {
                        scenesToUnload.Add(scene);
                    }
                }

                for (int i = 0; i < scenesToUnload.Count; i++)
                {
                    AsyncOperation unload = SceneManager.UnloadSceneAsync(scenesToUnload[i]);
                    await Awaitable.FromAsyncOperation(unload, cancellationToken);
                }

                await Awaitable.FromAsyncOperation(Resources.UnloadUnusedAssets(), cancellationToken);

                IReadOnlyList<string> paths = level.ScenePaths;

                for (int i = 0; i < paths.Count; i++)
                {
                    AsyncOperation load = SceneManager.LoadSceneAsync(paths[i], LoadSceneMode.Additive);
                    await Awaitable.FromAsyncOperation(load, cancellationToken);
                }

                // First part = the one holding lighting/environment settings.
                SceneManager.SetActiveScene(SceneManager.GetSceneByPath(paths[0]));
            }
            finally
            {
                m_isLoading = false;
            }
        }

        private async void LoadLevelEntryAsync(LevelSO level, CancellationToken cancellationToken)
        {
            try
            {
                await LoadLevelAsync(level, cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Loader destroyed (Play mode exit): nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }
    }
}
