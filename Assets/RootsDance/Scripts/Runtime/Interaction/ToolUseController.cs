using System;
using RootsDance.App;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Interaction
{
    /// <summary>
    /// Owns the "a tool is currently in use" gate. One interaction at a time, start to finish:
    /// this is what stops an interaction being confirmed twice in one frame, and what makes the
    /// investigation result wait for the art performance instead of popping instantly.
    /// </summary>
    public class ToolUseController : MonoBehaviour
    {
        [Tooltip("Safety net in seconds. If a tool view never reports back, release the gate anyway.")]
        [SerializeField] private float m_timeout = 8f;

        private IToolView m_activeView;
        private Action m_onFinished;
        private float m_elapsed;

        public bool IsBusy => m_activeView != null;

        private void Update()
        {
            if (m_activeView == null)
            {
                return;
            }

            m_elapsed += Time.deltaTime;

            if (m_elapsed >= m_timeout)
            {
                Log.Warning("Tool view never raised UseFinished; releasing the interaction gate.", this);
                Finish();
            }
        }

        /// <summary>
        /// Starts a tool performance. Returns false when another one is still running.
        /// A null <paramref name="view"/> completes immediately, which is how the slice runs before
        /// any animation exists.
        /// </summary>
        public bool TryUse(IToolView view, Action onFinished)
        {
            if (IsBusy || !WorldAccess.TryBeginExclusiveInteraction(this))
            {
                return false;
            }

            if (view == null)
            {
                WorldAccess.EndExclusiveInteraction(this);
                onFinished?.Invoke();
                return true;
            }

            m_activeView = view;
            m_onFinished = onFinished;
            m_elapsed = 0f;

            view.UseFinished += OnUseFinished;
            view.PlayUse();
            return true;
        }

        private void OnUseFinished()
        {
            Finish();
        }

        private void OnDestroy()
        {
            // No callback on the way out — the scene is going down. Only the gate must not leak.
            if (m_activeView != null)
            {
                m_activeView.UseFinished -= OnUseFinished;
                m_activeView = null;
                m_onFinished = null;
            }

            WorldAccess.EndExclusiveInteraction(this);
        }

        private void Finish()
        {
            IToolView view = m_activeView;
            Action callback = m_onFinished;

            m_activeView = null;
            m_onFinished = null;

            if (view != null)
            {
                view.UseFinished -= OnUseFinished;
            }

            WorldAccess.EndExclusiveInteraction(this);
            callback?.Invoke();
        }
    }
}
