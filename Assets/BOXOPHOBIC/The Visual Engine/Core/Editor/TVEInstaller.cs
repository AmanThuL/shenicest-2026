#if !BOXOPHOBIC_DEVELOPMENT
#if !THE_VISUAL_ENGINE_NOINSTALL

using UnityEngine;
using UnityEditor;
using System.IO;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    [InitializeOnLoad]
    public class TVEInstaller
    {
        static TVEInstaller()
        {
            EditorApplication.update += OnInit;
        }

        static void OnInit()
        {
            EditorApplication.update -= OnInit;

            var installer = AssetDatabase.GUIDToAssetPath("ecbf0283237e69b479df3949d3f5ab4a");

            if (!File.Exists(installer))
	        {
                return;
	        }

            var symbol = "THE_VISUAL_ENGINE";
            var version = AssetDatabase.GUIDToAssetPath("205459a1a763d614b80e362dbbc05b68");

            var assetFolder = TVEUtils.GetAssetFolder();
            var userFolder = BoxoUtils.GetUserFolder();
            var userVersion = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Version.asset", "0");

            var assetVersion = SettingsUtils.LoadSettingsData(version, 0);

            var projectData = TVEUtils.GetProjectData();

            if (projectData.pipeline != "Standard")
            {
                if (projectData.isSupported)
                {
                    if (projectData.isTechRelease)
                    {
                        var message = "The current Unity version is not officially supported with the " + projectData.pipeline + " Render Pipeline! The Visual Engine only supports LTS releases!";

                        EditorUtility.DisplayDialog("The Visual Engine", message, "Got It!");
                    }

                    var pipelinePackagePath = assetFolder + "/Core/Pipelines/" + projectData.pipeline + " " + projectData.package + ".unitypackage";

                    if (File.Exists(pipelinePackagePath))
                    {
                        AssetDatabase.ImportPackage(pipelinePackagePath, false);
                        AssetDatabase.SaveAssets();
                        AssetDatabase.Refresh();

                        EditorApplication.ExecuteMenuItem("Window/BOXOPHOBIC/The Visual Engine/Material Upgrader");

                        Debug.Log("<b>[The Visual Engine]</b> " + projectData.pipeline + " Render Pipeline " + projectData.package + " support is imported for The Visual Engine!");
                    }
                    else
                    {
                        Debug.Log("<b>[The Visual Engine]</b> " + projectData.pipeline + " Render Pipeline " + projectData.package + " package cannot be found! Make sure to re-import the asset and keep the .unitypackage files!");
                    }
                }
                else
                {
                    var message = "The current Unity version is not supported! The Visual Engine only supports " + projectData.minimum + " or higher with the " + projectData.pipeline + " Render Pipeline!";
                        
                    EditorUtility.DisplayDialog("The Visual Engine", message, "Got It!");
                    Debug.Log("<b>[The Visual Engine]</b> " + message);
                }
            }
            else
            {
                Debug.Log("<b>[The Visual Engine]</b> " + projectData.pipeline + " Render Pipeline support is imported for The Visual Engine!");

                EditorApplication.ExecuteMenuItem("Window/BOXOPHOBIC/The Visual Engine/Material Upgrader");
            }

            SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Version.asset", assetVersion.ToString() + ";" + userVersion);
            SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Pipeline.asset", projectData.pipeline);

            //BoxoUtils.RemoveDefineSymbols(new string[] { "THE_VISUAL_ENGINE_V21", "THE_VISUAL_ENGINE_V22", "THE_VISUAL_ENGINE_STANDARD", "THE_VISUAL_ENGINE_UNIVERSAL", "THE_VISUAL_ENGINE_HD", "THE_VISUAL_ENGINE_IMPOSTORS", "THE_VISUAL_ENGINE_BLANKET", "THE_VISUAL_ENGINE_TERRAIN", "THE_VISUAL_ENGINE_AMPLIFY_IMPOSTORS", "THE_VISUAL_ENGINE_TERRAIN_BLANKET", "THE_VISUAL_ENGINE_TERRAIN_SHADERS", "THE_VISUAL_ENGINE_MOBILE_SHADERS" });

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            TVEUtils.SetVertexCompression();
            TVEUtils.SetScriptExecutionOrder();

            BoxoUtils.SetDefineSymbol(symbol + "_V22");

            if (projectData.pipeline == "Standard")
            {
                BoxoUtils.SetDefineSymbol(symbol + "_STANDARD");
            }

            if (projectData.pipeline == "Universal")
            {
                BoxoUtils.SetDefineSymbol(symbol + "_UNIVERSAL");
            }

            if (projectData.pipeline == "High Definition")
            {
                BoxoUtils.SetDefineSymbol(symbol + "_HD");
            }

            AssetDatabase.DeleteAsset(installer);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }
    }
}
#endif
#endif


