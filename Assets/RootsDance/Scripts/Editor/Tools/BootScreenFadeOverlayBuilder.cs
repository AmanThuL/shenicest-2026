using System;
using RootsDance.UI;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace RootsDance.Editor.Tools
{
    /// <summary>
    /// Adds the independent blackout canvas used for the hand-off from a playable level to the
    /// between-scenes boot screen. The canvas deliberately stays outside BootScreenCover's switched
    /// canvas list so it can cover the outgoing level before the boot screen itself is enabled.
    /// </summary>
    public static class BootScreenFadeOverlayBuilder
    {
        private const string k_PrefabPath =
            "Assets/RootsDance/Prefabs/UI/BootScreen/BootScreenCover.prefab";
        private const string k_OverlayName = "BlackoutCanvas";
        private const string k_ImageName = "BlackoutImage";

        [MenuItem("RootsDance/UI/Wire Boot Screen Fade Overlay")]
        public static void ApplyFromMenu()
        {
            ApplyAndSave();
        }

        /// <summary>Batch-mode entry point for deterministic prefab wiring.</summary>
        public static void ApplyFromCommandLine()
        {
            ApplyAndSave();
        }

        public static void ApplyAndSave()
        {
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(k_PrefabPath);

            if (prefab == null)
            {
                throw new InvalidOperationException($"Boot screen prefab was not found at '{k_PrefabPath}'.");
            }

            GameObject root = PrefabUtility.LoadPrefabContents(k_PrefabPath);

            try
            {
                BootScreenCover cover = root.GetComponent<BootScreenCover>();

                if (cover == null)
                {
                    throw new InvalidOperationException(
                        $"Boot screen prefab '{k_PrefabPath}' is missing {nameof(BootScreenCover)}.");
                }

                int uiLayer = LayerMask.NameToLayer("UI");

                if (uiLayer < 0)
                {
                    throw new InvalidOperationException("The required UI layer does not exist.");
                }

                GameObject overlay = EnsureUiChild(root.transform, k_OverlayName, uiLayer);
                overlay.SetActive(true);
                overlay.transform.SetAsLastSibling();

                Canvas canvas = GetOrAddComponent<Canvas>(overlay);
                canvas.renderMode = RenderMode.ScreenSpaceOverlay;
                canvas.overrideSorting = true;
                canvas.sortingOrder = short.MaxValue;
                canvas.pixelPerfect = false;

                CanvasGroup group = GetOrAddComponent<CanvasGroup>(overlay);
                group.alpha = 0f;
                group.interactable = false;
                group.blocksRaycasts = false;
                group.ignoreParentGroups = true;

                // A raycaster makes CanvasGroup.blocksRaycasts meaningful during the fade. The
                // Bootstrap scene still owns the project's single EventSystem.
                GetOrAddComponent<GraphicRaycaster>(overlay);

                FullscreenFadePresenter fade = GetOrAddComponent<FullscreenFadePresenter>(overlay);
                fade.enabled = true;

                GameObject imageObject = EnsureUiChild(overlay.transform, k_ImageName, uiLayer);
                Image image = GetOrAddComponent<Image>(imageObject);
                image.color = Color.black;
                image.raycastTarget = true;

                SerializedObject serializedCover = new SerializedObject(cover);
                SerializedProperty fadeProperty = serializedCover.FindProperty("m_fullscreenFade");

                if (fadeProperty == null)
                {
                    throw new InvalidOperationException(
                        $"{nameof(BootScreenCover)} no longer has the expected m_fullscreenFade field.");
                }

                fadeProperty.objectReferenceValue = fade;
                serializedCover.ApplyModifiedPropertiesWithoutUndo();

                PrefabUtility.SaveAsPrefabAsset(root, k_PrefabPath, out bool saved);

                if (!saved)
                {
                    throw new InvalidOperationException(
                        $"Failed to save the boot screen fade overlay to '{k_PrefabPath}'.");
                }
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(root);
            }

            AssetDatabase.SaveAssets();
            Debug.Log("BootScreenFadeOverlayBuilder: wired the independent blackout canvas.");
        }

        private static GameObject EnsureUiChild(Transform parent, string name, int layer)
        {
            Transform existing = FindDirectChild(parent, name);
            GameObject child;

            if (existing == null)
            {
                child = new GameObject(name, typeof(RectTransform));
                child.transform.SetParent(parent, false);
            }
            else
            {
                child = existing.gameObject;

                if (!(existing is RectTransform))
                {
                    throw new InvalidOperationException(
                        $"Existing '{name}' under '{parent.name}' must use a RectTransform.");
                }
            }

            child.name = name;
            child.layer = layer;

            RectTransform rect = (RectTransform)child.transform;
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.pivot = new Vector2(0.5f, 0.5f);
            rect.anchoredPosition = Vector2.zero;
            rect.sizeDelta = Vector2.zero;
            rect.localRotation = Quaternion.identity;
            rect.localScale = Vector3.one;

            return child;
        }

        private static Transform FindDirectChild(Transform parent, string name)
        {
            for (int i = 0; i < parent.childCount; i++)
            {
                Transform child = parent.GetChild(i);

                if (child.name == name)
                {
                    return child;
                }
            }

            return null;
        }

        private static T GetOrAddComponent<T>(GameObject gameObject) where T : Component
        {
            T component = gameObject.GetComponent<T>();

            if (component == null)
            {
                component = gameObject.AddComponent<T>();
            }

            return component;
        }
    }
}
