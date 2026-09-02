using System;
using DG.Tweening;
using RootsDance.Events;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// The one-line notice a story beat leaves on the screen: "荧光藻已装入手电筒". One table of
    /// "when this flag is raised, say this", listening to the bootstrap's <c>FlagRaised</c> channel.
    /// <para>
    /// Built the way <see cref="RootsDance.Audio.FlagAudioCues"/> is, and for the same reason
    /// (presentation contract D20): gameplay raises a flag because the world changed and has no
    /// idea a line exists, and every such line in the game is a row in an Inspector table rather
    /// than a call somewhere in a gameplay script. Flags are raised once, so a notice fires once —
    /// which is what a beat wants, and it also means a checkpoint that seeds its flags silently
    /// never replays a notice the player has already read.
    /// </para>
    /// <para>
    /// Motion: the line flicker-locks in the way every other notice on this device arrives, holds
    /// for <see cref="m_visibleSeconds"/>, then goes out on <see cref="TerminalMotion.FlickerLoss"/>
    /// — the signal breaking up rather than a fade, because nothing on this screen fades.
    /// </para>
    /// </summary>
    public class FlagNoticePresenter : MonoBehaviour
    {
        /// <summary>One row of the table.</summary>
        [Serializable]
        private struct Binding
        {
            [Tooltip("The flag id, exactly as RootsDance.Core.WorldFlags or the TriggerVolume spells it.")]
            public string m_flagId;

            [TextArea(1, 3)]
            [Tooltip("The line to put on screen. Empty rows are ignored.")]
            public string m_text;
        }

        [Header("Listens to")]
        [Tooltip("The bootstrap's FlagRaised channel. Data/Events/FlagRaised.")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Header("Table")]
        [SerializeField] private Binding[] m_bindings = new Binding[0];

        [Header("Widgets")]
        [Tooltip("Turned off while nothing is being said. Falls back to the label's own object.")]
        [SerializeField] private GameObject m_root;

        [SerializeField] private TextMeshProUGUI m_label;

        [Header("Timing")]
        [Tooltip("Seconds the line holds at full before the signal starts breaking up.")]
        [Min(0.1f)]
        [SerializeField] private float m_visibleSeconds = 3f;

        [Header("Motion")]
        [SerializeField] private TerminalMotionProfile m_motion = new TerminalMotionProfile();

        private CanvasGroup m_group;
        private float m_remaining;
        private bool m_isLeaving;

        private void Awake()
        {
            if (m_root == null && m_label != null)
            {
                m_root = m_label.gameObject;
            }

            m_group = TerminalMotion.EnsureCanvasGroup(m_root);
        }

        private void OnEnable()
        {
            Hide();

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

            m_remaining = 0f;
            m_isLeaving = false;

            TerminalMotion.Kill(m_group);
            TerminalMotion.Kill(m_label);
        }

        private void Update()
        {
            if (m_remaining <= 0f)
            {
                return;
            }

            m_remaining -= Time.deltaTime;

            if (m_remaining > 0f)
            {
                return;
            }

            Leave();
        }

        private void OnFlagRaised(string flagId)
        {
            if (string.IsNullOrEmpty(flagId) || m_label == null)
            {
                return;
            }

            for (int i = 0; i < m_bindings.Length; i++)
            {
                if (m_bindings[i].m_flagId != flagId || string.IsNullOrEmpty(m_bindings[i].m_text))
                {
                    continue;
                }

                Show(m_bindings[i].m_text);
                return;
            }
        }

        private void Show(string text)
        {
            m_isLeaving = false;
            m_remaining = m_visibleSeconds;

            TerminalMotion.Kill(m_label);

            m_label.text = text;
            m_label.maxVisibleCharacters = int.MaxValue;

            SetRootActive(true);

            TerminalMotion.FlickerLock(m_group, m_motion);
        }

        /// <summary>
        /// The line's exit. The object is only switched off once the flicker has played through —
        /// deactivating it now would cut the signal loss off at its first step, which reads as the
        /// notice simply vanishing.
        /// </summary>
        private void Leave()
        {
            if (m_isLeaving || m_group == null)
            {
                Hide();
                return;
            }

            m_isLeaving = true;

            Sequence sequence = TerminalMotion.FlickerLoss(m_group, m_motion);

            if (sequence == null)
            {
                Hide();
                return;
            }

            sequence.OnComplete(() =>
            {
                m_isLeaving = false;
                SetRootActive(false);
            });
        }

        private void Hide()
        {
            m_remaining = 0f;
            m_isLeaving = false;

            TerminalMotion.Kill(m_label);
            TerminalMotion.HardCut(m_group);

            SetRootActive(false);
        }

        private void SetRootActive(bool active)
        {
            // Through the shared rule, never a bare SetActive: this presenter's root is its own
            // GameObject in the bootstrap scene, and switching that off would drop the FlagRaised
            // subscription the notice exists to listen on. See <see cref="UiRootVisibility"/>.
            UiRootVisibility.Set(m_root, this, m_group, active);
        }
    }
}
