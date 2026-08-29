using UnityEngine;

namespace RootsDance.Scanner
{
    /// <summary>
    /// The one piece of maths behind "make the screen fill the view with a margin all round",
    /// solved both ways round: move the viewer back until a fixed screen fits
    /// (<see cref="DistanceForFill"/>, what the archive documents do), or grow the screen until it
    /// fills a view from a fixed distance (<see cref="ScaleForFill"/>, what the scanner does now
    /// that reading no longer moves the camera). Pure and static so it can be unit tested without a
    /// camera, a canvas or a scene.
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

        /// <summary>
        /// How wide and tall the viewport is, in metres, at a given distance from the camera.
        /// </summary>
        /// <param name="distanceMeters">Distance in front of the camera.</param>
        /// <param name="verticalFovDegrees">The camera's vertical field of view.</param>
        /// <param name="aspect">Viewport width divided by height.</param>
        public static Vector2 ViewportSizeAt(float distanceMeters, float verticalFovDegrees,
            float aspect)
        {
            float safeAspect = Mathf.Max(aspect, 0.01f);
            float halfFov = Mathf.Clamp(verticalFovDegrees, 1f, 179f) * 0.5f * Mathf.Deg2Rad;
            float height = 2f * Mathf.Max(distanceMeters, 0f) * Mathf.Tan(halfFov);

            return new Vector2(height * safeAspect, height);
        }

        /// <summary>
        /// Uniform scale that makes a rectangle cover <paramref name="fill"/> of a viewport on the
        /// rectangle's tighter axis. The inverse of <see cref="DistanceForFill"/>: instead of
        /// standing back from a fixed screen, grow the screen inside a fixed view.
        /// </summary>
        /// <param name="size">Width and height of the rectangle, in any one unit.</param>
        /// <param name="viewportSize">Width and height of the viewport, from
        /// <see cref="ViewportSizeAt"/>, in metres.</param>
        /// <param name="fill">Fraction of the viewport the rectangle should cover, 0 to 1.</param>
        /// <returns>Metres per unit of <paramref name="size"/>, always positive.</returns>
        public static float ScaleForFill(Vector2 size, Vector2 viewportSize, float fill)
        {
            float safeFill = Mathf.Clamp(fill, 0.05f, 1f);
            float width = Mathf.Max(Mathf.Abs(size.x), 1e-6f);
            float height = Mathf.Max(Mathf.Abs(size.y), 1e-6f);

            // Whichever axis runs out first is the one that decides, so the rectangle never
            // overflows the view on either.
            float byWidth = Mathf.Abs(viewportSize.x) / width;
            float byHeight = Mathf.Abs(viewportSize.y) / height;

            return Mathf.Max(Mathf.Min(byWidth, byHeight) * safeFill, 1e-9f);
        }
    }
}
