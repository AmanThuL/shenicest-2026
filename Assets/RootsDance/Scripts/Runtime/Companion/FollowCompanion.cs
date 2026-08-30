using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Companion
{
    /// <summary>
    /// The flower sprite from the moment she turns up behind the player on the chapter house
    /// bridge onwards: she appears on one flag, starts following on the next, and stays with the
    /// player for the rest of the chapter.
    /// <para>
    /// Two flags, not one, because the beat has two halves. <see cref="WorldFlags.k_FlowerSpriteAppeared"/>
    /// goes up as the player walks into the meeting volume — she snaps into place behind them and
    /// the camera checks over its shoulder, so the first line ("……什么东西？") is spoken at
    /// something the player has actually seen. <see cref="WorldFlags.k_MetFlowerSprite"/> goes up
    /// when that conversation finishes, and only then does she start walking after them.
    /// </para>
    /// <para>
    /// One of these sits in every gameplay scene she is meant to be in, hidden until her flags are
    /// up — the same shape <see cref="Chase.ChaseDirector"/> uses, and for the same reason: a scene
    /// that loads after a flag was raised never hears the event, so a scene entered mid-chapter has
    /// to read the world state once instead. That is what carries her from the chapter house into
    /// the greenhouse without anything having to survive the level change.
    /// </para>
    /// <para>
    /// Deliberately not a NavMesh agent: she trails a player who is walking a corridor, and a bake
    /// on every level change would buy nothing. The arithmetic is in
    /// <see cref="CompanionFollowStep"/>, which is where the behaviour is tested.
    /// </para>
    /// </summary>
    public class FollowCompanion : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("She becomes visible, behind the player, when this goes up.")]
        [SerializeField] private string m_appearOnFlag = WorldFlags.k_FlowerSpriteAppeared;

        [Tooltip("She starts following when this goes up. Leave empty to follow from the moment "
            + "she appears.")]
        [SerializeField] private string m_followOnFlag = WorldFlags.k_MetFlowerSprite;

        [Header("Appearing")]
        [Tooltip("Metres behind the player she arrives at. Far enough back that the look-behind "
            + "frames her instead of filling the lens with a petal.")]
        [Min(0.5f)]
        [SerializeField] private float m_appearStandoff = 2.6f;

        [Header("Following")]
        [Tooltip("Metres she holds behind the player. Inside this she stands still, which is what "
            + "keeps her out of the player's back while they read something.")]
        [Min(0.5f)]
        [SerializeField] private float m_followDistance = 2.2f;

        [Tooltip("Metres per second. The player walks at 2.4 and sprints at 4.4; a little over "
            + "walking pace lets her close a gap without ever outrunning them.")]
        [Min(0f)]
        [SerializeField] private float m_moveSpeed = 3.1f;

        [Tooltip("Past this many metres she stops walking and simply reappears behind the player. "
            + "A closed door or a level change is not something she can walk out of. 0 turns the "
            + "cut off and she will trail however far behind she has fallen.")]
        [Min(0f)]
        [SerializeField] private float m_cutDistance = 18f;

        [Tooltip("Degrees per second she turns to face where she is going.")]
        [Min(30f)]
        [SerializeField] private float m_turnDegreesPerSecond = 480f;

        [Header("Animation")]
        [Tooltip("Float parameter on her animator, set to how fast she is actually moving so the "
            + "walk cycle does not play while she stands still. Empty leaves the animator alone.")]
        [SerializeField] private string m_speedParameter = "Speed";

        private Transform m_player;
        private Animator m_animator;
        private Renderer[] m_renderers;
        private int m_speedParameterId;
        private float m_playerGroundOffset;
        private bool m_hasAppeared;
        private bool m_isFollowing;
        private bool m_stateChecked;

        /// <summary>True once she is standing in the world rather than waiting to be needed.</summary>
        public bool HasAppeared => m_hasAppeared;

        /// <summary>True once the meeting is over and she walks after the player.</summary>
        public bool IsFollowing => m_isFollowing;

        private void Awake()
        {
            m_animator = GetComponentInChildren<Animator>();
            m_renderers = GetComponentsInChildren<Renderer>(includeInactive: true);
            m_speedParameterId = string.IsNullOrEmpty(m_speedParameter)
                ? 0
                : Animator.StringToHash(m_speedParameter);

            SetVisible(false);
        }

        private void Start()
        {
            // Found once rather than serialized: she is dressed into a level scene and the player
            // lives in another one, which a serialized reference cannot cross. Guideline 04's rule
            // about Find* is about per-frame use, not initialisation.
            PlayerTriggerProbe probe = FindFirstObjectByType<PlayerTriggerProbe>();

            if (probe == null)
            {
                Log.Warning("FollowCompanion found no player; she will stay where she was placed.",
                    this);
                return;
            }

            m_player = probe.transform;
            m_playerGroundOffset = transform.position.y - m_player.position.y;
        }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }
        }

        private void Update()
        {
            CheckWorldStateOnce();

            if (!m_hasAppeared || m_player == null)
            {
                return;
            }

            float moved = m_isFollowing ? Follow() : 0f;
            FacePlayer();

            if (m_animator != null && m_speedParameterId != 0)
            {
                m_animator.SetFloat(m_speedParameterId, moved / Mathf.Max(Time.deltaTime, 0.0001f));
            }
        }

        /// <summary>
        /// Puts her behind the player and shows her. Public so a cue sequence can play the beat
        /// directly in a scene that is not driven by the flags — the dev checkpoints do this.
        /// </summary>
        public void Appear()
        {
            m_hasAppeared = true;

            if (m_player != null)
            {
                Vector3 position = CompanionFollowStep.AppearPosition(
                    m_player.position, m_player.forward, m_appearStandoff);
                position.y += m_playerGroundOffset;
                transform.position = position;
                FaceInstantly();
            }

            SetVisible(true);
        }

        /// <summary>Starts the following. Ignored until she has appeared.</summary>
        public void StartFollowing()
        {
            if (!m_hasAppeared)
            {
                Appear();
            }

            m_isFollowing = true;
        }

        /// <summary>
        /// Reads the world once the bootstrap answers, so a scene loaded after her flags went up
        /// still has her in it. Runs exactly once; the flags themselves only ever fire an event
        /// in the scene that was already open.
        /// </summary>
        private void CheckWorldStateOnce()
        {
            if (m_stateChecked)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_stateChecked = true;

            if (!string.IsNullOrEmpty(m_appearOnFlag) && state.HasFlag(m_appearOnFlag))
            {
                Appear();
            }

            if (!string.IsNullOrEmpty(m_followOnFlag) && state.HasFlag(m_followOnFlag))
            {
                StartFollowing();
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (!string.IsNullOrEmpty(m_appearOnFlag) && flagId == m_appearOnFlag)
            {
                Appear();

                if (string.IsNullOrEmpty(m_followOnFlag))
                {
                    m_isFollowing = true;
                }
            }

            if (!string.IsNullOrEmpty(m_followOnFlag) && flagId == m_followOnFlag)
            {
                StartFollowing();
            }
        }

        /// <summary>Walks one step towards the player and answers how far that was.</summary>
        private float Follow()
        {
            if (CompanionFollowStep.ShouldCut(m_player.position, transform.position, m_cutDistance))
            {
                Appear();
                return 0f;
            }

            Vector3 target = CompanionFollowStep.DesiredPosition(
                m_player.position, transform.position, m_followDistance);

            // Both scenes author her root at floor level and the player root at eye clearance.
            // Preserve that authored relationship as the player moves between floor heights.
            target.y = m_player.position.y + m_playerGroundOffset;

            Vector3 before = transform.position;
            transform.position = Vector3.MoveTowards(before, target, m_moveSpeed * Time.deltaTime);

            return Vector3.Distance(before, transform.position);
        }

        private void FacePlayer()
        {
            Quaternion facing = FacingRotation();

            if (facing == transform.rotation)
            {
                return;
            }

            transform.rotation = Quaternion.RotateTowards(
                transform.rotation, facing, m_turnDegreesPerSecond * Time.deltaTime);
        }

        private void FaceInstantly()
        {
            transform.rotation = FacingRotation();
        }

        private Quaternion FacingRotation()
        {
            Vector3 toPlayer = m_player.position - transform.position;
            toPlayer.y = 0f;

            return toPlayer.sqrMagnitude > 0.0001f
                ? Quaternion.LookRotation(toPlayer)
                : transform.rotation;
        }

        private void SetVisible(bool isVisible)
        {
            if (m_renderers == null)
            {
                return;
            }

            for (int i = 0; i < m_renderers.Length; i++)
            {
                if (m_renderers[i] != null)
                {
                    m_renderers[i].enabled = isVisible;
                }
            }
        }
    }
}
