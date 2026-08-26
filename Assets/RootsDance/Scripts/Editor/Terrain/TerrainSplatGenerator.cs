using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Pure splatmap generator for the greybox terrain. Turns the warped ring radius and the lab terrace outline
    /// into normalised per-layer weights for <c>TerrainData.SetAlphamaps</c>.
    /// </summary>
    public static class TerrainSplatGenerator
    {
        /// <summary>Number of splat layers the greybox terrain uses: A, B, C, D, E.</summary>
        public const int k_LayerCount = 5;

        /// <summary>Layer index of A — Ash_Dry, the outermost ring.</summary>
        public const int k_LayerAshDry = 0;

        /// <summary>Layer index of B — Humus_Dead.</summary>
        public const int k_LayerHumusDead = 1;

        /// <summary>Layer index of C — GrassBand_Greybox.</summary>
        public const int k_LayerGrassBand = 2;

        /// <summary>Layer index of D — Stable_Soil.</summary>
        public const int k_LayerStableSoil = 3;

        /// <summary>Layer index of E — Research_Ground, the lab terrace.</summary>
        public const int k_LayerResearchGround = 4;

        /// <summary>
        /// Bakes the whole splatmap. Index order matches <c>TerrainData.SetAlphamaps</c>: the first index runs
        /// along +Z, the second along +X, the third is the layer. Weights sum to one per cell; layer order is
        /// 0 = A Ash_Dry, 1 = B Humus_Dead, 2 = C GrassBand_Greybox, 3 = D Stable_Soil, 4 = E Research_Ground.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <returns>
        /// Weights sized <c>AlphamapResolution</c> squared by <see cref="k_LayerCount"/>, or an empty map when
        /// the resolution is below one.
        /// </returns>
        public static float[,,] Generate(TerrainGreyboxParams p)
        {
            int resolution = p.AlphamapResolution;

            if (resolution < 1)
            {
                return new float[0, 0, k_LayerCount];
            }

            float[,,] alphamaps = new float[resolution, resolution, k_LayerCount];
            float stepX = p.TerrainSize.x / resolution;
            float stepZ = p.TerrainSize.z / resolution;
            float[] weights = new float[k_LayerCount];

            for (int iz = 0; iz < resolution; iz++)
            {
                float worldZ = p.TerrainPosition.z + (iz + 0.5f) * stepZ;
                for (int ix = 0; ix < resolution; ix++)
                {
                    float worldX = p.TerrainPosition.x + (ix + 0.5f) * stepX;
                    SampleWeights(p, worldX, worldZ, weights);
                    for (int layer = 0; layer < weights.Length; layer++)
                    {
                        alphamaps[iz, ix, layer] = weights[layer];
                    }
                }
            }

            return alphamaps;
        }

        /// <summary>
        /// Index of the layer with the largest weight at a world position.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <returns>The dominant layer index, 0..4.</returns>
        public static int DominantLayer(TerrainGreyboxParams p, float worldX, float worldZ)
        {
            float[] weights = new float[k_LayerCount];
            SampleWeights(p, worldX, worldZ, weights);

            int dominant = 0;
            for (int layer = 1; layer < weights.Length; layer++)
            {
                if (weights[layer] > weights[dominant])
                {
                    dominant = layer;
                }
            }

            return dominant;
        }

        /// <summary>
        /// Fills <paramref name="weights"/> with the normalised layer weights at a world position.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <param name="weights">Destination buffer of length <c>k_LayerCount</c>; overwritten.</param>
        private static void SampleWeights(TerrainGreyboxParams p, float worldX, float worldZ, float[] weights)
        {
            float radius = TerrainHeightmapGenerator.WarpedRadius(p, worldX, worldZ);
            float outsideAB = RingStep(p, radius, p.RingRadiusAB);
            float outsideBC = RingStep(p, radius, p.RingRadiusBC);
            float outsideCD = RingStep(p, radius, p.RingRadiusCD);
            float outsideDE = RingStep(p, radius, p.RingRadiusDE);

            float terrace = TerrainHeightmapGenerator.TerraceWeight(p, worldX, worldZ, p.SplatBlend);
            float ring = 1f - terrace;

            weights[k_LayerAshDry] = outsideAB * ring;
            weights[k_LayerHumusDead] = (outsideBC - outsideAB) * ring;
            weights[k_LayerGrassBand] = (outsideCD - outsideBC) * ring;
            weights[k_LayerStableSoil] = (outsideDE - outsideCD) * ring;
            weights[k_LayerResearchGround] = (1f - outsideDE) * ring + terrace;

            float sum = 0f;
            for (int layer = 0; layer < weights.Length; layer++)
            {
                if (weights[layer] < 0f)
                {
                    weights[layer] = 0f;
                }

                sum += weights[layer];
            }

            if (sum <= 0f)
            {
                weights[k_LayerResearchGround] = 1f;
                return;
            }

            for (int layer = 0; layer < weights.Length; layer++)
            {
                weights[layer] /= sum;
            }
        }

        /// <summary>
        /// Crossfade telling how far outside a ring boundary a radius sits: zero well inside, one well outside,
        /// one half exactly on the boundary.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="radius">Warped radius, in metres.</param>
        /// <param name="boundaryRadius">Ring boundary radius, in metres.</param>
        /// <returns>The crossfade value in 0..1.</returns>
        private static float RingStep(TerrainGreyboxParams p, float radius, float boundaryRadius)
        {
            if (p.SplatBlend <= 0f)
            {
                return radius >= boundaryRadius ? 1f : 0f;
            }

            return TerrainHeightmapGenerator.SmoothStep01((radius - boundaryRadius) / p.SplatBlend + 0.5f);
        }
    }
}
