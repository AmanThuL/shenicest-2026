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
    /// material rules and the uniform scale measured against the greybox (birches 6-10 m, Kenney rocks
    /// 0.5-2 m, Kenney road signs 2-3 m, PSX barrier ~1 m, Quaternius sci-fi wall 4 m).
    /// </summary>
    public static class EnvironmentPrefabTable
    {
        /// <summary>Prefab sub-folder for trees, bushes, grass, logs and mushrooms.</summary>
        public const string k_Vegetation = "Vegetation";

        /// <summary>Prefab sub-folder for the Kenney rock and stone set.</summary>
        public const string k_Rocks = "Rocks";

        /// <summary>Prefab sub-folder for the photogrammetry hero props.</summary>
        public const string k_Heroes = "Heroes";

        /// <summary>Prefab sub-folder for man-made props: barriers, signs, pipes, sci-fi panels.</summary>
        public const string k_Facility = "Facility";

        private const string k_ThirdPartyRoot = "Assets/ThirdParty/Environment/";
        private const string k_Nature = k_ThirdPartyRoot + "Quaternius/UltimateNature/";
        private const string k_SciFi = k_ThirdPartyRoot + "Quaternius/ModularSciFi/";
        private const string k_KenneyNature = k_ThirdPartyRoot + "Kenney/NatureKit/";
        private const string k_KenneyRoad = k_ThirdPartyRoot + "Kenney/RoadKit/";
        private const string k_KenneyFactory = k_ThirdPartyRoot + "Kenney/FactoryKit/";
        private const string k_Psx = k_ThirdPartyRoot + "Retroarchy/PsxRoadBarriers/";
        private const string k_PolyHaven = k_ThirdPartyRoot + "PolyHaven/Models/";

        private static readonly MaterialRule[] k_NoRules = new MaterialRule[0];

        // Quaternius names its foliage by colour (Green, DarkGreen, Orange, LightOrange); the leaf/foliage
        // fragments are kept so a differently named pack still lands on the right palette key.
        private static readonly MaterialRule[] k_LeafDeadRules =
        {
            new MaterialRule("green", "Leaf_Dead"),
            new MaterialRule("leaf", "Leaf_Dead"),
            new MaterialRule("leaves", "Leaf_Dead"),
            new MaterialRule("foliage", "Leaf_Dead"),
            new MaterialRule("crown", "Leaf_Dead")
        };

        private static readonly MaterialRule[] k_LeafAliveRules =
        {
            new MaterialRule("green", "Leaf_Alive"),
            new MaterialRule("leaf", "Leaf_Alive"),
            new MaterialRule("leaves", "Leaf_Alive"),
            new MaterialRule("foliage", "Leaf_Alive"),
            new MaterialRule("crown", "Leaf_Alive")
        };

        private static readonly MaterialRule[] k_LeafHalfRules =
        {
            new MaterialRule("orange", "Leaf_Half"),
            new MaterialRule("green", "Leaf_Half"),
            new MaterialRule("leaf", "Leaf_Half"),
            new MaterialRule("leaves", "Leaf_Half"),
            new MaterialRule("foliage", "Leaf_Half"),
            new MaterialRule("crown", "Leaf_Half")
        };

        private static readonly MaterialRule[] k_PlantRules =
        {
            new MaterialRule("berr", "Mushroom_Red")
        };

        // Stumps and logs carry moss (Quaternius calls it Green/DarkGreen) and small mushrooms.
        private static readonly MaterialRule[] k_WoodRules =
        {
            new MaterialRule("mushroom_top", "Mushroom_Red"),
            new MaterialRule("mushroom", "Mushroom_Tan"),
            new MaterialRule("moss", "Rock_Moss"),
            new MaterialRule("green", "Rock_Moss")
        };

        private static readonly MaterialRule[] k_MushroomRedRules =
        {
            new MaterialRule("red", "Mushroom_Red"),
            new MaterialRule("cap", "Mushroom_Red")
        };

        private static readonly MaterialRule[] k_RockRules =
        {
            new MaterialRule("moss", "Rock_Moss"),
            new MaterialRule("grass", "Rock_Moss")
        };

        private static readonly MaterialRule[] k_PineRootsRules =
        {
            new MaterialRule("_a", "Scan_PineRoots_A"),
            new MaterialRule("_b", "Scan_PineRoots_B")
        };

        // Kenney's road and factory kits ship a single "colormap" atlas material per model, so these
        // fragments never hit; the per-model DefaultMaterial carries the look instead.
        private static readonly MaterialRule[] k_SignRules =
        {
            new MaterialRule("sign", "Sign_Face"),
            new MaterialRule("face", "Sign_Face"),
            new MaterialRule("board", "Sign_Face"),
            new MaterialRule("white", "Sign_Face")
        };

        private static readonly MaterialRule[] k_ValveRules =
        {
            new MaterialRule("valve", "Metal_Rust"),
            new MaterialRule("red", "Metal_Rust")
        };

        // Quaternius sci-fi panels: Main/DarkGrey are the wall, Light is the emissive strip, Accent the trim.
        private static readonly MaterialRule[] k_WallRules =
        {
            new MaterialRule("door", "Metal_Rust"),
            new MaterialRule("light", "Sign_Face"),
            new MaterialRule("accent", "Metal_Dark")
        };

        private static PrefabEntry[] s_entries;

        /// <summary>
        /// Every dressing prefab the builder produces, in build order. Built lazily rather than from a
        /// static field initializer: <see cref="BuildEntries"/> reads the <c>k_*Rules</c> arrays above, and a
        /// field initializer would tie correctness to declaration order within this class.
        /// </summary>
        public static PrefabEntry[] Entries
        {
            get
            {
                if (s_entries == null)
                {
                    s_entries = BuildEntries();
                }

                return s_entries;
            }
        }

        private static PrefabEntry[] BuildEntries()
        {
            List<PrefabEntry> list = new List<PrefabEntry>(128);

            AddSeries(list, k_Nature, "BirchTree_Dead_", 1, 5, k_Vegetation, ColliderKind.TrunkCapsule,
                k_LeafDeadRules, "Bark_Dead", 2.4f);
            AddSeries(list, k_Nature, "Willow_Dead_", 1, 5, k_Vegetation, ColliderKind.TrunkCapsule,
                k_LeafDeadRules, "Bark_Dead", 2.6f);
            AddSeries(list, k_Nature, "BirchTree_", 1, 5, k_Vegetation, ColliderKind.TrunkCapsule,
                k_LeafAliveRules, "Bark_Alive", 2f);
            AddSeries(list, k_Nature, "CommonTree_", 1, 3, k_Vegetation, ColliderKind.TrunkCapsule,
                k_LeafAliveRules, "Bark_Alive", 2.4f);
            AddSeries(list, k_Nature, "BirchTree_Autumn_", 1, 3, k_Vegetation, ColliderKind.TrunkCapsule,
                k_LeafHalfRules, "Bark_Alive", 2f);

            AddSeries(list, k_Nature, "Bush_", 1, 2, k_Vegetation, ColliderKind.None,
                k_PlantRules, "Plant_Cold", 1f);
            AddSeries(list, k_Nature, "Plant_", 1, 5, k_Vegetation, ColliderKind.None,
                k_PlantRules, "Plant_Cold", 1f);
            Add(list, k_Nature + "BushBerries_1.fbx", k_Vegetation, ColliderKind.None,
                k_PlantRules, "Plant_Cold", 1f);
            AddMany(list, k_KenneyNature, new[] { "plant_bush", "plant_bushLarge", "plant_bushSmall", "grass_leafs",
                "grass_large" }, k_Vegetation, ColliderKind.None, k_PlantRules, "Plant_Cold", 2f);

            AddMany(list, k_Nature, new[] { "Grass", "Grass_2", "Grass_Short" }, k_Vegetation, ColliderKind.None,
                k_NoRules, "Grass_Silver", 0.5f);

            AddMany(list, k_Nature, new[] { "TreeStump", "WoodLog" }, k_Vegetation, ColliderKind.Box,
                k_WoodRules, "Wood_Log", 1f);
            AddMany(list, k_Nature, new[] { "TreeStump_Moss", "WoodLog_Moss" }, k_Vegetation, ColliderKind.Box,
                k_WoodRules, "Wood_Log", 1f);
            Add(list, k_KenneyNature + "log_large.fbx", k_Vegetation, ColliderKind.Box, k_WoodRules, "Wood_Log", 2f);
            Add(list, k_KenneyNature + "stump_round.fbx", k_Vegetation, ColliderKind.Box, k_WoodRules, "Wood_Log",
                2.5f);

            AddMany(list, k_KenneyNature, new[] { "mushroom_tan", "mushroom_tanGroup", "mushroom_tanTall" },
                k_Vegetation, ColliderKind.None, k_NoRules, "Mushroom_Tan", 1.5f);
            Add(list, k_KenneyNature + "mushroom_redGroup.fbx", k_Vegetation, ColliderKind.None,
                k_MushroomRedRules, "Mushroom_Tan", 1.5f);
            Add(list, k_KenneyNature + "hanging_moss.fbx", k_Vegetation, ColliderKind.None,
                k_NoRules, "Plant_Cold", 2f);

            AddLetters(list, k_KenneyNature, "rock_large", 'A', 'F', k_Rocks, ColliderKind.MeshConvex,
                k_RockRules, "Rock_Grey", 1.6f);
            AddLetters(list, k_KenneyNature, "rock_tall", 'A', 'D', k_Rocks, ColliderKind.MeshConvex,
                k_RockRules, "Rock_Grey", 1.6f);
            AddLetters(list, k_KenneyNature, "stone_large", 'A', 'C', k_Rocks, ColliderKind.MeshConvex,
                k_RockRules, "Rock_Grey", 1.6f);
            AddLetters(list, k_KenneyNature, "rock_small", 'A', 'D', k_Rocks, ColliderKind.None,
                k_RockRules, "Rock_Grey", 1.6f);

            Add(list, k_PolyHaven + "DeadTreeTrunk/dead_tree_trunk_1k.fbx", k_Heroes, ColliderKind.MeshConvex,
                k_NoRules, "Scan_DeadTreeTrunk", 1f);
            Add(list, k_PolyHaven + "TreeStump02/tree_stump_02_1k.fbx", k_Heroes, ColliderKind.MeshConvex,
                k_NoRules, "Scan_TreeStump02", 1f);
            Add(list, k_PolyHaven + "PineRoots/pine_roots_1k.fbx", k_Heroes, ColliderKind.MeshConvex,
                k_PineRootsRules, "Scan_PineRoots_A", 1f);
            Add(list, k_PolyHaven + "DryBranchesMedium01/dry_branches_medium_01_1k.fbx", k_Heroes,
                ColliderKind.None, k_NoRules, "Scan_DryBranchesMedium01", 1f);
            Add(list, k_PolyHaven + "RockMossSet02/rock_moss_set_02_1k.fbx", k_Heroes, ColliderKind.None,
                k_NoRules, "Scan_RockMossSet02", 1f);

            AddMany(list, k_Psx, new[] { "road_barrier", "road_barrier_broken", "pole" }, k_Facility,
                ColliderKind.Box, k_NoRules, "Psx_RoadBarrier", 1.8f);

            AddMany(list, k_KenneyRoad, new[] { "road-sign-empty", "road-sign-empty-hanging" },
                k_Facility, ColliderKind.Box, k_SignRules, "Sign_Face", 5f);
            Add(list, k_KenneyRoad + "sign-highway.fbx", k_Facility, ColliderKind.Box, k_SignRules, "Sign_Face", 4f);
            Add(list, k_KenneyRoad + "electricity-pole.fbx", k_Facility, ColliderKind.Box, k_SignRules,
                "Metal_Dark", 5f);
            AddMany(list, k_KenneyRoad, new[] { "construction-fence", "construction-barrier", "dumpster" },
                k_Facility, ColliderKind.Box, k_NoRules, "Metal_Rust", 5f);

            AddMany(list, k_KenneyFactory, new[] { "pipe-large", "pipe-large-long", "pipe-large-bend",
                "pipe-large-junction", "catwalk-straight" }, k_Facility, ColliderKind.Box, k_NoRules,
                "Metal_Dark", 1f);
            Add(list, k_KenneyFactory + "catwalk-stairs.fbx", k_Facility, ColliderKind.MeshConvex, k_NoRules,
                "Metal_Dark", 1f);
            Add(list, k_KenneyFactory + "pipe-large-valve.fbx", k_Facility, ColliderKind.Box, k_ValveRules,
                "Metal_Dark", 1f);

            AddSeries(list, k_SciFi, "Details_Vent_", 1, 5, k_Facility, ColliderKind.Box, k_NoRules,
                "Metal_Dark", 1f);
            AddMany(list, k_SciFi, new[] { "RoofTile_Vents", "Details_Pipes_Long", "Details_Pipes_Medium",
                "Door_Single" }, k_Facility, ColliderKind.Box, k_NoRules, "Metal_Dark", 1f);
            AddMany(list, k_SciFi, new[] { "DoorSingle_Wall_SideA", "Wall_Empty" }, k_Facility, ColliderKind.Box,
                k_WallRules, "Concrete_Pale", 1f);

            return list.ToArray();
        }

        private static void Add(List<PrefabEntry> list, string modelPath, string category, ColliderKind collider,
            MaterialRule[] rules, string defaultMaterial, float scale)
        {
            string key = Path.GetFileNameWithoutExtension(modelPath);
            list.Add(new PrefabEntry(key, modelPath, category, collider, rules, defaultMaterial, scale));
        }

        private static void AddMany(List<PrefabEntry> list, string folder, string[] names, string category,
            ColliderKind collider, MaterialRule[] rules, string defaultMaterial, float scale)
        {
            foreach (string name in names)
            {
                Add(list, folder + name + ".fbx", category, collider, rules, defaultMaterial, scale);
            }
        }

        private static void AddSeries(List<PrefabEntry> list, string folder, string prefix, int first, int last,
            string category, ColliderKind collider, MaterialRule[] rules, string defaultMaterial, float scale)
        {
            for (int i = first; i <= last; i++)
            {
                Add(list, $"{folder}{prefix}{i}.fbx", category, collider, rules, defaultMaterial, scale);
            }
        }

        private static void AddLetters(List<PrefabEntry> list, string folder, string prefix, char first, char last,
            string category, ColliderKind collider, MaterialRule[] rules, string defaultMaterial, float scale)
        {
            for (char c = first; c <= last; c++)
            {
                Add(list, $"{folder}{prefix}{c}.fbx", category, collider, rules, defaultMaterial, scale);
            }
        }
    }
}
