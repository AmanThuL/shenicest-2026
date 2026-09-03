using System;
using System.Collections.Generic;
using System.IO;
using RootsDance.App;
using RootsDance.Core;
using RootsDance.Data;
using RootsDance.Editor.DevPlay;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.UI;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Object = UnityEngine.Object;

namespace RootsDance.Editor.Tools
{
    /// <summary>Scoped installer: only the rescue prefab, input asset, catalog and Bootstrap are saved.</summary>
    public static class CheckpointRescueBuilder
    {
        public const string k_PrefabPath = "Assets/RootsDance/Prefabs/UI/CheckpointRescue.prefab";
        private const string k_InputPath = "Assets/RootsDance/Input/RootsDance.inputactions";
        private const string k_FontPath = "Assets/TextMesh Pro/Resources/Fonts & Materials/LiberationSans SDF.asset";
        private static readonly Color k_Background = new Color(0.035f, 0.05f, 0.065f, 0.98f);
        private static readonly Color k_Button = new Color(0.13f, 0.21f, 0.24f, 1f);

        [MenuItem("RootsDance/Dev Play/Install Build Checkpoint Rescue")]
        public static void Build()
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode)
            {
                throw new InvalidOperationException("Exit Play mode before installing checkpoint rescue.");
            }

            for (int i = 0; i < SceneManager.sceneCount; i++)
            {
                if (SceneManager.GetSceneAt(i).isDirty)
                {
                    throw new InvalidOperationException("Save or discard dirty scenes before installing rescue UI.");
                }
            }

            SceneSetup[] setup = EditorSceneManager.GetSceneManagerSetup();
            try
            {
                RescueCheckpointExporter.RefreshCatalog();
                InstallInput();
                BuildPrefab(RecordingModeInstaller.EnsureAsset());
                RecordingModeInstaller.InstallHiders();
                Scene scene = EditorSceneManager.OpenScene(ScenePaths.k_Bootstrap, OpenSceneMode.Single);
                // Opening Single unloads unreferenced assets. Resolve saved assets only after it,
                // or a first install silently serializes a fake-null catalog reference.
                RescueCheckpointCatalogSO catalog = AssetDatabase.LoadAssetAtPath<RescueCheckpointCatalogSO>(
                    RescueCheckpointExporter.k_CatalogPath);
                GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PrefabPath);
                if (catalog == null || prefab == null)
                {
                    throw new InvalidOperationException("Generated rescue assets could not be loaded.");
                }

                GameBootstrap bootstrap = FindInScene<GameBootstrap>(scene);
                if (bootstrap == null)
                {
                    throw new InvalidOperationException("Bootstrap scene has no GameBootstrap.");
                }

                SceneLoader loader = bootstrap.GetComponent<SceneLoader>();
                if (loader == null)
                {
                    throw new InvalidOperationException("GameBootstrap has no SceneLoader.");
                }

                CheckpointRescueService service = bootstrap.GetComponent<CheckpointRescueService>();
                if (service == null)
                {
                    service = bootstrap.gameObject.AddComponent<CheckpointRescueService>();
                }

                SetReference(service, "m_bootstrap", bootstrap);
                SetReference(service, "m_sceneLoader", loader);
                SetReference(service, "m_catalog", catalog);
                WireParticipants(service, scene);
                SetReference(bootstrap, "m_rescueService", service);
                Canvas canvas = EnsureCanvas(scene);
                EnsureEventSystem(scene);
                CheckpointRescuePresenter presenter = FindInScene<CheckpointRescuePresenter>(scene);
                if (presenter == null)
                {
                    var instance = (GameObject)PrefabUtility.InstantiatePrefab(prefab, scene);
                    instance.transform.SetParent(canvas.transform, false);
                    presenter = instance.GetComponent<CheckpointRescuePresenter>();
                }

                presenter.transform.SetAsLastSibling();
                SetReference(presenter, "m_serviceBehaviour", service);
                PrefabUtility.RecordPrefabInstancePropertyModifications(presenter);
                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);
            }
            finally
            {
                EditorSceneManager.RestoreSceneManagerSetup(setup);
            }
        }

        private static void InstallInput()
        {
            InputActionAsset source = AssetDatabase.LoadAssetAtPath<InputActionAsset>(k_InputPath);
            if (source == null)
            {
                throw new InvalidOperationException("Project-wide input asset is missing.");
            }

            InputActionAsset asset = InputActionAsset.FromJson(source.ToJson());
            try
            {
                InputActionMap map = asset.FindActionMap("Debug") ?? asset.AddActionMap("Debug");
                if (map.FindAction("ToggleCheckpointRescue") == null)
                {
                    InputAction toggle = map.AddAction("ToggleCheckpointRescue", InputActionType.Button);
                    toggle.AddCompositeBinding("ButtonWithTwoModifiers")
                        .With("Modifier1", "<Keyboard>/ctrl")
                        .With("Modifier2", "<Keyboard>/shift")
                        .With("Button", "<Keyboard>/d");
                }

                if (map.FindAction("CloseCheckpointRescue") == null)
                {
                    map.AddAction("CloseCheckpointRescue", InputActionType.Button, "<Keyboard>/escape");
                }

                string json = asset.ToJson();
                if (json != source.ToJson())
                {
                    File.WriteAllText(k_InputPath, json);
                    AssetDatabase.ImportAsset(k_InputPath, ImportAssetOptions.ForceUpdate);
                }
            }
            finally
            {
                Object.DestroyImmediate(asset);
            }
        }

        private static void WireParticipants(CheckpointRescueService service, Scene scene)
        {
            var participants = new List<MonoBehaviour>();
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                foreach (MonoBehaviour behaviour in root.GetComponentsInChildren<MonoBehaviour>(true))
                {
                    if (behaviour is IRescueResetParticipant || behaviour is IRescueStateRestoredParticipant)
                    {
                        participants.Add(behaviour);
                    }
                }
            }

            var serialized = new SerializedObject(service);
            SerializedProperty property = serialized.FindProperty("m_participants");
            property.arraySize = participants.Count;
            for (int i = 0; i < participants.Count; i++)
            {
                property.GetArrayElementAtIndex(i).objectReferenceValue = participants[i];
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static GameObject BuildPrefab(RecordingModeSO recordingMode)
        {
            TMP_FontAsset font = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontPath);
            if (font == null)
            {
                throw new InvalidOperationException("Rescue UI requires the existing Liberation Sans TMP font.");
            }

            RectTransform root = Rect("CheckpointRescue", null);
            try
            {
                Stretch(root);
                Canvas overlay = root.gameObject.AddComponent<Canvas>();
                overlay.overrideSorting = true;
                overlay.sortingOrder = 32760;
                root.gameObject.AddComponent<GraphicRaycaster>();
                CheckpointRescuePresenter presenter = root.gameObject.AddComponent<CheckpointRescuePresenter>();
                RectTransform blocker = Rect("ModalBlocker", root);
                Stretch(blocker);
                blocker.gameObject.AddComponent<Image>().color = new Color(0f, 0f, 0f, 0.8f);
                RectTransform panel = Rect("Panel", blocker);
                panel.anchorMin = new Vector2(0.12f, 0.08f);
                panel.anchorMax = new Vector2(0.88f, 0.92f);
                panel.offsetMin = Vector2.zero;
                panel.offsetMax = Vector2.zero;
                panel.gameObject.AddComponent<Image>().color = k_Background;
                Label("Title", panel, font, "DEVELOPER / CHECKPOINT RESCUE", 30,
                    new Vector2(0.035f, 0.89f), new Vector2(0.965f, 0.97f));
                TextMeshProUGUI status = Label("Status", panel, font, "Current level", 24,
                    new Vector2(0.035f, 0.77f), new Vector2(0.965f, 0.89f));
                RectTransform scrollRoot = Rect("CheckpointList", panel);
                Anchor(scrollRoot, new Vector2(0.035f, 0.41f), new Vector2(0.965f, 0.75f));
                CanvasGroup listGroup = scrollRoot.gameObject.AddComponent<CanvasGroup>();
                ScrollRect scroll = scrollRoot.gameObject.AddComponent<ScrollRect>();
                scroll.horizontal = false;
                scroll.movementType = ScrollRect.MovementType.Clamped;
                scroll.scrollSensitivity = 32f;
                RectTransform viewport = Rect("Viewport", scrollRoot);
                Stretch(viewport);
                viewport.gameObject.AddComponent<Image>().color = new Color(0.02f, 0.03f, 0.04f, 1f);
                viewport.gameObject.AddComponent<RectMask2D>();
                RectTransform content = Rect("Content", viewport);
                content.anchorMin = new Vector2(0f, 1f);
                content.anchorMax = Vector2.one;
                content.pivot = new Vector2(0.5f, 1f);
                content.sizeDelta = Vector2.zero;
                VerticalLayoutGroup layout = content.gameObject.AddComponent<VerticalLayoutGroup>();
                layout.padding = new RectOffset(8, 8, 8, 8);
                layout.spacing = 6f;
                layout.childControlHeight = true;
                layout.childControlWidth = true;
                layout.childForceExpandHeight = false;
                ContentSizeFitter fitter = content.gameObject.AddComponent<ContentSizeFitter>();
                fitter.verticalFit = ContentSizeFitter.FitMode.PreferredSize;
                scroll.viewport = viewport;
                scroll.content = content;
                Button rowButton = Button("CheckpointRow", content, font, "Checkpoint", out TextMeshProUGUI rowLabel);
                LayoutElement rowLayout = rowButton.gameObject.AddComponent<LayoutElement>();
                rowLayout.preferredHeight = 48f;
                CheckpointRescueRow row = rowButton.gameObject.AddComponent<CheckpointRescueRow>();
                SetReference(row, "m_button", rowButton);
                SetReference(row, "m_label", rowLabel);
                row.gameObject.SetActive(false);
                Toggle[] recordingToggles = BuildRecordingSection(panel, font, recordingMode);
                TextMeshProUGUI details = Label("Details", panel, font, "Select a checkpoint.", 22,
                    new Vector2(0.035f, 0.12f), new Vector2(0.965f, 0.29f));
                Button close = Button("Close", panel, font, "Close / Esc", out _);
                Anchor((RectTransform)close.transform, new Vector2(0.035f, 0.035f), new Vector2(0.32f, 0.10f));
                Button jump = Button("Jump", panel, font, "Reset and jump", out TextMeshProUGUI jumpLabel);
                Anchor((RectTransform)jump.transform, new Vector2(0.50f, 0.035f), new Vector2(0.965f, 0.10f));
                SetReference(presenter, "m_panel", blocker.gameObject);
                SetReference(presenter, "m_status", status);
                SetReference(presenter, "m_details", details);
                SetReference(presenter, "m_jumpLabel", jumpLabel);
                SetReference(presenter, "m_close", close);
                SetReference(presenter, "m_jump", jump);
                SetReference(presenter, "m_listGroup", listGroup);
                SetReference(presenter, "m_list", content);
                SetReference(presenter, "m_rowTemplate", row);
                SetReferences(presenter, "m_recordingToggles", recordingToggles);
                blocker.gameObject.SetActive(false);
                return PrefabUtility.SaveAsPrefabAsset(root.gameObject, k_PrefabPath);
            }
            finally
            {
                Object.DestroyImmediate(root.gameObject);
            }
        }

        /// <summary>
        /// The "no UI while recording" row: one master switch and one box per hidden group. Every
        /// box carries its own <see cref="RecordingModeToggle"/>; the presenter only threads them
        /// into keyboard navigation. Order here is reading order.
        /// </summary>
        private static Toggle[] BuildRecordingSection(Transform panel, TMP_FontAsset font,
            RecordingModeSO recordingMode)
        {
            Label("RecordingCaption", panel, font, "RECORDING  /  hide while capturing footage", 18,
                new Vector2(0.035f, 0.375f), new Vector2(0.965f, 0.40f));

            var toggles = new List<Toggle>
            {
                RecordingToggle("RecordingMaster", panel, font, recordingMode, "Recording mode (hide UI)",
                    isMaster: true, RecordingHiddenUi.None, 0.035f, 0.33f),
                RecordingToggle("HideHints", panel, font, recordingMode, "Hints",
                    isMaster: false, RecordingHiddenUi.InteractionHints, 0.345f, 0.49f),
                RecordingToggle("HideDialogue", panel, font, recordingMode, "Dialogue",
                    isMaster: false, RecordingHiddenUi.Dialogue, 0.50f, 0.655f),
                RecordingToggle("HideSubtitles", panel, font, recordingMode, "Subtitles",
                    isMaster: false, RecordingHiddenUi.Subtitles, 0.665f, 0.815f),
                RecordingToggle("HideHelmetHud", panel, font, recordingMode, "Helmet HUD",
                    isMaster: false, RecordingHiddenUi.HelmetHud, 0.825f, 0.965f)
            };

            return toggles.ToArray();
        }

        private static Toggle RecordingToggle(string name, Transform parent, TMP_FontAsset font,
            RecordingModeSO recordingMode, string text, bool isMaster, RecordingHiddenUi group,
            float xMin, float xMax)
        {
            RectTransform rect = Rect(name, parent);
            Anchor(rect, new Vector2(xMin, 0.31f), new Vector2(xMax, 0.37f));
            RectTransform box = Rect("Box", rect);
            box.anchorMin = new Vector2(0f, 0.5f);
            box.anchorMax = new Vector2(0f, 0.5f);
            box.pivot = new Vector2(0f, 0.5f);
            box.anchoredPosition = Vector2.zero;
            box.sizeDelta = new Vector2(28f, 28f);
            Image background = box.gameObject.AddComponent<Image>();
            background.color = k_Button;
            RectTransform mark = Rect("Checkmark", box);
            Anchor(mark, new Vector2(0.2f, 0.2f), new Vector2(0.8f, 0.8f));
            Image check = mark.gameObject.AddComponent<Image>();
            check.color = new Color(0.55f, 0.95f, 0.80f, 1f);
            check.raycastTarget = false;
            Toggle toggle = rect.gameObject.AddComponent<Toggle>();
            toggle.targetGraphic = background;
            toggle.graphic = check;
            toggle.isOn = false;
            TextMeshProUGUI label = Label("Label", rect, font, text, 20, Vector2.zero, Vector2.one);
            label.rectTransform.offsetMin = new Vector2(36f, 0f);
            label.alignment = TextAlignmentOptions.MidlineLeft;
            // The label is part of the click target; a 28px box alone is a fiddly thing to hit.
            label.raycastTarget = true;
            RecordingModeToggle binding = rect.gameObject.AddComponent<RecordingModeToggle>();
            SetReference(binding, "m_mode", recordingMode);
            SetReference(binding, "m_toggle", toggle);
            var serialized = new SerializedObject(binding);
            serialized.FindProperty("m_isMasterSwitch").boolValue = isMaster;
            serialized.FindProperty("m_group").intValue = (int)group;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            return toggle;
        }

        private static Canvas EnsureCanvas(Scene scene)
        {
            Canvas canvas = FindInScene<Canvas>(scene);
            if (canvas != null)
            {
                if (canvas.renderMode != RenderMode.ScreenSpaceOverlay)
                {
                    throw new InvalidOperationException("Bootstrap Canvas must use Screen Space Overlay.");
                }

                if (canvas.GetComponent<GraphicRaycaster>() == null)
                {
                    canvas.gameObject.AddComponent<GraphicRaycaster>();
                }

                return canvas;
            }

            RectTransform root = Rect("Canvas", null);
            SceneManager.MoveGameObjectToScene(root.gameObject, scene);
            canvas = root.gameObject.AddComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;
            CanvasScaler scaler = root.gameObject.AddComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(1920f, 1080f);
            scaler.matchWidthOrHeight = 0.5f;
            root.gameObject.AddComponent<GraphicRaycaster>();
            return canvas;
        }

        private static void EnsureEventSystem(Scene scene)
        {
            EventSystem eventSystem = FindInScene<EventSystem>(scene);
            if (eventSystem != null)
            {
                if (eventSystem.GetComponent<InputSystemUIInputModule>() == null)
                {
                    throw new InvalidOperationException("Existing EventSystem needs InputSystemUIInputModule.");
                }

                return;
            }

            var root = new GameObject("EventSystem", typeof(EventSystem), typeof(InputSystemUIInputModule));
            SceneManager.MoveGameObjectToScene(root, scene);
            InputSystemUIInputModule module = root.GetComponent<InputSystemUIInputModule>();
            module.actionsAsset = AssetDatabase.LoadAssetAtPath<InputActionAsset>(k_InputPath);
            WireUiAction(module, "point", "UI/Point");
            WireUiAction(module, "leftClick", "UI/Click");
            WireUiAction(module, "scrollWheel", "UI/ScrollWheel");
            WireUiAction(module, "move", "UI/Navigate");
            WireUiAction(module, "submit", "UI/Submit");
            WireUiAction(module, "cancel", "UI/Cancel");
        }

        private static void WireUiAction(InputSystemUIInputModule module, string property, string actionName)
        {
            InputAction action = module.actionsAsset.FindAction(actionName);
            foreach (Object asset in AssetDatabase.LoadAllAssetsAtPath(k_InputPath))
            {
                if (asset is InputActionReference reference && reference.action != null
                    && action != null && reference.action.id == action.id)
                {
                    var serialized = new SerializedObject(module);
                    string field = "m_" + char.ToUpperInvariant(property[0]) + property.Substring(1) + "Action";
                    serialized.FindProperty(field).objectReferenceValue = reference;
                    serialized.ApplyModifiedPropertiesWithoutUndo();
                    return;
                }
            }

            throw new InvalidOperationException("Missing imported UI action reference: " + actionName);
        }

        private static T FindInScene<T>(Scene scene) where T : Component
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                T component = root.GetComponentInChildren<T>(true);
                if (component != null)
                {
                    return component;
                }
            }

            return null;
        }

        private static RectTransform Rect(string name, Transform parent)
        {
            var rect = (RectTransform)new GameObject(name, typeof(RectTransform)).transform;
            rect.SetParent(parent, false);
            return rect;
        }

        private static void Stretch(RectTransform rect)
        {
            Anchor(rect, Vector2.zero, Vector2.one);
        }

        private static void Anchor(RectTransform rect, Vector2 min, Vector2 max)
        {
            rect.anchorMin = min;
            rect.anchorMax = max;
            rect.offsetMin = Vector2.zero;
            rect.offsetMax = Vector2.zero;
        }

        private static TextMeshProUGUI Label(string name, Transform parent, TMP_FontAsset font,
            string text, int size, Vector2 min, Vector2 max)
        {
            RectTransform rect = Rect(name, parent);
            Anchor(rect, min, max);
            TextMeshProUGUI label = rect.gameObject.AddComponent<TextMeshProUGUI>();
            label.font = font;
            label.fontSize = size;
            label.text = text;
            label.color = new Color(0.87f, 0.93f, 0.94f);
            label.raycastTarget = false;
            label.overflowMode = TextOverflowModes.Ellipsis;
            return label;
        }

        private static Button Button(string name, Transform parent, TMP_FontAsset font,
            string text, out TextMeshProUGUI label)
        {
            RectTransform rect = Rect(name, parent);
            Image image = rect.gameObject.AddComponent<Image>();
            image.color = k_Button;
            Button button = rect.gameObject.AddComponent<Button>();
            button.targetGraphic = image;
            label = Label("Label", rect, font, text, 24, new Vector2(0.025f, 0f), new Vector2(0.975f, 1f));
            label.alignment = TextAlignmentOptions.MidlineLeft;
            return button;
        }

        private static void SetReferences(Object target, string field, Object[] values)
        {
            var serialized = new SerializedObject(target);
            SerializedProperty property = serialized.FindProperty(field);
            if (property == null)
            {
                throw new InvalidOperationException(target.GetType().Name + " is missing " + field);
            }

            property.arraySize = values.Length;
            for (int i = 0; i < values.Length; i++)
            {
                property.GetArrayElementAtIndex(i).objectReferenceValue = values[i];
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static void SetReference(Object target, string field, Object value)
        {
            var serialized = new SerializedObject(target);
            SerializedProperty property = serialized.FindProperty(field);
            if (property == null)
            {
                throw new InvalidOperationException(target.GetType().Name + " is missing " + field);
            }

            property.objectReferenceValue = value;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }
    }
}
