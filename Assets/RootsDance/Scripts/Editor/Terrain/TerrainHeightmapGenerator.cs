using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Pure height field generator for the greybox terrain. Composes a warped radial profile, a northern backdrop
    /// rise, detail noise, the lab terrace, local flat spots and walkable paths — in that order — into world
    /// heights, and bakes them into a normalised array for <c>TerrainData.SetHeights</c>.
    /// </summary>
    public static class TerrainHeightmapGenerator
    {
        private const float k_NoiseOffsetX = 17.3f;
        private const float k_NoiseOffsetZ = 41.9f;
        private const float k_FineWarpPhaseScale = 2.3f;
        private const float k_MinimumSegmentLengthSquared = 1e-8f;

        /// <summary>
        /// Warped polar radius from <see cref="TerrainGreyboxParams.RingCenter"/>, in metres. The warp breaks the
        /// perfect circle of the ring composition with a three-lobe and a five-lobe sine.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <returns>The warped radius, in metres. May be slightly negative near the ring centre.</returns>
        public static float WarpedRadius(TerrainGreyboxParams p, float worldX, float worldZ)
        {
            float dx = worldX - p.RingCenter.x;
            float dz = worldZ - p.RingCenter.y;
            float distance = Mathf.Sqrt(dx * dx + dz * dz);
            float theta = Mathf.Atan2(dz, dx);

            return distance
                + p.RingWarpAmplitude * Mathf.Sin(3f * theta + p.RingWarpPhase)
                + p.RingWarpAmplitudeFine * Mathf.Sin(5f * theta + k_FineWarpPhaseScale * p.RingWarpPhase);
        }

        /// <summary>
        /// Ground height in world metres, before clamping to the terrain box.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <returns>The composed world height, in metres.</returns>
        public static float SampleWorldHeight(TerrainGreyboxParams p, float worldX, float worldZ)
        {
            float radius = WarpedRadius(p, worldX, worldZ);
            float height = SampleRadialProfile(p.RadialProfile, radius);

            float riseSpan = p.NorthRiseEndZ - p.NorthRiseStartZ;
            if (Mathf.Abs(riseSpan) > Mathf.Epsilon)
            {
                height += p.NorthRiseHeight * SmoothStep01((worldZ - p.NorthRiseStartZ) / riseSpan);
            }

            float noise = Mathf.PerlinNoise(
                worldX * p.DetailNoiseFrequency + k_NoiseOffsetX,
                worldZ * p.DetailNoiseFrequency + k_NoiseOffsetZ);
            height += (noise - 0.5f) * 2f * p.DetailNoiseAmplitude;

            height = Mathf.Lerp(height, p.TerraceHeight, TerraceWeight(p, worldX, worldZ, p.TerraceBlend));

            if (p.FlatSpots != null)
            {
                for (int i = 0; i < p.FlatSpots.Length; i++)
                {
                    FlatSpot spot = p.FlatSpots[i];
                    float dx = worldX - spot.Center.x;
                    float dz = worldZ - spot.Center.y;
                    float distance = Mathf.Sqrt(dx * dx + dz * dz);
                    height = Mathf.Lerp(height, spot.Height, Falloff(distance, spot.Radius, spot.Blend));
                }
            }

            if (p.Paths != null)
            {
                Vector2 point = new Vector2(worldX, worldZ);
                for (int i = 0; i < p.Paths.Length; i++)
                {
                    HeightPath path = p.Paths[i];
                    if (path == null || path.Nodes == null || path.Nodes.Length == 0)
                    {
                        continue;
                    }

                    float pathHeight;
                    float distance = DistanceToPolyline(path.Nodes, point, out pathHeight);
                    height = Mathf.Lerp(height, pathHeight, Falloff(distance, path.HalfWidth, path.Blend));
                }
            }

            return height;
        }

        /// <summary>
        /// Bakes the whole height field. Index order matches <c>TerrainData.SetHeights</c>: the first index runs
        /// along +Z, the second along +X.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <returns>
        /// Normalised heights in 0..1, sized <c>HeightmapResolution</c> squared, or an empty array when the
        /// resolution is below two.
        /// </returns>
        public static float[,] Generate(TerrainGreyboxParams p)
        {
            int resolution = p.HeightmapResolution;

            if (resolution < 2)
            {
                return new float[0, 0];
            }

            float[,] heights = new float[resolution, resolution];
            float stepX = p.TerrainSize.x / (resolution - 1);
            float stepZ = p.TerrainSize.z / (resolution - 1);
            float baseY = p.TerrainPosition.y;
            float sizeY = Mathf.Approximately(p.TerrainSize.y, 0f) ? 1f : p.TerrainSize.y;

            for (int iz = 0; iz < resolution; iz++)
            {
                float worldZ = p.TerrainPosition.z + iz * stepZ;
                for (int ix = 0; ix < resolution; ix++)
                {
                    float worldX = p.TerrainPosition.x + ix * stepX;
                    float height = SampleWorldHeight(p, worldX, worldZ);
                    heights[iz, ix] = Mathf.Clamp01((height - baseY) / sizeY);
                }
            }

            return heights;
        }

        /// <summary>
        /// Shortest distance from a point to a polyline in world XZ, together with the polyline height at the
        /// closest point. Public so the corridor maths can be tested on its own.
        /// </summary>
        /// <param name="nodes">Polyline nodes; may be null or empty.</param>
        /// <param name="point">Query point in world XZ (x = world X, y = world Z).</param>
        /// <param name="heightAtClosest">Interpolated node height at the closest point, in metres.</param>
        /// <returns>The distance in metres, or <see cref="float.MaxValue"/> when there are no nodes.</returns>
        public static float DistanceToPolyline(PathNode[] nodes, Vector2 point, out float heightAtClosest)
        {
            heightAtClosest = 0f;
            if (nodes == null || nodes.Length == 0)
            {
                return float.MaxValue;
            }

            if (nodes.Length == 1)
            {
                heightAtClosest = nodes[0].Height;
                return Vector2.Distance(point, nodes[0].Position);
            }

            float best = float.MaxValue;
            for (int i = 0; i < nodes.Length - 1; i++)
            {
                Vector2 a = nodes[i].Position;
                Vector2 b = nodes[i + 1].Position;
                Vector2 ab = b - a;
                float lengthSquared = ab.sqrMagnitude;
                float t = 0f;
                if (lengthSquared > k_MinimumSegmentLengthSquared)
                {
                    t = Mathf.Clamp01(Vector2.Dot(point - a, ab) / lengthSquared);
                }

                float distance = Vector2.Distance(point, a + ab * t);
                if (distance < best)
                {
                    best = distance;
                    heightAtClosest = Mathf.Lerp(nodes[i].Height, nodes[i + 1].Height, t);
                }
            }

            return best;
        }

        /// <summary>
        /// Signed distance to the yawed rounded rectangle of the lab terrace, negative inside. Public so the
        /// terrace outline can be unit-tested and drawn as a gizmo.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <returns>The signed distance, in metres.</returns>
        public static float TerraceSignedDistance(TerrainGreyboxParams p, float worldX, float worldZ)
        {
            float dx = worldX - p.TerraceCenter.x;
            float dz = worldZ - p.TerraceCenter.y;

            // Unity's Y rotation is clockwise-positive: Quaternion.Euler(0, yaw, 0) * Vector3.right lands on
            // the world XZ direction (cos yaw, -sin yaw). The world -> local map below is that rotation's
            // inverse, so it sends exactly that direction back to local +X.
            float yaw = p.TerraceYawDegrees * Mathf.Deg2Rad;
            float cos = Mathf.Cos(yaw);
            float sin = Mathf.Sin(yaw);
            float localX = dx * cos - dz * sin;
            float localZ = dx * sin + dz * cos;

            float cornerRadius = p.TerraceCornerRadius;
            float qx = Mathf.Abs(localX) - (p.TerraceHalfExtents.x - cornerRadius);
            float qz = Mathf.Abs(localZ) - (p.TerraceHalfExtents.y - cornerRadius);
            float outsideX = Mathf.Max(qx, 0f);
            float outsideZ = Mathf.Max(qz, 0f);
            float outside = Mathf.Sqrt(outsideX * outsideX + outsideZ * outsideZ);

            return outside + Mathf.Min(Mathf.Max(qx, qz), 0f) - cornerRadius;
        }

        /// <summary>
        /// Terrace influence in 0..1 — one inside the outline, falling to zero <paramref name="blend"/> metres out.
        /// </summary>
        /// <param name="p">Terrain parameters.</param>
        /// <param name="worldX">World X, in metres.</param>
        /// <param name="worldZ">World Z, in metres.</param>
        /// <param name="blend">Falloff width outside the outline, in metres.</param>
        /// <returns>The weight in 0..1.</returns>
        internal static float TerraceWeight(TerrainGreyboxParams p, float worldX, float worldZ, float blend)
        {
            float distance = TerraceSignedDistance(p, worldX, worldZ);
            if (blend <= 0f)
            {
                return distance <= 0f ? 1f : 0f;
            }

            return 1f - SmoothStep01(distance / blend);
        }

        /// <summary>Hermite smoothstep of a value clamped to 0..1.</summary>
        /// <param name="t">Input value; clamped before shaping.</param>
        /// <returns>The smoothed value in 0..1.</returns>
        internal static float SmoothStep01(float t)
        {
            float clamped = Mathf.Clamp01(t);
            return clamped * clamped * (3f - 2f * clamped);
        }

        /// <summary>
        /// Influence of a feature with a fully applied core and a smooth falloff ring: one at or inside
        /// <paramref name="coreRadius"/>, zero <paramref name="blend"/> metres beyond it.
        /// </summary>
        /// <param name="distance">Distance from the feature, in metres.</param>
        /// <param name="coreRadius">Radius of the fully applied core, in metres.</param>
        /// <param name="blend">Falloff width outside the core, in metres.</param>
        /// <returns>The weight in 0..1.</returns>
        private static float Falloff(float distance, float coreRadius, float blend)
        {
            if (blend <= 0f)
            {
                return distance <= coreRadius ? 1f : 0f;
            }

            return 1f - SmoothStep01((distance - coreRadius) / blend);
        }

        /// <summary>
        /// Piecewise cosine interpolation of the radial profile; clamps to the first and last node outside the
        /// profile range.
        /// </summary>
        /// <param name="profile">Nodes ordered by ascending radius; may be null or empty.</param>
        /// <param name="radius">Warped radius to sample, in metres.</param>
        /// <returns>The profile height in metres, or zero when the profile is empty.</returns>
        private static float SampleRadialProfile(RadialNode[] profile, float radius)
        {
            if (profile == null || profile.Length == 0)
            {
                return 0f;
            }

            if (radius <= profile[0].Radius)
            {
                return profile[0].Height;
            }

            int last = profile.Length - 1;
            if (radius >= profile[last].Radius)
            {
                return profile[last].Height;
            }

            for (int i = 0; i < last; i++)
            {
                float innerRadius = profile[i].Radius;
                float outerRadius = profile[i + 1].Radius;
                if (radius > outerRadius)
                {
                    continue;
                }

                float span = outerRadius - innerRadius;
                if (span <= 0f)
                {
                    return profile[i + 1].Height;
                }

                float u = (radius - innerRadius) / span;
                float t = (1f - Mathf.Cos(Mathf.PI * u)) * 0.5f;
                return Mathf.Lerp(profile[i].Height, profile[i + 1].Height, t);
            }

            return profile[last].Height;
        }
    }
}
