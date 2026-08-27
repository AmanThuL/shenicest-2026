//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;

namespace TheVisualEngine
{
    public class ElementGUI : ShaderGUI
    {
        bool multiSelection = false;
        bool showInternalProperties = false;
        bool showHiddenProperties = false;
        bool showAdditionalInfo = false;

        string[] searchResult;

        bool advancedEnabled = true;

        GUIStyle styleButton;

        public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader)
        {
            base.AssignNewShaderToMaterial(material, oldShader, newShader);

            AssignDefaultSettings(material, newShader);

            TVEUtils.SetElementSettings(material);
        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            //GUILayout.Space(5);
            //TVEUtils.DrawToolbar(-34, -4);

            var material0 = materialEditor.target as Material;
            var materials = materialEditor.targets;

            if (materials.Length > 1)
                multiSelection = true;

            DrawDynamicInspector(material0, materialEditor, props);

            foreach (Material material in materials)
            {
                TVEUtils.SetElementSettings(material);
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

            TVEGlobals.searchElement = TVEUtils.DrawSearchField(TVEGlobals.searchElement, out searchResult, 2);

            TVEUtils.DrawCopyPaste(material, TVEGlobals.searchElement, searchResult);

            GUILayout.Space(10);

            TVEUtils.DrawCopySettingsFromObject(material);

            GUILayout.Space(15);
            //GUILayout.Space(5);

            var customPropsList = new List<MaterialProperty>();

            if (multiSelection)
            {
                for (int i = 0; i < props.Length; i++)
                {
                    var property = props[i];

                    if (BoxoUtils.IsShaderGUIPropertyHidden(property) && !showHiddenProperties)
                    {
                        continue;
                    }

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

                        if (material.GetInt(property.name) == 0)
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
                            if (material.HasProperty("_ElementMode"))
                            {
                                if (material.GetInt("_ElementMode") == 1 && property.name == "_MainColor")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalColor1")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalColor2")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalColor3")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalColor4")
                                    continue;

                                if (material.GetInt("_ElementMode") == 1 && property.name == "_MainValue")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalValue1")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalValue2")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalValue3")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_AdditionalValue4")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_SeasonRemap")
                                    continue;

                                if (material.GetInt("_ElementMode") == 0 && property.name == "_SeasonColor")
                                    continue;
                            }

                            //if (material.HasProperty("_ElementMotionMode"))
                            //{
                            //    var mode = material.GetInt("_ElementMotionMode");

                            //    if (mode == 13)
                            //    {
                            //        if (prop.name == "_MotionPower")
                            //            continue;
                            //    }
                            //}

                            if (material.HasProperty("_MotionDirectionMode"))
                            {
                                var mode = material.GetInt("_MotionDirectionMode");

                                if (mode != 2)
                                {
                                    if (property.name == "_SpeedTresholdValue")
                                        continue;
                                }
                            }
                            else
                            {
                                if (property.name == "_SpeedTresholdValue")
                                    continue;
                            }

                            if (material.HasProperty("_TerrainInputMode"))
                            {
                                if (material.GetInt("_TerrainInputMode") == 0 && property.name == "_MaskingTerrainInfo")
                                    continue;
                                if (material.GetInt("_TerrainInputMode") == 1 && property.name == "_MaskingModelInfo")
                                    continue;
                            }

                            //if (material.HasProperty("_ElementRaycastMode"))
                            //{
                            //    if (material.GetInt("_ElementRaycastMode") == 0 && prop.name == "_RaycastLayerMask")
                            //        continue;
                            //    if (material.GetInt("_ElementRaycastMode") == 0 && prop.name == "_RaycastDistanceMaxValue")
                            //        continue;
                            //}

                            customPropsList.Add(property);
                        }
                    }
                }
            }

            for (int i = 0; i < customPropsList.Count; i++)
            {
                var property = customPropsList[i];
                var internalName = property.name;
                var displayName = property.displayName;

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
            }

            advancedEnabled = StyledGUI.DrawInspectorCategory("Advanced Settings", advancedEnabled, true, 0, 0);

            if (advancedEnabled)
            {
                GUILayout.Space(10);

                if (EditorUtility.IsPersistent(material) /*&& (material.HasProperty("_ElementRaycastMode") && material.GetFloat("_ElementRaycastMode") < 0.5f)*/)
                {
                    materialEditor.EnableInstancingField();
                    GUILayout.Space(10);
                }
                else
                {
                    material.enableInstancing = false;
                }

                showInternalProperties = EditorGUILayout.Toggle("Show Internal Properties", showInternalProperties);
                showHiddenProperties = EditorGUILayout.Toggle("Show Hidden Properties", showHiddenProperties);
                showAdditionalInfo = EditorGUILayout.Toggle("Show Additional Info", showAdditionalInfo);

                if (showAdditionalInfo)
                {
                    TheVisualEngine.TVEUtils.DrawTechnicalDetails(material);
                }
            }

            GUILayout.Space(15);

            TheVisualEngine.TVEUtils.DrawPoweredBy();
        }

        void AssignDefaultSettings(Material material, Shader shader)
        {
            if (shader.name.Contains("Cutout"))
            {
                material.SetInt("_ElementBlendA", 1);
            }

            if (shader.name.Contains("Size"))
            {
                material.SetInt("_ElementBlendA", 0);
            }

            if (shader.name.Contains("Wind Intensity"))
            {
                material.SetInt("_ElementBlendA", 0);
            }

            if (shader.name.Contains("Interaction") || shader.name.Contains("Direction"))
            {
                if (material.HasProperty("_MainTex"))
                {
                    if (material.GetTexture("_MainTex") != null)
                    {
                        if (!material.GetTexture("_MainTex").name.Contains("Motion"))
                        {
                            material.SetTexture("_MainTex", Resources.Load<Material>("Internal Motion").GetTexture("_MainTex"));
                        }
                    }
                }

                if (material.HasProperty("_MotionTex"))
                {
                    if (material.GetTexture("_MotionTex") == null)
                    {
                        material.SetTexture("_MotionTex", Resources.Load<Material>("Internal Motion").GetTexture("_MotionTex"));
                    }
                }

                material.SetFloat("_MotionDirectionMode", 1);

            }
            else
            {
                if (material.HasProperty("_MainTex"))
                {
                    if (material.GetTexture("_MainTex") != null)
                    {
                        if (material.GetTexture("_MainTex").name.Contains("Motion"))
                        {
                            material.SetTexture("_MainTex", Resources.Load<Material>("Internal Colors").GetTexture("_MainTex"));
                        }
                    }
                }
            }
        }

        void DrawDefaultProperty(MaterialEditor materialEditor, MaterialProperty property, string internalName, string displayName)
        {
            materialEditor.ShaderProperty(property, displayName);
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

            GUILayout.EndHorizontal();
        }
    }
}

