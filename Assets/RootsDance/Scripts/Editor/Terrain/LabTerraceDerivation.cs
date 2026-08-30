using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// Pure helper that turns the lab blockout's own (unrotated) bounds into the terrace rectangle the
    /// heightmap and splat generators cut into the terrain. The terrace follows the lab's oriented box,
    /// not its world AABB: a lab placed at a diagonal yaw would otherwise get a square terrace with
    /// empty corners.
    /// </summary>
    public static class LabTerraceDerivation
    {
        /// <summary>
        /// Derives the terrace half extents and yaw from the lab's local bounds and placement yaw.
        /// </summary>
        /// <param name="localBounds">The lab cluster's bounds in the lab instance's local space.</param>
        /// <param name="labYawDegrees">The Y rotation applied to the lab instance, as passed to
        /// <c>Quaternion.Euler(0, labYawDegrees, 0)</c>.</param>
        /// <param name="margin">Flat ground added on every side of the building, in metres.</param>
        /// <param name="halfExtents">Half extents of the terrace along its own X and Z axes.</param>
        /// <param name="terraceYawDegrees">Value for <see cref="TerrainGreyboxParams.TerraceYawDegrees"/>.</param>
        /// <remarks>
        /// <c>TerrainHeightmapGenerator.TerraceSignedDistance</c> maps world to terrace space with the
        /// inverse of <c>Quaternion.Euler(0, TerraceYawDegrees, 0)</c>, so the terrace's local +X axis is
        /// that rotation applied to world +X — the same convention the lab instance is rotated with.
        /// The two yaws are therefore equal; no sign flip.
        /// </remarks>
        public static void DeriveTerrace(
            Bounds localBounds, float labYawDegrees, float margin,
            out Vector2 halfExtents, out float terraceYawDegrees)
        {
            halfExtents = new Vector2(localBounds.extents.x + margin, localBounds.extents.z + margin);
            terraceYawDegrees = labYawDegrees;
        }

        /// <summary>
        /// The lab-local point the builder snaps onto the terrace centre and height: the footprint
        /// centre in X/Z, and the lowest point raised by <paramref name="floorOffset"/> in Y. A zero
        /// offset puts the model's lowest vertex on the terrace; a positive one sinks the model by that
        /// much so its main floor slab, rather than a stray low element (the portal door frames in the
        /// V2 export), meets the ground.
        /// </summary>
        /// <param name="localBounds">The lab cluster's bounds in the lab instance's local space.</param>
        /// <param name="floorOffset">Distance from the model's lowest point up to its main floor slab, in
        /// metres, measured on the imported (scaled) model.</param>
        public static Vector3 LabPivot(Bounds localBounds, float floorOffset)
        {
            return new Vector3(localBounds.center.x, localBounds.min.y + floorOffset, localBounds.center.z);
        }
    }
}
