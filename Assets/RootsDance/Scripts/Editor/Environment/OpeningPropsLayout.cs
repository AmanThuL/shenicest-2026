using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Pure geometry over <see cref="OpeningPropsParams"/>: expands anchors, fence runs and scatter patches
    /// into a flat list of <see cref="PropInstance"/>. Deterministic — the same params always produce the same
    /// list, in the same order — so the builder is idempotent and the EditMode tests can assert on it without
    /// a scene or a terrain.
    /// </summary>
    /// <remarks>
    /// Everything that needs the actual terrain (ground height, slope, painted layer weight) is left to
    /// <see cref="OpeningPropsBuilder"/>; this class only decides <i>where in XZ</i> things go.
    /// </remarks>
    public static class OpeningPropsLayout
    {
        /// <summary>Candidates drawn per accepted instance before a patch gives up.</summary>
        private const int k_CandidatesPerInstance = 24;

        /// <summary>
        /// The terrain tests a scatter candidate has to pass. Injected so this class stays free of scene and
        /// terrain references: the builder supplies the real ground, the EditMode tests supply nothing and
        /// every candidate is accepted.
        /// </summary>
        public interface IGroundFilter
        {
            /// <summary>
            /// True when the ground at <paramref name="position"/> is no steeper than
            /// <paramref name="maxSlopeDegrees"/> and — when <paramref name="layer"/> is not -1 — is painted
            /// with at least <paramref name="minLayerWeight"/> of that terrain layer.
            /// </summary>
            bool Accepts(Vector2 position, float maxSlopeDegrees, int layer, float minLayerWeight);
        }

        /// <summary>Every instance the pass places, anchors first, then fences, then scatter.</summary>
        public static List<PropInstance> Build(OpeningPropsParams p, IGroundFilter filter = null)
        {
            List<PropInstance> all = new List<PropInstance>();

            for (int i = 0; i < p.Anchors.Length; i++)
            {
                all.Add(FromAnchor(p.Anchors[i]));
            }

            for (int i = 0; i < p.Fences.Length; i++)
            {
                BuildFence(p.Fences[i], all);
            }

            for (int i = 0; i < p.Patches.Length; i++)
            {
                BuildPatch(p.Patches[i], p.Route, all, filter);
            }

            return all;
        }

        private static PropInstance FromAnchor(PropAnchor anchor)
        {
            return new PropInstance
            {
                Prefab = anchor.Prefab,
                Pool = anchor.Pool,
                Group = "Anchor",
                Position = anchor.Position,
                Yaw = anchor.Yaw,
                ExtraEuler = anchor.ExtraEuler,
                Scale = anchor.Scale,
                Sink = anchor.Sink,
                NormalAlign = anchor.NormalAlign,
            };
        }

        // -------------------------------------------------------------------------------------------------
        // Fence runs
        // -------------------------------------------------------------------------------------------------

        /// <summary>Metres a gap filler sinks into the ground, so a rock or barrier reads as settled.</summary>
        private const float k_FillerSink = 0.15f;

        /// <summary>How far a gap filler follows the ground normal.</summary>
        private const float k_FillerNormalAlign = 0.6f;

        /// <summary>Maximum random tilt of a gap filler, in degrees.</summary>
        private const float k_FillerTiltJitter = 8f;

        /// <summary>The one filler key that belongs to the boundary palette rather than the rock clutter.</summary>
        private const string k_BarrierPrefab = "concrete_road_barrier";

        /// <summary>
        /// Walks the polyline on <see cref="FenceRun.ModuleLength"/> steps, dropping a post at every step and
        /// a panel across every gap between two posts. Panels are placed at the gap's midpoint and yawed along
        /// it, so a run follows a bend without leaving a wedge open.
        /// </summary>
        /// <remarks>
        /// A run with <see cref="FenceRun.GapFillers"/> or a <see cref="FenceRun.GapMaxModules"/> above 1 takes
        /// the gap-filling path: gaps may span several modules, lose their interior posts and get one big
        /// obstacle at their centre. Runs without either keep the original output, draw for draw.
        /// </remarks>
        public static void BuildFence(FenceRun run, List<PropInstance> into)
        {
            if (run.Nodes == null || run.Nodes.Length < 2 || run.ModuleLength <= 0f)
            {
                return;
            }

            List<Vector2> posts = SamplePolyline(run.Nodes, run.ModuleLength);
            Rng rng = new Rng(run.Seed);
            bool hasFillers = run.GapFillers != null && run.GapFillers.Length > 0;

            if (!hasFillers && run.GapMaxModules <= 1)
            {
                BuildPlainFence(run, posts, ref rng, into);
            }
            else
            {
                BuildGappedFence(run, posts, ref rng, into, hasFillers);
            }
        }

        /// <summary>The original fence: every post stands, single-module gaps stay empty.</summary>
        private static void BuildPlainFence(FenceRun run, List<Vector2> posts, ref Rng rng,
            List<PropInstance> into)
        {
            for (int i = 0; i < posts.Count; i++)
            {
                bool isEnd = i == 0 || i == posts.Count - 1;

                into.Add(new PropInstance
                {
                    Prefab = isEnd ? run.EndPostPrefab : run.PostPrefab,
                    Pool = PropPool.BrokenBoundary,
                    Group = run.Name + "_Post",
                    Position = posts[i],
                    Yaw = rng.Range(0f, 360f),
                    Scale = 1f,
                    Sink = run.Sink,
                    NormalAlign = 0f,
                    Tilt = rng.Range(0f, run.PostLean),
                    TiltDirection = rng.Range(0f, 360f),
                });
            }

            for (int i = 0; i + 1 < posts.Count; i++)
            {
                if (rng.Value() < run.GapChance)
                {
                    continue;
                }

                Vector2 a = posts[i];
                Vector2 b = posts[i + 1];

                into.Add(new PropInstance
                {
                    Prefab = run.PanelPrefab,
                    Pool = PropPool.BrokenBoundary,
                    Group = run.Name + "_Panel",
                    Position = (a + b) * 0.5f,
                    Yaw = YawAlongX(b - a),
                    Scale = 1f,
                    Sink = run.Sink,
                    NormalAlign = 0f,
                    Tilt = rng.Range(0f, run.PanelLean),
                    TiltDirection = rng.Range(0f, 360f),
                });
            }
        }

        /// <summary>
        /// The gap-filling fence. Modules are first assigned to gaps (each gap spans
        /// 1..<see cref="FenceRun.GapMaxModules"/> modules, clamped to the run), then the posts that survive,
        /// the panels of the ungapped modules and one filler per gap are emitted, in that order.
        /// </summary>
        private static void BuildGappedFence(FenceRun run, List<Vector2> posts, ref Rng rng,
            List<PropInstance> into, bool hasFillers)
        {
            int modules = posts.Count - 1;
            int maxGapModules = Mathf.Max(1, run.GapMaxModules);

            // gapId[m] is the index of the gap module m belongs to, or -1 when its panel stands.
            int[] gapId = new int[modules];
            List<int> gapStart = new List<int>();
            List<int> gapLength = new List<int>();

            for (int m = 0; m < modules; m++)
            {
                gapId[m] = -1;
            }

            for (int m = 0; m < modules; m++)
            {
                if (gapId[m] >= 0 || rng.Value() >= run.GapChance)
                {
                    continue;
                }

                int length = Mathf.Min(rng.RangeInt(1, maxGapModules), modules - m);

                for (int j = 0; j < length; j++)
                {
                    gapId[m + j] = gapStart.Count;
                }

                gapStart.Add(m);
                gapLength.Add(length);
            }

            for (int i = 0; i < posts.Count; i++)
            {
                // A post is interior to a gap when the modules on both sides belong to the same gap. The two
                // end posts and every gap boundary — including one shared by two adjacent gaps — stay.
                bool interior = i > 0 && i < modules && gapId[i - 1] >= 0 && gapId[i - 1] == gapId[i];

                if (interior)
                {
                    continue;
                }

                bool isEnd = i == 0 || i == posts.Count - 1;

                into.Add(new PropInstance
                {
                    Prefab = isEnd ? run.EndPostPrefab : run.PostPrefab,
                    Pool = PropPool.BrokenBoundary,
                    Group = run.Name + "_Post",
                    Position = posts[i],
                    Yaw = rng.Range(0f, 360f),
                    Scale = 1f,
                    Sink = run.Sink,
                    NormalAlign = 0f,
                    Tilt = rng.Range(0f, run.PostLean),
                    TiltDirection = rng.Range(0f, 360f),
                });
            }

            for (int m = 0; m < modules; m++)
            {
                if (gapId[m] >= 0)
                {
                    continue;
                }

                Vector2 a = posts[m];
                Vector2 b = posts[m + 1];

                into.Add(new PropInstance
                {
                    Prefab = run.PanelPrefab,
                    Pool = PropPool.BrokenBoundary,
                    Group = run.Name + "_Panel",
                    Position = (a + b) * 0.5f,
                    Yaw = YawAlongX(b - a),
                    Scale = 1f,
                    Sink = run.Sink,
                    NormalAlign = 0f,
                    Tilt = rng.Range(0f, run.PanelLean),
                    TiltDirection = rng.Range(0f, 360f),
                });
            }

            if (!hasFillers)
            {
                return;
            }

            for (int g = 0; g < gapStart.Count; g++)
            {
                Vector2 first = posts[gapStart[g]];
                Vector2 last = posts[gapStart[g] + gapLength[g]];
                string prefab = run.GapFillers[rng.RangeInt(0, run.GapFillers.Length - 1)];

                into.Add(new PropInstance
                {
                    Prefab = prefab,
                    Pool = prefab == k_BarrierPrefab ? PropPool.BrokenBoundary : PropPool.RootRockClutter,
                    Group = run.Name + "_Filler",
                    Position = (first + last) * 0.5f,
                    Yaw = rng.Range(0f, 360f),
                    Scale = rng.Range(run.FillerScaleMin, run.FillerScaleMax),
                    Sink = k_FillerSink,
                    NormalAlign = k_FillerNormalAlign,
                    Tilt = rng.Range(0f, k_FillerTiltJitter),
                    TiltDirection = rng.Range(0f, 360f),
                });
            }
        }

        /// <summary>Points every <paramref name="step"/> metres along a polyline, both ends included.</summary>
        public static List<Vector2> SamplePolyline(Vector2[] nodes, float step)
        {
            List<Vector2> points = new List<Vector2>();
            float carried = 0f;

            for (int i = 0; i + 1 < nodes.Length; i++)
            {
                Vector2 a = nodes[i];
                Vector2 b = nodes[i + 1];
                float length = Vector2.Distance(a, b);

                if (length <= Mathf.Epsilon)
                {
                    continue;
                }

                for (float travelled = carried; travelled < length; travelled += step)
                {
                    points.Add(Vector2.Lerp(a, b, travelled / length));
                }

                carried = Mathf.Repeat(carried - length, step);
            }

            points.Add(nodes[nodes.Length - 1]);
            return points;
        }

        // -------------------------------------------------------------------------------------------------
        // Scatter patches
        // -------------------------------------------------------------------------------------------------

        /// <summary>
        /// Rejection-samples <see cref="ScatterPatch.Count"/> positions inside the patch's annulus wedge.
        /// A candidate has to clear the clip box, the route corridor, the clump mask and every instance the
        /// patch has already accepted.
        /// </summary>
        public static void BuildPatch(ScatterPatch patch, Vector2[] route, List<PropInstance> into,
            IGroundFilter filter = null)
        {
            if (patch.Prefabs == null || patch.Prefabs.Length == 0 || patch.Count <= 0)
            {
                return;
            }

            Rng rng = new Rng(patch.Seed);
            List<Vector2> accepted = new List<Vector2>(patch.Count);
            int budget = patch.Count * k_CandidatesPerInstance;
            float spacingSqr = patch.MinSpacing * patch.MinSpacing;

            for (int attempt = 0; attempt < budget && accepted.Count < patch.Count; attempt++)
            {
                // Uniform over the annulus: the square root keeps the outer ring from being starved.
                float t = rng.Value();
                float radius = Mathf.Sqrt(Mathf.Lerp(patch.InnerRadius * patch.InnerRadius,
                    patch.OuterRadius * patch.OuterRadius, t));
                float angle = rng.Range(0f, 360f);

                if (!InArc(angle, patch.ArcMin, patch.ArcMax))
                {
                    continue;
                }

                float radians = angle * Mathf.Deg2Rad;
                Vector2 position = patch.Center + new Vector2(Mathf.Sin(radians), Mathf.Cos(radians)) * radius;

                if (position.x < patch.XRange.x || position.x > patch.XRange.y
                    || position.y < patch.ZRange.x || position.y > patch.ZRange.y)
                {
                    continue;
                }

                if (patch.RouteClearance > 0f && DistanceToRoute(route, position) < patch.RouteClearance)
                {
                    continue;
                }

                if (patch.ClumpThreshold > 0f && Clump(position, patch.ClumpFrequency, patch.Seed)
                    < patch.ClumpThreshold)
                {
                    continue;
                }

                if (filter != null && !filter.Accepts(position, patch.MaxSlopeDegrees, patch.TerrainLayer,
                    patch.MinLayerWeight))
                {
                    continue;
                }

                if (TooClose(accepted, position, spacingSqr))
                {
                    continue;
                }

                accepted.Add(position);

                into.Add(new PropInstance
                {
                    Prefab = patch.Prefabs[rng.Next(patch.Prefabs.Length)],
                    Pool = patch.Pool,
                    Group = patch.Name,
                    Position = position,
                    Yaw = rng.Range(0f, 360f),
                    Scale = rng.Range(patch.ScaleMin, patch.ScaleMax),
                    Sink = rng.Range(patch.SinkMin, patch.SinkMax),
                    NormalAlign = patch.NormalAlign,
                    Tilt = rng.Range(0f, patch.TiltJitter),
                    TiltDirection = rng.Range(0f, 360f),
                });
            }
        }

        private static bool TooClose(List<Vector2> accepted, Vector2 position, float spacingSqr)
        {
            if (spacingSqr <= 0f)
            {
                return false;
            }

            for (int i = 0; i < accepted.Count; i++)
            {
                if ((accepted[i] - position).sqrMagnitude < spacingSqr)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>True when <paramref name="angle"/> is inside the wedge, wrapping through 360.</summary>
        public static bool InArc(float angle, float min, float max)
        {
            if (max - min >= 360f)
            {
                return true;
            }

            float a = Mathf.Repeat(angle, 360f);
            float lo = Mathf.Repeat(min, 360f);
            float hi = Mathf.Repeat(max, 360f);

            return lo <= hi ? a >= lo && a <= hi : a >= lo || a <= hi;
        }

        /// <summary>Shortest distance from a world XZ point to the route polyline, in metres.</summary>
        public static float DistanceToRoute(Vector2[] route, Vector2 position)
        {
            if (route == null || route.Length == 0)
            {
                return float.MaxValue;
            }

            if (route.Length == 1)
            {
                return Vector2.Distance(route[0], position);
            }

            float best = float.MaxValue;

            for (int i = 0; i + 1 < route.Length; i++)
            {
                best = Mathf.Min(best, DistanceToSegment(route[i], route[i + 1], position));
            }

            return best;
        }

        private static float DistanceToSegment(Vector2 a, Vector2 b, Vector2 point)
        {
            Vector2 ab = b - a;
            float lengthSqr = ab.sqrMagnitude;

            if (lengthSqr <= Mathf.Epsilon)
            {
                return Vector2.Distance(a, point);
            }

            float t = Mathf.Clamp01(Vector2.Dot(point - a, ab) / lengthSqr);
            return Vector2.Distance(a + ab * t, point);
        }

        /// <summary>
        /// Patchiness mask in 0..1. Offsetting by the seed gives each patch its own lobes, so two patches
        /// sharing an area do not clump into the same spots.
        /// </summary>
        public static float Clump(Vector2 position, float frequency, int seed)
        {
            float offset = (seed % 977) * 3.137f;
            return Mathf.PerlinNoise(position.x * frequency + offset, position.y * frequency + offset);
        }

        /// <summary>
        /// Yaw, in degrees, that turns a model's local +X axis onto <paramref name="direction"/> — the axis
        /// the fence panels and the concrete barrier are modelled along.
        /// </summary>
        public static float YawAlongX(Vector2 direction)
        {
            return Mathf.Atan2(-direction.y, direction.x) * Mathf.Rad2Deg;
        }

        /// <summary>Yaw, in degrees, that turns a model's local +Z axis onto <paramref name="direction"/>.</summary>
        public static float YawAlongZ(Vector2 direction)
        {
            return Mathf.Atan2(direction.x, direction.y) * Mathf.Rad2Deg;
        }

        /// <summary>
        /// A tiny deterministic PRNG (xorshift32). <see cref="UnityEngine.Random"/> would tie the layout to
        /// global engine state shared with everything else running in the Editor.
        /// </summary>
        private struct Rng
        {
            private uint m_state;

            public Rng(int seed)
            {
                m_state = (uint)seed;

                if (m_state == 0u)
                {
                    m_state = 0x9E3779B9u;
                }
            }

            public uint NextUInt()
            {
                m_state ^= m_state << 13;
                m_state ^= m_state >> 17;
                m_state ^= m_state << 5;
                return m_state;
            }

            /// <summary>Uniform in [0, 1).</summary>
            public float Value()
            {
                return (NextUInt() & 0xFFFFFFu) / 16777216f;
            }

            /// <summary>Uniform in [0, <paramref name="exclusiveMax"/>).</summary>
            public int Next(int exclusiveMax)
            {
                return exclusiveMax <= 0 ? 0 : (int)(NextUInt() % (uint)exclusiveMax);
            }

            public float Range(float min, float max)
            {
                return min + (max - min) * Value();
            }

            /// <summary>
            /// Uniform integer in [<paramref name="minInclusive"/>, <paramref name="maxInclusive"/>].
            /// </summary>
            public int RangeInt(int minInclusive, int maxInclusive)
            {
                if (maxInclusive <= minInclusive)
                {
                    return minInclusive;
                }

                int span = maxInclusive - minInclusive + 1;
                return Mathf.Min(minInclusive + (int)(Value() * span), maxInclusive);
            }
        }
    }
}
