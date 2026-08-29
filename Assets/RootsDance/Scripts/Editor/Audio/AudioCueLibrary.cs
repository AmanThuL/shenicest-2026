using System.IO;
using RootsDance.Audio;
using UnityEditor;
using UnityEngine;
using UnityEngine.Audio;

namespace RootsDance.Editor.Audio
{
    /// <summary>
    /// Seeds the cue assets and the two channel assets the audio system needs, so a scene can be
    /// wired for sound before a single clip has been recorded.
    /// <para>
    /// The point is ordering. Wiring is slow and needs the scene; recording is slow and needs a
    /// microphone; and if the second has to finish before the first can start, both land on the
    /// same evening. A cue with no clips is silent and completely valid — dropping the file in
    /// later makes the whole scene audible with no further wiring.
    /// </para>
    /// <para>
    /// Non-destructive: an existing asset is left alone, because the moment a cue exists it belongs
    /// to whoever is mixing. Only the missing ones are created.
    /// </para>
    /// Menu: RootsDance &gt; Audio &gt; Build Audio Cue Library.
    /// </summary>
    public static class AudioCueLibrary
    {
        private const string k_CueFolder = "Assets/RootsDance/Data/Audio";
        private const string k_EventFolder = "Assets/RootsDance/Data/Events";

        /// <summary>
        /// A little pitch wander is what stops a repeated one-shot reading as one sample. It is
        /// also the AudioCueSO default, so the rows below say nothing about it — except the two
        /// that must not have it.
        /// </summary>
        private const float k_DefaultPitchJitter = 0.05f;

        /// <summary>Nothing detunes a spoken line. See the VOX_ rows.</summary>
        private const float k_NoPitchJitter = 0f;

        /// <summary>One row of the starter set: what to make, and how it should behave.</summary>
        private readonly struct CueSpec
        {
            public readonly string m_fileName;
            public readonly string m_group;
            public readonly bool m_loop;
            public readonly float m_spatialBlend;
            public readonly float m_maxDistance;
            public readonly float m_cooldownSeconds;
            public readonly float m_pitchJitter;

            public CueSpec(string fileName, string group, bool loop, float spatialBlend,
                float maxDistance, float cooldownSeconds)
                : this(fileName, group, loop, spatialBlend, maxDistance, cooldownSeconds,
                    k_DefaultPitchJitter)
            {
            }

            public CueSpec(string fileName, string group, bool loop, float spatialBlend,
                float maxDistance, float cooldownSeconds, float pitchJitter)
            {
                m_fileName = fileName;
                m_group = group;
                m_loop = loop;
                m_spatialBlend = spatialBlend;
                m_maxDistance = maxDistance;
                m_cooldownSeconds = cooldownSeconds;
                m_pitchJitter = pitchJitter;
            }
        }

        // The set covers what chapters 00 and 02 ask for and nothing else. A cue nobody has wired
        // is clutter in the picker, so the list grows when a scene needs a sound, not in advance.
        //
        // AMB_ loops and is owned by an AmbienceZone (a place) or a FlagAudioBed (a story beat);
        // SFX_ is a one-shot from the pool; UI_ is the interface; VOX_ is a mix for spoken lines
        // that carries no clips of its own; MUS_ belongs to the MusicDirector.
        private static readonly CueSpec[] k_Cues =
        {
            // Interface — flat, no position, and cooled down so a held prompt cannot machine-gun.
            new CueSpec("UI_ReportUpdated", AudioRouting.k_UiGroup, false, 0f, 20f, 0.15f),
            new CueSpec("UI_Notice", AudioRouting.k_UiGroup, false, 0f, 20f, 0.15f),
            new CueSpec("UI_SubtitleLine", AudioRouting.k_UiGroup, false, 0f, 20f, 0.08f),
            new CueSpec("UI_ConsoleSelect", AudioRouting.k_UiGroup, false, 0f, 20f, 0.1f),
            new CueSpec("UI_ConsoleDenied", AudioRouting.k_UiGroup, false, 0f, 20f, 0.1f),

            // World one-shots — positioned, and kept short-range: the greenhouse is one room.
            new CueSpec("SFX_ScanConfirm", AudioRouting.k_SfxGroup, false, 1f, 12f, 0f),
            new CueSpec("SFX_SampleTaken", AudioRouting.k_SfxGroup, false, 1f, 12f, 0f),
            new CueSpec("SFX_DoorSlide", AudioRouting.k_SfxGroup, false, 1f, 25f, 0.5f),
            new CueSpec("SFX_FoliageRustle", AudioRouting.k_SfxGroup, false, 1f, 16f, 0.2f),
            new CueSpec("SFX_StartleMovement", AudioRouting.k_SfxGroup, false, 1f, 20f, 0.5f),
            new CueSpec("SFX_WaterTrickle", AudioRouting.k_SfxGroup, false, 1f, 10f, 0f),

            // Beds — looping, owned by an AmbienceZone rather than the one-shot pool.
            new CueSpec("AMB_Corridor", AudioRouting.k_SfxGroup, true, 0.4f, 30f, 0f),
            new CueSpec("AMB_Greenhouse", AudioRouting.k_SfxGroup, true, 0.4f, 40f, 0f),
            new CueSpec("AMB_UndergroundNetwork", AudioRouting.k_SfxGroup, true, 1f, 8f, 0f),

            // Flat, not positioned: the protagonist's own breathing is not somewhere in the room.
            // Played by an always-on AmbienceZone on the player that a CueSequence switches on —
            // a loop needs a source that owns it, and that component already is one.
            new CueSpec("AMB_PanicBreath", AudioRouting.k_SfxGroup, true, 0f, 20f, 0f),

            // Music — flat by definition, and driven by the MusicDirector.
            new CueSpec("MUS_GreenhouseReveal", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f),
            new CueSpec("MUS_EndingBloom", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f),

            // ---- Chapter 00 -------------------------------------------------------------------

            // The two mixes every spoken line goes through. These deliberately hold no clips: the
            // recordings live on the lines of a RadioSequenceSO or a DialogueSO, and the request
            // carries the clip past the cue — see AudioCueRequest.Voice. Flat, because a radio in
            // the helmet and a thought in the player's head are not anywhere in the world, and with
            // no cooldown, which would otherwise swallow a line that follows a short one.
            // No pitch jitter: detuning a recorded voice is audible as a wobble, and it would also
            // put the clip's real duration out of step with the hold the subtitle was given.
            new CueSpec("VOX_Radio", AudioRouting.k_VoiceGroup, false, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("VOX_Dialogue", AudioRouting.k_VoiceGroup, false, 0f, 20f, 0f, k_NoPitchJitter),

            // The radio as hardware, as opposed to what is said through it.
            new CueSpec("SFX_RadioOpen", AudioRouting.k_SfxGroup, false, 0f, 20f, 0f),
            new CueSpec("SFX_RadioClose", AudioRouting.k_SfxGroup, false, 0f, 20f, 0f),
            new CueSpec("AMB_RadioStatic", AudioRouting.k_SfxGroup, true, 0f, 20f, 0f),

            // The suit. Breathing runs from the first frame to the moment the helmet comes off,
            // which is the single loudest signal that the air outside changed.
            new CueSpec("AMB_HelmetBreath", AudioRouting.k_SfxGroup, true, 0f, 20f, 0f),
            new CueSpec("SFX_HelmetOff", AudioRouting.k_SfxGroup, false, 0f, 20f, 0f),
            new CueSpec("SFX_HelmetOn", AudioRouting.k_SfxGroup, false, 0f, 20f, 0f),

            // Beds for the four acoustic states of chapter 00. Wide and mostly flat: these are the
            // air, not an object in it.
            new CueSpec("AMB_ContaminationWind", AudioRouting.k_SfxGroup, true, 0.2f, 60f, 0f),
            new CueSpec("AMB_LowContamination", AudioRouting.k_SfxGroup, true, 0.2f, 60f, 0f),
            new CueSpec("AMB_FacilityExterior", AudioRouting.k_SfxGroup, true, 0.3f, 40f, 0f),
            new CueSpec("AMB_MaintenanceTunnel", AudioRouting.k_SfxGroup, true, 0.3f, 30f, 0f),

            // Footsteps. Flat: they are emitted at the player, which is where the listener already
            // is, so panning them buys nothing and risks a step sounding off to one side. The
            // cooldown is a floor on cadence, not the cadence itself — see FootstepCadence.
            new CueSpec("SFX_FootstepDirt", AudioRouting.k_SfxGroup, false, 0f, 20f, 0.15f),
            new CueSpec("SFX_FootstepGrass", AudioRouting.k_SfxGroup, false, 0f, 20f, 0.15f),
            new CueSpec("SFX_FootstepMetal", AudioRouting.k_SfxGroup, false, 0f, 20f, 0.15f),

            // The survey tool: raising it, the scan running, and the two results it can reach are
            // already SFX_ScanConfirm and SFX_SampleTaken above.
            new CueSpec("SFX_ToolRaise", AudioRouting.k_SfxGroup, false, 0f, 20f, 0f),
            new CueSpec("SFX_ToolLower", AudioRouting.k_SfxGroup, false, 0f, 20f, 0f),
            new CueSpec("AMB_ScanLoop", AudioRouting.k_SfxGroup, true, 0f, 20f, 0f),

            // The facility from outside (nodes 00-08 to 00-15) and the duct behind it (00-16).
            new CueSpec("AMB_PlantOnStructure", AudioRouting.k_SfxGroup, true, 1f, 18f, 0f),
            new CueSpec("AMB_VentFan", AudioRouting.k_SfxGroup, true, 1f, 22f, 0f),
            new CueSpec("SFX_MetalCreak", AudioRouting.k_SfxGroup, false, 1f, 25f, 0.4f),
            new CueSpec("SFX_VineDrag", AudioRouting.k_SfxGroup, false, 1f, 14f, 0f),
            new CueSpec("SFX_WaterDrip", AudioRouting.k_SfxGroup, false, 1f, 10f, 0.3f),
            new CueSpec("AMB_PipeHum", AudioRouting.k_SfxGroup, true, 0.5f, 20f, 0f),

            // ---- The tracks the audition picked ------------------------------------------------

            // One cue per scene the music selection names, rather than one cue reused with a
            // different clip pushed into it: which piece plays where is a decision the mix owns,
            // and a cue is where the project already keeps that kind of decision. No pitch jitter
            // on any of them — a detuned track is audible as a wobble, and half of these crossfade
            // into each other.
            new CueSpec("MUS_MainMenu", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_Exploration", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_Contamination", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_Underground", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_SacredGaia", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_BossWarning", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_BossChase", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_Ending", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),
            new CueSpec("MUS_Credits", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f, k_NoPitchJitter),

            // ---- The four sounds the audition picked with no cue to put them in ----------------

            // Plant powers, the relic, the flower sprite and the creature. Nothing wires these yet;
            // they exist because the pick is a decision worth keeping, and a cue is the only place
            // in the project where a sound and its mix settings survive together.
            new CueSpec("SFX_PlantPower", AudioRouting.k_SfxGroup, false, 1f, 20f, 0f),
            new CueSpec("SFX_RelicChime", AudioRouting.k_SfxGroup, false, 1f, 25f, 0f),
            new CueSpec("SFX_FlowerVoice", AudioRouting.k_SfxGroup, false, 1f, 15f, 0.1f),
            new CueSpec("SFX_CreatureCall", AudioRouting.k_SfxGroup, false, 1f, 40f, 0.3f)
        };

        [MenuItem("RootsDance/Audio/Build Audio Cue Library")]
        public static void Build()
        {
            Directory.CreateDirectory(k_CueFolder);
            Directory.CreateDirectory(k_EventFolder);
            AssetDatabase.Refresh();

            AudioMixer mixer = AssetDatabase.LoadAssetAtPath<AudioMixer>(AudioRouting.k_MixerAssetPath);

            if (mixer == null)
            {
                Debug.LogWarning($"[Audio] No mixer at {AudioRouting.k_MixerAssetPath}; cues will be "
                    + "created with no output group. Create the mixer, then run "
                    + "RootsDance/Audio/Validate Mixer and this item again to fill the groups in.");
            }

            int cues = 0;
            int routed = 0;

            for (int i = 0; i < k_Cues.Length; i++)
            {
                if (CreateCue(k_Cues[i], mixer))
                {
                    cues++;
                }
                else if (RouteExistingCue(k_Cues[i], mixer))
                {
                    routed++;
                }
            }

            int channels = 0;
            channels += CreateChannel("AudioCueRequested") ? 1 : 0;
            channels += CreateChannel("MusicRequested") ? 1 : 0;

            AssetDatabase.SaveAssets();

            Debug.Log($"[Audio] {cues} cue asset(s) created in {k_CueFolder}, {routed} existing cue(s) "
                + $"given their mixer group, {channels} channel asset(s) in {k_EventFolder}. "
                + "Nothing else was touched.");
        }

        private static bool CreateCue(CueSpec spec, AudioMixer mixer)
        {
            string path = $"{k_CueFolder}/{spec.m_fileName}.asset";

            if (AssetDatabase.LoadAssetAtPath<AudioCueSO>(path) != null)
            {
                return false;
            }

            AudioCueSO cue = ScriptableObject.CreateInstance<AudioCueSO>();
            AssetDatabase.CreateAsset(cue, path);

            SerializedObject serialized = new SerializedObject(cue);
            serialized.FindProperty("m_loop").boolValue = spec.m_loop;
            serialized.FindProperty("m_spatialBlend").floatValue = spec.m_spatialBlend;
            serialized.FindProperty("m_maxDistance").floatValue = spec.m_maxDistance;
            serialized.FindProperty("m_cooldownSeconds").floatValue = spec.m_cooldownSeconds;
            serialized.FindProperty("m_pitchJitter").floatValue = spec.m_pitchJitter;
            serialized.FindProperty("m_outputGroup").objectReferenceValue = RouteTo(mixer, spec.m_group);
            serialized.ApplyModifiedPropertiesWithoutUndo();

            EditorUtility.SetDirty(cue);

            return true;
        }

        /// <summary>
        /// Fills in the mixer group of a cue that was created before the mixer existed, and only
        /// that. Running the builder first and authoring the mixer afterwards is the normal order —
        /// wiring does not wait on the mix — so without this the whole starter set would be left
        /// permanently unrouted and silent, with nothing saying why.
        /// </summary>
        private static bool RouteExistingCue(CueSpec spec, AudioMixer mixer)
        {
            if (mixer == null)
            {
                return false;
            }

            AudioCueSO cue = AssetDatabase.LoadAssetAtPath<AudioCueSO>($"{k_CueFolder}/{spec.m_fileName}.asset");

            if (cue == null || cue.OutputGroup != null)
            {
                return false;
            }

            AudioMixerGroup group = RouteTo(mixer, spec.m_group);

            if (group == null)
            {
                return false;
            }

            SerializedObject serialized = new SerializedObject(cue);
            serialized.FindProperty("m_outputGroup").objectReferenceValue = group;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(cue);

            return true;
        }

        private static bool CreateChannel(string fileName)
        {
            string path = $"{k_EventFolder}/{fileName}.asset";

            if (AssetDatabase.LoadAssetAtPath<AudioCueEventChannelSO>(path) != null)
            {
                return false;
            }

            AssetDatabase.CreateAsset(ScriptableObject.CreateInstance<AudioCueEventChannelSO>(), path);

            return true;
        }

        /// <summary>
        /// The group a cue comes out of. An optional group that has not been added to the mixer yet
        /// falls back to SFX rather than leaving the cue unrouted: an unrouted cue is silent, and a
        /// cue in the wrong group is a mix note. Adding the group later and re-running this item
        /// moves the cues into it, because <see cref="RouteExistingCue"/> only fills empty groups —
        /// so the fallback has to be undone by hand if it ever matters before then.
        /// </summary>
        private static AudioMixerGroup RouteTo(AudioMixer mixer, string groupPath)
        {
            AudioMixerGroup group = FindGroup(mixer, groupPath);

            if (group != null || !AudioRouting.IsOptionalGroup(groupPath))
            {
                return group;
            }

            return FindGroup(mixer, AudioRouting.k_FallbackGroup);
        }

        private static AudioMixerGroup FindGroup(AudioMixer mixer, string groupPath)
        {
            if (mixer == null)
            {
                return null;
            }

            AudioMixerGroup[] matches = mixer.FindMatchingGroups(groupPath);

            if (matches == null || matches.Length == 0)
            {
                return null;
            }

            int slash = groupPath.LastIndexOf('/');
            string leaf = slash < 0 ? groupPath : groupPath.Substring(slash + 1);

            for (int i = 0; i < matches.Length; i++)
            {
                if (matches[i] != null && matches[i].name == leaf)
                {
                    return matches[i];
                }
            }

            return null;
        }
    }
}
