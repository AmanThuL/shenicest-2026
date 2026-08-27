using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Environment;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the §S0 wake enclosure: the lowland is closed on every side but one, the single opening
    /// points at the first route bend, and nothing with a collider sits in the exit corridor.
    /// </summary>
    public sealed class OpeningPropsWakeTests
    {
        private static readonly Vector2 k_Wake = new Vector2(0f, -10f);

        // Bearings are clockwise from +Z, matching ScatterPatch arcs. The route's second node (-7, 4)
        // sits at -26.6°, so the opening wedge is centred on it.
        private const float k_OpeningMin = -45f;
        private const float k_OpeningMax = -8f;
        private const float k_EnclosureInner = 8f;
        private const float k_EnclosureOuter = 16f;

        /// <summary>The boulders big enough to stop a walk; rock_moss_07..13 are ankle-high gravel.</summary>
        private static readonly HashSet<string> k_Boulders = new HashSet<string>
        {
            "rock_moss_01", "rock_moss_02", "rock_moss_03", "rock_moss_04", "rock_moss_05", "rock_moss_06",
        };

        private static bool IsBlocker(string prefab)
        {
            return prefab.StartsWith("chainlink_") || prefab == "concrete_road_barrier"
                || k_Boulders.Contains(prefab) || prefab.StartsWith("root_cluster_")
                || prefab == "dead_tree_trunk_02" || prefab.StartsWith("tree0");
        }

        private static float Bearing(Vector2 offset)
        {
            return Mathf.Atan2(offset.x, offset.y) * Mathf.Rad2Deg;
        }

        private static List<PropInstance> BlockersNearWake(float maxDistance)
        {
            List<PropInstance> result = new List<PropInstance>();

            foreach (PropInstance instance in OpeningPropsLayout.Build(OpeningPropsParams.CreateDefault()))
            {
                if (IsBlocker(instance.Prefab) && Vector2.Distance(instance.Position, k_Wake) <= maxDistance)
                {
                    result.Add(instance);
                }
            }

            return result;
        }

        [Test]
        public void WakeEnclosure_OpeningWedge_HasNoBlockers()
        {
            foreach (PropInstance instance in BlockersNearWake(13.5f))
            {
                float bearing = Bearing(instance.Position - k_Wake);

                Assert.IsFalse(bearing >= k_OpeningMin && bearing <= k_OpeningMax,
                    $"{instance.Prefab} from {instance.Group} at {instance.Position} blocks the opening");
            }
        }

        [Test]
        public void WakeEnclosure_EveryClosedBearingBand_HasABlocker()
        {
            List<PropInstance> blockers = BlockersNearWake(k_EnclosureOuter);

            for (float bandStart = k_OpeningMax; bandStart < 360f + k_OpeningMin; bandStart += 20f)
            {
                bool found = false;

                foreach (PropInstance instance in blockers)
                {
                    Vector2 offset = instance.Position - k_Wake;
                    float bearing = Mathf.Repeat(Bearing(offset) - bandStart, 360f);

                    if (bearing <= 20f && offset.magnitude >= k_EnclosureInner)
                    {
                        found = true;
                        break;
                    }
                }

                Assert.IsTrue(found, $"no blocker closes the wake between bearings {bandStart} and {bandStart + 20f}");
            }
        }

        [Test]
        public void WakeExit_RouteCorridor_HasNoBlockers()
        {
            Vector2[] route = OpeningPropsParams.CreateDefault().Route;

            // §S0-S1 only: past the (-7, 4) ridge node §S2's trunks deliberately crowd the route.
            foreach (PropInstance instance in BlockersNearWake(15f))
            {
                // The forked foreground trunk hugs the spawn on purpose; the corridor starts past it.
                if (instance.Position.y < -7f)
                {
                    continue;
                }

                Assert.GreaterOrEqual(OpeningPropsLayout.DistanceToRoute(route, instance.Position), 1.6f,
                    $"{instance.Prefab} from {instance.Group} at {instance.Position} stands in the exit corridor");
            }
        }
    }
}
