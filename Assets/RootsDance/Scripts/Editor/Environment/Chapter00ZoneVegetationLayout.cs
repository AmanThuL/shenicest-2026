using System;
using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    [Serializable]
    public struct Chapter00PrefabMetrics
    {
        public float Height;
        public Vector2 Footprint;

        public Chapter00PrefabMetrics(float height, Vector2 footprint)
        {
            Height = height;
            Footprint = footprint;
        }
    }

    [Serializable]
    public struct Chapter00VegetationPlacement
    {
        public Chapter00VegetationZone Zone;
        public Chapter00VegetationRole Role;
        public Chapter00VegetationTint Tint;
        public string PrefabKey;
        public Vector2 Position;
        public float Yaw;
        public float TargetHeight;
        public float NormalAlign;

        /// <summary>Smallest final XZ Renderer dimension, used by the C coverage audit.</summary>
        public float Footprint;
    }

    /// <summary>
    /// Pure deterministic A-E placement. It consumes prefab Renderer metrics but never opens a scene, making
    /// footprint coverage, route policy, height ranges and blocker masks independently testable.
    /// </summary>
    public static class Chapter00ZoneVegetationLayout
    {
        private const float k_MinimumGroundPitch = .24f;

        public interface IPrefabMetrics
        {
            bool TryGet(string key, out Chapter00PrefabMetrics metrics);
        }

        public interface IGroundFilter
        {
            bool Accepts(Vector2 position, Chapter00VegetationZone zone, Chapter00VegetationRole role);
        }

        public static List<Chapter00VegetationPlacement> Build(
            Chapter00ZoneVegetationParams p,
            IPrefabMetrics metrics,
            IGroundFilter groundFilter = null)
        {
            if (p == null) throw new ArgumentNullException(nameof(p));
            if (metrics == null) throw new ArgumentNullException(nameof(metrics));

            List<Chapter00VegetationPlacement> placements = new List<Chapter00VegetationPlacement>();
            Rect bounds = EnvelopeBounds(p.VisibleEnvelopes);

            for (int layerIndex = 0; layerIndex < p.Layers.Length; layerIndex++)
            {
                Chapter00VegetationLayerSpec spec = p.Layers[layerIndex];
                float pitch = Pitch(spec, metrics);
                float rowPitch = spec.Role == Chapter00VegetationRole.WalkThroughGroundCover
                    ? pitch * .8660254f
                    : pitch;
                int row = 0;

                for (float z = bounds.yMin; z <= bounds.yMax; z += rowPitch, row++)
                {
                    float stagger = spec.Role == Chapter00VegetationRole.WalkThroughGroundCover
                        && (row & 1) != 0 ? pitch * .5f : 0f;
                    int column = 0;

                    for (float x = bounds.xMin + stagger; x <= bounds.xMax; x += pitch, column++)
                    {
                        uint hash = Hash(spec.Seed, row, column);
                        Vector2 point = new Vector2(x, z);

                        if (spec.Role != Chapter00VegetationRole.WalkThroughGroundCover)
                        {
                            point += new Vector2(Signed01(hash) * pitch * .24f,
                                Signed01(Hash(hash, 19u)) * pitch * .24f);
                        }

                        if (!AcceptsPoint(p, spec, point, groundFilter))
                        {
                            continue;
                        }

                        int keyIndex = (int)(Hash(hash, 71u) % (uint)spec.PrefabKeys.Length);
                        string key = spec.PrefabKeys[keyIndex];
                        Chapter00PrefabMetrics source;

                        if (!metrics.TryGet(key, out source) || source.Height <= .0001f)
                        {
                            throw new InvalidOperationException(
                                $"No usable Renderer metrics were supplied for vegetation prefab '{key}'.");
                        }

                        float targetHeight = Mathf.Lerp(spec.TargetHeightMin, spec.TargetHeightMax,
                            Unit01(Hash(hash, 113u)));
                        float scaledFootprint = Mathf.Min(source.Footprint.x, source.Footprint.y)
                            * targetHeight / source.Height;

                        placements.Add(new Chapter00VegetationPlacement
                        {
                            Zone = spec.Zone,
                            Role = spec.Role,
                            Tint = TintAt(spec.Zone, point, spec.Seed),
                            PrefabKey = key,
                            Position = point,
                            Yaw = Unit01(Hash(hash, 151u)) * 360f,
                            TargetHeight = targetHeight,
                            NormalAlign = spec.NormalAlign,
                            Footprint = Mathf.Max(.05f, scaledFootprint),
                        });
                    }
                }
            }

            return placements;
        }

        private static bool AcceptsPoint(
            Chapter00ZoneVegetationParams p,
            Chapter00VegetationLayerSpec spec,
            Vector2 point,
            IGroundFilter filter)
        {
            if (!IsInVisibleEnvelope(p, point) || ClassifyZone(p, point) != spec.Zone)
            {
                return false;
            }

            if (spec.RouteClearance > 0f && DistanceToRoutes(p.Routes, point) < spec.RouteClearance)
            {
                return false;
            }

            if (spec.CheckpointClearance > 0f && DistanceToPoints(p.Checkpoints, point) < spec.CheckpointClearance)
            {
                return false;
            }

            if (spec.Role == Chapter00VegetationRole.PhysicalBlocker
                && (spec.Zone == Chapter00VegetationZone.D || spec.Zone == Chapter00VegetationZone.E))
            {
                if (spec.Zone == Chapter00VegetationZone.E
                    && DistanceToRoute(p.Corridor1Route, point) < p.CorridorVisualHalfWidth)
                {
                    return false;
                }

                if (spec.CullFromDomeViewCone && IsInDomeViewCone(p, point))
                {
                    return false;
                }
            }

            return filter == null || filter.Accepts(point, spec.Zone, spec.Role);
        }

        public static Chapter00VegetationZone ClassifyZone(Chapter00ZoneVegetationParams p, Vector2 point)
        {
            float radius = Vector2.Distance(point, p.RingCenter);
            if (radius < Chapter00ZoneVegetationParams.k_RadiusDE) return Chapter00VegetationZone.E;
            if (radius < Chapter00ZoneVegetationParams.k_RadiusCD) return Chapter00VegetationZone.D;
            if (radius < Chapter00ZoneVegetationParams.k_RadiusBC) return Chapter00VegetationZone.C;
            if (radius < Chapter00ZoneVegetationParams.k_RadiusAB) return Chapter00VegetationZone.B;
            return Chapter00VegetationZone.A;
        }

        public static bool IsInVisibleEnvelope(Chapter00ZoneVegetationParams p, Vector2 point)
        {
            if (Vector2.Distance(point, p.RingCenter) > Chapter00ZoneVegetationParams.k_OuterVisibleRadius)
            {
                return false;
            }

            for (int i = 0; i < p.VisibleEnvelopes.Length; i++)
            {
                Chapter00ViewEnvelope envelope = p.VisibleEnvelopes[i];
                if ((point - envelope.Center).sqrMagnitude <= envelope.Radius * envelope.Radius)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// A conservative 2D corridor to the dome target. Tall blockers are rejected here; ground cover and
        /// low mid-layer plants remain free to hide the facility base.
        /// </summary>
        public static bool IsInDomeViewCone(Chapter00ZoneVegetationParams p, Vector2 point)
        {
            for (int i = 0; i < p.DomeViewOrigins.Length; i++)
            {
                Vector2 origin = p.DomeViewOrigins[i];
                Vector2 ray = p.DomeTarget - origin;
                float lengthSquared = ray.sqrMagnitude;

                if (lengthSquared < .001f)
                {
                    continue;
                }

                float t = Vector2.Dot(point - origin, ray) / lengthSquared;
                if (t < 0f || t > 1.08f)
                {
                    continue;
                }

                float widening = Mathf.Lerp(2.2f, p.DomeViewHalfWidth, Mathf.Clamp01(t));
                if (Vector2.Distance(point, origin + ray * t) < widening)
                {
                    return true;
                }
            }

            return false;
        }

        public static float DistanceToRoutes(Vector2[][] routes, Vector2 point)
        {
            float result = float.MaxValue;
            for (int i = 0; i < routes.Length; i++)
            {
                result = Mathf.Min(result, DistanceToRoute(routes[i], point));
            }
            return result;
        }

        public static float DistanceToRoute(Vector2[] route, Vector2 point)
        {
            if (route == null || route.Length == 0) return float.MaxValue;
            if (route.Length == 1) return Vector2.Distance(route[0], point);

            float result = float.MaxValue;
            for (int i = 0; i + 1 < route.Length; i++)
            {
                result = Mathf.Min(result, DistanceToSegment(point, route[i], route[i + 1]));
            }
            return result;
        }

        public static float DistanceToSegment(Vector2 point, Vector2 from, Vector2 to)
        {
            Vector2 line = to - from;
            float lengthSquared = line.sqrMagnitude;
            if (lengthSquared < .0001f) return Vector2.Distance(point, from);
            float t = Mathf.Clamp01(Vector2.Dot(point - from, line) / lengthSquared);
            return Vector2.Distance(point, from + line * t);
        }

        public static bool IsCovered(
            Vector2 point,
            IList<Chapter00VegetationPlacement> placements,
            Chapter00VegetationZone zone)
        {
            for (int i = 0; i < placements.Count; i++)
            {
                Chapter00VegetationPlacement placement = placements[i];
                if (placement.Zone != zone
                    || placement.Role != Chapter00VegetationRole.WalkThroughGroundCover)
                {
                    continue;
                }

                float radius = placement.Footprint * .5f;
                if ((placement.Position - point).sqrMagnitude <= radius * radius)
                {
                    return true;
                }
            }
            return false;
        }

        private static float Pitch(Chapter00VegetationLayerSpec spec, IPrefabMetrics metrics)
        {
            if (spec.Role != Chapter00VegetationRole.WalkThroughGroundCover)
            {
                return Mathf.Max(.25f, spec.Spacing);
            }

            float smallest = float.MaxValue;
            for (int i = 0; i < spec.PrefabKeys.Length; i++)
            {
                Chapter00PrefabMetrics value;
                if (!metrics.TryGet(spec.PrefabKeys[i], out value) || value.Height <= .0001f)
                {
                    throw new InvalidOperationException(
                        $"No usable Renderer metrics were supplied for vegetation prefab '{spec.PrefabKeys[i]}'.");
                }

                float footprint = Mathf.Min(value.Footprint.x, value.Footprint.y)
                    * spec.TargetHeightMin / value.Height;
                smallest = Mathf.Min(smallest, footprint);
            }

            return Mathf.Max(k_MinimumGroundPitch, spec.Spacing,
                smallest * (1f - spec.FootprintOverlap));
        }

        private static Chapter00VegetationTint TintAt(
            Chapter00VegetationZone zone,
            Vector2 point,
            int seed)
        {
            switch (zone)
            {
                case Chapter00VegetationZone.A: return Chapter00VegetationTint.DeadAsh;
                case Chapter00VegetationZone.B: return Chapter00VegetationTint.HumusOlive;
                case Chapter00VegetationZone.D: return Chapter00VegetationTint.StableGreen;
                case Chapter00VegetationZone.E: return Chapter00VegetationTint.FacilityGreen;
            }

            // C is one mutation expressed through two related shades, not a multi-colour meadow. A tighter
            // 2.5 m cell keeps warm stone-pink and cool pink-violet patches visibly interwoven at player height.
            int clusterX = Mathf.FloorToInt(point.x / 2.5f);
            int clusterZ = Mathf.FloorToInt(point.y / 2.5f);
            float roll = Unit01(Hash(seed + 991, clusterX, clusterZ));
            return roll < .5f
                ? Chapter00VegetationTint.FadedPink
                : Chapter00VegetationTint.MutedViolet;
        }

        private static Rect EnvelopeBounds(Chapter00ViewEnvelope[] envelopes)
        {
            if (envelopes == null || envelopes.Length == 0) return new Rect();
            float minX = float.MaxValue;
            float minZ = float.MaxValue;
            float maxX = float.MinValue;
            float maxZ = float.MinValue;
            for (int i = 0; i < envelopes.Length; i++)
            {
                minX = Mathf.Min(minX, envelopes[i].Center.x - envelopes[i].Radius);
                maxX = Mathf.Max(maxX, envelopes[i].Center.x + envelopes[i].Radius);
                minZ = Mathf.Min(minZ, envelopes[i].Center.y - envelopes[i].Radius);
                maxZ = Mathf.Max(maxZ, envelopes[i].Center.y + envelopes[i].Radius);
            }
            return Rect.MinMaxRect(minX, minZ, maxX, maxZ);
        }

        private static float DistanceToPoints(Vector2[] points, Vector2 point)
        {
            float result = float.MaxValue;
            for (int i = 0; i < points.Length; i++) result = Mathf.Min(result, Vector2.Distance(points[i], point));
            return result;
        }

        private static uint Hash(int seed, int a, int b)
        {
            return Hash(Hash((uint)seed, unchecked((uint)a)), unchecked((uint)b));
        }

        private static uint Hash(int seed, int a, int b, int c)
        {
            return Hash(Hash(seed, a, b), unchecked((uint)c));
        }

        private static uint Hash(uint value, uint salt)
        {
            uint x = value ^ (salt + 0x9e3779b9u + (value << 6) + (value >> 2));
            x ^= x >> 16;
            x *= 0x7feb352du;
            x ^= x >> 15;
            x *= 0x846ca68bu;
            x ^= x >> 16;
            return x;
        }

        private static float Unit01(uint value)
        {
            return (value & 0x00ffffffu) / 16777216f;
        }

        private static float Signed01(uint value)
        {
            return Unit01(value) * 2f - 1f;
        }
    }
}
