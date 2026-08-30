using NUnit.Framework;
using RootsDance.Editor.Terrain;

namespace RootsDance.Tests.EditMode.Terrain
{
    public class TerrainDetailGeneratorTests
    {
        private static DetailRule GrassRule()
        {
            return new DetailRule
            {
                Name = "GrassSilver", PrefabKey = "Grass", RadiusMin = 68f, RadiusMax = 90f,
                EdgeFade = 4f, MaxPerCell = 6, ClumpThreshold = 0f, TrailFactor = 0f,
            };
        }

        [Test]
        public void Generate_HasResolutionShape_AndValuesWithinMax()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            DetailRule rule = GrassRule();
            int[,] map = TerrainDetailGenerator.Generate(p, rule, 128);
            Assert.AreEqual(128, map.GetLength(0));
            Assert.AreEqual(128, map.GetLength(1));
            int nonZero = 0;
            for (int z = 0; z < 128; z++)
            {
                for (int x = 0; x < 128; x++)
                {
                    Assert.GreaterOrEqual(map[z, x], 0);
                    Assert.LessOrEqual(map[z, x], rule.MaxPerCell);
                    if (map[z, x] > 0) nonZero++;
                }
            }
            Assert.Greater(nonZero, 500);
        }

        [Test]
        public void CountAt_InsideBandCentre_IsMax_AndOutsideBand_IsZero()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            DetailRule rule = GrassRule();
            Assert.AreEqual(rule.MaxPerCell, TerrainDetailGenerator.CountAt(p, rule, -30f, 39f));
            Assert.AreEqual(0, TerrainDetailGenerator.CountAt(p, rule, 30f, -10f));
        }

        [Test]
        public void CountAt_OnTrail_IsZero_WhenTrailFactorIsZero()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Assert.AreEqual(0, TerrainDetailGenerator.CountAt(p, GrassRule(), -12f, 39f));
        }

        [Test]
        public void CountAt_OnTerrace_IsZero_WhenExcluded()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            DetailRule rule = GrassRule();
            rule.RadiusMin = 0f;
            Assert.AreEqual(0, TerrainDetailGenerator.CountAt(p, rule, 0f, 112f));
        }

        [Test]
        public void Generate_CellsMatchCountAt_AtTheirZThenXWorldPosition()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            DetailRule rule = GrassRule();
            rule.RadiusMin = 0f;
            rule.RadiusMax = 1000f;
            rule.ExcludeTerrace = false;
            const int resolution = 64;
            int[,] map = TerrainDetailGenerator.Generate(p, rule, resolution);

            // (1,23)/(23,1) is a confirmed asymmetric pair for this rule at this resolution (0 vs MaxPerCell,
            // in the south edge slope band); the rest sample a spread of cells for the per-cell CountAt check.
            (int iz, int ix)[] cells =
            {
                (2, 2), (61, 61), (10, 40), (40, 10), (1, 23), (23, 1),
            };

            bool foundAsymmetricPair = false;
            foreach ((int iz, int ix) in cells)
            {
                float stepX = p.TerrainSize.x / resolution;
                float stepZ = p.TerrainSize.z / resolution;
                float worldX = p.TerrainPosition.x + (ix + 0.5f) * stepX;
                float worldZ = p.TerrainPosition.z + (iz + 0.5f) * stepZ;
                Assert.AreEqual(TerrainDetailGenerator.CountAt(p, rule, worldX, worldZ), map[iz, ix],
                    $"cell ({iz},{ix})");

                if (map[iz, ix] != map[ix, iz])
                {
                    foundAsymmetricPair = true;
                }
            }

            // The ring centre sits at world Z 112, not the terrain centre, so the map is not symmetric under
            // transposition — a transposed implementation must fail at least one of the pairs above.
            Assert.IsTrue(foundAsymmetricPair, "expected at least one cell to differ from its transposed counterpart");
        }
    }
}
