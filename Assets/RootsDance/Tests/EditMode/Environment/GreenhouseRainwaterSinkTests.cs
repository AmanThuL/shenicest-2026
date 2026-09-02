using NUnit.Framework;
using RootsDance.App;
using RootsDance.Editor.Environment;
using RootsDance.Environment;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    public class GreenhouseRainwaterSinkTests
    {
        private const string k_FaucetName = "counter_counter_sink_faucet.001";

        [Test]
        public void RainwaterSink_AuthoredScene_ContainsCollectionSequence()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Single);
            Transform props = FindRoot(scene, "_Props");
            Transform root = props.Find(GreenhouseRainwaterSinkBuilder.k_RootName);

            Assert.That(root, Is.Not.Null);
            Transform sink = root.Find(GreenhouseRainwaterSinkBuilder.k_SinkName);
            Assert.That(sink, Is.Not.Null);

            Transform stream = root.Find(GreenhouseRainwaterSinkBuilder.k_StreamName);
            Assert.That(stream, Is.Not.Null);
            Assert.That(stream.GetComponent<WaterFlow>(), Is.Not.Null);
            Assert.That(Vector3.Dot(stream.up, Vector3.up), Is.GreaterThan(0.9999f));

            // The sink is a stopped one. The stream stays authored and switched off so it can be
            // turned back on with a checkbox, which is why every check below reads its geometry off
            // the mesh rather than off a Renderer an inactive object does not report bounds for.
            Assert.That(stream.gameObject.activeSelf, Is.False);

            // The water runs out of the faucet, so the top of the stream sits inside the spout.
            Transform faucet = FindDescendant(sink, k_FaucetName);
            Assert.That(faucet, Is.Not.Null);
            Bounds faucetBounds = faucet.GetComponent<Renderer>().bounds;
            Bounds streamBounds = MeshWorldBounds(stream);
            Assert.That(streamBounds.max.y, Is.GreaterThan(faucetBounds.min.y));
            Assert.That(streamBounds.max.y, Is.LessThan(faucetBounds.max.y));
            Assert.That(faucetBounds.Contains(new Vector3(
                streamBounds.center.x,
                streamBounds.max.y,
                streamBounds.center.z)), Is.True);

            Transform basin = root.Find(GreenhouseRainwaterSinkBuilder.k_BasinVolumeName);
            Assert.That(basin, Is.Not.Null);
            Bounds basinBounds = basin.GetComponent<BoxCollider>().bounds;
            Assert.That(basinBounds.Contains(new Vector3(
                streamBounds.min.x,
                basinBounds.center.y,
                streamBounds.min.z)), Is.True);
            Assert.That(basinBounds.Contains(new Vector3(
                streamBounds.max.x,
                basinBounds.center.y,
                streamBounds.max.z)), Is.True);

            Transform storedWater = root.Find(GreenhouseRainwaterSinkBuilder.k_StoredWaterName);
            Assert.That(storedWater, Is.Not.Null);
            Assert.That(storedWater.GetComponent<Renderer>().sharedMaterial, Is.Not.Null);

            // The basin is rectangular, so the pool is a box rather than a disc.
            Assert.That(storedWater.GetComponent<MeshFilter>().sharedMesh.name, Is.EqualTo("Cube"));

            Bounds waterBounds = storedWater.GetComponent<Renderer>().bounds;
            Assert.That(basinBounds.Contains(waterBounds.min), Is.True);
            Assert.That(basinBounds.Contains(waterBounds.max), Is.True);
            Assert.That(streamBounds.min.y, Is.LessThanOrEqualTo(waterBounds.max.y + 0.05f));

            // Dead leaves are what make the basin read as stopped rather than merely switched off,
            // so they are part of the authored state: on the water, inside the basin, all of them.
            Transform leaves = root.Find(GreenhouseRainwaterSinkBuilder.k_FallenLeavesName);
            Assert.That(leaves, Is.Not.Null);
            Assert.That(leaves.childCount, Is.GreaterThan(0));

            for (int i = 0; i < leaves.childCount; i++)
            {
                Bounds leafBounds = leaves.GetChild(i).GetComponent<Renderer>().bounds;
                Assert.That(basinBounds.Contains(
                    new Vector3(leafBounds.center.x, basinBounds.center.y, leafBounds.center.z)),
                    Is.True);
                Assert.That(leafBounds.center.y, Is.GreaterThan(waterBounds.max.y - 0.02f));
                Assert.That(leafBounds.center.y, Is.LessThan(waterBounds.max.y + 0.05f));
            }
        }

        /// <summary>
        /// World-space bounds taken from the mesh, which an inactive object still answers for.
        /// </summary>
        private static Bounds MeshWorldBounds(Transform target)
        {
            Bounds local = target.GetComponent<MeshFilter>().sharedMesh.bounds;
            Bounds world = new Bounds(target.TransformPoint(local.center), Vector3.zero);

            for (int i = 0; i < 8; i++)
            {
                Vector3 corner = new Vector3(
                    (i & 1) == 0 ? local.min.x : local.max.x,
                    (i & 2) == 0 ? local.min.y : local.max.y,
                    (i & 4) == 0 ? local.min.z : local.max.z);
                world.Encapsulate(target.TransformPoint(corner));
            }

            return world;
        }

        private static Transform FindDescendant(Transform parent, string name)
        {
            Transform[] all = parent.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < all.Length; i++)
            {
                if (all[i].name == name)
                {
                    return all[i];
                }
            }

            return null;
        }

        private static Transform FindRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            return null;
        }
    }
}
