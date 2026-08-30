using RootsDance.App;
using RootsDance.Core;
using RootsDance.Interaction;
using UnityEngine;

namespace RootsDance.Investigation
{
    /// <summary>
    /// Puts an <see cref="InvestigationTargetSO"/> into the world. Focus feedback and the tool
    /// performance are delegated to art-side components through interfaces; this class only decides
    /// when the result is submitted.
    /// </summary>
    public class InvestigatableTarget : MonoBehaviour, IInteractable
    {
        [SerializeField] private InvestigationTargetSO m_target;

        [Tooltip("Off for scenery that answers 不可采样 / 不可识别 instead of producing a record.")]
        [SerializeField] private bool m_isInvestigable = true;

        [Tooltip("Shown when the object is not investigable.")]
        [SerializeField] private string m_refusalText = "不可采样";

        [Tooltip("Optional art component implementing IInteractableView (light mote, highlight).")]
        [SerializeField] private MonoBehaviour m_viewBehaviour;

        [Tooltip("Optional art component implementing IToolView (sampler animation). Empty = instant.")]
        [SerializeField] private MonoBehaviour m_toolViewBehaviour;

        private IInteractableView m_view;
        private IToolView m_toolView;
        private bool m_isRecorded;

        public string PromptText
        {
            get
            {
                if (!m_isInvestigable)
                {
                    return "调查";
                }

                return m_target == null ? "调查" : m_target.PromptText;
            }
        }

        public bool CanInteract => !m_isRecorded;

        private void Awake()
        {
            m_view = m_viewBehaviour as IInteractableView;
            m_toolView = m_toolViewBehaviour as IToolView;
        }

        private void Start()
        {
            // Only touches our own view; no bootstrap access here.
            if (m_view != null)
            {
                m_view.SetInvestigated(false);
            }
        }

        public void Interact(GameObject interactor)
        {
            if (m_isRecorded)
            {
                return;
            }

            ToolUseController toolUse = interactor.GetComponentInParent<ToolUseController>();
            InvestigationService service = interactor.GetComponentInParent<InvestigationService>();

            if (service == null)
            {
                Log.Error("No InvestigationService found on the interactor.", this);
                return;
            }

            if (!m_isInvestigable)
            {
                service.Refuse(m_refusalText);
                return;
            }

            if (m_target == null)
            {
                Log.Error("InvestigatableTarget has no target asset.", this);
                return;
            }

            if (toolUse == null)
            {
                Complete(service);
                return;
            }

            toolUse.TryUse(m_toolView, () => Complete(service));
        }

        private void Complete(InvestigationService service)
        {
            // The state check protects against a tool view that fires UseFinished more than once.
            if (m_isRecorded)
            {
                return;
            }

            m_isRecorded = true;
            service.Submit(m_target);

            if (m_view != null)
            {
                m_view.SetFocused(false);
                m_view.SetInvestigated(true);
            }
        }
    }
}
