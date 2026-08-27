//Cristian Pop - https://boxophobic.com/

#if THE_VISUAL_ENGINE_LAYERGUI
using UnityEngine;
using UnityEditor;
using System;

namespace TheVisualEngine
{
    [DisallowMultipleComponent]
    [CustomEditor(typeof(TerrainLayer))]
    public class TVEInspectorTerrainLayer : Editor
    {
        TerrainLayer terrainLayer;

        //Color bannerColor;
        //string bannerLabel;
        //string bannerVersion;

        TVEUVMode layerUVMode = TVEUVMode.Scale;

        Editor defaultEditor;

        //TVETerrainLayerTexture previewTexture = TVETerrainLayerTexture.Albedo;
        //int previewChannel = 0;
        //Material previewMaterial;

        void OnEnable()
        {
            terrainLayer = (TerrainLayer)target;

            var type = Type.GetType("UnityEditor.TerrainLayerInspector, UnityEditor");

            if (type != null)
            {
                defaultEditor = CreateEditor(targets, type);
            }

            //bannerColor = new Color(0.9f, 0.7f, 0.4f);
            //bannerLabel = "Layer";
            //bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        public override void OnInspectorGUI()
        {
            bool isTVE = TVEUtils.HasLabel(terrainLayer);

            if (isTVE)
            {
                TVEUtils.DrawTerrainLayer(terrainLayer, layerUVMode);
            }
            else
            {
                defaultEditor.OnInspectorGUI();

                GUILayout.Space(10);

                if (GUILayout.Button("Use The Visual Engine GUI"))
                {
                    TVEUtils.SetLabel(AssetDatabase.GetAssetPath(terrainLayer));
                }
            }
        }
    }
}
#endif

