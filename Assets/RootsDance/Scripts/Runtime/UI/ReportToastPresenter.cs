using RootsDance.Core;
using RootsDance.Events;
using TMPro;
using UnityEngine;

namespace RootsDance.UI
{
    /// <summary>
    /// The side-of-screen "官方探索报告已更新" notice of node 00-07. The design brief is explicit
    /// that the player must not be forced to open a full report panel, so this is all the feedback
    /// the first investigation gets.
    /// </summary>
    public class ReportToastPresenter : MonoBehaviour
    {
        [Header("Listens to")]
        [SerializeField] private ReportUpdateEventChannelSO m_reportUpdated;

        [Header("Text")]
        [SerializeField] private string m_headline = "官方探索报告已更新";

        [Tooltip("Label for the environment-sample counter.")]
        [SerializeField] private string m_sampleCounterLabel = "土壤样本";

        [Tooltip("Label for the confirmed-species counter.")]
        [SerializeField] private string m_speciesCounterLabel = "已确认物种";

        [SerializeField] private float m_visibleSeconds = 3.5f;

        [Header("Widgets")]
        [SerializeField] private GameObject m_root;
        [SerializeField] private TextMeshProUGUI m_title;
        [SerializeField] private TextMeshProUGUI m_line;

        private float m_remaining;

        private void OnEnable()
        {
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
            m_root.SetActive(isVisible);
        }
    }
}
