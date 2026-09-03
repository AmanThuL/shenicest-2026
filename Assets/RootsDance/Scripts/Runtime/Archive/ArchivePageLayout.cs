using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// Where everything sits on an archive sheet, in canvas units measured from the top-left corner.
    /// <para>
    /// The reference sheets are **collages, not forms**: a torn piece of paper with things laid on
    /// it at slightly wrong angles — a clipped photograph, a rubber stamp, a taped note, a code
    /// inked in the corner — and the writing sitting on pale washed patches rather than between
    /// ruled margins. So there is no frame and no header row here; there is an arrangement per
    /// <see cref="ArchiveDocumentKind"/>, because a hypothesis sheet with a drawing on it and an
    /// observation record with a photograph clipped to it are not the same object.
    /// </para>
    /// <para>
    /// Pure and static, and in the runtime assembly rather than the editor one, because the page
    /// re-places its blocks when a document is bound — one prefab serves every kind.
    /// </para>
    /// </summary>
    public static class ArchivePageLayout
    {
        public const float k_Width = 1000f;
        public const float k_Height = 1200f;

        /// <summary>Every thing that can be laid on a sheet.</summary>
        public enum Block
        {
            /// <summary>The tack holding the sheet up.</summary>
            Pin = 0,

            /// <summary>The clipped photograph.</summary>
            Photo = 1,

            /// <summary>The name written along the photograph's lower border.</summary>
            Signature = 2,

            /// <summary>The round ink stamp near the top.</summary>
            RoundStamp = 3,

            Title = 4,
            Subtitle = 5,

            /// <summary>The researcher's own drawing, when the sheet carries one.</summary>
            Diagram = 6,

            Body = 7,
            Transcription = 8,

            /// <summary>The note taped on afterwards.</summary>
            TapedNote = 9,

            /// <summary>The rubber-stamped date along the bottom.</summary>
            DateStamp = 10,

            /// <summary>The archive code inked in the corner by hand.</summary>
            ArchiveCode = 11,

            /// <summary>The dark stamp running off the bottom-right corner.</summary>
            EdgeStamp = 12,

            /// <summary>The turned-up corner of the sheet.</summary>
            CornerFold = 13
        }

        /// <summary>Every value of <see cref="Block"/>, for callers that want to walk the sheet.</summary>
        public static readonly Block[] k_AllBlocks =
        {
            Block.Pin, Block.Photo, Block.Signature, Block.RoundStamp, Block.Title, Block.Subtitle,
            Block.Diagram, Block.Body, Block.Transcription, Block.TapedNote, Block.DateStamp,
            Block.ArchiveCode, Block.EdgeStamp, Block.CornerFold
        };

        /// <summary>Every kind of sheet, for callers that want to walk the arrangements.</summary>
        public static readonly ArchiveDocumentKind[] k_AllKinds =
        {
            ArchiveDocumentKind.FieldNote,
            ArchiveDocumentKind.ObservationRecord,
            ArchiveDocumentKind.Memo,
            ArchiveDocumentKind.Photograph
        };

        /// <summary>
        /// Whether this kind of sheet carries this thing at all. A field note has a drawing on it
        /// and no photograph; an observation record is the other way round. Blocks a kind does not
        /// use are switched off, and their rectangles are never asked for.
        /// </summary>
        public static bool Uses(ArchiveDocumentKind kind, Block block)
        {
            switch (kind)
            {
                case ArchiveDocumentKind.FieldNote:
                    return block == Block.Pin || block == Block.Title || block == Block.Subtitle
                        || block == Block.Diagram || block == Block.Body
                        || block == Block.Transcription || block == Block.ArchiveCode;

                case ArchiveDocumentKind.Memo:
                    return block == Block.Title || block == Block.Body || block == Block.ArchiveCode;

                case ArchiveDocumentKind.Photograph:
                    // The page is the print and nothing else.
                    return block == Block.Photo;

                default:
                    return block != Block.Diagram;
            }
        }

        /// <summary>
        /// The thing's rectangle on this kind of sheet, x and y measured from the top-left corner.
        /// Asking for a block the kind does not use returns an empty rectangle.
        /// </summary>
        public static Rect RectOf(ArchiveDocumentKind kind, Block block)
        {
            if (!Uses(kind, block))
            {
                return Rect.zero;
            }

            switch (kind)
            {
                case ArchiveDocumentKind.FieldNote:
                    return FieldNoteRect(block);
                case ArchiveDocumentKind.Memo:
                    return MemoRect(block);
                case ArchiveDocumentKind.Photograph:
                    return PhotographRect(k_PhotographAspect);
                default:
                    return ObservationRect(block);
            }
        }

        /// <summary>
        /// How far the thing is turned on the sheet, in degrees. Nothing an archive built by hand is
        /// square with anything else; a page where every block is at zero reads as a printed form.
        /// </summary>
        public static float RollOf(Block block)
        {
            // Something written on something else is turned with it, or the name would sit askew
            // on a straight photograph.
            Block carrier = AttachedTo(block);

            switch (carrier)
            {
                case Block.Photo:        return 1.6f;
                case Block.RoundStamp:   return -8f;
                case Block.Title:        return -0.6f;
                case Block.Subtitle:     return -0.4f;
                case Block.TapedNote:    return -2.2f;
                case Block.DateStamp:    return -1.4f;
                case Block.ArchiveCode:  return 3.5f;
                case Block.EdgeStamp:    return -14f;
                default:                 return 0f;
            }
        }

        /// <summary>
        /// The hypothesis sheet: a drawing across the middle with the writing above and below it.
        /// </summary>
        private static Rect FieldNoteRect(Block block)
        {
            switch (block)
            {
                case Block.Pin:           return new Rect(474f, 26f, 56f, 56f);
                case Block.Title:         return new Rect(150f, 122f, 520f, 88f);
                case Block.Subtitle:      return new Rect(150f, 216f, 580f, 48f);
                case Block.Diagram:       return new Rect(104f, 288f, 800f, 392f);
                case Block.Body:          return new Rect(168f, 716f, 664f, 214f);
                case Block.Transcription: return new Rect(168f, 950f, 664f, 120f);
                default:                  return new Rect(104f, 1090f, 250f, 82f);
            }
        }

        /// <summary>
        /// The observation record: a photograph clipped at the top-left, the writing to the right of
        /// it, and everything the archive added afterwards along the bottom.
        /// </summary>
        private static Rect ObservationRect(Block block)
        {
            switch (block)
            {
                case Block.Pin:           return new Rect(452f, 30f, 56f, 56f);
                case Block.Photo:         return new Rect(72f, 96f, 250f, 306f);

                // On the photograph's lower border, which is the only place anyone writes on one.
                case Block.Signature:     return new Rect(88f, 336f, 218f, 44f);
                case Block.RoundStamp:    return new Rect(348f, 78f, 96f, 96f);
                case Block.Title:         return new Rect(392f, 186f, 520f, 92f);
                case Block.Subtitle:      return new Rect(392f, 282f, 520f, 52f);
                case Block.Body:          return new Rect(376f, 380f, 560f, 250f);
                case Block.Transcription: return new Rect(376f, 650f, 560f, 166f);
                case Block.TapedNote:     return new Rect(196f, 838f, 470f, 168f);
                case Block.DateStamp:     return new Rect(330f, 1044f, 370f, 50f);
                case Block.ArchiveCode:   return new Rect(72f, 1030f, 200f, 76f);
                case Block.EdgeStamp:     return new Rect(760f, 860f, 176f, 176f);
                default:                  return new Rect(872f, 1040f, 128f, 128f);
            }
        }

        /// <summary>The torn-off memo: a heading, a couple of lines, and the code.</summary>
        private static Rect MemoRect(Block block)
        {
            switch (block)
            {
                case Block.Title:       return new Rect(110f, 120f, 700f, 80f);
                case Block.Body:        return new Rect(110f, 240f, 700f, 300f);
                default:                return new Rect(110f, 600f, 250f, 76f);
            }
        }

        /// <summary>
        /// The print's own width over its height when no texture is there to measure: a 3:2 frame,
        /// which is what a 35 mm print is.
        /// </summary>
        public const float k_PhotographAspect = 1.5f;

        /// <summary>
        /// The size of the page in canvas units. Every sheet is the same sheet, except a photograph:
        /// that page is the print itself, so it is as wide as a sheet and exactly as tall as the
        /// print's aspect makes it — the exposure is never stretched to fit a page.
        /// </summary>
        public static Vector2 PageUnits(ArchiveDocumentKind kind, float photoAspect)
        {
            if (kind != ArchiveDocumentKind.Photograph)
            {
                return new Vector2(k_Width, k_Height);
            }

            float aspect = photoAspect > 0.01f ? photoAspect : k_PhotographAspect;

            return new Vector2(k_Width, k_Width / aspect);
        }

        /// <summary>The print on a photograph page: the whole page, edge to edge.</summary>
        public static Rect PhotographRect(float photoAspect)
        {
            Vector2 page = PageUnits(ArchiveDocumentKind.Photograph, photoAspect);

            return new Rect(0f, 0f, page.x, page.y);
        }

        /// <summary>
        /// The thing this block is laid on, when it is laid on another block rather than straight
        /// on the paper. The signature is written on the photograph, so the two are expected to
        /// overlap; everything else on a sheet is expected not to.
        /// </summary>
        public static Block AttachedTo(Block block)
        {
            return block == Block.Signature ? Block.Photo : block;
        }

        /// <summary>
        /// The pale washed patch the writing sits on. The reference sheets never put ink straight
        /// onto the dirty paper — every block of writing has a lighter, softer-edged patch under it,
        /// which is what keeps the text readable over the staining.
        /// </summary>
        public static Rect WashOf(ArchiveDocumentKind kind, Block block)
        {
            Rect rect = RectOf(kind, block);

            // Generous, and not centred on the writing: it was laid on by hand. A tight patch
            // reads as a printed label rather than as a wash soaked into the paper.
            return new Rect(rect.x - 34f, rect.y - 24f, rect.width + 78f, rect.height + 52f);
        }

        /// <summary>
        /// Converts a top-left rectangle into the anchored position uGUI wants for a rect anchored
        /// to its parent's top-left corner with a top-left pivot.
        /// </summary>
        public static Vector2 AnchoredPosition(Rect rect)
        {
            return new Vector2(rect.x, -rect.y);
        }

        /// <summary>Metres per canvas unit for a sheet of the given physical width.</summary>
        public static float MetresPerUnit(float pageWidthMeters)
        {
            return pageWidthMeters / k_Width;
        }
    }
}
