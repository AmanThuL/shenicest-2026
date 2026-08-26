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
            m_animator.Play(m_stateHash, 0, 0f);
            m_animator.speed = 1f;

            float duration = m_removeClip == null ? 1f : m_removeClip.length;

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
