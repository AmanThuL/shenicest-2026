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

        /// <summary>
        /// The signal is going: the last transmission starts here (node 00-04). Separate from
        /// <see cref="k_RadioSignalLost"/> because the carrier has to still be there while the last
        /// words are spoken — a transmission playing over silence reads as a bug, not as a fade.
        /// </summary>
        public const string k_RadioSignalFading = "flow.radio_signal_fading";

        /// <summary>
        /// The transmission failed for good (node 00-04), raised when the last one finishes. Read by
        /// the carrier-hiss bed, which stops on it, and by anything that must not expect help again.
        /// </summary>
        public const string k_RadioSignalLost = "flow.radio_signal_lost";

        /// <summary>Player stepped into the discoloured grass belt (node 00-06).</summary>
        public const string k_EnteredGrassBelt = "flow.entered_grass_belt";

        /// <summary>First investigation of any kind completed (node 00-07).</summary>
        public const string k_FirstInvestigationDone = "flow.first_investigation_done";

        // ---- Chapter 02: the corridor and the greenhouse ----------------------------------------

        /// <summary>The underground root network has been read through the floor window (02-02).</summary>
        public const string k_SawUndergroundNetwork = "flow.saw_underground_network";

        /// <summary>The flower sprite has been met and spoken to (02-04).</summary>
        public const string k_MetFlowerSprite = "flow.met_flower_sprite";

        /// <summary>The sprite has said the station belonged to someone — the first "her" (02-04).</summary>
        public const string k_HeardAboutHer = "flow.heard_about_her";

        /// <summary>The player has entered the greenhouse proper (02-08).</summary>
        public const string k_EnteredGreenhouse = "flow.entered_greenhouse";

        /// <summary>The staff photograph on the observation deck has been read (02-10).</summary>
        public const string k_SawStaffPhotograph = "flow.saw_staff_photograph";

        /// <summary>Core Cultivation was started — a wrong answer (02-12).</summary>
        public const string k_CirculationCore = "flow.circulation_core";

        /// <summary>Standard Ring was started — the other wrong answer (02-12).</summary>
        public const string k_CirculationRing = "flow.circulation_ring";

        /// <summary>Outer Boundary was started — the ecology's actual state (02-12).</summary>
        public const string k_CirculationOuter = "flow.circulation_outer";

        /// <summary>The player confirmed that the research facility's main entrance is blocked (node 00-09).</summary>
        public const string k_MainEntranceBlocked = "flow.main_entrance_blocked";

        /// <summary>The downward main-entrance sign has been examined (node 00-10).</summary>
        public const string k_MainEntranceSignRead = "flow.main_entrance_sign_read";

        /// <summary>The Briggs botanical-garden poster has been examined (node 00-11).</summary>
        public const string k_ResearchFacilityPosterRead = "flow.research_facility_poster_read";

        /// <summary>Ashleaf vine has been scanned into the biological report (node 00-12).</summary>
        public const string k_AshleafVineScanned = "flow.ashleaf_vine_scanned";

        /// <summary>Fine-veined vine has been scanned into the biological report (node 00-13).</summary>
        public const string k_FineVeinedVineScanned = "flow.fine_veined_vine_scanned";

        /// <summary>The player connected the fine vine's growth direction to the service hardware (node 00-14).</summary>
        public const string k_VineGrowthDirectionObserved = "flow.vine_growth_direction_observed";

        /// <summary>The maintenance-entrance vine cover has been moved aside (node 00-15).</summary>
        public const string k_MaintenanceEntranceRevealed = "flow.maintenance_entrance_revealed";

        /// <summary>
        /// The player is inside the service duct (node 00-16). The outdoor beds stop on it and the
        /// enclosed ones start, which is the whole acoustic difference between outside and inside.
        /// </summary>
        public const string k_EnteredMaintenanceTunnel = "flow.entered_maintenance_tunnel";
    }
}
