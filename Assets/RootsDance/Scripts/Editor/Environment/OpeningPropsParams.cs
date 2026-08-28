using System;
using RootsDance.App;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// The six PWB palettes the opening段 is dressed from. The enum name is only an identifier; the palette
    /// name written into the scene hierarchy comes from <see cref="OpeningPropsParams.PaletteName"/>.
    /// </summary>
    public enum PropPool
    {
        DeadTreeSparse = 0,
        RootRockClutter = 1,
        DryLowGrowth = 2,
        TransitionGrowth = 3,
        BrokenBoundary = 4,
        CampEvidence = 5,
    }

    /// <summary>One hand-placed prop: a hero silhouette or a piece of the survey camp.</summary>
    [Serializable]
    public class PropAnchor
    {
        /// <summary>Prefab key (the prefab file name), resolved through <c>EnvironmentPrefabBuilder</c>.</summary>
        public string Prefab;

        public PropPool Pool;

        /// <summary>World XZ; the ground height is sampled from the terrain.</summary>
        public Vector2 Position;

        /// <summary>Yaw around +Y, in degrees.</summary>
        public float Yaw;

        /// <summary>
        /// Euler applied inside the yaw, used to re-orient a model off its authored axis — (0, 0, 90) stands a
        /// lying trunk up, (90, 0, 0) tips an upright tube over, (-90, 0, 0) lays a flat tool on the ground.
        /// </summary>
        public Vector3 ExtraEuler;

        public float Scale = 1f;

        /// <summary>Metres the prop is pushed below the ground, hiding its base and reading as half-buried.</summary>
        public float Sink;

        /// <summary>0 keeps the prop upright, 1 lays it fully into the ground normal.</summary>
        public float NormalAlign;
    }

    /// <summary>
    /// One procedural cluster: candidates are drawn inside an annulus (optionally a wedge of it), thinned by
    /// a Perlin clump mask, then rejected on spacing, route clearance, slope and painted terrain layer.
    /// </summary>
    [Serializable]
    public class ScatterPatch
    {
        public string Name;
        public PropPool Pool;

        /// <summary>Prefab keys drawn from uniformly.</summary>
        public string[] Prefabs;

        /// <summary>Annulus centre in world XZ.</summary>
        public Vector2 Center;

        public float InnerRadius;
        public float OuterRadius;

        /// <summary>How many instances to accept; the sampler gives up after a fixed candidate budget.</summary>
        public int Count;

        /// <summary>Minimum distance between two accepted instances of this patch, in metres.</summary>
        public float MinSpacing = 1.5f;

        public float ScaleMin = 0.9f;
        public float ScaleMax = 1.15f;

        /// <summary>0 upright, 1 fully aligned to the ground normal.</summary>
        public float NormalAlign;

        /// <summary>Maximum random tilt away from the resolved up axis, in degrees.</summary>
        public float TiltJitter;

        public float SinkMin;
        public float SinkMax;

        /// <summary>Candidates on ground steeper than this are rejected.</summary>
        public float MaxSlopeDegrees = 55f;

        /// <summary>Metres kept clear of the route polyline, so props never wall the walkable line in.</summary>
        public float RouteClearance;

        /// <summary>
        /// Wedge of the annulus, in degrees, measured like a Unity yaw from the centre (0 = +Z, growing
        /// towards +X). <c>ArcMin &gt; ArcMax</c> wraps through 360.
        /// </summary>
        public float ArcMin;

        public float ArcMax = 360f;

        /// <summary>World XZ clip box applied on top of the annulus.</summary>
        public Vector2 XRange = new Vector2(-1000f, 1000f);

        public Vector2 ZRange = new Vector2(-1000f, 1000f);

        /// <summary>
        /// Index of a terrain layer the candidate must be painted with, or -1 to ignore the splat map. This
        /// is what pins the anomalous grass to the band the terrain already paints instead of to a circle.
        /// </summary>
        public int TerrainLayer = -1;

        public float MinLayerWeight = 0.5f;

        /// <summary>Perlin clump mask: candidates below the threshold are dropped. 0 disables clumping.</summary>
        public float ClumpThreshold;

        public float ClumpFrequency = 0.06f;

        public int Seed;
    }

    /// <summary>
    /// A stretch of the old isolation line: posts on a fixed pitch along a polyline with a wire panel spanning
    /// each gap. Panels drop out at <see cref="GapChance"/> and everything leans, so a run reads as a failed
    /// boundary rather than a tidy corridor.
    /// </summary>
    [Serializable]
    public class FenceRun
    {
        public string Name;

        /// <summary>Polyline in world XZ; at least two nodes.</summary>
        public Vector2[] Nodes;

        /// <summary>Post pitch, in metres. 1 for <c>chainlink_panel</c>, 2 for <c>chainlink_panel_double</c>.</summary>
        public float ModuleLength = 1f;

        /// <summary>Prefab key of the panel spanning one module.</summary>
        public string PanelPrefab = "chainlink_panel";

        public string PostPrefab = "chainlink_post";

        /// <summary>Prefab key of the two end posts.</summary>
        public string EndPostPrefab = "chainlink_post_end";

        /// <summary>Probability that a module's panel is missing, leaving the posts standing.</summary>
        public float GapChance = 0.2f;

        /// <summary>
        /// Prefab keys placed in fence gaps, one per gap at its centre. Null or empty keeps gaps empty
        /// (the original behaviour).
        /// </summary>
        public string[] GapFillers;

        /// <summary>
        /// Longest gap in modules when a gap is drawn; 1 keeps single-module gaps. Posts strictly inside a
        /// longer gap are dropped, so the filler stands in a clear span.
        /// </summary>
        public int GapMaxModules = 1;

        /// <summary>Uniform scale range for fillers.</summary>
        public float FillerScaleMin = 0.9f;

        public float FillerScaleMax = 1.25f;

        /// <summary>Maximum random lean of a panel away from vertical, in degrees.</summary>
        public float PanelLean = 9f;

        /// <summary>Maximum random lean of a post away from vertical, in degrees.</summary>
        public float PostLean = 7f;

        /// <summary>Metres the pieces sink into the ground, so a leaning post keeps its foot buried.</summary>
        public float Sink = 0.06f;

        public int Seed;
    }

    /// <summary>One resolved instance, ready for the builder to look up, ground-snap and instantiate.</summary>
    [Serializable]
    public struct PropInstance
    {
        public string Prefab;
        public PropPool Pool;

        /// <summary>Name of the source anchor, patch or fence run; becomes the GameObject name prefix.</summary>
        public string Group;

        public Vector2 Position;
        public float Yaw;
        public Vector3 ExtraEuler;
        public float Scale;
        public float Sink;
        public float NormalAlign;

        /// <summary>Extra tilt away from the resolved up axis, in degrees, and the direction it tilts in.</summary>
        public float Tilt;

        public float TiltDirection;
    }

    /// <summary>
    /// Every tunable of the opening props pass. Pure data with no Unity object references, so the layout code
    /// and its EditMode tests share one definition — the same split
    /// <see cref="OpeningAtmosphereParams"/> uses.
    /// </summary>
    /// <remarks>
    /// The content mirrors the three concept images of
    /// <c>docs/design/00章前段环境设计_起始点至异色草带.md</c> §5/§6: the contamination zone at the wake
    /// lowland, the abandoned survey camp in the shallow valley, and the threshold in front of the anomalous
    /// grass band. Positions are world XZ on the greybox terrain, whose route runs
    /// (0,-10) → (-7,4) → (-15,18) → (-16,28) → (-12,39).
    /// </remarks>
    [Serializable]
    public class OpeningPropsParams
    {
        /// <summary>Root GameObject PWB parents everything it paints to, in the active scene.</summary>
        public const string k_PwbRootName = "Prefab World Builder";

        /// <summary>
        /// PWB sub-parent for the tool that placed the objects. PWB writes the
        /// <c>ToolController.Tool</c> enum name; the Pin tool is the one this pass imitates.
        /// </summary>
        public const string k_PwbToolName = "PIN";

        /// <summary>Terrain layer index of <c>TL_GrassBand</c>, the painted anomalous band.</summary>
        public const int k_GrassBandLayer = 2;

        public string ScenePath = ScenePaths.k_MainEnvironment;

        /// <summary>The route polyline in world XZ, used for clearance tests.</summary>
        public Vector2[] Route;

        public PropAnchor[] Anchors;
        public ScatterPatch[] Patches;
        public FenceRun[] Fences;

        /// <summary>Palette name PWB writes as the sub-parent of <see cref="k_PwbRootName"/>.</summary>
        public static string PaletteName(PropPool pool)
        {
            switch (pool)
            {
                case PropPool.DeadTreeSparse: return "DeadTree_Sparse";
                case PropPool.RootRockClutter: return "RootRock_Clutter";
                case PropPool.DryLowGrowth: return "DryLowGrowth";
                case PropPool.TransitionGrowth: return "Transition_Growth";
                case PropPool.BrokenBoundary: return "BrokenBoundary";
                case PropPool.CampEvidence: return "CampEvidence";
                default: return pool.ToString();
            }
        }

        // --- prefab groups -------------------------------------------------------------------------------
        private static readonly string[] k_DeadTrees =
        {
            "tree01_winter", "tree02_winter", "tree03_winter",
            "tree04_winter", "tree05_winter", "tree06_winter"
        };

        private static readonly string[] k_DeadBushes =
        {
            "bush01_winter", "bush02_winter", "bush03_winter",
            "bush04_winter", "bush05_winter", "bush06_winter"
        };

        private static readonly string[] k_Branches = { "dry_branches_medium_01" };

        private static readonly string[] k_SmallRocks =
        {
            "rock_moss_07", "rock_moss_08", "rock_moss_09", "rock_moss_10",
            "rock_moss_11", "rock_moss_12", "rock_moss_13"
        };

        private static readonly string[] k_BigRocks =
        {
            "rock_moss_01", "rock_moss_02", "rock_moss_03",
            "rock_moss_04", "rock_moss_05", "rock_moss_06"
        };

        private static readonly string[] k_Roots =
        {
            "pine_roots", "root_cluster_01", "root_cluster_02", "single_root"
        };

        /// <summary>Roots that stay ankle-high: §S1's exit corridor must not get a 4 m root wall.</summary>
        private static readonly string[] k_LowRoots =
        {
            "pine_roots", "root_cluster_02", "single_root"
        };

        private static readonly string[] k_DryGrowth =
        {
            "bush07", "bush08", "M3D_grass_patch_6", "M3D_grass_patch_7", "M3D_grass_patch_8"
        };

        private static readonly string[] k_Ferns = { "M3D_fern-1", "M3D_fern-2" };

        private static readonly string[] k_LiveBushes =
        {
            "M3D_bush-1", "M3D_bush-2", "M3D_bush-3", "M3D_bush-4"
        };

        private static readonly string[] k_Ivy = { "M3D_ivy_1", "M3D_ivy_2", "M3D_ivy_3", "M3D_ivy_4" };

        private static readonly string[] k_BandGrass =
        {
            "M3D_grass_patch_1", "M3D_grass_patch_2", "M3D_grass_patch_3",
            "M3D_grass_patch_4", "M3D_grass_patch_5"
        };

        /// <summary>Builds the authored opening dressing.</summary>
        public static OpeningPropsParams CreateDefault()
        {
            OpeningPropsParams p = new OpeningPropsParams();

            p.Route = new[]
            {
                new Vector2(0f, -10f),
                new Vector2(-7f, 4f),
                new Vector2(-15f, 18f),
                new Vector2(-16f, 28f),
                new Vector2(-12f, 39f),
            };

            p.Fences = CreateFences();
            p.Anchors = CreateAnchors();
            p.Patches = CreatePatches();
            return p;
        }

        // -------------------------------------------------------------------------------------------------
        // Fences — §S0 two short non-parallel runs framing the gap, §S1 the last remnant, §S2 scraps,
        // §S4 two panels on the saddle behind the camp, §S6 a run dying into the fog beside the band.
        // -------------------------------------------------------------------------------------------------
        private static FenceRun[] CreateFences()
        {
            return new[]
            {
                // §S0: a broken isolation ring around the wake pad (bearings clockwise from +Z, ~11-13 m
                // out). Every run is short, jittered and gap-filled by boulders, roots, trunks or barriers;
                // the breaks between runs are plugged by the hero anchors below. Only the wedge at
                // -45..-8° (towards the (-7, 4) bend) stays open, framed by two short non-parallel stubs.
                Ring("S0_Ring_Front", 1111, 0.32f,
                    new Vector2(-0.8f, 2.4f), new Vector2(2.2f, 0.3f), new Vector2(4.6f, 1.6f),
                    new Vector2(7.7f, -0.6f)),
                Ring("S0_Ring_East", 1112, 0.38f,
                    new Vector2(9.5f, -2.6f), new Vector2(11.4f, -6.3f), new Vector2(12.0f, -11.0f)),
                Ring("S0_Ring_SouthEast", 1113, 0.4f,
                    new Vector2(10.7f, -14.3f), new Vector2(8.8f, -17.4f), new Vector2(5.8f, -20.0f)),
                Ring("S0_Ring_South", 1114, 0.36f,
                    new Vector2(2.3f, -20.8f), new Vector2(-1.9f, -20.8f), new Vector2(-6.3f, -19.0f)),
                Ring("S0_Ring_West", 1115, 0.34f,
                    new Vector2(-11.3f, -14.1f), new Vector2(-12.1f, -10.4f), new Vector2(-11.8f, -7.9f)),
                Ring("S0_Frame_Left", 1116, 0.2f,
                    new Vector2(-10.4f, -6.4f), new Vector2(-8.6f, -3.6f)),
                new FenceRun
                {
                    // §S1: the most complete remnant only crosses the start of the bend, then a fallen trunk
                    // bends it down — the anchors below drop that trunk across this line.
                    Name = "S1_Bend_Remnant",
                    Nodes = new[] { new Vector2(-12.5f, -3.5f), new Vector2(-10.2f, -0.6f), new Vector2(-8.6f, 1.6f) },
                    GapChance = 0.3f, PanelLean = 17f, PostLean = 13f, Seed = 1103,
                },
                new FenceRun
                {
                    // §S2: man-made order visibly leaves the picture — two modules and nothing else.
                    Name = "S2_Ridge_Scrap",
                    Nodes = new[] { new Vector2(-11.4f, 6.2f), new Vector2(-9.6f, 8.0f) },
                    GapChance = 0.45f, PanelLean = 22f, PostLean = 17f, Seed = 1104,
                },
                new FenceRun
                {
                    // §S4 / concept image 2: two panels standing on the saddle behind the camp.
                    Name = "S4_Saddle_Panels",
                    Nodes = new[] { new Vector2(-13.8f, 25.2f), new Vector2(-11.6f, 26.4f) },
                    GapChance = 0.2f, PanelLean = 14f, PostLean = 11f, Seed = 1105,
                },
                new FenceRun
                {
                    // §S6 / concept image 3: the run recedes into the fog on the downhill side and stops.
                    Name = "S6_Threshold_Line",
                    Nodes = new[]
                    {
                        new Vector2(-19.6f, 32.8f), new Vector2(-17.2f, 36.6f),
                        new Vector2(-15.0f, 40.4f), new Vector2(-14.2f, 44.2f),
                    },
                    GapChance = 0.28f, PanelLean = 15f, PostLean = 11f, Seed = 1106,
                },

                // Lab terrace: a broken divider between the detached vault block (east, its open arch facing
                // the gate) and the joined hall + hub complex. It starts in the inner corner where the SW
                // wing's south side meets the annex's NE wall, runs ESE under the wing and the hub's south
                // flank, then turns north through the 6 m corridor between the hub's east vertex and the
                // block's roof edge, dying 4 m short of the NE wing. The gate-to-vault approach stays open.
                Ring("Lab_Divider", 1121, 0.36f,
                    new Vector2(-11.5f, 124.3f), new Vector2(-3f, 119.5f), new Vector2(6f, 123.5f),
                    new Vector2(12.5f, 129f), new Vector2(13.2f, 138f), new Vector2(15f, 146f),
                    new Vector2(18.5f, 152f)),
            };
        }

        /// <summary>Everything a big obstacle can plug a fence gap with; barriers stay in BrokenBoundary.</summary>
        private static readonly string[] k_GapFillers =
        {
            "rock_moss_01", "rock_moss_02", "rock_moss_03", "rock_moss_04", "rock_moss_05", "rock_moss_06",
            "concrete_road_barrier", "root_cluster_01", "dead_tree_trunk_02",
        };

        /// <summary>A short §S0 enclosure run: random 1-3 module gaps, each plugged by a big obstacle.</summary>
        private static FenceRun Ring(string name, int seed, float gapChance, params Vector2[] nodes)
        {
            return new FenceRun
            {
                Name = name, Nodes = nodes, GapChance = gapChance, GapMaxModules = 3,
                GapFillers = k_GapFillers, PanelLean = 14f, PostLean = 10f, Seed = seed,
            };
        }

        // -------------------------------------------------------------------------------------------------
        // Hero anchors — the silhouettes each view is built around.
        // -------------------------------------------------------------------------------------------------
        private static PropAnchor[] CreateAnchors()
        {
            System.Collections.Generic.List<PropAnchor> a = new System.Collections.Generic.List<PropAnchor>();

            // --- concept image 1: the forked trunk cutting the near foreground, and the two barriers that
            // leave the gap towards the low saddle open. --------------------------------------------------
            a.Add(Hero("dead_tree_trunk_02", new Vector2(-2.9f, -8.3f), 40f, 1f, 0.1f, 0.55f));
            a.Add(Hero("dead_tree_trunk", new Vector2(-3.6f, -9.0f), 68f, 1f, 0.05f, 0.7f));
            a.Add(Hero("dead_tree_trunk", new Vector2(-1.7f, -9.5f), 14f, 0.9f, 0.05f, 0.7f));
            a.Add(Hero("root_cluster_01", new Vector2(-4.6f, -9.8f), 120f, 1f, 0.2f, 0.8f));

            a.Add(Barrier(new Vector2(1.6f, -3.6f), 58f, 0.06f, 0.35f));
            a.Add(Barrier(new Vector2(-0.3f, -2.3f), 78f, 0.1f, 0.3f));
            a.Add(Barrier(new Vector2(-5.6f, -6.2f), 34f, 0.24f, 0.5f));

            // --- §S0 ring breaks: the gaps between the fence runs are plugged by boulders, roots and
            // trunks, so the enclosure reads as scavenged and collapsed rather than built. --------------
            a.Add(Hero("rock_moss_04", new Vector2(8.6f, -1.0f), 35f, 1.1f, 0.35f, 0.9f));
            a.Add(Hero("dead_tree_trunk_02", new Vector2(9.9f, -2.2f), 150f, 1f, 0.15f, 0.6f));
            a.Add(Hero("root_cluster_01", new Vector2(11.7f, -12.7f), 10f, 1f, 0.25f, 0.85f));
            a.Add(Hero("rock_moss_05", new Vector2(4.0f, -20.5f), 200f, 1.05f, 0.4f, 0.9f));
            a.Add(Hero("dead_tree_trunk_02", new Vector2(5.2f, -19.4f), 60f, 1f, 0.15f, 0.6f));
            a.Add(Hero("rock_moss_03", new Vector2(-8.1f, -18.1f), 110f, 1.15f, 0.4f, 0.9f));
            a.Add(Hero("root_cluster_01", new Vector2(-9.8f, -16.1f), 300f, 1f, 0.25f, 0.85f));
            a.Add(Hero("rock_moss_01", new Vector2(-10.7f, -14.3f), 250f, 1f, 0.45f, 0.9f));
            a.Add(Hero("dead_tree_trunk_02", new Vector2(-11.2f, -7.2f), 30f, 1f, 0.15f, 0.6f));
            a.Add(Barrier(new Vector2(-3.9f, -20.2f), 84f, 0.3f, 0.5f));
            a.Add(Barrier(new Vector2(12.4f, -8.6f), 12f, 0.2f, 0.45f));

            // --- §S1: the trunk that bends the last fence panel down, plus half-buried barriers. ----------
            a.Add(Hero("dead_tree_trunk_02", new Vector2(-9.6f, 1.0f), 118f, 1f, 0.15f, 0.6f));
            a.Add(Barrier(new Vector2(-9.4f, -2.6f), 40f, 0.3f, 0.5f));
            a.Add(Barrier(new Vector2(-1.2f, 3.2f), 12f, 0.38f, 0.6f));
            a.Add(Post("chainlink_post", new Vector2(-12.8f, -1.2f), 24f, 19f));
            a.Add(Post("chainlink_post_end", new Vector2(-3.4f, 3.8f), 200f, 26f));

            // --- §S2: large trunks cutting the sightline on the ridge, with a walkable side left open. ----
            a.Add(Hero("dead_tree_trunk_02", new Vector2(-9.2f, 5.4f), 75f, 1.1f, 0.12f, 0.55f));
            a.Add(Hero("dead_tree_trunk", new Vector2(-5.2f, 6.8f), 20f, 1f, 0.05f, 0.7f));
            a.Add(Hero("dead_tree_trunk_02", new Vector2(-12.2f, 9.6f), 142f, 1f, 0.15f, 0.6f));
            a.Add(Hero("root_cluster_01", new Vector2(-10.4f, 3.2f), 46f, 1f, 0.25f, 0.85f));
            a.Add(Post("chainlink_post", new Vector2(-12.8f, 4.4f), 70f, 31f));

            // --- §S4 / concept image 2: the survey camp, an L along the outer bend of the shallow valley.
            // Without a canopy, table, crate or chair in the library the evidence layer carries the scene on
            // its own: recording, sampling, measuring, then a sudden walk-out. ---------------------------
            a.AddRange(CreateCamp());

            // --- §S5: the isolation line survives only as a broken head and a buried block. ---------------
            a.Add(Barrier(new Vector2(-18.8f, 29.6f), 100f, 0.34f, 0.6f));
            a.Add(Post("chainlink_post_end", new Vector2(-19.2f, 27.4f), 140f, 24f));
            a.Add(Post("chainlink_post", new Vector2(-18.4f, 25.8f), 96f, 33f));

            // --- §S6 / concept image 3: two heavy standing trunks frame the view, a barrier is sunk at the
            // foot of the fence and moss has taken the concrete. -----------------------------------------
            a.Add(Standing("dead_tree_trunk_02", new Vector2(-14.9f, 37.2f), 26f, 1.05f));
            a.Add(Standing("dead_tree_trunk_02", new Vector2(-9.3f, 40.9f), 148f, 1.15f));
            a.Add(Standing("dead_tree_trunk_02", new Vector2(-11.2f, 44.6f), 74f, 0.9f));
            a.Add(Standing("dead_tree_trunk", new Vector2(-16.8f, 41.8f), 210f, 1f));
            a.Add(Barrier(new Vector2(-17.4f, 36.2f), 122f, 0.26f, 0.55f));
            a.Add(Barrier(new Vector2(-13.0f, 40.6f), 65f, 0.42f, 0.7f));
            a.Add(Hero("root_cluster_01", new Vector2(-13.8f, 37.4f), 154f, 1f, 0.22f, 0.9f));

            return a.ToArray();
        }

        /// <summary>
        /// §S4 survey camp: a recording arm along the valley wall and a sampling arm across it, arranged so
        /// the walk-out reads as sudden but not violent — nothing is packed, nothing is broken.
        /// </summary>
        private static PropAnchor[] CreateCamp()
        {
            return new[]
            {
                // sampling arm, along the valley wall
                Camp("bottle_test_tube_rack", new Vector2(-18.30f, 16.42f), 12f),
                Fallen("bottle_glassware_test_tube_medium", new Vector2(-18.06f, 16.34f), 22f),
                Fallen("bottle_glassware_test_tube_small", new Vector2(-18.46f, 16.22f), 128f),
                Camp("misc_scale", new Vector2(-18.10f, 17.28f), -8f),
                Camp("bottle_glassware_reagent_bottle_medium", new Vector2(-18.44f, 17.74f), 0f),
                Camp("bottle_glassware_reagent_bottle_small", new Vector2(-18.22f, 17.94f), 34f),
                Fallen("bottle_glassware_vial_medium", new Vector2(-18.54f, 18.16f), 96f),
                Fallen("bottle_glassware_centrifuge_tube", new Vector2(-18.04f, 18.28f), 210f),
                Camp("dish_petridish", new Vector2(-18.36f, 18.62f), 18f),
                Camp("dish_watch_glass", new Vector2(-18.14f, 18.80f), -24f),
                Fallen("misc_wash_bottle", new Vector2(-18.50f, 19.08f), 158f),
                Fallen("bottle_plastic_bottle_medium", new Vector2(-18.08f, 19.26f), 64f),
                Fallen("bottle_dropper", new Vector2(-18.38f, 19.46f), 12f),

                // recording arm, across the valley floor
                Camp("clipboard", new Vector2(-17.70f, 19.86f), 24f),
                Camp("binder_notebook", new Vector2(-17.16f, 20.02f), -14f),
                Camp("clipboard", new Vector2(-16.58f, 19.72f), 62f),
                Flat("misc_magnifying_glass", new Vector2(-16.20f, 19.94f), 108f),
                Flat("heating_equipment_forceps", new Vector2(-15.86f, 19.76f), 42f),
                Flat("heating_equipment_thermometer", new Vector2(-15.58f, 20.06f), 172f),
                Camp("clamp_tube_clamp", new Vector2(-16.90f, 20.28f), 78f),
                Camp("ppe_rubber_gloves", new Vector2(-17.46f, 20.32f), 40f),
                Camp("ppe_safety_glasses", new Vector2(-16.34f, 20.46f), -30f),
                Camp("binder_notebook", new Vector2(-15.92f, 20.52f), 100f),

                // §8.5: the first life is only in the sheltered corners of the camp, never in the open
                Fern(new Vector2(-18.92f, 17.06f), 26f, 0.55f),
                Fern(new Vector2(-18.84f, 18.58f), 140f, 0.62f),
                Fern(new Vector2(-19.02f, 19.84f), 208f, 0.5f),
                Fern(new Vector2(-16.42f, 20.86f), 64f, 0.58f),
            };
        }

        private static PropAnchor Hero(string prefab, Vector2 xz, float yaw, float scale, float sink, float align)
        {
            return new PropAnchor
            {
                Prefab = prefab, Pool = PropPool.RootRockClutter, Position = xz, Yaw = yaw,
                Scale = scale, Sink = sink, NormalAlign = align,
            };
        }

        /// <summary>A lying trunk stood on end: its long axis is +X, so a roll of 90° takes it to +Y.</summary>
        private static PropAnchor Standing(string prefab, Vector2 xz, float yaw, float scale)
        {
            return new PropAnchor
            {
                Prefab = prefab, Pool = PropPool.RootRockClutter, Position = xz, Yaw = yaw,
                ExtraEuler = new Vector3(0f, 0f, 90f), Scale = scale, Sink = 0.15f, NormalAlign = 0.15f,
            };
        }

        private static PropAnchor Barrier(Vector2 xz, float yaw, float sink, float align)
        {
            return new PropAnchor
            {
                Prefab = "concrete_road_barrier", Pool = PropPool.BrokenBoundary, Position = xz, Yaw = yaw,
                Scale = 1f, Sink = sink, NormalAlign = align,
            };
        }

        private static PropAnchor Post(string prefab, Vector2 xz, float yaw, float tiltDegrees)
        {
            return new PropAnchor
            {
                Prefab = prefab, Pool = PropPool.BrokenBoundary, Position = xz, Yaw = yaw,
                ExtraEuler = new Vector3(tiltDegrees, 0f, 0f), Scale = 1f, Sink = 0.1f, NormalAlign = 0f,
            };
        }

        private static PropAnchor Camp(string prefab, Vector2 xz, float yaw)
        {
            return new PropAnchor
            {
                Prefab = prefab, Pool = PropPool.CampEvidence, Position = xz, Yaw = yaw,
                Scale = 1f, Sink = 0.005f, NormalAlign = 1f,
            };
        }

        /// <summary>An upright container tipped onto its side (its long axis is +Y).</summary>
        private static PropAnchor Fallen(string prefab, Vector2 xz, float yaw)
        {
            return new PropAnchor
            {
                Prefab = prefab, Pool = PropPool.CampEvidence, Position = xz, Yaw = yaw,
                ExtraEuler = new Vector3(90f, 0f, 0f), Scale = 1f, Sink = 0.004f, NormalAlign = 1f,
            };
        }

        /// <summary>A flat tool (magnifier, forceps, thermometer) laid down on the ground.</summary>
        private static PropAnchor Flat(string prefab, Vector2 xz, float yaw)
        {
            return new PropAnchor
            {
                Prefab = prefab, Pool = PropPool.CampEvidence, Position = xz, Yaw = yaw,
                ExtraEuler = new Vector3(-90f, 0f, 0f), Scale = 1f, Sink = 0.004f, NormalAlign = 1f,
            };
        }

        private static PropAnchor Fern(Vector2 xz, float yaw, float scale)
        {
            return new PropAnchor
            {
                Prefab = "M3D_fern-2", Pool = PropPool.TransitionGrowth, Position = xz, Yaw = yaw,
                Scale = scale, Sink = 0.02f, NormalAlign = 0.4f,
            };
        }

        // -------------------------------------------------------------------------------------------------
        // Scatter — the density curve of §7: dead and dry at the wake lowland, humus and dry tufts in the
        // valley, ferns and live bushes up the rising slope, the anomalous band on the far crest.
        // -------------------------------------------------------------------------------------------------
        private static ScatterPatch[] CreatePatches()
        {
            return new[]
            {
                // --- dead forest: dense and impassable behind the player, thin along the route ------------
                Patch("S0_DeadForest_Behind", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(0f, -14f), 12f, 27f, 96, 2.5f, 3.5f, 2001,
                    zRange: new Vector2(-31f, 2f)),
                Patch("S0_RightShoulder", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(16f, -5f), 0f, 8f, 22, 2.5f, 4f, 2002),
                Patch("S0_EastWall", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(3f, -9f), 13f, 22f, 34, 2.4f, 4f, 2038,
                    arcMin: 10f, arcMax: 120f),
                Patch("S1_Corridor_Sides", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-4f, -2f), 5f, 13f, 20, 2.9f, 4.5f, 2003),
                Patch("S2_OuterSlope", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-16f, 4f), 0f, 11f, 26, 2.6f, 4f, 2004),
                Patch("S2_RidgeLine", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-8f, 8f), 3.5f, 9f, 14, 3f, 4f, 2005),
                Patch("S3_ValleyRim_West", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-18f, 20f), 3f, 13f, 24, 3.2f, 4.5f, 2006),
                Patch("S4_ValleyRim_East", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-5f, 20f), 0f, 10f, 16, 3.4f, 5f, 2007),
                Patch("S5_Thinning", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-19f, 30f), 2.5f, 11f, 12, 3.6f, 5f, 2008),
                Patch("S6_BeyondBand", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-10f, 50f), 0f, 15f, 20, 3.6f, 4f, 2009),
                Patch("S6_EastTrees", PropPool.DeadTreeSparse, k_DeadTrees,
                    new Vector2(-2f, 42f), 0f, 11f, 12, 3.6f, 4f, 2010),

                // --- dead low growth: silhouette only, never a readable living plant at the start ---------
                Patch("S0_DeadBushes", PropPool.DeadTreeSparse, k_DeadBushes,
                    new Vector2(-4f, -3f), 2f, 18f, 46, 1.8f, 1.6f, 2011,
                    tilt: 8f, align: 0.5f),
                Patch("S2_RidgeBushes", PropPool.DeadTreeSparse, k_DeadBushes,
                    new Vector2(-9f, 7f), 1.5f, 10f, 18, 1.8f, 1.6f, 2012,
                    tilt: 8f, align: 0.5f),
                Patch("S0_ShoulderBushes", PropPool.DeadTreeSparse, k_DeadBushes,
                    new Vector2(8f, -4f), 0f, 8f, 12, 1.8f, 2f, 2013,
                    tilt: 8f, align: 0.5f),

                // --- fallen dry wood, the "time" layer of §2.5 --------------------------------------------
                Patch("S0_Branches", PropPool.DeadTreeSparse, k_Branches,
                    new Vector2(-2f, -7f), 0f, 16f, 40, 1.2f, 0.6f, 2014, tilt: 6f, align: 0.95f),
                Patch("S2_Branches", PropPool.DeadTreeSparse, k_Branches,
                    new Vector2(-9f, 6f), 0f, 12f, 26, 1.2f, 0.6f, 2015, tilt: 6f, align: 0.95f),
                Patch("S4_Branches", PropPool.DeadTreeSparse, k_Branches,
                    new Vector2(-15f, 19f), 0f, 12f, 26, 1.2f, 0.6f, 2016, tilt: 6f, align: 0.95f),
                Patch("S6_Branches", PropPool.DeadTreeSparse, k_Branches,
                    new Vector2(-13f, 39f), 0f, 13f, 30, 1.2f, 0.6f, 2017, tilt: 6f, align: 0.95f),

                // --- rock and root clutter ---------------------------------------------------------------
                Patch("S0_Gravel", PropPool.RootRockClutter, k_SmallRocks,
                    new Vector2(-1f, -7f), 0f, 16f, 30, 1.7f, 1f, 2018,
                    tilt: 12f, align: 1f, scaleMin: 0.28f, scaleMax: 0.6f, sinkMin: 0.05f, sinkMax: 0.25f),
                Patch("S2_Boulders", PropPool.RootRockClutter, k_BigRocks,
                    new Vector2(-10f, 6f), 0f, 11f, 12, 3.5f, 3f, 2019,
                    tilt: 10f, align: 1f, scaleMin: 0.5f, scaleMax: 0.95f, sinkMin: 0.2f, sinkMax: 0.6f,
                    zRange: new Vector2(3.5f, 1000f)),
                Patch("S4_Stones", PropPool.RootRockClutter, k_SmallRocks,
                    new Vector2(-15f, 19f), 0f, 12f, 20, 1.7f, 1f, 2020,
                    tilt: 12f, align: 1f, scaleMin: 0.25f, scaleMax: 0.55f, sinkMin: 0.05f, sinkMax: 0.25f),
                Patch("S5_Boulders", PropPool.RootRockClutter, k_BigRocks,
                    new Vector2(-15f, 32f), 0f, 11f, 12, 3.5f, 3f, 2021,
                    tilt: 10f, align: 1f, scaleMin: 0.45f, scaleMax: 0.9f, sinkMin: 0.2f, sinkMax: 0.6f),
                Patch("S6_Stones", PropPool.RootRockClutter, k_SmallRocks,
                    new Vector2(-13f, 39f), 0f, 14f, 34, 1.6f, 0.9f, 2022,
                    tilt: 12f, align: 1f, scaleMin: 0.22f, scaleMax: 0.5f, sinkMin: 0.05f, sinkMax: 0.3f),
                Patch("S1_Roots", PropPool.RootRockClutter, k_LowRoots,
                    new Vector2(-8f, 2f), 0f, 12f, 26, 1.9f, 1.2f, 2023, tilt: 7f, align: 1f,
                    sinkMin: 0.02f, sinkMax: 0.12f),
                Patch("S4_Roots", PropPool.RootRockClutter, k_Roots,
                    new Vector2(-15f, 19f), 0f, 12f, 24, 1.9f, 1.2f, 2024, tilt: 7f, align: 1f,
                    sinkMin: 0.02f, sinkMax: 0.12f),
                Patch("S5_Roots", PropPool.RootRockClutter, k_Roots,
                    new Vector2(-16f, 29f), 0f, 11f, 26, 1.9f, 1.2f, 2025, tilt: 7f, align: 1f,
                    sinkMin: 0.02f, sinkMax: 0.12f),
                Patch("S6_Roots", PropPool.RootRockClutter, k_Roots,
                    new Vector2(-13f, 40f), 0f, 14f, 36, 1.8f, 1.1f, 2026, tilt: 7f, align: 1f,
                    sinkMin: 0.02f, sinkMax: 0.12f),

                // --- dry low growth: the valley's first ground cover, still colourless --------------------
                Patch("S2_DryTufts", PropPool.DryLowGrowth, k_DryGrowth,
                    new Vector2(-9f, 8f), 0f, 11f, 26, 1.3f, 1f, 2027, tilt: 6f, align: 0.7f,
                    scaleMin: 0.6f, scaleMax: 1f, zRange: new Vector2(1f, 40f)),
                // Concept image 1 keeps a single dark clump on the far ridge silhouette. It has to stay on the
                // ridge: §10 requires the wake lowland to hold no readable living plant at all.
                Patch("S0_RidgeTufts", PropPool.DryLowGrowth, k_DryGrowth,
                    new Vector2(2f, 6f), 0f, 7f, 8, 2f, 2f, 2028, tilt: 6f, align: 0.7f,
                    scaleMin: 0.5f, scaleMax: 0.8f, zRange: new Vector2(4f, 14f)),
                Patch("S4_DryTufts", PropPool.DryLowGrowth, k_DryGrowth,
                    new Vector2(-15f, 19f), 0f, 13f, 60, 1.1f, 0.8f, 2029, tilt: 6f, align: 0.75f,
                    scaleMin: 0.6f, scaleMax: 1.05f),
                Patch("S5_DryTufts", PropPool.DryLowGrowth, k_DryGrowth,
                    new Vector2(-16f, 29f), 0f, 12f, 60, 1.1f, 0.8f, 2030, tilt: 6f, align: 0.75f,
                    scaleMin: 0.65f, scaleMax: 1.1f),

                // --- recovery: ferns leave shelter, then live bushes, then the band ---------------------
                Patch("S5_Ferns", PropPool.TransitionGrowth, k_Ferns,
                    new Vector2(-16f, 29f), 0f, 12f, 55, 1.4f, 0.8f, 2031, tilt: 8f, align: 0.55f,
                    scaleMin: 0.5f, scaleMax: 0.85f, clump: 0.42f),
                Patch("S6_Ferns", PropPool.TransitionGrowth, k_Ferns,
                    new Vector2(-12f, 39f), 0f, 14f, 80, 1.3f, 0.7f, 2032, tilt: 8f, align: 0.55f,
                    scaleMin: 0.55f, scaleMax: 0.95f, clump: 0.38f),
                Patch("S5_LiveBushes", PropPool.TransitionGrowth, k_LiveBushes,
                    new Vector2(-15f, 33f), 0f, 12f, 34, 2f, 1.2f, 2033, tilt: 7f, align: 0.5f,
                    scaleMin: 0.5f, scaleMax: 0.9f, clump: 0.4f),
                Patch("S6_Ivy", PropPool.TransitionGrowth, k_Ivy,
                    new Vector2(-14f, 36f), 0f, 13f, 34, 1.6f, 0.8f, 2034, tilt: 6f, align: 1f,
                    scaleMin: 0.5f, scaleMax: 0.9f, sinkMin: 0.01f, sinkMax: 0.05f),

                // --- the anomalous band itself. The annulus is only a coarse limit: what actually decides
                // where a clump lands is the painted TL_GrassBand weight, so the props follow the terrain's
                // own irregular, noise-warped edge instead of drawing a clean ring (§8.6). ----------------
                Patch("S6_AnomalousBand", PropPool.TransitionGrowth, k_BandGrass,
                    new Vector2(0f, 112f), 56f, 86f, 420, 0.75f, 0.5f, 2035, tilt: 5f, align: 0.6f,
                    scaleMin: 0.55f, scaleMax: 1.1f, arcMin: 166f, arcMax: 214f,
                    xRange: new Vector2(-34f, 12f), zRange: new Vector2(34f, 64f),
                    layer: k_GrassBandLayer, layerWeight: 0.4f, clump: 0.3f, clumpFrequency: 0.09f),
                Patch("S6_BandBushes", PropPool.TransitionGrowth, k_LiveBushes,
                    new Vector2(0f, 112f), 56f, 86f, 90, 1.8f, 0.8f, 2036, tilt: 6f, align: 0.5f,
                    scaleMin: 0.45f, scaleMax: 0.85f, arcMin: 166f, arcMax: 214f,
                    xRange: new Vector2(-34f, 12f), zRange: new Vector2(34f, 64f),
                    layer: k_GrassBandLayer, layerWeight: 0.45f, clump: 0.36f, clumpFrequency: 0.08f),

                // §S6: ordinary vegetation bleeding out of the band, so its edge interlocks instead of
                // switching colour on a line.
                Patch("S6_BandFringe", PropPool.DryLowGrowth, k_DryGrowth,
                    new Vector2(0f, 112f), 76f, 94f, 70, 1.1f, 0.6f, 2037, tilt: 6f, align: 0.7f,
                    scaleMin: 0.5f, scaleMax: 0.9f, arcMin: 166f, arcMax: 214f,
                    xRange: new Vector2(-34f, 12f), zRange: new Vector2(32f, 52f), clump: 0.35f),
            };
        }

        private static ScatterPatch Patch(string name, PropPool pool, string[] prefabs, Vector2 center,
            float inner, float outer, int count, float spacing, float routeClearance, int seed,
            float tilt = 4f, float align = 0f, float scaleMin = 0.85f, float scaleMax = 1.15f,
            float sinkMin = 0f, float sinkMax = 0.06f, float arcMin = 0f, float arcMax = 360f,
            Vector2 xRange = default, Vector2 zRange = default, int layer = -1, float layerWeight = 0.5f,
            float clump = 0f, float clumpFrequency = 0.06f)
        {
            return new ScatterPatch
            {
                Name = name, Pool = pool, Prefabs = prefabs, Center = center,
                InnerRadius = inner, OuterRadius = outer, Count = count, MinSpacing = spacing,
                ScaleMin = scaleMin, ScaleMax = scaleMax, NormalAlign = align, TiltJitter = tilt,
                SinkMin = sinkMin, SinkMax = sinkMax, RouteClearance = routeClearance,
                ArcMin = arcMin, ArcMax = arcMax,
                XRange = xRange == default(Vector2) ? new Vector2(-1000f, 1000f) : xRange,
                ZRange = zRange == default(Vector2) ? new Vector2(-1000f, 1000f) : zRange,
                TerrainLayer = layer, MinLayerWeight = layerWeight,
                ClumpThreshold = clump, ClumpFrequency = clumpFrequency, Seed = seed,
            };
        }
    }
}
