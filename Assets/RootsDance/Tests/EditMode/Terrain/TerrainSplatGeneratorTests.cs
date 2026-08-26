using NUnit.Framework;
using RootsDance.Editor.Terrain;

namespace RootsDance.Tests.EditMode.Terrain
{
    public class TerrainSplatGeneratorTests
    {
        [Test]
        public void Generate_DefaultParams_WeightsSumToOne()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            float[,,] maps = TerrainSplatGenerator.Generate(p);
            Assert.AreEqual(p.AlphamapResolution, maps.GetLength(0));
            Assert.AreEqual(TerrainSplatGenerator.k_LayerCount, maps.GetLength(2));
            for (int iz = 0; iz < maps.GetLength(0); iz += 37)
            {
                for (int ix = 0; ix < maps.GetLength(1); ix += 41)
                {
                    float sum = 0f;

                    for (int l = 0; l < maps.GetLength(2); l++)
                    {
                        sum += maps[iz, ix, l];
                    }

                    Assert.AreEqual(1f, sum, 1e-3f, $"cell {iz},{ix}");
                }
            }
        }

        [TestCase(0f, -10f, 0, TestName = "wake is A Ash_Dry")]
        [TestCase(-14f, 14f, 1, TestName = "valley is B Humus_Dead")]
        [TestCase(-12f, 39f, 2, TestName = "grass platform is C GrassBand")]
        [TestCase(0f, 52f, 3, TestName = "saddle is D Stable_Soil")]
        [TestCase(0f, 112f, 4, TestName = "lab centre is E Research_Ground")]
        public void DominantLayer_SpecAnchor_IsExpectedRing(float x, float z, int expectedLayer)
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Assert.AreEqual(expectedLayer, TerrainSplatGenerator.DominantLayer(p, x, z));
        }

        /// <summary>
        /// The builder indexes its layer name and colour tables with the constants above, so a table that
        /// drifted out of order would paint every ring with the wrong texture.
        /// </summary>
        [Test]
        public void LayerTables_MatchSplatLayerConstants()
        {
            string[] names = TerrainGreyboxBuilder.k_LayerNames;

            Assert.AreEqual(TerrainSplatGenerator.k_LayerCount, names.Length);
            Assert.AreEqual(TerrainSplatGenerator.k_LayerCount, TerrainGreyboxBuilder.k_LayerColors.Length);
            Assert.AreEqual("AshDry", names[TerrainSplatGenerator.k_LayerAshDry]);
            Assert.AreEqual("HumusDead", names[TerrainSplatGenerator.k_LayerHumusDead]);
            Assert.AreEqual("GrassBandGreybox", names[TerrainSplatGenerator.k_LayerGrassBand]);
            Assert.AreEqual("StableSoil", names[TerrainSplatGenerator.k_LayerStableSoil]);
            Assert.AreEqual("ResearchGround", names[TerrainSplatGenerator.k_LayerResearchGround]);
        }
    }
}
