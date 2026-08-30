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
            Assert.That(stream.position.x, Is.EqualTo(sink.position.x).Within(0.001f));
            Assert.That(stream.position.z, Is.EqualTo(sink.position.z).Within(0.001f));

            Bounds streamBounds = stream.GetComponent<Renderer>().bounds;
            Assert.That(streamBounds.max.y, Is.GreaterThan(28f));

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

            Bounds waterBounds = storedWater.GetComponent<Renderer>().bounds;
            Assert.That(basinBounds.Contains(waterBounds.min), Is.True);
            Assert.That(basinBounds.Contains(waterBounds.max), Is.True);
            Assert.That(streamBounds.min.y, Is.LessThanOrEqualTo(waterBounds.max.y + 0.05f));
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
