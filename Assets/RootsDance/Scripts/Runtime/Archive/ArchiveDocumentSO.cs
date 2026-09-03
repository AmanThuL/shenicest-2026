using RootsDance.Data;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// One sheet of the researcher's archive, authored by the designer. Programmers build the page
    /// and the reading flow once; every document in the game is one of these assets under
    /// <c>Data/Archive/</c>, dropped onto the shared page prefab.
    /// <para>
    /// The copy is bilingual by design and the two halves are not interchangeable: the Chinese
    /// block is the researcher's own hand and is what the player reads, the English block is the
    /// archive's later transcription and is set smaller, in italics, as a quotation. Keeping them
    /// as separate fields is what lets the page style them differently.
    /// </para>
    /// </summary>
    [CreateAssetMenu(fileName = "ArchiveDocument", menuName = "RootsDance/Archive/Document")]
    [TypeInfoBox("One sheet of the field archive. IDs follow PREFIX-NNN (e.g. DOC-001). The "
        + "printed archive code (S9-01) is separate — it is art on the paper, not an identifier.")]
    public class ArchiveDocumentSO : ScriptableObject
    {
        // ---- Basic Info -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Basic Info"), Required]
        [ValidateInput("IsValidId", "Use the form DOC-001.")]
        [Tooltip("Stable id used by flags and save data, for example DOC-001.")]
        private string m_id;

        [SerializeField, TitleGroup("Basic Info"), EnumToggleButtons]
        [Tooltip("Which sort of paper this is. Decides the header caption and the optional blocks.")]
        private ArchiveDocumentKind m_kind = ArchiveDocumentKind.FieldNote;

        [SerializeField, TitleGroup("Basic Info"), Required]
        [Tooltip("Chinese heading in the researcher's hand, for example 地下网络.")]
        private string m_title;

        [SerializeField, TitleGroup("Basic Info")]
        [Tooltip("English strapline under the heading, for example "
            + "'Subterranean response / field hypothesis'.")]
        private string m_subtitle;

        // ---- Interaction ------------------------------------------------------------------------
        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("Prompt shown while the sheet is focused.")]
        private string m_promptText = "[E] 拾取";

        [SerializeField, TitleGroup("Interaction")]
        [Tooltip("Width and height of the physical sheet in metres. A5 is 0.148 x 0.21.")]
        private Vector2 m_pageSizeMeters = new Vector2(0.16f, 0.21f);

        [SerializeField, TitleGroup("Interaction"), Range(0f, 1f)]
        [Tooltip("How thickly the dust lies before the player wipes it. 0 is a clean sheet.")]
        private float m_dustAmount = 0.75f;

        // ---- Conditions -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Conditions")]
        [Tooltip("World flag that has to be raised before the sheet can be picked up. Empty = always.")]
        private string m_requiredFlag;

        // ---- Result -----------------------------------------------------------------------------
        [SerializeField, TitleGroup("Result"), TextArea(1, 3)]
        [Tooltip("The handwritten Chinese body, one array entry per printed line.")]
        private string[] m_bodyLines = new string[0];

        [SerializeField, TitleGroup("Result"), TextArea(3, 8)]
        [Tooltip("The archive's English transcription, set as one italic quotation.")]
        private string m_transcription;

        [SerializeField, TitleGroup("Result")]
        [Tooltip("The researcher's own drawing, laid across the middle of a field note. Empty "
            + "leaves the sheet to its writing.")]
        private Texture2D m_diagram;

        [SerializeField, TitleGroup("Result")]
        [Tooltip("The clipped photograph on an observation record. Empty leaves the plate an "
            + "undeveloped dark exposure.")]
        private Texture2D m_photo;

        [SerializeField, TitleGroup("Result"), ReadOnly]
        [Tooltip("The whole sheet — paper and writing together — composed into one image by "
            + "RootsDance/Archive/Compose Pages. Generated: do not assign by hand. The page is "
            + "drawn from this so that the fold shader can crease the writing along with the "
            + "paper it is written on.")]
        private Texture2D m_composedPage;

        [SerializeField, TitleGroup("Result"), TextArea(1, 4)]
        [Tooltip("Text on the note taped over the sheet. Empty hides the note and its tape.")]
        private string m_marginNote;

        [SerializeField, TitleGroup("Result")]
        [Tooltip("Rubber-stamped date, for example MARCH 22 1997. Empty hides the stamp.")]
        private string m_stampText;

        [SerializeField, TitleGroup("Result")]
        [Tooltip("Signature under the clipped photograph. Empty hides both.")]
        private string m_signature;

        [SerializeField, TitleGroup("Result")]
        [Tooltip("Archive code inked in the corner, for example S9-01. Art, not an identifier.")]
        private string m_archiveCode = "S9-01";

        [SerializeField, TitleGroup("Result")]
        [Tooltip("Where the sheet was filed, printed next to the code, for example DESK.")]
        private string m_fileLocation;

        // ---- Scene Change -----------------------------------------------------------------------
        [SerializeField, TitleGroup("Scene Change")]
        [Tooltip("World flag raised once the player has read this sheet. May be empty.")]
        private string m_flagOnRead;

        [SerializeField, TitleGroup("Scene Change")]
        [Tooltip("On: the sheet is kept and disappears from the world once read. "
            + "Off: it is laid back exactly where it was found.")]
        private bool m_isCollected;

        public string Id => m_id;
        public ArchiveDocumentKind Kind => m_kind;

        /// <summary>
        /// The photograph's width over its height, or a 35 mm frame when there is no photograph
        /// to measure. A <see cref="ArchiveDocumentKind.Photograph"/> page takes its shape from it.
        /// </summary>
        public float PhotoAspect => m_photo == null || m_photo.height == 0
            ? ArchivePageLayout.k_PhotographAspect
            : (float)m_photo.width / m_photo.height;
        public string Title => m_title;
        public string Subtitle => m_subtitle;
        public string PromptText => m_promptText;
        public Vector2 PageSizeMeters => m_pageSizeMeters;
        public float DustAmount => m_dustAmount;
        public string RequiredFlag => m_requiredFlag;
        public string[] BodyLines => m_bodyLines;
        public Texture2D Diagram => m_diagram;
        public Texture2D Photo => m_photo;

        /// <summary>The whole sheet composed into one image; see the field tooltip.</summary>
        public Texture2D ComposedPage => m_composedPage;
        public string Transcription => m_transcription;
        public string MarginNote => m_marginNote;
        public string StampText => m_stampText;
        public string Signature => m_signature;
        public string ArchiveCode => m_archiveCode;
        public string FileLocation => m_fileLocation;
        public string FlagOnRead => m_flagOnRead;
        public bool IsCollected => m_isCollected;

        /// <summary>The body as one string, one line per array entry.</summary>
        public string BodyText()
        {
            // Called once per pick-up, never per frame, so the join is not a hot allocation.
            return m_bodyLines == null ? string.Empty : string.Join("\n", m_bodyLines);
        }

        [Button("Fill Id From Asset Name"), ButtonGroup("Basic Info/Tools")]
        private void FillIdFromAssetName()
        {
            // Idempotent: derives the id from the asset file name, never touches gameplay state.
            m_id = ContentId.FromAssetName(name);
        }

        // Odin calls this in the Editor with the field's current value; the rule is testable C#.
        private static bool IsValidId(string value)
        {
            return ContentId.IsValid(value);
        }
    }
}
