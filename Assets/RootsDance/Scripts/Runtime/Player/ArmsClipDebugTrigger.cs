using System;
using System.Collections.Generic;
using RootsDance.Core;
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player
{
    /// <summary>
    /// TEST SCAFFOLDING — fires a one-shot arms clip from a debug key, so a newly exported
    /// animation can be judged in Play mode before it has any gameplay trigger. Table-driven: a
    /// new clip is a new row, not a new component.
    /// <para>
    /// One-shot, unlike <see cref="CrawlDebugTrigger"/>, which toggles a looping cycle. When the
    /// clip has run through, the rig parks on <see cref="m_idleState"/> frozen at its first frame —
    /// the pose <see cref="HelmetAnimatorView"/> leaves the arms in.
    /// </para>
    /// Deliberately reads the keyboard device instead of the project-wide action asset
    /// (guideline 04 / rule 5): a throwaway key must not add churn to the shared
    /// Input/RootsDance.inputactions that every teammate merges.
    /// </summary>
    [RequireComponent(typeof(Animator))]
    public class ArmsClipDebugTrigger : MonoBehaviour
    {
        /// <summary>One debug key mapped to one Animator state in the base layer.</summary>
        [Serializable]
        public struct Binding
        {
            [Tooltip("Key that fires the clip.")]
            public Key m_key;

            [Tooltip("One-shot state in the controller's base layer.")]
            public string m_stateName;
        }

        [SerializeField] private List<Binding> m_bindings = new List<Binding>();

        [Tooltip("State the rig parks on once a clip finishes, held on frame 0.")]
        [SerializeField] private string m_idleState = "HelmetOff";

        private Animator m_animator;
        private int m_idleHash;
        private int m_playingHash;

        /// <summary>The key table. The rig builder writes rows through this.</summary>
        public List<Binding> Bindings
        {
            get { return m_bindings; }
        }

        public string IdleState
        {
            get { return m_idleState; }
            set { m_idleState = value; }
        }

        private void Awake()
        {
            m_animator = GetComponent<Animator>();
            m_idleHash = Animator.StringToHash(m_idleState);
        }

        private void Update()
        {
            Keyboard keyboard = Keyboard.current;

            if (keyboard == null || m_animator == null)
            {
                return;
            }

            for (int i = 0; i < m_bindings.Count; i++)
            {
                if (string.IsNullOrEmpty(m_bindings[i].m_stateName)
                    || !keyboard[m_bindings[i].m_key].wasPressedThisFrame)
                {
                    continue;
                }

                m_playingHash = Animator.StringToHash(m_bindings[i].m_stateName);
                m_animator.speed = 1f;
                m_animator.Play(m_playingHash, 0, 0f);
                Log.Info($"ArmsClipDebugTrigger: {m_bindings[i].m_key} pressed, "
                    + $"{m_bindings[i].m_stateName} started.", this);
                return;
            }

            if (m_playingHash == 0)
            {
                return;
            }

            // normalizedTime keeps climbing past 1 on a non-looping state, so this reads as
            // "the clip has played through" rather than "the clip is exactly at its last frame".
            AnimatorStateInfo state = m_animator.GetCurrentAnimatorStateInfo(0);

            if (state.shortNameHash != m_playingHash || state.normalizedTime < 1f)
            {
                return;
            }

            m_playingHash = 0;
            m_animator.Play(m_idleHash, 0, 0f);
            m_animator.speed = 0f;
        }
    }
}
