using System;
using System.Threading;
using RootsDance.Core;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Block = RootsDance.Archive.ArchivePageLayout.Block;

namespace RootsDance.Archive
{
    /// <summary>
    /// Draws one sheet of the archive on a world-space canvas.
    /// <para>
    /// The reference sheets are collages: a torn piece of paper with a photograph clipped to it, a
    /// stamp banged on it, a note taped over it and the writing sitting on pale washed patches. So
    /// this does not lay out a form — it takes the arrangement for the document's kind out of
    /// <see cref="ArchivePageLayout"/>, moves each thing to its place, turns it a degree or two off
    /// square, and switches off everything the document has no content for. One prefab, every sheet.
    /// </para>
    /// <para>
    /// The paper the collage sits on is a **lit** surface behind this canvas, not a graphic in it:
    /// HDRP shades a canvas Unlit and nothing changes that, so the object's face is a real material
    /// that takes the flashlight and only the ink is drawn here. See
    /// <see cref="ArchivePaperLighting"/> for how the ink is kept in step with it.
    /// </para>
    /// </summary>
    [DisallowMultipleComponent]
    public class ArchiveDocumentPageView : MonoBehaviour, IArchiveDocumentPageView
    {
        [Header("Sheet")]
        [Tooltip("The rect of the printed sheet. Its world size is the page's physical size.")]
        [SerializeField] private RectTransform m_page;

        [Tooltip("The one layer visible at run time: the whole page as one image, drawn by the "
            + "fold shader so the crease deforms the writing along with the paper.")]
        [SerializeField] private RawImage m_composite;

        [Tooltip("The layers the composed page is baked from. Off at run time — they exist so the "
            + "page can be re-composed when the copy changes, and so the layout stays inspectable.")]
        [SerializeField] private GameObject m_layers;

        [Tooltip("Every thing that can be laid on the sheet, with the wash that goes under it.")]
        [SerializeField] private ArchivePageBlock[] m_blocks = Array.Empty<ArchivePageBlock>();

        [Header("Writing")]
        [SerializeField] private TextMeshProUGUI m_title;
        [SerializeField] private TextMeshProUGUI m_subtitle;

        [Tooltip("The researcher's own hand. One printed line per array entry on the document.")]
        [SerializeField] private TextMeshProUGUI m_body;

        [Tooltip("The archive's later English transcription, set as a small italic quotation.")]
        [SerializeField] private TextMeshProUGUI m_transcription;

        [Tooltip("Text on the note taped over the sheet.")]
        [SerializeField] private TextMeshProUGUI m_tapedNote;

        [Tooltip("The rubber-stamped date along the bottom.")]
        [SerializeField] private TextMeshProUGUI m_dateStamp;

        [Tooltip("The name written along the photograph's lower border.")]
        [SerializeField] private TextMeshProUGUI m_signature;

        [Tooltip("The archive code inked in the corner by hand.")]
        [SerializeField] private TextMeshProUGUI m_archiveCode;

        [Header("Images")]
        [Tooltip("The researcher's drawing, when the sheet carries one.")]
        [SerializeField] private RawImage m_diagram;

        [Tooltip("The exposure inside the clipped photograph. Left untouched — an undeveloped "
            + "dark plate — when the document has no photo of its own.")]
        [SerializeField] private RawImage m_photo;

        [Tooltip("The paper the collage is baked onto. Off for a photograph: that page is the print.")]
        [SerializeField] private RawImage m_paper;

        [Tooltip("The cream card the exposure is sunk into. Off for a photograph, whose exposure "
            + "is the whole page.")]
        [SerializeField] private RawImage m_photoCard;

        [Tooltip("The paperclip holding the photograph to a sheet. Off for a photograph.")]
        [SerializeField] private RawImage m_photoClip;

        [Tooltip("The grime layer over the whole sheet, wiped off when the sheet is raised.")]
        [SerializeField] private Graphic m_dustOverlay;

        [Tooltip("Seconds the dust takes to come off once the sheet is up.")]
        [Range(0.05f, 4f)]
        [SerializeField] private float m_dustClearSeconds = 0.8f;

        /// <summary>
        /// How far the exposure sits inside its card on a sheet: a thin border on three sides and
        /// the deep one along the bottom that a Polaroid is written on. Bottom-left and top-right
        /// offsets of a stretched rect. The prefab builder lays the card out with the same numbers.
        /// </summary>
        public static readonly Vector2 k_ExposureOffsetMin = new Vector2(14f, 62f);
        public static readonly Vector2 k_ExposureOffsetMax = new Vector2(-14f, -14f);

        private ArchiveDocumentSO m_document;
        private float m_dustAmount;
        private bool m_isWiped;

        /// <summary>
        /// Physical size of the sheet, measured off the rect rather than authored twice. A world-
        /// space canvas rect's world size is its rect size times the canvas scale.
        /// </summary>
        public Vector2 PageSizeMeters
        {
            get
            {
                if (m_page == null)
                {
                    return new Vector2(0.16f, 0.192f);
                }

                Vector3 scale = m_page.lossyScale;

                return new Vector2(
                    Mathf.Abs(m_page.rect.width * scale.x),
                    Mathf.Abs(m_page.rect.height * scale.y));
            }
        }

        public void Bind(ArchiveDocumentSO document)
        {
            if (document == null)
            {
                Log.Error("ArchiveDocumentPageView was bound to a null document.", this);
                return;
            }

            m_document = document;

            SetText(m_title, document.Title);
            SetText(m_subtitle, document.Subtitle);
            SetText(m_body, document.BodyText());
            SetText(m_transcription, Quote(document.Transcription));
            SetText(m_tapedNote, document.MarginNote);
            SetText(m_dateStamp, document.StampText);
            SetText(m_signature, document.Signature);
            SetText(m_archiveCode, document.ArchiveCode);

            if (m_diagram != null)
            {
                m_diagram.texture = document.Diagram;
            }

            if (m_photo != null && document.Photo != null)
            {
                m_photo.texture = document.Photo;
                m_photo.color = Color.white;
            }

            ShapePage(document);
            Arrange(document);
            ShowComposedPage(document);

            m_dustAmount = Mathf.Clamp01(document.DustAmount);
            m_isWiped = false;
            SetDust(m_dustAmount);
        }

        public void BeginReading()
        {
            if (m_isWiped || m_dustOverlay == null)
            {
                return;
            }

            m_isWiped = true;
            WipeDustEntryAsync(destroyCancellationToken);
        }

        public void EndReading()
        {
            // Nothing to do: dust does not come back. Once a sheet has been wiped it stays legible,
            // so a second look is never a second chore.
        }

        /// <summary>
        /// Puts up the composed page and takes the layers it was baked from down.
        /// <para>
        /// A crease deforms the sheet, and the writing is on the sheet — so the fold has to move
        /// the writing too. It can only do that to something already flattened: the writing is
        /// drawn by TextMeshPro's own material, which the fold shader cannot reach, and a uGUI
        /// graphic has four vertices with nothing to displace. See
        /// <c>docs/architecture/systems/纸张折痕研究.md</c> §5.
        /// </para>
        /// </summary>
        private void ShowComposedPage(ArchiveDocumentSO document)
        {
            if (m_composite == null)
            {
                return;
            }

            Texture2D composed = document.ComposedPage;

            if (composed == null)
            {
                // Falling back to the layers keeps the page readable, but the fold will only crease
                // the paper — which is the bug this whole arrangement exists to avoid.
                Log.Warning($"'{document.Id}' has no composed page; run RootsDance/Archive/"
                    + "Compose Pages. The fold will not crease the writing until it is composed.",
                    this);
                m_composite.gameObject.SetActive(false);
                SetActive(m_layers, true);
                return;
            }

            m_composite.texture = composed;
            m_composite.gameObject.SetActive(true);
            SetActive(m_layers, false);
        }

        /// <summary>
        /// Puts the layers back up and takes the composed page down, so the page can be re-baked.
        /// Editor-side only: nothing in a running game composes a sheet.
        /// </summary>
        public void ShowLayersForComposing()
        {
            SetActive(m_layers, true);

            if (m_composite != null)
            {
                m_composite.gameObject.SetActive(false);
            }
        }

        /// <summary>
        /// Gives the page its shape. Every sheet is the same sheet; a photograph page is the print
        /// itself and nothing else — no paper under it, no dust over it, no card round the
        /// exposure — at the print's own aspect, so the exposure is never stretched.
        /// </summary>
        private void ShapePage(ArchiveDocumentSO document)
        {
            bool isPrint = document.Kind == ArchiveDocumentKind.Photograph;

            if (m_page != null)
            {
                m_page.sizeDelta = ArchivePageLayout.PageUnits(document.Kind, document.PhotoAspect);
            }

            if (m_paper != null)
            {
                m_paper.gameObject.SetActive(!isPrint);
            }

            if (m_photoClip != null)
            {
                m_photoClip.gameObject.SetActive(!isPrint);
            }

            if (m_photoCard != null)
            {
                // The card's own image goes, not its object: the exposure hangs off it.
                m_photoCard.enabled = !isPrint;
            }

            if (m_dustOverlay != null)
            {
                m_dustOverlay.gameObject.SetActive(!isPrint);
            }

            if (m_photo != null)
            {
                RectTransform exposure = m_photo.rectTransform;
                exposure.anchorMin = Vector2.zero;
                exposure.anchorMax = Vector2.one;
                exposure.pivot = new Vector2(0.5f, 0.5f);
                exposure.offsetMin = isPrint ? Vector2.zero : k_ExposureOffsetMin;
                exposure.offsetMax = isPrint ? Vector2.zero : k_ExposureOffsetMax;
            }
        }

        /// <summary>
        /// Moves every thing on the sheet to its place for this kind of document, and switches off
        /// the ones this kind does not carry or this document has nothing to put in.
        /// </summary>
        private void Arrange(ArchiveDocumentSO document)
        {
            ArchiveDocumentKind kind = document.Kind;
            bool isPrint = kind == ArchiveDocumentKind.Photograph;

            for (int i = 0; i < m_blocks.Length; i++)
            {
                ArchivePageBlock binding = m_blocks[i];

                if (binding == null || binding.Target == null)
                {
                    continue;
                }

                Block block = binding.Block;
                bool isUsed = ArchivePageLayout.Uses(kind, block) && HasContentFor(block);

                binding.Target.gameObject.SetActive(isUsed);

                if (binding.Wash != null)
                {
                    binding.Wash.gameObject.SetActive(isUsed);
                }

                if (!isUsed)
                {
                    continue;
                }

                // On a print the photograph is the page: edge to edge, and not turned on it.
                Rect rect = isPrint
                    ? ArchivePageLayout.PhotographRect(document.PhotoAspect)
                    : ArchivePageLayout.RectOf(kind, block);
                float roll = isPrint ? 0f : ArchivePageLayout.RollOf(block);

                Place(binding.Target, rect, roll);

                if (binding.Wash != null)
                {
                    // The wash was laid on by hand and is not square with the writing on it.
                    Place(binding.Wash, ArchivePageLayout.WashOf(kind, block),
                        roll * 0.6f - 0.8f);
                }
            }
        }

        private static void Place(RectTransform rect, Rect layout, float rollDegrees)
        {
            rect.anchorMin = new Vector2(0f, 1f);
            rect.anchorMax = new Vector2(0f, 1f);
            rect.pivot = new Vector2(0f, 1f);
            rect.anchoredPosition = ArchivePageLayout.AnchoredPosition(layout);
            rect.sizeDelta = layout.size;
            rect.localRotation = Quaternion.Euler(0f, 0f, rollDegrees);
        }

        /// <summary>
        /// Whether this document has anything to put in this block. A block whose only content is
        /// empty is switched off rather than left as a blank box: an empty stamp outline on an
        /// archive sheet reads as a bug, not as a blank.
        /// </summary>
        private bool HasContentFor(Block block)
        {
            switch (block)
            {
                case Block.Photo:
                    return m_document.Photo != null || !string.IsNullOrEmpty(m_document.Signature);
                case Block.Signature:
                    return !string.IsNullOrEmpty(m_document.Signature);
                case Block.TapedNote:
                    return !string.IsNullOrEmpty(m_document.MarginNote);
                case Block.DateStamp:
                    return !string.IsNullOrEmpty(m_document.StampText);
                case Block.ArchiveCode:
                    return !string.IsNullOrEmpty(m_document.ArchiveCode);
                case Block.Subtitle:
                    return !string.IsNullOrEmpty(m_document.Subtitle);
                case Block.Transcription:
                    return !string.IsNullOrEmpty(m_document.Transcription);
                case Block.Diagram:
                    return m_document.Diagram != null;
                case Block.Body:
                    return !string.IsNullOrEmpty(m_document.BodyText());
                default:
                    // The pin, the stamps and the turned-up corner are the paper's own furniture;
                    // whether they appear is the arrangement's business, not the copy's.
                    return true;
            }
        }

        /// <summary>
        /// Fire-and-forget entry point: an un-awaited <c>async Awaitable</c> swallows its
        /// exceptions, so the body is wrapped here (guideline 04).
        /// </summary>
        private async void WipeDustEntryAsync(CancellationToken cancellationToken)
        {
            try
            {
                float from = m_dustAmount;

                for (float elapsed = 0f; elapsed < m_dustClearSeconds; elapsed += Time.deltaTime)
                {
                    SetDust(Mathf.Lerp(from, 0f, elapsed / m_dustClearSeconds));
                    await Awaitable.NextFrameAsync(cancellationToken);
                }

                SetDust(0f);
            }
            catch (OperationCanceledException)
            {
                // The sheet was destroyed mid-wipe; there is nothing left to clean.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private void SetDust(float alpha)
        {
            if (m_dustOverlay == null)
            {
                return;
            }

            Color color = m_dustOverlay.color;
            color.a = Mathf.Clamp01(alpha);
            m_dustOverlay.color = color;
        }

        /// <summary>Wraps the transcription in the curly quotes the archive prints it with.</summary>
        private static string Quote(string text)
        {
            return string.IsNullOrEmpty(text) ? string.Empty : "“" + text + "”";
        }

        private static void SetActive(GameObject target, bool isActive)
        {
            if (target != null && target.activeSelf != isActive)
            {
                target.SetActive(isActive);
            }
        }

        private static void SetText(TextMeshProUGUI label, string text)
        {
            if (label != null)
            {
                label.text = text == null ? string.Empty : text;
            }
        }
    }
}
