using RootsDance.Audio;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Audio
{
    /// <summary>
    /// Puts the imported clips into the cue assets: one table of "this cue plays these files",
    /// applied to <c>Assets/RootsDance/Data/Audio/</c>.
    /// <para>
    /// The pairing has to be written down somewhere, and an Inspector drag is the one place it
    /// cannot be reviewed, re-run or explained. A table in code is diffable, survives a cue asset
    /// being regenerated, and — because every row names a file rather than a GUID — says out loud
    /// which audition pick ended up where. Swapping a sound is editing one line and running the
    /// menu item again, which is the same shape as
    /// <see cref="AudioCueLibrary"/> and <see cref="RootsDance.Editor.Tools.Chapter00AudioWiringBuilder"/>.
    /// </para>
    /// <para>
    /// Idempotent, and narrow: only the cues listed here are touched, and a row whose files are
    /// missing is reported and skipped rather than clearing a cue that already sounds. Everything
    /// else about a cue — group, volume, distance — stays with whoever is mixing.
    /// </para>
    /// Menu: RootsDance &gt; Audio &gt; Bind Audio Clips.
    /// </summary>
    public static class AudioClipBinder
    {
        private const string k_CueFolder = "Assets/RootsDance/Data/Audio";

        /// <summary>Folder names under <c>Assets/RootsDance/Audio/</c>. The import profile follows.</summary>
        public const string k_MusicFolder = "Music";
        public const string k_AmbienceFolder = "Ambience";
        public const string k_SfxFolder = "SFX";

        /// <summary>The prefix of a cue the <see cref="MusicDirector"/> plays.</summary>
        public const string k_MusicPrefix = "MUS_";

        /// <summary>One row: a cue, and the clips it plays.</summary>
        public readonly struct ClipBinding
        {
            public readonly string m_cue;
            public readonly string m_folder;
            public readonly string[] m_files;

            public ClipBinding(string cue, string folder, params string[] files)
            {
                m_cue = cue;
                m_folder = folder;
                m_files = files;
            }

            /// <summary>Where clip <paramref name="index"/> is expected to sit in the project.</summary>
            public string ClipPath(int index)
            {
                return AudioImportProfile.k_AudioRoot + m_folder + "/" + m_files[index];
            }
        }

        // Where each row comes from is recorded in docs/architecture/systems/音频管线.md §9. Rows
        // marked "selection" are the auditioned pick from roots-dance-audio-selections.json; the
        // rest are siblings from the same pack, chosen so a cue whose family was auditioned is not
        // left silent on its own.
        //
        // A footstep cue takes the whole five-file set: one step sample repeated at walking cadence
        // reads as a machine, and the picker already refuses to play the same variant twice.
        public static readonly ClipBinding[] k_Bindings =
        {
            // ---- Music -------------------------------------------------------------------------
            // Every track is a selection. MUS_Credits deliberately shares the reveal's track: the
            // audition picked Convergence for both, and two cues pointing at one file costs nothing.
            new ClipBinding("MUS_MainMenu", k_MusicFolder, "Machina.mp3"),
            new ClipBinding("MUS_GreenhouseReveal", k_MusicFolder, "Convergence.mp3"),
            new ClipBinding("MUS_Exploration", k_MusicFolder, "PhaseShift.mp3"),
            new ClipBinding("MUS_Contamination", k_MusicFolder, "Permafrost.mp3"),
            new ClipBinding("MUS_Underground", k_MusicFolder, "MemoriesOfStone.mp3"),
            new ClipBinding("MUS_SacredGaia", k_MusicFolder, "Incantation.mp3"),
            new ClipBinding("MUS_BossWarning", k_MusicFolder, "ICanFeelItComing.mp3"),
            new ClipBinding("MUS_BossChase", k_MusicFolder, "EyesInTheVoid.mp3"),
            new ClipBinding("MUS_EndingBloom", k_MusicFolder, "HourOfTheWitch.mp3"),
            new ClipBinding("MUS_Ending", k_MusicFolder, "NightmareMachine.mp3"),
            new ClipBinding("MUS_Credits", k_MusicFolder, "Convergence.mp3"),

            // ---- Beds --------------------------------------------------------------------------
            // The four synthesized loops. The audition picked the running breath for "helmet
            // breathing"; it is the panic bed here, because AMB_HelmetBreath runs from the first
            // frame of the chapter and a player standing still is not out of breath.
            new ClipBinding("AMB_HelmetBreath", k_AmbienceFolder, "HelmetBreath_Calm_Loop.wav"),
            new ClipBinding("AMB_PanicBreath", k_AmbienceFolder, "HelmetBreath_Run_Loop.wav"),
            new ClipBinding("AMB_LowContamination", k_AmbienceFolder, "Pollution_Spores_Loop.wav"),
            new ClipBinding("AMB_ContaminationWind", k_AmbienceFolder, "Pollution_Machinery_Loop.wav"),
            new ClipBinding("AMB_FacilityExterior", k_AmbienceFolder, "Pollution_Wind_Loop.wav"),

            // ---- Footsteps ---------------------------------------------------------------------
            // The audition picked one carpet step for "footsteps and ground"; the other two surfaces
            // take the matching sets from the same pack so the three cues sound like one library.
            new ClipBinding("SFX_FootstepDirt", k_SfxFolder,
                "Footstep_Carpet_01.ogg", "Footstep_Carpet_02.ogg", "Footstep_Carpet_03.ogg",
                "Footstep_Carpet_04.ogg", "Footstep_Carpet_05.ogg"),
            new ClipBinding("SFX_FootstepGrass", k_SfxFolder,
                "Footstep_Grass_01.ogg", "Footstep_Grass_02.ogg", "Footstep_Grass_03.ogg",
                "Footstep_Grass_04.ogg", "Footstep_Grass_05.ogg"),
            new ClipBinding("SFX_FootstepMetal", k_SfxFolder,
                "Footstep_Concrete_01.ogg", "Footstep_Concrete_02.ogg", "Footstep_Concrete_03.ogg",
                "Footstep_Concrete_04.ogg", "Footstep_Concrete_05.ogg"),

            // ---- Interface and the survey tool -------------------------------------------------
            // "Survey tool and UI" auditioned one confirmation and one click; the rest of the
            // interface takes its neighbours from the same Kenney pack.
            new ClipBinding("SFX_ScanConfirm", k_SfxFolder, "UI_Confirm_01.ogg"),
            new ClipBinding("SFX_SampleTaken", k_SfxFolder, "UI_Confirm_03.ogg"),
            new ClipBinding("UI_ReportUpdated", k_SfxFolder, "UI_Confirm_02.ogg"),
            new ClipBinding("UI_ConsoleSelect", k_SfxFolder, "UI_Click_01.ogg"),
            new ClipBinding("UI_ConsoleDenied", k_SfxFolder, "UI_Error_01.ogg"),
            new ClipBinding("UI_Notice", k_SfxFolder, "UI_Notice_01.ogg"),
            new ClipBinding("UI_SubtitleLine", k_SfxFolder, "UI_Tick_01.ogg"),
            new ClipBinding("SFX_ToolRaise", k_SfxFolder, "Tool_Raise_01.ogg"),
            new ClipBinding("SFX_ToolLower", k_SfxFolder, "Tool_Lower_01.ogg"),

            // ---- The world ---------------------------------------------------------------------
            new ClipBinding("SFX_RadioOpen", k_SfxFolder, "Radio_Open_01.ogg"),
            new ClipBinding("SFX_RadioClose", k_SfxFolder, "Radio_Close_01.ogg"),
            new ClipBinding("SFX_DoorSlide", k_SfxFolder, "Door_Close_01.ogg"),
            new ClipBinding("SFX_PlantPower", k_SfxFolder, "Plant_Power_01.ogg"),
            new ClipBinding("SFX_RelicChime", k_SfxFolder, "Relic_Chime_01.mp3"),
            new ClipBinding("SFX_FlowerVoice", k_SfxFolder, "Flower_Chirp_01.ogg"),
            new ClipBinding("SFX_CreatureCall", k_SfxFolder, "Creature_Call_01.ogg"),

            // ---- The beds the audition library had no candidate for ----------------------------
            // Synthesized by Tools/audio/generate_beds.py: a bed has to loop, and every looping
            // candidate in the library is a one-shot with a seam in it. Placeholders with the right
            // length and spectrum — replacing one is dropping a file with the same name.
            new ClipBinding("AMB_RadioStatic", k_AmbienceFolder, "Radio_Static_Loop.wav"),
            new ClipBinding("AMB_Corridor", k_AmbienceFolder, "Corridor_Loop.wav"),
            new ClipBinding("AMB_Greenhouse", k_AmbienceFolder, "Greenhouse_Loop.wav"),
            new ClipBinding("AMB_UndergroundNetwork", k_AmbienceFolder, "Underground_Network_Loop.wav"),
            new ClipBinding("AMB_ScanLoop", k_AmbienceFolder, "Scan_Loop.wav"),
            new ClipBinding("AMB_PlantOnStructure", k_AmbienceFolder, "Plant_On_Structure_Loop.wav"),

            // Water, also synthesized: nothing in the library is water. The three drips have no cue
            // any more — the duct they dripped in was cut with the late chapter-00 nodes — so the
            // files stay in SFX/ unbound, ready for whatever room takes their place.
            new ClipBinding("SFX_WaterTrickle", k_SfxFolder, "Water_Trickle_01.wav"),

            // ---- The props, from the pack the door came out of ---------------------------------
            new ClipBinding("SFX_MetalCreak", k_SfxFolder,
                "Metal_Creak_01.ogg", "Metal_Creak_02.ogg", "Metal_Creak_03.ogg"),
            new ClipBinding("SFX_FoliageRustle", k_SfxFolder,
                "Foliage_Rustle_01.ogg", "Foliage_Rustle_02.ogg"),
            new ClipBinding("SFX_StartleMovement", k_SfxFolder,
                "Startle_Movement_01.ogg", "Startle_Movement_02.ogg"),
            new ClipBinding("SFX_HelmetOn", k_SfxFolder, "Helmet_On_01.ogg"),
            new ClipBinding("SFX_HelmetOff", k_SfxFolder, "Helmet_Off_01.ogg")
        };

        [MenuItem("RootsDance/Audio/Bind Audio Clips")]
        public static void Bind()
        {
            int bound = 0;
            int skipped = 0;

            for (int i = 0; i < k_Bindings.Length; i++)
            {
                if (BindOne(k_Bindings[i]))
                {
                    bound++;
                }
                else
                {
                    skipped++;
                }
            }

            AssetDatabase.SaveAssets();

            Debug.Log($"[Audio] {bound} cue(s) given their clips, {skipped} row(s) skipped. "
                + "Cues outside the table were not touched.");
        }

        /// <summary>
        /// Creates any missing cue and then binds, in one call, for
        /// <c>-batchmode -executeMethod</c>. Exits non-zero when a row could not be applied, so a
        /// renamed file fails the run instead of silently leaving a cue mute.
        /// </summary>
        public static void BuildAndBindBatch()
        {
            AudioCueLibrary.Build();

            int failed = 0;

            for (int i = 0; i < k_Bindings.Length; i++)
            {
                if (!BindOne(k_Bindings[i]))
                {
                    failed++;
                }
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            Debug.Log($"[Audio] Batch bind finished: {k_Bindings.Length - failed} of "
                + $"{k_Bindings.Length} row(s) applied.");

            EditorApplication.Exit(failed == 0 ? 0 : 1);
        }

        private static bool BindOne(ClipBinding binding)
        {
            string cuePath = $"{k_CueFolder}/{binding.m_cue}.asset";
            AudioCueSO cue = AssetDatabase.LoadAssetAtPath<AudioCueSO>(cuePath);

            if (cue == null)
            {
                Debug.LogError($"[Audio] No cue asset at {cuePath}. Run "
                    + "RootsDance/Audio/Build Audio Cue Library first.");
                return false;
            }

            AudioClip[] clips = new AudioClip[binding.m_files.Length];

            for (int i = 0; i < binding.m_files.Length; i++)
            {
                string clipPath = binding.ClipPath(i);
                clips[i] = AssetDatabase.LoadAssetAtPath<AudioClip>(clipPath);

                if (clips[i] == null)
                {
                    Debug.LogError($"[Audio] {binding.m_cue}: no clip at {clipPath}. The cue was "
                        + "left as it was.");
                    return false;
                }
            }

            SerializedObject serialized = new SerializedObject(cue);
            SerializedProperty list = serialized.FindProperty("m_clips");
            list.arraySize = clips.Length;

            for (int i = 0; i < clips.Length; i++)
            {
                list.GetArrayElementAtIndex(i).objectReferenceValue = clips[i];
            }

            // A music cue never wants the one-shot pitch wander. The cue default (±0.05) is what
            // stops a repeated prop sound reading as one sample; on a track it is most of a
            // semitone, and it also puts the piece out of tune with itself across a crossfade.
            if (binding.m_cue.StartsWith(k_MusicPrefix))
            {
                serialized.FindProperty("m_pitchJitter").floatValue = 0f;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(cue);

            return true;
        }
    }
}
