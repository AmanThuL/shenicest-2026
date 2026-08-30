using System;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// <see cref="IScannerView"/> backed by the arms rig's two scanner clips. Lives on the arms
    /// object, next to the Animator, because the performance is an arm animation — the scanner prop
    /// itself only rides along on its hand socket.
    /// <para>
    /// Both clips are single-arm (arms contract: no camera and no root curves), so they play on a
    /// masked layer rather than the base layer. <see cref="m_layer"/> names that layer; leaving it
    /// at 0 plays them on the base layer, which is fine for a test rig and wrong in the game.
    /// </para>
    /// </summary>
    [RequireComponent(typeof(Animator))]
    public class ScannerAnimatorView : MonoBehaviour, IScannerView
    {
        [Tooltip("Animator state that plays scanner_raise.")]
        [SerializeField] private string m_raiseState = "ScannerRaise";

        [Tooltip("Animator state that plays scanner_lower.")]
        [SerializeField] private string m_lowerState = "ScannerLower";

        [Tooltip("Clip behind the raise state. Read for its length only.")]
        [SerializeField] private AnimationClip m_raiseClip;

        [Tooltip("Clip behind the lower state. Read for its length only.")]
        [SerializeField] private AnimationClip m_lowerClip;

        [Tooltip("Animator layer the two states live on. 0 is the base layer; the game uses the "
            + "left-arm masked layer so the right arm keeps whatever it was doing.")]
        [SerializeField] private int m_layer;

        [Tooltip("Playback speed. 1 is the authored speed.")]
        [Range(0.1f, 2f)]
        [SerializeField] private float m_playbackSpeed = 1f;

        [Tooltip("Renderer of the held scanner. Hidden until the raise starts, shown again after "
            + "the lower finishes. Optional — leave empty when the prop is always visible.")]
        [SerializeField] private Renderer m_scannerRenderer;

        private Animator m_animator;
        private int m_raiseHash;
        private int m_lowerHash;
        private bool m_isPlaying;

        public event Action RaiseFinished;

        public event Action LowerFinished;

        /// <summary>True between <see cref="PlayRaise"/> and the matching finished event.</summary>
        public bool IsPlaying => m_isPlaying;

        private void Awake()
        {
            m_animator = GetComponent<Animator>();
            m_raiseHash = Animator.StringToHash(m_raiseState);
            m_lowerHash = Animator.StringToHash(m_lowerState);
        }

        public void PlayRaise()
        {
            Play(m_raiseHash, m_raiseClip, true);
        }

        public void PlayLower()
        {
            Play(m_lowerHash, m_lowerClip, false);
        }

        private void Play(int stateHash, AnimationClip clip, bool isRaise)
        {
            if (m_isPlaying)
            {
                Log.Warning("ScannerAnimatorView was asked for a second performance while one was "
                    + "still running; the request was dropped.", this);
                return;
            }

            m_isPlaying = true;

            // Fire and forget on purpose: the caller is told the performance is over through
            // RaiseFinished / LowerFinished, not by awaiting here.
            _ = PlayAsync(stateHash, clip, isRaise);
        }

        private async Awaitable PlayAsync(int stateHash, AnimationClip clip, bool isRaise)
        {
            if (m_animator == null)
            {
                Finish(isRaise);
                return;
            }

            if (isRaise && m_scannerRenderer != null)
            {
                m_scannerRenderer.enabled = true;
            }

            m_animator.speed = m_playbackSpeed;
            m_animator.Play(stateHash, m_layer, 0f);

            if (clip == null)
            {
                Log.Warning("ScannerAnimatorView is missing a clip; using a 0.5 s fallback.", this);
            }

            float duration = (clip == null ? 0.5f : clip.length) / Mathf.Max(m_playbackSpeed, 0.01f);

            try
            {
                await Awaitable.WaitForSecondsAsync(duration, destroyCancellationToken);
            }
            catch (OperationCanceledException)
            {
                return;
            }

            // Nothing freezes the Animator here on purpose: the raise state is non-looping, so it
            // holds its last frame by itself, and zeroing the speed would also stop every other
            // layer — the right arm included.
            if (!isRaise && m_scannerRenderer != null)
            {
                m_scannerRenderer.enabled = false;
            }

            Finish(isRaise);
        }

        private void Finish(bool isRaise)
        {
            m_isPlaying = false;

            if (isRaise)
            {
                RaiseFinished?.Invoke();
            }
            else
            {
                LowerFinished?.Invoke();
            }
        }
    }
}
