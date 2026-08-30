// Cristian Pop - https://boxophobic.com/

using Boxophobic.StyledGUI;
using Boxophobic.Utility;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using Object = UnityEngine.Object;
using Random = UnityEngine.Random;

namespace TheVisualEngine
{
    public class TVEAssetConverter : EditorWindow
    {
        const int FALSE = 0;
        const int TRUE = 1;
        const int GUI_SPACE_SMALL = 5;
        const int GUI_SELECTION_HEIGHT = 24;
        const int GUI_SQUARE_BUTTON_WIDTH = 20;
        const int GUI_SQUARE_BUTTON_HEIGHT = 18;
        float GUI_HALF_EDITOR_WIDTH = 200;

        string[] SourceMaskEnum = new string[]
        {
        "None", "Channel", "Procedural", "Texture", "3rd Party",
        };

        string[] SourceMaskMeshEnum = new string[]
        {
        "[0]  Vertex R", "[1]  Vertex G", "[2]  Vertex B", "[3]  Vertex A",
        "[4]  UV 0 X", "[5]  UV 0 Y", "[6]  UV 0 Z", "[7]  UV 0 W",
        "[8]  UV 2 X", "[9]  UV 2 Y", "[10]  UV 2 Z", "[11]  UV 2 W",
        "[12]  UV 3 X", "[13]  UV 3 Y", "[14]  UV 3 Z", "[16]  UV 3 W",
        "[16]  UV 4 X", "[17]  UV 4 Y", "[18]  UV 4 Z", "[19]  UV 4 W",
        };

        string[] SourceMaskProceduralEnum = new string[]
        {
        "[0]  Constant Black", "[1]  Constant White", "[2]  Accurate Element Variation", "[3]  Random Element Variation", "[4]  Height", "[5]  Sphere", "[6]  Cylinder", "[7]  Capsule",
        "[8]  Base To Top", "[9]  Bottom Projection", "[10]  Top Projection", "[11]  Height Offset (Low)", "[12]  Height Offset (Medium)", "[13]  Height Offset (High)",
        "[14]  Height Grass", "[15]  Sphere Plant", "[16]  Cylinder Tree", "[17]  Capsule Tree", "[18]  Normalized Pos X", "[19]  Normalized Pos Y", "[20]  Normalized Pos Z",
        "[21]  Diagonal UV0",
        };

        string[] SourceMask3rdPartyEnum = new string[]
        {
        "[0]  CTI Leaves Mask", "[1]  CTI Leaves Variation", "[2]  ST8 Leaves Mask", "[3]  NM Leaves Mask", "[4]  Nicrom Leaves Mask", "[5]  Nicrom Detail Mask", "[6]  SeedMesh Variation"
        };

        string[] SourceFromTextureEnum = new string[]
        {
        "[0]  Channel R", "[1]  Channel G", "[2]  Channel B", "[3]  Channel A"
        };

        string[] SourceCoordEnum = new string[]
        {
        "None", "Channel", "Procedural", "3rd Party",
        };

        string[] SourceCoordMeshEnum = new string[]
        {
        "[0]  UV 0", "[1]  UV 2", "[2]  UV 3", "[3]  UV 4",
        };

        string[] SourceCoordProceduralEnum = new string[]
        {
        "[0]  Lightmap", "[1]  Planar XZ", "[2]  Planar XY", "[3]  Planar ZY",
        };

        string[] SourceCoord3rdPartyEnum = new string[]
        {
        "[0]  NM Trunk Blend"
        };

        string[] SourcePivotsEnum = new string[]
        {
        "None", "Channel", "Procedural",
        };

        string[] SourcePivotsMeshEnum = new string[]
        {
        "[0]  UV 0", "[1]  UV 2", "[2]  UV 3", "[3]  UV 4",
        };

        string[] SourcePivotsProceduralEnum = new string[]
        {
        "[0]  Procedural Pivots",
        };

        string[] SourceNormalsEnum = new string[]
        {
        "From Mesh", "Procedural",
        };

        string[] SourceNormalsProceduralEnum = new string[]
        {
        "[0]  Recalculate Normals",
        "[1]  Flat Shading (Low)", "[2]  Flat Shading (Medium)", "[3]  Flat Shading (Full)",
        "[4]  Spherical Shading (Low)", "[5]  Spherical Shading (Medium)", "[6]  Spherical Shading (Full)",
        //"[7]  Flat To Spherical Shading (Low)", "[8]  Flat To Spherical Shading (Medium)", "[9]  Flat To Spherical Shading (Full)",
        };

        string[] SourceBoundsEnum = new string[]
        {
        "From Mesh", "Multiplier"
        };

#if UNITY_6000_2_OR_NEWER
        string[] SourceMeshLODEnum = new string[]
        {
        "From Mesh", "MeshLOD Limit"
        };
#endif

        string[] SourceActionEnum = new string[]
        {
        "None", "One Minus", "Negative", "Remap 0-1", "Power Of 2", "Multiply By Height", "Clamp Negative Values", "Fractional Values"
        };

        string[] ReadWriteModeEnum = new string[]
        {
        "Mark Meshes As Non Readable", "Mark Meshes As Readable",
        };

        string[] TransformsModeEnum = new string[]
        {
        "Use Original Transforms", "Transform To World Space",
        };

        string[] OutputMeshesEnum = new string[]
        {
        "Off", "Default",
        };

        string[] OutputMaterialsEnum = new string[]
        {
        "Off", "Default",
        };

        string[] OutputTexturesEnum = new string[]
        {
        "Save Textures As Png", "Save Textures As Tga", "Save Textures As Exr", "Save Textures As Asset",
        };

        string[] CollectSharingEnum = new string[]
        {
        "Use Original Sharing", "Create Unique Materials",
        };

        string[] BoolEnum = new string[]
        {
        "Off", "On",
        };

        int outputMeshes = 1;
        int outputMaterials = 1;
        int outputTextures = 0;

        string uniqueDataFormat = "BASENAME DATANAME";
        string outputBaseFormat = "CONVERTROOT/BASENAME";
        string outputDataFormat = "CONVERTROOT/Prefabs Data/DATATYPEs/DATANAME DATAGUID (TVE DATATYPE)";
        string collectBaseFormat = "COLLECTROOT/BASENAME";
        string collectDataFormat = "COLLECTROOT/Prefabs Data/DATATYPEs/DATANAME";

        int collectSharing = 0;
        int collectLocking = 0;
        int collectBackups = 1;

        string outputPipelines = "";
        string outputVersion = "-1";
        bool outputValid = true;

        string convertFolder = "";
        string collectFolder = "";
        string userFolder = "Assets/BOXOPHOBIC+";

        string infoTitle = "";
        string infoPreset = "";
        string infoAdditive = "";
        string infoStatus = "";
        string infoOnline = "";
        string infoTutorial = "";
        string infoCollection = "";
        string infoMessage = "";
        string infoWarning = "";
        string infoError = "";
        //string infoSharing = "";

        int sourceVariation = 0;
        int optionVariation = 0;
        int actionVariation = 0;
        int coordVariation = 0;
        Texture2D textureVariation;

        int sourceOcclusion = 0;
        int optionOcclusion = 0;
        int actionOcclusion = 0;
        int coordOcclusion = 0;
        Texture2D textureOcclusion;

        int sourceDetail = 0;
        int optionDetail = 0;
        int actionDetail = 0;
        int coordDetail = 0;
        Texture2D textureDetail;

        int sourceHeight = 0;
        int optionHeight = 0;
        int actionHeight = 0;
        int coordHeight = 0;
        Texture2D textureHeight;

        int sourceMainCoord = 0;
        int optionMainCoord = 0;

        int sourceExtraCoord = 0;
        int optionExtraCoord = 0;

        int sourcePivots = 0;
        int optionPivots = 0;

        int sourceNormals = 0;
        int optionNormals = 0;

        int sourceBounds = 0;
        Vector3 boundsMultiplier = Vector3.one;

#if UNITY_6000_2_OR_NEWER
        int sourceMeshLOD = 0;
        int meshLODLimit = -1;
#endif

        int transformsMode = 0;
        int readWriteMode = 0;

        List<TVEPrefabData> prefabObjects;
        int convertedPrefabCount;
        int convertedLockedPrefabCount;
        int supportedPrefabCount;
        int unsupportedPrefabCount;
        int anySupportedPrefabCount;

        TVEPrefabData currentPrefab = new TVEPrefabData();

        //GameObject currentPrefabObject;
        //GameObject currentPrefabInstance;

        List<TVEGameObjectData> gameObjectDataSet;
        List<TVEModelSettings> uniqueMeshSettings;
        Vector4 maxBoundsInfo;

        List<string> exportList;

        int presetIndex = 0;
        int optionIndex = 0;
        bool presetAutoDetected = false;
        bool optionAutoDetected = false;
        bool presetMixedValues = false;
        List<int> overrideIndices;
        List<bool> overrideGlobals;

        bool hasPresetFromPrefab = false;
        bool hasPresetModifications = false;
        bool hasOptionModifications = false;

        bool showAdvancedSettings = false;
        bool shareCommonMaterials = false;
        bool hasShaderModifications = false;
        bool hasOutputModifications = false;
        bool hasModelModifications = false;

        bool keepConvertedMaterials = false;
        bool keepConvertedMaterialsSet = false;

        bool copySharedMaterials = false;
        bool copySharedMaterialsSet = false;

        bool keepConvertedPrefabs = false;

        string[] allPresetPaths;
        List<string> presetPaths;
        List<string> presetLines;
        List<string> overridePaths;
        List<string> detectLines;
        string[] PresetsEnum;
        string[] OptionsEnum;
        string[] OverridesEnum;

        Shader shaderProp;
        Shader shaderBark;
        Shader shaderLeaf;
        Shader shaderCover;
        Shader shaderPlant;
        Shader shaderGrass;
        Shader shaderCross;

        bool isValid = true;
        bool showSelection = true;
        float seed = 1;

        string projectPipeline;
        int assetVersion;

        GUIStyle styleLabel;
        GUIStyle stylePopup;
        GUIStyle styleCenteredHelpBox;
        GUIStyle styleMiniToggleButton;
        Color bannerColor;
        string bannerLabel;
        string bannerVersion;
        static TVEAssetConverter window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Visual Engine/Asset Converter", false, 2000)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEAssetConverter>(false, "Asset Converter", true);
            window.minSize = new Vector2(400, 280);
        }

        void OnEnable()
        {
            if (TVEManager.Instance == null)
            {
                isValid = false;
            }

            assetVersion = TVEUtils.GetAssetVersionInt();
            userFolder = BoxoUtils.GetUserFolder();

            string sharing = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Converter Sharing.asset", "True");

            if (sharing == "True")
            {
                shareCommonMaterials = true;
            }
            else
            {
                shareCommonMaterials = false;
            }

            projectPipeline = BoxoUtils.GetProjectPipeline();

            int intSeed = UnityEngine.Random.Range(1, 99);
            float floatSeed = UnityEngine.Random.Range(0.1f, 0.9f);
            seed = intSeed + floatSeed;

            GetDefaultShaders();

            GetPresets();
            Initialize();

            if (prefabObjects.Count > 20)
            {
                showSelection = false;
            }

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Asset Converter";
            bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        void OnLostFocus()
        {
            Shader.SetGlobalInt("TVE_ShowIcons", 0);
        }

        void OnDisable()
        {
            Shader.SetGlobalInt("TVE_ShowIcons", 0);
        }

        void OnDestroy()
        {
            Shader.SetGlobalInt("TVE_ShowIcons", 0);
        }

        void OnSelectionChange()
        {
            GetPrefabObjects();
            GetPrefabPresets();
            GetAllPresetInfo(false);

            Repaint();
        }

        void OnHierarchyChange()
        {
            GetPrefabObjects();
            GetPrefabPresets();
            GetAllPresetInfo(false);

            Repaint();
        }

        void OnFocus()
        {
            GetPresets();
            GetPrefabObjects();
            GetPrefabPresets();
            GetAllPresetInfo(false);

            Repaint();
        }

        void Initialize()
        {
            overrideIndices = new List<int>();
            overrideGlobals = new List<bool>();

            GetPrefabObjects();
            GetPrefabPresets();
            GetGlobalOverrides();

            if (overrideIndices.Count == 0)
            {
                overrideIndices.Add(0);
                overrideGlobals.Add(false);
            }

            GetAllPresetInfo(false);
        }

        void OnGUI()
        {
            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false);

            SetGUIStyles();

            Shader.SetGlobalInt("TVE_ShowIcons", 1);

            GUI_HALF_EDITOR_WIDTH = this.position.width / 2.0f;

            GUILayout.Space(10);
            TVEUtils.DrawToolbar(0, -1);
            StyledGUI.DrawWindowBanner(bannerColor, bannerLabel, bannerVersion);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);
            GUILayout.BeginVertical();

            DrawMessage();

            if (isValid)
            {
                DrawPrefabObjects();
                //DrawPrefabCreation();
                DrawPresetDownload();

                if (prefabObjects.Count > 0)
                {
                    DrawConversionSettings();
                    DrawConversionButtons();
                }
            }

            GUILayout.EndVertical();
            GUILayout.Space(10);
            GUILayout.EndHorizontal();
            GUILayout.EndScrollView();
            GUILayout.Space(15);
        }

        void SetGUIStyles()
        {
            styleLabel = new GUIStyle(EditorStyles.label)
            {
                alignment = TextAnchor.MiddleCenter,
                richText = true,
            };

            stylePopup = new GUIStyle(EditorStyles.popup)
            {
                alignment = TextAnchor.MiddleCenter
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };

            styleMiniToggleButton = new GUIStyle(GUI.skin.GetStyle("Button"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void DrawMessage()
        {
            GUILayout.Space(-2);

            if (isValid && anySupportedPrefabCount > 0)
            {
                if (presetIndex != 0)
                {
                    var preset = "";
                    var presetAdd = "";
                    var option = "";

                    if (optionAutoDetected)
                    {
                        option = " Pleasse note, the option auto-detection might not be accurate.";
                    }

                    if (infoPreset != "")
                    {
                        preset = "\n" + infoPreset + option + " After conversion, material adjustments might be needed!" + "\n";
                    }

                    if (infoAdditive != "")
                    {
                        presetAdd = "\n" + infoAdditive + "\n";
                    }

                    var presetString = "\n<size=14>" + infoTitle + "</size>\n" + preset + presetAdd + "\n\n\n\n";

                    GUILayout.Label(presetString, styleCenteredHelpBox);

                    var lastRect = GUILayoutUtility.GetLastRect();
                    //var statusRect = new Rect(lastRect.width / 2 - 20, lastRect.yMax - 30, 80, 18);
                    //var onlineRect = new Rect(lastRect.xMax - 58, lastRect.yMax - 30, 50, 18);
                    //var tutorialRect = new Rect(lastRect.xMax - 110, lastRect.yMax - 30, 50, 18);
                    //var collectionRect = new Rect(lastRect.x + 12, lastRect.yMax - 30, 130, 18);

                    var statusRect = new Rect(lastRect.width / 3 + 14, lastRect.yMax - 53, lastRect.width / 3, 18);
                    var collectionRect = new Rect(lastRect.x + 7, lastRect.yMax - 30, lastRect.width / 3, 18);
                    var tutorialRect = new Rect(lastRect.x + lastRect.width / 3, lastRect.yMax - 30, lastRect.width / 3, 18);
                    var onlineRect = new Rect(lastRect.x + lastRect.width / 3 * 2, lastRect.yMax - 30, lastRect.width / 3, 18);

                    var status = infoStatus;

                    if (infoStatus == "● ● ● ● ●")
                    {
                        status = "<color=#8BBE45>● ● ● ● ●</color>";
                    }
                    else if (infoStatus == "● ● ● ● ○")
                    {
                        status = "<color=#ADBE45>● ● ● ● ○</color>";
                    }
                    else if (infoStatus == "● ● ● ○ ○")
                    {
                        status = "<color=#E0B036>● ● ● ○ ○</color>";
                    }
                    else if (infoStatus == "● ● ○ ○ ○")
                    {
                        status = "<color=#E07236>● ● ○ ○ ○</color>";
                    }
                    else if (infoStatus == "● ○ ○ ○ ○")
                    {
                        status = "<color=#E04436>● ○ ○ ○ ○</color>";
                    }

                    GUI.Label(statusRect, "<size=11>" + status + "</size>", styleLabel);

                    if (infoOnline != "")
                    {
                        var onlineString = "<b><size=10><color=#AAB7FF>Unity Asset Store</color></size></b>";

                        if (!EditorGUIUtility.isProSkin)
                        {
                            onlineString = "<b><size=10><color=#4C67FF>Unity Asset Store</color></size></b>";
                        }

                        if (GUI.Button(onlineRect, onlineString, styleLabel))
                        {
                            Application.OpenURL(infoOnline);
                        }
                    }
                    else
                    {
                        GUI.Label(onlineRect, "<b><size=10><color=#808080>Unity Asset Store</color></size></b>", styleLabel);
                    }

                    if (infoTutorial != "")
                    {
                        var tutorialString = "<b><size=10><color=#FF7CB4>Conversion Tutorial</color></size></b>";

                        if (!EditorGUIUtility.isProSkin)
                        {
                            tutorialString = "<b><size=10><color=#D91E6E>Conversion Tutorial</color></size></b>";
                        }

                        if (GUI.Button(tutorialRect, tutorialString, styleLabel))
                        {
                            Application.OpenURL(infoTutorial);
                        }
                    }
                    else
                    {
                        GUI.Label(tutorialRect, "<b><size=10><color=#808080>Conversion Tutorial</color></size></b>", styleLabel);
                    }

                    if (infoCollection != "")
                    {
                        var collectionString = "<b><size=10><color=#fdc779>Available Collections</color></size></b>";

                        if (!EditorGUIUtility.isProSkin)
                        {
                            collectionString = "<b><size=10><color=#e16f00>Available Collections</color></size></b>";
                        }

                        if (GUI.Button(collectionRect, collectionString, styleLabel))
                        {
                            var collectionLinks = infoCollection.Split(char.Parse(";"));

                            for (int i = 0; i < collectionLinks.Length; i++)
                            {
                                var link = collectionLinks[i];
                                link = link.TrimStart();
                                link = link.TrimEnd();

                                Application.OpenURL(link);
                            }
                        }
                    }
                    else
                    {
                        GUI.Label(collectionRect, "<b><size=10><color=#808080>Available Collections</color></size></b>", styleLabel);
                    }

                    if (infoError != "")
                    {
                        GUILayout.Space(1);
                        EditorGUILayout.HelpBox(infoError, MessageType.Error, true);
                    }
                    else
                    {
                        if (infoWarning != "")
                        {
                            GUILayout.Space(1);
                            EditorGUILayout.HelpBox(infoWarning, MessageType.Warning, true);
                        }

                        if (infoMessage != "")
                        {
                            GUILayout.Space(1);
                            EditorGUILayout.HelpBox(infoMessage, MessageType.Info, true);
                        }
                    }

                    //if (infoCollection != "")
                    //{
                    //    GUILayout.Space(10);

                    //    GUI.contentColor = new Color(1f, 0.8f, 0.5f);
                    //    if (GUILayout.Button("Ready-Made Collections Available", GUILayout.Height(24)))
                    //    {
                    //        var collectionLinks = infoCollection.Split(char.Parse(";"));

                    //        for (int i = 0; i < collectionLinks.Length; i++)
                    //        {
                    //            var link = collectionLinks[i];
                    //            link = link.TrimStart();
                    //            link = link.TrimEnd();

                    //            Application.OpenURL(link);
                    //        }
                    //    }

                    //    GUI.contentColor = Color.white;
                    //}
                }
                else
                {
                    if (presetMixedValues)
                    {
                        GUILayout.Button("\n<size=14>Multiple conversion presets detected!</size>\n", styleCenteredHelpBox);
                    }
                    else
                    {
                        GUILayout.Button("\n<size=14>Choose a preset to convert the selected prefabs!</size>\n", styleCenteredHelpBox);
                    }
                }
            }
            else
            {
                if (isValid == false && TVEManager.Instance == null)
                {
                    GUILayout.Button("\n<size=14>The Visual Engine manager is missing from your scene!</size>\n", styleCenteredHelpBox);

                    GUILayout.Space(10);

                    if (GUILayout.Button("Create Scene Manager", GUILayout.Height(24)))
                    {
                        GameObject manager = new GameObject();
                        manager.AddComponent<TVEManager>();

                        EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());

                        isValid = true;
                    }
                }
                else if (anySupportedPrefabCount == 0)
                {
                    GUILayout.Button("\n<size=14>Select one or multiple valid prefabs to get started!</size>\n", styleCenteredHelpBox);
                }
            }
        }

        void DrawPrefabObjects()
        {
            if (prefabObjects.Count > 0)
            {
                GUILayout.Space(10);

                if (showSelection)
                {
                    if (StyledButton("Hide Prefab Selection"))
                        showSelection = !showSelection;
                }
                else
                {
                    if (StyledButton("Show Prefab Selection"))
                        showSelection = !showSelection;
                }

                if (showSelection)
                {
                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        StyledPrefab(prefabObjects[i]);
                    }
                }
            }
        }

        void DrawPrefabCreation()
        {
            if (unsupportedPrefabCount > 0)
            {
                GUILayout.Space(10);

                EditorGUILayout.HelpBox("The selection contains one or more non-prefab objects! Use the Create Prefabs option or drag the objects to the Project Window to create regular prefabs for conversion.", MessageType.Warning, true);

                GUILayout.Space(10);

                if (GUILayout.Button("Create Prefabs", GUILayout.Height(24)))
                {
                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        var prefabData = prefabObjects[i];

                        if (prefabData.status == TVEPrefabMode.Unsupported)
                        {
                            var gameObject = prefabObjects[i].prefabObject;
                            var gameObjectInstance = prefabObjects[i].prefabInstanceInScene;

                            var newPrefab = (GameObject)PrefabUtility.InstantiatePrefab(gameObject);
                            newPrefab.name = gameObject.name + " Prefab";

                            var prefabPath = AssetDatabase.GetAssetPath(gameObject);
                            var prefabExtension = Path.GetExtension(prefabPath);
                            var prefabaAltPath = prefabPath.Replace(prefabExtension, " Prefab.prefab");

                            PrefabUtility.UnpackPrefabInstance(newPrefab, PrefabUnpackMode.Completely, InteractionMode.AutomatedAction);
                            PrefabUtility.SaveAsPrefabAssetAndConnect(newPrefab, prefabaAltPath, InteractionMode.AutomatedAction);

                            AssetDatabase.SaveAssets();
                            AssetDatabase.Refresh();

                            if (gameObjectInstance != null)
                            {
                                if (gameObjectInstance.transform.parent != null)
                                {
                                    newPrefab.transform.parent = gameObjectInstance.transform.parent;
                                    newPrefab.transform.SetSiblingIndex(gameObjectInstance.transform.GetSiblingIndex() + 1);
                                    newPrefab.transform.localPosition = gameObjectInstance.transform.localPosition;
                                    newPrefab.transform.localRotation = gameObjectInstance.transform.localRotation;
                                    newPrefab.transform.localScale = gameObjectInstance.transform.localScale;
                                }
                                else
                                {
                                    newPrefab.transform.position = gameObjectInstance.transform.position;
                                    newPrefab.transform.rotation = gameObjectInstance.transform.rotation;
                                    newPrefab.transform.localScale = gameObjectInstance.transform.localScale;
                                }

                                gameObjectInstance.SetActive(false);
                            }
                            else
                            {
                                DestroyImmediate(newPrefab);
                            }
                        }
                    }

                    GetPrefabObjects();
                }
            }
        }

        void DrawPresetDownload()
        {
            if (PresetsEnum.Length < 2)
            {
                GUILayout.Space(10);

                if (GUILayout.Button("Download Conversion Presets", GUILayout.Height(24)))
                {
                    Application.OpenURL("https://u3d.as/35xx");
                }
            }
        }

        void DrawConversionSettings()
        {
            GUILayout.Space(10);

            if (anySupportedPrefabCount > 0 && unsupportedPrefabCount == 0)
            {
                EditorGUI.BeginChangeCheck();

                GUILayout.BeginHorizontal();

                presetIndex = StyledPresetPopup("Conversion Preset", "The preset used to convert the selected prefab or prefabs.", presetIndex, PresetsEnum);

                if (presetIndex != 0)
                {
                    if (StyledMiniToggleButton("", "Select the preset file.", 12, false))
                    {
                        EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(presetPaths[presetIndex]));
                    }

                    var lastRect = GUILayoutUtility.GetLastRect();
                    var iconRect = new Rect(lastRect.x, lastRect.y - 1, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("Preset.Context"));
                }

                GUILayout.EndHorizontal();

                if (EditorGUI.EndChangeCheck())
                {
                    presetAutoDetected = false;
                    hasPresetModifications = true;

                    GetAllPresetInfo(true);
                }

                if (presetIndex != 0 && OptionsEnum.Length > 1)
                {
                    EditorGUI.BeginChangeCheck();

                    GUILayout.BeginHorizontal();

                    optionIndex = StyledPresetPopup("Conversion Option", "The preset used to convert the selected prefab or prefabs.", optionIndex, OptionsEnum);
                    GUILayout.Label("", GUILayout.Width(GUI_SQUARE_BUTTON_WIDTH - 2));

                    GUILayout.EndHorizontal();

                    if (EditorGUI.EndChangeCheck())
                    {
                        optionAutoDetected = false;
                        hasOptionModifications = true;

                        GetAllPresetInfo(false);
                    }
                }
            }

            if (anySupportedPrefabCount > 0 || convertedLockedPrefabCount > 0)
            {
                for (int i = 0; i < overrideIndices.Count; i++)
                {
                    GUILayout.BeginHorizontal();

                    EditorGUI.BeginChangeCheck();

                    overrideIndices[i] = StyledPresetPopup("Override " + (i + 1).ToString("00") + " Preset", "Adds extra functionality over the currently used preset.", overrideIndices[i], OverridesEnum);
                    //overrideIndices[i] = StyledPresetPopup("Converter Override", "Adds extra functionality over the currently used preset.", overrideIndices[i], OverridesEnum);

                    if (overrideIndices[i] == 0)
                    {
                        GUI.enabled = false;
                    }

                    if (EditorGUI.EndChangeCheck())
                    {
                        GetAllPresetInfo(false);
                    }

                    EditorGUI.BeginChangeCheck();

                    overrideGlobals[i] = StyledMiniToggleButton("", "Set Override as global for future conversions.", 11, overrideGlobals[i]);

                    var lastRect = GUILayoutUtility.GetLastRect();
                    var iconRect = new Rect(lastRect.x - 1, lastRect.y - 1, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("InspectorLock"));

                    if (overrideIndices[i] == 0)
                    {
                        overrideGlobals[i] = false;
                    }

                    if (EditorGUI.EndChangeCheck())
                    {
                        var globalOverrides = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Converter Overrides.asset", "");

                        var currentOverride = OverridesEnum[overrideIndices[i]];

                        if (overrideGlobals[i] == true)
                        {
                            if (!globalOverrides.Contains(currentOverride))
                            {
                                globalOverrides = globalOverrides + currentOverride + ";";
                            }
                        }
                        else
                        {
                            globalOverrides = globalOverrides.Replace(currentOverride + ";", "");
                        }

                        SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Converter Overrides.asset", globalOverrides);
                    }

                    GUI.enabled = true;

                    GUILayout.EndHorizontal();
                }

                var overridesCount = overrideIndices.Count;

                if (overrideIndices[0] != 0 || overridesCount > 1)
                {
                    GUILayout.BeginHorizontal();

                    GUILayout.Label("");

                    //if (overridesCount > 1)
                    //{
                    //    if (GUILayout.Button(new GUIContent("-", "Remove the last override."), GUILayout.MaxWidth(GUI_SQUARE_BUTTON_WIDTH), GUILayout.MaxHeight(GUI_SQUARE_BUTTON_HEIGHT)))
                    //    {
                    //        overrideIndices.RemoveAt(overridesCount - 1);
                    //        overrideGlobals.RemoveAt(overridesCount - 1);

                    //        GetAllPresetInfo(false);
                    //    }
                    //}

                    if (GUILayout.Button(new GUIContent("+", "Add a new override."), GUILayout.MaxWidth(GUI_SQUARE_BUTTON_WIDTH), GUILayout.MaxHeight(GUI_SQUARE_BUTTON_HEIGHT)))
                    {
                        overrideIndices.Add(0);
                        overrideGlobals.Add(false);
                    }

                    GUILayout.EndHorizontal();
                }
            }

            GUILayout.Space(10);

            if (supportedPrefabCount > 0 || convertedPrefabCount > 0)
            {
                EditorGUI.BeginChangeCheck();

                if (shareCommonMaterials)
                {
                    EditorGUILayout.HelpBox("Sharing common materials for vegetation is not recommended because various object and motion properties might not be shareable between all prefab types!", MessageType.Info, true);
                    GUILayout.Space(10);

                    //if (infoSharing != "")
                    //{
                    //    if (infoSharing == "DEFAULT")
                    //    {
                    //        EditorGUILayout.HelpBox("Sharing common materials for vegetation is not recommended because various object and motion properties cannot be shared between all prefab types!", MessageType.Warning, true);
                    //    }
                    //    else
                    //    {
                    //        EditorGUILayout.HelpBox(infoSharing, MessageType.Warning, true);
                    //    }

                    //    GUILayout.Space(10);
                    //}
                }

                GUILayout.BeginHorizontal();
                GUILayout.Label(new GUIContent("Share Common Materials", "When enabled, the converter will share the materials across multiple prefabs."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                shareCommonMaterials = EditorGUILayout.Toggle(shareCommonMaterials);
                GUILayout.EndHorizontal();

                if (EditorGUI.EndChangeCheck())
                {
                    SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Converter Sharing.asset", shareCommonMaterials.ToString());
                }
            }

            if (supportedPrefabCount > 0 || convertedPrefabCount > 0 || convertedLockedPrefabCount > 0)
            {
                GUILayout.BeginHorizontal();
                GUILayout.Label("Show Advanced Settings", GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                showAdvancedSettings = EditorGUILayout.Toggle(showAdvancedSettings);
                GUILayout.EndHorizontal();

                if (showAdvancedSettings)
                {
                    GUILayout.Space(10);
                    StyledGUI.DrawWindowCategory("Output Settings");
                    GUILayout.Space(10);

                    if (hasOutputModifications)
                    {
                        EditorGUILayout.HelpBox("The output settings have been modified and they will not update when changing the preset or adding overrides!", MessageType.Info, true);

                        GUILayout.Space(10);
                    }



                    EditorGUI.BeginChangeCheck();

                    if (anySupportedPrefabCount > 0)
                    {
                        outputMeshes = StyledPopup("Output Meshes", "Mesh conversion.", outputMeshes, OutputMeshesEnum);
                        outputMaterials = StyledPopup("Output Materials", "Material conversion..", outputMaterials, OutputMaterialsEnum);
                        outputTextures = StyledPopup("Output Textures", "Texture encoding used for conversion.", outputTextures, OutputTexturesEnum);
                    }

                    collectSharing = StyledPopup("Collect Sharing", "Share or create unique materials.", collectSharing, CollectSharingEnum);
                    collectLocking = StyledPopup("Collect Locking", "Lock prefabs from furthur conversion.", collectLocking, BoolEnum);
                    collectBackups = StyledPopup("Collect Backups", "Collect backup files for future conversion.", collectBackups, BoolEnum);

                    GUILayout.Space(10);

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Unique Data Name", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    uniqueDataFormat = EditorGUILayout.TextField(uniqueDataFormat);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Output Base Format", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    outputBaseFormat = EditorGUILayout.TextField(outputBaseFormat);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Output Data Format", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    outputDataFormat = EditorGUILayout.TextField(outputDataFormat);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Collect Base Format", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    collectBaseFormat = EditorGUILayout.TextField(collectBaseFormat);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Collect Data Format", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    collectDataFormat = EditorGUILayout.TextField(collectDataFormat);
                    GUILayout.EndHorizontal();

                    if (EditorGUI.EndChangeCheck())
                    {
                        hasOutputModifications = true;
                    }

                    if (outputMeshes == 1 && anySupportedPrefabCount > 0)
                    {
                        GUILayout.Space(10);
                        StyledGUI.DrawWindowCategory("Model Settings");
                        GUILayout.Space(10);

                        if (hasModelModifications)
                        {
                            EditorGUILayout.HelpBox("The model settings have been modified and they will not update when changing the preset or adding overrides!", MessageType.Info, true);
                            GUILayout.Space(10);
                        }

                        EditorGUI.BeginChangeCheck();

                        readWriteMode = StyledPopup("Read Write Mode", "Set meshes readable mode.", readWriteMode, ReadWriteModeEnum);
                        transformsMode = StyledPopup("Transforms Mode", "Transform meshes to world space.", transformsMode, TransformsModeEnum);

                        GUILayout.Space(10);

                        sourcePivots = StyledSourcePopup("Pivots", "Pivots storing for grass when multiple grass blades are combined into a single originalMesh. Stored in UV4.XY.", sourcePivots, SourcePivotsEnum);
                        optionPivots = StyledPivotsOptionEnum("Pivots", "", sourcePivots, optionPivots);

                        sourceBounds = StyledSourcePopup("Bounds", "Mesh vertex bounds override.", sourceBounds, SourceBoundsEnum);

                        if (sourceBounds == 1)
                        {
                            GUILayout.BeginHorizontal();
                            GUILayout.Label(new GUIContent("Bounds Multiplier", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                            boundsMultiplier = EditorGUILayout.Vector3Field(new GUIContent(""), boundsMultiplier);
                            GUILayout.EndHorizontal();
                        }

                        sourceNormals = StyledSourcePopup("Normals", "", sourceNormals, SourceNormalsEnum);
                        optionNormals = StyledNormalsOptionEnum("Normals", "", sourceNormals, optionNormals);

#if UNITY_6000_2_OR_NEWER
                        sourceMeshLOD = StyledSourcePopup("MeshLOD", "MeshLOD override.", sourceMeshLOD, SourceMeshLODEnum);

                        if (sourceMeshLOD == 1)
                        {
                            GUILayout.BeginHorizontal();
                            GUILayout.Label(new GUIContent("MeshLOD Limit", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                            meshLODLimit = EditorGUILayout.IntField(new GUIContent(""), meshLODLimit);
                            GUILayout.EndHorizontal();
                        }
#endif

                        GUILayout.Space(10);

                        sourceMainCoord = StyledSourcePopup("Main UV", "Main UVs used for the main texture set. Stored in UV0.XY.", sourceMainCoord, SourceCoordEnum);
                        optionMainCoord = StyledCoordOptionEnum("Main UV", "", sourceMainCoord, optionMainCoord);

                        sourceExtraCoord = StyledSourcePopup("Extra UV", "Detail UVs used for layer blending for bark and props. Stored in UV3.XY.", sourceExtraCoord, SourceCoordEnum);
                        optionExtraCoord = StyledCoordOptionEnum("Extra UV", "", sourceExtraCoord, optionExtraCoord);

                        GUILayout.Space(10);

                        sourceVariation = StyledSourcePopup("Vertex R", "", sourceVariation, SourceMaskEnum);
                        textureVariation = StyledTexture("Vertex R", "", sourceVariation, textureVariation);
                        optionVariation = StyledMaskOptionEnum("Vertex R", "", sourceVariation, optionVariation, false);
                        coordVariation = StyledTextureCoord("Vertex R", "", sourceVariation, coordVariation);
                        actionVariation = StyledActionOptionEnum("Vertex R", "", sourceVariation, actionVariation, true);

                        GUILayout.Space(5);

                        sourceOcclusion = StyledSourcePopup("Vertex G", "", sourceOcclusion, SourceMaskEnum);
                        textureOcclusion = StyledTexture("Vertex G", "", sourceOcclusion, textureOcclusion);
                        optionOcclusion = StyledMaskOptionEnum("Vertex G", "", sourceOcclusion, optionOcclusion, false);
                        coordOcclusion = StyledTextureCoord("Vertex G", "", sourceOcclusion, coordOcclusion);
                        actionOcclusion = StyledActionOptionEnum("Vertex G", "", sourceOcclusion, actionOcclusion, true);

                        GUILayout.Space(5);

                        sourceDetail = StyledSourcePopup("Vertex B", "", sourceDetail, SourceMaskEnum);
                        textureDetail = StyledTexture("Vertex B", "", sourceDetail, textureDetail);
                        optionDetail = StyledMaskOptionEnum("Vertex B", "", sourceDetail, optionDetail, false);
                        coordDetail = StyledTextureCoord("Vertex B", "", sourceDetail, coordDetail);
                        actionDetail = StyledActionOptionEnum("Vertex B", "", sourceDetail, actionDetail, true);

                        GUILayout.Space(5);

                        sourceHeight = StyledSourcePopup("Vertex A", "", sourceHeight, SourceMaskEnum);
                        textureHeight = StyledTexture("Vertex A", "", sourceHeight, textureHeight);
                        optionHeight = StyledMaskOptionEnum("Vertex A", "", sourceHeight, optionHeight, false);
                        coordHeight = StyledTextureCoord("Vertex A", "", sourceHeight, coordHeight);
                        actionHeight = StyledActionOptionEnum("Vertex A", "", sourceHeight, actionHeight, true);

                        if (EditorGUI.EndChangeCheck())
                        {
                            hasModelModifications = true;
                        }
                    }

                    if (outputMaterials == 1 && anySupportedPrefabCount > 0)
                    {
                        GUILayout.Space(10);
                        StyledGUI.DrawWindowCategory("Shader Settings");
                        GUILayout.Space(10);

                        //EditorGUILayout.HelpBox("Default shaders used when converting prefabs. When using custom shaders, you can override the built-in shaders and the changes will be saved and used for future conversions!", MessageType.Info, true);

                        if (hasShaderModifications)
                        {
                            EditorGUILayout.HelpBox("The shader settings have been modified and they will not update when changing the preset or adding overrides!", MessageType.Info, true);

                            GUILayout.Space(10);
                        }

                        EditorGUI.BeginChangeCheck();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Prop", "Shader used when converting static props."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderProp = (Shader)EditorGUILayout.ObjectField(shaderProp, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Bark", "Shader used when converting tree bark."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderBark = (Shader)EditorGUILayout.ObjectField(shaderBark, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Leaf", "Shader used when converting tree leaves and bushes"), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderLeaf = (Shader)EditorGUILayout.ObjectField(shaderLeaf, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Plant", "Shader used when converting plants."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderPlant = (Shader)EditorGUILayout.ObjectField(shaderPlant, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Cover", "Shader used when converting covers."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderCover = (Shader)EditorGUILayout.ObjectField(shaderCover, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Grass", "Shader used when converting grasses and flowers."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderGrass = (Shader)EditorGUILayout.ObjectField(shaderGrass, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Shader Cross", "Shader used when converting cross billobards."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        shaderCross = (Shader)EditorGUILayout.ObjectField(shaderCross, typeof(Shader), false);
                        GUILayout.EndHorizontal();

                        if (EditorGUI.EndChangeCheck())
                        {
                            hasShaderModifications = true;
                        }
                    }
                }
            }
        }

        void DrawConversionButtons()
        {
            GUILayout.Space(10);

            GUILayout.BeginHorizontal();

            if (convertedPrefabCount > 0)
            {
                GUI.enabled = true;
            }
            else
            {
                GUI.enabled = false;
            }

            if (GUILayout.Button("Revert", GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 2)))
            {
                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    var prefabData = prefabObjects[i];

                    if (prefabData.status == TVEPrefabMode.Converted)
                    {
                        RevertPrefab(prefabData);
                    }
                }

                GetPrefabObjects();
            }

            if (presetIndex != 0 && outputValid && anySupportedPrefabCount > 0 && unsupportedPrefabCount == 0)
            {
                GUI.enabled = true;
            }
            else
            {
                GUI.enabled = false;
            }

            if (GUILayout.Button("Convert"))
            {
                keepConvertedMaterials = false;
                keepConvertedMaterialsSet = false;

                copySharedMaterials = false;
                copySharedMaterialsSet = false;

                keepConvertedPrefabs = false;

                if (convertedPrefabCount > 0 && supportedPrefabCount > 0)
                {
                    keepConvertedPrefabs = EditorUtility.DisplayDialog("Skip Converted Prefabs?", "The selection contains both converted and regular prefabs! Would you like to keep the previously converted prefabs or re-convert them?", "Skip Converted Prefabs", "Re-Convert");
                }

                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    var prefabData = prefabObjects[i];

                    if (prefabData.status == TVEPrefabMode.Supported || prefabData.status == TVEPrefabMode.Converted)
                    {
                        if (prefabData.status == TVEPrefabMode.Converted)
                        {
                            if (!keepConvertedPrefabs)
                            {
                                RevertPrefab(prefabData);
                                ConvertPrefab(prefabData);
                            }
                        }

                        if (prefabData.status == TVEPrefabMode.Supported)
                        {
                            ConvertPrefab(prefabData);
                        }
                    }

                    // Only ask to keep the converted materials at the beginning
                    if (i > 0)
                    {
                        keepConvertedMaterialsSet = true;
                    }
                }

                GetPrefabObjects();
                GetPrefabPresets();

                EditorUtility.ClearProgressBar();
            }

            var convertRect = GUILayoutUtility.GetLastRect();

            if (anySupportedPrefabCount > 0 && unsupportedPrefabCount > 0)
            {
                GUI.enabled = true;

                var convertIconRect = new Rect(convertRect.xMax - 20, convertRect.y, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);

                GUI.Label(convertIconRect, EditorGUIUtility.IconContent("console.erroricon.sml"));
                GUI.Label(convertIconRect, new GUIContent("", "Converting mixed prefabs is not supported. Make sure all selected Models, SpeedTree or Tree Creator assets are saved as prefabs and all overrides are applied!"));
            }

            if (convertedPrefabCount > 0 || convertedLockedPrefabCount > 0)
            {
                GUI.enabled = true;
            }
            else
            {
                GUI.enabled = false;
            }

            if (StyledMiniToggleButton("", "", 12, false))
            {
                int collectMode = EditorUtility.DisplayDialogComplex("Collect Converted Data", "Use the Collect feature to copy the converted prefabs and associated files to a new folder. Use the Export feature to save the converted prefabs and associated files as a package.", "Collect And Export", "Cancel", "Export Only");

                // 0 - Collect And Export
                // 1 - Cancel
                // 2 - Export Only
                if (collectMode == 0)
                {
                    if (collectBaseFormat.Contains("COLLECTROOT") || collectDataFormat.Contains("COLLECTROOT"))
                    {
                        var latestDataFolder = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Converter Latest.asset", "Assets");

                        if (!Directory.Exists(latestDataFolder))
                        {
                            latestDataFolder = "Assets";
                        }

                        collectFolder = EditorUtility.OpenFolderPanel("Save Converted Assets to Folder", latestDataFolder, "");

                        if (collectFolder != "")
                        {
                            collectFolder = "Assets" + collectFolder.Substring(Application.dataPath.Length);
                        }

                        if (collectFolder != "")
                        {
                            if (!Directory.Exists(collectFolder))
                            {
                                Directory.CreateDirectory(collectFolder);
                                AssetDatabase.Refresh();
                            }

                            SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Converter Latest.asset", collectFolder);
                        }
                        else
                        {
                            GUIUtility.ExitGUI();
                            return;
                        }
                    }

                    exportList = new();

                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        var prefabData = prefabObjects[i];

                        if (prefabData.status == TVEPrefabMode.Converted || prefabData.status == TVEPrefabMode.ConvertedAndLocked || prefabData.status == TVEPrefabMode.ConvertedMissingBackup)
                        {
                            CollectPrefab(prefabData);
                        }
                    }

                    // Stupid but it works
                    CollectAndLinkNestedPrefabs();

                    ExportPrefabs();

                    GetPrefabObjects();
                }

                if (collectMode == 2)
                {
                    exportList = new();

                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        var prefabData = prefabObjects[i];

                        if (prefabData.status == TVEPrefabMode.Converted)
                        {
                            CollectPrefabForExport(prefabData);
                        }
                    }

                    ExportPrefabs();

                    GetPrefabObjects();
                }
            }

            var collectRect = GUILayoutUtility.GetLastRect();

            //if (convertedPrefabCount > 0 && unsupportedPrefabCount + supportedPrefabCount > 0)
            //{
            //    GUI.enabled = true;

            //    var collectIconRect = new Rect(collectRect.x + 1, collectRect.y, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);

            //    GUI.Label(collectIconRect, EditorGUIUtility.IconContent("console.erroricon.sml"));
            //    GUI.Label(collectIconRect, new GUIContent("", "Collecting mixed prefabs is not supported. Make sure all selected prefabs are converted!"));
            //}
            //else
            //{
            var collectIconRect = new Rect(collectRect.x, collectRect.y - 1, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);

            //GUI.color = new Color(1f, 0.8f, 0.4f);

            GUI.Label(collectIconRect, EditorGUIUtility.IconContent("d_Package Manager@2x"));
            GUI.Label(collectIconRect, new GUIContent("", "Collect converted data to a new location."));
            //}

            GUILayout.EndHorizontal();

            GUI.enabled = true;
        }

        void StyledPrefab(TVEPrefabData prefabData)
        {
            if (prefabData.status == TVEPrefabMode.Converted || prefabData.status == TVEPrefabMode.ConvertedAndLocked)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    GUILayout.Label("<size=10><b><color=#fdc779>" + prefabData.prefabObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    GUILayout.Label("<size=10><b><color=#e16f00>" + prefabData.prefabObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
            }

            if (prefabData.status == TVEPrefabMode.Supported)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    GUILayout.Label("<size=10><b><color=#87b8ff>" + prefabData.prefabObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    GUILayout.Label("<size=10><b><color=#0b448b>" + prefabData.prefabObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
            }

            if (prefabData.status == TVEPrefabMode.Unsupported || prefabData.status == TVEPrefabMode.Backup || prefabData.status == TVEPrefabMode.ConvertedMissingBackup)
            {
                GUILayout.Label("<size=10><b><color=#808080>" + prefabData.prefabObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
            }

            var lastRect = GUILayoutUtility.GetLastRect();

            if (GUI.Button(lastRect, "", GUIStyle.none))
            {
                EditorGUIUtility.PingObject(prefabData.prefabObject);
            }

            var iconRect = new Rect(lastRect.width - 6, lastRect.y + 2, 20, 20);
            var iconExtra = new Rect(lastRect.width - 28, lastRect.y + 3, 20, 20);

            if (prefabData.status == TVEPrefabMode.Supported)
            {
                GUI.color = new Color(0.5f, 0.7f, 1f);

                if (prefabData.isNested)
                {
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_PrefabVariant On Icon"));
                    GUI.Label(iconRect, new GUIContent("", "The prefab is part of a nested prefab."));
                }
                else
                {
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_Prefab On Icon"));
                    GUI.Label(iconRect, new GUIContent("", "The prefab is supported!"));
                }

                GUI.color = Color.white;

                //if (prefabData.hasRotations)
                //{
                //    GUI.Label(iconExtra, EditorGUIUtility.IconContent("console.warnicon.sml"));
                //    //GUI.Label(iconExtra, new GUIContent("", "The prefab has rotated gameobjects or the meshes are set as Z-up which might cause issues! The converter can bake the axis rotations if the Transforms Mode is set to Transform To World Space under Model Settings!"));
                //    GUI.Label(iconExtra, new GUIContent("", "The prefab has rotated gameobjects or the meshes are set as Z-up which might cause issues if the x rotation diverges a lot from -90 degrees!"));
                //}
            }

            if (prefabData.status == TVEPrefabMode.Unsupported)
            {
                if (prefabData.hasOverrides)
                {
                    GUI.color = new Color(0.5f, 0.5f, 0.5f);
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_Prefab On Icon"));
                    GUI.color = Color.white;

                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_PrefabOverlayAdded Icon"));
                    GUI.Label(iconRect, new GUIContent("", "The prefab has overrides! Make sure to apply the overrides to support converting the prefab!"));

                    GUI.Label(iconExtra, EditorGUIUtility.IconContent("console.erroricon.sml"));
                    GUI.Label(iconExtra, new GUIContent("", "The prefab has overrides! Make sure to apply the overrides to support converting the prefab!"));
                }
                else
                {
                    GUI.color = new Color(0.9f, 0.8f, 1f);
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_PrefabModel Icon"));
                    GUI.color = Color.white;
                    GUI.Label(iconRect, new GUIContent("", "SpeedTree, Tree Creator, Models or any other asset type prefabs cannot be converted directly, you will need to create a regular prefab first! Drag the prefab into hierarchy then back to project window or from the hierarchy to project window."));

                    GUI.Label(iconExtra, EditorGUIUtility.IconContent("console.erroricon.sml"));
                    GUI.Label(iconExtra, new GUIContent("", "SpeedTree, Tree Creator, Models or any other asset type prefabs cannot be converted directly, you will need to create a regular prefab first! Drag the prefab into hierarchy then back to project window or from the hierarchy to project window."));
                }
            }

            if (prefabData.status == TVEPrefabMode.Converted || prefabData.status == TVEPrefabMode.ConvertedAndLocked)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    GUI.color = new Color(0.95f, 0.75f, 0.45f);
                }
                else
                {
                    GUI.color = new Color(1f, 0.6f, 0.2f);
                }

                if (prefabData.isNested)
                {
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_PrefabVariant On Icon"));
                    GUI.Label(iconRect, new GUIContent("", "The prefab is converted and part of a nested prefab."));
                }
                else
                {
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("d_Prefab On Icon"));
                    GUI.Label(iconRect, new GUIContent("", "The prefab is converted!"));
                }

                if (prefabData.isShared)
                {
                    GUI.Label(iconExtra, EditorGUIUtility.IconContent("d_Material On Icon"));
                    GUI.Label(iconExtra, new GUIContent("", "The prefab is converted using shared materials!"));
                }
                else
                {
                    GUI.color = new Color(0.5f, 0.5f, 0.5f);
                    GUI.Label(iconExtra, EditorGUIUtility.IconContent("d_Material On Icon"));
                    GUI.Label(iconExtra, new GUIContent("", "The prefab is converted using unique materials!"));
                }

                GUI.color = Color.white;
            }

            if (prefabData.status == TVEPrefabMode.ConvertedMissingBackup)
            {
                GUI.Label(iconRect, EditorGUIUtility.IconContent("console.erroricon.sml"));
                GUI.Label(iconRect, new GUIContent("", "The prefab cannot be reverted or re-converted because the backup file is missing!"));
            }

            if (prefabData.status == TVEPrefabMode.ConvertedAndLocked)
            {
                GUI.color = new Color(1f, 0.3f, 0.1f);

                var iconLock = new Rect(lastRect.width - 48, lastRect.y + 1, 20, 20);

                GUI.Label(iconLock, EditorGUIUtility.IconContent("InspectorLock"));
                GUI.Label(iconLock, new GUIContent("", "The prefab cannot be reverted or re-converted because the prefab is locked!"));

                GUI.color = Color.white;
            }

            if (prefabData.status == TVEPrefabMode.Backup)
            {
                GUI.Label(iconRect, EditorGUIUtility.IconContent("console.erroricon.sml"));
                GUI.Label(iconRect, new GUIContent("", "The prefab is a backup file used to revert the converted prefab!"));
            }
        }

        int StyledPopup(string name, string tooltip, int index, string[] options)
        {
            if (index >= options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(new GUIContent(name, tooltip), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
            index = EditorGUILayout.Popup(index, options, stylePopup);
            GUILayout.EndHorizontal();

            return index;
        }

        int StyledPresetPopup(string name, string tooltip, int index, string[] options)
        {
            if (index >= options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(new GUIContent(name, tooltip), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));

            if (name.Contains("Conversion Preset") && presetAutoDetected)
            {
                var lastRect = GUILayoutUtility.GetLastRect();
                var iconRect = new Rect(lastRect.x + 85, lastRect.y - 3, 100, 20);

                //GUI.color = new Color(2f, 0.9f, 0.5f);
                GUI.Label(iconRect, "<size=10>(Detected)</size>", styleLabel);
                //GUI.Label(iconRect, EditorGUIUtility.IconContent("d_Linked@2x"));
                //GUI.color = Color.white;
            }

            if (name.Contains("Conversion Option") && optionAutoDetected)
            {
                var lastRect = GUILayoutUtility.GetLastRect();
                var iconRect = new Rect(lastRect.x + 85, lastRect.y - 3, 100, 20);

                //GUI.color = new Color(0.75f, 0.95f, 2.0f);
                GUI.Label(iconRect, "<size=10>(Detected)</size>", styleLabel);
                //GUI.Label(iconRect, EditorGUIUtility.IconContent("d_Linked@2x"));
                //GUI.color = Color.white;
            }

            index = EditorGUILayout.Popup(index, options, stylePopup);

            var popupRect = GUILayoutUtility.GetLastRect();
            GUI.Label(popupRect, new GUIContent("", options[index]));

            GUILayout.EndHorizontal();

            return index;
        }

        int StyledSourcePopup(string name, string tooltip, int index, string[] options)
        {
            index = StyledPopup(name + " Source", tooltip, index, options);

            return index;
        }

        int StyledActionOptionEnum(string name, string tooltip, int source, int option, bool space)
        {
            if (source > 0)
            {
                option = StyledPopup(name + " Action", tooltip, option, SourceActionEnum);
            }

            //if (space)
            //{
            //    GUILayout.Space(GUI_SPACE_SMALL);
            //}

            return option;
        }

        int StyledMaskOptionEnum(string name, string tooltip, int source, int option, bool space)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourceMaskMeshEnum);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceMaskProceduralEnum);
            }
            if (source == 3)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourceFromTextureEnum);
            }
            if (source == 4)
            {
                option = StyledPopup(name + " 3rd Party", tooltip, option, SourceMask3rdPartyEnum);
            }

            //if (space)
            //{
            //    GUILayout.Space(GUI_SPACE_SMALL);
            //}

            return option;
        }

        Texture2D StyledTexture(string name, string tooltip, int source, Texture2D texture)
        {
            if (source == 3)
            {
                GUILayout.BeginHorizontal();
                GUILayout.Label(new GUIContent(name + " Texture", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                texture = (Texture2D)EditorGUILayout.ObjectField(texture, typeof(Texture2D), false);
                GUILayout.EndHorizontal();
            }

            return texture;
        }

        int StyledTextureCoord(string name, string tooltip, int sourceTexture, int option)
        {
            if (sourceTexture == 3)
            {
                option = StyledPopup(name + " Coord", tooltip, option, SourceCoordMeshEnum);
            }

            return option;
        }

        int StyledCoordOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourceCoordMeshEnum);
                //GUILayout.Space(GUI_SPACE_SMALL);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceCoordProceduralEnum);
                //GUILayout.Space(GUI_SPACE_SMALL);
            }
            if (source == 3)
            {
                option = StyledPopup(name + " 3rd Party", tooltip, option, SourceCoord3rdPartyEnum);
                //GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        int StyledPivotsOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourcePivotsMeshEnum);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourcePivotsProceduralEnum);
                //GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        int StyledNormalsOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceNormalsProceduralEnum);
                //GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            return value;
        }

        bool StyledMiniToggleButton(string text, string tooltip, int size, bool value)
        {
            value = GUILayout.Toggle(value, new GUIContent("<size=" + size + ">" + text + "</size>", tooltip), styleMiniToggleButton, GUILayout.MaxWidth(GUI_SQUARE_BUTTON_WIDTH), GUILayout.MaxHeight(GUI_SQUARE_BUTTON_HEIGHT));

            return value;
        }

        /// <summary>
        /// Convert and Revert Macros
        /// </summary>

        void ConvertPrefab(TVEPrefabData prefabData)
        {
            var prefabPath = AssetDatabase.GetAssetPath(prefabData.prefabObject);

            convertFolder = Path.GetDirectoryName(prefabPath);

            EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Prepare Prefab", 0.0f);

            currentPrefab = prefabData;
            //currentPrefabObject = prefabData.prefabObject;

            if (prefabData.isVariant && !prefabData.isNested)
            {
                currentPrefab.prefabInstance = Instantiate(prefabData.prefabObject);
            }
            else
            {
                currentPrefab.prefabInstance = (GameObject)PrefabUtility.InstantiatePrefab(prefabData.prefabObject);
            }

            currentPrefab.prefabInstance.name = prefabData.prefabObject.name;

            currentPrefab.prefabInstance.AddComponent<TVEPrefab>();

            var prefabComponent = currentPrefab.prefabInstance.GetComponent<TVEPrefab>();

            prefabComponent.storedPrefabParentGUID = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(prefabData.prefabObject));

            prefabComponent.storedPreset = PresetsEnum[presetIndex] + ";" + OptionsEnum[optionIndex];

            for (int i = 0; i < overrideIndices.Count; i++)
            {
                if (overrideIndices[i] != 0)
                {
                    prefabComponent.storedOverrides = prefabComponent.storedOverrides + OverridesEnum[overrideIndices[i]] + ";";
                }
            }

            prefabComponent.storedOverrides.Replace("None", "");

            EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Create Backup", 0.1f);

            var prefabBackup = CreatePrefabBackupFile(prefabData);

            prefabComponent.storedPrefabBackupGUID = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(prefabBackup));

            EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Prepare Assets", 0.2f);

            GetGameObjectsInPrefab();
            //GetGameObjectZUpInPrefab();
            FixInvalidPrefabScripts();

            DisableInvalidGameObjectsInPrefab();

            GetMeshRenderersInPrefab();
            GetMaterialArraysInPrefab();

            EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Convert Materials", 0.4f);

            if (outputMaterials != FALSE)
            {
                CreateMaterialArraysInstances();
                ConvertMaterials();
            }

            if (outputMeshes != FALSE)
            {
                GetMeshFiltersInPrefab();
                GetMeshesInPrefab();
                GetMeshCollidersInPrefab();
                GetCollidersInPrefab();

                PreProcessMeshes();

                CreateMeshInstances();

                EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Transform Meshes", 0.5f);

                if (transformsMode == TRUE)
                {
                    currentPrefab.prefabInstance.transform.localPosition = Vector3.zero;
                    currentPrefab.prefabInstance.transform.rotation = Quaternion.identity;
                    currentPrefab.prefabInstance.transform.localScale = Vector3.one;

                    TransformMeshesToWorldSpace();
                }

                // The bounds are needed before converting the mesh
                GetMaxBoundsInPrefab();

                EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Convert Meshes", 0.6f);

                ConvertMeshes();

                // Convert Colliders
                CreateColliderInstances();

                EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Transform Colliders", 0.7f);

                if (transformsMode == TRUE)
                {
                    TransformCollidersToWorldSpace();
                }

                EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Convert Colliders", 0.8f);

                ConvertColliders();

                if (transformsMode == TRUE)
                {
                    ResetGameObjectsTransforms();
                }

                PostProcessMeshes();
            }

            if (outputMaterials != FALSE)
            {
                PostProcessMaterials();
            }

            EnableInvalidGameObjectsInPrefab();

            EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Save Prefab", 0.9f);

            var saveFormat = outputBaseFormat;
            saveFormat = saveFormat.Replace("CONVERTROOT", convertFolder);
            saveFormat = saveFormat.Replace("BASENAME", prefabData.prefabObject.name);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            // Rebuild path to avoid issues when the folder and prefab names are the same
            //var saveFolder = saveFormat.Replace(splitFormat[splitFormat.Length - 1], "");

            var saveFolder = "";

            for (int i = 0; i < splitFormat.Length - 1; i++)
            {
                saveFolder = saveFolder + splitFormat[i] + "/";
            }

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            var saveName = splitFormat[splitFormat.Length - 1];

            var savePath = saveFolder + saveName + ".prefab";

            if (File.Exists(savePath))
            {
                PrefabUtility.SaveAsPrefabAssetAndConnect(currentPrefab.prefabInstance, savePath, InteractionMode.AutomatedAction);
            }
            else
            {
                PrefabUtility.SaveAsPrefabAsset(currentPrefab.prefabInstance, savePath);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            TVEUtils.SetLabel(savePath);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            EditorUtility.DisplayProgressBar("The Visual Engine", prefabData.prefabObject.name + ": Finish Conversion", 1.0f);

            DestroyImmediate(currentPrefab.prefabInstance);
        }

        void RevertPrefab(TVEPrefabData prefabData)
        {
            var prefabBackup = GetPrefabBackupFile(prefabData.prefabObject);

            var backupData = GetPrefabData(prefabBackup);

            if (backupData.isVariant && !backupData.isNested)
            {
                currentPrefab.prefabInstance = Instantiate(prefabBackup);
            }
            else
            {
                currentPrefab.prefabInstance = (GameObject)PrefabUtility.InstantiatePrefab(prefabBackup);
                PrefabUtility.UnpackPrefabInstance(currentPrefab.prefabInstance, PrefabUnpackMode.OutermostRoot, InteractionMode.AutomatedAction);
            }

            GetGameObjectsInPrefab();
            FixInvalidPrefabScripts();

            var prefabPath = AssetDatabase.GetAssetPath(prefabData.prefabObject);

            PrefabUtility.SaveAsPrefabAssetAndConnect(currentPrefab.prefabInstance, prefabPath, InteractionMode.AutomatedAction);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            DestroyImmediate(currentPrefab.prefabInstance);
        }

        void CollectPrefab(TVEPrefabData prefabData)
        {
            if (prefabData.isVariant && !prefabData.isNested)
            {
                currentPrefab.prefabInstance = Instantiate(prefabData.prefabObject);
            }
            else
            {
                currentPrefab.prefabInstance = (GameObject)PrefabUtility.InstantiatePrefab(prefabData.prefabObject);
                PrefabUtility.UnpackPrefabInstance(currentPrefab.prefabInstance, PrefabUnpackMode.OutermostRoot, InteractionMode.AutomatedAction);
            }

            currentPrefab.prefabInstance.name = prefabData.prefabObject.name;

            var prefabComponent = currentPrefab.prefabInstance.GetComponent<TVEPrefab>();
            var prefabParentGUID = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(prefabData.prefabObject));

            // Add the parent GUID for legacy conversions
            if (prefabComponent != null)
            {
                prefabComponent.storedPrefabParentGUID = prefabParentGUID;

                if (collectLocking == TRUE)
                {
                    prefabComponent.lockInAssetConverter = true;
                }
            }

            if (collectBackups == TRUE)
            {
                CollectPrefabBackups();
            }

            GetGameObjectsInPrefab();
            FixInvalidPrefabScripts();

            DisableNestedPrefabsInPrefab();

            GetMeshRenderersInPrefab();
            GetMaterialArraysInPrefab();

            CollectPrefabMaterials();

            GetMeshFiltersInPrefab();
            GetMeshesInPrefab();
            GetMeshCollidersInPrefab();
            GetCollidersInPrefab();

            CollectPrefabMeshes();
            CollectPrefabColliders();

            EnableNestedPrefabsInPrefab();

            var saveFormat = collectBaseFormat;
            saveFormat = saveFormat.Replace("COLLECTROOT", collectFolder);
            saveFormat = saveFormat.Replace("BASENAME", prefabData.prefabObject.name);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            // Rebuild path to avoid issues when the folder and prefab names are the same
            //var saveFolder = saveFormat.Replace(splitFormat[splitFormat.Length - 1], "");

            var saveFolder = "";

            for (int i = 0; i < splitFormat.Length - 1; i++)
            {
                saveFolder = saveFolder + splitFormat[i] + "/";
            }

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            var saveName = splitFormat[splitFormat.Length - 1];

            var savePath = saveFolder + saveName + ".prefab";

            if (File.Exists(savePath))
            {
                PrefabUtility.SaveAsPrefabAssetAndConnect(currentPrefab.prefabInstance, savePath, InteractionMode.AutomatedAction);
            }
            else
            {
                PrefabUtility.SaveAsPrefabAsset(currentPrefab.prefabInstance, savePath);
            }

            //var saveFolder = saveFormat;

            //if (!Directory.Exists(saveFolder))
            //{
            //    Directory.CreateDirectory(saveFolder);
            //    AssetDatabase.Refresh();
            //}

            //if (!saveFolder.EndsWith("/"))
            //{
            //    saveFolder = saveFolder + "/";
            //}

            //var savePath = saveFolder + prefabData.prefabObject.name + ".prefab";

            //if (File.Exists(savePath))
            //{
            //    PrefabUtility.SaveAsPrefabAssetAndConnect(currentPrefab.prefabInstance, savePath, InteractionMode.AutomatedAction);
            //}
            //else
            //{
            //    PrefabUtility.SaveAsPrefabAsset(currentPrefab.prefabInstance, savePath);
            //}

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            exportList.Add(savePath);

            DestroyImmediate(currentPrefab.prefabInstance);
        }

        void CollectAndLinkNestedPrefabs()
        {
            var allPrefabsInSaveFolder = Directory.GetFiles(collectFolder + "/", "*.prefab", SearchOption.TopDirectoryOnly);

            List<string> allValidPrefabPaths = new();
            List<string> allValidPrefabGUIDs = new();
            List<string> allValidParentGUIDs = new();

            for (int i = 0; i < allPrefabsInSaveFolder.Length; i++)
            {
                var currentPrefabPath = allPrefabsInSaveFolder[i];

                var currtentPrefabInstance = Instantiate(AssetDatabase.LoadAssetAtPath<GameObject>(currentPrefabPath));
                var currentPrefabComponent = currtentPrefabInstance.GetComponent<TVEPrefab>();

                if (currentPrefabComponent != null)
                {
                    allValidPrefabPaths.Add(currentPrefabPath);
                    allValidPrefabGUIDs.Add(AssetDatabase.AssetPathToGUID(currentPrefabPath));
                    allValidParentGUIDs.Add(currentPrefabComponent.storedPrefabParentGUID);
                }

                DestroyImmediate(currtentPrefabInstance);
            }

            for (int i = 0; i < allValidPrefabPaths.Count; i++)
            {
                var currentPrefabGUID = allValidPrefabGUIDs[i];
                var currentParentGUID = allValidParentGUIDs[i];

                for (int j = 0; j < allValidPrefabPaths.Count; j++)
                {
                    if (i == j)
                    {
                        continue;
                    }

                    var otherPrefabPath = allValidPrefabPaths[j];

                    // This is messing up the order in prefab
                    //string fileText = File.ReadAllText(otherPrefabPath);
                    //fileText = fileText.Replace(currentParentGUID, currentPrefabGUID);
                    //File.WriteAllText(otherPrefabPath, fileText);

                    StreamReader reader = new StreamReader(otherPrefabPath);

                    List<string> lines = new List<string>();

                    while (!reader.EndOfStream)
                    {
                        lines.Add(reader.ReadLine());
                    }

                    reader.Close();

                    for (int s = 0; s < lines.Count; s++)
                    {
                        // This is working better, but still adds the prefabs at the end!?
                        if (lines[s].Contains("m_SourcePrefab"))
                        {
                            lines[s] = lines[s].Replace(currentParentGUID, currentPrefabGUID);
                        }
                    }

                    StreamWriter writer = new StreamWriter(otherPrefabPath);

                    for (int s = 0; s < lines.Count; s++)
                    {
                        writer.WriteLine(lines[s]);
                    }

                    writer.Close();

                    lines.Clear();

                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }
            }
        }

        void CollectPrefabForExport(TVEPrefabData prefabData)
        {
            if (prefabData.isVariant && !prefabData.isNested)
            {
                currentPrefab.prefabInstance = Instantiate(prefabData.prefabObject);
            }
            else
            {
                currentPrefab.prefabInstance = (GameObject)PrefabUtility.InstantiatePrefab(prefabData.prefabObject);
                PrefabUtility.UnpackPrefabInstance(currentPrefab.prefabInstance, PrefabUnpackMode.OutermostRoot, InteractionMode.AutomatedAction);
            }

            if (collectBackups == TRUE)
            {
                CollectPrefabBackupsForExport();
            }

            GetGameObjectsInPrefab();

            DisableNestedPrefabsInPrefab();

            GetMeshRenderersInPrefab();
            GetMaterialArraysInPrefab();

            CollectPrefabMaterialsForExport();

            GetMeshFiltersInPrefab();
            GetMeshesInPrefab();
            GetMeshCollidersInPrefab();
            GetCollidersInPrefab();

            CollectPrefabMeshesForExport();
            CollectPrefabCollidersForExport();

            //EnableNestedPrefabsInPrefab();

            var prefabPath = AssetDatabase.GetAssetPath(prefabData.prefabObject);

            exportList.Add(prefabPath);

            DestroyImmediate(currentPrefab.prefabInstance);
        }

        void ExportPrefabs()
        {
            if (exportList.Count > 0)
            {
                var latestExportFolder = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Converter Export.asset", "Assets");

                if (!Directory.Exists(latestExportFolder))
                {
                    latestExportFolder = "Assets";
                }

                var packagePath = EditorUtility.SaveFilePanelInProject("Save Package", "Converted Prefabs", "unitypackage", "Choose where to save the Unity package files for the selected prefabs.", latestExportFolder);

                if (packagePath != "")
                {
                    SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Converter Export.asset", Path.GetDirectoryName(packagePath));

                    AssetDatabase.ExportPackage(exportList.ToArray(), packagePath, ExportPackageOptions.Default);

                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }
            }
        }

        /// <summary>
        /// Get GameObjects, Materials and MeshFilters in Prefab
        /// </summary>

        void GetPrefabObjects()
        {
            prefabObjects = new List<TVEPrefabData>();
            convertedPrefabCount = 0;
            convertedLockedPrefabCount = 0;
            supportedPrefabCount = 0;
            unsupportedPrefabCount = 0;
            anySupportedPrefabCount = 0;

            List<GameObject> selectionObjects = new();

#if UNITY_2021_3_OR_NEWER
            var prefabStage = PrefabStageUtility.GetCurrentPrefabStage();

            if (prefabStage != null)
            {
                if (prefabStage.assetPath != null)
                {
                    var selection = AssetDatabase.LoadAssetAtPath<GameObject>(prefabStage.assetPath);

                    selectionObjects.Add(selection);
                    TVEUtils.GetChildRecursive(selection, selectionObjects);
                }
            }
            else
            {

                for (int i = 0; i < Selection.gameObjects.Length; i++)
                {
                    var selection = Selection.gameObjects[i];

                    selectionObjects.Add(selection);
                    TVEUtils.GetChildRecursive(selection, selectionObjects);
                }
            }
#else
            
            for (int i = 0; i < Selection.gameObjects.Length; i++)
            {
                var selection = Selection.gameObjects[i];

                selectionObjects.Add(selection);
                TVEUtils.GetChildRecursive(selection, selectionObjects);
            }
#endif
            for (int i = 0; i < selectionObjects.Count; i++)
            {
                var selection = selectionObjects[i];

                var prefabData = GetPrefabData(selection);

                bool prefabDataExists = false;

                for (int j = 0; j < prefabObjects.Count; j++)
                {
                    if (prefabObjects[j].prefabObject == prefabData.prefabObject)
                    {
                        prefabDataExists = true;
                    }
                }

                if (!prefabDataExists)
                {
                    prefabObjects.Add(prefabData);
                }

                if (prefabData.status == TVEPrefabMode.Converted)
                {
                    convertedPrefabCount++;
                }

                if (prefabData.status == TVEPrefabMode.ConvertedAndLocked)
                {
                    convertedLockedPrefabCount++;
                }

                if (prefabData.status == TVEPrefabMode.Supported)
                {
                    supportedPrefabCount++;
                }

                if (prefabData.status == TVEPrefabMode.Unsupported)
                {
                    unsupportedPrefabCount++;
                }

                anySupportedPrefabCount = convertedPrefabCount + supportedPrefabCount;
            }
        }

        TVEPrefabData GetPrefabData(GameObject selection)
        {
            TVEPrefabData prefabData = new TVEPrefabData();

            prefabData.prefabObject = selection;
            prefabData.status = TVEPrefabMode.Undefined;

            if (selection.activeInHierarchy)
            {
                prefabData.prefabInstanceInScene = selection;
            }

            if (PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection).Length > 0)
            {
                var prefabPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection);
                var prefabAsset = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);
                var prefabAssets = AssetDatabase.LoadAllAssetRepresentationsAtPath(prefabPath);
                var prefabType = PrefabUtility.GetPrefabAssetType(prefabAsset);

                if (prefabAssets.Length == 0)
                {
                    if (prefabType == PrefabAssetType.Regular || prefabType == PrefabAssetType.Variant)
                    {
                        var prefabComponent = prefabAsset.GetComponent<TVEPrefab>();

                        if (prefabComponent != null)
                        {
                            prefabData.status = TVEPrefabMode.Converted;

                            var prefabBackupGO = GetPrefabBackupFile(prefabAsset);

                            if (prefabBackupGO == null)
                            {
                                prefabData.status = TVEPrefabMode.ConvertedMissingBackup;
                            }

                            if (prefabComponent.lockInAssetConverter)
                            {
                                prefabData.status = TVEPrefabMode.ConvertedAndLocked;
                            }
                        }
                        else
                        {
                            if (prefabPath.Contains("Backup"))
                            {
                                prefabData.status = TVEPrefabMode.Backup;
                            }
                            else
                            {
                                prefabData.status = TVEPrefabMode.Supported;
                            }
                        }

                        if (prefabType == PrefabAssetType.Variant)
                        {
                            prefabData.isVariant = true;
                        }
                    }
                    else if (prefabType == PrefabAssetType.MissingAsset || prefabType == PrefabAssetType.NotAPrefab)
                    {
                        prefabData.status = TVEPrefabMode.Undefined;
                    }
                }
                else
                {
                    if (prefabType == PrefabAssetType.Model || prefabPath.EndsWith(".st") || prefabPath.EndsWith(".st9") || prefabPath.EndsWith(".spm") || prefabPath.EndsWith(".prefab"))
                    {
                        prefabData.status = TVEPrefabMode.Unsupported;

                        //var prefabExtension = Path.GetExtension(prefabPath);
                        //var prefabaAltPath = prefabPath.Replace(prefabExtension, " Prefab.prefab");

                        //if (File.Exists(prefabaAltPath))
                        //{
                        //    prefabData.status = TVEPrefabMode.Supported;
                        //    prefabAsset = AssetDatabase.LoadAssetAtPath<GameObject>(prefabaAltPath);
                        //}
                    }
                }

                prefabData.prefabObject = prefabAsset;

                //if (selection.activeInHierarchy)
                //{
                //    prefabData.gameObjectInstance = selection;
                //}
            }
            else
            {
                prefabData.prefabObject = selection;
                prefabData.status = TVEPrefabMode.Undefined;
            }

            if (prefabData.status == TVEPrefabMode.Supported || prefabData.status == TVEPrefabMode.Converted || prefabData.status == TVEPrefabMode.ConvertedAndLocked)
            {
                prefabData = GetPrefabAttributes(prefabData);
            }

            return prefabData;
        }

        TVEPrefabData GetPrefabAttributes(TVEPrefabData prefabData)
        {
            string attributes = "";

            var rootPath = AssetDatabase.GetAssetPath(prefabData.prefabObject);

            attributes += rootPath + ";";

            var gameObjects = new List<GameObject>();
            var meshRenderers = new List<MeshRenderer>();

            gameObjects.Add(prefabData.prefabObject);
            TVEUtils.GetChildRecursive(prefabData.prefabObject, gameObjects);

            if (prefabData.prefabObject.transform.localEulerAngles.x >= 270 && prefabData.prefabObject.transform.localEulerAngles.x < 275)
            {
                prefabData.isZUp = true;
            }

            for (int i = 0; i < gameObjects.Count; i++)
            {
                var gameObject = gameObjects[i];
                var prefabRoot = PrefabUtility.GetNearestPrefabInstanceRoot(prefabData.prefabObject);
                var childRoot = PrefabUtility.GetNearestPrefabInstanceRoot(gameObject);

                if (prefabRoot != childRoot)
                {
                    if (childRoot != null)
                    {
                        gameObjects[i] = null;
                        prefabData.isNested = true;
                    }
                }
            }

            for (int i = 0; i < gameObjects.Count; i++)
            {
                var gameObject = gameObjects[i];

                // gameObject can be null if the prefab is nested
                if (gameObject != null)
                {
                    //if (gameObject.transform.localRotation.x != 0)
                    //{
                    //    prefabData.hasRotations = true;
                    //}

                    if (gameObject.GetComponent<MeshRenderer>() != null)
                    {
                        meshRenderers.Add(gameObject.GetComponent<MeshRenderer>());

                        if (gameObject.transform.localEulerAngles.x >= 270 && gameObject.transform.localEulerAngles.x < 275)
                        {
                            prefabData.isZUp = true;
                        }
                    }
                }
            }

            for (int i = 0; i < meshRenderers.Count; i++)
            {
                if (meshRenderers[i].sharedMaterials != null)
                {
                    for (int j = 0; j < meshRenderers[i].sharedMaterials.Length; j++)
                    {
                        var material = meshRenderers[i].sharedMaterials[j];

                        if (material != null)
                        {
                            if (!attributes.Contains(material.shader.name))
                            {
                                attributes += material.shader.name + ",";

                                var path = AssetDatabase.GetAssetPath(material);

                                if (TVEUtils.HasLabel(path))
                                {
                                    if (material.HasProperty("_IsShared"))
                                    {
                                        var shared = material.GetInt("_IsShared");

                                        if (shared == 1)
                                        {
                                            prefabData.isShared = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (prefabData.prefabInstanceInScene != null)
            {
                var overrides = PrefabUtility.GetObjectOverrides(prefabData.prefabInstanceInScene);
                var overridesCount = 0;               

                for (int i = 0; i < overrides.Count; i++)
                {
                    if (overrides[i].instanceObject.GetType() != typeof(UnityEngine.Transform))
                    {
                        overridesCount++;
                    }
                }

                if (overridesCount > 0)
                {
                    prefabData.hasOverrides = true;
                }
            }

            if (prefabData.prefabObject != null)
            {
                var prefabPath = AssetDatabase.GetAssetPath(prefabData.prefabObject);

                StreamReader reader = new StreamReader(prefabPath);

                string previous = null;

                while (!reader.EndOfStream)
                {
                    string line = reader.ReadLine();

                    if (previous != null && previous.TrimStart().StartsWith("m_AddedGameObjects:") && line.TrimStart().StartsWith("-"))
                    {
                        prefabData.hasOverrides = true;
                        break;
                    }

                    previous = line;
                }

                reader.Close();
            }

            if (prefabData.hasOverrides)
            {
                prefabData.status = TVEPrefabMode.Unsupported;
            }

            prefabData.attributes = attributes.ToUpperInvariant();

            return prefabData;
        }

        void GetPrefabPresets()
        {
            presetMixedValues = false;
            presetAutoDetected = false;
            optionAutoDetected = false;

            var presetIndices = new int[prefabObjects.Count];

            if (prefabObjects.Count > 0)
            {
                for (int o = 0; o < prefabObjects.Count; o++)
                {
                    var prefabData = prefabObjects[o];
                    var prefabComponent = prefabData.prefabObject.GetComponent<TVEPrefab>();

                    if (prefabComponent != null)
                    {
                        if (prefabComponent.storedPreset != "")
                        {
                            // Get new style presets
                            if (prefabComponent.storedPreset.Contains(";"))
                            {
                                var splitLine = prefabComponent.storedPreset.Split(char.Parse(";"));

                                var preset = splitLine[0];
                                var option = splitLine[1];

                                for (int i = 0; i < PresetsEnum.Length; i++)
                                {
                                    if (PresetsEnum[i] == preset)
                                    {
                                        presetIndex = i;
                                        presetIndices[o] = i;

                                        hasPresetFromPrefab = true;

                                        GetAllPresetInfo(false);

                                        for (int j = 0; j < OptionsEnum.Length; j++)
                                        {
                                            if (OptionsEnum[j] == option)
                                            {
                                                optionIndex = j;

                                                GetAllPresetInfo(false);                                                
                                            }
                                        }
                                    }
                                }
                            }
                            // Try get old style presets
                            else
                            {
                                var splitLine = prefabComponent.storedPreset.Split(char.Parse("/"));

                                var option = splitLine[splitLine.Length - 1];
                                var preset = prefabComponent.storedPreset.Replace("/" + option, "");

                                for (int i = 0; i < PresetsEnum.Length; i++)
                                {
                                    if (PresetsEnum[i] == prefabComponent.storedPreset || PresetsEnum[i] == preset)
                                    {
                                        presetIndex = i;
                                        presetIndices[o] = i;

                                        hasPresetFromPrefab = true;

                                        GetAllPresetInfo(false);

                                        for (int j = 0; j < OptionsEnum.Length; j++)
                                        {
                                            if (OptionsEnum[j] == option)
                                            {
                                                optionIndex = j;

                                                GetAllPresetInfo(false);
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        if (prefabComponent.storedOverrides != "")
                        {
                            var splitLine = prefabComponent.storedOverrides.Split(char.Parse(";"));

                            for (int i = 0; i < splitLine.Length; i++)
                            {
                                for (int j = 0; j < OverridesEnum.Length; j++)
                                {
                                    if (OverridesEnum[j] == splitLine[i])
                                    {
                                        if (!overrideIndices.Contains(j))
                                        {
                                            overrideIndices.Add(j);
                                            overrideGlobals.Add(false);
                                        }
                                    }
                                }
                            }
                        }

                        presetAutoDetected = false;
                        optionAutoDetected = false;
                    }
                    else
                    {
                        if (hasPresetFromPrefab)
                        {
                            continue;
                        }

                        if (hasPresetModifications)
                        {
                            continue;
                        }

                        // Try to autodetect preset
                        for (int i = 0; i < detectLines.Count; i++)
                        {
                            if (detectLines[i].StartsWith("Detect"))
                            {
                                var detect = detectLines[i].Replace("Detect ", "").Split(new string[] { " && " }, System.StringSplitOptions.None);
                                var preset = detectLines[i + 1].Replace("Preset ", "").Replace(" - ", "/");

                                int detectCount = 0;

                                for (int d = 0; d < detect.Length; d++)
                                {
                                    var element = detect[d].ToUpperInvariant();

                                    if (element.StartsWith("!"))
                                    {
                                        element = element.Replace("!", "");

                                        if (!prefabData.attributes.Contains(element))
                                        {
                                            detectCount++;
                                        }
                                    }
                                    else
                                    {
                                        if (prefabData.attributes.Contains(element))
                                        {
                                            detectCount++;
                                        }
                                    }
                                }

                                if (detectCount == detect.Length)
                                {
                                    for (int j = 0; j < PresetsEnum.Length; j++)
                                    {
                                        if (PresetsEnum[j] == preset)
                                        {
                                            presetIndex = j;
                                            presetIndices[o] = (j);
                                            presetAutoDetected = true;
                                        }
                                    }
                                }
                            }
                        }

                        if (hasOptionModifications)
                        {
                            continue;
                        }

                        for (int i = 0; i < detectLines.Count; i++)
                        {
                            if (detectLines[i].StartsWith("Prefab") && presetIndex > 0 && optionAutoDetected == false)
                            {
                                var detect = detectLines[i].Replace("Prefab ", "").Split(new string[] { " && " }, System.StringSplitOptions.None);
                                var option = detectLines[i + 1].Replace("Option ", "");

                                int detectCount = 0;

                                for (int d = 0; d < detect.Length; d++)
                                {
                                    var keywords = detect[d].ToUpperInvariant().Split(new string[] { "/" }, System.StringSplitOptions.None); ;

                                    bool keywordValid = false;

                                    for (int s = 0; s < keywords.Length; s++)
                                    {
                                        var keyword = keywords[s];


                                        var prefabPath = AssetDatabase.GetAssetPath(prefabData.prefabObject).ToUpper();

                                        if (keyword.StartsWith("!"))
                                        {
                                            keyword = keyword.Replace("!", "");

                                            if (!prefabPath.Contains(keyword))
                                            {
                                                keywordValid = true;
                                            }
                                        }
                                        else
                                        {
                                            if (prefabPath.Contains(keyword))
                                            {

                                                keywordValid = true;
                                            }
                                        }
                                    }

                                    if (keywordValid)
                                    {
                                        detectCount++;
                                    }
                                }

                                if (detectCount == detect.Length)
                                {
                                    GetAllPresetInfo(false);

                                    for (int j = 0; j < OptionsEnum.Length; j++)
                                    {
                                        if (OptionsEnum[j] == option)
                                        {
                                            optionIndex = j;
                                            optionAutoDetected = true;
                                        }
                                    }
                                }
                            }
                        }


                    }
                }

                for (int i = 1; i < presetIndices.Length; i++)
                {
                    if (presetIndices[i - 1] == 0)
                    {
                        presetIndices[i - 1] = presetIndices[i];
                    }

                    if (presetIndices[i - 1] != presetIndices[i])
                    {
                        presetIndex = 0;
                        presetMixedValues = true;

                        break;
                    }
                }

                //if (presetIndex > 0 && optionAutoDetected == false)
                //{
                //    for (int o = 0; o < prefabObjects.Count; o++)
                //    {
                //        var prefabData = prefabObjects[o];

                //        // Try to autodetect option
                //        for (int i = 0; i < detectLines.Count; i++)
                //        {
                //            if (detectLines[i].StartsWith("Prefab"))
                //            {
                //                var detect = detectLines[i].Replace("Prefab ", "").Split(new string[] { " && " }, System.StringSplitOptions.None);
                //                var option = detectLines[i + 1].Replace("Option ", "");

                //                int detectCount = 0;

                //                for (int d = 0; d < detect.Length; d++)
                //                {
                //                    var keywords = detect[d].ToUpperInvariant().Split(new string[] { "/" }, System.StringSplitOptions.None); ;

                //                    bool keywordValid = false;

                //                    for (int s = 0; s < keywords.Length; s++)
                //                    {
                //                        var keyword = keywords[s];

                //                        var prefabPath = AssetDatabase.GetAssetPath(prefabData.prefabObject).ToUpper();

                //                        if (keyword.StartsWith("!"))
                //                        {
                //                            keyword = keyword.Replace("!", "");

                //                            if (!prefabPath.Contains(keyword))
                //                            {
                //                                keywordValid = true;
                //                            }
                //                        }
                //                        else
                //                        {
                //                            if (prefabPath.Contains(keyword))
                //                            {

                //                                keywordValid = true;
                //                            }
                //                        }
                //                    }

                //                    if (keywordValid)
                //                    {
                //                        detectCount++;
                //                    }
                //                }

                //                if (detectCount == detect.Length)
                //                {
                //                    GetAllPresetInfo(false);

                //                    for (int j = 0; j < OptionsEnum.Length; j++)
                //                    {
                //                        if (OptionsEnum[j] == option)
                //                        {
                //                            optionIndex = j;
                //                            optionAutoDetected = true;
                //                        }
                //                    }
                //                }
                //            }
                //        }
                //    }
                //}
            }
        }

        GameObject CreatePrefabBackupFile(TVEPrefabData prefabData)
        {
            var saveName = GetConvertedAssetName(prefabData.prefabObject, "Backup", true);
            var savePath = GetConvertedAssetPath(prefabData.prefabObject, saveName, "prefab", "Backup");

            AssetDatabase.SetLabels(prefabData.prefabObject, new string[] { });

            AssetDatabase.CopyAsset(AssetDatabase.GetAssetPath(prefabData.prefabObject), savePath);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            return AssetDatabase.LoadAssetAtPath<GameObject>(savePath);
        }

        GameObject GetPrefabBackupFile(GameObject prefabInstance)
        {
            GameObject prefabBackupGO = null;

            var prefabBackupGUID = prefabInstance.GetComponent<TVEPrefab>().storedPrefabBackupGUID;

            if (prefabBackupGUID != null || prefabBackupGUID != "")
            {
                var prefabBackupPath = AssetDatabase.GUIDToAssetPath(prefabBackupGUID);
                prefabBackupGO = AssetDatabase.LoadAssetAtPath<GameObject>(prefabBackupPath) as GameObject;
            }

            // Get the backup if serialization changed
            //if (prefabBackupGO == null)
            //{
            //    var prefabPath = AssetDatabase.GetAssetPath(prefabInstance);
            //    var prefabName = Path.GetFileNameWithoutExtension(prefabPath);
            //    var prefabBackupName = prefabName + " (Backup)";
            //    var prefabBackupAssets = AssetDatabase.FindAssets(prefabBackupName);

            //    if (prefabBackupAssets != null && prefabBackupAssets.Length > 0)
            //    {
            //        var prefabBackupPath = AssetDatabase.GUIDToAssetPath(prefabBackupAssets[0]);
            //        prefabBackupGO = AssetDatabase.LoadAssetAtPath<GameObject>(prefabBackupPath);
            //    }
            //}

            return prefabBackupGO;
        }

        void GetGameObjectsInPrefab()
        {
            gameObjectDataSet = new List<TVEGameObjectData>();

            var gameObjectData = new TVEGameObjectData();
            gameObjectData.gameObject = currentPrefab.prefabInstance;

            gameObjectDataSet.Add(gameObjectData);

            TVEUtils.GetChildRecursive(currentPrefab.prefabInstance, gameObjectDataSet);
        }

        void DisableInvalidGameObjectsInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObject = gameObjectDataSet[i].gameObject;

                if (gameObject.name.Contains("Impostor"))
                {
                    var material = gameObject.GetComponent<MeshRenderer>().sharedMaterial;

                    if (material != null)
                    {
                        if (material.shader.name.Contains("Polyart/Utilities/Impostor"))
                        {
                            gameObject.SetActive(false);
                            Debug.Log("<b>[The Visual Engine]</b> " + "Polyart Impostors are not supported! The " + gameObject.name + " gameobject has been disabled. You can manually enable them after the conversion is done!");
                        }
                    }
                }

                if (gameObject.GetComponent<BillboardRenderer>() != null)
                {
                    gameObject.SetActive(false);
                    Debug.Log("<b>[The Visual Engine]</b> " + "Billboard Renderers are not supported! The " + gameObject.name + " gameobject has been disabled. You can manually enable them after the conversion is done!");
                }

                //if (gameObject.GetComponent<MeshRenderer>() != null)
                //{
                //    var material = gameObject.GetComponent<MeshRenderer>().sharedMaterial;

                //    if (material != null)
                //    {
                //        if (material.shader.name.Contains("BK/Billboards"))
                //        {
                //            gameObject.SetActive(false);
                //            Debug.Log("<b>[The Visual Engine]</b> " + "BK Billboard Renderers are not supported! The " + gameObject.name + " gameobject has been disabled. You can manually enable them after the conversion is done!");
                //        }
                //    }
                //}

                if (gameObject.GetComponent<Tree>() != null)
                {
                    DestroyImmediate(gameObject.GetComponent<Tree>());
                }

                if (PrefabUtility.GetNearestPrefabInstanceRoot(gameObject) != PrefabUtility.GetNearestPrefabInstanceRoot(currentPrefab.prefabInstance))
                {
                    gameObject.SetActive(false);
                }
            }
        }

        void EnableInvalidGameObjectsInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObject = gameObjectDataSet[i].gameObject;

                if (gameObject.name.Contains("Impostor") == true)
                {
                    gameObject.SetActive(true);
                }

                if (PrefabUtility.GetNearestPrefabInstanceRoot(gameObject) != PrefabUtility.GetNearestPrefabInstanceRoot(currentPrefab.prefabInstance))
                {
                    gameObject.SetActive(true);
                }
            }
        }

        void DisableNestedPrefabsInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObject = gameObjectDataSet[i].gameObject;

                if (PrefabUtility.GetNearestPrefabInstanceRoot(gameObject) != PrefabUtility.GetNearestPrefabInstanceRoot(currentPrefab.prefabInstance))
                {
                    gameObject.SetActive(false);
                }
            }
        }

        void EnableNestedPrefabsInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObject = gameObjectDataSet[i].gameObject;

                if (PrefabUtility.GetNearestPrefabInstanceRoot(gameObject) != PrefabUtility.GetNearestPrefabInstanceRoot(currentPrefab.prefabInstance))
                {
                    gameObject.SetActive(true);
                }
            }
        }

        void FixInvalidPrefabScripts()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObject = gameObjectDataSet[i].gameObject;

                GameObjectUtility.RemoveMonoBehavioursWithMissingScript(gameObject);
            }
        }

        //void GetGameObjectZUpInPrefab()
        //{
        //    for (int i = 0; i < gameObjectDataSet.Count; i++)
        //    {
        //        var gameObjectData = gameObjectDataSet[i];

        //        if (IsValidGameObject(gameObjectData.gameObject))
        //        {
        //            if (gameObjectData.gameObject.transform.eulerAngles.x > -100 && gameObjectData.gameObject.transform.eulerAngles.x < -80)
        //            {
        //                gameObjectData.isZUp = true;
        //            }
        //        }
        //    }
        //}

        void GetMeshRenderersInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];
                var meshRenderer = gameObjectData.gameObject.GetComponent<MeshRenderer>();

                if (IsValidGameObject(gameObjectData.gameObject) && meshRenderer != null)
                {
                    gameObjectData.meshRenderer = meshRenderer;
                }
            }
        }

        void GetMaterialArraysInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                if (gameObjectData.meshRenderer != null)
                {
                    gameObjectData.originalMaterials = gameObjectData.meshRenderer.sharedMaterials;
                }
            }
        }

        void CreateMaterialArraysInstances()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                if (gameObjectData.originalMaterials != null)
                {
                    var originalMaterials = gameObjectData.originalMaterials;
                    var instanceMaterials = new Material[originalMaterials.Length];

                    for (int j = 0; j < originalMaterials.Length; j++)
                    {
                        var originalMaterial = originalMaterials[j];

                        if (IsValidMaterial(originalMaterial))
                        {
                            var dataName = GetConvertedAssetName(originalMaterial, "Material", shareCommonMaterials);
                            var dataPath = GetConvertedAssetPath(originalMaterial, dataName, "mat", "Material");

                            var sharedDataName = GetConvertedAssetName(originalMaterial, "Material", true);
                            var sharedDataPath = GetConvertedAssetPath(originalMaterial, sharedDataName, "mat", "Material");

                            var dataNameLegacy = GetLegacyAssetName(originalMaterial, "Material", shareCommonMaterials);
                            var dataPathLegacy = GetLegacyAssetPath(originalMaterial, dataNameLegacy, "mat", "Material");

                            var sharedDataNameLegacy = GetLegacyAssetName(originalMaterial, "Material", true);
                            var sharedDataPathLegacy = GetLegacyAssetPath(originalMaterial, sharedDataNameLegacy, "mat", "Material");

                            if (File.Exists(dataPath))
                            {
                                if (!keepConvertedMaterialsSet)
                                {
                                    keepConvertedMaterials = EditorUtility.DisplayDialog("Keep Converted Materials?", "Converted materials used by the current prefabs are found! Would you like to keep the previously converted materials or reconvert and replace them?", "Keep Converted Materials", "Replace");

                                    keepConvertedMaterialsSet = true;
                                }

                                if (keepConvertedMaterials)
                                {
                                    instanceMaterials[j] = AssetDatabase.LoadAssetAtPath<Material>(dataPath);
                                }
                                else
                                {
                                    instanceMaterials[j] = CreateMaterialInstance(originalMaterial, dataName, shareCommonMaterials);
                                }
                            }
                            else if (File.Exists(sharedDataPath))
                            {
                                if (!copySharedMaterialsSet)
                                {
                                    copySharedMaterials = EditorUtility.DisplayDialog("Copy Shared Materials?", "Shared materials used by the current prefabs are found! Would you like to copy the previously converted materials or create new ones?", "Copy Shared Materials", "Create New");

                                    copySharedMaterialsSet = true;
                                }

                                if (copySharedMaterials)
                                {
                                    var oldMaterial = AssetDatabase.LoadAssetAtPath<Material>(sharedDataPath);
                                    var newMaterial = CreateMaterialInstance(oldMaterial, dataName, shareCommonMaterials);

                                    instanceMaterials[j] = SaveMaterial(newMaterial, dataPath);
                                }
                                else
                                {
                                    instanceMaterials[j] = CreateMaterialInstance(originalMaterial, dataName, shareCommonMaterials);
                                }
                            }
                            else if (File.Exists(dataPathLegacy))
                            {
                                if (!keepConvertedMaterialsSet)
                                {
                                    keepConvertedMaterials = EditorUtility.DisplayDialog("Copy Legacy Materials?", "Legacy converted materials used by the current prefabs are found! Would you like to copy the previously converted materials settings or create new ones?", "Copy Legacy Materials", "Create New");

                                    keepConvertedMaterialsSet = true;
                                }

                                if (keepConvertedMaterials)
                                {
                                    var oldMaterial = AssetDatabase.LoadAssetAtPath<Material>(dataPathLegacy);
                                    var newMaterial = CreateMaterialInstance(oldMaterial, dataName, shareCommonMaterials);

                                    instanceMaterials[j] = SaveMaterial(newMaterial, dataPath);
                                }
                                else
                                {
                                    instanceMaterials[j] = CreateMaterialInstance(originalMaterial, dataName, shareCommonMaterials);
                                }
                            }
                            else if (File.Exists(sharedDataPathLegacy))
                            {
                                if (!copySharedMaterialsSet)
                                {
                                    copySharedMaterials = EditorUtility.DisplayDialog("Copy Shared Materials?", "Shared materials used by the current prefabs are found! Would you like to copy the previously converted materials or create new ones?", "Copy Shared Materials", "Create New");

                                    copySharedMaterialsSet = true;
                                }

                                if (copySharedMaterials)
                                {
                                    var oldMaterial = AssetDatabase.LoadAssetAtPath<Material>(sharedDataPathLegacy);
                                    var newMaterial = CreateMaterialInstance(oldMaterial, dataName, shareCommonMaterials);

                                    instanceMaterials[j] = SaveMaterial(newMaterial, dataPath);
                                }
                                else
                                {
                                    instanceMaterials[j] = CreateMaterialInstance(originalMaterial, dataName, shareCommonMaterials);
                                }
                            }
                            else
                            {
                                instanceMaterials[j] = CreateMaterialInstance(originalMaterial, dataName, shareCommonMaterials);
                            }
                        }
                        else
                        {
                            instanceMaterials[j] = originalMaterial;
                        }
                    }

                    gameObjectData.instanceMaterials = instanceMaterials;
                }
            }
        }

        Material CreateMaterialInstance(Material material, string dataName, bool shareCommonAssets)
        {
            Material instance;

            if (material.HasProperty("_IsTVEShader"))
            {
                instance = Instantiate(material);
            }
            else
            {
                instance = new Material(shaderLeaf);
            }

            instance.name = dataName;
            instance.enableInstancing = true;

            instance.SetInt("_IsIdentifier", (int)Random.Range(1, 100));

            if (shareCommonAssets)
            {
                instance.SetInt("_IsShared", 1);
            }
            else
            {
                instance.SetInt("_IsShared", 0);
            }

            return instance;
        }

        void GetMeshFiltersInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];
                var meshFilter = gameObjectData.gameObject.GetComponent<MeshFilter>();

                if (IsValidGameObject(gameObjectData.gameObject) && meshFilter != null)
                {
                    gameObjectData.meshFilter = meshFilter;
                }
            }
        }

        void GetMeshesInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                if (gameObjectData.meshFilter != null)
                {
                    gameObjectData.originalMesh = gameObjectData.meshFilter.sharedMesh;
                }
            }
        }

        void CreateMeshInstances()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];
                var originalMesh = gameObjectData.originalMesh;

                if (originalMesh != null)
                {
                    var dataName = GetConvertedAssetName(originalMesh, "Model", true);

                    var meshInstance = Instantiate(originalMesh);
                    meshInstance.name = dataName;
                    gameObjectData.instanceMesh = meshInstance;
                }
            }
        }

        void GetMeshCollidersInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                var allMeshCollider = gameObjectData.gameObject.GetComponents<MeshCollider>();

                if (IsValidGameObject(gameObjectData.gameObject))
                {
                    for (int j = 0; j < allMeshCollider.Length; j++)
                    {
                        gameObjectData.meshColliders.Add(allMeshCollider[j]);
                    }
                }
            }
        }

        void GetCollidersInPrefab()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                for (int j = 0; j < gameObjectData.meshColliders.Count; j++)
                {
                    var meshCollider = gameObjectData.meshColliders[j];

                    gameObjectData.originalColliders.Add(meshCollider.sharedMesh);
                }
            }
        }

        void CreateColliderInstances()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                for (int j = 0; j < gameObjectData.meshColliders.Count; j++)
                {
                    var originalCollider = gameObjectData.originalColliders[j];

                    if (originalCollider != null)
                    {
                        var dataName = GetConvertedAssetName(originalCollider, "Model", true);
                        var dataPath = GetConvertedAssetPath(originalCollider, dataName, "asset", "Model");

                        if (File.Exists(dataPath))
                        {
                            var instanceCollider = AssetDatabase.LoadAssetAtPath<Mesh>(dataPath);
                            gameObjectData.instanceColliders.Add(instanceCollider);
                        }
                        else
                        {
                            var instanceCollider = Instantiate(originalCollider);
                            instanceCollider.name = dataName;

                            gameObjectData.instanceColliders.Add(instanceCollider);
                        }
                    }
                    else
                    {
                        gameObjectData.instanceColliders.Add(null);
                    }
                }
            }
        }

        void PreProcessMeshes()
        {
            uniqueMeshSettings = new List<TVEModelSettings>();

            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var originalMesh = gameObjectDataSet[i].originalMesh;

                if (originalMesh != null)
                {
                    var meshPath = AssetDatabase.GetAssetPath(originalMesh);

                    bool exists = false;

                    for (int s = 0; s < uniqueMeshSettings.Count; s++)
                    {
                        var meshSettings = uniqueMeshSettings[s];

                        if (meshSettings.meshPath == meshPath)
                        {
                            exists = true;
                            break;
                        }
                    }

                    if (!exists)
                    {
                        var meshSettings = TVEUtils.PreProcessMesh(meshPath);
                        uniqueMeshSettings.Add(meshSettings);
                    }
                }
            }

            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var originalColliders = gameObjectDataSet[i].originalColliders;

                for (int j = 0; j < originalColliders.Count; j++)
                {
                    var originalMesh = originalColliders[j];

                    var meshPath = AssetDatabase.GetAssetPath(originalMesh);

                    bool exists = false;

                    for (int s = 0; s < uniqueMeshSettings.Count; s++)
                    {
                        var meshSettings = uniqueMeshSettings[s];

                        if (meshSettings.meshPath == meshPath)
                        {
                            exists = true;
                            break;
                        }
                    }

                    if (!exists)
                    {
                        var meshSettings = TVEUtils.PreProcessMesh(meshPath);
                        uniqueMeshSettings.Add(meshSettings);
                    }
                }
            }
        }

        void PostProcessMeshes()
        {
            for (int i = 0; i < uniqueMeshSettings.Count; i++)
            {
                var meshSettings = uniqueMeshSettings[i];
                TVEUtils.PostProcessMesh(meshSettings.meshPath, meshSettings);
            }
        }

        void TransformMeshesToWorldSpace()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                if (gameObjectData.instanceMesh != null)
                {
                    var instanceMesh = gameObjectData.instanceMesh;
                    var transform = gameObjectData.gameObject.transform;

                    Vector3[] verticesOS = instanceMesh.vertices;
                    Vector3[] verticesWS = new Vector3[instanceMesh.vertices.Length];

                    // Transform vertioces OS pos to WS pos
                    for (int v = 0; v < verticesOS.Length; v++)
                    {
                        verticesWS[v] = transform.TransformPoint(verticesOS[v]);
                    }

                    gameObjectData.instanceMesh.vertices = verticesWS;

                    //Some meshes don't have normals, check is needed
                    if (instanceMesh.normals != null && instanceMesh.normals.Length > 0)
                    {
                        Vector3[] normalsOS = instanceMesh.normals;
                        Vector3[] normalsWS = new Vector3[instanceMesh.vertices.Length];

                        for (int v = 0; v < normalsOS.Length; v++)
                        {
                            normalsWS[v] = transform.TransformDirection(normalsOS[v]);
                            //normalsWS[j] = new Vector3(transform.lossyScale.x * trans.x, transform.lossyScale.y * trans.y, transform.lossyScale.z * trans.z);
                        }

                        gameObjectData.instanceMesh.normals = normalsWS;
                    }

                    //Some meshes don't have tangenst, check is needed
                    if (instanceMesh.tangents != null && instanceMesh.tangents.Length > 0)
                    {
                        Vector4[] tangentsOS = instanceMesh.tangents;
                        Vector4[] tangentsWS = new Vector4[instanceMesh.vertices.Length];

                        for (int v = 0; v < tangentsOS.Length; v++)
                        {
                            tangentsWS[v] = transform.TransformDirection(tangentsOS[v]);
                            tangentsWS[v].w = tangentsOS[v].w;
                        }

                        gameObjectData.instanceMesh.tangents = tangentsWS;
                    }

                    //gameObjectData.mesh.RecalculateTangents();
                    gameObjectData.instanceMesh.RecalculateBounds();
                }
            }
        }

        void TransformCollidersToWorldSpace()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                for (int j = 0; j < gameObjectData.originalColliders.Count; j++)
                {
                    if (gameObjectData.originalColliders[j] != null && !EditorUtility.IsPersistent(gameObjectData.instanceColliders[j]))
                    {
                        var instanceCollider = gameObjectData.instanceColliders[j];
                        var transform = gameObjectData.gameObject.transform;

                        Vector3[] verticesOS = instanceCollider.vertices;
                        Vector3[] verticesWS = new Vector3[instanceCollider.vertices.Length];

                        // Transform vertioces OS pos to WS pos
                        for (int v = 0; v < verticesOS.Length; v++)
                        {
                            verticesWS[v] = transform.TransformPoint(verticesOS[v]);
                        }

                        gameObjectData.instanceColliders[j].vertices = verticesWS;

                        // Some meshes don't have normals, check is needed
                        if (instanceCollider.normals != null && instanceCollider.normals.Length > 0)
                        {
                            Vector3[] normalsOS = instanceCollider.normals;
                            Vector3[] normalsWS = new Vector3[instanceCollider.vertices.Length];

                            for (int v = 0; v < normalsOS.Length; v++)
                            {
                                normalsWS[j] = transform.TransformDirection(normalsOS[j]);
                                //normalsWS[j] = new Vector3(transform.lossyScale.x * trans.x, transform.lossyScale.y * trans.y, transform.lossyScale.z * trans.z);
                            }

                            gameObjectData.instanceColliders[j].normals = normalsWS;
                        }

                        //Some meshes don't have tangenst, check is needed
                        if (instanceCollider.tangents != null && instanceCollider.tangents.Length > 0)
                        {
                            Vector4[] tangentsOS = instanceCollider.tangents;
                            Vector4[] tangentsWS = new Vector4[instanceCollider.vertices.Length];

                            for (int t = 0; t < tangentsOS.Length; t++)
                            {
                                tangentsWS[t] = transform.TransformDirection(tangentsOS[t]);
                                tangentsWS[j].w = tangentsOS[j].w;
                            }

                            gameObjectData.instanceColliders[j].tangents = tangentsWS;
                        }

                        gameObjectData.instanceColliders[j].RecalculateBounds();
                    }
                }
            }
        }

        void ResetGameObjectsTransforms()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObject = gameObjectDataSet[i].gameObject;

                gameObject.transform.localPosition = Vector3.zero;
                gameObject.transform.localEulerAngles = Vector3.zero;
                gameObject.transform.localScale = Vector3.one;
            }
        }

        void GetMaxBoundsInPrefab()
        {
            maxBoundsInfo = Vector4.zero;

            var bounds = new Bounds(Vector3.zero, Vector3.zero);

            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshInstance = gameObjectDataSet[i].instanceMesh;

                if (meshInstance != null)
                {
                    bounds.Encapsulate(meshInstance.bounds);
                }
            }

            float maxR;
            float maxH;
            float maxS;

            if (currentPrefab.isZUp)
            {
                var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
                var maxY = Mathf.Max(Mathf.Abs(bounds.min.y), Mathf.Abs(bounds.max.y));

                maxR = Mathf.Max(maxX, maxY);
                maxH = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));
                maxS = Mathf.Max(maxR, maxH);
            }
            else
            {
                var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
                var maxZ = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));

                maxR = Mathf.Max(maxX, maxZ);
                maxH = Mathf.Max(Mathf.Abs(bounds.min.y), Mathf.Abs(bounds.max.y));
                maxS = Mathf.Max(maxR, maxH);
            }

            maxBoundsInfo = new Vector4(maxR, maxH, maxS, 0.0f);
        }

        bool IsValidGameObject(GameObject gameObject)
        {
            bool valid = true;

            if (gameObject.activeInHierarchy == false)
            {
                valid = false;
            }

            return valid;
        }

        /// <summary>
        /// Mesh Packing Macros
        /// </summary>

        void ConvertColliders()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshColliders = gameObjectDataSet[i].meshColliders;
                var originalColliders = gameObjectDataSet[i].originalColliders;
                var instanceColliders = gameObjectDataSet[i].instanceColliders;

                for (int j = 0; j < meshColliders.Count; j++)
                {
                    var meshCollider = meshColliders[j];
                    var originalCollider = originalColliders[j];
                    var instanceCollider = instanceColliders[j];

                    if (instanceCollider != null)
                    {
                        if (EditorUtility.IsPersistent(instanceCollider))
                        {
                            meshCollider.sharedMesh = instanceCollider;
                        }
                        else
                        {
                            var dataPath = GetConvertedAssetPath(originalCollider, instanceCollider.name, "asset", "Model");

                            meshCollider.sharedMesh = SaveMesh(instanceCollider, dataPath);
                        }
                    }
                }
            }
        }

        void ConvertMeshes()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var gameObjectData = gameObjectDataSet[i];

                var meshFilter = gameObjectDataSet[i].meshFilter;
                var originalMesh = gameObjectDataSet[i].originalMesh;
                var instanceMesh = gameObjectDataSet[i].instanceMesh;

                if (instanceMesh != null)
                {
                    if (outputMeshes == TRUE)
                    {
                        ConvertMesh(gameObjectData);
                    }

                    ConvertMeshNormals(gameObjectData);
                    ConvertMeshBounds(gameObjectData);

#if UNITY_6000_2_OR_NEWER
                    ConvertMeshLOD(gameObjectData);
#endif

                    var dataPath = GetConvertedAssetPath(originalMesh, instanceMesh.name, "asset", "Model");

                    meshFilter.sharedMesh = SaveMesh(instanceMesh, dataPath);
                }
            }
        }

        void ConvertMesh(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;
            var subMeshCount = instanceMesh.subMeshCount;

            var colors = new Color[vertexCount];
            var UV0 = GetCoordData(gameObjectData, 0, 0);
            var UV3 = GetCoordData(gameObjectData, 0, 0);
            var UV4 = GetCoordData(gameObjectData, 0, 0);

            var mainCoord = GetCoordData(gameObjectData, sourceMainCoord, optionMainCoord);
            var extraCoord = GetCoordData(gameObjectData, sourceExtraCoord, optionExtraCoord);
            var pivots = GetPivotsData(gameObjectData, sourcePivots, optionPivots);

            var newUV0 = new List<Vector2>(vertexCount);
            var newUV3 = new List<Vector2>(vertexCount);
            var newUV4 = new List<Vector2>(vertexCount);

            for (int s = 0; s < subMeshCount; s++)
            {
                var subMesh = instanceMesh.GetSubMesh(s);
                var baseVertex = subMesh.firstVertex;
                var endVertex = subMesh.firstVertex + subMesh.vertexCount;

                if (!hasModelModifications)
                {
                    Material material = null;

                    // Submesh count can be different than the material array
                    if (gameObjectData.originalMaterials != null && gameObjectData.originalMaterials.Length >= subMeshCount)
                    {
                        if (gameObjectData.originalMaterials[s] != null)
                        {
                            material = gameObjectData.originalMaterials[s];
                        }
                    }

                    GetMeshConversionFromPreset(material);
                }

                List<float> alpha;

                if (sourceHeight == 0)
                {
                    alpha = GetMaskData(gameObjectData, baseVertex, endVertex, 2, 4, 0, null, 0, 1.0f);
                }
                else
                {
                    alpha = GetMaskData(gameObjectData, baseVertex, endVertex, sourceHeight, optionHeight, coordHeight, textureHeight, actionHeight, 1.0f);
                }

                var red = GetMaskData(gameObjectData, baseVertex, endVertex, sourceVariation, optionVariation, coordVariation, textureVariation, actionVariation, 1.0f);
                var green = GetMaskData(gameObjectData, baseVertex, endVertex, sourceOcclusion, optionOcclusion, coordOcclusion, textureOcclusion, actionOcclusion, 1.0f);
                var blue = GetMaskData(gameObjectData, baseVertex, endVertex, sourceDetail, optionDetail, coordDetail, textureDetail, actionDetail, 1.0f);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    colors[i] = new Color(red[i], green[i], blue[i], alpha[i]);
                }

                if (sourceMainCoord != 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        UV0[i] = new Vector2(mainCoord[i].x, mainCoord[i].y);
                    }
                }

                if (sourceExtraCoord != 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        UV3[i] = new Vector2(extraCoord[i].x, extraCoord[i].y);
                    }
                }

                if (sourcePivots != 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        UV4[i] = new Vector2(pivots[i].x, pivots[i].y);
                    }
                }
            }

            // Lengts of UV is not the same as vertex count?!
            if (sourceMainCoord != 0)
            {
                for (int i = 0; i < colors.Length; i++)
                {
                    newUV0.Add(new Vector2(UV0[i].x, UV0[i].y));
                }
            }

            if (sourceExtraCoord != 0)
            {
                for (int i = 0; i < colors.Length; i++)
                {
                    newUV3.Add(new Vector2(UV3[i].x, UV3[i].y));
                }
            }

            if (sourcePivots != 0)
            {
                for (int i = 0; i < colors.Length; i++)
                {
                    newUV4.Add(new Vector2(UV4[i].x, UV4[i].y));
                }
            }

            if (instanceMesh.normals == null)
            {
                instanceMesh.RecalculateNormals();
            }

            if (instanceMesh.tangents == null)
            {
                instanceMesh.RecalculateTangents();
            }

            instanceMesh.SetColors(colors);

            if (sourceMainCoord != 0)
            {
                instanceMesh.SetUVs(0, newUV0);
            }

            if (sourceExtraCoord != 0)
            {
                instanceMesh.SetUVs(2, newUV3);
            }

            if (sourcePivots != 0)
            {
                instanceMesh.SetUVs(3, newUV4);
            }
        }

        void ConvertMeshNormals(TVEGameObjectData gameObjectData)
        {
            if (sourceNormals == 1)
            {
                var instanceMesh = gameObjectData.instanceMesh;
                var subMeshCount = gameObjectData.instanceMesh.subMeshCount;
                var vertices = gameObjectData.instanceMesh.vertices;
                var normals = gameObjectData.instanceMesh.normals;

                if (optionNormals == 0 || normals == null)
                {
                    instanceMesh.RecalculateNormals();
                }

                Vector3[] customNormals = instanceMesh.normals;

                for (int s = 0; s < subMeshCount; s++)
                {
                    var subMesh = instanceMesh.GetSubMesh(s);
                    var material = gameObjectData.instanceMaterials[s];

                    var baseVertex = subMesh.firstVertex;
                    var endVertex = subMesh.firstVertex + subMesh.vertexCount;

                    if (!hasModelModifications)
                    {
                        GetMeshConversionFromPreset(material);
                    }

                    // Flat Shading Low
                    if (optionNormals == 1)
                    {
                        if (currentPrefab.isZUp)
                        {
                            for (int i = baseVertex; i < endVertex; i++)
                            {
                                var height = Mathf.Clamp01(vertices[i].z / maxBoundsInfo.y);

                                customNormals[i] = Vector3.Lerp(normals[i], new Vector3(0, 0, 1), height);
                            }
                        }
                        else
                        {
                            for (int i = baseVertex; i < endVertex; i++)
                            {
                                var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                                customNormals[i] = Vector3.Lerp(normals[i], new Vector3(0, 1, 0), height);
                            }
                        }
                    }

                    // Flat Shading Medium
                    else if (optionNormals == 2)
                    {
                        if (currentPrefab.isZUp)
                        {
                            for (int i = baseVertex; i < endVertex; i++)
                            {
                                var height = Mathf.Clamp01(Mathf.Clamp01(vertices[i].z / maxBoundsInfo.y) + 0.5f);

                                customNormals[i] = Vector3.Lerp(normals[i], new Vector3(0, 0, 1), height);
                            }
                        }
                        else
                        {
                            for (int i = baseVertex; i < endVertex; i++)
                            {
                                var height = Mathf.Clamp01(Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y) + 0.5f);

                                customNormals[i] = Vector3.Lerp(normals[i], new Vector3(0, 1, 0), height);
                            }
                        }
                    }

                    // Flat Shading Full
                    else if (optionNormals == 3)
                    {
                        if (currentPrefab.isZUp)
                        {
                            for (int i = baseVertex; i < endVertex; i++)
                            {
                                customNormals[i] = new Vector3(0, 0, 1);
                            }
                        }
                        else
                        {
                            for (int i = baseVertex; i < endVertex; i++)
                            {
                                customNormals[i] = new Vector3(0, 1, 0);
                            }
                        }
                    }

                    // Spherical Shading Low
                    else if (optionNormals == 4)
                    {
                        for (int i = baseVertex; i < endVertex; i++)
                        {
                            var spherical = Vector3.Normalize(vertices[i]);

                            customNormals[i] = Vector3.Lerp(normals[i], spherical, 0.5f);
                        }
                    }

                    // Spherical Shading Medium
                    else if (optionNormals == 5)
                    {
                        for (int i = baseVertex; i < endVertex; i++)
                        {
                            var spherical = Vector3.Normalize(vertices[i]);

                            customNormals[i] = Vector3.Lerp(normals[i], spherical, 0.75f);
                        }
                    }

                    // Spherical Shading Full
                    else if (optionNormals == 6)
                    {
                        for (int i = baseVertex; i < endVertex; i++)
                        {
                            customNormals[i] = Vector3.Normalize(vertices[i]);
                        }
                    }
                }

                instanceMesh.normals = customNormals;
                instanceMesh.RecalculateTangents();
            }
        }

        void ConvertMeshBounds(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;

            if (sourceBounds == 1)
            {
                var meshBounds = instanceMesh.bounds;

                Bounds bounds = new Bounds();
                Vector3 min = new Vector3(meshBounds.min.x * boundsMultiplier.x, meshBounds.min.y * boundsMultiplier.y, meshBounds.min.z * boundsMultiplier.z);
                Vector3 max = new Vector3(meshBounds.max.x * boundsMultiplier.x, meshBounds.max.y * boundsMultiplier.y, meshBounds.max.z * boundsMultiplier.z);
                bounds.SetMinMax(min, max);

                instanceMesh.bounds = bounds;
            }
        }

#if UNITY_6000_2_OR_NEWER
        void ConvertMeshLOD(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;

            if (sourceMeshLOD == 1)
            {
                MeshLodUtility.GenerateMeshLods(instanceMesh, meshLODLimit);
            }
        }
#endif

        void GetMeshConversionFromPreset(Material material)
        {
            if (presetIndex == 0)
            {
                return;
            }

            var usePresetLines = new List<bool>();
            usePresetLines.Add(true);

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(usePresetLines, presetLines[i], material);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Mesh"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));
                        string name = "";
                        string source = "";
                        int sourceIndex = 0;
                        string option = "";
                        int optionIndex = 0;
                        string action = "";
                        int actionIndex = 0;
                        int coordIndex = 0;

                        var x = "0";
                        var y = "0";
                        var z = "0";

                        string prop = "";
                        Texture2D texture = null;

                        if (splitLine.Length > 1)
                        {
                            name = splitLine[1];
                        }

                        if (splitLine.Length > 2)
                        {
                            source = splitLine[2];

                            if (source == "NONE")
                            {
                                sourceIndex = 0;
                            }

                            if (source == "AUTO")
                            {
                                sourceIndex = 0;
                            }

                            // Available options for Float masks
                            if (source == "GET_MASK_FROM_CHANNEL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_MASK_PROCEDURAL")
                            {
                                sourceIndex = 2;
                            }

                            if (source == "GET_MASK_FROM_TEXTURE")
                            {
                                sourceIndex = 3;
                            }

                            if (source == "GET_MASK_3RD_PARTY")
                            {
                                sourceIndex = 4;
                            }

                            // Available options for Coord masks
                            if (source == "GET_COORD_FROM_CHANNEL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_COORD_PROCEDURAL")
                            {
                                sourceIndex = 2;
                            }

                            if (source == "GET_COORD_3RD_PARTY")
                            {
                                sourceIndex = 3;
                            }

                            if (source == "GET_NORMALS_PROCEDURAL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_BOUNDS_PROCEDURAL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_BOUNDS_MULTIPLIER")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_MESHLOD_PROCEDURAL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "MARK_MESHES_AS_NON_READABLE")
                            {
                                sourceIndex = 0;
                            }

                            if (source == "MARK_MESHES_AS_READABLE")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "USE_ORIGINAL_TRANSFORMS")
                            {
                                sourceIndex = 0;
                            }

                            if (source == "TRANSFORM_TO_WORLD_SPACE")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_PIVOTS_FROM_CHANNEL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_PIVOTS_PROCEDURAL")
                            {
                                sourceIndex = 2;
                            }
                        }

                        if (splitLine.Length > 3)
                        {
                            option = splitLine[3];
                            x = splitLine[3];

                            if (option == "GET_RED")
                            {
                                optionIndex = 0;
                            }
                            else if (option == "GET_GREEN")
                            {
                                optionIndex = 1;
                            }
                            else if (option == "GET_BLUE")
                            {
                                optionIndex = 2;
                            }
                            else if (option == "GET_ALPHA")
                            {
                                optionIndex = 3;
                            }
                            else
                            {
                                if (source != "GET_BOUNDS_MULTIPLIER")
                                {
                                    optionIndex = int.Parse(option);
                                }
                            }
                        }

                        if (splitLine.Length > 4)
                        {
                            prop = splitLine[4];
                            y = splitLine[4];

                            if (material != null && material.HasProperty(prop))
                            {
                                texture = (Texture2D)material.GetTexture(prop);
                            }
                        }

                        if (splitLine.Length > 5)
                        {
                            z = splitLine[5];

                            if (splitLine[5] == "GET_COORD")
                            {
                                coordIndex = int.Parse(splitLine[6]);
                            }
                        }

                        action = splitLine[splitLine.Length - 1];

                        if (action == "ACTION_ONE_MINUS")
                        {
                            actionIndex = 1;
                        }

                        if (action == "ACTION_NEGATIVE")
                        {
                            actionIndex = 2;
                        }

                        if (action == "ACTION_REMAP_01")
                        {
                            actionIndex = 3;
                        }

                        if (action == "ACTION_POWER_2")
                        {
                            actionIndex = 4;
                        }

                        if (action == "ACTION_MULTIPLY_BY_HEIGHT")
                        {
                            actionIndex = 5;
                        }

                        if (action == "ACTION_CLAMP_NEGATIVE_VALUES")
                        {
                            actionIndex = 6;
                        }

                        if (action == "ACTION_FRACTIONAL_VALUES")
                        {
                            actionIndex = 7;
                        }

                        if (action == "ACTION_APPLY_VARIATION_ID")
                        {
                            actionIndex = 8;
                        }

                        if (name == "SetVariation" || name == "SetRed")
                        {
                            sourceVariation = sourceIndex;
                            optionVariation = optionIndex;
                            actionVariation = actionIndex;
                            coordVariation = coordIndex;
                            textureVariation = texture;
                        }

                        if (name == "SetOcclusion" || name == "SetGreen" || name == "SetMotion2")
                        {
                            sourceOcclusion = sourceIndex;
                            optionOcclusion = optionIndex;
                            actionOcclusion = actionIndex;
                            coordOcclusion = coordIndex;
                            textureOcclusion = texture;
                        }

                        if (name == "SetDetailMask" || name == "SetBlue" || name == "SetMotion3")
                        {
                            sourceDetail = sourceIndex;
                            optionDetail = optionIndex;
                            actionDetail = actionIndex;
                            coordDetail = coordIndex;
                            textureDetail = texture;
                        }

                        if (name == "SetExtraCoord")
                        {
                            sourceExtraCoord = sourceIndex;
                            optionExtraCoord = optionIndex;
                        }

                        if (name == "SetHeight" || name == "SetAlpha")
                        {
                            sourceHeight = sourceIndex;
                            optionHeight = optionIndex;
                            actionHeight = actionIndex;
                            coordHeight = coordIndex;
                            textureHeight = texture;
                        }

                        if (name == "SetPivots")
                        {
                            sourcePivots = sourceIndex;
                            optionPivots = optionIndex;
                        }

                        if (name == "SetNormals")
                        {
                            sourceNormals = sourceIndex;
                            optionNormals = optionIndex;
                        }

                        if (name == "SetBounds")
                        {
                            sourceBounds = sourceIndex;
                            boundsMultiplier = new Vector3(float.Parse(x), float.Parse(y), float.Parse(z));
                        }

#if UNITY_6000_2_OR_NEWER
                        if (name == "SetMeshLOD")
                        {
                            sourceMeshLOD = sourceIndex;
                            meshLODLimit = optionIndex;
                        }
#endif

                        if (name == "SetReadWrite")
                        {
                            readWriteMode = sourceIndex;
                        }

                        if (name == "SetTransforms")
                        {
                            transformsMode = sourceIndex;
                        }
                    }
                }
            }
        }

        // Get Float data
        List<float> GetMaskData(TVEGameObjectData gameObjectData, int baseVertex, int endVertex, int source, int option, int coord, Texture2D texture, int action, float defaulValue)
        {
            var meshChannel = new List<float>();

            if (source == 0)
            {
                meshChannel = GetMaskDefaultValue(gameObjectData, defaulValue);
            }

            else if (source == 1)
            {
                meshChannel = GetMaskMeshData(gameObjectData, baseVertex, endVertex, option, defaulValue);
            }

            else if (source == 2)
            {
                meshChannel = GetMaskProceduralData(gameObjectData, baseVertex, endVertex, option, defaulValue);
            }

            else if (source == 3)
            {
                meshChannel = GetMaskFromTextureData(gameObjectData, baseVertex, endVertex, option, coord, texture, defaulValue);
            }

            else if (source == 4)
            {
                meshChannel = GetMask3rdPartyData(gameObjectData, baseVertex, endVertex, option, defaulValue);
            }

            if (action > 0)
            {
                meshChannel = MeshAction(meshChannel, gameObjectData, action);
            }

            return meshChannel;
        }

        List<float> GetMaskDefaultValue(TVEGameObjectData gameObjectData, float defaulValue)
        {
            var mesh = gameObjectData.instanceMesh;
            var vertexCount = mesh.vertexCount;

            var meshChannel = new List<float>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                meshChannel.Add(defaulValue);
            }

            return meshChannel;
        }

        List<float> GetMaskMeshData(TVEGameObjectData gameObjectData, int baseVertex, int endVertex, int option, float defaultValue)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshChannel = GetMaskDefaultValue(gameObjectData, defaultValue);

            // Vertex Color Data
            if (option == 0)
            {
                var channel = GetVertexColorData(gameObjectData);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].r;
                }
            }

            else if (option == 1)
            {
                var channel = GetVertexColorData(gameObjectData);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].g;
                }
            }

            else if (option == 2)
            {
                var channel = GetVertexColorData(gameObjectData);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].b;
                }
            }

            else if (option == 3)
            {
                var channel = GetVertexColorData(gameObjectData);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].a;
                }
            }

            // UV 0 Data
            else if (option == 4)
            {
                var channel = GetCoordData(gameObjectData, 1, 0);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].x;
                }
            }

            else if (option == 5)
            {
                var channel = GetCoordData(gameObjectData, 1, 0);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].y;
                }
            }

            else if (option == 6)
            {
                var channel = GetCoordData(gameObjectData, 1, 0);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].z;
                }
            }

            else if (option == 7)
            {
                var channel = GetCoordData(gameObjectData, 1, 0);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].w;
                }
            }

            // UV 2 Data
            else if (option == 8)
            {
                var channel = GetCoordData(gameObjectData, 1, 1);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].x;
                }
            }

            else if (option == 9)
            {
                var channel = GetCoordData(gameObjectData, 1, 1);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].y;
                }
            }

            else if (option == 10)
            {
                var channel = GetCoordData(gameObjectData, 1, 1);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].z;
                }
            }

            else if (option == 11)
            {
                var channel = GetCoordData(gameObjectData, 1, 1);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].w;
                }
            }

            // UV 3 Data
            else if (option == 12)
            {
                var channel = GetCoordData(gameObjectData, 1, 2);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].x;
                }
            }

            else if (option == 13)
            {
                var channel = GetCoordData(gameObjectData, 1, 2);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].y;
                }
            }

            else if (option == 14)
            {
                var channel = GetCoordData(gameObjectData, 1, 2);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].z;
                }
            }

            else if (option == 15)
            {
                var channel = GetCoordData(gameObjectData, 1, 2);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].w;
                }
            }

            // UV 4 Data
            else if (option == 16)
            {
                var channel = GetCoordData(gameObjectData, 1, 3);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].x;
                }
            }

            else if (option == 17)
            {
                var channel = GetCoordData(gameObjectData, 1, 3);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].y;
                }
            }

            else if (option == 18)
            {
                var channel = GetCoordData(gameObjectData, 1, 3);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].z;
                }
            }

            else if (option == 19)
            {
                var channel = GetCoordData(gameObjectData, 1, 3);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = channel[i].w;
                }
            }

            return meshChannel;
        }

        List<float> GetMaskProceduralData(TVEGameObjectData gameObjectData, int baseVertex, int endVertex, int option, float defaultValue)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;
            var vertices = instanceMesh.vertices;
            var normals = instanceMesh.normals;

            //for (int i = 0; i < vertices.Length; i++)
            //{
            //    vertices[i] = vertices[i] + gameObjectData.gameObject.transform.localPosition;
            //}

            var meshChannel = GetMaskDefaultValue(gameObjectData, defaultValue);

            if (option == 0)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = 0.0f;
                }
            }
            else if (option == 1)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    meshChannel[i] = 1.0f;
                }
            }
            // Accurate Variation
            else if (option == 2)
            {
                meshChannel = new List<float>();

                // Fill the variation
                for (int i = 0; i < vertexCount; i++)
                {
                    meshChannel.Add(1);
                }

                elements = new();
                vertexToElementMap = new();
                int elementCount = 0;

                int[] triangles = instanceMesh.triangles;
                bool[] visitedTriangles = new bool[triangles.Length / 3];

                for (int i = 0; i < visitedTriangles.Length; i++)
                {
                    if (!visitedTriangles[i])
                    {
                        // New element, assign an incremental ID
                        MeshElement newElement = new MeshElement
                        {
                            elementID = elementCount++
                        };

                        // Perform DFS/BFS to find all connected triangles starting from triangle 'i'
                        Queue<int> triangleQueue = new Queue<int>();
                        triangleQueue.Enqueue(i);

                        while (triangleQueue.Count > 0)
                        {
                            int triangleIndex = triangleQueue.Dequeue();

                            if (visitedTriangles[triangleIndex]) continue;

                            visitedTriangles[triangleIndex] = true;
                            newElement.triangles.Add(triangleIndex);

                            // Get the vertices of the current triangle
                            int v1 = triangles[triangleIndex * 3];
                            int v2 = triangles[triangleIndex * 3 + 1];
                            int v3 = triangles[triangleIndex * 3 + 2];

                            // Assign vertices to the element
                            AssignVertexToElement(v1, newElement.elementID);
                            AssignVertexToElement(v2, newElement.elementID);
                            AssignVertexToElement(v3, newElement.elementID);

                            // Check for neighboring triangles that share any vertex with this triangle
                            for (int j = 0; j < visitedTriangles.Length; j++)
                            {
                                if (!visitedTriangles[j])
                                {
                                    int t1 = triangles[j * 3];
                                    int t2 = triangles[j * 3 + 1];
                                    int t3 = triangles[j * 3 + 2];

                                    // If any of the vertices match, it means they are connected
                                    if (VerticesSharePosition(vertices[v1], vertices[t1], vertices[t2], vertices[t3]) ||
                                        VerticesSharePosition(vertices[v2], vertices[t1], vertices[t2], vertices[t3]) ||
                                        VerticesSharePosition(vertices[v3], vertices[t1], vertices[t2], vertices[t3]))
                                    {
                                        triangleQueue.Enqueue(j); // Add this neighboring triangle to the queue
                                    }
                                }
                            }
                        }

                        elements.Add(newElement);
                    }
                }

                foreach (var kvp in vertexToElementMap)
                {
                    int vertexIndex = kvp.Key;
                    int elementID = kvp.Value;

                    // Normalize the elementID to the range [0, 1] based on total elements
                    float variation = (float)elementID / (elements.Count - 1);
                    variation = Mathf.Repeat(variation * seed, 1.0f);
                    meshChannel[vertexIndex] = variation;
                }
            }
            // Random Variation
            else if (option == 3)
            {
                meshChannel = new List<float>();

                var triangles = instanceMesh.triangles;
                var trianglesCount = instanceMesh.triangles.Length;

                var elementIndices = new List<int>(vertexCount);
                int elementCount = 0;

                for (int i = 0; i < vertexCount; i++)
                {
                    elementIndices.Add(-99);
                }

                for (int i = 0; i < trianglesCount; i += 3)
                {
                    var index1 = triangles[i + 0];
                    var index2 = triangles[i + 1];
                    var index3 = triangles[i + 2];

                    int element = 0;

                    if (elementIndices[index1] != -99)
                    {
                        element = elementIndices[index1];
                    }
                    else if (elementIndices[index2] != -99)
                    {
                        element = elementIndices[index2];
                    }
                    else if (elementIndices[index3] != -99)
                    {
                        element = elementIndices[index3];
                    }
                    else
                    {
                        element = elementCount;
                        elementCount++;
                    }

                    elementIndices[index1] = element;
                    elementIndices[index2] = element;
                    elementIndices[index3] = element;
                }

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    var variation = (float)elementIndices[i] / elementCount;
                    variation = Mathf.Repeat(variation * seed, 1.0f);
                    meshChannel.Add(variation);
                }
            }
            // Normalized in bounds height
            else if (option == 4)
            {
                if (currentPrefab.isZUp)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var mask = Mathf.Clamp01(vertices[i].z / maxBoundsInfo.y);

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        meshChannel[i] = mask;
                    }
                }
            }
            // Procedural Sphere
            else if (option == 5)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Distance(vertices[i], Vector3.zero) / maxBoundsInfo.z);

                    meshChannel[i] = mask;
                }
            }
            // Procedural Cylinder no Cap
            else if (option == 6)
            {
                if (currentPrefab.isZUp)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var mask = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, 0, vertices[i].z)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var mask = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));

                        meshChannel[i] = mask;
                    }
                }
            }
            // Procedural Capsule
            else if (option == 7)
            {
                if (currentPrefab.isZUp)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var maskCyl = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, 0, vertices[i].z)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                        var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].z / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                        var maskBase = Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].z / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                        var mask = Mathf.Clamp01(maskCyl + maskCap) * maskBase;

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var maskCyl = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                        var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                        var maskBase = Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                        var mask = Mathf.Clamp01(maskCyl + maskCap) * maskBase;

                        meshChannel[i] = mask;
                    }
                }
            }
            // Base To Top
            else if (option == 8)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = 1.0f - Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                    meshChannel[i] = mask;
                }
            }
            // Bottom Projection
            else if (option == 9)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Dot(new Vector3(0, -1, 0), normals[i]) * 0.5f + 0.5f);

                    meshChannel[i] = mask;
                }
            }
            // Top Projection
            else if (option == 10)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Dot(new Vector3(0, 1, 0), normals[i]) * 0.5f + 0.5f);

                    meshChannel[i] = mask;
                }
            }
            // Normalized in bounds height with black Offset at the bottom
            else if (option == 11)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var mask = Mathf.Clamp01((height - 0.2f) / (1 - 0.2f));

                    meshChannel[i] = mask;
                }
            }
            // Normalized in bounds height with black Offset at the bottom
            else if (option == 12)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var mask = Mathf.Clamp01((height - 0.4f) / (1 - 0.4f));

                    meshChannel[i] = mask;
                }
            }
            // Normalized in bounds height with black Offset at the bottom
            else if (option == 13)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var mask = Mathf.Clamp01((height - 0.6f) / (1 - 0.6f));

                    meshChannel[i] = mask;
                }
            }
            // Height Grass
            else if (option == 14)
            {
                if (currentPrefab.isZUp)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var oneMinusMask = 1 - Mathf.Clamp01(vertices[i].z / maxBoundsInfo.y);
                        var powerMask = oneMinusMask * oneMinusMask * oneMinusMask * oneMinusMask;
                        var mask = 1 - powerMask;

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var oneMinusMask = 1 - Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                        var powerMask = oneMinusMask * oneMinusMask * oneMinusMask * oneMinusMask;
                        var mask = 1 - powerMask;

                        meshChannel[i] = mask;
                    }
                }
            }
            // Sphere Plant
            else if (option == 15)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var sphere = Mathf.Clamp01(Vector3.Distance(vertices[i], Vector3.zero) / maxBoundsInfo.z);
                    var mask = sphere * sphere;

                    meshChannel[i] = mask;
                }
            }
            // Procedural Cylinder no Cap
            else if (option == 16)
            {
                if (currentPrefab.isZUp)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var cylinder = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, 0, vertices[i].z)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                        var mask = cylinder * cylinder;

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var cylinder = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                        var mask = cylinder * cylinder;

                        meshChannel[i] = mask;
                    }
                }
            }
            // Procedural Capsule
            else if (option == 17)
            {
                if (currentPrefab.isZUp)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var maskCyl = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, 0, vertices[i].z)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                        var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].z / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                        var maskBase = Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].z / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                        var maskCalpule = Mathf.Clamp01(maskCyl + maskCap) * maskBase;

                        var maskHeight = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        var mask = Mathf.Lerp(maskCalpule, 1, 1 - (1 - maskHeight * maskHeight));

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var maskCyl = Mathf.Clamp01(BoxoUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                        var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                        var maskBase = Mathf.Clamp01(BoxoUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                        var maskCalpule = Mathf.Clamp01(maskCyl + maskCap) * maskBase;

                        var maskHeight = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        var mask = Mathf.Lerp(maskCalpule, 1, 1 - (1 - maskHeight * maskHeight));

                        meshChannel[i] = mask;
                    }
                }
            }
            // Normalized pos X
            else if (option == 18)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = vertices[i].x / maxBoundsInfo.x;

                    meshChannel[i] = mask;
                }
            }
            // Normalized pos Y
            else if (option == 19)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = vertices[i].y / maxBoundsInfo.y;

                    meshChannel[i] = mask;
                }
            }
            // Normalized pos Z
            else if (option == 20)
            {
                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = vertices[i].z / maxBoundsInfo.x;

                    meshChannel[i] = mask;
                }
            }
            // Diagonal UV0
            else if (option == 21)
            {
                var channel = new List<Vector2>(vertexCount);
                instanceMesh.GetUVs(0, channel);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = Vector3.SqrMagnitude(channel[i]);

                    meshChannel[i] = mask;
                }
            }

            return meshChannel;
        }

        List<MeshElement> elements = new List<MeshElement>();
        Dictionary<int, int> vertexToElementMap = new Dictionary<int, int>(); // Vertex ID to element ID map

        public class MeshElement
        {
            public int elementID;
            public List<int> triangles = new List<int>();
        }

        bool VerticesSharePosition(Vector3 v1, Vector3 t1, Vector3 t2, Vector3 t3)
        {
            return v1 == t1 || v1 == t2 || v1 == t3;
        }

        // Assign vertex to element ID map
        void AssignVertexToElement(int vertexIndex, int elementID)
        {
            if (!vertexToElementMap.ContainsKey(vertexIndex))
            {
                vertexToElementMap.Add(vertexIndex, elementID);
            }
        }

        List<float> GetMask3rdPartyData(TVEGameObjectData gameObjectData, int baseVertex, int endVertex, int option, float defaulValue)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;
            var vertices = instanceMesh.vertices;

            var meshChannel = GetMaskDefaultValue(gameObjectData, defaulValue);

            // CTI Leaves Mask
            if (option == 0)
            {
                var UV3 = instanceMesh.uv3;

                if (UV3 != null && UV3.Length > 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var pivotX = (Mathf.Repeat(UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotZ = (Mathf.Repeat(32768.0f * UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotY = Mathf.Sqrt(1.0f - Mathf.Clamp01(Vector2.Dot(new Vector2(pivotX, pivotZ), new Vector2(pivotX, pivotZ))));

                        var pivot = new Vector3(pivotX * UV3[i].y, pivotY * UV3[i].y, pivotZ * UV3[i].y);
                        var pos = vertices[i];

                        var mask = Vector3.Magnitude(pos - pivot) / (maxBoundsInfo.x * 1f);

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    Debug.Log("<b>[The Visual Engine]</b> " + "The current originalMesh does not use CTI masks! Please use a procedural mask for flutter!");
                }
            }
            // CTI Leaves Variation
            else if (option == 1)
            {
                var UV3 = instanceMesh.uv3;

                if (UV3 != null && UV3.Length > 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var pivotX = (Mathf.Repeat(UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotZ = (Mathf.Repeat(32768.0f * UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotY = Mathf.Sqrt(1.0f - Mathf.Clamp01(Vector2.Dot(new Vector2(pivotX, pivotZ), new Vector2(pivotX, pivotZ))));

                        var pivot = new Vector3(pivotX * UV3[i].y, pivotY * UV3[i].y, pivotZ * UV3[i].y);

                        var variX = Mathf.Repeat(pivot.x * 33.3f, 1.0f);
                        var variY = Mathf.Repeat(pivot.y * 33.3f, 1.0f);
                        var variZ = Mathf.Repeat(pivot.z * 33.3f, 1.0f);

                        var mask = variX + variY + variZ;

                        if (UV3[i].x < 0.01f)
                        {
                            mask = 0.0f;
                        }

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    Debug.Log("<b>[The Visual Engine]</b> " + "The current originalMesh does not use CTI masks! Please use a procedural mask for variation!");
                }
            }
            // ST8 Leaves Mask
            else if (option == 2)
            {
                var UV2 = new List<Vector4>();
                var UV3 = new List<Vector4>();
                var UV4 = new List<Vector4>();

                instanceMesh.GetUVs(1, UV2);
                instanceMesh.GetUVs(2, UV3);
                instanceMesh.GetUVs(3, UV4);

                if (UV4.Count != 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        //var anchor = new Vector3(UV2[i].z - vertices[i].x, UV2[i].w - vertices[i].y, UV3[i].w - vertices[i].z);
                        //var length = Vector3.Magnitude(anchor);
                        //var leaves = UV2[i].w * UV4[i].w;
                        //var mask = (length * leaves) / maxBoundsInfo.x;
                        //meshChannel[i] = mask;

                        // new approach
                        //var anchor = new Vector3(UV2[i].z - vertices[i].x, UV2[i].w - vertices[i].y, UV3[i].w - vertices[i].z);
                        //var length = Vector3.Magnitude(anchor);
                        //var mask = Mathf.Clamp01(length * 2);
                        //meshChannel[i] = mask;

                        // new approach 2
                        var anchor = new Vector3(UV2[i].z - vertices[i].x, UV2[i].w - vertices[i].y, UV3[i].w - vertices[i].z);
                        var length = Vector3.Magnitude(anchor);
                        var leaves = UV2[i].w * UV4[i].w;

                        var mask = Mathf.Clamp01((length * leaves) / maxBoundsInfo.x);

                        meshChannel[i] = mask;
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        meshChannel[i] = mask;
                    }
                }
            }
            // NM Leaves Mask
            else if (option == 3)
            {
                var colors = new List<Color>(vertexCount);
                instanceMesh.GetColors(colors);

                if (colors.Count != 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        if (colors[i].a > 0.99f)
                        {
                            meshChannel[i] = 0.0f;
                        }
                        else
                        {
                            meshChannel[i] = colors[i].a;
                        }
                    }
                }
                else
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        meshChannel[i] = mask;
                    }
                }
            }

            // Nicrom Leaves Mask
            else if (option == 4)
            {
                var UV0 = new List<Vector4>();

                instanceMesh.GetUVs(0, UV0);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = 0;

                    if (UV0[i].x > 1.5)
                    {
                        mask = 1;
                    }

                    meshChannel[i] = mask;
                }
            }

            // Nicrom Detail Mask
            else if (option == 5)
            {
                var UV0 = new List<Vector4>();

                instanceMesh.GetUVs(0, UV0);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    var mask = 0;

                    if (UV0[i].y > 0)
                    {
                        mask = 1;
                    }

                    meshChannel[i] = 1 - mask;
                }
            }
            // SeedMesh Variation
            else if (option == 6)
            {
                var colors = new List<Color>(vertexCount);
                instanceMesh.GetColors(colors);

                if (colors.Count != 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        meshChannel[i] = Mathf.Max(colors[i].g, colors[i].b);

                    }
                }
            }

            // BOTD Branch Variation
            else if (option == 7)
            {
                var UV3 = new List<Vector4>();

                instanceMesh.GetUVs(3, UV3);

                for (int i = baseVertex; i < endVertex; i++)
                {
                    var pivot = UnpackPivot0(UV3[i]);

                    var variX = Mathf.Repeat(pivot.x * 33.3f, 1.0f);
                    var variY = Mathf.Repeat(pivot.y * 33.3f, 1.0f);
                    var variZ = Mathf.Repeat(pivot.z * 33.3f, 1.0f);

                    var mask = pivot.x;

                    meshChannel[i] = mask;
                }
            }

            return meshChannel;
        }

        Vector3 UnpackPivot0(Vector3 packedData)
        {
            Vector3 pivotPos0;

            //if (packedData.y & 0xFFFF0000)
            {
                pivotPos0.x = UnpackFixedToSFloat((uint)packedData.x, 8f, 10, 22);
                pivotPos0.y = UnpackFixedToUFloat((uint)packedData.x, 32f, 12, 10);
                pivotPos0.z = UnpackFixedToSFloat((uint)packedData.x, 8f, 10, 0);
            }

            return pivotPos0;
        }

        Vector3 UnpackPivot1(Vector3 packedData)
        {
            Vector3 pivotPos1;

            //if (packedData.y & 0x0000FFFF)
            {
                pivotPos1.x = UnpackFixedToSFloat((uint)(packedData.z), 8f, 10, 22);
                pivotPos1.y = UnpackFixedToUFloat((uint)(packedData.z), 32f, 12, 10);
                pivotPos1.z = UnpackFixedToSFloat((uint)(packedData.z), 8f, 10, 0);

            }
            return pivotPos1;
        }

        float UnpackFixedToSFloat(uint val, float range, uint bits, uint shift)
        {
            uint BitMask = (1u << (int)bits) - 1u;
            val = (val >> (int)shift) & BitMask;
            float fval = val / (float)BitMask;
            return (fval * 2f - 1f) * range;
        }

        float UnpackFixedToUFloat(uint val, float range, uint bits, uint shift)
        {
            uint BitMask = (1u << (int)bits) - 1u;
            val = (val >> (int)shift) & BitMask;
            float fval = val / (float)BitMask;
            return fval * range;
        }

        List<float> GetMaskFromTextureData(TVEGameObjectData gameObjectData, int baseVertex, int endVertex, int option, int coord, Texture2D texture, float defaultValue)
        {
            var meshChannel = GetMaskDefaultValue(gameObjectData, defaultValue);

            if (texture != null)
            {
                string texPath = AssetDatabase.GetAssetPath(texture);
                TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                texImporter.isReadable = true;
                texImporter.SaveAndReimport();
                AssetDatabase.Refresh();

                var meshCoord = GetCoordMeshData(gameObjectData, coord);

                if (option == 0)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                        meshChannel[i] = pixel.r;
                    }
                }
                else if (option == 1)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                        meshChannel[i] = pixel.g;
                    }
                }
                else if (option == 2)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                        meshChannel[i] = pixel.b;
                    }
                }
                else if (option == 3)
                {
                    for (int i = baseVertex; i < endVertex; i++)
                    {
                        var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                        meshChannel[i] = pixel.a;
                    }
                }

                texImporter.isReadable = false;
                texImporter.SaveAndReimport();
                AssetDatabase.Refresh();
            }

            return meshChannel;
        }

        List<Vector4> GetCoordData(TVEGameObjectData gameObjectData, int source, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            if (source == 0)
            {
                instanceMesh.GetUVs(0, meshCoord);
            }
            else if (source == 1)
            {
                meshCoord = GetCoordMeshData(gameObjectData, option);
            }
            else if (source == 2)
            {
                meshCoord = GetCoordProceduralData(gameObjectData, option);
            }
            else if (source == 3)
            {
                meshCoord = GetCoord3rdPartyData(gameObjectData, option);
            }

            if (meshCoord.Count == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(Vector4.zero);
                }

                //if (vertexCount != 0)
                //{
                //    Unwrapping.GenerateSecondaryUVSet(originalMesh);
                //    originalMesh.GetUVs(1, meshCoord);
                //}
            }

            return meshCoord;
        }

        List<Vector4> GetCoordDefaultData(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                meshCoord.Add(Vector4.zero);
            }

            return meshCoord;
        }

        List<Vector4> GetCoordMeshData(TVEGameObjectData gameObjectData, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            if (option == 0)
            {
                instanceMesh.GetUVs(0, meshCoord);
            }

            else if (option == 1)
            {
                instanceMesh.GetUVs(1, meshCoord);
            }

            else if (option == 2)
            {
                instanceMesh.GetUVs(2, meshCoord);
            }

            else if (option == 3)
            {
                instanceMesh.GetUVs(3, meshCoord);
            }

            return meshCoord;
        }

        List<Vector4> GetCoordProceduralData(TVEGameObjectData gameObjectData, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;
            var vertices = instanceMesh.vertices;

            var meshCoord = new List<Vector4>(vertexCount);

            // Automatic (Get LightmapUV)
            if (option == 0)
            {
                instanceMesh.GetUVs(1, meshCoord);

                if (meshCoord.Count == 0)
                {
                    if (vertexCount != 0)
                    {
                        Unwrapping.GenerateSecondaryUVSet(instanceMesh);
                        instanceMesh.GetUVs(1, meshCoord);
                    }
                }
            }
            // Planar XZ
            else if (option == 1)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(vertices[i].x, vertices[i].z, 0, 0));
                }
            }
            // Planar XY
            else if (option == 2)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(vertices[i].x, vertices[i].y, 0, 0));
                }
            }
            // Planar ZY
            else if (option == 3)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(vertices[i].z, vertices[i].y, 0, 0));
                }
            }

            return meshCoord;
        }

        List<Vector4> GetCoord3rdPartyData(TVEGameObjectData gameObjectData, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            // NM Trunk Blend
            if (option == 0)
            {
                instanceMesh.GetUVs(3, meshCoord);

                if (meshCoord.Count == 0)
                {
                    instanceMesh.GetUVs(2, meshCoord);
                }

                if (meshCoord.Count == 0)
                {
                    instanceMesh.GetUVs(1, meshCoord);
                }

                if (meshCoord.Count == 0)
                {
                    instanceMesh.GetUVs(0, meshCoord);
                }
            }

            return meshCoord;
        }

        List<Vector4> GetPivotsData(TVEGameObjectData gameObjectData, int source, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshPivots = new List<Vector4>(vertexCount);

            if (source == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshPivots.Add(Vector4.zero);
                }
            }
            else if (source == 1)
            {
                meshPivots = GetPivotsMeshData(gameObjectData, option);
            }
            else if (source == 2)
            {
                meshPivots = GetPivotsProceduralData(gameObjectData, option);
            }

            if (meshPivots.Count == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshPivots.Add(Vector4.zero);
                }
            }

            return meshPivots;
        }

        List<Vector4> GetPivotsMeshData(TVEGameObjectData gameObjectData, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            if (option == 0)
            {
                instanceMesh.GetUVs(0, meshCoord);
            }

            else if (option == 1)
            {
                instanceMesh.GetUVs(1, meshCoord);
            }

            else if (option == 2)
            {
                instanceMesh.GetUVs(2, meshCoord);
            }

            else if (option == 3)
            {
                instanceMesh.GetUVs(3, meshCoord);
            }

            return meshCoord;
        }

        List<Vector4> GetPivotsProceduralData(TVEGameObjectData gameObjectData, int option)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshPivots = new List<Vector4>(vertexCount);

            // Procedural Pivots XZ
            if (option == 0)
            {
                meshPivots = GenerateElementPivots(gameObjectData);
            }

            return meshPivots;
        }

        List<Color> GetVertexColorData(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var channel = new List<Color>(vertexCount);
            instanceMesh.GetColors(channel);

            if (channel.Count == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    channel.Add(Color.white);
                }
            }

            return channel;
        }

        List<Vector4> GetLightmapData(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;

            var meshLightmap = new List<Vector4>(vertexCount);

            instanceMesh.GetUVs(1, meshLightmap);

            // Generate Lightmap UVs
            if (meshLightmap.Count == 0)
            {
                Unwrapping.GenerateSecondaryUVSet(instanceMesh);
            }

            // If Lightmap fails try get UV0
            if (meshLightmap.Count == 0)
            {
                meshLightmap = GetCoordData(gameObjectData, 0, 0);
            }

            return meshLightmap;
        }

        List<float> GeneratePredictiveVariation(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;
            var meshChannel = new List<float>(vertexCount);

            var triangles = instanceMesh.triangles;
            var trianglesCount = instanceMesh.triangles.Length;

            var elementIndices = new List<int>(vertexCount);
            int elementCount = 0;

            for (int i = 0; i < vertexCount; i++)
            {
                elementIndices.Add(-99);
            }

            for (int i = 0; i < trianglesCount; i += 3)
            {
                var index1 = triangles[i + 0];
                var index2 = triangles[i + 1];
                var index3 = triangles[i + 2];

                int element = 0;

                if (elementIndices[index1] != -99)
                {
                    element = elementIndices[index1];
                }
                else if (elementIndices[index2] != -99)
                {
                    element = elementIndices[index2];
                }
                else if (elementIndices[index3] != -99)
                {
                    element = elementIndices[index3];
                }
                else
                {
                    element = elementCount;
                    elementCount++;
                }

                elementIndices[index1] = element;
                elementIndices[index2] = element;
                elementIndices[index3] = element;
            }

            for (int i = 0; i < elementIndices.Count; i++)
            {
                var variation = (float)elementIndices[i] / elementCount;
                variation = Mathf.Repeat(variation * seed, 1.0f);
                meshChannel.Add(variation);
            }

            return meshChannel;
        }

        List<Vector4> GenerateElementPivots(TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertexCount = instanceMesh.vertexCount;
            var vertices = instanceMesh.vertices;
            var triangles = instanceMesh.triangles;
            var trianglesCount = instanceMesh.triangles.Length;

            var elementIndices = new List<int>(vertexCount);
            var meshPivots = new List<Vector4>(vertexCount);
            int elementCount = 0;

            for (int i = 0; i < vertexCount; i++)
            {
                elementIndices.Add(-99);
            }

            for (int i = 0; i < vertexCount; i++)
            {
                meshPivots.Add(Vector4.zero);
            }

            for (int i = 0; i < trianglesCount; i += 3)
            {
                var index1 = triangles[i + 0];
                var index2 = triangles[i + 1];
                var index3 = triangles[i + 2];

                int element = 0;

                if (elementIndices[index1] != -99)
                {
                    element = elementIndices[index1];
                }
                else if (elementIndices[index2] != -99)
                {
                    element = elementIndices[index2];
                }
                else if (elementIndices[index3] != -99)
                {
                    element = elementIndices[index3];
                }
                else
                {
                    element = elementCount;
                    elementCount++;
                }

                elementIndices[index1] = element;
                elementIndices[index2] = element;
                elementIndices[index3] = element;
            }

            for (int e = 0; e < elementCount; e++)
            {
                var positions = new List<Vector3>();

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    if (elementIndices[i] == e)
                    {
                        positions.Add(vertices[i]);
                    }
                }

                float x = 0;
                float y = 0;
                float z = 0;

                for (int p = 0; p < positions.Count; p++)
                {
                    x = x + positions[p].x;
                    y = y + positions[p].y;
                    z = z + positions[p].z;
                }

                if (currentPrefab.isZUp)
                {
                    for (int i = 0; i < elementIndices.Count; i++)
                    {
                        if (elementIndices[i] == e)
                        {
                            meshPivots[i] = new Vector4(x / positions.Count, y / positions.Count, 0, 0);
                        }
                    }
                }
                else
                {
                    for (int i = 0; i < elementIndices.Count; i++)
                    {
                        if (elementIndices[i] == e)
                        {
                            meshPivots[i] = new Vector4(x / positions.Count, z / positions.Count, 0, 0);
                        }
                    }
                }
            }

            return meshPivots;
        }

        /// <summary>
        /// Mesh Actions
        /// </summary>

        List<float> MeshAction(List<float> source, TVEGameObjectData gameObjectData, int action)
        {
            if (action == 1)
            {
                source = MeshActionInvert(source);
            }
            else if (action == 2)
            {
                source = MeshActionNegate(source);
            }
            else if (action == 3)
            {
                source = MeshActionRemap01(source);
            }
            else if (action == 4)
            {
                source = MeshActionPower2(source);
            }
            else if (action == 5)
            {
                source = MeshActionMultiplyByHeight(source, gameObjectData);
            }
            else if (action == 6)
            {
                source = MeshActionClampNegativeValues(source, gameObjectData);
            }
            else if (action == 7)
            {
                source = MeshActionFactionalValues(source, gameObjectData);
            }
            else if (action == 8)
            {
                source = MeshActionUseBranchID(source, gameObjectData);
            }

            return source;
        }

        List<float> MeshActionInvert(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = 1.0f - source[i];
            }

            return source;
        }

        List<float> MeshActionNegate(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = source[i] * -1.0f;
            }

            return source;
        }

        List<float> MeshActionRemap01(List<float> source)
        {
            float min = source[0];
            float max = source[0];

            for (int i = 0; i < source.Count; i++)
            {
                if (source[i] < min)
                    min = source[i];

                if (source[i] > max)
                    max = source[i];
            }

            // Avoid divide by 0
            if (min != max)
            {
                for (int i = 0; i < source.Count; i++)
                {
                    source[i] = (source[i] - min) / (max - min);
                }
            }
            else
            {
                for (int i = 0; i < source.Count; i++)
                {
                    source[i] = 0.0f;
                }
            }

            return source;
        }

        List<float> MeshActionPower2(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = Mathf.Pow(source[i], 2.0f);
            }

            return source;
        }

        List<float> MeshActionMultiplyByHeight(List<float> source, TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertices = instanceMesh.vertices;

            for (int i = 0; i < source.Count; i++)
            {
                var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                source[i] = source[i] * mask;
            }

            return source;
        }

        List<float> MeshActionClampNegativeValues(List<float> source, TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertices = instanceMesh.vertices;

            for (int i = 0; i < source.Count; i++)
            {
                var mask = 1.0f;

                if (vertices[i].y < 0)
                {
                    mask = 0.0f;
                }

                source[i] = source[i] * mask;
            }

            return source;
        }

        List<float> MeshActionFactionalValues(List<float> source, TVEGameObjectData gameObjectData)
        {
            var instanceMesh = gameObjectData.instanceMesh;
            var vertices = instanceMesh.vertices;

            for (int i = 0; i < source.Count; i++)
            {
                source[i] = Mathf.Repeat(source[i], 1.0f);
            }

            return source;
        }

        List<float> MeshActionUseBranchID(List<float> source, TVEGameObjectData gameObjectData)
        {
            var variation = GeneratePredictiveVariation(gameObjectData);

            for (int i = 0; i < source.Count; i++)
            {
                source[i] = source[i] * 99 + variation[i] + 1;
            }

            return source;
        }

        /// <summary>
        /// Convert Macros
        /// </summary>

        void ConvertMaterials()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var originalMaterials = gameObjectDataSet[i].originalMaterials;
                var instanceMaterials = gameObjectDataSet[i].instanceMaterials;

                if (originalMaterials != null)
                {
                    for (int j = 0; j < originalMaterials.Length; j++)
                    {
                        var originalMaterial = originalMaterials[j];
                        var instanceMaterial = instanceMaterials[j];

                        if (IsValidMaterial(instanceMaterial))
                        {
                            ConvertMaterial(originalMaterial, instanceMaterial, i);

                            var dataPath = GetConvertedAssetPath(originalMaterial, instanceMaterial.name, "mat", "Material");

                            instanceMaterials[j] = SaveMaterial(instanceMaterial, dataPath);
                        }
                    }
                }
            }

            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshRenderer = gameObjectDataSet[i].meshRenderer;
                var materialArrayInstances = gameObjectDataSet[i].instanceMaterials;

                if (meshRenderer != null)
                {
                    meshRenderer.sharedMaterials = materialArrayInstances;
                }
            }
        }

        void ConvertMaterial(Material originalMaterial, Material instanceMaterial, int index)
        {
            GetMaterialConversionFromPreset(originalMaterial, instanceMaterial, index);

            if (currentPrefab.isZUp)
            {
                instanceMaterial.SetFloat("_ObjectCoordMode", 1);
            }

            TVEUtils.SetMaterialSettings(instanceMaterial);
        }

        void GetDefaultShadersFromPreset()
        {
            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("Shader"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));

                    var type = "";

                    if (splitLine.Length > 1)
                    {
                        type = splitLine[1];
                    }

                    if (type == "SHADER_STANDARD")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_STANDARD ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderProp = Shader.Find(shader);
                            shaderBark = Shader.Find(shader);
                            shaderCover = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_SUBSURFACE")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_SUBSURFACE ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderLeaf = Shader.Find(shader);
                            shaderPlant = Shader.Find(shader);
                            shaderGrass = Shader.Find(shader);
                            shaderCross = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_PROP")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_PROP ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderProp = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_BARK")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_BARK ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderBark = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_LEAF")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_LEAF ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderLeaf = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_COVER")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_COVER ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderCover = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_PLANT")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_PLANT ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderPlant = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_GRASS")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_GRASS ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderGrass = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_CROSS")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_CROSS ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderCross = Shader.Find(shader);
                        }
                    }
                }
            }
        }

        void GetMaterialConversionFromPreset(Material originalMaterial, Material instanceMaterial, int index)
        {
            if (presetIndex == 0)
            {
                return;
            }

            bool doPostProcessing = false;

            if (!EditorUtility.IsPersistent(instanceMaterial))
            {
                doPostProcessing = true;
            }

            var material = originalMaterial;

            var texPropName = "_MainShaderTex";
            var texSaveName = "";
            int maskIndex = 0;
            int packChannel = 0;
            int coordChannel = 0;
            ////int layerChannel = 0;

            TVEPackerData packerData = TVEUtils.InitPackerData();

            var usePresetLines = new List<bool>();
            usePresetLines.Add(true);

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(usePresetLines, presetLines[i], material);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Utility"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";
                        var file = "";

                        if (splitLine.Length > 1)
                        {
                            type = splitLine[1];
                        }

                        if (splitLine.Length > 2)
                        {
                            file = splitLine[2];
                        }

                        // Create a copy of the material instance at this point
                        if (type == "USE_CONVERTED_MATERIAL_AS_BASE")
                        {
                            material = new Material(instanceMaterial);
                        }

                        // Use the currently converted material
                        if (type == "USE_CURRENT_MATERIAL_AS_BASE")
                        {
                            material = instanceMaterial;
                        }

                        // Reset material to original
                        if (type == "USE_ORIGINAL_MATERIAL_AS_BASE")
                        {
                            material = originalMaterial;
                        }

                        // Allow material conversion even if Keep Converted is on
                        if (type == "USE_MATERIAL_POST_PROCESSING")
                        {
                            doPostProcessing = true;
                        }

                        if (type == "DEBUG_LOG")
                        {
                            var message = presetLines[i].Replace("Utility DEBUG_LOG ", "");
                            Debug.Log(message);
                        }

                        //if (type == "DELETE_FILES_BY_NAME")
                        //{
                        //    string dataPath;

                        //    dataPath = prefabDataFolder;

                        //    if (Directory.Exists(dataPath) && file != "")
                        //    {
                        //        var allFolderFiles = Directory.GetFiles(dataPath);

                        //        for (int f = 0; f < allFolderFiles.Length; f++)
                        //        {
                        //            if (allFolderFiles[f].Contains(file))
                        //            {
                        //                FileUtil.DeleteFileOrDirectory(allFolderFiles[f]);
                        //            }
                        //        }

                        //        AssetDatabase.Refresh();
                        //    }
                        //}
                    }

                    if (presetLines[i].StartsWith("Material") && doPostProcessing)
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";
                        var src = "";
                        var dst = "";
                        var val = "";
                        var set = "";

                        var x = "0";
                        var y = "0";
                        var z = "0";
                        var w = "0";

                        if (splitLine.Length > 1)
                        {
                            type = splitLine[1];
                        }

                        if (splitLine.Length > 2)
                        {
                            src = splitLine[2];
                            set = splitLine[2];
                        }

                        if (splitLine.Length > 3)
                        {
                            dst = splitLine[3];
                            val = splitLine[3];
                            x = splitLine[3];
                        }

                        if (splitLine.Length > 4)
                        {
                            y = splitLine[4];
                        }

                        if (splitLine.Length > 5)
                        {
                            z = splitLine[5];
                        }

                        if (splitLine.Length > 6)
                        {
                            w = splitLine[6];
                        }

                        if (type == "SET_SHADER")
                        {
                            instanceMaterial.shader = GetShaderFromPreset(set);
                        }
                        else if (type == "SET_SHADER_BY_NAME")
                        {
                            var shader = presetLines[i].Replace("Material SET_SHADER_BY_NAME ", "");

                            if (Shader.Find(shader) != null)
                            {
                                instanceMaterial.shader = Shader.Find(shader);
                            }
                        }
                        else if (type == "SET_SHADER_BY_LIGHTING")
                        {
                            var lighting = presetLines[i].Replace("Material SET_SHADER_BY_LIGHTING ", "");

                            var newShaderName = material.shader.name;
                            newShaderName = newShaderName.Replace("Vertex", "XXX");
                            newShaderName = newShaderName.Replace("Simple", "XXX");
                            newShaderName = newShaderName.Replace("Standard", "XXX");
                            newShaderName = newShaderName.Replace("Subsurface", "XXX");
                            newShaderName = newShaderName.Replace("XXX", lighting);

                            if (Shader.Find(newShaderName) != null)
                            {
                                material.shader = Shader.Find(newShaderName);
                            }
                        }
                        else if (type == "SET_SHADER_BY_REPLACE")
                        {
                            var shader = material.shader.name.Replace(src, dst);

                            if (Shader.Find(shader) != null)
                            {
                                material.shader = Shader.Find(shader);
                            }
                        }
                        else if (type == "SET_FLOAT")
                        {
                            instanceMaterial.SetFloat(set, float.Parse(x, CultureInfo.InvariantCulture));
                        }
                        else if (type == "SET_COLOR")
                        {
                            instanceMaterial.SetColor(set, new Color(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "SET_VECTOR")
                        {
                            instanceMaterial.SetVector(set, new Vector4(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "SET_REMAP")
                        {
                            var vecX = float.Parse(x, CultureInfo.InvariantCulture);
                            var vecY = float.Parse(y, CultureInfo.InvariantCulture);
                            var vecW = float.Parse(w, CultureInfo.InvariantCulture);

                            var vecZ = 1 / (vecY - vecX);

                            instanceMaterial.SetVector(set, new Vector4(vecX, vecY, vecZ, vecW));
                        }
                        else if (type == "SET_TEX")
                        {
                            var texLoad = presetLines[i].Replace("Material SET_TEX ", "");

                            // Support old format
                            texLoad = texLoad.Replace("__", " ");

                            var texAsset = Resources.Load<Texture>(texLoad);

                            instanceMaterial.SetTexture(set, texAsset);
                        }
                        else if (type == "SET_TEX_BY_GUID")
                        {
                            var texGUID = presetLines[i].Replace("Material SET_TEX_BY_GUID ", "");

                            var texAsset = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(texGUID));

                            instanceMaterial.SetTexture(set, texAsset);
                        }
                        else if (type == "SET_TEX_BY_PATH")
                        {
                            var texPath = presetLines[i].Replace("Material SET_TEX_BY_PATH ", "");

                            var texAsset = AssetDatabase.LoadAssetAtPath<Texture>(texPath);

                            instanceMaterial.SetTexture(set, texAsset);
                        }
                        else if (type == "COPY_PROPS")
                        {
                            TVEUtils.CopyMaterialProperties(material, instanceMaterial);
                        }
                        else if (type == "COPY_FLOAT")
                        {
                            if (material.HasFloat(src))
                            {
                                var value = material.GetFloat(src);
                                value = SetFloatActions(presetLines[i], value);

                                instanceMaterial.SetFloat(dst, value);
                            }
                        }
                        else if (type == "COPY_TEX")
                        {
                            if (material.HasTexture(src) && material.GetTexture(src) != null)
                            {
                                GetOrCopyTexture(material, instanceMaterial, src, dst);
                            }
                        }
                        else if (type == "COPY_TEX_FIRST_VALID")
                        {
                            var shader = material.shader;

                            for (int s = 0; s < BoxoUtils.GetShaderPropertyCount(material.shader); s++)
                            {
                                var propName = BoxoUtils.GetShaderPropertyName(shader, s);
                                var propType = BoxoUtils.GetShaderPropertyType(shader, s);

                                if (propType == UnityEngine.Rendering.ShaderPropertyType.Texture)
                                {
                                    if (material.GetTexture(propName) != null)
                                    {
                                        GetOrCopyTexture(material, instanceMaterial, propName, set);
                                        break;
                                    }
                                }
                            }
                        }
                        else if (type == "COPY_TEX_BY_NAME")
                        {
                            var shader = material.shader;

                            for (int s = 0; s < BoxoUtils.GetShaderPropertyCount(material.shader); s++)
                            {
                                var propName = BoxoUtils.GetShaderPropertyName(shader, s);
                                var propType = BoxoUtils.GetShaderPropertyType(shader, s);

                                if (propType == UnityEngine.Rendering.ShaderPropertyType.Texture)
                                {
                                    var propNameCheck = propName.ToUpperInvariant();

                                    if (propNameCheck.Contains(src.ToUpperInvariant()) && material.GetTexture(propName) != null)
                                    {
                                        GetOrCopyTexture(material, instanceMaterial, propName, dst);
                                    }
                                }
                            }
                        }
                        else if (type == "COPY_COLOR")
                        {
                            if (material.HasColor(src))
                            {
                                var value = material.GetColor(src);
                                value.r = SetFloatActions(presetLines[i], value.r);
                                value.g = SetFloatActions(presetLines[i], value.g);
                                value.b = SetFloatActions(presetLines[i], value.b);

                                instanceMaterial.SetColor(dst, value);
                            }
                        }
                        else if (type == "COPY_COLOR_GAMMA")
                        {
                            if (material.HasColor(src))
                            {
                                var value = material.GetColor(src).gamma;
                                value.r = SetFloatActions(presetLines[i], value.r);
                                value.g = SetFloatActions(presetLines[i], value.g);
                                value.b = SetFloatActions(presetLines[i], value.b);

                                instanceMaterial.SetColor(dst, value);
                            }
                        }
                        else if (type == "COPY_COLOR_LINEAR")
                        {
                            if (material.HasColor(src))
                            {
                                var value = material.GetColor(src).linear;
                                value.r = SetFloatActions(presetLines[i], value.r);
                                value.g = SetFloatActions(presetLines[i], value.g);
                                value.b = SetFloatActions(presetLines[i], value.b);

                                instanceMaterial.SetColor(dst, value);
                            }
                        }
                        else if (type == "COPY_VECTOR")
                        {
                            if (material.HasVector(src))
                            {
                                var value = material.GetVector(src);
                                value.x = SetFloatActions(presetLines[i], value.x);
                                value.y = SetFloatActions(presetLines[i], value.y);
                                value.z = SetFloatActions(presetLines[i], value.z);

                                instanceMaterial.SetVector(dst, value);
                            }
                        }
                        else if (type == "COPY_ST_AS_VECTOR")
                        {
                            if (material.HasProperty(src))
                            {
                                Vector4 uvs = new Vector4(material.GetTextureScale(src).x, material.GetTextureScale(src).y,
                                                          material.GetTextureOffset(src).x, material.GetTextureOffset(src).y);

                                instanceMaterial.SetVector(dst, uvs);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_X")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var value = material.GetFloat(src);
                                value = SetFloatActions(presetLines[i], value);

                                var vector = instanceMaterial.GetVector(dst);
                                vector.x = value;

                                instanceMaterial.SetVector(dst, vector);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_Y")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var value = material.GetFloat(src);
                                value = SetFloatActions(presetLines[i], value);

                                var vector = instanceMaterial.GetVector(dst);
                                vector.y = value;

                                instanceMaterial.SetVector(dst, vector);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_Z")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var value = material.GetFloat(src);
                                value = SetFloatActions(presetLines[i], value);

                                var vector = instanceMaterial.GetVector(dst);
                                vector.z = value;

                                instanceMaterial.SetVector(dst, vector);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_W")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var value = material.GetFloat(src);
                                value = SetFloatActions(presetLines[i], value);

                                var vector = instanceMaterial.GetVector(dst);
                                vector.w = value;

                                instanceMaterial.SetVector(dst, vector);
                            }
                        }
                        else if (type == "COPY_VECTOR_X_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                var value = material.GetVector(src);
                                value.x = SetFloatActions(presetLines[i], value.x);

                                instanceMaterial.SetFloat(dst, value.x);
                            }
                        }
                        else if (type == "COPY_VECTOR_Y_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                var value = material.GetVector(src);
                                value.y = SetFloatActions(presetLines[i], value.y);

                                instanceMaterial.SetFloat(dst, value.y);
                            }
                        }
                        else if (type == "COPY_VECTOR_Z_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                var value = material.GetVector(src);
                                value.z = SetFloatActions(presetLines[i], value.z);

                                instanceMaterial.SetFloat(dst, value.z);
                            }
                        }
                        else if (type == "COPY_VECTOR_W_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                var value = material.GetVector(src);
                                value.w = SetFloatActions(presetLines[i], value.w);

                                instanceMaterial.SetFloat(dst, value.w);
                            }
                        }
                        else if (type == "ENABLE_KEYWORD")
                        {
                            instanceMaterial.EnableKeyword(set);
                        }
                        else if (type == "DISABLE_KEYWORD")
                        {
                            instanceMaterial.DisableKeyword(set);
                        }
                        else if (type == "ENABLE_INSTANCING")
                        {
                            instanceMaterial.enableInstancing = true;
                        }
                        else if (type == "DISABLE_INSTANCING")
                        {
                            instanceMaterial.enableInstancing = false;
                        }
#if UNITY_2022_1_OR_NEWER
                        else if (type == "LOCK_PROP")
                        {
                            instanceMaterial.SetPropertyLock(set, true);
                        }
                        else if (type == "UNLOCK_PROP")
                        {
                            instanceMaterial.SetPropertyLock(set, false);
                        }
#endif
                    }

                    if (presetLines[i].StartsWith("Texture") && doPostProcessing)
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));
                        string type = "";
                        string value = "";
                        string pack = "";
                        string tex = "";

                        if (splitLine.Length > 2)
                        {
                            type = splitLine[1];
                            value = splitLine[2];

                            if (type == "PropName")
                            {
                                if (value != "")
                                {
                                    texPropName = value;
                                }
                            }

                            if (type == "SaveName")
                            {
                                if (value != "")
                                {
                                    texSaveName = value;
                                }
                            }

                            if (type == "ImportType")
                            {
                                if (value == "DEFAULT")
                                {
                                    packerData.saveAsDefault = true;
                                }
                                else if (value == "NORMALMAP")
                                {
                                    packerData.saveAsDefault = false;
                                }
                            }

                            if (type == "ImportSpace")
                            {
                                if (value == "SRGB")
                                {
                                    packerData.saveAsSRGB = true;
                                }
                                else if (value == "LINEAR")
                                {
                                    packerData.saveAsSRGB = false;
                                }
                            }

                            if (type == "TransformSpace")
                            {
                                if (value == "NONE")
                                {
                                    packerData.transformSpace = 0;
                                }
                                else if (value == "GAMMA_TO_LINEAR")
                                {
                                    packerData.transformSpace = 1;
                                }
                                else if (value == "LINEAR_TO_GAMMA")
                                {
                                    packerData.transformSpace = 2;
                                }
                                else if (value == "OBJECT_TO_TANGENT")
                                {
                                    packerData.transformSpace = 3;
                                    packerData.blitMesh = gameObjectDataSet[index].instanceMesh;
                                }
                                else if (value == "TANGENT_TO_OBJECT")
                                {
                                    packerData.transformSpace = 4;
                                    packerData.blitMesh = gameObjectDataSet[index].instanceMesh;
                                }
                            }
                        }

                        if (splitLine.Length > 3)
                        {
                            tex = splitLine[3];
                        }

                        var propIsValidTexture = false;

                        if (material.HasProperty(tex))
                        {
                            var propIndex = material.shader.FindPropertyIndex(tex);

                            if (material.shader.GetPropertyType(propIndex) == UnityEngine.Rendering.ShaderPropertyType.Texture)
                            {
                                if (material.GetTexture(tex) != null)
                                {
                                    propIsValidTexture = true;
                                }
                            }
                        }

                        if (propIsValidTexture)
                        {
                            if (splitLine.Length > 1)
                            {
                                type = splitLine[1];

                                if (type == "SetRed")
                                {
                                    maskIndex = 0;
                                }
                                else if (type == "SetGreen")
                                {
                                    maskIndex = 1;
                                }

                                else if (type == "SetBlue")
                                {
                                    maskIndex = 2;
                                }
                                else if (type == "SetAlpha")
                                {
                                    maskIndex = 3;
                                }
                            }

                            if (splitLine.Length > 2)
                            {
                                pack = splitLine[2];

                                if (pack == "NONE")
                                {
                                    packChannel = 0;
                                }
                                else if (pack == "GET_RED")
                                {
                                    packChannel = 1;
                                }
                                else if (pack == "GET_GREEN")
                                {
                                    packChannel = 2;
                                }
                                else if (pack == "GET_BLUE")
                                {
                                    packChannel = 3;
                                }
                                else if (pack == "GET_ALPHA")
                                {
                                    packChannel = 4;
                                }
                                else if (pack == "GET_MAX")
                                {
                                    packChannel = 111;
                                }
                                else if (pack == "GET_MAX_ALL")
                                {
                                    packChannel = 222;
                                }
                                else if (pack == "GET_GRAY")
                                {
                                    packChannel = 555;
                                }
                                else if (pack == "GET_GREY")
                                {
                                    packChannel = 555;
                                }
                                else
                                {
                                    packChannel = int.Parse(pack);
                                }
                            }

                            if (splitLine.Length > 4)
                            {
                                if (splitLine[4] == "GET_COORD")
                                {
                                    coordChannel = int.Parse(splitLine[5]);
                                    packerData.blitMesh = gameObjectDataSet[index].originalMesh;
                                }
                            }

                            packerData.maskTextures[maskIndex] = material.GetTexture(tex);
                            packerData.maskChannels[maskIndex] = packChannel;
                            packerData.maskCoords[maskIndex] = coordChannel;

                            SetPackerActions(presetLines[i], packerData, maskIndex);
                        }
                    }

                    if (presetLines[i].StartsWith("Utility"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";

                        if (splitLine.Length > 1)
                        {
                            type = splitLine[1];
                        }

                        if (type == "START_TEXTURE_PACKING" || type == "FORCE_TEXTURE_PACKING")
                        {
                            var validTexturesFound = false;
                            var additionalTexturesFound = false;
                            var additionalChannelsFound = false;
                            var additionalCoordsFound = false;
                            var additionalActions0Found = false;
                            var additionalActions1Found = false;

                            var validTextureName = "";
                            var validTextureCoord = -1;
                            var validTextureChannel = -1;
                            var validTextureActions0 = -1;
                            var validTextureActions1 = -1;

                            for (int t = 0; t < packerData.maskTextures.Length; t++)
                            {
                                if (packerData.maskTextures[t] != null)
                                {
                                    validTexturesFound = true;

                                    validTextureName = packerData.maskTextures[t].name;
                                    validTextureCoord = packerData.maskCoords[t];
                                    validTextureChannel = packerData.maskChannels[t];
                                    validTextureActions0 = packerData.maskActions0[t];
                                    validTextureActions1 = packerData.maskActions1[t];

                                    break;
                                }
                            }

                            if (validTexturesFound)
                            {
                                for (int t = 0; t < packerData.maskTextures.Length; t++)
                                {
                                    if (packerData.maskTextures[t] != null)
                                    {
                                        if (packerData.maskTextures[t].name != validTextureName)
                                        {
                                            additionalTexturesFound = true;
                                        }

                                        if (packerData.maskCoords[t] != validTextureCoord)
                                        {
                                            additionalCoordsFound = true;
                                        }

                                        if (packerData.maskChannels[t] != t + 1)
                                        {
                                            additionalCoordsFound = true;
                                        }

                                        if (packerData.maskActions0[t] != validTextureActions0)
                                        {
                                            additionalActions0Found = true;
                                        }

                                        if (packerData.maskActions1[t] != validTextureActions0)
                                        {
                                            additionalActions1Found = true;
                                        }
                                    }
                                }
                            }

                            bool validPacking = additionalTexturesFound || additionalCoordsFound || additionalChannelsFound || additionalActions0Found || additionalActions1Found;

                            if (type == "FORCE_TEXTURE_PACKING")
                            {
                                validPacking = true;
                            }

                            if (validTexturesFound && validPacking)
                            {
                                var packedTexturePath = GetPackedTexturePath(packerData, texSaveName);

                                if (packedTexturePath != "")
                                {
                                    if (File.Exists(packedTexturePath) && keepConvertedMaterials)
                                    {
                                        var packedTexure = AssetDatabase.LoadAssetAtPath<Texture2D>(packedTexturePath);
                                        instanceMaterial.SetTexture(texPropName, packedTexure);
                                    }
                                    else
                                    {
                                        var packedTexure = TVEUtils.CreatePackedTexture(packedTexturePath, packerData);
                                        instanceMaterial.SetTexture(texPropName, packedTexure);
                                    }

                                    texPropName = "_MainShaderTex";

                                    packerData = TVEUtils.InitPackerData();
                                }
                            }
                        }
                    }
                }
            }
        }

        float SetFloatActions(string presetLine, float value)
        {
            if (presetLine.Contains("ACTION"))
            {
                var splitLine = presetLine.Split(" ");

                for (int i = 3; i < splitLine.Length; i++)
                {
                    var splitElement = splitLine[i];

                    if (splitElement == "ACTION_ONE_MINUS")
                    {
                        value = 1 - value;
                    }
                    else if (splitElement == "ACTION_NEGATIVE")
                    {
                        value = -value;
                    }
                    else if (splitElement == "ACTION_SATURATE")
                    {
                        value = Mathf.Clamp01(value);
                    }
                    else if (splitElement == "ACTION_CLAMP_NEGATIVE_VALUES")
                    {
                        value = Mathf.Clamp(value, 0, Mathf.Infinity);
                    }
                    else if (splitElement.Contains("ACTION_MUL_"))
                    {
                        var str = splitElement.Replace("ACTION_MUL_", "");
                        var val = 1.0f;

                        float.TryParse(str, out val);

                        value = value * val;
                    }
                    else if (splitElement.Contains("ACTION_POW_"))
                    {
                        var str = splitElement.Replace("ACTION_POW_", "");
                        var val = 1.0f;

                        float.TryParse(str, out val);

                        value = Mathf.Pow(value, val);
                    }
                    else if (splitElement.Contains("ACTION_DIV_"))
                    {
                        var str = splitElement.Replace("ACTION_DIV_", "");
                        var val = 1.0f;

                        float.TryParse(str, out val);

                        value = value / val;
                    }
                    else if (splitElement.Contains("ACTION_ADD_"))
                    {
                        var str = splitElement.Replace("ACTION_ADD_", "");
                        var val = 0.0f;

                        float.TryParse(str, out val);

                        value = value + val;
                    }
                    else if (splitElement.Contains("ACTION_SUB_"))
                    {
                        var str = splitElement.Replace("ACTION_SUB_", "");
                        var val = 0.0f;

                        float.TryParse(str, out val);

                        value = value - val;
                    }
                }
            }

            return value;
        }

        void SetPackerActions(string presetLine, TVEPackerData packerData, int maskIndex)
        {
            if (presetLine.Contains("ACTION"))
            {
                var splitLine = presetLine.Split(" ");

                int actionCount = 0;

                for (int i = 4; i < splitLine.Length; i++)
                {
                    var splitElement = splitLine[i];

                    if (splitElement == "ACTION_ONE_MINUS")
                    {
                        int actionIndex = 1;

                        if (actionCount == 0)
                        {
                            packerData.maskActions0[maskIndex] = actionIndex;
                            actionCount++;
                        }
                        else if (actionCount == 1)
                        {
                            packerData.maskActions1[maskIndex] = actionIndex;
                            actionCount++;
                        }
                    }
                    else if (splitElement.Contains("ACTION_MUL_"))
                    {
                        var str = splitElement.Replace("ACTION_MUL_", "");
                        var val = 1.0f;

                        float.TryParse(str, out val);

                        int actionIndex = 2;
                        float actionValue = val;

                        if (actionCount == 0)
                        {
                            packerData.maskActions0[maskIndex] = actionIndex;
                            packerData.maskValues0[maskIndex] = val;
                            actionCount++;
                        }
                        else if (actionCount == 1)
                        {
                            packerData.maskActions1[maskIndex] = actionIndex;
                            packerData.maskValues1[maskIndex] = val;
                            actionCount++;
                        }
                    }
                    else if (splitElement == "ACTION_MAKE_COLOR_BLACK")
                    {
                        int actionIndex = 11;

                        if (actionCount == 0)
                        {
                            packerData.maskActions0[maskIndex] = actionIndex;
                            actionCount++;
                        }
                        else if (actionCount == 1)
                        {
                            packerData.maskActions1[maskIndex] = actionIndex;
                            actionCount++;
                        }
                    }
                    else if (splitElement == "ACTION_MAKE_COLOR_WHITE")
                    {
                        int actionIndex = 12;

                        if (actionCount == 0)
                        {
                            packerData.maskActions0[maskIndex] = actionIndex;
                            actionCount++;
                        }
                        else if (actionCount == 1)
                        {
                            packerData.maskActions1[maskIndex] = actionIndex;
                            actionCount++;
                        }
                    }
                    else if (splitElement == "ACTION_MAKE_VALUE_GAMMA")
                    {
                        int actionIndex = 20;

                        if (actionCount == 0)
                        {
                            packerData.maskActions0[maskIndex] = actionIndex;
                            actionCount++;
                        }
                        else if (actionCount == 1)
                        {
                            packerData.maskActions1[maskIndex] = actionIndex;
                            actionCount++;
                        }
                    }
                    else if (splitElement == "ACTION_MAKE_VALUE_LINEAR")
                    {
                        int actionIndex = 21;

                        if (actionCount == 0)
                        {
                            packerData.maskActions0[maskIndex] = actionIndex;
                            actionCount++;
                        }
                        else if (actionCount == 1)
                        {
                            packerData.maskActions1[maskIndex] = actionIndex;
                            actionCount++;
                        }
                    }
                }
            }
        }

        Shader GetShaderFromPreset(string check)
        {
            var shader = shaderLeaf;

            if (check == "SHADER_STANDARD")
            {
                shader = shaderBark;
            }
            else if (check == "SHADER_SUBSURFACE")
            {
                shader = shaderLeaf;
            }
            else if (check == "SHADER_PROP")
            {
                shader = shaderProp;
            }
            else if (check == "SHADER_BARK")
            {
                shader = shaderBark;
            }
            else if (check == "SHADER_LEAF")
            {
                shader = shaderLeaf;
            }
            else if (check == "SHADER_COVER")
            {
                shader = shaderCover;
            }
            else if (check == "SHADER_PLANT")
            {
                shader = shaderPlant;
            }
            else if (check == "SHADER_GRASS")
            {
                shader = shaderGrass;
            }
            else if (check == "SHADER_CROSS")
            {
                shader = shaderCross;
            }

            return shader;
        }

        void PostProcessMaterials()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var instanceMaterials = gameObjectDataSet[i].instanceMaterials;

                if (instanceMaterials != null)
                {
                    for (int j = 0; j < instanceMaterials.Length; j++)
                    {
                        var instanceMaterial = instanceMaterials[j];

                        if (IsValidMaterial(instanceMaterial))
                        {
                            //if (sourceVariation > 0 && (optionVariation == 2 || optionVariation == 3))
                            //{
                            //    instanceMaterial.SetFloat("_VertexVariationMode", 1);
                            //}

                            //// Guess best values for squash motion
                            //var scale = Mathf.Round((1.0f / maxBoundsInfo.y * 10.0f * 0.5f) * 10);

                            //if (scale > 1)
                            //{
                            //    scale = Mathf.Clamp(Mathf.FloorToInt(scale), 0, 20);
                            //}

                            if (sourceExtraCoord != 0)
                            {
                                instanceMaterial.SetFloat("_HasExtraCoord", 1);
                            }

                            if (sourcePivots != 0)
                            {
                                instanceMaterial.SetFloat("_HasBakedPivots", 1);
                            }

                            instanceMaterial.SetFloat("_ObjectRadiusValue", Mathf.Round(maxBoundsInfo.x * 100) / 100);
                            instanceMaterial.SetFloat("_ObjectHeightValue", Mathf.Round(maxBoundsInfo.y * 100) / 100);

                            instanceMaterial.SetFloat("_IsConverted", 1);
                        }
                    }
                }
            }
        }

        void GetOrCopyTexture(Material material, Material instanceMaterial, string src, string dst)
        {
            var srcTex = material.GetTexture(src);

            instanceMaterial.SetTexture(dst, srcTex);
        }

        bool IsValidMaterial(Material material)
        {
            bool isValid = true;

            if (material == null)
            {
                isValid = false;
            }

            return isValid;
        }

        /// <summary>
        /// Saving Utils
        /// </summary>

        string GetConvertedAssetName(Object asset, string type, bool shareCommonAssets)
        {
            var assetName = GetAssetSafeName(asset);
            var assetGUID = GetAssetGUIDAndID(asset);
            var nameFormat = assetName;

            if (!shareCommonAssets)
            {
                if (!assetName.Contains(currentPrefab.prefabInstance.name))
                {
                    //nameFormat = currentPrefab.prefabInstance.name + "_" + assetName;
                    nameFormat = uniqueDataFormat;
                    nameFormat = nameFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
                    nameFormat = nameFormat.Replace("DATANAME", assetName);
                }
            }

            var saveFormat = outputDataFormat;
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATANAME", nameFormat);
            saveFormat = saveFormat.Replace("DATAGUID", assetGUID);
            saveFormat = saveFormat.Replace("DATATYPE", type);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            string saveName = splitFormat[splitFormat.Length - 1];

            return saveName;
        }

        string GetConvertedAssetPath(Object asset, string name, string extention, string type)
        {
            string savePath;

            var saveFormat = outputDataFormat;
            saveFormat = saveFormat.Replace("CONVERTROOT", convertFolder);
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATANAME", name);
            saveFormat = saveFormat.Replace("DATATYPE", type);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            var saveFolder = saveFormat.Replace(splitFormat[splitFormat.Length - 1], "");

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            savePath = saveFolder + name + "." + extention;

            return savePath;
        }

        string GetCollectedAssetName(Object asset, int collectSharingMode)
        {
            var assetName = asset.name;
            var nameFormat = assetName;

            if (collectSharingMode == 1)
            {
                if (!assetName.Contains(currentPrefab.prefabInstance.name))
                {
                    //nameFormat = currentPrefab.prefabInstance.name + "_" + assetName;
                    nameFormat = uniqueDataFormat;
                    nameFormat = nameFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
                    nameFormat = nameFormat.Replace("DATANAME", assetName);
                }
            }

            var saveFormat = collectDataFormat;
            saveFormat = saveFormat.Replace("DATANAME", nameFormat);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            string saveName = splitFormat[splitFormat.Length - 1];

            return saveName;
        }

        string GetCollectedAssetExt(Object asset)
        {
            var assetPath = AssetDatabase.GetAssetPath(asset);
            var assetExt = Path.GetExtension(assetPath);

            assetExt = assetExt.Replace(".", "");

            return assetExt;
        }

        string GetCollectedAssetPath(Object asset, string name, string extention, string type)
        {
            string savePath;

            var saveFormat = collectDataFormat;
            saveFormat = saveFormat.Replace("COLLECTROOT", collectFolder);
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATANAME", name);
            saveFormat = saveFormat.Replace("DATATYPE", type);

            var splitFormat = saveFormat.Split(char.Parse("/"));

            var saveFolder = saveFormat.Replace(splitFormat[splitFormat.Length - 1], "");

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            savePath = saveFolder + name + "." + extention;

            return savePath;
        }

        string GetOriginalAssetName(Object asset, string type)
        {
            var name = GetAssetSafeName(asset);
            var guid = GetAssetGUIDAndID(asset);

            var saveFormat = outputDataFormat;
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATANAME", name);
            saveFormat = saveFormat.Replace("DATAGUID", guid);
            saveFormat = saveFormat.Replace("DATATYPE", type);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            string saveName = splitFormat[splitFormat.Length - 1];

            return saveName;
        }

        string GetOriginalAssetPath(Object asset, string name, string type)
        {
            string savePath;

            var assetPath = AssetDatabase.GetAssetPath(asset);
            var assetName = name;

            var saveFormat = collectDataFormat;
            saveFormat = saveFormat.Replace("COLLECTROOT", collectFolder);
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATATYPE", type);

            var saveFolder = saveFormat;

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            if (!saveFolder.EndsWith("/"))
            {
                saveFolder = saveFolder + "/";
            }

            var extension = Path.GetExtension(assetPath);

            if (asset.name.Contains("Impostor"))
            {
                if (asset.GetType() == typeof(Material))
                {
                    extension = ".mat";
                }
            }

            savePath = saveFolder + assetName + extension;

            return savePath;
        }

        string GetLegacyAssetName(Object asset, string type, bool shareCommonAssets)
        {
            var name = GetLegacySafeName(asset);
            var guid = GetLegacyGUIDAndID(asset);

            var assetPath = AssetDatabase.GetAssetPath(asset);

            if (!IsValidPath(assetPath) || !shareCommonAssets)
            {
                name = name + " " + currentPrefab.prefabInstance.name;
            }

            var saveFormat = outputDataFormat;
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATANAME", name);
            saveFormat = saveFormat.Replace("DATAGUID", guid);
            saveFormat = saveFormat.Replace("DATATYPE", type);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            string saveName = splitFormat[splitFormat.Length - 1];

            return saveName;
        }

        string GetLegacyAssetPath(Object asset, string name, string extention, string type)
        {
            string savePath;

            var saveFormat = outputDataFormat;
            saveFormat = saveFormat.Replace("CONVERTROOT", convertFolder);
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
            saveFormat = saveFormat.Replace("DATANAME", name);
            saveFormat = saveFormat.Replace("DATATYPE", type);
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            var saveFolder = saveFormat.Replace(splitFormat[splitFormat.Length - 1], "");

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            savePath = saveFolder + name + "." + extention;

            return savePath;
        }

        string GetPackedTexturePath(TVEPackerData packerData, string texSaveName)
        {
            string savePath = "";

            Texture firstValidTexture = null;

            for (int i = 0; i < packerData.maskTextures.Length; i++)
            {
                var texture = packerData.maskTextures[i];

                if (texture != null)
                {
                    firstValidTexture = texture;
                    break;
                }
            }

            string extension = "png";

            if (outputTextures == 1)
            {
                extension = "tga";
            }
            else if (outputTextures == 2)
            {
                extension = "exr";
            }
            else if (outputTextures == 3)
            {
                extension = "asset";
            }

            string guid = "";

            for (int i = 0; i < packerData.maskTextures.Length; i++)
            {
                var texture = packerData.maskTextures[i];

                if (texture != null)
                {
                    var path = AssetDatabase.GetAssetPath(texture);
                    guid = guid + AssetDatabase.AssetPathToGUID(path).Substring(0, 1).ToUpper();
                }
                else
                {
                    guid = guid + "0";
                }
            }

            var saveFormat = outputDataFormat;
            saveFormat = saveFormat.Replace("CONVERTROOT", convertFolder);
            saveFormat = saveFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);

            if (texSaveName != "")
            {
                saveFormat = saveFormat.Replace("DATANAME", texSaveName);
            }
            else
            {
                saveFormat = saveFormat.Replace("DATANAME", firstValidTexture.name);
            }

            saveFormat = saveFormat.Replace("DATAGUID", guid);
            saveFormat = saveFormat.Replace("DATATYPE", "Texture");
            saveFormat = saveFormat.Replace("\\", "/");

            var splitFormat = saveFormat.Split(char.Parse("/"));

            string saveFolder = saveFormat.Replace(splitFormat[splitFormat.Length - 1], "");
            string saveName = splitFormat[splitFormat.Length - 1];

            if (!Directory.Exists(saveFolder))
            {
                Directory.CreateDirectory(saveFolder);
                AssetDatabase.Refresh();
            }

            savePath = saveFolder + saveName + "." + extension;

            return savePath;
        }

        Mesh SaveMesh(Mesh mesh, string savePath)
        {
            if (readWriteMode == 0)
            {
                mesh.UploadMeshData(true);
            }

            if (File.Exists(savePath))
            {
                var asset = AssetDatabase.LoadAssetAtPath<Mesh>(savePath);
                asset.Clear();

                EditorUtility.CopySerialized(mesh, asset);
            }
            else
            {
                AssetDatabase.CreateAsset(mesh, savePath);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            TVEUtils.SetLabel(savePath);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            return AssetDatabase.LoadAssetAtPath<Mesh>(savePath);
        }

        Material SaveMaterial(Material material, string savePath)
        {
            if (File.Exists(savePath))
            {
                var asset = AssetDatabase.LoadAssetAtPath<Material>(savePath);

#if UNITY_2022_1_OR_NEWER
                // CopySerialized is not replacing the locked properties, possible unity bug
                if (!keepConvertedMaterials)
                {
                    var assetShader = asset.shader;
                    var materialShader = material.shader;

                    for (int i = 0; i < assetShader.GetPropertyCount(); i++)
                    {
                        var propertyName = assetShader.GetPropertyName(i);

                        asset.SetPropertyLock(propertyName, false);
                    }

                    for (int i = 0; i < materialShader.GetPropertyCount(); i++)
                    {
                        var propertyName = materialShader.GetPropertyName(i);

                        if (material.IsPropertyLocked(propertyName))
                        {
                            asset.SetPropertyLock(propertyName, true);
                        }
                    }
                }
#endif

                EditorUtility.CopySerialized(material, asset);
            }
            else
            {
                AssetDatabase.CreateAsset(material, savePath);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            TVEUtils.SetLabel(savePath);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            return AssetDatabase.LoadAssetAtPath<Material>(savePath);
        }

        Texture SaveTexture(Texture texture, string savePath)
        {
            if (!File.Exists(savePath))
            {
                var texturePath = AssetDatabase.GetAssetPath(texture);

                AssetDatabase.CopyAsset(texturePath, savePath);

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            TVEUtils.SetLabel(savePath);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            return AssetDatabase.LoadAssetAtPath<Texture>(savePath);
        }

        string GetAssetSafeName(Object asset)
        {
            var assetName = asset.name;
            var assetPath = AssetDatabase.GetAssetPath(asset);
            var assetFileName = Path.GetFileNameWithoutExtension(assetPath);

            var nameFormat = assetName;

            // Make Tree Creator Assets explicit
            if (assetPath.EndsWith(".prefab"))
            {
                if (assetName == "Mesh")
                {
                    nameFormat = assetFileName;
                }

                if (assetName == "Optimized Bark Material")
                {
                    nameFormat = assetFileName + " Bark";
                }

                if (assetName == "Optimized Leaf Material")
                {
                    nameFormat = assetFileName + " Leaf";
                }
            }
            else if (!IsValidPath(assetPath))
            {
                //nameFormat = currentPrefab.prefabInstance.name + "_" + assetName;
                nameFormat = uniqueDataFormat;
                nameFormat = nameFormat.Replace("BASENAME", currentPrefab.prefabInstance.name);
                nameFormat = nameFormat.Replace("DATANAME", assetName);
            }
            else
            {
                if (!assetName.Contains(assetFileName))
                {
                    //nameFormat = assetFileName + "_" + assetName;
                    nameFormat = uniqueDataFormat;
                    nameFormat = nameFormat.Replace("BASENAME", assetFileName);
                    nameFormat = nameFormat.Replace("DATANAME", assetName);
                }
            }

            return System.Text.RegularExpressions.Regex.Replace(nameFormat, "[^\\w\\._ ()-]", "");
        }

        string GetAssetGUIDAndID(Object asset)
        {
            var assetPath = AssetDatabase.GetAssetPath(asset);
            var assetGUID = AssetDatabase.AssetPathToGUID(assetPath);
            var shortGUID = assetGUID.Substring(0, 4).ToUpper();

            if (!assetPath.EndsWith(".prefab"))
            {
                var subAssets = AssetDatabase.LoadAllAssetsAtPath(assetPath);

                if (subAssets != null && subAssets.Length > 1)
                {
                    int id = 0;

                    for (int i = 0; i < subAssets.Length; i++)
                    {
                        if (asset == subAssets[i])
                        {
                            id = i;
                            break;
                        }
                    }

                    shortGUID = assetGUID.Substring(0, 2).ToUpper() + id.ToString("00");
                }
            }

            return shortGUID;
        }

        string GetLegacySafeName(Object asset)
        {
            var name = asset.name;
            var path = AssetDatabase.GetAssetPath(asset);

            // Make Tree Creator Assets explicit
            if (asset.name == "Mesh")
            {
                name = Path.GetFileNameWithoutExtension(path);
            }

            // Make Tree Creator Assets explicit
            if (asset.name == "Optimized Bark Material")
            {
                name = Path.GetFileNameWithoutExtension(path) + " Bark";
            }

            // Make Tree Creator Assets explicit
            if (asset.name == "Optimized Leaf Material")
            {
                name = Path.GetFileNameWithoutExtension(path) + " Leaf";
            }

            return System.Text.RegularExpressions.Regex.Replace(name, "[^\\w\\._ ()-]", "");
        }

        string GetLegacyGUIDAndID(Object asset)
        {
            var path = AssetDatabase.GetAssetPath(asset);
            var guid = AssetDatabase.AssetPathToGUID(path).Substring(0, 2).ToUpper();

            var subAssets = AssetDatabase.LoadAllAssetsAtPath(path);

            int id = 0;

            if (subAssets != null)
            {
                for (int i = 0; i < subAssets.Length; i++)
                {
                    if (asset == subAssets[i])
                    {
                        id = i;
                        break;
                    }
                }
            }

            return guid + id.ToString("00");
        }

        bool IsValidPath(string path)
        {
            bool isValid = true;

            if (path == "" || path.Contains("unity default resources") || path.Contains("unity_builtin_extra") || path.Contains("Packages"))
            {
                isValid = false;
            }

            return isValid;
        }

        /// <summary>
        /// Collect Utils
        /// </summary>

        void CollectPrefabBackups()
        {
            if (currentPrefab.prefabInstance.GetComponent<TVEPrefab>() != null)
            {
                var prefabComponent = currentPrefab.prefabInstance.GetComponent<TVEPrefab>();
                var prefabBackupPath = AssetDatabase.GUIDToAssetPath(prefabComponent.storedPrefabBackupGUID);
                var prefabBackup = AssetDatabase.LoadAssetAtPath<Object>(prefabBackupPath);

                if (prefabBackupPath != "")
                {
                    var saveName = GetCollectedAssetName(prefabBackup, 0);
                    var savePath = GetCollectedAssetPath(prefabBackup, saveName, "prefab", "Backup");

                    AssetDatabase.CopyAsset(prefabBackupPath, savePath);
                    AssetDatabase.Refresh();

                    prefabComponent.storedPrefabBackupGUID = AssetDatabase.AssetPathToGUID(savePath);

                    exportList.Add(savePath);
                }
            }
        }

        void CollectPrefabBackupsForExport()
        {
            if (currentPrefab.prefabInstance.GetComponent<TVEPrefab>() != null)
            {
                var prefabComponent = currentPrefab.prefabInstance.GetComponent<TVEPrefab>();
                var prefabBackupPath = AssetDatabase.GUIDToAssetPath(prefabComponent.storedPrefabBackupGUID);

                if (prefabBackupPath != "")
                {
                    exportList.Add(prefabBackupPath);
                }
            }
        }

        void CollectPrefabMaterials()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshRenderer = gameObjectDataSet[i].meshRenderer;

                if (meshRenderer != null)
                {
                    var sharedMaterials = meshRenderer.sharedMaterials;

                    if (sharedMaterials != null)
                    {
                        for (int m = 0; m < sharedMaterials.Length; m++)
                        {
                            if (sharedMaterials[m] != null)
                            {
                                var material = sharedMaterials[m];

                                string saveMaterialName;
                                string saveMaterialPath;

                                if (TVEUtils.HasLabel(material))
                                {
                                    saveMaterialName = GetCollectedAssetName(material, collectSharing);
                                    saveMaterialPath = GetCollectedAssetPath(material, saveMaterialName, "mat", "Material");
                                }
                                else
                                {
                                    var type = "Material";

                                    if (material.name.Contains("Impostor"))
                                    {
                                        type = "Impostor";
                                    }

                                    saveMaterialName = GetOriginalAssetName(material, type);
                                    saveMaterialPath = GetOriginalAssetPath(material, saveMaterialName, type);
                                }

                                var instanceMaterial = Instantiate(material);
                                instanceMaterial.name = saveMaterialName;

                                if (collectSharing == 1)
                                {
                                    instanceMaterial.SetInt("_IsShared", 0);
                                }

                                instanceMaterial.SetInt("_IsCollected", 1);
                                instanceMaterial.SetInt("_IsIdentifier", (int)Random.Range(1, 100));

                                sharedMaterials[m] = SaveMaterial(instanceMaterial, saveMaterialPath);

                                exportList.Add(saveMaterialPath);

                                var shader = material.shader;

                                for (int s = 0; s < BoxoUtils.GetShaderPropertyCount(shader); s++)
                                {
                                    var propName = BoxoUtils.GetShaderPropertyName(shader, s);
                                    var propType = BoxoUtils.GetShaderPropertyType(shader, s);

                                    if (propType == UnityEngine.Rendering.ShaderPropertyType.Texture)
                                    {
                                        var texture = sharedMaterials[m].GetTexture(propName);
                                        var texturePath = AssetDatabase.GetAssetPath(texture);

                                        // Skip tve textures because they are available already
                                        if (texture != null && texturePath != "" && !texturePath.Contains("The Visual Engine"))
                                        {
                                            string saveTextureName;
                                            string saveTexturePath;

                                            // If has Label, it is a TVE packed texture, otherwise it is an original texture
                                            if (TVEUtils.HasLabel(texture))
                                            {
                                                saveTextureName = GetCollectedAssetName(texture, 0);
                                                var saveTextureExt = GetCollectedAssetExt(texture);
                                                saveTexturePath = GetCollectedAssetPath(texture, saveTextureName, saveTextureExt, "Texture");
                                            }
                                            else
                                            {
                                                var type = "Texture";

                                                if (texture.name.Contains("Impostor"))
                                                {
                                                    type = "Impostor";
                                                }

                                                saveTextureName = GetOriginalAssetName(texture, type);
                                                saveTexturePath = GetOriginalAssetPath(texture, saveTextureName, type);
                                            }

                                            sharedMaterials[m].SetTexture(propName, SaveTexture(texture, saveTexturePath));

                                            exportList.Add(saveTexturePath);
                                        }
                                    }
                                }
                            }
                        }

                        meshRenderer.sharedMaterials = sharedMaterials;
                    }
                }
            }
        }

        void CollectPrefabMaterialsForExport()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshRenderer = gameObjectDataSet[i].meshRenderer;

                if (meshRenderer != null)
                {
                    var sharedMaterials = meshRenderer.sharedMaterials;

                    if (sharedMaterials != null)
                    {
                        for (int m = 0; m < sharedMaterials.Length; m++)
                        {
                            if (sharedMaterials[m] != null)
                            {
                                var material = sharedMaterials[m];
                                var materialPath = AssetDatabase.GetAssetPath(material);

                                exportList.Add(materialPath);

                                var shader = material.shader;

                                for (int s = 0; s < BoxoUtils.GetShaderPropertyCount(shader); s++)
                                {
                                    var propName = BoxoUtils.GetShaderPropertyName(shader, s);
                                    var propType = BoxoUtils.GetShaderPropertyType(shader, s);

                                    if (propType == UnityEngine.Rendering.ShaderPropertyType.Texture)
                                    {
                                        var texture = sharedMaterials[m].GetTexture(propName);
                                        var texturePath = AssetDatabase.GetAssetPath(texture);

                                        // Skip tve textures because they are available already
                                        if (texture != null && !texturePath.Contains("The Visual Engine"))
                                        {
                                            exportList.Add(texturePath);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        void CollectPrefabMeshes()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshFilter = gameObjectDataSet[i].meshFilter;
                var originalMesh = gameObjectDataSet[i].originalMesh;

                if (meshFilter != null)
                {
                    if (originalMesh != null)
                    {
                        string saveName;
                        string savePath;

                        if (TVEUtils.HasLabel(originalMesh))
                        {
                            saveName = GetCollectedAssetName(originalMesh, 0);
                            savePath = GetCollectedAssetPath(originalMesh, saveName, "asset", "Model");
                        }
                        else
                        {
                            var type = "Model";

                            if (originalMesh.name.Contains("Impostor"))
                            {
                                type = "Impostor";
                            }

                            saveName = GetOriginalAssetName(originalMesh, type);
                            savePath = GetOriginalAssetPath(originalMesh, saveName, type);
                        }

                        var instanceMesh = Instantiate(originalMesh);
                        instanceMesh.name = saveName;

                        meshFilter.sharedMesh = SaveMesh(instanceMesh, savePath);

                        exportList.Add(savePath);
                    }
                }
            }
        }

        void CollectPrefabMeshesForExport()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshFilter = gameObjectDataSet[i].meshFilter;
                var originalMesh = gameObjectDataSet[i].originalMesh;

                if (meshFilter != null)
                {
                    if (originalMesh != null)
                    {
                        var meshPath = AssetDatabase.GetAssetPath(originalMesh);

                        exportList.Add(meshPath);
                    }
                }
            }
        }

        void CollectPrefabColliders()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshColliders = gameObjectDataSet[i].meshColliders;
                var originalColliders = gameObjectDataSet[i].originalColliders;

                for (int j = 0; j < meshColliders.Count; j++)
                {
                    var meshCollider = meshColliders[j];
                    var originalCollider = originalColliders[j];

                    if (meshCollider != null)
                    {
                        if (originalCollider != null)
                        {
                            string saveName;
                            string savePath;

                            if (!TVEUtils.HasLabel(originalCollider))
                            {
                                saveName = GetCollectedAssetName(originalCollider, 0);
                                savePath = GetCollectedAssetPath(originalCollider, saveName, "asset", "Model");
                            }
                            else
                            {
                                var type = "Model";

                                if (originalCollider.name.Contains("Impostor"))
                                {
                                    type = "Impostor";
                                }

                                saveName = GetOriginalAssetName(originalCollider, type);
                                savePath = GetOriginalAssetPath(originalCollider, saveName, type);
                            }

                            var instanceCollider = Instantiate(originalCollider);
                            instanceCollider.name = saveName;

                            meshCollider.sharedMesh = SaveMesh(instanceCollider, savePath);

                            exportList.Add(savePath);
                        }
                    }
                }
            }
        }

        void CollectPrefabCollidersForExport()
        {
            for (int i = 0; i < gameObjectDataSet.Count; i++)
            {
                var meshColliders = gameObjectDataSet[i].meshColliders;
                var originalColliders = gameObjectDataSet[i].originalColliders;

                for (int j = 0; j < meshColliders.Count; j++)
                {
                    var meshCollider = meshColliders[j];
                    var originalCollider = originalColliders[j];

                    if (meshCollider != null)
                    {
                        if (originalCollider != null)
                        {
                            var colliderPath = AssetDatabase.GetAssetPath(originalCollider);

                            exportList.Add(colliderPath);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Get Project Presets
        /// </summary>

        void GetPresets()
        {
            presetPaths = new List<string>();
            presetPaths.Add("");

            overridePaths = new List<string>();
            overridePaths.Add("");

            detectLines = new List<string>();

            allPresetPaths = BoxoUtils.FindAssets("*.tvepreset", false);

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                string assetPath = allPresetPaths[i];

                if (assetPath.Contains("[PRESET]"))
                {
                    presetPaths.Add(assetPath);
                }

                if (assetPath.Contains("[OVERRIDE]") == true)
                {
                    overridePaths.Add(assetPath);
                }

                if (assetPath.Contains("[DETECT]") == true)
                {
                    StreamReader reader = new StreamReader(assetPath);

                    while (!reader.EndOfStream)
                    {
                        detectLines.Add(reader.ReadLine());
                    }

                    reader.Close();
                }
            }

            PresetsEnum = new string[presetPaths.Count];
            PresetsEnum[0] = "Choose a preset";

            OverridesEnum = new string[overridePaths.Count];
            OverridesEnum[0] = "None";

            for (int i = 1; i < presetPaths.Count; i++)
            {
                PresetsEnum[i] = Path.GetFileNameWithoutExtension(presetPaths[i]);
                //PresetsEnum[i] = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(presetPaths[i]).name;
                PresetsEnum[i] = PresetsEnum[i].Replace("[PRESET] ", "");
                PresetsEnum[i] = PresetsEnum[i].Replace(" - ", "/");
            }

            for (int i = 1; i < overridePaths.Count; i++)
            {
                OverridesEnum[i] = Path.GetFileNameWithoutExtension(overridePaths[i]);
                //OverridesEnum[i] = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(overridePaths[i]).name;
                OverridesEnum[i] = OverridesEnum[i].Replace("[OVERRIDE] ", "");
                OverridesEnum[i] = OverridesEnum[i].Replace(" - ", "/");
            }
        }

        void GetPresetLines()
        {
            presetLines = new List<string>();

            StreamReader reader = new StreamReader(presetPaths[presetIndex]);

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();
                line = line.TrimStart();
                line = line.TrimEnd();

                presetLines.Add(line);

                if (line.Contains("Include"))
                {
                    GetIncludeLines(line);
                }
            }

            reader.Close();

            for (int i = 0; i < overrideIndices.Count; i++)
            {
                if (overrideIndices[i] != 0)
                {
                    reader = new StreamReader(overridePaths[overrideIndices[i]]);

                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();
                        line = line.TrimStart();
                        line = line.TrimEnd();

                        presetLines.Add(line);

                        if (line.Contains("Include"))
                        {
                            GetIncludeLines(line);
                        }
                    }

                    reader.Close();
                }
            }

            //for (int i = 0; i < presetLines.Count; i++)
            //{
            //    Debug.Log(presetLines[i]);
            //}
        }

        void GetIncludeLines(string include)
        {
            var import = include.Replace("Include ", "");

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                if (allPresetPaths[i].Contains(import))
                {
                    StreamReader reader = new StreamReader(allPresetPaths[i]);

                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();
                        line = line.TrimStart();
                        line = line.TrimEnd();

                        presetLines.Add(line);

                        if (line.Contains("Include"))
                        {
                            GetIncludeLines(line);
                        }
                    }

                    reader.Close();
                }
            }
        }

        void GetOptionsFromPreset(bool usePrefered)
        {
            if (presetIndex == 0)
            {
                return;
            }

            var options = new List<string>();
            var splitPrefered = new string[0];

            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("OutputOptions"))
                {
                    var splitLine = presetLines[i].Replace("OutputOptions ", "").Split(char.Parse("/"));
                    splitPrefered = presetLines[i].Split(char.Parse(" "));

                    for (int j = 0; j < splitLine.Length; j++)
                    {
                        options.Add(splitLine[j]);
                    }
                }
            }

            if (options.Count == 0)
            {
                options.Add("");

                OptionsEnum = options.ToArray();
            }
            else
            {
                int prefered = 0;

                if (int.TryParse(splitPrefered[splitPrefered.Length - 1], out prefered))
                {
                    if (usePrefered)
                    {
                        optionIndex = prefered;
                    }

                    options[options.Count - 1] = options[options.Count - 1].Replace(" " + prefered, "");
                }

                OptionsEnum = new string[options.Count];

                for (int i = 0; i < options.Count; i++)
                {
                    OptionsEnum[i] = options[i];
                }
            }

            if (optionIndex >= OptionsEnum.Length)
            {
                optionIndex = 0;
            }

            //for (int i = 0; i < ModelOptions.Length; i++)
            //{
            //    Debug.Log(ModelOptions[i]);
            //}
        }

        void GetDescriptionFromPreset()
        {
            infoTitle = "Preset";
            infoPreset = "";
            infoAdditive = "";
            infoStatus = "";
            infoOnline = "";
            infoTutorial = "";
            infoCollection = "";
            infoMessage = "";
            infoWarning = "";
            infoError = "";
            //infoSharing = "";

            var usePresetLines = new List<bool>();
            usePresetLines.Add(true);

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(usePresetLines, presetLines[i], null);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("InfoTitle"))
                    {
                        infoTitle = presetLines[i].Replace("InfoTitle ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoPreset"))
                    {
                        infoPreset = presetLines[i].Replace("InfoPreset ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoAdditive"))
                    {
                        infoAdditive = presetLines[i].Replace("InfoAdditive ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoStatus"))
                    {
                        infoStatus = presetLines[i].Replace("InfoStatus ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoOnline"))
                    {
                        infoOnline = presetLines[i].Replace("InfoOnline ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoTutorial"))
                    {
                        infoTutorial = presetLines[i].Replace("InfoTutorial ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoCollection"))
                    {
                        infoCollection = presetLines[i].Replace("InfoCollection ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoMessage"))
                    {
                        infoMessage = presetLines[i].Replace("InfoMessage ", "").Replace("NONE", "");
                    }
                    else if (presetLines[i].StartsWith("InfoWarning"))
                    {
                        infoWarning = presetLines[i].Replace("InfoWarning ", "").Replace("NONE", "");
                    }
                    else if (presetLines[i].StartsWith("InfoError"))
                    {
                        infoError = presetLines[i].Replace("InfoError ", "").Replace("NONE", "");
                    }
                    //else if (presetLines[i].StartsWith("InfoSharing"))
                    //{
                    //    infoSharing = presetLines[i].Replace("InfoSharing ", "").Replace("NONE", "");
                    //}
                }
            }

            //if (presetAutoDetected)
            //{
            //    infoTitle = infoTitle + " (Auto Detected)";
            //}
        }

        void GetOutputsFromPreset()
        {
            outputMeshes = TRUE;
            outputMaterials = TRUE;
            outputTextures = 0;
            collectBackups = 1;
            collectLocking = 0;
            outputValid = true;
            outputVersion = "-1";
            outputPipelines = "";

            uniqueDataFormat = "BASENAME DATANAME";
            outputBaseFormat = "CONVERTROOT/BASENAME";
            outputDataFormat = "CONVERTROOT/Prefabs Data/DATATYPEs/DATANAME DATAGUID (TVE DATATYPE)";
            collectBaseFormat = "COLLECTROOT/BASENAME";
            collectDataFormat = "COLLECTROOT/Prefabs Data/DATATYPEs/DATANAME";

            var usePresetLines = new List<bool>();
            usePresetLines.Add(true);

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(usePresetLines, presetLines[i], null);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("OutputMeshes"))
                    {
                        string source = presetLines[i].Replace("OutputMeshes ", "");

                        if (source == "OFF" || source == "NONE")
                        {
                            outputMeshes = FALSE;
                        }
                        else if (source == "DEFAULT")
                        {
                            outputMeshes = TRUE;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputMaterials"))
                    {
                        string source = presetLines[i].Replace("OutputMaterials ", "");

                        if (source == "OFF" || source == "NONE")
                        {
                            outputMaterials = FALSE;
                        }
                        else if (source == "DEFAULT")
                        {
                            outputMaterials = TRUE;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputTextures"))
                    {
                        string source = presetLines[i].Replace("OutputTextures ", "");

                        if (source == "SAVE_TEXTURES_AS_PNG")
                        {
                            outputTextures = 0;
                        }
                        else if (source == "SAVE_TEXTURES_AS_TGA")
                        {
                            outputTextures = 1;
                        }
                        else if (source == "SAVE_TEXTURES_AS_EXR")
                        {
                            outputTextures = 2;
                        }
                        else if (source == "SAVE_TEXTURES_AS_ASSET")
                        {
                            outputTextures = 3;
                        }
                    }
                    else if (presetLines[i].StartsWith("CollectSharing"))
                    {
                        string source = presetLines[i].Replace("CollectSharing ", "");

                        if (source == "USE_ORIGINAL_SHARING")
                        {
                            collectSharing = 0;
                        }
                        else if (source == "CREATE_UNIQUE_MATERIALS")
                        {
                            collectSharing = 1;
                        }
                    }
                    else if (presetLines[i].StartsWith("CollectBackups"))
                    {
                        string source = presetLines[i].Replace("CollectBackups ", "");

                        if (source == "FALSE")
                        {
                            collectBackups = FALSE;
                        }
                        else if (source == "TRUE")
                        {
                            collectBackups = TRUE;
                        }
                    }
                    else if (presetLines[i].StartsWith("CollectLocking"))
                    {
                        string source = presetLines[i].Replace("CollectLocking ", "");

                        if (source == "FALSE")
                        {
                            collectLocking = FALSE;
                        }
                        else if (source == "TRUE")
                        {
                            collectLocking = TRUE;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputPipelines"))
                    {
                        outputPipelines = presetLines[i].Replace("OutputPipelines ", "");
                    }
                    else if (presetLines[i].StartsWith("OutputVersion"))
                    {
                        outputVersion = presetLines[i].Replace("OutputVersion ", "");
                    }
                    //else if (presetLines[i].StartsWith("UniqueName"))
                    //{
                    //    outputBaseFormat = presetLines[i].Replace("UniqueName ", "");
                    //}
                    else if (presetLines[i].StartsWith("OutputBase"))
                    {
                        outputBaseFormat = presetLines[i].Replace("OutputBase ", "");
                    }
                    else if (presetLines[i].StartsWith("OutputData"))
                    {
                        outputDataFormat = presetLines[i].Replace("OutputData ", "");
                    }
                    else if (presetLines[i].StartsWith("CollectBase"))
                    {
                        collectBaseFormat = presetLines[i].Replace("CollectBase ", "");
                    }
                    else if (presetLines[i].StartsWith("CollectData"))
                    {
                        collectDataFormat = presetLines[i].Replace("CollectData ", "");
                    }
                    else if (presetLines[i].StartsWith("OutputValid"))
                    {
                        string source = presetLines[i].Replace("OutputValid ", "");

                        if (source == "FALSE")
                        {
                            outputValid = false;
                        }
                        else if (source == "TRUE")
                        {
                            outputValid = true;
                        }
                    }

                    if (outputPipelines != "")
                    {
                        if (!outputPipelines.Contains(projectPipeline))
                        {
                            outputValid = false;
                            infoError = "The current asset can only be converted in the " + outputPipelines + " render pipeline and then exported to you project using the Collect Converted Data feature! Check the documentation for more details. ";
                        }
                    }

                    if (assetVersion < int.Parse(outputVersion))
                    {
                        var version = outputVersion;
                        version = version.Insert(2, ".");
                        version = version.Insert(4, ".");

                        outputValid = false;
                        infoError = "The current asset can only be converted in using version " + version + " or higher! ";
                    }
                }
            }
        }

        void GetGlobalOverrides()
        {
            var globalOverrides = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Converter Overrides.asset", "");

            if (globalOverrides != "")
            {
                var splitLine = globalOverrides.Split(char.Parse(";"));

                for (int o = 0; o < OverridesEnum.Length; o++)
                {
                    for (int s = 0; s < splitLine.Length; s++)
                    {
                        if (OverridesEnum[o] == splitLine[s])
                        {
                            if (!overrideIndices.Contains(o))
                            {
                                overrideIndices.Add(o);
                                overrideGlobals.Add(true);
                            }
                        }
                    }
                }

                for (int i = 0; i < overrideIndices.Count; i++)
                {
                    if (globalOverrides.Contains(OverridesEnum[overrideIndices[i]]))
                    {
                        overrideGlobals[i] = true;
                    }
                }
            }
        }

        void GetDefaultShaders()
        {
            var shaderStandard = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit");
            var shaderSubsurface = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Subsurface Lit");

            shaderProp = shaderStandard;
            shaderBark = shaderStandard;
            shaderLeaf = shaderSubsurface;
            shaderCover = shaderStandard;
            shaderPlant = shaderSubsurface;
            shaderGrass = shaderSubsurface;
            shaderCross = shaderSubsurface;
        }

        void GetAllPresetInfo(bool usePrefered)
        {
            if (presetIndex == 0)
            {
                return;
            }

            if (!File.Exists(presetPaths[presetIndex]))
            {
                presetIndex = 0;
                return;
            }

            GetPresetLines();
            GetOptionsFromPreset(usePrefered);
            GetDescriptionFromPreset();

            if (!hasShaderModifications)
            {
                GetDefaultShadersFromPreset();
            }

            if (!hasOutputModifications)
            {
                GetOutputsFromPreset();
            }

            if (!hasModelModifications)
            {
                GetMeshConversionFromPreset(null);
            }
        }

        bool GetConditionFromLine(List<bool> usePresetLines, string line, Material material)
        {
            var valid = true;

            if (line.StartsWith("if"))
            {
                valid = false;

                string[] splitLine = line.Split(char.Parse(" "));

                var type = "";
                var check = "";
                var checkFull = "";
                var val = splitLine[splitLine.Length - 1];

                if (splitLine.Length > 1)
                {
                    type = splitLine[1];
                }

                if (splitLine.Length > 2)
                {
                    for (int i = 2; i < splitLine.Length; i++)
                    {
                        if (!float.TryParse(splitLine[i], out _))
                        {
                            check = check + splitLine[i] + " ";
                        }

                        checkFull = checkFull + splitLine[i] + " ";
                    }

                    // Trim final space
                    check = check.TrimEnd();
                    checkFull = checkFull.TrimEnd();
                }

                if (type.Contains("OUTPUT_OPTION_CONTAINS"))
                {
                    if (OptionsEnum[optionIndex].Contains(check))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("PROJECT_HAS_DEFINE_SYMBOL"))
                {
#if UNITY_2023_1_OR_NEWER
                    BuildTarget buildTarget = EditorUserBuildSettings.activeBuildTarget;
                    BuildTargetGroup targetGroup = BuildPipeline.GetBuildTargetGroup(buildTarget);
                    var namedBuildTarget = UnityEditor.Build.NamedBuildTarget.FromBuildTargetGroup(targetGroup);
                    var defineSymbols = PlayerSettings.GetScriptingDefineSymbols(namedBuildTarget);
#else
                    var defineSymbols = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);
#endif

                    if (defineSymbols.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("PREFAB_PATH_CONTAINS"))
                {
                    var path = AssetDatabase.GetAssetPath(currentPrefab.prefabInstance).ToUpperInvariant();

                    if (path.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("ANY_PREFAB_PATH_CONTAINS"))
                {
                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        var prefab = prefabObjects[i].prefabObject;

                        var path = AssetDatabase.GetAssetPath(prefab).ToUpperInvariant();

                        if (path.Contains(check.ToUpperInvariant()))
                        {
                            valid = true;
                        }
                    }
                }
                else if (type.Contains("ANY_PREFAB_ATTRIBUTE_CONTAINS"))
                {
                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        var attribute = prefabObjects[i].attributes;

                        if (attribute.Contains(check.ToUpperInvariant()))
                        {
                            valid = true;
                        }
                    }
                }
                else if (type.Contains("ASSET_VERSION_EQUALS"))
                {
                    var value = int.Parse(val, CultureInfo.InvariantCulture);

                    if (assetVersion == value)
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("ASSET_VERSION_SMALLER"))
                {
                    var value = int.Parse(val, CultureInfo.InvariantCulture);

                    if (assetVersion < value)
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("ASSET_VERSION_GREATER"))
                {
                    var value = int.Parse(val, CultureInfo.InvariantCulture);

                    if (assetVersion > value)
                    {
                        valid = true;
                    }
                }

                if (material != null)
                {
                    if (type.Contains("SHADER_PATH_CONTAINS"))
                    {
                        var path = AssetDatabase.GetAssetPath(material.shader).ToUpperInvariant();

                        if (path.Contains(check.ToUpperInvariant()))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_NAME_CONTAINS"))
                    {
                        var name = material.shader.name.ToUpperInvariant();

                        if (name.Contains(check.ToUpperInvariant()))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_NAME_EQUALS"))
                    {
                        var name = material.shader.name.ToUpperInvariant();

                        if (name == checkFull.ToUpperInvariant())
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_IS_UNITY_LIT"))
                    {
                        var name = material.shader.name;

                        if (name.StartsWith("Standard") || name.StartsWith("Universal Render Pipeline") || name.StartsWith("HDRP"))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_PIPELINE_IS_STANDARD"))
                    {
                        if (material.GetTag("RenderPipeline", false) == "")
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_PIPELINE_IS_UNIVERSAL"))
                    {
                        if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_PIPELINE_IS_HD"))
                    {
                        if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("SHADER_PIPELINE_IS_SRP"))
                    {
                        if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline" || material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_PATH_CONTAINS"))
                    {
                        var path = AssetDatabase.GetAssetPath(material).ToUpperInvariant();

                        if (path.Contains(check.ToUpperInvariant()))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_NAME_CONTAINS"))
                    {
                        var name = material.name.ToUpperInvariant();

                        if (name.Contains(check.ToUpperInvariant()))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_RENDERTYPE_TAG_CONTAINS"))
                    {
                        if (material.GetTag("RenderType", false).Contains(check))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_HAS_PROP"))
                    {
                        if (material.HasProperty(check))
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_HAS_TEX"))
                    {
                        if (material.HasProperty(check))
                        {
                            if (material.GetTexture(check) != null)
                            {
                                valid = true;
                            }
                        }
                    }
#if UNITY_2021_3_OR_NEWER
                    else if (type.Contains("MATERIAL_HAS_KEYWORD"))
                    {
                        var keyword = material.shader.keywordSpace.FindKeyword(check);

                        if (keyword.isValid)
                        {
                            valid = true;
                        }
                    }
#endif
                    else if (type.Contains("MATERIAL_FLOAT_EQUALS"))
                    {
                        var min = float.Parse(val, CultureInfo.InvariantCulture) - 0.01f;
                        var max = float.Parse(val, CultureInfo.InvariantCulture) + 0.01f;

                        if (material.HasProperty(check) && material.GetFloat(check) > min && material.GetFloat(check) < max)
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_FLOAT_SMALLER"))
                    {
                        var value = float.Parse(val, CultureInfo.InvariantCulture);

                        if (material.HasProperty(check) && material.GetFloat(check) < value)
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_FLOAT_GREATER"))
                    {
                        var value = float.Parse(val, CultureInfo.InvariantCulture);

                        if (material.HasProperty(check) && material.GetFloat(check) > value)
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_COLOR_BLACK"))
                    {
                        var min = -0.01f;
                        var max = +0.01f;

                        if (material.HasProperty(check))
                        {
                            var color = material.GetVector(check);
                            var value = color.x + color.y + color.z;

                            if (value > min && value < max)
                            {
                                valid = true;
                            }
                        }
                    }
                    else if (type.Contains("MATERIAL_COLOR_WHITE"))
                    {
                        var min = 0.99f;
                        var max = 1.01f;

                        if (material.HasProperty(check))
                        {
                            var color = material.GetVector(check);
                            var value = color.x + color.y + color.z;

                            if (value > min && value < max)
                            {
                                valid = true;
                            }
                        }
                    }
                    else if (type.Contains("MATERIAL_FLOAT_SMALLER"))
                    {
                        var value = float.Parse(val, CultureInfo.InvariantCulture);

                        if (material.HasProperty(check) && material.GetFloat(check) < value)
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_FLOAT_GREATER"))
                    {
                        var value = float.Parse(val, CultureInfo.InvariantCulture);

                        if (material.HasProperty(check) && material.GetFloat(check) > value)
                        {
                            valid = true;
                        }
                    }
                    else if (type.Contains("MATERIAL_TEX_SRGB"))
                    {
                        if (material.HasProperty(check))
                        {
                            var texture = material.GetTexture(check);

                            if (texture != null)
                            {
                                if (texture.isDataSRGB)
                                {
                                    valid = true;
                                }
                            }
                        }
                    }
                    else if (type.Contains("MATERIAL_KEYWORD_ENABLED"))
                    {
                        if (material.IsKeywordEnabled(check))
                        {
                            valid = true;
                        }
                    }
                }

                usePresetLines.Add(valid);
            }

            if (line.StartsWith("if") && line.Contains("!"))
            {
                valid = !valid;
                usePresetLines[usePresetLines.Count - 1] = valid;
            }

            if (line.StartsWith("endif") || line.StartsWith("}"))
            {
                usePresetLines.RemoveAt(usePresetLines.Count - 1);
            }

            var useLine = true;

            for (int i = 1; i < usePresetLines.Count; i++)
            {
                if (usePresetLines[i] == false)
                {
                    useLine = false;
                    break;
                }
            }

            return useLine;
        }
    }
}
