using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.App;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using RootsDance.Player;
using UnityEngine;
using UnityEngine.SceneManagement;

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
    public class DialogueRunner : MonoBehaviour, IRescueResetParticipant
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

        [Header("Voice")]
        [Tooltip("Where a line's recording is played. Data/Events/AudioCueRequested. Empty runs "
            + "the conversation as subtitles only.")]
        [SerializeField] private AudioCueEventChannelSO m_audioChannel;

        [Tooltip("The cue that mixes spoken lines — group, volume, spatial blend. One cue serves "
            + "every line; the recordings live on the lines themselves.")]
        [SerializeField] private AudioCueSO m_voiceCue;

        [Header("View")]
        [Tooltip("The component implementing IDialogueView. Empty runs the conversation silently, "
            + "which is what an automated test wants and what a half-built scene tolerates.")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        [Header("Input")]
        [Tooltip("Optional. With it, the interact button skips ahead to the next line. Leave empty "
            + "and it is found once at Start — which is the normal case, because the runner lives "
            + "in the bootstrap scene next to the screen it drives, and the player is in a level "
            + "scene where no serialized reference can reach.")]
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
        private CancellationTokenSource m_conversationCancellation;

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

        private void Start()
        {
            // Once, at startup, and only when a scene could not wire it: skipping a line is a
            // convenience, so a missing reader costs the skip and nothing else.
            if (m_input == null)
            {
                m_input = FindFirstObjectByType<PlayerInputReader>();
            }
        }

        private void OnEnable()
        {
            SceneManager.sceneLoaded += OnSceneLoaded;

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
            SceneManager.sceneLoaded -= OnSceneLoaded;
            CancelConversation();

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

            m_conversationCancellation = CancellationTokenSource.CreateLinkedTokenSource(destroyCancellationToken);
            PlayEntryAsync(conversation, m_conversationCancellation);
        }

        /// <summary>Cancels unfinished dialogue without carrying its completion flags into a new checkpoint.</summary>
        public void ResetForRescue()
        {
            CancelConversation();
            m_played.Clear();
            m_remaining.Clear();
            m_pendingChoice = -1;
            m_input = null;
        }

        private void CancelConversation()
        {
            CancellationTokenSource cancellation = m_conversationCancellation;
            m_conversationCancellation = null;
            cancellation?.Cancel();

            bool wasPlaying = IsPlaying;
            IsPlaying = false;
            m_view?.Hide();

            if (wasPlaying)
            {
                Raise(m_conversationEnded);
            }
        }

        private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
        {
            if (m_input != null)
            {
                return;
            }

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                m_input = root.GetComponentInChildren<PlayerInputReader>();

                if (m_input != null)
                {
                    return;
                }
            }
        }

        private bool CanPlay(DialogueSO conversation)
        {
            if (conversation.PlaysOnce && m_played.Contains(conversation.Id))
            {
                return false;
            }

            IWorldStateReader state = WorldAccess.State;
            if (conversation.PlaysOnce && state != null
                && !string.IsNullOrEmpty(conversation.FlagOnComplete)
                && state.HasFlag(conversation.FlagOnComplete))
            {
                return false;
            }

            if (string.IsNullOrEmpty(conversation.RequiredFlag))
            {
                return true;
            }

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

        private async void PlayEntryAsync(DialogueSO conversation, CancellationTokenSource cancellation)
        {
            IsPlaying = true;
            Raise(m_conversationStarted);

            try
            {
                await ConversationAsync(conversation, cancellation.Token);
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
                if (m_conversationCancellation == cancellation)
                {
                    m_conversationCancellation = null;
                    IsPlaying = false;
                    m_view?.Hide();
                    Raise(m_conversationEnded);
                }

                cancellation.Dispose();
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

                AudioClip voice = line.Voice;

                if (voice != null && m_voiceCue != null && m_audioChannel != null)
                {
                    m_audioChannel.RaiseEvent(AudioCueRequest.Voice(m_voiceCue, voice));
                }

                float hold = DialogueTiming.HoldSecondsForLine(line.HoldSeconds,
                    voice == null ? 0f : voice.length, line.Chinese, line.English,
                    m_cjkCharsPerSecond, m_latinCharsPerSecond, m_minimumHoldSeconds,
                    m_maximumHoldSeconds);

                // A recorded line is not skippable: the pool has no per-voice stop, so cutting the
                // subtitle would leave the recording talking over the next line. An unvoiced line
                // still skips, which is what makes a subtitle-only conversation bearable to replay.
                await HoldAsync(hold, voice == null, cancellationToken);
            }
        }

        /// <summary>
        /// Waits out a line, and — when the line is not voiced — lets the interact button cut it
        /// short. Counted frame by frame
        /// rather than with WaitForSecondsAsync because a hold that cannot be skipped is the
        /// difference between a conversation and a cutscene.
        /// </summary>
        private async Awaitable HoldAsync(float seconds, bool allowSkip,
            CancellationToken cancellationToken)
        {
            float elapsed = 0f;

            while (elapsed < seconds)
            {
                await Awaitable.NextFrameAsync(cancellationToken);
                elapsed += Time.deltaTime;

                if (allowSkip && m_input != null && m_input.InteractPressedThisFrame)
                {
                    return;
                }
            }
        }

        /// <summary>
        /// The player saying the option they picked, heard before the answer comes back. The choice
        /// list is already gone from the view, so nothing is on screen during it — the beat where
        /// the question hangs in the air is the point. Silent options cost nothing.
        /// </summary>
        private async Awaitable PickedLineAsync(DialogueChoice chosen, CancellationToken cancellationToken)
        {
            AudioClip voice = chosen.Voice;

            if (voice == null || m_voiceCue == null || m_audioChannel == null)
            {
                return;
            }

            m_audioChannel.RaiseEvent(AudioCueRequest.Voice(m_voiceCue, voice));
            await HoldAsync(voice.length + DialogueTiming.k_VoiceTailSeconds, false, cancellationToken);
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

                await PickedLineAsync(chosen, cancellationToken);
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
