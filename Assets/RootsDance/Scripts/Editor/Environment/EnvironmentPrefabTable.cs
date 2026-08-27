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
        /// <summary>Prefab name and lookup key — always the FBX file name without its extension.</summary>
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

        public PrefabEntry(string key, string modelPath, string category, ColliderKind collider,
            MaterialRule[] materials, string defaultMaterial, float scale)
        {
            Key = key;
            ModelPath = modelPath;
            Category = category;
            Collider = collider;
            Materials = materials;
            DefaultMaterial = defaultMaterial;
            Scale = scale;
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

            // --- BrokenBoundary ----------------------------------------------------------------------
            Scan("modular_chainlink_fence", k_Facility, ColliderKind.Box, k_FenceRules, "Scan_ChainlinkFence_Posts"),
            Scan("concrete_road_barrier", k_Facility, ColliderKind.Box, k_NoRules, "Scan_ConcreteRoadBarrier"),

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

        private static PrefabEntry Niwl(string key, string folder, string material)
        {
            return new PrefabEntry(key, $"{k_Niwl}{folder}/{key}.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, material, 1f);
        }

        private static PrefabEntry Scan(string key, string category, ColliderKind collider, MaterialRule[] rules,
            string material)
        {
            return new PrefabEntry(key, $"{k_PolyHaven}{key}/{key}_1k.fbx", category, collider, rules, material, 1f);
        }

        private static PrefabEntry Lab(string key)
        {
            return new PrefabEntry(key, $"{k_Lab}{key}.fbx", k_Props, ColliderKind.Box, k_LabRules, "Lab_Palette",
                k_LabScale);
        }
    }
}
