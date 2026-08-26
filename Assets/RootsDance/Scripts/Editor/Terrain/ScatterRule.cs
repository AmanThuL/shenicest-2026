using System;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>One scatter rule: which prefabs, in which ring band, how dense, and what to keep clear of.</summary>
    [Serializable]
    public class ScatterRule
    {
        public string Name = "Rule";
        /// <summary>
        /// Prefab keys (== prefab file names) picked per instance, weighted by <see cref="PrefabWeights"/>.
        /// </summary>
        public string[] PrefabKeys;
        /// <summary>
        /// Optional weights parallel to <see cref="PrefabKeys"/>; null or mismatched length = uniform.
        /// </summary>
        public float[] PrefabWeights;
        /// <summary>Band in noisy warped radius, in metres (inclusive min, exclusive max).</summary>
        public float RadiusMin;
        public float RadiusMax = 1000f;
        /// <summary>Candidates per 100 m² before rejection.</summary>
        public float Density = 3f;
        /// <summary>Minimum distance between accepted instances of this rule, in metres.</summary>
        public float MinSpacing = 3f;
        public float ScaleMin = 0.9f;
        public float ScaleMax = 1.2f;
        public float MaxSlopeDegrees = 35f;
        /// <summary>
        /// Perlin patchiness: candidates where noise &lt; threshold are dropped. Zero disables clumping.
        /// </summary>
        public float ClumpThreshold;
        public float ClumpFrequency = 0.03f;
        /// <summary>Metres kept clear beyond each path's HalfWidth + Blend.</summary>
        public float RouteClearance = 1f;
        /// <summary>
        /// Distance from a path over which density ramps from <see cref="RouteThinningFactor"/> to one; zero
        /// disables.
        /// </summary>
        public float RouteThinningDistance;
        public float RouteThinningFactor = 1f;
        /// <summary>Metres kept clear outside the terrace outline (negative allows overlap).</summary>
        public float TerraceClearance = 2f;
        public float FlatSpotClearance = 1f;
        /// <summary>Metres kept clear from the terrain edge.</summary>
        public float EdgeMargin = 6f;
        /// <summary>
        /// Optional disc limit: when <see cref="AreaRadius"/> &gt; 0, candidates farther than
        /// <see cref="AreaRadius"/> from this world XZ centre are rejected.
        /// </summary>
        public Vector2 AreaCenter;
        /// <summary>
        /// Optional disc limit: when AreaRadius &gt; 0, candidates farther than AreaRadius from
        /// <see cref="AreaCenter"/> are rejected. Zero = no limit.
        /// </summary>
        public float AreaRadius;
        /// <summary>Tilt the instance to the ground normal (rocks, logs) instead of staying upright (trees).</summary>
        public bool AlignToSlope;
        /// <summary>How far the pivot sinks below the ground, in metres, to hide floating edges.</summary>
        public float SinkDepth = 0.05f;
    }

    /// <summary>One placed instance produced by <see cref="TerrainScatterGenerator"/>.</summary>
    [Serializable]
    public struct ScatterInstance
    {
        public string PrefabKey;
        /// <summary>
        /// World position; Y is the generator's height sample (the builder re-samples the real terrain).
        /// </summary>
        public Vector3 Position;
        public float YawDegrees;
        public float Scale;
        public Vector3 GroundNormal;
    }
}
