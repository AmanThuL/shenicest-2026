using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.Dialogue
{
    /// <summary>
    /// Runs one conversation at a time: plays the lines, offers the options, waits for an answer,
    /// and raises the flags the script hangs on it. Lives with the player.
    /// <para>
    /// The order and the timing are here; how any of it looks is the view's. The runner never
    /// touches a Text component, and the view never learns what a conversation is — see
    /// <see cref="IDialogueView"/>.
    /// </para>
    /// </summary>
    public class DialogueRunner : MonoBehaviour
    {
        [Header("Listens to")]
        [Tooltip("Data/Events/DialogueRequested. Triggers in content scenes raise it.")]
        [SerializeField] private DialogueEventChannelSO m_playRequested;

        [Header("Broadcasts on")]
        [Tooltip("Raised as a conversation starts. Nothing consumes it yet; it is the hook for "
            + "taking movement and interaction away from the player while someone is talking.")]
        [SerializeField] private VoidEventChannelSO m_conversationStarted;

        [Tooltip("Raised once it ends, whichever way it went — including when it is cut short.")]
        [SerializeField] private VoidEventChannelSO m_conversationEnded;

        [Header("View")]
        [Tooltip("The component implementing IDialogueView. Empty runs the conversation silently, "
            + "which is what an automated test wants and what a half-built scene tolerates.")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        [Header("Input")]
        [Tooltip("Optional. With it, the interact button skips ahead to the next line.")]
        [SerializeField] private PlayerInputReader m_input;

        [Header("Reading speed")]
        [Tooltip("Chinese characters per second for a line with no authored hold.")]
        [SerializeField] private float m_cjkCharsPerSecond = DialogueTiming.k_DefaultCjkCharsPerSecond;

        [Tooltip("Latin characters per second, for the English subtitle under it.")]
        [SerializeField] private float m_latinCharsPerSecond = DialogueTiming.k_DefaultLatinCharsPerSecond;

        [SerializeField] private float m_minimumHoldSeconds = DialogueTiming.k_DefaultMinimumSeconds;

        [SerializeField] private float m_maximumHoldSeconds = DialogueTiming.k_DefaultMaximumSeconds;

        private readonly HashSet<string> m_played = new HashSet<string>();
        private readonly List<int> m_remaining = new List<int>();
        private IDialogueView m_view;
        private int m_pendingChoice = -1;

        /// <summary>True while a conversation is on screen. A second request is refused, not queued.</summary>
        public bool IsPlaying { get; private set; }

        private void Awake()
        {
            m_view = m_viewBehaviour as IDialogueView;

            if (m_viewBehaviour != null && m_view == null)
            {
                Log.Error($"'{m_viewBehaviour.GetType().Name}' does not implement IDialogueView.", this);
            }
        }

        private void OnEnable()
        {
            if (m_playRequested != null)
            {
                m_playRequested.EventRaised += Play;
            }

            if (m_view != null)
            {
                m_view.ChoiceSelected += OnChoiceSelected;
            }
        }

        private void OnDisable()
        {
            if (m_playRequested != null)
            {
                m_playRequested.EventRaised -= Play;
            }

            if (m_view != null)
            {
                m_view.ChoiceSelected -= OnChoiceSelected;
            }
        }

        /// <summary>Starts a conversation if nothing is playing and its conditions are met.</summary>
        public void Play(DialogueSO conversation)
        {
            if (conversation == null || IsPlaying || !CanPlay(conversation))
            {
                return;
            }

            PlayEntryAsync(conversation, destroyCancellationToken);
        }

        private bool CanPlay(DialogueSO conversation)
        {
            if (conversation.PlaysOnce && m_played.Contains(conversation.Id))
            {
                return false;
            }

            if (string.IsNullOrEmpty(conversation.RequiredFlag))
            {
                return true;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                // Only reachable on the first frame of a level-only Play session. Refusing is the
                // safe half of the choice: the trigger will come round again, and a gated
                // conversation playing early would spend a story beat out of order.
                Log.Warning($"Dialogue '{conversation.Id}' needs flag '{conversation.RequiredFlag}' "
                    + "but the bootstrap has not arrived yet; skipped.", this);
                return false;
            }

            return state.HasFlag(conversation.RequiredFlag);
        }

        private async void PlayEntryAsync(DialogueSO conversation, CancellationToken cancellationToken)
        {
            IsPlaying = true;
            Raise(m_conversationStarted);

            try
            {
                await ConversationAsync(conversation, cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Object destroyed or Play mode exited: nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
            finally
            {
                IsPlaying = false;

                if (m_view != null)
                {
                    m_view.Hide();
                }

                Raise(m_conversationEnded);
            }
        }

        private async Awaitable ConversationAsync(DialogueSO conversation, CancellationToken cancellationToken)
        {
            m_played.Add(conversation.Id);

            await LinesAsync(conversation.Lines, cancellationToken);
            await ChoicesAsync(conversation, cancellationToken);

            if (!string.IsNullOrEmpty(conversation.FlagOnComplete))
            {
                WorldAccess.Enqueue(new RaiseFlagCommand(conversation.FlagOnComplete), this);
            }
        }

        private async Awaitable LinesAsync(DialogueLine[] lines, CancellationToken cancellationToken)
        {
            if (lines == null)
            {
                return;
            }

            for (int i = 0; i < lines.Length; i++)
            {
                DialogueLine line = lines[i];

                if (m_view != null)
                {
                    m_view.ShowLine(line.Speaker, line.Chinese, line.English);
                }

                float hold = line.HoldSeconds > 0f
                    ? line.HoldSeconds
                    : DialogueTiming.HoldSecondsFor(line.Chinese, line.English, m_cjkCharsPerSecond,
                        m_latinCharsPerSecond, m_minimumHoldSeconds, m_maximumHoldSeconds);

                await HoldAsync(hold, cancellationToken);
            }
        }

        /// <summary>
        /// Waits out a line, but lets the interact button cut it short. Counted frame by frame
        /// rather than with WaitForSecondsAsync because a hold that cannot be skipped is the
        /// difference between a conversation and a cutscene.
        /// </summary>
        private async Awaitable HoldAsync(float seconds, CancellationToken cancellationToken)
        {
            float elapsed = 0f;

            while (elapsed < seconds)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
                elapsed += Time.deltaTime;

                if (m_input != null && m_input.InteractPressedThisFrame)
                {
                    return;
                }
            }
        }

        private async Awaitable ChoicesAsync(DialogueSO conversation, CancellationToken cancellationToken)
        {
            DialogueChoice[] choices = conversation.Choices;

            if (choices == null || choices.Length == 0 || m_view == null)
            {
                return;
            }

            m_remaining.Clear();

            for (int i = 0; i < choices.Length; i++)
            {
                if (choices[i] != null)
                {
                    m_remaining.Add(i);
                }
            }

            while (m_remaining.Count > 0)
            {
                string[] chinese = new string[m_remaining.Count];
                string[] english = new string[m_remaining.Count];

                for (int i = 0; i < m_remaining.Count; i++)
                {
                    chinese[i] = choices[m_remaining[i]].Chinese;
                    english[i] = choices[m_remaining[i]].English;
                }

                m_pendingChoice = -1;
                m_view.ShowChoices(chinese, english);

                while (m_pendingChoice < 0)
                {
                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                // The view reports an index into what it was shown, which is the remaining set.
                int offered = Mathf.Clamp(m_pendingChoice, 0, m_remaining.Count - 1);
                DialogueChoice chosen = choices[m_remaining[offered]];
                m_remaining.RemoveAt(offered);

                if (!string.IsNullOrEmpty(chosen.FlagOnChosen))
                {
                    WorldAccess.Enqueue(new RaiseFlagCommand(chosen.FlagOnChosen), this);
                }

                await LinesAsync(chosen.Response, cancellationToken);

                if (chosen.Follow != null)
                {
                    await ConversationAsync(chosen.Follow, cancellationToken);
                }

                if (!conversation.ChoicesRepeat)
                {
                    return;
                }
            }
        }

        private void OnChoiceSelected(int index)
        {
            m_pendingChoice = index;
        }

        private void Raise(VoidEventChannelSO channel)
        {
            if (channel != null)
            {
                channel.RaiseEvent();
            }
        }
    }
}
