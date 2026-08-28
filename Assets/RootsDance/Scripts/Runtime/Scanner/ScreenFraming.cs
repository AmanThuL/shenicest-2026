using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// The one piece of camera maths behind "zoom in until the screen fills the view with a margin
    /// all round". Pure and static so it can be unit tested without a camera, a canvas or a scene.
    /// </summary>
    public static class ScreenFraming
    {
        /// <summary>
        /// Distance from a screen rectangle at which it covers <paramref name="fill"/> of the
        /// viewport on its tighter axis.
        /// </summary>
        /// <param name="sizeMeters">Width and height of the rectangle, in metres.</param>
        /// <param name="verticalFovDegrees">The camera's vertical field of view.</param>
        /// <param name="aspect">Viewport width divided by height.</param>
        /// <param name="fill">Fraction of the viewport the rectangle should cover, 0 to 1. At 1 the
        /// rectangle touches the viewport edge on its tighter axis and there is no margin left.</param>
        /// <returns>Distance in metres, always positive.</returns>
        public static float DistanceForFill(Vector2 sizeMeters, float verticalFovDegrees,
            float aspect, float fill)
        {
            float safeFill = Mathf.Clamp(fill, 0.05f, 1f);
            float safeAspect = Mathf.Max(aspect, 0.01f);
            float halfFov = Mathf.Clamp(verticalFovDegrees, 1f, 179f) * 0.5f * Mathf.Deg2Rad;
            float tanHalf = Mathf.Tan(halfFov);

            // Height and width each imply a distance; the larger one is the one that fits both.
            float byHeight = Mathf.Abs(sizeMeters.y) / (2f * safeFill * tanHalf);
            float byWidth = Mathf.Abs(sizeMeters.x) / (2f * safeFill * tanHalf * safeAspect);

            return Mathf.Max(Mathf.Max(byHeight, byWidth), 0.001f);
        }
    }
}
