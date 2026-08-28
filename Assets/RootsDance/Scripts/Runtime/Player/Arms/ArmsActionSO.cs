using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// One arms animation, and everything about it that is worth tuning, in one asset.
    /// <para>
    /// This is the tuning surface: adding an animation to the game is authoring a clip, exporting
    /// it, and filling in one of these — not writing a component. Nothing here is duplicated in a
    /// controller graph, because <see cref="ArmsDirector"/> cross-fades states directly and the
    /// controller is regenerated from <see cref="ArmsActionSetSO"/> by
    /// <c>RootsDance > Build Arms Controller</c>.
    /// </para>
    /// The pose fields are the arms contract written down where code can enforce it: an action
    /// whose <see cref="RequiredPose"/> does not match the arm's current pose is refused rather
    /// than played into a broken seam.
    /// </summary>
    [CreateAssetMenu(fileName = "ArmsAction", menuName = "RootsDance/Arms/Action")]
    public class ArmsActionSO : ScriptableObject
    {
        /// <summary>One attach/detach moment inside the clip, expressed as a fraction of it.</summary>
        [Serializable]
        public struct HandEvent
        {
            [Tooltip("When in the clip this fires, 0 = first frame, 1 = last. Authored frame f of "
                + "an n-frame clip is (f - 1) / (n - 1).")]
            [Range(0f, 1f)]
            public float m_normalizedTime;

            [Tooltip("Which hand socket.")]
            public HandSide m_hand;

            [Tooltip("Attach takes the pending item into the hand; Detach hands it to physics.")]
            public HandEventKind m_kind;
        }

        [Header("Basic info")]
        [Tooltip("What gameplay asks for. Must be unique inside the set.")]
        [SerializeField] private string m_id;

        [Tooltip("State name in the generated controller. Blank = derived from the id.")]
        [SerializeField] private string m_stateName;

        [Tooltip("The imported clip. The controller builder puts this on the state.")]
        [SerializeField] private AnimationClip m_clip;

        [Tooltip("Which arm — and therefore which Animator layer — this action owns.")]
        [SerializeField] private ArmsScope m_scope = ArmsScope.Both;

        [Tooltip("Looping actions never finish on their own: Neutral, Hold, Crawl.")]
        [SerializeField] private bool m_loop;

        [Header("State machine")]
        [Tooltip("Off for actions with no legal entry pose yet (the crawl cycle has no authored "
            + "way in). Leave on for everything the contract gives a start pose.")]
        [SerializeField] private bool m_requiredPoseEnforced = true;

        [Tooltip("The pose this action's first frame assumes. Requests from any other pose are "
            + "refused with a warning instead of playing a broken seam.")]
        [SerializeField] private ArmsPose m_requiredPose = ArmsPose.HangLow;

        [Tooltip("The pose the arms are left in. Drives the gate for whatever runs next.")]
        [SerializeField] private ArmsPose m_resultPose = ArmsPose.HangLow;

        [Tooltip("Played automatically when this one finishes, gate bypassed — the seam is "
            + "authored, not requested. This is how GrabGround hands the right arm to Hold.")]
        [SerializeField] private string m_chainToId;

        [Tooltip("Freeze on the last frame instead of returning to neutral. On for actions whose "
            + "end pose is a held pose the player stays in (ScannerRaise).")]
        [SerializeField] private bool m_holdAfterFinish;

        [Header("Height")]
        [Tooltip("Which body height this action is authored against. See ArmsHeightRig.")]
        [SerializeField] private ArmsHeightBase m_heightBase = ArmsHeightBase.Standing;

        [Header("Hands")]
        [Tooltip("When the hands take hold of and let go of things. Tune the times here rather "
            + "than re-authoring Animation Events, which do not survive a re-import.")]
        [SerializeField] private List<HandEvent> m_handEvents = new List<HandEvent>();

        [Header("Tuning")]
        [Tooltip("1 is the authored speed.")]
        [Range(0.1f, 2f)]
        [SerializeField] private float m_speed = 1f;

        [Tooltip("Seconds to cross-fade in.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_fadeIn = 0.08f;

        [Tooltip("Seconds for a masked layer to fade back out when this finishes.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_fadeOut = 0.12f;

        [Tooltip("Debug key that fires this action through ArmsDebugConsole. None = not bound.")]
        [SerializeField] private Key m_debugKey = Key.None;

        public string Id => m_id;

        /// <summary>State name in the controller; falls back to the id when left blank.</summary>
        public string StateName => string.IsNullOrEmpty(m_stateName) ? m_id : m_stateName;

        public AnimationClip Clip => m_clip;
        public ArmsScope Scope => m_scope;
        public bool Loop => m_loop;
        public bool RequiredPoseEnforced => m_requiredPoseEnforced;
        public ArmsPose RequiredPose => m_requiredPose;
        public ArmsPose ResultPose => m_resultPose;
        public string ChainToId => m_chainToId;
        public bool HoldAfterFinish => m_holdAfterFinish;
        public ArmsHeightBase HeightBase => m_heightBase;
        public IReadOnlyList<HandEvent> HandEvents => m_handEvents;
        public float Speed => m_speed;
        public float FadeIn => m_fadeIn;
        public float FadeOut => m_fadeOut;
        public Key DebugKey => m_debugKey;

        /// <summary>The Animator layer this action's scope maps to.</summary>
        public int Layer => (int)m_scope;

        /// <summary>Seconds this action runs for at its tuned speed. 0 for a looping action.</summary>
        public float Duration
        {
            get
            {
                if (m_loop || m_clip == null)
                {
                    return 0f;
                }

                return m_clip.length / Mathf.Max(m_speed, 0.01f);
            }
        }
    }
}
