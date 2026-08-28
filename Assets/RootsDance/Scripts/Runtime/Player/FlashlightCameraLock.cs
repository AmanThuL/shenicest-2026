using UnityEngine;

namespace RootsDance.Player
{
    /// <summary>
    /// Which cameras the flashlight snaps to before they render. Only the game camera: the Scene
    /// view, reflection probes and preview cameras render the same scene and must not drag the
    /// light away from the player's eye.
    /// </summary>
    public static class FlashlightCameraLock
    {
        public static bool ShouldFollow(CameraType cameraType)
        {
            return cameraType == CameraType.Game;
        }
    }
}
