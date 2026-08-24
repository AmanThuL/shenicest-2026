namespace RootsDance.Core
{
    /// <summary>
    /// Flag ids that runtime code reacts to by name. Designers type the same string into the
    /// TriggerVolume inspector, so any change here must be mirrored in the Level00_Gameplay scene.
    /// Flags that only unlock content (and are never read by code) do not need a constant here.
    /// </summary>
    public static class WorldFlags
    {
        /// <summary>Player left the wake-up area and is heading inwards (node 00-02).</summary>
        public const string k_LeftStartArea = "flow.left_start_area";

        /// <summary>Radio briefing sequence has started (node 00-03).</summary>
        public const string k_RadioBriefingStarted = "flow.radio_briefing_started";

        /// <summary>Radio briefing sequence finished playing (node 00-03).</summary>
        public const string k_RadioBriefingFinished = "flow.radio_briefing_finished";

        /// <summary>Outside contamination dropped below the suit threshold (node 00-05).</summary>
        public const string k_HelmetRemovable = "flow.helmet_removable";

        /// <summary>The helmet is off; HUD is gone and the ambience changed (node 00-05).</summary>
        public const string k_HelmetRemoved = "flow.helmet_removed";

        /// <summary>Player stepped into the discoloured grass belt (node 00-06).</summary>
        public const string k_EnteredGrassBelt = "flow.entered_grass_belt";

        /// <summary>First investigation of any kind completed (node 00-07).</summary>
        public const string k_FirstInvestigationDone = "flow.first_investigation_done";
    }
}
