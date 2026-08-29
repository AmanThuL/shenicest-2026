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
    /// for.
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

        [Tooltip("Root of the held scanner. Every renderer under it is hidden until the scanner is "
            + "raised — the two-handed animations are authored with an empty left hand, so a "
            + "scanner sitting in it during those reads as a mistake.")]
        [SerializeField] private Transform m_scannerRoot;

        private Renderer[] m_scannerRenderers;

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

            // Falls back to the left hand socket when nothing is wired. Hiding the scanner is not
            // a nicety — the two-handed clips are authored with an empty left hand — so it must not
            // depend on someone having run a scene builder first.
            if (m_scannerRoot == null)
            {
                m_scannerRoot = FindLeftHandSocket();
            }

            // Toggling renderers rather than the object: the inspect controller and the proximity
            // trigger live on the prop root, so deactivating it would switch off the very things
            // that start a scan.
            if (m_scannerRoot != null)
            {
                m_scannerRenderers = m_scannerRoot.GetComponentsInChildren<Renderer>(true);
            }
            else
            {
                Log.Warning("ScannerArmsView found no scanner to hide; it will stay visible "
                    + "through the two-handed animations.", this);
            }

            SetScannerVisible(false);
        }

        /// <summary>The socket the scanner rides, found by side so no wiring step is required.</summary>
        private static Transform FindLeftHandSocket()
        {
            foreach (HandSocket socket in FindObjectsByType<HandSocket>(
                FindObjectsInactive.Include, FindObjectsSortMode.None))
            {
                if (socket.Hand == HandSide.Left)
                {
                    return socket.transform;
                }
            }

            return null;
        }

        /// <summary>Shows or hides the held scanner without disabling anything that drives it.</summary>
        private void SetScannerVisible(bool visible)
        {
            if (m_scannerRenderers == null)
            {
                return;
            }

            for (int i = 0; i < m_scannerRenderers.Length; i++)
            {
                if (m_scannerRenderers[i] != null)
                {
                    m_scannerRenderers[i].enabled = visible;
                }
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

            SetScannerVisible(true);
            m_isRaising = m_director.TryPlay(m_raiseActionId);

            if (!m_isRaising)
            {
                // Refused (the arm is busy) — put it away again rather than leaving it floating.
                SetScannerVisible(false);
            }
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

            SetScannerVisible(false);
            LowerFinished?.Invoke();
        }
    }
}
