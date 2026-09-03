using NUnit.Framework;
using RootsDance.Archive;
using UnityEngine;
using Block = RootsDance.Archive.ArchivePageLayout.Block;

namespace RootsDance.Tests.EditMode.Archive
{
    public class ArchivePageLayoutTests
    {
        [Test]
        public void RectOf_EveryBlockOfEveryKind_StaysOnTheSheet()
        {
            ForEachUsedBlock((kind, block, rect) =>
            {
                Assert.GreaterOrEqual(rect.xMin, 0f, $"{kind}.{block} runs off the left edge.");
                Assert.GreaterOrEqual(rect.yMin, 0f, $"{kind}.{block} runs off the top edge.");
                Assert.LessOrEqual(rect.xMax, ArchivePageLayout.k_Width,
                    $"{kind}.{block} runs off the right edge.");
                Assert.LessOrEqual(rect.yMax, ArchivePageLayout.k_Height,
                    $"{kind}.{block} runs off the bottom edge.");
            });
        }

        [Test]
        public void RectOf_EveryBlockOfEveryKind_HasArea()
        {
            ForEachUsedBlock((kind, block, rect) =>
            {
                Assert.Greater(rect.width, 0f, $"{kind}.{block} has no width.");
                Assert.Greater(rect.height, 0f, $"{kind}.{block} has no height.");
            });
        }

        [Test]
        public void RectOf_NoTwoBlocksOnOneSheet_LandOnTopOfEachOther()
        {
            for (int k = 0; k < ArchivePageLayout.k_AllKinds.Length; k++)
            {
                ArchiveDocumentKind kind = ArchivePageLayout.k_AllKinds[k];
                Block[] blocks = ArchivePageLayout.k_AllBlocks;

                for (int a = 0; a < blocks.Length; a++)
                {
                    if (!ArchivePageLayout.Uses(kind, blocks[a]))
                    {
                        continue;
                    }

                    for (int b = a + 1; b < blocks.Length; b++)
                    {
                        if (!ArchivePageLayout.Uses(kind, blocks[b]))
                        {
                            continue;
                        }

                        // Something written on something else is meant to overlap it.
                        if (ArchivePageLayout.AttachedTo(blocks[a]) == blocks[b]
                            || ArchivePageLayout.AttachedTo(blocks[b]) == blocks[a])
                        {
                            continue;
                        }

                        Rect first = ArchivePageLayout.RectOf(kind, blocks[a]);
                        Rect second = ArchivePageLayout.RectOf(kind, blocks[b]);

                        Assert.IsFalse(first.Overlaps(second),
                            $"On a {kind}, {blocks[a]} and {blocks[b]} overlap.");
                    }
                }
            }
        }

        [Test]
        public void RectOf_BlockTheKindDoesNotCarry_IsEmpty()
        {
            // A field note has a drawing and no photograph; an observation record is the other way.
            Assert.IsFalse(ArchivePageLayout.Uses(ArchiveDocumentKind.FieldNote, Block.Photo));
            Assert.IsTrue(ArchivePageLayout.Uses(ArchiveDocumentKind.FieldNote, Block.Diagram));
            Assert.IsTrue(ArchivePageLayout.Uses(ArchiveDocumentKind.ObservationRecord, Block.Photo));
            Assert.IsFalse(ArchivePageLayout.Uses(ArchiveDocumentKind.ObservationRecord, Block.Diagram));

            Assert.AreEqual(Rect.zero,
                ArchivePageLayout.RectOf(ArchiveDocumentKind.FieldNote, Block.Photo));
        }

        [Test]
        public void RectOf_EveryKind_CarriesItsWritingAndItsCode()
        {
            for (int k = 0; k < ArchivePageLayout.k_AllKinds.Length; k++)
            {
                ArchiveDocumentKind kind = ArchivePageLayout.k_AllKinds[k];

                // A photograph page is the print and nothing else; nothing is written on it.
                if (kind == ArchiveDocumentKind.Photograph)
                {
                    continue;
                }

                Assert.IsTrue(ArchivePageLayout.Uses(kind, Block.Title), $"{kind} has no title.");
                Assert.IsTrue(ArchivePageLayout.Uses(kind, Block.Body), $"{kind} has no body.");
                Assert.IsTrue(ArchivePageLayout.Uses(kind, Block.ArchiveCode),
                    $"{kind} has no archive code.");
            }
        }

        [Test]
        public void Uses_Photograph_CarriesNothingButThePrint()
        {
            for (int i = 0; i < ArchivePageLayout.k_AllBlocks.Length; i++)
            {
                Block block = ArchivePageLayout.k_AllBlocks[i];

                Assert.AreEqual(block == Block.Photo,
                    ArchivePageLayout.Uses(ArchiveDocumentKind.Photograph, block),
                    $"A photograph page {(block == Block.Photo ? "is" : "is not")} the {block}.");
            }
        }

        [Test]
        public void PageUnits_Photograph_IsThePrintsOwnShape_NeverStretched()
        {
            Vector2 landscape = ArchivePageLayout.PageUnits(ArchiveDocumentKind.Photograph, 1.5f);
            Vector2 portrait = ArchivePageLayout.PageUnits(ArchiveDocumentKind.Photograph, 0.8f);
            Vector2 sheet = ArchivePageLayout.PageUnits(ArchiveDocumentKind.ObservationRecord, 1.5f);

            Assert.AreEqual(ArchivePageLayout.k_Width, landscape.x);
            Assert.AreEqual(1.5f, landscape.x / landscape.y, 0.001f);
            Assert.AreEqual(0.8f, portrait.x / portrait.y, 0.001f);
            Assert.AreEqual(new Vector2(ArchivePageLayout.k_Width, ArchivePageLayout.k_Height), sheet);

            // The print fills its page edge to edge, so there is nothing around it.
            Rect print = ArchivePageLayout.PhotographRect(1.5f);
            Assert.AreEqual(new Rect(0f, 0f, landscape.x, landscape.y), print);
            Assert.AreEqual(print, ArchivePageLayout.RectOf(ArchiveDocumentKind.Photograph, Block.Photo));
        }

        [Test]
        public void AttachedTo_SignatureSitsOnThePhotograph_AndIsInsideIt()
        {
            Assert.AreEqual(Block.Photo, ArchivePageLayout.AttachedTo(Block.Signature));

            Rect photo = ArchivePageLayout.RectOf(ArchiveDocumentKind.ObservationRecord, Block.Photo);
            Rect signature = ArchivePageLayout.RectOf(ArchiveDocumentKind.ObservationRecord,
                Block.Signature);

            Assert.GreaterOrEqual(signature.xMin, photo.xMin);
            Assert.LessOrEqual(signature.xMax, photo.xMax);
            Assert.LessOrEqual(signature.yMax, photo.yMax);
        }

        [Test]
        public void AttachedTo_EverythingElse_StandsOnThePaperItself()
        {
            for (int i = 0; i < ArchivePageLayout.k_AllBlocks.Length; i++)
            {
                Block block = ArchivePageLayout.k_AllBlocks[i];

                if (block == Block.Signature)
                {
                    continue;
                }

                Assert.AreEqual(block, ArchivePageLayout.AttachedTo(block));
            }
        }

        [Test]
        public void WashOf_AlwaysEnclosesTheWritingItSitsUnder()
        {
            ForEachUsedBlock((kind, block, rect) =>
            {
                Rect wash = ArchivePageLayout.WashOf(kind, block);

                Assert.Less(wash.xMin, rect.xMin, $"{kind}.{block}'s wash starts inside the writing.");
                Assert.Less(wash.yMin, rect.yMin, $"{kind}.{block}'s wash starts inside the writing.");
                Assert.Greater(wash.xMax, rect.xMax, $"{kind}.{block}'s wash ends inside the writing.");
                Assert.Greater(wash.yMax, rect.yMax, $"{kind}.{block}'s wash ends inside the writing.");
            });
        }

        [Test]
        public void RollOf_SomethingOnEverySheet_IsOffSquare()
        {
            // A page where every block is at zero reads as a printed form, not as a collage.
            int turned = 0;

            for (int i = 0; i < ArchivePageLayout.k_AllBlocks.Length; i++)
            {
                if (!Mathf.Approximately(ArchivePageLayout.RollOf(ArchivePageLayout.k_AllBlocks[i]), 0f))
                {
                    turned++;
                }
            }

            Assert.Greater(turned, 3);
        }

        [Test]
        public void AnchoredPosition_TopLeftRect_BecomesADownwardOffset()
        {
            // uGUI's Y grows upwards, so a block measured down from the top of the sheet is negative.
            Vector2 anchored = ArchivePageLayout.AnchoredPosition(new Rect(78f, 168f, 844f, 96f));

            Assert.AreEqual(78f, anchored.x, 1e-5f);
            Assert.AreEqual(-168f, anchored.y, 1e-5f);
        }

        [Test]
        public void MetresPerUnit_SheetOfAGivenWidth_ScalesTheCanvasToIt()
        {
            float scale = ArchivePageLayout.MetresPerUnit(0.16f);

            Assert.AreEqual(0.16f, ArchivePageLayout.k_Width * scale, 1e-6f);
            Assert.AreEqual(0.192f, ArchivePageLayout.k_Height * scale, 1e-3f);
        }

        private static void ForEachUsedBlock(System.Action<ArchiveDocumentKind, Block, Rect> check)
        {
            for (int k = 0; k < ArchivePageLayout.k_AllKinds.Length; k++)
            {
                ArchiveDocumentKind kind = ArchivePageLayout.k_AllKinds[k];

                for (int i = 0; i < ArchivePageLayout.k_AllBlocks.Length; i++)
                {
                    Block block = ArchivePageLayout.k_AllBlocks[i];

                    if (!ArchivePageLayout.Uses(kind, block))
                    {
                        continue;
                    }

                    check(kind, block, ArchivePageLayout.RectOf(kind, block));
                }
            }
        }
    }
}
