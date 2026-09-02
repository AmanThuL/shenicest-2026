using UnityEngine;

namespace RootsDance.Rendering
{
    /// <summary>
    /// One shared switch for "the player is reading something held up to the eye" — an archive
    /// sheet, the photograph, the keypad, the scanner's report. The PSX treatment exists to coarsen
    /// the world; on a page of text it just destroys legibility, so it stands down while any
    /// close-up is up.
    /// <para>
    /// Declared per frame rather than begin/end pairs: every reading loop already has an Update
    /// that knows whether it is busy, and a declaration that simply expires cannot be left dangling
    /// by a rescue, a scene unload, or an aborted raise. The short grace period covers the frames
    /// between two declarations and lets the effect return just after the sheet goes down.
    /// </para>
    /// </summary>
    public static class CloseUpFocus
    {
        private const float k_GraceSeconds = 0.2f;

        private static float s_heldUntil = float.NegativeInfinity;

        /// <summary>Whether any close-up read is holding the screen right now.</summary>
        public static bool IsHeld => Time.unscaledTime < s_heldUntil;

        /// <summary>Called every frame by a busy reading loop; expires on its own.</summary>
        public static void HoldThisFrame()
        {
            s_heldUntil = Time.unscaledTime + k_GraceSeconds;
        }
    }
}
