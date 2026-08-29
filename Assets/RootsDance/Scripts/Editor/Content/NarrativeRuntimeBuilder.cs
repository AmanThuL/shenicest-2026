using System;
using RootsDance.Audio;
using RootsDance.Core;
using RootsDance.Dialogue;
using RootsDance.Events;
using RootsDance.Sequencing;
using RootsDance.UI;
using RootsDance.World;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Wires what chapter 02/03's content needs on top of chapter 00's narrative wiring: the
    /// runner's voice references filled in where they are empty, a subtitle line for the radio,
    /// monologue and notice channels (which nothing displays yet), and the chapter's dialogue
    /// triggers in the two interior scenes — the corridor meeting, the sprite's greenhouse
    /// remarks, the staff photograph, the circulation console, and the wrong-choice outburst that
    /// hands over to the chase.
    /// <para>
    /// Repeatable: existing objects are found and re-pointed, never duplicated. Trigger positions
    /// are grey-box values against today's blockout geometry, expected to move with it.
    /// </para>
    /// Menu: RootsDance &gt; Content &gt; Wire Narrative Runtime.
    /// </summary>
    public static class NarrativeRuntimeBuilder
    {
        private const string k_BootstrapScenePath = "Assets/RootsDance/Scenes/Bootstrap.unity";
        private const string k_BriggsGameplayPath =
            "Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity";
        private const string k_GreenhouseGameplayPath =
            "Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Gameplay.unity";

        private const string k_DialogueScreenPrefabPath = "Assets/RootsDance/Prefabs/UI/DialogueScreen.prefab";
        private const string k_FontPath = "Assets/RootsDance/Fonts/m5x7 SDF.asset";

        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_DialogueChannelPath = k_EventsFolder + "/DialogueRequested.asset";
        private const string k_DialogueFolder = "Assets/RootsDance/Data/Dialogue";
        private const string k_VoiceCuePath = "Assets/RootsDance/Data/Audio/VOX_Dialogue.asset";

        [MenuItem("RootsDance/Content/Wire Narrative Runtime")]
        public static void ApplyFromMenu()
        {
            ApplyAndSave();
        }

        /// <summary>Batch entry point for the deterministic narrative wiring pass.</summary>
        public static void ApplyFromCommandLine()
        {
            ApplyAndSave();
        }

        public static void ApplyAndSave()
        {
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                EnsureDialogueChannel();
                WireBootstrap();
                WireBriggs();
                WireGreenhouse();
                AssetDatabase.SaveAssets();
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }

            Debug.Log("NarrativeRuntimeBuilder: claimed the dialogue runner, added the subtitle "
                + "line and wired the chapter triggers. Run Build Chapter 02 Dialogue first so the "
                + "triggers have conversations to point at.");
        }

        // ---- Assets ----------------------------------------------------------------------------

        private static DialogueEventChannelSO EnsureDialogueChannel()
        {
            DialogueEventChannelSO channel =
                AssetDatabase.LoadAssetAtPath<DialogueEventChannelSO>(k_DialogueChannelPath);

            if (channel == null)
            {
                channel = ScriptableObject.CreateInstance<DialogueEventChannelSO>();
                AssetDatabase.CreateAsset(channel, k_DialogueChannelPath);
            }

            return channel;
        }

        // ---- Bootstrap -------------------------------------------------------------------------

        private static void WireBootstrap()
        {
            Scene scene = EditorSceneManager.OpenScene(k_BootstrapScenePath, OpenSceneMode.Single);

            EnsureDialogueRunner(scene);
            EnsureSubtitleLine(scene);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        /// <summary>
        /// The runner and the screen it drives. Both normally exist already — chapter 00's wiring
        /// put them there — so this claims whatever is in the scene and only fills the references
        /// that are still empty. Adding a second runner would play every conversation twice.
        /// </summary>
        private static void EnsureDialogueRunner(Scene scene)
        {
            DialoguePresenter presenter = FindInScene<DialoguePresenter>(scene);

            if (presenter == null)
            {
                GameObject prefab = LoadRequired<GameObject>(k_DialogueScreenPrefabPath);
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                instance.name = "DialogueScreen";
                presenter = instance.GetComponentInChildren<DialoguePresenter>(true);
            }

            DialogueRunner runner = FindInScene<DialogueRunner>(scene);

            if (runner == null)
            {
                // Next to the screen it drives: the player is in a level scene, so a serialized
                // view reference could never reach across from there.
                runner = EnsureComponent<DialogueRunner>(EnsureRoot(scene, "Narrative").gameObject);
            }

            using (SerializedObject serialized = new SerializedObject(runner))
            {
                FillIfEmpty(serialized, "m_playRequested", EnsureDialogueChannel());
                FillIfEmpty(serialized, "m_viewBehaviour", presenter);
                FillIfEmpty(serialized, "m_audioChannel",
                    LoadRequired<AudioCueEventChannelSO>(k_EventsFolder + "/AudioCueRequested.asset"));
                FillIfEmpty(serialized, "m_voiceCue",
                    AssetDatabase.LoadAssetAtPath<AudioCueSO>(k_VoiceCuePath));
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        /// <summary>Leaves an authored reference alone; only an empty slot is filled.</summary>
        private static void FillIfEmpty(SerializedObject serialized, string path,
            UnityEngine.Object value)
        {
            SerializedProperty property = serialized.FindProperty(path);

            if (property != null && property.objectReferenceValue == null)
            {
                property.objectReferenceValue = value;
            }
        }

        /// <summary>
        /// One line of centred text above the dialogue box, fed by every string channel that
        /// narrates: the radio, the monologues, the notices. Its own canvas, sorted under the
        /// dialogue screen — a subtitle never needs to cover a conversation.
        /// </summary>
        private static void EnsureSubtitleLine(Scene scene)
        {
            Transform existing = FindTransform(scene, "SubtitleCanvas");
            GameObject root = existing == null ? new GameObject("SubtitleCanvas") : existing.gameObject;

            if (existing == null)
            {
                SceneManager.MoveGameObjectToScene(root, scene);
            }

            Canvas canvas = EnsureComponent<Canvas>(root);
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;
            canvas.sortingOrder = 5;

            CanvasScaler scaler = EnsureComponent<CanvasScaler>(root);
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(1920f, 1080f);
            scaler.matchWidthOrHeight = 0.5f;

            Transform labelTransform = root.transform.Find("Line");
            GameObject label = labelTransform == null ? new GameObject("Line") : labelTransform.gameObject;

            if (labelTransform == null)
            {
                label.transform.SetParent(root.transform, false);
            }

            RectTransform rect = EnsureComponent<RectTransform>(label);
            rect.anchorMin = new Vector2(0.5f, 0f);
            rect.anchorMax = new Vector2(0.5f, 0f);
            rect.pivot = new Vector2(0.5f, 0f);
            rect.anchoredPosition = new Vector2(0f, 260f);
            rect.sizeDelta = new Vector2(1400f, 120f);

            TextMeshProUGUI text = EnsureComponent<TextMeshProUGUI>(label);
            text.fontSize = 34f;
            text.alignment = TextAlignmentOptions.Bottom;
            text.textWrappingMode = TextWrappingModes.Normal;
            text.raycastTarget = false;

            TMP_FontAsset font = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontPath);

            if (font != null)
            {
                text.font = font;
            }

            SubtitlePresenter presenter = EnsureComponent<SubtitlePresenter>(root);

            using (SerializedObject serialized = new SerializedObject(presenter))
            {
                SerializedProperty channels = serialized.FindProperty("m_channels");
                string[] feeds = { "RadioLine", "Monologue", "Notice" };
                channels.arraySize = feeds.Length;

                for (int i = 0; i < feeds.Length; i++)
                {
                    channels.GetArrayElementAtIndex(i).objectReferenceValue =
                        LoadRequired<StringEventChannelSO>($"{k_EventsFolder}/{feeds[i]}.asset");
                }

                serialized.FindProperty("m_label").objectReferenceValue = text;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        // ---- Briggs interior -------------------------------------------------------------------

        private static void WireBriggs()
        {
            Scene scene = EditorSceneManager.OpenScene(k_BriggsGameplayPath, OpenSceneMode.Single);
            Transform root = EnsureRoot(scene, "_Narrative");

            // 02-04: the first meeting, walked into in the rear half of the lab on the way to the
            // north door. Grey-box: spans the walkway between the benches.
            Transform meeting = EnsureChild(root, "FirstMeeting");
            meeting.position = new Vector3(0f, 1.5f, -2f);
            ConfigureVolumeTrigger(meeting.gameObject, "DLG-001_FirstMeeting", new Vector3(8f, 3f, 4f));

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        // ---- Greenhouse interior ---------------------------------------------------------------

        private static void WireGreenhouse()
        {
            Scene scene = EditorSceneManager.OpenScene(k_GreenhouseGameplayPath, OpenSceneMode.Single);
            Transform root = EnsureRoot(scene, "_Narrative");

            // Crossing the south entrance raises the flag DLG-004 hangs on.
            Transform entered = EnsureChild(root, "EnteredGreenhouse");
            entered.position = new Vector3(0f, 1.5f, -8f);
            BoxCollider enteredBox = EnsureComponent<BoxCollider>(entered.gameObject);
            enteredBox.isTrigger = true;
            enteredBox.size = new Vector3(7f, 3f, 2f);
            TriggerVolume volume = EnsureComponent<TriggerVolume>(entered.gameObject);

            using (SerializedObject serialized = new SerializedObject(volume))
            {
                serialized.FindProperty("m_flagId").stringValue = WorldFlags.k_EnteredGreenhouse;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }

            // The sprite reacts to arrival without a place: the flag is the trigger.
            Transform neat = EnsureChild(root, "GreenhouseNeat");
            ConfigureFlagTrigger(neat.gameObject, "DLG-004_ItUsedToBeNeat",
                WorldFlags.k_EnteredGreenhouse);

            // Grey-box interactables: sign west of the entrance path, statue at the north centre,
            // photograph east of the statue, console south of it — all placeholders for props.
            Transform sign = EnsureChild(root, "BoundarySign");
            sign.position = new Vector3(-3.5f, 1.2f, -4f);
            ConfigureInteractTrigger(sign.gameObject, "DLG-005_TheSign",
                new Vector3(1.5f, 1.6f, 0.4f), "查看牌子");

            Transform statue = EnsureChild(root, "GaiaStatue");
            statue.position = new Vector3(0f, 1.4f, 6f);
            ConfigureInteractTrigger(statue.gameObject, "DLG-006_SheUsedToMove",
                new Vector3(1.4f, 2.4f, 1.4f), "端详雕像");

            Transform photo = EnsureChild(root, "StaffPhotograph");
            photo.position = new Vector3(4f, 1.5f, 6.5f);
            ConfigureInteractTrigger(photo.gameObject, "DLG-007_StaffPhotograph",
                new Vector3(1.6f, 1.1f, 0.4f), "查看合照");

            Transform console = EnsureChild(root, "CirculationConsole");
            console.position = new Vector3(0f, 1.2f, 2.5f);
            ConfigureInteractTrigger(console.gameObject, "DLG-008_CirculationConsole",
                new Vector3(1.4f, 1.4f, 0.9f), "查看终端");

            // Either wrong cycle: the outburst plays over the start of the chase, not before it —
            // the dialogue step does not wait, and the chase flag follows one breath later.
            EnsureWrongChoiceSequence(root, "WrongChoiceCore", WorldFlags.k_CirculationCore);
            EnsureWrongChoiceSequence(root, "WrongChoiceRing", WorldFlags.k_CirculationRing);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
        }

        private static void EnsureWrongChoiceSequence(Transform root, string name, string startFlag)
        {
            Transform host = EnsureChild(root, name);
            CueSequence sequence = EnsureComponent<CueSequence>(host.gameObject);

            using (SerializedObject serialized = new SerializedObject(sequence))
            {
                serialized.FindProperty("m_playOn").enumValueIndex = 2; // OnFlagRaised
                serialized.FindProperty("m_startOnFlag").stringValue = startFlag;
                serialized.FindProperty("m_flagRaised").objectReferenceValue =
                    LoadRequired<StringEventChannelSO>(k_EventsFolder + "/FlagRaised.asset");
                serialized.FindProperty("m_playsOnce").boolValue = true;
                serialized.FindProperty("m_dialogueChannel").objectReferenceValue =
                    EnsureDialogueChannel();

                SerializedProperty steps = serialized.FindProperty("m_steps");
                steps.arraySize = 2;

                SerializedProperty outburst = steps.GetArrayElementAtIndex(0);
                outburst.FindPropertyRelative("m_kind").enumValueIndex = (int)CueStepKind.PlayDialogue;
                outburst.FindPropertyRelative("m_delay").floatValue = 1.5f;
                outburst.FindPropertyRelative("m_conversation").objectReferenceValue =
                    LoadDialogue("DLG-009_TheyAreNotThere");

                SerializedProperty chase = steps.GetArrayElementAtIndex(1);
                chase.FindPropertyRelative("m_kind").enumValueIndex = (int)CueStepKind.RaiseFlag;
                chase.FindPropertyRelative("m_delay").floatValue = 0f;
                chase.FindPropertyRelative("m_flagId").stringValue = WorldFlags.k_ChaseStarted;

                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        // ---- Trigger configuration -------------------------------------------------------------

        private static void ConfigureVolumeTrigger(GameObject host, string dialogueFile, Vector3 size)
        {
            BoxCollider box = EnsureComponent<BoxCollider>(host);
            box.isTrigger = true;
            box.size = size;

            DialogueTrigger trigger = EnsureComponent<DialogueTrigger>(host);

            using (SerializedObject serialized = new SerializedObject(trigger))
            {
                serialized.FindProperty("m_conversation").objectReferenceValue =
                    LoadDialogue(dialogueFile);
                serialized.FindProperty("m_channel").objectReferenceValue = EnsureDialogueChannel();
                serialized.FindProperty("m_playOn").enumValueIndex =
                    (int)DialogueTrigger.Moment.OnPlayerEnter;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static void ConfigureFlagTrigger(GameObject host, string dialogueFile, string flagId)
        {
            DialogueTrigger trigger = EnsureComponent<DialogueTrigger>(host);

            using (SerializedObject serialized = new SerializedObject(trigger))
            {
                serialized.FindProperty("m_conversation").objectReferenceValue =
                    LoadDialogue(dialogueFile);
                serialized.FindProperty("m_channel").objectReferenceValue = EnsureDialogueChannel();
                serialized.FindProperty("m_playOn").enumValueIndex =
                    (int)DialogueTrigger.Moment.OnFlagRaised;
                serialized.FindProperty("m_flagId").stringValue = flagId;
                serialized.FindProperty("m_flagRaised").objectReferenceValue =
                    LoadRequired<StringEventChannelSO>(k_EventsFolder + "/FlagRaised.asset");
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static void ConfigureInteractTrigger(GameObject host, string dialogueFile,
            Vector3 size, string prompt)
        {
            // Solid, not a trigger: the interaction raycaster needs a surface to hit.
            BoxCollider box = EnsureComponent<BoxCollider>(host);
            box.isTrigger = false;
            box.size = size;

            DialogueTrigger trigger = EnsureComponent<DialogueTrigger>(host);

            using (SerializedObject serialized = new SerializedObject(trigger))
            {
                serialized.FindProperty("m_conversation").objectReferenceValue =
                    LoadDialogue(dialogueFile);
                serialized.FindProperty("m_channel").objectReferenceValue = EnsureDialogueChannel();
                serialized.FindProperty("m_playOn").enumValueIndex =
                    (int)DialogueTrigger.Moment.OnInteract;
                serialized.FindProperty("m_promptText").stringValue = prompt;
                serialized.FindProperty("m_fireOnce").boolValue = false;
                serialized.ApplyModifiedPropertiesWithoutUndo();
            }
        }

        private static DialogueSO LoadDialogue(string fileName)
        {
            DialogueSO conversation =
                AssetDatabase.LoadAssetAtPath<DialogueSO>($"{k_DialogueFolder}/{fileName}.asset");

            if (conversation == null)
            {
                Debug.LogWarning($"[Content] Conversation '{fileName}' is missing — run "
                    + "RootsDance > Content > Build Chapter 02 Dialogue, then this again.");
            }

            return conversation;
        }

        // ---- Scene helpers ---------------------------------------------------------------------

        private static T LoadRequired<T>(string path) where T : UnityEngine.Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new InvalidOperationException($"Required asset missing: {path}");
            }

            return asset;
        }

        private static T EnsureComponent<T>(GameObject target) where T : Component
        {
            T component = target.GetComponent<T>();
            return component != null ? component : target.AddComponent<T>();
        }

        private static Transform EnsureRoot(Scene scene, string name)
        {
            Transform existing = FindTransform(scene, name);

            if (existing != null)
            {
                return existing;
            }

            GameObject root = new GameObject(name);
            SceneManager.MoveGameObjectToScene(root, scene);
            return root.transform;
        }

        private static Transform EnsureChild(Transform parent, string name)
        {
            Transform existing = parent.Find(name);

            if (existing != null)
            {
                return existing;
            }

            GameObject child = new GameObject(name);
            child.transform.SetParent(parent, false);
            return child.transform;
        }

        /// <summary>The first component of this type anywhere in the scene, inactive ones included.</summary>
        private static T FindInScene<T>(Scene scene) where T : Component
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                T found = root.GetComponentInChildren<T>(true);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        private static Transform FindTransform(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root.transform;
                }

                Transform found = root.transform.Find(name);

                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }
    }
}
