using System.Threading;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Fades an opaque full-screen graphic over the current frame. The graphic lives on its own
    /// canvas so it can cover the outgoing level before the between-scenes boot screen is enabled.
    /// </summary>
    [DisallowMultipleComponent]
    [RequireComponent(typeof(CanvasGroup))]
    public class FullscreenFadePresenter : MonoBehaviour
    {
        [Tooltip("Seconds for the outgoing scene to fade fully to black, in unscaled time.")]
        [Min(0f)]
        [SerializeField] private float m_fadeToBlackSeconds = 0.35f;

        private CanvasGroup m_group;

        private void Awake()
        {
            m_group = GetComponent<CanvasGroup>();
            m_group.interactable = false;
            Hide();
        }

        /// <summary>Fades from the current opacity to opaque black using unscaled time.</summary>
        public async Awaitable FadeToBlackAsync(CancellationToken cancellationToken)
        {
            m_group.blocksRaycasts = true;

            if (m_fadeToBlackSeconds <= 0f)
            {
                m_group.alpha = 1f;
                await Awaitable.NextFrameAsync(cancellationToken);
                return;
            }

            float startingAlpha = m_group.alpha;
            float startedAt = Time.realtimeSinceStartup;

            while (m_group.alpha < 1f)
            {
                float elapsed = Time.realtimeSinceStartup - startedAt;
                float fraction = Mathf.Clamp01(elapsed / m_fadeToBlackSeconds);
                m_group.alpha = Mathf.Lerp(startingAlpha, 1f, fraction);

                if (fraction >= 1f)
                {
                    break;
                }

                await Awaitable.NextFrameAsync(cancellationToken);
            }

            m_group.alpha = 1f;
            await Awaitable.NextFrameAsync(cancellationToken);
        }

        /// <summary>Immediately removes the black overlay once another opaque screen is underneath.</summary>
        public void Hide()
        {
            m_group.alpha = 0f;
            m_group.blocksRaycasts = false;
        }
    }
}
