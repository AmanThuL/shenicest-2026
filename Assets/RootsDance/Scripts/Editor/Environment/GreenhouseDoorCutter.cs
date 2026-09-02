using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Cuts a rectangular doorway into a Greenhouse glass wall panel and turns the removed piece
    /// into the two swing-door leaves, matching the geometry that L-W1's door was hand-authored
    /// with (a hole cut directly into the panel mesh, the cut-out split into a left/right leaf).
    /// <para>
    /// Each panel is a thin 3D shell (frame + pane, not a flat quad), tilted to whichever facet of
    /// the octagonal room it belongs to, so there's no fixed local axis to cut along. Instead the
    /// panel's own outward direction is estimated as the area-weighted average of its triangle
    /// normals — reliable for a mostly-flat shell — and used to build a 2D (right, up) basis to
    /// project every triangle into. A door-sized rectangle in that 2D space, centred horizontally
    /// and sitting on the panel's own bottom edge, is cut out with real polygon clipping
    /// (<see cref="ClipHalfPlane"/>, Sutherland-Hodgman per triangle) rather than sorting whole
    /// triangles by centroid — a centroid test leaves a jagged, torn boundary wherever a triangle
    /// straddles the door edge; clipping inserts a new vertex exactly on the line, so the cut edge
    /// is straight and each leaf reads as one flat piece of glass, not a faceted, folded-looking
    /// mess. Because the leaf meshes are literally sliced from the wall mesh, they're already in
    /// the wall's own local space — the new door root just needs the wall's exact local transform,
    /// no re-derived offset like L-W1's reused door prefab needed.
    /// </para>
    /// </summary>
    public static class GreenhouseDoorCutter
    {
        private const string k_MeshFolder = "Assets/RootsDance/Meshes/Environment/GreenhouseInterior/GlassRepair";
        private const string k_DoorMaterialPath =
            "Assets/RootsDance/Materials/Environment/GreenhouseInterior/GreenHouse1DoorGlass_LightGreen.mat";

        public static GameObject CutDoorwayAndBuildDoor(
            string wallObjectName, float doorWidth, float doorHeight, Vector3 roomCenterXZ)
        {
            GameObject wallGo = GameObject.Find(wallObjectName);

            if (wallGo == null)
            {
                throw new System.InvalidOperationException("Wall not found: " + wallObjectName);
            }

            // doorWidth/doorHeight arrive in world metres; mesh vertices are in the wall's own
            // local space, which this building's walls hold at a ~265x uniform scale — comparing
            // metres directly against local-space extents made every clamp below a no-op.
            float worldToLocal = 1f / Mathf.Max(0.0001f, wallGo.transform.lossyScale.x);
            float doorWidthLocal = doorWidth * worldToLocal;
            float doorHeightLocal = doorHeight * worldToLocal;

            MeshFilter wallFilter = wallGo.GetComponent<MeshFilter>();
            Mesh sourceMesh = wallFilter.sharedMesh;
            Vector3[] verts = sourceMesh.vertices;
            Vector3[] normalsSrc = sourceMesh.normals;
            Vector2[] uvsSrc = sourceMesh.uv;
            bool hasNormals = normalsSrc != null && normalsSrc.Length == verts.Length;
            bool hasUvs = uvsSrc != null && uvsSrc.Length == verts.Length;

            Vector3 panelNormal = ComputeAverageFaceNormal(sourceMesh);
            Vector3 up = Vector3.up - Vector3.Dot(Vector3.up, panelNormal) * panelNormal;

            if (up.sqrMagnitude < 0.01f)
            {
                up = Vector3.forward - Vector3.Dot(Vector3.forward, panelNormal) * panelNormal;
            }

            up.Normalize();
            Vector3 right = Vector3.Cross(up, panelNormal).normalized;

            Vector3 centroid = Vector3.zero;
            foreach (Vector3 v in verts) { centroid += v; }
            centroid /= verts.Length;

            float uMin = float.MaxValue, uMax = float.MinValue, vMin = float.MaxValue, vMax = float.MinValue;

            foreach (Vector3 v in verts)
            {
                Vector3 d = v - centroid;
                float u = Vector3.Dot(d, right);
                float vv = Vector3.Dot(d, up);
                uMin = Mathf.Min(uMin, u);
                uMax = Mathf.Max(uMax, u);
                vMin = Mathf.Min(vMin, vv);
                vMax = Mathf.Max(vMax, vv);
            }

            float doorVMax = Mathf.Min(vMin + doorHeightLocal, vMax);

            // Centre the door on the widest *contiguous* span of actual glass at door height, not
            // the panel's overall bounding box — some panels (L-W3) have a real gap or mullion
            // partway up from the bottom, so the naive bbox midpoint lands squarely in empty space,
            // leaving one leaf a sliver or nothing at all. Scan a horizontal line at door-mid-height
            // and keep only the widest run actually covered by a source triangle.
            float doorUMin, doorUMax;
            FindWidestSpanAtHeight(
                verts, sourceMesh, centroid, right, up, vMin + (doorVMax - vMin) * 0.5f, uMin, uMax,
                out float spanUMin, out float spanUMax);
            float uMid = (spanUMin + spanUMax) * 0.5f;
            float halfWidth = Mathf.Min(doorWidthLocal, (spanUMax - spanUMin) * 0.85f) * 0.5f;
            doorUMin = uMid - halfWidth;
            doorUMax = uMid + halfWidth;

            // Per-submesh output: each is a flat (position,normal,uv) triangle soup built by
            // clipping every source triangle against the door rectangle's edges — never assigning
            // a whole triangle to one side by its centroid, which is what tore the leaf geometry
            // apart into a jagged, faceted mess instead of one flat clean piece.
            int subMeshCount = sourceMesh.subMeshCount;
            List<List<PolyVertex>> wallSubTris = new List<List<PolyVertex>>();
            for (int sub = 0; sub < subMeshCount; sub++) { wallSubTris.Add(new List<PolyVertex>()); }
            List<PolyVertex> leftTris = new List<PolyVertex>();
            List<PolyVertex> rightTris = new List<PolyVertex>();

            System.Func<Vector3, float> uOf = p => Vector3.Dot(p - centroid, right);
            System.Func<Vector3, float> vOf = p => Vector3.Dot(p - centroid, up);

            for (int sub = 0; sub < subMeshCount; sub++)
            {
                int[] subTris = sourceMesh.GetTriangles(sub);

                for (int i = 0; i < subTris.Length; i += 3)
                {
                    PolyVertex a = MakeVertex(subTris[i], verts, normalsSrc, uvsSrc, hasNormals, hasUvs);
                    PolyVertex b = MakeVertex(subTris[i + 1], verts, normalsSrc, uvsSrc, hasNormals, hasUvs);
                    PolyVertex c = MakeVertex(subTris[i + 2], verts, normalsSrc, uvsSrc, hasNormals, hasUvs);
                    List<PolyVertex> tri = new List<PolyVertex> { a, b, c };

                    // Door rectangle = triangle ∩ (u>=doorUMin) ∩ (u<=doorUMax) ∩ (v<=doorVMax);
                    // v>=doorVMin is automatic since the panel's own bottom edge IS doorVMin.
                    List<PolyVertex> doorPoly = ClipHalfPlane(tri, p => doorUMin - uOf(p));
                    doorPoly = ClipHalfPlane(doorPoly, p => uOf(p) - doorUMax);
                    doorPoly = ClipHalfPlane(doorPoly, p => vOf(p) - doorVMax);
                    AppendFan(ClipHalfPlane(doorPoly, p => uOf(p) - uMid), leftTris);
                    AppendFan(ClipHalfPlane(doorPoly, p => uMid - uOf(p)), rightTris);

                    // Wall remainder = the 3 disjoint strips outside the door rectangle (no bottom
                    // strip needed — the door already sits flush with the panel's own bottom edge).
                    AppendFan(ClipHalfPlane(tri, p => uOf(p) - doorUMin), wallSubTris[sub]); // left of door
                    AppendFan(ClipHalfPlane(tri, p => doorUMax - uOf(p)), wallSubTris[sub]); // right of door
                    List<PolyVertex> topStrip = ClipHalfPlane(tri, p => doorUMin - uOf(p));
                    topStrip = ClipHalfPlane(topStrip, p => uOf(p) - doorUMax);
                    topStrip = ClipHalfPlane(topStrip, p => doorVMax - vOf(p));
                    AppendFan(topStrip, wallSubTris[sub]);
                }
            }

            if (leftTris.Count == 0 || rightTris.Count == 0)
            {
                throw new System.InvalidOperationException(
                    "Door rectangle for " + wallObjectName + " missed the panel geometry (left="
                    + leftTris.Count + " right=" + rightTris.Count + " verts) — panel too small or door misaligned.");
            }

            string shortName = wallObjectName.Replace("-GLASS", "");
            EnsureFolder(k_MeshFolder);

            Mesh cutWallMesh = BuildMeshFromTriSoup(wallSubTris, hasNormals, hasUvs);
            cutWallMesh.name = shortName + "-GLASS";
            SaveMeshAsset(cutWallMesh, k_MeshFolder + "/" + shortName + "-GLASS.asset");

            Mesh leftLeafMesh = BuildMeshFromTriSoup(new List<List<PolyVertex>> { leftTris }, hasNormals, hasUvs);
            leftLeafMesh.name = shortName + "-DoorLeaf-Left";
            SaveMeshAsset(leftLeafMesh, k_MeshFolder + "/" + shortName + "-DoorLeaf-Left.asset");

            Mesh rightLeafMesh = BuildMeshFromTriSoup(new List<List<PolyVertex>> { rightTris }, hasNormals, hasUvs);
            rightLeafMesh.name = shortName + "-DoorLeaf-Right";
            SaveMeshAsset(rightLeafMesh, k_MeshFolder + "/" + shortName + "-DoorLeaf-Right.asset");

            wallFilter.sharedMesh = cutWallMesh;
            MeshCollider wallCollider = wallGo.GetComponent<MeshCollider>();

            if (wallCollider != null)
            {
                wallCollider.sharedMesh = cutWallMesh;
            }

            Material doorMaterial = AssetDatabase.LoadAssetAtPath<Material>(k_DoorMaterialPath);
            Material wallMaterial = wallGo.GetComponent<MeshRenderer>().sharedMaterial;

            GameObject doorRoot = new GameObject(shortName + "-Door");
            doorRoot.transform.SetParent(wallGo.transform.parent, false);
            doorRoot.transform.SetLocalPositionAndRotation(
                wallGo.transform.localPosition, wallGo.transform.localRotation);
            doorRoot.transform.localScale = wallGo.transform.localScale;

            // Must match L-W1-Door's layer: the player's trigger probe (PlayerTriggerProbe, on its
            // own PlayerProbe layer) only collides with TriggerVolume in the physics matrix — left
            // on Default, the door's trigger silently never fires.
            int triggerVolumeLayer = LayerMask.NameToLayer("TriggerVolume");

            if (triggerVolumeLayer >= 0)
            {
                doorRoot.layer = triggerVolumeLayer;
            }

            CreateLeafChild(doorRoot.transform, "DoorLeaf_Left", leftLeafMesh, doorMaterial ?? wallMaterial);
            CreateLeafChild(doorRoot.transform, "DoorLeaf_Right", rightLeafMesh, doorMaterial ?? wallMaterial);

            // All of these margins are metres too — same local-space conversion as the door size.
            float approachWidth = doorWidthLocal + 2f * worldToLocal;
            float approachHeight = doorHeightLocal + 1.5f * worldToLocal;
            float approachDepth = 5f * worldToLocal;
            Vector3 doorLocalCenter = centroid + right * uMid + up * ((vMin + doorVMax) * 0.5f);
            BoxCollider trigger = doorRoot.AddComponent<BoxCollider>();
            trigger.isTrigger = true;

            // BoxCollider.size must be axis-aligned in local space; approximate the (right/up/normal)
            // approach volume by summing each local axis's projected contribution.
            float sizeX = Mathf.Abs(right.x) * approachWidth + Mathf.Abs(up.x) * approachHeight + Mathf.Abs(panelNormal.x) * approachDepth;
            float sizeY = Mathf.Abs(right.y) * approachWidth + Mathf.Abs(up.y) * approachHeight + Mathf.Abs(panelNormal.y) * approachDepth;
            float sizeZ = Mathf.Abs(right.z) * approachWidth + Mathf.Abs(up.z) * approachHeight + Mathf.Abs(panelNormal.z) * approachDepth;
            trigger.center = doorLocalCenter;
            trigger.size = new Vector3(sizeX, sizeY, sizeZ);

            EditorUtility.SetDirty(wallGo);
            EditorUtility.SetDirty(doorRoot);

            // ComputeAverageFaceNormal only picks a face direction from winding order — it doesn't
            // know which side the room is on — so confirm it actually points away from room centre
            // (using the panel's own world position as the reference point) and flip it if not.
            Vector3 outwardNormalWorld = wallGo.transform.TransformDirection(panelNormal).normalized;
            Vector3 panelWorldPos = wallGo.transform.TransformPoint(centroid);
            Vector3 towardRoomCenter = new Vector3(roomCenterXZ.x - panelWorldPos.x, 0f, roomCenterXZ.z - panelWorldPos.z);

            if (Vector3.Dot(outwardNormalWorld, towardRoomCenter) > 0f)
            {
                outwardNormalWorld = -outwardNormalWorld;
            }

            Vector3 wallAxisWorld = wallGo.transform.TransformDirection(right).normalized;
            GreenhouseSwingDoorBuilder.ConvertDoorToSwing(doorRoot, roomCenterXZ, outwardNormalWorld, wallAxisWorld);

            return doorRoot;
        }

        private static void CreateLeafChild(Transform parent, string name, Mesh mesh, Material material)
        {
            GameObject leaf = new GameObject(name);
            leaf.transform.SetParent(parent, false);
            MeshFilter filter = leaf.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;
            MeshRenderer renderer = leaf.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
        }

        /// <summary>Scans a horizontal line at <paramref name="vTest"/> across the panel's full
        /// u-range, testing actual triangle coverage (not vertex bounds) at each sample, and
        /// returns the widest contiguous covered run — the real usable width at that height, gaps
        /// and mullions excluded.</summary>
        private static void FindWidestSpanAtHeight(
            Vector3[] verts, Mesh mesh, Vector3 centroid, Vector3 right, Vector3 up, float vTest,
            float uMin, float uMax, out float spanUMin, out float spanUMax)
        {
            const int k_Samples = 200;
            bool[] covered = new bool[k_Samples];
            int[] triangles = mesh.triangles;
            float[] uVals = new float[verts.Length];
            float[] vVals = new float[verts.Length];

            for (int i = 0; i < verts.Length; i++)
            {
                Vector3 d = verts[i] - centroid;
                uVals[i] = Vector3.Dot(d, right);
                vVals[i] = Vector3.Dot(d, up);
            }

            for (int s = 0; s < k_Samples; s++)
            {
                float u = uMin + (uMax - uMin) * (s + 0.5f) / k_Samples;

                for (int t = 0; t < triangles.Length; t += 3)
                {
                    int ia = triangles[t], ib = triangles[t + 1], ic = triangles[t + 2];

                    if (PointInTriangle2D(
                        u, vTest, uVals[ia], vVals[ia], uVals[ib], vVals[ib], uVals[ic], vVals[ic]))
                    {
                        covered[s] = true;
                        break;
                    }
                }
            }

            int bestStart = -1, bestLen = 0, curStart = -1, curLen = 0;

            for (int s = 0; s < k_Samples; s++)
            {
                if (covered[s])
                {
                    if (curStart < 0) { curStart = s; }
                    curLen++;
                    if (curLen > bestLen) { bestLen = curLen; bestStart = curStart; }
                }
                else
                {
                    curStart = -1;
                    curLen = 0;
                }
            }

            if (bestStart < 0)
            {
                spanUMin = uMin;
                spanUMax = uMax;
                return;
            }

            spanUMin = uMin + (uMax - uMin) * bestStart / k_Samples;
            spanUMax = uMin + (uMax - uMin) * (bestStart + bestLen) / k_Samples;
        }

        private static bool PointInTriangle2D(
            float px, float py, float ax, float ay, float bx, float by, float cx, float cy)
        {
            float d1 = Sign2D(px, py, ax, ay, bx, by);
            float d2 = Sign2D(px, py, bx, by, cx, cy);
            float d3 = Sign2D(px, py, cx, cy, ax, ay);
            bool hasNeg = d1 < 0f || d2 < 0f || d3 < 0f;
            bool hasPos = d1 > 0f || d2 > 0f || d3 > 0f;
            return !(hasNeg && hasPos);
        }

        private static float Sign2D(float px, float py, float ax, float ay, float bx, float by)
        {
            return (px - bx) * (ay - by) - (ax - bx) * (py - by);
        }

        private static Vector3 ComputeAverageFaceNormal(Mesh mesh)
        {
            Vector3[] verts = mesh.vertices;
            int[] tris = mesh.triangles;
            Vector3 sum = Vector3.zero;

            for (int i = 0; i < tris.Length; i += 3)
            {
                Vector3 a = verts[tris[i]], b = verts[tris[i + 1]], c = verts[tris[i + 2]];
                sum += Vector3.Cross(b - a, c - a);
            }

            return sum.normalized;
        }

        /// <summary>One polygon-clip vertex: interpolated position/normal/uv, no index — clipping
        /// creates new vertices at cut edges that don't exist in the source mesh.</summary>
        private struct PolyVertex
        {
            public Vector3 Position;
            public Vector3 Normal;
            public Vector2 Uv;
        }

        private static PolyVertex MakeVertex(
            int index, Vector3[] verts, Vector3[] normalsSrc, Vector2[] uvsSrc, bool hasNormals, bool hasUvs)
        {
            return new PolyVertex
            {
                Position = verts[index],
                Normal = hasNormals ? normalsSrc[index] : Vector3.up,
                Uv = hasUvs ? uvsSrc[index] : Vector2.zero,
            };
        }

        /// <summary>Sutherland-Hodgman clip of a convex polygon against one half-plane. Keeps the
        /// region where <paramref name="signedDistance"/> is &lt;= 0, inserting a new interpolated
        /// vertex on every edge that crosses the plane — this is what gives the cut a straight edge
        /// instead of the jagged, whole-triangle-at-a-time boundary the old centroid test left.</summary>
        private static List<PolyVertex> ClipHalfPlane(List<PolyVertex> poly, System.Func<Vector3, float> signedDistance)
        {
            if (poly.Count == 0) { return poly; }

            List<PolyVertex> out_ = new List<PolyVertex>(poly.Count + 1);

            for (int i = 0; i < poly.Count; i++)
            {
                PolyVertex curr = poly[i];
                PolyVertex next = poly[(i + 1) % poly.Count];
                float dCurr = signedDistance(curr.Position);
                float dNext = signedDistance(next.Position);
                bool currIn = dCurr <= 0f;
                bool nextIn = dNext <= 0f;

                if (currIn) { out_.Add(curr); }

                if (currIn != nextIn)
                {
                    float t = dCurr / (dCurr - dNext);
                    out_.Add(new PolyVertex
                    {
                        Position = Vector3.Lerp(curr.Position, next.Position, t),
                        Normal = Vector3.Lerp(curr.Normal, next.Normal, t).normalized,
                        Uv = Vector2.Lerp(curr.Uv, next.Uv, t),
                    });
                }
            }

            return out_;
        }

        /// <summary>Fan-triangulates a convex polygon (the only shape ClipHalfPlane can produce
        /// from a triangle) and appends the resulting triangles' vertices to <paramref name="dest"/>.</summary>
        private static void AppendFan(List<PolyVertex> poly, List<PolyVertex> dest)
        {
            for (int i = 1; i + 1 < poly.Count; i++)
            {
                dest.Add(poly[0]);
                dest.Add(poly[i]);
                dest.Add(poly[i + 1]);
            }
        }

        /// <summary>Builds a mesh from flat (position,normal,uv) triangle soups, one list per
        /// submesh — no shared-vertex remap, since clip-generated vertices rarely land on exactly
        /// the same float values across triangles anyway.</summary>
        private static Mesh BuildMeshFromTriSoup(List<List<PolyVertex>> subMeshTris, bool hasNormals, bool hasUvs)
        {
            List<Vector3> newVerts = new List<Vector3>();
            List<Vector3> newNormals = hasNormals ? new List<Vector3>() : null;
            List<Vector2> newUvs = hasUvs ? new List<Vector2>() : null;
            List<List<int>> newSubTris = new List<List<int>>();

            foreach (List<PolyVertex> subTris in subMeshTris)
            {
                List<int> indices = new List<int>(subTris.Count);

                foreach (PolyVertex v in subTris)
                {
                    indices.Add(newVerts.Count);
                    newVerts.Add(v.Position);
                    if (hasNormals) { newNormals.Add(v.Normal); }
                    if (hasUvs) { newUvs.Add(v.Uv); }
                }

                newSubTris.Add(indices);
            }

            Mesh result = new Mesh();
            result.indexFormat = UnityEngine.Rendering.IndexFormat.UInt32;
            result.SetVertices(newVerts);
            if (hasNormals) { result.SetNormals(newNormals); }
            if (hasUvs) { result.SetUVs(0, newUvs); }
            result.subMeshCount = newSubTris.Count;

            for (int sub = 0; sub < newSubTris.Count; sub++)
            {
                result.SetTriangles(newSubTris[sub], sub);
            }

            if (!hasNormals) { result.RecalculateNormals(); }
            result.RecalculateBounds();
            return result;
        }

        private static void SaveMeshAsset(Mesh mesh, string path)
        {
            AssetDatabase.CreateAsset(mesh, path);
        }

        private static void EnsureFolder(string path)
        {
            if (AssetDatabase.IsValidFolder(path))
            {
                return;
            }

            string parent = Path.GetDirectoryName(path)?.Replace('\\', '/');

            if (!string.IsNullOrEmpty(parent) && !AssetDatabase.IsValidFolder(parent))
            {
                EnsureFolder(parent);
            }

            string folderParent = Path.GetDirectoryName(path)?.Replace('\\', '/');
            string folderName = Path.GetFileName(path);
            AssetDatabase.CreateFolder(folderParent, folderName);
        }
    }
}
