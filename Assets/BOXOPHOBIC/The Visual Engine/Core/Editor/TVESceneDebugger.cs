// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using System.Collections.Generic;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    public class TVESceneDebugger : EditorWindow
    {
        float GUI_HALF_EDITOR_WIDTH = 200;

        string[] DebugModeOptions = new string[]
        {
        "None", "Show Opaque", "Show Alpha"
        };

        string[] DebugTypeOptions = new string[]
        {
        "Material Conversion", "Material Sharing", "Material Shader", "Material Global", "Material Vertex", "Material Visual", "Material Features",
        };

        string[] DebugShadingOptions = new string[]
        {
        "Shader Type", "Shader Lighting", "Shader Custom",
        };

        string[] DebugGlobalsOptions = new string[]
        {
        "Global Cascades", "",
        "Coat Layer (R)", "Coat Detail (G)", "Coat Stack (B)", "",
        "Draw Colormap (RGB)", "Draw Colormap Mask (A)", "",
        "Paint Tinting (RGB)", "Paint Tinting Mask (A)", "",
        "Fade Cutout (R)", "",
        "Atmo Dryness (R)", "Atmo Overlay (G)", "Atmo Wetness (B)", "Atmo Rainfall (A)", "",
        "Glow Emissive (RGB)", "Glow Emissive Mask (A)", "",
        "Form Normal (RG)", "Form Height (B)", "Form Size Fade (A)", "",
        "Vertx Size Fade (R)", "",
        "Flow Normal (RG)", "Flow Intensity (B)", "Flow Mask (A)",
        "User RGB", "User R", "User G", "User B", "User A",
        };

        string[] DebugVertexOptions = new string[]
        {
        "Raw Position OS", "Raw Normal OS", "Raw Tangent OS", "Raw Pivots OS", "", "Out Position OS", "Out Normal OS", "Out Tangent OS", "", "Vertex R", "Vertex G", "Vertex B", "Vertex A", "", "Height Mask", "Capsule Mask", "", "UV 0 (Main UV)", "UV 2 (Lightmap UV)", "UV 3 (Extra UV)","",
        "UV0 X", "UV0 Y", "UV0 Z", "UV0 W", "", "UV2 X", "UV2 Y", "UV2 Z", "UV2 W", "", "UV3 X", "UV3 Y", "UV3 Z", "UV3 W", "", "UV4 X", "UV4 Y", "UV4 Z", "UV4 W",
        };

        string[] DebugVisualOptions = new string[]
        {
        "Albedo", "Albedo Base", "", "Normal TS", "Normal WS", "", "Metallic", "Occlusion", "Smoothness", "", "Base Mask", "Multi Mask", "Gray Mask", "Luma Mask", "", "Alpha Clip", "Alpha Fade", "", "Emissive", "", "Subsurface",
        };

        string[] DebugFeatureOptions = new string[]
        {
        "Layer Settings", "Detail Settings", "Terrain Settings (Blanket)", "Overlay Settings", "Motion Settings", "Flatten Settings", "Transfer Settings", "Combine Settings",
        };

        string[] DebugFeatureLayerOptions = new string[]
        {
        "Layer Enabled", "",
        "Layer Mask", "",
        "Layer Elements",
        };

        string[] DebugFeatureDetailOptions = new string[]
        {
        "Detail Enabled", "",
        "Detail Mask", "",
        "Detail Elements",
        };

        string[] DebugFeatureTerrainOptions = new string[]
        {
        "Terrain Enabled", "",
        "Terrain Mask",
        };

        string[] DebugFeatureOverlayOptions = new string[]
        {
        "Overlay Enabled", "Overlay Maps", "Overlay Glitter", "",
        "Overlay Mask", "",
        "Overlay Elements",
        };

        string[] DebugFeatureMotionOptions = new string[]
        {
        "Motion Enabled", "",
        "Primary Mask", "Primary Noise", "Primary Phase", "Primary Phase ID", "Primary Interaction", "",
        "Second Mask", "Second Noise", "Second Phase", "Second Phase ID", "Second Interaction", "",
        "Leaves Mask", "Leaves Noise", "",
        "Motion Wind Elements",
        "Motion Push Elements",
        };

        string[] DebugFeatureFlattenOptions = new string[]
        {
        "Flatten Enabled", "",
        "Flatten Mask", "",
        "Flatten OS", "Flatten WS",
        };

        string[] DebugFeatureTransferOptions = new string[]
        {
        "Transfer Enabled", "",
        "Transfer Mask", "",
        "Transfer OS", "Transfer WS",
        };

        string[] DebugFeatureCombineOptions = new string[]
        {
        "Combine Enabled", "",
        "Combine Mask", "",
        "Combine WS",
        };

        string userFolder = "Assets/BOXOPHOBIC+";

        Shader debugShader;
        int debugModeIndex = 2;
        int debugTypeIndex = 0;
        int debugTypeIndex_1 = 0;
        int debugTypeIndex_2 = 0;
        bool showAllMaterials = true;
        bool showGlobalMasks = true;

        float debugMin = 0;
        float debugMax = 1;

        List<Light> activeLights;
        List<Terrain> activeTerrains;

        GUIStyle stylePopup;
        GUIStyle styleBox;
        GUIStyle styleLabel;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;
        static TVESceneDebugger window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Visual Engine/Scene Debugger", false, 2009)]
        public static void ShowWindow()
        {
            window = GetWindow<TVESceneDebugger>(false, "Scene Debugger", true);
            window.minSize = new Vector2(400, 300);
        }

        void OnEnable()
        {
            Shader.SetGlobalTexture("TVE_DEBUG_MipTex",Resources.Load<Texture2D>("Internal MipTex"));

            userFolder = BoxoUtils.GetUserFolder();

            var loadSettings = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Scene Debugger.asset", "");

            if (!string.IsNullOrEmpty(loadSettings))
            {
                var loadSettingsSplit = loadSettings.Split(";");

                debugModeIndex = int.Parse(loadSettingsSplit[0]);
                debugTypeIndex = int.Parse(loadSettingsSplit[1]);
                debugTypeIndex_1 = int.Parse(loadSettingsSplit[2]);
                debugTypeIndex_2 = int.Parse(loadSettingsSplit[3]);
            }

#if UNITY_6000_4_OR_NEWER
            var allLights = FindObjectsByType<Light>();
#elif UNITY_2023_1_OR_NEWER
            var allLights = FindObjectsByType<Light>(FindObjectsSortMode.None);
#else
            var allLights = FindObjectsOfType<Light>();
#endif

            activeLights = new List<Light>();

            for (int i = 0; i < allLights.Length; i++)
            {
                if (allLights[i] != null && allLights[i].enabled)
                {
                    activeLights.Add(allLights[i]);
                }
            }
#if UNITY_6000_4_OR_NEWER
            var allTerrains = FindObjectsByType<Terrain>();
#elif UNITY_2023_1_OR_NEWER
            var allTerrains = FindObjectsByType<Terrain>(FindObjectsSortMode.None);
#else
            var allTerrains = FindObjectsOfType<Terrain>();
#endif

            activeTerrains = new List<Terrain>();

            for (int i = 0; i < allTerrains.Length; i++)
            {
                if (allTerrains[i] != null && allTerrains[i].enabled && allTerrains[i].drawInstanced)
                {
                    activeTerrains.Add(allTerrains[i]);
                }
            }

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Scene Debugger";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        void OnDestroy()
        {
            DisableDebugger();
        }

        void OnDisable()
        {
            DisableDebugger();
        }

        void OnGUI()
        {
            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false);

            SetGUIStyles();

            GUI_HALF_EDITOR_WIDTH = this.position.width / 2.0f;

            GUILayout.Space(10);
            TVEUtils.DrawToolbar(0, -1);
            StyledGUI.DrawWindowBanner(bannerColor, bannerLabel, bannerVersion);

            GUILayout.BeginHorizontal();
            GUILayout.Space(10);
            GUILayout.BeginVertical();

            EditorGUI.BeginChangeCheck();

            debugModeIndex = StyledPopup("Debug Mode", "", debugModeIndex, DebugModeOptions);
            debugTypeIndex = StyledPopup("Debug Type", "", debugTypeIndex, DebugTypeOptions);

            // Conversion
            if (debugTypeIndex == 0)
            {
                GUILayout.Space(10);
                StyledGUI.DrawWindowCategory("Debug Legend");
                GUILayout.Space(10);

                StyledLegend("3rd Party Materials", new Color(0.3f, 0.3f, 0.3f, 0.75f));
                StyledLegend("Converted Materials", new Color(0.9f, 0.7f, 0.4f, 0.75f));
                //StyledLegend("Collected Materials", new Color(0.0f, 0.75f, 0.75f, 0.75f));
            }

            // Shading
            if (debugTypeIndex == 2)
            {
                GUILayout.Space(10);

                debugTypeIndex_1 = StyledPopup("Debug Shader", "", debugTypeIndex_1, DebugShadingOptions);

                GUILayout.Space(10);
                StyledGUI.DrawWindowCategory("Debug Legend");
                GUILayout.Space(10);

                // Scope
                if (debugTypeIndex_1 == 0)
                {
                    StyledLegend("3rd Party Shaders", new Color(0.3f, 0.3f, 0.3f, 0.75f));
                    StyledLegend("General Shaders", new Color(0.9f, 0.7f, 0.4f, 0.75f));
                    StyledLegend("Blanket Shaders", new Color(0.62f, 0.77f, 0.15f, 0.75f));
                    StyledLegend("Impostor Shaders", new Color(0.66f, 0.34f, 0.85f, 0.75f));
                    StyledLegend("Terrain Shaders", new Color(1f, 0.21f, 0.1f, 0.75f));
                }

                // Lighting
                if (debugTypeIndex_1 == 1)
                {
                    StyledLegend("3rd Party Shaders", new Color(0.3f, 0.3f, 0.3f, 0.75f));
                    StyledLegend("Simple Lit Shaders", new Color(0.33f, 0.61f, 0.81f, 0.75f));
                    StyledLegend("Standard Lit Shaders", new Color(0.66f, 0.34f, 0.85f, 0.75f));
                    StyledLegend("Subsurface Lit Shaders", new Color(0.92f, 0.84f, 0.18f, 0.75f));
                }

                // Custom
                if (debugTypeIndex_1 == 2)
                {
                    StyledLegend("3rd Party Shaders", new Color(0.3f, 0.3f, 0.3f, 0.75f));
                    StyledLegend("Core Shaders", new Color(0.9f, 0.7f, 0.4f, 0.75f));
                    StyledLegend("User Shaders", new Color(0.25f, 0.85f, 0.55f, 0.75f));
                }
            }

            // Global Textures
            if (debugTypeIndex == 3)
            {
                GUILayout.Space(10);

                debugTypeIndex_1 = StyledPopup("Debug Global", "", debugTypeIndex_1, DebugGlobalsOptions);

                GUILayout.BeginHorizontal();
                StyledLabel("Debug Remap");
                EditorGUILayout.MinMaxSlider(ref debugMin, ref debugMax, 0.0f, 1.0f, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 4));
                GUILayout.EndHorizontal();
            }

            // Vertex
            if (debugTypeIndex == 4)
            {
                GUILayout.Space(10);

                debugTypeIndex_1 = StyledPopup("Debug Vertex", "", debugTypeIndex_1, DebugVertexOptions);

                GUILayout.BeginHorizontal();
                StyledLabel("Debug Remap");
                EditorGUILayout.MinMaxSlider(ref debugMin, ref debugMax, 0.0f, 1.0f, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 4));
                GUILayout.EndHorizontal();

                GUILayout.Space(10);

                GUILayout.BeginHorizontal();
                StyledLabel("Include All Scene Objects");
                showAllMaterials = EditorGUILayout.Toggle(showAllMaterials, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                GUILayout.EndHorizontal();
            }

            // Visuals
            if (debugTypeIndex == 5)
            {
                GUILayout.Space(10);

                debugTypeIndex_1 = StyledPopup("Debug Visual", "", debugTypeIndex_1, DebugVisualOptions);

                GUILayout.BeginHorizontal();
                StyledLabel("Debug Remap");
                EditorGUILayout.MinMaxSlider(ref debugMin, ref debugMax, 0.0f, 1.0f, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 4));
                GUILayout.EndHorizontal();
            }

            // Material Features
            if (debugTypeIndex == 6)
            {
                GUILayout.Space(10);

                debugTypeIndex_1 = StyledPopup("Debug Feature", "", debugTypeIndex_1, DebugFeatureOptions);

                int index = 0;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureLayerOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureDetailOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureTerrainOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureOverlayOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureMotionOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureFlattenOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureTransferOptions);
                }

                index++;

                if (debugTypeIndex_1 == index)
                {
                    debugTypeIndex_2 = StyledPopup("Debug Settings", "", debugTypeIndex_2, DebugFeatureCombineOptions);
                }

                GUILayout.BeginHorizontal();
                StyledLabel("Debug Remap");
                EditorGUILayout.MinMaxSlider(ref debugMin, ref debugMax, 0.0f, 1.0f, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                GUILayout.EndHorizontal();

                GUILayout.Space(10);

                GUILayout.BeginHorizontal();
                StyledLabel("Include Global Masks / Elements");
                showGlobalMasks = EditorGUILayout.Toggle(showGlobalMasks, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                GUILayout.EndHorizontal();
            }

            if (debugModeIndex > 0)
            {
                EnableDebugger();
            }
            else
            {
                DisableDebugger();
            }

            if (EditorGUI.EndChangeCheck())
            {
                var saveSettings = debugModeIndex + ";" + debugTypeIndex + ";" + debugTypeIndex_1 + ";" + debugTypeIndex_2;

                SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Scene Debugger.asset", saveSettings);
            }

            GUILayout.EndVertical();
            GUILayout.Space(10);
            GUILayout.EndHorizontal();
            GUILayout.EndScrollView();
            GUILayout.Space(15);
        }

        void SetGUIStyles()
        {
            stylePopup = new GUIStyle(EditorStyles.popup)
            {
                alignment = TextAnchor.MiddleCenter
            };

            styleBox = new GUIStyle(GUI.skin.GetStyle("Label"))
            {
                fontSize = 14,               
            };

            styleLabel = new GUIStyle(GUI.skin.GetStyle("Label"))
            {
                richText = true,
                fontSize = 11,
            };
        }

        int StyledPopup(string name, string tooltip, int index, string[] options)
        {
            if (index >= options.Length)
            {
                index = 0;
            }

            if (options[index] == "")
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(new GUIContent(name, tooltip), GUILayout.Width(GUI_HALF_EDITOR_WIDTH));
            index = EditorGUILayout.Popup(index, options, stylePopup);
            GUILayout.EndHorizontal();

            return index;
        }

        void StyledLabel(string label)
        {
            GUI.color = new Color(1, 1, 1, 0.9f);
            GUILayout.Label(label, GUILayout.Width(GUI_HALF_EDITOR_WIDTH));
            GUI.color = Color.white;
        }

        void StyledLegend(string label, Color color)
        {
            GUILayout.Label("", styleBox);

            var rect = GUILayoutUtility.GetLastRect();
            EditorGUI.DrawRect(rect, color);
            EditorGUI.LabelField(rect, "<b>" + label + "</b>", styleLabel);
        }

        void EnableDebugger()
        {
            Shader.SetGlobalFloat("TVE_DebugEnabled", 1);

            if (SceneView.lastActiveSceneView != null)
            {
                if (debugModeIndex == 2)
                {
                    Shader.SetGlobalFloat("TVE_DEBUG_Clip", 1);
                }
                else
                {
                    Shader.SetGlobalFloat("TVE_DEBUG_Clip", 0);
                }

                // Material Convertion
                if (debugTypeIndex == 0)
                {
                    debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Conversion");

                    Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Min", 0);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", 1);
                }

                if (debugTypeIndex == 1)
                {
                    debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Sharing");

                    Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Min", 0);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", 1);
                }

                // Material Shading
                if (debugTypeIndex == 2)
                {
                    if (debugTypeIndex_1 == 0)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Type");
                    }

                    if (debugTypeIndex_1 == 1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Lighting");
                    }

                    if (debugTypeIndex_1 == 2)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Custom");
                    }

                    Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Min", 0);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", 1);
                }

                // Global
                if (debugTypeIndex == 3)
                {
                    debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Global");

                    Shader.SetGlobalFloat("TVE_DEBUG_Index", debugTypeIndex_1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 0);

                    Shader.SetGlobalFloat("TVE_DEBUG_Min", debugMin);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", debugMax);
                }

                // Vertex
                if (debugTypeIndex == 4)
                {
                    debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Vertex");

                    Shader.SetGlobalFloat("TVE_DEBUG_Index", debugTypeIndex_1);
                    //Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 0);

                    Shader.SetGlobalFloat("TVE_DEBUG_Min", debugMin);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", debugMax);

                    if (showAllMaterials)
                    {
                        Shader.SetGlobalFloat("TVE_DEBUG_Filter", 0);
                    }
                    else
                    {
                        Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    }
                }

                // Visual
                if (debugTypeIndex == 5)
                {
                    debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Visual");

                    Shader.SetGlobalFloat("TVE_DEBUG_Index", debugTypeIndex_1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 0);

                    Shader.SetGlobalFloat("TVE_DEBUG_Min", debugMin);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", debugMax);
                }

                // Material Features
                if (debugTypeIndex == 6)
                {
                    int indexCount_1 = 0;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Layer");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Detail");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Terrain");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Overlay");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Motion");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Flatten");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Transfer");
                    }

                    indexCount_1++;

                    if (debugTypeIndex_1 == indexCount_1)
                    {
                        debugShader = Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Combine");
                    }

                    Shader.SetGlobalFloat("TVE_DEBUG_Index", debugTypeIndex_2);
                    Shader.SetGlobalFloat("TVE_DEBUG_Filter", 1);
                    Shader.SetGlobalFloat("TVE_DEBUG_Shading", 0);

                    Shader.SetGlobalFloat("TVE_DEBUG_Min", debugMin);
                    Shader.SetGlobalFloat("TVE_DEBUG_Max", debugMax);

                    if (showGlobalMasks)
                    {
                        Shader.SetGlobalFloat("TVE_DEBUG_Global", 1);
                    }
                    else
                    {
                        Shader.SetGlobalFloat("TVE_DEBUG_Global", 0);
                    }
                }

                SceneView.lastActiveSceneView.SetSceneViewShaderReplace(debugShader, null);
                SceneView.lastActiveSceneView.Repaint();

                foreach (var light in activeLights)
                {
                    if (light != null)
                    {
                        light.gameObject.SetActive(false);
                    }
                }

                foreach (var terrain in activeTerrains)
                {
                    if (terrain != null)
                    {
                        terrain.drawInstanced = false;
                    }
                }
            }
        }

        void DisableDebugger()
        {
            Shader.SetGlobalFloat("TVE_DebugEnabled", 0);

            if (SceneView.lastActiveSceneView != null)
            {
                SceneView.lastActiveSceneView.SetSceneViewShaderReplace(null, null);
                SceneView.lastActiveSceneView.Repaint();

                foreach (var light in activeLights)
                {
                    if (light != null)
                    {
                        light.gameObject.SetActive(true);
                    }
                }

                foreach (var terrain in activeTerrains)
                {
                    if (terrain != null)
                    {
                        terrain.drawInstanced = true;
                    }
                }
            }
        }
    }
}
