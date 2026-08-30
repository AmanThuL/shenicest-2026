//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.Constants;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;
using System.Globalization;
using System.IO;

namespace TheVisualEngine
{
    public class MaterialGUI : ShaderGUI, ITerrainLayerCustomUI
    {
        bool multiSelection = false;
        bool showInternalProperties = false;
        bool showHiddenProperties = false;
        bool showActiveKeywords = false;
        bool showAdditionalInfo = false;

        bool advancedEnabled = true;

        string[] searchResult;

        List<string> presetLines;
        int presetIndex;
        bool useLine;
        List<bool> useLines;

        TVEUVMode layerUVMode = TVEUVMode.Scale;

        GUIStyle styleButton;

        public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader)
        {
            base.AssignNewShaderToMaterial(material, oldShader, newShader);

            TVEUtils.SetMaterialSettings(material);
        }

        public override void OnClosed(Material material)
        {
            base.OnClosed(material);
        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            //GUILayout.Space(5);
            //TVEUtils.DrawToolbar(-34, -4);

            // TODO store the preset to not search for them
            //if (!presetsFound)
            //{
            //    GetPresets();

            //    presetsFound = true;
            //}

            TVEUtils.GetSettingsPresetsEnum(false);

            var material0 = materialEditor.target as Material;
            var materials = materialEditor.targets;

            if (materials.Length > 1)
                multiSelection = true;

            // Used for impostors only
            if (material0.HasProperty("_IsInitialized"))
            {
                if (material0.GetFloat("_IsInitialized") > 0)
                {
                    DrawDynamicInspector(material0, materialEditor, props);
                }
                else
                {
                    DrawInitInspector(material0);
                }
            }
            else
            {
                DrawDynamicInspector(material0, materialEditor, props);
            }

            foreach (Material material in materials)
            {
                TVEUtils.SetMaterialSettings(material);
            }
        }

        void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
        {
            styleButton = new GUIStyle(GUI.skin.GetStyle("Button"))
            {
                alignment = TextAnchor.MiddleLeft,
            };

            bool showCategory = true;

            TVEUtils.DrawShaderBanner(material);

            GUILayout.Space(5);

            TVEGlobals.searchMaterial = TVEUtils.DrawSearchField(TVEGlobals.searchMaterial, out searchResult, 2);

            TVEUtils.DrawCopyPaste(material, TVEGlobals.searchMaterial, searchResult);

            GUILayout.Space(10);

            presetIndex = EditorGUILayout.Popup("Material Preset", presetIndex, TVEGlobals.settingPresetsEnum);

            if (presetIndex > 0)
            {
                GetPresetLines();
                GetMaterialConversionFromPreset(material);
                presetIndex = 0;

                Debug.Log("<b>[The Visual Engine]</b> " + "The selected preset has been applied!");
            }

            TVEUtils.DrawCopySettingsFromObject(material);

            if (!material.HasProperty("_IsTerrainShader"))
            {
                if (material.HasProperty("_IsStandardShader"))
                {
                    GUILayout.Space(15);
                    EditorGUILayout.HelpBox("Use the Standard Lit shader when simple or no subsurface scattering is needed. Please note, the shader is rendered via both Forward and Deferred paths. Hover over the categories and textures to learn more about the features and texture packing!", MessageType.Info);
                }

                if (material.HasProperty("_IsSubsurfaceShader"))
                {
                    GUILayout.Space(15);
                    EditorGUILayout.HelpBox("Use the Subsurface Lit shader when accurate subsurface scattering is desired. Please note, the shader is always rendered via the Forward path when used in BIRP and URP. Hover over the categories and textures to learn more about the features and texture packing!", MessageType.Info);
                }
            }

            GUILayout.Space(15);

            var customPropsList = new List<MaterialProperty>();

            if (multiSelection)
            {
                for (int i = 0; i < props.Length; i++)
                {
                    var property = props[i];

                    if (BoxoUtils.IsShaderGUIPropertyHidden(property))
                        continue;

                    if (property.name == "unity_Lightmaps")
                        continue;

                    if (property.name == "unity_LightmapsInd")
                        continue;

                    if (property.name == "unity_ShadowMasks")
                        continue;

                    customPropsList.Add(property);
                }
            }
            else
            {
                for (int i = 0; i < props.Length; i++)
                {
                    var property = props[i];
                    var displayName = property.displayName;
                    var internalName = property.name;

                    if (BoxoUtils.IsShaderGUIPropertyHidden(property) && !showHiddenProperties)
                    {
                        continue;
                    }

                    //if (MHUtils.GetPropertyVisibility(material, internalName))
                    //{
                    //    customPropsList.Add(prop);
                    //}

                    bool searchValid = false;

                    foreach (var tag in searchResult)
                    {
                        if (displayName.ToUpper().Contains(tag) || internalName.ToUpper().Contains(tag))
                        {
                            searchValid = true;
                            break;
                        }
                    }

                    if (!searchValid)
                    {
                        continue;
                    }

                    if (internalName.Contains("Category"))
                    {
                        customPropsList.Add(property);

                        if (material.GetInt(internalName) == 0)
                        {
                            showCategory = false;
                        }
                        else
                        {
                            showCategory = true;
                        }
                    }
                    else
                    {
                        if (showCategory)
                        {
                            if (TVEUtils.GetPropertyVisibility(material, internalName))
                            {
                                customPropsList.Add(property);
                            }
                        }
                    }
                }
            }

            for (int i = 0; i < customPropsList.Count; i++)
            {
                var property = customPropsList[i];
                var internalName = property.name;
                var displayName = TVEUtils.GetPropertyDisplay(material, property.name, property.displayName);

                if (showInternalProperties)
                {
                    bool isSpecialProp = internalName.Contains("Category") || internalName.Contains("End") || internalName.Contains("Space") || internalName.Contains("Info") || internalName.Contains("Message");

                    if (isSpecialProp)
                    {
                        DrawDefaultProperty(materialEditor, property, internalName, displayName);
                    }
                    else
                    {
                        DrawInternalProperty(materialEditor, property, internalName, displayName);
                    }
                }
                else
                {
                    DrawDefaultProperty(materialEditor, property, internalName, displayName);
                }

                //TVEUtils.GetActiveDisplay(material, internalName, "_LayerCategory", "_SecondIntensityValue", "79D0FF", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_DetailCategory", "_ThirdIntensityValue", "8FFF79", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_TerrainCategory", "_TerrainIntensityValue", "FFAF5A", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_OcclusionCategory", "_OcclusionIntensityValue", "60E87F", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_GradientCategory", "_GradientIntensityValue", "FFBC5B", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_VariationCategory", "_VariationIntensityValue", "FF79CC", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_TintingCategory", "_TintingIntensityValue", "FF8971", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_DrynessCategory", "_DrynessIntensityValue", "FFBE71", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_OverlayCategory", "_OverlayIntensityValue", "98C8FF", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_WetnessCategory", "_WetnessIntensityValue", "72FBD4", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_CutoutCategory", "_CutoutIntensityValue", "D2D2D2", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_DitherCategory", new string[] { "_DitherConstantValue", "_DitherDistanceValue", "_DitherProximityValue", "_DitherGlancingValue" }, "D2D2D2", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_GlancingCategory", "_GlancingIntensityValue", "D2D2D2", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_EmissiveCategory", "_EmissiveIntensityValue", "FFF700", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_SubsurfaceCategory", "_SubsurfaceIntensityValue", "CFFF75", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_PerspectiveCategory", "_PerspectiveIntensityValue", "CD75FF", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_SizeFadeCategory", "_SizeFadeIntensityValue", "9FA2FF", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_HeightCategory", "_HeightIntensityValue", "9FA2FF", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_ConformCategory", new string[] { "_ConformHeightValue", "_ConformNormalValue" }, "FFF300", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_MotionCategory", "_MotionIntensityValue", "7FFF79", subTitleStyle);
                //TVEUtils.GetActiveDisplay(material, internalName, "_NormalCategory", new string[] { "_NormalFlattenValue", "_NormalSphereValue", "_NormalComputeValue", "_NormalBlanketValue" }, "9393FF", subTitleStyle);
            }

            //GUILayout.Space(10);

            advancedEnabled = StyledGUI.DrawInspectorCategory("Advanced Settings", advancedEnabled, true, 0, 0);

            if (advancedEnabled)
            {
                //if (!material.shader.name.Contains("Terrain"))
                {
                    GUILayout.Space(10);

                    materialEditor.EnableInstancingField();
                }

                if (material.shader.name.Contains("Geometry"))
                {
                    GUILayout.Space(10);

                    TVEUtils.DrawRenderQueue(material, materialEditor);
                    TVEUtils.DrawBakeGIMode(material);
                }

                //GUILayout.Space(10);

                //TVEUtils.DrawStripUnusedTextures(material);

                GUILayout.Space(10);

                showInternalProperties = EditorGUILayout.Toggle("Show Internal Properties", showInternalProperties);
                showHiddenProperties = EditorGUILayout.Toggle("Show Hidden Properties", showHiddenProperties);
                showActiveKeywords = EditorGUILayout.Toggle("Show Active Keywords", showActiveKeywords);
                showAdditionalInfo = EditorGUILayout.Toggle("Show Additional Info", showAdditionalInfo);

                if (showActiveKeywords)
                {
                    TVEUtils.DrawActiveKeywords(material);
                }

                if (showAdditionalInfo)
                {
                    TVEUtils.DrawTechnicalDetails(material);
                }
            }

            GUILayout.Space(15);

            TVEUtils.DrawPoweredBy();
        }

        void DrawInitInspector(Material material)
        {
            TVEUtils.DrawShaderBanner(material);

            GUILayout.Space(5);

            EditorGUILayout.HelpBox("The original material properties are not copied to the Impostor material. Drag the game object the impostor is baked from to the field below to copy the properties!", MessageType.Error, true);

            GUILayout.Space(10);

            TVEUtils.DrawCopySettingsFromObject(material);

            GUILayout.Space(10);
        }

        void DrawDefaultProperty(MaterialEditor materialEditor, MaterialProperty property, string internalName, string displayName)
        {
            if (internalName == "_Albedo" || internalName == "_Normals")
            {
                materialEditor.TexturePropertySingleLine(new GUIContent(displayName, ""), property);
            }
            else
            {
                materialEditor.ShaderProperty(property, displayName);
            }
        }

        void DrawInternalProperty(MaterialEditor materialEditor, MaterialProperty property, string internalName, string displayName)
        {
            GUILayout.BeginHorizontal();

            materialEditor.DefaultShaderProperty(property, displayName + "  ( " + internalName + " )");

            GUILayout.Space(2);

            if (GUILayout.Button("C", styleButton, GUILayout.Width(20), GUILayout.Height(18)))
            {
                GUIUtility.systemCopyBuffer = internalName;
            }

            if (GUILayout.Button("S", styleButton, GUILayout.Width(20), GUILayout.Height(18)))
            {
                if (BoxoUtils.IsShaderGUIPropertyTexture(property))
                {
                    GUIUtility.systemCopyBuffer = "Material SET_TEX " + internalName + " XXX";
                }

                if (BoxoUtils.IsShaderGUIPropertyFloat(property))
                {
                    GUIUtility.systemCopyBuffer = "Material SET_FLOAT " + internalName + " 0";
                }

                if (BoxoUtils.IsShaderGUIPropertyVector(property))
                {
                    GUIUtility.systemCopyBuffer = "Material SET_VECTOR " + internalName + " 0 0 0 0";
                }
            }

            if (GUILayout.Button("T", styleButton, GUILayout.Width(20), GUILayout.Height(18)))
            {
                if (BoxoUtils.IsShaderGUIPropertyTexture(property))
                {
                    GUIUtility.systemCopyBuffer = "Material COPY_TEX XXX " + internalName;
                }

                if (BoxoUtils.IsShaderGUIPropertyFloat(property))
                {
                    GUIUtility.systemCopyBuffer = "Material COPY_FLOAT XXX " + internalName;
                }

                if (BoxoUtils.IsShaderGUIPropertyVector(property))
                {
                    GUIUtility.systemCopyBuffer = "Material COPY_VECTOR XXX " + internalName;
                }
            }

            GUILayout.EndHorizontal();
        }

        void GetPresetLines()
        {
            StreamReader reader = new StreamReader(TVEGlobals.settingPresetPaths[presetIndex]);

            presetLines = new List<string>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine().TrimStart();

                presetLines.Add(line);
            }

            reader.Close();
        }

        void GetMaterialConversionFromPreset(Material material)
        {
            useLines = new List<bool>();
            useLines.Add(true);

            for (int i = 0; i < presetLines.Count; i++)
            {
                useLine = GetConditionFromLine(presetLines[i], material);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Material"))
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

                        if (type == "SET_FLOAT")
                        {
                            material.SetFloat(set, float.Parse(x, CultureInfo.InvariantCulture));
                        }
                        else if (type == "SET_COLOR")
                        {
                            material.SetColor(set, new Color(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "SET_VECTOR")
                        {
                            material.SetVector(set, new Vector4(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "SET_TEX")
                        {
                            val = val.Replace("__", " ");

                            material.SetTexture(set, Resources.Load<Texture>(val));
                        }
                        else if (type == "SET_TEX_BY_PATH")
                        {
                            val = val.Replace("__", " ");

                            material.SetTexture(set, AssetDatabase.LoadAssetAtPath<Texture>(val));
                        }
                        else if (type == "SET_TEX_BY_GUID")
                        {
                            var path = AssetDatabase.GUIDToAssetPath(val);
                            
                            material.SetTexture(set, AssetDatabase.LoadAssetAtPath<Texture>(path));
                        }
                        else if (type == "COPY_FLOAT")
                        {
                            if (material.HasFloat(src))
                            {
                                var value = material.GetFloat(src);
                                value = SetFloatActions(presetLines[i], value);

                                material.SetFloat(dst, value);
                            }
                        }
                        else if (type == "COPY_TEX")
                        {
                            if (material.HasTexture(src))
                            {
                                material.SetTexture(dst, material.GetTexture(src));
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

                                material.SetVector(dst, value);
                            }
                        }
                        else if (type == "ENABLE_INSTANCING")
                        {
                            material.enableInstancing = true;
                        }
                        else if (type == "DISABLE_INSTANCING")
                        {
                            material.enableInstancing = false;
                        }
                        else if (type == "SET_SHADER_BY_NAME")
                        {
                            var shader = presetLines[i].Replace("Material SET_SHADER_BY_NAME ", "");

                            if (Shader.Find(shader) != null)
                            {
                                material.shader = Shader.Find(shader);
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
                    }

                    if (presetLines[i].StartsWith("Utility"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";

                        if (splitLine.Length > 1)
                        {
                            type = splitLine[1];
                        }

                        if (type == "STRIP_UNUSED_TEXTURES")
                        {
                            TVEUtils.StripUnusedTextures(material);
                        }
                    }
                }
            }
        }

        bool GetConditionFromLine(string line, Material material)
        {
            var valid = true;

            if (line.StartsWith("if"))
            {
                valid = false;

                string[] splitLine = line.Split(char.Parse(" "));

                var type = "";
                var check = "";
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
                    }

                    check = check.TrimEnd();
                }

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
                else if (type.Contains("MATERIAL_NAME_CONTAINS"))
                {
                    var name = material.name.ToUpperInvariant();

                    if (name.Contains(check.ToUpperInvariant()))
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
                    if (material.name.Contains(check))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_PIPELINE_IS_STANDARD"))
                {
                    if (material.GetTag("RenderPipeline", false) == "")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_PIPELINE_IS_UNIVERSAL"))
                {
                    if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_PIPELINE_IS_HD"))
                {
                    if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
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
                else if (type.Contains("MATERIAL_FLOAT_EQUALS"))
                {
                    var min = float.Parse(val, CultureInfo.InvariantCulture) - 0.1f;
                    var max = float.Parse(val, CultureInfo.InvariantCulture) + 0.1f;

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
                else if (type.Contains("MATERIAL_KEYWORD_ENABLED"))
                {
                    if (material.IsKeywordEnabled(check))
                    {
                        valid = true;
                    }
                }

                useLines.Add(valid);
            }

            if (line.StartsWith("if") && line.Contains("!"))
            {
                valid = !valid;
                useLines[useLines.Count - 1] = valid;
            }

            if (line.StartsWith("endif") || line.StartsWith("}"))
            {
                useLines.RemoveAt(useLines.Count - 1);
            }

            var useLine = true;

            for (int i = 1; i < useLines.Count; i++)
            {
                if (useLines[i] == false)
                {
                    useLine = false;
                    break;
                }
            }

            return useLine;
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

        bool ITerrainLayerCustomUI.OnTerrainLayerGUI(TerrainLayer terrainLayer, Terrain terrain)
        {
            TVEUtils.DrawTerrainLayer(terrainLayer, layerUVMode);

            return true;
        }
    }
}

