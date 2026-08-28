using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the lab terrace divider: the broken fence line that separates the detached vault block from
    /// the joined hall + hub complex stays on its authored polyline, keeps out of every building, and leaves
    /// both the trail and the gate-to-vault approach open.
    /// </summary>
    public sealed class OpeningPropsLabDividerTests
    {
        private const string k_Run = "Lab_Divider";

        /// <summary>Metres an instance may stray from the run's polyline (corner-cutting gap fillers).</summary>
        private const float k_PolylineTolerance = 1.5f;

        /// <summary>NE of the annex's NE wall (x + z = 110.3), with clearance.</summary>
        private const float k_AnnexOutside = 111.5f;

        /// <summary>SE of the glass wings' south side (x - z = -139), with clearance.</summary>
        private const float k_WingSouthOutside = -137.5f;

        /// <summary>The octagonal hub is 12.5 m in radius; the divider keeps another 2.5 m off it.</summary>
        private const float k_HubKeepOut = 15f;

        /// <summary>West of the vault block's roof edge (x = 16.3) wherever the run is level with it.</summary>
        private const float k_BlockWestLimit = 16.5f;

        /// <summary>Z range of the vault block — from its open vault mouth to its roof's north edge (143.5).</summary>
        private const float k_BlockSouthZ = 118f;

        private const float k_BlockNorthZ = 146f;

        /// <summary>Metres the run keeps clear of the player trail and the gate-to-vault approach.</summary>
        private const float k_PathClearance = 6f;

        /// <summary>Metres the run keeps clear of the gate and sign review markers.</summary>
        private const float k_MarkerClearance = 3f;

        private static readonly Vector2 k_HubCentre = new Vector2(-2.6f, 141f);

        /// <summary>The trail as it climbs onto the terrace from the south.</summary>
        private static readonly Vector2[] k_Trail =
        {
            new Vector2(2f, 75f), new Vector2(9f, 87f), new Vector2(24f, 106f),
        };

        /// <summary>From the gate marker straight north into the vault's open arch.</summary>
        private static readonly Vector2[] k_VaultApproach =
        {
            new Vector2(24f, 106f), new Vector2(24f, 121f),
        };

        private static readonly Vector2 k_GateMarker = new Vector2(24f, 106f);
        private static readonly Vector2 k_SignMarker = new Vector2(17f, 102f);

        private static List<PropInstance> Instances()
        {
            List<PropInstance> result = new List<PropInstance>();

            foreach (PropInstance instance in OpeningPropsLayout.Build(OpeningPropsParams.CreateDefault()))
            {
                if (instance.Group != null && instance.Group.StartsWith(k_Run))
                {
                    result.Add(instance);
                }
            }

            return result;
        }

        private static Vector2[] Nodes()
        {
            foreach (FenceRun run in OpeningPropsParams.CreateDefault().Fences)
            {
                if (run.Name == k_Run)
                {
                    return run.Nodes;
                }
            }

            Assert.Fail($"no fence run named {k_Run}");
            return null;
        }

        [Test]
        public void LabDivider_Run_ProducesPostsAndAGapFiller()
        {
            int posts = 0;
            bool filler = false;

            foreach (PropInstance instance in Instances())
            {
                if (instance.Prefab == null)
                {
                    continue;
                }

                if (instance.Prefab.StartsWith("chainlink_post"))
                {
                    posts++;
                }
                else if (!instance.Prefab.StartsWith("chainlink_"))
                {
                    filler = true;
                }
            }

            Assert.Greater(posts, 0, "the divider produced no posts");
            Assert.IsTrue(filler, "the divider has no gap filler, so its breaks read as empty");
        }

        [Test]
        public void LabDivider_Instances_StayOnThePolyline()
        {
            Vector2[] nodes = Nodes();

            foreach (PropInstance instance in Instances())
            {
                Assert.LessOrEqual(OpeningPropsLayout.DistanceToRoute(nodes, instance.Position),
                    k_PolylineTolerance,
                    $"{instance.Prefab} from {instance.Group} at {instance.Position} left the divider line");
            }
        }

        [Test]
        public void LabDivider_Instances_StayOutOfEveryBuilding()
        {
            foreach (PropInstance instance in Instances())
            {
                Vector2 p = instance.Position;
                string where = $"{instance.Prefab} from {instance.Group} at {p}";

                Assert.GreaterOrEqual(p.x + p.y, k_AnnexOutside, $"{where} sits inside the annex");
                Assert.GreaterOrEqual(p.x - p.y, k_WingSouthOutside, $"{where} sits inside a glass wing");
                Assert.GreaterOrEqual(Vector2.Distance(p, k_HubCentre), k_HubKeepOut, $"{where} crowds the hub");

                if (p.y >= k_BlockSouthZ && p.y <= k_BlockNorthZ)
                {
                    Assert.LessOrEqual(p.x, k_BlockWestLimit, $"{where} sits under the vault block's roof");
                }
            }
        }

        [Test]
        public void LabDivider_Instances_LeaveTrailAndVaultApproachOpen()
        {
            foreach (PropInstance instance in Instances())
            {
                Vector2 p = instance.Position;
                string where = $"{instance.Prefab} from {instance.Group} at {p}";

                Assert.GreaterOrEqual(OpeningPropsLayout.DistanceToRoute(k_Trail, p), k_PathClearance,
                    $"{where} stands in the trail");
                Assert.GreaterOrEqual(OpeningPropsLayout.DistanceToRoute(k_VaultApproach, p), k_PathClearance,
                    $"{where} blocks the way from the gate into the vault");
                Assert.GreaterOrEqual(Vector2.Distance(p, k_GateMarker), k_MarkerClearance,
                    $"{where} crowds the gate marker");
                Assert.GreaterOrEqual(Vector2.Distance(p, k_SignMarker), k_MarkerClearance,
                    $"{where} crowds the sign marker");
            }
        }
    }
}
