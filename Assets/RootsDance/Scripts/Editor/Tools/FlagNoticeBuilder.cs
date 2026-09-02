using RootsDance.Core;
using RootsDance.Events;
using RootsDance.UI;
using TMPro;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Puts the story-notice line on the bootstrap HUD and fills its table.
    /// <para>
    /// The line lives in <c>Bootstrap.unity</c> beside the interaction prompt, not on the helmet
    /// canvas: the helmet is off by the time the corridor beat runs, and everything under the visor
    /// root goes with it. It borrows the prompt's own font so the two read as one device.
    /// </para>
    /// <para>
    /// Idempotent: it rebuilds the widget and rewires it, and the table is authored here so a
    /// rebuild cannot silently drop a line. Saves the bootstrap scene, like the other HUD builders.
    /// </para>
    /// Menu: RootsDance > Build Flag Notice (Bootstrap).
    /// </summary>
    public static class FlagNoticeBuilder
    {
        private const string k_BootstrapPath = "Assets/RootsDance/Scenes/Bootstrap.unity";
        private const string k_FlagRaisedPath = "Assets/RootsDance/Data/Events/FlagRaised.asset";
        private const string k_CanvasName = "InteractionHudCanvas";
        private const string k_NoticeName = "FlagNotice";

        /// <summary>Above the interaction prompt, which sits at y 170 and moves down from there.</summary>
        private static readonly Vector2 k_AnchoredPosition = new Vector2(0f, 300f);

        private static readonly Vector2 k_Size = new Vector2(900f, 90f);

        private const float k_FontSize = 34f;

        /// <summary>The readouts' green. The device speaks in one colour.</summary>
        private static readonly Color k_Color = new Color(0.78f, 0.86f, 0.80f, 0.92f);

        [MenuItem("RootsDance/Build Flag Notice (Bootstrap)")]
        public static void Build()
        {
            Scene scene = EditorSceneManager.GetSceneByPath(k_BootstrapPath);

            if (!scene.isLoaded)
            {
                scene = EditorSceneManager.OpenScene(k_BootstrapPath, OpenSceneMode.Additive);
            }

            GameObject canvas = Find(scene, k_CanvasName);

            if (canvas == null)
            {
                Debug.LogError($"FlagNoticeBuilder: no '{k_CanvasName}' in {k_BootstrapPath}.");
                return;
            }

            TMP_FontAsset font = BorrowFont(canvas);
            GameObject notice = EnsureNotice(canvas, font);

            Wire(notice);

            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);

            Debug.Log($"FlagNoticeBuilder: '{k_NoticeName}' built under '{k_CanvasName}' and "
                + $"{k_BootstrapPath} saved.", notice);
        }

        /// <summary>The interaction prompt's font, so the notice is the same device talking.</summary>
        private static TMP_FontAsset BorrowFont(GameObject canvas)
        {
            InteractionPromptPresenter prompt = canvas.GetComponentInChildren<InteractionPromptPresenter>(true);

            if (prompt == null)
            {
                return null;
            }

            TextMeshProUGUI label = prompt.GetComponentInChildren<TextMeshProUGUI>(true);

            return label == null ? null : label.font;
        }

        private static GameObject EnsureNotice(GameObject canvas, TMP_FontAsset font)
        {
            Transform existing = canvas.transform.Find(k_NoticeName);
            GameObject notice = existing == null ? null : existing.gameObject;

            if (notice == null)
            {
                notice = new GameObject(k_NoticeName, typeof(RectTransform));
                notice.transform.SetParent(canvas.transform, false);
            }

            RectTransform rect = (RectTransform)notice.transform;
            rect.anchorMin = new Vector2(0.5f, 0f);
            rect.anchorMax = new Vector2(0.5f, 0f);
            rect.pivot = new Vector2(0.5f, 0f);
            rect.anchoredPosition = k_AnchoredPosition;
            rect.sizeDelta = k_Size;

            TextMeshProUGUI label = notice.GetComponent<TextMeshProUGUI>();

            if (label == null)
            {
                label = notice.AddComponent<TextMeshProUGUI>();
            }

            if (font != null)
            {
                label.font = font;
            }

            label.text = string.Empty;
            label.fontSize = k_FontSize;
            label.color = k_Color;
            label.alignment = TextAlignmentOptions.Center;
            label.raycastTarget = false;

            // Starts off: the notice is only ever on while it is saying something.
            notice.SetActive(false);

            return notice;
        }

        /// <summary>
        /// The table. Authored here rather than left to the Inspector because the flag id and the
        /// line have to agree, and a typo in the id is silent — the beat simply says nothing.
        /// </summary>
        private static void Wire(GameObject notice)
        {
            FlagNoticePresenter presenter = notice.GetComponent<FlagNoticePresenter>();

            if (presenter == null)
            {
                presenter = notice.AddComponent<FlagNoticePresenter>();
            }

            SerializedObject so = new SerializedObject(presenter);

            so.FindProperty("m_flagRaised").objectReferenceValue =
                AssetDatabase.LoadAssetAtPath<StringEventChannelSO>(k_FlagRaisedPath);
            so.FindProperty("m_root").objectReferenceValue = notice;
            so.FindProperty("m_label").objectReferenceValue = notice.GetComponent<TextMeshProUGUI>();
            so.FindProperty("m_visibleSeconds").floatValue = 3f;

            SerializedProperty bindings = so.FindProperty("m_bindings");
            bindings.arraySize = 1;

            SerializedProperty algae = bindings.GetArrayElementAtIndex(0);
            algae.FindPropertyRelative("m_flagId").stringValue = WorldFlags.k_FlashlightPowered;
            algae.FindPropertyRelative("m_text").stringValue = "荧光藻已装入手电筒";

            so.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(presenter);
        }

        private static GameObject Find(Scene scene, string name)
        {
            foreach (GameObject root in scene.GetRootGameObjects())
            {
                if (root.name == name)
                {
                    return root;
                }
            }

            return null;
        }
    }
}
