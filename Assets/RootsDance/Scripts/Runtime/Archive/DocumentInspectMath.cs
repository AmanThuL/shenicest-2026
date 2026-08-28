using RootsDance.Scanner;
using UnityEngine;

namespace RootsDance.Archive
{
    /// <summary>
    /// The three sums behind holding a sheet of paper up to your face: how far away it has to be to
    /// fill the view, how the zoom moves between two such distances, and how far the player may
    /// turn it before it goes edge-on and becomes unreadable. Pure and static so the reading feel
    /// can be unit tested without a camera, a canvas or a scene.
    /// </summary>
    public static class DocumentInspectMath
    {
        /// <summary>
        /// Distance at which a sheet covers <paramref name="fill"/> of the viewport.
        /// </summary>
        /// <remarks>
        /// This is the scanner's framing sum — "how far back until this rectangle covers a given
        /// fraction of the view". <see cref="ScreenFraming"/> is a pure static with no scanner
        /// state in it, so it is reused here rather than the trigonometry being copied.
        /// </remarks>
        /// <param name="pageSizeMeters">Width and height of the sheet, in metres.</param>
        /// <param name="verticalFovDegrees">The reading camera's vertical field of view.</param>
        /// <param name="aspect">Viewport width divided by height.</param>
        /// <param name="fill">Fraction of the viewport the sheet should cover, 0 to 1.</param>
        public static float HoldDistance(Vector2 pageSizeMeters, float verticalFovDegrees,
            float aspect, float fill)
        {
            return ScreenFraming.DistanceForFill(pageSizeMeters, verticalFovDegrees, aspect, fill);
        }

        /// <summary>
        /// Moves the sheet along the view axis. Positive <paramref name="input"/> pulls it closer,
        /// which is a <em>smaller</em> distance — the two ends are handed over in either order and
        /// sorted here, because the near end comes from the larger fill and reads as a maximum.
        /// </summary>
        /// <param name="distance">Current distance from the eye, in metres.</param>
        /// <param name="input">Zoom axis, -1 to 1. Positive pulls the sheet closer.</param>
        /// <param name="metresPerSecond">Travel rate at full deflection.</param>
        /// <param name="deltaTime">Frame time in seconds.</param>
        /// <param name="distanceA">One end of the allowed travel, in metres.</param>
        /// <param name="distanceB">The other end.</param>
        public static float Zoom(float distance, float input, float metresPerSecond,
            float deltaTime, float distanceA, float distanceB)
        {
            float near = Mathf.Min(distanceA, distanceB);
            float far = Mathf.Max(distanceA, distanceB);
            float moved = distance - Mathf.Clamp(input, -1f, 1f) * metresPerSecond * deltaTime;

            return Mathf.Clamp(moved, near, far);
        }

        /// <summary>
        /// Turns the sheet under the mouse and clamps it. The clamp is what keeps the page readable:
        /// left free it would go edge-on and vanish, so the player may only tip it enough to catch
        /// the light and read the margin.
        /// </summary>
        /// <param name="current">Current tilt: x is pitch, y is yaw, both in degrees.</param>
        /// <param name="lookDelta">Pointer delta for this frame, in pixels.</param>
        /// <param name="degreesPerPixel">Turn rate.</param>
        /// <param name="maxPitchDegrees">Largest allowed tip away from the reader, either way.</param>
        /// <param name="maxYawDegrees">Largest allowed turn about the page's up axis, either way.</param>
        /// <returns>The new tilt, clamped. x is pitch, y is yaw.</returns>
        public static Vector2 Tilt(Vector2 current, Vector2 lookDelta, float degreesPerPixel,
            float maxPitchDegrees, float maxYawDegrees)
        {
            float pitchLimit = Mathf.Abs(maxPitchDegrees);
            float yawLimit = Mathf.Abs(maxYawDegrees);

            // Mouse up tips the top of the sheet away, which is a negative pitch about its X axis.
            float pitch = current.x - lookDelta.y * degreesPerPixel;
            float yaw = current.y + lookDelta.x * degreesPerPixel;

            return new Vector2(
                Mathf.Clamp(pitch, -pitchLimit, pitchLimit),
                Mathf.Clamp(yaw, -yawLimit, yawLimit));
        }
    }
}
