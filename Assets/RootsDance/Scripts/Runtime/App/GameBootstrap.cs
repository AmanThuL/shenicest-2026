using System.Collections.Generic;
using DG.Tweening;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    /// <summary>
    /// The single persistent root. Owns the world state and the command queue, and drains the queue
    /// once per frame in LateUpdate — the one place where the world is allowed to change, so that
    /// trigger callbacks (physics step) and input (Update) can never interleave unpredictably.
    /// </summary>
    public class GameBootstrap : PersistentSingleton<GameBootstrap>
    {
        [Header("Services")]
        [SerializeField] private SceneLoader m_sceneLoader;
        [SerializeField] private CheckpointRescueService m_rescueService;

        [Header("Listens to")]
        [SerializeField] private LevelEventChannelSO m_loadLevelRequested;

        [Tooltip("Requests an additive content stream (e.g. exterior geometry revealed through "
            + "windows) without unloading or covering the current level. Payload is a scene path.")]
        [SerializeField] private StringEventChannelSO m_streamSceneRequested;

        [Header("Broadcasts on")]
        [Tooltip("Every world flag, the first time it is raised. Content scenes listen here instead "
            + "of reaching into the world state, so load order stops mattering.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Every accepted official-report entry, with its section count for the UI.")]
        [SerializeField] private ReportUpdateEventChannelSO m_reportUpdated;

        [Tooltip("The new time of day, every time it actually changes. Lighting and the flashlight "
            + "listen here; unlike a flag this value is not monotonic and can change back.")]
        [SerializeField] private TimeOfDayEventChannelSO m_timeOfDayChanged;

        [Header("Startup")]
        [Tooltip("Loaded when Play starts from Bootstrap with no other scene open. Leave empty while "
            + "there is no main menu; then always press Play from a level scene.")]
        [SerializeField] private LevelSO m_startupLevel;

        private WorldState m_worldState;
        private CommandQueue m_commands;
        private InteractionLock m_interactionLock;

        /// <summary>Read-only view of the session's ground truth. The mutable object stays private.</summary>
        public IWorldStateReader WorldState => m_worldState;

        /// <summary>The only sanctioned way to change the world.</summary>
        public CommandQueue Commands => m_commands;

        /// <summary>
        /// The one gate for exclusive player interactions. Reach it through
        /// <see cref="WorldAccess"/> from content code; the bootstrap force-releases it whenever
        /// the player object is about to be rebuilt.
        /// </summary>
        public InteractionLock InteractionLock => m_interactionLock;
        public ICheckpointRescueService RescueService => m_rescueService;

        /// <summary>Called only after outgoing scenes unload and before fresh gameplay initializes.</summary>
        public void RestoreCheckpointSnapshot(IReadOnlyList<string> flags, IReadOnlyList<ReportEntry> report,
            bool hasTimeOfDay, TimeOfDay timeOfDay)
        {
            // The outgoing player and its half-finished interaction are gone; a lock still held by
            // a destroyed owner would wedge every interaction in the restored session shut.
            m_interactionLock.ForceRelease();
            m_worldState.RestoreSnapshot(flags, report, hasTimeOfDay, timeOfDay);
        }

        protected override void Awake()
        {
            base.Awake();

            // A duplicate destroys itself in base.Awake; do not build services for it.
            if (Instance != this)
            {
                return;
            }

            // Replaces DOTween's Utility-Panel-generated Resources/DOTweenSettings.asset (forbidden
            // by project rule: no Resources/ folder) with the same defaults set from code.
            DOTween.Init(recycleAllByDefault: false, useSafeMode: true, logBehaviour: LogBehaviour.ErrorsOnly);

            m_worldState = new WorldState();
            m_commands = new CommandQueue();
            m_interactionLock = new InteractionLock();

            // Bridge the ground truth onto channel assets. Assets always exist, so a content-scene
            // component can subscribe in OnEnable without knowing whether the bootstrap loaded yet.
            m_worldState.FlagRaised += OnFlagRaised;
            m_worldState.ReportEntryAdded += OnReportEntryAdded;
            m_worldState.TimeOfDayChanged += OnTimeOfDayChanged;
        }

        private void OnEnable()
        {
            if (m_loadLevelRequested != null)
            {
                m_loadLevelRequested.EventRaised += OnLoadLevelRequested;
            }

            if (m_streamSceneRequested != null)
            {
                m_streamSceneRequested.EventRaised += OnStreamSceneRequested;
            }
        }

        private void Start()
        {
            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                Scene scene = SceneManager.GetSceneAt(i);

                // isLoaded excludes scenes Alt/Option-dragged into the Hierarchy for reference only.
                if (scene.isLoaded && scene.path != ScenePaths.k_Bootstrap)
                {
                    // A level is already open in the Editor: adopt it, keep its active scene.
                    DismissLoadingScreen();
                    return;
                }
            }

            if (m_startupLevel == null)
            {
                Log.Warning("Bootstrap started alone and no startup level is assigned. "
                    + "Press Play from a level scene instead.", this);
                DismissLoadingScreen();
                return;
            }

            if (m_loadLevelRequested == null)
            {
                Log.Error("No LoadLevelRequested channel assigned on GameBootstrap.", this);
                DismissLoadingScreen();
                return;
            }

            m_loadLevelRequested.RaiseEvent(m_startupLevel);
        }

        /// <summary>
        /// Every path out of <see cref="Start"/> that does not load a level has to say so, or a cover
        /// raised by an earlier request would be left up over a game that is already playable.
        /// </summary>
        private void DismissLoadingScreen()
        {
            if (m_sceneLoader != null)
            {
                m_sceneLoader.DismissLoadingScreen();
            }
        }

        private void LateUpdate()
        {
            m_commands.Drain(m_worldState);
        }

        private void OnDisable()
        {
            if (m_loadLevelRequested != null)
            {
                m_loadLevelRequested.EventRaised -= OnLoadLevelRequested;
            }

            if (m_streamSceneRequested != null)
            {
                m_streamSceneRequested.EventRaised -= OnStreamSceneRequested;
            }
        }

        private void OnDestroy()
        {
            if (m_worldState != null)
            {
                m_worldState.FlagRaised -= OnFlagRaised;
                m_worldState.ReportEntryAdded -= OnReportEntryAdded;
                m_worldState.TimeOfDayChanged -= OnTimeOfDayChanged;
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.RaiseEvent(flagId);
            }
        }

        private void OnReportEntryAdded(ReportEntry entry)
        {
            if (m_reportUpdated == null)
            {
                return;
            }

            // The count is resolved here so presentation code never reads the world state.
            m_reportUpdated.RaiseEvent(
                new ReportUpdate(entry, m_worldState.CountReportEntries(entry.Category)));
        }

        private void OnTimeOfDayChanged(TimeOfDay phase)
        {
            if (m_timeOfDayChanged != null)
            {
                m_timeOfDayChanged.RaiseEvent(phase);
            }
        }

        private void OnLoadLevelRequested(LevelSO level)
        {
            if (m_rescueService != null && m_rescueService.IsBusy)
            {
                return;
            }

            if (m_sceneLoader == null)
            {
                Log.Error("No SceneLoader assigned on GameBootstrap.", this);
                return;
            }

            // Whatever interaction raised this request (the keypad's transition, a portal) is over:
            // its scene is about to unload, and the fresh level must start with an open gate.
            m_interactionLock.ForceRelease();
            m_sceneLoader.RequestLoad(level);
        }

        private void OnStreamSceneRequested(string scenePath)
        {
            if (m_sceneLoader == null)
            {
                Log.Error("No SceneLoader assigned on GameBootstrap.", this);
                return;
            }

            m_sceneLoader.RequestStreamAdditiveContent(scenePath);
        }
    }
}
