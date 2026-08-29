using System.Collections.Generic;
using System.IO;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>Guards the source-only contract of the environment prefab build table.</summary>
    public sealed class EnvironmentPrefabTableTests
    {
        private static readonly string[] k_NewWalkThroughKeys =
        {
            "grass01", "grass02", "grass03", "grass04", "grass05", "grass06", "grass07", "grass08",
            "grass09", "grass_bush", "grass_patch", "grass_patch_viridian", "grass_patch_cyan", "grass_patch_violet",
            "grass_patch_amber", "grass_patch_rose", "grass_patch_silver", "grass_patch_corner",
            "grass_patch_corner_cyan", "grass_patch_corner_violet", "grass_patch_corner_amber",
            "bush01_summer", "bush02_summer", "bush03_summer", "bush04_summer", "bush05_summer",
            "bush06_summer", "M3D_ivy_6", "M3D_ivy_7", "M3D_ivy_8", "M3D_meadown", "M3D_poppy-1",
            "M3D_poppy2", "M3D_sunflower",
        };

        private static readonly string[] k_NewTreeKeys =
        {
            "tree01_summer", "tree02_summer", "tree03_summer", "tree04_summer", "tree05_summer",
            "tree06_summer", "tree07_summer", "tree08_summer", "M3D_alder_1", "M3D_alder_2",
            "M3D_alder_3", "M3D_birch-tree-1", "M3D_birch-tree-2", "M3D_birch-tree-3", "M3D_pine",
        };

        [Test]
        public void Entries_HaveUniqueNonEmptyKeysAndExistingModels()
        {
            HashSet<string> seen = new HashSet<string>();
            string projectRoot = Directory.GetParent(Application.dataPath).FullName;

            foreach (PrefabEntry entry in EnvironmentPrefabTable.Entries)
            {
                Assert.IsFalse(string.IsNullOrWhiteSpace(entry.Key), "empty prefab key");
                Assert.IsTrue(seen.Add(entry.Key), entry.Key + " is duplicated");
                string absolutePath = Path.Combine(projectRoot, entry.ModelPath);
                Assert.IsTrue(File.Exists(absolutePath), entry.Key + " model is missing at " + entry.ModelPath);
            }
        }

        [Test]
        public void Entries_OnlyReferenceDeclaredPaletteKeys()
        {
            foreach (PrefabEntry entry in EnvironmentPrefabTable.Entries)
            {
                Assert.IsTrue(EnvironmentPalette.HasMaterialKey(entry.DefaultMaterial),
                    entry.Key + " references unknown default material " + entry.DefaultMaterial);

                if (entry.Materials == null)
                {
                    continue;
                }

                foreach (MaterialRule rule in entry.Materials)
                {
                    Assert.IsTrue(EnvironmentPalette.HasMaterialKey(rule.MaterialKey),
                        entry.Key + " references unknown rule material " + rule.MaterialKey);
                }
            }
        }

        [Test]
        public void NewGrassFlowersAndBushes_AreWalkThrough()
        {
            Dictionary<string, PrefabEntry> byKey = ByKey();

            foreach (string key in k_NewWalkThroughKeys)
            {
                Assert.IsTrue(byKey.ContainsKey(key), key + " is missing");
                Assert.AreEqual(ColliderKind.None, byKey[key].Collider, key);
            }
        }

        [Test]
        public void NaturalBoundaryTrees_UseTrunkCapsules()
        {
            Dictionary<string, PrefabEntry> byKey = ByKey();

            foreach (string key in k_NewTreeKeys)
            {
                Assert.IsTrue(byKey.ContainsKey(key), key + " is missing");
                Assert.AreEqual(ColliderKind.TrunkCapsule, byKey[key].Collider, key);
            }
        }

        private static Dictionary<string, PrefabEntry> ByKey()
        {
            Dictionary<string, PrefabEntry> result = new Dictionary<string, PrefabEntry>();

            foreach (PrefabEntry entry in EnvironmentPrefabTable.Entries)
            {
                result.Add(entry.Key, entry);
            }

            return result;
        }
    }
}
