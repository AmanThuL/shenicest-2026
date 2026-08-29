using System.IO;
using NUnit.Framework;
using RootsDance.Archive;
using RootsDance.Editor.Archive;
using UnityEngine;
using UnityEngine.UI;
using Block = RootsDance.Archive.ArchivePageLayout.Block;

namespace RootsDance.Tests.EditMode.Archive
{
    /// <summary>
    /// The two things the first fold got wrong, written down so they cannot come back.
    /// <para>
    /// It creased a strip of sheet a finger wide, and it creased only the paper — the writing sat
    /// flat on top, unmoved, because the layers were folded separately instead of the page being
    /// folded as one. Both are invisible in a screenshot unless you already know to look, and both
    /// are trivially measurable. The numbers come from
    /// <c>docs/architecture/systems/纸张折痕研究.md</c>.
    /// </para>
    /// </summary>
    public class ArchiveFoldTests
    {
        /// <summary>The sheet is 0.16 m across and 0.192 m down.</summary>
        private const float k_WidthMillimetres = 160f;
        private const float k_HeightMillimetres = 192f;

        /// <summary>
        /// A crease on 80 g/m² paper is about 3.3 mm across including both shoulders. Five is the
        /// generous end of plausible; seventeen, which is what the first version drew, is a thumb.
        /// </summary>
        private const float k_MaxCreaseMillimetres = 5f;

        private static Texture2D LoadFoldField()
        {
            string path = ArchivePaperTextureBaker.k_FoldPath;
            Assert.IsTrue(File.Exists(path), $"{path} is missing; run RootsDance/Archive/Build All.");

            Texture2D field = new Texture2D(2, 2, TextureFormat.RGBA32, false);
            Assert.IsTrue(field.LoadImage(File.ReadAllBytes(path), false), "The fold field is not a PNG.");

            return field;
        }

        /// <summary>
        /// Width of the crease at one point along it, in samples, measured around where the crease
        /// actually is rather than where its nominal line is. The crease wanders by design, so a
        /// window centred on the nominal line drifts off it and measures the shoulder and the
        /// crumple instead of the fold.
        /// </summary>
        private static int CreaseSpan(Texture2D field, bool horizontal, float centre, float along)
        {
            int length = horizontal ? field.height : field.width;
            int acrossIndex = Mathf.RoundToInt(along * ((horizontal ? field.width : field.height) - 1));
            int centreIndex = DeepestIndex(field, horizontal, centre, acrossIndex);

            int window = Mathf.RoundToInt(length * 0.06f);
            int samples = window * 2 + 1;
            float[] heights = new float[samples];

            for (int i = 0; i < samples; i++)
            {
                int index = Mathf.Clamp(centreIndex - window + i, 0, length - 1);
                heights[i] = horizontal
                    ? field.GetPixel(acrossIndex, index).r
                    : field.GetPixel(index, acrossIndex).r;
            }

            // The baseline is local, and the threshold is a fraction of the crease's own depth.
            // Both matter: the sheet also carries a shallow crumple, and it is several times the
            // amplitude of a fixed small threshold — measure against a distant baseline with one
            // and the crumple gets counted as part of the fold, which reads as a 26 mm crease.
            float baseline = Median(heights);
            float peak = 0f;

            for (int i = 0; i < samples; i++)
            {
                peak = Mathf.Max(peak, Mathf.Abs(heights[i] - baseline));
            }

            if (peak < 1e-4f)
            {
                return 0;
            }

            // Full width at a fifth of the maximum: the shoulder has faded into the paper by then.
            float threshold = peak * 0.2f;
            int first = int.MaxValue;
            int last = int.MinValue;

            for (int i = 0; i < samples; i++)
            {
                if (Mathf.Abs(heights[i] - baseline) > threshold)
                {
                    first = Mathf.Min(first, i);
                    last = Mathf.Max(last, i);
                }
            }

            return last < first ? 0 : last - first + 1;
        }

        /// <summary>
        /// Index of the lowest point of the fold near its nominal line — that is, where the crease
        /// has wandered to at this point along its length.
        /// </summary>
        private static int DeepestIndex(Texture2D field, bool horizontal, float nominal, int across)
        {
            int length = horizontal ? field.height : field.width;
            int centre = Mathf.RoundToInt(nominal * (length - 1));
            int search = Mathf.RoundToInt(length * 0.03f);
            int deepest = centre;
            float lowest = float.MaxValue;

            for (int offset = -search; offset <= search; offset++)
            {
                int index = Mathf.Clamp(centre + offset, 0, length - 1);
                float height = horizontal
                    ? field.GetPixel(across, index).r
                    : field.GetPixel(index, across).r;

                if (height < lowest)
                {
                    lowest = height;
                    deepest = index;
                }
            }

            return deepest;
        }

        /// <summary>
        /// The crease's width at several points along it, in millimetres, as a median. One sample
        /// is not enough now: a fold across the grain tears the fibres in patches and all but
        /// disappears in places, and measuring a gap says nothing about how wide the fold is.
        /// </summary>
        private static float MedianCreaseMillimetres(Texture2D field, bool horizontal, float centre)
        {
            const int k_Points = 7;
            float[] widths = new float[k_Points];
            int length = horizontal ? field.height : field.width;
            float millimetres = horizontal ? k_HeightMillimetres : k_WidthMillimetres;

            for (int i = 0; i < k_Points; i++)
            {
                float along = 0.2f + 0.6f * i / (k_Points - 1f);
                widths[i] = CreaseSpan(field, horizontal, centre, along) / (float)length * millimetres;
            }

            return Median(widths);
        }

        private static float Median(float[] values)
        {
            float[] sorted = (float[])values.Clone();
            System.Array.Sort(sorted);

            return sorted[sorted.Length / 2];
        }

        [Test]
        public void FoldField_EveryCrease_IsAsNarrowAsRealPaper()
        {
            Texture2D field = LoadFoldField();

            try
            {
                // The baker walks rows bottom-up and so does Texture2D.GetPixel, so the fold at
                // v is at row v — no flip. (PIL and other top-down readers do need one.)
                float acrossA = MedianCreaseMillimetres(field, true, 0.415f);
                float acrossB = MedianCreaseMillimetres(field, true, 0.735f);
                float down = MedianCreaseMillimetres(field, false, 0.520f);

                Assert.Greater(acrossA, 0.2f, "The first fold is not in the field at all.");
                Assert.Greater(down, 0.2f, "The fold down the sheet is not in the field at all.");

                Assert.Less(acrossA, k_MaxCreaseMillimetres, $"Fold A is {acrossA:F1} mm across.");
                Assert.Less(acrossB, k_MaxCreaseMillimetres, $"Fold B is {acrossB:F1} mm across.");
                Assert.Less(down, k_MaxCreaseMillimetres, $"The fold down is {down:F1} mm across.");
            }
            finally
            {
                Object.DestroyImmediate(field);
            }
        }

        [Test]
        public void FoldField_ACrease_HasAValleyAndAShoulder()
        {
            // A fold is not a dent: the paper dips at the crease and rises either side of it. The
            // raised shoulder is the part that catches the light, and a field with only a dip in it
            // renders as a dirty line rather than as a fold.
            Texture2D field = LoadFoldField();

            try
            {
                int column = Mathf.RoundToInt(field.width * 0.25f);
                int centre = DeepestIndex(field, true, 0.415f, column);

                float valley = field.GetPixel(column, centre).r;
                float flat = field.GetPixel(column, Mathf.RoundToInt(field.height * 0.05f)).r;

                float shoulder = valley;

                for (int offset = 2; offset <= Mathf.RoundToInt(field.height * 0.02f); offset++)
                {
                    shoulder = Mathf.Max(shoulder, field.GetPixel(column, centre + offset).r);
                }

                Assert.Less(valley, flat, "The crease does not sink below the sheet.");
                Assert.Greater(shoulder, flat, "The crease has no raised shoulder beside it.");
            }
            finally
            {
                Object.DestroyImmediate(field);
            }
        }

        /// <summary>Row of the deepest point of the fold near <paramref name="at"/>, or -1.</summary>
        private static int ValleyRow(Texture2D field, int column, float at)
        {
            int centre = Mathf.RoundToInt(at * (field.height - 1));
            int window = Mathf.RoundToInt(field.height * 0.03f);
            int deepest = -1;
            float lowest = float.MaxValue;

            for (int offset = -window; offset <= window; offset++)
            {
                int row = Mathf.Clamp(centre + offset, 0, field.height - 1);
                float height = field.GetPixel(column, row).r;

                if (height < lowest)
                {
                    lowest = height;
                    deepest = row;
                }
            }

            return deepest;
        }

        [Test]
        public void FoldField_TheCrease_WandersAndVariesInDepthAlongItsLength()
        {
            // A machine crease is straight and even because a steel rule pressed it into a groove.
            // This sheet was folded by hand in the field: the line was set by eye and a thumbnail
            // run along it, and folding across the grain fractures fibres in patches rather than
            // crushing them evenly. A crease of constant depth on a perfectly straight line reads
            // as a printed rule, and would pass every other test here.
            Texture2D field = LoadFoldField();

            try
            {
                const int k_Samples = 24;
                float[] centres = new float[k_Samples];
                float[] depths = new float[k_Samples];

                for (int i = 0; i < k_Samples; i++)
                {
                    // Sampled across the middle of the sheet, clear of the fold's tapered ends.
                    float along = 0.15f + 0.70f * i / (k_Samples - 1f);
                    int column = Mathf.RoundToInt(along * (field.width - 1));
                    int row = ValleyRow(field, column, 0.415f);

                    centres[i] = row / (float)field.height * k_HeightMillimetres;
                    depths[i] = 1f - field.GetPixel(column, row).r;
                }

                float centreSpread = Spread(centres);
                Assert.Greater(centreSpread, 0.5f,
                    $"The crease wanders {centreSpread:F2} mm end to end, so it is drawn as a "
                    + "straight line. A hand fold is set by eye and never is.");

                float variation = Spread(depths) / Mathf.Max(Mean(depths), 1e-4f);
                Assert.Greater(variation, 0.15f,
                    $"The crease's depth varies by {variation:P0} along its length; a thumb does "
                    + "not press evenly and fibres tear in patches, so it should vary more.");
            }
            finally
            {
                Object.DestroyImmediate(field);
            }
        }

        private static float Mean(float[] values)
        {
            float sum = 0f;

            for (int i = 0; i < values.Length; i++)
            {
                sum += values[i];
            }

            return sum / values.Length;
        }

        /// <summary>Largest minus smallest.</summary>
        private static float Spread(float[] values)
        {
            float low = float.MaxValue;
            float high = float.MinValue;

            for (int i = 0; i < values.Length; i++)
            {
                low = Mathf.Min(low, values[i]);
                high = Mathf.Max(high, values[i]);
            }

            return high - low;
        }

        [Test]
        public void Render_TheFold_MovesTheWritingAndNotOnlyThePaper()
        {
            // The one the first version failed. Rendering with the warp switched off must change
            // the pixels *inside the body text*, because a fold deforms the sheet and the writing
            // is on the sheet. An implementation that creases only the paper leaves the writing
            // identical in both renders.
            ArchiveDocumentSO document = null;
            ArchiveDocumentSO[] documents = ArchivePageStage.LoadDocuments();

            for (int i = 0; i < documents.Length; i++)
            {
                if (documents[i].Kind == ArchiveDocumentKind.ObservationRecord)
                {
                    document = documents[i];
                }
            }

            Assert.IsNotNull(document, "No ObservationRecord document to render.");

            Texture2D folded = ArchivePageStage.Render(document, 500, 600);
            Texture2D flat = ArchivePageStage.Render(document, 500, 600, DisableWarp);

            Assert.IsNotNull(folded);
            Assert.IsNotNull(flat);

            try
            {
                Rect body = ArchivePageLayout.RectOf(ArchiveDocumentKind.ObservationRecord, Block.Body);
                float difference = MeanAbsoluteDifference(folded, flat, body);

                // The threshold has to be worth something. An earlier version of this asserted
                // >0.002, which a warp far too small to see satisfied comfortably — the test went
                // green while the fold visibly did nothing to the writing. This is set below what
                // a working warp measures and well above the noise a broken one produces.
                Assert.Greater(difference, 0.010f,
                    $"The body text differs by only {difference:F4} with the fold warp on and off, "
                    + "so the fold is creasing the paper and leaving the writing flat on top of it.");
            }
            finally
            {
                Object.DestroyImmediate(folded);
                Object.DestroyImmediate(flat);
            }
        }

        /// <summary>Switches the fold's displacement off, leaving its shading alone.</summary>
        private static void DisableWarp(GameObject instance)
        {
            Graphic[] graphics = instance.GetComponentsInChildren<Graphic>(true);
            bool found = false;

            for (int i = 0; i < graphics.Length; i++)
            {
                Material material = graphics[i].material;

                if (material != null && material.HasProperty("_WarpStrength"))
                {
                    material.SetFloat("_WarpStrength", 0f);
                    found = true;
                }
            }

            Assert.IsTrue(found, "Nothing on the sheet has a fold warp to switch off.");
        }

        /// <summary>Mean absolute luminance difference over a rectangle given in sheet units.</summary>
        private static float MeanAbsoluteDifference(Texture2D a, Texture2D b, Rect sheetRect)
        {
            int x0 = Mathf.RoundToInt(sheetRect.xMin / ArchivePageLayout.k_Width * a.width);
            int x1 = Mathf.RoundToInt(sheetRect.xMax / ArchivePageLayout.k_Width * a.width);
            int y0 = Mathf.RoundToInt((1f - sheetRect.yMax / ArchivePageLayout.k_Height) * a.height);
            int y1 = Mathf.RoundToInt((1f - sheetRect.yMin / ArchivePageLayout.k_Height) * a.height);

            float sum = 0f;
            int count = 0;

            for (int y = Mathf.Max(y0, 0); y <= Mathf.Min(y1, a.height - 1); y++)
            {
                for (int x = Mathf.Max(x0, 0); x <= Mathf.Min(x1, a.width - 1); x++)
                {
                    sum += Mathf.Abs(ArchivePageStage.Luma(a.GetPixel(x, y))
                        - ArchivePageStage.Luma(b.GetPixel(x, y)));
                    count++;
                }
            }

            return count == 0 ? 0f : sum / count;
        }
    }
}
