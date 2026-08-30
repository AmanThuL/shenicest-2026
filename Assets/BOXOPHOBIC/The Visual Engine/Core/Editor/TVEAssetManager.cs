// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using System.Collections.Generic;
using System.Reflection;
using System.IO;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    public class TVEAssetManager : EditorWindow
    {
        float GUI_HALF_EDITOR_WIDTH = 200;
        float GUI_FULL_EDITOR_WIDTH = 200;

        string[] SeletionEnum = new string[]
        {
        "Selected Folders", "Selected Assets",
        };

        int selectionIndex = 0;
        Vector3 boundsMultiplier = Vector3.one;
#if UNITY_6000_2_OR_NEWER
        int meshLODLimit = -1;
#endif

        List<string> allAssetsPaths;

        string userFolder = "Assets/BOXOPHOBIC+";

        GUIStyle stylePopup;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;
        static TVEAssetManager window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Visual Engine/Asset Manager", false, 2005)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEAssetManager>(false, "Asset Manager", true);
            window.minSize = new Vector2(400, 300);
        }

        void OnEnable()
        {
            userFolder = BoxoUtils.GetUserFolder();

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Assets Manager";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        void OnGUI()
        {
            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false);

            SetGUIStyles();

            GUI_HALF_EDITOR_WIDTH = (this.position.width / 2.0f - 24) - 5;
            GUI_FULL_EDITOR_WIDTH = this.position.width - 40;

            GUILayout.Space(10);
            TVEUtils.DrawToolbar(0, -1);
            StyledGUI.DrawWindowBanner(bannerColor, bannerLabel, bannerVersion);

            GUILayout.BeginHorizontal();
            GUILayout.Space(10);
            GUILayout.BeginVertical();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Selection Mode", GUILayout.Width(GUI_HALF_EDITOR_WIDTH));
            selectionIndex = EditorGUILayout.Popup(selectionIndex, SeletionEnum, stylePopup);
            GUILayout.EndHorizontal();

            GUILayout.Space(10);
            StyledGUI.DrawWindowCategory("Processing Settings");
            GUILayout.Space(10);

            if (GUILayout.Button("Validate TVE Materials", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Material));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    TVEUtils.ValidateMaterial(assetPath, false);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " materials have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Validate TVE Elements", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Material));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    TVEUtils.ValidateMaterial(assetPath, false);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " elements have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            GUILayout.Space(10);

            if (GUILayout.Button("Log Material Keywords", GUILayout.Height(24)))
            {
                var logFolder = userFolder + "/Shader Keyword Log";

                Directory.CreateDirectory(logFolder);

                List<Material> allMaterials = new List<Material>();
                List<Shader> allShaders = new List<Shader>();

                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Material));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var material = AssetDatabase.LoadAssetAtPath<Material>(assetPath);

                    if (assetPath.Contains("Packages"))
                    {
                        continue;
                    }

                    if (material == null)
                    {
                        continue;
                    }

                    //if (material.HasProperty("_IsTVEShader"))
                    //{
                    //    allMaterials.Add(material);
                    //}
                    var shaderName = material.shader.name;
                    var isValidShader = !shaderName.Contains("CustomRT") && !shaderName.Contains("Element") && !shaderName.Contains("Helper") && !shaderName.Contains("Legacy");

                    if (!isValidShader)
                    {
                        continue;
                    }

                    allMaterials.Add(material);

                    if (!allShaders.Contains(material.shader))
                    {
                        allShaders.Add(material.shader);
                    }

                    //var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    //EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                for (int s = 0; s < allShaders.Count; s++)
                {
                    var currentShader = allShaders[s];

                    List<Material> materialsPerShader = new List<Material>();
                    List<string> keywordsPerShader = new List<string>();
                    List<string> keywordTypesPerShader = new List<string>();
                    List<int> keywordsUsagePerShader = new List<int>();

                    for (int m = 0; m < allMaterials.Count; m++)
                    {
                        var tveMaterial = allMaterials[m];

                        if (tveMaterial.shader == currentShader)
                        {
                            materialsPerShader.Add(tveMaterial);
                        }
                    }

                    if (materialsPerShader.Count == 0)
                    {
                        continue;
                    }

                    for (int m = 0; m < materialsPerShader.Count; m++)
                    {
                        var material = materialsPerShader[m];

                        var shaderKeywords = material.shader.keywordSpace.keywords;

                        for (int k = 0; k < shaderKeywords.Length; k++)
                        {
                            var shaderKeyword = shaderKeywords[k];

                            var shaderKeywordType = "undefined";

                            if (shaderKeyword.isDynamic)
                            {
                                shaderKeywordType = "dynamic_branch";
                            }
                            else
                            {
                                if (shaderKeyword.isOverridable)
                                {
                                    shaderKeywordType = "multi_compile";
                                }
                                else
                                {
                                    shaderKeywordType = "shader_feature";
                                }
                            }

                            if (!keywordsPerShader.Contains(shaderKeyword.name))
                            {
                                keywordsPerShader.Add(shaderKeyword.name);
                                keywordTypesPerShader.Add(shaderKeywordType);
                            }
                        }
                    }

                    StreamWriter writer = new StreamWriter(logFolder + "/" + Path.GetFileName(currentShader.name) + ".txt");

                    writer.WriteLine("Active keywords in all selected materials using this shader:");

                    for (int i = 0; i < keywordsPerShader.Count; i++)
                    {
                        var foundKeywords = 0;
                        var shaderKeyword = keywordsPerShader[i];
                        var shaderKeywordType = keywordTypesPerShader[i];

                        for (int m = 0; m < materialsPerShader.Count; m++)
                        {
                            var material = materialsPerShader[m];
                            var materialKeywords = material.enabledKeywords;

                            for (int k = 0; k < materialKeywords.Length; k++)
                            {
                                var materialKeyword = materialKeywords[k];

                                if (shaderKeyword.Contains(materialKeyword.name))
                                {
                                    foundKeywords++;
                                }
                            }
                        }

                        keywordsUsagePerShader.Add(foundKeywords);

                        var padding = 40;

                        if (shaderKeywordType == "dynamic_branch")
                        {
                            writer.WriteLine(shaderKeyword.PadRight(padding) + " dynamic_branch");
                        }

                        if (shaderKeywordType == "multi_compile")
                        {
                            writer.WriteLine(shaderKeyword.PadRight(padding) + " multi_compile");
                        }

                        if (shaderKeywordType == "shader_feature")
                        {
                            writer.WriteLine(shaderKeyword.PadRight(padding) + " found in " + foundKeywords + "/" + materialsPerShader.Count + " materials");
                        }
                    }

                    writer.WriteLine("");
                    writer.WriteLine("Unused keywords in all selected materials using this shader:");

                    for (int i = 0; i < keywordsPerShader.Count; i++)
                    {
                        if (keywordTypesPerShader[i] == "shader_feature" && keywordsUsagePerShader[i] == 0)
                        {
                            writer.WriteLine(keywordsPerShader[i]);
                        }
                    }

                    //int multiCompileCount = 0;
                    //int shaderFeatureCount = 0;
                    //int dynamicBranchCount = 0;

                    //for (int i = 0; i < keywordsPerShader.Count; i++)
                    //{
                    //    string type = keywordTypesPerShader[i];
                    //    int usage = keywordsUsagePerShader[i];

                    //    switch (type)
                    //    {
                    //        case "multi_compile":
                    //            multiCompileCount++;
                    //            break;

                    //        case "shader_feature":
                    //            if (usage > 0) // at least one material uses it
                    //                shaderFeatureCount++;
                    //            break;

                    //        case "dynamic_branch":
                    //            dynamicBranchCount++;
                    //            break;
                    //    }
                    //}

                    //double multiCompileVariants = Mathf.Pow(2, multiCompileCount);
                    //double shaderFeatureVariants = Mathf.Pow(2, shaderFeatureCount);
                    //double combinedVariants = Mathf.Pow(2, multiCompileCount + shaderFeatureCount);

                    //writer.WriteLine("");
                    //writer.WriteLine("Potential variants in all selected materials in this shader:");

                    //writer.WriteLine("multi_compile variants before stripping: " + multiCompileVariants);
                    //writer.WriteLine("shader_feature variants (used only): " + shaderFeatureVariants);
                    //writer.WriteLine("combined variants before stripping: " + combinedVariants);

                    for (int m = 0; m < materialsPerShader.Count; m++)
                    {
                        var material = materialsPerShader[m];
                        var materialKeywords = material.enabledKeywords;

                        writer.WriteLine("");
                        writer.WriteLine("Active keywords in " + AssetDatabase.GetAssetPath(material));

                        for (int k = 0; k < materialKeywords.Length; k++)
                        {
                            var materialKeyword = materialKeywords[k];

                            writer.WriteLine(materialKeyword);
                        }
                    }

                    writer.Close();
                }

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(logFolder + "/" + Path.GetFileName(allShaders[0].name) + ".txt"));
            }

            GUILayout.Space(10);

            if (GUILayout.Button("Mark Model As Readable", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    string fileText = File.ReadAllText(assetPath);
                    fileText = fileText.Replace("m_IsReadable: 0", "m_IsReadable: 1");
                    File.WriteAllText(assetPath, fileText);

                    //Not working for some reasons
                    //var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    //var meshInstance = Instantiate(meshOriginal);
                    //meshInstance.name = meshOriginal.name;

                    //meshInstance.UploadMeshData(false);
                    //meshOriginal.Clear();

                    //EditorUtility.CopySerialized(meshInstance, meshOriginal);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Mark Model As Non Readable", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    string fileText = File.ReadAllText(assetPath);
                    fileText = fileText.Replace("m_IsReadable: 1", "m_IsReadable: 0");
                    File.WriteAllText(assetPath, fileText);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Recalcuate Mesh Normals", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var meshInstance = Instantiate(meshOriginal);
                    meshInstance.name = meshOriginal.name;

                    meshInstance.RecalculateNormals();
                    meshOriginal.Clear();

                    EditorUtility.CopySerialized(meshInstance, meshOriginal);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Recalcuate Mesh Tangents", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var meshInstance = Instantiate(meshOriginal);
                    meshInstance.name = meshOriginal.name;

                    meshInstance.RecalculateTangents();
                    meshOriginal.Clear();

                    EditorUtility.CopySerialized(meshInstance, meshOriginal);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Generate Lightmap UV", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var meshInstance = Instantiate(meshOriginal);
                    meshInstance.name = meshOriginal.name;
#if UNITY_2022_3_OR_NEWER
                    if (Unwrapping.GenerateSecondaryUVSet(meshInstance))
                    {
#else
                    Unwrapping.GenerateSecondaryUVSet(meshInstance);
#endif
                        meshOriginal.Clear();

                        EditorUtility.CopySerialized(meshInstance, meshOriginal);
#if UNITY_2022_3_OR_NEWER
                    }
                    else
                    {
                        Debug.Log("<b>[The Visual Engine]</b> " + "Lightmap UV cannot be generated for " + meshOriginal.name);
                    }
#endif

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Generate Random Variation", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var meshInstance = Instantiate(meshOriginal);
                    meshInstance.name = meshOriginal.name;

                    GenerateRandomVariation(meshInstance);

                    meshOriginal.Clear();

                    EditorUtility.CopySerialized(meshInstance, meshOriginal);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Set Mesh Bounds Multiplier", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var meshInstance = Instantiate(meshOriginal);
                    meshInstance.name = meshOriginal.name;

                    var meshBounds = meshInstance.bounds;

                    Bounds bounds = new Bounds();
                    Vector3 min = new Vector3(meshBounds.min.x * boundsMultiplier.x, meshBounds.min.y * boundsMultiplier.y, meshBounds.min.z * boundsMultiplier.z);
                    Vector3 max = new Vector3(meshBounds.max.x * boundsMultiplier.x, meshBounds.max.y * boundsMultiplier.y, meshBounds.max.z * boundsMultiplier.z);
                    bounds.SetMinMax(min, max);

                    meshInstance.bounds = bounds;
                    meshOriginal.Clear();

                    EditorUtility.CopySerialized(meshInstance, meshOriginal);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            boundsMultiplier = EditorGUILayout.Vector3Field(new GUIContent(""), boundsMultiplier);

#if UNITY_6000_2_OR_NEWER
            if (GUILayout.Button(new GUIContent("Set MeshLOD Limit", "The maximum number of LOD levels to generate. If the value is 0, the method does not generate any extra LOD levels in addition to the original mesh. If the value is negative, the generation process stops when the next Mesh LOD level has around 64 indices."), GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Model", "*.asset");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var meshOriginal = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var meshInstance = Instantiate(meshOriginal);
                    meshInstance.name = meshOriginal.name;

                    MeshLodUtility.GenerateMeshLods(meshInstance, meshLODLimit);

                    meshOriginal.Clear();

                    EditorUtility.CopySerialized(meshInstance, meshOriginal);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            meshLODLimit = EditorGUILayout.IntField(new GUIContent(""), meshLODLimit);
#endif

            GUILayout.Space(10);

            if (GUILayout.Button("Delete Backup Prefabs", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Backup", "*.prefab");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    FileUtil.DeleteFileOrDirectory(assetPath);
                    FileUtil.DeleteFileOrDirectory(assetPath + ".meta");

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " backups have been deleted.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Delete Prefab Component", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", "*.prefab");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var prefabObject = AssetDatabase.LoadAssetAtPath<GameObject>(assetPath);

                    if (prefabObject.GetComponent<TVEPrefab>() != null)
                    {
                        var prefabInstance = Instantiate(prefabObject);

                        DestroyImmediate(prefabInstance.GetComponent<TVEPrefab>(), true);

                        PrefabUtility.SaveAsPrefabAssetAndConnect(prefabInstance, assetPath, InteractionMode.AutomatedAction);

                        var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                        EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                    }
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " prefabs have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Delete Converted Assets", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Model", "*.asset");
                GetAssetsPaths("TVE Material", "*.mat");
                GetAssetsPaths("TVE Texture", "*.png");
                GetAssetsPaths("TVE Texture", "*.tga");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    FileUtil.DeleteFileOrDirectory(assetPath);
                    FileUtil.DeleteFileOrDirectory(assetPath + ".meta");

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " assets have been deleted.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            GUILayout.Space(10);

            if (GUILayout.Button("Cleanup All Name GUID", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Model", "*.asset");
                GetAssetsPaths("TVE Material", "*.mat");
                GetAssetsPaths("TVE Texture", "*.png");
                GetAssetsPaths("TVE Texture", "*.tga");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var pathData = TVEUtils.GetPathData(assetPath);

                    AssetDatabase.RenameAsset(assetPath, pathData.name + " (TVE " + pathData.type + ")");

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " assets have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Cleanup Model Name GUID", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Model", "*.asset");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];
                    var mesh = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    var pathData = TVEUtils.GetPathData(assetPath);

                    mesh.name = pathData.name + " (TVE Model)";

                    AssetDatabase.RenameAsset(assetPath, mesh.name);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " meshes have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Cleanup Material Name GUID", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Material", "*.mat");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];
                    var material = AssetDatabase.LoadAssetAtPath<Material>(assetPath);

                    var pathData = TVEUtils.GetPathData(assetPath);

                    material.name = pathData.name + " (TVE Material)";

                    AssetDatabase.RenameAsset(assetPath, material.name);

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " materials have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Cleanup Texture Name GUID", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("TVE Texture", "*.png");
                GetAssetsPaths("TVE Texture", "*.tga");

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var pathData = TVEUtils.GetPathData(assetPath);

                    AssetDatabase.RenameAsset(assetPath, pathData.name + " (TVE Texture)");

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " textures have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            GUILayout.Space(10);

            if (GUILayout.Button("Fix Missing Shaders", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Material));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    var material = AssetDatabase.LoadAssetAtPath<Material>(assetPath);

                    if (material.shader == null || material.shader.name.Contains("Error"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit");

                        if (material.HasProperty("_SubsurfaceIntensity") && material.GetFloat("_SubsurfaceIntensity") > 0)
                        {
                            material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Subsurface Lit");
                        }
                    }

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " materials have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (GUILayout.Button("Fix Legacy Extra UV", GUILayout.Height(24)))
            {
                allAssetsPaths = new List<string>();

                GetAssetsPaths("", typeof(Mesh));

                for (int i = 0; i < allAssetsPaths.Count; i++)
                {
                    var assetPath = allAssetsPaths[i];

                    if (Path.GetFullPath(assetPath).Length > 256)
                    {
                        Debug.Log("<b>[The Visual Engine]</b> " + assetPath + " could not be upgraded because the file path is too long! To fix the issue, rename the folders and file names, then go to Hub > Show Advanced Settings > Validate All Project Meshes to re-process the meshes!");
                        return;
                    }

                    var mesh = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);

                    if (mesh == null)
                    {
                        Debug.Log("<b>[The Visual Engine]</b> " + assetPath + " could not be upgraded because the mesh is null!");
                        return;
                    }

                    var meshName = mesh.name;

                    var instanceMesh = UnityEngine.Object.Instantiate(mesh);
                    instanceMesh.name = meshName;

                    if (instanceMesh == null)
                    {
                        Debug.Log("<b>[The Visual Engine]</b> " + assetPath + " could not be upgraded because the mesh is null!");
                        continue;
                    }

                    var vertexCount = mesh.vertexCount;
                    var UV2 = new List<Vector4>(vertexCount);
                    var newUV3 = new List<Vector2>(vertexCount);

                    mesh.GetUVs(1, UV2);

                    if (UV2.Count != 0)
                    {
                        for (int v = 0; v < vertexCount; v++)
                        {
                            newUV3.Add(new Vector2(UV2[v].z, UV2[v].w));
                        }
                    }

                    instanceMesh.SetUVs(2, newUV3);

                    instanceMesh.SetUVs(2, newUV3);

                    mesh.Clear();

                    EditorUtility.CopySerialized(instanceMesh, mesh);
                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();

                    TVEUtils.SetLabel(assetPath);

                    UV2.Clear();
                    newUV3.Clear();

                    var progress = (float)i * 1.0f / (float)allAssetsPaths.Count;
                    EditorUtility.DisplayProgressBar("The Visual Engine", "Processing " + Path.GetFileName(assetPath), progress);
                }

                EditorUtility.ClearProgressBar();

                Debug.Log("<b>[The Visual Engine]</b> " + allAssetsPaths.Count.ToString() + " models have been processed.");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
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
        }

        string[] GetSelectedFolders()
        {
            var selected = Selection.GetFiltered(typeof(UnityEngine.Object), SelectionMode.Assets);
            List<string> folders = new List<string>();

            for (int i = 0; i < selected.Length; i++)
            {
                string path = AssetDatabase.GetAssetPath(selected[i]);

                if (AssetDatabase.IsValidFolder(path))
                {
                    folders.Add(path);
                }
            }

            return folders.ToArray();
        }

        void GetAssetsPaths(string searchPattern, string extension)
        {
            var selectedFolders = GetSelectedFolders();

            if (selectionIndex == 0)
            {
                for (int s = 0; s < selectedFolders.Length; s++)
                {
                    var selection = Directory.GetFiles(selectedFolders[s], extension, SearchOption.AllDirectories);

                    for (int i = 0; i < selection.Length; i++)
                    {
                        if (selection[i].Contains(searchPattern))
                        {
                            allAssetsPaths.Add(selection[i]);
                        }
                    }
                }
            }
            else
            {
                var selection = Selection.objects;

                for (int i = 0; i < selection.Length; i++)
                {
                    var assetPath = AssetDatabase.GetAssetPath(selection[i]);

                    if (assetPath.Contains(searchPattern))
                    {
                        allAssetsPaths.Add(assetPath);
                    }
                }
            }
        }

        void GetAssetsPaths(string searchPattern, System.Type typeOf)
        {
            if (selectionIndex == 0)
            {
                var selectedFolders = GetSelectedFolders();

                for (int s = 0; s < selectedFolders.Length; s++)
                {
                    string filter = "t:" + typeOf.Name;
                    string[] guids = AssetDatabase.FindAssets(filter, selectedFolders);

                    for (int i = 0; i < guids.Length; i++)
                    {
                        string path = AssetDatabase.GUIDToAssetPath(guids[i]);

                        if (!string.IsNullOrEmpty(searchPattern) && !path.Contains(searchPattern))
                            continue;

                        if (!allAssetsPaths.Contains(path))
                            allAssetsPaths.Add(path);

                        // include sub-assets inside .asset containers
                        var subAssets = AssetDatabase.LoadAllAssetsAtPath(path);

                        for (int k = 0; k < subAssets.Length; k++)
                        {
                            var sub = subAssets[k];
                            if (sub == null)
                                continue;

                            if (typeOf.IsAssignableFrom(sub.GetType()))
                            {
                                if (!allAssetsPaths.Contains(path))
                                    allAssetsPaths.Add(path);
                            }
                        }
                    }
                }
            }
            else
            {
                var selection = Selection.objects;

                for (int i = 0; i < selection.Length; i++)
                {
                    var assetPath = AssetDatabase.GetAssetPath(selection[i]);

                    if (string.IsNullOrEmpty(assetPath))
                        continue;

                    if (!string.IsNullOrEmpty(searchPattern) && !assetPath.Contains(searchPattern))
                        continue;

                    var mainAsset = AssetDatabase.LoadMainAssetAtPath(assetPath);

                    if (mainAsset != null && typeOf.IsAssignableFrom(mainAsset.GetType()))
                    {
                        if (!allAssetsPaths.Contains(assetPath))
                            allAssetsPaths.Add(assetPath);
                    }

                    var subAssets = AssetDatabase.LoadAllAssetsAtPath(assetPath);

                    for (int k = 0; k < subAssets.Length; k++)
                    {
                        var sub = subAssets[k];
                        if (sub == null)
                            continue;

                        if (typeOf.IsAssignableFrom(sub.GetType()))
                        {
                            if (!allAssetsPaths.Contains(assetPath))
                                allAssetsPaths.Add(assetPath);
                        }
                    }
                }
            }
        }

        void GenerateRandomVariation(Mesh mesh)
        {
            var vertexCount = mesh.vertexCount;

            var meshChannel = new List<float>(vertexCount);
            var vertexColors = new List<Color>(vertexCount);
            mesh.GetColors(vertexColors);

            var triangles = mesh.triangles;
            var trianglesCount = mesh.triangles.Length;

            for (int i = 0; i < vertexCount; i++)
            {
                meshChannel.Add(-99);
            }

            for (int i = 0; i < trianglesCount; i += 3)
            {
                var index1 = triangles[i + 0];
                var index2 = triangles[i + 1];
                var index3 = triangles[i + 2];

                float variation = 0;

                if (meshChannel[index1] != -99)
                {
                    variation = meshChannel[index1];
                }
                else if (meshChannel[index2] != -99)
                {
                    variation = meshChannel[index2];
                }
                else if (meshChannel[index3] != -99)
                {
                    variation = meshChannel[index3];
                }
                else
                {
                    variation = UnityEngine.Random.Range(0.0f, 1.0f);
                }

                meshChannel[index1] = variation;
                meshChannel[index2] = variation;
                meshChannel[index3] = variation;
            }

            for (int i = 0; i < vertexCount; i++)
            {
                vertexColors[i] = new Color(meshChannel[i], vertexColors[i].g, vertexColors[i].b, vertexColors[i].a);
            }

            mesh.SetColors(vertexColors);
        }
    }
}


