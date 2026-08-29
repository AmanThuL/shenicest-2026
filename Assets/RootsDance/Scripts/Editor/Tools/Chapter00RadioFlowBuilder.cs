using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Events;
using RootsDance.Narrative;
using RootsDance.World;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Closes the radio half of chapter 00's loop: the level's three transmissions in one player,
    /// and the volume that starts the signal failing.
    /// <para>
    /// <b>The signal fails on two flags, not one.</b> The trigger raises
    /// <see cref="WorldFlags.k_RadioSignalFading"/>, which puts the last transmission on the air;
    /// that transmission raises <see cref="WorldFlags.k_RadioSignalLost"/> when it ends, and that is
    /// what the carrier-hiss bed stops on. A single flag would kill the hiss on the frame the last
    /// words begin, and a voice over silence reads as a bug rather than as a fade.
    /// </para>
    /// <para>
    /// <b>Only the failure is triggered by distance.</b> The approach call chains off the briefing's
    /// own finish flag instead of a volume of its own, because the route is shorter than the
    /// briefing: the walk from the briefing volume to the helmet-unlock volume takes about five
    /// seconds and the briefing takes fourteen, so a second volume in between would fire while the
    /// first transmission is still talking. Order that must hold comes from flags; only the beat
    /// that must happen *somewhere in particular* comes from a volume.
    /// </para>
    /// <para>
    /// That volume is placed between the briefing and the helmet-unlock trigger, at a fraction of
    /// the line between them rather than at coordinates typed in here. The route is grey-box and
    /// still moving; a position derived from the triggers either side moves with it, and re-running
    /// this item is all it takes to catch up. Nothing outside <c>Main_Gameplay</c> is opened — the
    /// environment scenes belong to whoever is dressing them.
    /// </para>
    /// Idempotent: objects are found by name and re-wired rather than duplicated.
    /// Menu: RootsDance &gt; Content &gt; Wire Chapter 00 Radio Flow.
    /// </summary>
    public static class Chapter00RadioFlowBuilder
    {
        private const string k_Gameplay = "Assets/RootsDance/Scenes/Levels/Main/Main_Gameplay.unity";
        private const string k_TriggersRoot = "Triggers";
        private const string k_NarrativeRoot = "Narrative";

        private const string k_BriefingTrigger = "RadioBriefing";
        private const string k_HelmetTrigger = "HelmetUnlock";

        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_CueFolder = "Assets/RootsDance/Data/Audio";
        private const string k_NarrativeFolder = "Assets/RootsDance/Data/Narrative";

        /// <summary>
        /// Where the volume sits between the briefing (0) and the helmet unlock (1). Late, because
        /// node 00-05 has the signal going as the player closes on the belt, not as they set off.
        /// </summary>
        private const float k_FadingFraction = 0.75f;

        /// <summary>Wide enough that the route cannot be walked round, low enough to sit on it.</summary>
        private static readonly Vector3 k_VolumeSize = new Vector3(10f, 3f, 4f);

        [MenuItem("RootsDance/Content/Wire Chapter 00 Radio Flow")]
        public static void Build()
        {
            if (!EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
            {
                Debug.LogWarning("[Content] Radio flow cancelled: current scenes have unsaved changes.");
                return;
            }

            Scene scene = EditorSceneManager.OpenScene(k_Gameplay, OpenSceneMode.Single);

            Transform triggers = EnsureRoot(scene, k_TriggersRoot);
            Transform narrative = EnsureRoot(scene, k_NarrativeRoot);

            Transform briefing = triggers.Find(k_BriefingTrigger);
            Transform helmet = triggers.Find(k_HelmetTrigger);

            if (briefing == null || helmet == null)
            {
                Debug.LogError($"[Content] {k_Gameplay} has no '{k_TriggersRoot}/{k_BriefingTrigger}' "
                    + $"or '{k_TriggersRoot}/{k_HelmetTrigger}'. The new volumes are placed between "
                    + "those two, so there is nothing to place them against.");
                return;
            }

            Vector3 from = briefing.position;
            Vector3 to = helmet.position;

            Trigger(triggers, "RadioSignalFading", Vector3.Lerp(from, to, k_FadingFraction),
                WorldFlags.k_RadioSignalFading);

            // Left over from the first pass, when the approach call had a volume of its own.
            Remove(triggers, "RadioApproach");

            StringEventChannelSO flagRaised = Load<StringEventChannelSO>($"{k_EventsFolder}/FlagRaised.asset");
            StringEventChannelSO line = Load<StringEventChannelSO>($"{k_EventsFolder}/RadioLine.asset");
            StringEventChannelSO english = Load<StringEventChannelSO>($"{k_EventsFolder}/RadioLineEnglish.asset");
            AudioCueEventChannelSO cues = Load<AudioCueEventChannelSO>($"{k_EventsFolder}/AudioCueRequested.asset");
            RadioEventChannelSO requested = Load<RadioEventChannelSO>($"{k_EventsFolder}/RadioRequested.asset");

            // One radio, three transmissions. The player already on the Narrative root is the one
            // the level was built with; it grows a table instead of gaining siblings.
            Radio(narrative, flagRaised, line, english, cues, requested);

            Remove(narrative, "RadioApproach");
            Remove(narrative, "RadioSignalLost");

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"[Content] Chapter 00 radio flow in {k_Gameplay}: one radio on "
                + $"'{k_NarrativeRoot}' with three transmissions, and a '{WorldFlags.k_RadioSignalFading}' "
                + $"volume {k_FadingFraction:P0} of the way from '{k_BriefingTrigger}' to "
                + $"'{k_HelmetTrigger}'. '{WorldFlags.k_RadioSignalLost}' is raised when the last "
                + "transmission ends, which is what stops the carrier hiss.");
        }

        private static void Trigger(Transform parent, string name, Vector3 position, string flagId)
        {
            Transform existing = parent.Find(name);
            GameObject host;

            if (existing == null)
            {
                host = new GameObject(name);
                host.transform.SetParent(parent, worldPositionStays: false);
            }
            else
            {
                host = existing.gameObject;
            }

            host.transform.position = position;

            BoxCollider box = Ensure<BoxCollider>(host);
            box.isTrigger = true;
            box.size = k_VolumeSize;
            box.center = Vector3.zero;

            TriggerVolume volume = Ensure<TriggerVolume>(host);

            SerializedObject serialized = new SerializedObject(volume);
            serialized.FindProperty("m_flagId").stringValue = flagId;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        /// <summary>
        /// The level's one radio: every transmission, each with the flag that starts it and the
        /// flag it raises when it ends. The chain is briefing → approach → signal loss, and only
        /// the last of those waits on a place in the world.
        /// </summary>
        private static void Radio(Transform host, StringEventChannelSO flagRaised,
            StringEventChannelSO line, StringEventChannelSO english, AudioCueEventChannelSO cues,
            RadioEventChannelSO requested)
        {
            RadioSequencePlayer player = Ensure<RadioSequencePlayer>(host.gameObject);

            SerializedObject serialized = new SerializedObject(player);
            serialized.FindProperty("m_flagRaised").objectReferenceValue = flagRaised;
            serialized.FindProperty("m_playRequested").objectReferenceValue = requested;
            serialized.FindProperty("m_lineShown").objectReferenceValue = line;
            serialized.FindProperty("m_englishShown").objectReferenceValue = english;
            serialized.FindProperty("m_audioChannel").objectReferenceValue = cues;
            serialized.FindProperty("m_openCue").objectReferenceValue =
                Load<AudioCueSO>($"{k_CueFolder}/SFX_RadioOpen.asset");
            serialized.FindProperty("m_closeCue").objectReferenceValue =
                Load<AudioCueSO>($"{k_CueFolder}/SFX_RadioClose.asset");

            SerializedProperty table = serialized.FindProperty("m_transmissions");
            table.arraySize = 3;

            Row(table.GetArrayElementAtIndex(0), WorldFlags.k_RadioBriefingStarted,
                "RadioBriefing", WorldFlags.k_RadioBriefingFinished);
            Row(table.GetArrayElementAtIndex(1), WorldFlags.k_RadioBriefingFinished,
                "RAD-003_Approach", string.Empty);
            Row(table.GetArrayElementAtIndex(2), WorldFlags.k_RadioSignalFading,
                "RAD-004_SignalLost", WorldFlags.k_RadioSignalLost);

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void Row(SerializedProperty row, string startFlag, string sequenceFile,
            string finishFlag)
        {
            row.FindPropertyRelative("m_startOnFlag").stringValue = startFlag;
            row.FindPropertyRelative("m_sequence").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<RadioSequenceSO>(
                    $"{k_NarrativeFolder}/{sequenceFile}.asset");
            row.FindPropertyRelative("m_flagOnFinished").stringValue = finishFlag;
        }

        private static void Remove(Transform parent, string name)
        {
            Transform child = parent.Find(name);

            if (child != null)
            {
                Object.DestroyImmediate(child.gameObject);
            }
        }

        private static Transform EnsureRoot(Scene scene, string name)
        {
            GameObject[] roots = scene.GetRootGameObjects();

            for (int i = 0; i < roots.Length; i++)
            {
                if (roots[i].name == name)
                {
                    return roots[i].transform;
                }
            }

            GameObject created = new GameObject(name);
            SceneManager.MoveGameObjectToScene(created, scene);

            return created.transform;
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
                Debug.LogWarning($"[Content] Missing asset at {path}; the field it fills was left empty.");
            }

            return asset;
        }
    }
}
