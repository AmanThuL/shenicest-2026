using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the pure half of the opening props pass: the layout has to be deterministic, honour its own
    /// spacing and clearance contracts, and only name prefabs that actually exist.
    /// </summary>
    public sealed class OpeningPropsLayoutTests
    {
        private static OpeningPropsParams Params()
        {
            return OpeningPropsParams.CreateDefault();
        }

        [Test]
        public void Build_SameParams_ProducesTheSameList()
        {
            List<PropInstance> first = OpeningPropsLayout.Build(Params());
            List<PropInstance> second = OpeningPropsLayout.Build(Params());

            Assert.AreEqual(first.Count, second.Count, "instance count");

            for (int i = 0; i < first.Count; i++)
            {
                Assert.AreEqual(first[i].Prefab, second[i].Prefab, $"prefab at {i}");
                Assert.AreEqual(first[i].Position, second[i].Position, $"position at {i}");
                Assert.AreEqual(first[i].Yaw, second[i].Yaw, $"yaw at {i}");
            }
        }

        [Test]
        public void Build_UsesEveryPalettePool()
        {
            HashSet<PropPool> used = new HashSet<PropPool>();

            foreach (PropInstance instance in OpeningPropsLayout.Build(Params()))
            {
                used.Add(instance.Pool);
            }

            foreach (PropPool pool in System.Enum.GetValues(typeof(PropPool)))
            {
                Assert.IsTrue(used.Contains(pool), OpeningPropsParams.PaletteName(pool) + " places nothing");
            }
        }

        [Test]
        public void Build_EveryPrefabKey_ResolvesToAnExistingPrefab()
        {
            HashSet<string> checked_ = new HashSet<string>();

            foreach (PropInstance instance in OpeningPropsLayout.Build(Params()))
            {
                if (!checked_.Add(instance.Prefab))
                {
                    continue;
                }

                string path = EnvironmentPrefabBuilder.PrefabPath(instance.Prefab);
                Assert.IsNotNull(path, instance.Prefab + " is not in EnvironmentPrefabTable");
                Assert.IsTrue(AssetDatabase.LoadAssetAtPath<GameObject>(path) != null,
                    path + " is missing — run RootsDance/Environment/Build Environment Prefabs");
            }
        }

        [Test]
        public void BuildPatch_KeepsInstancesApartByMinSpacing()
        {
            ScatterPatch patch = new ScatterPatch
            {
                Name = "Test", Pool = PropPool.RootRockClutter, Prefabs = new[] { "rock_moss_08" },
                Center = Vector2.zero, InnerRadius = 0f, OuterRadius = 20f, Count = 40,
                MinSpacing = 2.5f, Seed = 7,
            };

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildPatch(patch, new[] { new Vector2(0f, -100f) }, placed);

            Assert.Greater(placed.Count, 0, "the patch placed nothing");

            for (int i = 0; i < placed.Count; i++)
            {
                for (int j = i + 1; j < placed.Count; j++)
                {
                    float distance = Vector2.Distance(placed[i].Position, placed[j].Position);
                    Assert.GreaterOrEqual(distance, patch.MinSpacing - 0.001f,
                        $"instances {i} and {j} are {distance:0.00} m apart");
                }
            }
        }

        [Test]
        public void BuildPatch_KeepsTheRouteCorridorClear()
        {
            Vector2[] route = { new Vector2(0f, -10f), new Vector2(-7f, 4f) };
            ScatterPatch patch = new ScatterPatch
            {
                Name = "Test", Pool = PropPool.DeadTreeSparse, Prefabs = new[] { "tree01_winter" },
                Center = new Vector2(-3f, -3f), InnerRadius = 0f, OuterRadius = 16f, Count = 40,
                MinSpacing = 1f, RouteClearance = 4f, Seed = 11,
            };

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildPatch(patch, route, placed);

            Assert.Greater(placed.Count, 0, "the patch placed nothing");

            foreach (PropInstance instance in placed)
            {
                Assert.GreaterOrEqual(OpeningPropsLayout.DistanceToRoute(route, instance.Position),
                    patch.RouteClearance - 0.001f, "an instance stands inside the route corridor");
            }
        }

        [Test]
        public void BuildPatch_WithARejectingFilter_PlacesNothing()
        {
            ScatterPatch patch = new ScatterPatch
            {
                Name = "Test", Pool = PropPool.TransitionGrowth, Prefabs = new[] { "M3D_fern-1" },
                Center = Vector2.zero, OuterRadius = 10f, Count = 20, MinSpacing = 0.5f, Seed = 3,
            };

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildPatch(patch, new Vector2[0], placed, new RejectAll());

            Assert.AreEqual(0, placed.Count);
        }

        [Test]
        public void BuildFence_PlacesOnePostPerModuleAndPanelsBetweenThem()
        {
            FenceRun run = new FenceRun
            {
                Name = "Test",
                Nodes = new[] { new Vector2(0f, 0f), new Vector2(10f, 0f) },
                ModuleLength = 1f, GapChance = 0f, PanelLean = 0f, PostLean = 0f, Seed = 5,
            };

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(run, placed);

            int posts = placed.FindAll(i => i.Group.EndsWith("_Post")).Count;
            int panels = placed.FindAll(i => i.Group.EndsWith("_Panel")).Count;

            Assert.AreEqual(11, posts, "a 10 m run on a 1 m pitch has 11 posts");
            Assert.AreEqual(posts - 1, panels, "no gaps means one panel per module");
        }

        [Test]
        public void BuildFence_YawsPanelsAlongTheRun()
        {
            FenceRun run = new FenceRun
            {
                Name = "Test",
                Nodes = new[] { new Vector2(0f, 0f), new Vector2(0f, 6f) },
                ModuleLength = 1f, GapChance = 0f, PanelLean = 0f, PostLean = 0f, Seed = 5,
            };

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(run, placed);

            // The panel mesh runs along local +X, so a run heading +Z needs a yaw of -90.
            foreach (PropInstance instance in placed.FindAll(i => i.Group.EndsWith("_Panel")))
            {
                Assert.AreEqual(-90f, instance.Yaw, 0.01f);
            }
        }

        [Test]
        public void YawAlongX_TurnsTheLocalXAxisOntoTheDirection()
        {
            Vector2 direction = new Vector2(0.6f, -0.8f);
            float yaw = OpeningPropsLayout.YawAlongX(direction);
            Vector3 rotated = Quaternion.Euler(0f, yaw, 0f) * Vector3.right;

            Assert.AreEqual(direction.x, rotated.x, 0.001f);
            Assert.AreEqual(direction.y, rotated.z, 0.001f);
        }

        [Test]
        public void InArc_WrapsThroughZero()
        {
            Assert.IsTrue(OpeningPropsLayout.InArc(350f, 340f, 20f));
            Assert.IsTrue(OpeningPropsLayout.InArc(10f, 340f, 20f));
            Assert.IsFalse(OpeningPropsLayout.InArc(180f, 340f, 20f));
        }

        [Test]
        public void AnomalousBand_OnlyPlacesWhereTheGrassBandLayerIsPainted()
        {
            OpeningPropsParams p = Params();
            ScatterPatch band = System.Array.Find(p.Patches, patch => patch.Name == "S6_AnomalousBand");

            Assert.IsNotNull(band, "the anomalous band patch is missing");
            Assert.AreEqual(OpeningPropsParams.k_GrassBandLayer, band.TerrainLayer,
                "the band must follow the painted TL_GrassBand, not a circle");
            Assert.Greater(band.MinLayerWeight, 0f);
        }

        [Test]
        public void WakeLowland_HasNoLivingVegetation()
        {
            // §10: "起点没有可读的活体植被" — nothing from the recovery pools may stand in the wake bowl.
            foreach (PropInstance instance in OpeningPropsLayout.Build(Params()))
            {
                if (instance.Pool != PropPool.TransitionGrowth && instance.Pool != PropPool.DryLowGrowth)
                {
                    continue;
                }

                Assert.Greater(Vector2.Distance(instance.Position, new Vector2(0f, -10f)), 12f,
                    $"{instance.Prefab} from {instance.Group} grows in the wake lowland");
            }
        }

        private sealed class RejectAll : OpeningPropsLayout.IGroundFilter
        {
            public bool Accepts(Vector2 position, float maxSlopeDegrees, int layer, float minLayerWeight)
            {
                return false;
            }
        }
    }
}
