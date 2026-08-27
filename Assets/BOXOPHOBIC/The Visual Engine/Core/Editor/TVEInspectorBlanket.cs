//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using UnityEngine.SceneManagement;

namespace TheVisualEngine
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(TVEBlanket))]
    public class TVEInspectorBlanket : Editor
    {
        string excludeProps = "m_Script";
        TVEBlanket targetScript;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;

        Scene activeScene;

        void OnEnable()
        {
            targetScript = (TVEBlanket)target;

            targetScript.isSelected = true;

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Blanket";
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
            StyledGUI.DrawInspectorBanner(bannerColor, bannerLabel, bannerVersion);

            if (targetScript.blanketBlending.blendMode == TVEBlendMode.AutoTerrainBlending)
            {
                EditorGUILayout.HelpBox("When using the Auto Terrain Blending feature, make sure to update the prefab material Terrain Layers/Remap/Maps/Colors properties to be the same as on the terrain material. Blending the object with multiple terrains at the same time is not supported!", MessageType.Info);
                GUILayout.Space(10);
            }

            DrawInspector();

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }
    }
}


