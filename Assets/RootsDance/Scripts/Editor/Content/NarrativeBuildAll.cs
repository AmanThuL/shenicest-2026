using RootsDance.Editor.Audio;
using RootsDance.Editor.Tools;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Runs every narrative and voice builder in dependency order, so the whole talking half of the
    /// game can be regenerated from the shell in one batch run.
    /// <para>
    /// Each step is idempotent on its own; this fixes only the order, and the order matters in
    /// three places. The copy is written before the recordings are attached, because a recording is
    /// matched to a line by the line's opening words. The placeholders come after the real copy,
    /// because a placeholder only ever fills an asset that is still empty. And the bootstrap is
    /// built first, because every scene wired afterwards points at channels it creates.
    /// </para>
    /// <para>
    /// Main_Gameplay is opened and saved three times over — once for the beds, once for the radio,
    /// once for the conversations. Each builder owns one concern and re-opens the scene fresh, so
    /// the later ones see what the earlier ones saved.
    /// </para>
    /// Menu: RootsDance &gt; Content &gt; Build Narrative (all steps).
    /// </summary>
    public static class NarrativeBuildAll
    {
        [MenuItem("RootsDance/Content/Build Narrative (all steps)")]
        public static void Run()
        {
            // 1. The persistent root: audio directors, dialogue runner, dialogue screen, channels.
            BootstrapSceneBuilder.Build();

            // The chapter's assets and channels are laid out by Chapter00NarrativeBuilder, which is
            // deliberately not in this chain: it names RAD-001 after node 00-01 and the asset in
            // the project is named after node 00-02, so a run of it adds a second RAD-001 rather
            // than finding the first. Run it by hand when a new beat needs an asset.

            // 2. The copy the flow document actually contains, then a stand-in for the rest.
            Chapter00NarrativeText.Fill();
            Chapter00PlaceholderTextBuilder.Build();

            // 3. The recordings, matched to the lines by their opening words.
            Chapter00VoiceWiringBuilder.Build();
            AssetDatabase.SaveAssets();

            // 4. Main_Gameplay: beds and footsteps, the radio, the conversations.
            Chapter00AudioWiringBuilder.Build();
            Chapter00RadioFlowBuilder.Build();
            Chapter00DialogueTriggerBuilder.Build();

            // 5. Chapter 02/03 on top: the runner's voice references and the interior triggers.
            NarrativeRuntimeBuilder.ApplyAndSave();

            AssetDatabase.SaveAssets();
            Debug.Log("NarrativeBuildAll: done.");
        }

        /// <summary>Batch entry point (-executeMethod).</summary>
        public static void RunFromCommandLine()
        {
            Run();
        }
    }
}
