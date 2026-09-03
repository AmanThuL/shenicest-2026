namespace RootsDance.Archive
{
    /// <summary>
    /// What sort of paper the document is. The page prefab reads this to pick its header caption
    /// and which optional blocks (photo, stamp, margin note) it puts up.
    /// </summary>
    public enum ArchiveDocumentKind
    {
        /// <summary>研究员手记 — a loose sheet of field notes.</summary>
        FieldNote = 0,

        /// <summary>观察记录 — an observation log, usually left unfinished.</summary>
        ObservationRecord = 1,

        /// <summary>便条 — a short torn-off memo, no header furniture.</summary>
        Memo = 2,

        /// <summary>
        /// 合照 — the print itself and nothing else: no paper behind it, no pin, no stamp, no
        /// writing. Picked up and read like any other sheet, but the page *is* the photograph,
        /// at the photograph's own aspect.
        /// </summary>
        Photograph = 3
    }
}
