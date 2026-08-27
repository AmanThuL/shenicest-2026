using Boxophobic.Utility;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace TheVisualEngine
{
    class TVEPostProcessor : AssetPostprocessor
    {
        static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
        {
            TVEEvents.InvokeAssetsSaved();

#if !THE_VISUAL_ENGINE_NOPROCESSING && !BOXOPHOBIC_DEVELOPMENT
            foreach (var path in importedAssets)
            {

                if (path.EndsWith(".shader"))
                {
                    if (TVEUtils.IsValidShader(path))
                    {
                        string userFolder = BoxoUtils.GetUserFolder();

                        var shader = AssetDatabase.LoadAssetAtPath<Shader>(path);
                        var engine = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Shaders/Engine " + shader.name.Replace("/", "__") + ".asset", "Unity Default Renderer");
                        var model = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Shaders/Model " + shader.name.Replace("/", "__") + ".asset", "From Shader");

                        var shaderSettings = new TVEShaderSettings();
                        shaderSettings.renderEngine = engine;
                        shaderSettings.shaderModel = model;

                        TVEUtils.SetShaderSettings(path, shaderSettings);

                        AssetDatabase.SaveAssets();
                        AssetDatabase.Refresh();
                    }
                }

                if (path.EndsWith(".mat"))
                {
                    var name = Path.GetFileNameWithoutExtension(path);

                    if (TVEUtils.HasLabel(path) || name.Contains("_Impostor"))
                    {
                        var material = AssetDatabase.LoadAssetAtPath<Material>(path);

                        TVEUtils.SetMaterialSettings(material);
                    }
                }

                if (path.EndsWith(".tvecollection"))
                {
                    EditorApplication.ExecuteMenuItem("Window/BOXOPHOBIC/The Visual Engine/Collection Manager");
                }
            }
#endif

            //foreach (var path in deletedAssets)
            //{
            //    if (path.Contains("TVEManager"))
            //    {
            //        BoxoUtils.RemoveDefineSymbols(new string[] { "THE_VISUAL_ENGINE_V21", "THE_VISUAL_ENGINE_V22", "THE_VISUAL_ENGINE_STANDARD", "THE_VISUAL_ENGINE_UNIVERSAL", "THE_VISUAL_ENGINE_HD", "THE_VISUAL_ENGINE_IMPOSTORS", "THE_VISUAL_ENGINE_BLANKET", "THE_VISUAL_ENGINE_TERRAIN", "THE_VISUAL_ENGINE_AMPLIFY_IMPOSTORS", "THE_VISUAL_ENGINE_TERRAIN_BLANKET", "THE_VISUAL_ENGINE_TERRAIN_SHADERS", "THE_VISUAL_ENGINE_MOBILE_SHADERS" });

            //        AssetDatabase.SaveAssets();
            //        AssetDatabase.Refresh();
            //    }
            //}
        }
    }
}

