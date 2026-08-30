// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;
using System.IO;
using System.Collections.Generic;

namespace TheVisualEngine
{
    public class TVEShaderManager : EditorWindow
    {
        float GUI_HALF_EDITOR_WIDTH = 220;
        const int GUI_SELECTION_HEIGHT = 24;

        string userFolder = "Assets/BOXOPHOBIC+";

        List<string> coreShaderPaths;

        List<int> renderEngineIndices;
        List<int> shaderModelIndices;
        List<TVEShaderSettings> coreShaderSettings;

#if AMPLIFY_SHADER_EDITOR
        List<string> userShaderPaths;
        bool hasCustomShaders = false;
#endif

        int renderEngineIndex = 0;
        int shaderModelIndex = 0;
        bool showRenderEngineMixedValues = false;
        bool showShaderModelMixedValues = false;
        bool showSelection = true;

        GUIStyle stylePopup;
        GUIStyle styleLabel;
        GUIStyle styleHelpBox;
        GUIStyle styleCenteredHelpBox;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;
        static TVEShaderManager window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Visual Engine/Shader Manager", false, 2007)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEShaderManager>(false, "Shader Manager", true);
            window.minSize = new Vector2(400, 300);
        }

        void OnEnable()
        {
            userFolder = BoxoUtils.GetUserFolder();
            coreShaderPaths = TVEUtils.GetCoreShaderPaths();

#if AMPLIFY_SHADER_EDITOR
            userShaderPaths = new();

            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                var shaderPath = coreShaderPaths[i];

                if (!shaderPath.Contains("Core"))
                {
                    userShaderPaths.Add(shaderPath);
                    hasCustomShaders = true;
                }
            }
#endif

            GetShaderSettings();
            GetShaderMixedSettings();

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Shader Manager";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        void OnGUI()
        {
            SetGUIStyles();

            GUI_HALF_EDITOR_WIDTH = this.position.width / 2.0f;

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false);

            GUILayout.Space(10);
            TVEUtils.DrawToolbar(0, -1);
            StyledGUI.DrawWindowBanner(bannerColor, bannerLabel, bannerVersion);

            GUILayout.BeginHorizontal();
            GUILayout.Space(10);
            GUILayout.BeginVertical();

            EditorGUILayout.HelpBox("Choose the shader render engine to enable instanced indirect support when working with 3rd party tools! The option can be set for each shader individually!", MessageType.Info, true);
            EditorGUILayout.HelpBox("GPU Instancer and Quadro Renderer create compatible shaders automatically and adding support is not required. You can still enable the support if you need the instanced indirect to be added to the original shaders specifically!", MessageType.Warning, true);

            GUILayout.Space(15);

            if (showRenderEngineMixedValues)
            {
                renderEngineIndex = -1;
            }

            EditorGUI.showMixedValue = showRenderEngineMixedValues;

            EditorGUI.BeginChangeCheck();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Render Engine Support", GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            renderEngineIndex = EditorGUILayout.Popup(renderEngineIndex, TVEUtils.RenderEngineOptions, stylePopup, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            GUILayout.EndHorizontal();

            if (EditorGUI.EndChangeCheck())
            {
                showRenderEngineMixedValues = false;

                UpdateShaders();

                GetShaderSettings();
                GetShaderMixedSettings();

                GUIUtility.ExitGUI();
            }

            if (showShaderModelMixedValues)
            {
                shaderModelIndex = -1;
            }

            EditorGUI.showMixedValue = showShaderModelMixedValues;

            EditorGUI.BeginChangeCheck();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Shader Model Support", GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            shaderModelIndex = EditorGUILayout.Popup(shaderModelIndex, TVEUtils.ShaderModelOptions, stylePopup, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            GUILayout.EndHorizontal();

            if (EditorGUI.EndChangeCheck())
            {
                showShaderModelMixedValues = false;

                UpdateShaders();

                GetShaderSettings();
                GetShaderMixedSettings();

                GUIUtility.ExitGUI();
            }

            EditorGUI.showMixedValue = false;

            GUILayout.Space(10);

            //if (showShaderModelMixedValues || showRenderEngineMixedValues)
            //{
            //    GUI.enabled = false;
            //}

            //if (GUILayout.Button("Set Shader Settings", GUILayout.Height(24)))
            //{
            //    showShaderModelMixedValues = false;
            //    showRenderEngineMixedValues = false;
            //    //SettingsUtils.SaveSettingsData(userFolder + "/Engine.asset", OOUtils.RenderEngineOptions[renderEngineIndex]);

            //    UpdateShaders();

            //    GetShaderSettings();
            //    GetShaderMixedSettings();

            //    GUIUtility.ExitGUI();
            //}

            if (showSelection)
            {
                if (StyledButton("Hide Shader Selection"))
                    showSelection = !showSelection;
            }
            else
            {
                if (StyledButton("Show Shader Selection"))
                    showSelection = !showSelection;
            }

            if (showSelection)
            {
                for (int i = 0; i < coreShaderPaths.Count; i++)
                {
                    StyledShader(i);
                }
            }

            GUILayout.Space(10);

#if AMPLIFY_SHADER_EDITOR
            bool isAmplifyTemplateImported = TVEUtils.IsAmplifyTemplateImported();
            bool isAmplifyVersionSupported = TVEUtils.IsAmplifyVersionSupported();

            if (isAmplifyTemplateImported)
            {
                if (!isAmplifyVersionSupported)
                {
                    EditorGUILayout.HelpBox("The current Amplify Shader Editor version is not supported. Make sure to use the latest version to compile the custom shaders", MessageType.Error, true);
                }
            }
            else
            {
                EditorGUILayout.HelpBox("The Amplify Templates for shader compilation are missing! Make sure to import them from the Unity Asset Store!", MessageType.Error, true);
            }

            GUILayout.Space(10);

            if (isAmplifyTemplateImported)
            {
                if (!isAmplifyVersionSupported)
                {
                    GUI.enabled = false;
                }

                if (GUILayout.Button("Compile All Shaders", GUILayout.Height(24)))
                {
                    AmplifyShaderEditor.AmplifyShaderEditorWindow.LoadAndSaveList(coreShaderPaths.ToArray());
                }

                if (hasCustomShaders)
                {
                    if (GUILayout.Button("Compile Custom Shaders", GUILayout.Height(24)))
                    {
                        AmplifyShaderEditor.AmplifyShaderEditorWindow.LoadAndSaveList(userShaderPaths.ToArray());
                    }
                }
            }
            else
            {
                if (GUILayout.Button("Download Amplify Templates", GUILayout.Height(24)))
                {
                    Application.OpenURL("https://u3d.as/3TeL");
                }
            }

            GUI.enabled = true;
#endif

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

            styleLabel = new GUIStyle(GUI.skin.GetStyle("Label"))
            {
                richText = true,
                alignment = TextAnchor.MiddleRight,
                fontSize = 10
            };

            styleHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleLeft,
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void StyledShader(int index)
        {
            var shader = AssetDatabase.LoadAssetAtPath<Shader>(coreShaderPaths[index]);

            if (shader == null)
            {
                return;
            }

            var splitLine = shader.name.Split(char.Parse("/"));
            var splitCount = splitLine.Length;
            var shaderName = splitLine[splitCount - 1];
            var shaderCategory = splitLine[splitCount - 2];
            var shaderType = splitLine[splitCount - 3];

            if (AssetDatabase.GetAssetPath(shader).Contains("Core"))
            {
                shaderType = "Core";

                if (AssetDatabase.GetAssetPath(shader).Contains("Lite"))
                {
                    shaderType = "Lite";

                    GUILayout.Label("<size=10><b>" + "  " + shaderName + "</b></size>  <color=#808080>" + shaderType + " / " + shaderCategory + "</color>", styleHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        GUILayout.Label("<size=10><b>" + "  " + shaderName + "</b></size>  <color=#ffdb78>" + shaderType + " / " + shaderCategory + "</color>", styleHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                    }
                    else
                    {
                        GUILayout.Label("<size=10><b>" + "  " + shaderName + "</b></size>  " + shaderType + " / " + shaderCategory, styleHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                    }
                }
            }
            else
            {
                shaderType = "User";

                if (EditorGUIUtility.isProSkin)
                {
                    GUILayout.Label("<size=10><b>" + "  " + shaderName + "</b></size>  <color=#8affc4>" + shaderType + " / " + shaderCategory + "</color>", styleHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    GUILayout.Label("<size=10><b>" + "  " + shaderName + "</b></size>  <color=#008c60>" + shaderType + " / " + shaderCategory + "</color>", styleHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
            }

            var lastRect = GUILayoutUtility.GetLastRect();
            var popupRect = new Rect(GUI_HALF_EDITOR_WIDTH + 5, lastRect.y + 3, lastRect.width / 2 - 30, lastRect.height);
            var selectionRect = new Rect(lastRect.x, lastRect.y, GUI_HALF_EDITOR_WIDTH, lastRect.height);
            var duplicateRect = new Rect(lastRect.width - 10, lastRect.y + 3, 18, 18);

            if (GUI.Button(selectionRect, "", GUIStyle.none))
            {
                EditorGUIUtility.PingObject(shader);
            }

            GUILayout.BeginHorizontal();

            if (shader.name.Contains("Terrain"))
            {
                GUI.enabled = false;
            }

            EditorGUI.BeginChangeCheck();

            renderEngineIndices[index] = EditorGUI.Popup(popupRect, renderEngineIndices[index], TVEUtils.RenderEngineOptions, stylePopup);

            if (EditorGUI.EndChangeCheck())
            {
                SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Shaders/Engine " + shader.name.Replace("/", "__") + ".asset", TVEUtils.RenderEngineOptions[renderEngineIndices[index]]);

                coreShaderSettings[index].renderEngine = TVEUtils.RenderEngineOptions[renderEngineIndices[index]];
                coreShaderSettings[index].shaderModel = TVEUtils.ShaderModelOptions[shaderModelIndex];

                TVEUtils.SetShaderSettings(coreShaderPaths[index], coreShaderSettings[index]);

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                GetShaderSettings();
                GetShaderMixedSettings();

                //GUIUtility.ExitGUI();
            }

            if (shader.name.Contains("Terrain"))
            {
                GUI.enabled = true;
            }

            if (GUI.Button(duplicateRect, new GUIContent("+", "Duplicate the shader to be edited in Amplify Shader Editor.")))
            {
                var saveFolder = userFolder + "/The Visual Engine/Shaders";

                if (!Directory.Exists(saveFolder))
                {
                    Directory.CreateDirectory(saveFolder);
                    AssetDatabase.Refresh();
                }

                var newShaderPath = EditorUtility.SaveFilePanelInProject("Save New Shader", shaderName + " (Custom)", "shader", "Save new shader.", saveFolder);

                if (newShaderPath == "")
                {
                    GUIUtility.ExitGUI();
                    return;
                }

                var newSplitLine = newShaderPath.Replace(".shader", "").Split(char.Parse("/"));
                var newSplitCount = newSplitLine.Length;
                var newShaderName = newSplitLine[newSplitCount - 1];

                var oldShaderPath = AssetDatabase.GetAssetPath(shader);

                if (!File.Exists(newShaderPath))
                {
                    AssetDatabase.CopyAsset(oldShaderPath, newShaderPath);
                    AssetDatabase.Refresh();
                }

                //Inject shader features
                StreamReader reader = new StreamReader(oldShaderPath);

                List<string> lines = new List<string>();

                while (!reader.EndOfStream)
                {
                    lines.Add(reader.ReadLine());
                }

                reader.Close();

                var newShaderFullName = "BOXOPHOBIC/The Visual Engine/" + shaderCategory + "/" + newShaderName;

                for (int i = 0; i < 10; i++)
                {
                    if (lines[i].StartsWith("Shader"))
                    {
                        lines[i] = "Shader \"" + newShaderFullName + "\"";
                    }
                }

                StreamWriter writer = new StreamWriter(newShaderPath, false);

                for (int i = 0; i < lines.Count; i++)
                {
                    writer.WriteLine(lines[i]);
                }

                writer.Close();

                lines = new List<string>();

                SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Shaders/Engine " + newShaderFullName.Replace("/", "__") + ".asset", TVEUtils.RenderEngineOptions[renderEngineIndices[index]]);

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                AssetDatabase.ImportAsset(newShaderPath);

                var newShader = AssetDatabase.LoadAssetAtPath<Shader>(newShaderPath);
                EditorGUIUtility.PingObject(newShader);

                coreShaderPaths = TVEUtils.GetCoreShaderPaths();

                GetShaderSettings();
                GetShaderMixedSettings();
            }

            GUILayout.EndHorizontal();
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            return value;
        }

        void UpdateShaders()
        {
            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                var shader = AssetDatabase.LoadAssetAtPath<Shader>(coreShaderPaths[i]);

                if (renderEngineIndex == -1)
                {
                    coreShaderSettings[i].renderEngine = TVEUtils.GetShaderSettings(coreShaderPaths[i]).renderEngine;
                }
                else
                {
                    coreShaderSettings[i].renderEngine = TVEUtils.RenderEngineOptions[renderEngineIndex];
                }

                if (shader.name.Contains("Terrain"))
                {
                    coreShaderSettings[i].renderEngine = "Unity Default Renderer";
                }

                coreShaderSettings[i].shaderModel = TVEUtils.ShaderModelOptions[shaderModelIndex];

                SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Shaders/Engine " + shader.name.Replace("/", "__") + ".asset", coreShaderSettings[i].renderEngine);
                SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Shaders/Model " + shader.name.Replace("/", "__") + ".asset", TVEUtils.ShaderModelOptions[shaderModelIndex]);

                TVEUtils.SetShaderSettings(coreShaderPaths[i], coreShaderSettings[i]);
            }

            Debug.Log("<b>[The Visual Engine]</b> " + "Shader features updated!");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            GetShaderMixedSettings();
        }

        void GetShaderSettings()
        {
            coreShaderSettings = new List<TVEShaderSettings>();
            renderEngineIndices = new List<int>();
            shaderModelIndices = new List<int>();

            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                var shaderSettings = TVEUtils.GetShaderSettings(coreShaderPaths[i]);

                coreShaderSettings.Add(shaderSettings);
                renderEngineIndices.Add(0);
                shaderModelIndices.Add(0);
            }

            for (int i = 0; i < coreShaderSettings.Count; i++)
            {
                var shaderSettings = coreShaderSettings[i];

                for (int s = 0; s < TVEUtils.RenderEngineOptions.Length; s++)
                {
                    if (shaderSettings.renderEngine == TVEUtils.RenderEngineOptions[s])
                    {
                        renderEngineIndices[i] = s;
                        renderEngineIndex = s;
                    }
                }

                for (int s = 0; s < TVEUtils.ShaderModelOptions.Length; s++)
                {
                    if (shaderSettings.shaderModel == TVEUtils.ShaderModelOptions[s])
                    {
                        shaderModelIndices[i] = s;
                        shaderModelIndex = s;
                    }
                }
            }
        }

        void GetShaderMixedSettings()
        {
            showRenderEngineMixedValues = false;
            showShaderModelMixedValues = false;

            for (int i = 1; i < renderEngineIndices.Count; i++)
            {
                bool skipProcess = Path.GetFileName(coreShaderPaths[i - 1]).Contains("Terrain") || Path.GetFileName(coreShaderPaths[i]).Contains("Terrain");

                if (renderEngineIndices[i - 1] != renderEngineIndices[i] && !skipProcess)
                {
                    showRenderEngineMixedValues = true;
                    break;
                }
            }

            for (int i = 1; i < shaderModelIndices.Count; i++)
            {
                if (shaderModelIndices[i - 1] != shaderModelIndices[i])
                {
                    showShaderModelMixedValues = true;
                    break;
                }
            }
        }
    }
}
