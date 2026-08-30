using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.UI;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>
    /// The only component allowed to talk to <see cref="SceneManager"/>. Lives on the GameBootstrap
    /// root in Bootstrap.unity; gameplay code raises a level event channel instead of calling this.
    /// <para>
    /// It also owns the loading screen, because it is the only thing that knows when the frame stops
    /// being showable: between the unload and the first settled frame of the new level the camera has
    /// no level content, no volume and no sky to clear to. The cover goes up before the first unload
    /// and comes down a few frames after the last scene is live, so the hitch that follows a load —
    /// shader warm-up, Awake storms, the first physics step — happens behind it rather than in front
    /// of the player. This is the one place App reaches into UI, and it is deliberate: the loader is
    /// the only code that knows when the frame is unshowable, so it is the only code that can decide
    /// when the cover goes up — nothing else can raise it, which is what keeps it strictly between
    /// scenes and never mid-scene.
    /// </para>
    /// </summary>
    public class SceneLoader : MonoBehaviour
    {
        [Header("Loading screen")]
        [Tooltip("The boot screen prefab, used as the between-scenes cover. Instantiated once, on "
            + "the first scene change, and kept across loads. Empty means no cover.")]
        [SerializeField] private BootScreenCover m_coverPrefab;

        [Tooltip("Shortest time the cover stays up, in unscaled seconds. A cover that flashes for "
            + "three frames on a fast machine reads as a glitch, not as a load.")]
        [Min(0f)]
        [SerializeField] private float m_minimumCoverSeconds = 1.25f;

        [Tooltip("Frames the cover is held after the last scene is live. The first frames of a fresh "
            + "level are the expensive ones — this is what stops them being visible.")]
        [Min(0)]
        [SerializeField] private int m_settleFrames = 4;

        private BootScreenCover m_cover;

        private bool m_isLoading;

        /// <summary>One warning per session about a missing cover, not one per scene change.</summary>
        private bool m_warnedAboutMissingCover;

        /// <summary>Unscaled time the cover went up, so the minimum hold survives a paused game.</summary>
        private float m_coverShownAt;
        private string m_currentLevelName;

        public bool IsLoading => m_isLoading;

        /// <summary>Where the current load is, 0..1. Sits at 1 while nothing is loading.</summary>
        public float Progress { get; private set; } = 1f;
        public string CurrentLevelName => string.IsNullOrEmpty(m_currentLevelName)
            ? SceneManager.GetActiveScene().name : m_currentLevelName;

        /// <summary>Runs rescue hooks behind the cover, with spawn applied before each scene's Start.</summary>
        public Awaitable ReloadForRescueAsync(LevelSO level, Action beforeLoad, Action<Scene> sceneReady,
            Action beforeReveal, CancellationToken cancellationToken)
        {
            return LoadLevelInternalAsync(level, beforeLoad, sceneReady, beforeReveal, cancellationToken);
        }

        /// <summary>One rescue-initialization traversal, including props reparented below Bootstrap's camera.</summary>
        public void CollectRescueParticipants(List<MonoBehaviour> participants)
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);
                if (!scene.isLoaded)
                {
                    continue;
                }

                GameObject[] roots = scene.GetRootGameObjects();
                for (int j = 0; j < roots.Length; j++)
                {
                    MonoBehaviour[] behaviours = roots[j].GetComponentsInChildren<MonoBehaviour>(true);
                    for (int k = 0; k < behaviours.Length; k++)
                    {
                        MonoBehaviour behaviour = behaviours[k];
                        if (behaviour != null && !participants.Contains(behaviour)
                            && (behaviour is IRescueResetParticipant || behaviour is IRescueStateRestoredParticipant))
                        {
                            participants.Add(behaviour);
                        }
                    }
                }
            }
        }

        // Fire-and-forget entry point (called by the LoadLevelRequested channel listener).
        public void RequestLoad(LevelSO level)
        {
            LoadLevelEntryAsync(level, destroyCancellationToken);
        }

        /// <summary>
        /// Takes the cover down without loading anything. GameBootstrap calls this on the paths where
        /// it decides not to load a startup level — adopting a scene the Editor already had open, or
        /// finding nothing configured — so the cover can never be left up over a playable game.
        /// </summary>
        public void DismissLoadingScreen()
        {
            if (m_isLoading)
            {
                return;
            }

            HideCover();
        }

        public Awaitable LoadLevelAsync(LevelSO level, CancellationToken cancellationToken)
        {
            return LoadLevelInternalAsync(level, null, null, null, cancellationToken);
        }

        private async Awaitable LoadLevelInternalAsync(LevelSO level, Action beforeLoad, Action<Scene> sceneReady,
            Action beforeReveal, CancellationToken cancellationToken)
        {
            if (m_isLoading)
            {
                throw new InvalidOperationException("Scene load already in progress.");
            }

            if (level == null)
            {
                throw new ArgumentNullException(nameof(level));
            }

            cancellationToken.ThrowIfCancellationRequested();
            if (level.ScenePaths == null || level.ScenePaths.Count == 0)
            {
                throw new InvalidOperationException("The level contains no scenes.");
            }

            // Unity dispatches this event after Awake/OnEnable and before Start. Exceptions are captured
            // and rethrown by the owning task, rather than escaping Unity's event dispatcher.
            Exception initializationFailure = null;
            void OnSceneLoaded(Scene scene, LoadSceneMode mode)
            {
                if (initializationFailure != null)
                {
                    return;
                }

                try
                {
                    sceneReady?.Invoke(scene);
                }
                catch (Exception exception)
                {
                    initializationFailure = exception;
                }
            }

            m_isLoading = true;

            try
            {
                EnsureCover();

                // A pure Bootstrap startup has no playable frame to preserve, so it goes straight
                // to the boot screen. Any adopted or previously loaded content scene is already in
                // front of the player and fades out before the cover replaces it.
                if (HasPlayableSceneLoaded() && m_cover != null)
                {
                    await m_cover.FadeToBlackAsync(cancellationToken);
                }

                ShowCover();

                if (m_cover != null)
                {
                    // The cover is opaque now. Removing the black overlay in the same frame reveals
                    // it, never the outgoing world, and leaves the overlay ready for the next load.
                    m_cover.HideBlackOverlay();
                }

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

                IReadOnlyList<string> paths = level.ScenePaths;

                // Every scene unload, the asset sweep, and every scene load count for the same share
                // of the bar. See LoadProgress for why an even bar beats a guessed weighting.
                int stepCount = scenesToUnload.Count + 1 + paths.Count;
                int completedSteps = 0;

                Report(completedSteps, stepCount, 0f);

                for (int i = 0; i < scenesToUnload.Count; i++)
                {
                    AsyncOperation unload = SceneManager.UnloadSceneAsync(scenesToUnload[i]);
                    await RunStepAsync(unload, completedSteps, stepCount, cancellationToken);
                    completedSteps++;
                }

                await RunStepAsync(Resources.UnloadUnusedAssets(), completedSteps, stepCount, cancellationToken);
                completedSteps++;
                beforeLoad?.Invoke();
                SceneManager.sceneLoaded += OnSceneLoaded;

                for (int i = 0; i < paths.Count; i++)
                {
                    AsyncOperation load = SceneManager.LoadSceneAsync(paths[i], LoadSceneMode.Additive);
                    await RunStepAsync(load, completedSteps, stepCount, cancellationToken);
                    if (initializationFailure != null)
                    {
                        throw initializationFailure;
                    }
                    completedSteps++;
                }

                // First part = the one holding lighting/environment settings.
                SceneManager.SetActiveScene(SceneManager.GetSceneByPath(paths[0]));
                beforeReveal?.Invoke();
                m_currentLevelName = level.name;

                await SettleAsync(cancellationToken);
            }
            finally
            {
                SceneManager.sceneLoaded -= OnSceneLoaded;
                m_isLoading = false;
                Progress = 1f;
                HideCover();
            }
        }

        /// <summary>
        /// Runs one async operation to completion, reporting its progress into the shared bar every
        /// frame. Polled rather than awaited whole (<c>Awaitable.FromAsyncOperation</c>) purely so the
        /// bar has something to say while a scene loads.
        /// </summary>
        private async Awaitable RunStepAsync(AsyncOperation operation, int stepIndex, int stepCount,
            CancellationToken cancellationToken)
        {
            if (operation == null)
            {
                throw new InvalidOperationException("Unity could not start the requested scene operation.");
            }

            while (!operation.isDone)
            {
                Report(stepIndex, stepCount, operation.progress);
                // Unity scene operations cannot be cancelled. Finish the operation before honoring
                // cancellation so a retry cannot race an unfinished load or unload.
                await Awaitable.NextFrameAsync();
            }

            cancellationToken.ThrowIfCancellationRequested();

            Report(stepIndex + 1, stepCount, 0f);
        }

        /// <summary>
        /// Holds the cover after the last scene is live: a few frames for the new level's first
        /// Awake/Start/physics step to get out of the way, then the rest of the minimum hold.
        /// </summary>
        private async Awaitable SettleAsync(CancellationToken cancellationToken)
        {
            Report(1, 1, 1f);

            for (int i = 0; i < m_settleFrames; i++)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }

            // The cover's own hold wins when it is longer: at game start the boot sequence has a
            // title card to finish, and cutting it off halfway is worse than a slightly long wait.
            float hold = Mathf.Max(m_minimumCoverSeconds, m_cover == null ? 0f : m_cover.HoldSeconds);

            while (Time.realtimeSinceStartup - m_coverShownAt < hold)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }
        }

        private void Report(int completedSteps, int stepCount, float currentStepProgress)
        {
            Progress = LoadProgress.Fraction(completedSteps, stepCount, currentStepProgress);

            if (m_cover != null)
            {
                m_cover.SetProgress(Progress);
            }
        }

        /// <summary>
        /// Brings the cover up, instantiating the boot screen the first time it is needed rather than
        /// in Awake — a session that never changes scene should never pay for it.
        /// </summary>
        private void ShowCover()
        {
            EnsureCover();

            if (m_cover == null)
            {
                return;
            }

            if (!m_cover.IsVisible)
            {
                m_coverShownAt = Time.realtimeSinceStartup;
            }

            m_cover.Show();
        }

        private void HideCover()
        {
            if (m_cover != null)
            {
                m_cover.Hide();
            }
        }

        private static bool HasPlayableSceneLoaded()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                if (scene.isLoaded && scene.path != ScenePaths.k_Bootstrap)
                {
                    return true;
                }
            }

            return false;
        }

        private void EnsureCover()
        {
            if (m_cover != null)
            {
                return;
            }

            if (m_coverPrefab == null)
            {
                if (!m_warnedAboutMissingCover)
                {
                    m_warnedAboutMissingCover = true;
                    Log.Warning("No boot screen prefab assigned on SceneLoader, so scene changes are "
                        + "uncovered. Assign one to the Cover Prefab field in Bootstrap.unity.", this);
                }

                return;
            }

            m_cover = Instantiate(m_coverPrefab);
            m_cover.name = m_coverPrefab.name;

            // The cover has to outlive the level it is covering.
            DontDestroyOnLoad(m_cover.gameObject);
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
