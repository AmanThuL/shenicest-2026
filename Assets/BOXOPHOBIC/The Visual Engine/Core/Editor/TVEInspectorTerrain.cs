//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    [DisallowMultipleComponent]
    [CustomEditor(typeof(TVETerrain))]
    public class TVEInspectorTerrain : Editor
    {
        string excludeProp = "m_Script";
        TVETerrain targetScript;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;

        void OnEnable()
        {
            targetScript = (TVETerrain)target;

            targetScript.isSelected = true;

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Terrain";
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

            if (targetScript.terrainMaterial != null)
            {
                var materialLayers = BoxoUtils.GetMaterialInt(targetScript.terrainMaterial, "_TerrainLayersMode", 1);

                if (targetScript.terrainLayers > materialLayers)
                {
                    EditorGUILayout.HelpBox("The terrain has more layers than set on the material. Make sure to update the Terrain Layers mode to support the additional layers!", MessageType.Error);
                }
            }

            if (targetScript.terrainSettings.terrainAlbedo == null)
            {
                EditorGUILayout.HelpBox("The Terrain Base textures used for optimized distance rendering are missing. The distance shader is disabled!", MessageType.Warning);
            }
            else
            {
                EditorGUILayout.HelpBox("The Visual Engine terrain shader is using an optimized shader for distance rendering. The distance is controlled by the terrain Base Map Distance value!", MessageType.Info);
            }

            GUILayout.Space(10);

            DrawInspector();

            GUILayout.Space(10);

            string buttonStr = "Update Terrain Textures";

            if (targetScript.terrainRenderer.bakeMode == TVETerrainBaking.Baked && targetScript.terrainSettings.terrainAlbedo == null)
            {
                buttonStr = "Bake Terrain Textures";
            }

            if (targetScript.terrainRenderer.bakeMode == TVETerrainBaking.Baked)
            {
                if (GUILayout.Button(buttonStr))
                {
                    //targetScript.InitializeTerrain();
                    //targetScript.UpdateTerrainSettings();
                    targetScript.DestroyProxyTextures();
                    targetScript.TryGetProxyTextures();
                    targetScript.CreateProxyTextures(true);
                    targetScript.UpdateProxySettings();

                    EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene());
                }
            }

            //if (targetScript.terrainRenderer.bakeMode == TVETerrainBaking.RuntimeRenderTexture)
            //{
            //    if (GUILayout.Button(buttonStr))
            //    {
            //        targetScript.DestroyProxyTextures();
            //        targetScript.CreateProxyTextures(false);
            //        targetScript.UpdateProxySettings();
            //    }
            //}

            GUI.enabled = true;

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProp);

            serializedObject.ApplyModifiedProperties();
        }
    }
}


