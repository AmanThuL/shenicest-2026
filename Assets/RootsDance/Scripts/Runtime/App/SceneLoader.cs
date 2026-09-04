using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Environment;
using RootsDance.Events;
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

        [Tooltip("Longest the cover waits for a level's deferred content (streamed props spawning "
            + "over frames) to finish before revealing whatever is there, in unscaled seconds.")]
        [Min(0f)]
        [SerializeField] private float m_deferredContentTimeoutSeconds = 90f;

        [Header("Streaming")]
        [Tooltip("Raised with the scene path once an additive content stream finishes loading. "
            + "Listeners (e.g. a baked-sky reveal) react without polling scene load state themselves.")]
        [SerializeField] private StringEventChannelSO m_additiveContentStreamed;

        [Tooltip("Collision meshes to cook on worker threads while each of these scenes loads, so its "
            + "activation frame creates MeshColliders against cached data instead of cooking them "
            + "itself. Scenes not listed here simply cook on activation as Unity always did.")]
        [SerializeField] private ScenePrebake[] m_scenePrebakes = Array.Empty<ScenePrebake>();

        [Serializable]
        private struct ScenePrebake
        {
            public string ScenePath;
            public CollisionPrebakeSet Set;
        }

        private BootScreenCover m_cover;

        /// <summary>Scene paths already streamed in, so a second request for the same path is a no-op.</summary>
        private readonly HashSet<string> m_streamedScenePaths = new HashSet<string>();

        /// <summary>Additive streams in flight, keyed by scene path, so a repeat request is a no-op.</summary>
        private readonly Dictionary<string, AsyncOperation> m_pendingStreams = new Dictionary<string, AsyncOperation>();

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

        /// <summary>
        /// Fire-and-forget entry point (called by the additive-stream-request channel listener).
        /// Unlike <see cref="RequestLoad"/>, this never touches the cover or unloads anything — it
        /// only brings one extra scene in behind whatever is already on screen.
        /// </summary>
        public void RequestStreamAdditiveContent(string scenePath)
        {
            StreamAdditiveContentEntryAsync(scenePath, destroyCancellationToken);
        }

        /// <summary>
        /// Fire-and-forget entry point (called by the preload-request channel listener). Same work
        /// as <see cref="RequestStreamAdditiveContent"/>: the separate channel exists so content can
        /// ask the moment it knows the scene will be needed, without a proximity trigger in the way.
        /// The earlier the ask, the more of the stream lands while nothing is looking at it.
        /// </summary>
        public void RequestPreloadAdditiveContent(string scenePath)
        {
            StreamAdditiveContentEntryAsync(scenePath, destroyCancellationToken);
        }

        /// <summary>
        /// Additively loads one scene without unloading anything else, changing the active scene, or
        /// showing the cover. For streaming distant content in behind a level that is already playable
        /// (e.g. real exterior geometry replacing a baked-sky backdrop) rather than switching levels.
        /// </summary>
        public Awaitable LoadAdditiveContentAsync(string scenePath, CancellationToken cancellationToken)
        {
            return LoadAdditiveContentInternalAsync(scenePath, cancellationToken);
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
            List<CollisionPrebakeJob> levelPrebakes = new List<CollisionPrebakeJob>();

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

                // Cook collision meshes on worker threads alongside the loads. Whatever is cooked by
                // the time a scene activates is skipped by its colliders; the rest they cook as before.
                for (int i = 0; i < paths.Count; i++)
                {
                    CollisionPrebakeJob prebake = SchedulePrebake(paths[i]);

                    if (prebake != null)
                    {
                        levelPrebakes.Add(prebake);
                    }
                }

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

                for (int i = 0; i < levelPrebakes.Count; i++)
                {
                    levelPrebakes[i].Complete();
                }

                m_isLoading = false;
                Progress = 1f;
                HideCover();
            }
        }

        /// <summary>
        /// Streams one scene in behind a playable level with nothing on screen to show for it. Every
        /// heavy part is kept off the frame: deserialization on Unity's loading thread, collision
        /// cooking on worker threads (see <see cref="m_scenePrebakes"/>), and the scene's own bulk
        /// content spawned over frames by its <see cref="IDeferredContent"/>. What is left for the
        /// activation frame is registering the scene's remaining objects — measured at ~60 ms in the
        /// Editor for Main_Environment once its vegetation was baked out, small enough to hide in a
        /// frame the player is already in. Returns without doing anything for a scene already
        /// streamed or already in flight.
        /// </summary>
        private async Awaitable LoadAdditiveContentInternalAsync(string scenePath, CancellationToken cancellationToken)
        {
            if (string.IsNullOrEmpty(scenePath))
            {
                throw new ArgumentException("Scene path is empty.", nameof(scenePath));
            }

            if (m_streamedScenePaths.Contains(scenePath) || m_pendingStreams.ContainsKey(scenePath)
                || SceneManager.GetSceneByPath(scenePath).isLoaded)
            {
                // Several triggers guard the same corridor; the first one wins, the rest are quiet.
                return;
            }

            Log.Info($"Streaming additive content: {scenePath}", this);
            AsyncOperation load = SceneManager.LoadSceneAsync(scenePath, LoadSceneMode.Additive);

            if (load == null)
            {
                throw new InvalidOperationException("Unity could not start the requested scene operation.");
            }

            // Registered before anything can yield: a second request for the same path in a later
            // frame finds this entry instead of starting a second concurrent load of the same scene.
            // Activation is held back so it can wait for the collision cook rather than race it.
            load.allowSceneActivation = false;
            m_pendingStreams.Add(scenePath, load);
            CollisionPrebakeJob prebake = SchedulePrebake(scenePath);

            try
            {
                // Unity parks an un-activatable load at 0.9 once deserialization is done.
                while (load.progress < 0.9f || (prebake != null && !prebake.IsCompleted))
                {
                    await Awaitable.NextFrameAsync();
                }

                prebake?.Complete();
                prebake = null;
                load.allowSceneActivation = true;

                // Unity scene operations cannot be cancelled — finish the load before honoring
                // cancellation so a retry can never race an unfinished one.
                while (!load.isDone)
                {
                    await Awaitable.NextFrameAsync();
                }
            }
            finally
            {
                prebake?.Complete();
                m_pendingStreams.Remove(scenePath);
            }

            m_streamedScenePaths.Add(scenePath);
            cancellationToken.ThrowIfCancellationRequested();

            // isLoaded flips a frame before the scene's first Awake/Start frame; give listeners the
            // same settle the level path gets before telling them the content is there.
            for (int i = 0; i < m_settleFrames; i++)
            {
                await Awaitable.NextFrameAsync();
            }

            if (m_additiveContentStreamed != null)
            {
                m_additiveContentStreamed.RaiseEvent(scenePath);
            }
        }

        private CollisionPrebakeJob SchedulePrebake(string scenePath)
        {
            for (int i = 0; i < m_scenePrebakes.Length; i++)
            {
                if (m_scenePrebakes[i].ScenePath == scenePath && m_scenePrebakes[i].Set != null)
                {
                    return CollisionPrebakeJob.Schedule(m_scenePrebakes[i].Set);
                }
            }

            return null;
        }

        private async void StreamAdditiveContentEntryAsync(string scenePath, CancellationToken cancellationToken)
        {
            try
            {
                await LoadAdditiveContentAsync(scenePath, cancellationToken);
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

            await WaitForDeferredContentAsync(cancellationToken);

            // The cover's own hold wins when it is longer: at game start the boot sequence has a
            // title card to finish, and cutting it off halfway is worse than a slightly long wait.
            float hold = Mathf.Max(m_minimumCoverSeconds, m_cover == null ? 0f : m_cover.HoldSeconds);

            while (Time.realtimeSinceStartup - m_coverShownAt < hold)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
            }
        }

        /// <summary>
        /// Lets a level's streamed content (see <see cref="DeferredContent"/>) finish behind the cover
        /// at its covered budget, so the reveal is a complete level rather than props popping in. Times
        /// out rather than hang on content that never completes; whatever spawned by then is shown.
        /// </summary>
        private async Awaitable WaitForDeferredContentAsync(CancellationToken cancellationToken)
        {
            if (DeferredContent.AllComplete)
            {
                return;
            }

            float deadline = Time.realtimeSinceStartup + m_deferredContentTimeoutSeconds;
            DeferredContent.SetCovered(true);

            try
            {
                while (!DeferredContent.AllComplete && Time.realtimeSinceStartup < deadline)
                {
                    Report(0, 1, DeferredContent.Progress);
                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                if (!DeferredContent.AllComplete)
                {
                    Log.Warning("Deferred content did not complete before the cover timeout; revealing anyway.", this);
                }
            }
            finally
            {
                DeferredContent.SetCovered(false);
            }

            Report(1, 1, 1f);
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
