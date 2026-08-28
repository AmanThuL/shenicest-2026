using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// One batch entry point for the two rebuilds that have to happen together: the arms rig (now
    /// without the height anchor) and the helmet HUD (now without the visor frame). Running them in
    /// a single Editor boot keeps the reported measurements from describing two different states.
    /// </summary>
    public static class HudAndArmsBatch
    {
        public static void Run()
        {
            Debug.Log("=== ARMS REBUILD ===");
            ArmsFullRebuild.Run();

            Debug.Log("=== HUD REBUILD ===");
            RootsDance.Editor.Tools.HelmetHudBuilder.Build();

            Debug.Log("=== ARMS RIG ===");
            ArmsRigProbe.Report();

            Debug.Log("=== CURVE ===");
            HudCurveProbe.Report();
        }
    }
}
