using NUnit.Framework;
using RootsDance.Editor.Terrain;
using UnityEngine;

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

        [TestCase(30f, -10f, 0, TestName = "wake lowland off the trail is A Ash_Dry")]
        [TestCase(-30f, 14f, 1, TestName = "valley is B Humus_Dead")]
        [TestCase(-24f, 39f, 2, TestName = "grass band is C GrassBand")]
        [TestCase(12f, 52f, 3, TestName = "saddle is D Stable_Soil")]
        [TestCase(-20f, 130f, 4, TestName = "facility terrace is E Research_Ground")]
        [TestCase(-7f, 4f, 5, TestName = "main route node is Trail")]
        [TestCase(15f, 127.8f, 5, TestName = "clue route node is Trail")]
        public void DominantLayer_SpecPoint_IsExpectedLayer(float x, float z, int expectedLayer)
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Assert.AreEqual(expectedLayer, TerrainSplatGenerator.DominantLayer(p, x, z));
        }

        [Test]
        public void TrailWeight_OnPathCentre_IsOne_AndFarAway_IsZero()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Assert.AreEqual(1f, TerrainSplatGenerator.TrailWeight(p, -7f, 4f), 1e-3f);
            Assert.AreEqual(0f, TerrainSplatGenerator.TrailWeight(p, 60f, -20f), 1e-3f);
        }

        [Test]
        public void NoisyRadius_WithZeroAmplitude_EqualsWarpedRadius()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            p.BandNoiseAmplitude = 0f;
            Assert.AreEqual(TerrainHeightmapGenerator.WarpedRadius(p, 10f, 20f),
                TerrainSplatGenerator.NoisyRadius(p, 10f, 20f), 1e-4f);
        }

        [Test]
        public void NoisyRadius_DefaultAmplitude_StaysWithinAmplitudeOfWarpedRadius()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            for (float x = -140f; x <= 140f; x += 17f)
            {
                for (float z = -30f; z <= 250f; z += 19f)
                {
                    float delta = TerrainSplatGenerator.NoisyRadius(p, x, z)
                        - TerrainHeightmapGenerator.WarpedRadius(p, x, z);
                    Assert.LessOrEqual(Mathf.Abs(delta), p.BandNoiseAmplitude + 1e-3f, $"({x},{z})");
                }
            }
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
            Assert.AreEqual("GrassBand", names[TerrainSplatGenerator.k_LayerGrassBand]);
            Assert.AreEqual("StableSoil", names[TerrainSplatGenerator.k_LayerStableSoil]);
            Assert.AreEqual("ResearchGround", names[TerrainSplatGenerator.k_LayerResearchGround]);
            Assert.AreEqual("Trail", names[TerrainSplatGenerator.k_LayerTrail]);

            // Pins TerrainLayerMaskPacker.k_LayerSources' row order to the same constants, so a 7th
            // splat layer (or a reordered table) is caught here instead of throwing IndexOutOfRange at
            // TerrainGreyboxBuilder.EnsureLayerAssets / EnsureLayerTexturesWired.
            string[,] sources = TerrainLayerMaskPacker.k_LayerSources;
            Assert.AreEqual(TerrainSplatGenerator.k_LayerCount, sources.GetLength(0));

            for (int i = 0; i < TerrainSplatGenerator.k_LayerCount; i++)
            {
                Assert.AreEqual(names[i], sources[i, 0], $"k_LayerSources row {i}");
            }
        }
    }
}
