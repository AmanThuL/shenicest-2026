using System;
using RootsDance.Core;
using RootsDance.Scanner;
using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// <see cref="IScannerView"/> on top of <see cref="IArmsDirector"/>.
    /// <see cref="ScannerInspectController"/> is unchanged: it still asks for a raise and waits for
    /// <see cref="RaiseFinished"/>.
    /// <para>
    /// Both scanner clips are left-arm only, so they run on the masked left layer and the right
    /// hand keeps whatever it was holding. The raise holds its end pose until the lower is asked
    /// for, which the director enforces through the pose gate rather than by convention.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ScannerArmsView : MonoBehaviour, IScannerView
    {
        [Tooltip("The arms director. Found on this object or a parent when left empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Tooltip("Action id that raises the scanner to the aim pose.")]
        [SerializeField] private string m_raiseActionId = "scannerRaise";

        [Tooltip("Action id that brings it back to neutral.")]
        [SerializeField] private string m_lowerActionId = "scannerLower";

        [Tooltip("Renderer of the held scanner. Shown while it is up. Optional.")]
        [SerializeField] private Renderer m_scannerRenderer;

        private bool m_isRaising;
        private bool m_isLowering;

        public event Action RaiseFinished;

        public event Action LowerFinished;

        /// <summary>True between a request and the matching finished event.</summary>
        public bool IsPlaying => m_isRaising || m_isLowering;

        private void Awake()
        {
            if (m_director == null)
            {
                m_director = GetComponentInParent<ArmsDirector>();
            }

            if (m_director == null)
            {
                Log.Error("ScannerArmsView has no ArmsDirector; the scanner will not animate.", this);
            }
        }

        private void OnEnable()
        {
            if (m_director != null)
            {
                m_director.ActionFinished += OnActionFinished;
            }
        }

        private void OnDisable()
        {
            if (m_director != null)
            {
                m_director.ActionFinished -= OnActionFinished;
            }
        }

        public void PlayRaise()
        {
            if (IsPlaying || m_director == null)
            {
                return;
            }

            if (m_scannerRenderer != null)
            {
                m_scannerRenderer.enabled = true;
            }

            m_isRaising = m_director.TryPlay(m_raiseActionId);
        }

        public void PlayLower()
        {
            if (IsPlaying || m_director == null)
            {
                return;
            }

            m_isLowering = m_director.TryPlay(m_lowerActionId);
        }

        private void OnActionFinished(string actionId)
        {
            if (m_isRaising && actionId == m_raiseActionId)
            {
                m_isRaising = false;
                RaiseFinished?.Invoke();
                return;
            }

            if (!m_isLowering || actionId != m_lowerActionId)
            {
                return;
            }

            m_isLowering = false;

            if (m_scannerRenderer != null)
            {
                m_scannerRenderer.enabled = false;
            }

            LowerFinished?.Invoke();
        }
    }
}
