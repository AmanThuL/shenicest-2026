using System.Collections.Generic;
using NUnit.Framework;
using RootsDance.Editor.Terrain;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Terrain
{
    public class TerrainScatterGeneratorTests
    {
        private static ScatterRule RingARule()
        {
            return new ScatterRule
            {
                Name = "A",
                PrefabKeys = new[] { "BirchTree_Dead_1", "Willow_Dead_1" },
                RadiusMin = 112f,
                RadiusMax = 137f,
                Density = 4f,
                MinSpacing = 3f,
                MaxSlopeDegrees = 40f,
                RouteClearance = 1f,
                TerraceClearance = 2f,
            };
        }

        [Test]
        public void Generate_SameSeed_IsDeterministic()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            List<ScatterInstance> a = TerrainScatterGenerator.Generate(p, RingARule(), 7);
            List<ScatterInstance> b = TerrainScatterGenerator.Generate(p, RingARule(), 7);
            Assert.AreEqual(a.Count, b.Count);
            for (int i = 0; i < a.Count; i++)
            {
                Assert.AreEqual(a[i].Position, b[i].Position);
                Assert.AreEqual(a[i].PrefabKey, b[i].PrefabKey);
            }
        }

        [Test]
        public void Generate_DifferentSeed_ChangesPositions()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            List<ScatterInstance> a = TerrainScatterGenerator.Generate(p, RingARule(), 1);
            List<ScatterInstance> b = TerrainScatterGenerator.Generate(p, RingARule(), 2);
            Assert.Greater(a.Count, 50);
            Assert.AreNotEqual(a[0].Position, b[0].Position);
        }

        [Test]
        public void Generate_AllInstances_InsideBandAndSpaced()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            ScatterRule rule = RingARule();
            List<ScatterInstance> instances = TerrainScatterGenerator.Generate(p, rule, 3);
            for (int i = 0; i < instances.Count; i++)
            {
                float r = TerrainSplatGenerator.NoisyRadius(p, instances[i].Position.x, instances[i].Position.z);
                Assert.GreaterOrEqual(r, rule.RadiusMin, $"instance {i}");
                Assert.Less(r, rule.RadiusMax, $"instance {i}");
                Assert.IsTrue(rule.PrefabKeys[0] == instances[i].PrefabKey
                    || rule.PrefabKeys[1] == instances[i].PrefabKey);
                Assert.GreaterOrEqual(instances[i].Scale, rule.ScaleMin);
                Assert.LessOrEqual(instances[i].Scale, rule.ScaleMax);
                for (int j = i + 1; j < instances.Count; j++)
                {
                    Vector2 d = new Vector2(instances[i].Position.x - instances[j].Position.x,
                        instances[i].Position.z - instances[j].Position.z);
                    Assert.GreaterOrEqual(d.magnitude, rule.MinSpacing - 1e-3f, $"pair {i},{j}");
                }
            }
        }

        [Test]
        public void Generate_NoInstance_OnTrailOrTerraceOrFlatSpot()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            ScatterRule rule = RingARule();
            rule.RadiusMin = 0f;
            rule.RadiusMax = 1000f;
            List<ScatterInstance> instances = TerrainScatterGenerator.Generate(p, rule, 5);
            Assert.Greater(instances.Count, 200);
            for (int i = 0; i < instances.Count; i++)
            {
                Vector3 pos = instances[i].Position;
                Assert.AreEqual(0f, TerrainSplatGenerator.TrailWeight(p, pos.x, pos.z), 1e-3f, $"on trail {pos}");
                Assert.Greater(TerrainHeightmapGenerator.TerraceSignedDistance(p, pos.x, pos.z),
                    rule.TerraceClearance - 1e-3f, $"on terrace {pos}");
                for (int s = 0; s < p.FlatSpots.Length; s++)
                {
                    float d = Vector2.Distance(new Vector2(pos.x, pos.z), p.FlatSpots[s].Center);
                    Assert.Greater(d, p.FlatSpots[s].Radius + p.FlatSpots[s].Blend + rule.FlatSpotClearance - 1e-3f);
                }
            }
        }

        [Test]
        public void Generate_RespectsSlopeLimit_AndEdgeMargin()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            ScatterRule rule = RingARule();
            rule.RadiusMin = 0f;
            rule.RadiusMax = 1000f;
            rule.MaxSlopeDegrees = 12f;
            rule.EdgeMargin = 10f;
            List<ScatterInstance> instances = TerrainScatterGenerator.Generate(p, rule, 9);
            Vector3 min = p.TerrainPosition;
            Vector3 max = p.TerrainPosition + p.TerrainSize;
            for (int i = 0; i < instances.Count; i++)
            {
                Vector3 pos = instances[i].Position;
                Assert.LessOrEqual(TerrainScatterGenerator.SlopeDegrees(p, pos.x, pos.z), rule.MaxSlopeDegrees + 1e-3f);
                Assert.GreaterOrEqual(pos.x, min.x + rule.EdgeMargin);
                Assert.LessOrEqual(pos.x, max.x - rule.EdgeMargin);
                Assert.GreaterOrEqual(pos.z, min.z + rule.EdgeMargin);
                Assert.LessOrEqual(pos.z, max.z - rule.EdgeMargin);
            }
        }

        [Test]
        public void Generate_RouteThinning_ReducesCountNearRoute()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            ScatterRule dense = RingARule();
            dense.RadiusMin = 0f;
            dense.RadiusMax = 1000f;
            ScatterRule thinned = RingARule();
            thinned.RadiusMin = 0f;
            thinned.RadiusMax = 1000f;
            thinned.RouteThinningDistance = 25f;
            thinned.RouteThinningFactor = 0.1f;
            int nearDense = CountWithin(TerrainScatterGenerator.Generate(p, dense, 4), p, 12f);
            int nearThinned = CountWithin(TerrainScatterGenerator.Generate(p, thinned, 4), p, 12f);
            Assert.Less(nearThinned, nearDense / 2);
        }

        [Test]
        public void Generate_AreaRadius_RejectsCandidatesOutsideDisc()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            ScatterRule rule = RingARule();
            rule.RadiusMin = 0f;
            rule.RadiusMax = 1000f;
            rule.AreaCenter = new Vector2(0f, -10f);
            rule.AreaRadius = 25f;
            List<ScatterInstance> instances = TerrainScatterGenerator.Generate(p, rule, 3);
            Assert.Greater(instances.Count, 5);
            for (int i = 0; i < instances.Count; i++)
            {
                Vector2 xz = new Vector2(instances[i].Position.x, instances[i].Position.z);
                Assert.LessOrEqual(Vector2.Distance(xz, rule.AreaCenter), rule.AreaRadius + 1e-3f, $"instance {i}");
            }
        }

        [Test]
        public void Generate_AreaRadiusZero_MatchesUnlimitedRule()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            ScatterRule limited = RingARule();
            limited.AreaCenter = new Vector2(0f, -10f);
            limited.AreaRadius = 0f;
            List<ScatterInstance> withField = TerrainScatterGenerator.Generate(p, limited, 3);
            List<ScatterInstance> unlimited = TerrainScatterGenerator.Generate(p, RingARule(), 3);
            Assert.AreEqual(unlimited.Count, withField.Count);
            for (int i = 0; i < unlimited.Count; i++)
            {
                Assert.AreEqual(unlimited[i].Position, withField[i].Position, $"instance {i}");
                Assert.AreEqual(unlimited[i].PrefabKey, withField[i].PrefabKey, $"instance {i}");
            }
        }

        [Test]
        public void GroundNormal_OnFlatTerrace_IsUp()
        {
            TerrainGreyboxParams p = TerrainGreyboxParams.CreateDefault();
            Vector3 n = TerrainScatterGenerator.GroundNormal(p, 0f, 112f);
            Assert.Greater(n.y, 0.999f);
        }

        private static int CountWithin(List<ScatterInstance> instances, TerrainGreyboxParams p, float metresOfRoute)
        {
            int count = 0;
            for (int i = 0; i < instances.Count; i++)
            {
                Vector2 point = new Vector2(instances[i].Position.x, instances[i].Position.z);
                float h;
                if (TerrainHeightmapGenerator.DistanceToPolyline(p.Paths[0].Nodes, point, out h) < metresOfRoute)
                {
                    count++;
                }
            }

            return count;
        }
    }
}
