using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the lab terrace divider: the broken fence line that separates the gabled hall from the
    /// octagonal hub stays on its authored polyline, keeps out of both buildings, and leaves the trail and
    /// its review markers a clear approach to the forecourt.
    /// </summary>
    public sealed class OpeningPropsLabDividerTests
    {
        private const string k_SouthRun = "Lab_Divider_South";
        private const string k_NorthRun = "Lab_Divider_North";

        /// <summary>Metres an instance may stray from its run's polyline (corner-cutting gap fillers).</summary>
        private const float k_PolylineTolerance = 1.5f;

        /// <summary>NE of the annex's NE wall (x + z = 110.3), with clearance.</summary>
        private const float k_AnnexOutside = 111.5f;

        /// <summary>SE of the glass wing's south side (x - z = -139), with clearance.</summary>
        private const float k_WingSouthOutside = -137.5f;

        /// <summary>South of the octagonal hub, so the divider never runs into its footprint.</summary>
        private const float k_HubSouthLimit = 126f;

        /// <summary>NW of the glass wing's NW side (x - z = -149), with clearance.</summary>
        private const float k_WingNorthOutside = -153f;

        /// <summary>How far down the terrace's NW slope the north stub is allowed to die.</summary>
        private const float k_NorthSlopeLimit = -170f;

        /// <summary>Metres the south run keeps clear of the player trail.</summary>
        private const float k_TrailClearance = 6f;

        /// <summary>Metres the south run keeps clear of the gate and sign review markers.</summary>
        private const float k_MarkerClearance = 3f;

        /// <summary>Metres a north-run piece keeps clear of the hall's north corner.</summary>
        private const float k_HallCornerClearance = 2f;

        /// <summary>The trail as it climbs onto the terrace from the south.</summary>
        private static readonly Vector2[] k_Trail =
        {
            new Vector2(2f, 75f), new Vector2(9f, 87f), new Vector2(24f, 106f),
        };

        private static readonly Vector2 k_GateMarker = new Vector2(24f, 106f);
        private static readonly Vector2 k_SignMarker = new Vector2(17f, 102f);
        private static readonly Vector2 k_HallNorthCorner = new Vector2(-29.5f, 125.7f);

        private static List<PropInstance> InstancesOf(string runName)
        {
            List<PropInstance> result = new List<PropInstance>();

            foreach (PropInstance instance in OpeningPropsLayout.Build(OpeningPropsParams.CreateDefault()))
            {
                if (instance.Group != null && instance.Group.StartsWith(runName))
                {
                    result.Add(instance);
                }
            }

            return result;
        }

        private static Vector2[] NodesOf(string runName)
        {
            foreach (FenceRun run in OpeningPropsParams.CreateDefault().Fences)
            {
                if (run.Name == runName)
                {
                    return run.Nodes;
                }
            }

            Assert.Fail($"no fence run named {runName}");
            return null;
        }

        private static int CountPosts(List<PropInstance> instances)
        {
            int posts = 0;

            foreach (PropInstance instance in instances)
            {
                if (instance.Prefab != null && instance.Prefab.StartsWith("chainlink_post"))
                {
                    posts++;
                }
            }

            return posts;
        }

        [Test]
        public void LabDivider_BothRuns_ProduceInstances()
        {
            Assert.Greater(CountPosts(InstancesOf(k_SouthRun)), 0, "the south divider produced no posts");
            Assert.Greater(CountPosts(InstancesOf(k_NorthRun)), 0, "the north divider produced no posts");
        }

        [Test]
        public void LabDivider_SouthRun_HasAtLeastOneGapFiller()
        {
            bool found = false;

            foreach (PropInstance instance in InstancesOf(k_SouthRun))
            {
                if (instance.Prefab != null && !instance.Prefab.StartsWith("chainlink_"))
                {
                    found = true;
                    break;
                }
            }

            Assert.IsTrue(found, "the south divider has no gap filler, so its breaks read as empty");
        }

        [Test]
        public void LabDivider_Instances_StayOnTheirPolyline()
        {
            AssertOnPolyline(k_SouthRun);
            AssertOnPolyline(k_NorthRun);
        }

        private static void AssertOnPolyline(string runName)
        {
            Vector2[] nodes = NodesOf(runName);

            foreach (PropInstance instance in InstancesOf(runName))
            {
                Assert.LessOrEqual(OpeningPropsLayout.DistanceToRoute(nodes, instance.Position),
                    k_PolylineTolerance,
                    $"{instance.Prefab} from {instance.Group} at {instance.Position} left the {runName} line");
            }
        }

        [Test]
        public void LabDivider_SouthRun_StaysClearOfBuildingsAndTrail()
        {
            foreach (PropInstance instance in InstancesOf(k_SouthRun))
            {
                Vector2 p = instance.Position;
                string where = $"{instance.Prefab} from {instance.Group} at {p}";

                Assert.GreaterOrEqual(p.x + p.y, k_AnnexOutside, $"{where} sits inside the annex");
                Assert.GreaterOrEqual(p.x - p.y, k_WingSouthOutside, $"{where} sits inside the glass wing");
                Assert.LessOrEqual(p.y, k_HubSouthLimit, $"{where} sits inside the hub");

                Assert.GreaterOrEqual(OpeningPropsLayout.DistanceToRoute(k_Trail, p), k_TrailClearance,
                    $"{where} stands in the trail");
                Assert.GreaterOrEqual(Vector2.Distance(p, k_GateMarker), k_MarkerClearance,
                    $"{where} crowds the gate marker");
                Assert.GreaterOrEqual(Vector2.Distance(p, k_SignMarker), k_MarkerClearance,
                    $"{where} crowds the sign marker");
            }
        }

        [Test]
        public void LabDivider_NorthRun_StaysBetweenHallAndWing()
        {
            foreach (PropInstance instance in InstancesOf(k_NorthRun))
            {
                Vector2 p = instance.Position;
                string where = $"{instance.Prefab} from {instance.Group} at {p}";

                Assert.LessOrEqual(p.x - p.y, k_WingNorthOutside, $"{where} sits inside the glass wing");
                Assert.GreaterOrEqual(p.x - p.y, k_NorthSlopeLimit, $"{where} runs off down the NW slope");
                Assert.GreaterOrEqual(Vector2.Distance(p, k_HallNorthCorner), k_HallCornerClearance,
                    $"{where} crowds the hall's north corner");
            }
        }
    }
}
