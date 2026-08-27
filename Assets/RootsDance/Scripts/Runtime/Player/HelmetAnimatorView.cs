using System;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// <see cref="IHelmetView"/> backed by the arms rig's removal clip. Holds the clip's first frame
    /// (helmet on, arms in the start pose) until <see cref="PlayRemove"/> is called, plays it once,
    /// then hides the helmet renderer and reports back. The controller stays free of any animation
    /// knowledge — it only asks for the performance and waits for <see cref="RemoveFinished"/>.
    /// </summary>
    [RequireComponent(typeof(Animator))]
    public class HelmetAnimatorView : MonoBehaviour, IHelmetView
    {
        [Tooltip("State in the controller's base layer that plays the removal.")]
        [SerializeField] private string m_stateName = "HelmetOff";

        [Tooltip("Clip played by that state. Read for its length only.")]
        [SerializeField] private AnimationClip m_removeClip;

        [Tooltip("Helmet renderer disabled once removal finishes. Optional.")]
        [SerializeField] private Renderer m_helmetRenderer;

        [Tooltip("Playback speed of the removal. 1 = authored speed, 0.5 = half speed.")]
        [Range(0.1f, 2f)]
        [SerializeField] private float m_playbackSpeed = 0.5f;

        private Animator m_animator;
        private int m_stateHash;
        private bool m_isPlaying;

        public event Action RemoveFinished;

        private void Awake()
        {
            m_animator = GetComponent<Animator>();
            m_stateHash = Animator.StringToHash(m_stateName);

            // Freeze on the first frame so the helmet reads as worn until the player triggers removal.
            m_animator.Play(m_stateHash, 0, 0f);
            m_animator.speed = 0f;
        }

        public void PlayRemove()
        {
            if (m_isPlaying)
            {
                return;
            }

            m_isPlaying = true;
            PlayRemoveAsync();
        }

        private async Awaitable PlayRemoveAsync()
        {
            // Replays (debug trigger, retries) start with the helmet worn again, so undo the
            // hide from the previous run before the first frame renders.
            if (m_helmetRenderer != null)
            {
                m_helmetRenderer.enabled = true;
            }

            m_animator.Play(m_stateHash, 0, 0f);
            m_animator.speed = m_playbackSpeed;

            // The wait must cover the slowed clip, or the helmet hides mid-performance.
            float duration = (m_removeClip == null ? 1f : m_removeClip.length)
                / Mathf.Max(m_playbackSpeed, 0.01f);

            if (m_removeClip == null)
            {
                Log.Warning("HelmetAnimatorView has no remove clip assigned; using a 1s fallback.", this);
            }

            try
            {
                await Awaitable.WaitForSecondsAsync(duration, destroyCancellationToken);
            }
            catch (OperationCanceledException)
            {
                return;
            }

            m_animator.speed = 0f;

            if (m_helmetRenderer != null)
            {
                m_helmetRenderer.enabled = false;
            }

            m_isPlaying = false;
            RemoveFinished?.Invoke();
        }
    }
}
