// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Helpers/Custom Texture Packing"
{
	Properties
	{
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 1
		[HideInInspector] _IsShaderType( "_IsShaderType", Float ) = 0
		[HideInInspector] _IsObjectType( "_IsObjectType", Float ) = 0
		[HideInInspector] _IsLightingType( "_IsLightingType", Float ) = 0
		[HideInInspector] _IsCustomShader( "_IsCustomShader", Float ) = 0
		[HideInInspector] _IsConverted( "_IsConverted", Float ) = 0
		[HideInInspector] _IsCollected( "_IsCollected", Float ) = 0
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[HideInInspector] _IsShared( "_IsShared", Float ) = 0
		[HideInInspector] _UseExternalSettings( "_UseExternalSettings", Float ) = 1
		[StyledCategory(Render Settings, true, Use the Faces option to control if the faces should be rendered as double sided.NEWNEWUse the Motion option to control if the shader writes Motion Vectors OPAwhen availableCPA.NEWNEWUse the GBuffer to option to control if the shader writes to GBuffer__ even if the shader is rendered in Forward path OPAwhen availableCPA.NEWNEWUse the Render Normals option to Flip or Mirror the normal map on the mesh backface. When the mesh normals are flattened__ use the Same option so the normals are the same on both sides.NEWNEWUse the Filtering options to control the texture filtering. The Default option keeps the Albedo filtering at higher quality__ and the Normal and Shader filtering at lower quality for better performance.NEWNEWUse the Render Clipping to enable alpha testing__ also know as alpha cutout., 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		[Enum(Opaque,0,Transparent,1)] _RenderMode( "Render Mode", Float ) = 0
		[Enum(Off,0,On,1)] _RenderZWrite( "Render ZWrite", Float ) = 1
		[Enum(Both,0,Back,1,Front,2)] _RenderCull( "Render Faces", Float ) = 2
		[HideInInspector] _RenderQueue( "Render Queue", Float ) = 0
		[HideInInspector] _RenderPriority( "Render Priority", Float ) = 0
		[HideInInspector] _RenderBakeGI( "Render BakeGI", Float ) = 0
		[Enum(Off,0,On,1)] _RenderSSR( "Render SSR", Float ) = 0
		[Enum(Off,0,On,1)] _RenderDecals( "Render Decals", Float ) = 0
		[Enum(Auto,0,Off,1,On,2)] _RenderMotion( "Render Motion", Float ) = 0
		[Enum(Flip,0,Mirror,1,Same,2)] _RenderNormal( "Render Normals", Float ) = 0
		[Enum(Off,0,On,1)] _RenderSpecular( "Render Specular", Float ) = 1
		[Enum(Default,0,Point ,1,Low,2,Medium,3,High,4)] _RenderFilter( "Render Filtering", Float ) = 0
		[Enum(Off,0,On,1)] _RenderClip( "Render Clipping", Float ) = 0
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 1
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		[StyledCategory(Main Settings, true, 0, 10)] _MainCategory( "[Main Category ]", Float ) = 1
		[StyledMessage(Info, Use the Multi Mask as leaves mask for Dual Colors__ Global Effects and as Subsurface Mask. The mask is stored in the Shader texture blue channel and it can be in subsurface format or thickness format by inverting the Multi Mask remap slider. , 0, 0)] _MainMultiMaskInfo( "# MainMultiMaskInfo", Float ) = 0
		[StyledMessage(Info, The Smoothness mask is stored in the Shader texture alpha channel and it can be in smoothness format or roughness format by inverting the Smoothness remap slider. , 0, 10)] _MainSmoothnessInfo( "# MainSmoothnessInfo", Float ) = 0
		[StyledTextureSingleLine(Albedo RGB Alpha A)] _MainAlbedoTex( "Main Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _MainNormalTex( "Main Normal", 2D ) = "bump" {}
		[StyledTextureSingleLine(Metallic R Occlusion G BaseMask and MultiMask B Smoothness A)] _MainShaderTex( "Main Shader", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3,Stochastic,4,Stochastic Triplanar,5)][Space(10)] _MainSampleMode( "Main Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _MainCoordMode( "Main UV Mode", Float ) = 0
		[StyledVector(9)] _MainCoordValue( "Main UV Value", Vector ) = ( 1, 1, 0, 0 )
		[HideInInspector] _main_coord_value( "_main_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[Enum(Constant,0,Dual Colors,1)] _MainColorMode( "Main Color", Float ) = 0
		[HDR] _MainColor( "Main Color", Color ) = ( 1, 1, 1, 1 )
		[HDR] _MainColorTwo( "Main ColorB", Color ) = ( 1, 1, 1, 1 )
		_MainAlbedoValue( "Main Albedo", Range( 0, 1 ) ) = 1
		_MainNormalValue( "Main Normal", Range( -8, 8 ) ) = 1
		[Space(10)] _MainAlphaClipValue( "Main Alpha", Range( 0, 1 ) ) = 0.5
		[Enum(Default Albedo Texture A,0,Custom Texture,1)] _MainAlphaSourceMode( "Main Alpha Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainAlphaChannelMode( "Main Alpha Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainMetallicTex( "Main Metallic", 2D ) = "white" {}
		[Space(10)] _MainMetallicValue( "Main Metallic", Range( 0, 1 ) ) = 0
		[Enum(Default Shader Texture R,0,Custom Texture,1)] _MainMetallicSourceMode( "Main Metallic Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainMetallicChannelMode( "Main Metallic Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainOcclusionTex( "Main Occlusion", 2D ) = "white" {}
		[Space(10)] _MainOcclusionValue( "Main Occlusion", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainOcclusionRemap( "Main Occlusion", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Default Shader Texture G,0,Custom Texture,1)] _MainOcclusionSourceMode( "Main Occlusion Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainOcclusionChannelMode( "Main Occlusion Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainMultiTex( "Main Multi Mask", 2D ) = "white" {}
		[StyledRemapSlider] _MainMultiWriteRemap( "Main Multi Mask", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Default Shader Texture B,0,Custom Texture,1)] _MainMultiSourceMode( "Main Multi Mask Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainMultiChannelMode( "Main Multi Mask Channel", Float ) = 0
		[Space(10)] _MainSmoothnessValue( "Main Smoothness", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainSmoothnessRemap( "Main Smoothness", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Default Shader Texture A,0,Custom Texture,1)] _MainSmoothnessSourceMode( "Main Smoothness Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainSmoothnessChannelMode( "Main Smoothness Channel", Float ) = 0
		[StyledSpace(10)] _MainEnd( "[Main End ]", Float ) = 1
		[HideInInspector] _render_cull( "_render_cull", Float ) = 0
		[HideInInspector] _render_src( "_render_src", Float ) = 5
		[HideInInspector] _render_dst( "_render_dst", Float ) = 10
		[HideInInspector] _render_zw( "_render_zw", Float ) = 1
		[HideInInspector] _render_coverage( "_render_coverage", Float ) = 0
		[HideInInspector] _IsGeneralShader( "_IsGeneralShader", Float ) = 1
		[HideInInspector] _IsStandardShader( "_IsStandardShader", Float ) = 1

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		//[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector][ToggleUI] _SupportDecals("Support Decals", Float) = 1.0
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0 // StencilUsage.Clear
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 0 // Nothing
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8 // StencilUsage.TraceReflectionRay
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 4 				// DEPRECATED
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 4	// DEPRECATED
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 2 // StencilUsage.RequiresDeferredLighting
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector][ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector][ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector][ToggleUI] _ReceivesSSRTransparent("Receives SSR Transparent", Float) = 0
		[HideInInspector] _SurfaceType("Surface Type", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _DstBlend2("__dst2", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector][ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector][ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 0
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Float) = 0
		[HideInInspector][ToggleUI] _EnableFogOnTransparent("Enable Fog", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2 // This mode is dedicated to Forward to correctly handle backface then front face rendering thin transparent
		[HideInInspector][Enum(Back, 2, Front, 1)] _TransparentCullMode("TransparentCullMode", Int) = 2 // Back culling by default
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4 // Less equal
		[HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Int) = 4 // Less equal
		[HideInInspector][ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector][ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 1
		[HideInInspector][ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 1
		[HideInInspector][ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 0
		[HideInInspector][Enum(Default, 1, Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleUI] _TransparentWritingMotionVec("Transparent Writing MotionVec", Float) = 0
		[HideInInspector][ToggleUI] _PerPixelSorting("_PerPixelSorting", Float) = 0.0
		[HideInInspector][Enum(Back, 2, Front, 1)] _OpaqueCullMode("_OpaqueCullMode", Int) = 2 // Back culling by default
		[HideInInspector][ToggleUI] _EnableBlendModePreserveSpecularLighting("Enable Blend Mode Preserve Specular Lighting", Float) = 1
		[HideInInspector] _EmissionColor("Color", Color) = (1, 1, 1)

		[HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		[HideInInspector][Enum(Default, 0, Auto, 0, On, 1, Off, 2)] _DoubleSidedGIMode("Double sided GI mode", Float) = 0

		[HideInInspector][ToggleUI] _AlphaToMaskInspectorValue("_AlphaToMaskInspectorValue", Float) = 0 // Property used to save the alpha to mask state in the inspector
        [HideInInspector][ToggleUI] _AlphaToMask("__alphaToMask", Float) = 0

		//_Refrac ( "Refraction Model", Float) = 0
		//_InstancedTerrainNormals("Instanced Terrain Normals", Float) = 1.0
	}

	SubShader
	{
		PackageRequirements
		{
			"com.unity.render-pipelines.high-definition": "[17.0,18.0]"
		}

		

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" "ShaderGraphShader"="true" }

	LOD 0

		AlphaToMask Off

		HLSLINCLUDE
		#pragma target 4.5

		#if ( UNITY_VERSION >= 60030000 )
			#pragma exclude_renderers glcore gles gles3 switch2 webgpu 
		#else
			#pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
		#endif

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		struct GlobalSurfaceDescription
		{
			float3 BaseColor;
			float3 Normal;
			float3 BentNormal;
			float3 Specular;
			float CoatMask;
			float Metallic;
			float3 Emission;
			float Smoothness;
			float Occlusion;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float AlphaClipThresholdDepthPostpass;
			float SpecularOcclusion;
			float SpecularAAScreenSpaceVariance;
			float SpecularAAThreshold;
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			float DiffusionProfile;
			float TransmissionMask;
			float Thickness;
			float SubsurfaceMask;
			float Anisotropy;
			float3 Tangent;
			float IridescenceMask;
			float IridescenceThickness;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
			float2 Distortion;
			float DistortionBlur;

			float3 ObjectSpaceNormal;
			float3 WorldSpaceNormal;
			float3 TangentSpaceNormal;
			float3 ObjectSpaceViewDirection;
			float3 WorldSpaceViewDirection;
			float3 ObjectSpacePosition;
		};

		#define ASE_ADJUST_CLIP_POSITION( x ) x

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="GBuffer" }

			Cull [_CullMode]
			ZTest [_ZTestGBuffer]

			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
				Comp Always
				Pass Replace
			}


			HLSLPROGRAM
            #define ASE_GEOMETRY
            #define _ENERGY_CONSERVING_SPECULAR 1
            #define ASE_FRAGMENT_NORMAL 0
            #pragma shader_feature_local_fragment _ _DISABLE_DECALS
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #define _AMBIENT_OCCLUSION 1
            #define ASE_VERSION 19912
            #define ASE_SRP_VERSION 170004
            #define ASE_USING_SAMPLING_MACROS 1

            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT

			#pragma multi_compile_fragment _ RENDERING_LAYERS
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma multi_compile _ LIGHTMAP_ON
			#if UNITY_VERSION > 60010000
				#pragma multi_compile _ LIGHTMAP_BICUBIC_SAMPLING
			#endif
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
            #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT
            #pragma multi_compile _ USE_LEGACY_LIGHTMAPS

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			half _DisableSRPBatcher;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#if ( UNITY_VERSION >= 60050001 )
			#include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#else
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 uv0 : TEXCOORD3;
				float4 uv1 : TEXCOORD4;
				float4 uv2 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};


			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.thickness = 0.0;

				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				if (surfaceData.subsurfaceMask > 0)
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normal = surfaceDescription.Normal;

				#ifdef DECAL_NORMAL_BLENDING
					#ifndef SURFACE_GRADIENT
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						normal = SurfaceGradientFromPerturbedNormal(TransformWorldToObjectNormal(fragInputs.tangentToWorld[2]), normal);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						normal = SurfaceGradientFromPerturbedNormal(fragInputs.tangentToWorld[2], normal);
					#else
						normal = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normal, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
					#endif
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normal);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif

					GetNormalWS_SG(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
				#else
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						GetNormalWS_SrcOS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						GetNormalWS_SrcWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#else
						GetNormalWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif
				#endif

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if !defined(SHADER_STAGE_RAY_TRACING)
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{
						#ifdef FRAG_INPUTS_USE_TEXCOORD0
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
						#else
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
						#endif
						surfaceData.metallic = 0;
					}
					#endif
					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
					#if ( UNITY_VERSION >= 60020000 )
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
					#else
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
					#endif
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS output;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord6.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord7.xyz = vertexToFrag76_g205214;
				
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord6.w = 0;
				output.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				#ifdef ASE_CUSTOM_MOTION_VECTOR
				// Declared so the Velocity output port surfaces on the master node; only consumed by the motion vector passes.
				float3 aseCustomVelocity = float3( 0, 0, 0 );
				#endif

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				output.positionCS = ASE_ADJUST_CLIP_POSITION( TransformWorldToHClip(positionRWS) );
				output.positionRWS = positionRWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;
				output.uv0 = inputMesh.uv0;
				output.uv1 = inputMesh.uv1;
				output.uv2 = inputMesh.uv2;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = inputMesh.uv0.xy;
					output.tangentWS.xy = inputMesh.uv0.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput,
						OUTPUT_GBUFFER(outGBuffer)
						#if defined( ASE_WRITE_DEPTH )
							, out float outputDepth : ASE_SV_DEPTH
						#endif
						 )
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.positionSS = packedInput.positionCS;
				input.positionRWS = packedInput.positionRWS;
				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS, packedInput.normalWS);
				input.texCoord0 = packedInput.uv0;
				input.texCoord1 = packedInput.uv1;
				input.texCoord2 = packedInput.uv2;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half IsFrontFace = input.isFrontFace;
				float3 PositionRWS = posInput.positionWS;
				float3 PositionWS = GetAbsolutePositionWS( posInput.positionWS );
				float3 V = GetWorldSpaceNormalizeViewDir( packedInput.positionRWS );
				float4 ScreenPosNorm = float4( posInput.positionNDC, packedInput.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, packedInput.positionCS.z ) * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos, _ProjectionParams.x );
				float3 NormalWS = packedInput.normalWS;
				float3 TangentWS = packedInput.tangentWS.xyz;
				float3 BitangentWS = input.tangentToWorld[ 1 ];
				float4 UV0 = packedInput.uv0;
				float4 UV1 = packedInput.uv1;
				float4 UV2 = packedInput.uv2;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (packedInput.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					input.tangentToWorld = BuildTangentToWorld( float4( TangentWS, -1 ), NormalWS );
					BitangentWS = input.tangentToWorld[ 1 ];
				#endif

				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord6.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord7.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(UV0.xy , UV2.xy));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				half3 Input_Albedo24_g251325 = Out_Albedo4_g251324;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251325 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251325 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251325 = staticSwitch22_g251325;
				float4 break24_g251316 = Out_Shader4_g251324;
				half Metallic95_g251316 = break24_g251316.x;
				half Input_Metallic25_g251325 = Metallic95_g251316;
				half OneMinusReflectivity31_g251325 = ( (ColorSpaceDielectricSpec23_g251325).w - ( (ColorSpaceDielectricSpec23_g251325).w * Input_Metallic25_g251325 ) );
				float3 temp_output_6_0_g251333 = ( Input_Albedo24_g251325 * OneMinusReflectivity31_g251325 );
				half Render_Common200_g251316 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251316 = _RenderMotion;
				half Render_HDRPOnly191_g251316 = ( _RenderDecals + _RenderSSR + Render_Motion186_g251316 );
				half Render_Pipeline184_g251316 = ( Render_Common200_g251316 + Render_HDRPOnly191_g251316 );
				float temp_output_7_0_g251333 = Render_Pipeline184_g251316;
				float temp_output_17_0_g251333 = ( temp_output_7_0_g251333 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251333 = ( temp_output_6_0_g251333 + temp_output_17_0_g251333 );
				#else
				float3 staticSwitch14_g251333 = temp_output_6_0_g251333;
				#endif
				
				float3 lerpResult28_g251325 = lerp( (ColorSpaceDielectricSpec23_g251325).xyz , Input_Albedo24_g251325 , Input_Metallic25_g251325);
				half3 Specular160_g251316 = lerpResult28_g251325;
				half3 Input_Specular73_g251326 = Specular160_g251316;
				half Render_Spec102_g251316 = _RenderSpecular;
				half Input_RenderSpec58_g251326 = Render_Spec102_g251316;
				half localGBufferPassCheck36_g251327 = ( 0.0 );
				half Input_True57_g251327 = 0.0;
				half True36_g251327 = Input_True57_g251327;
				half Smoothness105_g251316 = break24_g251316.w;
				half Input_Smoothness43_g251326 = Smoothness105_g251316;
				float temp_output_46_0_g251326 = max( ( Input_Smoothness43_g251326 * Input_RenderSpec58_g251326 ), 0.001 );
				half Input_False58_g251327 = temp_output_46_0_g251326;
				half False36_g251327 = Input_False58_g251327;
				half Result36_g251327 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251327 = True36_g251327;
				#else
				Result36_g251327 = False36_g251327;
				#endif
				}
				float3 temp_cast_11 = (Result36_g251327).xxx;
				#ifdef ASE_LIGHTING_SIMPLE
				float3 staticSwitch75_g251326 = temp_cast_11;
				#else
				float3 staticSwitch75_g251326 = ( Input_Specular73_g251326 * Input_RenderSpec58_g251326 );
				#endif
				
				half localGBufferPassCheck36_g251329 = ( 0.0 );
				half Input_True57_g251329 = 0.0;
				half True36_g251329 = Input_True57_g251329;
				half Input_False58_g251329 = temp_output_46_0_g251326;
				half False36_g251329 = Input_False58_g251329;
				half Result36_g251329 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251329 = True36_g251329;
				#else
				Result36_g251329 = False36_g251329;
				#endif
				}
				#ifdef ASE_LIGHTING_SIMPLE
				float staticSwitch79_g251326 = Result36_g251329;
				#else
				float staticSwitch79_g251326 = Input_Smoothness43_g251326;
				#endif
				
				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.BaseColor = staticSwitch14_g251333;
				surfaceDescription.Normal = Out_NormalWS4_g251324;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = staticSwitch75_g251326;
				#endif

				surfaceDescription.Smoothness = staticSwitch79_g251326;
				surfaceDescription.Occlusion = break24_g251316.y;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = _AlphaCutoffShadow;
				surfaceDescription.AlphaClipThresholdShadow = _UseShadowThreshold ? surfaceDescription.AlphaClipThresholdShadow : surfaceDescription.AlphaClipThreshold;
				#endif

				surfaceDescription.AlphaClipThresholdDepthPrepass = 0.5;
				surfaceDescription.AlphaClipThresholdDepthPostpass = 0.5;

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_DISTORTION
				surfaceDescription.Distortion = float2( 0, 0 );
				surfaceDescription.DistortionBlur = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#if defined( ASE_CHANGES_WORLD_POS )
					posInput.positionWS = PositionRWS;
				#endif

				#if defined( ASE_WRITE_DEPTH )
					#if !defined( _DEPTHOFFSET_ON )
						posInput.deviceDepth = posInput.deviceDepth;
					#else
						surfaceDescription.DepthOffset = 0;
					#endif
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );

				ENCODE_INTO_GBUFFER( surfaceData, builtinData, posInput.positionSS, outGBuffer );

				#if defined( ASE_WRITE_DEPTH )
					outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#define ASE_GEOMETRY
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define ASE_FRAGMENT_NORMAL 0
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _AMBIENT_OCCLUSION 1
			#define ASE_VERSION 19912
			#define ASE_SRP_VERSION 170004
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma shader_feature EDITOR_VISUALIZATION
			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
            #define SCENEPICKINGPASS 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			half _DisableSRPBatcher;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#if SHADERPASS == SHADERPASS_LIGHT_TRANSPORT
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/MetaPass.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				#ifdef EDITOR_VISUALIZATION
				float2 VizUV : TEXCOORD0;
				float4 LightCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.thickness = 0.0;

				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

                #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				if (surfaceData.subsurfaceMask > 0)
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

                #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
                #endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normal = surfaceDescription.Normal;

				#ifdef DECAL_NORMAL_BLENDING
					#ifndef SURFACE_GRADIENT
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						normal = SurfaceGradientFromPerturbedNormal(TransformWorldToObjectNormal(fragInputs.tangentToWorld[2]), normal);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						normal = SurfaceGradientFromPerturbedNormal(fragInputs.tangentToWorld[2], normal);
					#else
						normal = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normal, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
					#endif
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normal);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif

					GetNormalWS_SG(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
				#else
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						GetNormalWS_SrcOS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						GetNormalWS_SrcWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#else
						GetNormalWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif
				#endif

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if !defined(SHADER_STAGE_RAY_TRACING)
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{
						#ifdef FRAG_INPUTS_USE_TEXCOORD0
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
						#else
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
						#endif
						surfaceData.metallic = 0;
					}
					#endif
					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
					#if ( UNITY_VERSION >= 60020000 )
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
					#else
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
					#endif
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh  )
			{
				PackedVaryingsMeshToPS output;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord2.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.uv3.x , inputMesh.uv3.z , inputMesh.uv3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord3.xyz = vertexToFrag76_g205214;
				float3 ase_normalWS = TransformObjectToWorldNormal( inputMesh.normalOS );
				output.ase_texcoord4.xyz = ase_normalWS;
				float3 ase_tangentWS = TransformObjectToWorldDir( inputMesh.tangentOS.xyz );
				output.ase_texcoord5.xyz = ase_tangentWS;
				float ase_tangentSign = inputMesh.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				output.ase_texcoord6.xyz = ase_bitangentWS;
				
				output.ase_texcoord7.xy = inputMesh.uv0.xy;
				output.ase_texcoord7.zw = inputMesh.uv2.xy;
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord2.w = 0;
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;
				output.ase_texcoord5.w = 0;
				output.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				output.positionCS = UnityMetaVertexPosition(inputMesh.positionOS, inputMesh.uv1.xy, inputMesh.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);

				#ifdef EDITOR_VISUALIZATION
					float2 vizUV = 0;
					float4 lightCoord = 0;
					UnityEditorVizData(inputMesh.positionOS.xyz, inputMesh.uv0.xy, inputMesh.uv1.xy, inputMesh.uv2.xy, vizUV, lightCoord);

					output.VizUV.xy = vizUV;
					output.LightCoord = lightCoord;
				#endif

				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.uv3 = v.uv3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.uv3 = patch[0].uv3 * bary.x + patch[1].uv3 * bary.y + patch[2].uv3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag(PackedVaryingsMeshToPS packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half isFrontFace = input.isFrontFace;

				float3 V = float3(1.0, 1.0, 1.0);

				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord2.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord3.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 ase_normalWS = packedInput.ase_texcoord4.xyz;
				float3 normalizedWorldNormal = normalize( ase_normalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				float3 ase_tangentWS = packedInput.ase_texcoord5.xyz;
				half3 TangentWS136_g205214 = ase_tangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				float3 ase_bitangentWS = packedInput.ase_texcoord6.xyz;
				half3 BiangentWS421_g205214 = ase_bitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(packedInput.ase_texcoord7.xy , packedInput.ase_texcoord7.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				half3 Input_Albedo24_g251325 = Out_Albedo4_g251324;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251325 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251325 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251325 = staticSwitch22_g251325;
				float4 break24_g251316 = Out_Shader4_g251324;
				half Metallic95_g251316 = break24_g251316.x;
				half Input_Metallic25_g251325 = Metallic95_g251316;
				half OneMinusReflectivity31_g251325 = ( (ColorSpaceDielectricSpec23_g251325).w - ( (ColorSpaceDielectricSpec23_g251325).w * Input_Metallic25_g251325 ) );
				float3 temp_output_6_0_g251333 = ( Input_Albedo24_g251325 * OneMinusReflectivity31_g251325 );
				half Render_Common200_g251316 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251316 = _RenderMotion;
				half Render_HDRPOnly191_g251316 = ( _RenderDecals + _RenderSSR + Render_Motion186_g251316 );
				half Render_Pipeline184_g251316 = ( Render_Common200_g251316 + Render_HDRPOnly191_g251316 );
				float temp_output_7_0_g251333 = Render_Pipeline184_g251316;
				float temp_output_17_0_g251333 = ( temp_output_7_0_g251333 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251333 = ( temp_output_6_0_g251333 + temp_output_17_0_g251333 );
				#else
				float3 staticSwitch14_g251333 = temp_output_6_0_g251333;
				#endif
				
				float3 lerpResult28_g251325 = lerp( (ColorSpaceDielectricSpec23_g251325).xyz , Input_Albedo24_g251325 , Input_Metallic25_g251325);
				half3 Specular160_g251316 = lerpResult28_g251325;
				half3 Input_Specular73_g251326 = Specular160_g251316;
				half Render_Spec102_g251316 = _RenderSpecular;
				half Input_RenderSpec58_g251326 = Render_Spec102_g251316;
				half localGBufferPassCheck36_g251327 = ( 0.0 );
				half Input_True57_g251327 = 0.0;
				half True36_g251327 = Input_True57_g251327;
				half Smoothness105_g251316 = break24_g251316.w;
				half Input_Smoothness43_g251326 = Smoothness105_g251316;
				float temp_output_46_0_g251326 = max( ( Input_Smoothness43_g251326 * Input_RenderSpec58_g251326 ), 0.001 );
				half Input_False58_g251327 = temp_output_46_0_g251326;
				half False36_g251327 = Input_False58_g251327;
				half Result36_g251327 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251327 = True36_g251327;
				#else
				Result36_g251327 = False36_g251327;
				#endif
				}
				float3 temp_cast_11 = (Result36_g251327).xxx;
				#ifdef ASE_LIGHTING_SIMPLE
				float3 staticSwitch75_g251326 = temp_cast_11;
				#else
				float3 staticSwitch75_g251326 = ( Input_Specular73_g251326 * Input_RenderSpec58_g251326 );
				#endif
				
				half localGBufferPassCheck36_g251329 = ( 0.0 );
				half Input_True57_g251329 = 0.0;
				half True36_g251329 = Input_True57_g251329;
				half Input_False58_g251329 = temp_output_46_0_g251326;
				half False36_g251329 = Input_False58_g251329;
				half Result36_g251329 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251329 = True36_g251329;
				#else
				Result36_g251329 = False36_g251329;
				#endif
				}
				#ifdef ASE_LIGHTING_SIMPLE
				float staticSwitch79_g251326 = Result36_g251329;
				#else
				float staticSwitch79_g251326 = Input_Smoothness43_g251326;
				#endif
				
				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.BaseColor = staticSwitch14_g251333;
				surfaceDescription.Normal = Out_NormalWS4_g251324;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = staticSwitch75_g251326;
				#endif

				surfaceDescription.Smoothness = staticSwitch79_g251326;
				surfaceDescription.Occlusion = break24_g251316.y;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);
				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);
				LightTransportData lightTransportData = GetLightTransportData(surfaceData, builtinData, bsdfData);

				float4 res = float4( 0.0, 0.0, 0.0, 1.0 );
				UnityMetaInput metaInput;
				metaInput.Albedo = lightTransportData.diffuseColor.rgb;
				metaInput.Emission = lightTransportData.emissiveColor;

			#ifdef EDITOR_VISUALIZATION
				metaInput.VizUV = packedInput.VizUV;
				metaInput.LightCoord = packedInput.LightCoord;
			#endif
				res = UnityMetaFragment(metaInput);

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ZTest LEqual
			ColorMask 0

			HLSLPROGRAM
			#define ASE_GEOMETRY
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define ASE_FRAGMENT_NORMAL 0
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _AMBIENT_OCCLUSION 1
			#define ASE_VERSION 19912
			#define ASE_SRP_VERSION 170004
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_SHADOWS

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.thickness = 0.0;

				// refraction ShadowCaster
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                    #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				if (surfaceData.subsurfaceMask > 0)
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normal = float3(0.0f, 0.0f, 1.0f);

				#ifdef DECAL_NORMAL_BLENDING
					#ifndef SURFACE_GRADIENT
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						normal = SurfaceGradientFromPerturbedNormal(TransformWorldToObjectNormal(fragInputs.tangentToWorld[2]), normal);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						normal = SurfaceGradientFromPerturbedNormal(fragInputs.tangentToWorld[2], normal);
					#else
						normal = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normal, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
					#endif
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normal);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif

					GetNormalWS_SG(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
				#else
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						GetNormalWS_SrcOS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						GetNormalWS_SrcWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#else
						GetNormalWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif
				#endif

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#if defined(DEBUG_DISPLAY)
					#if !defined(SHADER_STAGE_RAY_TRACING)
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{
						#ifdef FRAG_INPUTS_USE_TEXCOORD0
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
						#else
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
						#endif
						surfaceData.metallic = 0;
					}
					#endif
					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
					#if ( UNITY_VERSION >= 60020000 )
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
					#else
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
					#endif
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#if defined( _ALPHATEST_SHADOW_ON )
					DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow );
				#elif defined( _ALPHATEST_ON )
					DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS output;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord3.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord4.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord5.xy = inputMesh.ase_texcoord.xy;
				output.ase_texcoord5.zw = inputMesh.ase_texcoord2.xy;
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				output.positionCS = ASE_ADJUST_CLIP_POSITION( TransformWorldToHClip(positionRWS) );
				output.positionRWS = positionRWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) || defined(WRITE_RENDERING_LAYER)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif
						#if defined( ASE_WRITE_DEPTH )
							, out float outputDepth : ASE_SV_DEPTH
						#endif
						 )
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.positionSS = packedInput.positionCS;
				input.positionRWS = packedInput.positionRWS;
				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS, packedInput.normalWS);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half IsFrontFace = input.isFrontFace;
				float3 PositionRWS = posInput.positionWS;
				float3 PositionWS = GetAbsolutePositionWS( posInput.positionWS );
				float3 V = GetWorldSpaceNormalizeViewDir( packedInput.positionRWS );
				float4 ScreenPosNorm = float4( posInput.positionNDC, packedInput.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, packedInput.positionCS.z ) * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos, _ProjectionParams.x );
				float3 NormalWS = packedInput.normalWS;
				float3 TangentWS = packedInput.tangentWS.xyz;
				float3 BitangentWS = input.tangentToWorld[ 1 ];

				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord3.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord4.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(packedInput.ase_texcoord5.xy , packedInput.ase_texcoord5.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = _AlphaCutoffShadow;
				surfaceDescription.AlphaClipThresholdShadow = _UseShadowThreshold ? surfaceDescription.AlphaClipThresholdShadow : surfaceDescription.AlphaClipThreshold;
				#endif

				#if defined( ASE_CHANGES_WORLD_POS )
					posInput.positionWS = PositionRWS;
				#endif

				#if defined( ASE_WRITE_DEPTH )
					#if !defined( _DEPTHOFFSET_ON )
						posInput.deviceDepth = posInput.deviceDepth;
					#else
						surfaceDescription.DepthOffset = 0;
					#endif
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#if defined( ASE_WRITE_DEPTH )
					outputDepth = posInput.deviceDepth;
					float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
					outputDepth += bias;
				#endif

				#ifdef WRITE_MSAA_DEPTH
					depthColor = packedInput.vmesh.positionCS.z;
					depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif

				#if defined(WRITE_NORMAL_BUFFER)
				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

				#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) || defined(WRITE_RENDERING_LAYER)
					DecalPrepassData decalPrepassData;
					#ifdef _DISABLE_DECALS
					ZERO_INITIALIZE(DecalPrepassData, decalPrepassData);
					#else
					decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
					#endif
					decalPrepassData.renderingLayerMask = GetMeshRenderingLayerMask();
					EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off

			HLSLPROGRAM
			#define ASE_GEOMETRY
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define ASE_FRAGMENT_NORMAL 0
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _AMBIENT_OCCLUSION 1
			#define ASE_VERSION 19912
			#define ASE_SRP_VERSION 170004
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma editor_sync_compilation
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
		    #define SCENESELECTIONPASS 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.thickness = 0.0;

				//refraction SceneSelectionPass
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				if (surfaceData.subsurfaceMask > 0)
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normal = float3(0.0f, 0.0f, 1.0f);

				#ifdef DECAL_NORMAL_BLENDING
					#ifndef SURFACE_GRADIENT
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						normal = SurfaceGradientFromPerturbedNormal(TransformWorldToObjectNormal(fragInputs.tangentToWorld[2]), normal);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						normal = SurfaceGradientFromPerturbedNormal(fragInputs.tangentToWorld[2], normal);
					#else
						normal = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normal, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
					#endif
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normal);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif

					GetNormalWS_SG(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
				#else
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						GetNormalWS_SrcOS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						GetNormalWS_SrcWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#else
						GetNormalWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif
				#endif

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#if defined(DEBUG_DISPLAY)
					#if !defined(SHADER_STAGE_RAY_TRACING)
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{
						#ifdef FRAG_INPUTS_USE_TEXCOORD0
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
						#else
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
						#endif
						surfaceData.metallic = 0;
					}
					#endif
					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
					#if ( UNITY_VERSION >= 60020000 )
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
					#else
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
					#endif
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS output;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord3.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord4.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord5.xy = inputMesh.ase_texcoord.xy;
				output.ase_texcoord5.zw = inputMesh.ase_texcoord2.xy;
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				output.positionCS = ASE_ADJUST_CLIP_POSITION( TransformWorldToHClip(positionRWS) );
				output.positionRWS = positionRWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						, out float4 outColor : SV_Target0
						#if defined( ASE_WRITE_DEPTH )
							, out float outputDepth : ASE_SV_DEPTH
						#endif
						 )
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.positionSS = packedInput.positionCS;
				input.positionRWS = packedInput.positionRWS;
				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS, packedInput.normalWS);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half IsFrontFace = input.isFrontFace;
				float3 PositionRWS = posInput.positionWS;
				float3 PositionWS = GetAbsolutePositionWS( posInput.positionWS );
				float3 V = GetWorldSpaceNormalizeViewDir( packedInput.positionRWS );
				float4 ScreenPosNorm = float4( posInput.positionNDC, packedInput.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, packedInput.positionCS.z ) * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos, _ProjectionParams.x );
				float3 NormalWS = packedInput.normalWS;
				float3 TangentWS = packedInput.tangentWS.xyz;
				float3 BitangentWS = input.tangentToWorld[ 1 ];

				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord3.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord4.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(packedInput.ase_texcoord5.xy , packedInput.ase_texcoord5.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#if defined( ASE_CHANGES_WORLD_POS )
					posInput.positionWS = PositionRWS;
				#endif

				#if defined( ASE_WRITE_DEPTH )
					#if !defined( _DEPTHOFFSET_ON )
						posInput.deviceDepth = posInput.deviceDepth;
					#else
						surfaceDescription.DepthOffset = 0;
					#endif
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#if defined( ASE_WRITE_DEPTH )
					outputDepth = posInput.deviceDepth;
				#endif

				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			Cull [_CullMode]
			ZWrite On

			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
			}


			HLSLPROGRAM
			#define ASE_GEOMETRY
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define ASE_FRAGMENT_NORMAL 0
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _AMBIENT_OCCLUSION 1
			#define ASE_VERSION 19912
			#define ASE_SRP_VERSION 170004
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
            #pragma multi_compile_fragment _ WRITE_DECAL_BUFFER WRITE_RENDERING_LAYER

			#pragma vertex Vert
			#pragma fragment Frag

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.thickness = 0.0;

				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				if (surfaceData.subsurfaceMask > 0)
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normal = surfaceDescription.Normal;

				#ifdef DECAL_NORMAL_BLENDING
					#ifndef SURFACE_GRADIENT
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						normal = SurfaceGradientFromPerturbedNormal(TransformWorldToObjectNormal(fragInputs.tangentToWorld[2]), normal);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						normal = SurfaceGradientFromPerturbedNormal(fragInputs.tangentToWorld[2], normal);
					#else
						normal = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normal, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
					#endif
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normal);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif

					GetNormalWS_SG(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
				#else
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						GetNormalWS_SrcOS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						GetNormalWS_SrcWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#else
						GetNormalWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif
				#endif

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#if defined(DEBUG_DISPLAY)
					#if !defined(SHADER_STAGE_RAY_TRACING)
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{
						#ifdef FRAG_INPUTS_USE_TEXCOORD0
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
						#else
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
						#endif
						surfaceData.metallic = 0;
					}
					#endif
					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
					#if ( UNITY_VERSION >= 60020000 )
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
					#else
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
					#endif
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) || defined(WRITE_RENDERING_LAYER)
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalPrepassBuffer.hlsl"
			#endif

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS output;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord3.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord4.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord5.xy = inputMesh.uv0.xy;
				output.ase_texcoord5.zw = inputMesh.ase_texcoord2.xy;
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				output.positionCS = ASE_ADJUST_CLIP_POSITION( TransformWorldToHClip(positionRWS) );
				output.positionRWS = positionRWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = inputMesh.uv0.xy;
					output.tangentWS.xy = inputMesh.uv0.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) || defined(WRITE_RENDERING_LAYER)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif
						#if defined( ASE_WRITE_DEPTH )
							, out float outputDepth : ASE_SV_DEPTH
						#endif
						 )
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.positionSS = packedInput.positionCS;
				input.positionRWS = packedInput.positionRWS;
				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS, packedInput.normalWS);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half IsFrontFace = input.isFrontFace;
				float3 PositionRWS = posInput.positionWS;
				float3 PositionWS = GetAbsolutePositionWS( posInput.positionWS );
				float3 V = GetWorldSpaceNormalizeViewDir( packedInput.positionRWS );
				float4 ScreenPosNorm = float4( posInput.positionNDC, packedInput.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, packedInput.positionCS.z ) * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos, _ProjectionParams.x );
				float3 NormalWS = packedInput.normalWS;
				float3 TangentWS = packedInput.tangentWS.xyz;
				float3 BitangentWS = input.tangentToWorld[ 1 ];

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (packedInput.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					input.tangentToWorld = BuildTangentToWorld( float4( TangentWS, -1 ), NormalWS );
					BitangentWS = input.tangentToWorld[ 1 ];
				#endif

				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord3.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord4.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(packedInput.ase_texcoord5.xy , packedInput.ase_texcoord5.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				
				float4 break24_g251316 = Out_Shader4_g251324;
				half Smoothness105_g251316 = break24_g251316.w;
				half Input_Smoothness43_g251326 = Smoothness105_g251316;
				half localGBufferPassCheck36_g251329 = ( 0.0 );
				half Input_True57_g251329 = 0.0;
				half True36_g251329 = Input_True57_g251329;
				half Render_Spec102_g251316 = _RenderSpecular;
				half Input_RenderSpec58_g251326 = Render_Spec102_g251316;
				float temp_output_46_0_g251326 = max( ( Input_Smoothness43_g251326 * Input_RenderSpec58_g251326 ), 0.001 );
				half Input_False58_g251329 = temp_output_46_0_g251326;
				half False36_g251329 = Input_False58_g251329;
				half Result36_g251329 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251329 = True36_g251329;
				#else
				Result36_g251329 = False36_g251329;
				#endif
				}
				#ifdef ASE_LIGHTING_SIMPLE
				float staticSwitch79_g251326 = Result36_g251329;
				#else
				float staticSwitch79_g251326 = Input_Smoothness43_g251326;
				#endif
				
				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.Normal = Out_NormalWS4_g251324;
				surfaceDescription.Smoothness = staticSwitch79_g251326;
				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#if defined( ASE_CHANGES_WORLD_POS )
					posInput.positionWS = PositionRWS;
				#endif

				#if defined( ASE_WRITE_DEPTH )
					#if !defined( _DEPTHOFFSET_ON )
						posInput.deviceDepth = posInput.deviceDepth;
					#else
						surfaceDescription.DepthOffset = 0;
					#endif
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

                #if defined( ASE_WRITE_DEPTH )
					outputDepth = posInput.deviceDepth;
				#endif

                #if SHADERPASS == SHADERPASS_SHADOWS
                float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
                outputDepth += bias;
                #endif

				#ifdef SCENESELECTIONPASS
    				outColor = float4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
    				outColor = unity_SelectionID;
				#else
    				#ifdef WRITE_MSAA_DEPTH
    					depthColor = packedInput.positionCS.z;
    					depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
    				#endif

    				#if defined(WRITE_NORMAL_BUFFER)
    				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
    				#endif

					#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) || defined(WRITE_RENDERING_LAYER)
						DecalPrepassData decalPrepassData;
						#ifdef _DISABLE_DECALS
						ZERO_INITIALIZE(DecalPrepassData, decalPrepassData);
						#else
						decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
						#endif
						decalPrepassData.renderingLayerMask = GetMeshRenderingLayerMask();
						EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
					#endif
				#endif // SCENESELECTIONPASS
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="Forward" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Blend 1 One OneMinusSrcAlpha
			Blend 2 One [_DstBlend2]
			Blend 3 One [_DstBlend2]
			Blend 4 One OneMinusSrcAlpha

			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
			}


            ColorMask [_ColorMaskTransparentVelOne] 1
            ColorMask [_ColorMaskTransparentVelTwo] 2

			HLSLPROGRAM
			#define ASE_GEOMETRY
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define ASE_FRAGMENT_NORMAL 0
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _AMBIENT_OCCLUSION 1
			#define ASE_VERSION 19912
			#define ASE_SRP_VERSION 170004
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
            #pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT

            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment PUNCTUAL_SHADOW_LOW PUNCTUAL_SHADOW_MEDIUM PUNCTUAL_SHADOW_HIGH
            #pragma multi_compile_fragment DIRECTIONAL_SHADOW_LOW DIRECTIONAL_SHADOW_MEDIUM DIRECTIONAL_SHADOW_HIGH
            #pragma multi_compile_fragment AREA_SHADOW_MEDIUM AREA_SHADOW_HIGH
            #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
			#if ( UNITY_VERSION >= 60050000 )
				#pragma multi_compile_fragment _ CONTACT_SHADOWS_OFF
			#endif
            #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST

            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma multi_compile _ LIGHTMAP_ON
			#if UNITY_VERSION > 60010000
				#pragma multi_compile _ LIGHTMAP_BICUBIC_SAMPLING
			#endif
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
            #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT
            #pragma multi_compile _ USE_LEGACY_LIGHTMAPS

			#if ( UNITY_VERSION >= 60050000 )
				#pragma extended_structured_buffer_bindings
			#endif

			#ifndef SHADER_STAGE_FRAGMENT
			#define SHADOW_LOW
			#ifndef USE_FPTL_LIGHTLIST
			#define USE_FPTL_LIGHTLIST
			#endif
			#endif

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_FORWARD
		    #define HAS_LIGHTLOOP 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			half _DisableSRPBatcher;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
        	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 uv0 : TEXCOORD3;
				float4 uv1 : TEXCOORD4;
				float4 uv2 : TEXCOORD5;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float4 vpassPositionCS : TEXCOORD6;
					float4 vpassPreviousPositionCS : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				surfaceData.specularOcclusion = 1.0;
				surfaceData.thickness = 0.0;

				surfaceData.baseColor =                 surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				if (surfaceData.subsurfaceMask > 0)
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

				#ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normal = surfaceDescription.Normal;

				#ifdef DECAL_NORMAL_BLENDING
					#ifndef SURFACE_GRADIENT
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						normal = SurfaceGradientFromPerturbedNormal(TransformWorldToObjectNormal(fragInputs.tangentToWorld[2]), normal);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						normal = SurfaceGradientFromPerturbedNormal(fragInputs.tangentToWorld[2], normal);
					#else
						normal = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normal, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
					#endif
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normal);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif

					GetNormalWS_SG(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
				#else
					#if ( ASE_FRAGMENT_NORMAL == 1 )
						GetNormalWS_SrcOS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						GetNormalWS_SrcWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#else
						GetNormalWS(fragInputs, normal, surfaceData.normalWS, doubleSidedConstants);
					#endif

					#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
						ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
					}
					#endif
				#endif

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
					#if !defined(SHADER_STAGE_RAY_TRACING)
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{
						#ifdef FRAG_INPUTS_USE_TEXCOORD0
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
						#else
							surfaceData.baseColor = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
						#endif
						surfaceData.metallic = 0;
					}
					#endif
					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
					#if ( UNITY_VERSION >= 60020000 )
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
					#else
						surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
					#endif
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS output, out float3 customVelocity)
			{
				float3 currentTimeParams = _TimeParameters.xyz;
				_TimeParameters.xyz = timeParameters;

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord8.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord9.xyz = vertexToFrag76_g205214;
				
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord8.w = 0;
				output.ase_texcoord9.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				customVelocity = float3( 0, 0, 0 );

				_TimeParameters.xyz = currentTimeParams;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 currentVelocity;
				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, output, currentVelocity);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 previousVelocity;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test, previousVelocity);
						effectivePositionOS = previousMesh.positionOS;
					#endif

					#if defined(_ADD_PRECOMPUTED_VELOCITY)
						effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif
					#if defined(ASE_CUSTOM_MOTION_VECTOR)
						effectivePositionOS -= currentVelocity;
					#endif

					float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				output.positionCS = ASE_ADJUST_CLIP_POSITION( TransformWorldToHClip(positionRWS) );
				output.positionRWS = positionRWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;
				output.uv0 = inputMesh.uv0;
				output.uv1 = inputMesh.uv1;
				output.uv2 = inputMesh.uv2;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = inputMesh.uv0.xy;
					output.tangentWS.xy = inputMesh.uv0.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					output.vpassPositionCS = ASE_ADJUST_CLIP_POSITION( VPASSpositionCS );
					output.vpassPreviousPositionCS = ASE_ADJUST_CLIP_POSITION( VPASSpreviousPositionCS );
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplayMaterial.hlsl"

            #if defined(_TRANSPARENT_REFRACTIVE_SORT) || defined(_ENABLE_FOG_ON_TRANSPARENT)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Water/Shaders/UnderWaterUtilities.hlsl"
            #endif

            // @diogo: had to place this here due to a Unity bug
            #if ( UNITY_VERSION >= 60050001 ) && defined( UNITY_VIRTUAL_TEXTURING )
				#pragma rendertarget_format_hint MRT1 R16G16_UNorm
			#endif

            #ifdef UNITY_VIRTUAL_TEXTURING
                #ifdef OUTPUT_SPLIT_LIGHTING
                   #define DIFFUSE_LIGHTING_TARGET SV_Target2
                   #define SSS_BUFFER_TARGET SV_Target3
                #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
                   #define MOTION_VECTOR_TARGET SV_Target2
                    #ifdef _TRANSPARENT_REFRACTIVE_SORT
                        #define BEFORE_REFRACTION_TARGET SV_Target3
                        #define BEFORE_REFRACTION_ALPHA_TARGET SV_Target4
                    #endif
            	#endif
				#if defined(SHADER_API_PSSL)
					#pragma PSSL_target_output_format(target 1 FMT_32_ABGR)
				#endif
            #else
                #ifdef OUTPUT_SPLIT_LIGHTING
                #define DIFFUSE_LIGHTING_TARGET SV_Target1
                #define SSS_BUFFER_TARGET SV_Target2
                #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
                #define MOTION_VECTOR_TARGET SV_Target1
                #ifdef _TRANSPARENT_REFRACTIVE_SORT
                     #define BEFORE_REFRACTION_TARGET SV_Target2
                     #define BEFORE_REFRACTION_ALPHA_TARGET SV_Target3
                #endif
                #endif
            #endif

			void Frag(PackedVaryingsMeshToPS packedInput
						, out float4 outColor:SV_Target0
					#ifdef UNITY_VIRTUAL_TEXTURING
						, out float4 outVTFeedback : SV_Target1
					#endif
					#ifdef OUTPUT_SPLIT_LIGHTING
						, out float4 outDiffuseLighting : DIFFUSE_LIGHTING_TARGET
						, OUTPUT_SSSBUFFER(outSSSBuffer) : SSS_BUFFER_TARGET
					#elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
						, out float4 outMotionVec : MOTION_VECTOR_TARGET
						#ifdef _TRANSPARENT_REFRACTIVE_SORT
							, out float4 outBeforeRefractionColor : BEFORE_REFRACTION_TARGET
							, out float4 outBeforeRefractionAlpha : BEFORE_REFRACTION_ALPHA_TARGET
						#endif
					#endif
					#if defined( ASE_WRITE_DEPTH )
						, out float outputDepth : ASE_SV_DEPTH
					#endif
					 )
			{
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				    outMotionVec = float4(2.0, 0.0, 0.0, 1.0);
				#endif

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.positionSS = packedInput.positionCS;
				input.positionRWS = packedInput.positionRWS;
				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS, packedInput.normalWS);
				input.texCoord0 = packedInput.uv0;
				input.texCoord1 = packedInput.uv1;
				input.texCoord2 = packedInput.uv2;

				AdjustFragInputsToOffScreenRendering(input, _OffScreenRendering > 0, _OffScreenDownsampleFactor);
				uint2 tileIndex = uint2(input.positionSS.xy) / GetTileSize ();

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz, tileIndex );

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half IsFrontFace = input.isFrontFace;
				float3 PositionRWS = posInput.positionWS;
				float3 PositionWS = GetAbsolutePositionWS( posInput.positionWS );
				float3 V = GetWorldSpaceNormalizeViewDir( packedInput.positionRWS );
				float4 ScreenPosNorm = float4( posInput.positionNDC, packedInput.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, packedInput.positionCS.z ) * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos, _ProjectionParams.x );
				float3 NormalWS = packedInput.normalWS;
				float3 TangentWS = packedInput.tangentWS.xyz;
				float3 BitangentWS = input.tangentToWorld[ 1 ];
				float4 UV0 = packedInput.uv0;
				float4 UV1 = packedInput.uv1;
				float4 UV2 = packedInput.uv2;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (packedInput.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					input.tangentToWorld = BuildTangentToWorld( float4( TangentWS, -1 ), NormalWS );
					BitangentWS = input.tangentToWorld[ 1 ];
				#endif

				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord8.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord9.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(UV0.xy , UV2.xy));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				half3 Input_Albedo24_g251325 = Out_Albedo4_g251324;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251325 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251325 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251325 = staticSwitch22_g251325;
				float4 break24_g251316 = Out_Shader4_g251324;
				half Metallic95_g251316 = break24_g251316.x;
				half Input_Metallic25_g251325 = Metallic95_g251316;
				half OneMinusReflectivity31_g251325 = ( (ColorSpaceDielectricSpec23_g251325).w - ( (ColorSpaceDielectricSpec23_g251325).w * Input_Metallic25_g251325 ) );
				float3 temp_output_6_0_g251333 = ( Input_Albedo24_g251325 * OneMinusReflectivity31_g251325 );
				half Render_Common200_g251316 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251316 = _RenderMotion;
				half Render_HDRPOnly191_g251316 = ( _RenderDecals + _RenderSSR + Render_Motion186_g251316 );
				half Render_Pipeline184_g251316 = ( Render_Common200_g251316 + Render_HDRPOnly191_g251316 );
				float temp_output_7_0_g251333 = Render_Pipeline184_g251316;
				float temp_output_17_0_g251333 = ( temp_output_7_0_g251333 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251333 = ( temp_output_6_0_g251333 + temp_output_17_0_g251333 );
				#else
				float3 staticSwitch14_g251333 = temp_output_6_0_g251333;
				#endif
				
				float3 lerpResult28_g251325 = lerp( (ColorSpaceDielectricSpec23_g251325).xyz , Input_Albedo24_g251325 , Input_Metallic25_g251325);
				half3 Specular160_g251316 = lerpResult28_g251325;
				half3 Input_Specular73_g251326 = Specular160_g251316;
				half Render_Spec102_g251316 = _RenderSpecular;
				half Input_RenderSpec58_g251326 = Render_Spec102_g251316;
				half localGBufferPassCheck36_g251327 = ( 0.0 );
				half Input_True57_g251327 = 0.0;
				half True36_g251327 = Input_True57_g251327;
				half Smoothness105_g251316 = break24_g251316.w;
				half Input_Smoothness43_g251326 = Smoothness105_g251316;
				float temp_output_46_0_g251326 = max( ( Input_Smoothness43_g251326 * Input_RenderSpec58_g251326 ), 0.001 );
				half Input_False58_g251327 = temp_output_46_0_g251326;
				half False36_g251327 = Input_False58_g251327;
				half Result36_g251327 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251327 = True36_g251327;
				#else
				Result36_g251327 = False36_g251327;
				#endif
				}
				float3 temp_cast_11 = (Result36_g251327).xxx;
				#ifdef ASE_LIGHTING_SIMPLE
				float3 staticSwitch75_g251326 = temp_cast_11;
				#else
				float3 staticSwitch75_g251326 = ( Input_Specular73_g251326 * Input_RenderSpec58_g251326 );
				#endif
				
				half localGBufferPassCheck36_g251329 = ( 0.0 );
				half Input_True57_g251329 = 0.0;
				half True36_g251329 = Input_True57_g251329;
				half Input_False58_g251329 = temp_output_46_0_g251326;
				half False36_g251329 = Input_False58_g251329;
				half Result36_g251329 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result36_g251329 = True36_g251329;
				#else
				Result36_g251329 = False36_g251329;
				#endif
				}
				#ifdef ASE_LIGHTING_SIMPLE
				float staticSwitch79_g251326 = Result36_g251329;
				#else
				float staticSwitch79_g251326 = Input_Smoothness43_g251326;
				#endif
				
				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.BaseColor = staticSwitch14_g251333;
				surfaceDescription.Normal = Out_NormalWS4_g251324;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = staticSwitch75_g251326;
				#endif

				surfaceDescription.Smoothness = staticSwitch79_g251326;
				surfaceDescription.Occlusion = break24_g251316.y;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif

				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#if defined( ASE_CHANGES_WORLD_POS )
					posInput.positionWS = PositionRWS;
					#if defined( _WRITE_TRANSPARENT_MOTION_VECTOR )
						float3 positionOS = mul( GetWorldToObjectMatrix(),  float4( PositionRWS, 1.0 ) ).xyz;
						float3 previousPositionRWS = mul( GetPrevObjectToWorldMatrix(),  float4( positionOS, 1.0 ) ).xyz;
						packedInput.vpassPositionCS = mul( UNITY_MATRIX_UNJITTERED_VP, float4( PositionRWS, 1.0 ) );
						packedInput.vpassPreviousPositionCS = mul( UNITY_MATRIX_PREV_VP, float4( previousPositionRWS, 1.0 ) );
					#endif
				#endif

				#if defined( ASE_WRITE_DEPTH )
					#if !defined( _DEPTHOFFSET_ON )
						posInput.deviceDepth = posInput.deviceDepth;
					#else
						surfaceDescription.DepthOffset = 0;
					#endif
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

				PreLightData preLightData = GetPreLightData(V, posInput, bsdfData);

				outColor = float4(0.0, 0.0, 0.0, 0.0);

				#ifdef DEBUG_DISPLAY
				#ifdef OUTPUT_SPLIT_LIGHTING
					outDiffuseLighting = float4(0, 0, 0, 1);
					ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#endif

			    bool viewMaterial = GetMaterialDebugColor(outColor, input, builtinData, posInput, surfaceData, bsdfData);

				if (!viewMaterial)
				{
					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_DIFFUSE_COLOR || _DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_SPECULAR_COLOR)
					{
						float3 result = float3(0.0, 0.0, 0.0);
						GetPBRValidatorDebug(surfaceData, result);
						outColor = float4(result, 1.0f);
					}
					else if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
					else
                #endif
					{
                #ifdef _SURFACE_TYPE_TRANSPARENT
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_TRANSPARENT;
                #else
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_OPAQUE;
                #endif
						LightLoopOutput lightLoopOutput;
						LightLoop(V, posInput, preLightData, bsdfData, builtinData, featureFlags, lightLoopOutput);

						// Alias
						float3 diffuseLighting = lightLoopOutput.diffuseLighting;
						float3 specularLighting = lightLoopOutput.specularLighting;

						diffuseLighting *= GetCurrentExposureMultiplier();
						specularLighting *= GetCurrentExposureMultiplier();

                #ifdef OUTPUT_SPLIT_LIGHTING
						if (_EnableSubsurfaceScattering != 0 && ShouldOutputSplitLighting(bsdfData))
						{
							outColor = float4(specularLighting, 1.0);
							outDiffuseLighting = float4(TagLightingForSSS(diffuseLighting), 1.0);
						}
						else
						{
							outColor = float4(diffuseLighting + specularLighting, 1.0);
							outDiffuseLighting = float4(0, 0, 0, 1);
						}
						ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
                #else
						outColor = ApplyBlendMode(diffuseLighting, specularLighting, builtinData.opacity);

						#ifdef _ENABLE_FOG_ON_TRANSPARENT
                        outColor = EvaluateAtmosphericScattering(posInput, V, outColor);
                        #endif

                        #ifdef _TRANSPARENT_REFRACTIVE_SORT
                        ComputeRefractionSplitColor(posInput, outColor, outBeforeRefractionColor, outBeforeRefractionAlpha);
                        #endif
                #endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						float4 VPASSpositionCS = packedInput.vpassPositionCS;
						float4 VPASSpreviousPositionCS = packedInput.vpassPreviousPositionCS;
						bool forceNoMotion = any(unity_MotionVectorsParams.yw == 0.0);
                #if defined(HAVE_VFX_MODIFICATION) && !VFX_FEATURE_MOTION_VECTORS
                        forceNoMotion = true;
                #endif
				        if (!forceNoMotion)
						{
							float2 motionVec = CalculateMotionVector(VPASSpositionCS, VPASSpreviousPositionCS);
							EncodeMotionVector(motionVec * 0.5, outMotionVec);
							outMotionVec.zw = 1.0;
						}
				#endif
				}

				#ifdef DEBUG_DISPLAY
				}
				#endif

				#if defined( ASE_WRITE_DEPTH )
					outputDepth = posInput.deviceDepth;
				#endif

                #ifdef UNITY_VIRTUAL_TEXTURING
				    float vtAlphaValue = builtinData.opacity;
                    #if defined(HAS_REFRACTION) && HAS_REFRACTION
					vtAlphaValue = 1.0f - bsdfData.transmittanceMask;
                #endif
				outVTFeedback = PackVTFeedbackWithAlpha(builtinData.vtPackedFeedback, input.positionSS.xy, vtAlphaValue);
				outVTFeedback.rgb *= outVTFeedback.a; // premuliplied alpha
                #endif

			}
			ENDHLSL
		}

		
		Pass
        {
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }

            Cull [_CullMode]

            HLSLPROGRAM
			#define ASE_GEOMETRY
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define ASE_FRAGMENT_NORMAL 0
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _AMBIENT_OCCLUSION 1
			#define ASE_VERSION 19912
			#define ASE_SRP_VERSION 170004
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma editor_sync_compilation
            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_TANGENT_TO_WORLD

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

            #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            #undef _MATERIAL_FEATURE_CLEAR_COAT
            #endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

            CBUFFER_START( UnityPerMaterial )
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _main_coord_value;
			half4 _MainOcclusionRemap;
			half4 _MainCoordValue;
			half4 _MainSmoothnessRemap;
			half4 _MainMultiWriteRemap;
			half _MainOcclusionChannelMode;
			half _MainOcclusionSourceMode;
			half _MainOcclusionValue;
			half _MainSmoothnessChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainSmoothnessValue;
			half _MainMultiChannelMode;
			half _MainMultiSourceMode;
			half _MainMetallicValue;
			half _MainColorMode;
			half _MainAlphaChannelMode;
			half _MainAlphaSourceMode;
			half _MainAlphaClipValue;
			half _RenderCull;
			half _RenderZWrite;
			half _RenderQueue;
			half _RenderPriority;
			half _RenderBakeGI;
			half _RenderNormal;
			half _RenderFilter;
			half _RenderClip;
			half _RenderDecals;
			half _RenderSSR;
			half _RenderMotion;
			half _MainNormalValue;
			half _MainMetallicSourceMode;
			half _render_src;
			half _RenderSpecular;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _IsShared;
			half _UseExternalSettings;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _RenderMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _AlphaCutoffShadow;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _DstBlend2;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			UNITY_TEXTURE_STREAMING_DEBUG_VARS;
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS;  
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			   
			struct TVEVertexData
			{   
				half Dummy;   
				float3 PositionOS;   
				half3 NormalOS;   
				half4 TangentOS;   
				half4 TransformData;   
				half4 RotationData;   
				float4 Interpolator;   
			};   
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;    
				float3 PositionWS;    
				float3 PositionWO;    
				float3 PositionRawOS;    
				float3 PivotOS;    
				float3 PivotWS;    
				float3 PivotWO;    
				half3 NormalOS;    
				half3 NormalWS;    
				half3 NormalRawOS;    
				half4 TangentOS;    
				half3 TangentWS;    
				half3 BitangentWS;    
				half3 TriplanarWeights;    
				half3 ViewDirWS;    
				float4 CoordsData;    
				half4 VertexData;    
				half4 MasksData;    
				half4 PhaseData;    
				half4 TransformData;    
				half4 RotationData;    
				float4 Interpolator;    
			};    
			     
			struct TVEGlobalData
			{     
				half Dummy;     
				half4 CoatTexture;
				half4 DrawTexture;
				half4 PaintTexture;
				half4 AtmoTexture;
				half4 EffexTexture;
				half4 GlowTexture;
				float4 FormTexture;
				float4 LandTexture;
				float4 VertxTexture;
				half4 FlowTexture;
				half4 UserTexture;
			};     
			      
			struct TVEMasksData
			{      
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};      
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			half3 ComputeTriplanarMasks( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( inout TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_Interpolator )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.Interpolator = In_Interpolator;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_Interpolator )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_Interpolator = Data.Interpolator;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                //BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);

            }

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS output;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_positionWS = GetAbsolutePositionWS( TransformObjectToWorld( ( inputMesh.positionOS ).xyz ) );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord3.xyz = vertexToFrag73_g205214;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205217 = ObjectPosition_UNITY_MATRIX_M();
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205217 = ( localObjectPosition_UNITY_MATRIX_M14_g205217 + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205217 = localObjectPosition_UNITY_MATRIX_M14_g205217;
				#endif
				float3 temp_output_340_7_g205214 = staticSwitch13_g205217;
				float3 localObjectPosition_UNITY_MATRIX_M14_g205219 = ObjectPosition_UNITY_MATRIX_M();
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				float3 PositionOS131_g205214 = inputMesh.positionOS;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g205219 = ( ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g205219 = ( localObjectPosition_UNITY_MATRIX_M14_g205219 + PivotsOnlyWS105_g205219 );
				#endif
				float3 temp_output_341_7_g205214 = staticSwitch13_g205219;
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord4.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord5.xy = inputMesh.ase_texcoord.xy;
				output.ase_texcoord5.zw = inputMesh.ase_texcoord2.xy;
				output.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				output.positionCS = ASE_ADJUST_CLIP_POSITION( TransformWorldToHClip(positionRWS) );
				output.positionRWS = positionRWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) || defined(WRITE_RENDERING_LAYER)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif
						#if defined( ASE_WRITE_DEPTH )
							, out float outputDepth : ASE_SV_DEPTH
						#endif
						 )
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.positionSS = packedInput.positionCS;
				input.positionRWS = packedInput.positionRWS;
				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS, packedInput.normalWS);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
					input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
					#if defined(ASE_NEED_CULLFACE)
						input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
					#endif
				#endif

				half isFrontFace = input.isFrontFace;
				float3 PositionRWS = posInput.positionWS;
				float3 PositionWS = GetAbsolutePositionWS( posInput.positionWS );
				float3 V = GetWorldSpaceNormalizeViewDir( packedInput.positionRWS );
				float4 ScreenPosNorm = float4( posInput.positionNDC, packedInput.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, packedInput.positionCS.z ) * packedInput.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos, _ProjectionParams.x );
				float3 NormalWS = packedInput.normalWS;
				float3 TangentWS = packedInput.tangentWS.xyz;
				float3 BitangentWS = input.tangentToWorld[ 1 ];

				float localCustomAlphaClip21_g251332 = ( 0.0 );
				float localBreakVisualData4_g251324 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207106 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207106 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207106;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = packedInput.ase_texcoord3.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = packedInput.ase_texcoord4.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarMasks427_g205214 = ComputeTriplanarMasks( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarMasks427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(packedInput.ase_texcoord5.xy , packedInput.ase_texcoord5.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = packedInput.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205225 = _ObjectPhaseMode;
				float Option70_g205225 = temp_output_17_0_g205225;
				float4 temp_output_3_0_g205225 = packedInput.ase_color;
				float4 Channel70_g205225 = temp_output_3_0_g205225;
				float localSwitchChannel470_g205225 = SwitchChannel4( Option70_g205225 , Channel70_g205225 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205225;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4((frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_Interpolator16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_Interpolator16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_Interpolator15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_Interpolator15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207106;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207106;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				half3 NormalWS512_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = NormalWS512_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207106;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				half3 Triplanar522_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = Triplanar522_g207093;
				half3 NormalWS490_g207093 = NormalWS512_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207106;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = NormalWS512_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207106;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = Triplanar522_g207093;
				half3 NormalWS500_g207093 = NormalWS512_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207107) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207113 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207113 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207107 = staticSwitch38_g207113;
				float localBreakTextureData456_g207107 = ( 0.0 );
				TVEMasksData Data456_g207107 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207107 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207107 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207107 , Out_MaskA456_g207107 , Out_MaskB456_g207107 , Out_MaskC456_g207107 , Out_MaskD456_g207107 , Out_MaskE456_g207107 , Out_MaskF456_g207107 , Out_MaskG456_g207107 , Out_MaskH456_g207107 , Out_MaskI456_g207107 , Out_MaskJ456_g207107 , Out_MaskK456_g207107 , Out_MaskL456_g207107 , Out_MaskM456_g207107 , Out_MaskN456_g207107 );
				half2 UV276_g207107 = (Out_MaskA456_g207107).xy;
				float temp_output_504_0_g207107 = 0.0;
				half Bias276_g207107 = temp_output_504_0_g207107;
				half2 Normal276_g207107 = float2( 0,0 );
				half4 localSampleCoord276_g207107 = SampleCoord( Texture276_g207107 , Sampler276_g207107 , UV276_g207107 , Bias276_g207107 , Normal276_g207107 );
				TEXTURE2D(Texture502_g207107) = _MainShaderTex;
				SamplerState Sampler502_g207107 = staticSwitch38_g207113;
				half2 UV502_g207107 = (Out_MaskA456_g207107).zw;
				half Bias502_g207107 = temp_output_504_0_g207107;
				half2 Normal502_g207107 = float2( 0,0 );
				half4 localSampleCoord502_g207107 = SampleCoord( Texture502_g207107 , Sampler502_g207107 , UV502_g207107 , Bias502_g207107 , Normal502_g207107 );
				TEXTURE2D(Texture496_g207107) = _MainShaderTex;
				SamplerState Sampler496_g207107 = staticSwitch38_g207113;
				float2 temp_output_463_0_g207107 = (Out_MaskB456_g207107).zw;
				half2 XZ496_g207107 = temp_output_463_0_g207107;
				half Bias496_g207107 = temp_output_504_0_g207107;
				half3 NormalWS512_g207107 = (Out_MaskK456_g207107).xyz;
				half3 NormalWS496_g207107 = NormalWS512_g207107;
				half3 Normal496_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207107 = SamplePlanar2D( Texture496_g207107 , Sampler496_g207107 , XZ496_g207107 , Bias496_g207107 , NormalWS496_g207107 , Normal496_g207107 );
				TEXTURE2D(Texture490_g207107) = _MainShaderTex;
				SamplerState Sampler490_g207107 = staticSwitch38_g207113;
				float2 temp_output_462_0_g207107 = (Out_MaskB456_g207107).xy;
				half2 ZY490_g207107 = temp_output_462_0_g207107;
				half2 XZ490_g207107 = temp_output_463_0_g207107;
				float2 temp_output_464_0_g207107 = (Out_MaskC456_g207107).xy;
				half2 XY490_g207107 = temp_output_464_0_g207107;
				half Bias490_g207107 = temp_output_504_0_g207107;
				half3 Triplanar522_g207107 = (Out_MaskN456_g207107).xyz;
				half3 Triplanar490_g207107 = Triplanar522_g207107;
				half3 NormalWS490_g207107 = NormalWS512_g207107;
				half3 Normal490_g207107 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207107 = SamplePlanar3D( Texture490_g207107 , Sampler490_g207107 , ZY490_g207107 , XZ490_g207107 , XY490_g207107 , Bias490_g207107 , Triplanar490_g207107 , NormalWS490_g207107 , Normal490_g207107 );
				TEXTURE2D(Texture498_g207107) = _MainShaderTex;
				SamplerState Sampler498_g207107 = staticSwitch38_g207113;
				half2 XZ498_g207107 = temp_output_463_0_g207107;
				float2 temp_output_473_0_g207107 = (Out_MaskE456_g207107).xy;
				half2 XZ_1498_g207107 = temp_output_473_0_g207107;
				float2 temp_output_474_0_g207107 = (Out_MaskE456_g207107).zw;
				half2 XZ_2498_g207107 = temp_output_474_0_g207107;
				float2 temp_output_475_0_g207107 = (Out_MaskF456_g207107).xy;
				half2 XZ_3498_g207107 = temp_output_475_0_g207107;
				float temp_output_510_0_g207107 = exp2( temp_output_504_0_g207107 );
				half Bias498_g207107 = temp_output_510_0_g207107;
				float3 temp_output_480_0_g207107 = (Out_MaskI456_g207107).xyz;
				half3 Weights_2498_g207107 = temp_output_480_0_g207107;
				half3 NormalWS498_g207107 = NormalWS512_g207107;
				half3 Normal498_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207107 = SampleStochastic2D( Texture498_g207107 , Sampler498_g207107 , XZ498_g207107 , XZ_1498_g207107 , XZ_2498_g207107 , XZ_3498_g207107 , Bias498_g207107 , Weights_2498_g207107 , NormalWS498_g207107 , Normal498_g207107 );
				TEXTURE2D(Texture500_g207107) = _MainShaderTex;
				SamplerState Sampler500_g207107 = staticSwitch38_g207113;
				half2 ZY500_g207107 = temp_output_462_0_g207107;
				half2 ZY_1500_g207107 = (Out_MaskC456_g207107).zw;
				half2 ZY_2500_g207107 = (Out_MaskD456_g207107).xy;
				half2 ZY_3500_g207107 = (Out_MaskD456_g207107).zw;
				half2 XZ500_g207107 = temp_output_463_0_g207107;
				half2 XZ_1500_g207107 = temp_output_473_0_g207107;
				half2 XZ_2500_g207107 = temp_output_474_0_g207107;
				half2 XZ_3500_g207107 = temp_output_475_0_g207107;
				half2 XY500_g207107 = temp_output_464_0_g207107;
				half2 XY_1500_g207107 = (Out_MaskF456_g207107).zw;
				half2 XY_2500_g207107 = (Out_MaskG456_g207107).xy;
				half2 XY_3500_g207107 = (Out_MaskG456_g207107).zw;
				half Bias500_g207107 = temp_output_510_0_g207107;
				half3 Weights_1500_g207107 = (Out_MaskH456_g207107).xyz;
				half3 Weights_2500_g207107 = temp_output_480_0_g207107;
				half3 Weights_3500_g207107 = (Out_MaskJ456_g207107).xyz;
				half3 Triplanar500_g207107 = Triplanar522_g207107;
				half3 NormalWS500_g207107 = NormalWS512_g207107;
				half3 Normal500_g207107 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207107 = SampleStochastic3D( Texture500_g207107 , Sampler500_g207107 , ZY500_g207107 , ZY_1500_g207107 , ZY_2500_g207107 , ZY_3500_g207107 , XZ500_g207107 , XZ_1500_g207107 , XZ_2500_g207107 , XZ_3500_g207107 , XY500_g207107 , XY_1500_g207107 , XY_2500_g207107 , XY_3500_g207107 , Bias500_g207107 , Weights_1500_g207107 , Weights_2500_g207107 , Weights_3500_g207107 , Triplanar500_g207107 , NormalWS500_g207107 , Normal500_g207107 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207107;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207107;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207107;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207107;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251313 = _MainMetallicChannelMode;
				float Option83_g251313 = temp_output_17_0_g251313;
				TEXTURE2D(Texture276_g207121) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207127 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207127 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207121 = staticSwitch38_g207127;
				float localBreakTextureData456_g207121 = ( 0.0 );
				TVEMasksData Data456_g207121 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207121 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207121 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207121 , Out_MaskA456_g207121 , Out_MaskB456_g207121 , Out_MaskC456_g207121 , Out_MaskD456_g207121 , Out_MaskE456_g207121 , Out_MaskF456_g207121 , Out_MaskG456_g207121 , Out_MaskH456_g207121 , Out_MaskI456_g207121 , Out_MaskJ456_g207121 , Out_MaskK456_g207121 , Out_MaskL456_g207121 , Out_MaskM456_g207121 , Out_MaskN456_g207121 );
				half2 UV276_g207121 = (Out_MaskA456_g207121).xy;
				float temp_output_504_0_g207121 = 0.0;
				half Bias276_g207121 = temp_output_504_0_g207121;
				half2 Normal276_g207121 = float2( 0,0 );
				half4 localSampleCoord276_g207121 = SampleCoord( Texture276_g207121 , Sampler276_g207121 , UV276_g207121 , Bias276_g207121 , Normal276_g207121 );
				TEXTURE2D(Texture502_g207121) = _MainMetallicTex;
				SamplerState Sampler502_g207121 = staticSwitch38_g207127;
				half2 UV502_g207121 = (Out_MaskA456_g207121).zw;
				half Bias502_g207121 = temp_output_504_0_g207121;
				half2 Normal502_g207121 = float2( 0,0 );
				half4 localSampleCoord502_g207121 = SampleCoord( Texture502_g207121 , Sampler502_g207121 , UV502_g207121 , Bias502_g207121 , Normal502_g207121 );
				TEXTURE2D(Texture496_g207121) = _MainMetallicTex;
				SamplerState Sampler496_g207121 = staticSwitch38_g207127;
				float2 temp_output_463_0_g207121 = (Out_MaskB456_g207121).zw;
				half2 XZ496_g207121 = temp_output_463_0_g207121;
				half Bias496_g207121 = temp_output_504_0_g207121;
				half3 NormalWS512_g207121 = (Out_MaskK456_g207121).xyz;
				half3 NormalWS496_g207121 = NormalWS512_g207121;
				half3 Normal496_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207121 = SamplePlanar2D( Texture496_g207121 , Sampler496_g207121 , XZ496_g207121 , Bias496_g207121 , NormalWS496_g207121 , Normal496_g207121 );
				TEXTURE2D(Texture490_g207121) = _MainMetallicTex;
				SamplerState Sampler490_g207121 = staticSwitch38_g207127;
				float2 temp_output_462_0_g207121 = (Out_MaskB456_g207121).xy;
				half2 ZY490_g207121 = temp_output_462_0_g207121;
				half2 XZ490_g207121 = temp_output_463_0_g207121;
				float2 temp_output_464_0_g207121 = (Out_MaskC456_g207121).xy;
				half2 XY490_g207121 = temp_output_464_0_g207121;
				half Bias490_g207121 = temp_output_504_0_g207121;
				half3 Triplanar522_g207121 = (Out_MaskN456_g207121).xyz;
				half3 Triplanar490_g207121 = Triplanar522_g207121;
				half3 NormalWS490_g207121 = NormalWS512_g207121;
				half3 Normal490_g207121 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207121 = SamplePlanar3D( Texture490_g207121 , Sampler490_g207121 , ZY490_g207121 , XZ490_g207121 , XY490_g207121 , Bias490_g207121 , Triplanar490_g207121 , NormalWS490_g207121 , Normal490_g207121 );
				TEXTURE2D(Texture498_g207121) = _MainMetallicTex;
				SamplerState Sampler498_g207121 = staticSwitch38_g207127;
				half2 XZ498_g207121 = temp_output_463_0_g207121;
				float2 temp_output_473_0_g207121 = (Out_MaskE456_g207121).xy;
				half2 XZ_1498_g207121 = temp_output_473_0_g207121;
				float2 temp_output_474_0_g207121 = (Out_MaskE456_g207121).zw;
				half2 XZ_2498_g207121 = temp_output_474_0_g207121;
				float2 temp_output_475_0_g207121 = (Out_MaskF456_g207121).xy;
				half2 XZ_3498_g207121 = temp_output_475_0_g207121;
				float temp_output_510_0_g207121 = exp2( temp_output_504_0_g207121 );
				half Bias498_g207121 = temp_output_510_0_g207121;
				float3 temp_output_480_0_g207121 = (Out_MaskI456_g207121).xyz;
				half3 Weights_2498_g207121 = temp_output_480_0_g207121;
				half3 NormalWS498_g207121 = NormalWS512_g207121;
				half3 Normal498_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207121 = SampleStochastic2D( Texture498_g207121 , Sampler498_g207121 , XZ498_g207121 , XZ_1498_g207121 , XZ_2498_g207121 , XZ_3498_g207121 , Bias498_g207121 , Weights_2498_g207121 , NormalWS498_g207121 , Normal498_g207121 );
				TEXTURE2D(Texture500_g207121) = _MainMetallicTex;
				SamplerState Sampler500_g207121 = staticSwitch38_g207127;
				half2 ZY500_g207121 = temp_output_462_0_g207121;
				half2 ZY_1500_g207121 = (Out_MaskC456_g207121).zw;
				half2 ZY_2500_g207121 = (Out_MaskD456_g207121).xy;
				half2 ZY_3500_g207121 = (Out_MaskD456_g207121).zw;
				half2 XZ500_g207121 = temp_output_463_0_g207121;
				half2 XZ_1500_g207121 = temp_output_473_0_g207121;
				half2 XZ_2500_g207121 = temp_output_474_0_g207121;
				half2 XZ_3500_g207121 = temp_output_475_0_g207121;
				half2 XY500_g207121 = temp_output_464_0_g207121;
				half2 XY_1500_g207121 = (Out_MaskF456_g207121).zw;
				half2 XY_2500_g207121 = (Out_MaskG456_g207121).xy;
				half2 XY_3500_g207121 = (Out_MaskG456_g207121).zw;
				half Bias500_g207121 = temp_output_510_0_g207121;
				half3 Weights_1500_g207121 = (Out_MaskH456_g207121).xyz;
				half3 Weights_2500_g207121 = temp_output_480_0_g207121;
				half3 Weights_3500_g207121 = (Out_MaskJ456_g207121).xyz;
				half3 Triplanar500_g207121 = Triplanar522_g207121;
				half3 NormalWS500_g207121 = NormalWS512_g207121;
				half3 Normal500_g207121 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207121 = SampleStochastic3D( Texture500_g207121 , Sampler500_g207121 , ZY500_g207121 , ZY_1500_g207121 , ZY_2500_g207121 , ZY_3500_g207121 , XZ500_g207121 , XZ_1500_g207121 , XZ_2500_g207121 , XZ_3500_g207121 , XY500_g207121 , XY_1500_g207121 , XY_2500_g207121 , XY_3500_g207121 , Bias500_g207121 , Weights_1500_g207121 , Weights_2500_g207121 , Weights_3500_g207121 , Triplanar500_g207121 , NormalWS500_g207121 , Normal500_g207121 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207121;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207121;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207121;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207121;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 temp_output_84_0_g251313 = Local_MetallicTex341_g207086;
				float4 ChannelA83_g251313 = temp_output_84_0_g251313;
				float4 temp_output_85_0_g251313 = ( 1.0 - Local_MetallicTex341_g207086 );
				float4 ChannelB83_g251313 = temp_output_85_0_g251313;
				float localSwitchChannel883_g251313 = SwitchChannel8( Option83_g251313 , ChannelA83_g251313 , ChannelB83_g251313 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251313 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251312 = _MainOcclusionChannelMode;
				float Option83_g251312 = temp_output_17_0_g251312;
				TEXTURE2D(Texture276_g207128) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207148 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207148 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207128 = staticSwitch38_g207148;
				float localBreakTextureData456_g207128 = ( 0.0 );
				TVEMasksData Data456_g207128 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207128 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207128 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207128 , Out_MaskA456_g207128 , Out_MaskB456_g207128 , Out_MaskC456_g207128 , Out_MaskD456_g207128 , Out_MaskE456_g207128 , Out_MaskF456_g207128 , Out_MaskG456_g207128 , Out_MaskH456_g207128 , Out_MaskI456_g207128 , Out_MaskJ456_g207128 , Out_MaskK456_g207128 , Out_MaskL456_g207128 , Out_MaskM456_g207128 , Out_MaskN456_g207128 );
				half2 UV276_g207128 = (Out_MaskA456_g207128).xy;
				float temp_output_504_0_g207128 = 0.0;
				half Bias276_g207128 = temp_output_504_0_g207128;
				half2 Normal276_g207128 = float2( 0,0 );
				half4 localSampleCoord276_g207128 = SampleCoord( Texture276_g207128 , Sampler276_g207128 , UV276_g207128 , Bias276_g207128 , Normal276_g207128 );
				TEXTURE2D(Texture502_g207128) = _MainOcclusionTex;
				SamplerState Sampler502_g207128 = staticSwitch38_g207148;
				half2 UV502_g207128 = (Out_MaskA456_g207128).zw;
				half Bias502_g207128 = temp_output_504_0_g207128;
				half2 Normal502_g207128 = float2( 0,0 );
				half4 localSampleCoord502_g207128 = SampleCoord( Texture502_g207128 , Sampler502_g207128 , UV502_g207128 , Bias502_g207128 , Normal502_g207128 );
				TEXTURE2D(Texture496_g207128) = _MainOcclusionTex;
				SamplerState Sampler496_g207128 = staticSwitch38_g207148;
				float2 temp_output_463_0_g207128 = (Out_MaskB456_g207128).zw;
				half2 XZ496_g207128 = temp_output_463_0_g207128;
				half Bias496_g207128 = temp_output_504_0_g207128;
				half3 NormalWS512_g207128 = (Out_MaskK456_g207128).xyz;
				half3 NormalWS496_g207128 = NormalWS512_g207128;
				half3 Normal496_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207128 = SamplePlanar2D( Texture496_g207128 , Sampler496_g207128 , XZ496_g207128 , Bias496_g207128 , NormalWS496_g207128 , Normal496_g207128 );
				TEXTURE2D(Texture490_g207128) = _MainOcclusionTex;
				SamplerState Sampler490_g207128 = staticSwitch38_g207148;
				float2 temp_output_462_0_g207128 = (Out_MaskB456_g207128).xy;
				half2 ZY490_g207128 = temp_output_462_0_g207128;
				half2 XZ490_g207128 = temp_output_463_0_g207128;
				float2 temp_output_464_0_g207128 = (Out_MaskC456_g207128).xy;
				half2 XY490_g207128 = temp_output_464_0_g207128;
				half Bias490_g207128 = temp_output_504_0_g207128;
				half3 Triplanar522_g207128 = (Out_MaskN456_g207128).xyz;
				half3 Triplanar490_g207128 = Triplanar522_g207128;
				half3 NormalWS490_g207128 = NormalWS512_g207128;
				half3 Normal490_g207128 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207128 = SamplePlanar3D( Texture490_g207128 , Sampler490_g207128 , ZY490_g207128 , XZ490_g207128 , XY490_g207128 , Bias490_g207128 , Triplanar490_g207128 , NormalWS490_g207128 , Normal490_g207128 );
				TEXTURE2D(Texture498_g207128) = _MainOcclusionTex;
				SamplerState Sampler498_g207128 = staticSwitch38_g207148;
				half2 XZ498_g207128 = temp_output_463_0_g207128;
				float2 temp_output_473_0_g207128 = (Out_MaskE456_g207128).xy;
				half2 XZ_1498_g207128 = temp_output_473_0_g207128;
				float2 temp_output_474_0_g207128 = (Out_MaskE456_g207128).zw;
				half2 XZ_2498_g207128 = temp_output_474_0_g207128;
				float2 temp_output_475_0_g207128 = (Out_MaskF456_g207128).xy;
				half2 XZ_3498_g207128 = temp_output_475_0_g207128;
				float temp_output_510_0_g207128 = exp2( temp_output_504_0_g207128 );
				half Bias498_g207128 = temp_output_510_0_g207128;
				float3 temp_output_480_0_g207128 = (Out_MaskI456_g207128).xyz;
				half3 Weights_2498_g207128 = temp_output_480_0_g207128;
				half3 NormalWS498_g207128 = NormalWS512_g207128;
				half3 Normal498_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207128 = SampleStochastic2D( Texture498_g207128 , Sampler498_g207128 , XZ498_g207128 , XZ_1498_g207128 , XZ_2498_g207128 , XZ_3498_g207128 , Bias498_g207128 , Weights_2498_g207128 , NormalWS498_g207128 , Normal498_g207128 );
				TEXTURE2D(Texture500_g207128) = _MainOcclusionTex;
				SamplerState Sampler500_g207128 = staticSwitch38_g207148;
				half2 ZY500_g207128 = temp_output_462_0_g207128;
				half2 ZY_1500_g207128 = (Out_MaskC456_g207128).zw;
				half2 ZY_2500_g207128 = (Out_MaskD456_g207128).xy;
				half2 ZY_3500_g207128 = (Out_MaskD456_g207128).zw;
				half2 XZ500_g207128 = temp_output_463_0_g207128;
				half2 XZ_1500_g207128 = temp_output_473_0_g207128;
				half2 XZ_2500_g207128 = temp_output_474_0_g207128;
				half2 XZ_3500_g207128 = temp_output_475_0_g207128;
				half2 XY500_g207128 = temp_output_464_0_g207128;
				half2 XY_1500_g207128 = (Out_MaskF456_g207128).zw;
				half2 XY_2500_g207128 = (Out_MaskG456_g207128).xy;
				half2 XY_3500_g207128 = (Out_MaskG456_g207128).zw;
				half Bias500_g207128 = temp_output_510_0_g207128;
				half3 Weights_1500_g207128 = (Out_MaskH456_g207128).xyz;
				half3 Weights_2500_g207128 = temp_output_480_0_g207128;
				half3 Weights_3500_g207128 = (Out_MaskJ456_g207128).xyz;
				half3 Triplanar500_g207128 = Triplanar522_g207128;
				half3 NormalWS500_g207128 = NormalWS512_g207128;
				half3 Normal500_g207128 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207128 = SampleStochastic3D( Texture500_g207128 , Sampler500_g207128 , ZY500_g207128 , ZY_1500_g207128 , ZY_2500_g207128 , ZY_3500_g207128 , XZ500_g207128 , XZ_1500_g207128 , XZ_2500_g207128 , XZ_3500_g207128 , XY500_g207128 , XY_1500_g207128 , XY_2500_g207128 , XY_3500_g207128 , Bias500_g207128 , Weights_1500_g207128 , Weights_2500_g207128 , Weights_3500_g207128 , Triplanar500_g207128 , NormalWS500_g207128 , Normal500_g207128 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207128;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207128;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207128;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207128;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 temp_output_84_0_g251312 = Local_OcclusionTex349_g207086;
				float4 ChannelA83_g251312 = temp_output_84_0_g251312;
				float4 temp_output_85_0_g251312 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float4 ChannelB83_g251312 = temp_output_85_0_g251312;
				float localSwitchChannel883_g251312 = SwitchChannel8( Option83_g251312 , ChannelA83_g251312 , ChannelB83_g251312 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251312 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option70_g251307 = temp_output_17_0_g251307;
				float4 temp_output_3_0_g251307 = float4( 0,0,0,0 );
				float4 Channel70_g251307 = temp_output_3_0_g251307;
				float localSwitchChannel470_g251307 = SwitchChannel4( Option70_g251307 , Channel70_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel470_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251314 = _MainMultiChannelMode;
				float Option83_g251314 = temp_output_17_0_g251314;
				TEXTURE2D(Texture276_g207134) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207140 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207140 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207134 = staticSwitch38_g207140;
				float localBreakTextureData456_g207134 = ( 0.0 );
				TVEMasksData Data456_g207134 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207134 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207134 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207134 , Out_MaskA456_g207134 , Out_MaskB456_g207134 , Out_MaskC456_g207134 , Out_MaskD456_g207134 , Out_MaskE456_g207134 , Out_MaskF456_g207134 , Out_MaskG456_g207134 , Out_MaskH456_g207134 , Out_MaskI456_g207134 , Out_MaskJ456_g207134 , Out_MaskK456_g207134 , Out_MaskL456_g207134 , Out_MaskM456_g207134 , Out_MaskN456_g207134 );
				half2 UV276_g207134 = (Out_MaskA456_g207134).xy;
				float temp_output_504_0_g207134 = 0.0;
				half Bias276_g207134 = temp_output_504_0_g207134;
				half2 Normal276_g207134 = float2( 0,0 );
				half4 localSampleCoord276_g207134 = SampleCoord( Texture276_g207134 , Sampler276_g207134 , UV276_g207134 , Bias276_g207134 , Normal276_g207134 );
				TEXTURE2D(Texture502_g207134) = _MainMultiTex;
				SamplerState Sampler502_g207134 = staticSwitch38_g207140;
				half2 UV502_g207134 = (Out_MaskA456_g207134).zw;
				half Bias502_g207134 = temp_output_504_0_g207134;
				half2 Normal502_g207134 = float2( 0,0 );
				half4 localSampleCoord502_g207134 = SampleCoord( Texture502_g207134 , Sampler502_g207134 , UV502_g207134 , Bias502_g207134 , Normal502_g207134 );
				TEXTURE2D(Texture496_g207134) = _MainMultiTex;
				SamplerState Sampler496_g207134 = staticSwitch38_g207140;
				float2 temp_output_463_0_g207134 = (Out_MaskB456_g207134).zw;
				half2 XZ496_g207134 = temp_output_463_0_g207134;
				half Bias496_g207134 = temp_output_504_0_g207134;
				half3 NormalWS512_g207134 = (Out_MaskK456_g207134).xyz;
				half3 NormalWS496_g207134 = NormalWS512_g207134;
				half3 Normal496_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207134 = SamplePlanar2D( Texture496_g207134 , Sampler496_g207134 , XZ496_g207134 , Bias496_g207134 , NormalWS496_g207134 , Normal496_g207134 );
				TEXTURE2D(Texture490_g207134) = _MainMultiTex;
				SamplerState Sampler490_g207134 = staticSwitch38_g207140;
				float2 temp_output_462_0_g207134 = (Out_MaskB456_g207134).xy;
				half2 ZY490_g207134 = temp_output_462_0_g207134;
				half2 XZ490_g207134 = temp_output_463_0_g207134;
				float2 temp_output_464_0_g207134 = (Out_MaskC456_g207134).xy;
				half2 XY490_g207134 = temp_output_464_0_g207134;
				half Bias490_g207134 = temp_output_504_0_g207134;
				half3 Triplanar522_g207134 = (Out_MaskN456_g207134).xyz;
				half3 Triplanar490_g207134 = Triplanar522_g207134;
				half3 NormalWS490_g207134 = NormalWS512_g207134;
				half3 Normal490_g207134 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207134 = SamplePlanar3D( Texture490_g207134 , Sampler490_g207134 , ZY490_g207134 , XZ490_g207134 , XY490_g207134 , Bias490_g207134 , Triplanar490_g207134 , NormalWS490_g207134 , Normal490_g207134 );
				TEXTURE2D(Texture498_g207134) = _MainMultiTex;
				SamplerState Sampler498_g207134 = staticSwitch38_g207140;
				half2 XZ498_g207134 = temp_output_463_0_g207134;
				float2 temp_output_473_0_g207134 = (Out_MaskE456_g207134).xy;
				half2 XZ_1498_g207134 = temp_output_473_0_g207134;
				float2 temp_output_474_0_g207134 = (Out_MaskE456_g207134).zw;
				half2 XZ_2498_g207134 = temp_output_474_0_g207134;
				float2 temp_output_475_0_g207134 = (Out_MaskF456_g207134).xy;
				half2 XZ_3498_g207134 = temp_output_475_0_g207134;
				float temp_output_510_0_g207134 = exp2( temp_output_504_0_g207134 );
				half Bias498_g207134 = temp_output_510_0_g207134;
				float3 temp_output_480_0_g207134 = (Out_MaskI456_g207134).xyz;
				half3 Weights_2498_g207134 = temp_output_480_0_g207134;
				half3 NormalWS498_g207134 = NormalWS512_g207134;
				half3 Normal498_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207134 = SampleStochastic2D( Texture498_g207134 , Sampler498_g207134 , XZ498_g207134 , XZ_1498_g207134 , XZ_2498_g207134 , XZ_3498_g207134 , Bias498_g207134 , Weights_2498_g207134 , NormalWS498_g207134 , Normal498_g207134 );
				TEXTURE2D(Texture500_g207134) = _MainMultiTex;
				SamplerState Sampler500_g207134 = staticSwitch38_g207140;
				half2 ZY500_g207134 = temp_output_462_0_g207134;
				half2 ZY_1500_g207134 = (Out_MaskC456_g207134).zw;
				half2 ZY_2500_g207134 = (Out_MaskD456_g207134).xy;
				half2 ZY_3500_g207134 = (Out_MaskD456_g207134).zw;
				half2 XZ500_g207134 = temp_output_463_0_g207134;
				half2 XZ_1500_g207134 = temp_output_473_0_g207134;
				half2 XZ_2500_g207134 = temp_output_474_0_g207134;
				half2 XZ_3500_g207134 = temp_output_475_0_g207134;
				half2 XY500_g207134 = temp_output_464_0_g207134;
				half2 XY_1500_g207134 = (Out_MaskF456_g207134).zw;
				half2 XY_2500_g207134 = (Out_MaskG456_g207134).xy;
				half2 XY_3500_g207134 = (Out_MaskG456_g207134).zw;
				half Bias500_g207134 = temp_output_510_0_g207134;
				half3 Weights_1500_g207134 = (Out_MaskH456_g207134).xyz;
				half3 Weights_2500_g207134 = temp_output_480_0_g207134;
				half3 Weights_3500_g207134 = (Out_MaskJ456_g207134).xyz;
				half3 Triplanar500_g207134 = Triplanar522_g207134;
				half3 NormalWS500_g207134 = NormalWS512_g207134;
				half3 Normal500_g207134 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207134 = SampleStochastic3D( Texture500_g207134 , Sampler500_g207134 , ZY500_g207134 , ZY_1500_g207134 , ZY_2500_g207134 , ZY_3500_g207134 , XZ500_g207134 , XZ_1500_g207134 , XZ_2500_g207134 , XZ_3500_g207134 , XY500_g207134 , XY_1500_g207134 , XY_2500_g207134 , XY_3500_g207134 , Bias500_g207134 , Weights_1500_g207134 , Weights_2500_g207134 , Weights_3500_g207134 , Triplanar500_g207134 , NormalWS500_g207134 , Normal500_g207134 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207134;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207134;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207134;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207134;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 temp_output_84_0_g251314 = Local_MultiTex357_g207086;
				float4 ChannelA83_g251314 = temp_output_84_0_g251314;
				float4 temp_output_85_0_g251314 = ( 1.0 - Local_MultiTex357_g207086 );
				float4 ChannelB83_g251314 = temp_output_85_0_g251314;
				float localSwitchChannel883_g251314 = SwitchChannel8( Option83_g251314 , ChannelA83_g251314 , ChannelB83_g251314 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251314 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiWriteRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				float temp_output_42_0_g207086 = saturate( ( temp_output_9_0_g251303 * _MainMultiWriteRemap.z ) );
				half Local_MultiMask78_g207086 = temp_output_42_0_g207086;
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207099) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch37_g207105;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainNormalTex;
				SamplerState Sampler502_g207099 = staticSwitch37_g207105;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainNormalTex;
				SamplerState Sampler496_g207099 = staticSwitch37_g207105;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				half3 NormalWS512_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = NormalWS512_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainNormalTex;
				SamplerState Sampler490_g207099 = staticSwitch37_g207105;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				half3 Triplanar522_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = Triplanar522_g207099;
				half3 NormalWS490_g207099 = NormalWS512_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainNormalTex;
				SamplerState Sampler498_g207099 = staticSwitch37_g207105;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = NormalWS512_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainNormalTex;
				SamplerState Sampler500_g207099 = staticSwitch37_g207105;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = Triplanar522_g207099;
				half3 NormalWS500_g207099 = NormalWS512_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option70_g251310 = temp_output_17_0_g251310;
				float4 temp_output_3_0_g251310 = float4( 0,0,0,0 );
				float4 Channel70_g251310 = temp_output_3_0_g251310;
				float localSwitchChannel470_g251310 = SwitchChannel4( Option70_g251310 , Channel70_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel470_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251324 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251324 = 0.0;
				float3 Out_Albedo4_g251324 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251324 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251324 = float2( 0,0 );
				float3 Out_NormalWS4_g251324 = float3( 0,0,0 );
				float4 Out_Shader4_g251324 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251324 = float4( 0,0,0,0 );
				float4 Out_Season4_g251324 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251324 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251324 = 0.0;
				float Out_Grayscale4_g251324 = 0.0;
				float Out_Luminosity4_g251324 = 0.0;
				float Out_AlphaClip4_g251324 = 0.0;
				float Out_AlphaFade4_g251324 = 0.0;
				float3 Out_Translucency4_g251324 = float3( 0,0,0 );
				float Out_Transmission4_g251324 = 0.0;
				float Out_Thickness4_g251324 = 0.0;
				float Out_Diffusion4_g251324 = 0.0;
				float Out_Depth4_g251324 = 0.0;
				BreakVisualData( Data4_g251324 , Out_Dummy4_g251324 , Out_Albedo4_g251324 , Out_AlbedoBase4_g251324 , Out_NormalTS4_g251324 , Out_NormalWS4_g251324 , Out_Shader4_g251324 , Out_Feature4_g251324 , Out_Season4_g251324 , Out_Emissive4_g251324 , Out_MultiMask4_g251324 , Out_Grayscale4_g251324 , Out_Luminosity4_g251324 , Out_AlphaClip4_g251324 , Out_AlphaFade4_g251324 , Out_Translucency4_g251324 , Out_Transmission4_g251324 , Out_Thickness4_g251324 , Out_Diffusion4_g251324 , Out_Depth4_g251324 );
				float temp_output_3_0_g251332 = Out_AlphaClip4_g251324;
				float Alpha21_g251332 = temp_output_3_0_g251332;
				float temp_output_15_0_g251332 = 0.0;
				float Treshold21_g251332 = temp_output_15_0_g251332;
				{
				#if defined (TVE_ALPHA_CLIP)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha21_g251332 - Treshold21_g251332);
				#endif
				#endif
				}
				half Render_Mode177_g251316 = _RenderMode;
				float lerpResult178_g251316 = lerp( 1.0 , Out_AlphaFade4_g251324 , Render_Mode177_g251316);
				

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;

				surfaceDescription.Alpha = saturate( ( Alpha21_g251332 * lerpResult178_g251316 ) );

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#if defined( ASE_WRITE_DEPTH )
					#if !defined( _DEPTHOFFSET_ON )
						posInput.deviceDepth = posInput.deviceDepth;
					#else
						surfaceDescription.DepthOffset = 0;
					#endif
				#endif

				#if defined( ASE_WRITE_DEPTH )
					outputDepth = posInput.deviceDepth;
				#endif

				outColor = unity_SelectionID;
			}

            ENDHLSL
		}

	
	}
	

	

	CustomEditor "TheVisualEngine.MaterialGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19912
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":5246,"pos":[640,-256],"params":["Inherit","False","Block Model","47","","205214","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":4641,"pos":[960,-192],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":4598,"pos":[1408,-256],"params":["Inherit","False","4641","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":5292,"pos":[1664,-256],"params":["Inherit","False","Block Main Packer","60","","207086","6f902604bb216a2499087c243d45e11c","2,65,1,136,1","1","225","OBJECT","0,0,0,0","False","1","OBJECT","106"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":4635,"pos":[1984,-256],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2213,"pos":[2432,-256],"params":["Inherit","False","4635","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":20,"pos":[2608,-640],"params":["Half","False","Property","_render_src","_render_src","103","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","5","1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":10,"pos":[2432,-640],"params":["Half","False","Property","_render_cull","_render_cull","102","1","[HideInInspector]","Create","True","0","3","Both","0","Back","1","Front","2","0","True","0","False","Object","-1","","0","2","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":7,"pos":[2784,-640],"params":["Half","False","Property","_render_dst","_render_dst","104","1","[HideInInspector]","Create","True","0","2","Opaque","0","Transparent","1","0","True","0","False","Object","-1","","10","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":17,"pos":[2960,-640],"params":["Half","False","Property","_render_zw","_render_zw","105","1","[HideInInspector]","Create","True","0","2","Opaque","0","Transparent","1","0","True","0","False","Object","-1","","1","1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1355,"pos":[3136,-640],"params":["Half","False","Property","_render_coverage","_render_coverage","106","1","[HideInInspector]","Create","True","0","2","Opaque","0","Transparent","1","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":1087,"pos":[3712,-640],"params":["Inherit","False","Base Compile","-1","","251315","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2267,"pos":[2432,-768],"params":["Half","False","Property","_IsGeneralShader","_IsGeneralShader","107","1","[HideInInspector]","Create","True","0","2","Opaque","0","Transparent","1","0","True","0","False","Object","-1","","1","1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":5267,"pos":[2688,-256],"params":["Inherit","False","Block Render","0","","251316","a46c8f81ec84cc34b8c5bbba7c174e1d","0","3","17","OBJECT","","False","19","OBJECT","","False","125","FLOAT","0","False","17","FLOAT3","21","FLOAT3","22","FLOAT3","77","FLOAT","27","FLOAT","26","FLOAT3","34","FLOAT","72","FLOAT","28","FLOAT","71","FLOAT3","65","FLOAT","66","FLOAT","67","FLOAT","68","FLOAT","73","FLOAT3","30","FLOAT3","32","FLOAT4","33"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":4258,"pos":[2656,-768],"params":["Half","False","Property","_IsStandardShader","_IsStandardShader","108","1","[HideInInspector]","Create","True","0","2","Opaque","0","Transparent","1","0","True","0","False","Object","-1","","1","1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":4645,"pos":[960,-256],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5294,"pos":[3232,-256],"params":["Float","False","True","-1","3","TheVisualEngine.MaterialGUI","0","1","BOXOPHOBIC/The Visual Engine/Helpers/Custom Texture Packing","28cd5599e02859647ae1798e4fcaef6c","True","GBuffer","0","0","GBuffer","38","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","False","False","False","False","False","False","False","False","True","True","0","True","_StencilRefGBuffer","255","False","","255","True","_StencilWriteMaskGBuffer","7","False","","3","False","","0","False","","0","False","","7","False","","3","False","","0","False","","0","False","","False","False","True","0","True","_ZTestGBuffer","False","False","True","1","LightMode=GBuffer","False","False","0","","0","0","Standard","45","Category","0","0","Surface Type","0","0","  Rendering Pass","1","0","  Refraction Model","0","0","    Blending Mode","0","0","    Blend Preserves Specular","0","0","  Back Then Front Rendering","0","0","  Transparent Depth Prepass","0","0","  Transparent Depth Postpass","0","0","  Distortion","0","0","    Distortion Mode","0","0","    Distortion Depth Test","1","0","  ZWrite","0","0","  Z Test","4","0","Double-Sided","0","638742674576054130","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Material Type","4","638742674620213704","  Energy Conserving Specular","1","0","  Transmission","0","0","Normal Space","0","0","Receive Decals","1","0","Receive SSR","1","0","Receive SSR Transparent","0","0","Motion Vectors","0","638742674670180871","  Add Precomputed Velocity","0","0","  Add Custom Velocity","0","0","Specular AA","0","0","Specular Occlusion Mode","1","0","Override Baked GI","0","0","Write Depth","0","0","  Depth Offset","0","0","  Conservative","0","0","GPU Instancing","1","0","LOD CrossFade","1","638742674721403398","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Vertex Position","0","638742674735013747","0","12","True","True","True","True","True","False","False","False","False","True","True","False","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5295,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","META","0","1","META","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5296,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","2","ShadowCaster","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","True","False","False","False","False","0","False","","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","True","0","True","_ZClip","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5297,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","3","SceneSelectionPass","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5298,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","DepthOnly","0","4","DepthOnly","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","False","False","False","False","False","False","False","False","True","True","0","True","_StencilRefDepth","255","False","","255","True","_StencilWriteMaskDepth","7","False","","3","False","","0","False","","0","False","","7","False","","3","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","LightMode=DepthOnly","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5299,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","MotionVectors","0","5","MotionVectors","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","False","False","False","False","False","False","False","False","True","True","0","True","_StencilRefMV","255","False","","255","True","_StencilWriteMaskMV","7","False","","3","False","","0","False","","0","False","","7","False","","3","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","LightMode=MotionVectors","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5300,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","TransparentBackface","0","6","TransparentBackface","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","True","3","1","False","","10","False","","0","1","False","","0","False","","False","False","True","3","1","False","","10","False","","0","1","False","","0","False","","False","False","True","3","1","False","","10","False","","0","1","False","","0","False","","False","False","False","True","1","False","","False","False","False","True","True","True","True","True","0","True","_ColorMaskTransparentVelOne","False","True","True","True","True","True","0","True","_ColorMaskTransparentVelTwo","False","False","False","False","False","True","0","True","_ZWrite","True","0","True","_ZTestTransparent","False","False","True","1","LightMode=TransparentBackface","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5301,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","TransparentDepthPrepass","0","7","TransparentDepthPrepass","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","False","False","False","False","False","False","False","False","True","True","0","True","_StencilRefDepth","255","False","","255","True","_StencilWriteMaskDepth","7","False","","3","False","","0","False","","0","False","","7","False","","3","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","LightMode=TransparentDepthPrepass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5302,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","TransparentDepthPostpass","0","8","TransparentDepthPostpass","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","True","False","False","False","False","0","False","","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=TransparentDepthPostpass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5303,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Forward","0","9","Forward","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","True","3","1","False","","10","False","","0","1","False","","0","False","","False","False","True","1","1","False","","0","True","_DstBlend2","0","1","False","","0","False","","False","False","True","1","1","False","","0","True","_DstBlend2","0","1","False","","0","False","","False","False","False","True","0","True","_CullModeForward","False","False","False","True","True","True","True","True","0","True","_ColorMaskTransparentVelOne","False","True","True","True","True","True","0","True","_ColorMaskTransparentVelTwo","False","False","False","True","True","0","True","_StencilRef","255","False","","255","True","_StencilWriteMask","7","False","","3","False","","0","False","","0","False","","7","False","","3","False","","0","False","","0","False","","False","True","0","True","_ZWrite","True","0","True","_ZTestDepthEqualForOpaque","False","False","True","1","LightMode=Forward","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5304,"pos":[3232,-256],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","10","ScenePickingPass","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":5305,"pos":[3232,-146],"params":["Float","False","False","-1","3","Rendering.HighDefinition.LightingShaderGraphGUI","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Distortion","0","11","Distortion","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","4","RenderPipeline=HDRenderPipeline","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","ShaderGraphShader=true","True","5","True","9","d3d11","metal","vulkan","xboxone","xboxseries","playstation","ps4","ps5","switch","0","False","True","4","1","False","","1","False","","4","1","False","","1","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","True","_CullMode","False","False","False","False","False","False","False","False","False","True","True","0","True","_StencilRefDistortionVec","255","False","","255","True","_StencilWriteMaskDistortionVec","7","False","","3","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","2","False","","True","3","False","","False","False","True","1","LightMode=DistortionVectors","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[4641,0,5246,314]}
{"wire":[5292,225,4598,0]}
{"wire":[4635,0,5292,106]}
{"wire":[5267,17,2213,0]}
{"wire":[4645,0,5246,128]}
{"wire":[5294,0,5267,21]}
{"wire":[5294,1,5267,22]}
{"wire":[5294,5,5267,77]}
{"wire":[5294,7,5267,27]}
{"wire":[5294,8,5267,26]}
{"wire":[5294,9,5267,28]}
ASEEND*/
//CHKSM=746CDA402874B9B2FF707AAE2D662CA01CBD985C