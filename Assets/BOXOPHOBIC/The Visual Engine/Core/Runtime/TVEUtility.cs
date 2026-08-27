//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using System.IO;
using UnityEngine.Rendering;
using System.Collections.Generic;
using System.Globalization;
using System;
using UnityEngine.Serialization;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;

#if UNITY_EDITOR
using UnityEditor;
using Boxophobic.Constants;
#endif

namespace TheVisualEngine
{
    public class TVEUtils
    {
        // Settings Utils
        public static void SetMaterialSettings(Material material)
        {
            if (!material.HasProperty("_IsTVEShader"))
            {
                return;
            }

            TVEUtils.SetMaterialUpgrade(material);
            TVEUtils.SetMaterialRuntime(material);
            TVEUtils.SetMaterialInternal(material);

#if UNITY_EDITOR
            //TVEUtils.StripUnusedTextures(material);
            //TVEUtils.GetStrippedTextures(material);
            TVEUtils.SetImpostorFeatures(material);
#endif
        }

        public static void SetMaterialLegacy(Material material)
        {
            var shaderName = material.shader.name;

            if (material.HasProperty("_IsVersion"))
            {
                var version = material.GetInt("_IsVersion");

                // fix wrong version added in shader
                if (version == 1200)
                {
                    version = 1050;
                }

                // Chanage shader early
                if (version < 900)
                {
                    // Mobile shaders
                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Cross Vertex Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Vertex Lit (Mobile)");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                        material.SetFloat("_MotionValue_20", 0);
                        material.SetFloat("_MotionValue_30", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Cross Simple Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Simple Lit (Mobile)");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                        material.SetFloat("_MotionValue_20", 0);
                        material.SetFloat("_MotionValue_30", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Grass Vertex Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Vertex Lit (Mobile)");

                        material.SetFloat("_MotionValue_20", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Grass Simple Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Simple Lit (Mobile)");

                        material.SetFloat("_MotionValue_20", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Uber Vertex Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Vertex Lit (Mobile)");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Uber Simple Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Simple Lit (Mobile)");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                    }

                    // Default Shaders
                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Cross Standard Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Standard Lit");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                        material.SetFloat("_MotionValue_20", 0);
                        material.SetFloat("_MotionValue_30", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Cross Subsurface Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Subsurface Lit");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                        material.SetFloat("_MotionValue_20", 0);
                        material.SetFloat("_MotionValue_30", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Grass Standard Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Standard Lit");

                        material.SetFloat("_MotionValue_20", 0);
                        material.SetFloat("_MotionValue_30", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Grass Subsurface Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Subsurface Lit");

                        material.SetFloat("_MotionValue_20", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Uber Standard Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Standard Lit");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Uber Subsurface Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Subsurface Lit");

                        material.SetFloat("_SizeFadeStartValue", 0);
                        material.SetFloat("_SizeFadeEndValue", 0);
                    }

                    // Upgrade to 14
                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Prop Standard Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry Standard Lit");

                        material.SetFloat("_TintingIntensityValue", 0);
                        material.SetFloat("_DrynessIntensityValue", 0);
                        material.SetFloat("_ScaleIntensityValue", 0);
                        material.SetFloat("_MotionIntensityValue", 0);
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Prop Subsurface Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry Subsurface Lit");

                        material.SetFloat("_TintingIntensityValue", 0);
                        material.SetFloat("_DrynessIntensityValue", 0);
                        material.SetFloat("_ScaleIntensityValue", 0);
                        material.SetFloat("_MotionIntensityValue", 0);
                    }
                }

                if (version < 1100)
                {
                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Bark Standard Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Standard Lit");

                        material.SetFloat("_GlobalColors", 0);
                        material.SetFloat("_GlobalAlpha", 0);
                        material.SetFloat("_SubsurfaceValue", 0);
                        material.SetFloat("_MotionAmplitude_32", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                        material.SetPropertyLock("_GlobalColors", true);
                        material.SetPropertyLock("_GlobalAlpha", true);
                        material.SetPropertyLock("_SubsurfaceValue", true);
                        material.SetPropertyLock("_MotionAmplitude_32", true);
#endif
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Bark Vertex Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Vertex Lit (Mobile)");

                        material.SetFloat("_GlobalColors", 0);
                        material.SetFloat("_GlobalAlpha", 0);
                        material.SetFloat("_SubsurfaceValue", 0);
                        material.SetFloat("_MotionAmplitude_32", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                        material.SetPropertyLock("_GlobalColors", true);
                        material.SetPropertyLock("_GlobalAlpha", true);
                        material.SetPropertyLock("_SubsurfaceValue", true);
                        material.SetPropertyLock("_MotionAmplitude_32", true);
#endif
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Bark Simple Lit (Mobile)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Simple Lit (Mobile)");

                        material.SetFloat("_GlobalColors", 0);
                        material.SetFloat("_GlobalAlpha", 0);
                        material.SetFloat("_SubsurfaceValue", 0);
                        material.SetFloat("_MotionAmplitude_32", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                        material.SetPropertyLock("_GlobalColors", true);
                        material.SetPropertyLock("_GlobalAlpha", true);
                        material.SetPropertyLock("_SubsurfaceValue", true);
                        material.SetPropertyLock("_MotionAmplitude_32", true);
#endif
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Bark Standard Lit (Blanket)"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Plant Standard Lit (Blanket)");

                        material.SetFloat("_GlobalColors", 0);
                        material.SetFloat("_GlobalAlpha", 0);
                        material.SetFloat("_SubsurfaceValue", 0);
                        material.SetFloat("_MotionAmplitude_32", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                        material.SetPropertyLock("_GlobalColors", true);
                        material.SetPropertyLock("_GlobalAlpha", true);
                        material.SetPropertyLock("_SubsurfaceValue", true);
                        material.SetPropertyLock("_MotionAmplitude_32", true);
#endif
                    }

                    // Disable Coloring for Props
                    if (material.shader.name.Contains("Prop"))
                    {
                        material.SetFloat("_GlobalColors", 0);
                        material.SetFloat("_GlobalAlpha", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                        material.SetPropertyLock("_GlobalColors", true);
                        material.SetPropertyLock("_GlobalAlpha", true);
#endif
                    }
                }

                // Update settings
                if (version < 500)
                {
                    if (material.HasProperty("_RenderPriority"))
                    {
                        if (material.GetInt("_RenderPriority") != 0)
                        {
                            material.SetInt("_RenderQueue", 1);
                        }
                    }

                    material.SetInt("_IsVersion", 500);
                }

                if (version < 600)
                {
                    if (material.HasProperty("_LayerReactValue"))
                    {
                        material.SetInt("_LayerVertexValue", material.GetInt("_LayerReactValue"));
                    }

                    material.SetInt("_IsVersion", 600);
                }

                if (version < 620)
                {
                    if (material.HasProperty("_VertexRollingMode"))
                    {
                        material.SetInt("_MotionValue_20", material.GetInt("_VertexRollingMode"));
                    }

                    material.SetInt("_IsVersion", 620);
                }

                if (version < 630)
                {
                    material.DisableKeyword("TVE_DETAIL_BLEND_OVERLAY");
                    material.DisableKeyword("TVE_DETAIL_BLEND_REPLACE");

                    material.SetInt("_IsVersion", 630);
                }

                if (version < 640)
                {
                    if (material.HasProperty("_Cutoff"))
                    {
                        material.SetFloat("_AlphaCutoffValue", material.GetFloat("_Cutoff"));
                    }

                    material.SetInt("_IsVersion", 640);
                }

                if (version < 650)
                {
                    if (material.HasProperty("_Cutoff"))
                    {
                        material.SetFloat("_AlphaClipValue", material.GetFloat("_Cutoff"));
                    }

                    if (material.HasProperty("_MotionValue_20"))
                    {
                        material.SetFloat("_MotionValue_20", 1);
                    }

                    // Guess best values for squash motion
                    if (material.HasProperty("_MotionScale_20") && material.HasProperty("_MaxBoundsInfo"))
                    {
                        var bounds = material.GetVector("_MaxBoundsInfo");
                        var scale = Mathf.Round((1.0f / bounds.y * 10.0f * 0.5f) * 10) / 10;

                        if (scale > 1)
                        {
                            scale = Mathf.Clamp(Mathf.FloorToInt(scale), 0, 20);
                        }

                        material.SetFloat("_MotionScale_20", scale);
                    }

                    if (material.shader.name.Contains("Bark"))
                    {
                        material.SetFloat("_DetailCoordMode", 1);
                    }

                    material.DisableKeyword("TVE_ALPHA_CLIP");
                    material.DisableKeyword("TVE_DETAIL_MODE_ON");
                    material.DisableKeyword("TVE_DETAIL_MODE_OFF");
                    material.DisableKeyword("TVE_DETAIL_TYPE_VERTEX_BLUE");
                    material.DisableKeyword("TVE_DETAIL_TYPE_PROJECTION");
                    material.DisableKeyword("TVE_IS_VEGETATION_SHADER");
                    material.DisableKeyword("TVE_IS_GRASS_SHADER");

                    material.SetInt("_IsVersion", 650);
                }

                if (version < 710)
                {
                    if (material.HasProperty("_MotionScale_20"))
                    {
                        var scale = material.GetFloat("_MotionScale_20");

                        material.SetFloat("_MotionScale_20", scale * 10.0f);
                    }

                    material.SetInt("_IsVersion", 710);
                }

                if (version < 800)
                {
                    if (material.HasProperty("_ColorsMaskMinValue") && material.HasProperty("_ColorsMaskMaxValue"))
                    {
                        var min = material.GetFloat("_ColorsMaskMinValue");
                        var max = material.GetFloat("_ColorsMaskMaxValue");

                        material.SetFloat("_MainMaskMinValue", min);
                        material.SetFloat("_MainMaskMaxValue", max);
                    }

                    if (material.HasProperty("_LeavesFilterMode") && material.HasProperty("_LeavesFilterColor"))
                    {
                        var mode = material.GetInt("_LeavesFilterMode");
                        var color = material.GetColor("_LeavesFilterColor");

                        if (mode == 1)
                        {
                            if (color.r < 0.1f && color.g < 0.1f && color.b < 0.1f)
                            {
                                material.SetFloat("_GlobalColors", 0);
                                material.SetFloat("_MotionValue_30", 0);
                            }
                        }
                    }

                    if (material.HasProperty("_DetailMeshValue"))
                    {
                        material.SetFloat("_DetailMeshValue", 0);
                        material.SetFloat("_DetailBlendMinValue", 0.4f);
                        material.SetFloat("_DetailBlendMaxValue", 0.6f);
                    }

                    material.SetInt("_IsVersion", 800);
                }

                if (version < 810)
                {
                    if (material.HasProperty("_GlobalColors"))
                    {
                        var value = material.GetFloat("_GlobalColors");

                        material.SetFloat("_GlobalColors", Mathf.Clamp01(value * 2.0f));
                    }

                    if (material.HasProperty("_VertexOcclusionColor"))
                    {
                        var color = material.GetColor("_VertexOcclusionColor");
                        var alpha = (color.r + color.g + color.b + 0.001f) / 3.0f;

                        color.a = Mathf.Clamp01(alpha);

                        material.SetColor("_VertexOcclusionColor", color);
                    }

                    material.SetInt("_IsIdentifier", 0);
                    material.SetInt("_IsVersion", 810);
                }

                if (version < 830)
                {
                    material.SetFloat("_OverlayProjectionValue", 0.6f);

                    material.SetInt("_IsVersion", 830);
                }

                if (version < 850)
                {
                    if (material.HasProperty("_DetailOpaqueMode"))
                    {
                        var mode = material.GetInt("_DetailOpaqueMode");

                        material.SetInt("_DetailFadeMode", 1 - mode);
                    }

                    if (material.HasProperty("_DetailTypeMode"))
                    {
                        var mode = material.GetInt("_DetailTypeMode");

                        if (mode == 1)
                        {
                            material.SetInt("_DetailCoordMode", 2);
                        }

                        // Transfer Type to Mesh variable
                        material.SetInt("_DetailMeshMode", material.GetInt("_DetailTypeMode"));
                    }

                    if (material.HasProperty("_DetailCoordMode"))
                    {
                        // Transfer Detail Coord to Second Coord
                        material.SetInt("_SecondUVsMode", material.GetInt("_DetailCoordMode"));
                    }

                    if (material.HasProperty("_EmissiveFlagMode"))
                    {
                        int mode = material.GetInt("_EmissiveFlagMode");

                        if (mode == 0)
                        {
                            material.SetInt("_EmissiveFlagMode", 0);
                        }
                        else if (mode == 10)
                        {
                            material.SetInt("_EmissiveFlagMode", 1);
                        }
                        else if (mode == 20)
                        {
                            material.SetInt("_EmissiveFlagMode", 2);
                        }
                        else if (mode == 30)
                        {
                            material.SetInt("_EmissiveFlagMode", 3);
                        }
                    }

                    if (material.HasProperty("_EmissiveIntensityParams"))
                    {
                        var value = 1.0f;
                        var param = material.GetVector("_EmissiveIntensityParams");

                        if (param.w == 0)
                        {
                            value = param.y;
                            material.SetInt("_EmissiveIntensityMode", 0);
                        }
                        else
                        {
                            value = param.z;
                            material.SetInt("_EmissiveIntensityMode", 1);
                        }

                        material.SetFloat("_EmissiveIntensityValue", value);
                    }

                    material.SetInt("_IsVersion", 850);
                }

                if (version < 900)
                {
                    material.SetFloat("_DetailMeshValue", 1);
                    material.SetFloat("_DetailMaskValue", 1);

                    material.SetInt("_IsVersion", 900);
                }

                if (version < 1000)
                {
                    material.SetInt("_IsIdentifier", (int)UnityEngine.Random.Range(1, 100));

                    if (material.HasProperty("_DetailMeshInvertMode"))
                    {
                        var mode = material.GetInt("_DetailMeshInvertMode");

                        if (mode == 0)
                        {
                            material.SetFloat("_DetailMeshMinValue", 0);
                            material.SetFloat("_DetailMeshMaxValue", 1);
                        }
                        else
                        {
                            material.SetFloat("_DetailMeshMinValue", 1);
                            material.SetFloat("_DetailMeshMaxValue", 0);
                        }
                    }

                    if (material.HasProperty("_DetailMaskInvertMode"))
                    {
                        var mode = material.GetInt("_DetailMaskInvertMode");

                        if (mode == 0)
                        {
                            material.SetFloat("_DetailMaskMinValue", 0);
                            material.SetFloat("_DetailMaskMaxValue", 1);
                        }
                        else
                        {
                            material.SetFloat("_DetailMaskMinValue", 1);
                            material.SetFloat("_DetailMaskMaxValue", 0);
                        }
                    }

                    material.SetInt("_IsVersion", 1000);
                }

                if (version < 1100)
                {
                    if (material.HasProperty("_MotionValue_20"))
                    {
                        var mode = material.GetInt("_MotionValue_20");

                        if (mode == 0)
                        {
                            material.SetFloat("_MotionAmplitude_20", 0);
                            material.SetFloat("_MotionAmplitude_22", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                            material.SetPropertyLock("_MotionAmplitude_20", true);
                            material.SetPropertyLock("_MotionAmplitude_22", true);
#endif
                        }
                    }

                    if (material.HasProperty("_MotionValue_30"))
                    {
                        var mode = material.GetInt("_MotionValue_30");

                        if (mode == 0)
                        {
                            material.SetFloat("_MotionAmplitude_32", 0);

#if UNITY_2022_1_OR_NEWER && UNITY_EDITOR
                            material.SetPropertyLock("_MotionAmplitude_32", true);
#endif
                        }
                    }

                    material.SetInt("_IsVersion", 1100);
                }

                // Bumped version because 1200 was used before by mistake
                if (version < 1201)
                {
                    if (material.HasProperty("_EmissiveColor"))
                    {
                        var color = material.GetColor("_EmissiveColor");

                        if (material.GetColor("_EmissiveColor").r > 0 || material.GetColor("_EmissiveColor").g > 0 || material.GetColor("_EmissiveColor").b > 0)
                        {
                            material.SetInt("_EmissiveMode", 1);
                        }
                    }

                    material.SetInt("_IsVersion", 1201);
                }

                // Refresh is needed to apply new keywords
                if (version < 1230)
                {
                    material.SetInt("_IsVersion", 1230);
                }
            }

        }

        public static void SetMaterialUpgrade(Material material)
        {
            var shaderName = material.shader.name;

            if (material.HasProperty("_IsVersion"))
            {
                var version = material.GetInt("_IsVersion");

#if UNITY_EDITOR
                if (version < 1400)
                {
                    int isPlant = 1;

                    string oldShader = material.shader.name;
                    Shader newShader = null;

                    if (oldShader.Contains("Prop"))
                    {
                        isPlant = 0;
                    }

                    if (!oldShader.Contains("Lite"))
                    {
                        if (oldShader.Contains("Blanket"))
                        {
                            if (oldShader.Contains("Standard"))
                            {
                                newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Blanket Standard Lit");
                            }

                            if (oldShader.Contains("Subsurface"))
                            {
                                newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Blanket Subsurface Lit");
                            }
                        }
                        else if (oldShader.Contains("Mobile"))
                        {
                            newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit");
                        }
                        else if (oldShader.Contains("Polygonal"))
                        {
                            newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit");
                        }
                        else if (oldShader.Contains("Impostor"))
                        {
                            if (oldShader.Contains("Standard"))
                            {
                                if (oldShader.Contains("Octa"))
                                {
                                    newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Octahedron Standard Lit");
                                }

                                if (oldShader.Contains("Hemi"))
                                {
                                    newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Octahedron Standard Lit");
                                    material.EnableKeyword("_HEMI_ON");
                                }

                                if (oldShader.Contains("Spherical"))
                                {
                                    newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Spherical Standard Lit");
                                }
                            }

                            if (oldShader.Contains("Subsurface"))
                            {
                                if (oldShader.Contains("Octa"))
                                {
                                    newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Octahedron Subsurface Lit");
                                }

                                if (oldShader.Contains("Hemi"))
                                {
                                    newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Octahedron Standard Lit");
                                    material.EnableKeyword("_HEMI_ON");
                                }

                                if (oldShader.Contains("Spherical"))
                                {
                                    newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Spherical Subsurface Lit");
                                }
                            }
                        }
                        else
                        {
                            if (oldShader.Contains("Standard"))
                            {
                                newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit");
                            }

                            if (oldShader.Contains("Subsurface"))
                            {
                                newShader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Subsurface Lit");
                            }
                        }

                        if (newShader != null)
                        {
                            material.shader = newShader;
                        }
                    }

                    // Render
                    material.SetFloat("_RenderNormal", BoxoUtils.GetMaterialSerializedFloat(material, "_RenderNormals", 0.0f));

                    // Globals
                    material.SetFloat("_GlobalPaintLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LayerColorsValue", 0.0f));
                    material.SetFloat("_GlobalGlowLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LayerColorsValue", 0.0f));
                    material.SetFloat("_GlobalAtmoLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LayerExtrasValue", 0.0f));
                    material.SetFloat("_GLobalFormLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LayerVertexValue", 0.0f));
                    material.SetFloat("_GlobalWindLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LayerMotionValue", 0.0f));
                    material.SetFloat("_GlobalPushLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LayerMotionValue", 0.0f));

                    material.SetFloat("_GlobalPaintPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ColorsPositionMode", 0.0f));
                    material.SetFloat("_GlobalGlowPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ColorsPositionMode", 0.0f));
                    material.SetFloat("_GlobalAtmoPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ExtrasPositionMode", 0.0f));
                    material.SetFloat("_GlobalFormPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_VertexPositionMode", 1.0f));

                    material.SetFloat("_TintingIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalColors", 0.0f));
                    material.SetFloat("_OverlayIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalOverlay", 0.0f));
                    material.SetFloat("_OverlayProjValue", BoxoUtils.GetMaterialSerializedFloat(material, "_OverlayProjectionValue", 0.5f));
                    material.SetFloat("_WetnessIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalWetness", 0.0f));
                    material.SetFloat("_EmissiveElementMode", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalEmissive", 0.0f));
                    //material.SetFloat("_CutoutIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalAlpha", 0.0f) * isPlant);
                    material.SetFloat("_HeightIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalHeight", 0.0f));
                    material.SetFloat("_BlanketConformValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalConform", 0.0f));
                    material.SetFloat("_BlanketOrientationValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalOrientation", 0.0f));

                    if (isPlant == 1)
                    {
                        material.SetFloat("_OverlayTextureMode", 0);
                        material.SetFloat("_WetnessDropsIntensityValue", 0);
                    }
                    else
                    {
                        material.SetFloat("_OverlayTextureMode", 1);
                        material.SetFloat("_WetnessDropsIntensityValue", 1);
                    }

                    // Object
                    material.SetFloat("_ObjectModelMode", 0);

                    var pivotsMode = BoxoUtils.GetMaterialSerializedFloat(material, "_VertexPivotMode", 0.0f);

                    material.SetFloat("_ObjectPivotMode", pivotsMode);

                    var boundsRadius = 1.0f;
                    var boundsHeight = 1.0f;

                    var boundsData = BoxoUtils.GetMaterialSerializedVector(material, "_MaxBoundsInfo", Vector4.one);

                    if (boundsData.x == 0)
                    {
                        boundsRadius = BoxoUtils.GetMaterialSerializedFloat(material, "_BoundsRadiusValue", 1.0f);
                    }
                    else
                    {
                        boundsRadius = boundsData.x;
                    }

                    if (boundsData.y == 0)
                    {
                        boundsHeight = BoxoUtils.GetMaterialSerializedFloat(material, "_BoundsHeightValue", 1.0f);
                    }
                    else
                    {
                        boundsHeight = boundsData.y;
                    }

                    material.SetFloat("_ObjectRadiusValue", Mathf.Round(boundsRadius * 100) / 100);
                    material.SetFloat("_ObjectHeightValue", Mathf.Round(boundsHeight * 100) / 100);

                    // Main
                    material.SetTexture("_MainShaderTex", BoxoUtils.GetMaterialSerializedTexture(material, "_MainMaskTex", null));
                    material.SetFloat("_MainCoordMode", BoxoUtils.GetMaterialSerializedFloat(material, "_MainUVScaleMode", 0));
                    material.SetVector("_MainCoordValue", BoxoUtils.GetMaterialSerializedVector(material, "_MainUVs", new Vector4(1, 1, 0, 0)));
                    material.SetFloat("_MainAlphaClipValue", BoxoUtils.GetMaterialSerializedFloat(material, "_AlphaClipValue", 0.5f));

                    material.SetVector("_MainMultiRemap", BoxoUtils.GetMaterialSerializedVector(material, "_MainMaskMinValue", "_MainMaskMaxValue", Vector4.zero));

                    // Second
                    var secondMode = (int)BoxoUtils.GetMaterialSerializedFloat(material, "_DetailMode", 0.0f);

                    if (secondMode == 0)
                    {
                        material.SetFloat("_SecondIntensityValue", 0);
                    }

                    if (secondMode == 1)
                    {
                        material.SetFloat("_SecondIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_DetailValue", 0.0f));
                    }

                    material.SetTexture("_SecondShaderTex", BoxoUtils.GetMaterialSerializedTexture(material, "_SecondMaskTex", null));

                    material.SetFloat("_SecondSampleMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondUVsMode", 0));
                    material.SetFloat("_SecondCoordMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondUVScaleMode", 0));
                    material.SetVector("_SecondCoordValue", BoxoUtils.GetMaterialSerializedVector(material, "_SecondUVs", new Vector4(1, 1, 0, 0)));

                    material.SetFloat("_SecondAlphaClipValue", BoxoUtils.GetMaterialSerializedFloat(material, "_AlphaClipValue", 0.5f));
                    material.SetVector("_SecondMultiRemap", BoxoUtils.GetMaterialSerializedVector(material, "_SecondMaskMinValue", "_SecondMaskMaxValue", Vector4.zero));

                    material.SetFloat("_SecondBlendAlbedoValue", 1 - BoxoUtils.GetMaterialSerializedFloat(material, "_DetailBlendMode", 1.0f));
                    material.SetFloat("_SecondBlendNormalValue", BoxoUtils.GetMaterialSerializedFloat(material, "_DetailNormalValue", 0.0f));
                    material.SetFloat("_SecondBlendAlphaValue", 1 - BoxoUtils.GetMaterialSerializedFloat(material, "_DetailAlphaMode", 1.0f));

                    var secondMeshMode = (int)BoxoUtils.GetMaterialSerializedFloat(material, "_DetailMeshMode", 0.0f);

                    if (secondMeshMode == 0)
                    {
                        material.SetFloat("_SecondProjValue", 0);
                        material.SetVector("_SecondProjRemap", Vector4.zero);
                        material.SetFloat("_SecondMeshValue", 1);
                        material.SetVector("_SecondMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_SecondMeshMinValue", "_SecondMeshMaxValue", new Vector4(0, 1, 0, 0)));
                    }

                    if (secondMeshMode == 1)
                    {
                        material.SetFloat("_SecondProjValue", 1);
                        material.SetVector("_SecondProjRemap", BoxoUtils.GetMaterialSerializedVector(material, "_SecondMeshMinValue", "_SecondMeshMaxValue", new Vector4(0, 1, 0, 0)));
                        material.SetFloat("_SecondMeshValue", 0);
                        material.SetVector("_SecondMeshRemap", Vector4.zero);
                    }

                    var secondMaskMode = (int)BoxoUtils.GetMaterialSerializedFloat(material, "_DetailMaskMode", 0.0f);

                    if (secondMaskMode == 0)
                    {
                        material.SetTexture("_SecondMaskTex", BoxoUtils.GetMaterialSerializedTexture(material, "_MainMaskTex", null));
                    }

                    if (secondMaskMode == 1)
                    {
                        material.SetTexture("_SecondMaskTex", BoxoUtils.GetMaterialSerializedTexture(material, "_SecondMaskTex", null));
                    }

                    var secondMaskRemap = BoxoUtils.GetMaterialSerializedVector(material, "_DetailMaskMinValue", "_DetailMaskMaxValue", new Vector4(0, 1, 0, 0));

                    if (secondMaskRemap.x == 0 && secondMaskRemap.y == 0)
                    {
                        material.SetFloat("_SecondMaskValue", 0);
                        material.SetVector("_SecondMaskRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_SecondMaskValue", 1);
                        material.SetVector("_SecondMaskRemap", BoxoUtils.GetMaterialSerializedVector(material, "_DetailMaskMinValue", "_DetailMaskMaxValue", new Vector4(0, 1, 0, 0)));
                    }

                    material.SetVector("_SecondBlendRemap", BoxoUtils.GetMaterialSerializedVector(material, "_DetailBlendMinValue", "_DetailBlendMaxValue", new Vector4(0, 1, 0, 0)));

                    // Terrain
                    material.SetFloat("_TerrainIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainMode", 0.0f));
                    material.SetFloat("_TerrainLandValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainBlendOffsetValue", 0.0f));
                    material.SetFloat("_NormalBlanketLandValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainBlendOffsetValue", 0.0f));

                    if (material.shader.name.Contains("Blanket") || material.shader.name.Contains("Terrain"))
                    {
                        material.SetTexture("_TerrainHolesTex", BoxoUtils.GetMaterialSerializedTexture(material, "_HolesTex", null));
                        material.SetTexture("_TerrainControlTex1", BoxoUtils.GetMaterialSerializedTexture(material, "_ControlTex1", null));
                        material.SetTexture("_TerrainControlTex2", BoxoUtils.GetMaterialSerializedTexture(material, "_ControlTex2", null));
                        material.SetTexture("_TerrainControlTex3", BoxoUtils.GetMaterialSerializedTexture(material, "_ControlTex3", null));
                        material.SetTexture("_TerrainControlTex4", BoxoUtils.GetMaterialSerializedTexture(material, "_ControlTex4", null));

                        for (int i = 1; i < 17; i++)
                        {
                            material.SetTexture("_TerrainAlbedoTex" + i, BoxoUtils.GetMaterialSerializedTexture(material, "_AlbedoTex" + i, null));
                            material.SetTexture("_TerrainNormalTex" + i, BoxoUtils.GetMaterialSerializedTexture(material, "_NormalTex" + i, null));
                            material.SetTexture("_TerrainShaderTex" + i, BoxoUtils.GetMaterialSerializedTexture(material, "_MaskTex" + i, null));
                            material.SetVector("_TerrainShaderMin" + i, BoxoUtils.GetMaterialSerializedVector(material, "_MaskMin" + i, Vector4.zero));
                            material.SetVector("_TerrainShaderMax" + i, BoxoUtils.GetMaterialSerializedVector(material, "_MaskMax" + i, Vector4.one));
                            material.SetVector("_TerrainParams" + i, BoxoUtils.GetMaterialSerializedVector(material, "_Params" + i, Vector4.one));
                            material.SetVector("_TerrainSpecular" + i, BoxoUtils.GetMaterialSerializedVector(material, "_Specular" + i, Vector4.zero));
                            material.SetVector("_TerrainCoord" + i, BoxoUtils.GetMaterialSerializedVector(material, "_Coords" + i, new Vector4(1, 1, 0, 0)));

                            material.SetFloat("_TerrainSampleMode" + i, BoxoUtils.GetMaterialSerializedFloat(material, "_LayerSampleMode" + i, 10) / 10 - 1);
                        }
                    }

                    // Occlusion
                    var occlusionColor = BoxoUtils.GetMaterialSerializedVector(material, "_VertexOcclusionColor", Vector4.one);
                    var occlusionValue = (occlusionColor.x + occlusionColor.y + occlusionColor.z) / 3;

                    if (occlusionValue != 1)
                    {
                        material.SetFloat("_OcclusionIntensityValue", 1);
                    }

                    material.SetVector("_OcclusionColorTwo", BoxoUtils.GetMaterialSerializedVector(material, "_VertexOcclusionColor", Vector4.one));
                    material.SetVector("_OcclusionMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_VertexOcclusionMinValue", "_VertexOcclusionMaxValue", new Vector4(0, 1, 0, 0)));

                    // Gradient
                    if (isPlant == 1)
                    {
                        var gradientColor1 = BoxoUtils.GetMaterialSerializedVector(material, "_GradientColorOne", Vector4.one);
                        var gradientColor2 = BoxoUtils.GetMaterialSerializedVector(material, "_GradientColorTwo", Vector4.one);
                        var gradientValue = (gradientColor1.x + gradientColor1.y + gradientColor1.z + gradientColor2.x + gradientColor2.y + gradientColor2.z) / 6;

                        if (gradientValue != 1)
                        {
                            material.SetFloat("_GradientIntensityValue", 1);
                        }

                        material.SetVector("_GradientMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_GradientMaskMinValue", "_GradientMaskMaxValue", new Vector4(0, 1, 0, 0)));
                    }

                    // Emissive
                    var emissiveMode = (int)BoxoUtils.GetMaterialSerializedFloat(material, "_EmissiveMode", 0.0f);

                    if (emissiveMode == 0)
                    {
                        material.SetFloat("_EmissiveIntensityValue", 0);
                    }

                    if (emissiveMode == 1)
                    {
                        material.SetFloat("_EmissiveIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_EmissivePhaseValue", 0.0f));
                    }

                    material.SetVector("_EmissiveCoordValue", BoxoUtils.GetMaterialSerializedVector(material, "_EmissiveUVs", new Vector4(1, 1, 0, 0)));

                    material.SetFloat("_EmissivePowerMode", BoxoUtils.GetMaterialSerializedFloat(material, "_EmissiveIntensityMode", 0.0f));
                    material.SetFloat("_EmissivePowerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_EmissiveIntensityValue", 1.0f));
                    material.SetTexture("_EmissiveMaskTex", BoxoUtils.GetMaterialSerializedTexture(material, "_EmissiveTex", null));

                    var emissiveMaskRemap = BoxoUtils.GetMaterialSerializedVector(material, "_EmissiveTexMinValue", "_EmissiveTexMinValue", new Vector4(0, 1, 0, 0));

                    if (emissiveMaskRemap.x == 0 && emissiveMaskRemap.y == 0)
                    {
                        material.SetFloat("_EmissiveMaskValue", 0);
                        material.SetVector("_EmissiveMaskRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_EmissiveMaskValue", 1);
                        material.SetVector("_EmissiveMaskRemap", BoxoUtils.GetMaterialSerializedVector(material, "_EmissiveTexMinValue", "_EmissiveTexMaxValue", new Vector4(0, 1, 0, 0)));
                    }

                    // Subsurface
                    material.SetFloat("_SubsurfaceIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SubsurfaceValue", 0.0f) * isPlant);
                    material.SetFloat("_SubsurfaceMultiValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SubsurfaceMaskValue", 1.0f));

                    // Size Fade
                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_SizeFadeStartValue", 0.0f) > 0 || BoxoUtils.GetMaterialSerializedFloat(material, "_SizeFadeEndValue", 0.0f) > 0 || BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalSize", 0.0f) > 0)
                    {
                        material.SetFloat("_SizeFadeIntensityValue", 1);
                    }

                    material.SetFloat("_SizeFadeElementMode", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalSize", 1.0f));

                    material.SetFloat("_SizeFadeDistMinValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SizeFadeStartValue", 0.0f));
                    material.SetFloat("_SizeFadeDistMaxValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SizeFadeEndValue", 0.0f));

                    // Blanket
                    material.SetFloat("_BlanketConformOffsetMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformOffsetMode", 1.0f));
                    material.SetFloat("_BlanketConformOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformOffsetValue", 0.0f));

                    material.SetFloat("_NormalBlanketValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainBlendOffsetValue", 0.0f) * BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainBlendNormalValue", 0.0f));

                    // Perspective
                    material.SetFloat("_PerspectiveIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_PerspectivePushValue", 0.0f));

                    // Motion
                    var highlight = BoxoUtils.GetMaterialSerializedVector(material, "_MotionHighlightColor", Vector4.zero);

                    material.SetFloat("_MotionHighlightValue", Mathf.Max(Mathf.Max(highlight.x, highlight.y), highlight.z) / 10 * isPlant);

                    material.SetFloat("_MotionSmallIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionAmplitude_20", 0.0f) * isPlant);

                    // Must be tree
                    if (pivotsMode == 0)
                    {
                        material.SetFloat("_MotionBaseIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionAmplitude_10", 0.0f) * 1.0f * isPlant);

                        material.SetFloat("_MotionBasePivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionPosition_10", 0.5f));
                        material.SetFloat("_MotionBaseTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionScale_10", 5));
                        material.SetFloat("_MotionBaseSpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeed_10", 5));

                        material.SetFloat("_MotionSmallPivotValue", 0.0f);
                        material.SetFloat("_MotionSmallTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionScale_20", 5));
                        material.SetFloat("_MotionSmallSpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeed_20", 5));
                    }

                    // Must be grass
                    if (pivotsMode == 1)
                    {
                        material.SetFloat("_MotionBaseIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionAmplitude_10", 0.0f) * 2.0f * isPlant);

                        material.SetFloat("_MotionBasePivotValue", 0.0f);
                        material.SetFloat("_MotionBaseTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionScale_10", 5));
                        material.SetFloat("_MotionBaseSpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeed_10", 5));

                        material.SetFloat("_MotionSmallPivotValue", 0.0f);
                        material.SetFloat("_MotionSmallTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionScale_20", 5));
                        material.SetFloat("_MotionSmallSpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeed_20", 5));
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_MotionVariation_10", 0.0f) > 0)
                    {
                        material.SetFloat("_MotionBasePhaseValue", 0.2f);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_MotionVariation_20", 0.0f) > 0)
                    {
                        material.SetFloat("_MotionSmallPhaseValue", 0.5f);
                    }

                    material.SetFloat("_MotionTinyIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionAmplitude_32", 0.0f) * isPlant);
                    material.SetFloat("_MotionTinyTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionScale_32", 20.0f) * 2.5f);
                    material.SetFloat("_MotionTinySpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeed_32", 20.0f) * 0.5f);

                    material.SetFloat("_MotionPushIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_InteractionAmplitude", 0.0f) * isPlant);
                    material.SetFloat("_MotionPushElementMode", isPlant);
                    material.SetFloat("_MotionFrontValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionFacingValue", 0.5f));

                    if (material.shader.name.Contains("Lite"))
                    {
                        var occlusionMask = BoxoUtils.GetMaterialSerializedFloat(material, "_VertexOcclusionMaskMode", 0.0f);

                        if (occlusionMask == 0)
                        {
                            material.SetFloat("_OcclusionMeshMode", 5);
                        }
                        else
                        {
                            material.SetFloat("_OcclusionMeshMode", occlusionMask / 10 - 1);
                        }

                        var gradientMask = BoxoUtils.GetMaterialSerializedFloat(material, "_GradientMaskMode", 0.0f);

                        if (gradientMask == 0)
                        {
                            material.SetFloat("_GradientMeshMode", 4);
                        }
                        else
                        {
                            material.SetFloat("_GradientMeshMode", occlusionMask / 10 - 1);
                        }

                        var phaseMode = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionVariationMode", 0.0f);

                        if (phaseMode == 0)
                        {
                            material.SetFloat("_MotionBasePhaseValue", 0);
                            material.SetFloat("_MotionSmallPhaseValue", 0);
                        }
                        else
                        {
                            material.SetFloat("_ObjectPhaseMode", phaseMode / 10 - 1);
                        }

                        // Lite uses automatic height mask
                        material.SetFloat("_MotionBaseMaskMode", 4);

                        var motionSmallMask = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionMaskMode_20", 0.0f);

                        if (motionSmallMask == 0)
                        {
                            material.SetFloat("_MotionSmallMaskMode", 5);
                        }
                        else
                        {
                            material.SetFloat("_MotionSmallMaskMode", motionSmallMask / 10 - 1);
                        }

                        var motionTinyMask = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionMaskMode_30", 0.0f);

                        if (motionTinyMask == 0)
                        {
                            material.SetFloat("_MotionTinyMaskMode", 8);
                        }
                        else
                        {
                            material.SetFloat("_MotionTinyMaskMode", motionTinyMask / 10 - 1);
                        }
                    }

                    // Impostors
                    material.SetTexture("_MasksA", BoxoUtils.GetMaterialSerializedTexture(material, "_Mask", null));
                    material.SetFloat("_ImpostorAlphaClipValue", BoxoUtils.GetMaterialSerializedFloat(material, "_AI_Clip", 0.5f));

                    material.SetInt("_IsConverted", 1);
                    material.SetInt("_IsVersion", 1400);
                }

                if (version < 1410)
                {
                    // Second Layer
                    var secondMask = BoxoUtils.GetMaterialSerializedVector(material, "_SecondMaskRemap", Vector4.zero);

                    if (secondMask.x == 0 && secondMask.y == 0)
                    {
                        material.SetFloat("_SecondMaskValue", 0);
                        material.SetVector("_SecondMaskRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_SecondMaskValue", 1);
                    }

                    var secondProj = BoxoUtils.GetMaterialSerializedVector(material, "_SecondProjRemap", Vector4.zero);

                    if (secondProj.x == 0 && secondProj.y == 0)
                    {
                        material.SetFloat("_SecondProjValue", 0);
                        material.SetVector("_SecondProjRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_SecondProjValue", 1);
                    }

                    var secondMesh = BoxoUtils.GetMaterialSerializedVector(material, "_SecondMeshRemap", Vector4.zero);

                    if (secondMesh.x == 0 && secondMesh.y == 0)
                    {
                        material.SetFloat("_SecondMeshValue", 0);
                        material.SetVector("_SecondMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_SecondMeshValue", 1);
                    }

                    // Fourth Layer
                    var thirdMask = BoxoUtils.GetMaterialSerializedVector(material, "_ThirdMaskRemap", Vector4.zero);

                    if (thirdMask.x == 0 && thirdMask.y == 0)
                    {
                        material.SetFloat("_ThirdMaskValue", 0);
                        material.SetVector("_ThirdMaskRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_ThirdMaskValue", 1);
                    }

                    var thirdProj = BoxoUtils.GetMaterialSerializedVector(material, "_ThirdProjRemap", Vector4.zero);

                    if (thirdProj.x == 0 && thirdProj.y == 0)
                    {
                        material.SetFloat("_ThirdProjValue", 0);
                        material.SetVector("_ThirdProjRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_ThirdProjValue", 1);
                    }

                    var thirdMesh = BoxoUtils.GetMaterialSerializedVector(material, "_ThirdMeshRemap", Vector4.zero);

                    if (thirdMesh.x == 0 && thirdMesh.y == 0)
                    {
                        material.SetFloat("_ThirdMeshValue", 0);
                        material.SetVector("_ThirdMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_ThirdMeshValue", 1);
                    }

                    // Terrain Layer
                    var terrainMask = BoxoUtils.GetMaterialSerializedVector(material, "_TerrainMaskRemap", Vector4.zero);

                    if (terrainMask.x == 0 && terrainMask.y == 0)
                    {
                        material.SetFloat("_TerrainMaskValue", 0);
                        material.SetVector("_TerrainMaskRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_TerrainMaskValue", 1);
                    }

                    var terrainProj = BoxoUtils.GetMaterialSerializedVector(material, "_TerrainProjRemap", Vector4.zero);

                    if (terrainProj.x == 0 && terrainProj.y == 0)
                    {
                        material.SetFloat("_TerrainProjValue", 0);
                        material.SetVector("_TerrainProjRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_TerrainProjValue", 1);
                    }

                    // Tinting Layer
                    var tintingMesh = BoxoUtils.GetMaterialSerializedVector(material, "_TintingMeshRemap", Vector4.zero);

                    if (tintingMesh.x == 0 && tintingMesh.y == 0)
                    {
                        material.SetFloat("_TintingMeshValue", 0);
                        material.SetVector("_TintingMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_TintingMeshValue", 1);
                    }

                    // Dryness Layer
                    var drynessMesh = BoxoUtils.GetMaterialSerializedVector(material, "_DrynessMeshRemap", Vector4.zero);

                    if (drynessMesh.x == 0 && drynessMesh.y == 0)
                    {
                        material.SetFloat("_DrynessMeshValue", 0);
                        material.SetVector("_DrynessMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_DrynessMeshValue", 1);
                    }

                    // Overlay Layer
                    var overlayMesh = BoxoUtils.GetMaterialSerializedVector(material, "_OverlayMeshRemap", Vector4.zero);

                    if (overlayMesh.x == 0 && overlayMesh.y == 0)
                    {
                        material.SetFloat("_OverlayMeshValue", 0);
                        material.SetVector("_OverlayMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_OverlayMeshValue", 1);
                    }

                    // Cutout Layer
                    var cutoutMesh = BoxoUtils.GetMaterialSerializedVector(material, "_CutoutMeshRemap", Vector4.zero);

                    if (cutoutMesh.x == 0 && cutoutMesh.y == 0)
                    {
                        material.SetFloat("_CutoutMeshValue", 0);
                        material.SetVector("_CutoutMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_CutoutMeshValue", 1);
                    }

                    // Emissive Layer
                    var emissiveMask = BoxoUtils.GetMaterialSerializedVector(material, "_EmissiveMaskRemap", Vector4.zero);

                    if (emissiveMask.x == 0 && emissiveMask.y == 0)
                    {
                        material.SetFloat("_EmissiveMaskValue", 0);
                        material.SetVector("_EmissiveMaskRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_EmissiveMaskValue", 1);
                    }

                    var emissiveMesh = BoxoUtils.GetMaterialSerializedVector(material, "_EmissiveMeshRemap", Vector4.zero);

                    if (emissiveMesh.x == 0 && emissiveMesh.y == 0)
                    {
                        material.SetFloat("_EmissiveMeshValue", 0);
                        material.SetVector("_EmissiveMeshRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_EmissiveMeshValue", 1);
                    }

                    // Decoupe bounds from Small Motion
                    var objectRadius = BoxoUtils.GetMaterialSerializedFloat(material, "_ObjectRadiusValue", 1);
                    var motionSmall = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSmallIntensityValue", 0);

                    material.SetFloat("_MotionSmallIntensityValue", motionSmall * objectRadius);

                    material.SetInt("_IsVersion", 1410);
                }

                if (version < 2020)
                {
                    // Copy Fade Layer
                    material.SetFloat("_GlobalFadeLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalAtmoLayerValue", 0));

                    // Typo Fix
                    material.SetFloat("_ThirdBlendIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ThitdBlendIntensityValue", 1));
                    material.SetFloat("_ThirdBlendShaderValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ThitdBlendShaderValue", 1));

                    // Terrain Land
                    var terrainLand = BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainLandValue", 0);

                    if (terrainLand > 0)
                    {
                        material.SetFloat("_TerrainLandValue", 1);
                        material.SetFloat("_TerrainLandOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainLandValue", 0));
                    }
                    else
                    {
                        material.SetFloat("_TerrainLandOffsetValue", 0);
                    }

                    // Terrain Height
                    material.SetFloat("_LandscapeHeightValue", BoxoUtils.GetMaterialSerializedFloat(material, "_HeightIntensityValue", 0));

                    // Normal Proj
                    var normalProj = BoxoUtils.GetMaterialSerializedVector(material, "_NormalBlanketProjRemap", Vector4.zero);

                    if (normalProj.x == 0 && normalProj.y == 0)
                    {
                        material.SetFloat("_NormalProjValue", 0);
                        material.SetVector("_NormalProjRemap", new Vector4(0, 1, 0, 0));
                    }
                    else
                    {
                        material.SetFloat("_NormalProjValue", 1);

                        //material.SetFloat("_NormalBlanketValue", 1);
                    }

                    // Normal Land
                    var normalLand = BoxoUtils.GetMaterialSerializedFloat(material, "_NormalBlanketLandValue", 0);

                    if (normalLand > 0)
                    {
                        material.SetFloat("_NormalBlanketValue", 1);
                        material.SetFloat("_NormalLandValue", 1);
                        material.SetFloat("_NormalLandOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalBlanketLandValue", 0));
                    }

                    material.SetInt("_IsVersion", 2020);
                }

                if (version < 2030)
                {
                    // Optimize tex if not used
                    if (material.HasProperty("_SecondMaskValue"))
                    {
                        var value = material.GetFloat("_SecondMaskValue");

                        if (value == 0)
                        {
                            if (material.HasProperty("_SecondMaskTex"))
                            {
                                material.SetTexture("_SecondMaskTex", null);
                            }
                        }
                    }

                    // Optimize tex if not used
                    if (material.HasProperty("_ThirdMaskValue"))
                    {
                        var value = material.GetFloat("_ThirdMaskValue");

                        if (value == 0)
                        {
                            if (material.HasProperty("_ThirdMaskTex"))
                            {
                                material.SetTexture("_ThirdMaskTex", null);
                            }
                        }
                    }

                    // Typo Fix
                    material.SetFloat("_TerrainMetallicValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainMetallicValue1", 1));

                    // Assign new RT texture
                    if (material.HasProperty("_MotionNoiseTex"))
                    {
                        material.SetTexture("_MotionNoiseTex", Resources.Load<CustomRenderTexture>("Internal MotionTexRT"));
                    }


                    material.SetInt("_IsVersion", 2030);
                }

                if (version < 2040)
                {
                    if (shaderName.Contains("Impostors"))
                    {
                        var impostorMask = BoxoUtils.GetMaterialSerializedTexture(material, "_MasksA", null);

                        if (impostorMask != null)
                        {
                            if (impostorMask.name.EndsWith("MasksA"))
                            {
                                // New shading format
                                material.SetInt("_ImpostorMaskMode", 3);
                                material.SetTexture("_Shader", impostorMask);
                            }
                            else
                            {
                                // Old packed format
                                material.SetInt("_ImpostorMaskMode", 2);
                                material.SetTexture("_Packed", impostorMask);
                            }
                        }

                        // Set previously not supported to 0
                        material.SetFloat("_TintingMeshValue", 0);
                        material.SetFloat("_DrynessMeshValue", 0);
                        material.SetFloat("_OverlayMeshValue", 0);
                        material.SetFloat("_CutoutMeshValue", 0);

                        material.SetFloat("_ImpostorOcclusionValue", 0);
                    }

                    // Typo fix
                    material.SetFloat("_GlobalLandPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalLandPivotValue1", 0));
                    material.SetFloat("_GlobalLandLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalLandLayerValue1", 0));

                    // Update Proximity
                    material.SetFloat("_DitherProximityMinValue", BoxoUtils.GetMaterialSerializedFloat(material, "_DitherProximityDistValue", 1));

                    // Set Motion Textures
                    if (material.HasProperty("_MotionNoiseTex"))
                    {
                        material.SetTexture("_MotionNoiseTex", Resources.Load<Texture2D>("Internal MotionTex"));
                    }

                    if (material.HasProperty("_MotionNoiseTexRT"))
                    {
                        material.SetTexture("_MotionNoiseTexRT", Resources.Load<CustomRenderTexture>("Internal MotionTexRT"));
                    }

                    // Copy Motion Settings
                    material.SetFloat("_MotionBaseSpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeedValue", 5));
                    material.SetFloat("_MotionBaseTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTillingValue", 5));

                    material.SetFloat("_MotionSmallSpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSpeedValue", 5));
                    material.SetFloat("_MotionSmallTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTillingValue", 5));

                    material.SetFloat("_MotionBaseDelayValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionDelayValue", 0));

                    material.SetInt("_IsVersion", 2040);
                }

                if (version < 2050)
                {
                    // Typo fix
                    material.SetVector("_OverlayBlendRemap", BoxoUtils.GetMaterialSerializedVector(material, "_OverlayBlendRemap1", new Vector4(0.1f, 0.2f, 0, 0)));

                    // Set global sliders                  
                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_SecondElementMode", 1) == 0)
                    {
                        material.SetFloat("_SecondGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdElementMode", 1) == 0)
                    {
                        material.SetFloat("_ThirdGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainElementMode", 1) == 0)
                    {
                        material.SetFloat("_TerrainGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_TintingElementMode", 1) == 0)
                    {
                        material.SetFloat("_TintingGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_DrynessElementMode", 1) == 0)
                    {
                        material.SetFloat("_DrynessGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_OverlayElementMode", 1) == 0)
                    {
                        material.SetFloat("_OverlayGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_WetnessElementMode", 1) == 0)
                    {
                        material.SetFloat("_WetnessGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_CutoutElementMode", 1) == 0)
                    {
                        material.SetFloat("_CutoutGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_EmissiveElementMode", 1) == 0)
                    {
                        material.SetFloat("_EmissiveGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_SubsurfaceElementMode", 1) == 0)
                    {
                        material.SetFloat("_SubsurfaceGlobalValue", 0);
                    }

                    if (BoxoUtils.GetMaterialSerializedFloat(material, "_SizefadeElementMode", 1) == 0)
                    {
                        material.SetFloat("_SizeFadeGlobalValue", 0);
                    }

                    // Conform Rename
                    if (shaderName.Contains("Blanket"))
                    {
                        material.SetFloat("_ConformHeightValue", BoxoUtils.GetMaterialSerializedFloat(material, "_BlanketConformValue", 0f));
                        material.SetFloat("_ConformHeightOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_BlanketConformOffsetValue", 0f));
                        material.SetFloat("_ConformHeightOffsetMode", BoxoUtils.GetMaterialSerializedFloat(material, "_BlanketConformOffsetMode", 1f));
                        material.SetFloat("_ConformNormalValue", BoxoUtils.GetMaterialSerializedFloat(material, "_BlanketOrientationValue", 0f));
                    }

                    if (shaderName.Contains("Terrain"))
                    {
                        material.SetFloat("_ConformHeightValue", BoxoUtils.GetMaterialSerializedFloat(material, "_LandscapeHeightValue", 0f));
                        material.SetFloat("_ConformHeightMode", 0);
                    }

                    material.SetFloat("_TerrainFormValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainLandValue", 0f));
                    material.SetFloat("_TerrainFormMode", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainLandMode", 1f));
                    material.SetFloat("_TerrainFormOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainLandOffsetValue", 1f));

                    material.SetFloat("_NormalConformValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalBlanketValue", 0f));
                    material.SetFloat("_NormalFormValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalLandValue", 0f));
                    material.SetFloat("_NormalFormMode", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalLandMode", 1f));
                    material.SetFloat("_NormalFormOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalLandOffsetValue", 1f));

                    // Wind Mode
                    var windMode = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionWindMode", 1);

                    if (windMode == 0 || windMode == 1)
                    {
                        // Copy motion tilling for Optimized Mode, but keep Advanced mode unchanged
                        material.SetFloat("_MotionBaseTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTillingValue", 5));
                        material.SetFloat("_MotionSmallTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTillingValue", 5));
                    }

                    var motionWave = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionHighlightValue", 0);
                    var motionBase = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionBaseIntensityValue", 0);
                    var motionSmall = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSmallIntensityValue", 0);
                    var motionTiny = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTinyIntensityValue", 0);
                    var motionPush = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionPushIntensityValue", 0);

                    var motionEnabled = motionWave + motionBase + motionSmall + motionTiny;

                    if (motionEnabled == 0)
                    {
                        material.SetFloat("_MotionIntensityValue", 0);
                    }

                    material.SetFloat("_MotionTinyTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTinyTillingValue", 20) * 2.5f);
                    material.SetFloat("_MotionTinySpeedValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTinySpeedValue", 20) * 0.5f);
                    material.SetFloat("_MotionBasePhaseValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionBasePhaseValue", 0) * 0.5f);
                    material.SetFloat("_MotionSmallPhaseValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSmallPhaseValue", 0) * 0.5f);

                    material.SetFloat("_GlobalFlowLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionPushLayerValue", 0f));
                    material.SetFloat("_GlobalFlowPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionPushPivotValue", 1f));

                    if (motionPush > 0)
                    {
                        material.SetFloat("_MotionElementMode", 1);
                    }
                    else
                    {
                        material.SetFloat("_MotionElementMode", 0);
                    }

                    material.SetFloat("_MotionBasePushValue", Mathf.Clamp01(motionPush));
                    material.SetFloat("_MotionSmallPushValue", Mathf.Clamp01(motionPush));

                    if (shaderName.Contains("Blanket") || shaderName.Contains("Terrain"))
                    {
                        for (int i = 1; i < 17; i++)
                        {
                            var layerRemapMin = BoxoUtils.GetMaterialSerializedVector(material, "_TerrainShaderMin" + i, new Vector4(0, 0, 0, 0));
                            var layerRemapMax = BoxoUtils.GetMaterialSerializedVector(material, "_TerrainShaderMax" + i, new Vector4(1, 1, 1, 1));

                            var rcpX = 1 / (layerRemapMax.x - layerRemapMin.x);
                            var rcpY = 1 / (layerRemapMax.y - layerRemapMin.y);
                            var rcpZ = 1 / (layerRemapMax.z - layerRemapMin.z);
                            var rcpW = 1 / (layerRemapMax.w - layerRemapMin.w);

                            material.SetVector("_TerrainShaderRcp" + i, new Vector4(rcpX, rcpY, rcpZ, rcpW));
                        }
                    }

                    material.SetInt("_IsVersion", 2050);
                }

                if (version < 2070)
                {
                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Impostors/Hemi Standard Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Octahedron Standard Lit");

                        material.SetFloat("_Hemi", 1);
                        material.SetFloat("_AI_Hemi", 1);
                        material.EnableKeyword("_HEMI_ON");
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Impostors/Hemi Subsurface Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Impostors/Octahedron Subsurface Lit");

                        material.SetFloat("_Hemi", 1);
                        material.SetFloat("_AI_Hemi", 1);
                        material.EnableKeyword("_HEMI_ON");
                    }

                    material.SetInt("_IsVersion", 2070);
                }

                if (version < 2100)
                {
                    // Update Simple Lit shaders
                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/General Simple Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/General Standard Lit");
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Geometry/Blanket Simple Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Geometry/Blanket Standard Lit");
                    }

                    if (material.shader.name == ("Hidden/BOXOPHOBIC/The Visual Engine/Landscape/Terrain Simple Lit"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Landscape/Terrain Standard Lit");
                    }

                    // Optimize texture usage
                    if (material.HasProperty("_SecondMaskTex"))
                    {
                        if (material.GetTexture("_SecondMaskTex") == null)
                        {
                            material.SetFloat("_SecondMaskValue", 0);
                        }
                    }

                    if (material.HasProperty("_ThirdMaskTex"))
                    {
                        if (material.GetTexture("_ThirdMaskTex") == null)
                        {
                            material.SetFloat("_ThirdMaskValue", 0);
                        }
                    }

                    material.SetFloat("_ConformPositionValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformHeightValue", 0));
                    material.SetFloat("_ConformPositionMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformHeightOffsetMode", 0));
                    material.SetFloat("_ConformPositionOffsetValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformHeightOffsetValue", 0));
                    material.SetFloat("_ConformRotationValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformNormalValue", 0));

                    // Update Motion
                    material.SetFloat("_MotionBasePushValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionBaseIntensityValue", 0) * BoxoUtils.GetMaterialSerializedFloat(material, "_MotionBasePushValue", 0));
                    material.SetFloat("_MotionSmallPushValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSmallIntensityValue", 0) * BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSmallPushValue", 0));

                    material.SetInt("_IsVersion", 2100);
                }

                if (version < 2120)
                {
                    if (shaderName.Contains("Impostors"))
                    {
                        // Switch to renamed Tex
                        var emissiveTex = BoxoUtils.GetMaterialSerializedTexture(material, "_Emissive", null);

                        material.SetTexture("_Feature", emissiveTex);

                        // Can use Packed tex
                        var impostorMaskMode = BoxoUtils.GetMaterialSerializedFloat(material, "_ImpostorMaskMode", 2);

                        if (impostorMaskMode == 0 || impostorMaskMode == 2)
                        {
                            material.SetFloat("_ImpostorOcclusionValue", 0);
                        }
                    }

                    // Update Coloring masks
                    material.SetFloat("_OcclusionColorMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_OcclusionMeshMode", 1));
                    material.SetVector("_OcclusionColorMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_OcclusionMeshRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_GradientColorMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_GradientMeshMode", 3));
                    material.SetVector("_GradientColorMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_GradientMeshRemap", new Vector4(0, 1, 0, 0)));

                    material.SetVector("_VariationColorNoiseRemap", BoxoUtils.GetMaterialSerializedVector(material, "_VariationMeshRemap", new Vector4(0, 1, 0, 0)));
                    material.SetFloat("_VariationColorNoiseTillingValue", BoxoUtils.GetMaterialSerializedFloat(material, "_VariationNoiseTillingValue", 10));
                    material.SetFloat("_VariationColorNoisePivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_VariationNoisePivotValue", 0));

                    // Update Dither settings
                    var ditherEnabled = BoxoUtils.GetMaterialFloat(material, "_DitherConstantValue") + BoxoUtils.GetMaterialFloat(material, "_DitherProximityValue") + BoxoUtils.GetMaterialFloat(material, "_DitherDistanceValue") + BoxoUtils.GetMaterialFloat(material, "_DitherGlancingValue");

                    if (ditherEnabled > 0)
                    {
                        material.SetFloat("_DitherIntensityValue", 1);
                        // Set Procedural Noise for enabled
                        material.SetFloat("_DitherNoiseMode", 1);
                    }
                    else
                    {
                        material.SetFloat("_DitherNoiseMode", 0);
                        material.SetFloat("_DitherNoiseTillingValue", 100);
                    }

                    // Update Rain tilling
                    material.SetFloat("_WetnessRainIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_WetnessDropsIntensityValue", 0));
                    material.SetFloat("_WetnessRainDistValue", BoxoUtils.GetMaterialSerializedFloat(material, "_WetnessDropsDistValue", 50));

                    // Upgrade Conform
                    material.SetFloat("_ConformIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformPositionValue", 0));
                    material.SetFloat("_ConformMeshValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformMeshValue", 0));
                    material.SetFloat("_ConformMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformMeshMode", 3));
                    material.SetVector("_ConformMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_ConformMeshRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_RotationIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ConformRotationValue", 0));

                    // Upgrade Normal Shading
                    material.SetFloat("_FlattenIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalFlattenValue", 0));
                    material.SetFloat("_FlattenSphereValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalSphereValue", 0));
                    material.SetVector("_FlattenSphereOffsetValue", BoxoUtils.GetMaterialSerializedVector(material, "_NormalSphereOffsetValue", Vector4.zero));

                    material.SetFloat("_FlattenMeshValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalMeshValue", 0));
                    material.SetFloat("_FlattenMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalMeshMode", 3));
                    material.SetVector("_FlattenMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_NormalMeshRemap", new Vector4(0, 1, 0, 0)));

                    // Upgrade Normal Compute
                    material.SetFloat("_ReshadeIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalComputeValue", 0));

                    // Upgrade Normal Conform
                    material.SetFloat("_TransferIntensityValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalConformValue", 0));

                    material.SetFloat("_TransferMeshValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalMeshValue", 0));
                    material.SetFloat("_TransferMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalMeshMode", 3));
                    material.SetVector("_TransferMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_NormalMeshRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_TransferProjValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalProjValue", 0));
                    material.SetVector("_TransferProjRemap", BoxoUtils.GetMaterialSerializedVector(material, "_NormalMeshRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_TransferFormValue", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalFormValue", 0));
                    material.SetFloat("_TransferFormMode", BoxoUtils.GetMaterialSerializedFloat(material, "_NormalFormMode", 1));

                    material.SetInt("_IsVersion", 2120);
                }

                if (version < 2130)
                {
                    material.SetFloat("_GradientBlendAlbedoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GradientDoubleMode", 0));
                    material.SetFloat("_VariationBlendAlbedoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_VariationDoubleMode", 0));
                    material.SetFloat("_TintingBlendAlbedoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TintingDoubleMode", 1));
                    material.SetFloat("_DrynessBlendAlbedoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_DrynessDoubleMode", 1));

                    material.SetInt("_IsVersion", 2130);
                }

                if (version < 2140)
                {
                    if (QualitySettings.activeColorSpace == ColorSpace.Linear)
                    {
                        string[] colorsToGamma = new string[] {
                        "_MainColor",
                        "_MainColorTwo",
                        "_SecondColor",
                        "_SecondColorTwo",
                        "_ThirdColor",
                        "_ThirdColorTwo",
                        "_FourthColor",
                        "_FourthColorTwo",
                        "_OcclusionColorOne",
                        "_OcclusionColorTwo",
                        "_GradientColorOne",
                        "_GradientColorTwo",
                        "_VariationColorOne",
                        "_VariationColorTwo",
                        "_OverlayColor",
                        "_WetnessWaterColor",
                        "_RimLightColor",
                        "_EmissiveColor",
                        "_SubsurfaceColor",
                        "_MotionHighlightColor",
                        "_ImpostorColor",
                        "_ImpostorColorTwo",
                        };

                        for (int i = 0; i < colorsToGamma.Length; i++)
                        {
                            var colorProp = colorsToGamma[i];

                            if (material.HasColor(colorProp))
                            {
                                var linearColor = material.GetColor(colorProp);
                                var gammaColor = linearColor.gamma;
                                material.SetColor(colorProp, gammaColor);
                            }
                        }
                    }

                    material.SetInt("_IsVersion", 2140);
                }

                if (version < 2150)
                {
                    // Set Motion XR
                    material.SetFloat("_RenderMotionXR", BoxoUtils.GetMaterialSerializedFloat(material, "_RenderMotion", 0));

                    // Set old detault values for Layer/Detail
                    material.SetFloat("_SecondMaskMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondMaskMode", 2));
                    material.SetFloat("_SecondMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondMeshMode", 2));
                    material.SetFloat("_ThirdMaskMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdMaskMode", 1));
                    material.SetFloat("_ThirdMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdMeshMode", 1));

                    // Second Color Blend
                    var secondLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_SecondBlendAlbedoValue", 0);
                    var secondColorOne = BoxoUtils.GetMaterialSerializedVector(material, "_SecondColor", Vector4.one);
                    var secondColorTwo = BoxoUtils.GetMaterialSerializedVector(material, "_SecondColorTwo", Vector4.one);

                    material.SetVector("_SecondColor", Vector4.Lerp(secondColorOne, secondColorOne * 2.0f, secondLerp));
                    material.SetVector("_SecondColorTwo", Vector4.Lerp(secondColorTwo, secondColorTwo * 2.0f, secondLerp));

                    // Fourth Color Blend
                    var thirdLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdBlendAlbedoValue", 0);
                    var thirdColorOne = BoxoUtils.GetMaterialSerializedVector(material, "_ThirdColor", Vector4.one);
                    var thirdColorTwo = BoxoUtils.GetMaterialSerializedVector(material, "_ThirdColorTwo", Vector4.one);

                    material.SetVector("_ThirdColor", Vector4.Lerp(thirdColorOne, thirdColorOne * 2.0f, thirdLerp));
                    material.SetVector("_ThirdColorTwo", Vector4.Lerp(thirdColorTwo, thirdColorTwo * 2.0f, thirdLerp));

                    // Fourth Color Blend
                    var fourthLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_FourthBlendAlbedoValue", 0);
                    var fourthColorOne = BoxoUtils.GetMaterialSerializedVector(material, "_FourthColor", Vector4.one);
                    var fourthColorTwo = BoxoUtils.GetMaterialSerializedVector(material, "_FourthColorTwo", Vector4.one);

                    material.SetVector("_FourthColor", Vector4.Lerp(fourthColorOne, fourthColorOne * 2.0f, fourthLerp));
                    material.SetVector("_FourthColorTwo", Vector4.Lerp(fourthColorTwo, fourthColorTwo * 2.0f, fourthLerp));

                    // Gradient Color Blend
                    var gradientLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_GradientBlendAlbedoValue", 0);
                    var gradientColorOne = BoxoUtils.GetMaterialSerializedVector(material, "_GradientColorOne", Vector4.one);
                    var gradientColorTwo = BoxoUtils.GetMaterialSerializedVector(material, "_GradientColorTwo", Vector4.one);

                    material.SetVector("_GradientColorOne", Vector4.Lerp(gradientColorOne, gradientColorOne * 2.0f, gradientLerp));
                    material.SetVector("_GradientColorTwo", Vector4.Lerp(gradientColorTwo, gradientColorTwo * 2.0f, gradientLerp));

                    // Variation Color Blend
                    var variationLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_VariationBlendAlbedoValue", 0);
                    var variationColorOne = BoxoUtils.GetMaterialSerializedVector(material, "_VariationColorOne", Vector4.one);
                    var variationColorTwo = BoxoUtils.GetMaterialSerializedVector(material, "_VariationColorTwo", Vector4.one);

                    material.SetVector("_VariationColorOne", Vector4.Lerp(variationColorOne, variationColorOne * 2.0f, variationLerp));
                    material.SetVector("_VariationColorTwo", Vector4.Lerp(variationColorTwo, variationColorTwo * 2.0f, variationLerp));

                    // Tinting Color Blend
                    var tintingLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_TintingBlendAlbedoValue", 1);
                    var tintingColor = BoxoUtils.GetMaterialSerializedVector(material, "_TintingColor", Vector4.one);

                    material.SetVector("_TintingColor", Vector4.Lerp(tintingColor, tintingColor * 2.0f, tintingLerp));

                    // Dryness Color Blend
                    var drynessLerp = BoxoUtils.GetMaterialSerializedFloat(material, "_DrynessBlendAlbedoValue", 1);
                    var drynessColor = BoxoUtils.GetMaterialSerializedVector(material, "_DrynessColor", Vector4.one);

                    material.SetVector("_DrynessColor", Vector4.Lerp(drynessColor, drynessColor * 2.0f, drynessLerp));

                    //Set external type
                    if (material.GetTag("UseExternalSettings", false) == "False")
                    {
                        material.SetInt("_UseExternalSettings", 0);
                    }

                    //Set object type, might be useful
                    var motionIntensity = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionIntensityValue", 0);
                    var primaryMotion = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionBaseIntensityValue", 0);
                    var secondMotion = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionSmallIntensityValue", 0);
                    var leavesMotion = BoxoUtils.GetMaterialSerializedFloat(material, "_MotionTinyIntensityValue", 0);
                    var pivotsMode = BoxoUtils.GetMaterialSerializedFloat(material, "_ObjectPivotMode", 0);

                    if (motionIntensity > 0)
                    {
                        if (shaderName.Contains("Subsurface"))
                        {
                            if (pivotsMode > 0)
                            {
                                // Grass
                                material.SetInt("_IsObjectType", 6);
                            }
                            else
                            {
                                if (secondMotion > 0 || leavesMotion > 0)
                                {
                                    // Leaf
                                    material.SetInt("_IsObjectType", 3);
                                }
                                else
                                {
                                    // Cross
                                    material.SetInt("_IsObjectType", 7);
                                }
                            }
                        }

                        if (shaderName.Contains("Standard"))
                        {
                            if (pivotsMode > 0)
                            {
                                // Cover
                                material.SetInt("_IsObjectType", 5);
                            }
                            else
                            {
                                // Bark
                                material.SetInt("_IsObjectType", 2);
                            }
                        }
                    }
                    else
                    {
                        // Prop
                        material.SetInt("_IsObjectType", 1);
                    }

                    // Set terrain holes
                    material.SetFloat("_TerrainHolesMode", BoxoUtils.GetMaterialSerializedFloat(material, "_RenderClipping", 0));

                    material.SetInt("_IsVersion", 2150);
                }

                if (version < 2200)
                {
                    // Keep Legacy Maskign Mode to not break blendings
                    material.SetFloat("_SecondBlendMath", 0);
                    material.SetFloat("_ThirdBlendMath", 0);
                    material.SetFloat("_FourthBlendMath", 0);
                    material.SetFloat("_TerrainBlendMath", 0);
                    material.SetFloat("_TintingBlendMath", 0);
                    material.SetFloat("_DrynessBlendMath", 0);
                    material.SetFloat("_OverlayBlendMath", 0);
                    material.SetFloat("_EmissiveBlendMath", 0);

                    // Update Multi Masks
                    material.SetFloat("_MainMultiWriteValue", BoxoUtils.GetMaterialSerializedFloat(material, "_MainMultiValue", 1));
                    material.SetFloat("_MainMultiWriteMode", BoxoUtils.GetMaterialSerializedFloat(material, "_MainMultiMode", 5));
                    material.SetVector("_MainMultiWriteRemap", BoxoUtils.GetMaterialSerializedVector(material, "_MainMultiRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_SecondMultiWriteValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondMultiValue", 1));
                    material.SetFloat("_SecondMultiWriteMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondMultiMode", 1));
                    material.SetVector("_SecondMultiWriteRemap", BoxoUtils.GetMaterialSerializedVector(material, "_SecondMultiRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_ThirdMultiWriteValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdMultiValue", 1));
                    material.SetFloat("_ThirdMultiWriteMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdMultiMode", 1));
                    material.SetVector("_ThirdMultiWriteRemap", BoxoUtils.GetMaterialSerializedVector(material, "_ThirdMultiRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_FourthMultiWriteValue", BoxoUtils.GetMaterialSerializedFloat(material, "_FourthMultiValue", 1));
                    material.SetFloat("_FourthMultiWriteMode", BoxoUtils.GetMaterialSerializedFloat(material, "_FourthMultiMode", 1));
                    material.SetVector("_FourthMultiWriteRemap", BoxoUtils.GetMaterialSerializedVector(material, "_FourthMultiRemap", new Vector4(0, 1, 0, 0)));

                    // Upgrade Fade/Vertx globals
                    material.SetFloat("_GlobalFadeLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalPaintLayerValue", 0));
                    material.SetFloat("_GlobalFadePivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalPaintPivotValue", 0));
                    material.SetFloat("_GlobalVertxLayerValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalFormLayerValue", 0));
                    material.SetFloat("_GlobalVertxPivotValue", BoxoUtils.GetMaterialSerializedFloat(material, "_GlobalFormPivotValue", 0));

                    // Upgrade elements
                    material.SetFloat("_SecondCoatValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondGlobalValue", 1));
                    material.SetFloat("_SecondCoatMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SecondElementMode", 0));

                    material.SetFloat("_ThirdCoatValue", BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdGlobalValue", 1));
                    material.SetFloat("_ThirdCoatMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ThirdElementMode", 0));

                    material.SetFloat("_FourthCoatValue", BoxoUtils.GetMaterialSerializedFloat(material, "_FourthGlobalValue", 1));
                    material.SetFloat("_FourthCoatMode", BoxoUtils.GetMaterialSerializedFloat(material, "_FourthElementMode", 0));

                    material.SetFloat("_TintingPaintValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TintingGlobalValue", 1));
                    material.SetFloat("_TintingPaintMode", BoxoUtils.GetMaterialSerializedFloat(material, "_TintingElementMode", 0));

                    material.SetFloat("_CutoutEffexValue", BoxoUtils.GetMaterialSerializedFloat(material, "_CutoutGlobalValue", 1));
                    material.SetFloat("_CutoutEffexMode", BoxoUtils.GetMaterialSerializedFloat(material, "_CutoutElementMode", 0));

                    material.SetFloat("_DrynessAtmoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_DrynessGlobalValue", 1));
                    material.SetFloat("_DrynessAtmoMode", BoxoUtils.GetMaterialSerializedFloat(material, "_DrynessElementMode", 0));

                    material.SetFloat("_RipplesFlowMode", BoxoUtils.GetMaterialSerializedFloat(material, "_RipplesElementMode", 0));

                    material.SetFloat("_OverlayAtmoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_OverlayGlobalValue", 1));
                    material.SetFloat("_OverlayAtmoMode", BoxoUtils.GetMaterialSerializedFloat(material, "_OverlayElementMode", 0));

                    material.SetFloat("_WetnessAtmoValue", BoxoUtils.GetMaterialSerializedFloat(material, "_WetnessGlobalValue", 1));
                    material.SetFloat("_WetnessAtmoMode", BoxoUtils.GetMaterialSerializedFloat(material, "_WetnessElementMode", 0));

                    material.SetFloat("_EmissiveGlowValue", BoxoUtils.GetMaterialSerializedFloat(material, "_EmissiveGlobalValue", 1));
                    material.SetFloat("_EmissiveGlowMode", BoxoUtils.GetMaterialSerializedFloat(material, "_EmissiveElementMode", 0));

                    material.SetFloat("_SizeFadeVertxValue", BoxoUtils.GetMaterialSerializedFloat(material, "_SizeFadeGlobalValue", 1));
                    material.SetFloat("_SizeFadeVertxMode", BoxoUtils.GetMaterialSerializedFloat(material, "_SizeFadeElementMode", 0));

                    material.SetFloat("_MotionFlowMode", BoxoUtils.GetMaterialSerializedFloat(material, "_MotionElementMode", 0));

                    // Upgrade Wetness remap to match the other base masks
                    //material.SetVector("_WetnessWaterBaseRemap", BoxoUtils.GetMaterialSerializedVector(material, "_WetnessWaterBlendRemap", new Vector4(0.1f, 0, 0, 1)));

                    // Upgrade Normal Conform
                    var transferValue = BoxoUtils.GetMaterialSerializedFloat(material, "_TransferIntensityValue", 0);
                    var transferMode = BoxoUtils.GetMaterialSerializedFloat(material, "_TransferPerPixelMode", 0);

                    if (transferMode == 1)
                    {
                        material.SetFloat("_TransferIntensityValue", 0);
                        material.SetFloat("_CombineIntensityValue", transferValue);
                    }

                    material.SetFloat("_CombineMeshValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TransferMeshValue", 0));
                    material.SetFloat("_CombineMeshMode", BoxoUtils.GetMaterialSerializedFloat(material, "_TransferMeshMode", 3));
                    material.SetVector("_CombineMeshRemap", BoxoUtils.GetMaterialSerializedVector(material, "_TransferMeshRemap", new Vector4(0, 1, 0, 0)));

                    material.SetFloat("_CombineProjValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TransferProjValue", 0));
                    material.SetVector("_CombineProjRemap", BoxoUtils.GetMaterialSerializedVector(material, "_TransferProjRemap", new Vector4(0, 1, 0, 0)));

                    // Upgrade Form Values
                    material.SetFloat("_TerrainFormValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainFormValue", 0) * BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainFormOffsetValue", 0));
                    material.SetFloat("_TerrainFormMath", BoxoUtils.GetMaterialSerializedFloat(material, "_TerrainFormMode", 1) + 1); //Make value 2 is not found

                    material.SetFloat("_CombineFormValue", BoxoUtils.GetMaterialSerializedFloat(material, "_TransferFormValue", 0) * BoxoUtils.GetMaterialSerializedFloat(material, "_TransferFormOffsetValue", 0));
                    material.SetFloat("_CombineFormMath", BoxoUtils.GetMaterialSerializedFloat(material, "_TransferFormMode", 1) + 1); //Make value 2 is not found

                    material.SetInt("_IsVersion", 2200);
                }
#endif
            }

        }

        public static void SetMaterialRuntime(Material material)
        {
            var projectPipeline = BoxoUtils.GetProjectPipeline();
            var shaderName = material.shader.name;

            //if (TVEGlobals.shaderDataList == null)
            //{
            //    TVEGlobals.shaderDataList = new List<string>();

            //    var allPresetPaths = BoxoUtils.FindAssets("*.tvepreset", false);
            //    var shaderPresetPaths = new List<string>();

            //    for (int i = 0; i < allPresetPaths.Length; i++)
            //    {
            //        string assetPath = allPresetPaths[i];

            //        if (assetPath.Contains("[SHADER]"))
            //        {
            //            shaderPresetPaths.Add(assetPath);
            //        }
            //    }

            //    for (int i = 0; i < shaderPresetPaths.Count; i++)
            //    {
            //        StreamReader reader = new StreamReader(shaderPresetPaths[i]);

            //        while (!reader.EndOfStream)
            //        {
            //            TVEGlobals.shaderDataList.Add(reader.ReadLine());
            //        }

            //        reader.Close();
            //    }
            //}

            //for (int s = 0; s < TVEGlobals.shaderDataList.Count; s++)
            //{
            //    var shaderData = TVEGlobals.shaderDataList[s];

            //    if (shaderData.StartsWith("SetCoords"))
            //    {
            //        var data = shaderData.Replace("SetCoords ", "").Split(" ");

            //        BoxoUtils.SetMaterialCoords(material, data[0], data[1], data[2]);
            //    }
            //}

            BoxoUtils.SetMaterialCoords(material, "_MainCoordMode", "_MainCoordValue", "_main_coord_value");
            BoxoUtils.SetMaterialVector(material, "_main_coord_value", "_MainAlbedoTex_ST");
            BoxoUtils.SetMaterialVector(material, "_main_coord_value", "_MainAlbedoTex_ST");
            BoxoUtils.SetMaterialVector(material, "_main_coord_value", "_MainAlbedoTex_ST");

            BoxoUtils.SetMaterialCoords(material, "_SecondCoordMode", "_SecondCoordValue", "_second_coord_value");
            BoxoUtils.SetMaterialVector(material, "_second_coord_value", "_SecondAlbedoTex_ST");
            BoxoUtils.SetMaterialVector(material, "_second_coord_value", "_SecondNormalTex_ST");
            BoxoUtils.SetMaterialVector(material, "_second_coord_value", "_SecondShaderTex_ST");
            BoxoUtils.SetMaterialCoords(material, "_SecondMaskCoordMode", "_SecondMaskCoordValue", "_second_mask_coord_value");
            BoxoUtils.SetMaterialVector(material, "_second_mask_coord_value", "_SecondMaskTex_ST");

            BoxoUtils.SetMaterialCoords(material, "_ThirdCoordMode", "_ThirdCoordValue", "_third_coord_value");
            BoxoUtils.SetMaterialVector(material, "_third_coord_value", "_ThirdAlbedoTex_ST");
            BoxoUtils.SetMaterialVector(material, "_third_coord_value", "_ThirdNormalTex_ST");
            BoxoUtils.SetMaterialVector(material, "_third_coord_value", "_ThirdShaderTex_ST");
            BoxoUtils.SetMaterialCoords(material, "_ThirdMaskCoordMode", "_ThirdMaskCoordValue", "_third_mask_coord_value");
            BoxoUtils.SetMaterialVector(material, "_third_mask_coord_value", "_ThirdMaskTex_ST");

            BoxoUtils.SetMaterialCoords(material, "_FourthCoordMode", "_FourthCoordValue", "_fourth_coord_value");
            BoxoUtils.SetMaterialVector(material, "_fourth_coord_value", "_FourthAlbedoTex_ST");
            BoxoUtils.SetMaterialVector(material, "_fourth_coord_value", "_FourthNormalTex_ST");
            BoxoUtils.SetMaterialVector(material, "_fourth_coord_value", "_FourthShaderTex_ST");
            BoxoUtils.SetMaterialCoords(material, "_FourthMaskCoordMode", "_FourthMaskCoordValue", "_fourth_mask_coord_value");
            BoxoUtils.SetMaterialVector(material, "_fourth_mask_coord_value", "_FourthMaskTex_ST");

            BoxoUtils.SetMaterialCoords(material, "_TerrainMaskCoordMode", "_TerrainMaskCoordValue", "_terrain_mask_coord_value");
            BoxoUtils.SetMaterialCoords(material, "_TintingMaskCoordMode", "_TintngMaskCoordValue", "_tinting_mask_coord_value");
            BoxoUtils.SetMaterialCoords(material, "_DrynessMaskCoordMode", "_DrynessMaskCoordValue", "_dryness_mask_coord_value");
            BoxoUtils.SetMaterialCoords(material, "_OverlayCoordMode", "_OverlayCoordValue", "_overlay_coord_value");
            BoxoUtils.SetMaterialCoords(material, "_OverlayMaskCoordMode", "_OverlayMaskCoordValue", "_overlay_mask_coord_value");

            BoxoUtils.SetMaterialCoords(material, "_EmissiveCoordMode", "_EmissiveCoordValue", "_emissive_coord_value");
            BoxoUtils.SetMaterialVector(material, "_emissive_coord_value", "_EmissiveMaskTex_ST");

            BoxoUtils.SetMaterialReciprocal(material, "_MainMultiWriteRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MainOcclusionRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MainSmoothnessRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondMultiWriteRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondOcclusionRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondSmoothnessRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SecondBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdMultiWriteRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdOcclusionRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdSmoothnessRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ThirdBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthMultiWriteRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthOcclusionRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthSmoothnessRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FourthBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TerrainBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TerrainMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TerrainProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TerrainMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TerrainBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ColormapMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OcclusionColorMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_GradientColorMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_GradientColorNoiseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_GradientColorBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_VariationColorNoiseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TintingMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TintingLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TintingMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TintingBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SeasonRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SeasonLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SeasonMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SeasonBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_CutoutMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_DrynessMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_DrynessLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_DrynessMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_DrynessBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OverlayMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OverlayBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OverlayLumaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OverlayProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OverlayMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_OverlayBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_WetnessWaterMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_WetnessWaterBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_WetnessWaterBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_WetnessRainMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_DitherGlancingRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_DitherMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_RimLightRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_EmissiveMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_EmissiveMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_EmissiveBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SizeFadeBlendRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_RipplesBaseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MotionBaseMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MotionSmallMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MotionTinyMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MotionHighlightRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_FlattenMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ConformMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_TransferMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_CombineMeshRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_CombineProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_CombineBlendRemap");

            BoxoUtils.SetMaterialFloat(material, "_ImpostorAlphaClipValue", "_AI_Clip");
            BoxoUtils.SetMaterialBool(material, "_MotionSmallIntensityValue", "_motion_small_mode");
            BoxoUtils.SetMaterialVector(material, "_MotionHighlightColor", "_motion_highlight_color");

            //var layerCoatMode = BoxoUtils.GetMaterialFloat(material, "_SecondIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_SecondCoatValue", 0) * BoxoUtils.GetMaterialFloat(material, "_SecondCoatMode", 0);
            //var detailCoatMode = BoxoUtils.GetMaterialFloat(material, "_ThirdIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_ThirdCoatValue", 0) * BoxoUtils.GetMaterialFloat(material, "_ThirdCoatMode", 0);
            //var stackCoatMode = BoxoUtils.GetMaterialFloat(material, "_FourthIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_FourthCoatValue", 0) * BoxoUtils.GetMaterialFloat(material, "_FourthCoatMode", 0);
            //var colormapDrawMode = BoxoUtils.GetMaterialFloat(material, "_ColormapIntensityValue", 0);
            //var tintingPaintMode = BoxoUtils.GetMaterialFloat(material, "_TintingIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_TintingPaintValue", 0) * BoxoUtils.GetMaterialFloat(material, "_TintingPaintMode", 0);
            //var cutoutFadeMode = BoxoUtils.GetMaterialFloat(material, "_CutoutIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_CutoutFadeValue", 0) * BoxoUtils.GetMaterialFloat(material, "_CutoutFadeMode", 0);
            //var drynessAtmoMode = BoxoUtils.GetMaterialFloat(material, "_DrynessIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_DrynessAtmoValue", 0) * BoxoUtils.GetMaterialFloat(material, "_DrynessAtmoMode", 0);
            //var overlayAtmoMode = BoxoUtils.GetMaterialFloat(material, "_OverlayIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_OverlayAtmoValue", 0) * BoxoUtils.GetMaterialFloat(material, "_OverlayAtmoMode", 0);
            //var wetnessAtmoMode = BoxoUtils.GetMaterialFloat(material, "_WetnessIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_WetnessAtmoValue", 0) * BoxoUtils.GetMaterialFloat(material, "_WetnessAtmoMode", 0);
            //var emissiveGlowMode = BoxoUtils.GetMaterialFloat(material, "_EmissiveIntensityValue", 0);
            //var conformFormMode = BoxoUtils.GetMaterialFloat(material, "_ConformIntensityValue", 0);
            //var rotationFormMode = BoxoUtils.GetMaterialFloat(material, "_RotationIntensityValue", 0);
            //var transferFormMode = BoxoUtils.GetMaterialFloat(material, "_TransferIntensityValue", 0);
            //var combineFormMode = BoxoUtils.GetMaterialFloat(material, "_CombineIntensityValue", 0);
            //var sizeFadeVertxMode = BoxoUtils.GetMaterialFloat(material, "_SizeFadeIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_SizeFadeVertxValue", 0) * BoxoUtils.GetMaterialFloat(material, "_SizeFadeVertxMode", 0);
            //var motionFlowMode = BoxoUtils.GetMaterialFloat(material, "_MotionIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_MotionFlowMode", 0);
            //var ripplesFlowMode = BoxoUtils.GetMaterialFloat(material, "_RipplesIntensityValue", 0) * BoxoUtils.GetMaterialFloat(material, "_RipplesFlowMode", 0);

            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_COAT", layerCoatMode + detailCoatMode + stackCoatMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_DRAW", colormapDrawMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_PAINT", tintingPaintMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_FADE", cutoutFadeMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_ATMO", drynessAtmoMode + overlayAtmoMode + wetnessAtmoMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_GLOW", emissiveGlowMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_FORM", conformFormMode + rotationFormMode + transferFormMode + combineFormMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_VERTX", sizeFadeVertxMode);
            //BoxoUtils.SetMaterialKeyword(material, "TVE_GLOBAL_FLOW", motionFlowMode + ripplesFlowMode);

            BoxoUtils.SetMaterialKeywordInverted(material, "_ObjectModelMode", "TVE_LEGACY");
            BoxoUtils.SetMaterialKeyword(material, "_ObjectCoordMode", "TVE_COORD_ZUP");
            BoxoUtils.SetMaterialKeyword(material, "_ObjectPivotMode", new string[] { "TVE_PIVOT_SINGLE", "TVE_PIVOT_BAKED", "TVE_PIVOT_PROC", "TVE_PIVOT_PHASE" });
            BoxoUtils.SetMaterialKeyword(material, "_RenderClip", "TVE_CLIPPING");
            BoxoUtils.SetMaterialKeyword(material, "_RenderFilter", new string[] { "TVE_FILTER_DEFAULT", "TVE_FILTER_POINT", "TVE_FILTER_LOW", "TVE_FILTER_MEDIUM", "TVE_FILTER_HIGH" });
            BoxoUtils.SetMaterialKeyword(material, "_ImpostorMaskMode", new string[] { "TVE_IMPOSTOR_MASK_OFF", "TVE_IMPOSTOR_MASK_DEFAULT", "TVE_IMPOSTOR_MASK_PACKED", "TVE_IMPOSTOR_MASK_SHADING" });
            BoxoUtils.SetMaterialKeyword(material, "_MainSampleMode", new string[] { "TVE_MAIN_SAMPLE_MAIN_UV", "TVE_MAIN_SAMPLE_EXTRA_UV", "TVE_MAIN_SAMPLE_PLANAR_2D", "TVE_MAIN_SAMPLE_PLANAR_3D", "TVE_MAIN_SAMPLE_STOCHASTIC_2D", "TVE_MAIN_SAMPLE_STOCHASTIC_3D" });

            BoxoUtils.SetMaterialKeyword(material, "_SecondIntensityValue", "TVE_SECOND");
            BoxoUtils.SetMaterialKeyword(material, "_SecondIntensityValue", "_SecondMaskValue", "TVE_SECOND_MASK");
            BoxoUtils.SetMaterialKeyword(material, "_SecondIntensityValue", "_SecondSampleMode", new string[] { "TVE_SECOND_SAMPLE_MAIN_UV", "TVE_SECOND_SAMPLE_EXTRA_UV", "TVE_SECOND_SAMPLE_PLANAR_2D", "TVE_SECOND_SAMPLE_PLANAR_3D", "TVE_SECOND_SAMPLE_STOCHASTIC_2D", "TVE_SECOND_SAMPLE_STOCHASTIC_3D" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_SecondIntensityValue", "_SecondMaskValue" }, "_SecondMaskSampleMode", new string[] { "TVE_SECOND_MASK_SAMPLE_MAIN_UV", "TVE_SECOND_MASK_SAMPLE_EXTRA_UV", "TVE_SECOND_MASK_SAMPLE_PLANAR_2D", "TVE_SECOND_MASK_SAMPLE_PLANAR_3D" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_SecondIntensityValue", "_SecondCoatValue", "_SecondCoatMode" }, "TVE_SECOND_COAT");

            BoxoUtils.SetMaterialKeyword(material, "_ThirdIntensityValue", "TVE_THIRD");
            BoxoUtils.SetMaterialKeyword(material, "_ThirdIntensityValue", "_ThirdMaskValue", "TVE_THIRD_MASK");
            BoxoUtils.SetMaterialKeyword(material, "_ThirdIntensityValue", "_ThirdSampleMode", new string[] { "TVE_THIRD_SAMPLE_MAIN_UV", "TVE_THIRD_SAMPLE_EXTRA_UV", "TVE_THIRD_SAMPLE_PLANAR_2D", "TVE_THIRD_SAMPLE_PLANAR_3D", "TVE_THIRD_SAMPLE_STOCHASTIC_2D", "TVE_THIRD_SAMPLE_STOCHASTIC_3D" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_ThirdIntensityValue", "_ThirdMaskValue" }, "_ThirdMaskSampleMode", new string[] { "TVE_THIRD_MASK_SAMPLE_MAIN_UV", "TVE_THIRD_MASK_SAMPLE_EXTRA_UV", "TVE_THIRD_MASK_SAMPLE_PLANAR_2D", "TVE_THIRD_MASK_SAMPLE_PLANAR_3D" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_ThirdIntensityValue", "_ThirdCoatValue", "_ThirdCoatMode" }, "TVE_THIRD_COAT");

            BoxoUtils.SetMaterialKeyword(material, "_FourthIntensityValue", "TVE_FOURTH");
            BoxoUtils.SetMaterialKeyword(material, "_FourthIntensityValue", "_FourthMaskValue", "TVE_FOURTH_MASK");
            BoxoUtils.SetMaterialKeyword(material, "_FourthIntensityValue", "_FourthSampleMode", new string[] { "TVE_FOURTH_SAMPLE_MAIN_UV", "TVE_FOURTH_SAMPLE_EXTRA_UV", "TVE_FOURTH_SAMPLE_PLANAR_2D", "TVE_FOURTH_SAMPLE_PLANAR_3D", "TVE_FOURTH_SAMPLE_STOCHASTIC_2D", "TVE_FOURTH_SAMPLE_STOCHASTIC_3D" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_FourthIntensityValue", "_FourthMaskValue" }, "_FourthMaskSampleMode", new string[] { "TVE_FOURTH_MASK_SAMPLE_MAIN_UV", "TVE_FOURTH_MASK_SAMPLE_EXTRA_UV", "TVE_FOURTH_MASK_SAMPLE_PLANAR_2D", "TVE_FOURTH_MASK_SAMPLE_PLANAR_3D" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_FourthIntensityValue", "_FourthCoatValue", "_FourthCoatMode" }, "TVE_FOURTH_COAT");

            BoxoUtils.SetMaterialKeyword(material, "_TerrainIntensityValue", "TVE_TERRAIN");
            BoxoUtils.SetMaterialKeyword(material, "_TerrainIntensityValue", "_TerrainMaskSampleMode", new string[] { "TVE_TERRAIN_MASK_SAMPLE_MAIN_UV", "TVE_TERRAIN_MASK_SAMPLE_EXTRA_UV", "TVE_TERRAIN_MASK_SAMPLE_PLANAR_2D", "TVE_TERRAIN_MASK_SAMPLE_PLANAR_3D" });

            BoxoUtils.SetMaterialKeyword(material, "_DualColorIntensityValue", "TVE_DUAL_COLOR");
            BoxoUtils.SetMaterialKeyword(material, "_OcclusionIntensityValue", "TVE_OCCLUSION");
            BoxoUtils.SetMaterialKeyword(material, "_GradientIntensityValue", "TVE_GRADIENT");
            BoxoUtils.SetMaterialKeyword(material, "_VariationIntensityValue", "TVE_VARIATION");
            BoxoUtils.SetMaterialKeyword(material, "_ColormapIntensityValue", "TVE_COLORMAP");
            BoxoUtils.SetMaterialKeyword(material, "_SeasonIntensityValue", "TVE_SEASON");

            BoxoUtils.SetMaterialKeyword(material, "_TintingIntensityValue", "TVE_TINTING");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_TintingIntensityValue", "_TintingPaintValue", "_TintingPaintMode" }, "TVE_TINTING_PAINT");

            BoxoUtils.SetMaterialKeyword(material, "_CutoutIntensityValue", "TVE_CUTOUT");
            BoxoUtils.SetMaterialKeyword(material, "_CutoutIntensityValue", "_CutoutShadowMode", "TVE_CUTOUT_SHADOW");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_CutoutIntensityValue", "_CutoutEffexValue", "_CutoutEffexMode" }, "TVE_CUTOUT_EFFEX");

            BoxoUtils.SetMaterialKeyword(material, "_DrynessIntensityValue", "TVE_DRYNESS");
            BoxoUtils.SetMaterialKeyword(material, "_DrynessIntensityValue", "_DrynessShiftValue", "TVE_DRYNESS_SHIFT");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_DrynessIntensityValue", "_DrynessAtmoValue", "_DrynessAtmoMode" }, "TVE_DRYNESS_ATMO");

            BoxoUtils.SetMaterialKeyword(material, "_OverlayIntensityValue", "TVE_OVERLAY");
            BoxoUtils.SetMaterialKeyword(material, "_OverlayIntensityValue", "_OverlayTextureMode", "TVE_OVERLAY_TEX");
            BoxoUtils.SetMaterialKeyword(material, "_OverlayIntensityValue", "_OverlaySampleMode", new string[] { "TVE_OVERLAY_SAMPLE_PLANAR_2D", "TVE_OVERLAY_SAMPLE_PLANAR_3D", "TVE_OVERLAY_SAMPLE_STOCHASTIC_2D", "TVE_OVERLAY_SAMPLE_STOCHASTIC_3D" });
            BoxoUtils.SetMaterialKeyword(material, "_OverlayIntensityValue", "_OverlayMaskSampleMode", new string[] { "TVE_OVERLAY_MASK_SAMPLE_MAIN_UV", "TVE_OVERLAY_MASK_SAMPLE_EXTRA_UV" });
            BoxoUtils.SetMaterialKeyword(material, "_OverlayIntensityValue", "_OverlayGlitterIntensityValue", "TVE_OVERLAY_GLITTER");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_OverlayIntensityValue", "_OverlayAtmoValue", "_OverlayAtmoMode" }, "TVE_OVERLAY_ATMO");

            BoxoUtils.SetMaterialKeyword(material, "_WetnessIntensityValue", "TVE_WETNESS");
            BoxoUtils.SetMaterialKeyword(material, "_WetnessIntensityValue", "_WetnessWaterIntensityValue", "TVE_WETNESS_WATER");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_WetnessIntensityValue", "_WetnessRainIntensityValue" }, "_WetnessDropsIntensityValue", "TVE_WETNESS_DROPS");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_WetnessIntensityValue", "_WetnessRainIntensityValue" }, "_WetnessDripsIntensityValue", "TVE_WETNESS_DRIPS");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_WetnessIntensityValue", "_WetnessAtmoValue", "_DrynessAtmoMode" }, "TVE_WETNESS_ATMO");

            BoxoUtils.SetMaterialKeyword(material, "_SeasonIntensityValue", "TVE_SEAOSON");

            BoxoUtils.SetMaterialKeyword(material, "_DitherIntensityValue", "TVE_DITHER");
            BoxoUtils.SetMaterialKeyword(material, "_DitherIntensityValue", "_DitherShadowMode", "TVE_DITHER_SHADOW");
            BoxoUtils.SetMaterialKeyword(material, "_DitherIntensityValue", "_DitherNoiseMode", new string[] { "TVE_DITHER_NOISE_BAYER", "TVE_DITHER_NOISE_OPTIMAL_3D" });

            BoxoUtils.SetMaterialKeyword(material, "_RimLightIntensityValue", "TVE_RIMLIGHT");

            BoxoUtils.SetMaterialKeyword(material, "_EmissiveIntensityValue", "TVE_EMISSIVE");
            BoxoUtils.SetMaterialKeyword(material, "_EmissiveIntensityValue", "_EmissiveSampleMode", new string[] { "TVE_EMISSIVE_SAMPLE_MAIN_UV", "TVE_EMISSIVE_SAMPLE_EXTRA_UV" });
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_EmissiveIntensityValue", "_EmissiveGlowValue", "_EmissiveGlowMode" }, "TVE_EMISSIVE_GLOW");

            BoxoUtils.SetMaterialKeyword(material, "_SubsurfaceIntensityValue", "TVE_SUBSURFACE");

            BoxoUtils.SetMaterialKeyword(material, "_PerspectiveIntensityValue", "TVE_PERSPECTIVE");

            BoxoUtils.SetMaterialKeyword(material, "_SizeFadeIntensityValue", "TVE_SIZEFADE");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_SizeFadeIntensityValue", "_SizeFadeVertxValue", "_SizeFadeVertxMode" }, "TVE_SIZEFADE_VERTX");

            BoxoUtils.SetMaterialKeyword(material, "_RipplesIntensityValue", "TVE_RIPPLES");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_RipplesIntensityValue", "_RipplesFlowValue", "_RipplesFlowMode" }, "TVE_RIPPLES_FLOW");

            BoxoUtils.SetMaterialKeyword(material, "_MotionIntensityValue", "TVE_MOTION");
            BoxoUtils.SetMaterialKeyword(material, true, new string[] { "_MotionIntensityValue", "_MotionFlowValue", "_MotionFlowMode" }, "TVE_MOTION_FLOW");

            BoxoUtils.SetMaterialKeyword(material, "_FlattenIntensityValue", "TVE_FLATTEN");
            BoxoUtils.SetMaterialKeyword(material, "_ReshadeIntensityValue", "TVE_RESHADE");

            BoxoUtils.SetMaterialKeyword(material, "_ConformIntensityValue", "TVE_CONFORM");
            BoxoUtils.SetMaterialKeyword(material, "_RotationIntensityValue", "TVE_ROTATION");
            BoxoUtils.SetMaterialKeyword(material, "_TransferIntensityValue", "TVE_TRANSFER");
            BoxoUtils.SetMaterialKeyword(material, "_CombineIntensityValue", "TVE_COMBINE");

            BoxoUtils.SetMaterialKeyword(material, "_TerrainRenderMode", "TVE_TERRAIN_PROXY");
            BoxoUtils.SetMaterialKeyword(material, "_TerrainTextureMode", new string[] { "TVE_TERRAIN_TEX_DEFAULT", "TVE_TERRAIN_TEX_PACKED" });
            BoxoUtils.SetMaterialKeyword(material, "_TerrainHolesMode", "TVE_TERRAIN_HOLES");
            BoxoUtils.SetMaterialKeyword(material, "_TerrainRemapMode", "TVE_TERRAIN_REMAP");
            BoxoUtils.SetMaterialKeyword(material, "_TerrainColorMode", "TVE_TERRAIN_COLOR");
            BoxoUtils.SetMaterialKeyword(material, "_TerrainHeightBlendValue", "TVE_TERRAIN_BLEND");
            BoxoUtils.SetMaterialKeyword(material, "_TerrainNormalPerPixelMode", "TVE_TERRAIN_NORMAL_PER_PIXEL");

            if (material.HasProperty("_TerrainLayersMode"))
            {
                var mode = material.GetInt("_TerrainLayersMode");

                if (mode == 1)
                {
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_01", true);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_04", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_08", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_12", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_16", false);
                }
                else if (mode == 4)
                {
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_01", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_04", true);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_08", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_12", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_16", false);
                }
                else if (mode == 8)
                {
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_01", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_04", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_08", true);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_12", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_16", false);
                }
                else if (mode == 12)
                {
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_01", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_04", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_08", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_12", true);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_16", false);
                }
                else if (mode == 16)
                {
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_01", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_04", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_08", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_12", false);
                    BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_16", true);
                }
            }

            // Set Terrain Mode
            if (material.HasProperty("_TerrainSampleMode1"))
            {
                for (int i = 1; i < 17; i++)
                {
                    var prop = "_TerrainSampleMode" + i;

                    if (material.HasProperty(prop))
                    {
                        var layer = i.ToString("00");
                        var mode = material.GetInt(prop);

                        if (mode == 0)
                        {
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_2D", true);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_3D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_2D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_3D", false);
                        }
                        else if (mode == 1)
                        {
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_2D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_3D", true);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_2D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_3D", false);
                        }
                        else if (mode == 2)
                        {
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_2D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_3D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_2D", true);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_3D", false);
                        }
                        else if (mode == 3)
                        {
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_2D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_PLANAR_3D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_2D", false);
                            BoxoUtils.SetMaterialKeyword(material, "TVE_TERRAIN_SAMPLE_" + layer + "_STOCHASTIC_3D", true);
                        }
                    }
                }
            }

            if (material.HasProperty("_EmissiveIntensityValue"))
            {
                // Set Intensity Mode
                if (material.HasProperty("_EmissivePowerMode") && material.HasProperty("_EmissivePowerValue"))
                {
                    float power = material.GetInt("_EmissivePowerMode");
                    float value = material.GetFloat("_EmissivePowerValue");

                    if (power == 0)
                    {
                        material.SetFloat("_emissive_power_value", value);
                    }
                    else if (power == 1)
                    {
                        material.SetFloat("_emissive_power_value", (12.5f / 100.0f) * Mathf.Pow(2f, value));
                    }
                }

                // Set GI Mode
                if (material.HasProperty("_EmissiveFlagMode"))
                {
                    int flag = material.GetInt("_EmissiveFlagMode");

                    if (flag == 0)
                    {
                        material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.None;
                    }
                    else if (flag == 1)
                    {
                        material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.AnyEmissive;
                    }
                    else if (flag == 2)
                    {
                        material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.BakedEmissive;
                    }
                    else if (flag == 3)
                    {
                        material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;
                    }
                }
            }

            if (material.HasProperty("_SubsurfaceIntensityValue"))
            {
                // Legacy Surface Shader
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceScatteringValue", "_Translucency");
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceNormalValue", "_TransNormalDistortion");

                // Lit Template
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceScatteringValue", "_TransStrength");
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceNormalValue", "_TransNormal");
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceAngleValue", "_TransScattering");
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceDirectValue", "_TransDirect");
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceAmbientValue", "_TransAmbient");
                BoxoUtils.SetMaterialFloat(material, "_SubsurfaceShadowValue", "_TransShadow");
            }

            if (material.HasProperty("_MetaEnabledMode"))
            {
                var overrideMode = BoxoUtils.GetMaterialInt(material, "_MetaEnabledMode");

                if (overrideMode == 1)
                {
                    var metaSurfaceMode = BoxoUtils.GetMaterialInt(material, "_MetaSurfaceMode");

                    if (metaSurfaceMode == 0)
                    {
                        BoxoUtils.SetMaterialTexture(material, "_MainAlbedoTex", "_MetaAlbedoTex");
                        BoxoUtils.SetMaterialVector(material, "_MainColor", "_MetaAlbedoColor");
                        BoxoUtils.SetMaterialFloat(material, "_MainAlbedoValue", "_MetaAlbedoValue");
                        BoxoUtils.SetMaterialVector(material, "_main_coord_value", "_MetaCoordValue");

                        var secondMode = BoxoUtils.GetMaterialFloat(material, "_SecondIntensityValue");

                        if (secondMode > 0)
                        {
                            BoxoUtils.SetMaterialTexture(material, "_SecondAlbedoTex", "_MetaAlbedoex");
                            BoxoUtils.SetMaterialVector(material, "_SecondColor", "_MetaAlbedoColor");
                            BoxoUtils.SetMaterialFloat(material, "_SecondAlbedoValue", "_MetaAlbedoValue");
                            BoxoUtils.SetMaterialVector(material, "_second_coord_value", "_MetaCoordValue");
                        }

                        var thirdMode = BoxoUtils.GetMaterialFloat(material, "_ThirdIntensityValue");

                        if (thirdMode > 0)
                        {
                            BoxoUtils.SetMaterialTexture(material, "_ThirdAlbedoTex", "_MetaAlbedoTex");
                            BoxoUtils.SetMaterialVector(material, "_ThirdColor", "_MetaAlbedoColor");
                            BoxoUtils.SetMaterialFloat(material, "_ThirdAlbedoValue", "_MetaAlbedoalue");
                            BoxoUtils.SetMaterialVector(material, "_third_coord_value", "_MetaCoordValue");
                        }

                        var fourthMode = BoxoUtils.GetMaterialFloat(material, "_FourthIntensityValue");

                        if (fourthMode > 0)
                        {
                            BoxoUtils.SetMaterialTexture(material, "_FourthAlbedoTex", "_MetaAlbedoTex");
                            BoxoUtils.SetMaterialVector(material, "_FourthColor", "_MetaAlbedoColor");
                            BoxoUtils.SetMaterialFloat(material, "_FourthAlbedoValue", "_MetaAlbedoalue");
                            BoxoUtils.SetMaterialVector(material, "_fourth_coord_value", "_MetaCoordValue");
                        }
                    }

                    var uvMode = BoxoUtils.GetMaterialInt(material, "_MetaSampleMode");

                    if (uvMode == 1)
                    {
                        material.SetVector("_MetaCoordValue", new Vector4(1, 1, 0, 0));
                    }
                }
            }

            // Set Internal Render Values

            int renderMode = BoxoUtils.GetMaterialInt(material, "_RenderMode");
            float renderClip = BoxoUtils.GetMaterialFloat(material, "_RenderClip") + BoxoUtils.GetMaterialFloat(material, "_CutoutIntensityValue") + BoxoUtils.GetMaterialFloat(material, "_DitherIntensityValue");
            int renderDecals = BoxoUtils.GetMaterialInt(material, "_RenderDecals");
            int renderSSR = BoxoUtils.GetMaterialInt(material, "_RenderSSR");

            int queue = 0;
            int priority = 0;

            if (material.HasProperty("_RenderQueue") && material.HasProperty("_RenderPriority"))
            {
                queue = material.GetInt("_RenderQueue");
                priority = material.GetInt("_RenderPriority");
            }

            // User Defined, render type changes needed
            if (queue == 2)
            {
                if (material.renderQueue == 2000)
                {
                    material.SetOverrideTag("RenderType", "Opaque");
                }

                if (material.renderQueue > 2449 && material.renderQueue < 3000)
                {
                    material.SetOverrideTag("RenderType", "TransparentCutout");
                }

                if (material.renderQueue > 2999)
                {
                    material.SetOverrideTag("RenderType", "Transparent");
                }
            }

            // Opaque
            if (renderMode == 0)
            {
                if (queue != 2)
                {
                    material.SetOverrideTag("RenderType", "TransparentCutout");
                    //material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest + priority;

                    if (renderClip == 0)
                    {
                        if (renderDecals == 0)
                        {
                            material.renderQueue = 2000 + priority;
                        }
                        else
                        {
                            material.renderQueue = 2225 + priority;
                        }
                    }
                    else
                    {
                        if (renderDecals == 0)
                        {
                            material.renderQueue = 2450 + priority;
                        }
                        else
                        {
                            material.renderQueue = 2475 + priority;
                        }
                    }
                }

                // Standard and Universal Render Pipeline
                material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_render_zw", 1);

                // Set Main Color alpha to 1
                //if (material.HasProperty("_MainColor"))
                //{
                //    var color = material.GetColor("_MainColor");
                //    material.SetColor("_MainColor", new Color(color.r, color.g, color.b, 1.0f));
                //}

                //if (material.HasProperty("_MainColorTwo"))
                //{
                //    var color = material.GetColor("_MainColorTwo");
                //    material.SetColor("_MainColorTwo", new Color(color.r, color.g, color.b, 1.0f));
                //}

                // HD Render Pipeline
                material.DisableKeyword("_SURFACE_TYPE_TRANSPARENT");
                material.DisableKeyword("_ENABLE_FOG_ON_TRANSPARENT");

                material.DisableKeyword("_BLENDMODE_ALPHA");
                material.DisableKeyword("_BLENDMODE_ADD");
                material.DisableKeyword("_BLENDMODE_PRE_MULTIPLY");

                material.SetInt("_RenderQueueType", 1);
                material.SetInt("_SurfaceType", 0);
                material.SetInt("_BlendMode", 0);
                material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_AlphaSrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_AlphaDstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);
                material.SetInt("_TransparentZWrite", 1);
                material.SetInt("_ZTestDepthEqualForOpaque", 3);

                if (renderClip == 0)
                {
                    material.SetInt("_ZTestGBuffer", 4);
                }
                else
                {
                    material.SetInt("_ZTestGBuffer", 3);
                }

                //material.SetInt("_ZTestGBuffer", 4);
                material.SetInt("_ZTestTransparent", 4);

                material.SetShaderPassEnabled("TransparentBackface", false);
                material.SetShaderPassEnabled("TransparentBackfaceDebugDisplay", false);
                material.SetShaderPassEnabled("TransparentDepthPrepass", false);
                material.SetShaderPassEnabled("TransparentDepthPostpass", false);
            }
            // Transparent
            else
            {
                if (queue != 2)
                {
                    material.SetOverrideTag("RenderType", "Transparent");
                    material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent + priority;
                }

                int zwrite = 1;

                if (material.HasProperty("_RenderZWrite"))
                {
                    zwrite = material.GetInt("_RenderZWrite");
                }

                // Standard and Universal Render Pipeline
                material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                material.SetInt("_render_zw", zwrite);

                // HD Render Pipeline
                material.EnableKeyword("_SURFACE_TYPE_TRANSPARENT");
                material.EnableKeyword("_ENABLE_FOG_ON_TRANSPARENT");

                material.EnableKeyword("_BLENDMODE_ALPHA");
                material.DisableKeyword("_BLENDMODE_ADD");
                material.DisableKeyword("_BLENDMODE_PRE_MULTIPLY");

                material.SetInt("_RenderQueueType", 5);
                material.SetInt("_SurfaceType", 1);
                material.SetInt("_BlendMode", 0);
                material.SetInt("_SrcBlend", 1);
                material.SetInt("_DstBlend", 10);
                material.SetInt("_AlphaSrcBlend", 1);
                material.SetInt("_AlphaDstBlend", 10);
                material.SetInt("_ZWrite", zwrite);
                material.SetInt("_TransparentZWrite", zwrite);
                material.SetInt("_ZTestDepthEqualForOpaque", 4);
                material.SetInt("_ZTestGBuffer", 4);
                material.SetInt("_ZTestTransparent", 4);

                material.SetShaderPassEnabled("TransparentBackface", true);
                material.SetShaderPassEnabled("TransparentBackfaceDebugDisplay", true);
                material.SetShaderPassEnabled("TransparentDepthPrepass", true);
                material.SetShaderPassEnabled("TransparentDepthPostpass", true);
            }

            // Set Receive Mode in HDRP
            if (projectPipeline == "High Definition")
            {
                BoxoUtils.SetMaterialKeywordInverted(material, "_RenderDecals", "_DISABLE_DECALS");

                if (material.HasProperty("_RenderSSR"))
                {
                    if (renderSSR == 0)
                    {
                        material.EnableKeyword("_DISABLE_SSR");

                        material.SetInt("_StencilRef", 0);
                        material.SetInt("_StencilRefDepth", 0);
                        material.SetInt("_StencilRefDistortionVec", 4);
                        material.SetInt("_StencilRefGBuffer", 2);
                        material.SetInt("_StencilRefMV", 32);
                        material.SetInt("_StencilWriteMask", 6);
                        material.SetInt("_StencilWriteMaskDepth", 8);
                        material.SetInt("_StencilWriteMaskDistortionVec", 4);
                        material.SetInt("_StencilWriteMaskGBuffer", 14);
                        material.SetInt("_StencilWriteMaskMV", 40);
                    }
                    else
                    {
                        material.DisableKeyword("_DISABLE_SSR");

                        material.SetInt("_StencilRef", 0);
                        material.SetInt("_StencilRefDepth", 8);
                        material.SetInt("_StencilRefDistortionVec", 4);
                        material.SetInt("_StencilRefGBuffer", 10);
                        material.SetInt("_StencilRefMV", 40);
                        material.SetInt("_StencilWriteMask", 6);
                        material.SetInt("_StencilWriteMaskDepth", 8);
                        material.SetInt("_StencilWriteMaskDistortionVec", 4);
                        material.SetInt("_StencilWriteMaskGBuffer", 14);
                        material.SetInt("_StencilWriteMaskMV", 40);
                    }
                }
            }

            // Set Cull Mode
            if (material.HasProperty("_RenderCull"))
            {
                int cull = material.GetInt("_RenderCull");

                material.SetInt("_render_cull", cull);
                material.SetInt("_CullMode", cull);
                material.SetInt("_TransparentCullMode", cull);
                material.SetInt("_CullModeForward", cull);

                // Needed for HD Render Pipeline
                if (cull == 0 || cull == 1)
                {
                    material.EnableKeyword("_DOUBLESIDED_ON");
                }
                else
                {
                    material.DisableKeyword("_DOUBLESIDED_ON");
                }
            }

            // Set Normals Mode
            if (material.HasProperty("_RenderNormal"))
            {
                int normals = material.GetInt("_RenderNormal");

                // Standard, Universal, HD Render Pipeline
                // Flip 0
                if (normals == 0)
                {
                    material.SetVector("_render_normal", new Vector4(-1, -1, -1, 0));
                    material.SetVector("_DoubleSidedConstants", new Vector4(-1, -1, -1, 0));
                }
                // Mirror 1
                else if (normals == 1)
                {
                    material.SetVector("_render_normal", new Vector4(1, 1, -1, 0));
                    material.SetVector("_DoubleSidedConstants", new Vector4(1, 1, -1, 0));
                }
                // None 2
                else if (normals == 2)
                {
                    material.SetVector("_render_normal", new Vector4(1, 1, 1, 0));
                    material.SetVector("_DoubleSidedConstants", new Vector4(1, 1, 1, 0));
                }
            }

            // Set Specular Mode
            //BoxoUtils.SetMaterialKeywordInverted(material, "_RenderSpecular", "_SPECULARHIGHLIGHTS_OFF");

            // Set Shadows Mode
            BoxoUtils.SetMaterialKeywordInverted(material, "_RenderShadow", "_RECEIVE_SHADOWS_OFF");

            // Set GBuffer Mode
            if (projectPipeline == "Universal")
            {
                var pass = "UniversalGBuffer";

                if (shaderName.Contains("Subsurface Lit"))
                {
                    if (material.HasProperty("_RenderGBuffer"))
                    {
                        var mode = material.GetInt("_RenderGBuffer");

                        if (mode == 0)
                        {
                            material.SetShaderPassEnabled(pass, false);
                        }
                        else
                        {
                            material.SetShaderPassEnabled(pass, true);
                        }
                    }
                }
                else
                {
                    material.SetShaderPassEnabled(pass, true);
                }
            }

            // Set Render Coverage
            if (material.HasProperty("_RenderCoverage"))
            {
                if (renderClip == 0)
                {
                    material.SetInt("_render_coverage", 0);
                }
                else
                {
                    BoxoUtils.SetMaterialFloat(material, "_RenderCoverage", "_render_coverage");
                }
            }
            else
            {
                material.SetInt("_render_coverage", 0);
            }

            float renderMotion = BoxoUtils.GetMaterialFloat(material, "_MotionIntensityValue");

            if (material.HasProperty("_RenderMotion"))
            {
                var mode = material.GetFloat("_RenderMotion");
                var pass = "MotionVectors";

                if (mode == 0)
                {
                    if (renderMotion > 0)
                    {
                        material.SetShaderPassEnabled(pass, true);
                    }
                    else
                    {
                        material.SetShaderPassEnabled(pass, false);
                    }
                }
                else if (mode == 1)
                {
                    material.SetShaderPassEnabled(pass, false);
                }
                else if (mode == 2)
                {
                    material.SetShaderPassEnabled(pass, true);
                }
            }

            if (material.HasProperty("_RenderMotionXR"))
            {
                var mode = material.GetFloat("_RenderMotionXR");
                var pass = "XRMotionVectors";

                if (mode == 0)
                {
                    if (renderMotion > 0)
                    {
                        material.SetShaderPassEnabled(pass, true);
                    }
                    else
                    {
                        material.SetShaderPassEnabled(pass, false);
                    }
                }
                else if (mode == 1)
                {
                    material.SetShaderPassEnabled(pass, false);
                }
                else if (mode == 2)
                {
                    material.SetShaderPassEnabled(pass, true);
                }
            }
        }

        public static void SetMaterialInternal(Material material)
        {
            var shaderName = material.shader.name;

#if UNITY_EDITOR
            // Assign Default HD Foliage profile
            if (material.HasProperty("_SubsurfaceDiffusion"))
            {
                // Workaround when the old HDRP 12 diffusion is not found
                if (material.GetFloat("_SubsurfaceDiffusion") == 3.5648174285888672f && AssetDatabase.GUIDToAssetPath("78322c7f82657514ebe48203160e3f39") == "")
                {
                    material.SetFloat("_SubsurfaceDiffusion", 0);
                }

                // Workaround when the old HDRP 14 diffusion is not found
                if (material.GetFloat("_SubsurfaceDiffusion") == 2.6486763954162598f && AssetDatabase.GUIDToAssetPath("879ffae44eefa4412bb327928f1a96dd") == "")
                {
                    material.SetFloat("_SubsurfaceDiffusion", 0);
                }

                // Search for one of Unity's diffusion profile
                if (material.GetFloat("_SubsurfaceDiffusion") == 0)
                {
                    // HDRP 12 Profile
                    if (AssetDatabase.GUIDToAssetPath("78322c7f82657514ebe48203160e3f39") != "")
                    {
                        material.SetFloat("_SubsurfaceDiffusion", 3.5648174285888672f);
                        material.SetVector("_SubsurfaceDiffusion_Asset", new Vector4(228889264007084710000000000000000000000f, 0.000000000000000000000000012389357880079404f, 0.00000000000000000000000000000000000076932702684439582f, 0.00018220426863990724f));
                    }

                    // HDRP 14 Profile
                    if (AssetDatabase.GUIDToAssetPath("879ffae44eefa4412bb327928f1a96dd") != "")
                    {
                        material.SetFloat("_SubsurfaceDiffusion", 2.6486763954162598f);
                        material.SetVector("_SubsurfaceDiffusion_Asset", new Vector4(-36985449400010195000000f, 20.616847991943359f, -0.00000000000000000000000000052916750040661612f, -1352014335655804900f));
                    }

                    // HDRP 16 Profile
                    if (AssetDatabase.GUIDToAssetPath("2384dbf2c1c420f45a792fbc315fbfb1") != "")
                    {
                        material.SetFloat("_SubsurfaceDiffusion", 3.8956573009490967f);
                        material.SetVector("_SubsurfaceDiffusion_Asset", new Vector4(-8695930962161997000000000000000f, -50949593547561853000000000000000f, -0.010710084810853004f, -0.0000000055696536271909736f));
                    }
                }
            }

            if (material.HasProperty("_IsConverted"))
            {
                var mode = material.GetInt("_IsConverted");

                if (mode == 0)
                {
                    Texture2D albedoTex = null;
                    Texture2D normalTex = null;
                    Texture2D shaderTex = null;

                    if (albedoTex == null)
                    {
                        albedoTex = BoxoUtils.GetMaterialSerializedTexture(material, "_MainTex", null);
                    }

                    if (albedoTex == null)
                    {
                        albedoTex = BoxoUtils.GetMaterialSerializedTexture(material, "_BaseMap", null);
                    }

                    if (albedoTex == null)
                    {
                        albedoTex = BoxoUtils.GetMaterialSerializedTexture(material, "_BaseColorMap", null);
                    }

                    if (normalTex == null)
                    {
                        normalTex = BoxoUtils.GetMaterialSerializedTexture(material, "_BumpMap", null);
                    }

                    if (normalTex == null)
                    {
                        normalTex = BoxoUtils.GetMaterialSerializedTexture(material, "_NormalMap", null);
                    }

                    if (shaderTex == null)
                    {
                        shaderTex = BoxoUtils.GetMaterialSerializedTexture(material, "_SpecGlossMap", null);
                    }

                    if (shaderTex == null)
                    {
                        shaderTex = BoxoUtils.GetMaterialSerializedTexture(material, "_MaskMap", null);
                    }

                    if (albedoTex != null)
                    {
                        material.SetTexture("_MainAlbedoTex", albedoTex);
                    }

                    if (normalTex != null)
                    {
                        material.SetTexture("_MainNormalTex", normalTex);
                    }

                    if (shaderTex != null)
                    {
                        material.SetTexture("_MainShaderTex", shaderTex);
                    }

                    material.SetInt("_IsConverted", 1);
                    material.SetInt("_ObjectModelMode", 1);
                }
            }
#endif

            if (material.HasTexture("_NoiseTex3D"))
            {
                if (material.GetTexture("_NoiseTex3D") == null)
                {
                    material.SetTexture("_NoiseTex3D", Resources.Load<Texture3D>("Internal NoiseTex3D"));
                }
            }

            if (material.HasTexture("_NoiseTexSS"))
            {
                if (material.GetTexture("_NoiseTexSS") == null)
                {
                    material.SetTexture("_NoiseTexSS", Resources.Load<Texture2D>("Internal NoiseTexSS"));
                }
            }

            if (material.HasTexture("_RipplesNoiseTex"))
            {
                if (material.GetTexture("_RipplesNoiseTex") == null)
                {
                    material.SetTexture("_RipplesNoiseTex", Resources.Load<Texture2D>("Internal MotionTex"));
                }
            }

            if (material.HasTexture("_OverlayNormalTex"))
            {
                if (material.GetTexture("_OverlayNormalTex") == null)
                {
                    material.SetTexture("_OverlayNormalTex", Resources.Load<Texture2D>("Internal SnowTex"));
                }
            }

            //if (material.HasTexture("_OverlayGlitterTexRT"))
            //{
            //    if (material.GetTexture("_OverlayGlitterTexRT") == null)
            //    {
            //        material.SetTexture("_OverlayGlitterTexRT", Resources.Load<CustomRenderTexture>("Internal GlitterTexRT"));
            //    }
            //}

            if (material.HasTexture("_WetnessDropsTexRT"))
            {
                if (material.GetTexture("_WetnessDropsTexRT") == null)
                {
                    material.SetTexture("_WetnessDropsTexRT", Resources.Load<CustomRenderTexture>("Internal DropsTexRT"));
                }
            }

            if (material.HasTexture("_WetnessDripsTexRT"))
            {
                if (material.GetTexture("_WetnessDripsTexRT") == null)
                {
                    material.SetTexture("_WetnessDripsTexRT", Resources.Load<CustomRenderTexture>("Internal DripsTexRT"));
                }
            }

            if (material.HasTexture("_MotionNoiseTex"))
            {
                if (material.GetTexture("_MotionNoiseTex") == null)
                {
                    material.SetTexture("_MotionNoiseTex", Resources.Load<Texture2D>("Internal MotionTex"));
                }
            }

            //if (material.HasTexture("_TerrainControlTex1"))
            //{
            //    if (material.GetTexture("_TerrainControlTex1") == null)
            //    {
            //        material.SetTexture("_TerrainControlTex1", Texture2D.redTexture);
            //    }
            //}

            //if (material.HasTexture("_TerrainAlbedoTex1"))
            //{
            //    if (material.GetTexture("_TerrainAlbedoTex1") == null)
            //    {
            //        material.SetTexture("_TerrainAlbedoTex1", Texture2D.redTexture);
            //    }
            //}

            // Set Gamma mode for textures
            BoxoUtils.SetMaterialTextureSpace(material, "_MainAlphaTex", "_MainAlphaTexGammaMode");
            BoxoUtils.SetMaterialTextureSpace(material, "_MainMetallicTex", "_MainMetallicTexGammaMode");
            BoxoUtils.SetMaterialTextureSpace(material, "_MainOcclusionTex", "_MainOcclusionTexGammaMode");
            BoxoUtils.SetMaterialTextureSpace(material, "_MainMultiTex", "_MainMultiTexGammaMode");
            BoxoUtils.SetMaterialTextureSpace(material, "_MainSmoothnessTex", "_MainSmoothnessTexGammaMode");

            // Set Legacy props for external bakers
            if (material.HasProperty("_MainAlphaClipValue"))
            {
                material.SetFloat("_Cutoff", material.GetFloat("_MainAlphaClipValue"));
            }

            // Set Legacy props for external bakers
            if (material.HasProperty("_MainColor"))
            {
                material.SetColor("_Color", material.GetColor("_MainColor"));
            }

            // Set BlinnPhong Spec Color
            if (material.HasProperty("_SpecColor"))
            {
                material.SetColor("_SpecColor", Color.white);
            }

            if (material.HasTexture("_MainAlbedoTex"))
            {
                if (material.HasTexture("_MainTex"))
                {
                    material.SetTexture("_MainTex", material.GetTexture("_MainAlbedoTex"));
                }
            }

            if (material.HasTexture("_MainNormalTex"))
            {
                if (material.HasTexture("_BumpMap"))
                {
                    material.SetTexture("_BumpMap", material.GetTexture("_MainNormalTex"));
                }
            }

            if (material.HasProperty("_MainCoordValue"))
            {
                if (material.HasTexture("_MainTex"))
                {
                    material.SetTextureScale("_MainTex", new Vector2(material.GetVector("_MainCoordValue").x, material.GetVector("_MainCoordValue").y));
                    material.SetTextureOffset("_MainTex", new Vector2(material.GetVector("_MainCoordValue").z, material.GetVector("_MainCoordValue").w));
                }

                if (material.HasTexture("_BumpMap"))
                {
                    material.SetTextureScale("_BumpMap", new Vector2(material.GetVector("_MainCoordValue").x, material.GetVector("_MainCoordValue").y));
                    material.SetTextureOffset("_BumpMap", new Vector2(material.GetVector("_MainCoordValue").z, material.GetVector("_MainCoordValue").w));
                }
            }

#if UNITY_EDITOR
            // Add ID for material
            if (material.HasProperty("_IsIdentifier"))
            {
                var id = material.GetInt("_IsIdentifier");

                if (id == 0)
                {
                    var newId = (int)UnityEngine.Random.Range(1, 100);

                    if (EditorUtility.IsPersistent(material))
                    {
                        material.SetInt("_IsIdentifier", newId);
                    }
                    else
                    {
                        material.SetInt("_IsIdentifier", newId * -1);
                    }
                }
            }

            // Detect if the shaders is custom compiled
            if (AssetDatabase.GetAssetPath(material.shader).Contains("Core"))
            {
                material.SetInt("_IsCustomShader", 0);
            }
            else
            {
                material.SetInt("_IsCustomShader", 1);
            }

            // Enable Nature Rendered support
            material.SetOverrideTag("NatureRendererInstancing", "True");

            int lightingType = 0;
            int shaderType = 0;

            // Set Internal shader type
            if (shaderName.Contains("Vertex Lit"))
            {
                lightingType = 1;
            }

            if (shaderName.Contains("Simple Lit"))
            {
                lightingType = 2;
            }

            if (shaderName.Contains("Standard Lit"))
            {
                lightingType = 3;
            }

            if (shaderName.Contains("Subsurface Lit"))
            {
                lightingType = 4;
            }

            if (shaderName.Contains("Unlit"))
            {
                lightingType = 5;
            }

            if (shaderName.Contains("General"))
            {
                shaderType = 1;
            }

            if (shaderName.Contains("Blanket"))
            {
                shaderType = 2;
            }

            if (shaderName.Contains("Impostor"))
            {
                shaderType = 3;
            }

            if (shaderName.Contains("Terrain"))
            {
                shaderType = 4;
            }

            material.SetInt("_IsLightingType", lightingType);
            material.SetInt("_IsShaderType", shaderType);
#endif
        }

        public static void SetImpostorSettings(Material oldMaterial, Material material)
        {
            material.SetFloat("_IsInitialized", 1);

            TVEUtils.SetMaterialRuntime(material);
            TVEUtils.SetMaterialInternal(material);

#if UNITY_EDITOR
            //TVEUtils.StripUnusedTextures(material);
            TVEUtils.SetImpostorFeatures(material);
            TVEUtils.SetImpostorBakeModes(oldMaterial, material);
#endif
        }

        public static void SetElementSettings(Material material)
        {
            if (!material.HasProperty("_IsElementShader"))
            {
                return;
            }

            var shaderName = material.shader.name;

            material.SetShaderPassEnabled("VolumePass", false);
            material.SetShaderPassEnabled("VolumePass1", false);
            material.SetShaderPassEnabled("VolumePass2", false);

            if (material.HasProperty("_IsVersion"))
            {
                var version = material.GetInt("_IsVersion");

                if (version < 600)
                {
                    if (material.HasProperty("_ElementLayerValue"))
                    {
                        var oldLayer = material.GetInt("_ElementLayerValue");

                        if (material.GetInt("_ElementLayerValue") > 0)
                        {
                            material.SetInt("_ElementLayerMask", (int)Mathf.Pow(2, oldLayer));
                            material.SetInt("_ElementLayerValue", -1);
                        }
                    }

                    if (material.HasProperty("_InvertX"))
                    {
                        material.SetInt("_ElementInvertMode", material.GetInt("_InvertX"));
                    }

                    if (material.HasProperty("_ElementFadeSupport"))
                    {
                        material.SetInt("_ElementVolumeFadeMode", material.GetInt("_ElementFadeSupport"));
                    }

                    material.SetInt("_IsVersion", 600);
                }

                if (version < 700)
                {
                    // Requires revalidation
                    material.SetInt("_IsVersion", 700);
                }

                if (version < 800)
                {
                    if (material.shader.name.Contains("Interaction"))
                    {
                        if (material.HasProperty("_ElementDirectionMode"))
                        {
                            if (material.GetInt("_ElementDirectionMode") == 1)
                            {
                                material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Elements/Default/Motion Advanced");
                                material.SetInt("_ElementDirectionMode", 30);
                            }
                        }
                    }

                    if (shaderName.Contains("Orientation"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Elements/Default/Motion Interaction");
                    }

                    if (shaderName.Contains("Turbulence"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Elements/Default/Motion Advanced");
                        material.SetInt("_ElementDirectionMode", 10);
                    }

                    if (shaderName.Contains("Wind Control"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Elements/Default/Wind Power");
                    }

                    if (shaderName.Contains("Wind Direction"))
                    {
                        material.shader = Shader.Find("BOXOPHOBIC/The Visual Engine/Elements/Default/Motion Advanced");
                        material.SetInt("_ElementDirectionMode", 10);
                    }

                    material.SetInt("_IsVersion", 800);
                }

                if (version < 810)
                {
                    if (material.HasProperty("_MainTexMinValue") && material.HasProperty("_MainTexMaxValue"))
                    {
                        var min = material.GetFloat("_MainTexMinValue");
                        var max = material.GetFloat("_MainTexMaxValue");

                        material.SetFloat("_MainMaskAlphaMinValue", min);
                        material.SetFloat("_MainMaskAlphaMaxValue", max);
                    }

                    material.SetInt("_IsVersion", 810);
                }

#if UNITY_EDITOR
                // Upgrade to 14
                if (version < 1400)
                {
                    var valueX = BoxoUtils.GetMaterialSerializedFloat(material, "_MainTexColorMinValue", 0.0f);
                    var valueY = BoxoUtils.GetMaterialSerializedFloat(material, "_MainTexColorMaxValue", 1.0f);

                    material.SetVector("_MainTexColorRemap", new Vector4(valueX, valueY, 0, 0));

                    var alphaX = BoxoUtils.GetMaterialSerializedFloat(material, "_MainTexAlphaMinValue", 0.0f);
                    var alphaY = BoxoUtils.GetMaterialSerializedFloat(material, "_MainTexAlphaMaxValue", 1.0f);

                    material.SetVector("_MainTexAlphaRemap", new Vector4(alphaX, alphaY, 0, 0));

                    var falloffX = BoxoUtils.GetMaterialSerializedFloat(material, "_MainTexFallofMinValue", 0.0f);
                    var falloffY = BoxoUtils.GetMaterialSerializedFloat(material, "_MainTexFallofMaxValue", 0.0f);

                    material.SetVector("_MainTexFalloffRemap", new Vector4(falloffX, falloffY, 0, 0));

                    //var seasonX = BoxoUtils.GetMaterialSerializedFloat(material, "_SeasonMinValue", 0.0f);
                    //var seasonY = BoxoUtils.GetMaterialSerializedFloat(material, "_SeasonMaxValue", 1.0f);

                    // Reset season curve
                    material.SetVector("_SeasonRemap", new Vector4(0, 1, 0, 0));

                    material.SetFloat("_RaycastDistanceMaxValue", BoxoUtils.GetMaterialSerializedFloat(material, "_RaycastDistanceEndValue", 0.0f));
                    material.SetFloat("_MotionDirectionMode", BoxoUtils.GetMaterialSerializedFloat(material, "_ElementDirectionMode", 20) / 10 - 1);

                    material.SetInt("_IsVersion", 1400);
                }
#endif
            }

            var shaderTypeName = Path.GetFileName(shaderName);
            var shaderTypeSplit = shaderTypeName.Split(" ");
            var shaderType = shaderTypeSplit[0];

            material.SetOverrideTag("ElementType", shaderType);

            if (material.HasProperty("_ElementColorsMode"))
            {
                var effect = material.GetInt("_ElementColorsMode");

                material.SetInt("_render_colormask", effect);
            }

            //if (material.HasProperty("_ElementMotionMode"))
            //{
            //    var effect = material.GetInt("_ElementMotionMode");

            //    material.SetInt("_render_colormask", effect);

            //    if (effect == 13)
            //    {
            //        material.SetFloat("_MotionPower", 0);
            //    }
            //}

            if (material.HasProperty("_ElementBlendRGB"))
            {
                var blend = material.GetInt("_ElementBlendRGB");

                if (blend == 0)
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                }
                else if (blend == 1)
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.DstColor);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.Zero);
                }
                else if (blend == 2)
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.One);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.One);
                }

                BoxoUtils.SetMaterialOptions(material, "_ElementBlendRGB", "_element_blend_rgb");
            }

            if (material.HasProperty("_ElementBlendA"))
            {
                var blend = material.GetInt("_ElementBlendA");

                if (blend == 0)
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.DstAlpha);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.Zero);
                }
                else
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.One);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.One);
                }
            }

            BoxoUtils.SetMaterialReciprocal(material, "_MainTexColorRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MainTexAlphaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MainTexFalloffRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MainAlbedoTexColorRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_MainAlbedoTexAlphaRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_SeasonRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_NoiseRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ElementMaskRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ElementProjRemap");
            BoxoUtils.SetMaterialReciprocal(material, "_ControlMaskRemap");

            BoxoUtils.SetMaterialOptions(material, "_MotionDirectionMode", "_motion_direction_mode");

            //BoxoUtils.SetMaterialKeyword(material, true, new string[]{ "_ElementMaskValue", "_ElementMaskValue", "_ElementMaskValue" }, "TVE_ELEMENT_MASKS");
            BoxoUtils.SetMaterialKeyword(material, "_ElementMaskValue", "TVE_ELEMENT_MASK");
            BoxoUtils.SetMaterialKeyword(material, "_ElementProjValue", "TVE_ELEMENT_PROJ");
            BoxoUtils.SetMaterialKeyword(material, "_ElementPosValue", "TVE_ELEMENT_POS");
            //BoxoUtils.SetMaterialKeyword(material, "_HeightOffsetMode", new string[] { "TVE_HEIGHT_CONSTANT", "TVE_HEIGHT_MODEL", "TVE_HEIGHT_TERRAIN" });

            //if (material.HasProperty("_ElementDirectionMode"))
            //{
            //    var direction = material.GetInt("_ElementDirectionMode");

            //    if (direction == 0)
            //    {
            //        material.SetVector("_element_direction_mode", new Vector4(1, 0, 0, 0));
            //    }

            //    if (direction == 1)
            //    {
            //        material.SetVector("_element_direction_mode", new Vector4(0, 1, 0, 0));
            //    }

            //    if (direction == 2)
            //    {
            //        material.SetVector("_element_direction_mode", new Vector4(0, 0, 1, 0));
            //    }

            //    if (direction == 3)
            //    {
            //        material.SetVector("_element_direction_mode", new Vector4(0, 0, 0, 1));
            //    }
            //}

            //if (material.HasProperty("_ElementRaycastMode"))
            //{
            //    var raycast = material.GetInt("_ElementRaycastMode");

            //    if (raycast == 1)
            //    {
            //        material.enableInstancing = false;
            //    }
            //}

#if UNITY_EDITOR
            // Add ID for material
            if (material.HasProperty("_IsIdentifier"))
            {
                var id = material.GetInt("_IsIdentifier");

                if (id == 0)
                {
                    var newId = (int)UnityEngine.Random.Range(1, 100);

                    if (EditorUtility.IsPersistent(material))
                    {
                        material.SetInt("_IsIdentifier", newId);
                    }
                    else
                    {
                        material.SetInt("_IsIdentifier", newId * -1);
                    }
                }
            }

            if (material.HasProperty("_ElementLayerMask"))
            {
                var layers = material.GetInt("_ElementLayerMask");

                if (layers > 1)
                {
                    material.SetInt("_ElementLayerMessage", 1);
                }
                else
                {
                    material.SetInt("_ElementLayerMessage", 0);
                }

                if (layers == -1)
                {
                    material.SetInt("_ElementLayerWarning", 1);
                }
                else
                {
                    material.SetInt("_ElementLayerWarning", 0);
                }
            }
#endif
        }

        // Element Utils
        public static GameObject CreateElement(Vector3 localPosition, Quaternion localRotation, Vector3 localScale, Transform parent, Material material, bool customMaterial)
        {
            //material.name = "Element Default";

            var gameObject = MonoBehaviour.Instantiate(Resources.Load<GameObject>("Internal Element"));
            gameObject.name = "Element " + Path.GetFileNameWithoutExtension(material.shader.name);

            gameObject.transform.localPosition = localPosition;
            gameObject.transform.localRotation = localRotation;
            gameObject.transform.localScale = localScale;

            gameObject.AddComponent<TVEElement>();

            if (customMaterial)
            {
                gameObject.GetComponent<TVEElement>().customMaterial = material;
            }
            else
            {
                gameObject.GetComponent<Renderer>().sharedMaterial = material;
            }

            gameObject.transform.parent = parent;

            return gameObject;
        }

        public static GameObject CreateElement(Vector3 localPosition, Quaternion localRotation, Vector3 localScale, Transform parent, Material material)
        {
            return CreateElement(localPosition, localRotation, localScale, parent, material, false);
        }

        public static GameObject CreateElement(Terrain terrain, Material material, bool customMaterial)
        {
            //material.name = "Element Terrain";

            var gameObject = MonoBehaviour.Instantiate(Resources.Load<GameObject>("Internal Element"));
            gameObject.name = "Element " + terrain.name;

            MaterialPropertyBlock terrainPropertyBlock = new MaterialPropertyBlock();

            CopyTerrainDataToElement(terrain, TVETerrainTexture.heightTexture, terrainPropertyBlock, material);

            gameObject.AddComponent<TVEElement>();

            if (customMaterial)
            {
                gameObject.GetComponent<TVEElement>().customMaterial = material;
            }
            else
            {
                gameObject.GetComponent<Renderer>().sharedMaterial = material;
            }

            var position = terrain.transform.position;
            var bounds = terrain.terrainData.bounds;
            gameObject.transform.localPosition = new Vector3(bounds.center.x + position.x, bounds.min.y + position.y, bounds.center.z + position.z);
            gameObject.transform.localScale = new Vector3(terrain.terrainData.size.x, 1, terrain.terrainData.size.z);

            gameObject.GetComponent<TVEElement>().terrainData = terrain;

            return gameObject;
        }

        public static GameObject CreateElement(Terrain terrain, Material material)
        {
            return CreateElement(terrain, material, false);
        }

        public static GameObject CreateElement(GameObject gameObject, Material material, bool customMaterial)
        {
            //material.name = "Element";

            gameObject.AddComponent<TVEElement>();

            if (customMaterial)
            {
                gameObject.GetComponent<TVEElement>().customMaterial = material;
            }
            else
            {
                gameObject.GetComponent<Renderer>().sharedMaterial = material;
            }

            return gameObject;
        }

        public static GameObject CreateElement(GameObject gameObject, Material material)
        {
            return CreateElement(gameObject, material, false);
        }

        public static void CopyTerrainDataToElement(Terrain terrain, TVETerrainTexture terrainMask, MaterialPropertyBlock terrainPropertyBlock, Material material)
        {
            if (terrain == null || terrain.terrainData == null || terrainMask == TVETerrainTexture.None)
            {
                material.SetTexture("_TerrainHeightTex", null);
                material.SetTexture("_TerrainNormalTex", null);
                material.SetTexture("_TerrainHolesTex", null);

                material.SetInt("_TerrainInputMode", 0);

                return;
            }

            material.SetInt("_TerrainInputMode", 1);

            material.SetVector("_TerrainPosition", terrain.transform.position);
            material.SetVector("_TerrainSize", terrain.terrainData.size);

            bool hasTerrainPropertyBlock = false;

            var terrainMaterial = terrain.materialTemplate;

            if (terrainMaterial != null && terrainMaterial.shader.name.Contains("The Visual Engine"))
            {
                terrain.GetSplatMaterialPropertyBlock(terrainPropertyBlock);

                hasTerrainPropertyBlock = true;
            }

            if (terrainMask == TVETerrainTexture.Auto)
            {
                if (material.HasProperty("_TerrainHeightTex"))
                {
                    var texture = terrain.terrainData.heightmapTexture;

                    if (texture != null)
                    {
                        material.SetTexture("_TerrainHeightTex", texture);
                    }
                }

                if (material.HasProperty("_TerrainNormalTex"))
                {
                    var texture = terrain.normalmapTexture;

                    if (texture != null)
                    {
                        material.SetTexture("_TerrainNormalTex", texture);
                    }
                    else
                    {
                        if (hasTerrainPropertyBlock)
                        {
                            if (terrainPropertyBlock.HasProperty("_TerrainNormalTex"))
                            {
                                var propertyBlockTexture = terrainPropertyBlock.GetTexture("_TerrainNormalTex");

                                if (propertyBlockTexture != null)
                                {
                                    material.SetTexture("_TerrainNormalTex", propertyBlockTexture);
                                }
                            }
                        }
                    }
                }

                if (material.HasProperty("_TerrainHolesTex"))
                {
                    var texture = terrain.terrainData.holesTexture;

                    if (texture != null)
                    {
                        material.SetTexture("_TerrainHolesTex", texture);
                    }
                }

                if (material.HasProperty("_UseTerrainAlbedo"))
                {
                    if (terrainPropertyBlock.HasProperty("_TerrainAlbedoTex"))
                    {
                        var propertyBlockTexture = terrainPropertyBlock.GetTexture("_TerrainAlbedoTex");

                        if (propertyBlockTexture != null)
                        {
                            material.SetTexture("_TerrainAlbedoTex", propertyBlockTexture);
                            material.SetTexture("_MainTex", propertyBlockTexture);
                        }
                    }
                }

                if (material.HasProperty("_TerrainShaderTex"))
                {
                    if (terrainPropertyBlock.HasProperty("_TerrainShaderTex"))
                    {
                        var propertyBlockTexture = terrainPropertyBlock.GetTexture("_TerrainShaderTex");

                        if (propertyBlockTexture != null)
                        {
                            material.SetTexture("_TerrainShaderTex", propertyBlockTexture);
                        }
                    }
                }

                if (material.HasFloat("_UseTerrainControl"))
                {
                    // Support for terrain elements
                    if (terrain.terrainData.alphamapTextureCount == 1)
                    {
                        material.SetTexture("_ControlTex1", terrain.terrainData.alphamapTextures[0]);
                    }

                    if (terrain.terrainData.alphamapTextureCount == 2)
                    {
                        material.SetTexture("_ControlTex2", terrain.terrainData.alphamapTextures[1]);
                    }

                    if (terrain.terrainData.alphamapTextureCount == 3)
                    {
                        material.SetTexture("_ControlTex3", terrain.terrainData.alphamapTextures[2]);
                    }

                    if (terrain.terrainData.alphamapTextureCount == 4)
                    {
                        material.SetTexture("_ControlTex4", terrain.terrainData.alphamapTextures[3]);
                    }
                }

                if (material.HasFloat("_UseTerrainTextures"))
                {
                    TVEUtils.CopyTerrainDataToMaterial(terrain, material);
                }
            }
            else if (terrainMask == TVETerrainTexture.heightTexture)
            {
                if (material.HasProperty("_MainTex"))
                {
                    var texture = terrain.terrainData.heightmapTexture;

                    if (texture != null)
                    {
                        material.SetTexture("_MainTex", texture);
                    }
                }
            }
            else if (terrainMask == TVETerrainTexture.normalTexture)
            {
                if (material.HasProperty("_MainTex"))
                {
                    var texture = terrain.normalmapTexture;

                    if (texture != null)
                    {
                        material.SetTexture("_MainTex", texture);
                    }
                    else
                    {
                        if (hasTerrainPropertyBlock)
                        {
                            if (terrainPropertyBlock.HasProperty("_TerrainNormalTex"))
                            {
                                var propertyBlockTexture = terrainPropertyBlock.GetTexture("_TerrainNormalTex");

                                if (propertyBlockTexture != null)
                                {
                                    material.SetTexture("_MainTex", propertyBlockTexture);
                                }
                            }
                        }
                    }
                }
            }
            else if (terrainMask == TVETerrainTexture.holesTexture)
            {
                if (material.HasProperty("_MainTex"))
                {
                    var texture = terrain.terrainData.holesTexture;

                    if (texture != null)
                    {
                        material.SetTexture("_MainTex", texture);
                    }
                }
            }
        }

        public static void CopyTerrainDataToMaterial(Terrain terrain, Material material)
        {
            if (terrain == null || material == null || terrain.materialTemplate == null)
            {
                return;
            }

            var terrainMaterial = terrain.materialTemplate;

            if (terrainMaterial.shader.name.Contains("The Visual Engine"))
            {
                MaterialPropertyBlock terrainPropertyBlock = new MaterialPropertyBlock();

                terrain.GetSplatMaterialPropertyBlock(terrainPropertyBlock);

                material.SetVector("_TerrainPosition", terrainPropertyBlock.GetVector("_TerrainPosition"));
                material.SetVector("_TerrainSize", terrainPropertyBlock.GetVector("_TerrainSize"));

                material.SetColor("_TerrainColor", terrainMaterial.GetColor("_TerrainColor"));
                material.SetFloat("_TerrainNormalValue", terrainMaterial.GetFloat("_TerrainNormalValue"));
                material.SetFloat("_TerrainMetallicValue", terrainMaterial.GetFloat("_TerrainMetallicValue"));
                material.SetFloat("_TerrainOcclusionValue", terrainMaterial.GetFloat("_TerrainOcclusionValue"));
                material.SetFloat("_TerrainSmoothnessValue", terrainMaterial.GetFloat("_TerrainSmoothnessValue"));
                material.SetFloat("_TerrainHeightBlendValue", terrainMaterial.GetFloat("_TerrainHeightBlendValue"));

                if (terrainPropertyBlock.HasProperty("_TerrainAlbedoTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainAlbedoTex");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainAlbedoTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainNormalTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainNormalTex");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainNormalTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainNormalWSTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainNormalWSTex");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainNormalWSTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainShaderTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainShaderTex");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainShaderTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainFeatureTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainFeatureTex");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainFeatureTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainHolesTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainHolesTex");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainHolesTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex1"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex1");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainControlTex1", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex2"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex2");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainControlTex2", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex3"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex3");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainControlTex3", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex4"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex4");

                    if (tex != null)
                    {
                        material.SetTexture("_TerrainControlTex4", tex);
                    }
                }

                for (int i = 0; i < terrain.terrainData.terrainLayers.Length; i++)
                {
                    var index = i + 1;

                    if (terrainPropertyBlock.HasProperty("_TerrainColor" + index))
                    {
                        material.SetVector("_TerrainColor" + index, terrainPropertyBlock.GetVector("_TerrainColor" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainAlbedoTex" + index))
                    {
                        material.SetTexture("_TerrainAlbedoTex" + index, terrainPropertyBlock.GetTexture("_TerrainAlbedoTex" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainNormalTex" + index))
                    {
                        material.SetTexture("_TerrainNormalTex" + index, terrainPropertyBlock.GetTexture("_TerrainNormalTex" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainShaderTex" + index))
                    {
                        material.SetTexture("_TerrainShaderTex" + index, terrainPropertyBlock.GetTexture("_TerrainShaderTex" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainShaderMin" + index))
                    {
                        material.SetVector("_TerrainShaderMin" + index, terrainPropertyBlock.GetVector("_TerrainShaderMin" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainShaderRcp" + index))
                    {
                        material.SetVector("_TerrainShaderRcp" + index, terrainPropertyBlock.GetVector("_TerrainShaderRcp" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainParams" + index))
                    {
                        material.SetVector("_TerrainParams" + index, terrainPropertyBlock.GetVector("_TerrainParams" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainSpecular" + index))
                    {
                        material.SetVector("_TerrainSpecular" + index, terrainPropertyBlock.GetVector("_TerrainSpecular" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainCoord" + index))
                    {
                        material.SetVector("_TerrainCoord" + index, terrainPropertyBlock.GetVector("_TerrainCoord" + index));
                    }
                }
            }
            else
            {
                material.SetVector("_TerrainPosition", terrain.transform.position);
                material.SetVector("_TerrainSize", terrain.terrainData.size);

                if (terrain.terrainData.holesTexture != null)
                {
                    material.SetTexture("_TerrainHolesTex", terrain.terrainData.holesTexture);
                }

                for (int i = 0; i < terrain.terrainData.alphamapTextures.Length; i++)
                {
                    var splat = terrain.terrainData.alphamapTextures[i];
                    var index = i + 1;

                    if (splat != null)
                    {
                        material.SetTexture("_TerrainControlTex" + index, splat);
                    }
                }

                for (int i = 0; i < terrain.terrainData.terrainLayers.Length; i++)
                {
                    var layer = terrain.terrainData.terrainLayers[i];
                    var index = i + 1;

                    if (layer == null)
                    {
                        continue;
                    }

                    if (layer.diffuseTexture != null)
                    {
                        material.SetTexture("_TerrainAlbedoTex" + index, layer.diffuseTexture);
                    }
                    else
                    {
                        material.SetTexture("_TerrainAlbedoTex" + index, Texture2D.whiteTexture);
                    }

                    if (layer.normalMapTexture != null)
                    {
                        material.SetTexture("_TerrainNormalTex" + index, layer.normalMapTexture);
                    }
                    else
                    {
                        material.SetTexture("_TerrainNormalTex" + index, Texture2D.normalTexture);
                    }

                    if (layer.maskMapTexture != null)
                    {
                        material.SetTexture("_TerrainShaderTex" + index, layer.maskMapTexture);
                    }
                    else
                    {
                        material.SetTexture("_TerrainShaderTex" + index, Texture2D.whiteTexture);
                    }

                    var rcpX = 1 / (layer.maskMapRemapMax.x - layer.maskMapRemapMin.x);
                    var rcpY = 1 / (layer.maskMapRemapMax.y - layer.maskMapRemapMin.y);
                    var rcpZ = 1 / (layer.maskMapRemapMax.z - layer.maskMapRemapMin.z);
                    var rcpW = 1 / (layer.maskMapRemapMax.w - layer.maskMapRemapMin.w);

                    material.SetVector("_TerrainShaderMin" + index, layer.maskMapRemapMin);
                    //material.SetVector("_TerrainShaderMax" + index, layer.maskMapRemapMax);
                    material.SetVector("_TerrainShaderRcp" + index, new Vector4(rcpX, rcpY, rcpZ, rcpW));
                    material.SetVector("_TerrainParams" + index, new Vector4(layer.metallic, 0, layer.normalScale, layer.smoothness));
                    material.SetVector("_TerrainSpecular" + index, layer.specular);
                    material.SetVector("_TerrainCoord" + index, new Vector4(1 / layer.tileSize.x, 1 / layer.tileSize.y, layer.tileOffset.x, layer.tileOffset.y));
                }
            }
        }

        public static void CopyTerrainDataToRenderer(Terrain terrain, Renderer renderer)
        {
            if (terrain == null || terrain.materialTemplate == null || renderer == null || renderer.sharedMaterials == null)
            {
                return;
            }

            var terrainMaterial = terrain.materialTemplate;

            if (terrainMaterial.shader.name.Contains("The Visual Engine"))
            {
                //Leave early if materials is not blendable
                //if (BoxoUtils.GetMaterialFloat(terrainMaterial, "_TerrainIntensityValue", 0) == 0)
                //{
                //    return;
                //}

                MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();
                MaterialPropertyBlock terrainPropertyBlock = new MaterialPropertyBlock();

                terrain.GetSplatMaterialPropertyBlock(terrainPropertyBlock);

                propertyBlock.SetVector("_TerrainPosition", terrainPropertyBlock.GetVector("_TerrainPosition"));
                propertyBlock.SetVector("_TerrainSize", terrainPropertyBlock.GetVector("_TerrainSize"));

                propertyBlock.SetColor("_TerrainColor", terrainMaterial.GetColor("_TerrainColor"));
                propertyBlock.SetFloat("_TerrainNormalValue", terrainMaterial.GetFloat("_TerrainNormalValue"));
                propertyBlock.SetFloat("_TerrainMetallicValue", terrainMaterial.GetFloat("_TerrainMetallicValue"));
                propertyBlock.SetFloat("_TerrainOcclusionValue", terrainMaterial.GetFloat("_TerrainOcclusionValue"));
                propertyBlock.SetFloat("_TerrainSmoothnessValue", terrainMaterial.GetFloat("_TerrainSmoothnessValue"));
                propertyBlock.SetFloat("_TerrainHeightBlendValue", terrainMaterial.GetFloat("_TerrainHeightBlendValue"));

                if (terrainPropertyBlock.HasProperty("_TerrainAlbedoTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainAlbedoTex");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainAlbedoTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainNormalTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainNormalTex");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainNormalTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainNormalWSTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainNormalWSTex");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainNormalWSTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainShaderTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainShaderTex");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainShaderTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainFeatureTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainFeatureTex");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainFeatureTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainHolesTex"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainHolesTex");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainHolesTex", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex1"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex1");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainControlTex1", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex2"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex2");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainControlTex2", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex3"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex3");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainControlTex3", tex);
                    }
                }

                if (terrainPropertyBlock.HasProperty("_TerrainControlTex4"))
                {
                    var tex = terrainPropertyBlock.GetTexture("_TerrainControlTex4");

                    if (tex != null)
                    {
                        propertyBlock.SetTexture("_TerrainControlTex4", tex);
                    }
                }

                var materialLayersMax = 0;

                for (int i = 0; i < renderer.sharedMaterials.Length; i++)
                {
                    var material = renderer.sharedMaterials[i];

                    if (material != null)
                    {
                        var materialLayers = BoxoUtils.GetMaterialInt(renderer.sharedMaterial, "_TerrainLayersMode", 0);

                        if (materialLayersMax < materialLayers)
                        {
                            materialLayersMax = materialLayers;
                        }
                    }
                }

                for (int i = 0; i < materialLayersMax; i++)
                {
                    var index = i + 1;

                    if (terrainPropertyBlock.HasProperty("_TerrainColor" + index))
                    {
                        propertyBlock.SetVector("_TerrainColor" + index, terrainPropertyBlock.GetVector("_TerrainColor" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainAlbedoTex" + index))
                    {
                        propertyBlock.SetTexture("_TerrainAlbedoTex" + index, terrainPropertyBlock.GetTexture("_TerrainAlbedoTex" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainNormalTex" + index))
                    {
                        propertyBlock.SetTexture("_TerrainNormalTex" + index, terrainPropertyBlock.GetTexture("_TerrainNormalTex" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainShaderTex" + index))
                    {
                        propertyBlock.SetTexture("_TerrainShaderTex" + index, terrainPropertyBlock.GetTexture("_TerrainShaderTex" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainShaderMin" + index))
                    {
                        propertyBlock.SetVector("_TerrainShaderMin" + index, terrainPropertyBlock.GetVector("_TerrainShaderMin" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainShaderRcp" + index))
                    {
                        propertyBlock.SetVector("_TerrainShaderRcp" + index, terrainPropertyBlock.GetVector("_TerrainShaderRcp" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainParams" + index))
                    {
                        propertyBlock.SetVector("_TerrainParams" + index, terrainPropertyBlock.GetVector("_TerrainParams" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainSpecular" + index))
                    {
                        propertyBlock.SetVector("_TerrainSpecular" + index, terrainPropertyBlock.GetVector("_TerrainSpecular" + index));
                    }

                    if (terrainPropertyBlock.HasProperty("_TerrainCoord" + index))
                    {
                        propertyBlock.SetVector("_TerrainCoord" + index, terrainPropertyBlock.GetVector("_TerrainCoord" + index));
                    }

                    renderer.SetPropertyBlock(propertyBlock);
                }

                //for (int i = sharedMaterialLayers; i < tveTerrain.terrain.terrainData.terrainLayers.Length; i++)
                //{
                //    var index = i + 1;

                //    propertyBlock.SetTexture("_TerrainAlbedoTex" + index, Texture2D.whiteTexture);
                //    propertyBlock.SetTexture("_TerrainNormalTex" + index, Texture2D.linearGrayTexture);
                //    propertyBlock.SetTexture("_TerrainShaderTex" + index, Texture2D.whiteTexture);
                //}
            }
        }

        // Mesh Utils
        public static Mesh CreatePackedMesh(TVEModelData meshData)
        {
            Mesh mesh = UnityEngine.Object.Instantiate(meshData.mesh);

            var vertexCount = mesh.vertexCount;

            var bounds = mesh.bounds;
            var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
            var maxZ = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));
            var maxR = Mathf.Max(maxX, maxZ) / 100f;
            var maxH = Mathf.Max(Mathf.Abs(bounds.min.y), Mathf.Abs(bounds.max.y)) / 100f;

            if (meshData.height == 0)
            {
                meshData.height = maxH;
            }

            if (meshData.radius == 0)
            {
                meshData.radius = maxR;
            }

            var dummyFloat = new List<float>(vertexCount);
            var dummyVector2 = new List<Vector2>(vertexCount);
            var dummyVector3 = new List<Vector3>(vertexCount);
            var dummyVector4 = new List<Vector4>(vertexCount);

            var colors = new List<Color>(vertexCount);
            var UV0 = new List<Vector4>(vertexCount);
            var UV2 = new List<Vector4>(vertexCount);
            var UV4 = new List<Vector4>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                dummyFloat.Add(1);
                dummyVector2.Add(Vector2.zero);
                dummyVector3.Add(Vector3.zero);
                dummyVector4.Add(Vector4.zero);
            }

            mesh.GetColors(colors);
            mesh.GetUVs(0, UV0);
            mesh.GetUVs(1, UV2);
            mesh.GetUVs(3, UV4);

            if (UV2.Count == 0)
            {
                UV2 = dummyVector4;
            }

            if (UV4.Count == 0)
            {
                UV4 = dummyVector4;
            }

            if (meshData.variationMask == null)
            {
                meshData.variationMask = dummyFloat;
            }

            if (meshData.occlusionMask == null)
            {
                meshData.occlusionMask = dummyFloat;
            }

            if (meshData.detailMask == null)
            {
                meshData.detailMask = dummyFloat;
            }

            if (meshData.heightMask == null)
            {
                meshData.heightMask = dummyFloat;
            }

            if (meshData.motion2Mask == null)
            {
                meshData.motion2Mask = dummyFloat;
            }

            if (meshData.motion3Mask == null)
            {
                meshData.motion3Mask = dummyFloat;
            }

            if (meshData.detailCoord == null)
            {
                meshData.detailCoord = dummyVector2;
            }

            if (meshData.detailCoord == null)
            {
                meshData.pivotPositions = dummyVector3;
            }

            for (int i = 0; i < vertexCount; i++)
            {
                colors[i] = new Color(meshData.variationMask[i], meshData.occlusionMask[i], meshData.detailMask[i], meshData.heightMask[i]);
                UV0[i] = new Vector4(UV0[i].x, UV0[i].y, BoxoUtils.MathVector2ToFloat(meshData.motion2Mask[i], meshData.motion3Mask[i]), BoxoUtils.MathVector2ToFloat(meshData.height / 100f, meshData.radius / 100f));
                UV2[i] = new Vector4(UV2[i].x, UV2[i].y, meshData.detailCoord[i].x, meshData.detailCoord[i].y);
                UV4[i] = new Vector4(meshData.pivotPositions[i].x, meshData.pivotPositions[i].z, meshData.pivotPositions[i].y, 0);
            }

            mesh.SetColors(colors);
            mesh.SetUVs(0, UV0);
            mesh.SetUVs(1, UV2);
            mesh.SetUVs(3, UV4);

            dummyFloat.Clear();
            dummyVector2.Clear();
            dummyVector3.Clear();
            dummyVector4.Clear();

            return mesh;
        }

        public static Mesh CombinePackedMeshes(List<GameObject> gameObjects, bool mergeSubMeshes, bool usePrebakedPivots)
        {
            var mesh = new Mesh();
            mesh.indexFormat = IndexFormat.UInt32;

            var combineInstances = new CombineInstance[gameObjects.Count];

            for (int i = 0; i < gameObjects.Count; i++)
            {
                var instanceMesh = UnityEngine.Object.Instantiate(gameObjects[i].GetComponent<MeshFilter>().sharedMesh);
                var meshRenderer = gameObjects[i].GetComponent<MeshRenderer>();

                var vertexCount = instanceMesh.vertexCount;
                var UV4 = new List<Vector3>(vertexCount);
                var newUV4 = new List<Vector4>(vertexCount);

                instanceMesh.GetUVs(3, UV4);

                if (usePrebakedPivots)
                {
                    for (int v = 0; v < vertexCount; v++)
                    {
                        var currentPivot = new Vector3(UV4[v].x, UV4[v].z, UV4[v].y);
                        var transformedPivot = gameObjects[i].transform.TransformPoint(currentPivot);
                        var swizzeledPivots = new Vector4(transformedPivot.x, transformedPivot.z, transformedPivot.y, 0);

                        newUV4.Add(swizzeledPivots);
                    }
                }
                else
                {
                    for (int v = 0; v < vertexCount; v++)
                    {
                        var currentPivot = gameObjects[i].transform.position;
                        var swizzeledPivots = new Vector4(currentPivot.x, currentPivot.z, currentPivot.y, 0);

                        newUV4.Add(swizzeledPivots);
                    }
                }

                instanceMesh.SetUVs(3, newUV4);

                combineInstances[i].mesh = instanceMesh;
                combineInstances[i].transform = meshRenderer.transform.localToWorldMatrix;
                combineInstances[i].lightmapScaleOffset = meshRenderer.lightmapScaleOffset;
                combineInstances[i].realtimeLightmapScaleOffset = meshRenderer.realtimeLightmapScaleOffset;
            }

            mesh.CombineMeshes(combineInstances, mergeSubMeshes, true, true);

            return mesh;
        }

        public static Mesh CombinePackedMeshes(List<GameObject> gameObjects, bool mergeSubMeshes)
        {
            return CombinePackedMeshes(gameObjects, mergeSubMeshes, true);
        }

        public static Mesh CombineColliderMeshes(List<GameObject> gameObjects)
        {
            var mesh = new Mesh();
            var combineInstances = new CombineInstance[gameObjects.Count];

            for (int i = 0; i < gameObjects.Count; i++)
            {
                var instanceMesh = UnityEngine.Object.Instantiate(gameObjects[i].GetComponent<MeshFilter>().sharedMesh);
                var meshRenderer = gameObjects[i].GetComponent<MeshRenderer>();
                var transformMatrix = meshRenderer.transform.localToWorldMatrix;

                combineInstances[i].mesh = instanceMesh;
                combineInstances[i].transform = transformMatrix;
                combineInstances[i].lightmapScaleOffset = meshRenderer.lightmapScaleOffset;
                combineInstances[i].realtimeLightmapScaleOffset = meshRenderer.realtimeLightmapScaleOffset;
            }

            mesh.CombineMeshes(combineInstances, true, true, false);

            return mesh;
        }

        public static List<Mesh> SplitPackedMesh(Mesh mesh)
        {
            var spliMeshes = new List<Mesh>();

            for (int i = 0; i < mesh.subMeshCount; i++)
            {
                Mesh submesh = GetSubmesh(mesh, i);

                spliMeshes.Add(submesh);
            }

            return spliMeshes;
        }

        public static Mesh GetSubmesh(Mesh mesh, int submeshIndex)
        {
            int[] triangles = mesh.GetTriangles(submeshIndex, true);

            Vector3[] vertices = mesh.vertices;
            Vector3[] normals = mesh.normals;
            Vector4[] tangents = mesh.tangents;
            Color[] colors = mesh.colors;
            List<Vector4> UV0 = new List<Vector4>();
            List<Vector4> UV2 = new List<Vector4>();
            List<Vector4> UV4 = new List<Vector4>();

            mesh.GetUVs(0, UV0);
            mesh.GetUVs(1, UV2);
            mesh.GetUVs(3, UV4);

            // Create a HashSet to store unique vertices and a dictionary to map old indices to new indices
            HashSet<Vector3> uniqueVertices = new HashSet<Vector3>();
            Dictionary<int, int> indexMap = new Dictionary<int, int>();
            Dictionary<Vector3, int> vertexMap = new Dictionary<Vector3, int>();

            // Loop through the triangles and add their vertices to the HashSet
            foreach (int triangleIndex in triangles)
            {
                Vector3 vertex = vertices[triangleIndex];

                if (!uniqueVertices.Contains(vertex))
                {
                    uniqueVertices.Add(vertex);

                    int newIndex = uniqueVertices.Count - 1;

                    indexMap[triangleIndex] = newIndex;
                    vertexMap[vertex] = newIndex;
                }
            }

            Vector3[] newVertices = new Vector3[uniqueVertices.Count];
            Vector3[] newNormals = new Vector3[uniqueVertices.Count];
            Vector4[] newTangents = new Vector4[uniqueVertices.Count];
            Color[] newColors = new Color[uniqueVertices.Count];
            List<Vector4> newUV0 = new List<Vector4>();
            List<Vector4> newUV2 = new List<Vector4>();
            List<Vector4> newUV4 = new List<Vector4>();

            uniqueVertices.CopyTo(newVertices);

            foreach (KeyValuePair<int, int> pair in indexMap)
            {
                int oldIndex = pair.Key;
                int newIndex = pair.Value;
                newNormals[newIndex] = normals[oldIndex];
                newTangents[newIndex] = tangents[oldIndex];
                newColors[newIndex] = colors[oldIndex];
                newUV0.Add(UV0[oldIndex]);
                newUV2.Add(UV2[oldIndex]);
                newUV4.Add(UV4[oldIndex]);
            }

            int[] newTriangles = new int[triangles.Length];

            for (int i = 0; i < triangles.Length; i += 3)
            {
                int newIndex1 = vertexMap[vertices[triangles[i + 0]]];
                int newIndex2 = vertexMap[vertices[triangles[i + 1]]];
                int newIndex3 = vertexMap[vertices[triangles[i + 2]]];
                newTriangles[i + 0] = newIndex1;
                newTriangles[i + 1] = newIndex2;
                newTriangles[i + 2] = newIndex3;
            }

            Mesh newMesh = new Mesh();
            newMesh.vertices = newVertices;
            newMesh.normals = newNormals;
            newMesh.tangents = newTangents;
            newMesh.colors = newColors;
            newMesh.SetUVs(0, newUV0);
            newMesh.SetUVs(1, newUV2);
            newMesh.SetUVs(3, newUV4);
            newMesh.triangles = newTriangles;

            return newMesh;
        }

#if UNITY_EDITOR
        public static void ValidateModel(string path, List<Vector2> subMeshMotion, bool unloadFromMemory)
        {
            // Exclude upgraded meshes or meshes converted with TVE24
            if (TVEUtils.HasLabel(path))
            {
                return;
            }

            if (Path.GetFullPath(path).Length > 256)
            {
                Debug.Log("<b>[The Visual Engine]</b> " + path + " could not be upgraded because the file path is too long! To fix the issue, rename the folders and file names, then go to Hub > Show Advanced Settings > Validate All Project Meshes to re-process the meshes!");
                return;
            }

            var mesh = AssetDatabase.LoadAssetAtPath<Mesh>(path);

            if (mesh == null)
            {
                Debug.Log("<b>[The Visual Engine]</b> " + path + " could not be upgraded because the mesh is null!");
                return;
            }

            var meshName = mesh.name;

            var instanceMesh = UnityEngine.Object.Instantiate(mesh);
            instanceMesh.name = meshName;

            if (instanceMesh == null)
            {
                Debug.Log("<b>[The Visual Engine]</b> " + path + " could not be upgraded because the mesh is null!");
                return;
            }

            //var bounds = mesh.bounds;

            //var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
            //var maxZ = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));
            //var maxR = Mathf.Max(maxX, maxZ);

            var vertexCount = mesh.vertexCount;
            var vertices = new List<Vector3>(vertexCount);
            var colors = new List<Color>(vertexCount);
            var UV0 = new List<Vector4>(vertexCount);
            var UV2 = new List<Vector4>(vertexCount);
            var UV4 = new List<Vector4>(vertexCount);
            var newColors = new List<Color>(vertexCount);
            var newUV0 = new List<Vector2>(vertexCount);
            var newUV2 = new List<Vector2>(vertexCount);
            var newUV3 = new List<Vector2>(vertexCount);
            var newUV4 = new List<Vector2>(vertexCount);
            //var newUV5 = new List<Vector2>(vertexCount);

            mesh.GetVertices(vertices);
            mesh.GetColors(colors);
            mesh.GetUVs(0, UV0);
            mesh.GetUVs(1, UV2);
            mesh.GetUVs(3, UV4);

            var motion = new List<Vector2>(vertexCount);

            if (UV0.Count != 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion.Add(BoxoUtils.MathFloatFromVector2(UV0[i].z));
                }
            }
            else
            {
                motion.Add(Vector2.zero);
            }

            var subMeshCount = instanceMesh.subMeshCount;

            for (int s = 0; s < subMeshCount; s++)
            {
                var subMesh = instanceMesh.GetSubMesh(s);
                var baseVertex = subMesh.firstVertex;
                var endVertex = subMesh.firstVertex + subMesh.vertexCount;

                for (int i = baseVertex; i < endVertex; i++)
                {
                    if (colors.Count != 0)
                    {
                        // Submesh count can be different than the material array
                        if (subMeshMotion != null && subMeshMotion.Count >= s)
                        {
                            var vcolor = colors[i];

                            if (subMeshMotion[s].x == 1)
                            {
                                vcolor.g = motion[i].x;
                            }

                            if (subMeshMotion[s].y == 1)
                            {
                                vcolor.b = motion[i].y;
                            }

                            newColors.Add(vcolor);
                        }
                        else
                        {
                            newColors.Add(colors[i]);
                        }
                    }
                    else
                    {
                        newColors.Add(Color.white);
                    }

                    if (UV0.Count != 0)
                    {
                        //var motion = TVEUtils.MathFloatFromVector2(UV0[i].z);

                        newUV0.Add(new Vector2(UV0[i].x, UV0[i].y));
                        //newUV5.Add(new Vector2(motion.x, motion.y));
                    }
                    else
                    {
                        newUV0.Add(Vector2.zero);
                        //newUV5.Add(Vector2.zero);
                    }

                    if (UV2.Count != 0)
                    {
                        newUV2.Add(new Vector2(UV2[i].x, UV2[i].y));
                        newUV3.Add(new Vector2(UV2[i].z, UV2[i].w));
                    }
                    else
                    {
                        if (UV0.Count != 0)
                        {
                            newUV2.Add(new Vector2(UV0[i].x, UV0[i].y));
                            newUV3.Add(new Vector2(UV0[i].z, UV0[i].w));
                        }
                        else
                        {
                            newUV2.Add(Vector2.zero);
                            newUV3.Add(Vector2.zero);
                        }
                    }

                    if (UV4.Count != 0)
                    {
                        newUV4.Add(new Vector2(UV4[i].x, UV4[i].y));
                    }
                    else
                    {
                        newUV4.Add(Vector2.zero);
                    }
                }
            }

            for (int i = 0; i < vertexCount; i++)
            {

            }

            instanceMesh.SetColors(newColors);
            instanceMesh.SetUVs(0, newUV0);
            instanceMesh.SetUVs(1, newUV2);
            instanceMesh.SetUVs(2, newUV3);
            instanceMesh.SetUVs(3, newUV4);
            //newMesh.SetUVs(4, newUV5);

            mesh.Clear();

            EditorUtility.CopySerialized(instanceMesh, mesh);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            TVEUtils.SetLabel(path);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            if (unloadFromMemory)
            {
                Resources.UnloadAsset(mesh);
                Resources.UnloadAsset(Resources.Load<Mesh>(path));
            }

            vertices.Clear();
            colors.Clear();
            UV0.Clear();
            UV2.Clear();
            UV4.Clear();
            newColors.Clear();
            newUV0.Clear();
            newUV2.Clear();
            newUV3.Clear();
            newUV4.Clear();
            //newUV5.Clear();
        }

        public static TVEModelSettings PreProcessMesh(string meshPath)
        {
            TVEModelSettings meshSettings = new TVEModelSettings();
            meshSettings.meshPath = meshPath;

            var modelImporter = AssetImporter.GetAtPath(meshPath) as ModelImporter;

            if (modelImporter != null)
            {
                var doPrecessing = false;

                if (!modelImporter.isReadable)
                {
                    doPrecessing = true;
                }

                if (modelImporter.keepQuads)
                {
                    doPrecessing = true;
                }

                if (modelImporter.meshCompression != ModelImporterMeshCompression.Off)
                {
                    doPrecessing = true;
                }

                if (doPrecessing)
                {
                    meshSettings.isReadable = modelImporter.isReadable;
                    meshSettings.keepQuads = modelImporter.keepQuads;
                    meshSettings.meshCompression = modelImporter.meshCompression;

                    modelImporter.isReadable = true;
                    modelImporter.keepQuads = false;
                    modelImporter.meshCompression = ModelImporterMeshCompression.Off;
                    modelImporter.SaveAndReimport();
                    AssetDatabase.Refresh();

                    meshSettings.requiresProcessing = true;
                }
            }

            //string fileText = File.ReadAllText(meshPath);
            //fileText = fileText.Replace("m_IsReadable: 0", "m_IsReadable: 1");
            //File.WriteAllText(meshPath, fileText);
            //AssetDatabase.SaveAssets();
            //AssetDatabase.Refresh();

            return meshSettings;
        }

        public static void PostProcessMesh(string meshPath, TVEModelSettings meshSettings)
        {
            if (meshSettings.requiresProcessing)
            {
                var modelImporter = AssetImporter.GetAtPath(meshPath) as ModelImporter;

                if (modelImporter != null)
                {
                    modelImporter.isReadable = meshSettings.isReadable;
                    modelImporter.keepQuads = meshSettings.keepQuads;
                    modelImporter.meshCompression = meshSettings.meshCompression;
                    modelImporter.SaveAndReimport();
                }
            }
        }

        public static void CreateModifiableMeshes(Mesh mesh)
        {
            var meshPath = AssetDatabase.GetAssetPath(mesh);

            var meshBase = UnityEngine.Object.Instantiate(mesh);
            var meshMotion = UnityEngine.Object.Instantiate(mesh);

            var vertexCount = mesh.vertexCount;

            var colors = new List<Color>(vertexCount);
            var UV0 = new List<Vector4>(vertexCount);
            var UV2 = new List<Vector4>(vertexCount);

            mesh.GetColors(colors);
            mesh.GetUVs(0, UV0);
            mesh.GetUVs(1, UV2);

            var dataUV3 = new List<Vector2>(vertexCount);
            var dataBase = new List<Color>(vertexCount);
            var dataMotion = new List<Color>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                // Store Detail UVs
                dataUV3.Add(new Vector4(UV2[i].z, UV2[i].w, 0, 0));

                // Store Variation, Occlusion and Detail Mask
                dataBase.Add(new Color(colors[i].r, colors[i].g, colors[i].b, 0));

                // Store HeightTexture Mask, Branch Mask and Leaves Mask
                var motionMasks = BoxoUtils.MathFloatFromVector2(UV0[i].z);
                dataMotion.Add(new Color(colors[i].a, motionMasks.x, motionMasks.y, 0));
            }

            meshBase.SetUVs(2, dataUV3);
            meshBase.SetColors(dataBase);
            meshMotion.SetColors(dataMotion);

            var basePath = meshPath.Replace("OO Model", "Modifiable Base");
            var motionPath = meshPath.Replace("OO Model", "Modifiable Motion");

            if (!File.Exists(basePath))
            {
                AssetDatabase.CreateAsset(meshBase, basePath);
            }
            else
            {
                var meshFile = AssetDatabase.LoadAssetAtPath<Mesh>(basePath);
                meshFile.Clear();
                EditorUtility.CopySerialized(meshBase, meshFile);
            }

            if (!File.Exists(motionPath))
            {
                AssetDatabase.CreateAsset(meshMotion, motionPath);
            }
            else
            {
                var meshFile = AssetDatabase.LoadAssetAtPath<Mesh>(motionPath);
                meshFile.Clear();
                EditorUtility.CopySerialized(meshMotion, meshFile);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        public static void CombineModifiableMeshes(Mesh mesh, Mesh meshBase, Mesh meshMotion)
        {
            var newMesh = UnityEngine.Object.Instantiate(mesh);
            newMesh.name = mesh.name;

            var vertexCount = mesh.vertexCount;

            var newColors = new List<Color>(vertexCount);
            var newUV0 = new List<Vector4>(vertexCount);
            var newUV2 = new List<Vector4>(vertexCount);

            mesh.GetColors(newColors);
            mesh.GetUVs(0, newUV0);
            mesh.GetUVs(1, newUV2);

            var dataUV3 = new List<Vector2>(vertexCount);
            var dataBase = new List<Color>(vertexCount);
            var dataMotion = new List<Color>(vertexCount);

            meshBase.GetUVs(3, dataUV3);
            meshBase.GetColors(dataBase);
            meshMotion.GetColors(dataMotion);

            for (int i = 0; i < vertexCount; i++)
            {
                newColors[i] = new Color(dataBase[i].r, dataBase[i].g, dataBase[i].b, dataMotion[i].r);
                newUV0[i] = new Vector4(newUV0[i].x, newUV0[i].y, BoxoUtils.MathVector2ToFloat(dataMotion[i].g, dataMotion[i].b), newUV0[i].w);
                newUV2[i] = new Vector4(newUV2[i].x, newUV2[i].y, dataUV3[i].x, dataUV3[i].y);
            }

            newMesh.SetColors(newColors);
            newMesh.SetUVs(0, newUV0);
            newMesh.SetUVs(1, newUV2);

            mesh.Clear();

            if (!mesh.isReadable)
            {
                newMesh.UploadMeshData(true);
            }

            EditorUtility.CopySerialized(newMesh, mesh);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        // Baking Utils
        public static TVEPackerData InitPackerData()
        {
            TVEPackerData packerData = new TVEPackerData();

            packerData.blitMaterial = new Material(Shader.Find("Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Packer"));

            packerData.maskChannels = new int[4];
            packerData.maskCoords = new int[4];
            //maskLayers = new int[4];
            packerData.maskActions0 = new int[4];
            packerData.maskValues0 = new float[4];
            packerData.maskActions1 = new int[4];
            packerData.maskValues1 = new float[4];
            packerData.maskTextures = new Texture[4];

            for (int i = 0; i < 4; i++)
            {
                packerData.maskChannels[i] = 0;
                packerData.maskCoords[i] = 0;
                //maskLayers[i] = 0;
                packerData.maskActions0[i] = 0;
                packerData.maskValues0[i] = 1;
                packerData.maskActions1[i] = 0;
                packerData.maskValues1[i] = 1;
                packerData.maskTextures[i] = null;
            }

            return packerData;
        }

        public static Texture CreatePackedTexture(string savePath, TVEPackerData packerData)
        {
            int importSize = GetPackedTextureImportSize(packerData);

            List<TVETextureSettings> uniqueTextureSettings = new List<TVETextureSettings>();

            for (int i = 0; i < packerData.maskTextures.Length; i++)
            {
                var texture = packerData.maskTextures[i];

                if (texture != null)
                {
                    var texturePath = AssetDatabase.GetAssetPath(texture);

                    bool exists = false;

                    for (int s = 0; s < uniqueTextureSettings.Count; s++)
                    {
                        if (texturePath == uniqueTextureSettings[s].texturePath)
                        {
                            exists = true;
                            break;
                        }
                    }

                    if (!exists)
                    {
                        var textureSettings = TVEUtils.PreProcessTexture(texturePath);
                        uniqueTextureSettings.Add(textureSettings);
                    }
                }
            }

            //Set Packer Metallic channel
            if (packerData.maskTextures[0] != null)
            {
                if (packerData.maskTextures[0].isDataSRGB)
                {
                    packerData.blitMaterial.SetInt("_PackerTexGammaModeR", 1);
                }

                packerData.blitMaterial.SetTexture("_PackerTexR", packerData.maskTextures[0]);
                packerData.blitMaterial.SetInt("_PackerChannelR", packerData.maskChannels[0]);
                packerData.blitMaterial.SetInt("_PackerCoordR", packerData.maskCoords[0]);
                //blitMaterial.SetInt("_Packer_LayerR", maskLayers[0]);
                packerData.blitMaterial.SetInt("_PackerActionR0", packerData.maskActions0[0]);
                packerData.blitMaterial.SetFloat("_PackerValueR0", packerData.maskValues0[0]);
                packerData.blitMaterial.SetInt("_PackerActionR1", packerData.maskActions1[0]);
                packerData.blitMaterial.SetFloat("_PackerValueR1", packerData.maskValues1[0]);
            }
            else
            {
                packerData.blitMaterial.SetInt("_PackerChannelR", 0);
                packerData.blitMaterial.SetFloat("_PackerFloatR", 1.0f);
            }

            //Set Packer Occlusion channel
            if (packerData.maskTextures[1] != null)
            {
                if (packerData.maskTextures[1].isDataSRGB)
                {
                    packerData.blitMaterial.SetInt("_PackerTexGammaModeG", 1);
                }

                packerData.blitMaterial.SetTexture("_PackerTexG", packerData.maskTextures[1]);
                packerData.blitMaterial.SetInt("_PackerChannelG", packerData.maskChannels[1]);
                packerData.blitMaterial.SetInt("_PackerCoordG", packerData.maskCoords[1]);
                //blitMaterial.SetInt("_Packer_LayerG", maskLayers[1]);
                packerData.blitMaterial.SetInt("_PackerActionG0", packerData.maskActions0[1]);
                packerData.blitMaterial.SetFloat("_PackerValueG0", packerData.maskValues0[1]);
                packerData.blitMaterial.SetInt("_PackerActionG1", packerData.maskActions1[1]);
                packerData.blitMaterial.SetFloat("_PackerValueG1", packerData.maskValues1[1]);
            }
            else
            {
                packerData.blitMaterial.SetInt("_PackerChannelG", 0);
                packerData.blitMaterial.SetFloat("_PackerFloatG", 1.0f);
            }

            //Set Packer Mask channel
            if (packerData.maskTextures[2] != null)
            {
                if (packerData.maskTextures[2].isDataSRGB)
                {
                    packerData.blitMaterial.SetInt("_PackerTexGammaModeB", 1);
                }

                packerData.blitMaterial.SetTexture("_PackerTexB", packerData.maskTextures[2]);
                packerData.blitMaterial.SetInt("_PackerChannelB", packerData.maskChannels[2]);
                packerData.blitMaterial.SetInt("_PackerCoordB", packerData.maskCoords[2]);
                //blitMaterial.SetInt("_Packer_LayerB", maskLayers[2]);
                packerData.blitMaterial.SetInt("_PackerActionB0", packerData.maskActions0[2]);
                packerData.blitMaterial.SetFloat("_PackerValueB0", packerData.maskValues0[2]);
                packerData.blitMaterial.SetInt("_PackerActionB1", packerData.maskActions1[2]);
                packerData.blitMaterial.SetFloat("_PackerValueB1", packerData.maskValues1[2]);
            }
            else
            {
                packerData.blitMaterial.SetInt("_PackerChannelB", 0);
                packerData.blitMaterial.SetFloat("_PackerFloatB", 1.0f);
            }

            //Set Packer Smothness channel
            if (packerData.maskTextures[3] != null)
            {
                if (packerData.maskTextures[3].isDataSRGB)
                {
                    packerData.blitMaterial.SetInt("_PackerTexGammaModeA", 1);
                }

                packerData.blitMaterial.SetTexture("_PackerTexA", packerData.maskTextures[3]);
                packerData.blitMaterial.SetInt("_PackerChannelA", packerData.maskChannels[3]);
                packerData.blitMaterial.SetInt("_PackerCoordA", packerData.maskCoords[3]);
                //blitMaterial.SetInt("_Packer_LayerA", maskLayers[3]);
                packerData.blitMaterial.SetInt("_PackerActionA0", packerData.maskActions0[3]);
                packerData.blitMaterial.SetFloat("_PackerValueA0", packerData.maskValues0[3]);
                packerData.blitMaterial.SetInt("_PackerActionA1", packerData.maskActions1[3]);
                packerData.blitMaterial.SetFloat("_PackerValueA1", packerData.maskValues1[3]);
            }
            else
            {
                packerData.blitMaterial.SetInt("_PackerChannelA", 0);
                packerData.blitMaterial.SetFloat("_PackerFloatA", 1.0f);
            }

            packerData.blitMaterial.SetInt("_PackerTransformMode", packerData.transformSpace);

            Vector2 pixelSize = GetPackedTexturePixelSize(packerData);

            RenderTexture renderTexture = new RenderTexture((int)pixelSize.x, (int)pixelSize.y, 0, RenderTextureFormat.ARGBFloat);
            Texture2D packedTexture = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGBAFloat, false);

            if (packerData.blitMesh != null)
            {
                var currentRenderTexture = RenderTexture.active;

                Graphics.SetRenderTarget(renderTexture);

                GL.Clear(false, true, new Color(0.5f, 0.5f, 1f, 0f), 0f);

                GL.PushMatrix();
                GL.LoadOrtho();

                packerData.blitMaterial.SetPass(packerData.blitPass);

                Graphics.DrawMeshNow(packerData.blitMesh, Matrix4x4.identity);

                RenderTexture.active = renderTexture;
                packedTexture.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);
                packedTexture.Apply();
                RenderTexture.active = currentRenderTexture;

                Graphics.SetRenderTarget(null);
                GL.PopMatrix();
            }
            else
            {
                var currentRenderTexture = RenderTexture.active;

                Graphics.Blit(Texture2D.whiteTexture, renderTexture, packerData.blitMaterial, packerData.blitPass);
                RenderTexture.active = renderTexture;
                packedTexture.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);
                packedTexture.Apply();
                RenderTexture.active = currentRenderTexture;
            }

            renderTexture.Release();

            if (savePath.EndsWith(".asset"))
            {
                if (File.Exists(savePath))
                {
                    var assetTexture = AssetDatabase.LoadAssetAtPath<Texture>(savePath);

                    EditorUtility.CopySerialized(packedTexture, assetTexture);
                }
                else
                {
                    AssetDatabase.CreateAsset(packedTexture, savePath);
                }

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }
            else
            {
                byte[] bytes;

                if (savePath.EndsWith("png"))
                {
                    bytes = packedTexture.EncodeToPNG();
                }
                else if (savePath.EndsWith("tga"))
                {
                    bytes = packedTexture.EncodeToTGA();
                }
                else
                {
                    bytes = packedTexture.EncodeToEXR();
                }

                //Workaround for long paths
                if (Path.GetFullPath(savePath).Length > 250)
                {
                    var fileName = Path.GetFileName(savePath);
                    var tempPath = "Assets/" + fileName;

                    File.WriteAllBytes(tempPath, bytes);

                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();

                    AssetDatabase.MoveAsset(tempPath, savePath);

                    AssetDatabase.DeleteAsset(tempPath);

                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }
                else
                {
                    File.WriteAllBytes(savePath, bytes);

                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }

                TextureImporter texImporter = AssetImporter.GetAtPath(savePath) as TextureImporter;

                if (packerData.saveAsDefault)
                {
                    texImporter.textureType = TextureImporterType.Default;
                }
                else
                {
                    texImporter.textureType = TextureImporterType.NormalMap;
                }

                texImporter.maxTextureSize = importSize;
                texImporter.sRGBTexture = packerData.saveAsSRGB;
                texImporter.alphaSource = TextureImporterAlphaSource.FromInput;

                texImporter.SaveAndReimport();
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                TVEUtils.SetLabel(savePath);

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            for (int i = 0; i < uniqueTextureSettings.Count; i++)
            {
                var textureSettings = uniqueTextureSettings[i];
                TVEUtils.PostProcessTexture(textureSettings.texturePath, textureSettings);
            }

            return AssetDatabase.LoadAssetAtPath<Texture>(savePath);
        }

        static int GetPackedTextureImportSize(TVEPackerData packerData)
        {
            int initSize = 32;

            for (int i = 0; i < packerData.maskTextures.Length; i++)
            {
                var texture = packerData.maskTextures[i];

                if (texture != null)
                {
                    string texPath = AssetDatabase.GetAssetPath(texture);

                    if (texPath.EndsWith(".asset"))
                    {
                        var texAsset = AssetDatabase.LoadAssetAtPath<Texture>(texPath);

                        initSize = Mathf.Max(initSize, texAsset.width);
                    }
                    else
                    {
                        TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                        initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
                    }
                }
            }

            return initSize;
        }

        static Vector2 GetPackedTexturePixelSize(TVEPackerData packerData)
        {
            int x = 32;
            int y = 32;

            for (int i = 0; i < packerData.maskTextures.Length; i++)
            {
                var texture = packerData.maskTextures[i];

                if (texture != null)
                {
                    x = Mathf.Max(x, texture.width);
                    y = Mathf.Max(y, texture.height);
                }
            }

            return new Vector2(x, y);
        }

        public static TVETextureSettings PreProcessTexture(string texturePath)
        {
            TVETextureSettings textureSettings = new TVETextureSettings();
            textureSettings.texturePath = texturePath;

            if (texturePath.EndsWith(".asset"))
            {
                textureSettings.isAsset = true;
            }
            else
            {
                TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;

                textureSettings.textureCompression = importer.textureCompression;
                textureSettings.maxTextureSize = importer.maxTextureSize;

                importer.ReadTextureSettings(textureSettings.textureSettings);

                //importer.textureType = TextureImporterType.Default;
                importer.sRGBTexture = false;
                importer.maxTextureSize = 8192;
                importer.textureCompression = TextureImporterCompression.Uncompressed;

                importer.SaveAndReimport();

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            return textureSettings;
        }

        public static void PostProcessTexture(string texturePath, TVETextureSettings textureSettings)
        {
            if (!textureSettings.isAsset)
            {
                TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;

                importer.textureCompression = textureSettings.textureCompression;
                importer.maxTextureSize = textureSettings.maxTextureSize;

                importer.SetTextureSettings(textureSettings.textureSettings);

                importer.SaveAndReimport();

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }
        }

#endif

        //public static Texture CreateProxyTextureFromTerrain(TVEProxyData proxyData)
        //{
        //    var tveTerrain = proxyData.blitTVETerrain;

        //    if (tveTerrain == null)
        //    {
        //        return null;
        //    }

        //    var terrain = proxyData.blitTVETerrain.terrain;

        //    if (terrain == null)
        //    {
        //        return null;
        //    }

        //    Vector3 terrainPosition = terrain.transform.position;
        //    Vector3 terrainSize = terrain.terrainData.size;

        //    var sharedMesh = CreateQuadFromTerrain(terrainPosition, terrainSize);
        //    var sharedMaterial = terrain.materialTemplate;

        //    var blitMaterial = new Material(sharedMaterial);
        //    blitMaterial.shader = proxyData.blitShader;
        //    blitMaterial.SetInt("_BakeDataMode", proxyData.bakeData);

        //    if (proxyData.bakeAlbedoAsSRGB)
        //    {
        //        blitMaterial.SetInt("_BakeAlbedoSRGBMode", 1);
        //    }
        //    else
        //    {
        //        blitMaterial.SetInt("_BakeAlbedoSRGBMode", 0);
        //    }

        //    var blitPropertBlock = tveTerrain.terrainPropertyBlock;

        //    // Create Textures
        //    RenderTexture renderTexture = new RenderTexture(proxyData.saveSize, proxyData.saveSize, 0, RenderTextureFormat.ARGBHalf);
        //    Texture2D proxyTexture = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGBAHalf, false);

        //    // Start texture rendering
        //    var currentRenderTexture = RenderTexture.active;

        //    CommandBuffer commandBuffer = new();

        //    commandBuffer.SetRenderTarget(renderTexture);
        //    commandBuffer.ClearRenderTarget(false, true, Color.clear);

        //    commandBuffer.SetViewport(new Rect(0, 0, renderTexture.width, renderTexture.height));

        //    // Terrain extents
        //    float left = terrainPosition.x;
        //    float right = terrainPosition.x + terrainSize.x;
        //    float bottom = terrainPosition.z;
        //    float top = terrainPosition.z + terrainSize.z;

        //    // Build view & projection
        //    Matrix4x4 view = Matrix4x4.TRS(Vector3.zero, Quaternion.Euler(90, 0, 0), Vector3.one).inverse;
        //    Matrix4x4 proj = Matrix4x4.Ortho(left, right, bottom, top, -10000f, 10000f);

        //    commandBuffer.SetViewProjectionMatrices(view, proj);

        //    commandBuffer.DrawMesh(sharedMesh, Matrix4x4.identity, blitMaterial, 0, 0, blitPropertBlock);

        //    Graphics.ExecuteCommandBuffer(commandBuffer);

        //    RenderTexture.active = renderTexture;

        //    proxyTexture.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);
        //    proxyTexture.Apply();

        //    RenderTexture.active = currentRenderTexture;

        //    renderTexture.Release();
        //    commandBuffer.Release();

        //    return proxyTexture;
        //}

        public static Texture CreateProxyTextureFromTerrain(TVEProxyData proxyData, MaterialPropertyBlock terrainPropertyBlock, Vector3 terrainPosition, Vector3 terrainSize)
        {
            if (terrainPropertyBlock == null)
            {
                return null;
            }

            RenderTexture renderTexture = new RenderTexture(proxyData.saveSize, proxyData.saveSize, 0, RenderTextureFormat.ARGBHalf);
            renderTexture.useMipMap = true;
            //Texture2D proxyTexture = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGBAHalf, false);

            //var currentRenderTexture = RenderTexture.active;

            CommandBuffer commandBuffer = new();

            commandBuffer.SetRenderTarget(renderTexture);
            commandBuffer.ClearRenderTarget(false, true, Color.clear);

            commandBuffer.SetViewport(new Rect(0, 0, renderTexture.width, renderTexture.height));

            // Terrain extents
            float left = terrainPosition.x;
            float right = terrainPosition.x + terrainSize.x;
            float bottom = terrainPosition.z;
            float top = terrainPosition.z + terrainSize.z;

            // Build view & projection
            Matrix4x4 view = Matrix4x4.TRS(Vector3.zero, Quaternion.Euler(90, 0, 0), Vector3.one).inverse;
            Matrix4x4 proj = Matrix4x4.Ortho(left, right, bottom, top, -10000f, 10000f);

            commandBuffer.SetViewProjectionMatrices(view, proj);

            commandBuffer.DrawMesh(proxyData.blitMesh, Matrix4x4.identity, proxyData.blitMaterial, 0, 0, terrainPropertyBlock);

            Graphics.ExecuteCommandBuffer(commandBuffer);

            //RenderTexture.active = renderTexture;

            //proxyTexture.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);
            //proxyTexture.Apply();

            //RenderTexture.active = currentRenderTexture;

            //renderTexture.Release();
            commandBuffer.Release();

            return renderTexture;
        }

        public static Mesh CreateQuadFromTerrain(Vector3 terrainPos, Vector3 terrainSize)
        {
            Mesh mesh = new Mesh();

            Vector3 bottomLeft = new Vector3(terrainPos.x, 0, terrainPos.z);
            Vector3 bottomRight = new Vector3(terrainPos.x + terrainSize.x, 0, terrainPos.z);
            Vector3 topLeft = new Vector3(terrainPos.x, 0, terrainPos.z + terrainSize.z);
            Vector3 topRight = new Vector3(terrainPos.x + terrainSize.x, 0, terrainPos.z + terrainSize.z);

            Vector3[] vertices =
            {
                bottomLeft,
                bottomRight,
                topLeft,
                topRight
            };

            Vector2[] uv =
            {
                new Vector2(0, 0),
                new Vector2(1, 0),
                new Vector2(0, 1),
                new Vector2(1, 1)
            };

            int[] triangles =
            {
                0, 2, 1,
                2, 3, 1
            };

            mesh.vertices = vertices;
            mesh.uv = uv;
            mesh.triangles = triangles;

            mesh.RecalculateNormals();
            mesh.RecalculateBounds();

            return mesh;
        }

#if UNITY_EDITOR
        public static Texture SaveProxyTextureFromTerrain(string savePath, Texture renderTexture, TVEProxyData proxyData)
        {
            savePath = savePath + "/" + renderTexture.name + ".png";

            Texture2D proxyTexture = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGBA32, false);

            var currentRenderTexture = RenderTexture.active;

            RenderTexture.active = (RenderTexture)renderTexture;

            proxyTexture.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);
            proxyTexture.Apply();

            RenderTexture.active = currentRenderTexture;

            BoxoUtils.DestryObject(renderTexture);

            if (savePath.EndsWith(".asset"))
            {
                if (File.Exists(savePath))
                {
                    var assetTexture = AssetDatabase.LoadAssetAtPath<Texture>(savePath);

                    EditorUtility.CopySerialized(proxyTexture, assetTexture);
                }
                else
                {
                    AssetDatabase.CreateAsset(proxyTexture, savePath);
                }

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }
            else
            {
                byte[] bytes;

                if (savePath.EndsWith("png"))
                {
                    bytes = proxyTexture.EncodeToPNG();
                }
                else if (savePath.EndsWith("tga"))
                {
                    bytes = proxyTexture.EncodeToTGA();
                }
                else
                {
                    bytes = proxyTexture.EncodeToEXR();
                }

                File.WriteAllBytes(savePath, bytes);

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                TextureImporter texImporter = AssetImporter.GetAtPath(savePath) as TextureImporter;

                if (proxyData.saveAsDefault)
                {
                    texImporter.textureType = TextureImporterType.Default;
                }
                else
                {
                    texImporter.textureType = TextureImporterType.NormalMap;
                }

                texImporter.maxTextureSize = proxyData.saveSize;
                texImporter.sRGBTexture = proxyData.saveAsSRGB;
                texImporter.alphaSource = TextureImporterAlphaSource.FromInput;
                texImporter.wrapMode = TextureWrapMode.Clamp;

                texImporter.SaveAndReimport();
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                TVEUtils.SetLabel(savePath);
            }

            return AssetDatabase.LoadAssetAtPath<Texture>(savePath);
        }
#endif

        // GameObject Utils
        public static void GetChildRecursive(GameObject go, List<GameObject> gameObjects)
        {
            foreach (Transform child in go.transform)
            {
                if (child == null)
                    continue;

                gameObjects.Add(child.gameObject);
                GetChildRecursive(child.gameObject, gameObjects);
            }
        }

        public static void GetChildRecursive(GameObject go, List<TVEGameObjectData> gameObjectsData)
        {
            foreach (Transform child in go.transform)
            {
                if (child == null)
                    continue;

                var gameObjectData = new TVEGameObjectData();
                gameObjectData.gameObject = child.gameObject;

                gameObjectsData.Add(gameObjectData);
                GetChildRecursive(child.gameObject, gameObjectsData);
            }
        }


        //// Math Utils
        //public static float MathRemap(float value, float minOld, float maxOld, float minNew, float maxNew)
        //{
        //    return minNew + (value - minOld) * (maxNew - minNew) / (maxOld - minOld);
        //}

        //public static float MathRemap(float value, float minOld, float maxOld)
        //{
        //    return (value - minOld) / (maxOld - minOld);
        //}

        //public static float BoxoUtils.MathVector2ToFloat(float x, float y)
        //{
        //    Vector2 output;

        //    output.x = Mathf.Floor(x * (2048 - 1));
        //    output.y = Mathf.Floor(y * (2048 - 1));

        //    return (output.x * 2048) + output.y;
        //}

        //public static Vector2 MathFloatFromVector2(float input)
        //{
        //    Vector2 output;

        //    output.y = input % 2048f;
        //    output.x = Mathf.Floor(input / 2048f);

        //    return output / (2048f - 1);
        //}

        // Texture Utils
        public static Color GetGlobalTextureData(string globalTexture, Vector3 position, int layer, Texture2DArray texture2DArray)
        {
            var tveManager = TVEManager.Instance;

            if (tveManager == null)
            {
                return Color.black;
            }

            var texture = Shader.GetGlobalTexture(globalTexture) as RenderTexture;

            if (texture == null)
            {
                return Color.black;
            }

            if (layer > texture.volumeDepth - 1)
            {
                Debug.Log("<b>[The Visual Engine]</b> The requested global texture layer does not exist!");
                return Color.black;
            }

            if (texture2DArray == null || texture2DArray.depth != texture.volumeDepth)
            {
                texture2DArray = new Texture2DArray(1, 1, texture.volumeDepth, TextureFormat.RGBAHalf, false);
            }

            var volumeParams = Shader.GetGlobalVector("TVE_RenderBasePositionR");

            if (globalTexture.Contains("Near"))
            {
                volumeParams = Shader.GetGlobalVector("TVE_RenderNearPositionR");
            }

            var volumePosition = new Vector3(volumeParams.x, volumeParams.y, volumeParams.z);
            var volumeRadius = volumeParams.w;

            var normalizedPositionX = Mathf.Clamp(BoxoUtils.MathRemap(position.x, volumePosition.x - volumeRadius, volumePosition.x + volumeRadius, 0, 1), 0.001f, 1);
            var normalizedPositionZ = Mathf.Clamp(BoxoUtils.MathRemap(position.z, volumePosition.z - volumeRadius, volumePosition.z + volumeRadius, 0, 1), 0.001f, 1);

            var pixelPositionX = Mathf.RoundToInt(normalizedPositionX * texture.width - 1);
            var pixelPositionZ = Mathf.RoundToInt(normalizedPositionZ * texture.height - 1);

            var asyncGPUReadback = AsyncGPUReadback.Request(texture, 0, pixelPositionX, 1, pixelPositionZ, 1, layer, 1);
            asyncGPUReadback.WaitForCompletion();

            if (!asyncGPUReadback.hasError)
            {
                texture2DArray.SetPixelData(asyncGPUReadback.GetData<byte>(), 0, layer);
                texture2DArray.Apply();

                //AsyncGPUReadback.Request(renderData.texObject, 0, (AsyncGPUReadbackRequest asyncAction) =>
                //{
                //    texture2DArray.SetPixelData(asyncAction.GetData<byte>(), 0, 0);
                //    texture2DArray.Apply();
                //});

                var texture2DPixels = texture2DArray.GetPixels(layer, 0);

                return texture2DPixels[0];
            }
            else
            {
                return Color.black;
            }
        }

#if UNITY_EDITOR
        public static void ValidateMaterial(string path, bool unloadFromMemory)
        {
            var material = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (path.Contains("Packages"))
            {
                return;
            }

            if (material == null)
            {
                return;
            }

            if (material.HasProperty("_IsTVEShader"))
            {
                TVEUtils.SetMaterialLegacy(material);
                TVEUtils.SetMaterialUpgrade(material);
                TVEUtils.SetMaterialRuntime(material);
                TVEUtils.SetMaterialInternal(material);
                TVEUtils.SetImpostorFeatures(material);
                //TVEUtils.StripUnusedTextures(material);

                if (unloadFromMemory)
                {
                    TVEUtils.UnloadMaterialFromMemory(material);
                }

                TVEUtils.SetLabel(path);
            }

            if (material.HasProperty("_IsElementShader"))
            {
                TVEUtils.SetElementSettings(material);

                TVEUtils.SetLabel(path);
            }
        }

        public static void UnloadMaterialFromMemory(Material material)
        {
            var shader = material.shader;

            for (int i = 0; i < BoxoUtils.GetShaderPropertyCount(shader); i++)
            {
                if (BoxoUtils.GetShaderPropertyType(shader, i) == ShaderPropertyType.Texture)
                {
                    var propName = BoxoUtils.GetShaderPropertyName(shader, i);
                    var texture = material.GetTexture(propName);

                    if (texture != null)
                    {
                        if (!texture.name.Contains("Unity"))
                        {
                            Resources.UnloadAsset(texture);
                        }
                    }
                }
            }
        }

        public static void CopyMaterialProperties(Material oldMaterial, Material newMaterial)
        {
            var oldShader = oldMaterial.shader;
            var newShader = newMaterial.shader;

            for (int i = 0; i < BoxoUtils.GetShaderPropertyCount(oldShader); i++)
            {
                for (int j = 0; j < BoxoUtils.GetShaderPropertyCount(newShader); j++)
                {
                    var propertyName = BoxoUtils.GetShaderPropertyName(oldShader, i);
                    var propertyType = BoxoUtils.GetShaderPropertyType(oldShader, i);

                    if (propertyName == BoxoUtils.GetShaderPropertyName(newShader, j))
                    {
                        if (propertyType == ShaderPropertyType.Color || propertyType == ShaderPropertyType.Vector)
                        {
#if UNITY_2022_1_OR_NEWER
                            if (!oldMaterial.IsPropertyLocked(propertyName))
                            {
                                newMaterial.SetVector(propertyName, oldMaterial.GetVector(propertyName));
                            }
#else
                            newMaterial.SetVector(propertyName, oldMaterial.GetVector(propertyName));
#endif
                        }

                        if (propertyType == ShaderPropertyType.Float || propertyType == ShaderPropertyType.Range)
                        {
#if UNITY_2022_1_OR_NEWER
                            if (!oldMaterial.IsPropertyLocked(propertyName))
                            {
                                newMaterial.SetFloat(propertyName, oldMaterial.GetFloat(propertyName));
                            }
#else
                            newMaterial.SetFloat(propertyName, oldMaterial.GetFloat(propertyName));
#endif
                        }

                        if (propertyType == ShaderPropertyType.Texture)
                        {
#if UNITY_2022_1_OR_NEWER
                            if (!oldMaterial.IsPropertyLocked(propertyName))
                            {
                                newMaterial.SetTexture(propertyName, oldMaterial.GetTexture(propertyName));
                            }
#else
                            newMaterial.SetTexture(propertyName, oldMaterial.GetTexture(propertyName));
#endif
                        }
                    }
                }
            }
        }

        public static void CopyMaterialPropertiesFromBlock(MaterialPropertyBlock propertyBlock, Material newMaterial)
        {
            var newShader = newMaterial.shader;

            for (int i = 0; i < BoxoUtils.GetShaderPropertyCount(newShader); i++)
            {
                var propertyName = BoxoUtils.GetShaderPropertyName(newShader, i);
                var propertyType = BoxoUtils.GetShaderPropertyType(newShader, i);

                if (propertyType == ShaderPropertyType.Color || propertyType == ShaderPropertyType.Vector)
                {
                    if (propertyBlock.HasColor(propertyName))
                    {
                        newMaterial.SetVector(propertyName, propertyBlock.GetColor(propertyName));
                    }
                }

                if (propertyType == ShaderPropertyType.Float || propertyType == ShaderPropertyType.Range)
                {
                    if (propertyBlock.HasFloat(propertyName))
                    {
                        newMaterial.SetFloat(propertyName, propertyBlock.GetFloat(propertyName));
                    }
                }

                if (propertyType == ShaderPropertyType.Texture)
                {
                    if (propertyBlock.HasTexture(propertyName))
                    {
                        newMaterial.SetTexture(propertyName, propertyBlock.GetTexture(propertyName));
                    }
                }
            }
        }

        public static void CopyMaterialPropertiesToImpostor(Renderer renderer, Material impostorMaterial)
        {
            List<Material> allMaterials = new();

            var sharedMaterials = renderer.sharedMaterials;

            if (sharedMaterials != null)
            {
                for (int i = 0; i < sharedMaterials.Length; i++)
                {
                    var currentMaterial = sharedMaterials[i];

                    if (currentMaterial != null && !allMaterials.Contains(currentMaterial))
                    {
                        allMaterials.Add(currentMaterial);
                    }
                }
            }

            if (allMaterials.Count == 1)
            {
                var oldMaterial = allMaterials[0];

                if (oldMaterial.HasProperty("_IsStandardShader"))
                {
                    var switchImpostorShader = Shader.Find(impostorMaterial.shader.name.Replace("Subsurface", "Standard"));

                    if (switchImpostorShader != null)
                    {
                        impostorMaterial.shader = switchImpostorShader;
                    }
                }

                //if (TVEUtils.GetShaderLightingType(oldMaterial) == TVEUtils.GetShaderLightingType(impostorMaterial))
                {
                    CopyMaterialProperties(oldMaterial, impostorMaterial);
                    SetImpostorBakeModes(oldMaterial, impostorMaterial);
                    impostorMaterial.SetFloat("_IsInitialized", 1);
                }
            }
            else if (allMaterials.Count > 1)
            {
                var standardShaderCount = 0;

                for (int i = 0; i < allMaterials.Count; i++)
                {
                    var oldMaterial = allMaterials[i];

                    if (oldMaterial.HasProperty("_IsStandardShader"))
                    {
                        standardShaderCount++;
                    }
                }

                // Switch shader to Standard Lit
                if (allMaterials.Count == standardShaderCount)
                {
                    var switchImpostorShader = Shader.Find(impostorMaterial.shader.name.Replace("Subsurface", "Standard"));

                    if (switchImpostorShader != null)
                    {
                        impostorMaterial.shader = switchImpostorShader;
                    }

                    for (int i = 0; i < allMaterials.Count; i++)
                    {
                        var oldMaterial = allMaterials[i];

                        CopyMaterialProperties(oldMaterial, impostorMaterial);
                        SetImpostorBakeModes(oldMaterial, impostorMaterial);
                        impostorMaterial.SetFloat("_IsInitialized", 1);
                    }
                }
                else
                {
                    for (int i = 0; i < allMaterials.Count; i++)
                    {
                        var oldMaterial = allMaterials[i];

                        // Copy from Subsurface Lit
                        if (TVEUtils.GetShaderLightingType(oldMaterial) == "Subsurface")
                        {
                            CopyMaterialProperties(oldMaterial, impostorMaterial);
                            SetImpostorBakeModes(oldMaterial, impostorMaterial);
                            impostorMaterial.SetFloat("_IsInitialized", 1);
                        }
                    }
                }
            }
        }

        public static void CopyMaterialSelectedProperties(Material material, string[] searchResult)
        {
            TVEGlobals.searchCopyPaste = "";

            var copy = "";
            var shader = material.shader;

            for (int i = 0; i < searchResult.Length; i++)
            {
                for (int j = 0; j < BoxoUtils.GetShaderPropertyCount(shader); j++)
                {
                    var propertyName = BoxoUtils.GetShaderPropertyName(shader, j);
                    var propertyType = BoxoUtils.GetShaderPropertyType(shader, j);

                    if (propertyName.ToUpper().Contains(searchResult[i]))
                    {
                        if (propertyType == ShaderPropertyType.Color || propertyType == ShaderPropertyType.Vector)
                        {
                            var vector = material.GetVector(propertyName);
#if UNITY_2022_1_OR_NEWER
                            if (!material.IsPropertyLocked(propertyName))
                            {
                                copy = copy + "SET_VECTOR " + propertyName + " " + vector.x.ToString(CultureInfo.InvariantCulture) + " " + vector.y.ToString(CultureInfo.InvariantCulture) + " " + vector.z.ToString(CultureInfo.InvariantCulture) + " " + vector.w.ToString(CultureInfo.InvariantCulture) + ";";
                            }
#else
                            copy = copy + "SET_VECTOR " + propertyName + " " + vector.x.ToString(CultureInfo.InvariantCulture) + " " + vector.y.ToString(CultureInfo.InvariantCulture) + " " + vector.z.ToString(CultureInfo.InvariantCulture) + " " + vector.w.ToString(CultureInfo.InvariantCulture) + ";";
#endif
                        }

                        if (propertyType == ShaderPropertyType.Float || propertyType == ShaderPropertyType.Range)
                        {
                            var value = material.GetFloat(propertyName);

#if UNITY_2022_1_OR_NEWER
                            if (!material.IsPropertyLocked(propertyName))
                            {
                                copy = copy + "SET_FLOAT " + propertyName + " " + value.ToString(CultureInfo.InvariantCulture) + ";";
                            }
#else
                            copy = copy + "SET_FLOAT " + propertyName + " " + material.GetFloat(propertyName) + ";";
#endif
                        }

                        if (propertyType == ShaderPropertyType.Texture)
                        {
                            var texture = material.GetTexture(propertyName);

                            if (texture != null)
                            {
#if UNITY_2022_1_OR_NEWER
                                if (!material.IsPropertyLocked(propertyName))
                                {
                                    copy = copy + "SET_TEX_BY_GUID " + propertyName + " " + AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(texture)) + ";";
                                }
#else
                                copy = copy + "SET_TEX_BY_GUID " + propertyName + " " + AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(texture)) +";";
#endif
                            }
                            else
                            {
#if UNITY_2022_1_OR_NEWER
                                if (!material.IsPropertyLocked(propertyName))
                                {
                                    copy = copy + "SET_TEX_BY_GUID " + propertyName + " " + "NONE" + ";";
                                }
#else
                                copy = copy + "SET_TEX_BY_GUID " + propertyName + " " + "NONE" + ";";
#endif
                            }

                        }
                    }
                }
            }

            TVEGlobals.searchCopyPaste = copy;
        }

        public static void PasteMaterialSelectedProperties(Material material)
        {
            var paste = TVEGlobals.searchCopyPaste.Split(";");

            for (int i = 0; i < paste.Length; i++)
            {
                if (paste[i] == "")
                {
                    continue;
                }

                var pasteSplit = paste[i].Split(" ");
                var pasteType = pasteSplit[0];
                var properyName = pasteSplit[1];

                if (pasteType == "SET_VECTOR")
                {
                    material.SetVector(properyName, new Vector4(float.Parse(pasteSplit[2], CultureInfo.InvariantCulture), float.Parse(pasteSplit[3], CultureInfo.InvariantCulture), float.Parse(pasteSplit[4], CultureInfo.InvariantCulture), float.Parse(pasteSplit[5], CultureInfo.InvariantCulture)));
                }

                if (pasteType == "SET_FLOAT")
                {
                    material.SetFloat(properyName, float.Parse(pasteSplit[2], CultureInfo.InvariantCulture));
                }

                if (pasteType == "SET_TEX_BY_GUID")
                {
                    if (pasteSplit[2] == "NONE")
                    {
                        material.SetTexture(properyName, null);
                    }
                    else
                    {
                        var path = AssetDatabase.GUIDToAssetPath(pasteSplit[2]);

                        material.SetTexture(properyName, AssetDatabase.LoadAssetAtPath<Texture>(path));
                    }
                }
            }
        }

        public static TVEMaterialSettings GetMaterialSettings(Material material)
        {
            TVEMaterialSettings settings = new();

            var shaderName = material.shader.name;

            if (BoxoUtils.GetMaterialFloat(material, "_SecondIntensityValue") > 0)
            {
                var coordMode = BoxoUtils.GetMaterialInt(material, "_SecondSampleMode", -1);

                if (coordMode == 0 || coordMode == 1)
                {
                    settings.texCoords = true;
                }

                var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_SecondMaskSampleMode", -1);

                if (maskCoordMode == 0 || maskCoordMode == 1)
                {
                    settings.texCoords = true;
                }

                var baseValue = BoxoUtils.GetMaterialFloat(material, "_SecondBaseValue");

                if (baseValue > 0)
                {
                    settings.baseMask = true;
                }

                var meshValue = BoxoUtils.GetMaterialFloat(material, "_SecondMeshValue");
                var meshMode = BoxoUtils.GetMaterialInt(material, "_SecondMeshMode");

                if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                {
                    settings.meshMaskRG = true;
                }

                if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                {
                    settings.meshMaskBA = true;
                }
            }

            return settings;
        }

        public static void StripUnusedTextures(Material material)
        {
            if (BoxoUtils.GetMaterialFloat(material, "_SecondIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_SecondAlbedoTex");
                StripUnusedTexture(material, "_SecondNormalTex");
                StripUnusedTexture(material, "_SecondShaderTex");
                StripUnusedTexture(material, "_SecondMaskTex");
            }

            if (BoxoUtils.GetMaterialFloat(material, "_ThirdIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_ThirdAlbedoTex");
                StripUnusedTexture(material, "_ThirdNormalTex");
                StripUnusedTexture(material, "_ThirdShaderTex");
                StripUnusedTexture(material, "_ThirdMaskTex");
            }

            if (BoxoUtils.GetMaterialFloat(material, "_FourthIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_FourthAlbedoTex");
                StripUnusedTexture(material, "_FourthNormalTex");
                StripUnusedTexture(material, "_FourthShaderTex");
                StripUnusedTexture(material, "_FourthMaskTex");
            }

            if (BoxoUtils.GetMaterialFloat(material, "_TintingIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_TintingMaskTex");
            }

            if (BoxoUtils.GetMaterialFloat(material, "_DrynessIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_DrynessMaskTex");
            }

            if (BoxoUtils.GetMaterialFloat(material, "_OverlayIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_OverlayAlbedoTex");
                StripUnusedTexture(material, "_OverlayNormalTex");
                StripUnusedTexture(material, "_OverlayMaskTex");
            }

            if (BoxoUtils.GetMaterialFloat(material, "_EmissiveIntensityValue") == 0)
            {
                StripUnusedTexture(material, "_EmissiveMaskTex");
            }
        }

        public static void GetStrippedTextures(Material material)
        {
            if (BoxoUtils.GetMaterialFloat(material, "_StripUnusedTextures") > 0)
            {
                if (BoxoUtils.GetMaterialFloat(material, "_SecondIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_SecondAlbedoTex");
                    GetStrippedTexture(material, "_SecondNormalTex");
                    GetStrippedTexture(material, "_SecondShaderTex");
                    GetStrippedTexture(material, "_SecondMaskTex");
                }

                if (BoxoUtils.GetMaterialFloat(material, "_ThirdIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_ThirdAlbedoTex");
                    GetStrippedTexture(material, "_ThirdNormalTex");
                    GetStrippedTexture(material, "_ThirdShaderTex");
                    GetStrippedTexture(material, "_ThirdMaskTex");
                }

                if (BoxoUtils.GetMaterialFloat(material, "_FourthIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_FourthAlbedoTex");
                    GetStrippedTexture(material, "_FourthNormalTex");
                    GetStrippedTexture(material, "_FourthShaderTex");
                    GetStrippedTexture(material, "_FourthMaskTex");
                }

                if (BoxoUtils.GetMaterialFloat(material, "_TintingIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_TintingMaskTex");
                }

                if (BoxoUtils.GetMaterialFloat(material, "_DrynessIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_DrynessMaskTex");
                }

                if (BoxoUtils.GetMaterialFloat(material, "_OverlayIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_OverlayAlbedoTex");
                    GetStrippedTexture(material, "_OverlayNormalTex");
                    GetStrippedTexture(material, "_OverlayMaskTex");
                }

                if (BoxoUtils.GetMaterialFloat(material, "_EmissiveIntensityValue") > 0)
                {
                    GetStrippedTexture(material, "_EmissiveMaskTex");
                }
            }
        }

        public static void StripUnusedTexture(Material material, string property)
        {
            if (material.HasProperty(property))
            {
                var texture = material.GetTexture(property);

                if (texture != null && !texture.name.Contains("Internal"))
                {
                    material.SetTexture(property, null);

                    var sessionKey = material.name + "&&" + property;
                    var sessionValue = sessionKey + "&&" + AssetDatabase.GetAssetPath(texture);

                    SessionState.SetString(sessionKey, sessionValue);
                }
            }
        }

        public static void GetStrippedTexture(Material material, string property)
        {
            if (material.HasProperty(property))
            {
                var sessionKey = material.name + "&&" + property;
                var sessionValue = SessionState.GetString(sessionKey, "");

                if (sessionValue != "")
                {
                    var sessionSplit = sessionValue.Split("&&");

                    if (material.name == sessionSplit[0] && property == sessionSplit[1])
                    {
                        var texture = AssetDatabase.LoadAssetAtPath<Texture>(sessionSplit[2]);

                        material.SetTexture(property, texture);

                        SessionState.EraseString(sessionKey);
                    }
                }
            }
        }

        public static void SetImpostorFeatures(Material material)
        {
            var shaderName = material.shader.name;

            if (shaderName.Contains("Impostors"))
            {
                var texPath = "";
                var texAlbedo = material.GetTexture("_Albedo");

                if (texAlbedo != null)
                {
                    texPath = AssetDatabase.GetAssetPath(texAlbedo).Replace("_Albedo", "XXX");
                    // Replace Vanilla AI format
                    texPath = texPath.Replace("_AlbedoAlpha", "XXX");
                    // Replace Default TVE format
                    texPath = texPath.Replace("_Albedo", "XXX");
                }

                bool shaderTexMode = false;
                bool featureTexMode = false;
                bool coordTexMode = false;

                //bool vertexRedOrGreenMode = false;
                bool vertexBlueOrAlphaMode = false;

                // Set ShaderTex
                if (BoxoUtils.GetMaterialFloat(material, "_ImpostorMetallicValue") > 0 || BoxoUtils.GetMaterialFloat(material, "_ImpostorOcclusionValue") > 0)
                {
                    shaderTexMode = true;
                }

                if (BoxoUtils.GetMaterialFloat(material, "_SecondIntensityValue") > 0)
                {
                    var coordMode = BoxoUtils.GetMaterialInt(material, "_SecondSampleMode", -1);

                    if (coordMode == 0 || coordMode == 1)
                    {
                        coordTexMode = true;
                    }

                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_SecondMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_SecondMaskTex") && material.GetTexture("_SecondMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_SecondMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var baseValue = BoxoUtils.GetMaterialFloat(material, "_SecondBaseValue");

                    if (baseValue > 0)
                    {
                        featureTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_SecondMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_SecondMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_ThirdIntensityValue") > 0)
                {
                    var coordMode = BoxoUtils.GetMaterialInt(material, "_ThirdSampleMode", -1);

                    if (coordMode == 0 || coordMode == 1)
                    {
                        coordTexMode = true;
                    }

                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_ThirdMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_ThirdMaskTex") && material.GetTexture("_ThirdMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_ThirdMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var baseValue = BoxoUtils.GetMaterialFloat(material, "_ThirdBaseValue");

                    if (baseValue > 0)
                    {
                        featureTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_ThirdMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_ThirdMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_FourthIntensityValue") > 0)
                {
                    var coordMode = BoxoUtils.GetMaterialInt(material, "_FourthSampleMode", -1);

                    if (coordMode == 0 || coordMode == 1)
                    {
                        coordTexMode = true;
                    }

                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_FourthMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_FourthMaskTex") && material.GetTexture("_FourthMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_FourthMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var baseValue = BoxoUtils.GetMaterialFloat(material, "_FourthBaseValue");

                    if (baseValue > 0)
                    {
                        featureTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_FourthMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_FourthMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_OcclusionIntensityValue") > 0)
                {
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_OcclusionColorMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshMode == 2 || meshMode == 3)
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_GradientIntensityValue") > 0)
                {
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_GradientColorMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshMode == 2 || meshMode == 3)
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_TintingIntensityValue") > 0)
                {
                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_TintingMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_TintingMaskTex") && material.GetTexture("_TintingMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_TintingMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_TintingMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_TintingMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_CutoutIntensityValue") > 0)
                {
                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_CutoutMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_CutoutMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_DrynessIntensityValue") > 0)
                {
                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_DrynessMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_DrynessMaskTex") && material.GetTexture("_DrynessMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_DrynessMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_DrynessMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_DrynessMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_OverlayIntensityValue") > 0)
                {
                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_OverlayMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_OverlayMaskTex") && material.GetTexture("_OverlayMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_OverlayMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var baseValue = BoxoUtils.GetMaterialFloat(material, "_FourthBaseValue");

                    if (baseValue > 0)
                    {
                        featureTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_OverlayMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_OverlayMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (BoxoUtils.GetMaterialFloat(material, "_EmissiveIntensityValue") > 0)
                {
                    featureTexMode = true;

                    var maskCoordMode = BoxoUtils.GetMaterialInt(material, "_EmissiveMaskSampleMode", -1);
                    var maskTexMode = material.HasTexture("_EmissiveMaskTex") && material.GetTexture("_EmissiveMaskTex") != null && BoxoUtils.GetMaterialFloat(material, "_EmissiveMaskValue") > 0;

                    if (maskTexMode && (maskCoordMode == 0 || maskCoordMode == 1))
                    {
                        coordTexMode = true;
                    }

                    var meshValue = BoxoUtils.GetMaterialFloat(material, "_EmissiveMeshValue");
                    var meshMode = BoxoUtils.GetMaterialInt(material, "_EmissiveMeshMode");

                    //if (meshValue > 0 && (meshMode == 0 || meshMode == 1))
                    //{
                    //    vertexRedOrGreenMode = true;
                    //}

                    if (meshValue > 0 && (meshMode == 2 || meshMode == 3))
                    {
                        vertexBlueOrAlphaMode = true;
                    }
                }

                if (shaderTexMode)
                {
                    var shaderTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_Shader"));

                    if (shaderTex == null)
                    {
                        // Old format
                        shaderTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_MasksA"));
                    }

                    if (shaderTex != null)
                    {
                        material.SetTexture("_Shader", shaderTex);
                    }

                    material.SetTexture("_Packed", null);

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_PACKED", false);
                }
                else
                {
                    var packedTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_Packed"));

                    if (packedTex != null)
                    {
                        material.SetTexture("_Packed", packedTex);
                    }

                    material.SetTexture("_Shader", null);

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_PACKED", true);
                }

                if (featureTexMode)
                {
                    var featureTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_Feature"));

                    if (featureTex == null)
                    {
                        // Old format
                        featureTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_Emissive"));
                    }

                    if (featureTex != null)
                    {
                        material.SetTexture("_Feature", featureTex);
                    }

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_FEATURE", true);
                }
                else
                {
                    material.SetTexture("_Feature", null);

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_FEATURE", false);
                }

                if (coordTexMode)
                {
                    var coordTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_Coord"));

                    if (coordTex != null)
                    {
                        material.SetTexture("_Coord", coordTex);
                    }

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_COORD", true);
                }
                else
                {
                    material.SetTexture("_Coord", null);

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_COORD", false);
                }

                if (vertexBlueOrAlphaMode)
                {
                    var vertexTex = AssetDatabase.LoadAssetAtPath<Texture>(texPath.Replace("XXX", "_Vertex"));

                    if (vertexTex != null)
                    {
                        material.SetTexture("_Vertex", vertexTex);
                    }

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_VERTEX", true);
                }
                else
                {
                    material.SetTexture("_Vertex", null);

                    BoxoUtils.SetMaterialKeyword(material, "TVE_IMPOSTOR_VERTEX", false);
                }
            }
        }

        public static void SetImpostorBakeModes(Material oldMaterial, Material newMaterial)
        {
            SetImpostorBakeMode(oldMaterial, newMaterial, "_Second");
            SetImpostorBakeMode(oldMaterial, newMaterial, "_Third");
            SetImpostorBakeMode(oldMaterial, newMaterial, "_Fourth");
            SetImpostorBakeMode(oldMaterial, newMaterial, "_Occlusion");
            SetImpostorBakeMode(oldMaterial, newMaterial, "_Gradient");
            //SetImpostorBakeMode(oldMaterial, newMaterial, "_Tinting");
            //SetImpostorBakeMode(oldMaterial, newMaterial, "_Dryness");
            //SetImpostorBakeMode(oldMaterial, newMaterial, "_Overlay");
            //SetImpostorBakeMode(oldMaterial, newMaterial, "_Wetness");
            //SetImpostorBakeMode(oldMaterial, newMaterial, "_Cutout");
        }

        public static void SetImpostorBakeMode(Material oldMaterial, Material newMaterial, string feature)
        {
            if (oldMaterial.HasProperty(feature + "BakeMode"))
            {
                var bake = oldMaterial.GetInt(feature + "BakeMode");

                if (bake == 0)
                {
                    newMaterial.SetFloat(feature + "BakeInfo", 0);
                }
                else
                {
                    newMaterial.SetFloat(feature + "BakeInfo", 1);
                    newMaterial.SetFloat(feature + "IntensityValue", 0);
                }
            }
        }

        // Shader Utils
        public static bool IsValidShader(string shaderPath)
        {
            bool valid = false;

            var shader = AssetDatabase.LoadAssetAtPath<Shader>(shaderPath);

            if (shader != null)
            {
                var shaderName = AssetDatabase.LoadAssetAtPath<Shader>(shaderPath).name;

                var isFoundShader = shaderName.Contains("The Visual Engine") && (shaderName.Contains("Geometry") || shaderName.Contains("Impostors") || shaderName.Contains("Landscape"));
                var isValidShader = !shaderName.Contains("GPUI") && !shaderName.Contains("Helper") && !shaderName.Contains("Legacy") && !shaderName.Contains("Hidden");

                if (isFoundShader && isValidShader)
                {
                    valid = true;
                }
            }

            return valid;
        }

        public static List<string> GetCoreShaderPaths()
        {
            var shaderPaths = new List<string>();

            string[] shaderGuids = AssetDatabase.FindAssets("t:Shader");

            foreach (string guid in shaderGuids)
            {
                string shaderPath = AssetDatabase.GUIDToAssetPath(guid);

                if (IsValidShader(shaderPath))
                {
                    shaderPaths.Add(shaderPath);
                }
            }

            return shaderPaths;
        }

        public static List<string> GetShaderNames(string category)
        {
            var shaderNames = new List<string>();

            string[] shaderGuids = AssetDatabase.FindAssets("t:Shader");

            foreach (string guid in shaderGuids)
            {
                string shaderPath = AssetDatabase.GUIDToAssetPath(guid);
                Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(shaderPath);

                if (shader != null)
                {
                    var shaderName = shader.name;

                    var isFoundShader = shader.name.Contains("The Visual Engine") && shader.name.Contains(category);
                    var isValidShader = !shaderName.Contains("GPUI") && !shaderName.Contains("Helper") && !shaderName.Contains("Legacy") && !shaderName.Contains("Hidden");

                    if (isFoundShader && isValidShader)
                    {
                        shaderNames.Add(shaderName);
                    }
                }
            }

            return shaderNames;
        }

        public static string[] ShaderModelOptions =
        {
            "Shader Model 2.0",
            "Shader Model 2.5",
            "Shader Model 3.0",
            "Shader Model 3.5",
            "Shader Model 4.0",
            "Shader Model 4.5",
            "Shader Model 4.6",
            "Shader Model 5.0",
        };

        public static string[] RenderEngineOptions =
        {
            "Unity Default Renderer",
            "Vegetation Studio (Instanced Indirect)",
            "Vegetation Studio 1.4.5+ (Instanced Indirect)",
            "Vegetation Studio Beyond (Instanced Indirect)",
            "Nature Renderer (Instanced Indirect)",
            "Foliage Renderer (Instanced Indirect)",
            "Flora Renderer (Instanced Indirect)",
            "Flora Renderer 2 (Instanced Indirect)",
            "Flora Renderer 6 (Legacy Pipeline)",
            "GPU Instancer (Instanced Indirect)",
            "GPU Instancer Pro (Instanced Indirect)",
            "Infinite Lands Renderer (Instanced Indirect)",
            "Vegetation Instancer (Instanced Indirect)",
            "Renderer Stack (Instanced Indirect)",
            "Instant Renderer (Instanced Indirect)",
            "Custom Renderer (Instanced Indirect)",
            "Disable SRP Batcher Compatibility",
        };

        public static string GetShaderLightingType(Material material)
        {
            var type = "";

            var shaderName = material.shader.name;

            if (shaderName.Contains("Vertex"))
            {
                type = "Vertex";
            }
            else if (shaderName.Contains("Simple"))
            {
                type = "Simple";
            }
            else if (shaderName.Contains("Standard"))
            {
                type = "Standard";
            }
            else if (shaderName.Contains("Subsurface"))
            {
                type = "Subsurface";
            }
            else if (shaderName.Contains("Unlit"))
            {
                type = "Unlit";
            }

            return type;
        }

        public static TVEShaderSettings GetShaderSettings(string shaderPath)
        {
            TVEShaderSettings shaderSettings = new TVEShaderSettings();
            shaderSettings.shaderPath = shaderPath;

            StreamReader reader = new StreamReader(shaderPath);

            string lines = reader.ReadToEnd();

            for (int i = 0; i < RenderEngineOptions.Length; i++)
            {
                var renderEngine = RenderEngineOptions[i];

                if (lines.Contains(renderEngine))
                {
                    shaderSettings.renderEngine = renderEngine;
                    break;
                }
            }

            for (int i = 0; i < ShaderModelOptions.Length; i++)
            {
                var shaderModel = ShaderModelOptions[i].Replace("Shader Model", "#pragma target");

                if (lines.Contains(shaderModel))
                {
                    shaderSettings.shaderModel = ShaderModelOptions[i];
                    break;
                }
            }

            reader.Close();

            return shaderSettings;
        }

        public static void SetShaderSettings(string shaderPath, TVEShaderSettings shaderSettings)
        {
            var renderEngine = shaderSettings.renderEngine;
            var shaderModel = shaderSettings.shaderModel.Replace("Shader Model", "#pragma target");

            string[] engineVegetationStudio = new string[]
            {
            "           //Vegetation Studio (Instanced Indirect)",
            "           #include \"XXX/Core/Shaders/Includes/VS_Indirect.cginc\"",
            "           #pragma instancing_options procedural:setup forwardadd",
            "           #pragma multi_compile GPU_FRUSTUM_ON __",
            };

            string[] engineVegetationStudioHD = new string[]
            {
            "           //Vegetation Studio (Instanced Indirect)",
            "           #include \"XXX/Core/Shaders/Includes/VS_IndirectHD.cginc\"",
            "           #pragma instancing_options procedural:setupVSPro forwardadd",
            "           #pragma multi_compile GPU_FRUSTUM_ON __",
            };

            string[] engineVegetationStudio145 = new string[]
            {
            "           //Vegetation Studio 1.4.5+ (Instanced Indirect)",
            "           #include \"XXX/Core/Shaders/Includes/VS_Indirect145.cginc\"",
            "           #pragma instancing_options procedural:setupVSPro forwardadd",
            "           #pragma multi_compile GPU_FRUSTUM_ON __",
            };

            string[] engineVegetationStudioBeyond = new string[]
            {
            "           //Vegetation Studio Beyond (Instanced Indirect)",
            "           #include \"XXX/Core/Shaders/Includes/VSB_Indirect.cginc\"",
            "           #pragma instancing_options procedural:setupVSPro forwardadd",
            "           #pragma multi_compile GPU_FRUSTUM_ON __",
            };

            string[] engineVegetationStudioBeyondHD = new string[]
            {
            "           //Vegetation Studio Beyond (Instanced Indirect)",
            "           #include \"XXX/Core/Shaders/Includes/VSB_IndirectHD.cginc\"",
            "           #pragma instancing_options procedural:setupVSPro forwardadd",
            "           #pragma multi_compile GPU_FRUSTUM_ON __",
            };

            string[] engineNatureRenderer = new string[]
            {
            "           //Nature Renderer (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:SetupNatureRenderer forwardadd",
            };

            string[] engineFoliageRenderer = new string[]
            {
            "           //Foliage Renderer (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:setupFoliageRenderer forwardadd",
            };

            string[] engineFloraRenderer = new string[]
            {
            "           //Flora Renderer (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:FloraInstancingSetup forwardadd",
            };

            string[] engineFloraRenderer2 = new string[]
            {
            "           //Flora Renderer 2 (Instanced Indirect)",
            "           #include_with_pragmas \"XXX\"",
            "           #pragma instancing_options procedural:FloraInstancingSetup forwardadd",
            };

            string[] engineFloraRenderer6 = new string[]
            {
            "           //Flora Renderer 6 (Legacy Pipeline)",
            "           #include_with_pragmas \"XXX\"",
            "           #pragma instancing_options procedural:SetupFloraInstancingData",
            };

            string[] engineGPUInstancer = new string[]
            {
            "           //GPU Instancer (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:setupGPUI forwardadd",
            };

            string[] engineGPUInstancerPro = new string[]
            {
            "           //GPU Instancer Pro (Instanced Indirect)",
            "           #include_with_pragmas \"XXX\"",
            "           #pragma instancing_options procedural:setupGPUI forwardadd",
            };

            string[] engineInfiniteLandsRenderer = new string[]
            {
            "           //Infinite Lands Renderer (Instanced Indirect)",
            "           #include_with_pragmas \"XXX\"",
            "           #pragma instancing_options procedural:IL_Initialize"
            };

            string[] engineVegetationInstancer = new string[]
            {
            "           //Vegetation Instancer (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:setupGPUInstancedIndirect",
            };

            string[] engineRendererStack = new string[]
            {
            "           //Renderer Stack (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:GPUInstancedIndirectInclude forwardadd",
            };

            string[] engineInstantRenderer = new string[]
            {
            "           //Instant Renderer (Instanced Indirect)",
            "           #include \"XXX\"",
            "           #pragma instancing_options procedural:setupInstantRenderer forwardadd",
            };

            string[] engineCustomRenderer = new string[]
            {
            "           //Custom Renderer (Instanced Indirect)",
            "           #include_with_pragmas \"XXX/The Visual Engine/Shaders/Includes/CustomRenderer.cginc\"",
            "           #pragma instancing_options procedural:setupCustomRenderer forwardadd",
            };

            var assetFolder = TVEUtils.GetAssetFolder();
            var userFolder = BoxoUtils.GetUserFolder();

            var cgincNatureRenderer = "Assets/Visual Design Cafe/Nature Renderer/Shader Includes/Nature Renderer.templatex";

            if (!File.Exists(cgincNatureRenderer))
            {
                cgincNatureRenderer = BoxoUtils.FindAsset("Nature Renderer.templatex");
            }

            var cgincFoliageRenderer = "Packages/com.jbooth.foliagerenderer/Shaders/FoliageRendererInstancing.cginc";

            if (!File.Exists(cgincFoliageRenderer))
            {
                cgincFoliageRenderer = BoxoUtils.FindAsset("FoliageRendererInstancing.cginc");
            }

            var cgincFloraRenderer = "Packages/com.ma.flora/ShaderLibrary/Flora.hlsl";

            if (!File.Exists(cgincFloraRenderer))
            {
                cgincFloraRenderer = BoxoUtils.FindAsset("Flora.hlsl");
            }

            var cgincFloraRenderer2 = "Packages/com.ma.flora/ShaderLibrary/Instancing.hlsl";

            if (!File.Exists(cgincFloraRenderer2))
            {
                cgincFloraRenderer2 = BoxoUtils.FindAsset("Instancing.hlsl");
            }

            var cgincFloraRenderer6 = "Packages/ma.com.flora/ShaderLibrary/Instancing.hlsl";

            if (!File.Exists(cgincFloraRenderer6))
            {
                cgincFloraRenderer6 = BoxoUtils.FindAsset("Instancing.hlsl");
            }

            var cgincGPUInstancer = "Assets/GPUInstancer/Shaders/Include/GPUInstancerInclude.cginc";

            if (!File.Exists(cgincGPUInstancer))
            {
                cgincGPUInstancer = BoxoUtils.FindAsset("GPUInstancerInclude.cginc");
            }

            var cgincGPUInstancerPro = "Packages/com.gurbu.gpui-pro/Runtime/Shaders/Include/GPUInstancerSetup.hlsl";

            if (!File.Exists(cgincGPUInstancerPro))
            {
                cgincGPUInstancerPro = BoxoUtils.FindAsset("GPUInstancerSetup.hlsl");
            }

            var cgincInfiniteLandsRenderer = "Packages/com.sapra.infinitelands/Runtime/Resources/Include/GPUInstancing.hlsl";

            if (!File.Exists(cgincInfiniteLandsRenderer))
            {
                cgincInfiniteLandsRenderer = BoxoUtils.FindAsset("GrassInstanced.hlsl");
            }

            var cgincVegetationInstancer = "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc";

            if (!File.Exists(cgincVegetationInstancer))
            {
                cgincVegetationInstancer = BoxoUtils.FindAsset("GPUInstancedIndirectInclude.cginc");
            }

            var cgincRendererStack = "Assets/VladislavTsurikov/RendererStack/Shaders/Include/GPUInstancedIndirectInclude.cginc";

            if (!File.Exists(cgincRendererStack))
            {
                cgincRendererStack = BoxoUtils.FindAsset("GPUInstancedIndirectInclude.cginc");
            }

            var cgincInstantRenderer = "Assets/VladislavTsurikov/InstantRenderer/Shaders/Include/InstantRendererInclude.cginc";

            if (!File.Exists(cgincInstantRenderer))
            {
                cgincInstantRenderer = BoxoUtils.FindAsset("GPUInstancerInclude.cginc");
            }

            // Add correct paths for VSP and GPUI
            engineVegetationStudio[1] = engineVegetationStudio[1].Replace("XXX", assetFolder);
            engineVegetationStudioHD[1] = engineVegetationStudioHD[1].Replace("XXX", assetFolder);
            engineVegetationStudio145[1] = engineVegetationStudio145[1].Replace("XXX", assetFolder);
            engineVegetationStudioBeyond[1] = engineVegetationStudioBeyond[1].Replace("XXX", assetFolder);
            engineVegetationStudioBeyondHD[1] = engineVegetationStudioBeyondHD[1].Replace("XXX", assetFolder);
            engineNatureRenderer[1] = engineNatureRenderer[1].Replace("XXX", cgincNatureRenderer);
            engineFoliageRenderer[1] = engineFoliageRenderer[1].Replace("XXX", cgincFoliageRenderer);
            engineFloraRenderer[1] = engineFloraRenderer[1].Replace("XXX", cgincFloraRenderer);
            engineFloraRenderer2[1] = engineFloraRenderer2[1].Replace("XXX", cgincFloraRenderer2);
            engineFloraRenderer6[1] = engineFloraRenderer6[1].Replace("XXX", cgincFloraRenderer6);
            engineGPUInstancer[1] = engineGPUInstancer[1].Replace("XXX", cgincGPUInstancer);
            engineGPUInstancerPro[1] = engineGPUInstancerPro[1].Replace("XXX", cgincGPUInstancerPro);
            engineInfiniteLandsRenderer[1] = engineInfiniteLandsRenderer[1].Replace("XXX", cgincInfiniteLandsRenderer);
            engineVegetationInstancer[1] = engineVegetationInstancer[1].Replace("XXX", cgincVegetationInstancer);
            engineRendererStack[1] = engineRendererStack[1].Replace("XXX", cgincRendererStack);
            engineInstantRenderer[1] = engineInstantRenderer[1].Replace("XXX", cgincInstantRenderer);
            engineCustomRenderer[1] = engineCustomRenderer[1].Replace("XXX", userFolder);

            var isHDPipeline = false;

            StreamReader reader = new StreamReader(shaderPath);

            List<string> lines = new List<string>();

            while (!reader.EndOfStream)
            {
                lines.Add(reader.ReadLine());
            }

            reader.Close();

            int count = lines.Count;

            if (shaderModel != "From Shader")
            {
                for (int i = 0; i < count; i++)
                {
                    if (lines[i].Contains("#pragma target"))
                    {
                        lines[i] = shaderModel;
                    }
                }
            }

            for (int i = 0; i < count; i++)
            {
                if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                {
                    int c = 0;
                    int j = i + 1;

                    while (lines[j].Contains("SHADER INJECTION POINT END") == false)
                    {
                        j++;
                        c++;
                    }

                    lines.RemoveRange(i + 1, c);
                    count = count - c;
                }
            }

            count = lines.Count;

            for (int i = 0; i < count; i++)
            {
                if (lines[i].Contains("HDRenderPipeline"))
                {
                    isHDPipeline = true;
                }

                if (lines[i].Contains("[HideInInspector] _DisableSRPBatcher"))
                {
                    lines.RemoveAt(i);
                    count--;
                }

                if (lines[i].Contains("TVEShaderGUICore"))
                {
                    lines[i] = lines[i].Replace("TVEShaderGUICore", "TheVisualEngine.MaterialGUI");
                }
            }

            //Inject 3rd Party Support
            if (renderEngine.Contains("Vegetation Studio (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        if (isHDPipeline)
                        {
                            lines.InsertRange(i + 1, engineVegetationStudioHD);
                        }
                        else
                        {
                            lines.InsertRange(i + 1, engineVegetationStudio);
                        }
                    }
                }
            }

            if (renderEngine.Contains("Vegetation Studio 1.4.5+ (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineVegetationStudio145);
                    }
                }
            }

            if (renderEngine.Contains("Vegetation Studio Beyond (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        if (isHDPipeline)
                        {
                            lines.InsertRange(i + 1, engineVegetationStudioBeyondHD);
                        }
                        else
                        {
                            lines.InsertRange(i + 1, engineVegetationStudioBeyond);
                        }
                    }
                }
            }

            if (renderEngine.Contains("Nature Renderer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineNatureRenderer);
                    }
                }
            }

            if (renderEngine.Contains("Foliage Renderer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineFoliageRenderer);
                    }
                }
            }

            if (renderEngine.Contains("Flora Renderer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineFloraRenderer);
                    }
                }
            }

            if (renderEngine.Contains("Flora Renderer 2 (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineFloraRenderer2);
                    }
                }
            }

            if (renderEngine.Contains("GPU Instancer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineGPUInstancer);
                    }
                }
            }

            if (renderEngine.Contains("GPU Instancer Pro (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineGPUInstancerPro);
                    }
                }
            }

            if (renderEngine.Contains("Infinite Lands Renderer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineInfiniteLandsRenderer);
                    }
                }
            }

            if (renderEngine.Contains("Vegetation Instancer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineVegetationInstancer);
                    }
                }
            }

            if (renderEngine.Contains("Renderer Stack (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineRendererStack);
                    }
                }
            }

            if (renderEngine.Contains("Instant Renderer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineInstantRenderer);
                    }
                }
            }

            if (renderEngine.Contains("Custom Renderer (Instanced Indirect)"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineCustomRenderer);
                    }
                }
            }

            if (renderEngine.Contains("Disable SRP Batcher Compatibility"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].EndsWith("Properties"))
                    {
                        lines.Insert(i + 2, "		[HideInInspector] _DisableSRPBatcher(\"_DisableSRPBatcher\", Float) = 0 //Disable SRP Batcher Compatibility");
                    }
                }
            }

            //for (int i = 0; i < lines.Count; i++)
            //{
            //    // Disable ASE Drawers
            //    if (lines[i].Contains("[ASEBegin]"))
            //    {
            //        lines[i] = lines[i].Replace("[ASEBegin]", "");
            //    }

            //    if (lines[i].Contains("[ASEnd]"))
            //    {
            //        lines[i] = lines[i].Replace("[ASEnd]", "");
            //    }
            //}

#if !AMPLIFY_SHADER_EDITOR && !UNITY_2020_2_OR_NEWER

            // Add diffusion profile support for HDRP 7
            if (isHDPipeline)
            {
                if (shaderPath.Contains("Subsurface Lit"))
                {
                    for (int i = 0; i < lines.Count; i++)
                    {
                        if (lines[i].Contains("[DiffusionProfile]"))
                        {
                            lines[i] = lines[i].Replace("[DiffusionProfile]", "[StyledDiffusionMaterial(_SubsurfaceDiffusion)]");
                        }
                    }
                }
            }

#elif AMPLIFY_SHADER_EDITOR && !UNITY_2020_2_OR_NEWER

            // Add diffusion profile support
            if (isHDPipeline)
            {
                if (shaderAssetPath.Contains("Subsurface Lit"))
                {
                    for (int i = 0; i < lines.Count; i++)
                    {
                        if (lines[i].Contains("[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]"))
                        {
                            lines[i] = lines[i].Replace("[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]", "[Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]");
                        }

                        if (lines[i].Contains("[DiffusionProfile]") && !lines[i].Contains("[HideInInspector]"))
                        {
                            lines[i] = lines[i].Replace("[DiffusionProfile]", "[HideInInspector][DiffusionProfile]");
                        }

                        if (lines[i].Contains("[StyledDiffusionMaterial(_SubsurfaceDiffusion)]"))
                        {
                            lines[i] = lines[i].Replace("[StyledDiffusionMaterial(_SubsurfaceDiffusion)]", "[HideInInspector][StyledDiffusionMaterial(_SubsurfaceDiffusion)]");
                        }
                    }
                }
            }
#endif

            StreamWriter writer = new StreamWriter(shaderPath);

            for (int i = 0; i < lines.Count; i++)
            {
                writer.WriteLine(lines[i]);
            }

            writer.Close();

            lines = new List<string>();

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            //AssetDatabase.ImportAsset(shaderPath);
        }

        public static void CopyOrReplaceShader(string oldShaderPath, string newShaderPath, string newShaderName)
        {
            if (File.Exists(newShaderPath))
            {
                // Copy old shader content
                StreamReader reader = new StreamReader(oldShaderPath);

                List<string> lines = new List<string>();

                while (!reader.EndOfStream)
                {
                    lines.Add(reader.ReadLine());
                }

                reader.Close();

                for (int i = 0; i < 10; i++)
                {
                    if (lines[i].StartsWith("Shader"))
                    {
                        lines[i] = "Shader \"" + newShaderName + "\"";
                    }
                }

                StreamWriter writer = new StreamWriter(newShaderPath, false);

                for (int i = 0; i < lines.Count; i++)
                {
                    writer.WriteLine(lines[i]);
                }

                writer.Close();

                lines = new List<string>();

                AssetDatabase.ImportAsset(newShaderPath);
                AssetDatabase.Refresh();
            }
            else
            {
                AssetDatabase.CopyAsset(oldShaderPath, newShaderPath);
                AssetDatabase.Refresh();
            }
        }

        public static bool IsAmplifyVersionSupported()
        {
            const int major = 1;
            const int minor = 9;
            const int patch = 9;
            const int fixes = 12;
            const string amplifyVersionGUID = "580cccd3e608b7f4cac35ea46d62d429";

            string amplifyVersionPath = AssetDatabase.GUIDToAssetPath(amplifyVersionGUID);

            if (string.IsNullOrEmpty(amplifyVersionPath) || !File.Exists(amplifyVersionPath))
                return false;

            string firstLine;
            try
            {
                using (var reader = new StreamReader(amplifyVersionPath))
                {
                    firstLine = reader.ReadLine();
                }
            }
            catch
            {
                return false;
            }

            if (string.IsNullOrEmpty(firstLine))
                return false;

            if (firstLine[0] == 'v' || firstLine[0] == 'V')
                firstLine = firstLine.Substring(1);

            string[] parts = firstLine.Split('.');
            if (parts.Length != 4)
                return false;

            if (!int.TryParse(parts[0], out int fileMajor) ||
                !int.TryParse(parts[1], out int fileMinor) ||
                !int.TryParse(parts[2], out int filePatch) ||
                !int.TryParse(parts[3], out int fileFixes))
                return false;

            if (fileMajor != major) return fileMajor > major;
            if (fileMinor != minor) return fileMinor > minor;
            if (filePatch != patch) return filePatch > patch;
            return fileFixes >= fixes;
        }

        public static bool IsAmplifyTemplateImported()
        {
            const string amplifyTemplateGUID = "28cd5599e02859647ae1798e4fcaef6c";

            string amplifyTemplatePath = AssetDatabase.GUIDToAssetPath(amplifyTemplateGUID);

            if (!string.IsNullOrEmpty(amplifyTemplatePath) && File.Exists(amplifyTemplatePath))
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        // GUI Utils
        public static void DrawTerrainLayer(TerrainLayer terrainLayer, TVEUVMode layerUVMode)
        {
            StyledGUI.DrawInspectorBanner(terrainLayer.name);

            EditorGUI.BeginChangeCheck();

            Undo.RecordObject(terrainLayer, "Modify Terrain Layer");

            terrainLayer.diffuseTexture = (Texture2D)EditorGUILayout.ObjectField("Layer Albedo", terrainLayer.diffuseTexture, typeof(Texture2D), false, GUILayout.Height(EditorGUIUtility.singleLineHeight));
            terrainLayer.normalMapTexture = (Texture2D)EditorGUILayout.ObjectField("Layer Normal", terrainLayer.normalMapTexture, typeof(Texture2D), false, GUILayout.Height(EditorGUIUtility.singleLineHeight));
            terrainLayer.maskMapTexture = (Texture2D)EditorGUILayout.ObjectField("Layer Shader", terrainLayer.maskMapTexture, typeof(Texture2D), false, GUILayout.Height(EditorGUIUtility.singleLineHeight)); GUILayout.Space(10);

            var diffuseRemapMax = terrainLayer.diffuseRemapMax;

            var color = new Color(diffuseRemapMax.x, diffuseRemapMax.y, diffuseRemapMax.z);

            color = EditorGUILayout.ColorField(new GUIContent("Layer Color"), color, true, false, true);

            terrainLayer.normalScale = EditorGUILayout.Slider("Layer Normal", terrainLayer.normalScale, -8.0f, 8.0f);

            var maskMapRemapMin = terrainLayer.maskMapRemapMin;
            var maskMapRemapMax = terrainLayer.maskMapRemapMax;

            terrainLayer.metallic = EditorGUILayout.Slider("Layer Metallic", terrainLayer.metallic, 0.0f, 1.0f);
            EditorGUILayout.MinMaxSlider("Layer Metallic", ref maskMapRemapMin.x, ref maskMapRemapMax.x, 0.0f, 1.0f);
            EditorGUILayout.MinMaxSlider("Layer Occlusion", ref maskMapRemapMin.y, ref maskMapRemapMax.y, 0.0f, 1.0f);
            EditorGUILayout.MinMaxSlider("Layer Height Mask", ref maskMapRemapMin.z, ref maskMapRemapMax.z, 0.0f, 1.0f);
            terrainLayer.smoothness = EditorGUILayout.Slider("Layer Smoothness", terrainLayer.smoothness, 0.0f, 1.0f);
            EditorGUILayout.MinMaxSlider("Layer Smoothness", ref maskMapRemapMin.w, ref maskMapRemapMax.w, 0.0f, 1.0f);

            terrainLayer.maskMapRemapMin = maskMapRemapMin;
            terrainLayer.maskMapRemapMax = maskMapRemapMax;

            //targetScript.maskMapRemapMin = EditorGUILayout.Vector4Field("Layer Remap Min", targetScript.maskMapRemapMin);
            //targetScript.maskMapRemapMax = EditorGUILayout.Vector4Field("Layer Remap Max", targetScript.maskMapRemapMax);

            GUILayout.Space(10);

            var specular = terrainLayer.specular;

            specular.r = EditorGUILayout.Slider("Layer Specular R (Emissive)", specular.r, 0.0f, 1.0f);
            specular.a = EditorGUILayout.Slider("Layer Specular A (Multi Mask)", specular.a, 0.0f, 1.0f);

            terrainLayer.specular = specular;

            GUILayout.Space(10);

            if (diffuseRemapMax.w == 0)
            {
                layerUVMode = TVEUVMode.Tilling;
            }
            else
            {
                layerUVMode = TVEUVMode.Scale;
            }

            layerUVMode = (TVEUVMode)EditorGUILayout.EnumPopup("Layer UV Mode", layerUVMode);

            if (layerUVMode == TVEUVMode.Tilling)
            {
                diffuseRemapMax.w = 0;
            }
            else
            {
                diffuseRemapMax.w = 1;
            }

            terrainLayer.diffuseRemapMax = new Vector4(color.r, color.g, color.b, diffuseRemapMax.w);

            var UVVector = new Vector4(terrainLayer.tileSize.x, terrainLayer.tileSize.y, terrainLayer.tileOffset.x, terrainLayer.tileOffset.y);
            UVVector = EditorGUILayout.Vector4Field("Layer UV Value", UVVector);
            terrainLayer.tileSize = new Vector2(UVVector.x, UVVector.y);
            terrainLayer.tileOffset = new Vector2(UVVector.z, UVVector.w);

            if (EditorGUI.EndChangeCheck())
            {
                EditorUtility.SetDirty(terrainLayer);

                // Optional:
                //AssetDatabase.SaveAssets();
            }

            //if (previewMaterial == null)
            //{
            //    previewMaterial = new Material(Shader.Find("Hidden/BOXOPHOBIC/Helpers/Channel Preview"));
            //}

            //GUILayout.Space(10);

            //previewTexture = (TVETerrainLayerTexture)EditorGUILayout.EnumPopup("Layer Preview", previewTexture);

            //if (previewTexture == TVETerrainLayerTexture.Albedo && targetScript.diffuseTexture != null)
            //{
            //    previewChannel = StyledGUI.DrawTexturePreview(targetScript.diffuseTexture, previewMaterial, previewChannel);
            //}

            //if (previewTexture == TVETerrainLayerTexture.Normal && targetScript.normalMapTexture != null)
            //{
            //    previewChannel = StyledGUI.DrawTexturePreview(targetScript.normalMapTexture, previewMaterial, previewChannel);
            //}

            //if (previewTexture == TVETerrainLayerTexture.Shader && targetScript.maskMapTexture != null)
            //{
            //    previewChannel = StyledGUI.DrawTexturePreview(targetScript.maskMapTexture, previewMaterial, previewChannel);
            //}

            //float spacing = 1f;
            //float totalWidth = EditorGUIUtility.currentViewWidth - 22; // Inspector padding
            //float size = (totalWidth - spacing * 2f) / 3f;

            //Rect rowRect = GUILayoutUtility.GetRect(totalWidth, size);

            //Rect diffuseRect = new Rect(rowRect.x, rowRect.y, size, size);
            //Rect normalRect = new Rect(diffuseRect.xMax + spacing, rowRect.y, size, size);
            //Rect maskRect = new Rect(normalRect.xMax + spacing, rowRect.y, size, size);

            //// Backgrounds
            //EditorGUI.DrawRect(diffuseRect, new Color(0.18f, 0.18f, 0.18f));
            //EditorGUI.DrawRect(normalRect, new Color(0.18f, 0.18f, 0.18f));
            //EditorGUI.DrawRect(maskRect, new Color(0.18f, 0.18f, 0.18f));

            //// Texture previews
            //if (targetScript.diffuseTexture != null)
            //    EditorGUI.DrawPreviewTexture(diffuseRect, targetScript.diffuseTexture, null, ScaleMode.ScaleToFit);

            //if (targetScript.normalMapTexture != null)
            //    EditorGUI.DrawPreviewTexture(normalRect, targetScript.normalMapTexture, null, ScaleMode.ScaleToFit);

            //if (targetScript.maskMapTexture != null)
            //    EditorGUI.DrawPreviewTexture(maskRect, targetScript.maskMapTexture, null, ScaleMode.ScaleToFit);

        }
        public static void DrawShaderBanner(Material material)
        {
            GUIStyle titleStyle = new GUIStyle("label")
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter
            };

            GUIStyle subTitleStyle = new GUIStyle("label")
            {
                richText = true,
                alignment = TextAnchor.MiddleRight
            };

            var splitLine = material.shader.name.Split(char.Parse("/"));
            var splitCount = splitLine.Length;
            var shaderName = splitLine[splitCount - 1];
            var shaderCategory = splitLine[splitCount - 2];
            var shaderType = splitLine[splitCount - 3];

            var subtitle = "";

            if (shaderType == "The Visual Engine")
            {
                if (AssetDatabase.GetAssetPath(material.shader).Contains("Core"))
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        subtitle = "<color=#ffdb78>" + "Core" + " / " + shaderCategory + "</color>";
                    }
                    else
                    {
                        subtitle = "Core" + " / " + shaderCategory;
                    }
                }
                else
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        subtitle = "<color=#8affc4>" + "User" + " / " + shaderCategory + "</color>";
                    }
                    else
                    {
                        subtitle = "<b><color=#008c60>" + "User" + " / " + shaderCategory + "</color></b>";
                    }
                }
            }
            else
            {
                if (shaderType.Contains("The Visual Engine "))
                {
                    shaderType = shaderType.Replace("The Visual Engine ", "");

                    if (EditorGUIUtility.isProSkin)
                    {
                        subtitle = "<color=#8affc4>" + shaderType + " / " + shaderCategory + "</color>";
                    }
                    else
                    {
                        subtitle = "<b><color=#008c60>" + "User" + " / " + shaderCategory + "</color></b>";
                    }
                }
            }

            GUILayout.Space(10);

            var fullRect = GUILayoutUtility.GetRect(0, 0, 36, 0);
            var fillRect = new Rect(0, fullRect.position.y, fullRect.xMax + 3, 36);
            var subRect = new Rect(0, fullRect.position.y - 2, fullRect.xMax, 36);
            var lineRect = new Rect(0, fullRect.position.y, fullRect.xMax + 3, 1);

            Color color;
            Color guiColor;

            if (EditorGUIUtility.isProSkin)
            {
                color = Constant.ColorDarkGray;
                guiColor = Constant.ColorLightGray;
            }
            else
            {
                color = Constant.ColorLightGray;
                guiColor = Constant.ColorDarkGray;
            }

            EditorGUI.DrawRect(fillRect, color);
            EditorGUI.DrawRect(lineRect, Constant.LineColor);

            GUI.Label(fullRect, "<size=16><color=#" + ColorUtility.ToHtmlStringRGB(guiColor) + ">" + shaderName + "</color></size>", titleStyle);
            GUI.Label(subRect, "<size=10>" + subtitle + "</size>", subTitleStyle);

            GUILayout.Space(10);
        }

        public static void DrawTechnicalDetails(Material material)
        {
            GUILayout.Space(10);

            var shaderName = material.shader.name;
            var projectPipeline = BoxoUtils.GetProjectPipeline();

            var styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleLeft,
                wordWrap = true,
            };


            if (shaderName.Contains("Simple Lit"))
            {
                DrawTechincalLabel("Shader Complexity: Optimized", styleLabel);
            }

            if (shaderName.Contains("Standard Lit") || shaderName.Contains("Subsurface Lit"))
            {
                DrawTechincalLabel("Shader Complexity: Balanced", styleLabel);
            }

            if (!material.HasProperty("_IsElementShader"))
            {
                if (projectPipeline == "High Definition")
                {
                    DrawTechincalLabel("Render Pipeline: High Definition Render Pipeline", styleLabel);
                }
                else if (projectPipeline == "Universal")
                {
                    DrawTechincalLabel("Render Pipeline: Universal Render Pipeline", styleLabel);
                }
                else
                {
                    DrawTechincalLabel("Render Pipeline: Standard Render Pipeline", styleLabel);
                }
            }
            else
            {
                DrawTechincalLabel("Render Pipeline: Any Render Pipeline", styleLabel);
            }

            DrawTechincalLabel("Render Queue: " + material.renderQueue.ToString(), styleLabel);

            if (shaderName.Contains("Standard Lit"))
            {
                DrawTechincalLabel("Render Path: Rendered in both Forward and Deferred path", styleLabel);
            }

            if (shaderName.Contains("Subsurface Lit"))
            {
                DrawTechincalLabel("Render Path: Always rendered in Forward path", styleLabel);
            }

            if (shaderName.Contains("Standard Lit") || shaderName.Contains("Subsurface Lit"))
            {
                DrawTechincalLabel("Lighting Model: Physicaly Based Shading", styleLabel);
            }

            if (shaderName.Contains("Simple Lit"))
            {
                DrawTechincalLabel("Lighting Model: Blinn Phong Shading", styleLabel);
            }

            if (!shaderName.Contains("Terrain"))
            {
                if (shaderName.Contains("Simple Lit") || shaderName.Contains("Standard Lit"))
                {
                    DrawTechincalLabel("Subsurface Model: Subsurface Scattering Approximation", styleLabel);
                }

                if (shaderName.Contains("Subsurface Lit"))
                {
                    DrawTechincalLabel("Subsurface Model: Translucency Subsurface Scattering", styleLabel);
                }

                if (material.HasProperty("_IsImpostorShader") || material.HasProperty("_IsElementShader"))
                {
                    DrawTechincalLabel("Batching Support: No", styleLabel);
                }
                else
                {
                    DrawTechincalLabel("Batching Support: Limited, depending on the used features", styleLabel);
                }
            }

            var elementTag = material.GetTag("ElementType", false, "");

            if (elementTag != "")
            {
                DrawTechincalLabel("Element Type Tag: " + elementTag, styleLabel);
            }
        }

        public static void DrawActiveKeywords(Material material)
        {
            GUILayout.Space(10);

            var styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleLeft,
                wordWrap = true,
            };

            var keywords = material.enabledKeywords;

            for (int i = 0; i < keywords.Length; i++)
            {
                DrawTechincalLabel(keywords[i].name, styleLabel);
            }
        }

        public static void DrawTechincalLabel(string label, GUIStyle style)
        {
            GUILayout.Label("<size=10>" + label + "</size>", style);
        }

        public static void DrawCopySettingsFromObject(Material material)
        {
            UnityEngine.Object inputObject = null;

            GUILayout.BeginHorizontal();
            inputObject = (UnityEngine.Object)EditorGUILayout.ObjectField("Copy Settings From Object", inputObject, typeof(UnityEngine.Object), true, GUILayout.Height(17));
            GUILayout.Space(2);
            GUILayout.EndHorizontal();

            if (inputObject != null)
            {
                if (inputObject.GetType() == typeof(GameObject))
                {
                    var gameObject = (GameObject)inputObject;
                    var terrain = gameObject.GetComponent<Terrain>();

                    if (terrain != null)
                    {
                        bool copyTerrainSettingsOnly = EditorUtility.DisplayDialog("Copy Terrain Settings?", "Copy material settings for terrain to object blending or copy all settings?", "Copy Terrain Settings Only", "All Settings");

                        if (copyTerrainSettingsOnly)
                        {
                            CopyTerrainDataToMaterial(terrain, material);
                        }
                        else
                        {
                            CopyMaterialProperties(terrain.materialTemplate, material);
                            CopyTerrainDataToMaterial(terrain, material);
                        }

                        Debug.Log("<b>[The Visual Engine]</b> " + "Terrain material settings copied to the current material!");
                    }
                    else
                    {
                        List<Material> allMaterials = new();
                        List<GameObject> allGameObjects = new();

                        allGameObjects.Add(gameObject);
                        GetChildRecursive(gameObject, allGameObjects);

                        for (int i = 0; i < allGameObjects.Count; i++)
                        {
                            var currentGameObject = allGameObjects[i];
                            var currentRenderer = currentGameObject.GetComponent<MeshRenderer>();
                            Material[] sharedMaterials = null;

                            if (currentRenderer != null)
                            {
                                sharedMaterials = currentRenderer.sharedMaterials;
                            }

                            if (sharedMaterials != null)
                            {
                                for (int j = 0; j < sharedMaterials.Length; j++)
                                {
                                    var currentMaterial = sharedMaterials[j];

                                    if (currentMaterial != null && currentMaterial != material && !allMaterials.Contains(currentMaterial))
                                    {
                                        allMaterials.Add(currentMaterial);
                                    }
                                }
                            }
                        }

                        if (allMaterials.Count == 0)
                        {
                            Debug.Log("<b>[The Visual Engine]</b> " + "No material to copy from found!");
                        }
                        else if (allMaterials.Count == 1)
                        {
                            var oldMaterial = allMaterials[0];

                            CopyMaterialProperties(oldMaterial, material);
                            SetImpostorBakeModes(oldMaterial, material);
                            material.SetFloat("_IsInitialized", 1);

                            Debug.Log("<b>[The Visual Engine]</b> " + "Gameobject material settings copied to the current material!");
                        }
                        else if (allMaterials.Count > 1)
                        {
                            for (int i = 0; i < allMaterials.Count; i++)
                            {
                                var oldMaterial = allMaterials[i];

                                bool copySettings = EditorUtility.DisplayDialog("Copy Material Settings?", "Copy the settings from " + oldMaterial.name.ToUpper() + "?", "Copy Material Settings", "Skip");

                                if (copySettings)
                                {
                                    CopyMaterialProperties(oldMaterial, material);
                                    SetImpostorBakeModes(oldMaterial, material);
                                    material.SetFloat("_IsInitialized", 1);
                                }
                            }

                            Debug.Log("<b>[The Visual Engine]</b> " + "Selected material settings copied to the current material!");
                        }
                    }
                }

                if (inputObject.GetType() == typeof(Material))
                {
                    var oldMaterial = (Material)inputObject;

                    if (oldMaterial != null)
                    {
                        CopyMaterialProperties(oldMaterial, material);

                        material.SetFloat("_IsInitialized", 1);

                        Debug.Log("<b>[The Visual Engine]</b> " + "Selected material settings copied to the current material!");
                    }
                }

                inputObject = null;
            }
        }

        public static void DrawRenderQueue(Material material, MaterialEditor materialEditor)
        {
            if (material.HasProperty("_RenderQueue") && material.HasProperty("_RenderPriority"))
            {
                var mode = material.GetInt("_RenderQueue");
                var priority = material.GetInt("_RenderPriority");

                mode = EditorGUILayout.Popup("Render Queue Mode", mode, new string[] { "Auto", "Priority", "User Defined" });

                if (mode == 0)
                {
                    priority = 0;
                }
                else if (mode == 1)
                {
                    priority = EditorGUILayout.IntSlider("Render Priority", priority, -100, 100);
                }
                else
                {
                    priority = 0;
                    materialEditor.RenderQueueField();
                }

                material.SetInt("_RenderQueue", mode);
                material.SetInt("_RenderPriority", priority);
            }
        }

        public static void DrawBakeGIMode(Material material)
        {
            if (material.HasProperty("_RenderBakeGI") && material.HasProperty("_RenderCull"))
            {
                var mode = material.GetInt("_RenderBakeGI");
                var cull = material.GetInt("_RenderCull");

                mode = EditorGUILayout.Popup("Double Sided GI Mode", mode, new string[] { "Auto", "Off", "On" });

                if (mode == 0)
                {
                    if (cull == 0)
                    {
                        material.doubleSidedGI = true;
                    }
                    else
                    {
                        material.doubleSidedGI = false;
                    }
                }
                else if (mode == 1)
                {
                    material.doubleSidedGI = false;
                }
                else
                {
                    material.doubleSidedGI = true;
                }

                material.SetInt("_RenderBakeGI", mode);
            }
        }

        public static void DrawStripUnusedTextures(Material material)
        {
            if (material.HasProperty("_StripUnusedTextures"))
            {
                var mode = material.GetInt("_StripUnusedTextures");
                bool strip;

                if (mode == 0)
                {
                    strip = false;
                }
                else
                {
                    strip = true;
                }

                strip = EditorGUILayout.Toggle(new GUIContent("Strip Unused Textures", "Unity is always exporting all shader textures to build regardless if the feature is enabled or not! Use this feature to clean up unused textures."), strip);

                if (strip)
                {
                    material.SetInt("_StripUnusedTextures", 1);
                }
                else
                {
                    material.SetInt("_StripUnusedTextures", 0);
                }
            }
        }

        public static string DrawSearchField(string searchText, out string[] searchResult, int space)
        {
            GUILayout.BeginHorizontal();
            //GUI.color = new Color(1, 1, 1, 0.9f);
            GUILayout.Space(space);

            GUIStyle searchStyle = GUI.skin.FindStyle("ToolbarSearchTextField");

            if (searchStyle == null)
            {
                searchStyle = GUI.skin.FindStyle("ToolbarSeachTextField");
            }

            searchText = GUILayout.TextField(searchText, searchStyle);

            //GUI.color = Color.white;
            GUILayout.EndHorizontal();

            if (searchText == "")
            {
                searchResult = new string[] { "" };
            }
            else
            {
                var searchInvariant = searchText.ToUpper();
                searchResult = searchInvariant.Split(";");

                for (int i = 0; i < searchResult.Length; i++)
                {
                    searchResult[i] = searchResult[i].TrimStart().TrimEnd();
                }
            }

            //for (int i = 0; i < searchResult.Length; i++)
            //{
            //    Debug.Log(i + " " + searchResult[i]);
            //}

            return searchText;
        }

        public static void DrawCopyPaste(Material material, string searchString, string[] searchResult)
        {
            if (searchString != "")
            {
                GUILayout.Space(10);

                if (TVEGlobals.searchCopyPaste != "")
                {
                    GUILayout.BeginHorizontal();

                    if (GUILayout.Button("Copy Selected Settings"))
                    {
                        TVEUtils.CopyMaterialSelectedProperties(material, searchResult);
                    }

                    if (GUILayout.Button("Paste Selected Settings"))
                    {
                        TVEUtils.PasteMaterialSelectedProperties(material);
                    }

                    GUILayout.EndHorizontal();
                }
                else
                {
                    if (GUILayout.Button("Copy Selected Settings"))
                    {
                        TVEUtils.CopyMaterialSelectedProperties(material, searchResult);
                    }
                }
            }
            else
            {
                if (TVEGlobals.searchCopyPaste != "")
                {
                    GUILayout.Space(10);

                    GUILayout.BeginHorizontal();

                    if (GUILayout.Button("Clear Selected Settings"))
                    {
                        TVEGlobals.searchCopyPaste = "";
                    }

                    if (GUILayout.Button("Paste Selected Settings"))
                    {
                        TVEUtils.PasteMaterialSelectedProperties(material);
                    }

                    GUILayout.EndHorizontal();
                }
            }
        }

        public static void DrawPoweredBy()
        {
            var styleLabelCentered = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };

            Rect lastRect0 = GUILayoutUtility.GetLastRect();
            EditorGUI.DrawRect(new Rect(0, lastRect0.yMax, 1000, 1), new Color(0, 0, 0, 0.4f));

            GUILayout.Space(10);

            GUILayout.Label("<size=10><color=#808080>Powered by The Visual Engine</color></size>", styleLabelCentered);

            Rect labelRect = GUILayoutUtility.GetLastRect();

            if (GUI.Button(labelRect, "", new GUIStyle()))
            {
                Application.OpenURL("https://u3d.as/3iHy");
            }

            GUILayout.Space(5);
        }

        public static void DrawToolbar(int leftSpace, int rightSpace)
        {
            var styledToolbar = new GUIStyle(EditorStyles.toolbarButton)
            {
                alignment = TextAnchor.MiddleCenter,
                fontStyle = FontStyle.Normal,
                fontSize = 11,
            };

            GUILayout.BeginHorizontal();
            GUILayout.Space(leftSpace);
            if (GUILayout.Button("Discord", styledToolbar))
            {
                Application.OpenURL("https://discord.com/invite/znxuXET");
            }
            GUILayout.Space(-1);

            if (GUILayout.Button("Manual", styledToolbar))
            {
                Application.OpenURL("https://docs.google.com/document/d/1ofHGsicGeyvCQTCky4ec5q96Ttaxub_PuuJ0YEoFpWk");
            }
            GUILayout.Space(-1);

            if (GUILayout.Button("Modules", styledToolbar))
            {
                Application.OpenURL("https://assetstore.unity.com/publishers/20529");
            }

#if UNITY_2020_3_OR_NEWER
            var rectModules = GUILayoutUtility.GetLastRect();
            var iconModules = new Rect(rectModules.xMax - 26, rectModules.y, 20, 20);

            //if (EditorGUIUtility.isProSkin)
            //{
            //    GUI.color = new Color(0.2f, 1.0f, 1.0f);
            //}
            //else
            //{
            //    GUI.color = new Color(0.2f, 0.9f, 0.9f);
            //}

            GUI.Label(iconModules, EditorGUIUtility.IconContent("d_FlareLayer Icon"));
            //GUI.color = Color.white;
#endif
            GUILayout.Space(-1);

            if (GUILayout.Button("Review", styledToolbar))
            {
                Application.OpenURL("https://assetstore.unity.com/packages/tools/utilities/the-visual-engine-286827#reviews");
            }

#if UNITY_2020_3_OR_NEWER
            var rectReview = GUILayoutUtility.GetLastRect();
            var iconReview = new Rect(rectReview.xMax - 26, rectReview.y, 20, 20);

            if (EditorGUIUtility.isProSkin)
            {
                GUI.color = new Color(1f, 1f, 0.5f);
            }
            else
            {
                GUI.color = new Color(1f, 0.8f, 0.3f);
            }

            GUI.Label(iconReview, EditorGUIUtility.IconContent("d_Favorite"));
            GUI.color = Color.white;
#endif
            GUILayout.Space(-1);
            GUILayout.Space(rightSpace);
            GUILayout.EndHorizontal();
        }

        // Property Utils
        public static bool GetPropertyVisibility(Material material, string internalName)
        {
            bool valid = true;

            var shaderName = material.shader.name;
            var projectPipeline = BoxoUtils.GetProjectPipeline();

            if (internalName == "unity_Lightmaps")
                valid = false;

            if (internalName == "unity_LightmapsInd")
                valid = false;

            if (internalName == "unity_ShadowMasks")
                valid = false;

            if (internalName.Contains("_Banner"))
                valid = false;

            if (internalName == "_SpecColor")
                valid = false;

            if (internalName.Contains("_AI_Hemi"))
                valid = false;

            if (internalName.Contains("_AI_Clip"))
                valid = false;

            if (internalName.Contains("_NoiseTex3D"))
                valid = false;

            if (internalName.Contains("_NoiseTexSS"))
                valid = false;

            if (internalName.Contains("_motion_highlight_color"))
                valid = false;

            if (material.HasProperty("_RenderMode"))
            {
                if (material.GetInt("_RenderMode") == 0 && internalName == "_RenderZWrite")
                    valid = false;
            }

            bool hasRenderNormals = false;

            if (material.HasProperty("_render_normal"))
            {
                hasRenderNormals = true;
            }

            if (!hasRenderNormals)
            {
                if (internalName == "_RenderNormal")
                    valid = false;
            }

            if (material.HasProperty("_RenderCull"))
            {
                if (material.GetInt("_RenderCull") == 2 && internalName == "_RenderNormal")
                    valid = false;
            }

            if (projectPipeline == "Universal")
            {
                if (internalName == "_RenderGBuffer" && shaderName.Contains("Standard Lit"))
                    valid = false;
            }

            if (material.HasProperty("_MainColorMode"))
            {
                if (material.GetInt("_MainColorMode") == 0)
                {
                    if (internalName == "_MainColorTwo")
                        valid = false;
                }
            }

            if (material.HasProperty("_SecondColorMode"))
            {
                if (material.GetInt("_SecondColorMode") == 0)
                {
                    if (internalName == "_SecondColorTwo")
                        valid = false;
                }
            }

            if (material.HasProperty("_ThirdColorMode"))
            {
                if (material.GetInt("_ThirdColorMode") == 0)
                {
                    if (internalName == "_ThirdColorTwo")
                        valid = false;
                }
            }

            if (material.HasProperty("_FourthColorMode"))
            {
                if (material.GetInt("_FourthColorMode") == 0)
                {
                    if (internalName == "_FourthColorTwo")
                        valid = false;
                }
            }

            if (material.HasProperty("_ImpostorColorMode"))
            {
                if (material.GetInt("_ImpostorColorMode") == 0)
                {
                    if (internalName == "_ImpostorColorTwo")
                        valid = false;
                }
            }

            // Standard Render Pipeline SSS
            if (internalName == "_Translucency")
                valid = false;
            if (internalName == "_TransNormalDistortion")
                valid = false;
            if (internalName == "_TransScattering")
                valid = false;
            if (internalName == "_TransDirect")
                valid = false;
            if (internalName == "_TransAmbient")
                valid = false;
            if (internalName == "_TransShadow")
                valid = false;

            // Universal Render Pipeline SSS
            if (internalName == "_TransStrength")
                valid = false;
            if (internalName == "_TransNormal")
                valid = false;

            if (material.HasProperty("_ObjectModelMode"))
            {
                if (material.GetInt("_ObjectModelMode") == 0)
                {
                    if (internalName == "_MotionBaseMaskMode")
                        valid = false;
                    if (internalName == "_MotionSmallMaskMode")
                        valid = false;
                    if (internalName == "_MotionTinyMaskMode")
                        valid = false;
                }
            }

            if (material.HasProperty("_ObjectBoundsMode"))
            {
                if (material.GetInt("_ObjectBoundsMode") == 1)
                {
                    if (internalName == "_ObjectHeightValue")
                        valid = false;
                    if (internalName == "_ObjectRadiusValue")
                        valid = false;
                }
            }

            if (internalName == "_SecondBakeInfo")
            {
                if (material.HasProperty("_SecondBakeInfo") && material.GetInt("_SecondBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_ThirdBakeInfo")
            {
                if (material.HasProperty("_ThirdBakeInfo") && material.GetInt("_ThirdBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_FourthBakeInfo")
            {
                if (material.HasProperty("_FourthBakeInfo") && material.GetInt("_FourthBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_OcclusionBakeInfo")
            {
                if (material.HasProperty("_OcclusionBakeInfo") && material.GetInt("_OcclusionBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_GradientBakeInfo")
            {
                if (material.HasProperty("_GradientBakeInfo") && material.GetInt("_GradientBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_TintingBakeInfo")
            {
                if (material.HasProperty("_TintingBakeInfo") && material.GetInt("_TintingBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_DrynessBakeInfo")
            {
                if (material.HasProperty("_DrynessBakeInfo") && material.GetInt("_DrynessBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_OverlayBakeInfo")
            {
                if (material.HasProperty("_OverlayBakeInfo") && material.GetInt("_OverlayBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_WetnessBakeInfo")
            {
                if (material.HasProperty("_WetnessBakeInfo") && material.GetInt("_WetnessBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            if (internalName == "_CutoutBakeInfo")
            {
                if (material.HasProperty("_CutoutBakeInfo") && material.GetInt("_CutoutBakeInfo") == 0)
                {
                    valid = false;
                }
            }

            return valid;
        }

        public static string GetPropertyDisplay(Material material, string internalName, string displayName)
        {
            //#if !THE_VISUAL_ENGINE_IMPOSTORS
            //            if (internalName.Contains("BakeMode"))
            //            {
            //                GUI.color = new Color(0.7f, 0.7f, 0.7f, 1f);
            //            }
            //            else
            //            {
            //                GUI.color = Color.white;
            //            }
            //#endif

            //if (internalName == "_AI_Parallax")
            //{
            //    GUILayout.Space(10);
            //}

            //if (internalName == "AI_CLIP_NEIGHBOURS_FRAMES")
            //{
            //    GUILayout.Space(10);
            //}

            //if (internalName == "_AI_Clip")
            //{
            //    displayName = "Impostor Alpha Treshold";
            //}

            if (internalName == "_Albedo")
            {
                displayName = "Impostor Albedo";
            }

            if (internalName == "_Normals")
            {
                displayName = "Impostor Normal";
            }

            if (material.HasProperty("_MainColorMode"))
            {
                if (material.GetInt("_MainColorMode") == 1 && internalName == "_MainColor")
                {
                    displayName = displayName + " A";
                }
            }

            if (material.HasProperty("_SecondColorMode"))
            {
                if (material.GetInt("_SecondColorMode") == 1 && internalName == "_SecondColor")
                {
                    displayName = displayName + " A";
                }
            }

            if (material.HasProperty("_ThirdColorMode"))
            {
                if (material.GetInt("_ThirdColorMode") == 1 && internalName == "_ThirdColor")
                {
                    displayName = displayName + " A";
                }
            }

            if (material.HasProperty("_FourthColorMode"))
            {
                if (material.GetInt("_FourthColorMode") == 1 && internalName == "_FourthColor")
                {
                    displayName = displayName + " A";
                }
            }

            if (material.HasProperty("_ImpostorColorMode"))
            {
                if (material.GetInt("_ImpostorColorMode") == 1 && internalName == "_ImpostorColor")
                {
                    displayName = displayName + " A";
                }
            }

            //if (EditorGUIUtility.currentViewWidth > 550)
            //{
            //    if (internalName == "_MainMetallicValue")
            //    {
            //        if (shaderName.Contains("Standard Lit") || shaderName.Contains("Subsurface Lit"))
            //        {
            //            displayName = displayName + " (Mask Red)";
            //        }
            //    }

            //    if (internalName == "_MainOcclusionValue")
            //    {
            //        displayName = displayName + " (Mask Green)";
            //    }

            //    if (internalName == "_MainSmoothnessValue")
            //    {
            //        if (shaderName.Contains("Standard Lit") || shaderName.Contains("Subsurface Lit"))
            //        {
            //            displayName = displayName + " (Mask Alpha)";
            //        }
            //    }

            //    if (internalName == "_MainMaskRemap")
            //    {
            //        displayName = displayName + " (Mask Blue)";
            //    }

            //    if (internalName == "_SecondMetallicValue")
            //    {
            //        if (shaderName.Contains("Standard Lit") || shaderName.Contains("Subsurface Lit"))
            //        {
            //            displayName = displayName + " (Mask Red)";
            //        }
            //    }

            //    if (internalName == "_SecondOcclusionValue")
            //    {
            //        displayName = displayName + " (Mask Green)";
            //    }

            //    if (internalName == "_SecondSmoothnessValue")
            //    {
            //        if (shaderName.Contains("Standard Lit") || shaderName.Contains("Subsurface Lit"))
            //        {
            //            displayName = displayName + " (Mask Alpha)";
            //        }
            //    }

            //    if (internalName == "_SecondMaskRemap")
            //    {
            //        displayName = displayName + " (Mask Blue)";
            //    }

            //    if (internalName == "_DetailMeshMode" || internalName == "_DetailMeshRemap")
            //    {
            //        if (material.HasProperty("_DetailMeshMode"))
            //        {
            //            if (material.GetInt("_DetailMeshMode") == 0)
            //            {
            //                displayName = displayName + " (Vertex Blue)";
            //            }
            //            else if (material.GetInt("_DetailMeshMode") == 1)
            //            {
            //                displayName = displayName + " (World Normals)";
            //            }
            //        }
            //    }

            //    if (internalName == "_DetailMaskMode" || internalName == "_DetailMaskRemap")
            //    {
            //        displayName = displayName + " (Mask Blue)";
            //    }

            //    if (internalName == "_VertexOcclusionRemap")
            //    {
            //        displayName = displayName + " (Vertex Green)";
            //    }

            //    if (internalName == "_GradientMaskRemap")
            //    {
            //        displayName = displayName + " (Vertex Alpha)";
            //    }
            //}

            return displayName;
        }
        public static string GetAssetVersioPath()
        {
            return AssetDatabase.GUIDToAssetPath("205459a1a763d614b80e362dbbc05b68");
        }

        // Asset Utils
        public static TVEProjectData GetProjectData()
        {
            const string minimumVersionFor2022_3 = "2022.3.18";
            const string minimumVersionFor6000_0 = "6000.0.23";

            var projectData = new TVEProjectData();

            string pipeline = "Standard";

            if (GraphicsSettings.defaultRenderPipeline != null)
            {
                if (GraphicsSettings.defaultRenderPipeline.GetType().ToString().Contains("Universal"))
                {
                    pipeline = "Universal";
                }

                if (GraphicsSettings.defaultRenderPipeline.GetType().ToString().Contains("HD"))
                {
                    pipeline = "High Definition";
                }
            }

            if (QualitySettings.renderPipeline != null)
            {
                if (QualitySettings.renderPipeline.GetType().ToString().Contains("Universal"))
                {
                    pipeline = "Universal";
                }

                if (QualitySettings.renderPipeline.GetType().ToString().Contains("HD"))
                {
                    pipeline = "High Definition";
                }
            }

            projectData.pipeline = pipeline;

            var version = Application.unityVersion;

            if (version.Contains("a") || version.Contains("b"))
            {
                projectData.isAlphaOrBetaRelease = true;
            }

            version = version.Replace("f", "x").Replace("a", "x").Replace("b", "x");

            if (pipeline != "Standard")
            {
                var versionSplit = version.Split(".");

                var version0 = int.Parse(versionSplit[0], CultureInfo.InvariantCulture);
                var version1 = int.Parse(versionSplit[1], CultureInfo.InvariantCulture);
                var version2Split = versionSplit[2].Split("x");
                var version2 = int.Parse(version2Split[0], CultureInfo.InvariantCulture);

                if (version0 == 2022)
                {
                    var minimumSplit = minimumVersionFor2022_3.Split(".");
                    var minimum2 = int.Parse(minimumSplit[2], CultureInfo.InvariantCulture);

                    if (version1 != 3)
                    {
                        projectData.isSupported = false;
                    }
                    else
                    {
                        if (version2 < minimum2)
                        {
                            projectData.isSupported = false;
                        }
                    }

                    projectData.package = "2022.3+";
                }

                if (version0 >= 6000)
                {
                    if (version1 == 0)
                    {
                        var minimumSplit = minimumVersionFor6000_0.Split(".");
                        var minimum2 = int.Parse(minimumSplit[2], CultureInfo.InvariantCulture);

                        if (version2 < minimum2)
                        {
                            projectData.isSupported = false;
                        }
                    }

                    projectData.package = "6000.0+";
                }

                var minimum = minimumVersionFor2022_3;

                if (version0 >= 6000)
                {
                    minimum = minimumVersionFor6000_0;
                }

                projectData.minimum = minimum;
            }

            return projectData;
        }

        public static int GetAssetVersionInt()
        {
            var versionStr = SettingsUtils.LoadSettingsData(GetAssetVersioPath(), "-1");

            var versionSplit = versionStr.Split(" ");

            return int.Parse(versionSplit[0]);
        }

        public static string GetAssetVersionStr()
        {
            var versionStr = SettingsUtils.LoadSettingsData(GetAssetVersioPath(), "-1");

            versionStr = versionStr.Insert(2, ".");
            versionStr = versionStr.Insert(4, ".");

            return versionStr;
        }

        public static string GetAssetFolder()
        {
            return GetAssetVersioPath().Replace("/Core/Editor/Version.asset", "");
        }

        public static TVEPathData GetPathData(string assetPath)
        {
            var pathData = new TVEPathData();

            pathData.folder = Path.GetDirectoryName(assetPath);
            pathData.extention = Path.GetExtension(assetPath);

            assetPath = Path.GetFileNameWithoutExtension(assetPath);
            assetPath = assetPath.Replace("(", "");
            assetPath = assetPath.Replace(")", "");

            var splitLine = assetPath.Split(char.Parse(" "));
            var splitCount = splitLine.Length;

            pathData.type = splitLine[splitCount - 1];
            pathData.suffix = splitLine[splitCount - 2];

            assetPath = assetPath.Replace(pathData.type, "");
            assetPath = assetPath.Replace(pathData.suffix, "");

            // Old Assets might not have an ID
            if (splitCount > 3)
            {
                pathData.GUID = splitLine[splitCount - 3];
                assetPath = assetPath.Replace(pathData.GUID, "");
            }

            assetPath = assetPath.TrimEnd();

            pathData.name = assetPath;

            return pathData;
        }

        public static void CopyLabel(UnityEngine.Object originalObject, UnityEngine.Object instanceObject)
        {
            var labelsArr = AssetDatabase.GetLabels(originalObject);
            AssetDatabase.SetLabels(instanceObject, labelsArr);
        }

        public static void SetLabel(string path)
        {
            var asset = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path);

            AssetDatabase.SetLabels(asset, new string[] { "The Visual Engine" });
        }

        public static bool HasLabel(UnityEngine.Object asset)
        {
            bool valid = false;

            var labelsArr = AssetDatabase.GetLabels(asset);
            var labeldList = new List<string>();

            labeldList.AddRange(labelsArr);

            if (labeldList.Contains("The Visual Engine"))
            {
                valid = true;
            }

            labeldList.Clear();

            return valid;
        }

        public static bool HasLabel(string path)
        {
            bool valid = false;

            var asset = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path);
            var labelsArr = AssetDatabase.GetLabels(asset);
            var labeldList = new List<string>();

            labeldList.AddRange(labelsArr);

            if (labeldList.Contains("The Visual Engine"))
            {
                valid = true;
            }

            labeldList.Clear();

            return valid;
        }

        public static bool HasLabel(string path, string check)
        {
            bool valid = false;

            var asset = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path);
            var labelsArr = AssetDatabase.GetLabels(asset);
            var labeldList = new List<string>();

            labeldList.AddRange(labelsArr);

            if (labeldList.Contains(check))
            {
                valid = true;
            }

            labeldList.Clear();

            return valid;
        }

        public static void SetDefineSymbol(string symbol, string version)
        {
#if UNITY_2023_1_OR_NEWER
            BuildTarget buildTarget = EditorUserBuildSettings.activeBuildTarget;
            BuildTargetGroup targetGroup = BuildPipeline.GetBuildTargetGroup(buildTarget);
            var namedBuildTarget = UnityEditor.Build.NamedBuildTarget.FromBuildTargetGroup(targetGroup);
            var defineSymbols = PlayerSettings.GetScriptingDefineSymbols(namedBuildTarget);
#else
            var defineSymbols = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);
#endif

            var defineSymbolsSplit = defineSymbols.Split(";");

            var newDefineSymbols = "";

            var versionFormat = symbol + "_V";
            var versionSymbol = symbol + "_V" + version;

            for (int i = 0; i < defineSymbolsSplit.Length; i++)
            {
                var define = defineSymbolsSplit[i];

                if (define.Contains(versionFormat))
                {
                    defineSymbolsSplit[i] = versionSymbol;
                }

                newDefineSymbols = newDefineSymbols + defineSymbolsSplit[i] + ";";
            }

            if (!newDefineSymbols.Contains(symbol))
            {
                newDefineSymbols = newDefineSymbols + symbol + ";";
            }

            if (!newDefineSymbols.Contains(versionFormat))
            {
                newDefineSymbols = newDefineSymbols + versionSymbol + ";";
            }

#if UNITY_2023_1_OR_NEWER
            PlayerSettings.SetScriptingDefineSymbols(namedBuildTarget, newDefineSymbols);
#else
            PlayerSettings.SetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup, newDefineSymbols);
#endif
        }

        public static void SetScriptExecutionOrder()
        {
            MonoScript[] scripts = (MonoScript[])Resources.FindObjectsOfTypeAll(typeof(MonoScript));

            foreach (MonoScript script in scripts)
            {
                if (script.GetClass() == typeof(TVEManager))
                {
                    MonoImporter.SetExecutionOrder(script, -122);
                }

                if (script.GetClass() == typeof(SceneSwitch))
                {
                    MonoImporter.SetExecutionOrder(script, -123);
                }
            }
        }

        public static void SetVertexCompression()
        {
            if (EditorSettings.serializationMode == UnityEditor.SerializationMode.ForceText)
            {
                var projectSettingsPath = Path.Combine(Path.GetDirectoryName(Application.dataPath), "ProjectSettings", "ProjectSettings.asset");

                var requiresCompressionUpgrade = false;
                var vertexLayers = new List<int>();
                var settingsLines = new List<string>();

                if (File.Exists(projectSettingsPath))
                {
                    StreamReader reader = new StreamReader(projectSettingsPath);

                    int bitmask = 0;


                    while (!reader.EndOfStream)
                    {
                        settingsLines.Add(reader.ReadLine());
                    }

                    reader.Close();

                    for (int i = 0; i < settingsLines.Count; i++)
                    {
                        if (settingsLines[i].Contains("VertexChannelCompressionMask"))
                        {
                            string line = settingsLines[i].Replace("  VertexChannelCompressionMask: ", "");
                            bitmask = int.Parse(line, CultureInfo.InvariantCulture);
                        }
                    }

                    for (int i = 0; i < 9; i++)
                    {
                        if (((1 << i) & bitmask) != 0)
                        {
                            vertexLayers.Add(1);
                        }
                        else
                        {
                            vertexLayers.Add(0);
                        }
                    }

                    if (vertexLayers[4] == 1 || vertexLayers[7] == 1)
                    {
                        requiresCompressionUpgrade = true;
                    }
                }

                if (requiresCompressionUpgrade)
                {
                    // Disable layers
                    vertexLayers[4] = 0;
                    vertexLayers[7] = 0;

                    int layerMask = 0;

                    for (int i = 0; i < 9; i++)
                    {
                        if (vertexLayers[i] == 1)
                        {
                            layerMask = layerMask + (int)Mathf.Pow(2, i);
                        }
                    }

                    StreamWriter writer = new StreamWriter(projectSettingsPath);

                    for (int i = 0; i < settingsLines.Count; i++)
                    {
                        if (settingsLines[i].Contains("VertexChannelCompressionMask"))
                        {
                            settingsLines[i] = "  VertexChannelCompressionMask: " + layerMask;
                        }

                        //if (settingsLines[i].Contains("StripUnusedMeshComponents"))
                        //{
                        //    settingsLines[i] = "  StripUnusedMeshComponents: 1";
                        //}

                        writer.WriteLine(settingsLines[i]);
                    }

                    writer.Close();

                    Debug.Log("<b>[The Visual Engine]</b> Vertex Compression set to uncompressed for TexCoord0 (required for Legacy meshes) and TexCoord3 (required for Baked pivots)!");
                }
            }
        }

        // PresetUtils
        public static void GetSettingsPresetsEnum(bool refresh)
        {
            if (TVEGlobals.settingPresetPaths == null || TVEGlobals.settingPresetPaths.Count == 0 || refresh)
            {
                TVEGlobals.settingPresetPaths = new List<string>();
                TVEGlobals.settingPresetPaths.Add("");

                var allPresetPaths = BoxoUtils.FindAssets("*.tvepreset", false);

                for (int i = 0; i < allPresetPaths.Length; i++)
                {
                    string assetPath = allPresetPaths[i];

                    if (assetPath.Contains("[SETTINGS]") == true)
                    {
                        TVEGlobals.settingPresetPaths.Add(assetPath);
                    }
                }

                TVEGlobals.settingPresetsEnum = new string[TVEGlobals.settingPresetPaths.Count];
                TVEGlobals.settingPresetsEnum[0] = "Choose a preset";

                for (int i = 1; i < TVEGlobals.settingPresetPaths.Count; i++)
                {
                    TVEGlobals.settingPresetsEnum[i] = Path.GetFileNameWithoutExtension(TVEGlobals.settingPresetPaths[i]);
                    //PresetsEnum[i] = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(presetPaths[i]).name;
                    TVEGlobals.settingPresetsEnum[i] = TVEGlobals.settingPresetsEnum[i].Replace("[SETTINGS] ", "");
                    TVEGlobals.settingPresetsEnum[i] = TVEGlobals.settingPresetsEnum[i].Replace(" - ", "/");
                }
            }
        }

#endif
    }

    public class TVEGlobals
    {
        public static string searchMaterial = "";
        public static string searchElement = "";
        public static string searchManager = "";
        public static string searchCopyPaste = "";

        public static List<string> settingPresetPaths;
        public static string[] settingPresetsEnum;

        //public static List<string> shaderDataList;
    }

    public static class TVEEvents
    {
        public static event Action TVEOnAssetsSaved;

        public static void InvokeAssetsSaved()
        {
            if (TVEOnAssetsSaved != null)
            {
                TVEOnAssetsSaved.Invoke();
            }
        }

        public static event Action<TVETerrain> TVEOnTerrainUpdated;

        public static void InvokeTerrainUpdated(TVETerrain terrain)
        {
            if (TVEOnTerrainUpdated != null)
            {
                TVEOnTerrainUpdated.Invoke(terrain);
            }
        }
    }

    public enum TVEBool
    {
        Off = 0,
        On = 1,
    }

    public enum TVEPropertyType
    {
        Texture = 0,
        Vector = 1,
        Value = 2,
    }

    public enum TVEElementsVisibility
    {
        AlwaysHidden = 0,
        AlwaysVisible = 10,
        HiddenAtRuntime = 20,
    }

    public enum TVEElementVisibility
    {
        UseGlobalSettings = -1,
        AlwaysHidden = 0,
        AlwaysVisible = 10,
        HiddenAtRuntime = 20,
    }

    public enum TVEElementsOrdering
    {
        SortInEditMode = 0,
        SortAtRuntime = 10,
    }

    public enum TVETerrainTexture
    {
        Auto = -1,
        None = 0,
        heightTexture = 10,
        //terrainAlbedo = 15,
        normalTexture = 20,
        holesTexture = 30,
    }

    public enum TVETerrainLayerTexture
    {
        Albedo = 0,
        Normal = 10,
        Shader = 20,
    }

    public enum TVETerrainBaking
    {
        //[InspectorName("Pre-Baked")]
        //Off = 0,
        Baked = 10,
        RuntimeRenderTexture = 20,
    }

    public enum TVERefreshMode
    {
        Realtime = 0,
        Selection = 10,
    }

    public enum TVEUVMode
    {
        [InspectorName("Tilling And Offset")]
        Tilling = 0,
        [InspectorName("Scale And Offset")]
        Scale = 1,
    }

    public enum TVEElementType
    {
        None = 0,
        Coat = 10,
        Draw = 25,
        Paint = 20,
        Atmo = 30,
        Effex = 35,
        Glow = 40,
        Form = 50,
        Vertx = 55,
        Flow = 60,
        User = 200,
        //VRT0 = 300,
        //VRT1 = 310,
        //VRT2 = 320,
    }

    public enum TVETextureFormat
    {
        [InspectorName("LDR 8")]
        LDR8 = 0,
        [InspectorName("HDR 16")]
        HDR16 = 10,
        [InspectorName("HDR 32")]
        HDR32 = 20,
    }

    public enum TVETextureSize
    {
        _64 = 64,
        _128 = 128,
        _256 = 256,
        _512 = 512,
        _1024 = 1024,
        _2048 = 2048,
        _4096 = 4096,
        _8192 = 8192,
    }

    [System.Serializable]
    public class TVEGameObjectData
    {
        public GameObject parentPrefab;
        public GameObject gameObject;
        public MeshFilter meshFilter;
        public Mesh originalMesh;
        public Mesh instanceMesh;
        public List<MeshCollider> meshColliders = new List<MeshCollider>();
        public List<Mesh> originalColliders = new List<Mesh>();
        public List<Mesh> instanceColliders = new List<Mesh>();
        public MeshRenderer meshRenderer;
        public Material[] originalMaterials;
        public Material[] instanceMaterials;
        public bool isZUp = false;

        public TVEGameObjectData()
        {

        }
    }

#if UNITY_EDITOR
    public enum TVEPrefabMode
    {
        Undefined = -1,
        Converted = 10,
        Supported = 20,
        Backup = 25,
        Unsupported = 30,
        ConvertedMissingBackup = 40,
        ConvertedAndLocked = 50,
    }

    [System.Serializable]
    public class TVEPathData
    {
        public string folder = "";
        public string name = "";
        public string GUID = "";
        public string suffix = "";
        public string type = "";
        public string extention = "";

        public TVEPathData()
        {

        }
    }

    [System.Serializable]
    public class TVEPrefabData
    {
        public GameObject prefabObject;
        public GameObject prefabInstance;
        public GameObject prefabInstanceInScene;
        public TVEPrefabMode status;
        public string attributes = "";
        public bool isShared = false;
        public bool isNested = false;
        public bool isVariant = false;
        public bool isZUp = false;
        public bool hasRotations = false;
        public bool hasOverrides = false;

        public TVEPrefabData()
        {

        }
    }

    [System.Serializable]
    public class TVETransformData
    {
        public Vector3 position = Vector3.zero;
        public Quaternion rotation = Quaternion.identity;
        public Vector3 scale = Vector3.one;

        public TVETransformData()
        {

        }
    }

    [System.Serializable]
    public class TVECollectionData
    {
        public string status = "";
        public string online = "";
        public string message = "";
        public float decode = 0.0f;

        public TVECollectionData()
        {

        }
    }

    [System.Serializable]
    public class TVEPropertyData
    {
        public enum TVEPropertyType
        {
            Value,
            Range,
            Vector,
            Color,
            Remap,
            Enum,
            Toggle,
            Texture,
            Space,
            Category,
            Message,
        }

        public enum TVEPropertySetter
        {
            Value,
            Vector,
            Texture,
            Display,
        }

        public TVEPropertyType type;
        public TVEPropertySetter setter;
        public string prop = "";
        public string name = "";
        public string tag = "";
        public float value;
        public float min;
        public float max;
        public bool snap;
        public int vectorCount = 4;
        public Vector4 vector;
        public Texture texture;
        public string file;
        public string options;
        public bool hdr;
        public bool space;
        public int spaceTop;
        public int spaceDown;
        public string category;
        public string message = "";
        public string messageLong = "";
        public bool useMessageLong = false;
        public MessageType messageType = MessageType.Info;
        public string infoText = "";

        public int isVisible = 0;
        public int isLocked = 0;
        public bool isMixed = false;

        public TVEPropertyData(string prop)
        {
            type = TVEPropertyType.Space;
            setter = TVEPropertySetter.Display;
            this.prop = prop;
        }

        public TVEPropertyData(string prop, string category, string infoText)
        {
            type = TVEPropertyType.Category;
            setter = TVEPropertySetter.Display;
            this.prop = prop;
            this.category = category;
            this.infoText = infoText;
        }

        public TVEPropertyData(string prop, string message, string messageLong, int spaceTop, int spaceDown, MessageType messageType)
        {
            type = TVEPropertyType.Message;
            setter = TVEPropertySetter.Display;
            this.prop = prop;
            this.message = message;
            this.messageLong = messageLong;
            this.spaceTop = spaceTop;
            this.spaceDown = spaceDown;
            this.messageType = messageType;
        }

        public TVEPropertyData(string prop, string name, float value, bool snap, bool space)
        {
            type = TVEPropertyType.Value;
            setter = TVEPropertySetter.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.snap = snap;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, float value, int min, int max, bool snap, bool space)
        {
            type = TVEPropertyType.Range;
            setter = TVEPropertySetter.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.min = min;
            this.max = max;
            this.snap = snap;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, float value, string options, bool space)
        {
            type = TVEPropertyType.Enum;
            setter = TVEPropertySetter.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.options = options;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, float value, string file, string options, bool space)
        {
            type = TVEPropertyType.Enum;
            setter = TVEPropertySetter.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.file = file;
            this.options = options;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, float value, bool space)
        {
            type = TVEPropertyType.Toggle;
            setter = TVEPropertySetter.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, Vector4 vector, int vectorCount, bool space)
        {
            type = TVEPropertyType.Vector;
            setter = TVEPropertySetter.Vector;
            this.prop = prop;
            this.name = name;
            this.vectorCount = vectorCount;
            this.vector = vector;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, Vector4 vector, float min, float max, bool space)
        {
            type = TVEPropertyType.Remap;
            setter = TVEPropertySetter.Vector;
            this.prop = prop;
            this.name = name;
            this.vector = vector;
            this.min = min;
            this.max = max;
            this.space = space;
        }

        public TVEPropertyData(string prop, string name, Vector4 vector, bool hdr, bool space)
        {
            type = TVEPropertyType.Color;
            setter = TVEPropertySetter.Vector;
            this.prop = prop;
            this.name = name;
            this.vector = vector;
            this.hdr = hdr;
            this.space = space;
        }
        public TVEPropertyData(string prop, string name, Texture texture, bool space)
        {
            type = TVEPropertyType.Texture;
            setter = TVEPropertySetter.Texture;
            this.prop = prop;
            this.name = name;
            this.texture = texture;
            this.space = space;
        }
    }

    [System.Serializable]
    public class TVEPackerData
    {
        public Material blitMaterial;
        public Mesh blitMesh;
        public int blitPass = 0;
        public Texture[] maskTextures;
        public int[] maskChannels;
        public int[] maskCoords;
        //int[] maskLayers;
        public int[] maskActions0;
        public float[] maskValues0;
        public int[] maskActions1;
        public float[] maskValues1;
        public bool saveAsSRGB = false;
        public bool saveAsDefault = true;
        public int transformSpace;

        public TVEPackerData()
        {

        }
    }

    public class TVEModelSettings
    {
        public bool requiresProcessing = false;
        public string meshPath;
        public bool isReadable = false;
        public bool keepQuads = false;
        public ModelImporterMeshCompression meshCompression;

        public TVEModelSettings()
        {

        }
    }

    public class TVETextureSettings
    {
        public string texturePath;
        public TextureImporterSettings textureSettings = new TextureImporterSettings();
        public TextureImporterCompression textureCompression;
        public int maxTextureSize;
        public bool isAsset;

        public TVETextureSettings()
        {

        }
    }

    public class TVEShaderSettings
    {
        public string shaderPath;
        public string renderEngine = "Unity Default Renderer";
        public string shaderModel = "Shader Model 4.5";

        public TVEShaderSettings()
        {

        }
    }

    [System.Serializable]
    public class TVEProjectData
    {
        public string pipeline = "";
        public string minimum = "";
        public string package = "";
        public bool isSupported = true;
        public bool isTechRelease = false;
        public bool isAlphaOrBetaRelease = false;

        public TVEProjectData()
        {

        }
    }
#endif

    [System.Serializable]
    public class TVEMaterialSettings
    {
        public bool baseMask = false;
        public bool useMultiMask = false;
        public bool meshMaskRG = false;
        public bool meshMaskBA = false;
        public bool useProjMask = false;
        public bool useLumaMask = false;
        public bool texCoords = false;
        public bool useImpostorShader = false;
        public bool useImpostorFeature = false;

        public TVEMaterialSettings()
        {

        }
    }

    [System.Serializable]
    public class TVEProxyData
    {
        //public GameObject blitGameObject;
        public TVETerrain blitTVETerrain;
        public Mesh blitMesh;
        //public Shader blitShader;
        public Material blitMaterial;
        //public int bakeCoord = 0;
        //public int bakeData = 0;
        //public bool bakeAlbedoAsSRGB = false;
        public int saveSize = 512;
        public bool saveAsSRGB = true;
        public bool saveAsDefault = true;

        public TVEProxyData()
        {

        }
    }

    public enum TVEMotionSpeedMode
    {
        Constant = 0,
        Dynamic = 1,
    }

    [System.Serializable]
    public class TVEShaderMotionData
    {
        public TVEMotionSpeedMode motionSpeed = TVEMotionSpeedMode.Dynamic;
        //public float motionSpeedMin = 1;
        //public float motionSpeedMax = 3;

        public TVEShaderMotionData()
        {

        }
    }

    [System.Serializable]
    public class TVEShaderSeasonData
    {
        [ColorUsage(true, true)]
        public Color seasonWinter = Color.gray;
        [ColorUsage(true, true)]
        public Color seasonSpring = Color.gray;
        [ColorUsage(true, true)]
        public Color seasonSummer = Color.gray;
        [ColorUsage(true, true)]
        public Color seasonAutumn = Color.gray;

        public TVEShaderSeasonData()
        {

        }
    }

    public enum TVEMetaGIMode
    {
        Off = 0,
        [InspectorName("Enable HTrace Support")]
        EnableHTraceSupport = 1,
    }

    [System.Serializable]
    public class TVEShaderMetaGIData
    {
        public TVEMetaGIMode metaGIMode = TVEMetaGIMode.EnableHTraceSupport;

        public TVEShaderMetaGIData()
        {

        }
    }

    [System.Serializable]
    public class TVEGlobalCoatData
    {
        [Tooltip("Controls the global Layer intensity.")]
        [Range(0.0f, 1.0f)]
        public float layerIntensity = 1.0f;
        [Tooltip("Controls the global Detail intensity.")]
        [Range(0.0f, 1.0f)]
        public float detailIntensity = 1.0f;
        [Tooltip("Controls the global Stack intensity.")]
        [Range(0.0f, 1.0f)]
        public float stackIntensity = 1.0f;
        //[Tooltip("Controls the global Terrain blending intensity.")]
        //[Range(0.0f, 1.0f)]
        //public float terrainIntensity = 1.0f;
        public TVEGlobalCoatData()
        {

        }
    }

    [System.Serializable]
    public class TVEGlobalPaintData
    {
        [Tooltip("Controls the global tinting influence.")]
        [Range(0.0f, 1.0f)]
        public float tintingIntensity = 0.0f;
        [Tooltip("Controls the global tinting color.")]
        [ColorUsage(false, true)]
        public Color tintingColor = new Color(0.5f, 0.5f, 0.5f, 0);

        public TVEGlobalPaintData()
        {

        }
    }

    [System.Serializable]
    public class TVEGlobalGlowData
    {
        [Tooltip("Controls the global emissive intensity.")]
        [Range(0.0f, 1.0f)]
        public float emissiveIntensity = 1.0f;
        [Tooltip("Controls the global emissive color.")]
        [ColorUsage(false, true)]
        public Color emissiveColor = new Color(1f, 1f, 1f, 0);

        public TVEGlobalGlowData()
        {

        }
    }

    [System.Serializable]
    public class TVEGlobalAtmoData
    {
        [Tooltip("Controls the global dryness intensity.")]
        [Range(0.0f, 1.0f)]
        public float drynessIntensity = 0.0f;

        [Tooltip("Controls the global overlay intensity.")]
        [Range(0.0f, 1.0f)]
        public float overlayIntensity = 0.0f;

        [Tooltip("Controls the global wetness intensity.")]
        [Range(0.0f, 1.0f)]
        public float wetnessIntensity = 0.0f;

        [FormerlySerializedAs("raindropsIntensity")]
        [Tooltip("Controls the global rainfall intensity.")]
        [Range(0.0f, 1.0f)]
        public float rainfallIntensity = 0.0f;

        public TVEGlobalAtmoData()
        {

        }
    }

    [System.Serializable]
    public class TVEGlobalEffexData
    {
        [Tooltip("Controls the global Cutout intensity.")]
        [Range(0.0f, 1.0f)]
        public float cutoutIntensity = 0.0f;

        public TVEGlobalEffexData()
        {

        }
    }

    [System.Serializable]
    public class TVEGlobalVertxData
    {
        [HideInInspector]
        public float confromHeight = 0.0f;

        [FormerlySerializedAs("sizeFadeIntensity")]
        [Tooltip("Controls the global Size Fade scale.")]
        [Range(0.0f, 1.0f)]
        public float sizeFadeValue = 1.0f;

        public TVEGlobalVertxData()
        {

        }
    }

    //[System.Serializable]
    //public class TVEGlobalFlowData
    //{
    //    [Tooltip("Controls the global wind turbulence.")]
    //    [Range(0.0f, 1.0f)]
    //    public float windNoise = 0.0f;

    //    public TVEGlobalFlowData()
    //    {

    //    }
    //}

    [System.Serializable]
    public class TVEElementRendererData
    {
        //[Space(10)]
        public TVETextureSize baseTexture = TVETextureSize._512;
        public Transform baseCenter;
        public float baseRadius = 400f;

        [Space(10)]
        public TVETextureSize nearTexture = TVETextureSize._512;
        public Transform nearCenter;
        public float nearRadius = 40f;

        [Space(10)]
        [Range(0, 1)]
        public float baseToNearBlend = 0.5f;
        //[Range(0, 1)]
        //public float shiftFocusByView = 0.0f;

        [Space(10)]
        public List<TVEElementRendererSettings> rendererOverrides = new List<TVEElementRendererSettings>();

        public TVEElementRendererData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementRendererSettings
    {
        [HideInInspector]
        public string name = "";
        [HideInInspector]
        public bool isInitialized = false;

        public TVEElementType rendererData = TVEElementType.None;

        [Space(10)]
        public TVETextureSize baseTexture = TVETextureSize._512;
        public TVETextureFormat baseFormat = TVETextureFormat.HDR16;
        //[Range(0, 8)]
        //public int baseMipmap = 0;
        //public Transform baseCenter;
        //public float baseRadius = 400f;

        [Space(10)]
        public TVETextureSize nearTexture = TVETextureSize._512;
        public TVETextureFormat nearFormat = TVETextureFormat.HDR16;
        //[Range(0, 8)]
        //public int nearMipmap = 0;
        //public Transform nearCenter;
        //public float nearRadius = 40f;

        public TVEElementRendererSettings()
        {

        }
    }

    [System.Serializable]
    public class TVEElementBufferData
    {
        [HideInInspector]
        public string name = "";
        [HideInInspector]
        public bool isInitialized = false;

        public TVEBool renderMode = TVEBool.On;
        [Tooltip("The name used for the global shader parameters.")]
        public string renderName = "Custom";

        [Space(10)]
        [Tooltip("Sets render texture background color.")]
        public Color textureColor = Color.black;

        [Space(10)]
        [Tooltip("When enabled, the elements are rendered in realtime.")]
        public bool isRendering = true;

        [System.NonSerialized]
        public int renderDataID = 0;
        [System.NonSerialized]
        public int bufferSize = -1;
        [System.NonSerialized]
        public float[] bufferUsage;
        [System.NonSerialized]
        public RenderTexture baseObjectRT;
        [System.NonSerialized]
        public TVETextureSize baseTexture = TVETextureSize._512;
        [System.NonSerialized]
        public TVETextureFormat baseFormat = TVETextureFormat.HDR16;
        [System.NonSerialized]
        public int baseMipmap = 0;
        [System.NonSerialized]
        public RenderTexture nearObjectRT;
        [System.NonSerialized]
        public TVETextureSize nearTexture = TVETextureSize._512;
        [System.NonSerialized]
        public TVETextureFormat nearFormat = TVETextureFormat.HDR16;
        [System.NonSerialized]
        public int nearMipmap = 0;
        [System.NonSerialized]
        public CommandBuffer[] commandBuffers;

        [HideInInspector]
        public string baseTexName;
        [HideInInspector]
        public string baseTexCoord;
        [HideInInspector]
        public string nearTexName;
        [HideInInspector]
        public string nearTexCoord;
        [HideInInspector]
        public string texParams;
        [HideInInspector]
        public string texLayers;

        public TVEElementBufferData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementMaterialData
    {
        public Shader shader;
        public string shaderName = "";
        public List<TVEElementPropertyData> props;

        public TVEElementMaterialData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementPropertyData
    {
        public TVEPropertyType type;
        public string prop;
        public Texture texture;
        public Vector4 vector;
        public float value;

        public TVEElementPropertyData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementParamsData
    {
        public string prop = "_ElementParams";
        public Vector4 param = Vector4.one;

        public TVEElementParamsData()
        {

        }
    }

    [System.Serializable]
    public class TVEInstanced
    {
        public int instancedDataID = 0;
        public int renderDataID = 0;
        public List<int> renderLayers;
        public bool renderLayersAsPasses;
        //public int renderPass = 0;
        public Material material;
        public Mesh mesh;
        public List<TVEElement> elements = new List<TVEElement>();
        public List<Renderer> renderers = new List<Renderer>();
        public Matrix4x4[] matrices;
        public Vector4[] parameters;
        public Vector4[] parameters1;
        public Vector4[] parameters2;
        public Vector4[] parameters3;
        public MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();
        public int propertyBlockCount = -1;

        public TVEInstanced()
        {

        }
    }

    [System.Serializable]
    public class TVEMeshData
    {
        public Mesh mesh;
        public List<Vector3> vertices;
        public List<Color> colors;
        public List<Vector3> normals;
        public List<Vector4> tangents;
        public List<Vector4> UV0;
        public List<Vector4> UV2;
        public List<Vector4> UV4;

        public TVEMeshData()
        {

        }
    }

    [System.Serializable]
    public class TVEModelData
    {
        public Mesh mesh;
        public float height = 0;
        public float radius = 0;
        public List<float> variationMask;
        public List<float> occlusionMask;
        public List<float> detailMask;
        public List<float> heightMask;
        public List<Vector2> detailCoord;
        public List<float> motion2Mask;
        public List<float> motion3Mask;
        public List<Vector3> pivotPositions;

        public TVEModelData()
        {

        }
    }

    public enum TVEBlendMode
    {
        Off = 0,
        AutoTerrainBlending = 1,
    }

    [System.Serializable]
    public class TVEBlanketBlending
    {
        public TVEBlendMode blendMode = TVEBlendMode.Off;
    }

    [System.Serializable]
    public class TVETerrainSettings
    {
        //[Space(10)]
        //public bool overrideAllLayers = true;
        //public bool overrideAllTextures = true;
        //public bool overrideAllSettings = true;

        public Texture terrainAlbedo;
        public Texture terrainNormal;
        public Texture terrainShader;
        public Texture terrainFeature;

        [Space(10)]
        public bool useCustomTextures = false;

        [Space(10)]
        public Texture terrainControl01;
        public Texture terrainControl02;
        public Texture terrainControl03;
        public Texture terrainControl04;
        public Texture terrainHolesMask;

        [Space(10)]
        public bool useCustomTransforms = false;

        [Space(10)]
        public Vector3 terrainPosition = new Vector3(0, 0, 0);
        public Vector3 terrainSize = new Vector3(-1, 0, 0);

        [Space(10)]
        public bool useLayersOrderAsID = false;

        [Space(10)]
        public List<TVETerrainLayerSettings> terrainLayers = new List<TVETerrainLayerSettings>();
    }

    [System.Serializable]
    public class TVETerrainRenderer
    {
        [StyledDisplay("Proxy Mode")]
        public TVETerrainBaking bakeMode = TVETerrainBaking.RuntimeRenderTexture;
        [StyledDisplay("Proxy Albedo")]
        public TVETextureSize bakeAlbedoSize = TVETextureSize._256;
        [StyledDisplay("Proxy Normal")]
        public TVETextureSize bakeNormalSize = TVETextureSize._256;
        [StyledDisplay("Proxy Shader")]
        public TVETextureSize bakeShaderSize = TVETextureSize._256;
        [StyledDisplay("Proxy Feature")]
        public TVETextureSize bakeFeatureSize = TVETextureSize._256;
        [StyledDisplay("Proxy Material")]
        public Material bakeMaterial;
    }

    [System.Serializable]
    public class TVETerrainLayerSettings
    {
        [HideInInspector]
        public string name = "";
        [HideInInspector]
        public bool isInitialized = false;

        [Space(10)]
        [Range(1, 16)]
        public int layerID = 1;

        [Space(10)]
        public bool useCustomLayer = false;

        [Space(10)]
        public TerrainLayer terrainLayer;

        [Space(10)]
        public bool useCustomTextures = false;

        [Space(10)]
        public Texture layerAlbedo;
        public Texture layerNormal;
        public Texture layerShader;

        [Space(10)]
        public bool useCustomColor = false;

        [Space(10)]
        [ColorUsage(false, true)]
        public Color layerColor = Color.white;

        [Space(10)]
        public bool useCustomSettings = false;

        [Space(10)]
        [StyledDisplay("Layer Normal")]
        [Range(-8, 8)]
        public float layerNormalScale = 1;

        [Range(0, 1)]
        public float layerMetallic = 0;
        [StyledRemap("Layer Metallic", 0, 1)]
        public Vector2 layerMetallicRemap = new Vector2(0, 1);

        [StyledRemap("Layer Occlusion", 0, 1)]
        public Vector2 hayerOcclusionRemap = new Vector2(0, 1);

        [StyledRemap("Layer Height Mask", 0, 1)]
        public Vector2 hayerHeightRemap = new Vector2(0, 1);

        [Range(0, 1)]
        public float layerSmoothness = 1;
        [StyledRemap("Layer Smoothness", 0, 1)]
        public Vector2 layerSmoothnessRemap = new Vector2(0, 1);

        [Space(10)]
        [Range(0, 1)]
        public float layerEmissive = 0;
        [Range(0, 1)]
        public float layerMultiMask = 0;

        //public Vector4 layerRemapMin = Vector4.zero;
        //public Vector4 layerRemapMax = Vector4.one;

        [Space(10)]
        public bool useCustomCoords = false;

        [Space(10)]
        public TVEUVMode layerUVMode = TVEUVMode.Scale;
        public Vector4 layerUVValue = new Vector4(1, 1, 0, 0);

        public TVETerrainLayerSettings()
        {

        }
    }
}
