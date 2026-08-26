using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>Pure Terrain-detail density generator: one <c>int[z, x]</c> map per <see cref="DetailRule"/>.</summary>
    public static class TerrainDetailGenerator
    {
        private const float k_NoiseOffsetX = 33.3f;
        private const float k_NoiseOffsetZ = 8.8f;

        /// <summary>
        /// Bakes the whole detail-density map. Index order matches <c>TerrainData.SetDetailLayer</c>: the
        /// first index runs along +Z, the second along +X.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="rule">Detail rule.</param>
        /// <param name="detailResolution">Detail map resolution.</param>
        /// <returns>
        /// Instance counts sized <paramref name="detailResolution"/> squared, or an empty map when the
        /// resolution is below one.
        /// </returns>
        public static int[,] Generate(TerrainGreyboxParams p, DetailRule rule, int detailResolution)
        {
            if (p == null || rule == null || detailResolution < 1)
            {
                return new int[0, 0];
            }

            int[,] map = new int[detailResolution, detailResolution];
            float stepX = p.TerrainSize.x / detailResolution;
            float stepZ = p.TerrainSize.z / detailResolution;
            for (int iz = 0; iz < detailResolution; iz++)
            {
                float worldZ = p.TerrainPosition.z + (iz + 0.5f) * stepZ;
                for (int ix = 0; ix < detailResolution; ix++)
                {
                    float worldX = p.TerrainPosition.x + (ix + 0.5f) * stepX;
                    map[iz, ix] = CountAt(p, rule, worldX, worldZ);
                }
            }

            return map;
        }

        /// <summary>
        /// Instance count for one detail cell centred at a world position.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="rule">Detail rule.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <returns>The instance count in 0..<c>rule.MaxPerCell</c>.</returns>
        public static int CountAt(TerrainGreyboxParams p, DetailRule rule, float worldX, float worldZ)
        {
            float radius = TerrainSplatGenerator.NoisyRadius(p, worldX, worldZ);
            float band = BandWeight(radius, rule.RadiusMin, rule.RadiusMax, rule.EdgeFade);
            if (band <= 0f)
            {
                return 0;
            }

            float density = band;
            if (rule.ClumpThreshold > 0f)
            {
                float noise = Mathf.PerlinNoise(worldX * rule.ClumpFrequency + k_NoiseOffsetX,
                    worldZ * rule.ClumpFrequency + k_NoiseOffsetZ);
                density *= Mathf.Clamp01((noise - rule.ClumpThreshold) / Mathf.Max(1e-3f, 1f - rule.ClumpThreshold));
            }

            float trail = TerrainSplatGenerator.TrailWeight(p, worldX, worldZ);
            density *= Mathf.Lerp(1f, rule.TrailFactor, trail);

            if (rule.ExcludeTerrace
                && TerrainHeightmapGenerator.TerraceSignedDistance(p, worldX, worldZ) < rule.TerraceClearance)
            {
                return 0;
            }

            if (TerrainScatterGenerator.SlopeDegrees(p, worldX, worldZ) > rule.MaxSlopeDegrees)
            {
                return 0;
            }

            return Mathf.RoundToInt(density * rule.MaxPerCell);
        }

        /// <summary>
        /// Trapezoidal band weight: zero outside <paramref name="min"/>..<paramref name="max"/>, ramping to one
        /// over <paramref name="fade"/> metres at each edge.
        /// </summary>
        /// <param name="radius">Noisy warped radius, in metres.</param>
        /// <param name="min">Inclusive band minimum, in metres.</param>
        /// <param name="max">Exclusive band maximum, in metres.</param>
        /// <param name="fade">Fade width at each edge, in metres.</param>
        /// <returns>The band weight in 0..1.</returns>
        private static float BandWeight(float radius, float min, float max, float fade)
        {
            if (radius < min || radius >= max)
            {
                return 0f;
            }

            if (fade <= 0f)
            {
                return 1f;
            }

            float inner = Mathf.Clamp01((radius - min) / fade);
            float outer = Mathf.Clamp01((max - radius) / fade);
            return Mathf.Min(inner, outer);
        }
    }
}
