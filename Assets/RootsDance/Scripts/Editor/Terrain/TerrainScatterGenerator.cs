using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Pure, seeded scatter: jittered grid over the terrain, one candidate per cell, rejected by band, optional
    /// disc limit, trail, terrace, flat spots, slope, edge margin, Perlin clumping and minimum spacing.
    /// Deterministic for a given (params, rule, seed): the same inputs always yield the same list in the same
    /// order.
    /// </summary>
    public static class TerrainScatterGenerator
    {
        private const float k_SlopeSampleStep = 0.5f;
        private const float k_ClumpNoiseOffsetX = 5.3f;
        private const float k_ClumpNoiseOffsetZ = 71.9f;
        private const float k_CellFillProbability = 0.85f;

        /// <summary>
        /// Runs one <paramref name="rule"/> over the whole terrain: a jittered grid of candidates, each rejected
        /// or accepted in a fixed order so the result is deterministic for a given (params, rule, seed).
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="rule">Scatter rule.</param>
        /// <param name="seed">Deterministic RNG seed.</param>
        /// <returns>The accepted instances, in grid scan order; empty when the rule cannot place anything.</returns>
        public static List<ScatterInstance> Generate(TerrainGreyboxParams p, ScatterRule rule, int seed)
        {
            List<ScatterInstance> result = new List<ScatterInstance>();
            if (p == null || rule == null || rule.PrefabKeys == null || rule.PrefabKeys.Length == 0
                || rule.Density <= 0f)
            {
                return result;
            }

            System.Random random = new System.Random(seed);
            float cellSize = Mathf.Sqrt(100f / rule.Density);
            float minX = p.TerrainPosition.x + rule.EdgeMargin;
            float minZ = p.TerrainPosition.z + rule.EdgeMargin;
            float maxX = p.TerrainPosition.x + p.TerrainSize.x - rule.EdgeMargin;
            float maxZ = p.TerrainPosition.z + p.TerrainSize.z - rule.EdgeMargin;
            SpatialHash accepted = new SpatialHash(Mathf.Max(rule.MinSpacing, 0.01f));

            for (float z0 = minZ; z0 < maxZ; z0 += cellSize)
            {
                for (float x0 = minX; x0 < maxX; x0 += cellSize)
                {
                    // Always draw the same number of random values per cell so rejection never shifts the stream.
                    float jx = (float)random.NextDouble();
                    float jz = (float)random.NextDouble();
                    float fill = (float)random.NextDouble();
                    float yaw = (float)random.NextDouble() * 360f;
                    float scale = Mathf.Lerp(rule.ScaleMin, rule.ScaleMax, (float)random.NextDouble());
                    float pick = (float)random.NextDouble();
                    float thinning = (float)random.NextDouble();

                    float x = Mathf.Min(x0 + jx * cellSize, maxX);
                    float z = Mathf.Min(z0 + jz * cellSize, maxZ);

                    if (fill > k_CellFillProbability)
                    {
                        continue;
                    }

                    float radius = TerrainSplatGenerator.NoisyRadius(p, x, z);
                    if (radius < rule.RadiusMin || radius >= rule.RadiusMax)
                    {
                        continue;
                    }

                    if (rule.AreaRadius > 0f
                        && Vector2.Distance(new Vector2(x, z), rule.AreaCenter) > rule.AreaRadius)
                    {
                        continue;
                    }

                    if (rule.ClumpThreshold > 0f)
                    {
                        float noise = Mathf.PerlinNoise(x * rule.ClumpFrequency + k_ClumpNoiseOffsetX,
                            z * rule.ClumpFrequency + k_ClumpNoiseOffsetZ);
                        if (noise < rule.ClumpThreshold)
                        {
                            continue;
                        }
                    }

                    float routeDistance = DistanceToRoutes(p, x, z, out HeightPath nearestPath);
                    if (nearestPath != null)
                    {
                        float clear = nearestPath.HalfWidth + p.TrailExtraWidth + nearestPath.Blend
                            + rule.RouteClearance;
                        if (routeDistance < clear)
                        {
                            continue;
                        }

                        if (rule.RouteThinningDistance > 0f)
                        {
                            // Ramp starts at the clearance edge, not at the path centre line: everything
                            // closer than "clear" is already rejected above, so RouteThinningFactor is the
                            // keep-probability right at the edge, reaching one at clear + RouteThinningDistance.
                            float t = Mathf.Clamp01((routeDistance - clear) / rule.RouteThinningDistance);
                            float keep = Mathf.Lerp(rule.RouteThinningFactor, 1f, t);
                            if (thinning > keep)
                            {
                                continue;
                            }
                        }
                    }

                    if (TerrainHeightmapGenerator.TerraceSignedDistance(p, x, z) < rule.TerraceClearance)
                    {
                        continue;
                    }

                    if (IsInsideFlatSpot(p, x, z, rule.FlatSpotClearance))
                    {
                        continue;
                    }

                    if (SlopeDegrees(p, x, z) > rule.MaxSlopeDegrees)
                    {
                        continue;
                    }

                    if (!accepted.TryAdd(new Vector2(x, z), rule.MinSpacing))
                    {
                        continue;
                    }

                    ScatterInstance instance = new ScatterInstance
                    {
                        PrefabKey = PickKey(rule, pick),
                        Position = new Vector3(x,
                            TerrainHeightmapGenerator.SampleWorldHeight(p, x, z) - rule.SinkDepth, z),
                        YawDegrees = yaw,
                        Scale = scale,
                        GroundNormal = rule.AlignToSlope ? GroundNormal(p, x, z) : Vector3.up,
                    };
                    result.Add(instance);
                }
            }

            return result;
        }

        /// <summary>Ground slope from central differences of the generated height field, in degrees.</summary>
        public static float SlopeDegrees(TerrainGreyboxParams p, float worldX, float worldZ)
        {
            Vector3 n = GroundNormal(p, worldX, worldZ);
            return Mathf.Acos(Mathf.Clamp(n.y, -1f, 1f)) * Mathf.Rad2Deg;
        }

        /// <summary>Unit ground normal from central differences of the generated height field.</summary>
        public static Vector3 GroundNormal(TerrainGreyboxParams p, float worldX, float worldZ)
        {
            float s = k_SlopeSampleStep;
            float dhdx = (TerrainHeightmapGenerator.SampleWorldHeight(p, worldX + s, worldZ)
                - TerrainHeightmapGenerator.SampleWorldHeight(p, worldX - s, worldZ)) / (2f * s);
            float dhdz = (TerrainHeightmapGenerator.SampleWorldHeight(p, worldX, worldZ + s)
                - TerrainHeightmapGenerator.SampleWorldHeight(p, worldX, worldZ - s)) / (2f * s);
            return new Vector3(-dhdx, 1f, -dhdz).normalized;
        }

        private static float DistanceToRoutes(TerrainGreyboxParams p, float x, float z, out HeightPath nearest)
        {
            nearest = null;
            float best = float.MaxValue;
            if (p.Paths == null)
            {
                return best;
            }

            Vector2 point = new Vector2(x, z);
            for (int i = 0; i < p.Paths.Length; i++)
            {
                HeightPath path = p.Paths[i];
                if (path == null || path.Nodes == null || path.Nodes.Length < 2)
                {
                    continue;
                }

                float h;
                float d = TerrainHeightmapGenerator.DistanceToPolyline(path.Nodes, point, out h);
                if (d < best)
                {
                    best = d;
                    nearest = path;
                }
            }

            return best;
        }

        private static bool IsInsideFlatSpot(TerrainGreyboxParams p, float x, float z, float clearance)
        {
            if (p.FlatSpots == null)
            {
                return false;
            }

            for (int i = 0; i < p.FlatSpots.Length; i++)
            {
                FlatSpot spot = p.FlatSpots[i];
                float d = Vector2.Distance(new Vector2(x, z), spot.Center);
                if (d < spot.Radius + spot.Blend + clearance)
                {
                    return true;
                }
            }

            return false;
        }

        private static string PickKey(ScatterRule rule, float t)
        {
            string[] keys = rule.PrefabKeys;
            float[] weights = rule.PrefabWeights;
            if (weights == null || weights.Length != keys.Length)
            {
                return keys[Mathf.Min((int)(t * keys.Length), keys.Length - 1)];
            }

            float total = 0f;
            for (int i = 0; i < weights.Length; i++)
            {
                total += Mathf.Max(0f, weights[i]);
            }

            float target = t * total;
            for (int i = 0; i < weights.Length; i++)
            {
                target -= Mathf.Max(0f, weights[i]);
                if (target <= 0f)
                {
                    return keys[i];
                }
            }

            return keys[keys.Length - 1];
        }

        /// <summary>Grid hash used for the minimum-spacing test; cell size equals the spacing.</summary>
        private sealed class SpatialHash
        {
            private readonly float m_cellSize;
            private readonly Dictionary<long, List<Vector2>> m_cells = new Dictionary<long, List<Vector2>>();

            public SpatialHash(float cellSize)
            {
                m_cellSize = cellSize;
            }

            public bool TryAdd(Vector2 point, float minSpacing)
            {
                int cx = Mathf.FloorToInt(point.x / m_cellSize);
                int cz = Mathf.FloorToInt(point.y / m_cellSize);
                float minSq = minSpacing * minSpacing;
                for (int dz = -1; dz <= 1; dz++)
                {
                    for (int dx = -1; dx <= 1; dx++)
                    {
                        List<Vector2> bucket;
                        if (!m_cells.TryGetValue(Key(cx + dx, cz + dz), out bucket))
                        {
                            continue;
                        }

                        for (int i = 0; i < bucket.Count; i++)
                        {
                            if ((bucket[i] - point).sqrMagnitude < minSq)
                            {
                                return false;
                            }
                        }
                    }
                }

                List<Vector2> own;
                long key = Key(cx, cz);
                if (!m_cells.TryGetValue(key, out own))
                {
                    own = new List<Vector2>();
                    m_cells.Add(key, own);
                }

                own.Add(point);
                return true;
            }

            private static long Key(int x, int z)
            {
                return ((long)x << 32) ^ (uint)z;
            }
        }
    }
}
