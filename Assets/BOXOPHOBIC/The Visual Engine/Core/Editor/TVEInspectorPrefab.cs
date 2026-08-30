//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using System.Collections.Generic;

namespace TheVisualEngine
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(TVEPrefab))]
    public class TVEInspectorPrefab : Editor
    {
        string excludeProps = "m_Script";
        TVEPrefab targetScript;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;

        Renderer impostorRenderer = null;
        Material impostorMaterial = null;

        void OnEnable()
        {
            targetScript = (TVEPrefab)target;

            TVEEvents.TVEOnAssetsSaved += GetImpostorMaterial;

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Prefab";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();

            GetImpostorMaterial();
        }

        void OnDisable()
        {
            TVEEvents.TVEOnAssetsSaved -= GetImpostorMaterial;
        }

        void OnDestroy()
        {
            TVEEvents.TVEOnAssetsSaved -= GetImpostorMaterial;
        }

        public override void OnInspectorGUI()
        {
            var styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleRight,
                wordWrap = true,
            };

            StyledGUI.DrawInspectorBanner(bannerColor, bannerLabel, bannerVersion);

            var hasOverrides = false;
            var isStatic = false;

            if (!Application.isPlaying && PrefabUtility.IsPartOfPrefabInstance(targetScript.gameObject))
            {
                var overrides = PrefabUtility.GetObjectOverrides(targetScript.gameObject);
                var overridesCount = 0;

                for (int i = 0; i < overrides.Count; i++)
                {
                    if (overrides[i].instanceObject.GetType() != typeof(UnityEngine.Transform) && overrides[i].instanceObject.GetType() != typeof(UnityEngine.GameObject))
                    {
                        overridesCount++;
                    }
                }

                if (overridesCount > 0)
                {
                    hasOverrides = true;
                    EditorGUILayout.HelpBox("Prefab instance has overrides! The Visual Engine works on the prefab root level and not on individual prefab instances. Make sure to apply/revert all overrides to avoid any issues!", MessageType.Warning);
                }
            }

            var staticFlags = GameObjectUtility.GetStaticEditorFlags(targetScript.gameObject);

            if (staticFlags.HasFlag(StaticEditorFlags.BatchingStatic))
            {
                isStatic = true;
                EditorGUILayout.HelpBox("Please note, vegetation prefabs cannot be used with Static Batching. Please disable the Batching Static flag on the game object header!", MessageType.Warning);
            }

            if (hasOverrides || isStatic)
            {
                GUILayout.Space(10);
            }

            DrawInspector();

            //var fullRect = GUILayoutUtility.GetRect(0, 0, 1, 0);
            //var lineRect = new Rect(0, fullRect.position.y, fullRect.xMax + 3, 1);
            //EditorGUI.DrawRect(lineRect, Constant.LineColor);

            if (impostorRenderer != null && impostorMaterial != null)
            {
                if (GUILayout.Button("Update Impostor Material"))
                {
                    TVEUtils.CopyMaterialPropertiesToImpostor(impostorRenderer, impostorMaterial);
                }

            }

            GUILayout.BeginHorizontal();

            if (GUILayout.Button("Open Asset Converter"))
            {
                TVEAssetConverter window = EditorWindow.GetWindow<TVEAssetConverter>(false, "Assets Converter", true);
                window.minSize = new Vector2(480, 280);
                window.Show();
            }

            if (GUILayout.Button("Open Material Manager"))
            {
                TVEMaterialManager window = EditorWindow.GetWindow<TVEMaterialManager>(false, "Material Manager", true);
                window.minSize = new Vector2(389, 200);
                window.Show();
            }

            GUILayout.EndHorizontal();

            var preset = targetScript.storedPreset;

            if (preset != "")
            {
                GUILayout.Space(10);

                if (preset.EndsWith(";"))
                {
                    preset = preset.Replace(";", "");
                }

                preset = preset.Replace(";", "/").Replace("/", " / ");

                var presetSplit = preset.Split(" / ");
                var presetLabel = "";

                if (presetSplit.Length >= 4)
                {
                    presetLabel = presetSplit[presetSplit.Length - 3] + " / " + presetSplit[presetSplit.Length - 2] + " / " + presetSplit[presetSplit.Length - 1];
                }
                else
                {
                    presetLabel = preset;
                }

                GUILayout.Label("<size=10>" + presetLabel + "</size>", styleLabel);
            }

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }

        void GetImpostorMaterial()
        {
            if (targetScript == null)
            {
                return;
            }

            var prefabRenderers = new List<Renderer>();

            List<GameObject> gameObjectsInPrefab = new List<GameObject>();
            gameObjectsInPrefab.Add(targetScript.gameObject);

            TVEUtils.GetChildRecursive(targetScript.gameObject, gameObjectsInPrefab);

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                var gameObjectInPrefab = gameObjectsInPrefab[i];

                if (gameObjectInPrefab != null)
                {
                    var renderer = gameObjectInPrefab.GetComponent<Renderer>();

                    prefabRenderers.Add(renderer);
                }
            }

            for (int i = 0; i < prefabRenderers.Count; i++)
            {
                var prefabRenderer = prefabRenderers[i];

                if (prefabRenderer != null)
                {
                    if (impostorRenderer == null)
                    {
                        impostorRenderer = prefabRenderer;
                    }

                    var sharedMaterial = prefabRenderer.sharedMaterial;

                    if (sharedMaterial != null && sharedMaterial.shader.name.Contains("Impostor"))
                    {
                        impostorMaterial = prefabRenderer.sharedMaterial;
                    }
                }
            }
        }
    }
}


