using System.Collections.Generic;
using NUnit.Framework;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEngine;

namespace RootsDance.Tests.EditMode.Environment
{
    /// <summary>
    /// Guards the contract between <c>Tools/pipeline/build_bloom_flowers.py</c> and
    /// <c>RootsDance/Environment/StatueFlowers</c>.
    /// <para>
    /// Every failure this covers is silent in the Editor. A dropped UV channel, a colour channel
    /// imported as sRGB, an export profile that welds the poses away — none of them raise a shader
    /// error. They render three thousand flowers permanently open, which is exactly what the mesh
    /// looks like when it is working and the growth is 1.
    /// </para>
    /// </summary>
    public class BloomFlowersMeshTests
    {
        private const string k_Fbx =
            "Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/BloomFlowers.fbx";

        private const string k_Prefab =
            "Assets/RootsDance/Prefabs/Environment/StatueBloom.prefab";

        /// <summary>Metres. A pose delta longer than this is a decoding or unit error.</summary>
        private const float k_MaxDelta = 2f;

        private static Mesh LoadMesh()
        {
            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(k_Fbx))
            {
                if (asset is Mesh mesh)
                {
                    return mesh;
                }
            }

            return null;
        }

        private static List<Vector2> Channel(Mesh mesh, int index)
        {
            List<Vector2> uvs = new List<Vector2>();
            mesh.GetUVs(index, uvs);
            return uvs;
        }

        [Test]
        public void Field_IsImported()
        {
            Mesh mesh = LoadMesh();
            Assert.IsNotNull(mesh, $"{k_Fbx} carries no mesh.");

            // The point of the field is coverage. A rebuild that quietly halves the count is the
            // complaint this whole mesh exists to answer.
            Assert.Greater(mesh.vertexCount, 60000, "the field is far thinner than it was built.");
        }

        /// <summary>
        /// UV0 is the flower's own axis, octahedral-encoded; _Sink pushes along it. A field
        /// exported before that contract still imports and still opens — it just sinks in a
        /// random direction, which is the silent kind of wrong this file exists for.
        /// </summary>
        [Test]
        public void Field_CarriesEachFlowersAxis()
        {
            Mesh mesh = LoadMesh();
            List<Vector2> uv0 = Channel(mesh, 0);
            Assert.AreEqual(mesh.vertexCount, uv0.Count, "UV0 did not survive the import.");

            int leaningUp = 0;
            int inRange = 0;

            for (int i = 0; i < uv0.Count; i++)
            {
                Vector2 e = uv0[i];

                if (Mathf.Abs(e.x) <= 1.0001f && Mathf.Abs(e.y) <= 1.0001f)
                {
                    inRange++;
                }

                Vector3 v = new Vector3(e.x, e.y, 1f - Mathf.Abs(e.x) - Mathf.Abs(e.y));
                float t = Mathf.Clamp01(-v.z);
                v.x += v.x >= 0f ? -t : t;
                v.y += v.y >= 0f ? -t : t;

                // Mesh space, not world: the importer keeps Blender's X and Y and negates Z, and
                // the axis conversion sits on the model root as a rotation — so "up the statue"
                // is -Z here, the same frame the pose deltas are written in.
                if (v.normalized.z < 0f)
                {
                    leaningUp++;
                }
            }

            Assert.AreEqual(uv0.Count, inRange, "UV0 holds petal coordinates, not an encoded axis.");

            // Scattered with --upright 0.55 on anchors facing no lower than -0.2 from up: nearly
            // every flower leans up. Petal coordinates in [0,1] would decode to a fixed quadrant.
            Assert.Greater(leaningUp, uv0.Count * 0.9f,
                "most flowers decode to an axis pointing down; UV0 is not the aim.");
        }

        [Test]
        public void Field_CarriesBothClosedPoses()
        {
            Mesh mesh = LoadMesh();
            int n = mesh.vertexCount;

            foreach (int channel in new[] { 1, 2, 3 })
            {
                Assert.AreEqual(n, Channel(mesh, channel).Count,
                    $"UV{channel} did not survive the import; the flowers cannot close.");
            }
        }

        [Test]
        public void Field_PoseDeltasAreBoundedAndRealMovement()
        {
            Mesh mesh = LoadMesh();
            List<Vector2> uv1 = Channel(mesh, 1);
            List<Vector2> uv2 = Channel(mesh, 2);
            List<Vector2> uv3 = Channel(mesh, 3);

            float longest = 0f;
            int moving = 0;
            int ordered = 0;

            for (int i = 0; i < uv1.Count; i++)
            {
                Vector3 bud = new Vector3(uv1[i].x, uv1[i].y, uv2[i].x);
                Vector3 mid = new Vector3(uv2[i].y, uv3[i].x, uv3[i].y);

                Assert.IsFalse(float.IsNaN(bud.x + bud.y + bud.z + mid.x + mid.y + mid.z),
                    $"vertex {i} carries a NaN pose delta.");

                longest = Mathf.Max(longest, bud.magnitude);

                if (bud.magnitude > 0.05f)
                {
                    moving++;

                    // The half-open pose sits between the shut one and the open one, so it is
                    // always the nearer of the two. This is what catches a swapped UV channel:
                    // the values stay plausible, the flowers still move, and the arc runs
                    // backwards through a shape nothing was ever authored in.
                    if (mid.magnitude < bud.magnitude)
                    {
                        ordered++;
                    }
                }
            }

            Assert.Less(longest, k_MaxDelta, "a pose delta is longer than any flower on the "
                + "statue; the channel packing or the unit scale is wrong.");

            // A petal tip travels; the root of a stem does not. Both are expected, and a mesh
            // where nothing travels is a mesh where nothing opens.
            Assert.Greater(moving, uv1.Count / 10, "almost nothing moves between the poses.");
            Assert.Greater(ordered, Mathf.FloorToInt(moving * 0.98f),
                "the half-open pose is further from open than the shut one; UV1..UV3 are not the "
                + "channels the generator wrote.");
        }

        /// <summary>
        /// The shader compiles.
        /// <para>
        /// Worth a test because this one is handwritten against HDRP's pass includes rather than
        /// generated by Shader Graph, and a broken pass shows up as pink geometry at the end of
        /// the game rather than as anything the suite would otherwise notice.
        /// </para>
        /// </summary>
        [Test]
        public void Shader_Compiles()
        {
            Shader shader = Shader.Find("RootsDance/Environment/StatueFlowers");
            Assert.IsNotNull(shader, "RootsDance/Environment/StatueFlowers is not in the project.");

            ShaderMessage[] messages = ShaderUtil.GetShaderMessages(shader);
            System.Text.StringBuilder errors = new System.Text.StringBuilder();

            foreach (ShaderMessage m in messages)
            {
                if (m.severity == UnityEditor.Rendering.ShaderCompilerMessageSeverity.Error)
                {
                    errors.AppendLine($"{m.file}({m.line}): {m.message}");
                }
            }

            Assert.IsFalse(ShaderUtil.ShaderHasError(shader), errors.ToString());
            Assert.AreEqual(0, errors.Length, errors.ToString());
        }

        /// <summary>
        /// The two meshes stand in the same place.
        /// <para>
        /// Both FBXes carry the importer's axis conversion on their own root, and the flower field
        /// hangs under the cover's root — so the conversion is applied twice unless the parenting
        /// keeps the world pose. It is the same failure that once threw the cover 93 m off the
        /// statue, and from inside the prefab it looks like nothing at all: two healthy renderers
        /// with sensible transforms, in different postcodes.
        /// </para>
        /// </summary>
        [Test]
        public void Field_StandsWhereTheCoverDoes()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_Prefab);
            Assert.IsNotNull(prefab, $"{k_Prefab} not found; run RootsDance > Build Statue Bloom.");

            GameObject instance = Object.Instantiate(prefab);

            try
            {
                Transform field = instance.transform.Find("Flowers");
                Assert.IsNotNull(field, "the prefab carries no flower field.");

                MeshRenderer flowers = field.GetComponentInChildren<MeshRenderer>();
                MeshRenderer cover = null;

                foreach (MeshRenderer r in instance.GetComponentsInChildren<MeshRenderer>())
                {
                    if (!r.transform.IsChildOf(field))
                    {
                        cover = r;
                        break;
                    }
                }

                Assert.IsNotNull(flowers, "the flower field has no renderer.");
                Assert.IsNotNull(cover, "the cover has no renderer.");

                // The flowers stand out of the cover, so their bounds are taller and wider — but
                // they are wrapped on the same robe, so the middles agree.
                float apart = Vector3.Distance(flowers.bounds.center, cover.bounds.center);
                Assert.Less(apart, 1.5f, $"the flower field sits {apart:0.0} m from the cover; the "
                    + "axis conversion has been applied twice or the import scale disagrees.");

                // 1.65x too large is what a missed import scale looks like, and it survives a
                // centre check because it scales about roughly the same middle.
                float ratio = flowers.bounds.size.y / cover.bounds.size.y;
                Assert.That(ratio, Is.InRange(0.9f, 1.4f),
                    $"the flower field is {ratio:0.00}x the cover's height; check the import scale.");
            }
            finally
            {
                Object.DestroyImmediate(instance);
            }
        }

        [Test]
        public void Field_GrowthOrderSpansTheWholeAnimation()
        {
            Mesh mesh = LoadMesh();
            Color[] colors = mesh.colors;

            Assert.AreEqual(mesh.vertexCount, colors.Length,
                "the field carries no vertex colour, so there is no growth order to open on.");

            float lowest = float.MaxValue;
            float highest = float.MinValue;

            foreach (Color c in colors)
            {
                lowest = Mathf.Min(lowest, c.b);
                highest = Mathf.Max(highest, c.b);
            }

            // Normalised by the generator so _Growth 0 -> 1 spans first flower to last. Unnormalised
            // it stops wherever the scatter stopped and the ending plays on to a finished statue.
            Assert.Less(lowest, 0.02f, "no flower opens at the start of the growth.");
            Assert.Greater(highest, 0.98f, "no flower is left to open at the end of the growth.");
        }
    }
}
