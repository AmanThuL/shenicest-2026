using System;
using System.Collections.Generic;
using System.IO;
using RootsDance.Environment;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Installs the compact first-storey arch that physically joins the laboratory.</summary>
    public static class ChapterHouseRoundEntranceBuilder
    {
        private const string k_ModelPath =
            "Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouseRoundEntrance.fbx";
        private const string k_GeneratedMeshFolder =
            "Assets/RootsDance/Meshes/Environment/ChapterHouse/Generated";
        private const string k_MaterialFolder =
            "Assets/RootsDance/Materials/Environment/ChapterHouse/Entrance";
        private const string k_RootName = "ChapterHouseRoundEntrance";
        private const string k_DoorRootName = "ChapterHouseArchAutomaticDoor";
        private const string k_LeftDoorName = "RoundEntrance_Door_Left";
        private const string k_RightDoorName = "RoundEntrance_Door_Right";
        private const string k_TargetWallName = "ClothLandscape_CorridorShell.009";
        private const float k_OpeningHalfWidth = 1.875f;
        private const float k_OpeningSpringHeight = 1.15f;
        private const float k_OpeningArchRise = 1.63f;
        private const float k_CutPadding = 0.08f;
        private const float k_WallHalfDepth = 0.25f;
        private const float k_CorridorLength = 6.2f;
        private const int k_ArchSegments = 24;

        private static readonly Color k_WallColour = new Color(0.10f, 0.16f, 0.24f);
        private static readonly Color k_StoneColour = new Color(0.12f, 0.22f, 0.33f);
        private static readonly Color k_FloorColour = new Color(0.14f, 0.17f, 0.20f);

        /// <summary>World-space seam used to align the linked content with the laboratory.</summary>
        public readonly struct Placement
        {
            public Placement(Vector3 openingCentre, float floorY, float corridorLength)
            {
                OpeningCentre = openingCentre;
                FloorY = floorY;
                CorridorLength = corridorLength;
            }

            public Vector3 OpeningCentre { get; }
            public float FloorY { get; }
            public float CorridorLength { get; }
        }

        /// <summary>Restores the source building, cuts only its first-storey wall and adds the arch.</summary>
        public static Placement Replace(
            GameObject building,
            Transform geometry,
            Scene scene,
            Bounds floor,
            Bounds legacyDoorway)
        {
            if (building == null)
            {
                throw new ArgumentNullException(nameof(building));
            }

            float floorY = floor.max.y;
            float wallZ = legacyDoorway.center.z;
            Vector3 openingOrigin = new Vector3(floor.center.x, floorY, wallZ);
            Vector3 openingCentre = openingOrigin
                + Vector3.up * (k_OpeningSpringHeight + k_OpeningArchRise) * 0.5f;

            CreateOpeningMesh(building, openingOrigin);
            GameObject entrance = InstantiateEntrance(
                geometry,
                scene,
                openingOrigin,
                legacyDoorway.center.x - openingOrigin.x);
            AddCollision(entrance);
            SetStatic(entrance);
            InstallAutomaticDoor(entrance);

            return new Placement(openingCentre, floorY, k_CorridorLength);
        }

        /// <summary>
        /// Creates an opaque floor behind the undercroft so its two planted pits never reveal the skybox.
        /// </summary>
        public static Material EnsureUndercroftMaterial()
        {
            EnsureFolder(k_MaterialFolder);
            return EnsureMaterial(
                "ChapterHouseUndercroft_Liner",
                new Color(0.025f, 0.045f, 0.07f),
                0.08f);
        }

        private static void CreateOpeningMesh(GameObject building, Vector3 openingOrigin)
        {
            if (AssetDatabase.IsValidFolder(k_GeneratedMeshFolder))
            {
                AssetDatabase.DeleteAsset(k_GeneratedMeshFolder);
            }

            EnsureFolder(k_GeneratedMeshFolder);
            MeshFilter target = null;
            MeshFilter[] filters = building.GetComponentsInChildren<MeshFilter>(true);

            for (int i = 0; i < filters.Length; i++)
            {
                if (filters[i].name == k_TargetWallName)
                {
                    target = filters[i];
                    break;
                }
            }

            if (target == null || target.sharedMesh == null)
            {
                throw new InvalidOperationException(
                    "The Chapter House first-storey plaster wall was not found: " + k_TargetWallName);
            }

            Mesh source = target.sharedMesh;
            Vector3[] vertices = source.vertices;
            List<Vector2> opening = CreateOpeningPolygon(openingOrigin);
            List<int>[] trianglesBySubMesh = new List<int>[source.subMeshCount];
            int removedTriangleCount = 0;

            for (int subMesh = 0; subMesh < source.subMeshCount; subMesh++)
            {
                int[] triangles = source.GetTriangles(subMesh);
                List<int> kept = new List<int>(triangles.Length);

                for (int triangle = 0; triangle < triangles.Length; triangle += 3)
                {
                    Vector3 a = target.transform.TransformPoint(vertices[triangles[triangle]]);
                    Vector3 b = target.transform.TransformPoint(vertices[triangles[triangle + 1]]);
                    Vector3 c = target.transform.TransformPoint(vertices[triangles[triangle + 2]]);

                    if (IntersectsOpening(a, b, c, openingOrigin.z, opening))
                    {
                        removedTriangleCount++;
                        continue;
                    }

                    kept.Add(triangles[triangle]);
                    kept.Add(triangles[triangle + 1]);
                    kept.Add(triangles[triangle + 2]);
                }

                trianglesBySubMesh[subMesh] = kept;
            }

            if (removedTriangleCount < 20)
            {
                throw new InvalidOperationException(
                    "The first-storey arch did not intersect enough wall triangles ("
                    + removedTriangleCount + ").");
            }

            Mesh generated = UnityEngine.Object.Instantiate(source);
            generated.name = target.name + "_FirstStoreyArch";

            for (int subMesh = 0; subMesh < trianglesBySubMesh.Length; subMesh++)
            {
                generated.SetTriangles(trianglesBySubMesh[subMesh], subMesh, false);
            }

            generated.RecalculateBounds();
            string assetPath = k_GeneratedMeshFolder + "/ChapterHouse_FirstStoreyArch.asset";
            AssetDatabase.CreateAsset(generated, assetPath);
            target.sharedMesh = generated;
        }

        private static List<Vector2> CreateOpeningPolygon(Vector3 origin)
        {
            float halfWidth = k_OpeningHalfWidth + k_CutPadding;
            float spring = k_OpeningSpringHeight;
            float rise = k_OpeningArchRise + k_CutPadding;
            List<Vector2> points = new List<Vector2>(k_ArchSegments + 3)
            {
                new Vector2(origin.x - halfWidth, origin.y - k_CutPadding),
                new Vector2(origin.x - halfWidth, origin.y + spring),
            };

            for (int i = 1; i <= k_ArchSegments; i++)
            {
                float angle = Mathf.PI - Mathf.PI * i / k_ArchSegments;
                points.Add(new Vector2(
                    origin.x + halfWidth * Mathf.Cos(angle),
                    origin.y + spring + rise * Mathf.Sin(angle)));
            }

            points.Add(new Vector2(origin.x + halfWidth, origin.y - k_CutPadding));
            return points;
        }

        private static bool IntersectsOpening(
            Vector3 a,
            Vector3 b,
            Vector3 c,
            float wallZ,
            IReadOnlyList<Vector2> polygon)
        {
            float minimumZ = Mathf.Min(a.z, Mathf.Min(b.z, c.z));
            float maximumZ = Mathf.Max(a.z, Mathf.Max(b.z, c.z));

            if (maximumZ < wallZ - k_WallHalfDepth || minimumZ > wallZ + k_WallHalfDepth)
            {
                return false;
            }

            Vector2[] triangle =
            {
                new Vector2(a.x, a.y),
                new Vector2(b.x, b.y),
                new Vector2(c.x, c.y),
            };

            for (int i = 0; i < triangle.Length; i++)
            {
                if (PointInPolygon(triangle[i], polygon))
                {
                    return true;
                }
            }

            for (int i = 0; i < polygon.Count; i++)
            {
                if (PointInTriangle(polygon[i], triangle[0], triangle[1], triangle[2]))
                {
                    return true;
                }
            }

            for (int triangleEdge = 0; triangleEdge < triangle.Length; triangleEdge++)
            {
                Vector2 triangleStart = triangle[triangleEdge];
                Vector2 triangleEnd = triangle[(triangleEdge + 1) % triangle.Length];

                for (int polygonEdge = 0; polygonEdge < polygon.Count; polygonEdge++)
                {
                    Vector2 polygonStart = polygon[polygonEdge];
                    Vector2 polygonEnd = polygon[(polygonEdge + 1) % polygon.Count];

                    if (SegmentsIntersect(triangleStart, triangleEnd, polygonStart, polygonEnd))
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        private static bool PointInPolygon(Vector2 point, IReadOnlyList<Vector2> polygon)
        {
            bool inside = false;

            for (int i = 0, j = polygon.Count - 1; i < polygon.Count; j = i++)
            {
                Vector2 a = polygon[i];
                Vector2 b = polygon[j];
                bool crosses = (a.y > point.y) != (b.y > point.y)
                    && point.x < (b.x - a.x) * (point.y - a.y) / (b.y - a.y) + a.x;

                if (crosses)
                {
                    inside = !inside;
                }
            }

            return inside;
        }

        private static bool PointInTriangle(Vector2 point, Vector2 a, Vector2 b, Vector2 c)
        {
            float first = Cross(point, a, b);
            float second = Cross(point, b, c);
            float third = Cross(point, c, a);
            bool hasNegative = first < 0f || second < 0f || third < 0f;
            bool hasPositive = first > 0f || second > 0f || third > 0f;
            return !(hasNegative && hasPositive);
        }

        private static bool SegmentsIntersect(Vector2 a, Vector2 b, Vector2 c, Vector2 d)
        {
            float abC = Cross(c, a, b);
            float abD = Cross(d, a, b);
            float cdA = Cross(a, c, d);
            float cdB = Cross(b, c, d);
            return abC * abD <= 0f && cdA * cdB <= 0f;
        }

        private static float Cross(Vector2 point, Vector2 a, Vector2 b)
        {
            return (point.x - a.x) * (b.y - a.y) - (point.y - a.y) * (b.x - a.x);
        }

        private static GameObject InstantiateEntrance(
            Transform geometry,
            Scene scene,
            Vector3 openingOrigin,
            float legacyDoorOffset)
        {
            GameObject model = AssetDatabase.LoadAssetAtPath<GameObject>(k_ModelPath);

            if (model == null)
            {
                throw new FileNotFoundException("Chapter House entrance model missing: " + k_ModelPath);
            }

            GameObject entrance = (GameObject)PrefabUtility.InstantiatePrefab(model, scene);
            entrance.name = k_RootName;
            entrance.transform.SetParent(geometry, false);
            entrance.transform.SetPositionAndRotation(openingOrigin, Quaternion.identity);
            entrance.transform.localScale = Vector3.one;

            Transform patch = FindChild(entrance.transform, "RoundEntrance_LegacyDoorPatch");

            if (patch == null)
            {
                throw new InvalidOperationException("The Chapter House entrance has no legacy-door patch.");
            }

            Vector3 patchPosition = patch.localPosition;
            patchPosition.x = legacyDoorOffset;
            patch.localPosition = patchPosition;

            IReadOnlyDictionary<string, Material> materials = EnsureEntranceMaterials();
            Renderer[] renderers = entrance.GetComponentsInChildren<Renderer>(true);

            for (int i = 0; i < renderers.Length; i++)
            {
                string surface = SurfaceFor(renderers[i].name);

                if (!materials.TryGetValue(surface, out Material material))
                {
                    throw new InvalidOperationException("Entrance material is missing: " + surface);
                }

                Material[] slots = renderers[i].sharedMaterials;

                for (int slot = 0; slot < slots.Length; slot++)
                {
                    slots[slot] = material;
                }

                renderers[i].sharedMaterials = slots;
            }

            return entrance;
        }

        private static IReadOnlyDictionary<string, Material> EnsureEntranceMaterials()
        {
            EnsureFolder(k_MaterialFolder);
            return new Dictionary<string, Material>(StringComparer.Ordinal)
            {
                { "Wall", EnsureMaterial("ChapterHouseEntrance_Wall", k_WallColour, 0.14f) },
                { "Stone", EnsureMaterial("ChapterHouseEntrance_Stone", k_StoneColour, 0.22f) },
                { "Floor", EnsureMaterial("ChapterHouseEntrance_Floor", k_FloorColour, 0.16f) },
            };
        }

        private static Material EnsureMaterial(string name, Color colour, float smoothness)
        {
            string path = k_MaterialFolder + "/" + name + ".mat";
            Material material = AssetDatabase.LoadAssetAtPath<Material>(path);
            bool isNew = material == null;

            if (isNew)
            {
                Shader shader = Shader.Find("HDRP/Lit");

                if (shader == null)
                {
                    throw new InvalidOperationException("HDRP/Lit shader was not found.");
                }

                material = new Material(shader);
                material.name = name;
            }

            material.SetTexture("_BaseColorMap", null);
            material.SetColor("_BaseColor", colour);
            material.SetFloat("_Metallic", 0f);
            material.SetFloat("_Smoothness", smoothness);
            material.SetFloat("_DoubleSidedEnable", 1f);
            HDMaterial.ValidateMaterial(material);

            if (isNew)
            {
                AssetDatabase.CreateAsset(material, path);
            }
            else
            {
                EditorUtility.SetDirty(material);
            }

            return material;
        }

        private static string SurfaceFor(string objectName)
        {
            if (objectName == "RoundEntrance_Floor")
            {
                return "Floor";
            }

            if (objectName == "RoundEntrance_LegacyDoorPatch"
                || objectName == k_LeftDoorName
                || objectName == k_RightDoorName
                || objectName.StartsWith("RoundEntrance_FirstStoreySurround_", StringComparison.Ordinal))
            {
                return "Wall";
            }

            return "Stone";
        }

        private static void AddCollision(GameObject entrance)
        {
            int groundLayer = LayerMask.NameToLayer("Ground");

            if (groundLayer < 0)
            {
                throw new InvalidOperationException("The required Ground layer does not exist.");
            }

            MeshFilter[] filters = entrance.GetComponentsInChildren<MeshFilter>(true);

            for (int i = 0; i < filters.Length; i++)
            {
                MeshFilter filter = filters[i];

                if (filter.sharedMesh == null)
                {
                    continue;
                }

                MeshCollider collider = filter.gameObject.AddComponent<MeshCollider>();
                collider.sharedMesh = filter.sharedMesh;
                collider.convex = false;

                if (filter.name == "RoundEntrance_Floor")
                {
                    filter.gameObject.layer = groundLayer;
                }
            }
        }

        private static void InstallAutomaticDoor(GameObject entrance)
        {
            Transform left = FindChild(entrance.transform, k_LeftDoorName);
            Transform right = FindChild(entrance.transform, k_RightDoorName);

            if (left == null || right == null)
            {
                throw new InvalidOperationException("The Chapter House arch is missing its sliding door leaves.");
            }

            left.gameObject.isStatic = false;
            right.gameObject.isStatic = false;

            int triggerLayer = LayerMask.NameToLayer("TriggerVolume");

            if (triggerLayer < 0)
            {
                throw new InvalidOperationException("The required TriggerVolume layer does not exist.");
            }

            GameObject root = new GameObject(k_DoorRootName);
            root.transform.SetParent(entrance.transform, false);
            root.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.layer = triggerLayer;

            BoxCollider trigger = root.AddComponent<BoxCollider>();
            trigger.isTrigger = true;
            // Reach far enough down the tunnel to finish opening before contact, but only a short
            // distance into the hall so it closes as soon as the player has properly entered.
            trigger.center = new Vector3(0f, 1.4f, -1.5f);
            trigger.size = new Vector3(5.4f, 3.2f, 6f);

            AutomaticSlidingDoor door = root.AddComponent<AutomaticSlidingDoor>();
            door.Configure(left, right, 2.05f, 2.6f);
            door.ConfigureRuneSequence(
                null,
                null,
                1,
                null,
                null,
                0.05f,
                0.05f,
                0.05f,
                0f,
                0f);
        }

        private static Transform FindChild(Transform root, string name)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                if (transforms[i].name == name)
                {
                    return transforms[i];
                }
            }

            return null;
        }

        private static void SetStatic(GameObject root)
        {
            Transform[] transforms = root.GetComponentsInChildren<Transform>(true);

            for (int i = 0; i < transforms.Length; i++)
            {
                transforms[i].gameObject.isStatic = true;
            }
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
