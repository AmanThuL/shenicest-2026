using RootsDance.App;
using RootsDance.Core;
using RootsDance.Core.Commands;
using RootsDance.Events;
using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Node 00-05. Once contamination drops below the suit threshold the device offers to release
    /// the seal; the player confirms, art plays the removal, and only then is the flag raised.
    /// The whole slice runs without any animation: leave the view empty and removal completes at once.
    /// </summary>
    public class HelmetController : MonoBehaviour
    {
        [Header("Listens to")]
        [SerializeField] private StringEventChannelSO m_flagRaised;

        [Tooltip("Flag that unlocks removal.")]
        [SerializeField] private string m_unlockFlag = WorldFlags.k_HelmetRemovable;

        [Header("Broadcasts on")]
        [Tooltip("Device notice shown when removal becomes available.")]
        [SerializeField] private StringEventChannelSO m_noticeRequested;

        [TextArea(1, 4)]
        [SerializeField] private string m_noticeText = "外部污染浓度低于防护阈值。可解除环境隔离。";

        [Header("Wiring")]
        [SerializeField] private PlayerInputReader m_input;

        [Tooltip("Art component implementing IHelmetView. Empty = instant removal (placeholder).")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        private IHelmetView m_view;
        private bool m_isUnlocked;
        private bool m_isRemoving;
        private bool m_isRemoved;

        public bool IsRemoved => m_isRemoved;

        private void Awake()
        {
            m_view = m_viewBehaviour as IHelmetView;
        }

        private void OnEnable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised += OnFlagRaised;
            }

            if (m_view != null)
            {
                m_view.RemoveFinished += OnRemoveFinished;
            }
        }

        private void Update()
        {
            if (!m_isUnlocked || m_isRemoving || m_isRemoved || m_input == null)
            {
                return;
            }

            if (m_input.InteractPressedThisFrame)
            {
                BeginRemove();
            }
        }

        private void OnDisable()
        {
            if (m_flagRaised != null)
            {
                m_flagRaised.EventRaised -= OnFlagRaised;
            }

            if (m_view != null)
            {
                m_view.RemoveFinished -= OnRemoveFinished;
            }
        }

        private void OnFlagRaised(string flagId)
        {
            if (m_isUnlocked || flagId != m_unlockFlag)
            {
                return;
            }

            m_isUnlocked = true;

            if (m_noticeRequested != null)
            {
                m_noticeRequested.RaiseEvent(m_noticeText);
            }
        }

        private void BeginRemove()
        {
            m_isRemoving = true;

            if (m_view == null)
            {
                OnRemoveFinished();
                return;
            }

            m_view.PlayRemove();
        }

        private void OnRemoveFinished()
        {
            if (m_isRemoved)
            {
                return;
            }

            m_isRemoved = true;
            m_isRemoving = false;

            if (m_noticeRequested != null)
            {
                m_noticeRequested.RaiseEvent(string.Empty);
            }

            WorldAccess.Enqueue(new RaiseFlagCommand(WorldFlags.k_HelmetRemoved), this);
        }
    }
}
