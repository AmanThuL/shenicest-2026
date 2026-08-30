using System;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player.Arms
{
    /// <summary>
    /// <see cref="IHelmetView"/> on top of <see cref="IArmsDirector"/>. Keeps the presentation
    /// contract (表现层驱动契约 D17) exactly as gameplay knows it — <see cref="HelmetController"/>
    /// still just asks for the performance and waits — while the animation itself goes through the
    /// one component that owns the Animator.
    /// <para>
    /// The interesting part is the handover. The removal clip carries its own helmet on the rig's
    /// <c>helmet_socket</c> bone; at the authored Attach moment (frame 27 of 120, where the socket
    /// locks to the right hand) that rigged helmet is hidden and the real prop is put into the
    /// hand instead. From there the helmet is an ordinary carried object: the arms end on the hold
    /// pose, and the same 'drop' action that throws anything else will throw it.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class HelmetArmsView : MonoBehaviour, IHelmetView
    {
        [Tooltip("The arms director. Found on this object or a parent when left empty.")]
        [SerializeField] private ArmsDirector m_director;

        [Tooltip("Action id of the removal performance.")]
        [SerializeField] private string m_actionId = "helmetOff";

        [Tooltip("The helmet that rides the rig inside the clip. Hidden at the handover moment so "
            + "the real prop can take its place. Optional.")]
        [SerializeField] private Renderer m_riggedHelmet;

        [Tooltip("Socket the helmet is handed to. Optional — removal still completes without it.")]
        [SerializeField] private HandSocket m_rightSocket;

        [Tooltip("The helmet as a carried prop. Optional.")]
        [SerializeField] private CarriedItem m_helmetItem;

        private bool m_isRemoving;
        private bool m_hasRemoved;

        public event Action<float> RemoveStarted;

        public event Action RemoveFinished;

        private void Awake()
        {
            if (m_director == null)
            {
                m_director = GetComponentInParent<ArmsDirector>();
            }

            if (m_director == null)
            {
                Log.Error("HelmetArmsView has no ArmsDirector; removal will complete instantly.", this);
            }
        }

        private void OnEnable()
        {
            if (m_director == null)
            {
                return;
            }

            m_director.ActionFinished += OnActionFinished;
            m_director.HandEventRaised += OnHandEvent;
        }

        private void OnDisable()
        {
            if (m_director == null)
            {
                return;
            }

            m_director.ActionFinished -= OnActionFinished;
            m_director.HandEventRaised -= OnHandEvent;
        }

        public void PlayRemove()
        {
            // Taking the helmet off happens once.
            if (m_isRemoving || m_hasRemoved)
            {
                return;
            }

            if (m_director == null)
            {
                m_hasRemoved = true;
                RemoveStarted?.Invoke(0f);
                RemoveFinished?.Invoke();
                return;
            }

            if (m_rightSocket != null && m_helmetItem != null)
            {
                m_rightSocket.SetPending(m_helmetItem);
            }

            if (!m_director.TryPlay(m_actionId))
            {
                return;
            }

            m_isRemoving = true;

            ArmsActionSO action = m_director.FindAction(m_actionId);
            RemoveStarted?.Invoke(action == null ? 0f : action.Duration);
        }

        public void SetRemovedImmediately()
        {
            if (m_hasRemoved)
            {
                return;
            }

            m_isRemoving = false;
            m_hasRemoved = true;

            if (m_riggedHelmet != null)
            {
                m_riggedHelmet.enabled = false;
            }

            RemoveStarted?.Invoke(0f);
            RemoveFinished?.Invoke();
        }

        private void OnHandEvent(HandSide hand, HandEventKind kind)
        {
            if (!m_isRemoving || hand != HandSide.Right || kind != HandEventKind.Attach)
            {
                return;
            }

            // The director has just put the real prop in the hand; the clip's own helmet would now
            // be a second one.
            if (m_riggedHelmet != null)
            {
                m_riggedHelmet.enabled = false;
            }
        }

        private void OnActionFinished(string actionId)
        {
            if (!m_isRemoving || actionId != m_actionId)
            {
                return;
            }

            m_isRemoving = false;
            m_hasRemoved = true;
            RemoveFinished?.Invoke();
        }
    }
}
