using System;
using UnityEngine;

namespace RootsDance.Editor.Terrain
{
    /// <summary>
    /// One hand-authored prop: prefab key, world transform, and whether Y is dropped onto the terrain.
    /// </summary>
    [Serializable]
    public class PropPlacement
    {
        /// <summary>Name of the <c>_Props</c> child the prop is parented to.</summary>
        public string Group = "Terrace";

        /// <summary>
        /// Prefab key (== prefab file name), resolved through <c>EnvironmentPrefabBuilder.PrefabPath</c>.
        /// </summary>
        public string Key;

        /// <summary>Authored world position; Y is only used when <see cref="DropToGround"/> is false.</summary>
        public Vector3 Position;

        /// <summary>Yaw around +Y, in degrees.</summary>
        public float YawDegrees;

        /// <summary>Multiplier applied on top of the prefab root's own uniform scale.</summary>
        public float Scale = 1f;

        /// <summary>
        /// True: Y = terrain height at XZ + <see cref="HeightOffset"/>; false: keep <see cref="Position"/>.y.
        /// </summary>
        public bool DropToGround = true;

        /// <summary>Metres added to the sampled terrain height; negative sinks the prop into the ground.</summary>
        public float HeightOffset;

        /// <summary>Parameterless constructor for Unity's serializer and the Inspector's "add element".</summary>
        public PropPlacement()
        {
        }

        /// <summary>Creates a prop that is dropped onto the terrain surface.</summary>
        /// <param name="group">Name of the <c>_Props</c> child it is parented to.</param>
        /// <param name="key">Prefab key.</param>
        /// <param name="position">World position; Y is replaced by the terrain height.</param>
        /// <param name="yawDegrees">Yaw around +Y, in degrees.</param>
        public PropPlacement(string group, string key, Vector3 position, float yawDegrees)
            : this(group, key, position, yawDegrees, 1f, true)
        {
        }

        /// <summary>Creates a prop with an explicit scale and ground behaviour.</summary>
        /// <param name="group">Name of the <c>_Props</c> child it is parented to.</param>
        /// <param name="key">Prefab key.</param>
        /// <param name="position">World position.</param>
        /// <param name="yawDegrees">Yaw around +Y, in degrees.</param>
        /// <param name="scale">Multiplier on top of the prefab root's own scale.</param>
        /// <param name="dropToGround">False keeps <paramref name="position"/>.y (wall-mounted props).</param>
        public PropPlacement(string group, string key, Vector3 position, float yawDegrees, float scale,
            bool dropToGround)
        {
            Group = group;
            Key = key;
            Position = position;
            YawDegrees = yawDegrees;
            Scale = scale;
            DropToGround = dropToGround;
        }
    }
}
