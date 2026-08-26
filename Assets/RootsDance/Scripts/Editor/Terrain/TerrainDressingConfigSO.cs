using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Every tunable <see cref="TerrainDressingBuilder"/> reads: the scatter rules that fill the ring
    /// bands with trees, deadwood and rocks, the Terrain detail layers that make the grass band read,
    /// the hand-authored Chapter-00 props, the lab material keys and the skybox. The terrain shape
    /// itself comes from the referenced <see cref="TerrainGreyboxConfigSO"/> — this asset never edits
    /// heights or splats. Editor-only data; the asset lives at
    /// <c>Assets/RootsDance/Data/Config/TerrainDressingConfig.asset</c> and never ships in a build.
    /// </summary>
    [CreateAssetMenu(fileName = "TerrainDressingConfig", menuName = "RootsDance/Editor/Terrain Dressing Config")]
    public class TerrainDressingConfigSO : ScriptableObject
    {
        /// <summary>Pit-floor height plus the pipe run's support gap, in world metres.</summary>
        private const float k_ServicePipeY = 4.35f;

        /// <summary>Z of the pipe run: just north of the service hut's back wall.</summary>
        private const float k_ServicePipeZ = 109.6f;

        /// <summary>X of the elbow that closes the pipe run; its west opening meets the last piece.</summary>
        private const float k_ServicePipeBendX = 47.5f;

        [SerializeField, TitleGroup("General")]
        private int m_seed = 20260826;

        [SerializeField, TitleGroup("General"), Required]
        private TerrainGreyboxConfigSO m_greyboxConfig;

        [SerializeField, TitleGroup("Scatter")]
        private ScatterRule[] m_scatterRules = CreateDefaultScatterRules();

        [SerializeField, TitleGroup("Details")]
        private DetailRule[] m_detailRules = CreateDefaultDetailRules();

        [SerializeField, TitleGroup("Details")]
        private int m_detailResolution = 512;

        [SerializeField, TitleGroup("Details")]
        private int m_detailResolutionPerPatch = 32;

        [SerializeField, TitleGroup("Details")]
        private float m_detailDistance = 60f;

        [SerializeField, TitleGroup("Details")]
        private float m_detailDensity = 1f;

        [SerializeField, TitleGroup("Props")]
        private PropPlacement[] m_props = CreateDefaultProps();

        // Deliberately not [Required]: empty is the shipping state — it selects Unity's procedural sky.
        [SerializeField, TitleGroup("Skybox")]
        private Cubemap m_skyboxCubemap;

        [SerializeField, TitleGroup("Skybox")]
        private float m_skyboxExposure = 1.15f;

        [SerializeField, TitleGroup("Skybox")]
        private float m_skyboxRotation;

        [SerializeField, TitleGroup("Skybox"), Range(0f, 1f)]
        private float m_skySunSize = 0.02f;

        [SerializeField, TitleGroup("Skybox"), Range(1f, 10f)]
        private float m_skySunSizeConvergence = 5f;

        // 0.7, not the 1.4 an overcast preset would use: Unity's procedural sky draws its haze around
        // the sun, so a thick atmosphere with this scene's 50-degree sun turns the whole dome into a
        // sunset gradient. Low thickness with a near-neutral tint and an exposure just above 1 is the
        // pale low-contrast sky the chapter wants; a genuinely grey overcast dome needs a gradient sky
        // shader or an overcast HDRI.
        [SerializeField, TitleGroup("Skybox"), Range(0f, 5f)]
        private float m_skyAtmosphereThickness = 0.7f;

        [SerializeField, TitleGroup("Skybox")]
        private Color m_skyTint = new Color(0.55f, 0.57f, 0.60f);

        [SerializeField, TitleGroup("Skybox")]
        private Color m_skyGroundColor = new Color(0.42f, 0.42f, 0.40f);

        [SerializeField, TitleGroup("Lab")]
        private string m_labMaterialKey = "Concrete_Lab";

        [SerializeField, TitleGroup("Lab")]
        private string m_labGlassMaterialKey = "Lab_Glass";

        [SerializeField, TitleGroup("Lab")]
        private string m_labGlassNameContains = "glass";

        /// <summary>Base RNG seed; each scatter rule runs with <c>Seed + ruleIndex</c>.</summary>
        public int Seed => m_seed;

        /// <summary>The greybox config that owns the terrain shape, the scene path and the terrace.</summary>
        public TerrainGreyboxConfigSO GreyboxConfig => m_greyboxConfig;

        /// <summary>Prefab scatter rules, evaluated in order into <c>_Vegetation/&lt;Name&gt;</c> groups.</summary>
        public ScatterRule[] ScatterRules => m_scatterRules;

        /// <summary>Terrain detail layers, in the order they are written onto the TerrainData.</summary>
        public DetailRule[] DetailRules => m_detailRules;

        /// <summary>Detail map resolution passed to <c>TerrainData.SetDetailResolution</c>.</summary>
        public int DetailResolution => m_detailResolution;

        /// <summary>Detail patch resolution passed to <c>TerrainData.SetDetailResolution</c>.</summary>
        public int DetailResolutionPerPatch => m_detailResolutionPerPatch;

        /// <summary>Metres beyond which detail objects stop drawing.</summary>
        public float DetailDistance => m_detailDistance;

        /// <summary>Global multiplier on the baked detail densities.</summary>
        public float DetailDensity => m_detailDensity;

        /// <summary>Hand-authored props, grouped under <c>_Props/&lt;Group&gt;</c>.</summary>
        public PropPlacement[] Props => m_props;

        /// <summary>
        /// Cubemap the sky material samples. Empty — the shipping state — selects Unity's procedural sky
        /// instead, driven by the five fields below.
        /// </summary>
        public Cubemap SkyboxCubemap => m_skyboxCubemap;

        /// <summary>Skybox exposure; applies to both the cubemap and the procedural sky.</summary>
        public float SkyboxExposure => m_skyboxExposure;

        /// <summary>Cubemap rotation around +Y, in degrees; ignored by the procedural sky.</summary>
        public float SkyboxRotation => m_skyboxRotation;

        /// <summary>Procedural sky: angular size of the sun disc. Small values read as an overcast day.</summary>
        public float SkySunSize => m_skySunSize;

        /// <summary>Procedural sky: how sharply the sun disc falls off.</summary>
        public float SkySunSizeConvergence => m_skySunSizeConvergence;

        /// <summary>Procedural sky: atmosphere density; above 1 washes the horizon out.</summary>
        public float SkyAtmosphereThickness => m_skyAtmosphereThickness;

        /// <summary>Procedural sky: colour cast of the dome.</summary>
        public Color SkyTint => m_skyTint;

        /// <summary>Procedural sky: colour below the horizon, which also feeds the ambient bounce.</summary>
        public Color SkyGroundColor => m_skyGroundColor;

        /// <summary>Palette key painted onto every opaque lab-blockout renderer.</summary>
        public string LabMaterialKey => m_labMaterialKey;

        /// <summary>Palette key painted onto the lab's glazed renderers.</summary>
        public string LabGlassMaterialKey => m_labGlassMaterialKey;

        /// <summary>Case-insensitive fragment that marks a vendor material as glazing.</summary>
        public string LabGlassNameContains => m_labGlassNameContains;

        /// <summary>
        /// Drops the three authored tables back to the <c>CreateDefault*</c> code defaults. Needed
        /// because those methods only ever run once, when the asset is first created: after that the
        /// serialized arrays are the source of truth and code edits do not reach them.
        /// </summary>
        public void ApplyAuthoredDefaults()
        {
            m_scatterRules = CreateDefaultScatterRules();
            m_detailRules = CreateDefaultDetailRules();
            m_props = CreateDefaultProps();
        }

        /// <summary>
        /// The authored scatter rules, outside in: the dead-tree wall that closes the world, the two
        /// forest bands that thin toward the route, the deadwood and understorey that break their
        /// floor up, the hero clumps at the grass-band edges and the rocks that read as the old
        /// research ground. Editing these values in code does not reach an already-serialized config
        /// asset — press "Reset Authored Content" in the Inspector to pull the new defaults into it.
        /// </summary>
        /// <returns>A new array of the twelve authored scatter rules.</returns>
        public static ScatterRule[] CreateDefaultScatterRules()
        {
            return new[]
            {
                // Band A boundary: the tallest, densest ring. It is allowed onto steep ground and close
                // to the terrain edge, because its only job is to close every wrong direction.
                new ScatterRule
                {
                    Name = "Boundary",
                    PrefabKeys = Concat(Series("BirchTree_Dead_", 1, 5), Series("Willow_Dead_", 1, 5)),
                    RadiusMin = 137f, RadiusMax = 160f,
                    // 4, not 6: the ring is only ever seen from inside and it was the single largest
                    // contributor to the draw-call count at the wake viewpoint. See the Task 8 numbers.
                    Density = 4f, MinSpacing = 2.5f,
                    ScaleMin = 1f, ScaleMax = 1.4f,
                    MaxSlopeDegrees = 50f, EdgeMargin = 4f, RouteClearance = 0f
                },

                // Band A forest: dead birches twice as likely as willows, patchy, and thinning toward
                // the trail so the route stays legible from inside the wood.
                new ScatterRule
                {
                    Name = "TreesA",
                    PrefabKeys = Concat(Series("BirchTree_Dead_", 1, 5), Series("Willow_Dead_", 1, 5)),
                    PrefabWeights = Concat(Repeat(2f, 5), Repeat(1f, 5)),
                    RadiusMin = 112f, RadiusMax = 137f,
                    Density = 2.6f, MinSpacing = 3.5f,
                    ScaleMin = 0.9f, ScaleMax = 1.3f,
                    ClumpThreshold = 0.25f, ClumpFrequency = 0.025f,
                    RouteThinningDistance = 22f, RouteThinningFactor = 0.25f
                },

                // Fallen wood tilts with the ground and may sit at the very edge of the trail.
                new ScatterRule
                {
                    Name = "DeadwoodA",
                    PrefabKeys = new[] { "WoodLog", "TreeStump", "log_large", "stump_round" },
                    RadiusMin = 108f, RadiusMax = 140f,
                    Density = 1.2f, MinSpacing = 4f,
                    ScaleMin = 0.9f, ScaleMax = 1.3f,
                    AlignToSlope = true, RouteClearance = 0.5f
                },

                // Band B: the wood starts recovering — autumn and living birches mix into the dead ones.
                new ScatterRule
                {
                    Name = "TreesB",
                    PrefabKeys = Concat(Series("BirchTree_Dead_", 1, 3), Series("BirchTree_Autumn_", 1, 3),
                        Series("BirchTree_", 1, 2), Series("Willow_Dead_", 1, 2)),
                    RadiusMin = 90f, RadiusMax = 112f,
                    Density = 2.4f, MinSpacing = 4f,
                    ScaleMin = 0.9f, ScaleMax = 1.3f,
                    ClumpThreshold = 0.35f, ClumpFrequency = 0.03f,
                    RouteThinningDistance = 18f, RouteThinningFactor = 0.35f
                },

                new ScatterRule
                {
                    Name = "UnderstoreyB",
                    PrefabKeys = new[] { "Bush_1", "Bush_2", "TreeStump_Moss", "WoodLog_Moss", "plant_bushLarge" },
                    RadiusMin = 88f, RadiusMax = 114f,
                    Density = 1.5f, MinSpacing = 3f,
                    ScaleMin = 0.8f, ScaleMax = 1.2f,
                    AlignToSlope = true
                },

                // Hero clumps at the grass-band edges: strongly clumped so the C band reads as meadow
                // with plant islands rather than as an even sprinkle.
                new ScatterRule
                {
                    Name = "EdgeC",
                    PrefabKeys = Concat(Series("Plant_", 1, 5), new[] { "plant_bush", "BushBerries_1" }),
                    RadiusMin = 66f, RadiusMax = 92f,
                    Density = 1f, MinSpacing = 3f,
                    ScaleMin = 0.8f, ScaleMax = 1.3f,
                    ClumpThreshold = 0.4f, ClumpFrequency = 0.05f
                },

                // Band D: living trees, kept well off the trail and off the terrace apron.
                new ScatterRule
                {
                    Name = "TreesD",
                    PrefabKeys = Concat(Series("BirchTree_", 1, 5), Series("CommonTree_", 1, 3)),
                    RadiusMin = 55f, RadiusMax = 70f,
                    Density = 1.8f, MinSpacing = 5f,
                    ScaleMin = 1f, ScaleMax = 1.3f,
                    // Without clumping these read as evenly spaced lollipops on the open D ring; the
                    // low frequency gathers them into a handful of stands with real gaps between them.
                    ClumpThreshold = 0.35f, ClumpFrequency = 0.04f,
                    RouteThinningDistance = 15f, RouteThinningFactor = 0.3f,
                    TerraceClearance = 4f
                },

                new ScatterRule
                {
                    Name = "UnderstoreyD",
                    PrefabKeys = new[]
                    {
                        "mushroom_tanGroup", "mushroom_tan", "mushroom_tanTall", "mushroom_redGroup",
                        "plant_bushSmall", "rock_smallA", "rock_smallB", "rock_smallC", "rock_smallD"
                    },
                    RadiusMin = 54f, RadiusMax = 72f,
                    Density = 2f, MinSpacing = 2f,
                    ScaleMin = 0.8f, ScaleMax = 1.2f,
                    ClumpThreshold = 0.45f, ClumpFrequency = 0.06f
                },

                // Rocks span the outer half of the map, tilt with the ground and take the steepest slopes.
                new ScatterRule
                {
                    Name = "RocksAB",
                    PrefabKeys = Concat(Letters("rock_large", 'A', 'F'), Letters("rock_tall", 'A', 'D'),
                        Letters("stone_large", 'A', 'C')),
                    RadiusMin = 86f, RadiusMax = 150f,
                    Density = 0.5f, MinSpacing = 6f,
                    ScaleMin = 0.7f, ScaleMax = 1.6f,
                    MaxSlopeDegrees = 60f,
                    ClumpThreshold = 0.3f, ClumpFrequency = 0.02f,
                    AlignToSlope = true
                },

                new ScatterRule
                {
                    Name = "RocksD",
                    PrefabKeys = Concat(Letters("rock_large", 'A', 'C'), Letters("stone_large", 'A', 'C')),
                    RadiusMin = 50f, RadiusMax = 75f,
                    Density = 0.35f, MinSpacing = 8f,
                    ScaleMin = 0.6f, ScaleMax = 1.2f,
                    AlignToSlope = true
                },

                // The terrace rim: a negative terrace clearance lets these sit on the platform edge.
                new ScatterRule
                {
                    Name = "TerraceEdge",
                    PrefabKeys = Concat(Letters("rock_small", 'A', 'D'),
                        new[] { "construction-barrier", "Details_Pipes_Medium" }),
                    RadiusMin = 36f, RadiusMax = 52f,
                    Density = 0.6f, MinSpacing = 4f,
                    ScaleMin = 0.9f, ScaleMax = 1.1f,
                    RouteClearance = 2f, TerraceClearance = -3f
                },

                // The wake ring (00-01). TreesA thins itself away 22 m from the route, which is exactly
                // the wake bowl, so the opening frame had no trunks at all. This rule refills that bowl
                // with dead wood that is allowed much closer to the trail: a negative flat-spot
                // clearance lets it stand inside the bowl's blend ring (6 + 8 - 7 = 7 m of clear core
                // around the spawn), and the short thinning distance only opens a gap where the route
                // itself runs — the north-west opening the chapter wants. The disc limit keeps it local:
                // a 30 m disc around the spawn instead of the whole ring, so the wide band (100-140)
                // can wrap the north sector too without paying for hundreds of trunks the player never
                // sees. Keep it after TreesA so its own _Vegetation group is visible in the hierarchy
                // as the wake's wall.
                new ScatterRule
                {
                    Name = "WakeDeadwood",
                    PrefabKeys = Concat(Series("BirchTree_Dead_", 1, 5), Series("Willow_Dead_", 1, 5)),
                    RadiusMin = 100f, RadiusMax = 140f,
                    AreaCenter = new Vector2(0f, -10f), AreaRadius = 30f,
                    Density = 6f, MinSpacing = 3f,
                    ScaleMin = 1f, ScaleMax = 1.4f,
                    MaxSlopeDegrees = 45f,
                    ClumpThreshold = 0f,
                    RouteClearance = 0.5f,
                    RouteThinningDistance = 8f, RouteThinningFactor = 0.5f,
                    FlatSpotClearance = -7f, TerraceClearance = 2f, EdgeMargin = 6f
                },
            };
        }

        /// <summary>
        /// The authored Terrain detail layers. The grass band (C) carries the two tall grasses, the
        /// research ground (D) short grass and plants, the valley (B) a thin short-grass wash and the
        /// outer wood (A) dead leaf tufts. Everything keeps off the trail so the mud reads as a path.
        /// </summary>
        /// <returns>A new array of the six authored detail rules.</returns>
        public static DetailRule[] CreateDefaultDetailRules()
        {
            return new[]
            {
                new DetailRule
                {
                    Name = "GrassSilver", PrefabKey = "Grass",
                    RadiusMin = 66f, RadiusMax = 92f, EdgeFade = 5f,
                    MaxPerCell = 4, ClumpThreshold = 0.25f, ClumpFrequency = 0.08f,
                    TrailFactor = 0f
                },
                new DetailRule
                {
                    Name = "GrassSilver2", PrefabKey = "Grass_2",
                    RadiusMin = 68f, RadiusMax = 90f,
                    MaxPerCell = 3, ClumpThreshold = 0.4f, ClumpFrequency = 0.11f,
                    TrailFactor = 0f
                },
                new DetailRule
                {
                    Name = "GrassShortD", PrefabKey = "Grass_Short",
                    RadiusMin = 52f, RadiusMax = 70f,
                    MaxPerCell = 3, ClumpThreshold = 0.3f, ClumpFrequency = 0.07f,
                    TrailFactor = 0.1f, TerraceClearance = 3f
                },
                new DetailRule
                {
                    Name = "GrassShortB", PrefabKey = "Grass_Short",
                    RadiusMin = 92f, RadiusMax = 110f,
                    MaxPerCell = 1, ClumpThreshold = 0.55f, ClumpFrequency = 0.05f,
                    TrailFactor = 0f
                },

                // Plant_1, not the spec's Plant_2: a detail prototype must have exactly one material and
                // Plant_2's mesh has two sub-meshes, so Unity rejects it outright.
                new DetailRule
                {
                    Name = "PlantsD", PrefabKey = "Plant_1",
                    RadiusMin = 54f, RadiusMax = 68f,
                    MaxPerCell = 1, ClumpThreshold = 0.5f, ClumpFrequency = 0.09f,
                    TrailFactor = 0f
                },
                new DetailRule
                {
                    Name = "LeafsA", PrefabKey = "grass_leafs",
                    RadiusMin = 110f, RadiusMax = 140f,
                    MaxPerCell = 1, ClumpThreshold = 0.6f, ClumpFrequency = 0.06f,
                    TrailFactor = 0f
                },
            };
        }

        /// <summary>
        /// The hand-authored Chapter-00 props: the wake heroes that give the opening a foreground, the
        /// landmarks along the route, and the facility props that make the 00-09 gate → 00-16 service
        /// entrance clue chain legible. The service hut is a greybox stand-in for the service wing the
        /// lab model does not have.
        /// </summary>
        /// <returns>A new array of the authored prop placements.</returns>
        public static PropPlacement[] CreateDefaultProps()
        {
            List<PropPlacement> props = new List<PropPlacement>(64);

            // 00-01: the player wakes at (0, -10) facing north up the trail, with a 40-degree FOV and an
            // eye 1.7 m over a bowl whose rim is 4 m higher — so anything south of the spawn is behind the
            // camera and anything on the trail line is hidden by the bank. The heroes sit north of the
            // spawn, off both sides of the trail, where they actually land in the opening frame.
            props.Add(new PropPlacement("Wake", "dead_tree_trunk_1k", new Vector3(4f, 0f, -4f), 110f, 1.3f, true));
            props.Add(new PropPlacement("Wake", "dry_branches_medium_01_1k", new Vector3(2.5f, 0f, -7f), 30f));
            props.Add(new PropPlacement("Wake", "dry_branches_medium_01_1k", new Vector3(6f, 0f, -1f), 200f));
            props.Add(new PropPlacement("Wake", "rock_moss_set_02_1k", new Vector3(-7f, 0f, -5f), 60f, 1.2f, true));

            // Every Poly Haven wake prop is ground debris under 0.7 m tall, and the wake bowl's rim hides
            // all of it from the spawn, so the opening frame needs hand-placed trunks above the horizon.
            // They stand on and inside the bowl's rim and deliberately leave the north-west quadrant —
            // the direction of the route's first node (-7, 4) — open, so the only bright gap in the ring
            // of dead wood is the way out. Nothing sits within 5 m of the trail centre line.
            props.Add(new PropPlacement("Wake", "BirchTree_Dead_2", new Vector3(-7f, 0f, -17f), 40f, 1.3f, true));
            props.Add(new PropPlacement("Wake", "Willow_Dead_1", new Vector3(8f, 0f, -18f), 200f, 1.2f, true));
            props.Add(new PropPlacement("Wake", "BirchTree_Dead_4", new Vector3(-11f, 0f, -8f), 300f, 1.2f, true));
            props.Add(new PropPlacement("Wake", "Willow_Dead_3", new Vector3(11f, 0f, -5f), 120f, 1.3f, true));
            props.Add(new PropPlacement("Wake", "BirchTree_Dead_1", new Vector3(5f, 0f, -23f), 0f, 1.1f, true));
            props.Add(new PropPlacement("Wake", "Willow_Dead_5", new Vector3(-3f, 0f, -25f), 80f, 1.2f, true));
            props.Add(new PropPlacement("Wake", "BirchTree_Dead_5", new Vector3(12f, 0f, 2f), 10f, 1.2f, true));
            props.Add(new PropPlacement("Wake", "TreeStump", new Vector3(-4f, 0f, -14f), 30f));
            props.Add(new PropPlacement("Wake", "WoodLog", new Vector3(7f, 0f, -11f), 250f));

            props.Add(new PropPlacement("Ridge", "dry_branches_medium_01_1k", new Vector3(-22f, 0f, 10f), 75f));
            props.Add(new PropPlacement("Ridge", "dry_branches_medium_01_1k", new Vector3(14f, 0f, 22f), 300f));
            props.Add(new PropPlacement("Ridge", "tree_stump_02_1k", new Vector3(-24f, 0f, 24f), 40f));
            props.Add(new PropPlacement("Ridge", "rock_moss_set_02_1k", new Vector3(-8f, 0f, 26f), 15f));
            props.Add(new PropPlacement("Ridge", "rock_moss_set_02_1k", new Vector3(20f, 0f, 40f), 120f));

            // 00-07 grass platform: the two big plants frame the flat spot the route crosses.
            props.Add(new PropPlacement("GrassPlatform", "Plant_3", new Vector3(-16f, 0f, 36f), 20f, 1.3f, true));
            props.Add(new PropPlacement("GrassPlatform", "Plant_5", new Vector3(-8f, 0f, 43f), 200f, 1.2f, true));
            props.Add(new PropPlacement("GrassPlatform", "rock_largeB", new Vector3(-19f, 0f, 42f), 90f));

            props.Add(new PropPlacement("Saddle", "pine_roots_1k", new Vector3(10f, 0f, 60f), 250f));
            props.Add(new PropPlacement("Saddle", "rock_tallB", new Vector3(-9f, 0f, 58f), 0f));

            // 00-09 main gate: the broken barrier is the first man-made thing the player reads.
            props.Add(new PropPlacement("Gate", "road_barrier_broken", new Vector3(-1.5f, 0f, 78f), 0f));
            props.Add(new PropPlacement("Gate", "road_barrier", new Vector3(2.5f, 0f, 78.5f), 12f));
            props.Add(new PropPlacement("Gate", "construction-fence", new Vector3(0f, 0f, 76f), 0f, 1.5f, true));
            props.Add(new PropPlacement("Gate", "rock_smallB", new Vector3(1f, 0f, 77f), 0f));
            // The moss hangs on the lab's south face (z 85.5), not in mid-air: its mesh sits a metre
            // south of its pivot, so the pivot goes behind the wall line.
            props.Add(new PropPlacement("Gate", "hanging_moss", new Vector3(0f, 9.5f, 86.3f), 0f, 1f, false));
            props.Add(new PropPlacement("Gate", "pole", new Vector3(-4f, 0f, 79f), 0f));

            // The gate is the first man-made beat and the approach from (0, 66) has to read as blocked,
            // so the barrier line gets a second fence, a flanking barrier and three pieces of mass.
            props.Add(new PropPlacement("Gate", "construction-fence", new Vector3(2f, 0f, 75.5f), 5f, 1.5f, true));
            props.Add(new PropPlacement("Gate", "construction-barrier", new Vector3(-4f, 0f, 76.5f), 100f));
            props.Add(new PropPlacement("Gate", "rock_largeC", new Vector3(5f, 0f, 74f), 0f, 1.4f, true));
            props.Add(new PropPlacement("Gate", "dry_branches_medium_01_1k", new Vector3(-3.5f, 0f, 74f), 150f));
            props.Add(new PropPlacement("Gate", "WoodLog", new Vector3(-6f, 0f, 77f), 20f));

            // Two more moss falls spread across the porch. Like the first one they sit on the wall line
            // at z 86.3, not at the porch's south edge: the mesh hangs a metre south of its own pivot.
            props.Add(new PropPlacement("Gate", "hanging_moss", new Vector3(-3f, 9.5f, 86.3f), 0f, 1f, false));
            props.Add(new PropPlacement("Gate", "hanging_moss", new Vector3(3f, 9.5f, 86.3f), 0f, 1f, false));

            // 00-10: the sign faces the approach from the south-east.
            props.Add(new PropPlacement("Sign", "road-sign-empty", new Vector3(-12f, 0f, 83f), 160f));

            // 00-11: the poster board faces back east, toward the gate the player just left.
            props.Add(new PropPlacement("Poster", "sign-highway", new Vector3(-40f, 0f, 96f), 95f));
            props.Add(new PropPlacement("Poster", "dumpster", new Vector3(-36f, 0f, 100f), 80f));
            props.Add(new PropPlacement("Poster", "rock_smallC", new Vector3(-42f, 0f, 94f), 0f));

            props.Add(new PropPlacement("Terrace", "electricity-pole", new Vector3(24f, 0f, 80f), 0f));
            props.Add(new PropPlacement("Terrace", "electricity-pole", new Vector3(44f, 0f, 88f), 0f));
            props.Add(new PropPlacement("Terrace", "electricity-pole", new Vector3(-30f, 0f, 84f), 0f));

            // The east pipe run. Measured bounds: `pipe-large-long` is 2.000 m along its local +X at root
            // scale 1, `pipe-large-valve` 1.000 m, so the pivots step by half of each neighbouring piece —
            // 2 m between two longs, 1.5 m across the valve — and the run has neither a gap nor an overlap.
            // Yaw 90 lays the pieces end to end along +Z; at yaw 0 they stayed broadside to the row and
            // read as five loose rings. The terrace is terrain, not a slab, but it is flat here, so
            // dropping them still works.
            props.Add(new PropPlacement("Terrace", "pipe-large-long", new Vector3(34f, 0f, 92f), 90f));
            props.Add(new PropPlacement("Terrace", "pipe-large-long", new Vector3(34f, 0f, 94f), 90f));
            props.Add(new PropPlacement("Terrace", "pipe-large-valve", new Vector3(34f, 0f, 95.5f), 90f));
            props.Add(new PropPlacement("Terrace", "pipe-large-long", new Vector3(34f, 0f, 97f), 90f));
            props.Add(new PropPlacement("Terrace", "pipe-large-long", new Vector3(34f, 0f, 99f), 90f));

            props.Add(new PropPlacement("Terrace", "construction-barrier", new Vector3(20f, 0f, 84f), 30f));

            // This pipe bundle's pivot sits at its centre, so it needs half its height as an offset to
            // stand on the ground instead of sinking into it.
            props.Add(new PropPlacement("Terrace", "Details_Pipes_Long", new Vector3(-33f, 0f, 110f), 0f)
            {
                HeightOffset = 0.79f
            });

            // 00-14 exhaust fan: wall-mounted stand-ins on the lab's east face, which steps out from
            // x 22.8 (z 100) to x 26.9 (z 103 onwards) — hence the two different X values.
            props.Add(new PropPlacement("Fan", "RoofTile_Vents", new Vector3(27f, 11f, 103f), -90f, 1f, false));
            props.Add(new PropPlacement("Fan", "Details_Vent_2", new Vector3(22.95f, 9f, 100f), -90f, 1f, false));
            props.Add(new PropPlacement("Fan", "Details_Vent_3", new Vector3(27.03f, 9f, 106f), -90f, 1f, false));

            // 00-16 service entrance: a three-wall hut with its door facing south into the pit.
            props.Add(new PropPlacement("ServiceEntrance", "DoorSingle_Wall_SideA",
                new Vector3(44f, 0f, 108.5f), 180f));
            props.Add(new PropPlacement("ServiceEntrance", "Wall_Empty", new Vector3(41.5f, 0f, 108.5f), 180f));
            props.Add(new PropPlacement("ServiceEntrance", "Wall_Empty", new Vector3(46.5f, 0f, 108.5f), 180f));
            props.Add(new PropPlacement("ServiceEntrance", "Wall_Empty", new Vector3(48.5f, 0f, 106f), 90f));
            // One continuous run along the hut's back (north) wall. Measured bounds: `pipe-large-long` is
            // 2.000 m along its local +X at root scale 1, `pipe-large-valve` 1.000 m, so the pivots step
            // by half of each neighbouring piece — 2 m between two longs, 1.5 m across the valve — and
            // the run has neither a gap nor an overlap. It is pinned to the pit floor (4 m) plus a 0.35 m
            // support gap rather than dropped, so it stays straight across the bowl's slope.
            // The bend's two openings sit on its local -X and -Z faces (measured), so at yaw 0 it takes
            // the run in from the west at k_ServicePipeBendX - 1 and turns south into the hut's back wall.
            props.Add(new PropPlacement("ServiceEntrance", "pipe-large-long",
                new Vector3(38.5f, k_ServicePipeY, k_ServicePipeZ), 180f, 1f, false));
            props.Add(new PropPlacement("ServiceEntrance", "pipe-large-valve",
                new Vector3(40f, k_ServicePipeY, k_ServicePipeZ), 180f, 1f, false));
            props.Add(new PropPlacement("ServiceEntrance", "pipe-large-long",
                new Vector3(41.5f, k_ServicePipeY, k_ServicePipeZ), 180f, 1f, false));
            props.Add(new PropPlacement("ServiceEntrance", "pipe-large-long",
                new Vector3(43.5f, k_ServicePipeY, k_ServicePipeZ), 180f, 1f, false));
            props.Add(new PropPlacement("ServiceEntrance", "pipe-large-long",
                new Vector3(45.5f, k_ServicePipeY, k_ServicePipeZ), 180f, 1f, false));
            props.Add(new PropPlacement("ServiceEntrance", "pipe-large-bend",
                new Vector3(k_ServicePipeBendX, k_ServicePipeY, k_ServicePipeZ), 0f, 1f, false));
            // Just proud of the hut wall's south face (z 108.24) so the plate is not swallowed by it.
            props.Add(new PropPlacement("ServiceEntrance", "Details_Vent_1", new Vector3(44f, 6.2f, 108.15f), 180f,
                1f, false));

            // The stairs sit on the pit rim and step down into the bowl towards the door. Their run is
            // 2 m long for 1.4 m of drop, so they are sunk by most of that: the top tread meets the rim
            // and the bottom one lands on the floor, which is the only way a fixed staircase reads on a
            // ramp the terrain generator makes continuous.
            props.Add(new PropPlacement("ServiceEntrance", "catwalk-stairs", new Vector3(44f, 0f, 101f), 90f)
            {
                HeightOffset = -0.35f
            });
            props.Add(new PropPlacement("ServiceEntrance", "road_barrier", new Vector3(47f, 0f, 98f), 80f));
            // Props are never slope-aligned — the builder always uses Euler(0, yaw, 0) — so this one
            // stands upright on the pit ramp with the plain drop-to-ground default.
            props.Add(new PropPlacement("ServiceEntrance", "construction-barrier", new Vector3(41f, 0f, 97f), -20f));

            return props.ToArray();
        }

        private static string[] Series(string prefix, int first, int last)
        {
            string[] keys = new string[last - first + 1];

            for (int i = 0; i < keys.Length; i++)
            {
                keys[i] = prefix + (first + i);
            }

            return keys;
        }

        private static string[] Letters(string prefix, char first, char last)
        {
            string[] keys = new string[last - first + 1];

            for (int i = 0; i < keys.Length; i++)
            {
                keys[i] = prefix + (char)(first + i);
            }

            return keys;
        }

        private static float[] Repeat(float value, int count)
        {
            float[] weights = new float[count];

            for (int i = 0; i < count; i++)
            {
                weights[i] = value;
            }

            return weights;
        }

        private static T[] Concat<T>(params T[][] parts)
        {
            List<T> all = new List<T>();

            for (int i = 0; i < parts.Length; i++)
            {
                all.AddRange(parts[i]);
            }

            return all.ToArray();
        }

        [Button("Build Terrain Dressing"), TitleGroup("General")]
        private void BuildFromInspector()
        {
            TerrainDressingBuilder.Build(this);
        }

        /// <summary>Drops the scatter, detail and prop tables back to the authored defaults.</summary>
        [Button("Reset Authored Content"), TitleGroup("General")]
        private void ResetContentFromInspector()
        {
            TerrainDressingBuilder.ResetAuthoredContent(this);
        }
    }
}
