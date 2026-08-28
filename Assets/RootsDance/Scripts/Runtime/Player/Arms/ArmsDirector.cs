using System;
using System.Collections.Generic;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// The single owner of the arms <see cref="Animator"/>.
    /// <para>
    /// Everything that used to drive the rig — a helmet view, a scanner view, three debug triggers —
    /// now goes through <see cref="TryPlay"/>. That matters for one concrete reason: the old
    /// components each called <c>Animator.Play</c> and several of them parked the rig with
    /// <c>Animator.speed = 0</c>, which stops <b>every</b> layer. Testing one animation therefore
    /// froze all the others. Here the speed is never zeroed: standing still is a real looping
    /// state (the neutral pose, forearms down), and each arm has its own masked layer, so the left
    /// arm raising the scanner and the right arm holding something are independent.
    /// </para>
    /// <para>
    /// Timing is tracked here rather than read back from <see cref="AnimatorStateInfo"/>: the same
    /// clock drives the hand attach/detach moments, and it stays meaningful during a cross-fade,
    /// when the Animator is reporting two states at once.
    /// </para>
    /// Layers are fixed by <see cref="ArmsScope"/>: 0 base (both arms + camera + root), 1 left-arm
    /// mask, 2 right-arm mask. The controller and the two masks are generated from
    /// <see cref="m_actions"/> by <c>RootsDance &gt; Build Arms Controller</c>.
    /// </summary>
    [RequireComponent(typeof(Animator))]
    [DisallowMultipleComponent]
    public class ArmsDirector : MonoBehaviour, IArmsDirector
    {
        private const int k_LayerCount = 3;

        /// <summary>What one layer is doing this frame.</summary>
        private struct Playback
        {
            public ArmsActionSO m_action;
            public float m_elapsed;
            public float m_duration;
            public int m_nextEvent;
            public bool m_isRunning;
        }

        [Header("Data")]
        [Tooltip("Every action the rig can perform. The single place an animation is registered.")]
        [SerializeField] private ArmsActionSetSO m_actions;

        [Header("Hands")]
        [Tooltip("Socket riding hand.L. Optional — hand events still fire without it.")]
        [SerializeField] private HandSocket m_leftSocket;

        [Tooltip("Socket riding hand.R. Optional — hand events still fire without it.")]
        [SerializeField] private HandSocket m_rightSocket;

        [Header("Height")]
        [Tooltip("Moves the rig anchor between the standing and ground baselines. Optional.")]
        [SerializeField] private ArmsHeightRig m_heightRig;

        [Header("Debug")]
        [Tooltip("Logs every accepted request, refusal and hand event.")]
        [SerializeField] private bool m_verbose;

        private Animator m_animator;
        private readonly Playback[] m_playback = new Playback[k_LayerCount];
        private readonly float[] m_targetWeight = new float[k_LayerCount];
        private readonly float[] m_weightSpeed = new float[k_LayerCount];
        private readonly int[] m_speedParam = new int[k_LayerCount];
        private ArmsPose m_leftPose;
        private ArmsPose m_rightPose;

        public ArmsPose LeftPose => m_leftPose;

        public ArmsPose RightPose => m_rightPose;

        public event Action<string> ActionFinished;

        public event Action<HandSide, HandEventKind> HandEventRaised;

        /// <summary>Looks up an action so an adapter can read its tuned duration.</summary>
        public ArmsActionSO FindAction(string actionId)
        {
            return m_actions == null ? null : m_actions.Find(actionId);
        }

        public bool IsBusy(ArmsScope scope)
        {
            int layer = (int)scope;
            return m_playback[layer].m_isRunning && !m_playback[layer].m_action.Loop;
        }

        private void Awake()
        {
            m_animator = GetComponent<Animator>();

            for (int i = 0; i < k_LayerCount; i++)
            {
                m_speedParam[i] = Animator.StringToHash(SpeedParameterName(i));
            }

            if (m_actions == null)
            {
                Log.Error("ArmsDirector has no action set; the arms will not animate.", this);
                return;
            }

            m_actions.RebuildLookup();
        }

        private void Start()
        {
            // Never Animator.speed = 0. Standing still is the neutral action looping on the base
            // layer, so any other layer can keep running underneath it.
            m_animator.speed = 1f;

            for (int layer = 1; layer < k_LayerCount; layer++)
            {
                m_animator.SetLayerWeight(layer, 0f);
                m_targetWeight[layer] = 0f;
            }

            ReturnToNeutral();
        }

        /// <inheritdoc />
        public bool TryPlay(string actionId)
        {
            if (m_actions == null)
            {
                return false;
            }

            ArmsActionSO action = m_actions.Find(actionId);

            if (action == null)
            {
                Log.Warning($"ArmsDirector: no action with id '{actionId}'.", this);
                return false;
            }

            if (IsBusy(action.Scope))
            {
                Log.Warning($"ArmsDirector: '{actionId}' refused — "
                    + $"{action.Scope} is still playing '{m_playback[action.Layer].m_action.Id}'.", this);
                return false;
            }

            if (!ArmsPoseGate.Allows(action.Scope, action.RequiredPose,
                action.RequiredPoseEnforced, m_leftPose, m_rightPose))
            {
                Log.Warning($"ArmsDirector: '{actionId}' refused — it starts from "
                    + $"{action.RequiredPose}, the arms are in "
                    + $"(L {m_leftPose} / R {m_rightPose}).", this);
                return false;
            }

            Begin(action);
            return true;
        }

        private void Begin(ArmsActionSO action)
        {
            int layer = action.Layer;

            m_animator.SetFloat(m_speedParam[layer], action.Speed);
            m_animator.CrossFadeInFixedTime(
                Animator.StringToHash(action.StateName), action.FadeIn, layer, 0f);

            if (layer > 0)
            {
                SetLayerTarget(layer, 1f, action.FadeIn);
            }

            m_playback[layer] = new Playback
            {
                m_action = action,
                m_elapsed = 0f,
                m_duration = action.Duration,
                m_nextEvent = 0,
                m_isRunning = true,
            };

            if (m_heightRig != null)
            {
                m_heightRig.Begin(action.HeightBase, Mathf.Max(action.Duration, 0.001f));
            }

            if (m_verbose)
            {
                Log.Info($"ArmsDirector: '{action.Id}' started on layer {layer} "
                    + $"({action.Scope}, {action.Duration:F2}s).", this);
            }
        }

        private void Update()
        {
            float dt = Time.deltaTime;

            for (int layer = 0; layer < k_LayerCount; layer++)
            {
                StepWeight(layer, dt);
                StepPlayback(layer, dt);
            }
        }

        private void StepPlayback(int layer, float dt)
        {
            if (!m_playback[layer].m_isRunning)
            {
                return;
            }

            ArmsActionSO action = m_playback[layer].m_action;

            if (action.Loop)
            {
                return;
            }

            m_playback[layer].m_elapsed += dt;
            float duration = Mathf.Max(m_playback[layer].m_duration, 0.0001f);
            float t = Mathf.Clamp01(m_playback[layer].m_elapsed / duration);

            FireHandEvents(layer, t);

            if (m_playback[layer].m_elapsed < duration)
            {
                return;
            }

            Finish(layer, action);
        }

        /// <summary>
        /// Fires every authored moment the clock has passed this frame, in order. Each fires once
        /// per playthrough — a long frame that jumps over two of them still fires both.
        /// </summary>
        private void FireHandEvents(int layer, float normalizedTime)
        {
            ArmsActionSO action = m_playback[layer].m_action;
            IReadOnlyList<ArmsActionSO.HandEvent> events = action.HandEvents;

            if (events == null)
            {
                return;
            }

            while (m_playback[layer].m_nextEvent < events.Count
                && events[m_playback[layer].m_nextEvent].m_normalizedTime <= normalizedTime)
            {
                ArmsActionSO.HandEvent e = events[m_playback[layer].m_nextEvent];
                m_playback[layer].m_nextEvent++;
                Raise(e.m_hand, e.m_kind, action.Id);
            }
        }

        private void Raise(HandSide hand, HandEventKind kind, string actionId)
        {
            HandSocket socket = hand == HandSide.Left ? m_leftSocket : m_rightSocket;

            if (socket != null)
            {
                if (kind == HandEventKind.Attach)
                {
                    socket.AttachPending();
                }
                else
                {
                    socket.Detach();
                }
            }

            if (m_verbose)
            {
                Log.Info($"ArmsDirector: '{actionId}' {kind} on the {hand} hand.", this);
            }

            HandEventRaised?.Invoke(hand, kind);
        }

        private void Finish(int layer, ArmsActionSO action)
        {
            m_playback[layer].m_isRunning = false;
            SetPose(action.Scope, action.ResultPose);

            ArmsActionSO chain = m_actions.Find(action.ChainToId);

            // The chained action's seam is authored, so it bypasses the pose gate the way a
            // requested action cannot.
            if (chain != null && !IsBusy(chain.Scope))
            {
                Begin(chain);
            }

            if (!action.HoldAfterFinish)
            {
                if (layer > 0)
                {
                    // Only fade the arm back to the base layer when nothing took it over.
                    if (chain == null || chain.Layer != layer)
                    {
                        SetLayerTarget(layer, 0f, action.FadeOut);
                    }
                }
                else if (chain == null || chain.Layer != 0)
                {
                    ReturnToNeutral();
                }
            }

            if (m_verbose)
            {
                Log.Info($"ArmsDirector: '{action.Id}' finished; "
                    + $"pose now L {m_leftPose} / R {m_rightPose}.", this);
            }

            ActionFinished?.Invoke(action.Id);
        }

        /// <summary>Base layer back to the looping neutral pose, forearms down.</summary>
        private void ReturnToNeutral()
        {
            ArmsActionSO neutral = m_actions == null ? null : m_actions.Neutral;

            if (neutral == null)
            {
                Log.Warning("ArmsDirector has no neutral action; the base layer will hold whatever "
                    + "frame it stopped on.", this);
                return;
            }

            Begin(neutral);
            SetPose(neutral.Scope, neutral.ResultPose);
        }

        private void SetPose(ArmsScope scope, ArmsPose pose)
        {
            ArmsPoseGate.ApplyResult(scope, pose, ref m_leftPose, ref m_rightPose);
        }

        private void SetLayerTarget(int layer, float target, float seconds)
        {
            m_targetWeight[layer] = target;
            m_weightSpeed[layer] = seconds <= 0f
                ? float.MaxValue
                : 1f / seconds;
        }

        private void StepWeight(int layer, float dt)
        {
            if (layer == 0)
            {
                return;
            }

            float current = m_animator.GetLayerWeight(layer);

            if (Mathf.Approximately(current, m_targetWeight[layer]))
            {
                return;
            }

            float step = m_weightSpeed[layer] * dt;
            m_animator.SetLayerWeight(layer, Mathf.MoveTowards(current, m_targetWeight[layer], step));
        }

        /// <summary>Speed multiplier parameter the generated controller binds to each layer.</summary>
        public static string SpeedParameterName(int layer)
        {
            return "Speed" + layer;
        }
    }
}
