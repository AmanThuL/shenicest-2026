using System;
using System.Collections.Generic;
using System.IO;

namespace RootsDance.Editor.Environment
{
    /// <summary>What <see cref="EnvironmentPrefabBuilder"/> puts on the root of a dressing prefab.</summary>
    public enum ColliderKind
    {
        /// <summary>No collider — grass, plants, mushrooms and other things the player walks through.</summary>
        None,

        /// <summary>An upright capsule around the trunk of a tree, thin enough to not block the silhouette.</summary>
        TrunkCapsule,

        /// <summary>An axis-aligned box fitted to the renderer bounds.</summary>
        Box,

        /// <summary>A convex mesh collider on the model's largest mesh.</summary>
        MeshConvex
    }

    /// <summary>
    /// Maps one vendor sub-material onto a palette key. Matching is case-insensitive "contains" against the
    /// vendor material name; the first rule that hits wins, otherwise <see cref="PrefabEntry.DefaultMaterial"/>.
    /// </summary>
    [Serializable]
    public struct MaterialRule
    {
        /// <summary>Lower-case fragment searched for in the vendor material name.</summary>
        public string NameContains;

        /// <summary>Palette key applied when the fragment is found.</summary>
        public string MaterialKey;

        public MaterialRule(string nameContains, string materialKey)
        {
            NameContains = nameContains;
            MaterialKey = materialKey;
        }
    }

    /// <summary>One row of the dressing table: a vendor model plus how it becomes a project prefab.</summary>
    [Serializable]
    public struct PrefabEntry
    {
        /// <summary>
        /// Prefab name and lookup key. Usually the model file name without its extension; a logical material
        /// variant may deliberately reuse one source mesh under a distinct key (the dense grass-patch family).
        /// </summary>
        public string Key;

        /// <summary>Asset path of the vendor FBX under <c>Assets/ThirdParty/Environment/</c>.</summary>
        public string ModelPath;

        /// <summary>Sub-folder of <c>Assets/RootsDance/Prefabs/Environment/</c> the prefab is saved into.</summary>
        public string Category;

        /// <summary>Collider added to the prefab.</summary>
        public ColliderKind Collider;

        /// <summary>Vendor-material rules, evaluated in order.</summary>
        public MaterialRule[] Materials;

        /// <summary>Palette key used for every vendor material no rule matched.</summary>
        public string DefaultMaterial;

        /// <summary>Uniform scale applied to the prefab root so the model reads at real-world size.</summary>
        public float Scale;

        /// <summary>
        /// Name of the single renderer inside the vendor model this prefab is cut from, or null to keep the
        /// whole model. Vendor "kits" (the modular chain-link fence, the two moss-rock sets) ship every piece
        /// in one FBX laid out side by side; a kit is only usable once each piece is its own prefab.
        /// </summary>
        public string SubObject;

        public PrefabEntry(string key, string modelPath, string category, ColliderKind collider,
            MaterialRule[] materials, string defaultMaterial, float scale, string subObject = null)
        {
            Key = key;
            ModelPath = modelPath;
            Category = category;
            Collider = collider;
            Materials = materials;
            DefaultMaterial = defaultMaterial;
            Scale = scale;
            SubObject = subObject;
        }
    }

    /// <summary>
    /// The static list of every vendor model that becomes a dressing prefab, with its category, collider,
    /// material rules and the uniform scale applied to the wrapper root. Scales start at 1 (Poly Haven, Niwl
    /// and the PSX packs export in metres); the builder logs every prefab's world bounds so an outlier can be
    /// corrected here.
    /// <para>
    /// Pools (see the outdoor asset brief): dead trees + winter bushes for the outer dead ring, root/rock clutter,
    /// dry low growth, transition growth (Niwl), the broken boundary (fence, barrier) and camp evidence (Lab
    /// Assets, clipboard, binder).
    /// </para>
    /// </summary>
    public static class EnvironmentPrefabTable
    {
        /// <summary>Prefab sub-folder for trees, bushes, grass, ferns and ivy.</summary>
        public const string k_Vegetation = "Vegetation";

        /// <summary>Prefab sub-folder for the rock and root clutter.</summary>
        public const string k_Rocks = "Rocks";

        /// <summary>Prefab sub-folder for the photogrammetry hero pieces (dead trunks, branches).</summary>
        public const string k_Heroes = "Heroes";

        /// <summary>Prefab sub-folder for man-made boundary props: fence, concrete barrier.</summary>
        public const string k_Facility = "Facility";

        /// <summary>Prefab sub-folder for the hand-held camp evidence: sampling and recording tools.</summary>
        public const string k_Props = "Props";

        private const string k_ThirdPartyRoot = "Assets/ThirdParty/Environment/";
        private const string k_Retro = k_ThirdPartyRoot + "RetroPSXNature/Models/";
        private const string k_Niwl = k_ThirdPartyRoot + "NiwlPlants/Models/";
        private const string k_PolyHaven = k_ThirdPartyRoot + "PolyHaven/Models/";
        private const string k_Lab = k_ThirdPartyRoot + "LabAssetsCC0/Models/";

        private static readonly MaterialRule[] k_NoRules = new MaterialRule[0];

        // Lab Assets are modelled in centimetres (a test-tube rack measures 36 x 14 x 9 units).
        private const float k_LabScale = 0.01f;

        private static readonly MaterialRule[] k_PineRootsRules =
        {
            new MaterialRule("_a", "Scan_PineRoots_A"),
            new MaterialRule("_b", "Scan_PineRoots_B")
        };

        private static readonly MaterialRule[] k_FenceRules =
        {
            new MaterialRule("wire", "Scan_ChainlinkFence_Wire"),
            new MaterialRule("post", "Scan_ChainlinkFence_Posts")
        };

        private static readonly MaterialRule[] k_NiwlAlderRules =
        {
            new MaterialRule("bark", "Niwl_Tree_WillowBark"),
            new MaterialRule("leaves", "Niwl_TreeBranches")
        };

        private static readonly MaterialRule[] k_NiwlBirchRules =
        {
            new MaterialRule("bark", "Niwl_Tree_BirchBark"),
            new MaterialRule("leaves", "Niwl_TreeBranches")
        };

        private static readonly MaterialRule[] k_NiwlPineRules =
        {
            new MaterialRule("bark", "Niwl_Tree_WillowBark"),
            new MaterialRule("plant", "Niwl_Plants_Bunch")
        };

        // Lab Assets: "Solid" is the palette strip, "Solid - 25%" the vendor's 25 % opacity glass.
        private static readonly MaterialRule[] k_LabRules =
        {
            new MaterialRule("25%", "Lab_Glass")
        };

        /// <summary>Every dressing prefab, in build order.</summary>
        public static readonly PrefabEntry[] Entries =
        {
            // --- DeadTree_Sparse: Retro PSX Nature winter trees and bushes -------------------------------
            // The FBX trees split into "treeNN" (trunk + branches) and "treeNN_top" (crown cards) sharing one
            // vendor material: the crown gets the wind material, the trunk the static one. tree02 is the OBJ
            // export with both merged into one mesh, so it stays a static tree.
            PsxTree("tree01_winter", "Psx_Tree01_Winter"),
            new PrefabEntry("tree02_winter", k_Retro + "Trees/tree02_winter.obj", k_Vegetation,
                ColliderKind.TrunkCapsule, k_NoRules, "Psx_Tree02_Winter_Trunk", 1f),
            PsxTree("tree03_winter", "Psx_Tree03_Winter"),
            PsxTree("tree04_winter", "Psx_Tree04_Winter"),
            PsxTree("tree05_winter", "Psx_Tree05_Winter"),
            PsxTree("tree06_winter", "Psx_Tree06_Winter"),
            PsxBush("bush01_winter", "Psx_Bush01_Winter"),
            PsxBush("bush02_winter", "Psx_Bush02_Winter"),
            PsxBush("bush03_winter", "Psx_Bush03_Winter"),
            PsxBush("bush04_winter", "Psx_Bush04_Winter"),
            PsxBush("bush05_winter", "Psx_Bush05_Winter"),
            PsxBush("bush06_winter", "Psx_Bush06_Winter"),

            // --- DryLowGrowth: the two plain Retro bushes (fall sheet) ---------------------------------
            PsxBush("bush07", "Psx_Bush07_Fall"),
            PsxBush("bush08", "Psx_Bush08_Fall"),

            // --- Dense grass-band coverage -------------------------------------------------------------
            // Individual low-poly blades use the neutral winter sheet as an alpha-preserving tint base.
            // The two large patch meshes are intentionally reused under several material-variant keys: this
            // gives PWB/route builders seamless coverage without duplicating source geometry.
            PsxGrass("grass01", "Psx_Grass_Viridian"),
            PsxGrass("grass02", "Psx_Grass_Teal"),
            PsxGrass("grass03", "Psx_Grass_Cyan"),
            PsxGrass("grass04", "Psx_Grass_Violet"),
            PsxGrass("grass05", "Psx_Grass_Magenta"),
            PsxGrass("grass06", "Psx_Grass_Amber"),
            PsxGrass("grass07", "Psx_Grass_Rose"),
            PsxGrass("grass08", "Psx_Grass_Silver"),
            PsxGrass("grass09", "Psx_Grass_Chartreuse"),
            PsxGrass("grass_bush", "Psx_GrassBush_Healthy"),
            PsxGrassVariant("grass_patch", "grass_patch", "Psx_GrassPatch_Healthy"),
            PsxGrassVariant("grass_patch_viridian", "grass_patch", "Psx_GrassPatch_Viridian"),
            PsxGrassVariant("grass_patch_cyan", "grass_patch", "Psx_GrassPatch_Cyan"),
            PsxGrassVariant("grass_patch_violet", "grass_patch", "Psx_GrassPatch_Violet"),
            PsxGrassVariant("grass_patch_amber", "grass_patch", "Psx_GrassPatch_Amber"),
            PsxGrassVariant("grass_patch_rose", "grass_patch", "Psx_GrassPatch_Rose"),
            PsxGrassVariant("grass_patch_silver", "grass_patch", "Psx_GrassPatch_Silver"),
            PsxGrassVariant("grass_patch_corner", "grass_patch_corner", "Psx_GrassPatch_Healthy"),
            PsxGrassVariant("grass_patch_corner_cyan", "grass_patch_corner", "Psx_GrassPatch_Cyan"),
            PsxGrassVariant("grass_patch_corner_violet", "grass_patch_corner", "Psx_GrassPatch_Violet"),
            PsxGrassVariant("grass_patch_corner_amber", "grass_patch_corner", "Psx_GrassPatch_Amber"),

            // --- Healthy ordinary trees / bushes for the E-ring natural boundary -----------------------
            PsxSummerTree("tree01_summer", "tree01", "Psx_Tree01_Summer"),
            PsxSummerTree("tree02_summer", "tree02", "Psx_Tree02_Summer"),
            PsxSummerTree("tree03_summer", "tree03", "Psx_Tree03_Summer"),
            PsxSummerTree("tree04_summer", "tree04", "Psx_Tree04_Summer"),
            PsxSummerTree("tree05_summer", "tree05", "Psx_Tree05_Summer"),
            PsxSummerTree("tree06_summer", "tree06", "Psx_Tree06_Summer"),
            PsxSummerTree("tree07_summer", "tree07", "Psx_Tree07_Summer"),
            PsxSummerTree("tree08_summer", "tree08", "Psx_Tree08_Summer"),
            PsxSummerBush("bush01_summer", "bush01", "Psx_Bush01_Summer"),
            PsxSummerBush("bush02_summer", "bush02", "Psx_Bush02_Summer"),
            PsxSummerBush("bush03_summer", "bush03", "Psx_Bush03_Summer"),
            PsxSummerBush("bush04_summer", "bush04", "Psx_Bush04_Summer"),
            PsxSummerBush("bush05_summer", "bush05", "Psx_Bush05_Summer"),
            PsxSummerBush("bush06_summer", "bush06", "Psx_Bush06_Summer"),

            // --- Transition_Growth: Niwl grass patches, ferns, bushes, ivy ----------------------------
            Niwl("M3D_grass_patch_1", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_2", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_3", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_4", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_5", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_6", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_7", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_grass_patch_8", "Grass", "Niwl_Plants_General"),
            Niwl("M3D_fern-1", "Ferns", "Niwl_Plants_General"),
            Niwl("M3D_fern-2", "Ferns", "Niwl_Plants_General"),
            Niwl("M3D_bush-1", "Bushes", "Niwl_Plants_General"),
            Niwl("M3D_bush-2", "Bushes", "Niwl_Plants_General"),
            Niwl("M3D_bush-3", "Bushes", "Niwl_Plants_General"),
            Niwl("M3D_bush-4", "Bushes", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_1", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_2", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_3", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_4", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_6", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_7", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_ivy_8", "Ivy", "Niwl_Plants_Bunch"),
            Niwl("M3D_meadown", "Meadow", "Niwl_Plants_General"),
            Niwl("M3D_poppy-1", "Flowers", "Niwl_Plants_General"),
            Niwl("M3D_poppy2", "Flowers", "Niwl_Plants_General"),
            Niwl("M3D_sunflower", "Flowers", "Niwl_Plants_General"),
            NiwlTree("M3D_alder_1", k_NiwlAlderRules, "Niwl_TreeBranches"),
            NiwlTree("M3D_alder_2", k_NiwlAlderRules, "Niwl_TreeBranches"),
            NiwlTree("M3D_alder_3", k_NiwlAlderRules, "Niwl_TreeBranches"),
            NiwlTree("M3D_birch-tree-1", k_NiwlBirchRules, "Niwl_TreeBranches"),
            NiwlTree("M3D_birch-tree-2", k_NiwlBirchRules, "Niwl_TreeBranches"),
            NiwlTree("M3D_birch-tree-3", k_NiwlBirchRules, "Niwl_TreeBranches"),
            NiwlTree("M3D_pine", k_NiwlPineRules, "Niwl_Plants_Bunch"),

            // --- Dead wood heroes (Poly Haven scans) -------------------------------------------------
            Scan("dead_tree_trunk", k_Heroes, ColliderKind.MeshConvex, k_NoRules, "Scan_DeadTreeTrunk"),
            Scan("dead_tree_trunk_02", k_Heroes, ColliderKind.MeshConvex, k_NoRules, "Scan_DeadTreeTrunk02"),
            Scan("dry_branches_medium_01", k_Heroes, ColliderKind.None, k_NoRules, "Scan_DryBranchesMedium01"),

            // --- RootRock_Clutter (Poly Haven scans) ------------------------------------------------
            Scan("pine_roots", k_Rocks, ColliderKind.MeshConvex, k_PineRootsRules, "Scan_PineRoots_A"),
            Scan("root_cluster_01", k_Rocks, ColliderKind.MeshConvex, k_NoRules, "Scan_RootCluster01"),
            Scan("root_cluster_02", k_Rocks, ColliderKind.MeshConvex, k_NoRules, "Scan_RootCluster02"),
            Scan("single_root", k_Rocks, ColliderKind.MeshConvex, k_NoRules, "Scan_SingleRoot"),
            Scan("rock_moss_set_01", k_Rocks, ColliderKind.MeshConvex, k_NoRules, "Scan_RockMossSet01"),
            Scan("rock_moss_set_02", k_Rocks, ColliderKind.MeshConvex, k_NoRules, "Scan_RockMossSet02"),

            // Both moss-rock FBXs are a row of separate boulders. Placing the set drops six or seven rocks in
            // a straight line, so each boulder becomes its own prefab: set 01 is the 2-3 m slope boulders,
            // set 02 the 1-2 m ground stones.
            RockPiece("rock_moss_01", "rock_moss_set_01", "rock_moss_set_01_rock01", "Scan_RockMossSet01"),
            RockPiece("rock_moss_02", "rock_moss_set_01", "rock_moss_set_01_rock02", "Scan_RockMossSet01"),
            RockPiece("rock_moss_03", "rock_moss_set_01", "rock_moss_set_01_rock03", "Scan_RockMossSet01"),
            RockPiece("rock_moss_04", "rock_moss_set_01", "rock_moss_set_01_rock04", "Scan_RockMossSet01"),
            RockPiece("rock_moss_05", "rock_moss_set_01", "rock_moss_set_01_rock05", "Scan_RockMossSet01"),
            RockPiece("rock_moss_06", "rock_moss_set_01", "rock_moss_set_01_rock06", "Scan_RockMossSet01"),
            RockPiece("rock_moss_07", "rock_moss_set_02", "rock_moss_set_02_rock07", "Scan_RockMossSet02"),
            RockPiece("rock_moss_08", "rock_moss_set_02", "rock_moss_set_02_rock08", "Scan_RockMossSet02"),
            RockPiece("rock_moss_09", "rock_moss_set_02", "rock_moss_set_02_rock09", "Scan_RockMossSet02"),
            RockPiece("rock_moss_10", "rock_moss_set_02", "rock_moss_set_02_rock10", "Scan_RockMossSet02"),
            RockPiece("rock_moss_11", "rock_moss_set_02", "rock_moss_set_02_rock11", "Scan_RockMossSet02"),
            RockPiece("rock_moss_12", "rock_moss_set_02", "rock_moss_set_02_rock12", "Scan_RockMossSet02"),
            RockPiece("rock_moss_13", "rock_moss_set_02", "rock_moss_set_02_rock13", "Scan_RockMossSet02"),

            // --- BrokenBoundary ----------------------------------------------------------------------
            Scan("modular_chainlink_fence", k_Facility, ColliderKind.Box, k_FenceRules, "Scan_ChainlinkFence_Posts"),
            Scan("concrete_road_barrier", k_Facility, ColliderKind.Box, k_NoRules, "Scan_ConcreteRoadBarrier"),

            // The fence kit cut into placeable pieces. A run is posts on a 1 m (or 2 m) pitch with a wire
            // panel spanning each gap, so panel and post have to be separate prefabs; the gate and the corner
            // post give the run somewhere believable to start and stop.
            FencePiece("chainlink_panel", "modular_chainlink_fence"),
            FencePiece("chainlink_panel_double", "modular_chainlink_fence_double"),
            FencePiece("chainlink_post", "modular_chainlink_fence_post"),
            FencePiece("chainlink_post_end", "modular_chainlink_fence_end_01"),
            FencePiece("chainlink_post_corner", "modular_chainlink_fence_start_01_corner_01"),
            FencePiece("chainlink_gate_frame", "modular_chainlink_fence_door_frame"),
            FencePiece("chainlink_gate", "modular_chainlink_fence_door_gate"),

            // --- CampEvidence ------------------------------------------------------------------------
            Scan("clipboard", k_Props, ColliderKind.Box, k_NoRules, "Scan_Clipboard"),
            Scan("binder_notebook", k_Props, ColliderKind.Box, k_NoRules, "Scan_BinderNotebook"),
            Lab("bottle_test_tube_rack"),
            Lab("bottle_glassware_test_tube_medium"),
            Lab("bottle_glassware_test_tube_small"),
            Lab("bottle_glassware_vial_medium"),
            Lab("bottle_glassware_reagent_bottle_medium"),
            Lab("bottle_glassware_reagent_bottle_small"),
            Lab("bottle_glassware_centrifuge_tube"),
            Lab("bottle_dropper"),
            Lab("bottle_plastic_bottle_medium"),
            Lab("dish_petridish"),
            Lab("dish_watch_glass"),
            Lab("misc_wash_bottle"),
            Lab("misc_scale"),
            Lab("misc_magnifying_glass"),
            Lab("heating_equipment_thermometer"),
            Lab("heating_equipment_forceps"),
            Lab("clamp_tube_clamp"),
            Lab("ppe_rubber_gloves"),
            Lab("ppe_safety_glasses")
        };

        private static PrefabEntry PsxTree(string key, string crownMaterial)
        {
            MaterialRule[] rules = { new MaterialRule("_top", crownMaterial) };
            return new PrefabEntry(key, $"{k_Retro}Trees/{key}.fbx", k_Vegetation, ColliderKind.TrunkCapsule,
                rules, crownMaterial + "_Trunk", 1f);
        }

        private static PrefabEntry PsxBush(string key, string material)
        {
            return new PrefabEntry(key, $"{k_Retro}Bushes/{key}.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, material, 1f);
        }

        private static PrefabEntry PsxGrass(string key, string material)
        {
            return new PrefabEntry(key, $"{k_Retro}Grass/{key}.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, material, 1f);
        }

        private static PrefabEntry PsxGrassVariant(string key, string model, string material)
        {
            return new PrefabEntry(key, $"{k_Retro}Grass/{model}.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, material, 1f);
        }

        private static PrefabEntry PsxSummerTree(string key, string model, string crownMaterial)
        {
            MaterialRule[] rules = { new MaterialRule("_top", crownMaterial) };
            return new PrefabEntry(key, $"{k_Retro}Trees/{model}.fbx", k_Vegetation,
                ColliderKind.TrunkCapsule, rules, crownMaterial + "_Trunk", 1f);
        }

        private static PrefabEntry PsxSummerBush(string key, string model, string material)
        {
            return new PrefabEntry(key, $"{k_Retro}Bushes/{model}.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, material, 1f);
        }

        private static PrefabEntry Niwl(string key, string folder, string material)
        {
            return new PrefabEntry(key, $"{k_Niwl}{folder}/{key}.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, material, 1f);
        }

        private static PrefabEntry NiwlTree(string key, MaterialRule[] rules, string defaultMaterial)
        {
            return new PrefabEntry(key, $"{k_Niwl}Trees/{key}.fbx", k_Vegetation,
                ColliderKind.TrunkCapsule, rules, defaultMaterial, 1f);
        }

        private static PrefabEntry Scan(string key, string category, ColliderKind collider, MaterialRule[] rules,
            string material)
        {
            return new PrefabEntry(key, $"{k_PolyHaven}{key}/{key}_1k.fbx", category, collider, rules, material, 1f);
        }

        /// <summary>One piece of the modular chain-link kit, cut out of <c>modular_chainlink_fence_1k.fbx</c>.</summary>
        private static PrefabEntry FencePiece(string key, string subObject)
        {
            return new PrefabEntry(key, $"{k_PolyHaven}modular_chainlink_fence/modular_chainlink_fence_1k.fbx",
                k_Facility, ColliderKind.Box, k_FenceRules, "Scan_ChainlinkFence_Posts", 1f, subObject);
        }

        /// <summary>One boulder cut out of a moss-rock set FBX.</summary>
        private static PrefabEntry RockPiece(string key, string setName, string subObject, string material)
        {
            return new PrefabEntry(key, $"{k_PolyHaven}{setName}/{setName}_1k.fbx", k_Rocks,
                ColliderKind.MeshConvex, k_NoRules, material, 1f, subObject);
        }

        private static PrefabEntry Lab(string key)
        {
            return new PrefabEntry(key, $"{k_Lab}{key}.fbx", k_Props, ColliderKind.Box, k_LabRules, "Lab_Palette",
                k_LabScale);
        }
    }
}
