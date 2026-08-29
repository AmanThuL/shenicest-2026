using System;
using RootsDance.App;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    public enum Chapter00VegetationZone
    {
        A,
        B,
        C,
        D,
        E,
    }

    /// <summary>
    /// Placement semantics, kept separate from species. Only <see cref="PhysicalBlocker"/> is allowed to
    /// retain a collider; the other two layers are visual route language and may overlap the player route.
    /// </summary>
    public enum Chapter00VegetationRole
    {
        WalkThroughGroundCover,
        MidLayer,
        PhysicalBlocker,
    }

    public enum Chapter00VegetationTint
    {
        DeadAsh,
        HumusOlive,
        SilverGreyGreen,
        CoolCyanGreen,
        MutedViolet,
        FadedPink,
        CoolYellowGreen,
        StableGreen,
        FacilityGreen,
    }

    [Serializable]
    public struct Chapter00ViewEnvelope
    {
        public Vector2 Center;
        public float Radius;

        public Chapter00ViewEnvelope(Vector2 center, float radius)
        {
            Center = center;
            Radius = radius;
        }
    }

    /// <summary>One data-driven layer of a zone. All sizes are final world metres, never prefab scale.</summary>
    [Serializable]
    public sealed class Chapter00VegetationLayerSpec
    {
        public Chapter00VegetationZone Zone;
        public Chapter00VegetationRole Role;
        public string[] PrefabKeys;
        public float TargetHeightMin;
        public float TargetHeightMax;

        /// <summary>
        /// Ground cover derives pitch from the smallest scaled Renderer XZ footprint. A value of .12 means
        /// neighbouring footprints overlap by 12 percent. Mid/blocker layers use <see cref="Spacing"/>.
        /// </summary>
        public float FootprintOverlap;
        /// <summary>
        /// Explicit grid pitch for mid/blocker layers, and a lower bound for ground-cover pitch. C leaves this
        /// at zero so its broad patch Renderer footprint alone guarantees the authored overlap.
        /// </summary>
        public float Spacing;

        /// <summary>Clearance from the authored route. Ground cover deliberately uses zero.</summary>
        public float RouteClearance;

        /// <summary>Clearance around checkpoint player capsules. Ground cover deliberately uses zero.</summary>
        public float CheckpointClearance;

        /// <summary>
        /// Removes this physical layer from the upper-dome sightline. Keep this false for low root/rock
        /// barriers so a clear view does not accidentally become a walkable shortcut to another building.
        /// </summary>
        public bool CullFromDomeViewCone;

        public float NormalAlign;
        public int Seed;
    }

    /// <summary>
    /// Single source of placement data for the A-E vegetation pass. The zone boundaries mirror the terrain
    /// contract and are intentionally independent of the old rectangular <c>FillRegion</c> calls.
    /// </summary>
    [Serializable]
    public sealed class Chapter00ZoneVegetationParams
    {
        public const string k_PwbRootName = "Prefab World Builder";
        public const string k_PinName = "PIN";
        public const string k_OwnedPrefix = "C00V_";

        public const float k_RadiusAB = 112f;
        public const float k_RadiusBC = 90f;
        public const float k_RadiusCD = 68f;
        public const float k_RadiusDE = 55f;
        public const float k_OuterVisibleRadius = 137f;

        public string ScenePath = ScenePaths.k_MainEnvironment;
        public Vector2 RingCenter = new Vector2(0f, 112f);
        public Chapter00ViewEnvelope[] VisibleEnvelopes;
        public Vector2[][] Routes;
        public Vector2[] Corridor1Route;
        public Vector2[] Checkpoints;
        public Vector2[] DomeViewOrigins;
        public Vector2 DomeTarget;
        public float DomeViewHalfWidth = 10f;
        public float CorridorVisualHalfWidth = 2.5f;
        public Chapter00VegetationLayerSpec[] Layers;

        public static string PaletteName(Chapter00VegetationZone zone, Chapter00VegetationRole role)
        {
            if (zone == Chapter00VegetationZone.E)
            {
                return role == Chapter00VegetationRole.PhysicalBlocker
                    ? "ZoneE_NaturalBlockers"
                    : "ZoneE_Corridor1Ecology";
            }

            switch (zone)
            {
                case Chapter00VegetationZone.A: return "ZoneA_DeadGrowth";
                case Chapter00VegetationZone.B: return "ZoneB_Transition";
                case Chapter00VegetationZone.C: return "ZoneC_AnomalousCarpet";
                case Chapter00VegetationZone.D: return "ZoneD_StableEcology";
                default: throw new ArgumentOutOfRangeException(nameof(zone), zone, null);
            }
        }

        public static Chapter00ZoneVegetationParams CreateDefault()
        {
            Chapter00ZoneVegetationParams p = new Chapter00ZoneVegetationParams();

            // These overlapping discs are the union of first-person visibility around the authored route and
            // checkpoints. They replace the previous axis-aligned rectangles and stop us filling terrain the
            // player can never see while leaving visible corners bare.
            p.VisibleEnvelopes = new[]
            {
                new Chapter00ViewEnvelope(new Vector2(0f, -10f), 31f),
                new Chapter00ViewEnvelope(new Vector2(-11f, 10f), 31f),
                new Chapter00ViewEnvelope(new Vector2(-14f, 31f), 33f),
                new Chapter00ViewEnvelope(new Vector2(-6f, 54f), 34f),
                new Chapter00ViewEnvelope(new Vector2(0f, 77f), 35f),
                new Chapter00ViewEnvelope(new Vector2(14f, 94f), 38f),
                new Chapter00ViewEnvelope(new Vector2(13f, 113f), 44f),
                new Chapter00ViewEnvelope(new Vector2(8f, 132f), 46f),
            };

            Vector2[] approach =
            {
                new Vector2(0f, -10f), new Vector2(-7f, 4f), new Vector2(-15f, 18f),
                new Vector2(-16f, 28f), new Vector2(-12f, 39f), new Vector2(-6f, 52f),
                new Vector2(0f, 66f), new Vector2(1.5f, 73.5f), new Vector2(8f, 82f),
                new Vector2(16f, 88f), new Vector2(24f, 92.5f), new Vector2(30f, 96.2f),
            };
            Vector2[] narrative =
            {
                new Vector2(30f, 96.2f), new Vector2(25.8f, 95.5f), new Vector2(23f, 97.8f),
            };
            Vector2[] clue =
            {
                new Vector2(30f, 96.2f), new Vector2(33.8f, 97.5f), new Vector2(35.8f, 100.8f),
                new Vector2(36.4f, 104f), new Vector2(37f, 106f),
            };
            p.Corridor1Route = new[]
            {
                new Vector2(0f, 66f), new Vector2(1.5f, 73.5f), new Vector2(8f, 82f),
                new Vector2(16f, 88f), new Vector2(24f, 92.5f), new Vector2(30f, 96.2f),
                new Vector2(33.8f, 97.5f), new Vector2(35.8f, 100.8f),
                new Vector2(36.4f, 104f), new Vector2(37f, 106f),
            };
            p.Routes = new[] { approach, narrative, clue };
            p.Checkpoints = new[]
            {
                new Vector2(-16f, 28f), new Vector2(-12f, 39f), new Vector2(1.5f, 73.5f),
                new Vector2(30f, 96.2f), new Vector2(25.8f, 95.5f), new Vector2(23f, 97.8f),
                new Vector2(33.8f, 97.5f), new Vector2(35.8f, 100.8f),
                new Vector2(36.4f, 104f), new Vector2(37f, 106f), new Vector2(37f, 106f),
            };

            // Builder replaces the target with the current facility upper bounds when it can resolve them.
            p.DomeTarget = new Vector2(-3.5f, 132.3f);
            p.DomeViewOrigins = new[]
            {
                new Vector2(1.5f, 73.5f), new Vector2(16f, 88f), new Vector2(30f, 96.2f),
            };
            p.Layers = CreateLayers();
            return p;
        }

        private static Chapter00VegetationLayerSpec[] CreateLayers()
        {
            string[] niwlGrass =
            {
                "M3D_grass_patch_1", "M3D_grass_patch_2", "M3D_grass_patch_3",
                "M3D_grass_patch_4", "M3D_grass_patch_5", "M3D_grass_patch_6",
                "M3D_grass_patch_7", "M3D_grass_patch_8",
            };
            string[] patchGrass =
            {
                "grass_patch", "grass_patch_viridian", "grass_patch_cyan", "grass_patch_violet",
                "grass_patch_amber", "grass_patch_rose", "grass_patch_silver", "grass_patch_corner",
                "grass_patch_corner_cyan", "grass_patch_corner_violet", "grass_patch_corner_amber",
            };
            string[] anomalousPatchGrass =
            {
                "grass_patch_viridian", "grass_patch_cyan", "grass_patch_violet",
                "grass_patch_amber", "grass_patch_rose", "grass_patch_silver",
                "grass_patch_corner_cyan", "grass_patch_corner_violet", "grass_patch_corner_amber",
            };
            string[] grassVariety =
            {
                "grass01", "grass02", "grass03", "grass04", "grass05", "grass06", "grass07",
                "grass08", "grass09", "grass_bush", "M3D_meadown", "M3D_poppy-1", "M3D_poppy2",
                "M3D_sunflower", "M3D_ivy_6", "M3D_ivy_7", "M3D_ivy_8",
            };
            string[] dryGrass = { "M3D_grass_patch_6", "M3D_grass_patch_7", "M3D_grass_patch_8" };
            string[] fern = { "M3D_fern-1", "M3D_fern-2" };
            string[] liveBush = { "M3D_bush-1", "M3D_bush-2", "M3D_bush-3", "M3D_bush-4" };
            string[] deadBush =
            {
                "bush01_winter", "bush02_winter", "bush03_winter", "bush04_winter",
                "bush05_winter", "bush06_winter", "bush07", "bush08",
            };
            string[] trees =
            {
                "tree01_winter", "tree02_winter", "tree03_winter",
                "tree04_winter", "tree05_winter", "tree06_winter",
            };
            string[] summerTrees =
            {
                "tree01_summer", "tree02_summer", "tree03_summer", "tree04_summer",
                "tree05_summer", "tree06_summer", "tree07_summer", "tree08_summer",
                "M3D_alder_1", "M3D_alder_2", "M3D_alder_3", "M3D_birch-tree-1",
                "M3D_birch-tree-2", "M3D_birch-tree-3", "M3D_pine",
            };
            string[] summerBushes =
            {
                "bush01_summer", "bush02_summer", "bush03_summer",
                "bush04_summer", "bush05_summer", "bush06_summer",
            };
            string[] rootsAndRocks =
            {
                "pine_roots", "root_cluster_01", "root_cluster_02", "single_root",
                "rock_moss_01", "rock_moss_02", "rock_moss_03", "rock_moss_04",
                "rock_moss_05", "rock_moss_06",
            };

            return new[]
            {
                Layer(Chapter00VegetationZone.A, Chapter00VegetationRole.WalkThroughGroundCover,
                    dryGrass, .20f, .45f, .15f, .65f, 0f, 0f, .65f, 5101),
                Layer(Chapter00VegetationZone.A, Chapter00VegetationRole.MidLayer,
                    deadBush, .55f, 1.25f, 0f, 1.8f, 1.4f, 2.2f, .35f, 5102),
                Layer(Chapter00VegetationZone.A, Chapter00VegetationRole.PhysicalBlocker,
                    trees, 4.8f, 8.2f, 0f, 3.9f, 3.2f, 3f, .1f, 5103),

                Layer(Chapter00VegetationZone.B, Chapter00VegetationRole.WalkThroughGroundCover,
                    Combine(dryGrass, new[] { "grass_patch", "grass_patch_corner", "grass_bush" }),
                    .20f, .50f, .20f, .55f, 0f, 0f, .7f, 5201),
                Layer(Chapter00VegetationZone.B, Chapter00VegetationRole.MidLayer,
                    Combine(fern, deadBush, summerBushes, liveBush), .4f, 1.15f, 0f, 1.7f, 1.25f, 2.2f, .45f, 5202),
                Layer(Chapter00VegetationZone.B, Chapter00VegetationRole.PhysicalBlocker,
                    Combine(trees, summerTrees), 4.5f, 7.5f, 0f, 4.1f, 3.1f, 3f, .15f, 5203),
                Layer(Chapter00VegetationZone.B, Chapter00VegetationRole.PhysicalBlocker,
                    rootsAndRocks, .8f, 2.2f, 0f, 3.2f, 3.1f, 3f, .65f, 5204),

                // C ground cover has no route clearance by design. The second art-direction pass reduces the
                // previous layout by roughly one third while retaining slight footprint overlap.
                Layer(Chapter00VegetationZone.C, Chapter00VegetationRole.WalkThroughGroundCover,
                    anomalousPatchGrass, .25f, .55f, .12f, 0f, 0f, 0f, .7f, 5301),
                Layer(Chapter00VegetationZone.C, Chapter00VegetationRole.MidLayer,
                    Combine(grassVariety, fern, liveBush), .55f, .85f, 0f, 2.10f, 1.4f, 2.2f, .5f, 5302),
                Layer(Chapter00VegetationZone.C, Chapter00VegetationRole.PhysicalBlocker,
                    rootsAndRocks, .65f, 1.1f, 0f, 6f, 6.5f, 4.5f, .65f, 5303),

                Layer(Chapter00VegetationZone.D, Chapter00VegetationRole.WalkThroughGroundCover,
                    Combine(patchGrass, niwlGrass), .15f, .40f, .24f, .60f, 0f, 0f, .75f, 5401),
                Layer(Chapter00VegetationZone.D, Chapter00VegetationRole.MidLayer,
                    Combine(fern, summerBushes, liveBush), .45f, 1.05f, 0f, 1.65f, 1.25f, 2.2f, .5f, 5402),
                Layer(Chapter00VegetationZone.D, Chapter00VegetationRole.PhysicalBlocker,
                    summerTrees, 4.5f, 7.2f, 0f, 4f, 3.2f, 3f, .15f, 5403, true),
                Layer(Chapter00VegetationZone.D, Chapter00VegetationRole.PhysicalBlocker,
                    rootsAndRocks, .8f, 2.2f, 0f, 3.1f, 3.2f, 3f, .65f, 5404, true),

                Layer(Chapter00VegetationZone.E, Chapter00VegetationRole.WalkThroughGroundCover,
                    Combine(patchGrass, niwlGrass), .15f, .35f, .25f, .65f, 0f, 0f, .75f, 5501),
                Layer(Chapter00VegetationZone.E, Chapter00VegetationRole.MidLayer,
                    Combine(fern, summerBushes, liveBush), .7f, 1.6f, 0f, 1.45f, 2.5f, 2.2f, .45f, 5502),
                // Two staggered physical layers form a visible 3-6 m deep wall outside Corridor 1.
                Layer(Chapter00VegetationZone.E, Chapter00VegetationRole.PhysicalBlocker,
                    summerTrees, 5.5f, 9f, 0f, 3.1f, 4.5f, 4f, .08f, 5503, true),
                Layer(Chapter00VegetationZone.E, Chapter00VegetationRole.PhysicalBlocker,
                    rootsAndRocks, 1.0f, 1.8f, 0f, 1.25f, 4.5f, 6.5f, .65f, 5504),
            };
        }

        private static Chapter00VegetationLayerSpec Layer(
            Chapter00VegetationZone zone,
            Chapter00VegetationRole role,
            string[] keys,
            float minHeight,
            float maxHeight,
            float overlap,
            float spacing,
            float routeClearance,
            float checkpointClearance,
            float normalAlign,
            int seed,
            bool cullFromDomeViewCone = false)
        {
            return new Chapter00VegetationLayerSpec
            {
                Zone = zone,
                Role = role,
                PrefabKeys = keys,
                TargetHeightMin = minHeight,
                TargetHeightMax = maxHeight,
                FootprintOverlap = overlap,
                Spacing = spacing,
                RouteClearance = routeClearance,
                CheckpointClearance = checkpointClearance,
                CullFromDomeViewCone = cullFromDomeViewCone,
                NormalAlign = normalAlign,
                Seed = seed,
            };
        }

        private static string[] Combine(params string[][] arrays)
        {
            int count = 0;
            for (int i = 0; i < arrays.Length; i++) count += arrays[i].Length;
            string[] result = new string[count];
            int offset = 0;
            for (int i = 0; i < arrays.Length; i++)
            {
                Array.Copy(arrays[i], 0, result, offset, arrays[i].Length);
                offset += arrays[i].Length;
            }
            return result;
        }
    }
}
