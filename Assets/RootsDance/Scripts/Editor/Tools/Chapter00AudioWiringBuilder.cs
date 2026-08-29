using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Narrative;
using RootsDance.Player;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Puts chapter 00's sound into <c>Main_Gameplay</c>: the eight looping beds that track the
    /// story, the player's footsteps, and the radio player's voice wiring.
    /// <para>
    /// The beds are keyed to flags the level already raises, not to trigger volumes of their own.
    /// That is the whole reason <see cref="FlagAudioBed"/> exists: the helmet's breathing follows
    /// the helmet and the carrier hiss follows the transmission, and neither of those is a place
    /// the player can walk into. It also means this builder adds no colliders and moves nothing —
    /// the level's own layout stays the level designer's.
    /// </para>
    /// <para>
    /// Idempotent: every object is found by name and re-wired, so re-running after new cues have
    /// been recorded refreshes the references instead of stacking a second set of beds.
    /// </para>
    /// Menu: RootsDance &gt; Audio &gt; Wire Chapter 00 Audio.
    /// </summary>
    public static class Chapter00AudioWiringBuilder
    {
        private const string k_Gameplay = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_AudioRoot = "Audio";
        private const string k_FootstepsName = "Footsteps";

        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_CueFolder = "Assets/RootsDance/Data/Audio";

        /// <summary>One bed: what it plays, and the two flags that bracket it.</summary>
        private readonly struct BedSpec
        {
            public readonly string m_name;
            public readonly string m_cue;
            public readonly string m_startFlag;
            public readonly string m_stopFlag;

            public BedSpec(string name, string cue, string startFlag, string stopFlag)
            {
                m_name = name;
                m_cue = cue;
                m_startFlag = startFlag;
                m_stopFlag = stopFlag;
            }
        }

        // The table in docs/architecture/systems/无线电与对话语音接入.md §5, in one place in code.
        // An empty start flag means "from the first frame".
        private static readonly BedSpec[] k_Beds =
        {
            new BedSpec("Bed_HelmetBreath", "AMB_HelmetBreath",
                string.Empty, WorldFlags.k_HelmetRemoved),
            new BedSpec("Bed_ContaminationWind", "AMB_ContaminationWind",
                string.Empty, WorldFlags.k_EnteredGrassBelt),
            new BedSpec("Bed_RadioStatic", "AMB_RadioStatic",
                WorldFlags.k_RadioBriefingStarted, WorldFlags.k_RadioSignalLost),
            new BedSpec("Bed_LowContamination", "AMB_LowContamination",
                WorldFlags.k_EnteredGrassBelt, string.Empty),
            new BedSpec("Bed_FacilityExterior", "AMB_FacilityExterior",
                WorldFlags.k_MainEntranceBlocked, string.Empty),
            new BedSpec("Bed_PlantOnStructure", "AMB_PlantOnStructure",
                WorldFlags.k_MainEntranceBlocked, string.Empty)
        };

        [MenuItem("RootsDance/Audio/Wire Chapter 00 Audio")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("[Audio] Wiring cancelled: current scenes have unsaved changes.");
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_Gameplay, OpenSceneMode.Single);

            StringEventChannelSO flagRaised = Load<StringEventChannelSO>($"{k_EventsFolder}/FlagRaised.asset");
            AudioCueEventChannelSO cueRequested =
                Load<AudioCueEventChannelSO>($"{k_EventsFolder}/AudioCueRequested.asset");

            GameObject root = EnsureRoot(scene, k_AudioRoot);
            int beds = 0;

            for (int i = 0; i < k_Beds.Length; i++)
            {
                if (WireBed(root, k_Beds[i], flagRaised))
                {
                    beds++;
                }
            }

            bool footsteps = WireFootsteps(scene, root, cueRequested);
            bool radio = WireRadio(scene, cueRequested);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"[Audio] Chapter 00 wiring in {k_Gameplay}: {beds} bed(s) under '{k_AudioRoot}', "
                + $"footsteps {(footsteps ? "wired" : "skipped")}, radio {(radio ? "wired" : "skipped")}. "
                + "Cues with no clips stay silent; the wiring is already correct for when they arrive.");
        }

        private static bool WireBed(GameObject root, BedSpec spec, StringEventChannelSO flagRaised)
        {
            AudioCueSO cue = Load<AudioCueSO>($"{k_CueFolder}/{spec.m_cue}.asset");

            if (cue == null)
            {
                Debug.LogWarning($"[Audio] No cue '{spec.m_cue}'; '{spec.m_name}' was skipped. Run "
                    + "RootsDance/Audio/Build Audio Cue Library first.");
                return false;
            }

            Transform existing = root.transform.Find(spec.m_name);
            GameObject bed;

            if (existing == null)
            {
                bed = new GameObject(spec.m_name);
                bed.transform.SetParent(root.transform, worldPositionStays: false);
            }
            else
            {
                bed = existing.gameObject;
            }

            // A bed owns its own source: a pooled voice is retired when its clip ends, and a loop
            // never ends.
            AudioSource source = Ensure<AudioSource>(bed);
            source.playOnAwake = false;

            FlagAudioBed component = Ensure<FlagAudioBed>(bed);

            SerializedObject serialized = new SerializedObject(component);
            serialized.FindProperty("m_flagRaised").objectReferenceValue = flagRaised;
            serialized.FindProperty("m_startOnFlag").stringValue = spec.m_startFlag;
            serialized.FindProperty("m_stopOnFlag").stringValue = spec.m_stopFlag;
            serialized.FindProperty("m_cue").objectReferenceValue = cue;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return true;
        }

        /// <summary>
        /// Footsteps go on an object of their own rather than on the Player, which is a prefab
        /// instance shared with every other level: a component added here would be a scene
        /// override, and the next person to open the prefab would not know it existed. The
        /// controller is a scene reference, which is exactly what this component's field is for.
        /// </summary>
        private static bool WireFootsteps(Scene scene, GameObject root, AudioCueEventChannelSO channel)
        {
            FirstPersonController controller = FindInScene<FirstPersonController>(scene);

            if (controller == null)
            {
                Debug.LogWarning("[Audio] No FirstPersonController in the scene; footsteps skipped.");
                return false;
            }

            AudioCueSO cue = Load<AudioCueSO>($"{k_CueFolder}/SFX_FootstepDirt.asset");

            Transform existing = root.transform.Find(k_FootstepsName);
            GameObject host;

            if (existing == null)
            {
                host = new GameObject(k_FootstepsName);
                host.transform.SetParent(root.transform, worldPositionStays: false);
            }
            else
            {
                host = existing.gameObject;
            }

            FootstepAudio footsteps = Ensure<FootstepAudio>(host);

            SerializedObject serialized = new SerializedObject(footsteps);
            serialized.FindProperty("m_controller").objectReferenceValue = controller;
            serialized.FindProperty("m_channel").objectReferenceValue = channel;
            serialized.FindProperty("m_cue").objectReferenceValue = cue;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return true;
        }

        /// <summary>
        /// Fills in the fields the radio player gained: where a line's recording is played, the
        /// English subtitle's own channel, and the two carrier stings. The transmission, the flags
        /// and the Chinese channel were wired when the level was built and are left alone.
        /// </summary>
        private static bool WireRadio(Scene scene, AudioCueEventChannelSO channel)
        {
            RadioSequencePlayer player = FindInScene<RadioSequencePlayer>(scene);

            if (player == null)
            {
                Debug.LogWarning("[Audio] No RadioSequencePlayer in the scene; radio voice skipped.");
                return false;
            }

            SerializedObject serialized = new SerializedObject(player);
            serialized.FindProperty("m_audioChannel").objectReferenceValue = channel;
            serialized.FindProperty("m_englishShown").objectReferenceValue =
                Load<StringEventChannelSO>($"{k_EventsFolder}/RadioLineEnglish.asset");
            serialized.FindProperty("m_playRequested").objectReferenceValue =
                Load<RadioEventChannelSO>($"{k_EventsFolder}/RadioRequested.asset");
            serialized.FindProperty("m_openCue").objectReferenceValue =
                Load<AudioCueSO>($"{k_CueFolder}/SFX_RadioOpen.asset");
            serialized.FindProperty("m_closeCue").objectReferenceValue =
                Load<AudioCueSO>($"{k_CueFolder}/SFX_RadioClose.asset");
            serialized.ApplyModifiedPropertiesWithoutUndo();

            return true;
        }

        private static GameObject EnsureRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i];
                }
            }

            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);

            return created;
        }

        private static T FindInScene<T>(Scene scene) where T : Component
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                T found = roots[i].GetComponentInChildren<T>(true);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        private static T Ensure<T>(GameObject target) where T : Component
        {
            T component = target.GetComponent<T>();

            return component == null ? target.AddComponent<T>() : component;
        }

        private static T Load<T>(string path) where T : Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                Debug.LogWarning($"[Audio] Missing asset at {path}; the field it fills was left empty.");
            }

            return asset;
        }
    }
}
