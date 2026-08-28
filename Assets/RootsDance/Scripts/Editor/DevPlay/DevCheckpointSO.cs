using System.Collections.Generic;
using RootsDance.Data;
using RootsDance.Investigation;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Editor.DevPlay
{
    /// <summary>
    /// One place a developer can start the game from: where the Player stands and which world state
    /// has already happened. Editor-only data (this assembly never ships); assets live under
    /// Assets/RootsDance/Data/DevPlay/. Applied by <see cref="DevPlaySession"/>, listed by
    /// <see cref="DevPlayWindow"/>.
    /// </summary>
    [CreateAssetMenu(fileName = "Checkpoint", menuName = "RootsDance/Editor/Dev Checkpoint")]
    public class DevCheckpointSO : ScriptableObject
    {
        [TitleGroup("Where")]
        [Tooltip("Shown in the Dev Play window. Prefix with the station id so the list sorts along the route.")]
        [SerializeField, Required] private string m_label;

        [TitleGroup("Where")]
        [Tooltip("Level whose scenes are opened before Play.")]
        [SerializeField, Required] private LevelSO m_level;

        [TitleGroup("Where")]
        [Tooltip("Name of a child of _Anchors in the level (the orange spheres). Leave empty to use Position.")]
        [SerializeField] private string m_anchorName;

        [TitleGroup("Where")]
        [Tooltip("World position of the Player root when no anchor is named or the anchor is missing.")]
        [SerializeField] private Vector3 m_position;

        [TitleGroup("Where")]
        [Tooltip("Facing in degrees around Y. 0 looks down +Z, the route direction.")]
        [SerializeField] private float m_yaw;

        [TitleGroup("Where")]
        [Tooltip("Raycast down from above the target and stand on whatever is hit (terrain or geometry).")]
        [SerializeField] private bool m_snapToGround = true;

        [TitleGroup("Where")]
        [Tooltip("Metres between the found ground and the Player root (the capsule is 1.5 m tall, centred).")]
        [SerializeField, EnableIf("m_snapToGround")] private float m_groundClearance = 1f;

        [TitleGroup("World State")]
        [Tooltip("Time of day forced when this checkpoint is applied. Level Default leaves the level alone.")]
        [SerializeField] private CheckpointTimeOfDay m_timeOfDay = CheckpointTimeOfDay.LevelDefault;

        [TitleGroup("World State")]
        [Tooltip("Flags already raised when the Player takes control, applied in this order.")]
        [SerializeField, ValueDropdown("FlagChoices")] private string[] m_flags = new string[0];

        [TitleGroup("World State")]
        [Tooltip("Investigation targets already recorded in the official report.")]
        [SerializeField] private InvestigationTargetSO[] m_recordedTargets = new InvestigationTargetSO[0];

        public string Label => string.IsNullOrEmpty(m_label) ? name : m_label;
        public LevelSO Level => m_level;
        public string AnchorName => m_anchorName;
        public Vector3 Position => m_position;
        public float Yaw => m_yaw;
        public bool SnapToGround => m_snapToGround;
        public float GroundClearance => m_groundClearance;
        public CheckpointTimeOfDay TimeOfDay => m_timeOfDay;
        public IReadOnlyList<string> Flags => m_flags;
        public IReadOnlyList<InvestigationTargetSO> RecordedTargets => m_recordedTargets;

        /// <summary>Fills a freshly created asset. Only <see cref="DevCheckpointDefaults"/> calls this.</summary>
        public void Configure(
            string label, LevelSO level, string anchorName, Vector3 position, float yaw,
            CheckpointTimeOfDay timeOfDay, string[] flags, InvestigationTargetSO[] recordedTargets)
        {
            m_label = label;
            m_level = level;
            m_anchorName = anchorName;
            m_position = position;
            m_yaw = yaw;
            m_timeOfDay = timeOfDay;
            m_flags = flags ?? new string[0];
            m_recordedTargets = recordedTargets ?? new InvestigationTargetSO[0];
        }

        /// <summary>
        /// Rewrites only the time of day on an already authored asset. Only Dev Play tooling calls this
        /// (<see cref="DevCheckpointDefaults.SetAllTimeOfDayToNight"/>); the caller owns
        /// <c>EditorUtility.SetDirty</c> and saving.
        /// </summary>
        public void SetTimeOfDay(CheckpointTimeOfDay timeOfDay)
        {
            m_timeOfDay = timeOfDay;
        }

        private static IReadOnlyList<string> FlagChoices()
        {
            return WorldFlagCatalog.All;
        }
    }
}
