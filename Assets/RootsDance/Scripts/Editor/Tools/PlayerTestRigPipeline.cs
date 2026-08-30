using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// One-click rebuild of everything the PlayerTest scene needs. Order matters and is the whole
    /// reason this exists: the helmet rig builder destroys and recreates the shared Arms rig, wiping
    /// the other debug triggers — so it must run first, the additive rigs after it, and the HUD last
    /// so its wiring finds the fresh rig. Running the builders individually in another order is how
    /// the P/S/C keys kept dying.
    /// </summary>
    public static class PlayerTestRigPipeline
    {
        [MenuItem("RootsDance/Build Player Test Rig (All)")]
        public static void BuildAll()
        {
            HelmetTestRigBuilder.Build();
            StandUpTestRigBuilder.Build();
            CrawlTestRigBuilder.Build();
            KeypadPokeTestRigBuilder.Build();
            HelmetHudBuilder.Build();

            Debug.Log("PlayerTestRigPipeline: helmet, stand-up, crawl, keypad rigs and the HUD "
                + "rebuilt in order. Play: H removes the helmet, S/C/P fire their clips.");
        }
    }
}
