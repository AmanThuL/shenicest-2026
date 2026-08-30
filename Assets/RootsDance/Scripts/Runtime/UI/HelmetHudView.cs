using DG.Tweening;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Player;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// Rides the visor chrome on the helmet-removal performance: when <see cref="IHelmetView"/>
    /// reports the removal starting, the visor root (frame, glass shadow, on-glass readouts) lifts
    /// up and off the screen on the same clock, the way the world would slide out from under a
    /// helmet being pulled off. Removal is a one-way door — the view starts worn and, once the
    /// event fires, the chrome leaves for good.
    /// <para>
    /// The lift deliberately starts partway through the clip — the hands reach and grip first; the
    /// visor only moves once they actually pull.
    /// </para>
    /// </summary>
    public class HelmetHudView : MonoBehaviour
    {
        [Tooltip("Component implementing IHelmetView (the arms rig's HelmetAnimatorView).")]
        [SerializeField] private MonoBehaviour m_helmetViewBehaviour;

        [Tooltip("Everything that lifts away with the helmet: frame, shadow, readouts.")]
        [SerializeField] private RectTransform m_visorRoot;

        [Tooltip("Seconds after the removal starts before the visor moves — just the first grab. "
            + "The view must clear BEFORE the helmet mesh can be seen: you cannot watch your own "
            + "helmet come off from inside it.")]
        [Range(0f, 1.5f)]
        [SerializeField] private float m_liftDelay = 0.3f;

        [Tooltip("Seconds the lift itself takes. A helmet is pulled off fast.")]
        [Range(0.1f, 1.5f)]
        [SerializeField] private float m_liftDuration = 0.4f;

        [Tooltip("Lift distance in canvas heights. > 1 clears the frame's own overshoot.")]
        [Range(0.5f, 2f)]
        [SerializeField] private float m_liftHeights = 1.2f;

        [Tooltip("Scale the chrome grows to while leaving — the curved shell passing right over "
            + "the eyes. 1 = flat-paper slide.")]
        [Range(1f, 3f)]
        [SerializeField] private float m_liftScale = 1.9f;

        [Tooltip("Backwards tilt (degrees around X) while leaving, tipping the brow away.")]
        [Range(0f, 80f)]
        [SerializeField] private float m_liftTilt = 50f;

        [SerializeField] private Ease m_ease = Ease.InQuad;

        private IHelmetView m_view;
        private Vector2 m_wornPosition;
        private Sequence m_sequence;
        private bool m_checkedInitialState;

        private void Awake()
        {
            m_view = m_helmetViewBehaviour as IHelmetView;

            // The builder wires the reference when it can, but the rig may be rebuilt, renamed or
            // inactive at build time — fall back to finding it here (initialisation only).
            if (m_view == null)
            {
                HelmetAnimatorView found =
                    FindFirstObjectByType<HelmetAnimatorView>(FindObjectsInactive.Include);
                m_view = found;

                if (found != null)
                {
                    m_helmetViewBehaviour = found;
                }
            }

            if (m_view == null)
            {
                Log.Error("HelmetHudView: no IHelmetView assigned or found in the scene; "
                    + "the visor will not react to the removal.", this);
            }

            if (m_visorRoot != null)
            {
                m_wornPosition = m_visorRoot.anchoredPosition;
            }
        }

        private void OnEnable()
        {
            if (m_view != null)
            {
                m_view.RemoveStarted += OnRemoveStarted;
            }
        }

        private void OnDisable()
        {
            if (m_view != null)
            {
                m_view.RemoveStarted -= OnRemoveStarted;
            }
        }

        private void Update()
        {
            if (m_checkedInitialState)
            {
                return;
            }

            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return;
            }

            m_checkedInitialState = true;

            if (state.HasFlag(WorldFlags.k_HelmetRemoved) && m_visorRoot != null)
            {
                m_sequence?.Kill();
                m_visorRoot.gameObject.SetActive(false);
            }
        }

        private void OnDestroy()
        {
            m_sequence?.Kill();
        }

        private void OnRemoveStarted(float duration)
        {
            if (m_visorRoot == null)
            {
                return;
            }

            m_sequence?.Kill();
            m_visorRoot.anchoredPosition = m_wornPosition;
            m_visorRoot.localScale = Vector3.one;
            m_visorRoot.localRotation = Quaternion.identity;

            // Fixed seconds, not clip fractions: the removal clip is long and slowed, but the visor
            // clears in the first beat — the rest of the performance (the helmet in the hands) is
            // watched with free eyes. Rise, swell and tip back together; the swell is what sells the
            // curved shell passing right over the face.
            float lift = m_visorRoot.rect.height * m_liftHeights;
            float delay = Mathf.Min(m_liftDelay, duration * 0.25f);

            m_sequence = DOTween.Sequence()
                .AppendInterval(delay)
                .Append(m_visorRoot
                    .DOAnchorPosY(m_wornPosition.y + lift, m_liftDuration).SetEase(m_ease))
                .Join(m_visorRoot.DOScale(m_liftScale, m_liftDuration).SetEase(m_ease))
                .Join(m_visorRoot
                    .DOLocalRotate(new Vector3(m_liftTilt, 0f, 0f), m_liftDuration).SetEase(m_ease));
        }
    }
}
