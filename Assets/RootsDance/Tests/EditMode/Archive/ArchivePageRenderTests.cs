using NUnit.Framework;
using RootsDance.Archive;
using RootsDance.Editor.Archive;
using UnityEngine;
using Block = RootsDance.Archive.ArchivePageLayout.Block;

namespace RootsDance.Tests.EditMode.Archive
{
    /// <summary>
    /// The sheet actually draws. A page that renders nothing is indistinguishable from a page that
    /// is not there, and the difference is invisible in a screenshot once exposure is wrong — which
    /// is exactly how a perfectly good page was twice mistaken for a shader fault here. These
    /// assert on <b>linear radiance</b> at places whose answer is known in advance, and they compare
    /// regions against each other rather than against absolute values. Both of those matter: an
    /// 8-bit readback clips two different regions to the same white and the comparison silently
    /// becomes a test of nothing.
    /// </summary>
    public class ArchivePageRenderTests
    {
        private const int k_Width = 400;
        private const int k_Height = 480;

        private static ArchiveDocumentSO ObservationRecord()
        {
            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();

            for (int i = 0; i < documents.Length; i++)
            {
                if (documents[i].Kind == ArchiveDocumentKind.ObservationRecord)
                {
                    return documents[i];
                }
            }

            Assert.Fail("No ObservationRecord document under Data/Archive/ to render.");

            return null;
        }

        /// <summary>
        /// The finished render leaves a margin of air round the sheet, so a point on the sheet is
        /// not the same fraction of the image. Sampling without this reads off the edge of the
        /// paper and into the torn-away corner.
        /// </summary>
        private const float k_StageMargin = 1.06f;

        private static float ToImage(float sheetFraction)
        {
            return 0.5f + (sheetFraction - 0.5f) / k_StageMargin;
        }

        /// <summary>Mean colour over a small patch, sampled at a point on the sheet in 0..1.</summary>
        private static Color Patch(Texture2D image, float u, float v)
        {
            int cx = Mathf.RoundToInt(ToImage(u) * image.width);
            int cy = Mathf.RoundToInt((1f - ToImage(v)) * image.height);
            const int k_Radius = 4;
            Color sum = Color.black;
            int count = 0;

            for (int y = cy - k_Radius; y <= cy + k_Radius; y++)
            {
                for (int x = cx - k_Radius; x <= cx + k_Radius; x++)
                {
                    sum += image.GetPixel(Mathf.Clamp(x, 0, image.width - 1),
                        Mathf.Clamp(y, 0, image.height - 1));
                    count++;
                }
            }

            return sum / count;
        }

        private static float Luma(Color color)
        {
            return ArchivePageStage.Luma(color);
        }

        /// <summary>The centre of a block, as a fraction of the sheet.</summary>
        private static Vector2 Centre(Block block)
        {
            Rect rect = ArchivePageLayout.RectOf(ArchiveDocumentKind.ObservationRecord, block);

            return new Vector2((rect.x + rect.width * 0.5f) / ArchivePageLayout.k_Width,
                (rect.y + rect.height * 0.5f) / ArchivePageLayout.k_Height);
        }

        [Test]
        public void Render_TheSheet_IsNotTheEmptyBackdrop()
        {
            Texture2D image = ArchivePageStage.Render(ObservationRecord(), k_Width, k_Height);
            Assert.IsNotNull(image, "The page stage rendered nothing at all.");

            try
            {
                Color paper = Patch(image, 0.16f, 0.62f);
                Color backdrop = ArchivePageStage.Backdrop;

                // The middle of the sheet is paper, and paper is much brighter than the backdrop.
                Assert.Greater(Luma(paper), Luma(backdrop) * 2f,
                    $"The middle of the sheet came back as {paper}, which is the empty backdrop — "
                    + "the paper surface is not drawing.");
            }
            finally
            {
                Object.DestroyImmediate(image);
            }
        }

        [Test]
        public void Render_ThePhotograph_IsDarkerThanThePaperAroundIt()
        {
            Texture2D image = ArchivePageStage.Render(ObservationRecord(), k_Width, k_Height);
            Assert.IsNotNull(image);

            try
            {
                Vector2 photo = Centre(Block.Photo);
                Color exposure = Patch(image, photo.x, photo.y);

                // Bare paper: down the left margin, below the photograph and above the taped note,
                // where the observation record's layout puts nothing at all.
                Color paper = Patch(image, 0.16f, 0.62f);

                // The exposure on the Polaroid is nearly black; bare paper is not. If the canvas
                // graphics were not drawing, these two would read the same.
                Assert.Less(Luma(exposure), Luma(paper) * 0.6f,
                    $"The photograph read {exposure} against paper at {paper}; the canvas "
                    + "graphics are not drawing over the paper.");
            }
            finally
            {
                Object.DestroyImmediate(image);
            }
        }

        [Test]
        public void Render_TheWashes_LightenThePaperUnderTheWriting()
        {
            // Checked while composing, because that is where the washes are still their own layer:
            // the finished sheet is one flattened image, and the washes are already in it.
            ArchiveDocumentSO document = ObservationRecord();
            Texture2D with = ArchivePageStage.Render(document, k_Width, k_Height,
                ArchivePageStage.RenderMode.ComposeFlat, null);
            Texture2D without = ArchivePageStage.Render(document, k_Width, k_Height,
                ArchivePageStage.RenderMode.ComposeFlat, HideWashes);

            Assert.IsNotNull(with);
            Assert.IsNotNull(without);

            try
            {
                Rect wash = ArchivePageLayout.WashOf(ArchiveDocumentKind.ObservationRecord, Block.Body);
                float lit = MeanLuma(with, wash);
                float bare = MeanLuma(without, wash);

                Assert.Greater(lit, bare * 1.05f,
                    $"With the washes the body area read {lit:F3} and without them {bare:F3}; the "
                    + "pale patches the writing sits on are not drawing.");
            }
            finally
            {
                Object.DestroyImmediate(with);
                Object.DestroyImmediate(without);
            }
        }

        /// <summary>Switches off every wash on a live instance, leaving the writing on it.</summary>
        private static void HideWashes(GameObject instance)
        {
            Transform washes = instance.transform.Find("Sheet/Layers/Washes");
            Assert.IsNotNull(washes, "The page prefab has no Washes group any more.");
            washes.gameObject.SetActive(false);
        }

        /// <summary>Mean luminance over a rectangle given in sheet units.</summary>
        private static float MeanLuma(Texture2D image, Rect sheetRect)
        {
            int x0 = Mathf.Clamp(Mathf.RoundToInt(sheetRect.xMin / ArchivePageLayout.k_Width
                * image.width), 0, image.width - 1);
            int x1 = Mathf.Clamp(Mathf.RoundToInt(sheetRect.xMax / ArchivePageLayout.k_Width
                * image.width), 0, image.width - 1);
            int y0 = Mathf.Clamp(Mathf.RoundToInt((1f - sheetRect.yMax / ArchivePageLayout.k_Height)
                * image.height), 0, image.height - 1);
            int y1 = Mathf.Clamp(Mathf.RoundToInt((1f - sheetRect.yMin / ArchivePageLayout.k_Height)
                * image.height), 0, image.height - 1);

            float sum = 0f;
            int count = 0;

            for (int y = y0; y <= y1; y++)
            {
                for (int x = x0; x <= x1; x++)
                {
                    sum += Luma(image.GetPixel(x, y));
                    count++;
                }
            }

            return count == 0 ? 0f : sum / count;
        }

        [Test]
        public void Render_OffTheTornEdge_IsTheBackdrop()
        {
            Texture2D image = ArchivePageStage.Render(ObservationRecord(), k_Width, k_Height);
            Assert.IsNotNull(image);

            try
            {
                // The very corner is outside the sheet's torn silhouette, so the alpha clip has to
                // have cut it away. A rectangular sheet would fail this.
                Color corner = Patch(image, 0.012f, 0.012f);

                Assert.Less(Luma(corner), Luma(ArchivePageStage.Backdrop) * 1.5f,
                    $"The corner read {corner}; the paper is not being clipped to a torn edge.");
            }
            finally
            {
                Object.DestroyImmediate(image);
            }
        }
    }
}
