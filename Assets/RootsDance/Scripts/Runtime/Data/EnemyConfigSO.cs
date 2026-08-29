using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>
    /// Every value that decides how the boss behaves during a chase. Tuning happens in this asset,
    /// never on the prefab or the scene instance, so the pursuit can be retuned between playtests
    /// without opening a scene — the same split <see cref="PlayerConfigSO"/> makes for the player.
    /// <para>
    /// It is a chase, not a fight: there is no health, no damage and no attack range here, because
    /// the boss is a prop that holds a distance. The fear is played by the camera.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "EnemyConfig", menuName = "RootsDance/Config/Enemy")]
    public class EnemyConfigSO : ScriptableObject
    {
        [SerializeField, TitleGroup("Pursuit")]
        [Tooltip("Metres it tries to stay behind the player. The shoulder check only reads if "
            + "there is something to see at exactly this distance — too close and it fills the "
            + "frame, too far and the player finds an empty corridor.")]
        [MinValue(1f)]
        private float m_desiredGapMeters = 9f;

        [SerializeField, TitleGroup("Pursuit")]
        [Tooltip("Speed at the desired gap, in metres per second. The player sprints at 4.4, so "
            + "just under that reads as barely keeping up rather than as a countdown.")]
        [MinValue(0f)]
        private float m_baseSpeed = 4.2f;

        [SerializeField, TitleGroup("Pursuit")]
        [Tooltip("Extra metres per second for every metre it has fallen behind the desired gap, "
            + "and less for every metre it is too close. This is the whole rubber band.")]
        [MinValue(0f)]
        private float m_catchupPerMeter = 0.35f;

        [SerializeField, TitleGroup("Pursuit")]
        [Tooltip("Hard speed cap, in metres per second. Without it a long straight lets the "
            + "catch-up term run away and the boss arrives all at once.")]
        [MinValue(0f)]
        private float m_maxSpeed = 6.5f;

        [SerializeField, TitleGroup("Pursuit")]
        [Tooltip("Degrees per second it can turn to face where it is going.")]
        [MinValue(30f)]
        private float m_turnDegreesPerSecond = 540f;

        [SerializeField, TitleGroup("Trail")]
        [Tooltip("Metres between stored breadcrumbs of the player's route. Coarser is cheaper, and "
            + "the pursuit point is interpolated, so this does not make the motion steppy.")]
        [MinValue(0.1f)]
        private float m_trailSpacing = 0.75f;

        [SerializeField, TitleGroup("Trail")]
        [Tooltip("Oldest breadcrumbs are dropped past this count.")]
        [MinValue(16)]
        private int m_maxTrailPoints = 256;

        [SerializeField, TitleGroup("Grounding")]
        [Tooltip("Layers the feet probe treats as ground. Keep in step with the level's Ground layer.")]
        private LayerMask m_groundLayers = 1 << 8;

        // The opening beat (how long the rooted form holds) is scheduled by ChaseDirector, which
        // also owns the shoulder-check timings, so it is deliberately not duplicated here.
        [SerializeField, TitleGroup("Animation")]
        [Tooltip("Playback speed of the chase cycle at the base speed. The clip is retimed with "
            + "how fast it is actually moving, so a rubber-banding boss does not moonwalk.")]
        [MinValue(0f)]
        private float m_chaseCycleSpeed = 1f;

        public float DesiredGapMeters => m_desiredGapMeters;
        public float BaseSpeed => m_baseSpeed;
        public float CatchupPerMeter => m_catchupPerMeter;
        public float MaxSpeed => m_maxSpeed;
        public float TurnDegreesPerSecond => m_turnDegreesPerSecond;
        public float TrailSpacing => m_trailSpacing;
        public int MaxTrailPoints => m_maxTrailPoints;
        public LayerMask GroundLayers => m_groundLayers;
        public float ChaseCycleSpeed => m_chaseCycleSpeed;
    }
}
