using NUnit.Framework;
using RootsDance.Editor.Terrain;
using UnityEngine;
using UnityEngine.TestTools.Utils;

namespace RootsDance.Tests.EditMode.Terrain
{
    /// <summary>
    /// Covers the one pure function in the detail pipeline: the transform bake that turns a dressing
    /// prefab's mesh into a Terrain detail prototype mesh. The detail renderer ignores every transform
    /// in the prefab, so anything this bake gets wrong is drawn wrong on the terrain.
    /// </summary>
    public class TerrainDetailPrototypeFactoryTests
    {
        private static readonly Vector3EqualityComparer k_Vectors = new Vector3EqualityComparer(1e-4f);

        private Mesh m_source;
        private Mesh m_target;

        [SetUp]
        public void SetUp()
        {
            // A Z-up triangle, like the Quaternius grasses: the long axis is +Z and the face normal is
            // +Z's neighbour, so the vendor's -90 degrees X rotation is what stands it up along +Y.
            m_source = new Mesh();
            m_source.vertices = new[]
            {
                new Vector3(0f, 0f, 0f), new Vector3(1f, 0f, 0f), new Vector3(0f, 0f, 2f)
            };
            m_source.normals = new[] { Vector3.forward, Vector3.forward, Vector3.forward };
            m_source.SetTriangles(new[] { 0, 1, 2 }, 0);

            m_target = new Mesh();
        }

        [TearDown]
        public void TearDown()
        {
            Object.DestroyImmediate(m_source);
            Object.DestroyImmediate(m_target);
        }

        [Test]
        public void BakeInto_RotationAndScale_StandsVerticesUpAndScalesThem()
        {
            Matrix4x4 matrix = Matrix4x4.TRS(
                Vector3.zero, Quaternion.Euler(-90f, 0f, 0f), Vector3.one * 0.5f);

            TerrainDetailPrototypeFactory.BakeInto(m_target, m_source, matrix);

            Vector3[] vertices = m_target.vertices;
            Assert.AreEqual(3, vertices.Length);
            Assert.That(vertices[1], Is.EqualTo(new Vector3(0.5f, 0f, 0f)).Using(k_Vectors));
            Assert.That(vertices[2], Is.EqualTo(new Vector3(0f, 1f, 0f)).Using(k_Vectors));
        }

        [Test]
        public void BakeInto_TranslatingMatrix_TranslatesVertices()
        {
            Matrix4x4 matrix = Matrix4x4.Translate(new Vector3(10f, 20f, 30f));

            TerrainDetailPrototypeFactory.BakeInto(m_target, m_source, matrix);

            Assert.That(m_target.vertices[0], Is.EqualTo(new Vector3(10f, 20f, 30f)).Using(k_Vectors));
        }

        [Test]
        public void BakeInto_RotationAndScale_NormalizesRotatedNormals()
        {
            Matrix4x4 matrix = Matrix4x4.TRS(
                new Vector3(10f, 20f, 30f), Quaternion.Euler(-90f, 0f, 0f), Vector3.one * 0.5f);

            TerrainDetailPrototypeFactory.BakeInto(m_target, m_source, matrix);

            Vector3[] normals = m_target.normals;
            Assert.AreEqual(3, normals.Length);
            Assert.That(normals[0], Is.EqualTo(Vector3.up).Using(k_Vectors));
        }

        [Test]
        public void BakeInto_MirroringMatrix_SwapsTriangleWinding()
        {
            Matrix4x4 matrix = Matrix4x4.Scale(new Vector3(-1f, 1f, 1f));

            TerrainDetailPrototypeFactory.BakeInto(m_target, m_source, matrix);

            Assert.AreEqual(new[] { 0, 2, 1 }, m_target.GetTriangles(0));
        }

        [Test]
        public void BakeInto_UprightMatrix_KeepsTriangleWinding()
        {
            Matrix4x4 matrix = Matrix4x4.TRS(Vector3.zero, Quaternion.Euler(-90f, 0f, 0f), Vector3.one);

            TerrainDetailPrototypeFactory.BakeInto(m_target, m_source, matrix);

            Assert.AreEqual(new[] { 0, 1, 2 }, m_target.GetTriangles(0));
        }
    }
}
