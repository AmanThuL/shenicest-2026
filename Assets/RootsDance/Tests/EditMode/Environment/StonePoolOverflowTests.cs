using NUnit.Framework;
using RootsDance.App;
using RootsDance.Editor.Environment;
using RootsDance.Environment;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Tests.EditMode.Environment
{
    public class StonePoolOverflowTests
    {
        private const string k_WaterRootPath = "Statue/StatueWater";

        [Test]
        public void SetFillLevel_BelowSpillThreshold_LeavesRunOffOff()
        {
            RockPoolOverflow pool = BuildPool(out Transform surface, out GameObject spillway);

            try
            {
                pool.SetFillLevel(0.5f);

                Assert.That(pool.FillLevel, Is.EqualTo(0.5f).Within(0.0001f));
                Assert.That(pool.IsSpilling, Is.False);
                Assert.That(spillway.activeSelf, Is.False);
                Assert.That(surface.localPosition.y, Is.EqualTo(0.5f).Within(0.0001f));
                Assert.That(surface.localScale.x, Is.EqualTo(0.5f).Within(0.0001f));
            }
            finally
            {
                Object.DestroyImmediate(pool.gameObject);
            }
        }

        [Test]
        public void SetFillLevel_AtSpillThreshold_TurnsRunOffOn()
        {
            RockPoolOverflow pool = BuildPool(out Transform surface, out GameObject spillway);

            try
            {
                pool.SetFillLevel(1f);

                Assert.That(pool.IsSpilling, Is.True);
                Assert.That(spillway.activeSelf, Is.True);
                Assert.That(surface.localPosition.y, Is.EqualTo(1f).Within(0.0001f));

                // Coming back down shuts the run-off again: being full is a state the level is in,
                // not an event that happened, which is what lets a checkpoint restore either one.
                pool.SetFillLevel(0.2f);

                Assert.That(pool.IsSpilling, Is.False);
                Assert.That(spillway.activeSelf, Is.False);
            }
            finally
            {
                Object.DestroyImmediate(pool.gameObject);
            }
        }

        [Test]
        public void SetFillLevel_Dry_HidesTheWater()
        {
            RockPoolOverflow pool = BuildPool(out Transform surface, out GameObject _);

            try
            {
                pool.SetFillLevel(0f);

                Assert.That(surface.GetComponent<Renderer>().enabled, Is.False);

                pool.SetFillLevel(0.1f);

                Assert.That(surface.GetComponent<Renderer>().enabled, Is.True);
            }
            finally
            {
                Object.DestroyImmediate(pool.gameObject);
            }
        }

        [Test]
        public void StonePool_AuthoredScene_SpillsOffTheStoneIntoTheSoil()
        {
            Scene scene = EditorSceneManager.OpenScene(
                ScenePaths.k_GreenhouseInteriorEnvironment,
                OpenSceneMode.Single);
            Transform water = FindRoot(scene, "_Props").Find(k_WaterRootPath);
            Assert.That(water, Is.Not.Null, "The greenhouse scene lost the statue's water rig.");

            Transform root = water.Find(StonePoolOverflowBuilder.k_RootName);
            Assert.That(root, Is.Not.Null);

            // The rig undoes the statue node's import scale, so every size on it is in metres.
            Assert.That(root.lossyScale.x, Is.EqualTo(1f).Within(0.001f));

            RockPoolOverflow overflow = root.GetComponent<RockPoolOverflow>();
            Assert.That(overflow, Is.Not.Null);

            Transform surface = root.Find(StonePoolOverflowBuilder.k_SurfaceName);
            Assert.That(surface, Is.Not.Null);
            Assert.That(surface.GetComponent<WaterFlow>(), Is.Not.Null);

            Transform spillways = root.Find(StonePoolOverflowBuilder.k_SpillwaysName);
            Assert.That(spillways, Is.Not.Null);
            Assert.That(spillways.gameObject.activeSelf, Is.False, "The run-off starts dry.");

            // Full is where the run-off matters, and the level survives the check being read off a
            // scene rather than a fresh object.
            overflow.SetFillLevel(1f);
            Bounds pool = MeshWorldBounds(surface);
            int ribbons = 0;

            foreach (Transform child in spillways)
            {
                if (child.GetComponent<MeshFilter>() == null)
                {
                    continue;
                }

                ribbons++;
                Bounds ribbon = MeshWorldBounds(child);

                // Each ribbon leaves the rim the pool reaches and ends below the pool, which on
                // this stone is the soil it soaks into.
                Assert.That(ribbon.max.y, Is.LessThan(pool.max.y));
                Assert.That(ribbon.min.y, Is.LessThan(pool.min.y - 0.5f));
                Assert.That(ribbon.max.y, Is.GreaterThan(pool.min.y - 0.3f));
            }

            Assert.That(ribbons, Is.EqualTo(3), "The stone should shed water down three sides.");
        }

        private static RockPoolOverflow BuildPool(out Transform surface, out GameObject spillway)
        {
            GameObject root = new GameObject("StonePoolUnderTest");
            GameObject water = new GameObject("Surface");
            water.transform.SetParent(root.transform, false);
            water.AddComponent<MeshRenderer>();
            surface = water.transform;

            spillway = new GameObject("Spillway");
            spillway.transform.SetParent(root.transform, false);

            RockPoolOverflow pool = root.AddComponent<RockPoolOverflow>();
            SerializedFields(pool, surface, spillway);
            return pool;
        }

        /// <summary>
        /// Empty-to-full is set to 0 → 1 in both height and width so a level reads straight off the
        /// transform, and the tests say what the component did rather than what a lerp did.
        /// </summary>
        private static void SerializedFields(
            RockPoolOverflow pool, Transform surface, GameObject spillway)
        {
            SerializedObject serialized = new SerializedObject(pool);
            serialized.FindProperty("m_surface").objectReferenceValue = surface;
            serialized.FindProperty("m_surfaceRenderer").objectReferenceValue =
                surface.GetComponent<Renderer>();
            serialized.FindProperty("m_emptyHeight").floatValue = 0f;
            serialized.FindProperty("m_fullHeight").floatValue = 1f;
            serialized.FindProperty("m_emptyWidth").floatValue = 0f;
            serialized.FindProperty("m_fullWidth").floatValue = 1f;
            serialized.FindProperty("m_spillsAt").floatValue = 1f;
            SerializedProperty spillways = serialized.FindProperty("m_spillways");
            spillways.arraySize = 1;
            spillways.GetArrayElementAtIndex(0).objectReferenceValue = spillway;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static Bounds MeshWorldBounds(Transform target)
        {
            Mesh mesh = target.GetComponent<MeshFilter>().sharedMesh;
            Bounds local = mesh.bounds;
            Bounds world = new Bounds(target.TransformPoint(local.center), Vector3.zero);

            for (int i = 0; i < 8; i++)
            {
                Vector3 corner = local.center + Vector3.Scale(
                    local.extents,
                    new Vector3((i & 1) == 0 ? -1f : 1f, (i & 2) == 0 ? -1f : 1f, (i & 4) == 0 ? -1f : 1f));
                world.Encapsulate(target.TransformPoint(corner));
            }

            return world;
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

            Assert.Fail("The greenhouse scene has no root named " + name + ".");
            return null;
        }
    }
}
