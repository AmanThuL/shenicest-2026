//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using UnityEditor.SceneManagement;

namespace TheVisualEngine
{
    [DisallowMultipleComponent]
    [CustomEditor(typeof(TVEElement))]
    public class TVEInspectorElement : Editor
    {
        string excludeProps = "m_Script";
        TVEElement targetScript;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;

        Bounds volumeBounds = new();
        string debugData = "";

        void OnEnable()
        {
            targetScript = (TVEElement)target;

            targetScript.isSelected = true;

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Element";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        void OnDisable()
        {
            targetScript.isSelected = false;
        }

        void OnDestroy()
        {
            targetScript.isSelected = false;
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

            DrawInspector();
            UpdateDebugData();

            GUILayout.Space(5);

            GUILayout.Label(debugData, styleLabel);

            var elementMaterial = targetScript.elementMaterial;

            if (elementMaterial != null)
            {
                if (!EditorUtility.IsPersistent(elementMaterial) && targetScript.terrainData == null)
                {
                    //GUILayout.Space(10);
                    //EditorGUILayout.HelpBox("Unsaved element materials are only recommended for prototyping! Save the material to be able to use the element in prefabs, enable GPU Instancing support and saved runtime performance!", MessageType.Warning);
                    GUILayout.Space(10);

                    if (GUILayout.Button("Save Element Material"))
                    {
                        var savePath = EditorUtility.SaveFilePanelInProject("Save Material", "My Element", "mat", "Save Element material to disk!");

                        if (savePath != "")
                        {
                            // Add OO Element to be able to find the material on upgrade
                            savePath = savePath.Replace("(TVE Element)", "");
                            savePath = savePath.Replace(".mat", " (TVE Element).mat");

                            AssetDatabase.CreateAsset(elementMaterial, savePath);
                            targetScript.gameObject.GetComponent<Renderer>().sharedMaterial = AssetDatabase.LoadAssetAtPath<Material>(savePath);

                            if (Application.isPlaying == false)
                            {
                                EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
                            }

                            TVEUtils.SetLabel(savePath);

                            AssetDatabase.Refresh();
                        }
                    }
                }
            }

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }

        void UpdateDebugData()
        {
            var tveManager = TVEManager.Instance;

            if (tveManager == null)
            {
                debugData = "<size=10>The element is disabled because the manager is missing</size>";

                return;
            }

            if (!targetScript.isActive)
            {
                debugData = "<size=10>The element is disabled</size>";

                return;
            }

            volumeBounds.size = new Vector3(tveManager.elementRenderer.baseRadius * 2, tveManager.elementRenderer.baseRadius * 2, tveManager.elementRenderer.baseRadius * 2);

            if (tveManager.elementRenderer.baseCenter == null)
            {
                if (tveManager.mainCamera != null)
                {
                    volumeBounds.center = tveManager.mainCamera.transform.position;
                }
            }
            else
            {
                volumeBounds.center = tveManager.mainCamera.transform.position;
            }

            if (!Application.isPlaying)
            {
                if (SceneView.lastActiveSceneView != null)
                {
                    volumeBounds.center = SceneView.lastActiveSceneView.camera.transform.position;
                }
            }

            var elementBounds = targetScript.elementRenderer.bounds;

            if (volumeBounds.Intersects(elementBounds))
            {
                if (volumeBounds.Contains(elementBounds.min) && volumeBounds.Contains(elementBounds.max))
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        debugData = "<size=10><color=#e1f043>The element is inside the base distance bounds</color></size>";
                    }
                    else
                    {
                        debugData = "<size=10>The element is inside the base distance bounds</size>";
                    }
                }
                else
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        debugData = "<size=10><color=#ffdb78>The element is only partially inside the base distance bounds</color></size>";
                    }
                    else
                    {
                        debugData = "<size=10>The element is only partially inside the base distance bounds</size>";
                    }
                }
            }
            else
            {
                if (EditorGUIUtility.isProSkin)
                {
                    debugData = "<b><size=10><color=#ff7663>The element is outside the base distance bounds</color></size></b>";
                }
                else
                {
                    debugData = "<b><size=10><color=#e82c02>The element is outside the base distance bounds</color></size></b>";
                }
            }
        }
    }
}


