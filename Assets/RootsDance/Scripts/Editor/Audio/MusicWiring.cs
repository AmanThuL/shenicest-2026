using RootsDance.App;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Events;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Audio
{
    /// <summary>
    /// Puts the score on the bootstrap: a <see cref="FlagMusicCues"/> next to the
    /// <see cref="MusicDirector"/>, and the table of "this flag, that track".
    /// <para>
    /// The table is here rather than dragged into the Inspector for the same reason the clip table
    /// is (<see cref="AudioClipBinder"/>): which piece of music a story beat turns into is a
    /// decision worth reviewing in a diff, and a bootstrap scene edited by hand is the file the
    /// whole team conflicts on. Re-running is idempotent — the rows are rewritten to exactly what
    /// is below, and nothing else in the scene is touched.
    /// </para>
    /// Menu: RootsDance &gt; Audio &gt; Wire Music.
    /// </summary>
    public static class MusicWiring
    {
        private const string k_BootstrapScene = "Assets/RootsDance/Scenes/Bootstrap.unity";
        private const string k_CueFolder = "Assets/RootsDance/Data/Audio";
        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";

        /// <summary>What is playing before any flag has been raised — the menu, and the wake-up.</summary>
        public const string k_OpeningCue = "MUS_MainMenu";

        /// <summary>One beat: the flag that turns the music into <see cref="m_cue"/>.</summary>
        public readonly struct MusicBeat
        {
            public readonly string m_flagId;
            public readonly string m_cue;

            public MusicBeat(string flagId, string cue)
            {
                m_flagId = flagId;
                m_cue = cue;
            }
        }

        // The chapter as the music hears it. Each row is a state the player can tell apart without
        // being told: the air is bad, the air is clean, the ground is alive, the thing is awake.
        // Beats nobody raises a flag for yet (the credits roll) have their cue but no row — see
        // 音频管线 §9.
        public static readonly MusicBeat[] k_Beats =
        {
            // Chapter 00. The opening track carries the wake-up; the contaminated exterior takes
            // over once the player commits to walking inwards, and the helmet coming off is the
            // single clearest "the world is not what it was" beat in the chapter.
            new MusicBeat(WorldFlags.k_LeftStartArea, "MUS_Contamination"),
            new MusicBeat(WorldFlags.k_HelmetRemoved, "MUS_Exploration"),

            // Chapter 02.
            new MusicBeat(WorldFlags.k_SawUndergroundNetwork, "MUS_Underground"),
            new MusicBeat(WorldFlags.k_EnteredGreenhouse, "MUS_GreenhouseReveal"),

            // The circulation choice. Two wrong answers wake the thing in the greenhouse — the
            // warning plays before the player knows why — and the right one is where the ecology
            // starts coming back.
            new MusicBeat(WorldFlags.k_CirculationCore, "MUS_BossWarning"),
            new MusicBeat(WorldFlags.k_CirculationRing, "MUS_BossWarning"),
            // The statue gets two beats, not one: walking into the space it stands in, and the
            // ecology actually coming back. Arriving is quiet and enormous; the bloom is the
            // ending. One track for both would flatten the first into a preview of the second.
            new MusicBeat(WorldFlags.k_EnteredSacredSpace, "MUS_SacredGaia"),
            new MusicBeat(WorldFlags.k_CirculationOuter, "MUS_EndingBloom"),

            // The chase, and what is left after it.
            new MusicBeat(WorldFlags.k_ChaseStarted, "MUS_BossChase"),
            new MusicBeat(WorldFlags.k_ChaseEscaped, "MUS_Ending")
        };

        [MenuItem("RootsDance/Audio/Wire Music")]
        public static void Wire()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("[Audio] Music wiring cancelled: current scenes have unsaved changes.");
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_BootstrapScene, OpenSceneMode.Single);

            if (!Apply(scene, out int rows))
            {
                return;
            }

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"[Audio] Music wired in {k_BootstrapScene}: opening track {k_OpeningCue}, "
                + $"{rows} beat(s). The cues with no beat yet are listed in 音频管线 §9.");
        }

        /// <summary>Batch entry point for <c>-executeMethod</c>. Non-zero exit if a row is missing.</summary>
        public static void WireBatch()
        {
            Scene scene = EditorSceneManager.OpenScene(k_BootstrapScene, OpenSceneMode.Single);
            bool applied = Apply(scene, out int rows);

            if (applied)
            {
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
                Debug.Log($"[Audio] Music wired in batch: {rows} beat(s).");
            }

            AssetDatabase.SaveAssets();
            EditorApplication.Exit(applied ? 0 : 1);
        }

        /// <summary>
        /// Ensures the component on the bootstrap root and rewrites its table. Everything else in
        /// the scene — and every other field of the audio wiring — is left as it is.
        /// </summary>
        private static bool Apply(Scene scene, out int rows)
        {
            rows = 0;

            GameBootstrap bootstrap = FindBootstrap(scene);

            if (bootstrap == null)
            {
                Debug.LogError($"[Audio] No GameBootstrap in {scene.path}. Run "
                    + "RootsDance/Build Bootstrap Scene first.");
                return false;
            }

            FlagMusicCues component = bootstrap.GetComponent<FlagMusicCues>();

            if (component == null)
            {
                component = bootstrap.gameObject.AddComponent<FlagMusicCues>();
            }

            StringEventChannelSO flagRaised =
                AssetDatabase.LoadAssetAtPath<StringEventChannelSO>($"{k_EventsFolder}/FlagRaised.asset");
            AudioCueEventChannelSO musicRequested =
                AssetDatabase.LoadAssetAtPath<AudioCueEventChannelSO>($"{k_EventsFolder}/MusicRequested.asset");
            AudioCueSO opening = LoadCue(k_OpeningCue);

            if (flagRaised == null || musicRequested == null || opening == null)
            {
                Debug.LogError("[Audio] Missing FlagRaised / MusicRequested channel or the opening "
                    + "cue. Run RootsDance/Audio/Build Audio Cue Library first.");
                return false;
            }

            SerializedObject serialized = new SerializedObject(component);
            serialized.FindProperty("m_flagRaised").objectReferenceValue = flagRaised;
            serialized.FindProperty("m_musicRequested").objectReferenceValue = musicRequested;
            serialized.FindProperty("m_openingMusic").objectReferenceValue = opening;

            SerializedProperty bindings = serialized.FindProperty("m_bindings");
            bindings.arraySize = k_Beats.Length;

            for (int i = 0; i < k_Beats.Length; i++)
            {
                AudioCueSO cue = LoadCue(k_Beats[i].m_cue);

                if (cue == null)
                {
                    Debug.LogError($"[Audio] No cue '{k_Beats[i].m_cue}' for flag "
                        + $"'{k_Beats[i].m_flagId}'. Nothing was saved.");
                    return false;
                }

                SerializedProperty row = bindings.GetArrayElementAtIndex(i);
                row.FindPropertyRelative("m_flagId").stringValue = k_Beats[i].m_flagId;
                row.FindPropertyRelative("m_cue").objectReferenceValue = cue;
                row.FindPropertyRelative("m_stopsMusic").boolValue = false;
                rows++;
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();

            return true;
        }

        /// <summary>The bootstrap object of the scene that was just opened, not of any other.</summary>
        private static GameBootstrap FindBootstrap(Scene scene)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                GameBootstrap bootstrap = roots[i].GetComponentInChildren<GameBootstrap>(true);

                if (bootstrap != null)
                {
                    return bootstrap;
                }
            }

            return null;
        }

        private static AudioCueSO LoadCue(string cueName)
        {
            return AssetDatabase.LoadAssetAtPath<AudioCueSO>($"{k_CueFolder}/{cueName}.asset");
        }
    }
}
