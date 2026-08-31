using System.Collections.Generic;
using RootsDance.Environment;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Converts a Greenhouse door built from centre-pivoted "DoorLeaf_*" meshes (the old
    /// <see cref="AutomaticSlidingDoor"/> sliding-leaf layout) into a pair of hinged leaves
    /// driven by <see cref="SwingingDoor"/>.
    /// <para>
    /// The leaf meshes were authored with their pivot at a shared FBX-wide origin, not at the
    /// hinge edge, so rotating a leaf's own transform swings it around that distant origin, not
    /// the doorway. Its extreme mesh vertex along the relevant search direction *is* the hinge
    /// edge (the door's outer edge sits at the wall opening's perimeter, farther out than any
    /// other point on the leaf) — that locates a new hinge pivot positioned exactly there, with
    /// the leaf reparented under it (preserving its visual position) as a passive child.
    /// <see cref="SwingingDoor"/> rotates the two hinges directly, so everything under each one
    /// swings around its own pivot rather than the leaf's original off-site one. Which hinge goes
    /// into the left slot (always opens to <c>-openAngle</c>) versus the right slot (always
    /// <c>+openAngle</c>) is picked per-leaf: whichever sign moves that leaf's own mesh centroid
    /// further along the outward reference direction (see the two-argument
    /// <see cref="ConvertDoorToSwing(GameObject, Vector3, Vector3?, Vector3?)"/> overload for what
    /// "outward" and "extreme vertex" mean when a caller supplies the wall's own geometry).
    /// </para>
    /// </summary>
    public static class GreenhouseSwingDoorBuilder
    {
        [MenuItem("RootsDance/Environment/Convert Selected Greenhouse Door To Swing")]
        public static void ConvertSelectedFromMenu()
        {
            GameObject selected = Selection.activeGameObject;

            if (selected == null)
            {
                Debug.LogError("[GreenhouseSwingDoorBuilder] Select a door root (e.g. L-W1-Door) first.");
                return;
            }

            ConvertDoorToSwing(selected, GetGreenhouseRoomCenterXZ());
        }

        public static Vector3 GetGreenhouseRoomCenterXZ()
        {
            return new Vector3(1.79f, 0f, 0f);
        }

        /// <summary>
        /// Replaces both "DoorLeaf_*" children of <paramref name="doorRoot"/> with hinge pivots and
        /// wires them into a single <see cref="SwingingDoor"/> on the root, removing the old
        /// <see cref="AutomaticSlidingDoor"/> and reusing its trigger collider's bounds.
        /// </summary>
        public static void ConvertDoorToSwing(GameObject doorRoot, Vector3 roomCenterXZ)
        {
            ConvertDoorToSwing(doorRoot, roomCenterXZ, null, null);
        }

        /// <summary>
        /// Same as <see cref="ConvertDoorToSwing(GameObject, Vector3)"/>, but the caller supplies
        /// two extra world-space directions computed from the wall panel's own geometry (which a
        /// door root built from L-W1's manually-placed reused prefab never had, but every panel
        /// <c>GreenhouseDoorCutter</c> slices a door out of does):
        /// <para>
        /// <paramref name="outwardNormal"/> — the panel's own outward face normal, used as the
        /// swing-direction reference instead of "away from the room centre": two hinges only ~1-2m
        /// apart on the same ~13m-distant wall have nearly identical room-centre-relative outward
        /// vectors, too coarse to reliably tell which leaf needs which rotation sign.
        /// </para>
        /// <para>
        /// <paramref name="wallAxisWorld"/> — the wall's own left-right axis (<c>right</c> in
        /// <c>GreenhouseDoorCutter</c>). On a wall running roughly *perpendicular* to the
        /// room-centre direction, "farthest vertex from room centre" — fine for locating a hinge
        /// when the wall's length runs roughly toward/away from the room centre — can instead land
        /// near the shared mullion between the two leaves rather than each leaf's true outer edge,
        /// because the room-centre distance barely changes along that wall's length. Searching
        /// along the wall's own axis instead (first leaf load-bearing at -axis, second at +axis —
        /// matching the Left-then-Right child order every door here is built in) finds the real
        /// edges regardless of how the wall happens to sit relative to the room centre.
        /// </para>
        /// </summary>
        public static void ConvertDoorToSwing(
            GameObject doorRoot, Vector3 roomCenterXZ, Vector3? outwardNormal, Vector3? wallAxisWorld)
        {
            AutomaticSlidingDoor oldDoor = doorRoot.GetComponent<AutomaticSlidingDoor>();

            if (oldDoor != null)
            {
                Object.DestroyImmediate(oldDoor);
            }

            BoxCollider oldTrigger = doorRoot.GetComponent<BoxCollider>();
            Vector3 triggerLocalCenter = Vector3.zero;
            Vector3 triggerLocalSize = Vector3.one * 3f;

            if (oldTrigger != null)
            {
                triggerLocalCenter = oldTrigger.center;
                triggerLocalSize = oldTrigger.size;
                Object.DestroyImmediate(oldTrigger);
            }

            int leafCount = doorRoot.transform.childCount;
            Transform[] leaves = new Transform[leafCount];

            for (int i = 0; i < leafCount; i++)
            {
                leaves[i] = doorRoot.transform.GetChild(i);
            }

            Transform negativeHinge = null;
            Transform positiveHinge = null;
            int leafIndex = 0;

            foreach (Transform leaf in leaves)
            {
                if (!leaf.name.StartsWith("DoorLeaf"))
                {
                    continue;
                }

                // First leaf's true edge is toward -wallAxis, second's toward +wallAxis — see the
                // wallAxisWorld doc above. Null when the caller didn't supply one (e.g. L-W1's own
                // manual conversion), which falls back to the room-centre-distance search.
                Vector3? hingeSearchAxis = wallAxisWorld.HasValue
                    ? (Vector3?)(wallAxisWorld.Value * (leafIndex == 0 ? -1f : 1f))
                    : null;
                leafIndex++;

                Transform hinge = BuildHinge(
                    doorRoot.transform, leaf, roomCenterXZ, outwardNormal, hingeSearchAxis, out float sign);

                if (sign < 0f)
                {
                    negativeHinge = hinge;
                }
                else
                {
                    positiveHinge = hinge;
                }
            }

            BoxCollider trigger = doorRoot.AddComponent<BoxCollider>();
            trigger.isTrigger = true;
            trigger.center = triggerLocalCenter;
            trigger.size = triggerLocalSize;

            SwingingDoor swing = doorRoot.AddComponent<SwingingDoor>();
            swing.Configure(negativeHinge, positiveHinge, 100f, 120f);

            EditorUtility.SetDirty(doorRoot);
        }

        private static Transform BuildHinge(
            Transform doorRoot, Transform leaf, Vector3 roomCenterXZ, Vector3? outwardNormal,
            Vector3? hingeSearchAxis, out float outwardSign)
        {
            Mesh mesh = leaf.GetComponent<MeshFilter>().sharedMesh;
            Vector3[] vertices = mesh.vertices;
            Vector3 hingeWorld = Vector3.zero;
            Vector3 centroidWorld = Vector3.zero;
            float maxDistance = float.NegativeInfinity;

            foreach (Vector3 vertex in vertices)
            {
                Vector3 world = leaf.TransformPoint(vertex);
                centroidWorld += world;

                // hingeSearchAxis (when supplied): find this leaf's extreme point along its own
                // true-edge direction. Otherwise fall back to farthest-from-room-centre, which is
                // fine when the wall's own length runs roughly toward/away from the room.
                float distance = hingeSearchAxis.HasValue
                    ? Vector3.Dot(world, hingeSearchAxis.Value)
                    : Vector2.Distance(new Vector2(world.x, world.z), new Vector2(roomCenterXZ.x, roomCenterXZ.z));

                if (distance > maxDistance)
                {
                    maxDistance = distance;
                    hingeWorld = world;
                }
            }

            // The sign test rotates this point and checks whether it ends up farther from the
            // room centre — using the leaf's own mesh *centroid* (the bulk of the material) rather
            // than a single nearest-vertex is far less sensitive to one odd vertex on a small,
            // mullion-bounded leaf, where a single-vertex test occasionally agreed with the other
            // leaf's and silently dropped one hinge from SwingingDoor's left/right slots.
            centroidWorld /= vertices.Length;

            float pivotHeight = leaf.GetComponent<MeshRenderer>().bounds.center.y;
            Vector3 hingePosition = new Vector3(hingeWorld.x, pivotHeight, hingeWorld.z);

            // The hinge is what actually rotates — its own position becomes the pivot every
            // descendant swings around, which the leaf's original (off-site) pivot could never be.
            GameObject hinge = new GameObject(leaf.name + "_Hinge");
            hinge.transform.SetParent(doorRoot, false);
            hinge.transform.SetPositionAndRotation(hingePosition, Quaternion.identity);
            leaf.SetParent(hinge.transform, true);

            // The old sliding-door leaves were purely decorative (no collider at all — the sliding
            // script only ever gated a trigger, never physically blocked anyone). A swing leaf needs
            // to actually block the doorway while closed and clear it while open, so it gets a solid
            // MeshCollider matching its own geometry, which rotates with it for free since it's a
            // sibling component on the same leaf transform.
            if (leaf.GetComponent<Collider>() == null)
            {
                MeshCollider leafCollider = leaf.gameObject.AddComponent<MeshCollider>();
                leafCollider.sharedMesh = mesh;
                leafCollider.convex = false;
            }

            outwardSign = PickOutwardSign(hinge.transform, centroidWorld, roomCenterXZ, outwardNormal);
            return hinge.transform;
        }

        /// <summary>Tests both rotation signs and returns whichever moves the probe point further
        /// outward. Prefers the wall panel's own normal as the outward reference when supplied —
        /// reliable per-leaf even for two hinges close together — falling back to "away from the
        /// room centre" (fine when there's only one leaf's hinge position to reference by).</summary>
        private static float PickOutwardSign(
            Transform hinge, Vector3 probeWorld, Vector3 roomCenterXZ, Vector3? outwardNormal)
        {
            const float k_ProbeAngle = 80f;
            Vector3 outward = outwardNormal.HasValue
                ? outwardNormal.Value
                : new Vector3(hinge.position.x - roomCenterXZ.x, 0f, hinge.position.z - roomCenterXZ.z).normalized;
            Vector3 latchLocal = hinge.InverseTransformPoint(probeWorld);

            Vector3 plusWorld = hinge.TransformPoint(Quaternion.Euler(0f, k_ProbeAngle, 0f) * latchLocal);
            Vector3 minusWorld = hinge.TransformPoint(Quaternion.Euler(0f, -k_ProbeAngle, 0f) * latchLocal);

            float plusScore = Vector3.Dot(
                new Vector3(plusWorld.x - probeWorld.x, 0f, plusWorld.z - probeWorld.z), outward);
            float minusScore = Vector3.Dot(
                new Vector3(minusWorld.x - probeWorld.x, 0f, minusWorld.z - probeWorld.z), outward);

            return plusScore >= minusScore ? 1f : -1f;
        }
    }
}
