using System;
using System.Collections.Generic;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Scanner;
using RootsDance.UI.Kit;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.UI
{
    /// <summary>
    /// The survey report on the scanner's screen: 遗迹环境与资源调查报告, three levels deep.
    /// <list type="bullet">
    /// <item>Level one is the report itself — one title, one close control.</item>
    /// <item>Level two is the section rail down the left edge (01 调查概况, 02, 03 …), one tab per
    /// <see cref="ScannerReportSectionSO"/>.</item>
    /// <item>Level three is the page tabs across the top, one per page of the current section, plus
    /// the arrows that step through them.</item>
    /// </list>
    /// <para>
    /// The page tabs work one of two ways, and the brief asks for both: in
    /// <see cref="PageTabMode.ArchiveCount"/> the number of tabs <i>is</i> the number of records
    /// held, so scanning a new species grows the strip by one and lights a red dot; in
    /// <see cref="PageTabMode.Decorative"/> the strip is fixed dressing and only the red dot carries
    /// meaning. The switch is a serialized field so the choice can be made by looking at it.
    /// </para>
    /// </summary>
    public class ScannerReportPresenter : MonoBehaviour, IScannerScreenView
    {
        /// <summary>What the page tabs along the top mean. See the class summary.</summary>
        public enum PageTabMode
        {
            /// <summary>One tab per record held. The strip grows as the player scans.</summary>
            ArchiveCount = 0,

            /// <summary>A fixed strip of dressing. Only the red dot reports an update.</summary>
            Decorative = 1
        }

        [Header("Level one — the report")]
        [SerializeField] private GameObject m_root;

        [SerializeField] private ThemedText m_reportTitle;

        [SerializeField] private string m_reportTitleText = "遗迹环境与资源调查报告";

        [SerializeField] private Button m_closeButton;

        [Header("Level two — sections")]
        [Tooltip("The report's sections, in the order they appear down the rail.")]
        [SerializeField] private ScannerReportSectionSO[] m_sections = Array.Empty<ScannerReportSectionSO>();

        [Tooltip("Container the section tabs are cloned into.")]
        [SerializeField] private RectTransform m_sectionRail;

        [Tooltip("Inactive tab used as the template for the rail.")]
        [SerializeField] private ScannerReportTab m_sectionTabTemplate;

        [Header("Level three — pages")]
        [Tooltip("ArchiveCount: one tab per record held. Decorative: a fixed strip, red dot only.")]
        [SerializeField] private PageTabMode m_pageTabMode = PageTabMode.ArchiveCount;

        [Tooltip("How many tabs the decorative strip draws.")]
        [Range(1, 16)]
        [SerializeField] private int m_decorativePageTabs = 6;

        [SerializeField] private RectTransform m_pageTabBar;

        [SerializeField] private ScannerReportTab m_pageTabTemplate;

        [Tooltip("The red dot next to the page strip. Lit while an unread record is held.")]
        [SerializeField] private GameObject m_updateDot;

        [Header("Page body")]
        [Tooltip("The 1.1 index box.")]
        [SerializeField] private ThemedText m_indexLabel;

        [Tooltip("The 名称 field.")]
        [SerializeField] private ThemedText m_titleLabel;

        [Tooltip("Body copy. TMP rich text, so authored highlights and underlines come through.")]
        [SerializeField] private ThemedText m_bodyLabel;

        [SerializeField] private RectTransform m_functionTabBar;

        [SerializeField] private ScannerReportTab m_functionTabTemplate;

        [Tooltip("The turning model in the left slot.")]
        [SerializeField] private ScannerPreviewSlot m_previewSlot;

        [Header("Paging")]
        [SerializeField] private Button m_previousButton;

        [SerializeField] private Button m_nextButton;

        [Tooltip("Hide the next arrow on the last page and the previous arrow on the first, as the "
            + "brief asks, instead of greying them out.")]
        [SerializeField] private bool m_hideArrowsAtEnds = true;

        [Header("Opening")]
        [Tooltip("On: the screen opens on the record that was just scanned — its section, its "
            + "page — instead of on whatever was read last. Off: it reopens where it was left.")]
        [SerializeField] private bool m_openOnLatestRecord = true;

        [Header("Listens to")]
        [SerializeField] private ReportUpdateEventChannelSO m_reportUpdated;

        private readonly List<ScannerReportSectionSO> m_visibleSections = new List<ScannerReportSectionSO>();
        private readonly List<ScannerReportPage> m_pages = new List<ScannerReportPage>();
        private readonly List<ScannerReportTab> m_sectionTabs = new List<ScannerReportTab>();
        private readonly List<ScannerReportTab> m_pageTabs = new List<ScannerReportTab>();
        private readonly List<ScannerReportTab> m_functionTabs = new List<ScannerReportTab>();

        private WorldSpaceTextMaterial m_worldSpaceText;
        private ReportEntry m_latestRecord;
        private int m_sectionIndex;
        private int m_pageIndex;
        private bool m_isOpen;
        private bool m_hasUnread;
        private bool m_hasLatestRecord;

        /// <summary>
        /// Carries "the report is closed" when <see cref="m_root"/> is this component's own
        /// object. Resolved once, because the alternative — deactivating that object — switches
        /// this presenter off for the whole of the time the player is out scanning things, which
        /// is exactly when it has to be listening. See <see cref="UiRootVisibility"/>.
        /// </summary>
        private CanvasGroup m_rootGroup;

        /// <inheritdoc />
        public event Action CloseRequested;

        /// <summary>True while the report holds a record the player has not looked at yet.</summary>
        public bool HasUnread => m_hasUnread;

        /// <summary>
        /// The section the rail is showing, by its position among the visible ones, or -1 when the
        /// report has none. Read-only and public so a test can state where the report opened —
        /// "it opens on the thing you just scanned" is the whole behaviour, and it was wrong for a
        /// long time while looking right in code.
        /// </summary>
        public int CurrentSectionIndex => m_visibleSections.Count == 0 ? -1 : m_sectionIndex;

        /// <summary>The page the report is turned to inside the current section.</summary>
        public int CurrentPageIndex => m_pageIndex;

        /// <summary>The sections currently on the rail, in rail order.</summary>
        public IReadOnlyList<ScannerReportSectionSO> VisibleSections => m_visibleSections;

        private void Awake()
        {
            if (UiRootVisibility.RootIsOwner(m_root, this))
            {
                m_rootGroup = TerminalMotion.EnsureCanvasGroup(m_root);
            }

            if (m_reportTitle != null)
            {
                m_reportTitle.Text = m_reportTitleText;
            }

            HideTemplate(m_sectionTabTemplate);
            HideTemplate(m_pageTabTemplate);
            HideTemplate(m_functionTabTemplate);

            if (m_closeButton != null)
            {
                m_closeButton.onClick.AddListener(OnCloseClicked);
            }

            if (m_previousButton != null)
            {
                m_previousButton.onClick.AddListener(OnPreviousClicked);
            }

            if (m_nextButton != null)
            {
                m_nextButton.onClick.AddListener(OnNextClicked);
            }

            SetRootActive(false);
        }

        private void OnEnable()
        {
            if (m_reportUpdated != null)
            {
                m_reportUpdated.EventRaised += OnReportUpdated;
            }
        }

        private void OnDisable()
        {
            if (m_reportUpdated != null)
            {
                m_reportUpdated.EventRaised -= OnReportUpdated;
            }
        }

        private void OnDestroy()
        {
            if (m_closeButton != null)
            {
                m_closeButton.onClick.RemoveListener(OnCloseClicked);
            }

            if (m_previousButton != null)
            {
                m_previousButton.onClick.RemoveListener(OnPreviousClicked);
            }

            if (m_nextButton != null)
            {
                m_nextButton.onClick.RemoveListener(OnNextClicked);
            }
        }

        /// <inheritdoc />
        public void Open()
        {
            m_isOpen = true;
            SetRootActive(true);
            RebuildSections();

            // The screen a scan puts up is about the thing that was just scanned. Opening it on
            // 调查概况 and leaving the player to find 03 生物记录 themselves is the report answering
            // a question nobody asked.
            if (TryShowLatestRecord())
            {
                return;
            }

            SelectSection(Mathf.Clamp(m_sectionIndex, 0, Mathf.Max(0, m_visibleSections.Count - 1)));
        }

        /// <inheritdoc />
        public void Close()
        {
            m_isOpen = false;
            SetRootActive(false);

            if (m_previewSlot != null)
            {
                m_previewSlot.Show(null);
            }
        }

        /// <summary>Shows a section by its position in the rail. Public so a debug tool can drive it.</summary>
        public void SelectSection(int index)
        {
            if (m_visibleSections.Count == 0)
            {
                m_pages.Clear();
                ShowPage(0);
                return;
            }

            m_sectionIndex = Mathf.Clamp(index, 0, m_visibleSections.Count - 1);

            for (int i = 0; i < m_sectionTabs.Count; i++)
            {
                m_sectionTabs[i].SetSelected(i == m_sectionIndex);
            }

            RebuildPages(m_visibleSections[m_sectionIndex]);
            ShowPage(0);

            // Reading a section that grows with the report is what marks the update as seen.
            if (m_visibleSections[m_sectionIndex].FeedsFromReport)
            {
                SetUnread(false);
            }
        }

        /// <summary>Shows one page of the current section.</summary>
        public void ShowPage(int index)
        {
            m_pageIndex = m_pages.Count == 0 ? 0 : Mathf.Clamp(index, 0, m_pages.Count - 1);

            ScannerReportPage page = m_pages.Count == 0 ? null : m_pages[m_pageIndex];

            if (m_indexLabel != null)
            {
                m_indexLabel.Text = page == null ? string.Empty : ResolveIndex(page, m_pageIndex);
            }

            if (m_titleLabel != null)
            {
                m_titleLabel.Text = page == null ? string.Empty : page.Title;
            }

            if (m_bodyLabel != null)
            {
                m_bodyLabel.Text = page == null ? string.Empty : page.Body;
            }

            if (m_previewSlot != null)
            {
                m_previewSlot.Show(page == null ? null : page.Preview);
            }

            RebuildFunctionTabs(page);

            for (int i = 0; i < m_pageTabs.Count; i++)
            {
                m_pageTabs[i].SetSelected(m_pageTabMode == PageTabMode.ArchiveCount && i == m_pageIndex);
            }

            UpdateArrows();
            RestoreWorldSpaceTextMaterial();
        }

        private void OnPreviousClicked()
        {
            ShowPage(m_pageIndex - 1);
        }

        private void OnNextClicked()
        {
            ShowPage(m_pageIndex + 1);
        }

        private void OnCloseClicked()
        {
            CloseRequested?.Invoke();
        }

        private void OnReportUpdated(ReportUpdate update)
        {
            SetUnread(true);

            m_latestRecord = update.Entry;
            m_hasLatestRecord = true;

            // A record arriving while the screen is open should show up on the strip immediately;
            // otherwise the rebuild happens the next time it opens.
            if (!m_isOpen)
            {
                return;
            }

            if (TryShowLatestRecord())
            {
                return;
            }

            if (m_visibleSections.Count > 0 && m_visibleSections[m_sectionIndex].FeedsFromReport)
            {
                RebuildPages(m_visibleSections[m_sectionIndex]);
                ShowPage(m_pageIndex);
            }
        }

        /// <summary>
        /// Turns the report to the record that was scanned last: its section down the rail, its
        /// own page across the top. Spends the record — a second opening with nothing new scanned
        /// comes back where the player left off, which is what re-reading the report is for.
        /// </summary>
        /// <returns>False when there is nothing pending, or no section holds that category.</returns>
        private bool TryShowLatestRecord()
        {
            if (!m_openOnLatestRecord || !m_hasLatestRecord)
            {
                return false;
            }

            int section = SectionIndexFor(m_latestRecord.Category);

            if (section < 0)
            {
                return false;
            }

            SelectSection(section);

            int page = PageIndexOf(m_latestRecord);

            if (page >= 0)
            {
                ShowPage(page);
            }

            m_hasLatestRecord = false;

            return true;
        }

        /// <summary>The visible section fed by <paramref name="category"/>, or -1.</summary>
        private int SectionIndexFor(ReportCategory category)
        {
            for (int i = 0; i < m_visibleSections.Count; i++)
            {
                ScannerReportSectionSO section = m_visibleSections[i];

                if (section.FeedsFromReport && section.Category == category)
                {
                    return i;
                }
            }

            return -1;
        }

        /// <summary>
        /// Where <paramref name="entry"/> sits among the pages of its own section. Counted the same
        /// way <see cref="RebuildPages"/> prints them — report order, that category only — so the
        /// two cannot drift apart. -1 when the entry is not in the report.
        /// </summary>
        private int PageIndexOf(ReportEntry entry)
        {
            IWorldStateReader state = WorldAccess.State;

            if (state == null)
            {
                return -1;
            }

            IReadOnlyList<ReportEntry> entries = state.Report;
            int position = 0;

            for (int i = 0; i < entries.Count; i++)
            {
                if (entries[i].Category != entry.Category)
                {
                    continue;
                }

                if (entries[i].Id == entry.Id)
                {
                    return position;
                }

                position++;
            }

            return -1;
        }

        private void SetUnread(bool unread)
        {
            m_hasUnread = unread;

            if (m_updateDot != null)
            {
                m_updateDot.SetActive(unread);
            }
        }

        /// <summary>
        /// Drops sections whose unlock flag has not been raised. Called on every open, because a
        /// flag raised between two readings has to show up on the rail.
        /// </summary>
        private void RebuildSections()
        {
            m_visibleSections.Clear();
            IWorldStateReader state = WorldAccess.State;

            for (int i = 0; i < m_sections.Length; i++)
            {
                ScannerReportSectionSO section = m_sections[i];

                if (section == null)
                {
                    continue;
                }

                string flag = section.RequiredFlag;

                if (!string.IsNullOrEmpty(flag) && (state == null || !state.HasFlag(flag)))
                {
                    continue;
                }

                m_visibleSections.Add(section);
            }

            Fill(m_sectionTabs, m_sectionTabTemplate, m_sectionRail, m_visibleSections.Count,
                index => m_visibleSections[index].TabLabel, SelectSection);
        }

        private void RebuildPages(ScannerReportSectionSO section)
        {
            m_pages.Clear();

            if (section.FeedsFromReport)
            {
                IWorldStateReader state = WorldAccess.State;

                if (state != null)
                {
                    IReadOnlyList<ReportEntry> entries = state.Report;
                    int printed = 0;

                    for (int i = 0; i < entries.Count; i++)
                    {
                        ReportEntry entry = entries[i];

                        if (entry.Category != section.Category)
                        {
                            continue;
                        }

                        printed++;
                        m_pages.Add(ScannerReportPage.FromReport(
                            section.Number + "." + printed, entry.Title, entry.Body));
                    }
                }
            }
            else
            {
                ScannerReportPage[] authored = section.Pages;

                for (int i = 0; i < authored.Length; i++)
                {
                    if (authored[i] != null)
                    {
                        m_pages.Add(authored[i]);
                    }
                }
            }

            int tabCount = m_pageTabMode == PageTabMode.ArchiveCount
                ? m_pages.Count
                : m_decorativePageTabs;

            Fill(m_pageTabs, m_pageTabTemplate, m_pageTabBar, tabCount,
                index => (index + 1).ToString(),
                m_pageTabMode == PageTabMode.ArchiveCount ? (Action<int>)ShowPage : null);
        }

        private void RebuildFunctionTabs(ScannerReportPage page)
        {
            string[] labels = page == null ? Array.Empty<string>() : page.FunctionTabs;

            Fill(m_functionTabs, m_functionTabTemplate, m_functionTabBar, labels.Length,
                index => labels[index], null);

            if (m_functionTabBar != null)
            {
                m_functionTabBar.gameObject.SetActive(labels.Length > 0);
            }

            if (labels.Length > 0 && m_functionTabs.Count > 0)
            {
                m_functionTabs[0].SetSelected(true);
            }
        }

        /// <summary>
        /// Grows or shrinks a row of tabs to <paramref name="count"/> and rebinds every one of them.
        /// Clones are kept rather than destroyed so paging through a report does not churn objects.
        /// </summary>
        private void Fill(List<ScannerReportTab> tabs, ScannerReportTab template, RectTransform parent,
            int count, Func<int, string> label, Action<int> onClicked)
        {
            if (template == null || parent == null)
            {
                return;
            }

            while (tabs.Count < count)
            {
                ScannerReportTab clone = Instantiate(template, parent);
                clone.name = template.name + tabs.Count;
                tabs.Add(clone);
            }

            for (int i = 0; i < tabs.Count; i++)
            {
                bool used = i < count;
                tabs[i].gameObject.SetActive(used);

                if (!used)
                {
                    continue;
                }

                tabs[i].Bind(i, label(i), onClicked);
                tabs[i].SetSelected(false);
                tabs[i].SetUnread(false);
            }
        }

        private string ResolveIndex(ScannerReportPage page, int position)
        {
            if (!string.IsNullOrEmpty(page.Index))
            {
                return page.Index;
            }

            string number = m_visibleSections.Count == 0
                ? "0"
                : m_visibleSections[m_sectionIndex].Number;

            return number + "." + (position + 1);
        }

        private void UpdateArrows()
        {
            bool hasPrevious = m_pageIndex > 0;
            bool hasNext = m_pageIndex < m_pages.Count - 1;

            SetArrow(m_previousButton, hasPrevious);
            SetArrow(m_nextButton, hasNext);
        }

        private void SetArrow(Button button, bool available)
        {
            if (button == null)
            {
                return;
            }

            if (m_hideArrowsAtEnds)
            {
                button.gameObject.SetActive(available);
                return;
            }

            button.interactable = available;
        }

        /// <summary>
        /// Puts the world-space text material back after a page is written.
        /// <para>
        /// Writing a label runs the theme over it, and the theme assigns its face; TextMeshPro
        /// resets a label's material whenever its font changes, so every page turn would otherwise
        /// hand the screen back to TMP's own SDF shader — which renders nothing at this canvas's
        /// scale. Resolved lazily rather than in <c>Awake</c> so the headless capture tool, which
        /// never runs one, gets the same screen a player does.
        /// </para>
        /// </summary>
        private void RestoreWorldSpaceTextMaterial()
        {
            if (m_worldSpaceText == null)
            {
                m_worldSpaceText = GetComponentInParent<WorldSpaceTextMaterial>(true);
            }

            if (m_worldSpaceText != null)
            {
                m_worldSpaceText.Apply();
            }
        }

        private void SetRootActive(bool active)
        {
            // Through the shared rule rather than a bare SetActive. This presenter's root is its
            // own GameObject, so switching it off on Close() would unsubscribe it from the report
            // channel and it would never learn what was scanned — which is what decides the
            // section and page the report opens on. See <see cref="UiRootVisibility"/>.
            UiRootVisibility.Set(m_root, this, m_rootGroup, active);
        }

        private void HideTemplate(ScannerReportTab template)
        {
            if (template != null)
            {
                template.gameObject.SetActive(false);
            }
        }
    }
}
