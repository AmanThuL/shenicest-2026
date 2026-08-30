using RootsDance.Events;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace RootsDance.Editor.UI
{
    /// <summary>
    /// Builds the "press E" interaction hint as a plain overlay in Bootstrap, driven by
    /// <see cref="InteractionPromptPresenter"/>.
    /// <para>
    /// Deliberately not part of <c>HelmetHudCanvas</c>: the hint has nothing to do with whether the
    /// player is wearing a helmet, and most of the game is not — nesting it under the visor's
    /// <c>VisorRoot</c> would carry it off-screen with the glass on the one level that still plays
    /// the removal. Built here instead, in the one scene every level loads, so every level gets the
    /// hint without a per-level HUD build.
    /// </para>
    /// Idempotent: re-running finds what it made last time and rewrites it. Restores whatever scene
    /// set was open before it ran, the same guard <c>NarrativeRuntimeBuilder</c> uses for the same
    /// Single-open-Bootstrap step.
    /// Menu: RootsDance &gt; UI &gt; Build Interaction Hud.
    /// </summary>
    public static class InteractionHudBuilder
    {
        private const string k_BootstrapScenePath = "Assets/RootsDance/Scenes/Bootstrap.unity";
        private const string k_CanvasName = "InteractionHudCanvas";
        private const string k_LabelName = "InteractPrompt";
        private const string k_FontPath = "Assets/RootsDance/Fonts/m5x7 SDF.asset";

        private const string k_EventsFolder = "Assets/RootsDance/Data/Events";
        private const string k_PromptChannelPath = k_EventsFolder + "/InteractionPrompt.asset";
        private const string k_ConversationStartedPath = k_EventsFolder + "/ConversationStarted.asset";
        private const string k_ConversationEndedPath = k_EventsFolder + "/ConversationEnded.asset";

        /// <summary>Above the subtitle line (5), below the dialogue screen (10): a conversation
        /// covers the hint, the same relationship <see cref="InteractionPromptPresenter"/> already
        /// enforces logically through the conversation-started/ended channels.</summary>
        private const int k_SortingOrder = 8;

        private static readonly Vector2 k_LabelSize = new Vector2(520f, 140f);

        /// <summary>Centred, low on the screen — the position the visor's own copy of this label
        /// used, so the hint reads the same wherever it ends up living.</summary>
        private static readonly Vector2 k_LabelAnchoredPosition = new Vector2(0f, 170f);

        [MenuItem("RootsDance/UI/Build Interaction Hud")]
        public static void Build()
        {
            SceneSetup[] originalSetup = EditorSceneManager.GetSceneManagerSetup();

            try
            {
                Scene scene = EditorSceneManager.OpenScene(k_BootstrapScenePath, OpenSceneMode.Single);

                GameObject canvasGo = EnsureRoot(scene, k_CanvasName);

                Canvas canvas = EnsureComponent<Canvas>(canvasGo);
                canvas.renderMode = RenderMode.ScreenSpaceOverlay;
                canvas.sortingOrder = k_SortingOrder;

                CanvasScaler scaler = EnsureComponent<CanvasScaler>(canvasGo);
                scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
                scaler.referenceResolution = new Vector2(1920f, 1080f);
                scaler.matchWidthOrHeight = 0.5f;

                TextMeshProUGUI label = EnsureLabel(canvasGo.transform);
                WirePresenter(canvasGo, label);

                EditorSceneManager.MarkSceneDirty(scene);
                EditorSceneManager.SaveScene(scene);

                Debug.Log($"InteractionHudBuilder: {k_CanvasName} built and "
                    + $"{k_BootstrapScenePath} saved.");
            }
            finally
            {
                if (originalSetup.Length > 0)
                {
                    EditorSceneManager.RestoreSceneManagerSetup(originalSetup);
                }
            }
        }

        private static TextMeshProUGUI EnsureLabel(Transform parent)
        {
            Transform existing = parent.Find(k_LabelName);
            GameObject labelGo = existing == null ? new GameObject(k_LabelName) : existing.gameObject;

            if (existing == null)
            {
                labelGo.transform.SetParent(parent, false);
            }

            RectTransform rect = EnsureComponent<RectTransform>(labelGo);
            rect.anchorMin = new Vector2(0.5f, 0f);
            rect.anchorMax = new Vector2(0.5f, 0f);
            rect.pivot = new Vector2(0.5f, 0f);
            rect.anchoredPosition = k_LabelAnchoredPosition;
            rect.sizeDelta = k_LabelSize;

            TextMeshProUGUI label = EnsureComponent<TextMeshProUGUI>(labelGo);
            label.fontSize = 34f;
            label.alignment = TextAlignmentOptions.Bottom;
            label.textWrappingMode = TextWrappingModes.Normal;
            label.raycastTarget = false;

            TMP_FontAsset font = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(k_FontPath);

            if (font != null)
            {
                label.font = font;
            }

            return label;
        }

        private static void WirePresenter(GameObject canvasGo, TextMeshProUGUI label)
        {
            InteractionPromptPresenter presenter = EnsureComponent<InteractionPromptPresenter>(canvasGo);

            SerializedObject serialized = new SerializedObject(presenter);
            serialized.FindProperty("m_promptChanged").objectReferenceValue =
                LoadRequired<StringEventChannelSO>(k_PromptChannelPath);
            serialized.FindProperty("m_conversationStarted").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<VoidEventChannelSO>(k_ConversationStartedPath);
            serialized.FindProperty("m_conversationEnded").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<VoidEventChannelSO>(k_ConversationEndedPath);
            serialized.FindProperty("m_label").objectReferenceValue = label;
            serialized.ApplyModifiedPropertiesWithoutUndo();
        }

        private static GameObject EnsureRoot(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root;
                }
            }

            GameObject go = new GameObject(name);
            SceneManager.MoveGameObjectToScene(go, scene);
            return go;
        }

        private static T EnsureComponent<T>(GameObject target) where T : Component
        {
            T component = target.GetComponent<T>();
            return component != null ? component : target.AddComponent<T>();
        }

        private static T LoadRequired<T>(string path) where T : Object
        {
            T asset = AssetDatabase.LoadAssetAtPath<T>(path);

            if (asset == null)
            {
                throw new System.InvalidOperationException($"Required asset missing: {path}");
            }

            return asset;
        }
    }
}
