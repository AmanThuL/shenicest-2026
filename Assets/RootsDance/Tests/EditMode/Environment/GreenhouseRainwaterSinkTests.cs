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

            // The water runs out of the faucet, so the top of the stream sits inside the spout.
            Transform faucet = FindDescendant(sink, k_FaucetName);
            Assert.That(faucet, Is.Not.Null);
            Bounds faucetBounds = faucet.GetComponent<Renderer>().bounds;
            Bounds streamBounds = stream.GetComponent<Renderer>().bounds;
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
