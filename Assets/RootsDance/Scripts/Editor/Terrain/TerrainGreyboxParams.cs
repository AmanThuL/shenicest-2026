using System;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// One node of the radial height profile: the ground height at a given warped radius from the ring centre.
    /// </summary>
    [Serializable]
    public struct RadialNode
    {
        /// <summary>Warped radius from the ring centre, in metres.</summary>
        public float Radius;

        /// <summary>World height at that radius, in metres.</summary>
        public float Height;
    }

    /// <summary>
    /// A circular patch that flattens the terrain to a fixed height, with a smooth falloff ring around it.
    /// </summary>
    [Serializable]
    public struct FlatSpot
    {
        /// <summary>Centre in world XZ (x = world X, y = world Z), in metres.</summary>
        public Vector2 Center;

        /// <summary>Radius of the fully flattened core, in metres.</summary>
        public float Radius;

        /// <summary>Width of the falloff ring outside <see cref="Radius"/>, in metres.</summary>
        public float Blend;

        /// <summary>World height the core is flattened to, in metres.</summary>
        public float Height;
    }

    /// <summary>
    /// One node of a walkable height path: a world XZ position and the height the path carries there.
    /// </summary>
    [Serializable]
    public struct PathNode
    {
        /// <summary>Position in world XZ (x = world X, y = world Z), in metres.</summary>
        public Vector2 Position;

        /// <summary>World height the path carries at this node, in metres.</summary>
        public float Height;
    }

    /// <summary>
    /// A polyline that carves a walkable corridor into the terrain, interpolating height between its nodes.
    /// </summary>
    [Serializable]
    public class HeightPath
    {
        /// <summary>Ordered nodes of the polyline; at least two are needed for a corridor.</summary>
        public PathNode[] Nodes;

        /// <summary>Half width of the fully carved corridor, in metres.</summary>
        public float HalfWidth;

        /// <summary>Width of the falloff outside <see cref="HalfWidth"/>, in metres.</summary>
        public float Blend;
    }

    /// <summary>
    /// Value object holding every tunable of the greybox terrain. Pure data: no Unity object references, so both
    /// the generators and their EditMode tests can build one without a scene.
    /// </summary>
    [Serializable]
    public class TerrainGreyboxParams
    {
        /// <summary>World-space position of the terrain box corner (minimum X, base Y, minimum Z), in metres.</summary>
        public Vector3 TerrainPosition = new Vector3(-144f, -8f, -32f);

        /// <summary>Size of the terrain box (width, height, depth), in metres.</summary>
        public Vector3 TerrainSize = new Vector3(288f, 48f, 288f);

        /// <summary>Heightmap resolution; Unity requires 2^n + 1.</summary>
        public int HeightmapResolution = 513;

        /// <summary>Alphamap (splatmap) resolution; Unity requires a power of two.</summary>
        public int AlphamapResolution = 512;

        /// <summary>Centre of the concentric ring composition in world XZ (x = world X, y = world Z).</summary>
        public Vector2 RingCenter = new Vector2(0f, 112f);

        /// <summary>Amplitude of the three-lobe warp applied to the polar radius, in metres.</summary>
        public float RingWarpAmplitude = 5f;

        /// <summary>Amplitude of the five-lobe warp applied to the polar radius, in metres.</summary>
        public float RingWarpAmplitudeFine = 3f;

        /// <summary>Phase of the radius warp, in radians.</summary>
        public float RingWarpPhase = 0.7f;

        /// <summary>South-half radial height profile, radius ascending.</summary>
        public RadialNode[] RadialProfile;

        /// <summary>Extra height added by the backdrop rise north of the lab, in metres.</summary>
        public float NorthRiseHeight = 12f;

        /// <summary>World Z where the backdrop rise starts, in metres.</summary>
        public float NorthRiseStartZ = 150f;

        /// <summary>World Z where the backdrop rise reaches its full height, in metres.</summary>
        public float NorthRiseEndZ = 250f;

        /// <summary>Centre of the lab terrace in world XZ (x = world X, y = world Z).</summary>
        public Vector2 TerraceCenter = new Vector2(0f, 126f);

        /// <summary>
        /// Half extents of the lab terrace rectangle before rounding, in metres: the V2 lab blockout's
        /// local half size (33.05, 35.70) at import scale 0.4 plus a 6 m margin. The greybox builder
        /// overwrites it with the value it derives from the lab's own bounds.
        /// </summary>
        public Vector2 TerraceHalfExtents = new Vector2(44.5f, 31.5f);

        /// <summary>
        /// Yaw of the lab terrace around world Y, in degrees, with the <c>Quaternion.Euler(0, yaw, 0)</c>
        /// convention (the terrace's local +X is that rotation applied to world +X). The greybox builder
        /// overwrites it with the lab's yaw when it derives the terrace from the lab blockout.
        /// </summary>
        public float TerraceYawDegrees;

        /// <summary>Corner radius of the rounded terrace rectangle, in metres.</summary>
        public float TerraceCornerRadius = 12f;

        /// <summary>Flat world height of the lab terrace, in metres.</summary>
        public float TerraceHeight = 7f;

        /// <summary>Width of the falloff outside the terrace outline, in metres.</summary>
        public float TerraceBlend = 8f;

        /// <summary>Local circular flattening patches applied after the terrace.</summary>
        public FlatSpot[] FlatSpots;

        /// <summary>Walkable corridors applied last, overriding everything underneath them.</summary>
        public HeightPath[] Paths;

        /// <summary>Amplitude of the Perlin detail noise, in metres (peak deviation from the profile).</summary>
        public float DetailNoiseAmplitude = 0.5f;

        /// <summary>Frequency of the Perlin detail noise, in cycles per metre.</summary>
        public float DetailNoiseFrequency = 0.04f;

        /// <summary>Warped radius of the boundary between layer A and layer B, in metres.</summary>
        public float RingRadiusAB = 112f;

        /// <summary>Warped radius of the boundary between layer B and layer C, in metres.</summary>
        public float RingRadiusBC = 90f;

        /// <summary>Warped radius of the boundary between layer C and layer D, in metres.</summary>
        public float RingRadiusCD = 68f;

        /// <summary>Warped radius of the boundary between layer D and layer E, in metres.</summary>
        public float RingRadiusDE = 55f;

        /// <summary>Width of the crossfade between neighbouring splat rings, in metres.</summary>
        public float SplatBlend = 8f;

        /// <summary>Amplitude of the low-frequency Perlin offset applied to ring boundaries, in metres.</summary>
        public float BandNoiseAmplitude = 10f;

        /// <summary>Frequency of the ring-boundary offset noise, in cycles per metre.</summary>
        public float BandNoiseFrequency = 0.015f;

        /// <summary>
        /// Extra half-width the trail splat layer adds beyond each path's <c>HalfWidth</c>, in metres.
        /// </summary>
        public float TrailExtraWidth = 1f;

        /// <summary>
        /// Builds the spec defaults: the radial profile, the three flat spots and the two height paths that the
        /// greybox layout is measured against.
        /// </summary>
        /// <returns>A new parameter object holding the spec values.</returns>
        public static TerrainGreyboxParams CreateDefault()
        {
            TerrainGreyboxParams parameters = new TerrainGreyboxParams();

            parameters.RadialProfile = new[]
            {
                new RadialNode { Radius = 0f,   Height = 7f },
                new RadialNode { Radius = 44f,  Height = 7f },
                new RadialNode { Radius = 52f,  Height = 6f },
                new RadialNode { Radius = 60f,  Height = 5f },   // D saddle
                new RadialNode { Radius = 68f,  Height = 5.6f },
                new RadialNode { Radius = 74f,  Height = 6f },   // C grass platform
                new RadialNode { Radius = 82f,  Height = 6.2f },
                new RadialNode { Radius = 90f,  Height = 5.4f },
                new RadialNode { Radius = 100f, Height = 4f },   // B valley
                new RadialNode { Radius = 112f, Height = 8f },   // A/B ridge
                new RadialNode { Radius = 122f, Height = 3f },   // wake lowland
                new RadialNode { Radius = 130f, Height = 4f },
                new RadialNode { Radius = 137f, Height = 8f },
                new RadialNode { Radius = 150f, Height = 14f },  // soft boundary wall
                new RadialNode { Radius = 200f, Height = 18f },
            };

            parameters.FlatSpots = new[]
            {
                // Wake pad: wide enough to read as a deserted clearing (§7 P1); its influence ends 15 m out,
                // short of the (-7, 4) ridge node, so the first climb and its slope test are untouched.
                new FlatSpot { Center = new Vector2(1.5f, -11f), Radius = 9.5f, Blend = 5.5f, Height = 3f },
                new FlatSpot { Center = new Vector2(-12f, 39f), Radius = 4f, Blend = 6f, Height = 6f },
                // The maintenance entrance sits below Greenhouse Door12's main floor. A local cut at Y=5
                // makes the sign's "down" clue spatially true without moving any building in the Gaia group.
                new FlatSpot { Center = new Vector2(21.8f, 137.5f), Radius = 3f, Blend = 6f, Height = 5f },
            };

            // Nodes up to (0, 66) are the opening route and stay bit-identical. From there the path is
            // checkpoint-led: the facility-view station frames the fixed Gaia complex, then the route
            // approaches the blocked main entrance without exposing the maintenance clue branch early.
            HeightPath mainRoute = new HeightPath
            {
                HalfWidth = 2.5f,
                Blend = 4f,
                Nodes = new[]
                {
                    new PathNode { Position = new Vector2(0f, -10f),  Height = 3f },
                    new PathNode { Position = new Vector2(-7f, 4f),   Height = 7f },
                    new PathNode { Position = new Vector2(-15f, 18f), Height = 4f },
                    new PathNode { Position = new Vector2(-16f, 28f), Height = 5.2f },
                    new PathNode { Position = new Vector2(-12f, 39f), Height = 6f },
                    new PathNode { Position = new Vector2(-6f, 52f),  Height = 5f },
                    new PathNode { Position = new Vector2(0f, 66f),   Height = 6.4f },
                    new PathNode { Position = new Vector2(1.5f, 73.5f), Height = 6.8f },
                    new PathNode { Position = new Vector2(4f, 88f), Height = 7f },
                    new PathNode { Position = new Vector2(7f, 103f), Height = 7f },
                    new PathNode { Position = new Vector2(9.505f, 118.941f), Height = 7f },
                }
            };

            // A short narrative spur makes the sign and poster optional discoveries after the player has
            // understood that the main entrance is blocked. It deliberately does not connect to the clue
            // path at its far end, so the building perimeter reads as exploration rather than a racetrack.
            HeightPath narrativeSpur = new HeightPath
            {
                HalfWidth = 2f,
                Blend = 3f,
                Nodes = new[]
                {
                    new PathNode { Position = new Vector2(9.505f, 118.941f), Height = 7f },
                    new PathNode { Position = new Vector2(7.03f, 115.759f), Height = 7f },
                    new PathNode { Position = new Vector2(1f, 113.8f), Height = 7f },
                    new PathNode { Position = new Vector2(-4.637f, 114.699f), Height = 7f },
                }
            };

            // The actual puzzle route starts at the failed main entrance. Every bend is a gameplay station:
            // common ashleaf vine, distinct fine-veined vine, growth-direction/fan view, covered entrance,
            // then the revealed maintenance door. No branch exists before the main-entrance checkpoint.
            HeightPath clueRoute = new HeightPath
            {
                HalfWidth = 2.25f,
                Blend = 3f,
                Nodes = new[]
                {
                    new PathNode { Position = new Vector2(9.505f, 118.941f), Height = 7f },
                    new PathNode { Position = new Vector2(12.334f, 123.184f), Height = 7f },
                    new PathNode { Position = new Vector2(15f, 127.8f), Height = 6.8f },
                    new PathNode { Position = new Vector2(19.435f, 133.774f), Height = 6.3f },
                    new PathNode { Position = new Vector2(20.7f, 135.8f), Height = 6f },
                    new PathNode { Position = new Vector2(21.8f, 137.5f), Height = 5f },
                }
            };

            parameters.Paths = new[] { mainRoute, narrativeSpur, clueRoute };

            return parameters;
        }
    }
}
