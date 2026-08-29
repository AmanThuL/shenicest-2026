using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Environment
{
    /// <summary>Read-only spatial report for the current Chapter-00 facility and checkpoint anchors.</summary>
    public static class Chapter00FacilitySpatialAudit
    {
        private const string k_ScenePath =
            "Assets/RootsDance/Scenes/Levels/Main/Main_Environment.unity";
        private const string k_OutputPath = "Logs/SpatialAudits/chapter00_facility_current.txt";
        private const float k_PlayerRadius = .5f;
        private const float k_PlayerBottomCenter = .5f;
        private const float k_PlayerTopCenter = 1.3f;
        private const float k_RouteSampleStep = .25f;

        public static void AuditFromCommandLine()
        {
            Scene scene = EditorSceneManager.OpenScene(k_ScenePath, OpenSceneMode.Single);
            Transform facility = Find(scene, "ResearchFacility_GaiaV7");

            if (facility == null)
            {
                throw new InvalidOperationException("ResearchFacility_GaiaV7 was not found.");
            }

            StringBuilder report = new StringBuilder();
            report.AppendLine("Chapter 00 facility spatial audit");
            report.AppendLine($"scene={k_ScenePath}");
            report.AppendLine($"facility.position={Format(facility.position)}");
            report.AppendLine($"facility.euler={Format(facility.eulerAngles)}");
            report.AppendLine($"facility.bounds={Format(BoundsOf(facility))}");
            report.AppendLine();
            report.AppendLine("TOP_LEVEL_CHILDREN");

            foreach (Transform child in facility)
            {
                report.AppendLine(
                    $"{child.name}|world={Format(child.position)}|local={Format(child.localPosition)}"
                    + $"|euler={Format(child.eulerAngles)}|bounds={Format(BoundsOf(child))}");
            }

            report.AppendLine();
            report.AppendLine("NAMED_FACILITY_PARTS");
            string[] tokens = { "corridor", "greenhouse", "plantresearch", "door12", "door_12", "dome" };

            foreach (Transform transform in facility.GetComponentsInChildren<Transform>(true))
            {
                MeshFilter filter = transform.GetComponent<MeshFilter>();
                string meshName = filter != null && filter.sharedMesh != null ? filter.sharedMesh.name : string.Empty;
                string searchable = (transform.name + " " + meshName).ToLowerInvariant();

                if (!ContainsAny(searchable, tokens))
                {
                    continue;
                }

                report.AppendLine(
                    $"{PathOf(facility, transform)}|mesh={meshName}|world={Format(transform.position)}"
                    + $"|euler={Format(transform.eulerAngles)}|bounds={Format(BoundsOf(transform))}");
            }

            report.AppendLine();
            report.AppendLine("CHECKPOINT_ANCHORS");

            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (Transform transform in root.GetComponentsInChildren<Transform>(true))
                {
                    if (transform.name.StartsWith("Anchor_00-", StringComparison.Ordinal))
                    {
                        report.AppendLine($"{transform.name}|world={Format(transform.position)}");
                    }
                }
            }

            report.AppendLine();
            report.AppendLine("CORRIDOR1_FULL_CAPSULE_GRID x=16..44 step2, z=120..84 step-2; .=free #=blocked");
            Physics.SyncTransforms();
            UnityEngine.Terrain terrain = UnityEngine.Object.FindFirstObjectByType<UnityEngine.Terrain>();

            for (float z = 120f; z >= 84f; z -= 2f)
            {
                report.Append($"z={z,5:F1} ");

                for (float x = 16f; x <= 44f; x += 2f)
                {
                    float ground = terrain != null
                        ? terrain.SampleHeight(new Vector3(x, 0f, z)) + terrain.transform.position.y
                        : 7f;
                    Vector3 bottom = new Vector3(x, ground + k_PlayerBottomCenter, z);
                    Vector3 top = new Vector3(x, ground + k_PlayerTopCenter, z);
                    bool blocked = Physics.CheckCapsule(
                        bottom, top, k_PlayerRadius, ~0, QueryTriggerInteraction.Ignore);
                    report.Append(blocked ? '#' : '.');
                }

                report.AppendLine();
            }

            report.AppendLine();
            report.AppendLine("AUTHORED_ROUTE_FULL_CAPSULE_COLLISIONS step<=0.25m");
            Chapter00ZoneVegetationParams vegetation = Chapter00ZoneVegetationParams.CreateDefault();
            Dictionary<string, string> collisions = new Dictionary<string, string>();
            Dictionary<string, string> midLateCollisions = new Dictionary<string, string>();

            for (int routeIndex = 0; routeIndex < vegetation.Routes.Length; routeIndex++)
            {
                Vector2[] route = vegetation.Routes[routeIndex];
                for (int segment = 0; segment + 1 < route.Length; segment++)
                {
                    float length = Vector2.Distance(route[segment], route[segment + 1]);
                    int steps = Mathf.Max(1, Mathf.CeilToInt(length / k_RouteSampleStep));
                    for (int step = 0; step <= steps; step++)
                    {
                        Vector2 point = Vector2.Lerp(route[segment], route[segment + 1], step / (float)steps);
                        string sample = $"route{routeIndex}/segment{segment}/t{step}/{steps}";
                        CollectCapsuleCollisions(terrain, point, collisions, sample);
                        Chapter00VegetationZone zone =
                            Chapter00ZoneVegetationLayout.ClassifyZone(vegetation, point);
                        if (zone == Chapter00VegetationZone.C || zone == Chapter00VegetationZone.D
                            || zone == Chapter00VegetationZone.E)
                        {
                            CollectCapsuleCollisions(terrain, point, midLateCollisions, sample);
                        }
                    }
                }
            }

            for (int i = 0; i < vegetation.Checkpoints.Length; i++)
            {
                Vector2 point = vegetation.Checkpoints[i];
                string sample = $"checkpoint{i}";
                CollectCapsuleCollisions(terrain, point, collisions, sample);
                Chapter00VegetationZone zone = Chapter00ZoneVegetationLayout.ClassifyZone(vegetation, point);
                if (zone == Chapter00VegetationZone.C || zone == Chapter00VegetationZone.D
                    || zone == Chapter00VegetationZone.E)
                {
                    CollectCapsuleCollisions(terrain, point, midLateCollisions, sample);
                }
            }

            AppendCollisions(report, collisions);
            report.AppendLine();
            report.AppendLine("C_TO_E_FULL_CAPSULE_COLLISIONS");
            AppendCollisions(report, midLateCollisions);

            report.AppendLine();
            Transform corridor1 = Find(scene, "LabCorridor1");
            AppendENavigationFlood(report, terrain, vegetation,
                corridor1 != null ? BoundsOf(corridor1) : new Bounds());

            string folder = Path.GetDirectoryName(k_OutputPath);
            Directory.CreateDirectory(folder ?? "Logs/SpatialAudits");
            File.WriteAllText(k_OutputPath, report.ToString());
            Debug.Log($"Chapter00FacilitySpatialAudit: wrote {k_OutputPath}");
        }

        private static Transform Find(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (Transform transform in root.GetComponentsInChildren<Transform>(true))
                {
                    if (transform.name == name)
                    {
                        return transform;
                    }
                }
            }

            return null;
        }

        private static void CollectCapsuleCollisions(
            UnityEngine.Terrain terrain,
            Vector2 point,
            Dictionary<string, string> report,
            string sample)
        {
            float ground = terrain != null
                ? terrain.SampleHeight(new Vector3(point.x, 0f, point.y)) + terrain.transform.position.y
                : 7f;
            Vector3 bottom = new Vector3(point.x, ground + k_PlayerBottomCenter, point.y);
            Vector3 top = new Vector3(point.x, ground + k_PlayerTopCenter, point.y);
            Collider[] overlaps = Physics.OverlapCapsule(
                bottom, top, k_PlayerRadius, ~0, QueryTriggerInteraction.Ignore);

            foreach (Collider collider in overlaps)
            {
                if (collider is TerrainCollider) continue;
                string path = HierarchyPath(collider.transform);
                if (!report.ContainsKey(path))
                {
                    report[path] = $"{sample}|point=({point.x:F2},{point.y:F2})|collider={path}";
                }
            }
        }

        private static void AppendCollisions(StringBuilder report, Dictionary<string, string> collisions)
        {
            if (collisions.Count == 0)
            {
                report.AppendLine("none");
                return;
            }

            List<string> entries = new List<string>(collisions.Values);
            entries.Sort(StringComparer.Ordinal);
            foreach (string collision in entries) report.AppendLine(collision);
        }

        private static void AppendENavigationFlood(
            StringBuilder report,
            UnityEngine.Terrain terrain,
            Chapter00ZoneVegetationParams vegetation,
            Bounds corridor1Bounds)
        {
            const float step = .5f;
            const float minX = -55f;
            const float maxX = 55f;
            const float minZ = 57f;
            const float maxZ = 167f;
            int width = Mathf.RoundToInt((maxX - minX) / step) + 1;
            int height = Mathf.RoundToInt((maxZ - minZ) / step) + 1;
            bool[,] passable = new bool[width, height];
            bool[,] visited = new bool[width, height];

            for (int z = 0; z < height; z++)
            {
                for (int x = 0; x < width; x++)
                {
                    Vector2 point = new Vector2(minX + x * step, minZ + z * step);
                    passable[x, z] = Chapter00ZoneVegetationLayout.ClassifyZone(vegetation, point)
                        == Chapter00VegetationZone.E
                        && Chapter00ZoneVegetationLayout.IsInVisibleEnvelope(vegetation, point)
                        && IsWalkableCapsule(terrain, point);
                }
            }

            Vector2 startPoint = vegetation.Corridor1Route[0];
            int startX = Mathf.RoundToInt((startPoint.x - minX) / step);
            int startZ = Mathf.RoundToInt((startPoint.y - minZ) / step);
            Queue<Vector2Int> frontier = new Queue<Vector2Int>();
            if (startX >= 0 && startX < width && startZ >= 0 && startZ < height
                && passable[startX, startZ])
            {
                frontier.Enqueue(new Vector2Int(startX, startZ));
                visited[startX, startZ] = true;
            }

            int reachable = 0;
            int unexpected = 0;
            float maximumRouteDistance = 0f;
            bool corridorTargetReached = false;
            List<string> unexpectedExamples = new List<string>();
            Vector2 target = vegetation.Corridor1Route[vegetation.Corridor1Route.Length - 1];
            int[] dx = { -1, 1, 0, 0 };
            int[] dz = { 0, 0, -1, 1 };

            while (frontier.Count > 0)
            {
                Vector2Int cell = frontier.Dequeue();
                Vector2 point = new Vector2(minX + cell.x * step, minZ + cell.y * step);
                reachable++;
                float routeDistance = Chapter00ZoneVegetationLayout.DistanceToRoutes(
                    vegetation.Routes, point);
                maximumRouteDistance = Mathf.Max(maximumRouteDistance, routeDistance);
                if (Vector2.Distance(point, target) <= step * 1.5f) corridorTargetReached = true;

                bool inCorridor1Apron = corridor1Bounds.size.sqrMagnitude > .001f
                    && point.x >= corridor1Bounds.min.x - 4f
                    && point.x <= corridor1Bounds.max.x + 4f
                    && point.y >= corridor1Bounds.min.z - 4f
                    && point.y <= corridor1Bounds.max.z + 4f;
                if (point.y >= 82f && routeDistance > 6.5f && !inCorridor1Apron)
                {
                    unexpected++;
                    if (unexpectedExamples.Count < 8)
                    {
                        unexpectedExamples.Add($"({point.x:F1},{point.y:F1}) dRoute={routeDistance:F1}");
                    }
                }

                for (int direction = 0; direction < 4; direction++)
                {
                    int nextX = cell.x + dx[direction];
                    int nextZ = cell.y + dz[direction];
                    if (nextX < 0 || nextX >= width || nextZ < 0 || nextZ >= height
                        || visited[nextX, nextZ] || !passable[nextX, nextZ])
                    {
                        continue;
                    }

                    visited[nextX, nextZ] = true;
                    frontier.Enqueue(new Vector2Int(nextX, nextZ));
                }
            }

            report.AppendLine("E_NAVIGATION_FLOOD step=0.5m full-player-capsule four-neighbour");
            report.AppendLine($"start=({startPoint.x:F1},{startPoint.y:F1})"
                + $"|target=({target.x:F1},{target.y:F1})|targetReached={corridorTargetReached}"
                + $"|reachableCells={reachable}|maxDistanceToAuthoredRoutes={maximumRouteDistance:F2}m"
                + $"|unexpectedCellsBeyondRoutesOrCorridor1AfterZ82={unexpected}");
            if (unexpectedExamples.Count > 0)
            {
                report.AppendLine("unexpectedExamples=" + string.Join(", ", unexpectedExamples));
            }
        }

        private static bool IsWalkableCapsule(UnityEngine.Terrain terrain, Vector2 point)
        {
            float ground = terrain != null
                ? terrain.SampleHeight(new Vector3(point.x, 0f, point.y)) + terrain.transform.position.y
                : 7f;
            if (terrain != null)
            {
                Vector3 origin = terrain.transform.position;
                Vector3 size = terrain.terrainData.size;
                float u = Mathf.Clamp01((point.x - origin.x) / size.x);
                float v = Mathf.Clamp01((point.y - origin.z) / size.z);
                if (Vector3.Angle(terrain.terrainData.GetInterpolatedNormal(u, v), Vector3.up) > 45f)
                {
                    return false;
                }
            }

            Vector3 bottom = new Vector3(point.x, ground + k_PlayerBottomCenter, point.y);
            Vector3 top = new Vector3(point.x, ground + k_PlayerTopCenter, point.y);
            Collider[] overlaps = Physics.OverlapCapsule(
                bottom, top, k_PlayerRadius, ~0, QueryTriggerInteraction.Ignore);
            for (int i = 0; i < overlaps.Length; i++)
            {
                if (!(overlaps[i] is TerrainCollider)) return false;
            }
            return true;
        }

        private static string HierarchyPath(Transform leaf)
        {
            Stack<string> names = new Stack<string>();
            Transform current = leaf;
            while (current != null)
            {
                names.Push(current.name);
                current = current.parent;
            }
            return string.Join("/", names);
        }

        private static bool ContainsAny(string text, IEnumerable<string> tokens)
        {
            foreach (string token in tokens)
            {
                if (text.Contains(token))
                {
                    return true;
                }
            }

            return false;
        }

        private static Bounds BoundsOf(Transform root)
        {
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);

            if (renderers.Length == 0)
            {
                return new Bounds(root.position, Vector3.zero);
            }

            Bounds bounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                bounds.Encapsulate(renderers[i].bounds);
            }

            return bounds;
        }

        private static string PathOf(Transform root, Transform leaf)
        {
            Stack<string> names = new Stack<string>();
            Transform current = leaf;

            while (current != null)
            {
                names.Push(current.name);

                if (current == root)
                {
                    break;
                }

                current = current.parent;
            }

            return string.Join("/", names);
        }

        private static string Format(Vector3 value)
        {
            return $"({value.x:F3},{value.y:F3},{value.z:F3})";
        }

        private static string Format(Bounds value)
        {
            return $"center{Format(value.center)} size{Format(value.size)} min{Format(value.min)} max{Format(value.max)}";
        }
    }
}
