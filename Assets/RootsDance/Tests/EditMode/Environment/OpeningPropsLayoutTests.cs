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
                if (checked_.Add(instance.Prefab))
                {
                    AssertPrefabExists(instance.Prefab);
                }
            }

            // Gap fillers are only placed when a gap is drawn, so check the authored keys directly too.
            foreach (FenceRun run in Params().Fences)
            {
                if (run.GapFillers == null)
                {
                    continue;
                }

                foreach (string key in run.GapFillers)
                {
                    if (checked_.Add(key))
                    {
                        AssertPrefabExists(key);
                    }
                }
            }
        }

        private static void AssertPrefabExists(string key)
        {
            string path = EnvironmentPrefabBuilder.PrefabPath(key);
            Assert.IsNotNull(path, key + " is not in EnvironmentPrefabTable");
            Assert.IsTrue(AssetDatabase.LoadAssetAtPath<GameObject>(path) != null,
                path + " is missing — run RootsDance/Environment/Build Environment Prefabs");
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
        public void BuildFence_WithFillers_PlacesExactlyOneFillerPerGap()
        {
            FenceRun run = StraightRun(30f, 0.5f, 3, new[] { "rock_moss_03", "concrete_road_barrier" }, 21);

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(run, placed);

            List<Vector2> gaps = GapSpans(placed);
            List<PropInstance> fillers = placed.FindAll(i => i.Group.EndsWith("_Filler"));

            Assert.Greater(gaps.Count, 0, "the run drew no gap");
            Assert.AreEqual(gaps.Count, fillers.Count, "one filler per gap");
            Assert.AreEqual(fillers.Count, placed.FindAll(i => i.Group == "Test_Filler").Count,
                "every filler is grouped as <run>_Filler");
        }

        [Test]
        public void BuildFence_WithFillers_FillerSitsInsideItsGap()
        {
            FenceRun run = StraightRun(30f, 0.5f, 3, new[] { "rock_moss_03", "concrete_road_barrier" }, 21);

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(run, placed);

            List<Vector2> gaps = GapSpans(placed);
            List<PropInstance> panels = placed.FindAll(i => i.Group.EndsWith("_Panel"));
            List<PropInstance> fillers = placed.FindAll(i => i.Group.EndsWith("_Filler"));

            Assert.Greater(fillers.Count, 0, "the run placed no filler");

            foreach (PropInstance filler in fillers)
            {
                float nearestPanel = float.MaxValue;

                foreach (PropInstance panel in panels)
                {
                    nearestPanel = Mathf.Min(nearestPanel, Vector2.Distance(panel.Position, filler.Position));
                }

                Assert.Greater(nearestPanel, 0.5f, "a filler stands on a panel");
                Assert.IsTrue(gaps.Exists(g => filler.Position.x > g.x && filler.Position.x < g.y),
                    $"filler at x={filler.Position.x:0.00} is not between its gap's boundary posts");
            }
        }

        [Test]
        public void BuildFence_MultiModuleGap_DropsInteriorPosts()
        {
            FenceRun run = StraightRun(30f, 1f, 3, new[] { "rock_moss_03" }, 21);

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(run, placed);

            List<PropInstance> posts = placed.FindAll(i => i.Group.EndsWith("_Post"));
            List<PropInstance> fillers = placed.FindAll(i => i.Group.EndsWith("_Filler"));

            // Every module is gapped, so every surviving post is a gap boundary: 31 posts would mean a
            // multi-module gap kept its interior posts.
            Assert.Less(posts.Count, 31, "no multi-module gap dropped a post");

            foreach (Vector2 gap in GapSpans(placed))
            {
                int inside = fillers.FindAll(f => f.Position.x > gap.x && f.Position.x < gap.y).Count;
                Assert.AreEqual(1, inside, $"span {gap.x:0.0}..{gap.y:0.0} between two posts is not one gap");
            }
        }

        [Test]
        public void BuildFence_NoFillersSingleModuleGaps_MatchesLegacyOutput()
        {
            FenceRun run = StraightRun(10f, 0.3f, 1, null, 5);

            List<PropInstance> placed = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(run, placed);

            int posts = placed.FindAll(i => i.Group.EndsWith("_Post")).Count;

            Assert.AreEqual(11, posts, "the legacy path keeps every post, gapped or not");
            Assert.AreEqual(0, placed.FindAll(i => i.Group.EndsWith("_Filler")).Count, "no filler");

            for (int i = 0; i < placed.Count; i++)
            {
                Assert.IsTrue(placed[i].Group.EndsWith(i < posts ? "_Post" : "_Panel"),
                    $"instance {i} breaks the posts-then-panels order");
            }
        }

        [Test]
        public void BuildFence_WithFillers_ConcreteBarrierGoesToBrokenBoundaryPool()
        {
            List<PropInstance> barriers = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(StraightRun(30f, 1f, 3, new[] { "concrete_road_barrier" }, 21),
                barriers);

            List<PropInstance> rocks = new List<PropInstance>();
            OpeningPropsLayout.BuildFence(StraightRun(30f, 1f, 3, new[] { "rock_moss_01" }, 21), rocks);

            List<PropInstance> barrierFillers = barriers.FindAll(i => i.Group.EndsWith("_Filler"));
            List<PropInstance> rockFillers = rocks.FindAll(i => i.Group.EndsWith("_Filler"));

            Assert.Greater(barrierFillers.Count, 0, "no filler placed");

            foreach (PropInstance filler in barrierFillers)
            {
                Assert.AreEqual(PropPool.BrokenBoundary, filler.Pool, "a barrier filler left the boundary pool");
            }

            foreach (PropInstance filler in rockFillers)
            {
                Assert.AreEqual(PropPool.RootRockClutter, filler.Pool, "a rock filler left the clutter pool");
            }
        }

        /// <summary>A 1 m-pitch run along +X from the origin, so an instance's X is its distance along it.</summary>
        private static FenceRun StraightRun(float length, float gapChance, int gapMaxModules, string[] fillers,
            int seed)
        {
            return new FenceRun
            {
                Name = "Test",
                Nodes = new[] { new Vector2(0f, 0f), new Vector2(length, 0f) },
                ModuleLength = 1f, GapChance = gapChance, PanelLean = 0f, PostLean = 0f, Seed = seed,
                GapFillers = fillers, GapMaxModules = gapMaxModules,
            };
        }

        /// <summary>
        /// The gaps of a <see cref="StraightRun"/>: every span between two consecutive posts that holds no
        /// panel, as (start x, end x). Two gaps drawn back to back keep their shared boundary post, so they
        /// count as two spans.
        /// </summary>
        private static List<Vector2> GapSpans(List<PropInstance> placed)
        {
            List<float> postX = new List<float>();
            List<float> panelX = new List<float>();

            foreach (PropInstance instance in placed)
            {
                if (instance.Group.EndsWith("_Post"))
                {
                    postX.Add(instance.Position.x);
                }
                else if (instance.Group.EndsWith("_Panel"))
                {
                    panelX.Add(instance.Position.x);
                }
            }

            postX.Sort();
            List<Vector2> spans = new List<Vector2>();

            for (int i = 0; i + 1 < postX.Count; i++)
            {
                float start = postX[i];
                float end = postX[i + 1];

                if (!panelX.Exists(x => x > start && x < end))
                {
                    spans.Add(new Vector2(start, end));
                }
            }

            return spans;
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
