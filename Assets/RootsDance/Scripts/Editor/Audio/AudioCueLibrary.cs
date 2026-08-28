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

        /// <summary>One row of the starter set: what to make, and how it should behave.</summary>
        private readonly struct CueSpec
        {
            public readonly string m_fileName;
            public readonly string m_group;
            public readonly bool m_loop;
            public readonly float m_spatialBlend;
            public readonly float m_maxDistance;
            public readonly float m_cooldownSeconds;

            public CueSpec(string fileName, string group, bool loop, float spatialBlend,
                float maxDistance, float cooldownSeconds)
            {
                m_fileName = fileName;
                m_group = group;
                m_loop = loop;
                m_spatialBlend = spatialBlend;
                m_maxDistance = maxDistance;
                m_cooldownSeconds = cooldownSeconds;
            }
        }

        // The starter set covers what chapter 02 asks for and nothing else. A cue nobody has wired
        // is clutter in the picker, so the list grows when a scene needs a sound, not in advance.
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
            new CueSpec("MUS_EndingBloom", AudioRouting.k_MusicGroup, true, 0f, 20f, 0f)
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
            serialized.FindProperty("m_outputGroup").objectReferenceValue = FindGroup(mixer, spec.m_group);
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

            AudioMixerGroup group = FindGroup(mixer, spec.m_group);

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
