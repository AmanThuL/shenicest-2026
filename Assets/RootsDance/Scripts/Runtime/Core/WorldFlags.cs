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

        /// <summary>
        /// The flower sprite has just turned up behind the player on the bridge (02-04). Raised at
        /// the start of the meeting, not at its end: it is what makes her visible and what the
        /// camera's look-behind hangs on, and the player has to see her before she has said
        /// anything. <see cref="k_MetFlowerSprite"/> is the other end of the same beat.
        /// </summary>
        public const string k_FlowerSpriteAppeared = "flow.flower_sprite_appeared";

        /// <summary>
        /// The flower sprite has been met and spoken to (02-04). Raised by DLG-001 on completion,
        /// and it is what starts her following the player — from here she is company, not a prop.
        /// </summary>
        public const string k_MetFlowerSprite = "flow.met_flower_sprite";

        /// <summary>The sprite has said the station belonged to someone — the first "her" (02-04).</summary>
        public const string k_HeardAboutHer = "flow.heard_about_her";

        /// <summary>The player has entered the greenhouse proper (02-08).</summary>
        public const string k_EnteredGreenhouse = "flow.entered_greenhouse";

        /// <summary>The staff photograph on the observation deck has been read (02-10).</summary>
        public const string k_SawStaffPhotograph = "flow.saw_staff_photograph";

        /// <summary>The standing water left in the greenhouse sink has been sampled (02-11).</summary>
        public const string k_ResidualWaterSampled = "flow.residual_water_sampled";

        /// <summary>Core Cultivation was started — a wrong answer (02-12).</summary>
        public const string k_CirculationCore = "flow.circulation_core";

        /// <summary>Standard Ring was started — the other wrong answer (02-12).</summary>
        public const string k_CirculationRing = "flow.circulation_ring";

        /// <summary>Outer Boundary was started — the ecology's actual state (02-12).</summary>
        public const string k_CirculationOuter = "flow.circulation_outer";

        /// <summary>
        /// The player has walked into the space the StMuerte statue stands in (02-13). The one
        /// beat the statue gets before the ending: arriving is not the same as the ecology coming
        /// back, and the two want different music. <c>MusicWiring</c> scores this one with
        /// MUS_SacredGaia and <see cref="k_CirculationOuter"/> with MUS_EndingBloom.
        /// </summary>
        public const string k_EnteredSacredSpace = "flow.entered_sacred_space";

        // ---- The chase: the wrong cycle wakes the boss --------------------------------------------

        /// <summary>
        /// The sprite has finished her outburst over the wrong cycle (DLG-009). The deck holds
        /// under the player — groaning, shedding dust — until this is up; only then does it start
        /// to go. Raised by the conversation on completion.
        /// </summary>
        public const string k_WrongCycleOutburstDone = "flow.wrong_cycle_outburst_done";

        /// <summary>
        /// The wrong circulation choice woke the boss in the greenhouse; the run is on. Up only
        /// once the whole beat has landed — the outburst finished, the deck collapsed, the player
        /// on the floor — because this is the flag that unlocks the exits and arms the exterior
        /// stream (<c>GreenhouseExitArmer</c>). <c>GreenhouseStairCollapse</c> raises it.
        /// </summary>
        public const string k_ChaseStarted = "flow.chase_started";

        /// <summary>The car came back into view at the end of the run; the chase stands down.</summary>
        public const string k_ChaseEscaped = "flow.chase_escaped";

        /// <summary>The player confirmed that the research facility's main entrance is blocked (node 00-09).</summary>
        public const string k_MainEntranceBlocked = "flow.main_entrance_blocked";

        /// <summary>The downward main-entrance sign has been examined (node 00-10).</summary>
        public const string k_MainEntranceSignRead = "flow.main_entrance_sign_read";

        /// <summary>The Briggs botanical-garden poster has been examined (node 00-11).</summary>
        public const string k_ResearchFacilityPosterRead = "flow.research_facility_poster_read";

        // ---- Chapter 01: the lab corridor ------------------------------------------------------

        /// <summary>
        /// The dead torch has been taken off the corridor floor. Raised by the pickup, not by the
        /// torch: the torch only reports whether it is in a hand, and a hand can put it down again.
        /// </summary>
        public const string k_FlashlightRecovered = "flow.flashlight_recovered";

        /// <summary>
        /// BOT-AL-017 has been read into the biological report. Set as the recorded flag on the
        /// algae's InvestigationTargetSO, and as the required flag on its report section - that
        /// pair is what puts the section on the scanner screen.
        /// </summary>
        public const string k_AlgaeScanned = "flow.algae_scanned";

        /// <summary>
        /// Algae has been dropped into the torch and the beam works from here on. Read by
        /// <see cref="RootsDance.Player.FlashlightController"/>, which stays dark without it.
        /// </summary>
        public const string k_FlashlightPowered = "flow.flashlight_powered";

        /// <summary>
        /// The blue flask has been thrown at the Briggs exit rune and broken on it. This is what
        /// unlocks the north round door: before it the door ignores anyone standing in front of
        /// it, after it the door behaves like any other automatic door, so the player can walk
        /// back through. Held in world state rather than on the door so a checkpoint reload gets
        /// the answer right without a restore call.
        /// </summary>
        public const string k_BriggsExitRuneBroken = "flow.briggs_exit_rune_broken";

        // ---- Teaching -------------------------------------------------------------------------

        /// <summary>
        /// The player has put something down at least once, so the drop key has been taught and the
        /// standing "[G] 放下" hint stops. Held in world state rather than on the pickup trigger so
        /// it survives a reload and so a checkpoint can seed a player who is past the tutorial.
        /// The "put that down first" hint is unaffected — that one explains a blocked action rather
        /// than teaching a key, and is still worth showing every time.
        /// </summary>
        public const string k_LearnedDrop = "flow.learned_drop";
    }
}
