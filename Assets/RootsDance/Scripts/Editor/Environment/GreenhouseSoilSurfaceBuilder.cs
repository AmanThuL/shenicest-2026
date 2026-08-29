using System;
using System.Collections.Generic;
using Unity.Collections;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Builds a soil surface from the top footprint of the greenhouse model's own ground mesh.
    /// </summary>
    public static class GreenhouseSoilSurfaceBuilder
    {
        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment.unity";
        private const string k_MeshFolder = "Assets/RootsDance/Meshes/Environment/GreenhouseInterior";
        private const string k_MeshPath = k_MeshFolder + "/GreenhouseSoilSurface.asset";
        private const string k_MaterialPath =
            "Assets/RootsDance/Materials/Environment/GreenhouseInterior/GreenhouseSoil.mat";
        private const string k_BaseMapPath =
            "Assets/ThirdParty/Environment/PolyHaven/Textures/brown_mud_02/brown_mud_02_diff_1k.jpg";
        private const string k_NormalMapPath =
            "Assets/ThirdParty/Environment/PolyHaven/Textures/brown_mud_02/brown_mud_02_nor_gl_1k.jpg";
        private const string k_GreenhouseName = "GreenHouse1_Textured";
        private const string k_GroundMeshName = "GROUD_T";
        private const string k_RootName = "GreenhouseSoilSurface";

        private const int k_EdgeSubdivisions = 8;
        private const int k_Rings = 12;
        private const float k_SurfaceClearance = 0.015f;
        private const float k_VertexMergeTolerance = 0.002f;

        [MenuItem("RootsDance/Environment/Build Greenhouse Soil Surface")]
        private static void Build()
        {
            Scene scene = SceneManager.GetActiveScene();
            if (scene.path != k_ScenePath)
            {
                throw new InvalidOperationException(
                    "Open GreenhouseInterior_Environment before building its soil surface.");
            }

            Transform props = FindInScene(scene, "_Props");
            Transform greenhouse = FindInScene(scene, k_GreenhouseName);
            if (props == null || greenhouse == null)
            {
                throw new InvalidOperationException(
                    "The greenhouse scene is missing _Props or GreenHouse1_Textured.");
            }

            MeshFilter ground = FindGroundMesh(greenhouse);
            List<Vector3> boundary = ExtractTopBoundary(ground);
            Bounds groundTopBounds = CalculateBounds(boundary);
            Mesh mesh = BuildSoilMesh(boundary, groundTopBounds);
            ValidateMesh(mesh, groundTopBounds);
            SaveMesh(mesh);

            Mesh savedMesh = AssetDatabase.LoadAssetAtPath<Mesh>(k_MeshPath);
            if (savedMesh == null)
            {
                throw new InvalidOperationException("The greenhouse soil mesh was not saved.");
            }

            ValidateMesh(savedMesh, groundTopBounds);
            Material material = BuildMaterial();

            Transform existing = props.Find(k_RootName);
            if (existing != null)
            {
                Undo.DestroyObjectImmediate(existing.gameObject);
            }

            GameObject root = new GameObject(k_RootName);
            Undo.RegisterCreatedObjectUndo(root, "Build greenhouse soil surface");
            root.transform.SetParent(props, true);
            root.layer = LayerMask.NameToLayer("Ground");
            root.isStatic = true;

            MeshFilter filter = root.AddComponent<MeshFilter>();
            filter.sharedMesh = savedMesh;
            MeshRenderer renderer = root.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On;
            renderer.receiveShadows = true;

            MeshCollider soilCollider = root.AddComponent<MeshCollider>();
            soilCollider.sharedMesh = savedMesh;

            Transform walkableFloor = FindInScene(scene, "WalkableFloor");
            if (walkableFloor != null)
            {
                Collider floorCollider = walkableFloor.GetComponent<Collider>();
                if (floorCollider != null)
                {
                    floorCollider.enabled = false;
                }
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();
            Selection.activeGameObject = root;

            SceneView sceneView = SceneView.lastActiveSceneView;
            if (sceneView != null)
            {
                sceneView.pivot = groundTopBounds.center + new Vector3(0f, 0.18f, 0f);
                sceneView.rotation = Quaternion.LookRotation(new Vector3(0f, -0.35f, 1f));
                sceneView.size = Mathf.Max(8f, groundTopBounds.extents.magnitude * 0.7f);
                sceneView.Repaint();
            }

            Debug.Log(
                $"Built greenhouse soil from {k_GroundMeshName} top: "
                + $"{groundTopBounds.size.x:F2} x {groundTopBounds.size.z:F2} m, "
                + $"{boundary.Count}-point footprint, volume and Ground collision enabled.",
                root);
        }

        private static MeshFilter FindGroundMesh(Transform greenhouse)
        {
            MeshFilter match = null;

            foreach (MeshFilter filter in greenhouse.GetComponentsInChildren<MeshFilter>(true))
            {
                if (filter.sharedMesh == null)
                {
                    continue;
                }

                if (filter.name != k_GroundMeshName && filter.sharedMesh.name != k_GroundMeshName)
                {
                    continue;
                }

                if (match != null)
                {
                    throw new InvalidOperationException(
                        $"GreenHouse1_Textured contains more than one {k_GroundMeshName} mesh.");
                }

                match = filter;
            }

            if (match == null)
            {
                throw new InvalidOperationException(
                    $"GreenHouse1_Textured does not contain its expected {k_GroundMeshName} mesh.");
            }

            return match;
        }

        private static List<Vector3> ExtractTopBoundary(MeshFilter ground)
        {
            Mesh source = ground.sharedMesh;
            List<Vector3> worldVertices = new List<Vector3>(source.vertexCount);

            using (Mesh.MeshDataArray meshDataArray = MeshUtility.AcquireReadOnlyMeshData(source))
            using (NativeArray<Vector3> sourceVertices =
                new NativeArray<Vector3>(meshDataArray[0].vertexCount, Allocator.Temp))
            {
                meshDataArray[0].GetVertices(sourceVertices);

                for (int i = 0; i < sourceVertices.Length; i++)
                {
                    worldVertices.Add(ground.transform.TransformPoint(sourceVertices[i]));
                }
            }

            if (worldVertices.Count < 3)
            {
                throw new InvalidOperationException($"{k_GroundMeshName} has too few vertices.");
            }

            float minY = worldVertices[0].y;
            float maxY = worldVertices[0].y;
            foreach (Vector3 vertex in worldVertices)
            {
                minY = Mathf.Min(minY, vertex.y);
                maxY = Mathf.Max(maxY, vertex.y);
            }

            float topTolerance = Mathf.Max(0.01f, (maxY - minY) * 0.02f);
            List<Vector3> topVertices = new List<Vector3>();
            foreach (Vector3 vertex in worldVertices)
            {
                if (maxY - vertex.y <= topTolerance)
                {
                    AddUnique(topVertices, vertex);
                }
            }

            List<Vector3> boundary = BuildConvexHull(topVertices);
            if (boundary.Count < 3)
            {
                throw new InvalidOperationException(
                    $"Could not derive the top footprint of {k_GroundMeshName}.");
            }

            // The monotonic-chain hull is counter-clockwise in XZ, which faces down in Unity.
            boundary.Reverse();
            return boundary;
        }

        private static void AddUnique(List<Vector3> points, Vector3 candidate)
        {
            float toleranceSquared = k_VertexMergeTolerance * k_VertexMergeTolerance;
            foreach (Vector3 point in points)
            {
                Vector2 delta = new Vector2(point.x - candidate.x, point.z - candidate.z);
                if (delta.sqrMagnitude <= toleranceSquared)
                {
                    return;
                }
            }

            points.Add(candidate);
        }

        private static List<Vector3> BuildConvexHull(List<Vector3> points)
        {
            points.Sort(CompareByXThenZ);
            List<Vector3> hull = new List<Vector3>(points.Count * 2);

            foreach (Vector3 point in points)
            {
                while (hull.Count >= 2
                    && CrossXZ(hull[hull.Count - 2], hull[hull.Count - 1], point) <= 0f)
                {
                    hull.RemoveAt(hull.Count - 1);
                }

                hull.Add(point);
            }

            int lowerCount = hull.Count;
            for (int i = points.Count - 2; i >= 0; i--)
            {
                Vector3 point = points[i];
                while (hull.Count > lowerCount
                    && CrossXZ(hull[hull.Count - 2], hull[hull.Count - 1], point) <= 0f)
                {
                    hull.RemoveAt(hull.Count - 1);
                }

                hull.Add(point);
            }

            if (hull.Count > 1)
            {
                hull.RemoveAt(hull.Count - 1);
            }

            return hull;
        }

        private static int CompareByXThenZ(Vector3 left, Vector3 right)
        {
            int xComparison = left.x.CompareTo(right.x);
            return xComparison != 0 ? xComparison : left.z.CompareTo(right.z);
        }

        private static float CrossXZ(Vector3 origin, Vector3 a, Vector3 b)
        {
            return (a.x - origin.x) * (b.z - origin.z)
                - (a.z - origin.z) * (b.x - origin.x);
        }

        private static Bounds CalculateBounds(List<Vector3> points)
        {
            Bounds bounds = new Bounds(points[0], Vector3.zero);
            for (int i = 1; i < points.Count; i++)
            {
                bounds.Encapsulate(points[i]);
            }

            return bounds;
        }

        private static Mesh BuildSoilMesh(List<Vector3> boundary, Bounds footprintBounds)
        {
            int segmentCount = boundary.Count * k_EdgeSubdivisions;
            int surfaceVertexCount = 1 + k_Rings * segmentCount;
            List<Vector3> vertices = new List<Vector3>(surfaceVertexCount + segmentCount * 2);
            List<Vector2> uvs = new List<Vector2>(vertices.Capacity);
            List<int> triangles = new List<int>(segmentCount * (k_Rings * 6 + 6));

            Vector3 center = Vector3.zero;
            foreach (Vector3 point in boundary)
            {
                center += point;
            }

            center /= boundary.Count;
            AddSurfaceVertex(vertices, uvs, center, footprintBounds);

            for (int ring = 1; ring <= k_Rings; ring++)
            {
                float ring01 = ring / (float)k_Rings;
                for (int segment = 0; segment < segmentCount; segment++)
                {
                    Vector3 edgePoint = SampleBoundary(boundary, segment);
                    Vector3 point = Vector3.Lerp(center, edgePoint, ring01);
                    AddSurfaceVertex(vertices, uvs, point, footprintBounds);
                }
            }

            for (int segment = 0; segment < segmentCount; segment++)
            {
                int next = (segment + 1) % segmentCount;
                triangles.Add(0);
                triangles.Add(1 + segment);
                triangles.Add(1 + next);
            }

            for (int ring = 2; ring <= k_Rings; ring++)
            {
                int innerStart = 1 + (ring - 2) * segmentCount;
                int outerStart = innerStart + segmentCount;

                for (int segment = 0; segment < segmentCount; segment++)
                {
                    int next = (segment + 1) % segmentCount;
                    int inner = innerStart + segment;
                    int innerNext = innerStart + next;
                    int outer = outerStart + segment;
                    int outerNext = outerStart + next;

                    triangles.Add(inner);
                    triangles.Add(outer);
                    triangles.Add(outerNext);
                    triangles.Add(inner);
                    triangles.Add(outerNext);
                    triangles.Add(innerNext);
                }
            }

            int boundaryStart = 1 + (k_Rings - 1) * segmentCount;
            float skirtBottom = center.y + k_SurfaceClearance;
            AddSkirt(vertices, uvs, triangles, boundaryStart, segmentCount, skirtBottom);

            Mesh mesh = new Mesh { name = "GreenhouseSoilSurface" };
            mesh.SetVertices(vertices);
            mesh.SetUVs(0, uvs);
            mesh.SetTriangles(triangles, 0);
            mesh.RecalculateNormals();
            mesh.RecalculateTangents();
            mesh.RecalculateBounds();
            return mesh;
        }

        private static Vector3 SampleBoundary(List<Vector3> boundary, int segment)
        {
            int edge = segment / k_EdgeSubdivisions;
            int nextEdge = (edge + 1) % boundary.Count;
            float edge01 = (segment % k_EdgeSubdivisions) / (float)k_EdgeSubdivisions;
            return Vector3.Lerp(boundary[edge], boundary[nextEdge], edge01);
        }

        private static void AddSurfaceVertex(
            List<Vector3> vertices, List<Vector2> uvs, Vector3 point, Bounds footprintBounds)
        {
            point.y += k_SurfaceClearance
                + SampleHeight(point.x, point.z, footprintBounds.center, footprintBounds.size.x,
                    footprintBounds.size.z);
            vertices.Add(point);
            uvs.Add(new Vector2(point.x * 0.35f, point.z * 0.35f));
        }

        private static float SampleHeight(float x, float z, Vector3 center, float width, float depth)
        {
            float broad = Mathf.PerlinNoise((x + 43f) * 0.075f, (z - 17f) * 0.075f);
            float detail = Mathf.PerlinNoise((x - 9f) * 0.19f, (z + 31f) * 0.19f);
            float height = 0.14f + broad * 0.18f + detail * 0.04f;
            height += Mound(
                x, z, center.x - width * 0.22f, center.z + depth * 0.16f,
                width * 0.22f, depth * 0.16f, 0.16f);
            height += Mound(
                x, z, center.x + width * 0.2f, center.z - depth * 0.15f,
                width * 0.2f, depth * 0.18f, 0.14f);
            height += Mound(
                x, z, center.x, center.z + depth * 0.28f,
                width * 0.25f, depth * 0.13f, 0.1f);
            return height;
        }

        private static float Mound(
            float x, float z, float centerX, float centerZ, float radiusX, float radiusZ, float height)
        {
            float dx = (x - centerX) / Mathf.Max(0.01f, radiusX);
            float dz = (z - centerZ) / Mathf.Max(0.01f, radiusZ);
            return Mathf.Exp(-(dx * dx + dz * dz) * 2f) * height;
        }

        private static void AddSkirt(
            List<Vector3> vertices,
            List<Vector2> uvs,
            List<int> triangles,
            int boundaryStart,
            int segmentCount,
            float bottomY)
        {
            for (int segment = 0; segment < segmentCount; segment++)
            {
                int next = (segment + 1) % segmentCount;
                int topA = boundaryStart + segment;
                int topB = boundaryStart + next;
                int bottomA = vertices.Count;
                vertices.Add(new Vector3(vertices[topA].x, bottomY, vertices[topA].z));
                uvs.Add(uvs[topA]);
                int bottomB = vertices.Count;
                vertices.Add(new Vector3(vertices[topB].x, bottomY, vertices[topB].z));
                uvs.Add(uvs[topB]);

                triangles.Add(topA);
                triangles.Add(bottomA);
                triangles.Add(topB);
                triangles.Add(topB);
                triangles.Add(bottomA);
                triangles.Add(bottomB);
            }
        }

        private static void ValidateMesh(Mesh mesh, Bounds footprintBounds)
        {
            const float k_BoundsTolerance = 0.03f;
            Bounds meshBounds = mesh.bounds;
            bool matchesFootprint = Mathf.Abs(meshBounds.min.x - footprintBounds.min.x) <= k_BoundsTolerance
                && Mathf.Abs(meshBounds.max.x - footprintBounds.max.x) <= k_BoundsTolerance
                && Mathf.Abs(meshBounds.min.z - footprintBounds.min.z) <= k_BoundsTolerance
                && Mathf.Abs(meshBounds.max.z - footprintBounds.max.z) <= k_BoundsTolerance;

            if (!matchesFootprint || meshBounds.size.y < 0.1f)
            {
                throw new InvalidOperationException(
                    $"The soil mesh does not match the {k_GroundMeshName} top footprint.");
            }
        }

        private static Material BuildMaterial()
        {
            EnsureFolder("Assets/RootsDance/Materials/Environment/GreenhouseInterior");
            Material material = AssetDatabase.LoadAssetAtPath<Material>(k_MaterialPath);
            if (material == null)
            {
                Shader shader = Shader.Find("HDRP/Lit");
                if (shader == null)
                {
                    throw new InvalidOperationException("HDRP/Lit shader is unavailable.");
                }

                material = new Material(shader) { name = "GreenhouseSoil" };
                AssetDatabase.CreateAsset(material, k_MaterialPath);
            }

            material.SetColor("_BaseColor", new Color(0.72f, 0.55f, 0.38f, 1f));
            material.SetTexture("_BaseColorMap", AssetDatabase.LoadAssetAtPath<Texture2D>(k_BaseMapPath));
            material.SetTexture("_NormalMap", AssetDatabase.LoadAssetAtPath<Texture2D>(k_NormalMapPath));
            material.SetFloat("_NormalScale", 0.75f);
            material.SetFloat("_Smoothness", 0.08f);
            material.EnableKeyword("_NORMALMAP");
            EditorUtility.SetDirty(material);
            return material;
        }

        private static void SaveMesh(Mesh source)
        {
            EnsureFolder(k_MeshFolder);
            Mesh existing = AssetDatabase.LoadAssetAtPath<Mesh>(k_MeshPath);
            if (existing == null)
            {
                AssetDatabase.CreateAsset(source, k_MeshPath);
            }
            else
            {
                existing.Clear();
                existing.name = source.name;
                existing.indexFormat = source.indexFormat;
                existing.vertices = source.vertices;
                existing.uv = source.uv;
                existing.triangles = source.triangles;
                existing.normals = source.normals;
                existing.tangents = source.tangents;
                existing.bounds = source.bounds;
                UnityEngine.Object.DestroyImmediate(source);
                EditorUtility.SetDirty(existing);
            }
        }

        private static Transform FindInScene(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                Transform found = FindRecursive(root.transform, name);
                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        private static Transform FindRecursive(Transform root, string name)
        {
            if (root.name == name)
            {
                return root;
            }

            for (int i = 0; i < root.childCount; i++)
            {
                Transform found = FindRecursive(root.GetChild(i), name);
                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        private static void EnsureFolder(string path)
        {
            string[] parts = path.Split('/');
            string current = parts[0];
            for (int i = 1; i < parts.Length; i++)
            {
                string next = current + "/" + parts[i];
                if (!AssetDatabase.IsValidFolder(next))
                {
                    AssetDatabase.CreateFolder(current, parts[i]);
                }

                current = next;
            }
        }
    }
}
