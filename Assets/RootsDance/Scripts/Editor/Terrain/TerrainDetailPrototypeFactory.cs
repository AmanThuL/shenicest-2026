using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Bakes the Terrain detail prototypes the dressing builder needs out of the ordinary dressing
    /// prefabs. A detail prototype is not an ordinary prefab instance: Unity's detail renderer only
    /// reads the <see cref="MeshFilter"/> and the <see cref="MeshRenderer"/> that sit on the
    /// prototype's own root, and it ignores every transform in the prefab. The dressing prefabs put
    /// both the vendor unit fix (a wrapper-root scale) and the vendor axis fix (the model prefab's
    /// -90° X rotation, because the Quaternius grasses are authored Z-up) on exactly those transforms,
    /// so handing a dressing prefab straight to the renderer draws millimetre-sized grass lying flat
    /// on its side. This factory bakes that transform into a mesh asset and wraps it in a one-object
    /// prefab whose root carries the mesh and the vendor material, ready to be a prototype.
    /// </summary>
    /// <remarks>
    /// The generated assets are deterministic: the mesh is re-baked into the existing asset on every
    /// build, so identical input serialises to identical bytes and repeated builds leave the working
    /// tree clean.
    /// </remarks>
    public static class TerrainDetailPrototypeFactory
    {
        private const string k_LogPrefix = "TerrainDetailPrototypeFactory";
        private const string k_MeshFolder = "Assets/RootsDance/Meshes/Environment/Details";
        private const string k_PrefabFolder = "Assets/RootsDance/Prefabs/Environment/Details";
        /// <summary>Suffix both generated assets carry, so the builder can sweep orphans by name.</summary>
        public const string k_NameSuffix = "_Detail";

        /// <summary>Folder holding the generated prototype meshes.</summary>
        public static string MeshFolder => k_MeshFolder;

        /// <summary>Folder holding the generated prototype prefabs.</summary>
        public static string PrefabFolder => k_PrefabFolder;

        /// <summary>
        /// Find-or-bake the detail prototype prefab for a dressing prefab, caching one prototype per
        /// key so two rules that share a prefab (short grass in two bands) bake it once.
        /// </summary>
        /// <param name="key">Dressing prefab key, used to name the generated assets.</param>
        /// <param name="sourcePrefab">The dressing prefab to bake; its first mesh is used.</param>
        /// <param name="cache">Per-build cache of already-baked prototypes, misses included.</param>
        /// <returns>The prototype prefab's root GameObject, or null when the source cannot be baked.</returns>
        public static GameObject EnsurePrototype(string key, GameObject sourcePrefab,
            Dictionary<string, GameObject> cache)
        {
            GameObject prototype;

            if (cache.TryGetValue(key, out prototype))
            {
                return prototype;
            }

            prototype = Bake(key, sourcePrefab);
            cache[key] = prototype;
            return prototype;
        }

        /// <summary>Bakes the mesh asset and the prototype prefab for one dressing prefab.</summary>
        private static GameObject Bake(string key, GameObject sourcePrefab)
        {
            MeshFilter filter = FindDetailMesh(key, sourcePrefab);

            if (filter == null)
            {
                return null;
            }

            MeshRenderer sourceRenderer = filter.GetComponent<MeshRenderer>();

            if (sourceRenderer == null || sourceRenderer.sharedMaterial == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{key}' has no MeshRenderer with a material, so it "
                    + "cannot be a detail prototype.");
                return null;
            }

            Mesh mesh = EnsureBakedMesh(key, filter);

            if (mesh == null)
            {
                return null;
            }

            return EnsurePrototypePrefab(key, mesh, sourceRenderer.sharedMaterial);
        }

        /// <summary>
        /// Returns the single-material mesh a detail prototype can be built from, or null with a
        /// warning explaining which requirement the prefab misses.
        /// </summary>
        private static MeshFilter FindDetailMesh(string key, GameObject sourcePrefab)
        {
            MeshFilter filter = sourcePrefab.GetComponentInChildren<MeshFilter>(true);

            if (filter == null || filter.sharedMesh == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{key}' has no MeshFilter with a mesh, so it cannot "
                    + "be a detail prototype.");
                return null;
            }

            if (filter.sharedMesh.subMeshCount != 1)
            {
                Debug.LogWarning($"{k_LogPrefix}: '{key}' has {filter.sharedMesh.subMeshCount} sub-meshes; "
                    + "a detail prototype needs exactly one. Pick a single-material prefab instead.");
                return null;
            }

            return filter;
        }

        /// <summary>
        /// Re-bakes the dressing prefab's mesh with the prefab's own transform folded in, so the
        /// baked mesh stands upright at its real world size. Writes into the existing mesh asset when
        /// there is one, so a rebuild with unchanged input produces byte-identical output.
        /// </summary>
        private static Mesh EnsureBakedMesh(string key, MeshFilter filter)
        {
            string path = $"{k_MeshFolder}/{key}{k_NameSuffix}.asset";
            Mesh baked = AssetDatabase.LoadAssetAtPath<Mesh>(path);
            bool created = false;

            if (baked == null)
            {
                TerrainSceneUtility.EnsureFolder(k_MeshFolder);
                baked = new Mesh();
                created = true;
            }

            // The wrapper roots sit at the origin with identity rotation (guideline: environment
            // prefabs carry only a uniform root scale), so the child's local-to-world matrix is
            // already the mesh's placement inside the prefab.
            BakeInto(baked, filter.sharedMesh, filter.transform.localToWorldMatrix);
            baked.name = $"{key}{k_NameSuffix}";

            if (created)
            {
                AssetDatabase.CreateAsset(baked, path);
            }
            else
            {
                EditorUtility.SetDirty(baked);
            }

            return baked;
        }

        /// <summary>Copies <paramref name="source"/> into <paramref name="target"/> through a matrix.</summary>
        /// <param name="target">Mesh that is cleared and rewritten; may be an existing asset.</param>
        /// <param name="source">Mesh read from the dressing prefab; never modified.</param>
        /// <param name="matrix">Local-to-world matrix of the source mesh inside its prefab.</param>
        /// <remarks>Pure: no AssetDatabase access, which is what lets the EditMode tests cover it.</remarks>
        public static void BakeInto(Mesh target, Mesh source, Matrix4x4 matrix)
        {
            Vector3[] vertices = source.vertices;
            Vector3[] normals = source.normals;
            Vector4[] tangents = source.tangents;
            Matrix4x4 normalMatrix = matrix.inverse.transpose;

            for (int i = 0; i < vertices.Length; i++)
            {
                vertices[i] = matrix.MultiplyPoint3x4(vertices[i]);
            }

            for (int i = 0; i < normals.Length; i++)
            {
                normals[i] = normalMatrix.MultiplyVector(normals[i]).normalized;
            }

            for (int i = 0; i < tangents.Length; i++)
            {
                Vector3 direction = matrix.MultiplyVector(
                    new Vector3(tangents[i].x, tangents[i].y, tangents[i].z)).normalized;
                tangents[i] = new Vector4(direction.x, direction.y, direction.z, tangents[i].w);
            }

            int[] triangles = source.GetTriangles(0);

            // A mirroring matrix turns every triangle inside out; flipping the winding keeps the
            // baked mesh facing the same way the dressing prefab does.
            if (matrix.determinant < 0f)
            {
                for (int i = 0; i + 2 < triangles.Length; i += 3)
                {
                    int swap = triangles[i + 1];
                    triangles[i + 1] = triangles[i + 2];
                    triangles[i + 2] = swap;
                }
            }

            target.Clear();
            target.indexFormat = source.indexFormat;
            target.vertices = vertices;

            if (normals.Length > 0)
            {
                target.normals = normals;
            }

            if (tangents.Length > 0)
            {
                target.tangents = tangents;
            }

            target.uv = source.uv;
            target.uv2 = source.uv2;
            target.colors = source.colors;
            target.subMeshCount = 1;
            target.SetTriangles(triangles, 0);
            target.RecalculateBounds();
        }

        /// <summary>
        /// Find-or-create the one-object prefab that carries the baked mesh and the vendor material.
        /// An existing prefab that is already wired correctly is left untouched, so a rebuild does not
        /// churn the asset file.
        /// </summary>
        private static GameObject EnsurePrototypePrefab(string key, Mesh mesh, Material material)
        {
            string path = $"{k_PrefabFolder}/{key}{k_NameSuffix}.prefab";
            GameObject existing = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            if (existing != null && IsWired(existing, mesh, material))
            {
                return existing;
            }

            TerrainSceneUtility.EnsureFolder(k_PrefabFolder);

            GameObject temporary = new GameObject($"{key}{k_NameSuffix}");
            temporary.AddComponent<MeshFilter>().sharedMesh = mesh;
            MeshRenderer renderer = temporary.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;

            // Detail instances are drawn by the terrain, not by this renderer; grass shadows are off
            // by project convention anyway.
            renderer.shadowCastingMode = ShadowCastingMode.Off;

            GameObject saved = PrefabUtility.SaveAsPrefabAsset(temporary, path);
            UnityEngine.Object.DestroyImmediate(temporary);

            if (saved == null)
            {
                Debug.LogWarning($"{k_LogPrefix}: could not save the detail prototype prefab at {path}.");
            }

            return saved;
        }

        /// <summary>True when the prototype prefab already points at the baked mesh and material.</summary>
        private static bool IsWired(GameObject prototype, Mesh mesh, Material material)
        {
            MeshFilter filter = prototype.GetComponent<MeshFilter>();
            MeshRenderer renderer = prototype.GetComponent<MeshRenderer>();

            return filter != null
                && renderer != null
                && filter.sharedMesh == mesh
                && renderer.sharedMaterial == material;
        }
    }
}
