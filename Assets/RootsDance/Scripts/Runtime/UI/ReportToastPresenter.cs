using RootsDance.Core;
using RootsDance.Events;
using UnityEngine;
using UnityEngine.UIElements;

namespace RootsDance.UI
{
    /// <summary>
    /// The side-of-screen "官方探索报告已更新" notice of node 00-07. The design brief is explicit
    /// that the player must not be forced to open a full report panel, so this is all the feedback
    /// the first investigation gets.
    /// UXML contract: a VisualElement named "report-toast" containing Labels "report-toast__title"
    /// and "report-toast__line".
    /// </summary>
    [RequireComponent(typeof(UIDocument))]
    public class ReportToastPresenter : MonoBehaviour
    {
        private const string k_RootName = "report-toast";
        private const string k_TitleName = "report-toast__title";
        private const string k_LineName = "report-toast__line";

        [Header("Listens to")]
        [SerializeField] private ReportUpdateEventChannelSO m_reportUpdated;

        [Header("Text")]
        [SerializeField] private string m_headline = "官方探索报告已更新";

        [Tooltip("Label for the environment-sample counter.")]
        [SerializeField] private string m_sampleCounterLabel = "土壤样本";

        [Tooltip("Label for the confirmed-species counter.")]
        [SerializeField] private string m_speciesCounterLabel = "已确认物种";

        [SerializeField] private float m_visibleSeconds = 3.5f;

        private UIDocument m_document;
        private VisualElement m_root;
        private Label m_title;
        private Label m_line;
        private float m_remaining;

        private void Awake()
        {
            m_document = GetComponent<UIDocument>();
        }

        private void OnEnable()
        {
            VisualElement documentRoot = m_document.rootVisualElement;

            if (documentRoot == null)
            {
                Log.Error("ReportToastPresenter has no root visual element.", this);
                return;
            }

            m_root = documentRoot.Q<VisualElement>(k_RootName);
            m_title = documentRoot.Q<Label>(k_TitleName);
            m_line = documentRoot.Q<Label>(k_LineName);

            if (m_root == null)
            {
                Log.Error($"UXML is missing an element named '{k_RootName}'.", this);
            }

            SetVisible(false);

            if (m_reportUpdated != null)
            {
                m_reportUpdated.EventRaised += OnReportUpdated;
            }
        }

        private void Update()
        {
            if (m_remaining <= 0f)
            {
                return;
            }

            m_remaining -= Time.deltaTime;

            if (m_remaining <= 0f)
            {
                SetVisible(false);
            }
        }

        private void OnDisable()
        {
            if (m_reportUpdated != null)
            {
                m_reportUpdated.EventRaised -= OnReportUpdated;
            }
        }

        private void OnReportUpdated(ReportUpdate update)
        {
            if (m_title != null)
            {
                m_title.text = m_headline;
            }

            if (m_line != null)
            {
                m_line.text = BuildCounterLine(update.Entry.Category, update.CategoryCount);
            }

            SetVisible(true);
            m_remaining = m_visibleSeconds;
        }

        private string BuildCounterLine(ReportCategory category, int count)
        {
            string label = category == ReportCategory.BiologicalRecord
                ? m_speciesCounterLabel
                : m_sampleCounterLabel;

            return $"{label}：{count:00}";
        }

        private void SetVisible(bool isVisible)
        {
            if (m_root == null)
            {
                return;
            }

            m_root.style.display = isVisible ? DisplayStyle.Flex : DisplayStyle.None;
        }
    }
}
