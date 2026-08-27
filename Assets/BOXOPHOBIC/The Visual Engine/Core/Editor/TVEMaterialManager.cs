// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using Boxophobic.StyledGUI;
using Boxophobic.Utility;
using System.IO;
using System.Globalization;
using System.Collections.Generic;

namespace TheVisualEngine
{
    public class TVEMaterialManager : EditorWindow
    {
        const int MOTION_INDEX = 9;
        const int GUI_SMALL_WIDTH = 50;
        const int GUI_HEIGHT = 18;
        const int GUI_SELECTION_HEIGHT = 24;
        float GUI_HALF_EDITOR_WIDTH = 200;

        string[] materialOptions = new string[]
        {
        "All Material Settings", "Render Settings", "Surface Settings", "Terrain Settings", "Coloring Settings", "Seasons Settings", "Dithering Settings", "Lighting Settings", "Transform Settings", "Motion Settings", "Normal Settings", "Meta Settings"
        };

        string[] savingOptions = new string[]
        {
        "Save All Settings", "Save Current Settings",
        };

        List<TVEPropertyData> propertyDataSet = new List<TVEPropertyData>
        {

        };

        List<TVEPropertyData> savingDataSet = new List<TVEPropertyData>
        {

        };

        List<TVEPropertyData> renderData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_RenderCategory", "Render Settings", "Use the Faces option to control if the faces should be rendered as double sided.NEWNEWUse the Motion option to control if the shader writes Motion Vectors OPAwhen availableCPA.NEWNEWUse the GBuffer to option to control if the shader writes to GBuffer__ even if the shader is rendered in Forward path OPAwhen availableCPA.NEWNEWUse the Render Normals option to Flip or Mirror the normal map on the mesh backface. When the mesh normals are flattened__ use the Same option so the normals are the same on both sides.NEWNEWUse the Filtering options to control the texture filtering. The Default option keeps the Albedo filtering at higher quality__ and the Normal and Shader filtering at lower quality for better performance.NEWNEWUse the Render Clipping to enable alpha testing__ also know as alpha cutout."),

            new TVEPropertyData("_RenderMode", "Render Mode", -9000, "Opaque 0 Transparent 1", false),
            new TVEPropertyData("_RenderCull", "Render Faces", -9000, "Both 0 Back 1 Front 2", false),
            new TVEPropertyData("_RenderSSR", "Render SSR", -9000, "Off 0 On 1", false),
            new TVEPropertyData("_RenderDecals", "Render Decals", -9000, "Off 0 On 1", false),
            new TVEPropertyData("_RenderMotion", "Render Motion", -9000, "Auto 0 Off 1 On 2", false),
            new TVEPropertyData("_RenderNormal", "Render Normals", -9000, "Flip 0 Mirror 1 Same 2", false),
            new TVEPropertyData("_RenderGBuffer", "Render GBuffer", -9000, "Off 0 On 1", false),
            new TVEPropertyData("_RenderSpecular", "Render Specular", -9000, "Off 0 On 1", false),
            new TVEPropertyData("_RenderFilter", "Render Filtering", -9000, "Default 0 Point 1 Low 2 Medium 3 High 4", false),
            new TVEPropertyData("_RenderClip", "Render Clipping", -9000, "Off 0 On 1", false),
        };

        List<TVEPropertyData> objectData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_ObjectCategory", "Object Settings", ""),

            new TVEPropertyData("_ObjectBoundsInfo", "Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC", "", 0, 10, MessageType.Info),
            new TVEPropertyData("_ObjectModelMode", "Object Model Mode", -9000, "NULL", "Legacy 0 Default 1", false),
            new TVEPropertyData("_ObjectCoordMode", "Object Coord Mode", -9000, "NULL", "Y_Up 0 Z_Up 1", false),
            new TVEPropertyData("_ObjectPivotMode", "Object Pivots Mode", -9000, "NULL", "Single 0 Baked 1 Procedural 2", false),
            new TVEPropertyData("_ObjectPhaseMode", "Object Phase Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_ObjectBoundsMode", "Object Bounds Mode", -9000, "Manual 0 From_Renderer 1", false),
            new TVEPropertyData("_ObjectHeightValue", "Object Height Value", -9000, 0, 40, false, false),
            new TVEPropertyData("_ObjectRadiusValue", "Object Radius Value", -9000, 0, 40, false, false),
        };

        List<TVEPropertyData> globalData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalCoatLayerValue", "Global Coat Layer", -9000, "Coat Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalDrawLayerValue", "Global Draw Layer", -9000, "Draw Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalPaintLayerValue", "Global Paint Layer", -9000, "Paint Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalAtmoLayerValue", "Global Atmo Layer", -9000, "Atmo Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalGlowLayerValue", "Global Glow Layer", -9000, "Glow Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalLandLayerValue", "Global Land Layer", -9000, "Land Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalFormLayerValue", "Global Form Layer", -9000, "Form Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalWindLayerValue", "Global Wind Layer", -9000, "Wind Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalFlowLayerValue", "Global Flow Layer", -9000, "Flow Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalCoatPivotValue", "Global Coat Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalDrawPivotValue", "Global Draw Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalPaintPivotValue", "Global Paint Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalAtmoPivotValue", "Global Atmo Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalGlowPivotValue", "Global Glow Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalLandPivotValue", "Global Land Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalFormPivotValue", "Global Form Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalWindPivotValue", "Global Wind Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalFlowPivotValue", "Global Flow Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> surfaceDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalCoatLayerValue", "Global Coat Layer", -9000, "Coat Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalCoatPivotValue", "Global Coat Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> surfaceData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_MainCategory", "Main Settings", "Use the Multi Mask as a leaves mask when using dual colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders."),

            new TVEPropertyData("_MainAlbedoTex", "Main Albedo", null, false),
            new TVEPropertyData("_MainNormalTex", "Main Normal", null, false),
            new TVEPropertyData("_MainShaderTex", "Main Shader", null, false),

            new TVEPropertyData("_MainSampleMode", "Main Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3 Stochastic 4 Stochastic_Triplanar 5", true),
            new TVEPropertyData("_MainCoordMode", "Main UV Mode", -9000, "Tilling_and_Offset 0 Scale_and_Offset 1", false),
            new TVEPropertyData("_MainCoordValue", "Main UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_MainColorMode", "Main Color", -9000, "Constant 0 Dual_Colors 1", true),
            new TVEPropertyData("_MainColor", "Main Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_MainColorTwo", "Main Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_MainAlphaClipValue", "Main Alpha", -9000, 0, 1, false, false),
            new TVEPropertyData("_MainAlbedoValue", "Main Albedo", -9000, 0, 1, false, false),
            new TVEPropertyData("_MainNormalValue", "Main Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_MainMetallicValue", "Main Metallic", -9000, 0, 1, false, false),
            new TVEPropertyData("_MainOcclusionValue", "Main Occlusion", -9000, 0, 1, false, false),
            new TVEPropertyData("_MainOcclusionRemap", "Main Occlusion", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_MainMultiWriteValue", "Main Multi Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_MainMultiWriteMode", "Main Multi Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Albedo_A 4 Shader_B 5", false),
            new TVEPropertyData("_MainMultiWriteRemap", "Main Multi Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_MainSmoothnessValue", "Main Smoothness", -9000, 0, 1, false, false),
            new TVEPropertyData("_MainSmoothnessRemap", "Main Smoothness", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_ImpostorCategory", "Impostor Settings", ""),

            new TVEPropertyData("_ImpostorTextureInfo", "Based on the enabled settings, the impostor material will disable and strip out the unused textures to optimize performance and memeory usage.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_ImpostorColorMode", "Impostor Color", -9000, "Constant 0 Dual_Colors 1", false),
            new TVEPropertyData("_ImpostorColor", "Impostor Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_ImpostorColorTwo", "Impostor Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_ImpostorAlphaClipValue", "Impostor Alpha", -9000, 0, 1, false, false),
            new TVEPropertyData("_ImpostorMetallicValue", "Impostor Metallic", -9000, 0, 1, false, false),
            new TVEPropertyData("_ImpostorOcclusionValue", "Impostor Occlusion", -9000, 0, 1, false, false),
            new TVEPropertyData("_ImpostorSmoothnessValue", "Impostor Smoothness", -9000, 0, 1, false, false),

            new TVEPropertyData("_SecondCategory", "Layer Settings", "Use the Layer feature to add an additional texture layer over the previous pass.NEWNEWUse the Multi Mask as a leaves mask when using multi colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders.NEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXCNEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA."),

            new TVEPropertyData("_SecondIntensityValue", "Layer Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondBakeMode", "Layer Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),

            new TVEPropertyData("_SecondAlbedoTex", "Layer Albedo", null, true),
            new TVEPropertyData("_SecondNormalTex", "Layer Normal", null, false),
            new TVEPropertyData("_SecondShaderTex", "Layer Shader", null, false),

            new TVEPropertyData("_SecondSampleMode", "Layer Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3 Stochastic 4 Stochastic_Triplanar 5", true),
            new TVEPropertyData("_SecondCoordMode", "Layer UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_SecondCoordValue", "Layer UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_SecondColorMode", "Layer Color", -9000, "Constant 0 Multi_Colors 1", true),
            new TVEPropertyData("_SecondColor", "Layer Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_SecondColorTwo", "Layer Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_SecondAlphaClipValue", "Layer Alpha", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondAlbedoValue", "Layer Albedo", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondNormalValue", "Layer Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_SecondMetallicValue", "Layer Metallic", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondOcclusionValue", "Layer Occlusion", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondOcclusionRemap", "Layer Occlusion", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondMultiWriteValue", "Layer Multi Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondMultiWriteMode", "Layer Multi Mask", -9000, "Albedo_A 0 Shader_B 1", false),
            new TVEPropertyData("_SecondMultiWriteRemap", "Layer Multi Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondSmoothnessValue", "Layer Smoothness", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondSmoothnessRemap", "Layer Smoothness", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_SecondBlendIntensityValue", "Layer Blend Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_SecondBlendAlbedoValue", "Layer Blend Albedos", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondBlendNormalValue", "Layer Blend Normals", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondBlendShaderValue", "Layer Blend Shaders", -9000, 0, 1, false, false),

            new TVEPropertyData("_SecondMaskTex", "Layer Mask", null, true),

            new TVEPropertyData("_SecondMaskSampleMode", "Mask Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3", true),
            new TVEPropertyData("_SecondMaskCoordMode", "Mask UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_SecondMaskCoordValue", "Mask UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_SecondCoatValue", "Layer Coat Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_SecondCoatMode", "Layer Coat Mask", -9000, "Global_Data_Only 0 Use_Coat_Elements 1", false),
            new TVEPropertyData("_SecondMaskValue", "Layer TexB Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondMaskRemap", "Layer TexB Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondLumaValue", "Layer Luma Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondLumaRemap", "Layer Luma Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondBaseValue", "Layer Base Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondBaseRemap", "Layer Base Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondMeshValue", "Layer Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondMeshMode", "Layer Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_SecondMeshRemap", "Layer Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondProjValue", "Layer ProjY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_SecondProjRemap", "Layer ProjY Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_SecondBlendMath", "Layer Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_SecondBlendRemap", "Layer Blend Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_ThirdCategory", "Detail Settings", "Use the Detail feature to add an additional texture layer over the previous pass.NEWNEWUse the Multi Mask as a leaves mask when using dual colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders.NEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXCNEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA."),

            new TVEPropertyData("_ThirdIntensityValue", "Detail Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdBakeMode", "Detail Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),

            new TVEPropertyData("_ThirdAlbedoTex", "Detail Albedo", null, true),
            new TVEPropertyData("_ThirdNormalTex", "Detail Normal", null, false),
            new TVEPropertyData("_ThirdShaderTex", "Detail Shader", null, false),

            new TVEPropertyData("_ThirdSampleMode", "Detail Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3 Stochastic 4 Stochastic_Triplanar 5", true),
            new TVEPropertyData("_ThirdCoordMode", "Detail UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_ThirdCoordValue", "Detail UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_ThirdColorMode", "Detail Color", -9000, "Constant 0 Dual_Colors 1", true),
            new TVEPropertyData("_ThirdColor", "Detail Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_ThirdColorTwo", "Detail Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_ThirdAlphaClipValue", "Detail Alpha", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdAlbedoValue", "Detail Albedo", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdNormalValue", "Detail Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_ThirdMetallicValue", "Detail Metallic", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdOcclusionValue", "Detail Occlusion", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdOcclusionRemap", "Detail Occlusion", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdMultiWriteValue", "Detail Multi Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdMultiWriteMode", "Detail Multi Mask", -9000, "Albedo_A 0 Shader_B 1", false),
            new TVEPropertyData("_ThirdMultiWriteRemap", "Detail Multi Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdSmoothnessValue", "Detail Smoothness", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdSmoothnessRemap", "Detail Smoothness", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_ThirdBlendIntensityValue", "Detail Blend Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_ThirdBlendAlbedoValue", "Detail Blend Albedos", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdBlendNormalValue", "Detail Blend Normals", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdBlendShaderValue", "Detail Blend Shaders", -9000, 0, 1, false, false),

            new TVEPropertyData("_ThirdMaskTex", "Detail Mask", null, true),

            new TVEPropertyData("_ThirdMaskSampleMode", "Mask Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3", true),
            new TVEPropertyData("_ThirdMaskCoordMode", "Mask UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_ThirdMaskCoordValue", "Mask UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_ThirdCoatValue", "Detail Coat Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_ThirdCoatMode", "Detail Coat Mask", -9000, "Global_Data_Only 0 Use_Coat_Elements 1", false),
            new TVEPropertyData("_ThirdMaskRemap", "Detail TexG Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdLumaValue", "Detail Luma Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdLumaRemap", "Detail Luma Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdBaseValue", "Detail Base Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdBaseRemap", "Detail Base Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdMeshValue", "Detail Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdMeshMode", "Detail Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_ThirdMeshRemap", "Detail Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdProjValue", "Detail ProjY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_ThirdProjRemap", "Detail ProjY Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_ThirdBlendMath", "Detail Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_ThirdBlendRemap", "Detail Blend Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_FourthCategory", "Stack Settings", "Use the Stack feature to add an additional texture layer over the previous pass.NEWNEWUse the Multi Mask as a leaves mask when using dual colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders.NEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXCNEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA."),

            new TVEPropertyData("_FourthIntensityValue", "Stack Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthBakeMode", "Stack Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),

            new TVEPropertyData("_FourthAlbedoTex", "Stack Albedo", null, true),
            new TVEPropertyData("_FourthNormalTex", "Stack Normal", null, false),
            new TVEPropertyData("_FourthShaderTex", "Stack Shader", null, false),

            new TVEPropertyData("_FourthSampleMode", "Stack Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3 Stochastic 4 Stochastic_Triplanar 5", true),
            new TVEPropertyData("_FourthCoordMode", "Stack UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_FourthCoordValue", "Stack UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_FourthColorMode", "Stack Color", -9000, "Constant 0 Dual_Colors 1", true),
            new TVEPropertyData("_FourthColor", "Stack Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_FourthColorTwo", "Stack Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_FourthAlphaClipValue", "Stack Alpha", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthAlbedoValue", "Stack Albedo", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthNormalValue", "Stack Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_FourthMetallicValue", "Stack Metallic", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthOcclusionValue", "Stack Occlusion", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthOcclusionRemap", "Stack Occlusion", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthMultiWriteValue", "Stack Multi Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthMultiWriteMode", "Stack Multi Mask", -9000, "Albedo_A 0 Shader_B 1", false),
            new TVEPropertyData("_FourthMultiWriteRemap", "Stack Multi Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthSmoothnessValue", "Stack Smoothness", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthSmoothnessRemap", "Stack Smoothness", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_FourthBlendIntensityValue", "Stack Blend Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_FourthBlendAlbedoValue", "Stack Blend Albedos", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthBlendNormalValue", "Stack Blend Normals", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthBlendShaderValue", "Stack Blend Shaders", -9000, 0, 1, false, false),

            new TVEPropertyData("_FourthMaskTex", "Stack Mask", null, true),

            new TVEPropertyData("_FourthMaskSampleMode", "Mask Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3", true),
            new TVEPropertyData("_FourthMaskCoordMode", "Mask UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_FourthMaskCoordValue", "Mask UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_FourthCoatValue", "Stack Coat Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_FourthCoatMode", "Stack Coat Mask", -9000, "Global_Data_Only 0 Use_Coat_Elements 1", false),
            new TVEPropertyData("_FourthMaskRemap", "Stack TexG Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthBaseValue", "Stack Base Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthLumaValue", "Stack Luma Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthLumaRemap", "Stack Luma Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthBaseRemap", "Stack Base Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthMeshValue", "Stack Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthMeshMode", "Stack Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_FourthMeshRemap", "Stack Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthProjValue", "Stack ProjY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_FourthProjRemap", "Stack ProjY Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_FourthBlendMath", "Stack Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_FourthBlendRemap", "Stack Blend Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
        };

        List<TVEPropertyData> terrainDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalFormLayerValue", "Global Form Layer", -9000, "Land Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalFormPivotValue", "Global Form Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> terrainData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_TerrainCategory", "Terrain Settings", "Use the Terrain feature for object to terrain blending. To use the feature__ you can use the Copy From Object option to copy the terrain data to the material__ or use the Blanket component to blend the object at runtime and to support multiple terrains. Please note__ the blending works properly when the terrain normals are also transfered to the object. Use the Combine feature for this purposeEXCNEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXC"),

            new TVEPropertyData("_TerrainFormInfo", "The Form Mask feature requires elements to work. Use Form Surface or Form Height elements to send the terrain height data to the shaders.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_TerrainIntensityValue", "Terrain Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_TerrainRenderMode", "Terrain Render", -9000, "Default 0 Proxy 1", false),
            new TVEPropertyData("_TerrainLayersMode", "Terrain Layers", -9000, "4_Layers 4 8_Layers 8 12_Layers 12 16_Layers 16", false),
            new TVEPropertyData("_TerrainRemapMode", "Terrain Remap", -9000, "Off 0 Use_Channel_Remapping 1", false),
            new TVEPropertyData("_TerrainHolesMode", "Terrain Holes", -9000, "Off 0 On 1", false),
            new TVEPropertyData("_TerrainTextureMode", "Terrain Maps", -9000, "Default 0 Packed 1", false),
            new TVEPropertyData("_TerrainColorMode", "Terrain Color", -9000, "Constant 0 Use_Per_Layer_Color 1", false),
            new TVEPropertyData("_TerrainColor", "Terrain Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_TerrainNormalValue", "Terrain Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_TerrainMetallicValue", "Terrain Metallic", -9000, 0, 1, false, false),
            new TVEPropertyData("_TerrainOcclusionValue", "Terrain Occlusion", -9000, 0, 1, false, false),
            new TVEPropertyData("_TerrainSmoothnessValue", "Terrain Smoothness", -9000, 0, 1, false, false),

            new TVEPropertyData("_TerrainSampleMode1", "Terrain 01 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", true),
            new TVEPropertyData("_TerrainSampleMode2", "Terrain 02 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode3", "Terrain 03 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode4", "Terrain 04 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode5", "Terrain 05 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode6", "Terrain 06 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode7", "Terrain 07 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode8", "Terrain 08 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode9", "Terrain 09 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode10", "Terrain 10 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode11", "Terrain 11 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode12", "Terrain 12 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode13", "Terrain 13 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode14", "Terrain 14 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode15", "Terrain 15 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),
            new TVEPropertyData("_TerrainSampleMode16", "Terrain 16 Sampling", -9000, "Planar 1 Triplanar 2 Stochastic 3 Stochastic_Triplanar 4", false),

            new TVEPropertyData("_TerrainMaskTex", "Terrain Mask", null, true),

            new TVEPropertyData("_TerrainMaskSampleMode", "Mask Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3", true),
            new TVEPropertyData("_TerrainMaskCoordMode", "Mask UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_TerrainMaskCoordValue", "Mask UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_TerrainMaskValue", "Terrain TexR Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_TerrainMaskRemap", "Terrain TexR Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_TerrainBaseValue", "Terrain Base Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_TerrainBaseRemap", "Terrain Base Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_TerrainMeshValue", "Terrain Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_TerrainMeshMode", "Terrain Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_TerrainMeshRemap", "Terrain Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_TerrainProjValue", "Terrain ProjY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_TerrainProjRemap", "Terrain ProjY Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_TerrainFormValue", "Terrain Form Mask", -9000, 0, 16, false, false),
            new TVEPropertyData("_TerrainFormMath", "Terrain Form Mask", -9000, "Multiply 0 Additive 1 Multiply_And_Additive 2", false),
            new TVEPropertyData("_TerrainBlendMath", "Terrain Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_TerrainBlendRemap", "Terrain Blend Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
        };

        List<TVEPropertyData> coloringDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalDrawLayerValue", "Global Form Layer", -9000, "Land Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalDrawPivotValue", "Global Form Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> coloringData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_ColormapCategory", "Colormap Settings", "Use the Colormap feature to color the objects using Draw elements. The most common usage is to blend grass models with terrains."),

            new TVEPropertyData("_ColormapIntensityValue", "Colormap Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_ColormapGrayValue", "Colormap Gray", -9000, 0, 1, false, false),
            new TVEPropertyData("_ColormapColor", "Colormap Color", new Color(-9000, 0,0,0), true, false),

            new TVEPropertyData("_ColormapMeshValue", "Colormap Mesh Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_ColormapMeshMode", "Colormap Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_ColormapMeshRemap", "Colormap Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_OcclusionCategory", "Occlusion Settings", "Use the Occlusion feature to blend two colors based on the selected vertex color. The most common usage is to darken the base of grass models or the inside part of tree canopies.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA."),

            new TVEPropertyData("_OcclusionIntensityValue", "Occlusion Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_OcclusionBakeMode", "Occlusion Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_OcclusionColorOne", "Occlusion Color A", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_OcclusionColorTwo", "Occlusion Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_OcclusionColorMeshMode", "Occlusion Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_OcclusionColorMeshRemap", "Occlusion Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_DualColorCategory", "Dual Color Settings", ""),

            new TVEPropertyData("_DualColorIntensityValue", "Dual Color Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_DualColorBakeMode", "Dual Color Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_DualColorGrayValue", "Dual Color Gray", -9000, 0, 1, false, false),
            new TVEPropertyData("_DualColorOne", "Dual Color A", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_DualColorTwo", "Dual Color B", new Color(-9000, 0,0,0), true, false),

            new TVEPropertyData("_GradientCategory", "Gradient Settings", "Use the Gradient feature to blend two colors based on the selected vertex color. The most common usage is to add a top down gradient based on Vertex A.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA."),

            new TVEPropertyData("_GradientIntensityValue", "Gradient Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_GradientBakeMode", "Gradient Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_GradientGrayValue", "Gradient Gray", -9000, 0, 1, false, false),
            new TVEPropertyData("_GradientColorOne", "Gradient Color A", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_GradientColorTwo", "Gradient Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_GradientColorMeshMode", "Gradient Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_GradientColorMeshRemap", "Gradient Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_GradientMultiValue", "Gradient Multi Mask", -9000, 0, 1, false, true),

            new TVEPropertyData("_VariationCategory", "Variation Settings", "Use the Variation feature to blend two colors based on a 3D noise texture."),

            new TVEPropertyData("_VariationIntensityValue", "Variation Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_VariationGrayValue", "Variation Gray", -9000, 0, 1, false, false),
            new TVEPropertyData("_VariationColorOne", "Variation Color A", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_VariationColorTwo", "Variation Color B", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_VariationColorNoiseRemap", "Variation Noise Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_VariationColorNoiseTillingValue", "Variation Noise Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_VariationColorNoisePivotValue", "Variation Noise Pivots", -9000, 0, 1, false, false),

            new TVEPropertyData("_VariationMultiValue", "Variation Multi Mask", -9000, 0, 1, false, true),

        };

        List<TVEPropertyData> seasonsDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", ""),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),
            
            new TVEPropertyData("_GlobalPaintLayerValue", "Global Paint Layer", -9000, "Paint Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalAtmoLayerValue", "Global Atmo Layer", -9000, "Atmo Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalEffexLayerValue", "Global Effex Layer", -9000, "Effex Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalPaintPivotValue", "Global Paint Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalAtmoPivotValue", "Global Atmo Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_GlobalEffexPivotValue", "Global Effex Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> seasonsData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_TintingCategory", "Tinting Settings", "Use the Tinting feature to color the objects using Paint elements. The most common usage is to create season coloring.NEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXC"), 

            new TVEPropertyData("_TintingIntensityValue", "Tinting Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_TintingBakeMode", "Tinting Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_TintingGrayValue", "Tinting Gray", -9000, 0, 1, false, false),
            new TVEPropertyData("_TintingColor", "Tinting Color", new Color(-9000, 0,0,0), true, false),

            new TVEPropertyData("_TintingPaintValue", "Tinting Paint Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_TintingPaintMode", "Tinting Paint Mask", -9000, "Global_Data_Only 0 Use_Paint_Elements 1", false),
            new TVEPropertyData("_TintingMultiValue", "Tinting Multi Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_TintingLumaValue", "Tinting Luma Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_TintingLumaRemap", "Tinting Luma Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_TintingMeshValue", "Tinting Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_TintingMeshMode", "Tinting Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_TintingMeshRemap", "Tinting Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_TintingNoiseRemap", "Tinting Noise Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_TintingNoiseTillingValue", "Tinting Noise Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_TintingBlendMath", "Tinting Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_TintingBlendRemap", "Tinting Blend Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_CutoutCategory", "Cutout Settings", "Use the Cutout feature to cut the alpha of the objects or terrains. The most common usage is to create seasons__ fade out objects__ or cut dynamic holes on terrains OPAvisual onlyCPA."),

            new TVEPropertyData("_CutoutIntensityValue", "Cutout Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_CutoutShadowMode", "Cutout Shadow", -9000, "Off 0 Affect_Shadow_Pass 1", false),
            new TVEPropertyData("_CutoutAlphaValue", "Cutout Alpha Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_CutoutMeshValue", "Cutout Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_CutoutMeshMode", "Cutout Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_CutoutMeshRemap", "Cutout Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_CutoutNoiseValue", "Cutout Noise Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_CutoutNoiseTillingValue", "Cutout Noise Tilling", -9000, 0, 100, false, false),

            new TVEPropertyData("_CutoutEffexValue", "Cutout Effex Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_CutoutEffexMode", "Cutout Effex Mask", -9000, "Global_Data_Only 0 Use_Effex_Elements 1", false),
            new TVEPropertyData("_CutoutMultiValue", "Cutout Multi Mask", -9000, 0, 1, false, false),

            new TVEPropertyData("_DrynessCategory", "Dryness Settings", "Use the Dryness feature to create automn scenaries. The main advantage of using the feature is local control over coloring__ smoothness and subsurface effects. Please note__ when using Dryness__ Overlay and Wetness with elements__ the same global textures are used__ making the rendering more optimized compared to using Tinting for seasonsEXCNEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXC"),

            new TVEPropertyData("_DrynessIntensityValue", "Dryness Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_DrynessBakeMode", "Dryness Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_DrynessGrayValue", "Dryness Gray", -9000, 0, 1, false, false),
            new TVEPropertyData("_DrynessShiftValue", "Dryness Shift", -9000, 0, 1, false, false),
            new TVEPropertyData("_DrynessColor", "Dryness Color", new Color(-9000, 0,0,0), true, false),

            new TVEPropertyData("_DrynessAtmoValue", "Dryness Atmo Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_DrynessAtmoMode", "Dryness Atmo Mask", -9000, "Global_Data_Only 0 Use_Atmo_Elements 1", false),
            new TVEPropertyData("_DrynessMultiValue", "Dryness Multi Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_DrynessLumaValue", "Dryness Luma Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_DrynessLumaRemap", "Dryness Luma Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_DrynessMeshValue", "Dryness Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_DrynessMeshMode", "Dryness Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_DrynessMeshRemap", "Dryness Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_DrynessNoiseRemap", "Dryness Noise Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_DrynessNoiseTillingValue", "Dryness Noise Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_DrynessBlendMath", "Dryness Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_DrynessBlendRemap", "Dryness Blend Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_OverlayCategory", "Overlay Settings", "Use the Overlay feature add snow for seasons or sand for desert scenaries with Glitter support.NEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXC"),

            new TVEPropertyData("_OverlayIntensityValue", "Overlay Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayBakeMode", "Overlay Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_OverlayTextureMode", "Overlay Maps", -9000, "Off 0 On 1", false),

            new TVEPropertyData("_OverlayAlbedoTex", "Overlay Albedo", null, true),
            new TVEPropertyData("_OverlayNormalTex", "Overlay Normal", null, false),

            new TVEPropertyData("_OverlaySampleMode", "Overlay Sampling", -9000, "Planar 0 Triplanar 1 Stochastic 2 Stochastic_Triplanar 3", true),
            new TVEPropertyData("_OverlayCoordMode", "Overlay UV Mode", -9000, "Tilling_and_Offset 0 Scale_and_Offset 1", false),
            new TVEPropertyData("_OverlayCoordValue", "Overlay UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_OverlayColor", "Overlay Color", new Color(-9000, 0,0,0), true, true),
            new TVEPropertyData("_OverlayNormalValue", "Overlay Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_OverlaySubsurfaceValue", "Overlay Subsurface", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlaySmoothnessValue", "Overlay Smoothness", -9000, 0, 1, false, false),

            new TVEPropertyData("_OverlayGlitterTexRT", "Overlay Glitter RT", null, true),

            new TVEPropertyData("_OverlayGlitterIntensityValue", "Overlay Glitter Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_OverlayGlitterColor", "Overlay Glitter Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_OverlayGlitterTillingValue", "Overlay Glitter Tilling", -9000, 0, 10, false, false),
            new TVEPropertyData("_OverlayGlitterDistValue", "Overlay Glitter Limit", -9000, 0, 200, false, false),
            new TVEPropertyData("_OverlayGlitterAttenValue", "Overlay Glitter Atten Mask", -9000, 0, 1, false, false),

            new TVEPropertyData("_OverlayMaskTex", "Overlay Mask", null, true),

            new TVEPropertyData("_OverlayMaskSampleMode", "Mask Sampling", -9000, "Main_UV 0 Extra_UV", true),
            new TVEPropertyData("_OverlayMaskCoordMode", "Mask UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_OverlayMaskCoordValue", "Mask UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_OverlayAtmoValue", "Overlay Atmo Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_OverlayAtmoMode", "Overlay Atmo Mask", -9000, "Global_Data_Only 0 Use_Atmo_Elements 1", false),
            new TVEPropertyData("_OverlayMaskValue", "Overlay TexB Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayMaskRemap", "Overlay TexB Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_OverlayLumaValue", "Overlay Luma Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayLumaRemap", "Overlay Luma Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_OverlayBaseValue", "Overlay Base Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayBaseRemap", "Overlay Base Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_OverlayProjValue", "Overlay ProjY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayProjRemap", "Overlay ProjY Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_OverlayMeshValue", "Overlay Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayMeshMode", "Overlay Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_OverlayMeshRemap", "Overlay Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_OverlayPosValue", "Overlay PosY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_OverlayPosMinValue", "Overlay PosY Start", 0, false),
            new TVEPropertyData("_OverlayPosMaxValue", "Overlay PosY Limit", 0, false),
            new TVEPropertyData("_OverlayFormValue", "Overlay Form Mask", -9000, 0, 16, false, false),
            new TVEPropertyData("_OverlayFormMath", "Overlay Form Mask", -9000, "Multiply 0 Additive 1 Multiply_And_Additive 2", false),
            new TVEPropertyData("_OverlayNoiseRemap", "Overlay Noise Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),
            new TVEPropertyData("_OverlayNoiseTillingValue", "Overlay Noise Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_OverlayBlendMath", "Overlay Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_OverlayBlendRemap", "Overlay Blend Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_WetnessCategory", "Wetness Settings", "Use the Wetnees feature to add simple wetness__ puddles and rainfall effects to the objects. Please note__ the Puddle feature is using the combined Base Mask OPAheight maskCPA from the previous passes stored in the Shader textures blue channelEXC"),

            new TVEPropertyData("_WetnessIntensityValue", "Wetness Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessBakeMode", "Wetness Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),
            new TVEPropertyData("_WetnessContrastValue", "Wetness Contrast", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessSmoothnessValue", "Wetness Smoothness", -9000, 0, 1, false, false),

            new TVEPropertyData("_WetnessWaterIntensityValue", "Wetness Puddle Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_WetnessWaterColor", "Wetness Puddle Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_WetnessWaterSmoothnessValue", "Wetness Puddle Smoothness", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessWaterBaseValue", "Wetness Puddle Base Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessWaterMeshValue", "Wetness Puddle Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessWaterMeshMode", "Wetness Puddle Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_WetnessWaterMeshRemap", "Wetness Puddle Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_WetnessWaterBlendRemap", "Wetness Puddle Blend Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_WetnessRainIntensityValue", "Wetness Rainfall Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_WetnessRainDistValue", "Wetness Rainfall Limit", -9000, 0, 200, false, false),
            new TVEPropertyData("_WetnessRainMeshValue", "Wetness Rainfall Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessRainMeshMode", "Wetness Rainfall Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_WetnessRainMeshRemap", "Wetness Rainfall Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_WetnessDropsTexRT", "Wetness Drops RT", null, true),

            new TVEPropertyData("_WetnessDropsIntensityValue", "Wetness Drops Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_WetnessDropsNormalValue", "Wetness Drops Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_WetnessDropsTillingValue", "Wetness Drops Tilling", -9000, 0, 10, false, false),

            new TVEPropertyData("_WetnessDripsTexRT", "Wetness Sides RT", null, true),

            new TVEPropertyData("_WetnessDripsIntensityValue", "Wetness Sides Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_WetnessDripsNormalValue", "Wetness Sides Normal", -9000, -8, 8, false, false),
            new TVEPropertyData("_WetnessDripsTillingValue", "Wetness Sides Tilling", -9000, 0, 10, false, false),

            new TVEPropertyData("_WetnessAtmoValue", "Wetness Atmo Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_WetnessAtmoMode", "Wetness Atmo Mask", -9000, "Global_Data_Only 0 Use_Atmo_Elements 1", false),
            new TVEPropertyData("_WetnessMeshValue", "Wetness Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessMeshMode", "Wetness Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_WetnessMeshRemap", "Wetness Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_WetnessPosValue", "Wetness PosY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_WetnessPosMinValue", "Wetness PosY Start", 0, false),
            new TVEPropertyData("_WetnessPosMaxValue", "Wetness PosY Limit", 0, false),
            new TVEPropertyData("_WetnessFormValue", "Wetness Form Mask", -9000, 0, 16, false, false),
            new TVEPropertyData("_WetnessFormMath", "Wetness Form Mask", -9000, "Multiply 0 Additive 1 Multiply_And_Additive 2", false),
        };

        List<TVEPropertyData> ditheringData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_DitherCategory", "Dithering Settings", "Use the Dithering feature to fade out parts of the objects based on a dithering pattern.NEWNEWUse the Distance feature to gradually fade objects out based on distance. This feature is best used with LODGroups to prevent the objects from popping then culled.NEWNEWUse the Proximity feature to fade out the objects when the camera is clipping through the geometry.NEWNEWUse the Glancing feature to fade out quads that are parallel to the camera view. Usually used for stylized assets for a QUOfluffyQUO visual style.NEWNEWUse the To Player feature to fade out the objects when the player is occluded by them. Please note__ the player position is set on the ManagerEXC"),

            new TVEPropertyData("_DitherIntensityValue", "Dithering Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_DitherShadowMode", "Dithering Shadow", -9000, "Off 0 Affect_Shadow_Pass 1", false),
            new TVEPropertyData("_DitherNoiseMode", "Dithering Noise Mode", -9000, "Bayer_4x4 0 Optimal_3D 1", false),
            new TVEPropertyData("_DitherNoiseTillingValue", "Dithering Noise Tilling", -9000, 0, 100, false, false),

            new TVEPropertyData("_DitherConstantValue", "Dithering Constant", -9000, 0, 1, false, true),
            new TVEPropertyData("_DitherConstantMaskValue", "Dithering Constant Mask", -9000, 0, 1, false, false),

            new TVEPropertyData("_DitherDistanceValue", "Dithering Distance", -9000, 0, 1, false, true),
            new TVEPropertyData("_DitherDistanceMinValue", "Dithering Distance Start", -9000, 0, 2000, false, false),
            new TVEPropertyData("_DitherDistanceMaxValue", "Dithering Distance Limit", -9000, 0, 2000, false, false),

            new TVEPropertyData("_DitherProximityValue", "Dithering Proximity", -9000, 0, 1, false, true),
            new TVEPropertyData("_DitherProximityMinValue", "Dithering Proximity Start", -9000, 0, 100, false, false),
            new TVEPropertyData("_DitherProximityMaxValue", "Dithering Proximity Limit", -9000, 0, 100, false, false),

            new TVEPropertyData("_DitherGlancingValue", "Dithering Glancing", -9000, 0, 1, false, true),
            new TVEPropertyData("_DitherGlancingAngleValue", "Dithering Glancing Angle", -9000, 0, 8, false, false),

            new TVEPropertyData("_DitherToPlayerValue", "Dithering To Player", -9000, 0, 1, false, true),
            new TVEPropertyData("_DitherToPlayerRadiusValue", "Dithering To Player Radius", -9000, 0, 8, false, false),

            new TVEPropertyData("_DitherMultiValue", "Dithering Multi Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_DitherMeshValue", "Dithering Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_DitherMeshMode", "Dithering Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_DitherMeshRemap", "Dithering Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
        };

        List<TVEPropertyData> glowingDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalGlowLayerValue", "Global Glow Layer", -9000, "Atmo Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalGlowPivotValue", "Global Glow Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> glowingData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_RimLightCategory", "Rim Light Settings", "Use the Rim Light feature to create a QUOhaloQUO effect based on the view direction and the world normals."),

            new TVEPropertyData("_RimLightIntensityValue", "Rim Light Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_RimLighColor", "Rim Light Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_RimLighRemap", "Rim Light Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_EmissiveCategory", "Emissive Settings", "Use the Emissive feature to add glow to the objects. The effect works best when using Bloom and HDR rendering.NEWNEWUse the Blend Mask options to change the way the feature masks are used. The Multiply OPAlegacyCPA mode is multipling all masks together and it is kept for backwards compatiblity. The Buildup OPArecommendedCPA mode is using the Intensity and Global values to build up the effect resulting in a better overall transitionEXC"),

            new TVEPropertyData("_EmissiveIntensityValue", "Emissive Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_EmissiveFlagMode", "Emissive GI Mode", -9000, "None 0 Any 1 Baked 2 Realtime 3", false),
            new TVEPropertyData("_EmissiveColorMode", "Emissive Color", -9000, "Constant 0 Multiply_With_Base_Albedo 1", false),
            new TVEPropertyData("_EmissiveColor", "Emissive Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_EmissivePowerMode", "Emissive Value", -9000, "Nits 0 EV100 1", false),
            new TVEPropertyData("_EmissivePowerValue", "Emissive Value", -9000, false, false),
            new TVEPropertyData("_EmissiveExposureValue", "Emissive Weight", -9000, 0, 1, false, false),

            new TVEPropertyData("_EmissiveMaskTex", "Emissive Mask", null, true),

            new TVEPropertyData("_EmissiveSampleMode", "Emissive Sampling", -9000, "Main_UV 0 Extra_UV 1 Planar 2 Triplanar 3", true),
            new TVEPropertyData("_EmissiveCoordMode", "Emissive UV Mode", -9000, "Tilling_And_Offset 0 Scale_And_Offset 1", false),
            new TVEPropertyData("_EmissiveCoordValue", "Emissive UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_EmissiveGlowValue", "Emissive Glow Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_EmissiveGlowMode", "Emissive Glow Mask", -9000, "Global_Data_Only 0 Use_Glow_Elements 1", false),
            new TVEPropertyData("_EmissiveMaskValue", "Emissive TexR Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_EmissiveMaskRemap", "Emissive TexR Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_EmissiveMeshValue", "Emissive Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_EmissiveMeshMode", "Emissive Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_EmissiveMeshRemap", "Emissive Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_EmissiveBlendMath", "Emissive Blend Mask", -9000, "Multiply 0 Buildup 1", false),
            new TVEPropertyData("_EmissiveBlendRemap", "Emissive Blend Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_SubsurfaceCategory", "Subsurface Settings", "Use the Subsurface feature to add subsurface scattering OPAtransmissionCPA to the objects. Please note__ the effect is using different rendering methods based on the render pipelineCOLNEWNEWIn BIRP and URP__ the shader uses the Transluceny effect developed by Amplify.NEWNEWIn HDRP__ the shader uses Diffusion Profiles with the cheaper Transmissin effect better suited for foliage rendering OPAno blurring based on object depthCPA.NEWNEWWhen using Standard Lit shaders__ the effect is an approximation designed to work with Deferred rendering pathEXC"),

            new TVEPropertyData("_SubsurfaceAproxInfo", "When using Standard Lit shaders, the Subsurface feature is an approximation effect designed to work in deferred rendering path.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_SubsurfaceIntensityValue", "Subsurface Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_SubsurfaceColor", "Subsurface Color", new Color(-9000, 0,0,0), true, false),
            new TVEPropertyData("_SubsurfaceScatteringValue", "Subsurface Value", -9000, 0, 16, false, false),
            new TVEPropertyData("_SubsurfaceAngleValue", "Subsurface Angle", -9000, 1, 16, false, false),
            new TVEPropertyData("_SubsurfaceNormalValue", "Subsurface Normal", -9000, 0, 1, false, false),
            new TVEPropertyData("_SubsurfaceDirectValue", "Subsurface Direct", -9000, 0, 1, false, false),
            new TVEPropertyData("_SubsurfaceAmbientValue", "Subsurface Ambient", -9000, 0, 1, false, false),
            new TVEPropertyData("_SubsurfaceShadowValue", "Subsurface Shadow", -9000, 0, 1, false, false),
            new TVEPropertyData("_SubsurfaceThicknessValue", "Subsurface Thickness", -9000, 0, 16, false, false),

            new TVEPropertyData("_SubsurfaceMultiValue", "Subsurface Multi Mask", -9000, 0, 1, false, true),
        };

        List<TVEPropertyData> transformDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalFormLayerValue", "Global Form Layer", -9000, "Form Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalFormPivotValue", "Global Form Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> transformData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_PerspectiveCategory", "Perspective Settings", "Use the Perspective feature to QUOhideQUO the mesh quads when grass models are viewed from the top. The effect will adapt to the camera projectionCOLNEWNEWWhen Perspective camera is used__ the vertices are pushed to the edges of the screen.NEWNEWWhen Orthographic camera is used__ the vertices are pushed forward based on the camera view."),

            new TVEPropertyData("_PerspectiveIntensityValue", "Perspective Intensity", -9000, 0, 10, false, false),
            new TVEPropertyData("_PerspectivePhaseValue", "Perspective Phase", -9000, 0, 1, false, false),
            new TVEPropertyData("_PerspectiveAngleValue", "Perspective Angle", -9000, 0, 8, false, false),

            new TVEPropertyData("_ConformCategory", "Conform Settings", "Use the Conform feature to project the vertices to the terrain or mesh surfaces__ similar to how decals work__ but for 3D objects. The most common usage is with big patches of grass__ groups of rocks or QUOplanarQUO ground covers which would not work properly on curved surfaces. Please note__ the projection only works from top down view and the effect it is only visual OPAcollider is not affectedCPAEXC"),

            new TVEPropertyData("_ConformInfo", "The Conform features require elements to work. Use Form Surface or Form Height elements for conforming the objects to terrain surfaces. Please note, the conform effect is only visual and it does not affect the object collider and bounds.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_ConformIntensityValue", "Conform Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_ConformMode", "Conform Mode", -9000, "NULL", "Freeform_Object_Position 0 Lock_Position_With_Conform 1", false),
            new TVEPropertyData("_ConformOffsetValue", "Conform Offset", -9000, false, false),

            new TVEPropertyData("_ConformMeshValue", "Conform Mesh Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_ConformMeshMode", "Conform Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_ConformMeshRemap", "Conform Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_RotationCategory", "Rotation Settings", "Use the Rotation feature to aligning the objects to the terrain or mesh surfaces."),

            new TVEPropertyData("_RotationInfo", "The Rotation features require elements to work. Use Form Surface or Form Normal elements for aligning the objects to terrain surfaces.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_RotationIntensityValue", "Rotation Intensity", -9000, 0, 1, false, false),

            new TVEPropertyData("_SizeFadeCategory", "Size Fade Settings", "Use the Size Fade feature to fade out the size of the objects. The most common usage is to fade out grass on winter__ fade out grass based on distance or hide objects when placing building. Please note__ setting the size to zero might cut the perMINpixel rendering cost but it is best to not render the object at allEXC"),

            new TVEPropertyData("_SizeFadeIntensityValue", "Size Fade Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_SizeFadeScaleMode", "Size Fade Mode", -9000, "NULL", "All_Axis 0 Up_Axis 1", false),
            new TVEPropertyData("_SizeFadeScaleValue", "Size Fade Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_SizeFadeDistMinValue", "Size Fade Start", -9000, 0, 2000, false, false),
            new TVEPropertyData("_SizeFadeDistMaxValue", "Size Fade Limit", -9000, 0, 2000, false, false),

            new TVEPropertyData("_SizeFadeVertxValue", "Size Fade Vertx Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_SizeFadeVertxMode", "Size Fade Vertx Mask", -9000, "Global_Data_Only 0 Use_Vertx_Elements 1", false),
        };

        List<TVEPropertyData> motionDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalFlowLayerValue", "Global Flow Layer", -9000, "Flow Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalFlowPivotValue", "Global Flow Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> motionData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_MotionCategory", "Motion Settings", "Use the Motion feature to add wind animation and interaction to foliage. The shaders support 3 layers of animation driven by vertex colors__ procedural masks or texture masksCOLNEWNEWUse the Primary Motion to add bending animation. The bending can work per instance for plants and trees or per baked pivots for grass so each blade is bending individually.NEWNEWUse the Second Motion to push the vertices in the wind direction. Perfect for tree cannopies__ palm or willow tree leaves.NEWNEWUse the Leaves Motion to add flutter to the leaves or leaf edges.NEWNEWUse the Ripples Motion to add a visual effect for the flowing wind texture.NEWNEWAll layers use flow maps for the wind animation. Use the Noise sliders to control how turbulent the motion is at high wind. Use the Pivots slider to control if the the flow map is sampled in world space or per pivotSLHpivots. Use the Phase slider to offset the animation based on the baked Object Phase Mode option. Use the Tiling and Speed values to control the overall flow map animation.NEWNEWUse the Details Limit value to fade out the flutter and ripples at high distances to avoid visual noise."),

            new TVEPropertyData("_MotionFlowInfo", "The Interaction features require elements to work. Use Flow elements to add interaction and use the Interaction sliders to control the intensity per motion layer.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_MotionNoiseTex", "Motion Noise", null, false),
            new TVEPropertyData("_MotionMaskTex", "Motion Masks", null, false),

            new TVEPropertyData("_MotionIntensityValue", "Motion Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_MotionWindMode", "Motion Wind Mode", -9000, "Local 0 Global 1", false),
            new TVEPropertyData("_MotionDistValue", "Motion Details Limit", -9000, 0, 2000, false, false),

            new TVEPropertyData("_MotionBaseIntensityValue", "Motion Primary Intensity", -9000, 0, 10, false, true),
            new TVEPropertyData("_MotionBaseDelayValue", "Motion Primary Delay", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionBaseNoiseValue", "Motion Primary Noise", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionBasePivotValue", "Motion Primary Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionBasePhaseValue", "Motion Primary Phase", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionBaseTillingValue", "Motion Primary Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_MotionBaseSpeedValue", "Motion Primary Speed", -9000, 0, 50, false, false),
            new TVEPropertyData("_MotionBasePushValue", "Motion Primary Interaction", -9000, 0, 10, false, false),
            new TVEPropertyData("_MotionBaseMaskMode", "Motion Primary Anim Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Height 4 Capsule 5 Masks_R 6", false),
            new TVEPropertyData("_MotionBaseMaskRemap", "Motion Primary Anim Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_MotionSmallIntensityValue", "Motion Second Intensity", -9000, 0, 10, false, true),
            new TVEPropertyData("_MotionSmallDelayValue", "Motion Second Delay", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionSmallNoiseValue", "Motion Second Noise", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionSmallPivotValue", "Motion Second Pivots", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionSmallPhaseValue", "Motion Second Phase", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionSmallTillingValue", "Motion Second Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_MotionSmallSpeedValue", "Motion Second Speed", -9000, 0, 50, false, false),
            new TVEPropertyData("_MotionSmallPushValue", "Motion Second Interaction", -9000, 0, 10, false, false),
            new TVEPropertyData("_MotionSmallMaskMode", "Motion Second Anim Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Height 4 Capsule 5 Masks_G 6", false),
            new TVEPropertyData("_MotionSmallMaskRemap", "Motion Second Anim Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_MotionTinyIntensityValue", "Motion Leaves Intensity", -9000, 0, 10, false, true),
            new TVEPropertyData("_MotionTinyNoiseValue", "Motion Leaves Noise", -9000, 0, 1, false, false),
            new TVEPropertyData("_MotionTinyTillingValue", "Motion Leaves Tilling", -9000, 0, 100, false, false),
            new TVEPropertyData("_MotionTinySpeedValue", "Motion Leaves Speed", -9000, 0, 50, false, false),
            new TVEPropertyData("_MotionTinyMaskMode", "Motion Leaves Anim Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Height 4 Capsule 5 Masks_B 6", false),
            new TVEPropertyData("_MotionTinyMaskRemap", "Motion Leaves Anim Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_MotionHighlightValue", "Motion Ripples Intensity", -9000, 0, 1, false, true),
            new TVEPropertyData("_MotionHighlightColor", "Motion Ripples Color", new Color(-9000, 0,0,0), true, false),

            new TVEPropertyData("_MotionFlowValue", "Motion Flow Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_MotionFlowMode", "Motion Flow Mask", -9000, "Global_Wind_Only 0 Use_Flow_Elements 1", false),
        };

        List<TVEPropertyData> normalDataGlobal = new List<TVEPropertyData>
        {
            new TVEPropertyData("_GlobalCategory", "Global Settings", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available."),

            new TVEPropertyData("_GlobalPivotInfo", "Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_GlobalFormLayerValue", "Global Form Layer", -9000, "Form Layers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEPropertyData("_GlobalFormPivotValue", "Global Form Pivots", -9000, 0, 1, false, false),
        };

        List<TVEPropertyData> normalData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_FlattenCategory", "Flatten Settings", "Use the Flatten feature to flatten or spherify the vertex normals used for shading in the pixel stage. The most common usage is to give grass a more QUOlushQUO appearance or to spherify the shading for tree cannopies.NEWNEWUse the Baking option to preMINbake the shading to the impostor normal texture."),

            new TVEPropertyData("_FlattenIntensityValue", "Flatten Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_FlattenUpwardsValue", "Flatten Upwards", -9000, 0, 1, false, false),
            new TVEPropertyData("_FlattenSphereValue", "Flatten Spherical", -9000, 0, 1, false, false),
            new TVEPropertyData("_FlattenSphereOffsetValue", "Flatten Spherical Offset", new Vector4(-9000, 0,0,0), 3, false),
            new TVEPropertyData("_FlattenBakeMode", "Flatten Baking", -9000, "Off 0 Bake_Settings_To_Textures 1", false),

            new TVEPropertyData("_FlattenMeshValue", "Flatten Mesh Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_FlattenMeshMode", "Flatten Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_FlattenMeshRemap", "Flatten Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),

            new TVEPropertyData("_ReshadeCategory", "Reshade Settings", "Use the Reshade feature to reMINcalculate the vertex normals when Motion Primary Bending or Blanket Rotation features are used."),

            new TVEPropertyData("_ReshadeIntensityValue", "Reshade Intensity", -9000, 0, 1, false, false),

            new TVEPropertyData("_TransferCategory", "Transfer Settings", "Use the Transfer feature to send perMINvertex terrain normals to the material. The most common usage is to blend stylized grass with terrains. Works perfectly with the Colormap feature which gets the terrain albedo__ while the Transfer ensures the same shading is used on both the terrain and the grassEXC"),

            new TVEPropertyData("_TransferInfo", "The Transfer normal feature requires elements to work. Use Form Surface or Form Normal elements to send perMINvertex terrain normals to the material.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_TransferIntensityValue", "Transfer Intensity", -9000, 0, 1, false, false),

            new TVEPropertyData("_TransferMeshValue", "Transfer Mesh Mask", -9000, 0, 1, false, true),
            new TVEPropertyData("_TransferMeshMode", "Transfer Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_TransferMeshRemap", "ColoTransferrmap Mesh Mask", new Vector4(-9000, 0, 0, -9000), 0, 1, false),

            new TVEPropertyData("_CombineCategory", "Combine Settings", "Use the Combine feature to send perMINpixel terrain normals to the material. The most common usage is to blend objects with terrains. Works perfectly with the Terrain feature which gets the terrain layers while the Combine ensures the same shading is used on both the terrain and the object.NEWNEWUse the Form Mask to only transfer the terrain shading at the intsersection between the object with the terrain__ while keeping the rest of the object normal as is.NEWNEWUse the Triplanar slider to affect the world axis only at the terrain to object intsersection point. Higher values will break the triplanar mapping because the terrain normals are mostly pointing upEXC"),

            new TVEPropertyData("_CombineInfo", "The Combine normal feature requires elements to work. Use Form Surface or Form Normal elements to send perMINpixel terrain normals to the material.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_CombineIntensityValue", "Transfer Intensity", -9000, 0, 1, false, false),
            new TVEPropertyData("_CombineTriplanarFormValue", "Transfer Triplanar", -9000, 0, 1, false, false),

            new TVEPropertyData("_CombineSpace"),

            new TVEPropertyData("_CombineProjValue", "Transfer ProjY Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_CombineProjRemap", "Transfer ProjY Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_CombineMeshValue", "Transfer Mesh Mask", -9000, 0, 1, false, false),
            new TVEPropertyData("_CombineMeshMode", "Transfer Mesh Mask", -9000, "Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3", false),
            new TVEPropertyData("_CombineMeshRemap", "Transfer Mesh Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
            new TVEPropertyData("_CombineFormValue", "Transfer Form Mask", -9000, 0, 16, false, false),
            new TVEPropertyData("_CombineFormMath", "Transfer Form Mask", -9000, "Multiply 0 Additive 1 Multiply_And_Additive 2", false),
            new TVEPropertyData("_CombineBlendRemap", "Transfer Blend Mask", new Vector4(-9000, -9000, -9000, -9000), 0, 1, false),
        };

        List<TVEPropertyData> metaData = new List<TVEPropertyData>
        {
            new TVEPropertyData("_MetaCategory", "Meta Settings", ""),

            new TVEPropertyData("_MetaGeometryInfo", "The Meta settings are a low fidelity representation of the entire material shading used for HTrace voxelization when the object is not in view or occluded by other objects.", "", 0, 10, MessageType.Info),

            new TVEPropertyData("_MetaEnabledMode", "Meta Enabled", -9000, "Off 0 On 1", false),
            new TVEPropertyData("_MetaSurfaceMode", "Meta Surface", -9000, "Sync_With_Material 0 Override 1", false),

            new TVEPropertyData("_MetaAlbedoTex", "Meta Albedo", null, true),

            new TVEPropertyData("_MetaSampleMode", "Meta Sampling", -9000, "Main_UV 0 Lightmap_UV 1", true),
            new TVEPropertyData("_MetaCoordValue", "Main UV Value", new Vector4(-9000, 0,0,0), 4, false),

            new TVEPropertyData("_MetaAlbedoValue", "Meta Albedo Value", -9000, 0, 1, false, true),
            new TVEPropertyData("_MetaAlbedoColor", "Meta Albedo Color", new Color(-9000, 0,0,0), true, false),

            new TVEPropertyData("_MetaVariationValue", "Meta Variation Value", -9000, 0, 1, false, true),
            new TVEPropertyData("_MetaTintingValue", "Meta Tinting Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaCutoutValue", "Meta Cutout Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaDrynessValue", "Meta Dryness Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaOverlayValue", "Meta Overlay Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaWetnessValue", "Meta Wetness Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaDitherValue", "Meta Dithering Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaEmissiveValue", "Meta Emissive Value", -9000, 0, 1, false, false),
            new TVEPropertyData("_MetaSizeFadeValue", "Meta SizeFade Value", -9000, 0, 1, false, false),

            new TVEPropertyData("_MetaFinalIntensityValue", "Meta Final Intensity", -9000, 0, 10, false, true),
            new TVEPropertyData("_MetaFinalContrastValue", "Meta Final Contrast", -9000, 0, 1, false, false),
        };

        List<GameObject> selectedObjects = new List<GameObject>();
        List<Material> selectedMaterials = new List<Material>();

        List<string> presetLines;

        int presetIndex;
        int settingsIndex;
        int savingIndex = 1;
        string savePath = "";

        bool isValid = true;
        bool showSelection = true;
        bool refreshManager = false;

        bool useLine;
        List<bool> useLines;

        float motionControl = 0.5f;

        string userFolder = "Assets/BOXOPHOBIC+";

        string[] searchResult;

        GUIStyle styleLabel;
        GUIStyle stylePopup;
        GUIStyle stylePopupMini;
        GUIStyle styleCenteredHelpBox;

        Color bannerColor;
        string bannerLabel;
        string bannerVersion;
        static TVEMaterialManager window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Visual Engine/Material Manager", false, 2006)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEMaterialManager>(false, "Material Manager", true);
            window.minSize = new Vector2(400, 300);
        }

        void OnEnable()
        {
            Undo.undoRedoPerformed += OnUndoRedo;

            Undo.SetCurrentGroupName("TVE Material Manager");

            if (TVEManager.Instance == null)
            {
                isValid = false;
            }
            else
            {
                motionControl = TVEManager.Instance.motionControl;
            }

            Initialize();

            if (selectedMaterials.Count > 15)
            {
                showSelection = false;
            }

            userFolder = BoxoUtils.GetUserFolder();

            settingsIndex = SettingsUtils.LoadSettingsData(userFolder + "/User/The Visual Engine/Material Settings.asset", MOTION_INDEX);

            bannerColor = new Color(0.9f, 0.7f, 0.4f);
            bannerLabel = "Material Manager";
            bannerVersion = bannerVersion = TVEUtils.GetAssetVersionStr();
        }

        void OnSelectionChange()
        {
            Initialize();
            Repaint();
        }

        void OnFocus()
        {
            Initialize();
            Repaint();
        }

        void OnLostFocus()
        {
            ResetEditorWind();

            Shader.SetGlobalInt("TVE_ShowIcons", 0);
        }

        void OnDisable()
        {
            Undo.undoRedoPerformed -= OnUndoRedo;

            ResetEditorWind();

            Shader.SetGlobalInt("TVE_ShowIcons", 0);
        }

        void OnDestroy()
        {
            Undo.undoRedoPerformed -= OnUndoRedo;

            for (int i = 0; i < selectedMaterials.Count; i++)
            {
                Undo.ClearUndo(selectedMaterials[i]);
            }

            ResetEditorWind();

            Shader.SetGlobalInt("TVE_ShowIcons", 0);
        }

        void OnUndoRedo()
        {
            RefreshMaterialDataSet();
            Repaint();
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
            GUILayout.Space(10);
            GUILayout.BeginVertical();

            if (isValid && selectedMaterials.Count > 0)
            {
                EditorGUILayout.HelpBox("The Material Manager tool allows to set the same values to all selected material at once!", MessageType.Info, true);
            }
            else
            {
                if (TVEManager.Instance == null)
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
                else if (selectedMaterials.Count == 0)
                {
                    GUILayout.Button("\n<size=14>Select one or multiple gameobjects or materials to get started!</size>\n", styleCenteredHelpBox);
                }
            }

            if (isValid)
            {
                if (selectedMaterials.Count == 0)
                {
                    GUI.enabled = false;
                }

                //DrawWindPower();
                SetEditorWind();

                if (selectedMaterials.Count > 0)
                {
                    GUILayout.Space(5);
                }

                DrawMaterials();

                GUILayout.Space(10);

                DrawSettings();

                StyledGUI.DrawWindowBanner(materialOptions[settingsIndex]);

                TVEGlobals.searchManager = TVEUtils.DrawSearchField(TVEGlobals.searchManager, out searchResult, 6);

                GUILayout.Space(10);

                DrawCopySettingsFromObject();

                //if (settingsIndex == 0 || settingsIndex == 8)
                //{
                //    GUILayout.Space(15);
                //    StyledGUI.DrawWindowCategory("Motion Control");
                //    DrawWindPower();
                //}

                GUILayout.Space(7);

                Undo.RecordObjects(selectedMaterials.ToArray(), "Modify Material Data");

                DrawProperties();

                GUILayout.Space(20);

                DrawSaving();

                SetMaterialProperties();

                if (refreshManager)
                {
                    RefreshMaterialDataSet();

                    refreshManager = false;
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
                richText = true,
            };

            stylePopup = new GUIStyle(EditorStyles.popup)
            {
                alignment = TextAnchor.MiddleCenter
            };

            stylePopupMini = new GUIStyle(EditorStyles.popup)
            {
                fontSize = 9
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void DrawWindPower()
        {
            GUIStyle styleMid = new GUIStyle();
            styleMid.alignment = TextAnchor.MiddleCenter;
            styleMid.normal.textColor = Color.gray;
            styleMid.fontSize = 7;

            //EditorGUILayout.HelpBox("Always test the motion settings in various wind conditions!", MessageType.Info, true);

            //GUILayout.Space(10);

            GUILayout.BeginHorizontal();
            GUILayout.Space(8);
            motionControl = GUILayout.HorizontalSlider(motionControl, 0.0f, 1.0f);
            GUILayout.EndHorizontal();

            int maxWidth = 20;

            GUILayout.Space(15);

            GUILayout.BeginHorizontal();
            GUILayout.Space(8);
            GUILayout.Label("None", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Label("", styleMid);
            GUILayout.Space(4);
            GUILayout.Label("Windy", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Label("", styleMid);
            GUILayout.Label("Strong", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Space(5);
            GUILayout.EndHorizontal();

            GUILayout.Space(10);
        }

        void DrawMaterials()
        {
            if (selectedMaterials.Count > 0)
            {
                GUILayout.Space(10);
            }

            if (showSelection)
            {
                if (StyledButton("Hide Material Selection"))
                    showSelection = !showSelection;
            }
            else
            {
                if (StyledButton("Show Material Selection"))
                    showSelection = !showSelection;
            }
            if (showSelection)
            {
                for (int i = 0; i < selectedMaterials.Count; i++)
                {
                    if (selectedMaterials[i] != null)
                    {
                        StyledMaterial(selectedMaterials[i]);
                    }
                }
            }
        }

        void DrawSettings()
        {
            EditorGUI.BeginChangeCheck();

            presetIndex = StyledPopup("Material Preset", presetIndex, TVEGlobals.settingPresetsEnum);

            if (presetIndex > 0)
            {
                GetPresetLines();

                for (int i = 0; i < selectedMaterials.Count; i++)
                {
                    var material = selectedMaterials[i];

                    //if (material.GetTag("UseExternalSettings", false) == "False")
                    //{
                    //    continue;
                    //}

                    if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                    {
                        continue;
                    }

                    GetMaterialConversionFromPreset(material);
                    TVEUtils.SetMaterialSettings(material);
                }

                presetIndex = 0;

                Debug.Log("<b>[The Visual Engine]</b> " + "The selected preset has been applied!");
            }

            settingsIndex = StyledPopup("Material Settings", settingsIndex, materialOptions);

            if (EditorGUI.EndChangeCheck())
            {
                RefreshMaterialDataSet();

                SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Material Settings.asset", settingsIndex);
            }
        }

        void DrawProperties()
        {
            for (int i = 0; i < propertyDataSet.Count; i++)
            {
                var propertyData = propertyDataSet[i];

                if (propertyData.isVisible == 0)
                {
                    continue;
                }

                bool searchValid = false;

                foreach (var tag in searchResult)
                {
                    if (propertyData.prop.ToUpper().Contains(tag))
                    {
                        searchValid = true;
                        break;
                    }

                    if (propertyData.name.ToUpper().Contains(tag))
                    {
                        searchValid = true;
                        break;
                    }

                    if (propertyData.tag.ToUpper().Contains(tag))
                    {
                        searchValid = true;
                        break;
                    }
                }

                if (!searchValid)
                {
                    continue;
                }

                if (propertyData.space)
                {
                    GUILayout.Space(10);
                }

                if (settingsIndex == 0 || settingsIndex == MOTION_INDEX)
                {
                    if (propertyData.prop.Contains("_MotionFlowInfo"))
                    {
                        DrawWindPower();
                    }
                }

                if (propertyData.type == TVEPropertyData.TVEPropertyType.Value)
                {
                    propertyData.value = StyledValue(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Range)
                {
                    propertyData.value = StyledSlider(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Vector)
                {
                    propertyData.vector = StyledVector(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Remap)
                {
                    propertyData.vector = StyledRemap(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Color)
                {
                    propertyData.vector = StyledColor(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Enum)
                {
                    EditorGUI.BeginChangeCheck();

                    propertyData.value = StyledEnum(propertyData);

                    if (EditorGUI.EndChangeCheck())
                    {
                        refreshManager = true;
                    }
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Toggle)
                {
                    propertyData.value = StyledToggle(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Texture)
                {
                    propertyData.texture = StyledTexture(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Space)
                {
                    StyledSpace(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Category)
                {
                    StyledCategory(propertyData);
                }
                else if (propertyData.type == TVEPropertyData.TVEPropertyType.Message)
                {
                    StyledMessage(propertyData);
                }

                if (propertyData.snap)
                {
                    propertyData.value = Mathf.Round(propertyData.value);
                }
                else
                {
                    propertyData.value = Mathf.Round(propertyData.value * 1000f) / 1000f;
                }
            }
        }

        void StyledMaterial(Material material)
        {
            string color;
            bool useExternalSettings = true;

            if (EditorGUIUtility.isProSkin)
            {
                color = "<color=#87b8ff>";
            }
            else
            {
                color = "<color=#0b448b>";
            }

            if (material.GetTag("UseExternalSettings", false) == "False")
            {
                color = "<color=#808080>";
            }

            GUILayout.Label("<size=10><b>" + color + material.name.Replace(" (TVE Material)", "") + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            var lastRect = GUILayoutUtility.GetLastRect();

            var buttonRect = new Rect(lastRect.x, lastRect.y, lastRect.width - 20, lastRect.height);

            if (GUI.Button(buttonRect, "", GUIStyle.none))
            {
                EditorGUIUtility.PingObject(material);
            }

            var toogleRect = new Rect(lastRect.width - 5, lastRect.y + 6, 12, 12);

            //if (material.GetTag("UseExternalSettings", false) == "False")
            //{
            //    useExternalSettings = false;
            //}

            if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
            {
                useExternalSettings = false;
            }

            EditorGUI.BeginChangeCheck();

            useExternalSettings = EditorGUI.Toggle(toogleRect, useExternalSettings);
            GUI.Label(toogleRect, new GUIContent("", "Should the Prefab Settings tool affect the material?"));

            if (EditorGUI.EndChangeCheck())
            {
                if (useExternalSettings)
                {
                    material.SetInt("_UseExternalSettings", 1);
                }
                else
                {
                    material.SetInt("_UseExternalSettings", 0);
                }

                RefreshMaterialDataSet();
            }
        }

        int StyledPopup(string name, int index, string[] options)
        {
            if (index > options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            index = EditorGUILayout.Popup(index, options, stylePopup, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            GUILayout.EndHorizontal();

            return index;
        }

        void StyledLabel(TVEPropertyData propertyData)
        {
            GUI.color = new Color(1, 1, 1, 0.9f);

            string propertyName = propertyData.name;
            GUIContent propertyCtx = new GUIContent(propertyName, "");

            if (selectedMaterials.Count == 1)
            {
                if (propertyData.isLocked > 0)
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        propertyName = propertyData.name + "<size=10><color=#ffdb78> (Locked)</color></size>";
                    }
                    else
                    {
                        propertyName = propertyData.name + "<size=10> (Locked)</size>";
                    }

                    propertyCtx.text = propertyName;
                    propertyCtx.tooltip = "The current property is locked. You can unlock it on the material itself, by toggling the lock icon!";
                }
            }
            else
            {
                if (propertyData.isLocked > 0)
                {
                    if (selectedMaterials.Count == propertyData.isLocked)
                    {
                        if (EditorGUIUtility.isProSkin)
                        {
                            propertyName = propertyData.name + "<size=10><color=#ffdb78> (All Locked)</color></size>";
                        }
                        else
                        {
                            propertyName = propertyData.name + "<size=10> (All Locked)</size>";
                        }

                        propertyCtx.text = propertyName;
                        propertyCtx.tooltip = "The current property is locked on all selected materials. You can unlock it on the materials themselves, by toggling the lock icon!";
                    }
                    else
                    {
                        if (EditorGUIUtility.isProSkin)
                        {
                            propertyName = propertyData.name + "<size=10><color=#ffdb78> (" + propertyData.isLocked + "/"+ selectedMaterials.Count + " Locked)</color></size>";
                        }
                        else
                        {
                            propertyName = propertyData.name + "<size=10> (" + propertyData.isLocked + "/" + selectedMaterials.Count + " Locked)</size>";
                        }

                        propertyCtx.text = propertyName;
                        propertyCtx.tooltip = "The current property is locked on some materials. You can unlock it on the materials themselves, by toggling the lock icon!";
                    }
                }
            }

            GUILayout.Label(propertyCtx, styleLabel, GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 24));
            GUI.color = Color.white;
        }

        float StyledValue(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                EditorGUILayout.FloatField(0, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            }
            else
            {
                if (propertyData.value == -8000)
                {
                    EditorGUI.showMixedValue = true;
                    propertyData.isMixed = true;
                }

                propertyData.value = EditorGUILayout.FloatField(propertyData.value, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.value;
        }

        float StyledSlider(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                GUILayout.HorizontalSlider(propertyData.min, propertyData.min, propertyData.max, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 58));
                EditorGUILayout.FloatField(propertyData.min, GUILayout.MaxWidth(GUI_SMALL_WIDTH));
            }
            else
            {
                float equalValue = propertyData.value;
                float mixedValue = 0;

                if (propertyData.value == -8000)
                {
                    EditorGUI.showMixedValue = true;
                    propertyData.isMixed = true;

                    mixedValue = GUILayout.HorizontalSlider(mixedValue, propertyData.min, propertyData.max, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 58));

                    if (mixedValue != 0)
                    {
                        propertyData.value = mixedValue;
                    }

                    float floatVal = EditorGUILayout.FloatField(propertyData.value, GUILayout.MaxWidth(GUI_SMALL_WIDTH));

                    if (propertyData.value != floatVal)
                    {
                        propertyData.value = Mathf.Clamp(floatVal, propertyData.min, propertyData.max);
                    }
                }
                else
                {
                    equalValue = GUILayout.HorizontalSlider(equalValue, propertyData.min, propertyData.max, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 58));

                    propertyData.value = equalValue;

                    float floatVal = EditorGUILayout.FloatField(propertyData.value, GUILayout.MaxWidth(GUI_SMALL_WIDTH));

                    if (propertyData.value != floatVal)
                    {
                        propertyData.value = Mathf.Clamp(floatVal, propertyData.min, propertyData.max);
                    }
                }
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.value;
        }

        Vector4 StyledVector(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                if (propertyData.vectorCount == 4)
                {
                    EditorGUILayout.Vector4Field(new GUIContent(""), Vector4.zero, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                }
                else if (propertyData.vectorCount == 3)
                {
                    EditorGUILayout.Vector3Field(new GUIContent(""), Vector4.zero, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                }
                else if (propertyData.vectorCount == 2)
                {
                    EditorGUILayout.Vector4Field(new GUIContent(""), Vector4.zero, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                }

            }
            else
            {
                if (propertyData.vector.x == -8000 || propertyData.vector.w == -8000)
                {
                    EditorGUI.showMixedValue = true;
                    propertyData.isMixed = true;
                }

                if (propertyData.vectorCount == 4)
                {
                    propertyData.vector = EditorGUILayout.Vector4Field(new GUIContent(""), propertyData.vector, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                }
                else if (propertyData.vectorCount == 3)
                {
                    propertyData.vector = EditorGUILayout.Vector3Field(new GUIContent(""), propertyData.vector, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                }
                else if (propertyData.vectorCount == 2)
                {
                    propertyData.vector = EditorGUILayout.Vector2Field(new GUIContent(""), propertyData.vector, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));
                }
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.vector;
        }

        Vector4 StyledRemap(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            GUILayout.Space(2);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                float dummy = 0;

                GUILayout.BeginHorizontal();
                EditorGUILayout.MinMaxSlider(ref dummy, ref dummy, 0, 1, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 60));
                GUILayout.Space(2);
                EditorGUILayout.Popup(0, new string[] { "Remap", "Invert" }, stylePopupMini, GUILayout.Width(GUI_SMALL_WIDTH));
                GUILayout.EndHorizontal();
            }
            else
            {
                if (propertyData.vector.x == -8000 || propertyData.vector.w == -8000)
                {
                    EditorGUI.showMixedValue = true;
                    propertyData.isMixed = true;
                }

                float internalValueMin;
                float internalValueMax;

                if (propertyData.vector.w == 0)
                {
                    internalValueMin = propertyData.vector.x;
                    internalValueMax = propertyData.vector.y;
                }
                else
                {
                    internalValueMin = propertyData.vector.y;
                    internalValueMax = propertyData.vector.x;
                }

                GUILayout.BeginHorizontal();

                EditorGUI.BeginChangeCheck();

                EditorGUILayout.MinMaxSlider(ref internalValueMin, ref internalValueMax, propertyData.min, propertyData.max, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 60));

                GUILayout.Space(2);

                propertyData.vector.w = (float)EditorGUILayout.Popup((int)propertyData.vector.w, new string[] { "Remap", "Invert" }, stylePopupMini, GUILayout.Width(GUI_SMALL_WIDTH));

                if (EditorGUI.EndChangeCheck())
                {
                    EditorGUI.showMixedValue = false;
                }

                if (propertyData.vector.w == 0)
                {
                    propertyData.vector.x = internalValueMin;
                    propertyData.vector.y = internalValueMax;
                }
                else
                {
                    propertyData.vector.y = internalValueMin;
                    propertyData.vector.x = internalValueMax;
                }

                propertyData.vector.z = 1 / (propertyData.vector.y - propertyData.vector.x);

                GUILayout.EndHorizontal();
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.vector;
        }

        Color StyledColor(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                EditorGUILayout.ColorField(new GUIContent(""), Color.gray, true, true, propertyData.hdr, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 19));
            }
            else
            {
                if (propertyData.vector.x == -8000 || propertyData.vector.w == -8000)
                {
                    EditorGUI.showMixedValue = true;
                    propertyData.isMixed = true;
                }

                propertyData.vector = EditorGUILayout.ColorField(new GUIContent(""), propertyData.vector, true, true, propertyData.hdr, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 19));
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.vector;
        }

        Texture StyledTexture(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                propertyData.texture = (Texture)EditorGUILayout.ObjectField(propertyData.texture, typeof(Texture), false, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 6));
            }
            else
            {
                if (propertyData.isMixed)
                {
                    EditorGUI.showMixedValue = true;

                    EditorGUI.BeginChangeCheck();

                    propertyData.texture = (Texture)EditorGUILayout.ObjectField(propertyData.texture, typeof(Texture), false, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 6));

                    if (EditorGUI.EndChangeCheck())
                    {
                        propertyData.isMixed = false;
                        EditorGUI.showMixedValue = false;
                    }
                }
                else
                {
                    propertyData.texture = (Texture)EditorGUILayout.ObjectField(propertyData.texture, typeof(Texture), false, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 6));
                }
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.texture;
        }

        float StyledEnum(TVEPropertyData propertyData)
        {
            if (Resources.Load<TextAsset>(propertyData.file) != null)
            {
                var layersPath = AssetDatabase.GetAssetPath(Resources.Load<TextAsset>(propertyData.file));

                StreamReader reader = new StreamReader(layersPath);

                propertyData.options = reader.ReadLine();

                reader.Close();
            }

            string[] enumSplit = propertyData.options.Split(char.Parse(" "));
            List<string> enumOptions = new List<string>(enumSplit.Length / 2);
            List<int> enumIndices = new List<int>(enumSplit.Length / 2);

            for (int i = 0; i < enumSplit.Length; i++)
            {
                if (i % 2 == 0)
                {
                    enumOptions.Add(BoxoUtils.FormatEnum(enumSplit[i]));
                }
                else
                {
                    enumIndices.Add(int.Parse(enumSplit[i]));
                }
            }

            int index = (int)propertyData.value;
            int realIndex = enumIndices[0];

            for (int i = 0; i < enumIndices.Count; i++)
            {
                if (enumIndices[i] == index)
                {
                    realIndex = i;
                }
            }

            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;

                propertyData.value = EditorGUILayout.Popup(-8000, enumOptions.ToArray(), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
            }
            else
            {
                if (propertyData.value == -8000)
                {
                    EditorGUI.showMixedValue = true;
                    propertyData.isMixed = true;

                    propertyData.value = EditorGUILayout.Popup(-8000, enumOptions.ToArray(), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                }
                else
                {
                    propertyData.value = EditorGUILayout.Popup(realIndex, enumOptions.ToArray(), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                }
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.value;
        }

        float StyledToggle(TVEPropertyData propertyData)
        {
            GUILayout.BeginHorizontal();

            StyledLabel(propertyData);

            if (propertyData.isVisible == propertyData.isLocked)
            {
                GUI.enabled = false;
                EditorGUI.showMixedValue = true;
                propertyData.isMixed = true;

                EditorGUILayout.Toggle(false);
            }
            else
            {
                bool boolValue = false;

                if (propertyData.value > 0.5f)
                {
                    boolValue = true;
                }

                if (propertyData.value == -8000)
                {
                    EditorGUI.showMixedValue = true;

                    EditorGUI.BeginChangeCheck();

                    boolValue = EditorGUILayout.Toggle(boolValue);

                    if (EditorGUI.EndChangeCheck())
                    {
                        if (boolValue)
                        {
                            propertyData.value = 1;
                        }
                        else
                        {
                            propertyData.value = 0;
                        }
                    }

                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    boolValue = EditorGUILayout.Toggle(boolValue, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    if (boolValue)
                    {
                        propertyData.value = 1;
                    }
                    else
                    {
                        propertyData.value = 0;
                    }
                }
            }

            GUILayout.EndHorizontal();

            GUI.enabled = true;
            EditorGUI.showMixedValue = false;

            return propertyData.value;
        }

        void StyledSpace(TVEPropertyData propertyData)
        {
            GUILayout.Space(10);
        }

        void StyledCategory(TVEPropertyData propertyData)
        {
            GUILayout.Space(10);
            StyledGUI.DrawWindowCategory(propertyData.category, propertyData.infoText);
            GUILayout.Space(10);
        }

        void StyledMessage(TVEPropertyData propertyData)
        {
            GUILayout.Space(propertyData.spaceTop);

            if (propertyData.messageLong == "")
            {
                EditorGUILayout.HelpBox(propertyData.message, propertyData.messageType, true);
            }
            else
            {
                if (!propertyData.useMessageLong)
                {
                    EditorGUILayout.HelpBox(propertyData.message, propertyData.messageType, true);
                }
                else
                {
                    EditorGUILayout.HelpBox(propertyData.messageLong, propertyData.messageType, true);
                }

                var lastRect = GUILayoutUtility.GetLastRect();

                if (GUI.Button(lastRect, GUIContent.none, GUIStyle.none))
                {
                    propertyData.useMessageLong = !propertyData.useMessageLong;
                }
            }

            GUILayout.Space(propertyData.spaceDown);
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            return value;
        }

        void Initialize()
        {
            TVEUtils.GetSettingsPresetsEnum(true);

            //GetGlobalWind();

            GetSelectedObjects();
            GetPrefabMaterials();
            RefreshMaterialDataSet();
        }

        void GetSelectedObjects()
        {
            selectedObjects = new List<GameObject>();
            selectedMaterials = new List<Material>();

            for (int i = 0; i < Selection.objects.Length; i++)
            {
                var selection = Selection.objects[i];

                if (selection.GetType() == typeof(GameObject))
                {
                    selectedObjects.Add((GameObject)selection);
                }

                if (selection.GetType() == typeof(Material))
                {
                    selectedMaterials.Add((Material)selection);
                }
            }
        }

        void GetPrefabMaterials()
        {
            var gameObjects = new List<GameObject>();
            var meshRenderers = new List<MeshRenderer>();

            for (int i = 0; i < selectedObjects.Count; i++)
            {
                gameObjects.Add(selectedObjects[i]);
                TVEUtils.GetChildRecursive(selectedObjects[i], gameObjects);
            }

            for (int i = 0; i < gameObjects.Count; i++)
            {
                if (gameObjects[i].GetComponent<MeshRenderer>() != null)
                {
                    meshRenderers.Add(gameObjects[i].GetComponent<MeshRenderer>());
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
                            if (!selectedMaterials.Contains(material))
                            {
                                selectedMaterials.Add(material);
                            }
                        }
                    }
                }
            }
        }

        void RefreshMaterialDataSet()
        {
            for (int d = 0; d < propertyDataSet.Count; d++)
            {
                var propertyData = propertyDataSet[d];

                if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Display)
                {
                    propertyData.isMixed = false;
                    propertyData.value = -9000;
                    propertyData.isVisible = 0;
                    propertyData.isLocked = 0;
                }
                else if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Value)
                {
                    propertyData.isMixed = false;
                    propertyData.value = -9000;
                    propertyData.isVisible = 0;
                    propertyData.isLocked = 0;
                }
                else if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Vector)
                {
                    propertyData.isMixed = false;
                    propertyData.vector = new Vector4(-9000, -9000, -9000, -9000);
                    propertyData.isVisible = 0;
                    propertyData.isLocked = 0;
                }
                else if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Texture)
                {
                    propertyData.texture = null;
                    propertyData.isMixed = false;
                    propertyData.isVisible = 0;
                    propertyData.isLocked = 0;
                }
            }

            propertyDataSet = new List<TVEPropertyData>();

            if (settingsIndex == 0)
            {
                propertyDataSet.AddRange(renderData);
                propertyDataSet.AddRange(objectData);
                propertyDataSet.AddRange(globalData);
                propertyDataSet.AddRange(surfaceData);
                propertyDataSet.AddRange(terrainData);
                propertyDataSet.AddRange(coloringData);
                propertyDataSet.AddRange(seasonsData);
                propertyDataSet.AddRange(ditheringData);
                propertyDataSet.AddRange(glowingData);
                propertyDataSet.AddRange(transformData);
                propertyDataSet.AddRange(motionData);
                propertyDataSet.AddRange(normalData);
                propertyDataSet.AddRange(metaData);
            }
            else if (settingsIndex == 1)
            {
                propertyDataSet.AddRange(renderData);
            }
            else if (settingsIndex == 2)
            {
                propertyDataSet.AddRange(surfaceDataGlobal);
                propertyDataSet.AddRange(surfaceData);
            }
            else if (settingsIndex == 3)
            {
                propertyDataSet.AddRange(terrainDataGlobal);
                propertyDataSet.AddRange(terrainData);
            }
            else if (settingsIndex == 4)
            {
                propertyDataSet.AddRange(coloringDataGlobal);
                propertyDataSet.AddRange(coloringData);
            }
            else if (settingsIndex == 5)
            {
                propertyDataSet.AddRange(seasonsDataGlobal);
                propertyDataSet.AddRange(seasonsData);
            }
            else if (settingsIndex == 6)
            {
                propertyDataSet.AddRange(ditheringData);
            }
            else if (settingsIndex == 7)
            {
                propertyDataSet.AddRange(glowingDataGlobal);
                propertyDataSet.AddRange(glowingData);
            }
            else if (settingsIndex == 8)
            {
                propertyDataSet.AddRange(transformDataGlobal);
                propertyDataSet.AddRange(transformData);
            }
            else if (settingsIndex == 9)
            {
                propertyDataSet.AddRange(objectData);
                propertyDataSet.AddRange(motionDataGlobal);
                propertyDataSet.AddRange(motionData);
            }
            else if (settingsIndex == 10)
            {
                propertyDataSet.AddRange(normalDataGlobal);
                propertyDataSet.AddRange(normalData);
            }
            else if (settingsIndex == 11)
            {
                propertyDataSet.AddRange(metaData);
            }

            for (int i = 0; i < selectedMaterials.Count; i++)
            {
                var material = selectedMaterials[i];

                for (int d = 0; d < propertyDataSet.Count; d++)
                {
                    var propertyData = propertyDataSet[d];

                    //if (material.GetTag("UseExternalSettings", false) == "False")
                    //{
                    //    continue;
                    //}

                    if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                    {
                        continue;
                    }

                    if (material.HasProperty(propertyData.prop))
                    {
                        if (!TVEUtils.GetPropertyVisibility(material, propertyData.prop))
                        {
                            continue;
                        }
                    }
                    else
                    {
                        continue;
                    }

                    propertyData.isVisible++;

                    if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Display)
                    {
                        propertyData.value = 1;
                    }

                    if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Value)
                    {
#if UNITY_2022_1_OR_NEWER
                        if (material.IsPropertyLocked(propertyData.prop))
                        {
                            propertyData.isLocked++;
                        }
                        else
#endif
                        {
                            var value = material.GetFloat(propertyData.prop);

                            if (propertyData.value != -9000 && propertyData.value != value)
                            {
                                propertyData.value = -8000;
                            }
                            else
                            {
                                propertyData.value = value;
                            }
                        }
                    }

                    if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Vector)
                    {
#if UNITY_2022_1_OR_NEWER
                        if (material.IsPropertyLocked(propertyData.prop))
                        {
                            propertyData.isLocked++;
                        }
                        else
#endif
                        {
                            var vector = material.GetVector(propertyData.prop);

                            if (propertyData.vector.x != -9000 && propertyData.vector.w != -9000 && propertyData.vector != vector)
                            {
                                propertyData.vector = new Vector4(-8000, -8000, -8000, -8000);
                            }
                            else
                            {
                                propertyData.vector = vector;
                            }
                        }
                    }

                    if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Texture)
                    {
#if UNITY_2022_1_OR_NEWER
                        if (material.IsPropertyLocked(propertyData.prop))
                        {
                            propertyData.isLocked++;
                        }
                        else
#endif
                        {
                            var texture = material.GetTexture(propertyData.prop);

                            if (propertyData.texture != null && propertyData.texture != texture)
                            {
                                propertyData.isMixed = true;
                            }
                            else
                            {
                                propertyData.texture = texture;
                            }
                        }
                    }
                }
            }
        }

        void SetMaterialProperties()
        {
            for (int i = 0; i < selectedMaterials.Count; i++)
            {
                var material = selectedMaterials[i];

                // Maybe a better check for unfocus on Converter Convert button pressed
                if (material != null)
                {
                    TVEUtils.SetMaterialSettings(material);

                    //if (material.GetTag("UseExternalSettings", false) == "False")
                    //{
                    //    continue;
                    //}

                    if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                    {
                        continue;
                    }

                    for (int d = 0; d < propertyDataSet.Count; d++)
                    {
                        var propertyData = propertyDataSet[d];

                        bool isValid = true;

                        if (!material.HasProperty(propertyData.prop))
                        {
                            isValid = false;
                        }

#if UNITY_2022_1_OR_NEWER
                        if (material.IsPropertyLocked(propertyData.prop))
                        {
                            isValid = false;
                        }
#endif
                        //if (propertyData.isMixed)
                        //{
                        //    isValid = false;
                        //}

                        if (isValid)
                        {
                            if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Value)
                            {
                                if (propertyData.value > -90)
                                {
                                    material.SetFloat(propertyData.prop, propertyData.value);
                                }
                            }

                            if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Vector)
                            {
                                if (propertyData.vector.x > -90)
                                {
                                    material.SetVector(propertyData.prop, propertyData.vector);
                                }
                            }

                            if (propertyData.setter == TVEPropertyData.TVEPropertySetter.Texture)
                            {
                                if (propertyData.texture != null && !propertyData.isMixed)
                                {
                                    material.SetTexture(propertyData.prop, propertyData.texture);
                                }
                            }
                        }
                    }
                }
            }
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

            //for (int i = 0; i < presetLines.Count; i++)
            //{
            //    Debug.Log(presetLines[i]);
            //}
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
;
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

        void DrawCopySettingsFromObject()
        {
            UnityEngine.Object inputObject = null;

            EditorGUI.BeginChangeCheck();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Copy Settings From Object", GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 24));
            inputObject = (UnityEngine.Object)EditorGUILayout.ObjectField(inputObject, typeof(UnityEngine.Object), true);
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

                        for (int i = 0; i < selectedMaterials.Count; i++)
                        {
                            var material = selectedMaterials[i];

                            if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                            {
                                continue;
                            }

                            if (copyTerrainSettingsOnly)
                            {
                                TVEUtils.CopyTerrainDataToMaterial(terrain, material);
                            }
                            else
                            {
                                TVEUtils.CopyMaterialProperties(terrain.materialTemplate, material);
                                TVEUtils.CopyTerrainDataToMaterial(terrain, material);
                            }

                            TVEUtils.SetMaterialSettings(material);
                        }

                        Debug.Log("<b>[The Visual Engine]</b> " + "Terrain material settings copied to the selected materials!");
                    }
                    else
                    {
                        List<Material> allMaterials = new();
                        List<GameObject> allGameObjects = new();

                        allGameObjects.Add(gameObject);
                        TVEUtils.GetChildRecursive(gameObject, allGameObjects);

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

                                    if (currentMaterial != null && !allMaterials.Contains(currentMaterial))
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

                            for (int i = 0; i < selectedMaterials.Count; i++)
                            {
                                var material = selectedMaterials[i];

                                //if (material.GetTag("UseExternalSettings", false) == "False")
                                //{
                                //    continue;
                                //}

                                if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                                {
                                    continue;
                                }

                                TVEUtils.CopyMaterialProperties(oldMaterial, material);
                                TVEUtils.SetMaterialSettings(material);
                                material.SetFloat("_IsInitialized", 1);
                                TVEUtils.SetImpostorBakeModes(oldMaterial, material);
                            }

                            Debug.Log("<b>[The Visual Engine]</b> " + "Gameobject material settings copied to the selected materials!");
                        }
                        else if (allMaterials.Count > 1)
                        {
                            for (int m = 0; m < allMaterials.Count; m++)
                            {
                                var oldMaterial = allMaterials[m];

                                bool copySettings = EditorUtility.DisplayDialog("Copy Material Settings?", "Copy the settings from " + oldMaterial.name.ToUpper() + "?", "Copy Material Settings", "Skip");

                                if (copySettings)
                                {
                                    for (int i = 0; i < selectedMaterials.Count; i++)
                                    {
                                        var material = selectedMaterials[i];

                                        //if (material.GetTag("UseExternalSettings", false) == "False")
                                        //{
                                        //    continue;
                                        //}

                                        if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                                        {
                                            continue;
                                        }

                                        TVEUtils.CopyMaterialProperties(oldMaterial, material);
                                        TVEUtils.SetMaterialSettings(material);
                                        material.SetFloat("_IsInitialized", 1);
                                        TVEUtils.SetImpostorBakeModes(oldMaterial, material);
                                    }
                                }
                            }

                            Debug.Log("<b>[The Visual Engine]</b> " + "Selected material settings copied to the selected materials!");
                        }
                    }
                }

                if (inputObject.GetType() == typeof(Material))
                {
                    var oldMaterial = (Material)inputObject;

                    if (oldMaterial != null)
                    {
                        for (int i = 0; i < selectedMaterials.Count; i++)
                        {
                            var material = selectedMaterials[i];

                            //if (material.GetTag("UseExternalSettings", false) == "False")
                            //{
                            //    continue;
                            //}

                            if (BoxoUtils.GetMaterialInt(material, "_UseExternalSettings", 1) == 0)
                            {
                                continue;
                            }

                            TVEUtils.CopyMaterialProperties(oldMaterial, material);
                            TVEUtils.SetImpostorBakeModes(oldMaterial, material);
                            material.SetFloat("_IsInitialized", 1);
                            TVEUtils.SetMaterialSettings(material);
                        }

                        Debug.Log("<b>[The Visual Engine]</b> " + "Selected material settings copied to the selected materials!");
                    }
                }

                inputObject = null;

                if (EditorGUI.EndChangeCheck())
                {
                    RefreshMaterialDataSet();

                    SettingsUtils.SaveSettingsData(userFolder + "/User/The Visual Engine/Material Settings.asset", settingsIndex);
                }
            }
        }

        void DrawSaving()
        {
            GUILayout.BeginHorizontal();

            savingIndex = EditorGUILayout.Popup(savingIndex, savingOptions, stylePopup, GUILayout.Height(GUI_HEIGHT), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

            if (GUILayout.Button("Save Preset", GUILayout.Height(GUI_HEIGHT), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH)))
            {
                savePath = EditorUtility.SaveFilePanelInProject("Save Preset", "Custom - My Preset", "tvepreset", "Use the ' - ' simbol to create categories!");

                if (savePath != "")
                {
                    savePath = savePath.Replace("[SETTINGS] ", "");
                    savePath = savePath.Replace(Path.GetFileName(savePath), "[SETTINGS] " + Path.GetFileName(savePath));

                    StreamWriter writer = new StreamWriter(savePath);
                    
                    savingDataSet = new List<TVEPropertyData>();

                    if (savingIndex == 0)
                    {
                        savingDataSet.AddRange(renderData);
                        savingDataSet.AddRange(objectData);
                        savingDataSet.AddRange(globalData);
                        savingDataSet.AddRange(surfaceData);
                        savingDataSet.AddRange(terrainData);
                        savingDataSet.AddRange(coloringData);
                        savingDataSet.AddRange(seasonsData);
                        savingDataSet.AddRange(ditheringData);
                        savingDataSet.AddRange(glowingData);
                        savingDataSet.AddRange(transformData);
                        savingDataSet.AddRange(motionData);
                        savingDataSet.AddRange(normalData);
                        savingDataSet.AddRange(metaData);
                    }
                    else if (savingIndex == 1)
                    {
                        savingDataSet = propertyDataSet;
                    }

                    for (int i = 0; i < savingDataSet.Count; i++)
                    {
                        bool searchValid = false;

                        foreach (var tag in searchResult)
                        {
                            if (savingDataSet[i].prop.ToUpper().Contains(tag))
                            {
                                searchValid = true;
                                break;
                            }

                            if (savingDataSet[i].name.ToUpper().Contains(tag))
                            {
                                searchValid = true;
                                break;
                            }

                            if (savingDataSet[i].tag.ToUpper().Contains(tag))
                            {
                                searchValid = true;
                                break;
                            }
                        }

                        if (savingDataSet[i].space == true)
                        {
                            writer.WriteLine("");
                        }

                        if (savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Space)
                        {
                            writer.WriteLine("");
                        }

                        if (savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Category)
                        {
                            writer.WriteLine("");
                            writer.WriteLine("// " + savingDataSet[i].category);

                        }

                        if (savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Value || savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Range || savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Enum || savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Toggle)
                        {
                            if (!savingDataSet[i].isMixed && savingDataSet[i].isVisible > 0 && searchValid)
                                //if (savingDataSet[i].value > -99 && searchValid)
                            {
                                writer.WriteLine("Material SET_FLOAT " + savingDataSet[i].prop + " " + savingDataSet[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_FLOAT " + savingDataSet[i].prop + " " + "0");
                            }
                        }

                        if (savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Vector || savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Remap || savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Color)
                        {
                            if (!savingDataSet[i].isMixed && savingDataSet[i].isVisible > 0 && searchValid)
                            //if (savingDataSet[i].vector.x > -99 && searchValid)
                            {
                                writer.WriteLine("Material SET_VECTOR " + savingDataSet[i].prop + " " + savingDataSet[i].vector.x.ToString(CultureInfo.InvariantCulture) + " " + savingDataSet[i].vector.y.ToString(CultureInfo.InvariantCulture) + " " + savingDataSet[i].vector.z.ToString(CultureInfo.InvariantCulture) + " " + savingDataSet[i].vector.w.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_VECTOR " + savingDataSet[i].prop + " " + "0 0 0 0");
                            }
                        }

                        if (savingDataSet[i].type == TVEPropertyData.TVEPropertyType.Texture)
                        {
                            if (!savingDataSet[i].isMixed && savingDataSet[i].isVisible > 0 && searchValid)
                            {
                                writer.WriteLine("Material SET_TEX_BY_GUID " + savingDataSet[i].prop + " " + AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(savingDataSet[i].texture)));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_TEX_BY_GUID " + savingDataSet[i].prop + " " + "NONE");
                            }
                        }
                    }

                    writer.Close();

                    AssetDatabase.Refresh();

                    TVEUtils.GetSettingsPresetsEnum(true);

                    Debug.Log("<b>[The Visual Engine]</b> " + "Material preset saved!");

                    GUIUtility.ExitGUI();
                }
            }

            GUILayout.EndHorizontal();
        }

        void ResetEditorWind()
        {
            Shader.SetGlobalVector("TVE_WindEditor", new Vector4(1, 0, 0, 0));
        }

        void SetEditorWind()
        {
            float mulValue = 1;
            float addValue = 0;

            if (motionControl >= 0.5f)
            {
                mulValue = 1;
                addValue = motionControl * 2.0f - 1.0f;

            }
            else
            {
                mulValue = motionControl * 2.0f;
                addValue = 0;
            }

            //Shader.SetGlobalFloat("TVE_MaterialManagerActive", 1);
            Shader.SetGlobalVector("TVE_WindEditor", new Vector4(mulValue, addValue, motionControl, 1));
        }
    }
}
