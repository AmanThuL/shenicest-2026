using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>The shared player pose on the greenhouse observation deck.</summary>
    public static class GreenhouseObservationDeckSpawn
    {
        public static readonly Vector3 k_LocalPosition = new Vector3(-4.11f, 17.81f, 1.02f);
        public const float k_LocalYaw = 180f;

        /// <summary>Places an anchor in greenhouse level-local space.</summary>
        public static void ApplyTo(Transform anchor)
        {
            anchor.localPosition = k_LocalPosition;
            anchor.localRotation = Quaternion.Euler(0f, k_LocalYaw, 0f);
        }
    }
}
