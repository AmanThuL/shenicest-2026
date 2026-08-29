using System;
using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using RootsDance.Scanner;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    public sealed class Chapter00ZoneVegetationLayoutTests
    {
        [Test]
        public void FixedRadii_ClassifyAThroughE()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            Vector2 c = p.RingCenter;

            Assert.AreEqual(Chapter00VegetationZone.E,
                Chapter00ZoneVegetationLayout.ClassifyZone(p, c + Vector2.up * 20f));
            Assert.AreEqual(Chapter00VegetationZone.D,
                Chapter00ZoneVegetationLayout.ClassifyZone(p, c + Vector2.up * 61f));
            Assert.AreEqual(Chapter00VegetationZone.C,
                Chapter00ZoneVegetationLayout.ClassifyZone(p, c + Vector2.up * 79f));
            Assert.AreEqual(Chapter00VegetationZone.B,
                Chapter00ZoneVegetationLayout.ClassifyZone(p, c + Vector2.up * 101f));
            Assert.AreEqual(Chapter00VegetationZone.A,
                Chapter00ZoneVegetationLayout.ClassifyZone(p, c + Vector2.up * 122f));
        }

        [Test]
        public void DefaultRoute_UsesCorridor1Coordinates()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();

            CollectionAssert.AreEqual(new[]
            {
                new Vector2(0f, -10f), new Vector2(-7f, 4f), new Vector2(-15f, 18f),
                new Vector2(-16f, 28f), new Vector2(-12f, 39f), new Vector2(-6f, 52f),
                new Vector2(0f, 66f), new Vector2(1.5f, 73.5f), new Vector2(8f, 82f),
                new Vector2(16f, 88f), new Vector2(24f, 92.5f), new Vector2(30f, 96.2f),
            }, p.Routes[0]);
            Assert.AreEqual(new Vector2(37f, 106f), p.Corridor1Route[p.Corridor1Route.Length - 1]);
            Assert.AreEqual(new Vector2(1.5f, 73.5f), p.DomeViewOrigins[0]);
        }

        [Test]
        public void CCarpet_UsesReducedDensityAndNewPatchVariants()
        {
            Chapter00VegetationLayerSpec c = FindLayer(
                Chapter00ZoneVegetationParams.CreateDefault(),
                Chapter00VegetationZone.C,
                Chapter00VegetationRole.WalkThroughGroundCover,
                0);

            Assert.That(c.FootprintOverlap, Is.InRange(-.16f, -.12f));
            CollectionAssert.Contains(c.PrefabKeys, "grass_patch_viridian");
            CollectionAssert.Contains(c.PrefabKeys, "grass_patch_violet");
            CollectionAssert.Contains(c.PrefabKeys, "grass_patch_rose");
            CollectionAssert.Contains(c.PrefabKeys, "grass_patch_corner_cyan");
            Assert.AreEqual(0f, c.RouteClearance,
                "C walk-through grass must cross the route instead of cutting a bare trail.");
        }

        [Test]
        public void EveryDefaultPrefabKey_IsRegistered()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            HashSet<string> checkedKeys = new HashSet<string>();

            for (int layer = 0; layer < p.Layers.Length; layer++)
            {
                foreach (string key in p.Layers[layer].PrefabKeys)
                {
                    if (!checkedKeys.Add(key)) continue;
                    string path = EnvironmentPrefabBuilder.PrefabPath(key);
                    Assert.IsNotNull(path, key + " is absent from EnvironmentPrefabTable");

                    // Imported source assets and generated prefabs land in separate commits. A missing built
                    // prefab is actionable but should not hide a broken table key behind a null path.
                    if (AssetDatabase.LoadAssetAtPath<GameObject>(path) == null)
                    {
                        Assert.Inconclusive(path + " is not built yet; run Build Environment Prefabs.");
                    }
                }
            }
        }

        [Test]
        public void Layout_IsDeterministicAndTargetHeightsStayInLayerRanges()
        {
            Chapter00ZoneVegetationParams p = SmallDefault();
            UniformMetrics metrics = MetricsFor(p, 1f, new Vector2(8f, 8f));
            List<Chapter00VegetationPlacement> first = Chapter00ZoneVegetationLayout.Build(p, metrics);
            List<Chapter00VegetationPlacement> second = Chapter00ZoneVegetationLayout.Build(p, metrics);

            Assert.AreEqual(first.Count, second.Count);
            Assert.Greater(first.Count, 100);

            for (int i = 0; i < first.Count; i++)
            {
                Assert.AreEqual(first[i].PrefabKey, second[i].PrefabKey);
                Assert.AreEqual(first[i].Position, second[i].Position);
                Assert.AreEqual(first[i].TargetHeight, second[i].TargetHeight);
                Chapter00VegetationLayerSpec layer = MatchingLayer(p, first[i]);
                Assert.That(first[i].TargetHeight,
                    Is.InRange(layer.TargetHeightMin, layer.TargetHeightMax));
            }
        }

        [Test]
        public void CCarpet_RetainsBroadCoverageWithIntentionalGaps()
        {
            Chapter00ZoneVegetationParams source = Chapter00ZoneVegetationParams.CreateDefault();
            Chapter00VegetationLayerSpec c = FindLayer(source, Chapter00VegetationZone.C,
                Chapter00VegetationRole.WalkThroughGroundCover, 0);
            c.PrefabKeys = new[] { "test_patch" };
            c.TargetHeightMin = 1f;
            c.TargetHeightMax = 1f;

            Chapter00ZoneVegetationParams p = new Chapter00ZoneVegetationParams
            {
                RingCenter = source.RingCenter,
                VisibleEnvelopes = new[] { new Chapter00ViewEnvelope(new Vector2(0f, 34f), 7f) },
                Routes = new[] { new[] { new Vector2(-6f, 34f), new Vector2(6f, 34f) } },
                Corridor1Route = source.Corridor1Route,
                Checkpoints = new Vector2[0],
                DomeViewOrigins = source.DomeViewOrigins,
                DomeTarget = source.DomeTarget,
                Layers = new[] { c },
            };
            UniformMetrics metrics = new UniformMetrics();
            metrics.Add("test_patch", new Chapter00PrefabMetrics(1f, new Vector2(2.8f, 2.8f)));
            List<Chapter00VegetationPlacement> placements = Chapter00ZoneVegetationLayout.Build(p, metrics);

            int covered = 0;
            int sampled = 0;
            for (float z = 29f; z <= 39f; z += .4f)
            {
                for (float x = -5f; x <= 5f; x += .4f)
                {
                    Vector2 point = new Vector2(x, z);
                    if (Vector2.Distance(point, new Vector2(0f, 34f)) > 5f) continue;
                    sampled++;
                    if (Chapter00ZoneVegetationLayout.IsCovered(
                        point, placements, Chapter00VegetationZone.C)) covered++;
                }
            }

            float coverage = covered / (float)sampled;
            Assert.That(coverage, Is.InRange(.50f, .75f),
                "C carpet should remain visually dominant while exposing deliberate terrain gaps.");
        }

        [Test]
        public void CCarpet_CrossesRouteAndUsesBothMutationShades()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            // Validate the complete authored C envelope, but generate only its carpet layer. The compact
            // multi-zone fixture intentionally clips the outer C cells and can omit a low-weight colour.
            p.Layers = new[]
            {
                FindLayer(p, Chapter00VegetationZone.C,
                    Chapter00VegetationRole.WalkThroughGroundCover, 0),
            };
            UniformMetrics metrics = MetricsFor(p, 1f, new Vector2(8f, 8f));
            List<Chapter00VegetationPlacement> placements = Chapter00ZoneVegetationLayout.Build(p, metrics);
            HashSet<Chapter00VegetationTint> colours = new HashSet<Chapter00VegetationTint>();
            bool routeCovered = false;

            foreach (Chapter00VegetationPlacement placement in placements)
            {
                if (placement.Zone != Chapter00VegetationZone.C
                    || placement.Role != Chapter00VegetationRole.WalkThroughGroundCover) continue;
                colours.Add(placement.Tint);
                if (Chapter00ZoneVegetationLayout.DistanceToRoutes(p.Routes, placement.Position) < .7f)
                {
                    routeCovered = true;
                }
            }

            Assert.IsTrue(routeCovered);
            CollectionAssert.AreEquivalent(new[]
            {
                Chapter00VegetationTint.MutedViolet,
                Chapter00VegetationTint.FadedPink,
            }, colours);
            Assert.AreEqual(2, colours.Count);
        }

        [Test]
        public void AllCVegetation_UsesOnlyBothMutationShades()
        {
            Chapter00ZoneVegetationParams p = SmallDefault();
            UniformMetrics metrics = MetricsFor(p, 1f, new Vector2(8f, 8f));
            List<Chapter00VegetationPlacement> placements = Chapter00ZoneVegetationLayout.Build(p, metrics);

            foreach (Chapter00VegetationPlacement placement in placements)
            {
                if (placement.Zone != Chapter00VegetationZone.C) continue;
                Assert.That(placement.Tint, Is.EqualTo(Chapter00VegetationTint.FadedPink)
                    .Or.EqualTo(Chapter00VegetationTint.MutedViolet));
            }
        }

        [Test]
        public void InstalledCGroup_HasVisibleScannableTanmaoBesideRoute()
        {
            GameObject group = AssetDatabase.LoadAssetAtPath<GameObject>(
                "Assets/RootsDance/Prefabs/Environment/Chapter00ZoneVegetation/"
                + "C00V_Group_ZoneC_AnomalousCarpet.prefab");
            Assert.IsNotNull(group);
            ScannableTarget target = group.GetComponentInChildren<ScannableTarget>(true);
            Assert.IsNotNull(target);
            Assert.AreEqual("变异毯茅", target.DisplayName);
            Assert.IsNotNull(target.GetComponent<ScannerWorldStateResult>());
            Assert.IsEmpty(target.GetComponentsInChildren<Collider>(true));

            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            Vector2 point = new Vector2(target.transform.position.x, target.transform.position.z);
            float routeDistance = Chapter00ZoneVegetationLayout.DistanceToRoutes(p.Routes, point);
            Assert.That(routeDistance, Is.InRange(1f, 3f));

            Renderer[] renderers = target.GetComponentsInChildren<Renderer>(true);
            Assert.IsNotEmpty(renderers);
            Bounds bounds = renderers[0].bounds;
            for (int i = 1; i < renderers.Length; i++) bounds.Encapsulate(renderers[i].bounds);
            Assert.That(bounds.size.y, Is.InRange(1.20f, 1.30f));
            Assert.AreEqual(.65f, renderers[0].sharedMaterial.GetFloat("_EmissiveIntensityValue"), .001f);

            Transform[] transforms = target.GetComponentsInChildren<Transform>(true);
            int scannableLayer = LayerMask.NameToLayer("Scannable");
            foreach (Transform child in transforms) Assert.AreEqual(scannableLayer, child.gameObject.layer);

            Transform[] allGroupTransforms = group.GetComponentsInChildren<Transform>(true);
            int nonPhysicalPlantCount = 0;
            foreach (Transform child in allGroupTransforms)
            {
                if (child.name.StartsWith("C00V_C_WalkThroughGroundCover_", StringComparison.Ordinal)
                    || child.name.StartsWith("C00V_C_MidLayer_", StringComparison.Ordinal))
                {
                    nonPhysicalPlantCount++;
                }
            }
            Assert.That(nonPhysicalPlantCount, Is.InRange(1400, 1500),
                "Installed C vegetation must stay visually present without exceeding the 1,500-plant cap.");
        }

        [Test]
        public void EPhysicalBlockers_LeaveCorridorAndDomeViewConeOpen()
        {
            Chapter00ZoneVegetationParams p = SmallDefault();
            UniformMetrics metrics = MetricsFor(p, 1f, new Vector2(8f, 8f));
            List<Chapter00VegetationPlacement> placements = Chapter00ZoneVegetationLayout.Build(p, metrics);
            int blockers = 0;
            int lowSightlineBarriers = 0;
            Chapter00VegetationLayerSpec culledLayer = null;
            foreach (Chapter00VegetationLayerSpec layer in p.Layers)
            {
                if (layer.Zone == Chapter00VegetationZone.E
                    && layer.Role == Chapter00VegetationRole.PhysicalBlocker
                    && layer.CullFromDomeViewCone)
                {
                    culledLayer = layer;
                    break;
                }
            }
            Assert.IsNotNull(culledLayer);

            foreach (Chapter00VegetationPlacement placement in placements)
            {
                if (placement.Zone != Chapter00VegetationZone.E
                    || placement.Role != Chapter00VegetationRole.PhysicalBlocker) continue;
                blockers++;
                Assert.GreaterOrEqual(
                    Chapter00ZoneVegetationLayout.DistanceToRoute(p.Corridor1Route, placement.Position),
                    p.CorridorVisualHalfWidth);

                bool highCanopy = Array.IndexOf(culledLayer.PrefabKeys, placement.PrefabKey) >= 0;
                if (highCanopy)
                {
                    Assert.IsFalse(Chapter00ZoneVegetationLayout.IsInDomeViewCone(p, placement.Position));
                }
                else if (Chapter00ZoneVegetationLayout.IsInDomeViewCone(p, placement.Position))
                {
                    lowSightlineBarriers++;
                }
            }

            Assert.Greater(blockers, 10);
            Assert.Greater(lowSightlineBarriers, 0,
                "Low root/rock blockers must seal the dome sightline against walkable shortcuts.");
        }

        [Test]
        public void PwbOwnership_UsesOnlyZonePalettesAndPin()
        {
            Assert.AreEqual("ZoneA_DeadGrowth",
                Chapter00ZoneVegetationParams.PaletteName(Chapter00VegetationZone.A,
                    Chapter00VegetationRole.WalkThroughGroundCover));
            Assert.AreEqual("ZoneC_AnomalousCarpet",
                Chapter00ZoneVegetationParams.PaletteName(Chapter00VegetationZone.C,
                    Chapter00VegetationRole.MidLayer));
            Assert.AreEqual("ZoneE_Corridor1Ecology",
                Chapter00ZoneVegetationParams.PaletteName(Chapter00VegetationZone.E,
                    Chapter00VegetationRole.WalkThroughGroundCover));
            Assert.AreEqual("ZoneE_NaturalBlockers",
                Chapter00ZoneVegetationParams.PaletteName(Chapter00VegetationZone.E,
                    Chapter00VegetationRole.PhysicalBlocker));
            Assert.AreEqual("C00V_", Chapter00ZoneVegetationParams.k_OwnedPrefix);
            Assert.AreEqual("PIN", Chapter00ZoneVegetationParams.k_PinName);
        }

        private static Chapter00ZoneVegetationParams SmallDefault()
        {
            Chapter00ZoneVegetationParams p = Chapter00ZoneVegetationParams.CreateDefault();
            // The same disc union principle with a smaller validation surface keeps tests fast.
            p.VisibleEnvelopes = new[]
            {
                new Chapter00ViewEnvelope(new Vector2(-12f, 28f), 12f),
                new Chapter00ViewEnvelope(new Vector2(-5f, 50f), 14f),
                new Chapter00ViewEnvelope(new Vector2(1.5f, 73.5f), 14f),
                new Chapter00ViewEnvelope(new Vector2(18f, 92f), 18f),
            };
            return p;
        }

        private static UniformMetrics MetricsFor(
            Chapter00ZoneVegetationParams p,
            float height,
            Vector2 footprint)
        {
            UniformMetrics metrics = new UniformMetrics();
            for (int i = 0; i < p.Layers.Length; i++)
            {
                foreach (string key in p.Layers[i].PrefabKeys)
                {
                    metrics.Add(key, new Chapter00PrefabMetrics(height, footprint));
                }
            }
            return metrics;
        }

        private static Chapter00VegetationLayerSpec MatchingLayer(
            Chapter00ZoneVegetationParams p,
            Chapter00VegetationPlacement placement)
        {
            for (int i = 0; i < p.Layers.Length; i++)
            {
                Chapter00VegetationLayerSpec layer = p.Layers[i];
                if (layer.Zone != placement.Zone || layer.Role != placement.Role) continue;
                foreach (string key in layer.PrefabKeys) if (key == placement.PrefabKey) return layer;
            }
            Assert.Fail("No matching layer for " + placement.PrefabKey);
            return null;
        }

        private static Chapter00VegetationLayerSpec FindLayer(
            Chapter00ZoneVegetationParams p,
            Chapter00VegetationZone zone,
            Chapter00VegetationRole role,
            int occurrence)
        {
            for (int i = 0; i < p.Layers.Length; i++)
            {
                if (p.Layers[i].Zone != zone || p.Layers[i].Role != role) continue;
                if (occurrence-- == 0) return p.Layers[i];
            }
            Assert.Fail("Layer not found: " + zone + "/" + role);
            return null;
        }

        private sealed class UniformMetrics : Chapter00ZoneVegetationLayout.IPrefabMetrics
        {
            private readonly Dictionary<string, Chapter00PrefabMetrics> m_values =
                new Dictionary<string, Chapter00PrefabMetrics>();
            public void Add(string key, Chapter00PrefabMetrics value) { m_values[key] = value; }
            public bool TryGet(string key, out Chapter00PrefabMetrics metrics)
            {
                return m_values.TryGetValue(key, out metrics);
            }
        }
    }
}
