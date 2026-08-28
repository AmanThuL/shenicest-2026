using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// What the pick-up-and-read flow needs from whatever draws a sheet of paper. Keeps the flow
    /// free of any UI type: gameplay hands over the content, says when the page is being read, and
    /// asks how big the sheet is so the hold pose can be worked out.
    /// </summary>
    public interface IArchiveDocumentPageView
    {
        /// <summary>Width and height of the printed sheet in metres. Drives the hold distance.</summary>
        Vector2 PageSizeMeters { get; }

        /// <summary>Puts a document's copy on the page. Called once, before the sheet is raised.</summary>
        void Bind(ArchiveDocumentSO document);

        /// <summary>
        /// The sheet is now in front of the player's face. This is where the dust comes off — the
        /// page is legible only once it has been wiped, so the reveal is part of reading it.
        /// </summary>
        void BeginReading();

        /// <summary>The sheet is going back down. The dust settles again on the next pick-up.</summary>
        void EndReading();
    }
}
