// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Layer"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_SecondIntensityValue( "Layer Intensity", Range( 0, 1 ) ) = 0
		[Space(10)] _SecondBlendIntensityValue( "Layer Blend Intensity", Range( 0, 1 ) ) = 1
		[Space(10)][StyledTextureSingleLine(Mask B)] _SecondMaskTex( "Layer Mask", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3)][Space(10)] _SecondMaskSampleMode( "Mask Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _SecondMaskCoordMode( "Mask UV Mode", Float ) = 0
		[StyledVector(9)] _SecondMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_SecondCoatValue( "Layer Coat Mask", Range( 0, 1 ) ) = 1
		[Enum(Global Data Only,0,Use Coat Elements,1)] _SecondCoatMode( "Layer Coat Mask", Float ) = 0
		_SecondMaskValue( "Layer TexC Mask", Range( 0, 1 ) ) = 0
		[Enum(Mask R,0,Mask G,1,Mask B,2,Mask A,3)] _SecondMaskMode( "Layer TexC Mask", Float ) = 0
		[StyledRemapSlider] _SecondMaskRemap( "Layer TexC Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondLumaValue( "Layer Luma Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondLumaRemap( "Layer Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondBaseValue( "Layer Base Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondBaseRemap( "Layer Base Mask", Vector ) = ( 1, 0, 0, 1 )
		_SecondProjValue( "Layer ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondProjRemap( "Layer ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondMeshValue( "Layer Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _SecondMeshMode( "Layer Mesh Mask", Float ) = 0
		[StyledRemapSlider] _SecondMeshRemap( "Layer Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Multiply,0,Buildup,1)] _SecondBlendMath( "Layer Blend Mask", Float ) = 1
		[StyledRemapSlider] _SecondBlendRemap( "Layer Blend Mask", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _second_mask_coord_value( "_second_mask_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Y Up,0,Z Up,1)] _ObjectCoordMode( "Object Coord Mode", Float ) = 0
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
		_IsTerrainShader( "_IsTerrainShader", Float ) = 0
		[StyledCategory(Global Settings, true, Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available.,0, 10)] _GlobalCategory( "[ Global Category ]", Float ) = 1
		[StyledEnum(Coat Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalCoatLayerValue( "Global Coat Layer", Float ) = 0
		[StyledEnum(Paint Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalPaintLayerValue( "Global Paint Layer", Float ) = 0
		[StyledEnum(Atmo Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalAtmoLayerValue( "Global Atmo Layer", Float ) = 0
		[StyledEnum(Effex Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalEffexLayerValue( "Global Effex Layer", Float ) = 0
		[StyledEnum(Glow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalGlowLayerValue( "Global Glow Layer", Float ) = 0
		[StyledEnum(Form Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalFormLayerValue( "Global Form Layer", Float ) = 0
		[StyledEnum(Vertx Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalVertxLayerValue( "Global Vertx Layer", Float ) = 0
		[StyledEnum(Flow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalFlowLayerValue( "Global Flow Layer", Float ) = 0
		_GlobalCoatPivotValue( "Global Coat Pivots", Range( 0, 1 ) ) = 0
		_GlobalPaintPivotValue( "Global Paint Pivots", Range( 0, 1 ) ) = 0
		_GlobalAtmoPivotValue( "Global Atmo Pivots", Range( 0, 1 ) ) = 0
		_GlobalEffexPivotValue( "Global Effex Pivots", Range( 0, 1 ) ) = 0
		_GlobalGlowPivotValue( "Global Glow Pivots", Range( 0, 1 ) ) = 0
		_GlobalFormPivotValue( "Global Form Pivots", Range( 0, 1 ) ) = 0
		_GlobalVertxPivotValue( "Global Vertx Pivots", Range( 0, 1 ) ) = 1
		_GlobalFlowPivotValue( "Global Flow Pivots", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _GlobalEnd( "[ Global End ]", Float ) = 1
		[StyledCategory(Conform Settings, true, Use the Conform feature to project the vertices to the terrain or mesh surfaces__ similar to how decals work__ but for 3D objects. The most common usage is with big patches of grass__ groups of rocks or QUOplanarQUO ground covers which would not work properly on curved surfaces. Please note__ the projection only works from top down view and the effect it is only visual OPAcollider is not affectedCPAEXC, _ConformIntensityValue, FF0000, 0, 10)] _ConformCategory( "[ Conform Category ]", Float ) = 0
		[StyledMessage(Info, The Conform position features require elements to work. Use Form Surface or Form Height elements for conforming  the objects to terrain surfaces. Please note__ the conform effect is only visual and it does not affect the object collider and bounds., 0, 10)] _ConformInfo( "_ConformInfo", Float ) = 0
		_ConformIntensityValue( "Conform Intensity", Range( 0, 1 ) ) = 0
		[Enum(Freeform Object Position,0,Lock Position With Conform,1)] _ConformMode( "Conform Mode", Float ) = 1
		_ConformOffsetValue( "Conform Offset", Float ) = 0
		[Space(10)] _ConformMeshValue( "Conform Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ConformMeshMode( "Conform Mesh Mask", Float ) = 3
		[StyledRemapSlider] _ConformMeshRemap( "Conform Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _ConformEnd( "[ Conform End ]", Float ) = 1
		[StyledCategory(Main Settings, true, Use the Multi Mask as a leaves mask when using dual colors__ global coloring effects or subsurface scattering. Control how the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap slider.NEWNEWUse the Shader texture blue channel as a height mask for additional layers blending. Control how the mask is used OPAwhen availableCPA on the following layers via the Base Mask sliders., 0, 10)] _MainCategory( "[Main Category ]", Float ) = 1
		[MainTexture][StyledTextureSingleLine(Albedo RGB Alpha A)] _MainAlbedoTex( "Main Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _MainNormalTex( "Main Normal", 2D ) = "linearGrey" {}
		[StyledTextureSingleLine(Metallic R Occlusion G BaseMask and MultiMask B Smoothness A)] _MainShaderTex( "Main Shader", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3,Stochastic,4,Stochastic Triplanar,5)][Space(10)] _MainSampleMode( "Main Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _MainCoordMode( "Main UV Mode", Float ) = 0
		[StyledVector(9)] _MainCoordValue( "Main UV Value", Vector ) = ( 1, 1, 0, 0 )
		[Enum(Constant,0,Dual Colors,1)] _MainColorMode( "Main Color", Float ) = 0
		[HDR][Gamma][MainColor] _MainColor( "Main Color", Color ) = ( 1, 1, 1, 1 )
		[HDR][Gamma] _MainColorTwo( "Main Color B", Color ) = ( 1, 1, 1, 1 )
		_MainAlphaClipValue( "Main Alpha", Range( 0, 1 ) ) = 0.5
		_MainAlbedoValue( "Main Albedo", Range( 0, 1 ) ) = 1
		_MainNormalValue( "Main Normal", Range( -8, 8 ) ) = 1
		_MainMetallicValue( "Main Metallic", Range( 0, 1 ) ) = 0
		_MainOcclusionValue( "Main Occlusion", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainOcclusionRemap( "Main Occlusion", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Albedo A,4,Shader B,5)] _MainMultiWriteMode( "Main Multi Mask", Float ) = 5
		[StyledRemapSlider] _MainMultiWriteRemap( "Main Multi Mask", Vector ) = ( 0, 1, 0, 0 )
		_MainSmoothnessValue( "Main Smoothness", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainSmoothnessRemap( "Main Smoothness", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _main_coord_value( "_main_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledSpace(10)] _MainEnd( "[Main End ]", Float ) = 1


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		//_SpecularHighlights("Specular Highlights", Float) = 1.0
		//_GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }

	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA

		

		Blend Off
		

		CGINCLUDE
			#pragma target 4.5
			// ensure rendering platforms toggle list is visible

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

			float DistanceFromPlane (float3 pos, float4 plane)
			{
				float d = dot (float4(pos,1.0f), plane);
				return d;
			}

			bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
			{
				float4 planeTest;
				planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
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

			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
		ENDCG

		
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend One Zero

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19912
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
					#define ENABLE_TERRAIN_PERPIXEL_NORMAL
				#endif

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_SECOND_MASK
				#pragma shader_feature_local_fragment TVE_SECOND_MASK_SAMPLE_MAIN_UV TVE_SECOND_MASK_SAMPLE_EXTRA_UV TVE_SECOND_MASK_SAMPLE_PLANAR_2D TVE_SECOND_MASK_SAMPLE_PLANAR_3D
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_SECOND_COAT
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS, w = fogCoord
					half3 normalWS : TEXCOORD1;
					float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					half4 ambientOrLightmapUV : TEXCOORD3;
					UNITY_LIGHTING_COORDS( 4, 5 )
					float4 ase_texcoord6 : TEXCOORD6;
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					float4 ase_color : COLOR;
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TRANSMISSION
					float _TransmissionShadow;
				#endif
				#ifdef ASE_TRANSLUCENCY
					float _TransStrength;
					float _TransNormal;
					float _TransScattering;
					float _TransDirect;
					float _TransAmbient;
					float _TransShadow;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform half _ObjectCoordMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_EffexParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexBaseTex);
				uniform float4 TVE_EffexBaseCoord;
				uniform half _GlobalEffexPivotValue;
				uniform half _GlobalEffexLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexNearTex);
				uniform float4 TVE_EffexNearCoord;
				uniform float TVE_EffexLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_VertxParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxBaseTex);
				uniform float4 TVE_VertxBaseCoord;
				uniform half _GlobalVertxPivotValue;
				uniform half _GlobalVertxLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxNearTex);
				uniform float4 TVE_VertxNearCoord;
				uniform float TVE_VertxLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;
				uniform half _SecondIntensityValue;
				uniform half _SecondCoatMode;
				uniform half _SecondMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
				uniform half4 _second_mask_coord_value;
				uniform half _SecondMaskSampleMode;
				uniform half _SecondMaskCoordMode;
				uniform half4 _SecondMaskCoordValue;
				uniform half4 _SecondMaskRemap;
				uniform half _SecondMaskValue;
				uniform half _MainCategory;
				uniform half _MainEnd;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
				SamplerState sampler_Linear_Repeat_Aniso8;
				SamplerState sampler_Point_Repeat;
				uniform half4 _main_coord_value;
				uniform half _MainSampleMode;
				uniform half _MainCoordMode;
				uniform half4 _MainCoordValue;
				uniform half _MainAlbedoValue;
				uniform half4 _MainColorTwo;
				uniform half4 _MainColor;
				uniform half _MainMultiWriteMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainShaderTex);
				uniform half4 _MainMultiWriteRemap;
				uniform half _MainColorMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
				uniform half _MainNormalValue;
				uniform half _MainMetallicValue;
				uniform half4 _MainOcclusionRemap;
				uniform half _MainOcclusionValue;
				uniform half4 _MainSmoothnessRemap;
				uniform half _MainSmoothnessValue;
				uniform half _MainAlphaClipValue;
				uniform half4 _SecondBaseRemap;
				uniform half _SecondBaseValue;
				uniform half4 _SecondLumaRemap;
				uniform half _SecondLumaValue;
				uniform half4 _SecondProjRemap;
				uniform half _SecondProjValue;
				uniform half _SecondMeshMode;
				uniform half4 _SecondMeshRemap;
				uniform half _SecondMeshValue;
				uniform half _SecondBlendMath;
				uniform half4 _SecondBlendRemap;
				uniform half _SecondBlendIntensityValue;
				uniform half _SecondCoatValue;
				uniform half TVE_DEBUG_Global;
				uniform float _IsTerrainShader;
				uniform float _RenderClip;
				uniform float _IsElementShader;
				uniform float _IsHelperShader;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half4 In_TangentOS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.TangentOS = In_TangentOS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				void BuildVertexData( inout TVEVertexData Data, half In_Dummy, float3 In_PositionOS, half3 In_NormalOS, half4 In_TangentOS, half4 In_TransformData, half4 In_RotationData, float4 In_Interpolator )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.NormalOS = In_NormalOS;
					Data.TangentOS = In_TangentOS;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.Interpolator = In_Interpolator;
					return;
				}
				
				void BreakVertexData( inout TVEVertexData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_NormalOS, out half4 Out_TangentOS, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_NormalOS = Data.NormalOS;
					Out_TangentOS = Data.TangentOS;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				half3 ComputeTriplanarMasks( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatTexture, half4 In_DrawTexture, half4 In_PaintTexture, half4 In_AtmoTexture, half4 In_EffexTexture, half4 In_GlowTexture, float4 In_FormTexture, float4 In_LandTexture, float4 In_VertxTexture, float4 In_FlowTexture, half4 In_UserTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatTexture = In_CoatTexture;
					Data.DrawTexture = In_DrawTexture;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoTexture = In_AtmoTexture;
					Data.EffexTexture = In_EffexTexture;
					Data.GlowTexture = In_GlowTexture;
					Data.FormTexture = In_FormTexture;
					Data.LandTexture = In_LandTexture;
					Data.VertxTexture = In_VertxTexture;
					Data.FlowTexture = In_FlowTexture;
					Data.UserTexture = In_UserTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatTexture, out half4 Out_DrawTexture, out half4 Out_PaintTexture, out half4 Out_AtmoTexture, out half4 Out_EffexTexture, out half4 Out_GlowTexture, out float4 Out_FormTexture, out float4 Out_LandTexture, out half4 Out_VertxTexture, out half4 Out_FlowTexture, out half4 Out_UserTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatTexture = Data.CoatTexture;
					Out_DrawTexture = Data.DrawTexture;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_EffexTexture= Data.EffexTexture;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormTexture = Data.FormTexture;
					Out_LandTexture = Data.LandTexture;
					Out_VertxTexture = Data.VertxTexture;
					Out_FlowTexture = Data.FlowTexture;
					Out_UserTexture = Data.UserTexture;
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
				
				half4 SampleCoord( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
				{
					half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
					Normal = tex.wy * 2.0 - 1.0;
					return tex;
				}
				
				half4 SamplePlanar2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
				{
					half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
					half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
					normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
					Normal = normal_Y;
					return tex_Y;
				}
				
				half4 SamplePlanar3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				
				float SwitchChannel6( half Option, half4 ChannelA, half4 ChannelB )
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
					}
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
				
				half SwitchBlendMask( half Multiply, half Subtract, half Option )
				{
					switch (Option) {
						default:
					                case 0:
							return Multiply;
						case 1:
							return Subtract;
					}
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251664 =(TVEVertexData)0;
					float In_Dummy16_g251664 = 0.0;
					TVEVertexData Data16_g251659 =(TVEVertexData)0;
					float In_Dummy16_g251659 = 0.0;
					TVEModelData Data16_g235783 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#else
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#endif
					half Dummy207_g235765 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g235765 );
					float temp_output_14_0_g235783 = Dummy207_g235765;
					float In_Dummy16_g235783 = temp_output_14_0_g235783;
					float3 PositionOS131_g235765 = v.vertex.xyz;
					float3 temp_output_4_0_g235783 = PositionOS131_g235765;
					float3 In_PositionOS16_g235783 = temp_output_4_0_g235783;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g235765 = ase_positionWS;
					float3 vertexToFrag73_g235765 = temp_output_104_7_g235765;
					float3 PositionWS122_g235765 = vertexToFrag73_g235765;
					float3 In_PositionWS16_g235783 = PositionWS122_g235765;
					float4x4 break19_g235768 = unity_ObjectToWorld;
					float3 appendResult20_g235768 = (float3(break19_g235768[ 0 ][ 3 ] , break19_g235768[ 1 ][ 3 ] , break19_g235768[ 2 ][ 3 ]));
					float3 temp_output_340_7_g235765 = appendResult20_g235768;
					float4x4 break19_g235770 = unity_ObjectToWorld;
					float3 appendResult20_g235770 = (float3(break19_g235770[ 0 ][ 3 ] , break19_g235770[ 1 ][ 3 ] , break19_g235770[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g235766 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g235765 = PositionOS131_g235765;
					float3 appendResult234_g235765 = (float3(break233_g235765.x , 0.0 , break233_g235765.z));
					float3 break413_g235765 = PositionOS131_g235765;
					float3 appendResult414_g235765 = (float3(break413_g235765.x , break413_g235765.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g235772 = appendResult414_g235765;
					#else
					float3 staticSwitch65_g235772 = appendResult234_g235765;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g235765 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g235765 = appendResult60_g235766;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g235765 = staticSwitch65_g235772;
					#else
					float3 staticSwitch229_g235765 = _Vector0;
					#endif
					float3 PivotOS149_g235765 = staticSwitch229_g235765;
					float3 temp_output_122_0_g235770 = PivotOS149_g235765;
					float3 PivotsOnlyWS105_g235770 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g235770 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g235765 = ( appendResult20_g235770 + PivotsOnlyWS105_g235770 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#else
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#endif
					float3 vertexToFrag76_g235765 = staticSwitch236_g235765;
					float3 PivotWS121_g235765 = vertexToFrag76_g235765;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g235765 = ( PositionWS122_g235765 - PivotWS121_g235765 );
					#else
					float3 staticSwitch204_g235765 = PositionWS122_g235765;
					#endif
					float3 PositionWO132_g235765 = ( staticSwitch204_g235765 - TVE_WorldOrigin );
					float3 In_PositionWO16_g235783 = PositionWO132_g235765;
					float3 In_PivotOS16_g235783 = PivotOS149_g235765;
					float3 In_PivotWS16_g235783 = PivotWS121_g235765;
					float3 PivotWO133_g235765 = ( PivotWS121_g235765 - TVE_WorldOrigin );
					float3 In_PivotWO16_g235783 = PivotWO133_g235765;
					half3 NormalOS134_g235765 = v.normal;
					float3 temp_output_21_0_g235783 = NormalOS134_g235765;
					float3 In_NormalOS16_g235783 = temp_output_21_0_g235783;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g235765 = normalizedWorldNormal;
					float3 In_NormalWS16_g235783 = NormalWS95_g235765;
					half4 TangentlOS153_g235765 = v.tangent;
					float4 temp_output_6_0_g235783 = TangentlOS153_g235765;
					float4 In_TangentOS16_g235783 = temp_output_6_0_g235783;
					float3 normalizeResult296_g235765 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g235765 ) );
					half3 ViewDirWS169_g235765 = normalizeResult296_g235765;
					float3 In_ViewDirWS16_g235783 = ViewDirWS169_g235765;
					float4 appendResult397_g235765 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g235765 = appendResult397_g235765;
					float4 In_CoordsData16_g235783 = CoordsData398_g235765;
					half4 VertexMasks171_g235765 = v.ase_color;
					float4 In_VertexData16_g235783 = VertexMasks171_g235765;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235777 = (PositionOS131_g235765).z;
					#else
					float staticSwitch65_g235777 = (PositionOS131_g235765).y;
					#endif
					half Object_HeightValue267_g235765 = _ObjectHeightValue;
					half Bounds_HeightMask274_g235765 = saturate( ( staticSwitch65_g235777 / Object_HeightValue267_g235765 ) );
					half3 Position387_g235765 = PositionOS131_g235765;
					half Height387_g235765 = Object_HeightValue267_g235765;
					half Object_RadiusValue268_g235765 = _ObjectRadiusValue;
					half Radius387_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskYUp387_g235765 = CapsuleMaskYUp( Position387_g235765 , Height387_g235765 , Radius387_g235765 );
					half3 Position408_g235765 = PositionOS131_g235765;
					half Height408_g235765 = Object_HeightValue267_g235765;
					half Radius408_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskZUp408_g235765 = CapsuleMaskZUp( Position408_g235765 , Height408_g235765 , Radius408_g235765 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235782 = saturate( localCapsuleMaskZUp408_g235765 );
					#else
					float staticSwitch65_g235782 = saturate( localCapsuleMaskYUp387_g235765 );
					#endif
					half Bounds_SphereMask282_g235765 = staticSwitch65_g235782;
					float4 appendResult253_g235765 = (float4(Bounds_HeightMask274_g235765 , Bounds_SphereMask282_g235765 , 1.0 , 1.0));
					half4 MasksData254_g235765 = appendResult253_g235765;
					float4 In_MasksData16_g235783 = MasksData254_g235765;
					float temp_output_17_0_g235776 = _ObjectPhaseMode;
					float Option70_g235776 = temp_output_17_0_g235776;
					float4 temp_output_3_0_g235776 = v.ase_color;
					float4 Channel70_g235776 = temp_output_3_0_g235776;
					float localSwitchChannel470_g235776 = SwitchChannel4( Option70_g235776 , Channel70_g235776 );
					half Phase_Value372_g235765 = localSwitchChannel470_g235776;
					float3 break319_g235765 = PivotWO133_g235765;
					half Pivot_Position322_g235765 = ( break319_g235765.x + break319_g235765.z );
					half Phase_Position357_g235765 = ( Phase_Value372_g235765 + Pivot_Position322_g235765 );
					float temp_output_248_0_g235765 = frac( Phase_Position357_g235765 );
					float4 appendResult177_g235765 = (float4((frac( ( Phase_Position357_g235765 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g235765));
					half4 Phase_Data176_g235765 = appendResult177_g235765;
					float4 In_PhaseData16_g235783 = Phase_Data176_g235765;
					BuildModelVertData( Data16_g235783 , In_Dummy16_g235783 , In_PositionOS16_g235783 , In_PositionWS16_g235783 , In_PositionWO16_g235783 , In_PivotOS16_g235783 , In_PivotWS16_g235783 , In_PivotWO16_g235783 , In_NormalOS16_g235783 , In_NormalWS16_g235783 , In_TangentOS16_g235783 , In_ViewDirWS16_g235783 , In_CoordsData16_g235783 , In_VertexData16_g235783 , In_MasksData16_g235783 , In_PhaseData16_g235783 );
					TVEModelData Data15_g251660 =(TVEModelData)Data16_g235783;
					float Out_Dummy15_g251660 = 0.0;
					float3 Out_PositionOS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251660 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251660 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251660 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251660 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251660 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251660 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251660 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251660 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251660 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251660 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251660 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251660 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251660 , Out_Dummy15_g251660 , Out_PositionOS15_g251660 , Out_PositionWS15_g251660 , Out_PositionWO15_g251660 , Out_PositionRawOS15_g251660 , Out_PivotOS15_g251660 , Out_PivotWS15_g251660 , Out_PivotWO15_g251660 , Out_NormalOS15_g251660 , Out_NormalWS15_g251660 , Out_NormalRawOS15_g251660 , Out_TangentOS15_g251660 , Out_TangentWS15_g251660 , Out_BitangentWS15_g251660 , Out_ViewDirWS15_g251660 , Out_CoordsData15_g251660 , Out_VertexData15_g251660 , Out_MasksData15_g251660 , Out_PhaseData15_g251660 , Out_TransformData15_g251660 , Out_RotationData15_g251660 , Out_Interpolator15_g251660 );
					float3 In_PositionOS16_g251659 = Out_PositionOS15_g251660;
					float3 In_NormalOS16_g251659 = Out_NormalOS15_g251660;
					float4 In_TangentOS16_g251659 = Out_TangentOS15_g251660;
					float4 In_TransformData16_g251659 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251659 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251659 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251659 , In_Dummy16_g251659 , In_PositionOS16_g251659 , In_NormalOS16_g251659 , In_TangentOS16_g251659 , In_TransformData16_g251659 , In_RotationData16_g251659 , In_Interpolator16_g251659 );
					TVEVertexData Data15_g251662 =(TVEVertexData)Data16_g251659;
					float Out_Dummy15_g251662 = 0.0;
					float3 Out_PositionOS15_g251662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251662 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251662 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251662 , Out_Dummy15_g251662 , Out_PositionOS15_g251662 , Out_NormalOS15_g251662 , Out_TangentOS15_g251662 , Out_TransformData15_g251662 , Out_RotationData15_g251662 , Out_Interpolator15_g251662 );
					TVEModelData Data15_g251663 =(TVEModelData)Data15_g251660;
					float Out_Dummy15_g251663 = 0.0;
					float3 Out_PositionOS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251663 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251663 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251663 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251663 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251663 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251663 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251663 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251663 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251663 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251663 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251663 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251663 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251663 , Out_Dummy15_g251663 , Out_PositionOS15_g251663 , Out_PositionWS15_g251663 , Out_PositionWO15_g251663 , Out_PositionRawOS15_g251663 , Out_PivotOS15_g251663 , Out_PivotWS15_g251663 , Out_PivotWO15_g251663 , Out_NormalOS15_g251663 , Out_NormalWS15_g251663 , Out_NormalRawOS15_g251663 , Out_TangentOS15_g251663 , Out_TangentWS15_g251663 , Out_BitangentWS15_g251663 , Out_ViewDirWS15_g251663 , Out_CoordsData15_g251663 , Out_VertexData15_g251663 , Out_MasksData15_g251663 , Out_PhaseData15_g251663 , Out_TransformData15_g251663 , Out_RotationData15_g251663 , Out_Interpolator15_g251663 );
					float3 In_PositionOS16_g251664 = ( Out_PositionOS15_g251662 - Out_PivotOS15_g251663 );
					float3 In_NormalOS16_g251664 = Out_NormalOS15_g251663;
					float4 In_TangentOS16_g251664 = Out_TangentOS15_g251663;
					float4 In_TransformData16_g251664 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251664 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251664 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251664 , In_Dummy16_g251664 , In_PositionOS16_g251664 , In_NormalOS16_g251664 , In_TangentOS16_g251664 , In_TransformData16_g251664 , In_RotationData16_g251664 , In_Interpolator16_g251664 );
					TVEVertexData Data15_g251673 =(TVEVertexData)Data16_g251664;
					float Out_Dummy15_g251673 = 0.0;
					float3 Out_PositionOS15_g251673 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251673 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251673 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251673 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251673 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251673 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251673 , Out_Dummy15_g251673 , Out_PositionOS15_g251673 , Out_NormalOS15_g251673 , Out_TangentOS15_g251673 , Out_TransformData15_g251673 , Out_RotationData15_g251673 , Out_Interpolator15_g251673 );
					TVEVertexData Data16_g251674 =(TVEVertexData)Data15_g251673;
					half Dummy317_g251665 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251674 = Dummy317_g251665;
					float3 In_PositionOS16_g251674 = Out_PositionOS15_g251673;
					float3 In_NormalOS16_g251674 = Out_NormalOS15_g251673;
					float4 In_TangentOS16_g251674 = Out_TangentOS15_g251673;
					half4 Model_TransformData356_g251665 = Out_TransformData15_g251673;
					float localBuildGlobalData204_g235664 = ( 0.0 );
					TVEGlobalData Data204_g235664 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g235664 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g235664 = Dummy211_g235664;
					float4 temp_output_203_0_g235683 = TVE_CoatBaseCoord;
					TVEModelData Data16_g235773 =(TVEModelData)0;
					float In_Dummy16_g235773 = 0.0;
					float3 In_PositionWS16_g235773 = PositionWS122_g235765;
					float3 In_PositionWO16_g235773 = PositionWO132_g235765;
					float3 In_PivotWS16_g235773 = PivotWS121_g235765;
					float3 In_PivotWO16_g235773 = PivotWO133_g235765;
					float3 In_NormalWS16_g235773 = NormalWS95_g235765;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g235765 = ase_tangentWS;
					float3 In_TangentWS16_g235773 = TangentWS136_g235765;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g235765 = ase_bitangentWS;
					float3 In_BitangentWS16_g235773 = BiangentWS421_g235765;
					half3 NormalWS427_g235765 = NormalWS95_g235765;
					half3 localComputeTriplanarMasks427_g235765 = ComputeTriplanarMasks( NormalWS427_g235765 );
					half3 TriplanarWeights429_g235765 = localComputeTriplanarMasks427_g235765;
					float3 In_TriplanarWeights16_g235773 = TriplanarWeights429_g235765;
					float3 In_ViewDirWS16_g235773 = ViewDirWS169_g235765;
					float4 In_CoordsData16_g235773 = CoordsData398_g235765;
					float4 In_VertexData16_g235773 = VertexMasks171_g235765;
					float4 In_Interpolator16_g235773 = Phase_Data176_g235765;
					BuildModelFragData( Data16_g235773 , In_Dummy16_g235773 , In_PositionWS16_g235773 , In_PositionWO16_g235773 , In_PivotWS16_g235773 , In_PivotWO16_g235773 , In_NormalWS16_g235773 , In_TangentWS16_g235773 , In_BitangentWS16_g235773 , In_TriplanarWeights16_g235773 , In_ViewDirWS16_g235773 , In_CoordsData16_g235773 , In_VertexData16_g235773 , In_Interpolator16_g235773 );
					TVEModelData Data15_g235754 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g235754 = 0.0;
					float3 Out_PositionWS15_g235754 = float3( 0,0,0 );
					float3 Out_PositionWO15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWS15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWO15_g235754 = float3( 0,0,0 );
					float3 Out_NormalWS15_g235754 = float3( 0,0,0 );
					float3 Out_TangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g235754 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g235754 = float3( 0,0,0 );
					float4 Out_CoordsData15_g235754 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g235754 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g235754 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g235754 , Out_Dummy15_g235754 , Out_PositionWS15_g235754 , Out_PositionWO15_g235754 , Out_PivotWS15_g235754 , Out_PivotWO15_g235754 , Out_NormalWS15_g235754 , Out_TangentWS15_g235754 , Out_BitangentWS15_g235754 , Out_TriplanarWeights15_g235754 , Out_ViewDirWS15_g235754 , Out_CoordsData15_g235754 , Out_VertexData15_g235754 , Out_Interpolator15_g235754 );
					float3 Model_PositionWS497_g235664 = Out_PositionWS15_g235754;
					float2 Model_PositionWS_XZ143_g235664 = (Model_PositionWS497_g235664).xz;
					float3 Model_PivotWS498_g235664 = Out_PivotWS15_g235754;
					float2 Model_PivotWS_XZ145_g235664 = (Model_PivotWS498_g235664).xz;
					float2 lerpResult300_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g235683 = lerpResult300_g235664;
					float temp_output_82_0_g235681 = _GlobalCoatLayerValue;
					float temp_output_82_0_g235683 = temp_output_82_0_g235681;
					float4 tex2DArrayNode83_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235683).zw + ( (temp_output_203_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult210_g235683 = (float4(tex2DArrayNode83_g235683.rgb , tex2DArrayNode83_g235683.a));
					float4 temp_output_204_0_g235683 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235683).zw + ( (temp_output_204_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult212_g235683 = (float4(tex2DArrayNode122_g235683.rgb , tex2DArrayNode122_g235683.a));
					float4 TVE_RenderNearPositionR628_g235664 = TVE_RenderNearPositionR;
					float temp_output_507_0_g235664 = saturate( ( distance( Model_PositionWS497_g235664 , (TVE_RenderNearPositionR628_g235664).xyz ) / (TVE_RenderNearPositionR628_g235664).w ) );
					float temp_output_7_0_g235753 = 1.0;
					float temp_output_9_0_g235753 = ( temp_output_507_0_g235664 - temp_output_7_0_g235753 );
					half TVE_RenderNearFadeValue635_g235664 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g235664 = saturate( ( temp_output_9_0_g235753 / ( ( TVE_RenderNearFadeValue635_g235664 - temp_output_7_0_g235753 ) + 0.0001 ) ) );
					float4 lerpResult131_g235683 = lerp( appendResult210_g235683 , appendResult212_g235683 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235681 = lerpResult131_g235683;
					float4 lerpResult168_g235681 = lerp( TVE_CoatParams , temp_output_159_109_g235681 , TVE_CoatLayers[(int)temp_output_82_0_g235681]);
					float4 temp_output_589_109_g235664 = lerpResult168_g235681;
					half4 Coat_Texture302_g235664 = temp_output_589_109_g235664;
					float4 In_CoatTexture204_g235664 = Coat_Texture302_g235664;
					half4 Draw_Texture656_g235664 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g235664 = Draw_Texture656_g235664;
					float4 temp_output_203_0_g235708 = TVE_PaintBaseCoord;
					float2 lerpResult85_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g235708 = lerpResult85_g235664;
					float temp_output_82_0_g235705 = _GlobalPaintLayerValue;
					float temp_output_82_0_g235708 = temp_output_82_0_g235705;
					float4 tex2DArrayNode83_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235708).zw + ( (temp_output_203_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult210_g235708 = (float4(tex2DArrayNode83_g235708.rgb , tex2DArrayNode83_g235708.a));
					float4 temp_output_204_0_g235708 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235708).zw + ( (temp_output_204_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult212_g235708 = (float4(tex2DArrayNode122_g235708.rgb , tex2DArrayNode122_g235708.a));
					float4 lerpResult131_g235708 = lerp( appendResult210_g235708 , appendResult212_g235708 , Global_TexBlend509_g235664);
					float4 temp_output_171_109_g235705 = lerpResult131_g235708;
					float4 lerpResult174_g235705 = lerp( TVE_PaintParams , temp_output_171_109_g235705 , TVE_PaintLayers[(int)temp_output_82_0_g235705]);
					float4 temp_output_595_109_g235664 = lerpResult174_g235705;
					half4 Paint_Texture71_g235664 = temp_output_595_109_g235664;
					float4 In_PaintTexture204_g235664 = Paint_Texture71_g235664;
					float4 temp_output_203_0_g235691 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g235691 = lerpResult104_g235664;
					float temp_output_132_0_g235689 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g235691 = temp_output_132_0_g235689;
					float4 tex2DArrayNode83_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235691).zw + ( (temp_output_203_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult210_g235691 = (float4(tex2DArrayNode83_g235691.rgb , tex2DArrayNode83_g235691.a));
					float4 temp_output_204_0_g235691 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235691).zw + ( (temp_output_204_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult212_g235691 = (float4(tex2DArrayNode122_g235691.rgb , tex2DArrayNode122_g235691.a));
					float4 lerpResult131_g235691 = lerp( appendResult210_g235691 , appendResult212_g235691 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235689 = lerpResult131_g235691;
					float4 lerpResult145_g235689 = lerp( TVE_AtmoParams , temp_output_137_109_g235689 , TVE_AtmoLayers[(int)temp_output_132_0_g235689]);
					float4 temp_output_590_110_g235664 = lerpResult145_g235689;
					half4 Atmo_Texture80_g235664 = temp_output_590_110_g235664;
					float4 In_AtmoTexture204_g235664 = Atmo_Texture80_g235664;
					float4 temp_output_203_0_g235759 = TVE_EffexBaseCoord;
					float2 lerpResult414_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g235759 = lerpResult414_g235664;
					float temp_output_132_0_g235757 = _GlobalEffexLayerValue;
					float temp_output_82_0_g235759 = temp_output_132_0_g235757;
					float4 tex2DArrayNode83_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235759).zw + ( (temp_output_203_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult210_g235759 = (float4(tex2DArrayNode83_g235759.rgb , tex2DArrayNode83_g235759.a));
					float4 temp_output_204_0_g235759 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235759).zw + ( (temp_output_204_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult212_g235759 = (float4(tex2DArrayNode122_g235759.rgb , tex2DArrayNode122_g235759.a));
					float4 lerpResult131_g235759 = lerp( appendResult210_g235759 , appendResult212_g235759 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235757 = lerpResult131_g235759;
					float4 lerpResult145_g235757 = lerp( TVE_EffexParams , temp_output_137_109_g235757 , TVE_EffexLayers[(int)temp_output_132_0_g235757]);
					float4 temp_output_731_110_g235664 = lerpResult145_g235757;
					half4 Effex_Texture420_g235664 = temp_output_731_110_g235664;
					float4 In_EffexTexture204_g235664 = Effex_Texture420_g235664;
					float4 temp_output_203_0_g235739 = TVE_GlowBaseCoord;
					float2 lerpResult247_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g235739 = lerpResult247_g235664;
					float temp_output_82_0_g235737 = _GlobalGlowLayerValue;
					float temp_output_82_0_g235739 = temp_output_82_0_g235737;
					float4 tex2DArrayNode83_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235739).zw + ( (temp_output_203_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult210_g235739 = (float4(tex2DArrayNode83_g235739.rgb , tex2DArrayNode83_g235739.a));
					float4 temp_output_204_0_g235739 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235739).zw + ( (temp_output_204_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult212_g235739 = (float4(tex2DArrayNode122_g235739.rgb , tex2DArrayNode122_g235739.a));
					float4 lerpResult131_g235739 = lerp( appendResult210_g235739 , appendResult212_g235739 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235737 = lerpResult131_g235739;
					float4 lerpResult167_g235737 = lerp( TVE_GlowParams , temp_output_159_109_g235737 , TVE_GlowLayers[(int)temp_output_82_0_g235737]);
					float4 temp_output_593_109_g235664 = lerpResult167_g235737;
					half4 Glow_Texture248_g235664 = temp_output_593_109_g235664;
					float4 In_GlowTexture204_g235664 = Glow_Texture248_g235664;
					float4 temp_output_203_0_g235675 = TVE_FormBaseCoord;
					float2 lerpResult168_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g235675 = lerpResult168_g235664;
					float temp_output_130_0_g235673 = _GlobalFormLayerValue;
					float temp_output_82_0_g235675 = temp_output_130_0_g235673;
					float4 tex2DArrayNode83_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235675).zw + ( (temp_output_203_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult210_g235675 = (float4(tex2DArrayNode83_g235675.rgb , tex2DArrayNode83_g235675.a));
					float4 temp_output_204_0_g235675 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235675).zw + ( (temp_output_204_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult212_g235675 = (float4(tex2DArrayNode122_g235675.rgb , tex2DArrayNode122_g235675.a));
					float4 lerpResult131_g235675 = lerp( appendResult210_g235675 , appendResult212_g235675 , Global_TexBlend509_g235664);
					float4 temp_output_135_109_g235673 = lerpResult131_g235675;
					float4 lerpResult143_g235673 = lerp( TVE_FormParams , temp_output_135_109_g235673 , TVE_FormLayers[(int)temp_output_130_0_g235673]);
					float4 temp_output_592_0_g235664 = lerpResult143_g235673;
					float4 Form_Texture112_g235664 = temp_output_592_0_g235664;
					float4 In_FormTexture204_g235664 = Form_Texture112_g235664;
					float4 In_LandTexture204_g235664 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g235723 = TVE_VertxBaseCoord;
					float2 lerpResult681_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g235723 = lerpResult681_g235664;
					float temp_output_136_0_g235721 = _GlobalVertxLayerValue;
					float temp_output_82_0_g235723 = temp_output_136_0_g235721;
					float4 tex2DArrayNode83_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235723).zw + ( (temp_output_203_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult210_g235723 = (float4(tex2DArrayNode83_g235723.rgb , tex2DArrayNode83_g235723.a));
					float4 temp_output_204_0_g235723 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235723).zw + ( (temp_output_204_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult212_g235723 = (float4(tex2DArrayNode122_g235723.rgb , tex2DArrayNode122_g235723.a));
					float4 lerpResult131_g235723 = lerp( appendResult210_g235723 , appendResult212_g235723 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235721 = lerpResult131_g235723;
					float4 lerpResult149_g235721 = lerp( TVE_VertxParams , temp_output_141_109_g235721 , TVE_VertxLayers[(int)temp_output_136_0_g235721]);
					float4 temp_output_695_0_g235664 = lerpResult149_g235721;
					half4 Vertx_Texture693_g235664 = temp_output_695_0_g235664;
					float4 In_VertxTexture204_g235664 = Vertx_Texture693_g235664;
					float4 temp_output_203_0_g235699 = TVE_FlowBaseCoord;
					float2 lerpResult400_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g235699 = lerpResult400_g235664;
					float temp_output_136_0_g235697 = _GlobalFlowLayerValue;
					float temp_output_82_0_g235699 = temp_output_136_0_g235697;
					float4 tex2DArrayNode83_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235699).zw + ( (temp_output_203_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult210_g235699 = (float4(tex2DArrayNode83_g235699.rgb , tex2DArrayNode83_g235699.a));
					float4 temp_output_204_0_g235699 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235699).zw + ( (temp_output_204_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult212_g235699 = (float4(tex2DArrayNode122_g235699.rgb , tex2DArrayNode122_g235699.a));
					float4 lerpResult131_g235699 = lerp( appendResult210_g235699 , appendResult212_g235699 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235697 = lerpResult131_g235699;
					float4 lerpResult149_g235697 = lerp( TVE_FlowParams , temp_output_141_109_g235697 , TVE_FlowLayers[(int)temp_output_136_0_g235697]);
					float4 temp_output_594_0_g235664 = lerpResult149_g235697;
					half4 Flow_Texture405_g235664 = temp_output_594_0_g235664;
					float4 In_FlowTexture204_g235664 = Flow_Texture405_g235664;
					half4 User_Texture677_g235664 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g235664 = User_Texture677_g235664;
					BuildGlobalData( Data204_g235664 , In_Dummy204_g235664 , In_CoatTexture204_g235664 , In_DrawTexture204_g235664 , In_PaintTexture204_g235664 , In_AtmoTexture204_g235664 , In_EffexTexture204_g235664 , In_GlowTexture204_g235664 , In_FormTexture204_g235664 , In_LandTexture204_g235664 , In_VertxTexture204_g235664 , In_FlowTexture204_g235664 , In_UserTexture204_g235664 );
					TVEGlobalData Data15_g251675 =(TVEGlobalData)Data204_g235664;
					float Out_Dummy15_g251675 = 0.0;
					float4 Out_CoatTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251675 = float4( 0,0,0,0 );
					BreakData( Data15_g251675 , Out_Dummy15_g251675 , Out_CoatTexture15_g251675 , Out_DrawTexture15_g251675 , Out_PaintTexture15_g251675 , Out_AtmoTexture15_g251675 , Out_EffexTexture15_g251675 , Out_GlowTexture15_g251675 , Out_FormTexture15_g251675 , Out_LandTexture15_g251675 , Out_VertxTexture15_g251675 , Out_FlowTexture15_g251675 , Out_UserTexture15_g251675 );
					float4 Global_FormTexture351_g251665 = Out_FormTexture15_g251675;
					TVEModelData Data15_g251672 =(TVEModelData)Data15_g251663;
					float Out_Dummy15_g251672 = 0.0;
					float3 Out_PositionOS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251672 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251672 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251672 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251672 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251672 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251672 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251672 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251672 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251672 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251672 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251672 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251672 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251672 , Out_Dummy15_g251672 , Out_PositionOS15_g251672 , Out_PositionWS15_g251672 , Out_PositionWO15_g251672 , Out_PositionRawOS15_g251672 , Out_PivotOS15_g251672 , Out_PivotWS15_g251672 , Out_PivotWO15_g251672 , Out_NormalOS15_g251672 , Out_NormalWS15_g251672 , Out_NormalRawOS15_g251672 , Out_TangentOS15_g251672 , Out_TangentWS15_g251672 , Out_BitangentWS15_g251672 , Out_ViewDirWS15_g251672 , Out_CoordsData15_g251672 , Out_VertexData15_g251672 , Out_MasksData15_g251672 , Out_PhaseData15_g251672 , Out_TransformData15_g251672 , Out_RotationData15_g251672 , Out_Interpolator15_g251672 );
					float3 Model_PivotWO353_g251665 = Out_PivotWO15_g251672;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251671 = _ConformMeshMode;
					float Option70_g251671 = temp_output_17_0_g251671;
					half4 Model_VertexData357_g251665 = Out_VertexData15_g251672;
					float4 temp_output_3_0_g251671 = Model_VertexData357_g251665;
					float4 Channel70_g251671 = temp_output_3_0_g251671;
					float localSwitchChannel470_g251671 = SwitchChannel4( Option70_g251671 , Channel70_g251671 );
					float temp_output_390_0_g251665 = localSwitchChannel470_g251671;
					float temp_output_7_0_g251668 = _ConformMeshRemap.x;
					float temp_output_9_0_g251668 = ( temp_output_390_0_g251665 - temp_output_7_0_g251668 );
					float lerpResult374_g251665 = lerp( 1.0 , saturate( ( temp_output_9_0_g251668 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251665 = lerpResult374_g251665;
					float temp_output_328_0_g251665 = ( Blend_VertMask379_g251665 * TVE_IsEnabled );
					half Conform_Mask366_g251665 = temp_output_328_0_g251665;
					float temp_output_322_0_g251665 = ( ( ( ( (Global_FormTexture351_g251665).z - ( (Model_PivotWO353_g251665).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251665 ) );
					float3 appendResult329_g251665 = (float3(0.0 , temp_output_322_0_g251665 , 0.0));
					float3 appendResult387_g251665 = (float3(0.0 , 0.0 , temp_output_322_0_g251665));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251669 = appendResult387_g251665;
					#else
					float3 staticSwitch65_g251669 = appendResult329_g251665;
					#endif
					float3 Blanket_Conform368_g251665 = staticSwitch65_g251669;
					float4 appendResult312_g251665 = (float4(Blanket_Conform368_g251665 , 0.0));
					float4 temp_output_310_0_g251665 = ( Model_TransformData356_g251665 + appendResult312_g251665 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251665 = temp_output_310_0_g251665;
					#else
					float4 staticSwitch364_g251665 = Model_TransformData356_g251665;
					#endif
					half4 Final_TransformData365_g251665 = staticSwitch364_g251665;
					float4 In_TransformData16_g251674 = Final_TransformData365_g251665;
					float4 In_RotationData16_g251674 = Out_RotationData15_g251673;
					float4 In_Interpolator16_g251674 = Out_Interpolator15_g251673;
					BuildVertexData( Data16_g251674 , In_Dummy16_g251674 , In_PositionOS16_g251674 , In_NormalOS16_g251674 , In_TangentOS16_g251674 , In_TransformData16_g251674 , In_RotationData16_g251674 , In_Interpolator16_g251674 );
					TVEVertexData Data15_g251685 =(TVEVertexData)Data16_g251674;
					float Out_Dummy15_g251685 = 0.0;
					float3 Out_PositionOS15_g251685 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251685 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251685 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251685 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251685 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251685 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251685 , Out_Dummy15_g251685 , Out_PositionOS15_g251685 , Out_NormalOS15_g251685 , Out_TangentOS15_g251685 , Out_TransformData15_g251685 , Out_RotationData15_g251685 , Out_Interpolator15_g251685 );
					TVEVertexData Data16_g251686 =(TVEVertexData)Data15_g251685;
					float In_Dummy16_g251686 = 0.0;
					float3 Vertex_PositionOS147_g251676 = Out_PositionOS15_g251685;
					half3 VertexPos40_g251680 = Vertex_PositionOS147_g251676;
					float4 temp_output_1615_33_g251676 = Out_RotationData15_g251685;
					half4 Vertex_RotationData1569_g251676 = temp_output_1615_33_g251676;
					float2 break1582_g251676 = (Vertex_RotationData1569_g251676).xy;
					half Angle44_g251680 = break1582_g251676.y;
					half CosAngle89_g251680 = cos( Angle44_g251680 );
					half SinAngle93_g251680 = sin( Angle44_g251680 );
					float3 appendResult95_g251680 = (float3((VertexPos40_g251680).x , ( ( (VertexPos40_g251680).y * CosAngle89_g251680 ) - ( (VertexPos40_g251680).z * SinAngle93_g251680 ) ) , ( ( (VertexPos40_g251680).y * SinAngle93_g251680 ) + ( (VertexPos40_g251680).z * CosAngle89_g251680 ) )));
					half3 VertexPos40_g251681 = appendResult95_g251680;
					half Angle44_g251681 = -break1582_g251676.x;
					half CosAngle94_g251681 = cos( Angle44_g251681 );
					half SinAngle95_g251681 = sin( Angle44_g251681 );
					float3 appendResult98_g251681 = (float3(( ( (VertexPos40_g251681).x * CosAngle94_g251681 ) - ( (VertexPos40_g251681).y * SinAngle95_g251681 ) ) , ( ( (VertexPos40_g251681).x * SinAngle95_g251681 ) + ( (VertexPos40_g251681).y * CosAngle94_g251681 ) ) , (VertexPos40_g251681).z));
					half3 VertexPos40_g251679 = Vertex_PositionOS147_g251676;
					half Angle44_g251679 = break1582_g251676.y;
					half CosAngle89_g251679 = cos( Angle44_g251679 );
					half SinAngle93_g251679 = sin( Angle44_g251679 );
					float3 appendResult95_g251679 = (float3((VertexPos40_g251679).x , ( ( (VertexPos40_g251679).y * CosAngle89_g251679 ) - ( (VertexPos40_g251679).z * SinAngle93_g251679 ) ) , ( ( (VertexPos40_g251679).y * SinAngle93_g251679 ) + ( (VertexPos40_g251679).z * CosAngle89_g251679 ) )));
					half3 VertexPos40_g251684 = appendResult95_g251679;
					half Angle44_g251684 = break1582_g251676.x;
					half CosAngle91_g251684 = cos( Angle44_g251684 );
					half SinAngle92_g251684 = sin( Angle44_g251684 );
					float3 appendResult93_g251684 = (float3(( ( (VertexPos40_g251684).x * CosAngle91_g251684 ) + ( (VertexPos40_g251684).z * SinAngle92_g251684 ) ) , (VertexPos40_g251684).y , ( ( -(VertexPos40_g251684).x * SinAngle92_g251684 ) + ( (VertexPos40_g251684).z * CosAngle91_g251684 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251682 = appendResult93_g251684;
					#else
					float3 staticSwitch65_g251682 = appendResult98_g251681;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251677 = staticSwitch65_g251682;
					#else
					float3 staticSwitch65_g251677 = Vertex_PositionOS147_g251676;
					#endif
					float3 temp_output_1608_0_g251676 = staticSwitch65_g251677;
					half3 VertexPos40_g251683 = temp_output_1608_0_g251676;
					half Angle44_g251683 = (Vertex_RotationData1569_g251676).z;
					half CosAngle91_g251683 = cos( Angle44_g251683 );
					half SinAngle92_g251683 = sin( Angle44_g251683 );
					float3 appendResult93_g251683 = (float3(( ( (VertexPos40_g251683).x * CosAngle91_g251683 ) + ( (VertexPos40_g251683).z * SinAngle92_g251683 ) ) , (VertexPos40_g251683).y , ( ( -(VertexPos40_g251683).x * SinAngle92_g251683 ) + ( (VertexPos40_g251683).z * CosAngle91_g251683 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251678 = appendResult93_g251683;
					#else
					float3 staticSwitch65_g251678 = temp_output_1608_0_g251676;
					#endif
					float4 temp_output_1615_31_g251676 = Out_TransformData15_g251685;
					half4 Vertex_TransformData1568_g251676 = temp_output_1615_31_g251676;
					half3 Final_PositionOS178_g251676 = ( ( staticSwitch65_g251678 * (Vertex_TransformData1568_g251676).w ) + (Vertex_TransformData1568_g251676).xyz );
					float3 In_PositionOS16_g251686 = Final_PositionOS178_g251676;
					float3 In_NormalOS16_g251686 = Out_NormalOS15_g251685;
					float4 In_TangentOS16_g251686 = Out_TangentOS15_g251685;
					float4 In_TransformData16_g251686 = temp_output_1615_31_g251676;
					float4 In_RotationData16_g251686 = temp_output_1615_33_g251676;
					float4 In_Interpolator16_g251686 = Out_Interpolator15_g251685;
					BuildVertexData( Data16_g251686 , In_Dummy16_g251686 , In_PositionOS16_g251686 , In_NormalOS16_g251686 , In_TangentOS16_g251686 , In_TransformData16_g251686 , In_RotationData16_g251686 , In_Interpolator16_g251686 );
					TVEVertexData Data15_g251689 =(TVEVertexData)Data16_g251686;
					float Out_Dummy15_g251689 = 0.0;
					float3 Out_PositionOS15_g251689 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251689 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251689 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251689 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251689 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251689 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251689 , Out_Dummy15_g251689 , Out_PositionOS15_g251689 , Out_NormalOS15_g251689 , Out_TangentOS15_g251689 , Out_TransformData15_g251689 , Out_RotationData15_g251689 , Out_Interpolator15_g251689 );
					TVEVertexData Data16_g251690 =(TVEVertexData)Data15_g251689;
					float In_Dummy16_g251690 = 0.0;
					TVEModelData Data15_g251688 =(TVEModelData)Data15_g251672;
					float Out_Dummy15_g251688 = 0.0;
					float3 Out_PositionOS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251688 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251688 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251688 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251688 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251688 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251688 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251688 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251688 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251688 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251688 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251688 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251688 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251688 , Out_Dummy15_g251688 , Out_PositionOS15_g251688 , Out_PositionWS15_g251688 , Out_PositionWO15_g251688 , Out_PositionRawOS15_g251688 , Out_PivotOS15_g251688 , Out_PivotWS15_g251688 , Out_PivotWO15_g251688 , Out_NormalOS15_g251688 , Out_NormalWS15_g251688 , Out_NormalRawOS15_g251688 , Out_TangentOS15_g251688 , Out_TangentWS15_g251688 , Out_BitangentWS15_g251688 , Out_ViewDirWS15_g251688 , Out_CoordsData15_g251688 , Out_VertexData15_g251688 , Out_MasksData15_g251688 , Out_PhaseData15_g251688 , Out_TransformData15_g251688 , Out_RotationData15_g251688 , Out_Interpolator15_g251688 );
					float3 In_PositionOS16_g251690 = ( Out_PositionOS15_g251689 + Out_PivotOS15_g251688 );
					float3 In_NormalOS16_g251690 = Out_NormalOS15_g251689;
					float4 In_TangentOS16_g251690 = Out_TangentOS15_g251689;
					float4 In_TransformData16_g251690 = Out_TransformData15_g251689;
					float4 In_RotationData16_g251690 = Out_RotationData15_g251689;
					float4 In_Interpolator16_g251690 = Out_Interpolator15_g251689;
					BuildVertexData( Data16_g251690 , In_Dummy16_g251690 , In_PositionOS16_g251690 , In_NormalOS16_g251690 , In_TangentOS16_g251690 , In_TransformData16_g251690 , In_RotationData16_g251690 , In_Interpolator16_g251690 );
					TVEVertexData Data15_g252100 =(TVEVertexData)Data16_g251690;
					float Out_Dummy15_g252100 = 0.0;
					float3 Out_PositionOS15_g252100 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252100 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252100 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252100 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252100 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252100 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252100 , Out_Dummy15_g252100 , Out_PositionOS15_g252100 , Out_NormalOS15_g252100 , Out_TangentOS15_g252100 , Out_TransformData15_g252100 , Out_RotationData15_g252100 , Out_Interpolator15_g252100 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g235765;
					o.ase_texcoord7.xyz = vertexToFrag76_g235765;
					TVEVertexData Data1902_g251885 = Data16_g251690;
					float4 Out_Interpolator1902_g251885 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251885 = Data1902_g251885.Interpolator;
					}
					float4 vertexToFrag1901_g251885 = Out_Interpolator1902_g251885;
					o.ase_texcoord9 = vertexToFrag1901_g251885;
					float3 vertexPos57_g252092 = v.vertex.xyz;
					float4 ase_positionCS57_g252092 = UnityObjectToClipPos( vertexPos57_g252092 );
					o.ase_texcoord10 = ase_positionCS57_g252092;
					
					o.ase_texcoord8.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord8.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord7.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252100;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );
					half3 tangentWS = UnityObjectToWorldDir( v.tangent.xyz );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					o.tangentWS = half4( tangentWS, v.tangent.w );

					o.ambientOrLightmapUV = 0;
					#ifdef LIGHTMAP_ON
						o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#elif UNITY_SHOULD_SAMPLE_SH
						#ifdef VERTEXLIGHT_ON
							o.ambientOrLightmapUV.rgb += Shade4PointLights(
								unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
								unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
								unity_4LightAtten0, positionWS, normalWS );
						#endif
						//o.ambientOrLightmapUV.rgb = ShadeSHPerVertex( normalWS, o.ambientOrLightmapUV.rgb );
					#endif
					#ifdef DYNAMICLIGHTMAP_ON
						o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					#endif

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						o.tangentWS.zw = v.texcoord.xy;
						o.tangentWS.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#endif

					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
					#if defined( ASE_FOG )
						UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS( o, o.pos );
					#endif
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half4 tangent : TANGENT;
					half3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;

					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.tangent = v.tangent;
					o.normal = v.normal;
					o.texcoord = v.texcoord;
					o.texcoord1 = v.texcoord1;
					o.texcoord2 = v.texcoord2;
					o.texcoord = v.texcoord;
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
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
					o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						SurfaceOutput o = (SurfaceOutput)0;
					#else
						#if defined(_SPECULAR_SETUP)
							SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
						#else
							SurfaceOutputStandard o = (SurfaceOutputStandard)0;
						#endif
					#endif

					half atten;
					{
						#if defined( ASE_RECEIVE_SHADOWS )
							UNITY_LIGHT_ATTENUATION( temp, IN, IN.worldPos.xyz )
							atten = temp;
						#else
							atten = 1;
						#endif
					}

					float3 PositionWS = IN.worldPos.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;
					half3 LightAtten = atten;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float temp_output_2682_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2682_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2682_114).xxx;
					
					float3 color130_g252092 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g252092 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g252094 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g252093 = ( temp_cast_4 * ( 0.5 + appendResult128_g252094 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g252093 = (float4(ddx( FinalUV13_g252093 ) , ddy( FinalUV13_g252093 )));
					float4 UVDerivatives17_g252093 = appendResult16_g252093;
					float4 break28_g252093 = UVDerivatives17_g252093;
					float2 appendResult19_g252093 = (float2(break28_g252093.x , break28_g252093.z));
					float2 appendResult20_g252093 = (float2(break28_g252093.x , break28_g252093.z));
					float dotResult24_g252093 = dot( appendResult19_g252093 , appendResult20_g252093 );
					float2 appendResult21_g252093 = (float2(break28_g252093.y , break28_g252093.w));
					float2 appendResult22_g252093 = (float2(break28_g252093.y , break28_g252093.w));
					float dotResult23_g252093 = dot( appendResult21_g252093 , appendResult22_g252093 );
					float2 appendResult25_g252093 = (float2(dotResult24_g252093 , dotResult23_g252093));
					float2 derivativesLength29_g252093 = sqrt( appendResult25_g252093 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g252093 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g252093 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g252093 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g252093 = clampResult57_g252093;
					float2 break55_g252093 = derivativesLength29_g252093;
					float4 lerpResult73_g252093 = lerp( float4( color130_g252092 , 0.0 ) , float4( color81_g252092 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g252093.x * break71_g252093.y * sqrt( saturate( ( 1.1 - max( break55_g252093.x, break55_g252093.y ) ) ) ) ) ) ));
					float3 color107_g252084 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252084 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g252083 = ( 0.0 );
					float localIfMasksData25_g252082 = ( 0.0 );
					TVEMasksData Data25_g252082 = (TVEMasksData)0;
					float localBuildMasksData3_g251944 = ( 0.0 );
					TVEMasksData Data3_g251944 = (TVEMasksData)0;
					half Feature_Intensity1204_g251928 = _SecondIntensityValue;
					float ifLocalVar18_g251945 = 0;
					if( Feature_Intensity1204_g251928 <= 0.0 )
					ifLocalVar18_g251945 = 0.0;
					else
					ifLocalVar18_g251945 = 1.0;
					half Feature_Element1203_g251928 = _SecondCoatMode;
					float ifLocalVar18_g251946 = 0;
					if( Feature_Element1203_g251928 <= 0.0 )
					ifLocalVar18_g251946 = 0.0;
					else
					ifLocalVar18_g251946 = 1.0;
					float4 appendResult1090_g251928 = (float4(ifLocalVar18_g251945 , 0.0 , 0.0 , ifLocalVar18_g251946));
					float4 In_MaskA3_g251944 = appendResult1090_g251928;
					float temp_output_17_0_g251981 = _SecondMaskMode;
					float Option70_g251981 = temp_output_17_0_g251981;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251962) = _SecondMaskTex;
					SamplerState Sampler276_g251962 = sampler_Linear_Repeat;
					float localBreakTextureData456_g251962 = ( 0.0 );
					float localBuildTextureData431_g251976 = ( 0.0 );
					TVEMasksData Data431_g251976 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251976 = ( 0.0 );
					float4 temp_output_6_0_g251933 = _second_mask_coord_value;
					float4 temp_output_7_0_g251933 = ( _SecondMaskSampleMode + _SecondMaskCoordMode + _SecondMaskCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251933 = ( temp_output_6_0_g251933 + temp_output_7_0_g251933 );
					#else
					float4 staticSwitch14_g251933 = temp_output_6_0_g251933;
					#endif
					half4 Local_MaskCoordValue813_g251928 = staticSwitch14_g251933;
					float4 Coords444_g251976 = Local_MaskCoordValue813_g251928;
					TVEModelData Data16_g235773 =(TVEModelData)0;
					float In_Dummy16_g235773 = 0.0;
					float3 vertexToFrag73_g235765 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g235765 = vertexToFrag73_g235765;
					float3 In_PositionWS16_g235773 = PositionWS122_g235765;
					float3 vertexToFrag76_g235765 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g235765 = vertexToFrag76_g235765;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g235765 = ( PositionWS122_g235765 - PivotWS121_g235765 );
					#else
					float3 staticSwitch204_g235765 = PositionWS122_g235765;
					#endif
					float3 PositionWO132_g235765 = ( staticSwitch204_g235765 - TVE_WorldOrigin );
					float3 In_PositionWO16_g235773 = PositionWO132_g235765;
					float3 In_PivotWS16_g235773 = PivotWS121_g235765;
					float3 PivotWO133_g235765 = ( PivotWS121_g235765 - TVE_WorldOrigin );
					float3 In_PivotWO16_g235773 = PivotWO133_g235765;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g235765 = normalizedWorldNormal;
					float3 In_NormalWS16_g235773 = NormalWS95_g235765;
					half3 TangentWS136_g235765 = TangentWS;
					float3 In_TangentWS16_g235773 = TangentWS136_g235765;
					half3 BiangentWS421_g235765 = BitangentWS;
					float3 In_BitangentWS16_g235773 = BiangentWS421_g235765;
					half3 NormalWS427_g235765 = NormalWS95_g235765;
					half3 localComputeTriplanarMasks427_g235765 = ComputeTriplanarMasks( NormalWS427_g235765 );
					half3 TriplanarWeights429_g235765 = localComputeTriplanarMasks427_g235765;
					float3 In_TriplanarWeights16_g235773 = TriplanarWeights429_g235765;
					float3 normalizeResult296_g235765 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g235765 ) );
					half3 ViewDirWS169_g235765 = normalizeResult296_g235765;
					float3 In_ViewDirWS16_g235773 = ViewDirWS169_g235765;
					float4 appendResult397_g235765 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g235765 = appendResult397_g235765;
					float4 In_CoordsData16_g235773 = CoordsData398_g235765;
					half4 VertexMasks171_g235765 = IN.ase_color;
					float4 In_VertexData16_g235773 = VertexMasks171_g235765;
					float temp_output_17_0_g235776 = _ObjectPhaseMode;
					float Option70_g235776 = temp_output_17_0_g235776;
					float4 temp_output_3_0_g235776 = IN.ase_color;
					float4 Channel70_g235776 = temp_output_3_0_g235776;
					float localSwitchChannel470_g235776 = SwitchChannel4( Option70_g235776 , Channel70_g235776 );
					half Phase_Value372_g235765 = localSwitchChannel470_g235776;
					float3 break319_g235765 = PivotWO133_g235765;
					half Pivot_Position322_g235765 = ( break319_g235765.x + break319_g235765.z );
					half Phase_Position357_g235765 = ( Phase_Value372_g235765 + Pivot_Position322_g235765 );
					float temp_output_248_0_g235765 = frac( Phase_Position357_g235765 );
					float4 appendResult177_g235765 = (float4((frac( ( Phase_Position357_g235765 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g235765));
					half4 Phase_Data176_g235765 = appendResult177_g235765;
					float4 In_Interpolator16_g235773 = Phase_Data176_g235765;
					BuildModelFragData( Data16_g235773 , In_Dummy16_g235773 , In_PositionWS16_g235773 , In_PositionWO16_g235773 , In_PivotWS16_g235773 , In_PivotWO16_g235773 , In_NormalWS16_g235773 , In_TangentWS16_g235773 , In_BitangentWS16_g235773 , In_TriplanarWeights16_g235773 , In_ViewDirWS16_g235773 , In_CoordsData16_g235773 , In_VertexData16_g235773 , In_Interpolator16_g235773 );
					TVEModelData Data15_g251931 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g251931 = 0.0;
					float3 Out_PositionWS15_g251931 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251931 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251931 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251931 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251931 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251931 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251931 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251931 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251931 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251931 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251931 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251931 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251931 , Out_Dummy15_g251931 , Out_PositionWS15_g251931 , Out_PositionWO15_g251931 , Out_PivotWS15_g251931 , Out_PivotWO15_g251931 , Out_NormalWS15_g251931 , Out_TangentWS15_g251931 , Out_BitangentWS15_g251931 , Out_TriplanarWeights15_g251931 , Out_ViewDirWS15_g251931 , Out_CoordsData15_g251931 , Out_VertexData15_g251931 , Out_Interpolator15_g251931 );
					float4 Model_CoordsData1099_g251928 = Out_CoordsData15_g251931;
					float4 MeshCoords444_g251976 = Model_CoordsData1099_g251928;
					float2 UV0444_g251976 = float2( 0,0 );
					float2 UV3444_g251976 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251976 , MeshCoords444_g251976 , UV0444_g251976 , UV3444_g251976 );
					float4 appendResult430_g251976 = (float4(UV0444_g251976 , UV3444_g251976));
					float4 In_MaskA431_g251976 = appendResult430_g251976;
					float localComputeWorldCoords315_g251976 = ( 0.0 );
					float4 Coords315_g251976 = Local_MaskCoordValue813_g251928;
					float3 Model_PositionWO636_g251928 = Out_PositionWO15_g251931;
					float3 PositionWS315_g251976 = Model_PositionWO636_g251928;
					float2 ZY315_g251976 = float2( 0,0 );
					float2 XZ315_g251976 = float2( 0,0 );
					float2 XY315_g251976 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251976 , PositionWS315_g251976 , ZY315_g251976 , XZ315_g251976 , XY315_g251976 );
					float2 ZY402_g251976 = ZY315_g251976;
					float2 XZ403_g251976 = XZ315_g251976;
					float4 appendResult432_g251976 = (float4(ZY402_g251976 , XZ403_g251976));
					float4 In_MaskB431_g251976 = appendResult432_g251976;
					float2 XY404_g251976 = XY315_g251976;
					float localComputeStochasticCoords409_g251976 = ( 0.0 );
					float2 UV409_g251976 = ZY402_g251976;
					float2 UV1409_g251976 = float2( 0,0 );
					float2 UV2409_g251976 = float2( 0,0 );
					float2 UV3409_g251976 = float2( 0,0 );
					float3 Weights409_g251976 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251976 , UV1409_g251976 , UV2409_g251976 , UV3409_g251976 , Weights409_g251976 );
					float4 appendResult433_g251976 = (float4(XY404_g251976 , UV1409_g251976));
					float4 In_MaskC431_g251976 = appendResult433_g251976;
					float4 appendResult434_g251976 = (float4(UV2409_g251976 , UV3409_g251976));
					float4 In_MaskD431_g251976 = appendResult434_g251976;
					float localComputeStochasticCoords422_g251976 = ( 0.0 );
					float2 UV422_g251976 = XZ403_g251976;
					float2 UV1422_g251976 = float2( 0,0 );
					float2 UV2422_g251976 = float2( 0,0 );
					float2 UV3422_g251976 = float2( 0,0 );
					float3 Weights422_g251976 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251976 , UV1422_g251976 , UV2422_g251976 , UV3422_g251976 , Weights422_g251976 );
					float4 appendResult435_g251976 = (float4(UV1422_g251976 , UV2422_g251976));
					float4 In_MaskE431_g251976 = appendResult435_g251976;
					float localComputeStochasticCoords423_g251976 = ( 0.0 );
					float2 UV423_g251976 = XY404_g251976;
					float2 UV1423_g251976 = float2( 0,0 );
					float2 UV2423_g251976 = float2( 0,0 );
					float2 UV3423_g251976 = float2( 0,0 );
					float3 Weights423_g251976 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251976 , UV1423_g251976 , UV2423_g251976 , UV3423_g251976 , Weights423_g251976 );
					float4 appendResult436_g251976 = (float4(UV3422_g251976 , UV1423_g251976));
					float4 In_MaskF431_g251976 = appendResult436_g251976;
					float4 appendResult437_g251976 = (float4(UV2423_g251976 , UV3423_g251976));
					float4 In_MaskG431_g251976 = appendResult437_g251976;
					float4 In_MaskH431_g251976 = float4( Weights409_g251976 , 0.0 );
					float4 In_MaskI431_g251976 = float4( Weights422_g251976 , 0.0 );
					float4 In_MaskJ431_g251976 = float4( Weights423_g251976 , 0.0 );
					half3 Model_NormalWS869_g251928 = Out_NormalWS15_g251931;
					float3 temp_output_449_0_g251976 = Model_NormalWS869_g251928;
					float4 In_MaskK431_g251976 = float4( temp_output_449_0_g251976 , 0.0 );
					half3 Model_TangentWS1215_g251928 = Out_TangentWS15_g251931;
					float3 temp_output_450_0_g251976 = Model_TangentWS1215_g251928;
					float4 In_MaskL431_g251976 = float4( temp_output_450_0_g251976 , 0.0 );
					half3 Model_BitangentWS1216_g251928 = Out_BitangentWS15_g251931;
					float3 temp_output_451_0_g251976 = Model_BitangentWS1216_g251928;
					float4 In_MaskM431_g251976 = float4( temp_output_451_0_g251976 , 0.0 );
					half3 Model_TriplanarWeights1217_g251928 = Out_TriplanarWeights15_g251931;
					float3 temp_output_445_0_g251976 = Model_TriplanarWeights1217_g251928;
					float4 In_MaskN431_g251976 = float4( temp_output_445_0_g251976 , 0.0 );
					BuildTextureData( Data431_g251976 , In_MaskA431_g251976 , In_MaskB431_g251976 , In_MaskC431_g251976 , In_MaskD431_g251976 , In_MaskE431_g251976 , In_MaskF431_g251976 , In_MaskG431_g251976 , In_MaskH431_g251976 , In_MaskI431_g251976 , In_MaskJ431_g251976 , In_MaskK431_g251976 , In_MaskL431_g251976 , In_MaskM431_g251976 , In_MaskN431_g251976 );
					TVEMasksData Data456_g251962 =(TVEMasksData)Data431_g251976;
					float4 Out_MaskA456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251962 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251962 , Out_MaskA456_g251962 , Out_MaskB456_g251962 , Out_MaskC456_g251962 , Out_MaskD456_g251962 , Out_MaskE456_g251962 , Out_MaskF456_g251962 , Out_MaskG456_g251962 , Out_MaskH456_g251962 , Out_MaskI456_g251962 , Out_MaskJ456_g251962 , Out_MaskK456_g251962 , Out_MaskL456_g251962 , Out_MaskM456_g251962 , Out_MaskN456_g251962 );
					half2 UV276_g251962 = (Out_MaskA456_g251962).xy;
					float temp_output_504_0_g251962 = 0.0;
					half Bias276_g251962 = temp_output_504_0_g251962;
					half2 Normal276_g251962 = float2( 0,0 );
					half4 localSampleCoord276_g251962 = SampleCoord( Texture276_g251962 , Sampler276_g251962 , UV276_g251962 , Bias276_g251962 , Normal276_g251962 );
					float4 temp_output_868_277_g251928 = localSampleCoord276_g251962;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251962) = _SecondMaskTex;
					SamplerState Sampler502_g251962 = sampler_Linear_Repeat;
					half2 UV502_g251962 = (Out_MaskA456_g251962).zw;
					half Bias502_g251962 = temp_output_504_0_g251962;
					half2 Normal502_g251962 = float2( 0,0 );
					half4 localSampleCoord502_g251962 = SampleCoord( Texture502_g251962 , Sampler502_g251962 , UV502_g251962 , Bias502_g251962 , Normal502_g251962 );
					float4 temp_output_868_278_g251928 = localSampleCoord502_g251962;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251962) = _SecondMaskTex;
					SamplerState Sampler496_g251962 = sampler_Linear_Repeat;
					float2 temp_output_463_0_g251962 = (Out_MaskB456_g251962).zw;
					half2 XZ496_g251962 = temp_output_463_0_g251962;
					half Bias496_g251962 = temp_output_504_0_g251962;
					half3 NormalWS512_g251962 = (Out_MaskK456_g251962).xyz;
					half3 NormalWS496_g251962 = NormalWS512_g251962;
					half3 Normal496_g251962 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251962 = SamplePlanar2D( Texture496_g251962 , Sampler496_g251962 , XZ496_g251962 , Bias496_g251962 , NormalWS496_g251962 , Normal496_g251962 );
					float4 temp_output_868_0_g251928 = localSamplePlanar2D496_g251962;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251962) = _SecondMaskTex;
					SamplerState Sampler490_g251962 = sampler_Linear_Repeat;
					float2 temp_output_462_0_g251962 = (Out_MaskB456_g251962).xy;
					half2 ZY490_g251962 = temp_output_462_0_g251962;
					half2 XZ490_g251962 = temp_output_463_0_g251962;
					float2 temp_output_464_0_g251962 = (Out_MaskC456_g251962).xy;
					half2 XY490_g251962 = temp_output_464_0_g251962;
					half Bias490_g251962 = temp_output_504_0_g251962;
					half3 Triplanar522_g251962 = (Out_MaskN456_g251962).xyz;
					half3 Triplanar490_g251962 = Triplanar522_g251962;
					half3 NormalWS490_g251962 = NormalWS512_g251962;
					half3 Normal490_g251962 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251962 = SamplePlanar3D( Texture490_g251962 , Sampler490_g251962 , ZY490_g251962 , XZ490_g251962 , XY490_g251962 , Bias490_g251962 , Triplanar490_g251962 , NormalWS490_g251962 , Normal490_g251962 );
					float4 temp_output_868_201_g251928 = localSamplePlanar3D490_g251962;
					#if defined( TVE_SECOND_MASK_SAMPLE_MAIN_UV )
					float4 staticSwitch817_g251928 = temp_output_868_277_g251928;
					#elif defined( TVE_SECOND_MASK_SAMPLE_EXTRA_UV )
					float4 staticSwitch817_g251928 = temp_output_868_278_g251928;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_2D )
					float4 staticSwitch817_g251928 = temp_output_868_0_g251928;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_3D )
					float4 staticSwitch817_g251928 = temp_output_868_201_g251928;
					#else
					float4 staticSwitch817_g251928 = temp_output_868_277_g251928;
					#endif
					half4 Local_MaskSample861_g251928 = staticSwitch817_g251928;
					float4 temp_output_3_0_g251981 = Local_MaskSample861_g251928;
					float4 Channel70_g251981 = temp_output_3_0_g251981;
					float localSwitchChannel470_g251981 = SwitchChannel4( Option70_g251981 , Channel70_g251981 );
					float temp_output_1226_0_g251928 = localSwitchChannel470_g251981;
					float temp_output_7_0_g251986 = _SecondMaskRemap.x;
					float temp_output_9_0_g251986 = ( temp_output_1226_0_g251928 - temp_output_7_0_g251986 );
					float lerpResult1015_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251986 * _SecondMaskRemap.z ) ) , _SecondMaskValue);
					#ifdef TVE_SECOND_MASK
					float staticSwitch1088_g251928 = lerpResult1015_g251928;
					#else
					float staticSwitch1088_g251928 = 1.0;
					#endif
					half Blend_TexMask429_g251928 = staticSwitch1088_g251928;
					float localBreakVisualData4_g251949 = ( 0.0 );
					float localBuildVisualData3_g251891 = ( 0.0 );
					float localBuildVisualData3_g251886 = ( 0.0 );
					TVEVisualData Data3_g251886 =(TVEVisualData)0;
					float temp_output_14_0_g251886 = 0.0;
					float In_Dummy3_g251886 = temp_output_14_0_g251886;
					float3 temp_cast_18 = (0.5).xxx;
					float3 temp_output_4_0_g251886 = temp_cast_18;
					float3 In_Albedo3_g251886 = temp_output_4_0_g251886;
					float3 temp_cast_19 = (0.5).xxx;
					float3 temp_output_44_0_g251886 = temp_cast_19;
					float3 In_AlbedoBase3_g251886 = temp_output_44_0_g251886;
					float2 temp_cast_20 = (0.0).xx;
					float2 In_NormalTS3_g251886 = temp_cast_20;
					float3 temp_cast_21 = (0.5).xxx;
					float3 In_NormalWS3_g251886 = temp_cast_21;
					float4 In_Shader3_g251886 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251886 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251886 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251886 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251886 = 0.5;
					float In_Grayscale3_g251886 = temp_output_12_0_g251886;
					float temp_output_16_0_g251886 = 1.0;
					float In_Luminosity3_g251886 = temp_output_16_0_g251886;
					float In_MultiMask3_g251886 = 1.0;
					float In_AlphaClip3_g251886 = 1.0;
					float In_AlphaFade3_g251886 = 1.0;
					float3 temp_cast_22 = (1.0).xxx;
					float3 In_Translucency3_g251886 = temp_cast_22;
					float In_Transmission3_g251886 = 1.0;
					float In_Thickness3_g251886 = 0.0;
					float In_Diffusion3_g251886 = 0.0;
					float In_Depth3_g251886 = 0.0;
					BuildVisualData( Data3_g251886 , In_Dummy3_g251886 , In_Albedo3_g251886 , In_AlbedoBase3_g251886 , In_NormalTS3_g251886 , In_NormalWS3_g251886 , In_Shader3_g251886 , In_Feature3_g251886 , In_Season3_g251886 , In_Emissive3_g251886 , In_Grayscale3_g251886 , In_Luminosity3_g251886 , In_MultiMask3_g251886 , In_AlphaClip3_g251886 , In_AlphaFade3_g251886 , In_Translucency3_g251886 , In_Transmission3_g251886 , In_Thickness3_g251886 , In_Diffusion3_g251886 , In_Depth3_g251886 );
					TVEVisualData Data3_g251891 =(TVEVisualData)Data3_g251886;
					half Dummy130_g251889 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251891 = Dummy130_g251889;
					float In_Dummy3_g251891 = temp_output_14_0_g251891;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251912) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251894 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251912 = staticSwitch36_g251894;
					float localBreakTextureData456_g251912 = ( 0.0 );
					float localBuildTextureData431_g251911 = ( 0.0 );
					TVEMasksData Data431_g251911 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251911 = ( 0.0 );
					float4 temp_output_6_0_g251927 = _main_coord_value;
					float4 temp_output_7_0_g251927 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251927 = ( temp_output_6_0_g251927 + temp_output_7_0_g251927 );
					#else
					float4 staticSwitch14_g251927 = temp_output_6_0_g251927;
					#endif
					half4 Local_Coords180_g251889 = staticSwitch14_g251927;
					float4 Coords444_g251911 = Local_Coords180_g251889;
					TVEModelData Data15_g251887 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g251887 = 0.0;
					float3 Out_PositionWS15_g251887 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251887 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251887 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251887 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251887 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251887 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251887 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251887 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251887 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251887 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251887 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251887 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251887 , Out_Dummy15_g251887 , Out_PositionWS15_g251887 , Out_PositionWO15_g251887 , Out_PivotWS15_g251887 , Out_PivotWO15_g251887 , Out_NormalWS15_g251887 , Out_TangentWS15_g251887 , Out_BitangentWS15_g251887 , Out_TriplanarWeights15_g251887 , Out_ViewDirWS15_g251887 , Out_CoordsData15_g251887 , Out_VertexData15_g251887 , Out_Interpolator15_g251887 );
					TVEModelData Data16_g251888 =(TVEModelData)Data15_g251887;
					float In_Dummy16_g251888 = Out_Dummy15_g251887;
					float3 In_PositionWS16_g251888 = Out_PositionWS15_g251887;
					float3 In_PositionWO16_g251888 = Out_PositionWO15_g251887;
					float3 In_PivotWS16_g251888 = Out_PivotWS15_g251887;
					float3 In_PivotWO16_g251888 = Out_PivotWO15_g251887;
					float3 In_NormalWS16_g251888 = Out_NormalWS15_g251887;
					float3 In_TangentWS16_g251888 = Out_TangentWS15_g251887;
					float3 In_BitangentWS16_g251888 = Out_BitangentWS15_g251887;
					float3 In_TriplanarWeights16_g251888 = Out_TriplanarWeights15_g251887;
					float3 In_ViewDirWS16_g251888 = Out_ViewDirWS15_g251887;
					float4 In_CoordsData16_g251888 = Out_CoordsData15_g251887;
					float4 In_VertexData16_g251888 = Out_VertexData15_g251887;
					float4 vertexToFrag1901_g251885 = IN.ase_texcoord9;
					float4 In_Interpolator16_g251888 = vertexToFrag1901_g251885;
					BuildModelFragData( Data16_g251888 , In_Dummy16_g251888 , In_PositionWS16_g251888 , In_PositionWO16_g251888 , In_PivotWS16_g251888 , In_PivotWO16_g251888 , In_NormalWS16_g251888 , In_TangentWS16_g251888 , In_BitangentWS16_g251888 , In_TriplanarWeights16_g251888 , In_ViewDirWS16_g251888 , In_CoordsData16_g251888 , In_VertexData16_g251888 , In_Interpolator16_g251888 );
					TVEModelData Data15_g251890 =(TVEModelData)Data16_g251888;
					float Out_Dummy15_g251890 = 0.0;
					float3 Out_PositionWS15_g251890 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251890 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251890 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251890 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251890 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251890 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251890 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251890 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251890 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251890 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251890 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251890 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251890 , Out_Dummy15_g251890 , Out_PositionWS15_g251890 , Out_PositionWO15_g251890 , Out_PivotWS15_g251890 , Out_PivotWO15_g251890 , Out_NormalWS15_g251890 , Out_TangentWS15_g251890 , Out_BitangentWS15_g251890 , Out_TriplanarWeights15_g251890 , Out_ViewDirWS15_g251890 , Out_CoordsData15_g251890 , Out_VertexData15_g251890 , Out_Interpolator15_g251890 );
					float4 Model_CoordsData324_g251889 = Out_CoordsData15_g251890;
					float4 MeshCoords444_g251911 = Model_CoordsData324_g251889;
					float2 UV0444_g251911 = float2( 0,0 );
					float2 UV3444_g251911 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251911 , MeshCoords444_g251911 , UV0444_g251911 , UV3444_g251911 );
					float4 appendResult430_g251911 = (float4(UV0444_g251911 , UV3444_g251911));
					float4 In_MaskA431_g251911 = appendResult430_g251911;
					float localComputeWorldCoords315_g251911 = ( 0.0 );
					float4 Coords315_g251911 = Local_Coords180_g251889;
					float3 Model_PositionWO222_g251889 = Out_PositionWO15_g251890;
					float3 PositionWS315_g251911 = Model_PositionWO222_g251889;
					float2 ZY315_g251911 = float2( 0,0 );
					float2 XZ315_g251911 = float2( 0,0 );
					float2 XY315_g251911 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251911 , PositionWS315_g251911 , ZY315_g251911 , XZ315_g251911 , XY315_g251911 );
					float2 ZY402_g251911 = ZY315_g251911;
					float2 XZ403_g251911 = XZ315_g251911;
					float4 appendResult432_g251911 = (float4(ZY402_g251911 , XZ403_g251911));
					float4 In_MaskB431_g251911 = appendResult432_g251911;
					float2 XY404_g251911 = XY315_g251911;
					float localComputeStochasticCoords409_g251911 = ( 0.0 );
					float2 UV409_g251911 = ZY402_g251911;
					float2 UV1409_g251911 = float2( 0,0 );
					float2 UV2409_g251911 = float2( 0,0 );
					float2 UV3409_g251911 = float2( 0,0 );
					float3 Weights409_g251911 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251911 , UV1409_g251911 , UV2409_g251911 , UV3409_g251911 , Weights409_g251911 );
					float4 appendResult433_g251911 = (float4(XY404_g251911 , UV1409_g251911));
					float4 In_MaskC431_g251911 = appendResult433_g251911;
					float4 appendResult434_g251911 = (float4(UV2409_g251911 , UV3409_g251911));
					float4 In_MaskD431_g251911 = appendResult434_g251911;
					float localComputeStochasticCoords422_g251911 = ( 0.0 );
					float2 UV422_g251911 = XZ403_g251911;
					float2 UV1422_g251911 = float2( 0,0 );
					float2 UV2422_g251911 = float2( 0,0 );
					float2 UV3422_g251911 = float2( 0,0 );
					float3 Weights422_g251911 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251911 , UV1422_g251911 , UV2422_g251911 , UV3422_g251911 , Weights422_g251911 );
					float4 appendResult435_g251911 = (float4(UV1422_g251911 , UV2422_g251911));
					float4 In_MaskE431_g251911 = appendResult435_g251911;
					float localComputeStochasticCoords423_g251911 = ( 0.0 );
					float2 UV423_g251911 = XY404_g251911;
					float2 UV1423_g251911 = float2( 0,0 );
					float2 UV2423_g251911 = float2( 0,0 );
					float2 UV3423_g251911 = float2( 0,0 );
					float3 Weights423_g251911 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251911 , UV1423_g251911 , UV2423_g251911 , UV3423_g251911 , Weights423_g251911 );
					float4 appendResult436_g251911 = (float4(UV3422_g251911 , UV1423_g251911));
					float4 In_MaskF431_g251911 = appendResult436_g251911;
					float4 appendResult437_g251911 = (float4(UV2423_g251911 , UV3423_g251911));
					float4 In_MaskG431_g251911 = appendResult437_g251911;
					float4 In_MaskH431_g251911 = float4( Weights409_g251911 , 0.0 );
					float4 In_MaskI431_g251911 = float4( Weights422_g251911 , 0.0 );
					float4 In_MaskJ431_g251911 = float4( Weights423_g251911 , 0.0 );
					half3 Model_NormalWS226_g251889 = Out_NormalWS15_g251890;
					float3 temp_output_449_0_g251911 = Model_NormalWS226_g251889;
					float4 In_MaskK431_g251911 = float4( temp_output_449_0_g251911 , 0.0 );
					half3 Model_TangentWS366_g251889 = Out_TangentWS15_g251890;
					float3 temp_output_450_0_g251911 = Model_TangentWS366_g251889;
					float4 In_MaskL431_g251911 = float4( temp_output_450_0_g251911 , 0.0 );
					half3 Model_BitangentWS367_g251889 = Out_BitangentWS15_g251890;
					float3 temp_output_451_0_g251911 = Model_BitangentWS367_g251889;
					float4 In_MaskM431_g251911 = float4( temp_output_451_0_g251911 , 0.0 );
					half3 Model_TriplanarWeights368_g251889 = Out_TriplanarWeights15_g251890;
					float3 temp_output_445_0_g251911 = Model_TriplanarWeights368_g251889;
					float4 In_MaskN431_g251911 = float4( temp_output_445_0_g251911 , 0.0 );
					BuildTextureData( Data431_g251911 , In_MaskA431_g251911 , In_MaskB431_g251911 , In_MaskC431_g251911 , In_MaskD431_g251911 , In_MaskE431_g251911 , In_MaskF431_g251911 , In_MaskG431_g251911 , In_MaskH431_g251911 , In_MaskI431_g251911 , In_MaskJ431_g251911 , In_MaskK431_g251911 , In_MaskL431_g251911 , In_MaskM431_g251911 , In_MaskN431_g251911 );
					TVEMasksData Data456_g251912 =(TVEMasksData)Data431_g251911;
					float4 Out_MaskA456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251912 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251912 , Out_MaskA456_g251912 , Out_MaskB456_g251912 , Out_MaskC456_g251912 , Out_MaskD456_g251912 , Out_MaskE456_g251912 , Out_MaskF456_g251912 , Out_MaskG456_g251912 , Out_MaskH456_g251912 , Out_MaskI456_g251912 , Out_MaskJ456_g251912 , Out_MaskK456_g251912 , Out_MaskL456_g251912 , Out_MaskM456_g251912 , Out_MaskN456_g251912 );
					half2 UV276_g251912 = (Out_MaskA456_g251912).xy;
					float temp_output_504_0_g251912 = 0.0;
					half Bias276_g251912 = temp_output_504_0_g251912;
					half2 Normal276_g251912 = float2( 0,0 );
					half4 localSampleCoord276_g251912 = SampleCoord( Texture276_g251912 , Sampler276_g251912 , UV276_g251912 , Bias276_g251912 , Normal276_g251912 );
					float4 temp_output_407_277_g251889 = localSampleCoord276_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251912) = _MainAlbedoTex;
					SamplerState Sampler502_g251912 = staticSwitch36_g251894;
					half2 UV502_g251912 = (Out_MaskA456_g251912).zw;
					half Bias502_g251912 = temp_output_504_0_g251912;
					half2 Normal502_g251912 = float2( 0,0 );
					half4 localSampleCoord502_g251912 = SampleCoord( Texture502_g251912 , Sampler502_g251912 , UV502_g251912 , Bias502_g251912 , Normal502_g251912 );
					float4 temp_output_407_278_g251889 = localSampleCoord502_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251912) = _MainAlbedoTex;
					SamplerState Sampler496_g251912 = staticSwitch36_g251894;
					float2 temp_output_463_0_g251912 = (Out_MaskB456_g251912).zw;
					half2 XZ496_g251912 = temp_output_463_0_g251912;
					half Bias496_g251912 = temp_output_504_0_g251912;
					half3 NormalWS512_g251912 = (Out_MaskK456_g251912).xyz;
					half3 NormalWS496_g251912 = NormalWS512_g251912;
					half3 Normal496_g251912 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251912 = SamplePlanar2D( Texture496_g251912 , Sampler496_g251912 , XZ496_g251912 , Bias496_g251912 , NormalWS496_g251912 , Normal496_g251912 );
					float4 temp_output_407_0_g251889 = localSamplePlanar2D496_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251912) = _MainAlbedoTex;
					SamplerState Sampler490_g251912 = staticSwitch36_g251894;
					float2 temp_output_462_0_g251912 = (Out_MaskB456_g251912).xy;
					half2 ZY490_g251912 = temp_output_462_0_g251912;
					half2 XZ490_g251912 = temp_output_463_0_g251912;
					float2 temp_output_464_0_g251912 = (Out_MaskC456_g251912).xy;
					half2 XY490_g251912 = temp_output_464_0_g251912;
					half Bias490_g251912 = temp_output_504_0_g251912;
					half3 Triplanar522_g251912 = (Out_MaskN456_g251912).xyz;
					half3 Triplanar490_g251912 = Triplanar522_g251912;
					half3 NormalWS490_g251912 = NormalWS512_g251912;
					half3 Normal490_g251912 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251912 = SamplePlanar3D( Texture490_g251912 , Sampler490_g251912 , ZY490_g251912 , XZ490_g251912 , XY490_g251912 , Bias490_g251912 , Triplanar490_g251912 , NormalWS490_g251912 , Normal490_g251912 );
					float4 temp_output_407_201_g251889 = localSamplePlanar3D490_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251912) = _MainAlbedoTex;
					SamplerState Sampler498_g251912 = staticSwitch36_g251894;
					half2 XZ498_g251912 = temp_output_463_0_g251912;
					float2 temp_output_473_0_g251912 = (Out_MaskE456_g251912).xy;
					half2 XZ_1498_g251912 = temp_output_473_0_g251912;
					float2 temp_output_474_0_g251912 = (Out_MaskE456_g251912).zw;
					half2 XZ_2498_g251912 = temp_output_474_0_g251912;
					float2 temp_output_475_0_g251912 = (Out_MaskF456_g251912).xy;
					half2 XZ_3498_g251912 = temp_output_475_0_g251912;
					float temp_output_510_0_g251912 = exp2( temp_output_504_0_g251912 );
					half Bias498_g251912 = temp_output_510_0_g251912;
					float3 temp_output_480_0_g251912 = (Out_MaskI456_g251912).xyz;
					half3 Weights_2498_g251912 = temp_output_480_0_g251912;
					half3 NormalWS498_g251912 = NormalWS512_g251912;
					half3 Normal498_g251912 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251912 = SampleStochastic2D( Texture498_g251912 , Sampler498_g251912 , XZ498_g251912 , XZ_1498_g251912 , XZ_2498_g251912 , XZ_3498_g251912 , Bias498_g251912 , Weights_2498_g251912 , NormalWS498_g251912 , Normal498_g251912 );
					float4 temp_output_407_202_g251889 = localSampleStochastic2D498_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251912) = _MainAlbedoTex;
					SamplerState Sampler500_g251912 = staticSwitch36_g251894;
					half2 ZY500_g251912 = temp_output_462_0_g251912;
					half2 ZY_1500_g251912 = (Out_MaskC456_g251912).zw;
					half2 ZY_2500_g251912 = (Out_MaskD456_g251912).xy;
					half2 ZY_3500_g251912 = (Out_MaskD456_g251912).zw;
					half2 XZ500_g251912 = temp_output_463_0_g251912;
					half2 XZ_1500_g251912 = temp_output_473_0_g251912;
					half2 XZ_2500_g251912 = temp_output_474_0_g251912;
					half2 XZ_3500_g251912 = temp_output_475_0_g251912;
					half2 XY500_g251912 = temp_output_464_0_g251912;
					half2 XY_1500_g251912 = (Out_MaskF456_g251912).zw;
					half2 XY_2500_g251912 = (Out_MaskG456_g251912).xy;
					half2 XY_3500_g251912 = (Out_MaskG456_g251912).zw;
					half Bias500_g251912 = temp_output_510_0_g251912;
					half3 Weights_1500_g251912 = (Out_MaskH456_g251912).xyz;
					half3 Weights_2500_g251912 = temp_output_480_0_g251912;
					half3 Weights_3500_g251912 = (Out_MaskJ456_g251912).xyz;
					half3 Triplanar500_g251912 = Triplanar522_g251912;
					half3 NormalWS500_g251912 = NormalWS512_g251912;
					half3 Normal500_g251912 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251912 = SampleStochastic3D( Texture500_g251912 , Sampler500_g251912 , ZY500_g251912 , ZY_1500_g251912 , ZY_2500_g251912 , ZY_3500_g251912 , XZ500_g251912 , XZ_1500_g251912 , XZ_2500_g251912 , XZ_3500_g251912 , XY500_g251912 , XY_1500_g251912 , XY_2500_g251912 , XY_3500_g251912 , Bias500_g251912 , Weights_1500_g251912 , Weights_2500_g251912 , Weights_3500_g251912 , Triplanar500_g251912 , NormalWS500_g251912 , Normal500_g251912 );
					float4 temp_output_407_203_g251889 = localSampleStochastic3D500_g251912;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251889 = temp_output_407_277_g251889;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251889 = temp_output_407_278_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251889 = temp_output_407_0_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251889 = temp_output_407_201_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251889 = temp_output_407_202_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251889 = temp_output_407_203_g251889;
					#else
					float4 staticSwitch184_g251889 = temp_output_407_277_g251889;
					#endif
					half4 Local_AlbedoSample185_g251889 = staticSwitch184_g251889;
					float3 lerpResult53_g251889 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251889).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251889 = lerpResult53_g251889;
					float temp_output_17_0_g251909 = _MainMultiWriteMode;
					float Option91_g251909 = temp_output_17_0_g251909;
					float4 Model_VertexData418_g251889 = Out_VertexData15_g251890;
					float4 temp_output_84_0_g251909 = Model_VertexData418_g251889;
					float4 ChannelA91_g251909 = temp_output_84_0_g251909;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251897) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251896 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251897 = staticSwitch38_g251896;
					float localBreakTextureData456_g251897 = ( 0.0 );
					TVEMasksData Data456_g251897 =(TVEMasksData)Data431_g251911;
					float4 Out_MaskA456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251897 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251897 , Out_MaskA456_g251897 , Out_MaskB456_g251897 , Out_MaskC456_g251897 , Out_MaskD456_g251897 , Out_MaskE456_g251897 , Out_MaskF456_g251897 , Out_MaskG456_g251897 , Out_MaskH456_g251897 , Out_MaskI456_g251897 , Out_MaskJ456_g251897 , Out_MaskK456_g251897 , Out_MaskL456_g251897 , Out_MaskM456_g251897 , Out_MaskN456_g251897 );
					half2 UV276_g251897 = (Out_MaskA456_g251897).xy;
					float temp_output_504_0_g251897 = 0.0;
					half Bias276_g251897 = temp_output_504_0_g251897;
					half2 Normal276_g251897 = float2( 0,0 );
					half4 localSampleCoord276_g251897 = SampleCoord( Texture276_g251897 , Sampler276_g251897 , UV276_g251897 , Bias276_g251897 , Normal276_g251897 );
					float4 temp_output_405_277_g251889 = localSampleCoord276_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251897) = _MainShaderTex;
					SamplerState Sampler502_g251897 = staticSwitch38_g251896;
					half2 UV502_g251897 = (Out_MaskA456_g251897).zw;
					half Bias502_g251897 = temp_output_504_0_g251897;
					half2 Normal502_g251897 = float2( 0,0 );
					half4 localSampleCoord502_g251897 = SampleCoord( Texture502_g251897 , Sampler502_g251897 , UV502_g251897 , Bias502_g251897 , Normal502_g251897 );
					float4 temp_output_405_278_g251889 = localSampleCoord502_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251897) = _MainShaderTex;
					SamplerState Sampler496_g251897 = staticSwitch38_g251896;
					float2 temp_output_463_0_g251897 = (Out_MaskB456_g251897).zw;
					half2 XZ496_g251897 = temp_output_463_0_g251897;
					half Bias496_g251897 = temp_output_504_0_g251897;
					half3 NormalWS512_g251897 = (Out_MaskK456_g251897).xyz;
					half3 NormalWS496_g251897 = NormalWS512_g251897;
					half3 Normal496_g251897 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251897 = SamplePlanar2D( Texture496_g251897 , Sampler496_g251897 , XZ496_g251897 , Bias496_g251897 , NormalWS496_g251897 , Normal496_g251897 );
					float4 temp_output_405_0_g251889 = localSamplePlanar2D496_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251897) = _MainShaderTex;
					SamplerState Sampler490_g251897 = staticSwitch38_g251896;
					float2 temp_output_462_0_g251897 = (Out_MaskB456_g251897).xy;
					half2 ZY490_g251897 = temp_output_462_0_g251897;
					half2 XZ490_g251897 = temp_output_463_0_g251897;
					float2 temp_output_464_0_g251897 = (Out_MaskC456_g251897).xy;
					half2 XY490_g251897 = temp_output_464_0_g251897;
					half Bias490_g251897 = temp_output_504_0_g251897;
					half3 Triplanar522_g251897 = (Out_MaskN456_g251897).xyz;
					half3 Triplanar490_g251897 = Triplanar522_g251897;
					half3 NormalWS490_g251897 = NormalWS512_g251897;
					half3 Normal490_g251897 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251897 = SamplePlanar3D( Texture490_g251897 , Sampler490_g251897 , ZY490_g251897 , XZ490_g251897 , XY490_g251897 , Bias490_g251897 , Triplanar490_g251897 , NormalWS490_g251897 , Normal490_g251897 );
					float4 temp_output_405_201_g251889 = localSamplePlanar3D490_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251897) = _MainShaderTex;
					SamplerState Sampler498_g251897 = staticSwitch38_g251896;
					half2 XZ498_g251897 = temp_output_463_0_g251897;
					float2 temp_output_473_0_g251897 = (Out_MaskE456_g251897).xy;
					half2 XZ_1498_g251897 = temp_output_473_0_g251897;
					float2 temp_output_474_0_g251897 = (Out_MaskE456_g251897).zw;
					half2 XZ_2498_g251897 = temp_output_474_0_g251897;
					float2 temp_output_475_0_g251897 = (Out_MaskF456_g251897).xy;
					half2 XZ_3498_g251897 = temp_output_475_0_g251897;
					float temp_output_510_0_g251897 = exp2( temp_output_504_0_g251897 );
					half Bias498_g251897 = temp_output_510_0_g251897;
					float3 temp_output_480_0_g251897 = (Out_MaskI456_g251897).xyz;
					half3 Weights_2498_g251897 = temp_output_480_0_g251897;
					half3 NormalWS498_g251897 = NormalWS512_g251897;
					half3 Normal498_g251897 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251897 = SampleStochastic2D( Texture498_g251897 , Sampler498_g251897 , XZ498_g251897 , XZ_1498_g251897 , XZ_2498_g251897 , XZ_3498_g251897 , Bias498_g251897 , Weights_2498_g251897 , NormalWS498_g251897 , Normal498_g251897 );
					float4 temp_output_405_202_g251889 = localSampleStochastic2D498_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251897) = _MainShaderTex;
					SamplerState Sampler500_g251897 = staticSwitch38_g251896;
					half2 ZY500_g251897 = temp_output_462_0_g251897;
					half2 ZY_1500_g251897 = (Out_MaskC456_g251897).zw;
					half2 ZY_2500_g251897 = (Out_MaskD456_g251897).xy;
					half2 ZY_3500_g251897 = (Out_MaskD456_g251897).zw;
					half2 XZ500_g251897 = temp_output_463_0_g251897;
					half2 XZ_1500_g251897 = temp_output_473_0_g251897;
					half2 XZ_2500_g251897 = temp_output_474_0_g251897;
					half2 XZ_3500_g251897 = temp_output_475_0_g251897;
					half2 XY500_g251897 = temp_output_464_0_g251897;
					half2 XY_1500_g251897 = (Out_MaskF456_g251897).zw;
					half2 XY_2500_g251897 = (Out_MaskG456_g251897).xy;
					half2 XY_3500_g251897 = (Out_MaskG456_g251897).zw;
					half Bias500_g251897 = temp_output_510_0_g251897;
					half3 Weights_1500_g251897 = (Out_MaskH456_g251897).xyz;
					half3 Weights_2500_g251897 = temp_output_480_0_g251897;
					half3 Weights_3500_g251897 = (Out_MaskJ456_g251897).xyz;
					half3 Triplanar500_g251897 = Triplanar522_g251897;
					half3 NormalWS500_g251897 = NormalWS512_g251897;
					half3 Normal500_g251897 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251897 = SampleStochastic3D( Texture500_g251897 , Sampler500_g251897 , ZY500_g251897 , ZY_1500_g251897 , ZY_2500_g251897 , ZY_3500_g251897 , XZ500_g251897 , XZ_1500_g251897 , XZ_2500_g251897 , XZ_3500_g251897 , XY500_g251897 , XY_1500_g251897 , XY_2500_g251897 , XY_3500_g251897 , Bias500_g251897 , Weights_1500_g251897 , Weights_2500_g251897 , Weights_3500_g251897 , Triplanar500_g251897 , NormalWS500_g251897 , Normal500_g251897 );
					float4 temp_output_405_203_g251889 = localSampleStochastic3D500_g251897;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251889 = temp_output_405_277_g251889;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251889 = temp_output_405_278_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251889 = temp_output_405_0_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251889 = temp_output_405_201_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251889 = temp_output_405_202_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251889 = temp_output_405_203_g251889;
					#else
					float4 staticSwitch198_g251889 = temp_output_405_277_g251889;
					#endif
					half4 Local_ShaderSample199_g251889 = staticSwitch198_g251889;
					float2 appendResult428_g251889 = (float2((Local_AlbedoSample185_g251889).w , (Local_ShaderSample199_g251889).z));
					float2 temp_output_85_0_g251909 = appendResult428_g251889;
					float4 ChannelB91_g251909 = float4( temp_output_85_0_g251909, 0.0 , 0.0 );
					float localSwitchChannel691_g251909 = SwitchChannel6( Option91_g251909 , ChannelA91_g251909 , ChannelB91_g251909 );
					float clampResult17_g251907 = clamp( localSwitchChannel691_g251909 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251908 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251908 = ( clampResult17_g251907 - temp_output_7_0_g251908 );
					half Local_MultiMask78_g251889 = saturate( ( temp_output_9_0_g251908 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251889 = lerp( 1.0 , Local_MultiMask78_g251889 , _MainColorMode);
					float4 lerpResult62_g251889 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251889);
					half3 Local_ColorRGB93_g251889 = (lerpResult62_g251889).rgb;
					half3 Local_Albedo139_g251889 = ( Local_AlbedoRGB107_g251889 * Local_ColorRGB93_g251889 );
					float3 temp_output_4_0_g251891 = Local_Albedo139_g251889;
					float3 In_Albedo3_g251891 = temp_output_4_0_g251891;
					float3 temp_output_44_0_g251891 = Local_Albedo139_g251889;
					float3 In_AlbedoBase3_g251891 = temp_output_44_0_g251891;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251918) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251895 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251918 = staticSwitch37_g251895;
					float localBreakTextureData456_g251918 = ( 0.0 );
					TVEMasksData Data456_g251918 =(TVEMasksData)Data431_g251911;
					float4 Out_MaskA456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251918 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251918 , Out_MaskA456_g251918 , Out_MaskB456_g251918 , Out_MaskC456_g251918 , Out_MaskD456_g251918 , Out_MaskE456_g251918 , Out_MaskF456_g251918 , Out_MaskG456_g251918 , Out_MaskH456_g251918 , Out_MaskI456_g251918 , Out_MaskJ456_g251918 , Out_MaskK456_g251918 , Out_MaskL456_g251918 , Out_MaskM456_g251918 , Out_MaskN456_g251918 );
					half2 UV276_g251918 = (Out_MaskA456_g251918).xy;
					float temp_output_504_0_g251918 = 0.0;
					half Bias276_g251918 = temp_output_504_0_g251918;
					half2 Normal276_g251918 = float2( 0,0 );
					half4 localSampleCoord276_g251918 = SampleCoord( Texture276_g251918 , Sampler276_g251918 , UV276_g251918 , Bias276_g251918 , Normal276_g251918 );
					float2 temp_output_406_394_g251889 = Normal276_g251918;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251918) = _MainNormalTex;
					SamplerState Sampler502_g251918 = staticSwitch37_g251895;
					half2 UV502_g251918 = (Out_MaskA456_g251918).zw;
					half Bias502_g251918 = temp_output_504_0_g251918;
					half2 Normal502_g251918 = float2( 0,0 );
					half4 localSampleCoord502_g251918 = SampleCoord( Texture502_g251918 , Sampler502_g251918 , UV502_g251918 , Bias502_g251918 , Normal502_g251918 );
					float2 temp_output_406_397_g251889 = Normal502_g251918;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251918) = _MainNormalTex;
					SamplerState Sampler496_g251918 = staticSwitch37_g251895;
					float2 temp_output_463_0_g251918 = (Out_MaskB456_g251918).zw;
					half2 XZ496_g251918 = temp_output_463_0_g251918;
					half Bias496_g251918 = temp_output_504_0_g251918;
					half3 NormalWS512_g251918 = (Out_MaskK456_g251918).xyz;
					half3 NormalWS496_g251918 = NormalWS512_g251918;
					half3 Normal496_g251918 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251918 = SamplePlanar2D( Texture496_g251918 , Sampler496_g251918 , XZ496_g251918 , Bias496_g251918 , NormalWS496_g251918 , Normal496_g251918 );
					float3 temp_output_35_0_g251921 = Normal496_g251918;
					half3 TangentWS519_g251918 = (Out_MaskL456_g251918).xyz;
					float dotResult84_g251921 = dot( temp_output_35_0_g251921 , TangentWS519_g251918 );
					half3 BitangentWS521_g251918 = (Out_MaskM456_g251918).xyz;
					float dotResult85_g251921 = dot( temp_output_35_0_g251921 , BitangentWS521_g251918 );
					float2 appendResult87_g251921 = (float2(dotResult84_g251921 , dotResult85_g251921));
					float2 temp_output_406_375_g251889 = appendResult87_g251921;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251918) = _MainNormalTex;
					SamplerState Sampler490_g251918 = staticSwitch37_g251895;
					float2 temp_output_462_0_g251918 = (Out_MaskB456_g251918).xy;
					half2 ZY490_g251918 = temp_output_462_0_g251918;
					half2 XZ490_g251918 = temp_output_463_0_g251918;
					float2 temp_output_464_0_g251918 = (Out_MaskC456_g251918).xy;
					half2 XY490_g251918 = temp_output_464_0_g251918;
					half Bias490_g251918 = temp_output_504_0_g251918;
					half3 Triplanar522_g251918 = (Out_MaskN456_g251918).xyz;
					half3 Triplanar490_g251918 = Triplanar522_g251918;
					half3 NormalWS490_g251918 = NormalWS512_g251918;
					half3 Normal490_g251918 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251918 = SamplePlanar3D( Texture490_g251918 , Sampler490_g251918 , ZY490_g251918 , XZ490_g251918 , XY490_g251918 , Bias490_g251918 , Triplanar490_g251918 , NormalWS490_g251918 , Normal490_g251918 );
					float3 temp_output_35_0_g251922 = Normal490_g251918;
					float dotResult84_g251922 = dot( temp_output_35_0_g251922 , TangentWS519_g251918 );
					float dotResult85_g251922 = dot( temp_output_35_0_g251922 , BitangentWS521_g251918 );
					float2 appendResult87_g251922 = (float2(dotResult84_g251922 , dotResult85_g251922));
					float2 temp_output_406_353_g251889 = appendResult87_g251922;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251918) = _MainNormalTex;
					SamplerState Sampler498_g251918 = staticSwitch37_g251895;
					half2 XZ498_g251918 = temp_output_463_0_g251918;
					float2 temp_output_473_0_g251918 = (Out_MaskE456_g251918).xy;
					half2 XZ_1498_g251918 = temp_output_473_0_g251918;
					float2 temp_output_474_0_g251918 = (Out_MaskE456_g251918).zw;
					half2 XZ_2498_g251918 = temp_output_474_0_g251918;
					float2 temp_output_475_0_g251918 = (Out_MaskF456_g251918).xy;
					half2 XZ_3498_g251918 = temp_output_475_0_g251918;
					float temp_output_510_0_g251918 = exp2( temp_output_504_0_g251918 );
					half Bias498_g251918 = temp_output_510_0_g251918;
					float3 temp_output_480_0_g251918 = (Out_MaskI456_g251918).xyz;
					half3 Weights_2498_g251918 = temp_output_480_0_g251918;
					half3 NormalWS498_g251918 = NormalWS512_g251918;
					half3 Normal498_g251918 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251918 = SampleStochastic2D( Texture498_g251918 , Sampler498_g251918 , XZ498_g251918 , XZ_1498_g251918 , XZ_2498_g251918 , XZ_3498_g251918 , Bias498_g251918 , Weights_2498_g251918 , NormalWS498_g251918 , Normal498_g251918 );
					float3 temp_output_35_0_g251923 = Normal498_g251918;
					float dotResult84_g251923 = dot( temp_output_35_0_g251923 , TangentWS519_g251918 );
					float dotResult85_g251923 = dot( temp_output_35_0_g251923 , BitangentWS521_g251918 );
					float2 appendResult87_g251923 = (float2(dotResult84_g251923 , dotResult85_g251923));
					float2 temp_output_406_391_g251889 = appendResult87_g251923;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251918) = _MainNormalTex;
					SamplerState Sampler500_g251918 = staticSwitch37_g251895;
					half2 ZY500_g251918 = temp_output_462_0_g251918;
					half2 ZY_1500_g251918 = (Out_MaskC456_g251918).zw;
					half2 ZY_2500_g251918 = (Out_MaskD456_g251918).xy;
					half2 ZY_3500_g251918 = (Out_MaskD456_g251918).zw;
					half2 XZ500_g251918 = temp_output_463_0_g251918;
					half2 XZ_1500_g251918 = temp_output_473_0_g251918;
					half2 XZ_2500_g251918 = temp_output_474_0_g251918;
					half2 XZ_3500_g251918 = temp_output_475_0_g251918;
					half2 XY500_g251918 = temp_output_464_0_g251918;
					half2 XY_1500_g251918 = (Out_MaskF456_g251918).zw;
					half2 XY_2500_g251918 = (Out_MaskG456_g251918).xy;
					half2 XY_3500_g251918 = (Out_MaskG456_g251918).zw;
					half Bias500_g251918 = temp_output_510_0_g251918;
					half3 Weights_1500_g251918 = (Out_MaskH456_g251918).xyz;
					half3 Weights_2500_g251918 = temp_output_480_0_g251918;
					half3 Weights_3500_g251918 = (Out_MaskJ456_g251918).xyz;
					half3 Triplanar500_g251918 = Triplanar522_g251918;
					half3 NormalWS500_g251918 = NormalWS512_g251918;
					half3 Normal500_g251918 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251918 = SampleStochastic3D( Texture500_g251918 , Sampler500_g251918 , ZY500_g251918 , ZY_1500_g251918 , ZY_2500_g251918 , ZY_3500_g251918 , XZ500_g251918 , XZ_1500_g251918 , XZ_2500_g251918 , XZ_3500_g251918 , XY500_g251918 , XY_1500_g251918 , XY_2500_g251918 , XY_3500_g251918 , Bias500_g251918 , Weights_1500_g251918 , Weights_2500_g251918 , Weights_3500_g251918 , Triplanar500_g251918 , NormalWS500_g251918 , Normal500_g251918 );
					float3 temp_output_35_0_g251919 = Normal500_g251918;
					float dotResult84_g251919 = dot( temp_output_35_0_g251919 , TangentWS519_g251918 );
					float dotResult85_g251919 = dot( temp_output_35_0_g251919 , BitangentWS521_g251918 );
					float2 appendResult87_g251919 = (float2(dotResult84_g251919 , dotResult85_g251919));
					float2 temp_output_406_390_g251889 = appendResult87_g251919;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251889 = temp_output_406_394_g251889;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251889 = temp_output_406_397_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251889 = temp_output_406_375_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251889 = temp_output_406_353_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251889 = temp_output_406_391_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251889 = temp_output_406_390_g251889;
					#else
					float2 staticSwitch193_g251889 = temp_output_406_394_g251889;
					#endif
					half2 Local_NormaSample191_g251889 = staticSwitch193_g251889;
					half2 Local_NormalTS108_g251889 = ( Local_NormaSample191_g251889 * _MainNormalValue );
					float2 In_NormalTS3_g251891 = Local_NormalTS108_g251889;
					float2 break80_g251910 = Local_NormalTS108_g251889;
					float3 temp_output_77_0_g251910 = Model_TangentWS366_g251889;
					float3 temp_output_78_0_g251910 = Model_BitangentWS367_g251889;
					float3 temp_output_76_0_g251910 = Model_NormalWS226_g251889;
					half3 Local_NormalWS250_g251889 = ( ( break80_g251910.x * temp_output_77_0_g251910 ) + ( break80_g251910.y * temp_output_78_0_g251910 ) + temp_output_76_0_g251910 );
					float3 In_NormalWS3_g251891 = Local_NormalWS250_g251889;
					float temp_output_209_0_g251889 = (Local_ShaderSample199_g251889).y;
					float temp_output_7_0_g251903 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251903 = ( temp_output_209_0_g251889 - temp_output_7_0_g251903 );
					float lerpResult23_g251889 = lerp( 1.0 , saturate( ( temp_output_9_0_g251903 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251889 = lerpResult23_g251889;
					float temp_output_213_0_g251889 = (Local_ShaderSample199_g251889).w;
					float temp_output_7_0_g251906 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251906 = ( temp_output_213_0_g251889 - temp_output_7_0_g251906 );
					half Local_Smoothness317_g251889 = ( saturate( ( temp_output_9_0_g251906 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251889 = (float4(( (Local_ShaderSample199_g251889).x * _MainMetallicValue ) , Local_Occlusion313_g251889 , (Local_ShaderSample199_g251889).z , Local_Smoothness317_g251889));
					half4 Local_Masks109_g251889 = appendResult73_g251889;
					float4 In_Shader3_g251891 = Local_Masks109_g251889;
					float4 In_Feature3_g251891 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251891 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251891 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251924 = Local_Albedo139_g251889;
					float dotResult20_g251924 = dot( temp_output_3_0_g251924 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251889 = dotResult20_g251924;
					float temp_output_12_0_g251891 = Local_Grayscale110_g251889;
					float In_Grayscale3_g251891 = temp_output_12_0_g251891;
					float temp_output_3_0_g251925 = Local_Grayscale110_g251889;
					float clampResult27_g251925 = clamp( saturate( ( temp_output_3_0_g251925 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251889 = clampResult27_g251925;
					float temp_output_16_0_g251891 = Local_Luminosity145_g251889;
					float In_Luminosity3_g251891 = temp_output_16_0_g251891;
					float In_MultiMask3_g251891 = Local_MultiMask78_g251889;
					float temp_output_187_0_g251889 = (Local_AlbedoSample185_g251889).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251889 = ( temp_output_187_0_g251889 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251889 = temp_output_187_0_g251889;
					#endif
					half Local_AlphaClip111_g251889 = staticSwitch236_g251889;
					float In_AlphaClip3_g251891 = Local_AlphaClip111_g251889;
					half Local_AlphaFade246_g251889 = (lerpResult62_g251889).a;
					float In_AlphaFade3_g251891 = Local_AlphaFade246_g251889;
					float3 temp_cast_31 = (1.0).xxx;
					float3 In_Translucency3_g251891 = temp_cast_31;
					float In_Transmission3_g251891 = 1.0;
					float In_Thickness3_g251891 = 0.0;
					float In_Diffusion3_g251891 = 0.0;
					float In_Depth3_g251891 = 0.0;
					BuildVisualData( Data3_g251891 , In_Dummy3_g251891 , In_Albedo3_g251891 , In_AlbedoBase3_g251891 , In_NormalTS3_g251891 , In_NormalWS3_g251891 , In_Shader3_g251891 , In_Feature3_g251891 , In_Season3_g251891 , In_Emissive3_g251891 , In_Grayscale3_g251891 , In_Luminosity3_g251891 , In_MultiMask3_g251891 , In_AlphaClip3_g251891 , In_AlphaFade3_g251891 , In_Translucency3_g251891 , In_Transmission3_g251891 , In_Thickness3_g251891 , In_Diffusion3_g251891 , In_Depth3_g251891 );
					TVEVisualData Data4_g251949 =(TVEVisualData)Data3_g251891;
					float Out_Dummy4_g251949 = 0.0;
					float3 Out_Albedo4_g251949 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251949 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251949 = float2( 0,0 );
					float3 Out_NormalWS4_g251949 = float3( 0,0,0 );
					float4 Out_Shader4_g251949 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251949 = float4( 0,0,0,0 );
					float4 Out_Season4_g251949 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251949 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251949 = 0.0;
					float Out_Grayscale4_g251949 = 0.0;
					float Out_Luminosity4_g251949 = 0.0;
					float Out_AlphaClip4_g251949 = 0.0;
					float Out_AlphaFade4_g251949 = 0.0;
					float3 Out_Translucency4_g251949 = float3( 0,0,0 );
					float Out_Transmission4_g251949 = 0.0;
					float Out_Thickness4_g251949 = 0.0;
					float Out_Diffusion4_g251949 = 0.0;
					float Out_Depth4_g251949 = 0.0;
					BreakVisualData( Data4_g251949 , Out_Dummy4_g251949 , Out_Albedo4_g251949 , Out_AlbedoBase4_g251949 , Out_NormalTS4_g251949 , Out_NormalWS4_g251949 , Out_Shader4_g251949 , Out_Feature4_g251949 , Out_Season4_g251949 , Out_Emissive4_g251949 , Out_MultiMask4_g251949 , Out_Grayscale4_g251949 , Out_Luminosity4_g251949 , Out_AlphaClip4_g251949 , Out_AlphaFade4_g251949 , Out_Translucency4_g251949 , Out_Transmission4_g251949 , Out_Thickness4_g251949 , Out_Diffusion4_g251949 , Out_Depth4_g251949 );
					half4 Visual_Shader531_g251928 = Out_Shader4_g251949;
					float temp_output_1079_0_g251928 = (Visual_Shader531_g251928).z;
					float temp_output_7_0_g251983 = _SecondBaseRemap.x;
					float temp_output_9_0_g251983 = ( temp_output_1079_0_g251928 - temp_output_7_0_g251983 );
					float lerpResult1081_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251983 * _SecondBaseRemap.z ) ) , _SecondBaseValue);
					half Blend_BaseMask1077_g251928 = lerpResult1081_g251928;
					half Visual_Luminosity1041_g251928 = Out_Luminosity4_g251949;
					float temp_output_7_0_g251985 = _SecondLumaRemap.x;
					float temp_output_9_0_g251985 = ( Visual_Luminosity1041_g251928 - temp_output_7_0_g251985 );
					float lerpResult1036_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251985 * _SecondLumaRemap.z ) ) , _SecondLumaValue);
					half Blend_LumaMask1033_g251928 = lerpResult1036_g251928;
					half3 Visual_NormalWS951_g251928 = Out_NormalWS4_g251949;
					float temp_output_847_0_g251928 = saturate( (Visual_NormalWS951_g251928).y );
					float temp_output_7_0_g251984 = _SecondProjRemap.x;
					float temp_output_9_0_g251984 = ( temp_output_847_0_g251928 - temp_output_7_0_g251984 );
					float lerpResult996_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251984 * _SecondProjRemap.z ) ) , _SecondProjValue);
					half Blend_ProjMask434_g251928 = lerpResult996_g251928;
					float temp_output_17_0_g251994 = _SecondMeshMode;
					float Option70_g251994 = temp_output_17_0_g251994;
					half4 Model_VertexData964_g251928 = Out_VertexData15_g251931;
					float4 temp_output_3_0_g251994 = Model_VertexData964_g251928;
					float4 Channel70_g251994 = temp_output_3_0_g251994;
					float localSwitchChannel470_g251994 = SwitchChannel4( Option70_g251994 , Channel70_g251994 );
					float temp_output_1227_0_g251928 = localSwitchChannel470_g251994;
					float temp_output_7_0_g251982 = _SecondMeshRemap.x;
					float temp_output_9_0_g251982 = ( temp_output_1227_0_g251928 - temp_output_7_0_g251982 );
					float lerpResult1017_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251982 * _SecondMeshRemap.z ) ) , _SecondMeshValue);
					half Blend_VertMask918_g251928 = lerpResult1017_g251928;
					float temp_output_64_0_g252004 = ( Blend_TexMask429_g251928 * Blend_BaseMask1077_g251928 * Blend_LumaMask1033_g251928 * Blend_ProjMask434_g251928 * Blend_VertMask918_g251928 );
					half Blend_GlobalMask972_g251928 = 1.0;
					float temp_output_92_0_g252004 = ( Feature_Intensity1204_g251928 * Blend_GlobalMask972_g251928 );
					half Multiply93_g252004 = ( temp_output_64_0_g252004 * temp_output_92_0_g252004 );
					half Subtract93_g252004 = saturate( ( temp_output_92_0_g252004 - ( 1.0 - temp_output_64_0_g252004 ) ) );
					half Option93_g252004 = _SecondBlendMath;
					half localSwitchBlendMask93_g252004 = SwitchBlendMask( Multiply93_g252004 , Subtract93_g252004 , Option93_g252004 );
					float temp_output_7_0_g252003 = _SecondBlendRemap.x;
					float temp_output_9_0_g252003 = ( localSwitchBlendMask93_g252004 - temp_output_7_0_g252003 );
					half Blend_Mask412_g251928 = ( saturate( ( temp_output_9_0_g252003 * _SecondBlendRemap.z ) ) * _SecondBlendIntensityValue );
					float4 appendResult1126_g251928 = (float4(Blend_Mask412_g251928 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_32 = (0.0).xxxx;
					float4 temp_cast_33 = (0.0).xxxx;
					float4 ifLocalVar18_g251947 = 0;
					if( Feature_Intensity1204_g251928 <= 0.0 )
					ifLocalVar18_g251947 = temp_cast_33;
					else
					ifLocalVar18_g251947 = appendResult1126_g251928;
					float4 In_MaskB3_g251944 = ifLocalVar18_g251947;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 In_MaskC3_g251944 = temp_cast_34;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskD3_g251944 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskE3_g251944 = temp_cast_36;
					float4 temp_cast_37 = (0.0).xxxx;
					float4 In_MaskF3_g251944 = temp_cast_37;
					float4 temp_cast_38 = (0.0).xxxx;
					float4 In_MaskG3_g251944 = temp_cast_38;
					float4 temp_cast_39 = (0.0).xxxx;
					float4 In_MaskH3_g251944 = temp_cast_39;
					float4 temp_cast_40 = (0.0).xxxx;
					float4 In_MaskI3_g251944 = temp_cast_40;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 In_MaskJ3_g251944 = temp_cast_41;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskK3_g251944 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskL3_g251944 = temp_cast_43;
					{
					Data3_g251944.MaskA = In_MaskA3_g251944;
					Data3_g251944.MaskB = In_MaskB3_g251944;
					Data3_g251944.MaskC = In_MaskC3_g251944;
					Data3_g251944.MaskD = In_MaskD3_g251944;
					Data3_g251944.MaskE = In_MaskE3_g251944;
					Data3_g251944.MaskF = In_MaskF3_g251944;
					Data3_g251944.MaskG = In_MaskG3_g251944;
					Data3_g251944.MaskH = In_MaskH3_g251944;
					Data3_g251944.MaskI = In_MaskI3_g251944;
					Data3_g251944.MaskJ= In_MaskJ3_g251944;
					Data3_g251944.MaskK= In_MaskK3_g251944;
					Data3_g251944.MaskL = In_MaskL3_g251944;
					}
					TVEMasksData DataA25_g252082 = Data3_g251944;
					float localBuildMasksData3_g252021 = ( 0.0 );
					TVEMasksData Data3_g252021 = (TVEMasksData)0;
					half Feature_Intensity1204_g252005 = _SecondIntensityValue;
					float ifLocalVar18_g252022 = 0;
					if( Feature_Intensity1204_g252005 <= 0.0 )
					ifLocalVar18_g252022 = 0.0;
					else
					ifLocalVar18_g252022 = 1.0;
					half Feature_Element1203_g252005 = _SecondCoatMode;
					float ifLocalVar18_g252023 = 0;
					if( Feature_Element1203_g252005 <= 0.0 )
					ifLocalVar18_g252023 = 0.0;
					else
					ifLocalVar18_g252023 = 1.0;
					float4 appendResult1090_g252005 = (float4(ifLocalVar18_g252022 , 0.0 , 0.0 , ifLocalVar18_g252023));
					float4 In_MaskA3_g252021 = appendResult1090_g252005;
					float temp_output_17_0_g252058 = _SecondMaskMode;
					float Option70_g252058 = temp_output_17_0_g252058;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252039) = _SecondMaskTex;
					SamplerState Sampler276_g252039 = sampler_Linear_Repeat;
					float localBreakTextureData456_g252039 = ( 0.0 );
					float localBuildTextureData431_g252053 = ( 0.0 );
					TVEMasksData Data431_g252053 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252053 = ( 0.0 );
					float4 temp_output_6_0_g252010 = _second_mask_coord_value;
					float4 temp_output_7_0_g252010 = ( _SecondMaskSampleMode + _SecondMaskCoordMode + _SecondMaskCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252010 = ( temp_output_6_0_g252010 + temp_output_7_0_g252010 );
					#else
					float4 staticSwitch14_g252010 = temp_output_6_0_g252010;
					#endif
					half4 Local_MaskCoordValue813_g252005 = staticSwitch14_g252010;
					float4 Coords444_g252053 = Local_MaskCoordValue813_g252005;
					TVEModelData Data15_g252008 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g252008 = 0.0;
					float3 Out_PositionWS15_g252008 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252008 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252008 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252008 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252008 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252008 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252008 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252008 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252008 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252008 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252008 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252008 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252008 , Out_Dummy15_g252008 , Out_PositionWS15_g252008 , Out_PositionWO15_g252008 , Out_PivotWS15_g252008 , Out_PivotWO15_g252008 , Out_NormalWS15_g252008 , Out_TangentWS15_g252008 , Out_BitangentWS15_g252008 , Out_TriplanarWeights15_g252008 , Out_ViewDirWS15_g252008 , Out_CoordsData15_g252008 , Out_VertexData15_g252008 , Out_Interpolator15_g252008 );
					float4 Model_CoordsData1099_g252005 = Out_CoordsData15_g252008;
					float4 MeshCoords444_g252053 = Model_CoordsData1099_g252005;
					float2 UV0444_g252053 = float2( 0,0 );
					float2 UV3444_g252053 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252053 , MeshCoords444_g252053 , UV0444_g252053 , UV3444_g252053 );
					float4 appendResult430_g252053 = (float4(UV0444_g252053 , UV3444_g252053));
					float4 In_MaskA431_g252053 = appendResult430_g252053;
					float localComputeWorldCoords315_g252053 = ( 0.0 );
					float4 Coords315_g252053 = Local_MaskCoordValue813_g252005;
					float3 Model_PositionWO636_g252005 = Out_PositionWO15_g252008;
					float3 PositionWS315_g252053 = Model_PositionWO636_g252005;
					float2 ZY315_g252053 = float2( 0,0 );
					float2 XZ315_g252053 = float2( 0,0 );
					float2 XY315_g252053 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252053 , PositionWS315_g252053 , ZY315_g252053 , XZ315_g252053 , XY315_g252053 );
					float2 ZY402_g252053 = ZY315_g252053;
					float2 XZ403_g252053 = XZ315_g252053;
					float4 appendResult432_g252053 = (float4(ZY402_g252053 , XZ403_g252053));
					float4 In_MaskB431_g252053 = appendResult432_g252053;
					float2 XY404_g252053 = XY315_g252053;
					float localComputeStochasticCoords409_g252053 = ( 0.0 );
					float2 UV409_g252053 = ZY402_g252053;
					float2 UV1409_g252053 = float2( 0,0 );
					float2 UV2409_g252053 = float2( 0,0 );
					float2 UV3409_g252053 = float2( 0,0 );
					float3 Weights409_g252053 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252053 , UV1409_g252053 , UV2409_g252053 , UV3409_g252053 , Weights409_g252053 );
					float4 appendResult433_g252053 = (float4(XY404_g252053 , UV1409_g252053));
					float4 In_MaskC431_g252053 = appendResult433_g252053;
					float4 appendResult434_g252053 = (float4(UV2409_g252053 , UV3409_g252053));
					float4 In_MaskD431_g252053 = appendResult434_g252053;
					float localComputeStochasticCoords422_g252053 = ( 0.0 );
					float2 UV422_g252053 = XZ403_g252053;
					float2 UV1422_g252053 = float2( 0,0 );
					float2 UV2422_g252053 = float2( 0,0 );
					float2 UV3422_g252053 = float2( 0,0 );
					float3 Weights422_g252053 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252053 , UV1422_g252053 , UV2422_g252053 , UV3422_g252053 , Weights422_g252053 );
					float4 appendResult435_g252053 = (float4(UV1422_g252053 , UV2422_g252053));
					float4 In_MaskE431_g252053 = appendResult435_g252053;
					float localComputeStochasticCoords423_g252053 = ( 0.0 );
					float2 UV423_g252053 = XY404_g252053;
					float2 UV1423_g252053 = float2( 0,0 );
					float2 UV2423_g252053 = float2( 0,0 );
					float2 UV3423_g252053 = float2( 0,0 );
					float3 Weights423_g252053 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252053 , UV1423_g252053 , UV2423_g252053 , UV3423_g252053 , Weights423_g252053 );
					float4 appendResult436_g252053 = (float4(UV3422_g252053 , UV1423_g252053));
					float4 In_MaskF431_g252053 = appendResult436_g252053;
					float4 appendResult437_g252053 = (float4(UV2423_g252053 , UV3423_g252053));
					float4 In_MaskG431_g252053 = appendResult437_g252053;
					float4 In_MaskH431_g252053 = float4( Weights409_g252053 , 0.0 );
					float4 In_MaskI431_g252053 = float4( Weights422_g252053 , 0.0 );
					float4 In_MaskJ431_g252053 = float4( Weights423_g252053 , 0.0 );
					half3 Model_NormalWS869_g252005 = Out_NormalWS15_g252008;
					float3 temp_output_449_0_g252053 = Model_NormalWS869_g252005;
					float4 In_MaskK431_g252053 = float4( temp_output_449_0_g252053 , 0.0 );
					half3 Model_TangentWS1215_g252005 = Out_TangentWS15_g252008;
					float3 temp_output_450_0_g252053 = Model_TangentWS1215_g252005;
					float4 In_MaskL431_g252053 = float4( temp_output_450_0_g252053 , 0.0 );
					half3 Model_BitangentWS1216_g252005 = Out_BitangentWS15_g252008;
					float3 temp_output_451_0_g252053 = Model_BitangentWS1216_g252005;
					float4 In_MaskM431_g252053 = float4( temp_output_451_0_g252053 , 0.0 );
					half3 Model_TriplanarWeights1217_g252005 = Out_TriplanarWeights15_g252008;
					float3 temp_output_445_0_g252053 = Model_TriplanarWeights1217_g252005;
					float4 In_MaskN431_g252053 = float4( temp_output_445_0_g252053 , 0.0 );
					BuildTextureData( Data431_g252053 , In_MaskA431_g252053 , In_MaskB431_g252053 , In_MaskC431_g252053 , In_MaskD431_g252053 , In_MaskE431_g252053 , In_MaskF431_g252053 , In_MaskG431_g252053 , In_MaskH431_g252053 , In_MaskI431_g252053 , In_MaskJ431_g252053 , In_MaskK431_g252053 , In_MaskL431_g252053 , In_MaskM431_g252053 , In_MaskN431_g252053 );
					TVEMasksData Data456_g252039 =(TVEMasksData)Data431_g252053;
					float4 Out_MaskA456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252039 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252039 , Out_MaskA456_g252039 , Out_MaskB456_g252039 , Out_MaskC456_g252039 , Out_MaskD456_g252039 , Out_MaskE456_g252039 , Out_MaskF456_g252039 , Out_MaskG456_g252039 , Out_MaskH456_g252039 , Out_MaskI456_g252039 , Out_MaskJ456_g252039 , Out_MaskK456_g252039 , Out_MaskL456_g252039 , Out_MaskM456_g252039 , Out_MaskN456_g252039 );
					half2 UV276_g252039 = (Out_MaskA456_g252039).xy;
					float temp_output_504_0_g252039 = 0.0;
					half Bias276_g252039 = temp_output_504_0_g252039;
					half2 Normal276_g252039 = float2( 0,0 );
					half4 localSampleCoord276_g252039 = SampleCoord( Texture276_g252039 , Sampler276_g252039 , UV276_g252039 , Bias276_g252039 , Normal276_g252039 );
					float4 temp_output_868_277_g252005 = localSampleCoord276_g252039;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252039) = _SecondMaskTex;
					SamplerState Sampler502_g252039 = sampler_Linear_Repeat;
					half2 UV502_g252039 = (Out_MaskA456_g252039).zw;
					half Bias502_g252039 = temp_output_504_0_g252039;
					half2 Normal502_g252039 = float2( 0,0 );
					half4 localSampleCoord502_g252039 = SampleCoord( Texture502_g252039 , Sampler502_g252039 , UV502_g252039 , Bias502_g252039 , Normal502_g252039 );
					float4 temp_output_868_278_g252005 = localSampleCoord502_g252039;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252039) = _SecondMaskTex;
					SamplerState Sampler496_g252039 = sampler_Linear_Repeat;
					float2 temp_output_463_0_g252039 = (Out_MaskB456_g252039).zw;
					half2 XZ496_g252039 = temp_output_463_0_g252039;
					half Bias496_g252039 = temp_output_504_0_g252039;
					half3 NormalWS512_g252039 = (Out_MaskK456_g252039).xyz;
					half3 NormalWS496_g252039 = NormalWS512_g252039;
					half3 Normal496_g252039 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252039 = SamplePlanar2D( Texture496_g252039 , Sampler496_g252039 , XZ496_g252039 , Bias496_g252039 , NormalWS496_g252039 , Normal496_g252039 );
					float4 temp_output_868_0_g252005 = localSamplePlanar2D496_g252039;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252039) = _SecondMaskTex;
					SamplerState Sampler490_g252039 = sampler_Linear_Repeat;
					float2 temp_output_462_0_g252039 = (Out_MaskB456_g252039).xy;
					half2 ZY490_g252039 = temp_output_462_0_g252039;
					half2 XZ490_g252039 = temp_output_463_0_g252039;
					float2 temp_output_464_0_g252039 = (Out_MaskC456_g252039).xy;
					half2 XY490_g252039 = temp_output_464_0_g252039;
					half Bias490_g252039 = temp_output_504_0_g252039;
					half3 Triplanar522_g252039 = (Out_MaskN456_g252039).xyz;
					half3 Triplanar490_g252039 = Triplanar522_g252039;
					half3 NormalWS490_g252039 = NormalWS512_g252039;
					half3 Normal490_g252039 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252039 = SamplePlanar3D( Texture490_g252039 , Sampler490_g252039 , ZY490_g252039 , XZ490_g252039 , XY490_g252039 , Bias490_g252039 , Triplanar490_g252039 , NormalWS490_g252039 , Normal490_g252039 );
					float4 temp_output_868_201_g252005 = localSamplePlanar3D490_g252039;
					#if defined( TVE_SECOND_MASK_SAMPLE_MAIN_UV )
					float4 staticSwitch817_g252005 = temp_output_868_277_g252005;
					#elif defined( TVE_SECOND_MASK_SAMPLE_EXTRA_UV )
					float4 staticSwitch817_g252005 = temp_output_868_278_g252005;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_2D )
					float4 staticSwitch817_g252005 = temp_output_868_0_g252005;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_3D )
					float4 staticSwitch817_g252005 = temp_output_868_201_g252005;
					#else
					float4 staticSwitch817_g252005 = temp_output_868_277_g252005;
					#endif
					half4 Local_MaskSample861_g252005 = staticSwitch817_g252005;
					float4 temp_output_3_0_g252058 = Local_MaskSample861_g252005;
					float4 Channel70_g252058 = temp_output_3_0_g252058;
					float localSwitchChannel470_g252058 = SwitchChannel4( Option70_g252058 , Channel70_g252058 );
					float temp_output_1226_0_g252005 = localSwitchChannel470_g252058;
					float temp_output_7_0_g252063 = _SecondMaskRemap.x;
					float temp_output_9_0_g252063 = ( temp_output_1226_0_g252005 - temp_output_7_0_g252063 );
					float lerpResult1015_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252063 * _SecondMaskRemap.z ) ) , _SecondMaskValue);
					#ifdef TVE_SECOND_MASK
					float staticSwitch1088_g252005 = lerpResult1015_g252005;
					#else
					float staticSwitch1088_g252005 = 1.0;
					#endif
					half Blend_TexMask429_g252005 = staticSwitch1088_g252005;
					float localBreakVisualData4_g252026 = ( 0.0 );
					TVEVisualData Data4_g252026 =(TVEVisualData)Data3_g251891;
					float Out_Dummy4_g252026 = 0.0;
					float3 Out_Albedo4_g252026 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252026 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252026 = float2( 0,0 );
					float3 Out_NormalWS4_g252026 = float3( 0,0,0 );
					float4 Out_Shader4_g252026 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252026 = float4( 0,0,0,0 );
					float4 Out_Season4_g252026 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252026 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252026 = 0.0;
					float Out_Grayscale4_g252026 = 0.0;
					float Out_Luminosity4_g252026 = 0.0;
					float Out_AlphaClip4_g252026 = 0.0;
					float Out_AlphaFade4_g252026 = 0.0;
					float3 Out_Translucency4_g252026 = float3( 0,0,0 );
					float Out_Transmission4_g252026 = 0.0;
					float Out_Thickness4_g252026 = 0.0;
					float Out_Diffusion4_g252026 = 0.0;
					float Out_Depth4_g252026 = 0.0;
					BreakVisualData( Data4_g252026 , Out_Dummy4_g252026 , Out_Albedo4_g252026 , Out_AlbedoBase4_g252026 , Out_NormalTS4_g252026 , Out_NormalWS4_g252026 , Out_Shader4_g252026 , Out_Feature4_g252026 , Out_Season4_g252026 , Out_Emissive4_g252026 , Out_MultiMask4_g252026 , Out_Grayscale4_g252026 , Out_Luminosity4_g252026 , Out_AlphaClip4_g252026 , Out_AlphaFade4_g252026 , Out_Translucency4_g252026 , Out_Transmission4_g252026 , Out_Thickness4_g252026 , Out_Diffusion4_g252026 , Out_Depth4_g252026 );
					half4 Visual_Shader531_g252005 = Out_Shader4_g252026;
					float temp_output_1079_0_g252005 = (Visual_Shader531_g252005).z;
					float temp_output_7_0_g252060 = _SecondBaseRemap.x;
					float temp_output_9_0_g252060 = ( temp_output_1079_0_g252005 - temp_output_7_0_g252060 );
					float lerpResult1081_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252060 * _SecondBaseRemap.z ) ) , _SecondBaseValue);
					half Blend_BaseMask1077_g252005 = lerpResult1081_g252005;
					half Visual_Luminosity1041_g252005 = Out_Luminosity4_g252026;
					float temp_output_7_0_g252062 = _SecondLumaRemap.x;
					float temp_output_9_0_g252062 = ( Visual_Luminosity1041_g252005 - temp_output_7_0_g252062 );
					float lerpResult1036_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252062 * _SecondLumaRemap.z ) ) , _SecondLumaValue);
					half Blend_LumaMask1033_g252005 = lerpResult1036_g252005;
					half3 Visual_NormalWS951_g252005 = Out_NormalWS4_g252026;
					float temp_output_847_0_g252005 = saturate( (Visual_NormalWS951_g252005).y );
					float temp_output_7_0_g252061 = _SecondProjRemap.x;
					float temp_output_9_0_g252061 = ( temp_output_847_0_g252005 - temp_output_7_0_g252061 );
					float lerpResult996_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252061 * _SecondProjRemap.z ) ) , _SecondProjValue);
					half Blend_ProjMask434_g252005 = lerpResult996_g252005;
					float temp_output_17_0_g252071 = _SecondMeshMode;
					float Option70_g252071 = temp_output_17_0_g252071;
					half4 Model_VertexData964_g252005 = Out_VertexData15_g252008;
					float4 temp_output_3_0_g252071 = Model_VertexData964_g252005;
					float4 Channel70_g252071 = temp_output_3_0_g252071;
					float localSwitchChannel470_g252071 = SwitchChannel4( Option70_g252071 , Channel70_g252071 );
					float temp_output_1227_0_g252005 = localSwitchChannel470_g252071;
					float temp_output_7_0_g252059 = _SecondMeshRemap.x;
					float temp_output_9_0_g252059 = ( temp_output_1227_0_g252005 - temp_output_7_0_g252059 );
					float lerpResult1017_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252059 * _SecondMeshRemap.z ) ) , _SecondMeshValue);
					half Blend_VertMask918_g252005 = lerpResult1017_g252005;
					float temp_output_64_0_g252081 = ( Blend_TexMask429_g252005 * Blend_BaseMask1077_g252005 * Blend_LumaMask1033_g252005 * Blend_ProjMask434_g252005 * Blend_VertMask918_g252005 );
					float temp_output_1256_0_g252005 = (TVE_CoatParams).x;
					float localBuildGlobalData204_g235664 = ( 0.0 );
					TVEGlobalData Data204_g235664 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g235664 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g235664 = Dummy211_g235664;
					float4 temp_output_203_0_g235683 = TVE_CoatBaseCoord;
					TVEModelData Data15_g235754 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g235754 = 0.0;
					float3 Out_PositionWS15_g235754 = float3( 0,0,0 );
					float3 Out_PositionWO15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWS15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWO15_g235754 = float3( 0,0,0 );
					float3 Out_NormalWS15_g235754 = float3( 0,0,0 );
					float3 Out_TangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g235754 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g235754 = float3( 0,0,0 );
					float4 Out_CoordsData15_g235754 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g235754 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g235754 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g235754 , Out_Dummy15_g235754 , Out_PositionWS15_g235754 , Out_PositionWO15_g235754 , Out_PivotWS15_g235754 , Out_PivotWO15_g235754 , Out_NormalWS15_g235754 , Out_TangentWS15_g235754 , Out_BitangentWS15_g235754 , Out_TriplanarWeights15_g235754 , Out_ViewDirWS15_g235754 , Out_CoordsData15_g235754 , Out_VertexData15_g235754 , Out_Interpolator15_g235754 );
					float3 Model_PositionWS497_g235664 = Out_PositionWS15_g235754;
					float2 Model_PositionWS_XZ143_g235664 = (Model_PositionWS497_g235664).xz;
					float3 Model_PivotWS498_g235664 = Out_PivotWS15_g235754;
					float2 Model_PivotWS_XZ145_g235664 = (Model_PivotWS498_g235664).xz;
					float2 lerpResult300_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g235683 = lerpResult300_g235664;
					float temp_output_82_0_g235681 = _GlobalCoatLayerValue;
					float temp_output_82_0_g235683 = temp_output_82_0_g235681;
					float4 tex2DArrayNode83_g235683 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235683).zw + ( (temp_output_203_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683) );
					float4 appendResult210_g235683 = (float4(tex2DArrayNode83_g235683.rgb , tex2DArrayNode83_g235683.a));
					float4 temp_output_204_0_g235683 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g235683 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235683).zw + ( (temp_output_204_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683) );
					float4 appendResult212_g235683 = (float4(tex2DArrayNode122_g235683.rgb , tex2DArrayNode122_g235683.a));
					float4 TVE_RenderNearPositionR628_g235664 = TVE_RenderNearPositionR;
					float temp_output_507_0_g235664 = saturate( ( distance( Model_PositionWS497_g235664 , (TVE_RenderNearPositionR628_g235664).xyz ) / (TVE_RenderNearPositionR628_g235664).w ) );
					float temp_output_7_0_g235753 = 1.0;
					float temp_output_9_0_g235753 = ( temp_output_507_0_g235664 - temp_output_7_0_g235753 );
					half TVE_RenderNearFadeValue635_g235664 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g235664 = saturate( ( temp_output_9_0_g235753 / ( ( TVE_RenderNearFadeValue635_g235664 - temp_output_7_0_g235753 ) + 0.0001 ) ) );
					float4 lerpResult131_g235683 = lerp( appendResult210_g235683 , appendResult212_g235683 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235681 = lerpResult131_g235683;
					float4 lerpResult168_g235681 = lerp( TVE_CoatParams , temp_output_159_109_g235681 , TVE_CoatLayers[(int)temp_output_82_0_g235681]);
					float4 temp_output_589_109_g235664 = lerpResult168_g235681;
					half4 Coat_Texture302_g235664 = temp_output_589_109_g235664;
					float4 In_CoatTexture204_g235664 = Coat_Texture302_g235664;
					half4 Draw_Texture656_g235664 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g235664 = Draw_Texture656_g235664;
					float4 temp_output_203_0_g235708 = TVE_PaintBaseCoord;
					float2 lerpResult85_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g235708 = lerpResult85_g235664;
					float temp_output_82_0_g235705 = _GlobalPaintLayerValue;
					float temp_output_82_0_g235708 = temp_output_82_0_g235705;
					float4 tex2DArrayNode83_g235708 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235708).zw + ( (temp_output_203_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708) );
					float4 appendResult210_g235708 = (float4(tex2DArrayNode83_g235708.rgb , tex2DArrayNode83_g235708.a));
					float4 temp_output_204_0_g235708 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g235708 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235708).zw + ( (temp_output_204_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708) );
					float4 appendResult212_g235708 = (float4(tex2DArrayNode122_g235708.rgb , tex2DArrayNode122_g235708.a));
					float4 lerpResult131_g235708 = lerp( appendResult210_g235708 , appendResult212_g235708 , Global_TexBlend509_g235664);
					float4 temp_output_171_109_g235705 = lerpResult131_g235708;
					float4 lerpResult174_g235705 = lerp( TVE_PaintParams , temp_output_171_109_g235705 , TVE_PaintLayers[(int)temp_output_82_0_g235705]);
					float4 temp_output_595_109_g235664 = lerpResult174_g235705;
					half4 Paint_Texture71_g235664 = temp_output_595_109_g235664;
					float4 In_PaintTexture204_g235664 = Paint_Texture71_g235664;
					float4 temp_output_203_0_g235691 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g235691 = lerpResult104_g235664;
					float temp_output_132_0_g235689 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g235691 = temp_output_132_0_g235689;
					float4 tex2DArrayNode83_g235691 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235691).zw + ( (temp_output_203_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691) );
					float4 appendResult210_g235691 = (float4(tex2DArrayNode83_g235691.rgb , tex2DArrayNode83_g235691.a));
					float4 temp_output_204_0_g235691 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g235691 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235691).zw + ( (temp_output_204_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691) );
					float4 appendResult212_g235691 = (float4(tex2DArrayNode122_g235691.rgb , tex2DArrayNode122_g235691.a));
					float4 lerpResult131_g235691 = lerp( appendResult210_g235691 , appendResult212_g235691 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235689 = lerpResult131_g235691;
					float4 lerpResult145_g235689 = lerp( TVE_AtmoParams , temp_output_137_109_g235689 , TVE_AtmoLayers[(int)temp_output_132_0_g235689]);
					float4 temp_output_590_110_g235664 = lerpResult145_g235689;
					half4 Atmo_Texture80_g235664 = temp_output_590_110_g235664;
					float4 In_AtmoTexture204_g235664 = Atmo_Texture80_g235664;
					float4 temp_output_203_0_g235759 = TVE_EffexBaseCoord;
					float2 lerpResult414_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g235759 = lerpResult414_g235664;
					float temp_output_132_0_g235757 = _GlobalEffexLayerValue;
					float temp_output_82_0_g235759 = temp_output_132_0_g235757;
					float4 tex2DArrayNode83_g235759 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235759).zw + ( (temp_output_203_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759) );
					float4 appendResult210_g235759 = (float4(tex2DArrayNode83_g235759.rgb , tex2DArrayNode83_g235759.a));
					float4 temp_output_204_0_g235759 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g235759 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235759).zw + ( (temp_output_204_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759) );
					float4 appendResult212_g235759 = (float4(tex2DArrayNode122_g235759.rgb , tex2DArrayNode122_g235759.a));
					float4 lerpResult131_g235759 = lerp( appendResult210_g235759 , appendResult212_g235759 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235757 = lerpResult131_g235759;
					float4 lerpResult145_g235757 = lerp( TVE_EffexParams , temp_output_137_109_g235757 , TVE_EffexLayers[(int)temp_output_132_0_g235757]);
					float4 temp_output_731_110_g235664 = lerpResult145_g235757;
					half4 Effex_Texture420_g235664 = temp_output_731_110_g235664;
					float4 In_EffexTexture204_g235664 = Effex_Texture420_g235664;
					float4 temp_output_203_0_g235739 = TVE_GlowBaseCoord;
					float2 lerpResult247_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g235739 = lerpResult247_g235664;
					float temp_output_82_0_g235737 = _GlobalGlowLayerValue;
					float temp_output_82_0_g235739 = temp_output_82_0_g235737;
					float4 tex2DArrayNode83_g235739 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235739).zw + ( (temp_output_203_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739) );
					float4 appendResult210_g235739 = (float4(tex2DArrayNode83_g235739.rgb , tex2DArrayNode83_g235739.a));
					float4 temp_output_204_0_g235739 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g235739 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235739).zw + ( (temp_output_204_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739) );
					float4 appendResult212_g235739 = (float4(tex2DArrayNode122_g235739.rgb , tex2DArrayNode122_g235739.a));
					float4 lerpResult131_g235739 = lerp( appendResult210_g235739 , appendResult212_g235739 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235737 = lerpResult131_g235739;
					float4 lerpResult167_g235737 = lerp( TVE_GlowParams , temp_output_159_109_g235737 , TVE_GlowLayers[(int)temp_output_82_0_g235737]);
					float4 temp_output_593_109_g235664 = lerpResult167_g235737;
					half4 Glow_Texture248_g235664 = temp_output_593_109_g235664;
					float4 In_GlowTexture204_g235664 = Glow_Texture248_g235664;
					float4 temp_output_203_0_g235675 = TVE_FormBaseCoord;
					float2 lerpResult168_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g235675 = lerpResult168_g235664;
					float temp_output_130_0_g235673 = _GlobalFormLayerValue;
					float temp_output_82_0_g235675 = temp_output_130_0_g235673;
					float4 tex2DArrayNode83_g235675 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235675).zw + ( (temp_output_203_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675) );
					float4 appendResult210_g235675 = (float4(tex2DArrayNode83_g235675.rgb , tex2DArrayNode83_g235675.a));
					float4 temp_output_204_0_g235675 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g235675 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235675).zw + ( (temp_output_204_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675) );
					float4 appendResult212_g235675 = (float4(tex2DArrayNode122_g235675.rgb , tex2DArrayNode122_g235675.a));
					float4 lerpResult131_g235675 = lerp( appendResult210_g235675 , appendResult212_g235675 , Global_TexBlend509_g235664);
					float4 temp_output_135_109_g235673 = lerpResult131_g235675;
					float4 lerpResult143_g235673 = lerp( TVE_FormParams , temp_output_135_109_g235673 , TVE_FormLayers[(int)temp_output_130_0_g235673]);
					float4 temp_output_592_0_g235664 = lerpResult143_g235673;
					float4 Form_Texture112_g235664 = temp_output_592_0_g235664;
					float4 In_FormTexture204_g235664 = Form_Texture112_g235664;
					float4 In_LandTexture204_g235664 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g235723 = TVE_VertxBaseCoord;
					float2 lerpResult681_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g235723 = lerpResult681_g235664;
					float temp_output_136_0_g235721 = _GlobalVertxLayerValue;
					float temp_output_82_0_g235723 = temp_output_136_0_g235721;
					float4 tex2DArrayNode83_g235723 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235723).zw + ( (temp_output_203_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723) );
					float4 appendResult210_g235723 = (float4(tex2DArrayNode83_g235723.rgb , tex2DArrayNode83_g235723.a));
					float4 temp_output_204_0_g235723 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g235723 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235723).zw + ( (temp_output_204_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723) );
					float4 appendResult212_g235723 = (float4(tex2DArrayNode122_g235723.rgb , tex2DArrayNode122_g235723.a));
					float4 lerpResult131_g235723 = lerp( appendResult210_g235723 , appendResult212_g235723 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235721 = lerpResult131_g235723;
					float4 lerpResult149_g235721 = lerp( TVE_VertxParams , temp_output_141_109_g235721 , TVE_VertxLayers[(int)temp_output_136_0_g235721]);
					float4 temp_output_695_0_g235664 = lerpResult149_g235721;
					half4 Vertx_Texture693_g235664 = temp_output_695_0_g235664;
					float4 In_VertxTexture204_g235664 = Vertx_Texture693_g235664;
					float4 temp_output_203_0_g235699 = TVE_FlowBaseCoord;
					float2 lerpResult400_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g235699 = lerpResult400_g235664;
					float temp_output_136_0_g235697 = _GlobalFlowLayerValue;
					float temp_output_82_0_g235699 = temp_output_136_0_g235697;
					float4 tex2DArrayNode83_g235699 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235699).zw + ( (temp_output_203_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699) );
					float4 appendResult210_g235699 = (float4(tex2DArrayNode83_g235699.rgb , tex2DArrayNode83_g235699.a));
					float4 temp_output_204_0_g235699 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g235699 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235699).zw + ( (temp_output_204_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699) );
					float4 appendResult212_g235699 = (float4(tex2DArrayNode122_g235699.rgb , tex2DArrayNode122_g235699.a));
					float4 lerpResult131_g235699 = lerp( appendResult210_g235699 , appendResult212_g235699 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235697 = lerpResult131_g235699;
					float4 lerpResult149_g235697 = lerp( TVE_FlowParams , temp_output_141_109_g235697 , TVE_FlowLayers[(int)temp_output_136_0_g235697]);
					float4 temp_output_594_0_g235664 = lerpResult149_g235697;
					half4 Flow_Texture405_g235664 = temp_output_594_0_g235664;
					float4 In_FlowTexture204_g235664 = Flow_Texture405_g235664;
					half4 User_Texture677_g235664 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g235664 = User_Texture677_g235664;
					BuildGlobalData( Data204_g235664 , In_Dummy204_g235664 , In_CoatTexture204_g235664 , In_DrawTexture204_g235664 , In_PaintTexture204_g235664 , In_AtmoTexture204_g235664 , In_EffexTexture204_g235664 , In_GlowTexture204_g235664 , In_FormTexture204_g235664 , In_LandTexture204_g235664 , In_VertxTexture204_g235664 , In_FlowTexture204_g235664 , In_UserTexture204_g235664 );
					TVEGlobalData Data15_g252006 =(TVEGlobalData)Data204_g235664;
					float Out_Dummy15_g252006 = 0.0;
					float4 Out_CoatTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252006 = float4( 0,0,0,0 );
					BreakData( Data15_g252006 , Out_Dummy15_g252006 , Out_CoatTexture15_g252006 , Out_DrawTexture15_g252006 , Out_PaintTexture15_g252006 , Out_AtmoTexture15_g252006 , Out_EffexTexture15_g252006 , Out_GlowTexture15_g252006 , Out_FormTexture15_g252006 , Out_LandTexture15_g252006 , Out_VertxTexture15_g252006 , Out_FlowTexture15_g252006 , Out_UserTexture15_g252006 );
					half4 Global_CoatTexture1255_g252005 = Out_CoatTexture15_g252006;
					float temp_output_6_0_g252064 = (Global_CoatTexture1255_g252005).x;
					float temp_output_7_0_g252064 = _SecondCoatMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g252064 = ( temp_output_6_0_g252064 + temp_output_7_0_g252064 );
					#else
					float staticSwitch14_g252064 = temp_output_6_0_g252064;
					#endif
					float temp_output_1044_0_g252005 = staticSwitch14_g252064;
					#ifdef TVE_SECOND_COAT
					float staticSwitch971_g252005 = temp_output_1044_0_g252005;
					#else
					float staticSwitch971_g252005 = temp_output_1256_0_g252005;
					#endif
					float lerpResult1013_g252005 = lerp( 1.0 , staticSwitch971_g252005 , ( _SecondCoatValue * TVE_IsEnabled ));
					half Blend_GlobalMask972_g252005 = lerpResult1013_g252005;
					float temp_output_92_0_g252081 = ( Feature_Intensity1204_g252005 * Blend_GlobalMask972_g252005 );
					half Multiply93_g252081 = ( temp_output_64_0_g252081 * temp_output_92_0_g252081 );
					half Subtract93_g252081 = saturate( ( temp_output_92_0_g252081 - ( 1.0 - temp_output_64_0_g252081 ) ) );
					half Option93_g252081 = _SecondBlendMath;
					half localSwitchBlendMask93_g252081 = SwitchBlendMask( Multiply93_g252081 , Subtract93_g252081 , Option93_g252081 );
					float temp_output_7_0_g252080 = _SecondBlendRemap.x;
					float temp_output_9_0_g252080 = ( localSwitchBlendMask93_g252081 - temp_output_7_0_g252080 );
					half Blend_Mask412_g252005 = ( saturate( ( temp_output_9_0_g252080 * _SecondBlendRemap.z ) ) * _SecondBlendIntensityValue );
					float4 appendResult1126_g252005 = (float4(Blend_Mask412_g252005 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_59 = (0.0).xxxx;
					float4 temp_cast_60 = (0.0).xxxx;
					float4 ifLocalVar18_g252024 = 0;
					if( Feature_Intensity1204_g252005 <= 0.0 )
					ifLocalVar18_g252024 = temp_cast_60;
					else
					ifLocalVar18_g252024 = appendResult1126_g252005;
					float4 In_MaskB3_g252021 = ifLocalVar18_g252024;
					float4 temp_cast_61 = (0.0).xxxx;
					float4 In_MaskC3_g252021 = temp_cast_61;
					float4 temp_cast_62 = (0.0).xxxx;
					float4 In_MaskD3_g252021 = temp_cast_62;
					float4 temp_cast_63 = (0.0).xxxx;
					float4 In_MaskE3_g252021 = temp_cast_63;
					float4 temp_cast_64 = (0.0).xxxx;
					float4 In_MaskF3_g252021 = temp_cast_64;
					float4 temp_cast_65 = (0.0).xxxx;
					float4 In_MaskG3_g252021 = temp_cast_65;
					float4 temp_cast_66 = (0.0).xxxx;
					float4 In_MaskH3_g252021 = temp_cast_66;
					float4 temp_cast_67 = (0.0).xxxx;
					float4 In_MaskI3_g252021 = temp_cast_67;
					float4 temp_cast_68 = (0.0).xxxx;
					float4 In_MaskJ3_g252021 = temp_cast_68;
					float4 temp_cast_69 = (0.0).xxxx;
					float4 In_MaskK3_g252021 = temp_cast_69;
					float4 temp_cast_70 = (0.0).xxxx;
					float4 In_MaskL3_g252021 = temp_cast_70;
					{
					Data3_g252021.MaskA = In_MaskA3_g252021;
					Data3_g252021.MaskB = In_MaskB3_g252021;
					Data3_g252021.MaskC = In_MaskC3_g252021;
					Data3_g252021.MaskD = In_MaskD3_g252021;
					Data3_g252021.MaskE = In_MaskE3_g252021;
					Data3_g252021.MaskF = In_MaskF3_g252021;
					Data3_g252021.MaskG = In_MaskG3_g252021;
					Data3_g252021.MaskH = In_MaskH3_g252021;
					Data3_g252021.MaskI = In_MaskI3_g252021;
					Data3_g252021.MaskJ= In_MaskJ3_g252021;
					Data3_g252021.MaskK= In_MaskK3_g252021;
					Data3_g252021.MaskL = In_MaskL3_g252021;
					}
					TVEMasksData DataB25_g252082 = Data3_g252021;
					float Alpha25_g252082 = TVE_DEBUG_Global;
					{
					if (Alpha25_g252082 < 0.5 )
					{
					Data25_g252082 = DataA25_g252082;
					}
					else
					{
					Data25_g252082 = DataB25_g252082;
					}
					}
					TVEMasksData Data4_g252083 = Data25_g252082;
					float4 Out_MaskA4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g252083 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g252083 = Data4_g252083.MaskA;
					Out_MaskB4_g252083 = Data4_g252083.MaskB;
					Out_MaskC4_g252083 = Data4_g252083.MaskC;
					Out_MaskD4_g252083 = Data4_g252083.MaskD;
					Out_MaskE4_g252083 = Data4_g252083.MaskE;
					Out_MaskF4_g252083 = Data4_g252083.MaskF;
					Out_MaskG4_g252083 = Data4_g252083.MaskG;
					Out_MaskH4_g252083 = Data4_g252083.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g252083;
					float3 lerpResult2568 = lerp( color107_g252084 , color106_g252084 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g252088 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g252088 = lerpResult2568;
					float3 ifLocalVar40_g252089 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g252089 = (Out_MaskB4_g252083).xxx;
					float3 color107_g252086 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252086 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g252086 , color106_g252086 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g252090 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g252090 = lerpResult2607;
					half IsTerranShader2496 = _IsTerrainShader;
					float3 lerpResult2660 = lerp( ( ifLocalVar40_g252088 + ifLocalVar40_g252089 + ifLocalVar40_g252090 ) , float3( 0,0,0 ) , IsTerranShader2496);
					half3 Final_Debug2399 = lerpResult2660;
					float temp_output_7_0_g252099 = TVE_DEBUG_Min;
					float3 temp_cast_71 = (temp_output_7_0_g252099).xxx;
					float3 temp_output_9_0_g252099 = ( Final_Debug2399 - temp_cast_71 );
					float lerpResult76_g252092 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g252092 = lerpResult76_g252092;
					float3 lerpResult72_g252092 = lerp( (lerpResult73_g252093).rgb , saturate( ( temp_output_9_0_g252099 / ( ( TVE_DEBUG_Max - temp_output_7_0_g252099 ) + 0.0001 ) ) ) , Filter152_g252092);
					float dotResult61_g252092 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g252092 = ( 1.0 - saturate( dotResult61_g252092 ) );
					float Shading_Fresnel59_g252092 = (( 1.0 - ( temp_output_65_0_g252092 * temp_output_65_0_g252092 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g252092 = IN.ase_texcoord10;
					float depthLinearEye57_g252092 = LinearEyeDepth( ase_positionCS57_g252092.z / ase_positionCS57_g252092.w );
					float temp_output_69_0_g252092 = saturate(  (0.0 + ( depthLinearEye57_g252092 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g252092 = (( temp_output_69_0_g252092 * temp_output_69_0_g252092 )*0.5 + 0.5);
					float lerpResult84_g252092 = lerp( 1.0 , Shading_Fresnel59_g252092 , ( Shading_Distance58_g252092 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g252097 = ( 0.0 );
					TVEVisualData Data4_g252097 =(TVEVisualData)Data3_g251891;
					float Out_Dummy4_g252097 = 0.0;
					float3 Out_Albedo4_g252097 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252097 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252097 = float2( 0,0 );
					float3 Out_NormalWS4_g252097 = float3( 0,0,0 );
					float4 Out_Shader4_g252097 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252097 = float4( 0,0,0,0 );
					float4 Out_Season4_g252097 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252097 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252097 = 0.0;
					float Out_Grayscale4_g252097 = 0.0;
					float Out_Luminosity4_g252097 = 0.0;
					float Out_AlphaClip4_g252097 = 0.0;
					float Out_AlphaFade4_g252097 = 0.0;
					float3 Out_Translucency4_g252097 = float3( 0,0,0 );
					float Out_Transmission4_g252097 = 0.0;
					float Out_Thickness4_g252097 = 0.0;
					float Out_Diffusion4_g252097 = 0.0;
					float Out_Depth4_g252097 = 0.0;
					BreakVisualData( Data4_g252097 , Out_Dummy4_g252097 , Out_Albedo4_g252097 , Out_AlbedoBase4_g252097 , Out_NormalTS4_g252097 , Out_NormalWS4_g252097 , Out_Shader4_g252097 , Out_Feature4_g252097 , Out_Season4_g252097 , Out_Emissive4_g252097 , Out_MultiMask4_g252097 , Out_Grayscale4_g252097 , Out_Luminosity4_g252097 , Out_AlphaClip4_g252097 , Out_AlphaFade4_g252097 , Out_Translucency4_g252097 , Out_Transmission4_g252097 , Out_Thickness4_g252097 , Out_Diffusion4_g252097 , Out_Depth4_g252097 );
					float Alpha109_g252092 = Out_AlphaClip4_g252097;
					float lerpResult91_g252092 = lerp( 1.0 , Alpha109_g252092 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g252092 = lerp( 1.0 , lerpResult91_g252092 , Filter152_g252092);
					clip( lerpResult154_g252092 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2682_114;
					half Occlusion = 1;

					#if defined(ASE_LIGHTING_SIMPLE)
						o.Specular = Specular.x;
						o.Gloss = Smoothness;
					#else
						#if defined(_SPECULAR_SETUP)
							o.Specular = Specular;
						#else
							o.Metallic = Metallic;
						#endif
						o.Occlusion = Occlusion;
						o.Smoothness = Smoothness;
					#endif

					o.Emission = ( lerpResult72_g252092 * lerpResult84_g252092 );
					o.Alpha = 1;
					half3 BakedGI = 0;
					half3 Transmission = 1;
					half3 Translucency = 1;

					#if defined( ASE_DEPTH_WRITE_ON )
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_CHANGES_WORLD_POS )
					{
						#if defined( ASE_RECEIVE_SHADOWS )
							UNITY_LIGHT_ATTENUATION( temp, IN, PositionWS )
							LightAtten = temp;
						#else
							LightAtten = 1;
						#endif
					}
					#endif

					#if ( ASE_FRAGMENT_NORMAL == 0 )
						o.Normal = normalize( o.Normal.x * TangentWS + o.Normal.y * BitangentWS + o.Normal.z * NormalWS );
					#elif ( ASE_FRAGMENT_NORMAL == 1 )
						o.Normal = UnityObjectToWorldNormal( o.Normal );
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						// @diogo: already in world-space; do nothing
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifndef USING_DIRECTIONAL_LIGHT
						half3 lightDir = normalize( UnityWorldSpaceLightDir( PositionWS ) );
					#else
						half3 lightDir = _WorldSpaceLightPos0.xyz;
					#endif

					UnityGI gi;
					UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
					gi.indirect.diffuse = 0;
					gi.indirect.specular = 0;
					gi.light.color = _LightColor0.rgb;
					gi.light.dir = lightDir;

					UnityGIInput giInput;
					UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
					giInput.light = gi.light;
					giInput.worldPos = PositionWS;
					giInput.worldViewDir = ViewDirWS;
					giInput.atten = atten;
					#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
						giInput.lightmapUV = IN.ambientOrLightmapUV;
					#else
						giInput.lightmapUV = 0.0;
					#endif

					// #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					// 	giInput.ambient = IN.ambientOrLightmapUV.rgb;
					// #else
					// 	giInput.ambient.rgb = 0.0;
					// #endif

					#if UNITY_SHOULD_SAMPLE_SH
						#ifdef UNITY_COLORSPACE_GAMMA
							giInput.ambient.rgb = GammaToLinearSpace (IN.ambientOrLightmapUV.rgb);
						#endif
							giInput.ambient.rgb += SHEvalLinearL2 (half4(o.Normal, 1.0));
					#else
						giInput.ambient.rgb = 0.0;
					#endif

					giInput.probeHDR[0] = unity_SpecCube0_HDR;
					giInput.probeHDR[1] = unity_SpecCube1_HDR;
					#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
						giInput.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif
					#ifdef UNITY_SPECCUBE_BOX_PROJECTION
						giInput.boxMax[0] = unity_SpecCube0_BoxMax;
						giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
						giInput.boxMax[1] = unity_SpecCube1_BoxMax;
						giInput.boxMin[1] = unity_SpecCube1_BoxMin;
						giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							LightingBlinnPhong_GI(o, giInput, gi);
						#else
							LightingLambert_GI(o, giInput, gi);
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							LightingStandardSpecular_GI(o, giInput, gi);
						#else
							LightingStandard_GI(o, giInput, gi);
						#endif
					#endif

					#ifdef ASE_BAKEDGI
						gi.indirect.diffuse = BakedGI;
					#endif

					#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
						gi.indirect.diffuse = 0;
					#endif

					half4 c = 0;
					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							c += LightingBlinnPhong (o, ViewDirWS, gi);
						#else
							c += LightingLambert( o, gi );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							c += LightingStandardSpecular (o, ViewDirWS, gi);
						#else
							c += LightingStandard(o, ViewDirWS, gi);
						#endif
					#endif

					#ifdef ASE_TRANSMISSION
					{
						half shadow = _TransmissionShadow;
						#ifdef DIRECTIONAL
							half3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
						#else
							half3 lightAtten = gi.light.color;
						#endif
						half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
						c.rgb += o.Albedo * transmission;
					}
					#endif

					#ifdef ASE_TRANSLUCENCY
					{
						half shadow = _TransShadow;
						half normal = _TransNormal;
						half scattering = _TransScattering;
						half direct = _TransDirect;
						half ambient = _TransAmbient;
						half strength = _TransStrength;

						#ifdef DIRECTIONAL
							half3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
						#else
							half3 lightAtten = gi.light.color;
						#endif
						half3 lightDir = gi.light.dir + o.Normal * normal;
						half transVdotL = pow( saturate( dot( ViewDirWS, -lightDir ) ), scattering );
						half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
						c.rgb += o.Albedo * translucency * strength;
					}
					#endif

					c.rgb += o.Emission;

					#if defined( ASE_FOG )
						UNITY_EXTRACT_FOG_FROM_WORLD_POS( IN );
						UNITY_APPLY_FOG(_unity_fogCoord, c.rgb);
					#endif
					return c;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19912
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
				#pragma multi_compile_prepassfinal
				#ifndef UNITY_PASS_DEFERRED
					#define UNITY_PASS_DEFERRED
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"

				#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
					#define ENABLE_TERRAIN_PERPIXEL_NORMAL
				#endif

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_SECOND_MASK
				#pragma shader_feature_local_fragment TVE_SECOND_MASK_SAMPLE_MAIN_UV TVE_SECOND_MASK_SAMPLE_EXTRA_UV TVE_SECOND_MASK_SAMPLE_PLANAR_2D TVE_SECOND_MASK_SAMPLE_PLANAR_3D
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_SECOND_COAT
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS, w = fogCoord
					half3 normalWS : TEXCOORD1;
					float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					half4 ambientOrLightmapUV : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					float4 ase_texcoord5 : TEXCOORD5;
					float4 ase_texcoord6 : TEXCOORD6;
					float4 ase_color : COLOR;
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef LIGHTMAP_ON
				float4 unity_LightmapFade;
				#endif
				half4 unity_Ambient;
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform half _ObjectCoordMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_EffexParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexBaseTex);
				uniform float4 TVE_EffexBaseCoord;
				uniform half _GlobalEffexPivotValue;
				uniform half _GlobalEffexLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexNearTex);
				uniform float4 TVE_EffexNearCoord;
				uniform float TVE_EffexLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_VertxParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxBaseTex);
				uniform float4 TVE_VertxBaseCoord;
				uniform half _GlobalVertxPivotValue;
				uniform half _GlobalVertxLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxNearTex);
				uniform float4 TVE_VertxNearCoord;
				uniform float TVE_VertxLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;
				uniform half _SecondIntensityValue;
				uniform half _SecondCoatMode;
				uniform half _SecondMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
				uniform half4 _second_mask_coord_value;
				uniform half _SecondMaskSampleMode;
				uniform half _SecondMaskCoordMode;
				uniform half4 _SecondMaskCoordValue;
				uniform half4 _SecondMaskRemap;
				uniform half _SecondMaskValue;
				uniform half _MainCategory;
				uniform half _MainEnd;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
				SamplerState sampler_Linear_Repeat_Aniso8;
				SamplerState sampler_Point_Repeat;
				uniform half4 _main_coord_value;
				uniform half _MainSampleMode;
				uniform half _MainCoordMode;
				uniform half4 _MainCoordValue;
				uniform half _MainAlbedoValue;
				uniform half4 _MainColorTwo;
				uniform half4 _MainColor;
				uniform half _MainMultiWriteMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainShaderTex);
				uniform half4 _MainMultiWriteRemap;
				uniform half _MainColorMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
				uniform half _MainNormalValue;
				uniform half _MainMetallicValue;
				uniform half4 _MainOcclusionRemap;
				uniform half _MainOcclusionValue;
				uniform half4 _MainSmoothnessRemap;
				uniform half _MainSmoothnessValue;
				uniform half _MainAlphaClipValue;
				uniform half4 _SecondBaseRemap;
				uniform half _SecondBaseValue;
				uniform half4 _SecondLumaRemap;
				uniform half _SecondLumaValue;
				uniform half4 _SecondProjRemap;
				uniform half _SecondProjValue;
				uniform half _SecondMeshMode;
				uniform half4 _SecondMeshRemap;
				uniform half _SecondMeshValue;
				uniform half _SecondBlendMath;
				uniform half4 _SecondBlendRemap;
				uniform half _SecondBlendIntensityValue;
				uniform half _SecondCoatValue;
				uniform half TVE_DEBUG_Global;
				uniform float _IsTerrainShader;
				uniform float _RenderClip;
				uniform float _IsElementShader;
				uniform float _IsHelperShader;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half4 In_TangentOS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.TangentOS = In_TangentOS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				void BuildVertexData( inout TVEVertexData Data, half In_Dummy, float3 In_PositionOS, half3 In_NormalOS, half4 In_TangentOS, half4 In_TransformData, half4 In_RotationData, float4 In_Interpolator )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.NormalOS = In_NormalOS;
					Data.TangentOS = In_TangentOS;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.Interpolator = In_Interpolator;
					return;
				}
				
				void BreakVertexData( inout TVEVertexData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_NormalOS, out half4 Out_TangentOS, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_NormalOS = Data.NormalOS;
					Out_TangentOS = Data.TangentOS;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				half3 ComputeTriplanarMasks( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatTexture, half4 In_DrawTexture, half4 In_PaintTexture, half4 In_AtmoTexture, half4 In_EffexTexture, half4 In_GlowTexture, float4 In_FormTexture, float4 In_LandTexture, float4 In_VertxTexture, float4 In_FlowTexture, half4 In_UserTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatTexture = In_CoatTexture;
					Data.DrawTexture = In_DrawTexture;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoTexture = In_AtmoTexture;
					Data.EffexTexture = In_EffexTexture;
					Data.GlowTexture = In_GlowTexture;
					Data.FormTexture = In_FormTexture;
					Data.LandTexture = In_LandTexture;
					Data.VertxTexture = In_VertxTexture;
					Data.FlowTexture = In_FlowTexture;
					Data.UserTexture = In_UserTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatTexture, out half4 Out_DrawTexture, out half4 Out_PaintTexture, out half4 Out_AtmoTexture, out half4 Out_EffexTexture, out half4 Out_GlowTexture, out float4 Out_FormTexture, out float4 Out_LandTexture, out half4 Out_VertxTexture, out half4 Out_FlowTexture, out half4 Out_UserTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatTexture = Data.CoatTexture;
					Out_DrawTexture = Data.DrawTexture;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_EffexTexture= Data.EffexTexture;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormTexture = Data.FormTexture;
					Out_LandTexture = Data.LandTexture;
					Out_VertxTexture = Data.VertxTexture;
					Out_FlowTexture = Data.FlowTexture;
					Out_UserTexture = Data.UserTexture;
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
				
				half4 SampleCoord( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
				{
					half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
					Normal = tex.wy * 2.0 - 1.0;
					return tex;
				}
				
				half4 SamplePlanar2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
				{
					half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
					half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
					normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
					Normal = normal_Y;
					return tex_Y;
				}
				
				half4 SamplePlanar3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				
				float SwitchChannel6( half Option, half4 ChannelA, half4 ChannelB )
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
					}
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
				
				half SwitchBlendMask( half Multiply, half Subtract, half Option )
				{
					switch (Option) {
						default:
					                case 0:
							return Multiply;
						case 1:
							return Subtract;
					}
				}
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251664 =(TVEVertexData)0;
					float In_Dummy16_g251664 = 0.0;
					TVEVertexData Data16_g251659 =(TVEVertexData)0;
					float In_Dummy16_g251659 = 0.0;
					TVEModelData Data16_g235783 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#else
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#endif
					half Dummy207_g235765 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g235765 );
					float temp_output_14_0_g235783 = Dummy207_g235765;
					float In_Dummy16_g235783 = temp_output_14_0_g235783;
					float3 PositionOS131_g235765 = v.vertex.xyz;
					float3 temp_output_4_0_g235783 = PositionOS131_g235765;
					float3 In_PositionOS16_g235783 = temp_output_4_0_g235783;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g235765 = ase_positionWS;
					float3 vertexToFrag73_g235765 = temp_output_104_7_g235765;
					float3 PositionWS122_g235765 = vertexToFrag73_g235765;
					float3 In_PositionWS16_g235783 = PositionWS122_g235765;
					float4x4 break19_g235768 = unity_ObjectToWorld;
					float3 appendResult20_g235768 = (float3(break19_g235768[ 0 ][ 3 ] , break19_g235768[ 1 ][ 3 ] , break19_g235768[ 2 ][ 3 ]));
					float3 temp_output_340_7_g235765 = appendResult20_g235768;
					float4x4 break19_g235770 = unity_ObjectToWorld;
					float3 appendResult20_g235770 = (float3(break19_g235770[ 0 ][ 3 ] , break19_g235770[ 1 ][ 3 ] , break19_g235770[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g235766 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g235765 = PositionOS131_g235765;
					float3 appendResult234_g235765 = (float3(break233_g235765.x , 0.0 , break233_g235765.z));
					float3 break413_g235765 = PositionOS131_g235765;
					float3 appendResult414_g235765 = (float3(break413_g235765.x , break413_g235765.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g235772 = appendResult414_g235765;
					#else
					float3 staticSwitch65_g235772 = appendResult234_g235765;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g235765 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g235765 = appendResult60_g235766;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g235765 = staticSwitch65_g235772;
					#else
					float3 staticSwitch229_g235765 = _Vector0;
					#endif
					float3 PivotOS149_g235765 = staticSwitch229_g235765;
					float3 temp_output_122_0_g235770 = PivotOS149_g235765;
					float3 PivotsOnlyWS105_g235770 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g235770 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g235765 = ( appendResult20_g235770 + PivotsOnlyWS105_g235770 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#else
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#endif
					float3 vertexToFrag76_g235765 = staticSwitch236_g235765;
					float3 PivotWS121_g235765 = vertexToFrag76_g235765;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g235765 = ( PositionWS122_g235765 - PivotWS121_g235765 );
					#else
					float3 staticSwitch204_g235765 = PositionWS122_g235765;
					#endif
					float3 PositionWO132_g235765 = ( staticSwitch204_g235765 - TVE_WorldOrigin );
					float3 In_PositionWO16_g235783 = PositionWO132_g235765;
					float3 In_PivotOS16_g235783 = PivotOS149_g235765;
					float3 In_PivotWS16_g235783 = PivotWS121_g235765;
					float3 PivotWO133_g235765 = ( PivotWS121_g235765 - TVE_WorldOrigin );
					float3 In_PivotWO16_g235783 = PivotWO133_g235765;
					half3 NormalOS134_g235765 = v.normal;
					float3 temp_output_21_0_g235783 = NormalOS134_g235765;
					float3 In_NormalOS16_g235783 = temp_output_21_0_g235783;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g235765 = normalizedWorldNormal;
					float3 In_NormalWS16_g235783 = NormalWS95_g235765;
					half4 TangentlOS153_g235765 = v.tangent;
					float4 temp_output_6_0_g235783 = TangentlOS153_g235765;
					float4 In_TangentOS16_g235783 = temp_output_6_0_g235783;
					float3 normalizeResult296_g235765 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g235765 ) );
					half3 ViewDirWS169_g235765 = normalizeResult296_g235765;
					float3 In_ViewDirWS16_g235783 = ViewDirWS169_g235765;
					float4 appendResult397_g235765 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g235765 = appendResult397_g235765;
					float4 In_CoordsData16_g235783 = CoordsData398_g235765;
					half4 VertexMasks171_g235765 = v.ase_color;
					float4 In_VertexData16_g235783 = VertexMasks171_g235765;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235777 = (PositionOS131_g235765).z;
					#else
					float staticSwitch65_g235777 = (PositionOS131_g235765).y;
					#endif
					half Object_HeightValue267_g235765 = _ObjectHeightValue;
					half Bounds_HeightMask274_g235765 = saturate( ( staticSwitch65_g235777 / Object_HeightValue267_g235765 ) );
					half3 Position387_g235765 = PositionOS131_g235765;
					half Height387_g235765 = Object_HeightValue267_g235765;
					half Object_RadiusValue268_g235765 = _ObjectRadiusValue;
					half Radius387_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskYUp387_g235765 = CapsuleMaskYUp( Position387_g235765 , Height387_g235765 , Radius387_g235765 );
					half3 Position408_g235765 = PositionOS131_g235765;
					half Height408_g235765 = Object_HeightValue267_g235765;
					half Radius408_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskZUp408_g235765 = CapsuleMaskZUp( Position408_g235765 , Height408_g235765 , Radius408_g235765 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235782 = saturate( localCapsuleMaskZUp408_g235765 );
					#else
					float staticSwitch65_g235782 = saturate( localCapsuleMaskYUp387_g235765 );
					#endif
					half Bounds_SphereMask282_g235765 = staticSwitch65_g235782;
					float4 appendResult253_g235765 = (float4(Bounds_HeightMask274_g235765 , Bounds_SphereMask282_g235765 , 1.0 , 1.0));
					half4 MasksData254_g235765 = appendResult253_g235765;
					float4 In_MasksData16_g235783 = MasksData254_g235765;
					float temp_output_17_0_g235776 = _ObjectPhaseMode;
					float Option70_g235776 = temp_output_17_0_g235776;
					float4 temp_output_3_0_g235776 = v.ase_color;
					float4 Channel70_g235776 = temp_output_3_0_g235776;
					float localSwitchChannel470_g235776 = SwitchChannel4( Option70_g235776 , Channel70_g235776 );
					half Phase_Value372_g235765 = localSwitchChannel470_g235776;
					float3 break319_g235765 = PivotWO133_g235765;
					half Pivot_Position322_g235765 = ( break319_g235765.x + break319_g235765.z );
					half Phase_Position357_g235765 = ( Phase_Value372_g235765 + Pivot_Position322_g235765 );
					float temp_output_248_0_g235765 = frac( Phase_Position357_g235765 );
					float4 appendResult177_g235765 = (float4((frac( ( Phase_Position357_g235765 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g235765));
					half4 Phase_Data176_g235765 = appendResult177_g235765;
					float4 In_PhaseData16_g235783 = Phase_Data176_g235765;
					BuildModelVertData( Data16_g235783 , In_Dummy16_g235783 , In_PositionOS16_g235783 , In_PositionWS16_g235783 , In_PositionWO16_g235783 , In_PivotOS16_g235783 , In_PivotWS16_g235783 , In_PivotWO16_g235783 , In_NormalOS16_g235783 , In_NormalWS16_g235783 , In_TangentOS16_g235783 , In_ViewDirWS16_g235783 , In_CoordsData16_g235783 , In_VertexData16_g235783 , In_MasksData16_g235783 , In_PhaseData16_g235783 );
					TVEModelData Data15_g251660 =(TVEModelData)Data16_g235783;
					float Out_Dummy15_g251660 = 0.0;
					float3 Out_PositionOS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251660 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251660 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251660 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251660 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251660 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251660 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251660 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251660 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251660 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251660 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251660 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251660 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251660 , Out_Dummy15_g251660 , Out_PositionOS15_g251660 , Out_PositionWS15_g251660 , Out_PositionWO15_g251660 , Out_PositionRawOS15_g251660 , Out_PivotOS15_g251660 , Out_PivotWS15_g251660 , Out_PivotWO15_g251660 , Out_NormalOS15_g251660 , Out_NormalWS15_g251660 , Out_NormalRawOS15_g251660 , Out_TangentOS15_g251660 , Out_TangentWS15_g251660 , Out_BitangentWS15_g251660 , Out_ViewDirWS15_g251660 , Out_CoordsData15_g251660 , Out_VertexData15_g251660 , Out_MasksData15_g251660 , Out_PhaseData15_g251660 , Out_TransformData15_g251660 , Out_RotationData15_g251660 , Out_Interpolator15_g251660 );
					float3 In_PositionOS16_g251659 = Out_PositionOS15_g251660;
					float3 In_NormalOS16_g251659 = Out_NormalOS15_g251660;
					float4 In_TangentOS16_g251659 = Out_TangentOS15_g251660;
					float4 In_TransformData16_g251659 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251659 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251659 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251659 , In_Dummy16_g251659 , In_PositionOS16_g251659 , In_NormalOS16_g251659 , In_TangentOS16_g251659 , In_TransformData16_g251659 , In_RotationData16_g251659 , In_Interpolator16_g251659 );
					TVEVertexData Data15_g251662 =(TVEVertexData)Data16_g251659;
					float Out_Dummy15_g251662 = 0.0;
					float3 Out_PositionOS15_g251662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251662 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251662 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251662 , Out_Dummy15_g251662 , Out_PositionOS15_g251662 , Out_NormalOS15_g251662 , Out_TangentOS15_g251662 , Out_TransformData15_g251662 , Out_RotationData15_g251662 , Out_Interpolator15_g251662 );
					TVEModelData Data15_g251663 =(TVEModelData)Data15_g251660;
					float Out_Dummy15_g251663 = 0.0;
					float3 Out_PositionOS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251663 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251663 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251663 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251663 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251663 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251663 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251663 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251663 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251663 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251663 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251663 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251663 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251663 , Out_Dummy15_g251663 , Out_PositionOS15_g251663 , Out_PositionWS15_g251663 , Out_PositionWO15_g251663 , Out_PositionRawOS15_g251663 , Out_PivotOS15_g251663 , Out_PivotWS15_g251663 , Out_PivotWO15_g251663 , Out_NormalOS15_g251663 , Out_NormalWS15_g251663 , Out_NormalRawOS15_g251663 , Out_TangentOS15_g251663 , Out_TangentWS15_g251663 , Out_BitangentWS15_g251663 , Out_ViewDirWS15_g251663 , Out_CoordsData15_g251663 , Out_VertexData15_g251663 , Out_MasksData15_g251663 , Out_PhaseData15_g251663 , Out_TransformData15_g251663 , Out_RotationData15_g251663 , Out_Interpolator15_g251663 );
					float3 In_PositionOS16_g251664 = ( Out_PositionOS15_g251662 - Out_PivotOS15_g251663 );
					float3 In_NormalOS16_g251664 = Out_NormalOS15_g251663;
					float4 In_TangentOS16_g251664 = Out_TangentOS15_g251663;
					float4 In_TransformData16_g251664 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251664 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251664 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251664 , In_Dummy16_g251664 , In_PositionOS16_g251664 , In_NormalOS16_g251664 , In_TangentOS16_g251664 , In_TransformData16_g251664 , In_RotationData16_g251664 , In_Interpolator16_g251664 );
					TVEVertexData Data15_g251673 =(TVEVertexData)Data16_g251664;
					float Out_Dummy15_g251673 = 0.0;
					float3 Out_PositionOS15_g251673 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251673 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251673 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251673 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251673 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251673 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251673 , Out_Dummy15_g251673 , Out_PositionOS15_g251673 , Out_NormalOS15_g251673 , Out_TangentOS15_g251673 , Out_TransformData15_g251673 , Out_RotationData15_g251673 , Out_Interpolator15_g251673 );
					TVEVertexData Data16_g251674 =(TVEVertexData)Data15_g251673;
					half Dummy317_g251665 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251674 = Dummy317_g251665;
					float3 In_PositionOS16_g251674 = Out_PositionOS15_g251673;
					float3 In_NormalOS16_g251674 = Out_NormalOS15_g251673;
					float4 In_TangentOS16_g251674 = Out_TangentOS15_g251673;
					half4 Model_TransformData356_g251665 = Out_TransformData15_g251673;
					float localBuildGlobalData204_g235664 = ( 0.0 );
					TVEGlobalData Data204_g235664 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g235664 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g235664 = Dummy211_g235664;
					float4 temp_output_203_0_g235683 = TVE_CoatBaseCoord;
					TVEModelData Data16_g235773 =(TVEModelData)0;
					float In_Dummy16_g235773 = 0.0;
					float3 In_PositionWS16_g235773 = PositionWS122_g235765;
					float3 In_PositionWO16_g235773 = PositionWO132_g235765;
					float3 In_PivotWS16_g235773 = PivotWS121_g235765;
					float3 In_PivotWO16_g235773 = PivotWO133_g235765;
					float3 In_NormalWS16_g235773 = NormalWS95_g235765;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g235765 = ase_tangentWS;
					float3 In_TangentWS16_g235773 = TangentWS136_g235765;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g235765 = ase_bitangentWS;
					float3 In_BitangentWS16_g235773 = BiangentWS421_g235765;
					half3 NormalWS427_g235765 = NormalWS95_g235765;
					half3 localComputeTriplanarMasks427_g235765 = ComputeTriplanarMasks( NormalWS427_g235765 );
					half3 TriplanarWeights429_g235765 = localComputeTriplanarMasks427_g235765;
					float3 In_TriplanarWeights16_g235773 = TriplanarWeights429_g235765;
					float3 In_ViewDirWS16_g235773 = ViewDirWS169_g235765;
					float4 In_CoordsData16_g235773 = CoordsData398_g235765;
					float4 In_VertexData16_g235773 = VertexMasks171_g235765;
					float4 In_Interpolator16_g235773 = Phase_Data176_g235765;
					BuildModelFragData( Data16_g235773 , In_Dummy16_g235773 , In_PositionWS16_g235773 , In_PositionWO16_g235773 , In_PivotWS16_g235773 , In_PivotWO16_g235773 , In_NormalWS16_g235773 , In_TangentWS16_g235773 , In_BitangentWS16_g235773 , In_TriplanarWeights16_g235773 , In_ViewDirWS16_g235773 , In_CoordsData16_g235773 , In_VertexData16_g235773 , In_Interpolator16_g235773 );
					TVEModelData Data15_g235754 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g235754 = 0.0;
					float3 Out_PositionWS15_g235754 = float3( 0,0,0 );
					float3 Out_PositionWO15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWS15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWO15_g235754 = float3( 0,0,0 );
					float3 Out_NormalWS15_g235754 = float3( 0,0,0 );
					float3 Out_TangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g235754 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g235754 = float3( 0,0,0 );
					float4 Out_CoordsData15_g235754 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g235754 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g235754 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g235754 , Out_Dummy15_g235754 , Out_PositionWS15_g235754 , Out_PositionWO15_g235754 , Out_PivotWS15_g235754 , Out_PivotWO15_g235754 , Out_NormalWS15_g235754 , Out_TangentWS15_g235754 , Out_BitangentWS15_g235754 , Out_TriplanarWeights15_g235754 , Out_ViewDirWS15_g235754 , Out_CoordsData15_g235754 , Out_VertexData15_g235754 , Out_Interpolator15_g235754 );
					float3 Model_PositionWS497_g235664 = Out_PositionWS15_g235754;
					float2 Model_PositionWS_XZ143_g235664 = (Model_PositionWS497_g235664).xz;
					float3 Model_PivotWS498_g235664 = Out_PivotWS15_g235754;
					float2 Model_PivotWS_XZ145_g235664 = (Model_PivotWS498_g235664).xz;
					float2 lerpResult300_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g235683 = lerpResult300_g235664;
					float temp_output_82_0_g235681 = _GlobalCoatLayerValue;
					float temp_output_82_0_g235683 = temp_output_82_0_g235681;
					float4 tex2DArrayNode83_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235683).zw + ( (temp_output_203_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult210_g235683 = (float4(tex2DArrayNode83_g235683.rgb , tex2DArrayNode83_g235683.a));
					float4 temp_output_204_0_g235683 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235683).zw + ( (temp_output_204_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult212_g235683 = (float4(tex2DArrayNode122_g235683.rgb , tex2DArrayNode122_g235683.a));
					float4 TVE_RenderNearPositionR628_g235664 = TVE_RenderNearPositionR;
					float temp_output_507_0_g235664 = saturate( ( distance( Model_PositionWS497_g235664 , (TVE_RenderNearPositionR628_g235664).xyz ) / (TVE_RenderNearPositionR628_g235664).w ) );
					float temp_output_7_0_g235753 = 1.0;
					float temp_output_9_0_g235753 = ( temp_output_507_0_g235664 - temp_output_7_0_g235753 );
					half TVE_RenderNearFadeValue635_g235664 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g235664 = saturate( ( temp_output_9_0_g235753 / ( ( TVE_RenderNearFadeValue635_g235664 - temp_output_7_0_g235753 ) + 0.0001 ) ) );
					float4 lerpResult131_g235683 = lerp( appendResult210_g235683 , appendResult212_g235683 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235681 = lerpResult131_g235683;
					float4 lerpResult168_g235681 = lerp( TVE_CoatParams , temp_output_159_109_g235681 , TVE_CoatLayers[(int)temp_output_82_0_g235681]);
					float4 temp_output_589_109_g235664 = lerpResult168_g235681;
					half4 Coat_Texture302_g235664 = temp_output_589_109_g235664;
					float4 In_CoatTexture204_g235664 = Coat_Texture302_g235664;
					half4 Draw_Texture656_g235664 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g235664 = Draw_Texture656_g235664;
					float4 temp_output_203_0_g235708 = TVE_PaintBaseCoord;
					float2 lerpResult85_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g235708 = lerpResult85_g235664;
					float temp_output_82_0_g235705 = _GlobalPaintLayerValue;
					float temp_output_82_0_g235708 = temp_output_82_0_g235705;
					float4 tex2DArrayNode83_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235708).zw + ( (temp_output_203_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult210_g235708 = (float4(tex2DArrayNode83_g235708.rgb , tex2DArrayNode83_g235708.a));
					float4 temp_output_204_0_g235708 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235708).zw + ( (temp_output_204_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult212_g235708 = (float4(tex2DArrayNode122_g235708.rgb , tex2DArrayNode122_g235708.a));
					float4 lerpResult131_g235708 = lerp( appendResult210_g235708 , appendResult212_g235708 , Global_TexBlend509_g235664);
					float4 temp_output_171_109_g235705 = lerpResult131_g235708;
					float4 lerpResult174_g235705 = lerp( TVE_PaintParams , temp_output_171_109_g235705 , TVE_PaintLayers[(int)temp_output_82_0_g235705]);
					float4 temp_output_595_109_g235664 = lerpResult174_g235705;
					half4 Paint_Texture71_g235664 = temp_output_595_109_g235664;
					float4 In_PaintTexture204_g235664 = Paint_Texture71_g235664;
					float4 temp_output_203_0_g235691 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g235691 = lerpResult104_g235664;
					float temp_output_132_0_g235689 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g235691 = temp_output_132_0_g235689;
					float4 tex2DArrayNode83_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235691).zw + ( (temp_output_203_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult210_g235691 = (float4(tex2DArrayNode83_g235691.rgb , tex2DArrayNode83_g235691.a));
					float4 temp_output_204_0_g235691 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235691).zw + ( (temp_output_204_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult212_g235691 = (float4(tex2DArrayNode122_g235691.rgb , tex2DArrayNode122_g235691.a));
					float4 lerpResult131_g235691 = lerp( appendResult210_g235691 , appendResult212_g235691 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235689 = lerpResult131_g235691;
					float4 lerpResult145_g235689 = lerp( TVE_AtmoParams , temp_output_137_109_g235689 , TVE_AtmoLayers[(int)temp_output_132_0_g235689]);
					float4 temp_output_590_110_g235664 = lerpResult145_g235689;
					half4 Atmo_Texture80_g235664 = temp_output_590_110_g235664;
					float4 In_AtmoTexture204_g235664 = Atmo_Texture80_g235664;
					float4 temp_output_203_0_g235759 = TVE_EffexBaseCoord;
					float2 lerpResult414_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g235759 = lerpResult414_g235664;
					float temp_output_132_0_g235757 = _GlobalEffexLayerValue;
					float temp_output_82_0_g235759 = temp_output_132_0_g235757;
					float4 tex2DArrayNode83_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235759).zw + ( (temp_output_203_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult210_g235759 = (float4(tex2DArrayNode83_g235759.rgb , tex2DArrayNode83_g235759.a));
					float4 temp_output_204_0_g235759 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235759).zw + ( (temp_output_204_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult212_g235759 = (float4(tex2DArrayNode122_g235759.rgb , tex2DArrayNode122_g235759.a));
					float4 lerpResult131_g235759 = lerp( appendResult210_g235759 , appendResult212_g235759 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235757 = lerpResult131_g235759;
					float4 lerpResult145_g235757 = lerp( TVE_EffexParams , temp_output_137_109_g235757 , TVE_EffexLayers[(int)temp_output_132_0_g235757]);
					float4 temp_output_731_110_g235664 = lerpResult145_g235757;
					half4 Effex_Texture420_g235664 = temp_output_731_110_g235664;
					float4 In_EffexTexture204_g235664 = Effex_Texture420_g235664;
					float4 temp_output_203_0_g235739 = TVE_GlowBaseCoord;
					float2 lerpResult247_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g235739 = lerpResult247_g235664;
					float temp_output_82_0_g235737 = _GlobalGlowLayerValue;
					float temp_output_82_0_g235739 = temp_output_82_0_g235737;
					float4 tex2DArrayNode83_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235739).zw + ( (temp_output_203_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult210_g235739 = (float4(tex2DArrayNode83_g235739.rgb , tex2DArrayNode83_g235739.a));
					float4 temp_output_204_0_g235739 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235739).zw + ( (temp_output_204_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult212_g235739 = (float4(tex2DArrayNode122_g235739.rgb , tex2DArrayNode122_g235739.a));
					float4 lerpResult131_g235739 = lerp( appendResult210_g235739 , appendResult212_g235739 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235737 = lerpResult131_g235739;
					float4 lerpResult167_g235737 = lerp( TVE_GlowParams , temp_output_159_109_g235737 , TVE_GlowLayers[(int)temp_output_82_0_g235737]);
					float4 temp_output_593_109_g235664 = lerpResult167_g235737;
					half4 Glow_Texture248_g235664 = temp_output_593_109_g235664;
					float4 In_GlowTexture204_g235664 = Glow_Texture248_g235664;
					float4 temp_output_203_0_g235675 = TVE_FormBaseCoord;
					float2 lerpResult168_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g235675 = lerpResult168_g235664;
					float temp_output_130_0_g235673 = _GlobalFormLayerValue;
					float temp_output_82_0_g235675 = temp_output_130_0_g235673;
					float4 tex2DArrayNode83_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235675).zw + ( (temp_output_203_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult210_g235675 = (float4(tex2DArrayNode83_g235675.rgb , tex2DArrayNode83_g235675.a));
					float4 temp_output_204_0_g235675 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235675).zw + ( (temp_output_204_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult212_g235675 = (float4(tex2DArrayNode122_g235675.rgb , tex2DArrayNode122_g235675.a));
					float4 lerpResult131_g235675 = lerp( appendResult210_g235675 , appendResult212_g235675 , Global_TexBlend509_g235664);
					float4 temp_output_135_109_g235673 = lerpResult131_g235675;
					float4 lerpResult143_g235673 = lerp( TVE_FormParams , temp_output_135_109_g235673 , TVE_FormLayers[(int)temp_output_130_0_g235673]);
					float4 temp_output_592_0_g235664 = lerpResult143_g235673;
					float4 Form_Texture112_g235664 = temp_output_592_0_g235664;
					float4 In_FormTexture204_g235664 = Form_Texture112_g235664;
					float4 In_LandTexture204_g235664 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g235723 = TVE_VertxBaseCoord;
					float2 lerpResult681_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g235723 = lerpResult681_g235664;
					float temp_output_136_0_g235721 = _GlobalVertxLayerValue;
					float temp_output_82_0_g235723 = temp_output_136_0_g235721;
					float4 tex2DArrayNode83_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235723).zw + ( (temp_output_203_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult210_g235723 = (float4(tex2DArrayNode83_g235723.rgb , tex2DArrayNode83_g235723.a));
					float4 temp_output_204_0_g235723 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235723).zw + ( (temp_output_204_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult212_g235723 = (float4(tex2DArrayNode122_g235723.rgb , tex2DArrayNode122_g235723.a));
					float4 lerpResult131_g235723 = lerp( appendResult210_g235723 , appendResult212_g235723 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235721 = lerpResult131_g235723;
					float4 lerpResult149_g235721 = lerp( TVE_VertxParams , temp_output_141_109_g235721 , TVE_VertxLayers[(int)temp_output_136_0_g235721]);
					float4 temp_output_695_0_g235664 = lerpResult149_g235721;
					half4 Vertx_Texture693_g235664 = temp_output_695_0_g235664;
					float4 In_VertxTexture204_g235664 = Vertx_Texture693_g235664;
					float4 temp_output_203_0_g235699 = TVE_FlowBaseCoord;
					float2 lerpResult400_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g235699 = lerpResult400_g235664;
					float temp_output_136_0_g235697 = _GlobalFlowLayerValue;
					float temp_output_82_0_g235699 = temp_output_136_0_g235697;
					float4 tex2DArrayNode83_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235699).zw + ( (temp_output_203_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult210_g235699 = (float4(tex2DArrayNode83_g235699.rgb , tex2DArrayNode83_g235699.a));
					float4 temp_output_204_0_g235699 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235699).zw + ( (temp_output_204_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult212_g235699 = (float4(tex2DArrayNode122_g235699.rgb , tex2DArrayNode122_g235699.a));
					float4 lerpResult131_g235699 = lerp( appendResult210_g235699 , appendResult212_g235699 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235697 = lerpResult131_g235699;
					float4 lerpResult149_g235697 = lerp( TVE_FlowParams , temp_output_141_109_g235697 , TVE_FlowLayers[(int)temp_output_136_0_g235697]);
					float4 temp_output_594_0_g235664 = lerpResult149_g235697;
					half4 Flow_Texture405_g235664 = temp_output_594_0_g235664;
					float4 In_FlowTexture204_g235664 = Flow_Texture405_g235664;
					half4 User_Texture677_g235664 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g235664 = User_Texture677_g235664;
					BuildGlobalData( Data204_g235664 , In_Dummy204_g235664 , In_CoatTexture204_g235664 , In_DrawTexture204_g235664 , In_PaintTexture204_g235664 , In_AtmoTexture204_g235664 , In_EffexTexture204_g235664 , In_GlowTexture204_g235664 , In_FormTexture204_g235664 , In_LandTexture204_g235664 , In_VertxTexture204_g235664 , In_FlowTexture204_g235664 , In_UserTexture204_g235664 );
					TVEGlobalData Data15_g251675 =(TVEGlobalData)Data204_g235664;
					float Out_Dummy15_g251675 = 0.0;
					float4 Out_CoatTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251675 = float4( 0,0,0,0 );
					BreakData( Data15_g251675 , Out_Dummy15_g251675 , Out_CoatTexture15_g251675 , Out_DrawTexture15_g251675 , Out_PaintTexture15_g251675 , Out_AtmoTexture15_g251675 , Out_EffexTexture15_g251675 , Out_GlowTexture15_g251675 , Out_FormTexture15_g251675 , Out_LandTexture15_g251675 , Out_VertxTexture15_g251675 , Out_FlowTexture15_g251675 , Out_UserTexture15_g251675 );
					float4 Global_FormTexture351_g251665 = Out_FormTexture15_g251675;
					TVEModelData Data15_g251672 =(TVEModelData)Data15_g251663;
					float Out_Dummy15_g251672 = 0.0;
					float3 Out_PositionOS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251672 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251672 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251672 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251672 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251672 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251672 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251672 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251672 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251672 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251672 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251672 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251672 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251672 , Out_Dummy15_g251672 , Out_PositionOS15_g251672 , Out_PositionWS15_g251672 , Out_PositionWO15_g251672 , Out_PositionRawOS15_g251672 , Out_PivotOS15_g251672 , Out_PivotWS15_g251672 , Out_PivotWO15_g251672 , Out_NormalOS15_g251672 , Out_NormalWS15_g251672 , Out_NormalRawOS15_g251672 , Out_TangentOS15_g251672 , Out_TangentWS15_g251672 , Out_BitangentWS15_g251672 , Out_ViewDirWS15_g251672 , Out_CoordsData15_g251672 , Out_VertexData15_g251672 , Out_MasksData15_g251672 , Out_PhaseData15_g251672 , Out_TransformData15_g251672 , Out_RotationData15_g251672 , Out_Interpolator15_g251672 );
					float3 Model_PivotWO353_g251665 = Out_PivotWO15_g251672;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251671 = _ConformMeshMode;
					float Option70_g251671 = temp_output_17_0_g251671;
					half4 Model_VertexData357_g251665 = Out_VertexData15_g251672;
					float4 temp_output_3_0_g251671 = Model_VertexData357_g251665;
					float4 Channel70_g251671 = temp_output_3_0_g251671;
					float localSwitchChannel470_g251671 = SwitchChannel4( Option70_g251671 , Channel70_g251671 );
					float temp_output_390_0_g251665 = localSwitchChannel470_g251671;
					float temp_output_7_0_g251668 = _ConformMeshRemap.x;
					float temp_output_9_0_g251668 = ( temp_output_390_0_g251665 - temp_output_7_0_g251668 );
					float lerpResult374_g251665 = lerp( 1.0 , saturate( ( temp_output_9_0_g251668 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251665 = lerpResult374_g251665;
					float temp_output_328_0_g251665 = ( Blend_VertMask379_g251665 * TVE_IsEnabled );
					half Conform_Mask366_g251665 = temp_output_328_0_g251665;
					float temp_output_322_0_g251665 = ( ( ( ( (Global_FormTexture351_g251665).z - ( (Model_PivotWO353_g251665).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251665 ) );
					float3 appendResult329_g251665 = (float3(0.0 , temp_output_322_0_g251665 , 0.0));
					float3 appendResult387_g251665 = (float3(0.0 , 0.0 , temp_output_322_0_g251665));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251669 = appendResult387_g251665;
					#else
					float3 staticSwitch65_g251669 = appendResult329_g251665;
					#endif
					float3 Blanket_Conform368_g251665 = staticSwitch65_g251669;
					float4 appendResult312_g251665 = (float4(Blanket_Conform368_g251665 , 0.0));
					float4 temp_output_310_0_g251665 = ( Model_TransformData356_g251665 + appendResult312_g251665 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251665 = temp_output_310_0_g251665;
					#else
					float4 staticSwitch364_g251665 = Model_TransformData356_g251665;
					#endif
					half4 Final_TransformData365_g251665 = staticSwitch364_g251665;
					float4 In_TransformData16_g251674 = Final_TransformData365_g251665;
					float4 In_RotationData16_g251674 = Out_RotationData15_g251673;
					float4 In_Interpolator16_g251674 = Out_Interpolator15_g251673;
					BuildVertexData( Data16_g251674 , In_Dummy16_g251674 , In_PositionOS16_g251674 , In_NormalOS16_g251674 , In_TangentOS16_g251674 , In_TransformData16_g251674 , In_RotationData16_g251674 , In_Interpolator16_g251674 );
					TVEVertexData Data15_g251685 =(TVEVertexData)Data16_g251674;
					float Out_Dummy15_g251685 = 0.0;
					float3 Out_PositionOS15_g251685 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251685 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251685 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251685 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251685 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251685 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251685 , Out_Dummy15_g251685 , Out_PositionOS15_g251685 , Out_NormalOS15_g251685 , Out_TangentOS15_g251685 , Out_TransformData15_g251685 , Out_RotationData15_g251685 , Out_Interpolator15_g251685 );
					TVEVertexData Data16_g251686 =(TVEVertexData)Data15_g251685;
					float In_Dummy16_g251686 = 0.0;
					float3 Vertex_PositionOS147_g251676 = Out_PositionOS15_g251685;
					half3 VertexPos40_g251680 = Vertex_PositionOS147_g251676;
					float4 temp_output_1615_33_g251676 = Out_RotationData15_g251685;
					half4 Vertex_RotationData1569_g251676 = temp_output_1615_33_g251676;
					float2 break1582_g251676 = (Vertex_RotationData1569_g251676).xy;
					half Angle44_g251680 = break1582_g251676.y;
					half CosAngle89_g251680 = cos( Angle44_g251680 );
					half SinAngle93_g251680 = sin( Angle44_g251680 );
					float3 appendResult95_g251680 = (float3((VertexPos40_g251680).x , ( ( (VertexPos40_g251680).y * CosAngle89_g251680 ) - ( (VertexPos40_g251680).z * SinAngle93_g251680 ) ) , ( ( (VertexPos40_g251680).y * SinAngle93_g251680 ) + ( (VertexPos40_g251680).z * CosAngle89_g251680 ) )));
					half3 VertexPos40_g251681 = appendResult95_g251680;
					half Angle44_g251681 = -break1582_g251676.x;
					half CosAngle94_g251681 = cos( Angle44_g251681 );
					half SinAngle95_g251681 = sin( Angle44_g251681 );
					float3 appendResult98_g251681 = (float3(( ( (VertexPos40_g251681).x * CosAngle94_g251681 ) - ( (VertexPos40_g251681).y * SinAngle95_g251681 ) ) , ( ( (VertexPos40_g251681).x * SinAngle95_g251681 ) + ( (VertexPos40_g251681).y * CosAngle94_g251681 ) ) , (VertexPos40_g251681).z));
					half3 VertexPos40_g251679 = Vertex_PositionOS147_g251676;
					half Angle44_g251679 = break1582_g251676.y;
					half CosAngle89_g251679 = cos( Angle44_g251679 );
					half SinAngle93_g251679 = sin( Angle44_g251679 );
					float3 appendResult95_g251679 = (float3((VertexPos40_g251679).x , ( ( (VertexPos40_g251679).y * CosAngle89_g251679 ) - ( (VertexPos40_g251679).z * SinAngle93_g251679 ) ) , ( ( (VertexPos40_g251679).y * SinAngle93_g251679 ) + ( (VertexPos40_g251679).z * CosAngle89_g251679 ) )));
					half3 VertexPos40_g251684 = appendResult95_g251679;
					half Angle44_g251684 = break1582_g251676.x;
					half CosAngle91_g251684 = cos( Angle44_g251684 );
					half SinAngle92_g251684 = sin( Angle44_g251684 );
					float3 appendResult93_g251684 = (float3(( ( (VertexPos40_g251684).x * CosAngle91_g251684 ) + ( (VertexPos40_g251684).z * SinAngle92_g251684 ) ) , (VertexPos40_g251684).y , ( ( -(VertexPos40_g251684).x * SinAngle92_g251684 ) + ( (VertexPos40_g251684).z * CosAngle91_g251684 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251682 = appendResult93_g251684;
					#else
					float3 staticSwitch65_g251682 = appendResult98_g251681;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251677 = staticSwitch65_g251682;
					#else
					float3 staticSwitch65_g251677 = Vertex_PositionOS147_g251676;
					#endif
					float3 temp_output_1608_0_g251676 = staticSwitch65_g251677;
					half3 VertexPos40_g251683 = temp_output_1608_0_g251676;
					half Angle44_g251683 = (Vertex_RotationData1569_g251676).z;
					half CosAngle91_g251683 = cos( Angle44_g251683 );
					half SinAngle92_g251683 = sin( Angle44_g251683 );
					float3 appendResult93_g251683 = (float3(( ( (VertexPos40_g251683).x * CosAngle91_g251683 ) + ( (VertexPos40_g251683).z * SinAngle92_g251683 ) ) , (VertexPos40_g251683).y , ( ( -(VertexPos40_g251683).x * SinAngle92_g251683 ) + ( (VertexPos40_g251683).z * CosAngle91_g251683 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251678 = appendResult93_g251683;
					#else
					float3 staticSwitch65_g251678 = temp_output_1608_0_g251676;
					#endif
					float4 temp_output_1615_31_g251676 = Out_TransformData15_g251685;
					half4 Vertex_TransformData1568_g251676 = temp_output_1615_31_g251676;
					half3 Final_PositionOS178_g251676 = ( ( staticSwitch65_g251678 * (Vertex_TransformData1568_g251676).w ) + (Vertex_TransformData1568_g251676).xyz );
					float3 In_PositionOS16_g251686 = Final_PositionOS178_g251676;
					float3 In_NormalOS16_g251686 = Out_NormalOS15_g251685;
					float4 In_TangentOS16_g251686 = Out_TangentOS15_g251685;
					float4 In_TransformData16_g251686 = temp_output_1615_31_g251676;
					float4 In_RotationData16_g251686 = temp_output_1615_33_g251676;
					float4 In_Interpolator16_g251686 = Out_Interpolator15_g251685;
					BuildVertexData( Data16_g251686 , In_Dummy16_g251686 , In_PositionOS16_g251686 , In_NormalOS16_g251686 , In_TangentOS16_g251686 , In_TransformData16_g251686 , In_RotationData16_g251686 , In_Interpolator16_g251686 );
					TVEVertexData Data15_g251689 =(TVEVertexData)Data16_g251686;
					float Out_Dummy15_g251689 = 0.0;
					float3 Out_PositionOS15_g251689 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251689 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251689 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251689 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251689 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251689 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251689 , Out_Dummy15_g251689 , Out_PositionOS15_g251689 , Out_NormalOS15_g251689 , Out_TangentOS15_g251689 , Out_TransformData15_g251689 , Out_RotationData15_g251689 , Out_Interpolator15_g251689 );
					TVEVertexData Data16_g251690 =(TVEVertexData)Data15_g251689;
					float In_Dummy16_g251690 = 0.0;
					TVEModelData Data15_g251688 =(TVEModelData)Data15_g251672;
					float Out_Dummy15_g251688 = 0.0;
					float3 Out_PositionOS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251688 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251688 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251688 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251688 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251688 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251688 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251688 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251688 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251688 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251688 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251688 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251688 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251688 , Out_Dummy15_g251688 , Out_PositionOS15_g251688 , Out_PositionWS15_g251688 , Out_PositionWO15_g251688 , Out_PositionRawOS15_g251688 , Out_PivotOS15_g251688 , Out_PivotWS15_g251688 , Out_PivotWO15_g251688 , Out_NormalOS15_g251688 , Out_NormalWS15_g251688 , Out_NormalRawOS15_g251688 , Out_TangentOS15_g251688 , Out_TangentWS15_g251688 , Out_BitangentWS15_g251688 , Out_ViewDirWS15_g251688 , Out_CoordsData15_g251688 , Out_VertexData15_g251688 , Out_MasksData15_g251688 , Out_PhaseData15_g251688 , Out_TransformData15_g251688 , Out_RotationData15_g251688 , Out_Interpolator15_g251688 );
					float3 In_PositionOS16_g251690 = ( Out_PositionOS15_g251689 + Out_PivotOS15_g251688 );
					float3 In_NormalOS16_g251690 = Out_NormalOS15_g251689;
					float4 In_TangentOS16_g251690 = Out_TangentOS15_g251689;
					float4 In_TransformData16_g251690 = Out_TransformData15_g251689;
					float4 In_RotationData16_g251690 = Out_RotationData15_g251689;
					float4 In_Interpolator16_g251690 = Out_Interpolator15_g251689;
					BuildVertexData( Data16_g251690 , In_Dummy16_g251690 , In_PositionOS16_g251690 , In_NormalOS16_g251690 , In_TangentOS16_g251690 , In_TransformData16_g251690 , In_RotationData16_g251690 , In_Interpolator16_g251690 );
					TVEVertexData Data15_g252100 =(TVEVertexData)Data16_g251690;
					float Out_Dummy15_g252100 = 0.0;
					float3 Out_PositionOS15_g252100 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252100 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252100 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252100 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252100 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252100 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252100 , Out_Dummy15_g252100 , Out_PositionOS15_g252100 , Out_NormalOS15_g252100 , Out_TangentOS15_g252100 , Out_TransformData15_g252100 , Out_RotationData15_g252100 , Out_Interpolator15_g252100 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g235765;
					o.ase_texcoord5.xyz = vertexToFrag76_g235765;
					TVEVertexData Data1902_g251885 = Data16_g251690;
					float4 Out_Interpolator1902_g251885 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251885 = Data1902_g251885.Interpolator;
					}
					float4 vertexToFrag1901_g251885 = Out_Interpolator1902_g251885;
					o.ase_texcoord7 = vertexToFrag1901_g251885;
					float3 vertexPos57_g252092 = v.vertex.xyz;
					float4 ase_positionCS57_g252092 = UnityObjectToClipPos( vertexPos57_g252092 );
					o.ase_texcoord8 = ase_positionCS57_g252092;
					
					o.ase_texcoord6.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord6.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord5.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252100;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );
					half3 tangentWS = UnityObjectToWorldDir( v.tangent.xyz );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					o.tangentWS = half4( tangentWS, v.tangent.w );

					o.ambientOrLightmapUV = 0;
					#ifdef LIGHTMAP_ON
						o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#elif UNITY_SHOULD_SAMPLE_SH
						#ifdef VERTEXLIGHT_ON
							o.ambientOrLightmapUV.rgb += Shade4PointLights(
								unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
								unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
								unity_4LightAtten0, positionWS, normalWS );
						#endif
							//o.ambientOrLightmapUV.rgb = ShadeSHPerVertex( normalWS, o.ambientOrLightmapUV.rgb );
					#endif
					#ifdef DYNAMICLIGHTMAP_ON
						o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					#endif

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						o.tangentWS.zw = v.texcoord.xy;
						o.tangentWS.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#endif
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half4 tangent : TANGENT;
					half3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;

					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.tangent = v.tangent;
					o.normal = v.normal;
					o.texcoord = v.texcoord;
					o.texcoord1 = v.texcoord1;
					o.texcoord2 = v.texcoord2;
					o.texcoord = v.texcoord;
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
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
					o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				void frag (v2f IN 
					, out half4 outGBuffer0 : SV_Target0
					, out half4 outGBuffer1 : SV_Target1
					, out half4 outGBuffer2 : SV_Target2
					, out half4 outEmission : SV_Target3
					#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					, out half4 outShadowMask : SV_Target4
					#endif
					#if defined( ASE_DEPTH_WRITE_ON )
					, out float outputDepth : SV_Depth
					#endif
				)
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						SurfaceOutput o = (SurfaceOutput)0;
					#else
						#if defined(_SPECULAR_SETUP)
							SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
						#else
							SurfaceOutputStandard o = (SurfaceOutputStandard)0;
						#endif
					#endif

					float3 PositionWS = IN.worldPos.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float temp_output_2682_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2682_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2682_114).xxx;
					
					float3 color130_g252092 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g252092 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g252094 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g252093 = ( temp_cast_4 * ( 0.5 + appendResult128_g252094 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g252093 = (float4(ddx( FinalUV13_g252093 ) , ddy( FinalUV13_g252093 )));
					float4 UVDerivatives17_g252093 = appendResult16_g252093;
					float4 break28_g252093 = UVDerivatives17_g252093;
					float2 appendResult19_g252093 = (float2(break28_g252093.x , break28_g252093.z));
					float2 appendResult20_g252093 = (float2(break28_g252093.x , break28_g252093.z));
					float dotResult24_g252093 = dot( appendResult19_g252093 , appendResult20_g252093 );
					float2 appendResult21_g252093 = (float2(break28_g252093.y , break28_g252093.w));
					float2 appendResult22_g252093 = (float2(break28_g252093.y , break28_g252093.w));
					float dotResult23_g252093 = dot( appendResult21_g252093 , appendResult22_g252093 );
					float2 appendResult25_g252093 = (float2(dotResult24_g252093 , dotResult23_g252093));
					float2 derivativesLength29_g252093 = sqrt( appendResult25_g252093 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g252093 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g252093 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g252093 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g252093 = clampResult57_g252093;
					float2 break55_g252093 = derivativesLength29_g252093;
					float4 lerpResult73_g252093 = lerp( float4( color130_g252092 , 0.0 ) , float4( color81_g252092 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g252093.x * break71_g252093.y * sqrt( saturate( ( 1.1 - max( break55_g252093.x, break55_g252093.y ) ) ) ) ) ) ));
					float3 color107_g252084 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252084 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g252083 = ( 0.0 );
					float localIfMasksData25_g252082 = ( 0.0 );
					TVEMasksData Data25_g252082 = (TVEMasksData)0;
					float localBuildMasksData3_g251944 = ( 0.0 );
					TVEMasksData Data3_g251944 = (TVEMasksData)0;
					half Feature_Intensity1204_g251928 = _SecondIntensityValue;
					float ifLocalVar18_g251945 = 0;
					if( Feature_Intensity1204_g251928 <= 0.0 )
					ifLocalVar18_g251945 = 0.0;
					else
					ifLocalVar18_g251945 = 1.0;
					half Feature_Element1203_g251928 = _SecondCoatMode;
					float ifLocalVar18_g251946 = 0;
					if( Feature_Element1203_g251928 <= 0.0 )
					ifLocalVar18_g251946 = 0.0;
					else
					ifLocalVar18_g251946 = 1.0;
					float4 appendResult1090_g251928 = (float4(ifLocalVar18_g251945 , 0.0 , 0.0 , ifLocalVar18_g251946));
					float4 In_MaskA3_g251944 = appendResult1090_g251928;
					float temp_output_17_0_g251981 = _SecondMaskMode;
					float Option70_g251981 = temp_output_17_0_g251981;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251962) = _SecondMaskTex;
					SamplerState Sampler276_g251962 = sampler_Linear_Repeat;
					float localBreakTextureData456_g251962 = ( 0.0 );
					float localBuildTextureData431_g251976 = ( 0.0 );
					TVEMasksData Data431_g251976 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251976 = ( 0.0 );
					float4 temp_output_6_0_g251933 = _second_mask_coord_value;
					float4 temp_output_7_0_g251933 = ( _SecondMaskSampleMode + _SecondMaskCoordMode + _SecondMaskCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251933 = ( temp_output_6_0_g251933 + temp_output_7_0_g251933 );
					#else
					float4 staticSwitch14_g251933 = temp_output_6_0_g251933;
					#endif
					half4 Local_MaskCoordValue813_g251928 = staticSwitch14_g251933;
					float4 Coords444_g251976 = Local_MaskCoordValue813_g251928;
					TVEModelData Data16_g235773 =(TVEModelData)0;
					float In_Dummy16_g235773 = 0.0;
					float3 vertexToFrag73_g235765 = IN.ase_texcoord4.xyz;
					float3 PositionWS122_g235765 = vertexToFrag73_g235765;
					float3 In_PositionWS16_g235773 = PositionWS122_g235765;
					float3 vertexToFrag76_g235765 = IN.ase_texcoord5.xyz;
					float3 PivotWS121_g235765 = vertexToFrag76_g235765;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g235765 = ( PositionWS122_g235765 - PivotWS121_g235765 );
					#else
					float3 staticSwitch204_g235765 = PositionWS122_g235765;
					#endif
					float3 PositionWO132_g235765 = ( staticSwitch204_g235765 - TVE_WorldOrigin );
					float3 In_PositionWO16_g235773 = PositionWO132_g235765;
					float3 In_PivotWS16_g235773 = PivotWS121_g235765;
					float3 PivotWO133_g235765 = ( PivotWS121_g235765 - TVE_WorldOrigin );
					float3 In_PivotWO16_g235773 = PivotWO133_g235765;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g235765 = normalizedWorldNormal;
					float3 In_NormalWS16_g235773 = NormalWS95_g235765;
					half3 TangentWS136_g235765 = TangentWS;
					float3 In_TangentWS16_g235773 = TangentWS136_g235765;
					half3 BiangentWS421_g235765 = BitangentWS;
					float3 In_BitangentWS16_g235773 = BiangentWS421_g235765;
					half3 NormalWS427_g235765 = NormalWS95_g235765;
					half3 localComputeTriplanarMasks427_g235765 = ComputeTriplanarMasks( NormalWS427_g235765 );
					half3 TriplanarWeights429_g235765 = localComputeTriplanarMasks427_g235765;
					float3 In_TriplanarWeights16_g235773 = TriplanarWeights429_g235765;
					float3 normalizeResult296_g235765 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g235765 ) );
					half3 ViewDirWS169_g235765 = normalizeResult296_g235765;
					float3 In_ViewDirWS16_g235773 = ViewDirWS169_g235765;
					float4 appendResult397_g235765 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g235765 = appendResult397_g235765;
					float4 In_CoordsData16_g235773 = CoordsData398_g235765;
					half4 VertexMasks171_g235765 = IN.ase_color;
					float4 In_VertexData16_g235773 = VertexMasks171_g235765;
					float temp_output_17_0_g235776 = _ObjectPhaseMode;
					float Option70_g235776 = temp_output_17_0_g235776;
					float4 temp_output_3_0_g235776 = IN.ase_color;
					float4 Channel70_g235776 = temp_output_3_0_g235776;
					float localSwitchChannel470_g235776 = SwitchChannel4( Option70_g235776 , Channel70_g235776 );
					half Phase_Value372_g235765 = localSwitchChannel470_g235776;
					float3 break319_g235765 = PivotWO133_g235765;
					half Pivot_Position322_g235765 = ( break319_g235765.x + break319_g235765.z );
					half Phase_Position357_g235765 = ( Phase_Value372_g235765 + Pivot_Position322_g235765 );
					float temp_output_248_0_g235765 = frac( Phase_Position357_g235765 );
					float4 appendResult177_g235765 = (float4((frac( ( Phase_Position357_g235765 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g235765));
					half4 Phase_Data176_g235765 = appendResult177_g235765;
					float4 In_Interpolator16_g235773 = Phase_Data176_g235765;
					BuildModelFragData( Data16_g235773 , In_Dummy16_g235773 , In_PositionWS16_g235773 , In_PositionWO16_g235773 , In_PivotWS16_g235773 , In_PivotWO16_g235773 , In_NormalWS16_g235773 , In_TangentWS16_g235773 , In_BitangentWS16_g235773 , In_TriplanarWeights16_g235773 , In_ViewDirWS16_g235773 , In_CoordsData16_g235773 , In_VertexData16_g235773 , In_Interpolator16_g235773 );
					TVEModelData Data15_g251931 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g251931 = 0.0;
					float3 Out_PositionWS15_g251931 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251931 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251931 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251931 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251931 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251931 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251931 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251931 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251931 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251931 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251931 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251931 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251931 , Out_Dummy15_g251931 , Out_PositionWS15_g251931 , Out_PositionWO15_g251931 , Out_PivotWS15_g251931 , Out_PivotWO15_g251931 , Out_NormalWS15_g251931 , Out_TangentWS15_g251931 , Out_BitangentWS15_g251931 , Out_TriplanarWeights15_g251931 , Out_ViewDirWS15_g251931 , Out_CoordsData15_g251931 , Out_VertexData15_g251931 , Out_Interpolator15_g251931 );
					float4 Model_CoordsData1099_g251928 = Out_CoordsData15_g251931;
					float4 MeshCoords444_g251976 = Model_CoordsData1099_g251928;
					float2 UV0444_g251976 = float2( 0,0 );
					float2 UV3444_g251976 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251976 , MeshCoords444_g251976 , UV0444_g251976 , UV3444_g251976 );
					float4 appendResult430_g251976 = (float4(UV0444_g251976 , UV3444_g251976));
					float4 In_MaskA431_g251976 = appendResult430_g251976;
					float localComputeWorldCoords315_g251976 = ( 0.0 );
					float4 Coords315_g251976 = Local_MaskCoordValue813_g251928;
					float3 Model_PositionWO636_g251928 = Out_PositionWO15_g251931;
					float3 PositionWS315_g251976 = Model_PositionWO636_g251928;
					float2 ZY315_g251976 = float2( 0,0 );
					float2 XZ315_g251976 = float2( 0,0 );
					float2 XY315_g251976 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251976 , PositionWS315_g251976 , ZY315_g251976 , XZ315_g251976 , XY315_g251976 );
					float2 ZY402_g251976 = ZY315_g251976;
					float2 XZ403_g251976 = XZ315_g251976;
					float4 appendResult432_g251976 = (float4(ZY402_g251976 , XZ403_g251976));
					float4 In_MaskB431_g251976 = appendResult432_g251976;
					float2 XY404_g251976 = XY315_g251976;
					float localComputeStochasticCoords409_g251976 = ( 0.0 );
					float2 UV409_g251976 = ZY402_g251976;
					float2 UV1409_g251976 = float2( 0,0 );
					float2 UV2409_g251976 = float2( 0,0 );
					float2 UV3409_g251976 = float2( 0,0 );
					float3 Weights409_g251976 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251976 , UV1409_g251976 , UV2409_g251976 , UV3409_g251976 , Weights409_g251976 );
					float4 appendResult433_g251976 = (float4(XY404_g251976 , UV1409_g251976));
					float4 In_MaskC431_g251976 = appendResult433_g251976;
					float4 appendResult434_g251976 = (float4(UV2409_g251976 , UV3409_g251976));
					float4 In_MaskD431_g251976 = appendResult434_g251976;
					float localComputeStochasticCoords422_g251976 = ( 0.0 );
					float2 UV422_g251976 = XZ403_g251976;
					float2 UV1422_g251976 = float2( 0,0 );
					float2 UV2422_g251976 = float2( 0,0 );
					float2 UV3422_g251976 = float2( 0,0 );
					float3 Weights422_g251976 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251976 , UV1422_g251976 , UV2422_g251976 , UV3422_g251976 , Weights422_g251976 );
					float4 appendResult435_g251976 = (float4(UV1422_g251976 , UV2422_g251976));
					float4 In_MaskE431_g251976 = appendResult435_g251976;
					float localComputeStochasticCoords423_g251976 = ( 0.0 );
					float2 UV423_g251976 = XY404_g251976;
					float2 UV1423_g251976 = float2( 0,0 );
					float2 UV2423_g251976 = float2( 0,0 );
					float2 UV3423_g251976 = float2( 0,0 );
					float3 Weights423_g251976 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251976 , UV1423_g251976 , UV2423_g251976 , UV3423_g251976 , Weights423_g251976 );
					float4 appendResult436_g251976 = (float4(UV3422_g251976 , UV1423_g251976));
					float4 In_MaskF431_g251976 = appendResult436_g251976;
					float4 appendResult437_g251976 = (float4(UV2423_g251976 , UV3423_g251976));
					float4 In_MaskG431_g251976 = appendResult437_g251976;
					float4 In_MaskH431_g251976 = float4( Weights409_g251976 , 0.0 );
					float4 In_MaskI431_g251976 = float4( Weights422_g251976 , 0.0 );
					float4 In_MaskJ431_g251976 = float4( Weights423_g251976 , 0.0 );
					half3 Model_NormalWS869_g251928 = Out_NormalWS15_g251931;
					float3 temp_output_449_0_g251976 = Model_NormalWS869_g251928;
					float4 In_MaskK431_g251976 = float4( temp_output_449_0_g251976 , 0.0 );
					half3 Model_TangentWS1215_g251928 = Out_TangentWS15_g251931;
					float3 temp_output_450_0_g251976 = Model_TangentWS1215_g251928;
					float4 In_MaskL431_g251976 = float4( temp_output_450_0_g251976 , 0.0 );
					half3 Model_BitangentWS1216_g251928 = Out_BitangentWS15_g251931;
					float3 temp_output_451_0_g251976 = Model_BitangentWS1216_g251928;
					float4 In_MaskM431_g251976 = float4( temp_output_451_0_g251976 , 0.0 );
					half3 Model_TriplanarWeights1217_g251928 = Out_TriplanarWeights15_g251931;
					float3 temp_output_445_0_g251976 = Model_TriplanarWeights1217_g251928;
					float4 In_MaskN431_g251976 = float4( temp_output_445_0_g251976 , 0.0 );
					BuildTextureData( Data431_g251976 , In_MaskA431_g251976 , In_MaskB431_g251976 , In_MaskC431_g251976 , In_MaskD431_g251976 , In_MaskE431_g251976 , In_MaskF431_g251976 , In_MaskG431_g251976 , In_MaskH431_g251976 , In_MaskI431_g251976 , In_MaskJ431_g251976 , In_MaskK431_g251976 , In_MaskL431_g251976 , In_MaskM431_g251976 , In_MaskN431_g251976 );
					TVEMasksData Data456_g251962 =(TVEMasksData)Data431_g251976;
					float4 Out_MaskA456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251962 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251962 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251962 , Out_MaskA456_g251962 , Out_MaskB456_g251962 , Out_MaskC456_g251962 , Out_MaskD456_g251962 , Out_MaskE456_g251962 , Out_MaskF456_g251962 , Out_MaskG456_g251962 , Out_MaskH456_g251962 , Out_MaskI456_g251962 , Out_MaskJ456_g251962 , Out_MaskK456_g251962 , Out_MaskL456_g251962 , Out_MaskM456_g251962 , Out_MaskN456_g251962 );
					half2 UV276_g251962 = (Out_MaskA456_g251962).xy;
					float temp_output_504_0_g251962 = 0.0;
					half Bias276_g251962 = temp_output_504_0_g251962;
					half2 Normal276_g251962 = float2( 0,0 );
					half4 localSampleCoord276_g251962 = SampleCoord( Texture276_g251962 , Sampler276_g251962 , UV276_g251962 , Bias276_g251962 , Normal276_g251962 );
					float4 temp_output_868_277_g251928 = localSampleCoord276_g251962;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251962) = _SecondMaskTex;
					SamplerState Sampler502_g251962 = sampler_Linear_Repeat;
					half2 UV502_g251962 = (Out_MaskA456_g251962).zw;
					half Bias502_g251962 = temp_output_504_0_g251962;
					half2 Normal502_g251962 = float2( 0,0 );
					half4 localSampleCoord502_g251962 = SampleCoord( Texture502_g251962 , Sampler502_g251962 , UV502_g251962 , Bias502_g251962 , Normal502_g251962 );
					float4 temp_output_868_278_g251928 = localSampleCoord502_g251962;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251962) = _SecondMaskTex;
					SamplerState Sampler496_g251962 = sampler_Linear_Repeat;
					float2 temp_output_463_0_g251962 = (Out_MaskB456_g251962).zw;
					half2 XZ496_g251962 = temp_output_463_0_g251962;
					half Bias496_g251962 = temp_output_504_0_g251962;
					half3 NormalWS512_g251962 = (Out_MaskK456_g251962).xyz;
					half3 NormalWS496_g251962 = NormalWS512_g251962;
					half3 Normal496_g251962 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251962 = SamplePlanar2D( Texture496_g251962 , Sampler496_g251962 , XZ496_g251962 , Bias496_g251962 , NormalWS496_g251962 , Normal496_g251962 );
					float4 temp_output_868_0_g251928 = localSamplePlanar2D496_g251962;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251962) = _SecondMaskTex;
					SamplerState Sampler490_g251962 = sampler_Linear_Repeat;
					float2 temp_output_462_0_g251962 = (Out_MaskB456_g251962).xy;
					half2 ZY490_g251962 = temp_output_462_0_g251962;
					half2 XZ490_g251962 = temp_output_463_0_g251962;
					float2 temp_output_464_0_g251962 = (Out_MaskC456_g251962).xy;
					half2 XY490_g251962 = temp_output_464_0_g251962;
					half Bias490_g251962 = temp_output_504_0_g251962;
					half3 Triplanar522_g251962 = (Out_MaskN456_g251962).xyz;
					half3 Triplanar490_g251962 = Triplanar522_g251962;
					half3 NormalWS490_g251962 = NormalWS512_g251962;
					half3 Normal490_g251962 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251962 = SamplePlanar3D( Texture490_g251962 , Sampler490_g251962 , ZY490_g251962 , XZ490_g251962 , XY490_g251962 , Bias490_g251962 , Triplanar490_g251962 , NormalWS490_g251962 , Normal490_g251962 );
					float4 temp_output_868_201_g251928 = localSamplePlanar3D490_g251962;
					#if defined( TVE_SECOND_MASK_SAMPLE_MAIN_UV )
					float4 staticSwitch817_g251928 = temp_output_868_277_g251928;
					#elif defined( TVE_SECOND_MASK_SAMPLE_EXTRA_UV )
					float4 staticSwitch817_g251928 = temp_output_868_278_g251928;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_2D )
					float4 staticSwitch817_g251928 = temp_output_868_0_g251928;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_3D )
					float4 staticSwitch817_g251928 = temp_output_868_201_g251928;
					#else
					float4 staticSwitch817_g251928 = temp_output_868_277_g251928;
					#endif
					half4 Local_MaskSample861_g251928 = staticSwitch817_g251928;
					float4 temp_output_3_0_g251981 = Local_MaskSample861_g251928;
					float4 Channel70_g251981 = temp_output_3_0_g251981;
					float localSwitchChannel470_g251981 = SwitchChannel4( Option70_g251981 , Channel70_g251981 );
					float temp_output_1226_0_g251928 = localSwitchChannel470_g251981;
					float temp_output_7_0_g251986 = _SecondMaskRemap.x;
					float temp_output_9_0_g251986 = ( temp_output_1226_0_g251928 - temp_output_7_0_g251986 );
					float lerpResult1015_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251986 * _SecondMaskRemap.z ) ) , _SecondMaskValue);
					#ifdef TVE_SECOND_MASK
					float staticSwitch1088_g251928 = lerpResult1015_g251928;
					#else
					float staticSwitch1088_g251928 = 1.0;
					#endif
					half Blend_TexMask429_g251928 = staticSwitch1088_g251928;
					float localBreakVisualData4_g251949 = ( 0.0 );
					float localBuildVisualData3_g251891 = ( 0.0 );
					float localBuildVisualData3_g251886 = ( 0.0 );
					TVEVisualData Data3_g251886 =(TVEVisualData)0;
					float temp_output_14_0_g251886 = 0.0;
					float In_Dummy3_g251886 = temp_output_14_0_g251886;
					float3 temp_cast_18 = (0.5).xxx;
					float3 temp_output_4_0_g251886 = temp_cast_18;
					float3 In_Albedo3_g251886 = temp_output_4_0_g251886;
					float3 temp_cast_19 = (0.5).xxx;
					float3 temp_output_44_0_g251886 = temp_cast_19;
					float3 In_AlbedoBase3_g251886 = temp_output_44_0_g251886;
					float2 temp_cast_20 = (0.0).xx;
					float2 In_NormalTS3_g251886 = temp_cast_20;
					float3 temp_cast_21 = (0.5).xxx;
					float3 In_NormalWS3_g251886 = temp_cast_21;
					float4 In_Shader3_g251886 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251886 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251886 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251886 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251886 = 0.5;
					float In_Grayscale3_g251886 = temp_output_12_0_g251886;
					float temp_output_16_0_g251886 = 1.0;
					float In_Luminosity3_g251886 = temp_output_16_0_g251886;
					float In_MultiMask3_g251886 = 1.0;
					float In_AlphaClip3_g251886 = 1.0;
					float In_AlphaFade3_g251886 = 1.0;
					float3 temp_cast_22 = (1.0).xxx;
					float3 In_Translucency3_g251886 = temp_cast_22;
					float In_Transmission3_g251886 = 1.0;
					float In_Thickness3_g251886 = 0.0;
					float In_Diffusion3_g251886 = 0.0;
					float In_Depth3_g251886 = 0.0;
					BuildVisualData( Data3_g251886 , In_Dummy3_g251886 , In_Albedo3_g251886 , In_AlbedoBase3_g251886 , In_NormalTS3_g251886 , In_NormalWS3_g251886 , In_Shader3_g251886 , In_Feature3_g251886 , In_Season3_g251886 , In_Emissive3_g251886 , In_Grayscale3_g251886 , In_Luminosity3_g251886 , In_MultiMask3_g251886 , In_AlphaClip3_g251886 , In_AlphaFade3_g251886 , In_Translucency3_g251886 , In_Transmission3_g251886 , In_Thickness3_g251886 , In_Diffusion3_g251886 , In_Depth3_g251886 );
					TVEVisualData Data3_g251891 =(TVEVisualData)Data3_g251886;
					half Dummy130_g251889 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251891 = Dummy130_g251889;
					float In_Dummy3_g251891 = temp_output_14_0_g251891;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251912) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251894 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251894 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251912 = staticSwitch36_g251894;
					float localBreakTextureData456_g251912 = ( 0.0 );
					float localBuildTextureData431_g251911 = ( 0.0 );
					TVEMasksData Data431_g251911 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251911 = ( 0.0 );
					float4 temp_output_6_0_g251927 = _main_coord_value;
					float4 temp_output_7_0_g251927 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251927 = ( temp_output_6_0_g251927 + temp_output_7_0_g251927 );
					#else
					float4 staticSwitch14_g251927 = temp_output_6_0_g251927;
					#endif
					half4 Local_Coords180_g251889 = staticSwitch14_g251927;
					float4 Coords444_g251911 = Local_Coords180_g251889;
					TVEModelData Data15_g251887 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g251887 = 0.0;
					float3 Out_PositionWS15_g251887 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251887 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251887 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251887 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251887 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251887 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251887 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251887 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251887 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251887 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251887 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251887 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251887 , Out_Dummy15_g251887 , Out_PositionWS15_g251887 , Out_PositionWO15_g251887 , Out_PivotWS15_g251887 , Out_PivotWO15_g251887 , Out_NormalWS15_g251887 , Out_TangentWS15_g251887 , Out_BitangentWS15_g251887 , Out_TriplanarWeights15_g251887 , Out_ViewDirWS15_g251887 , Out_CoordsData15_g251887 , Out_VertexData15_g251887 , Out_Interpolator15_g251887 );
					TVEModelData Data16_g251888 =(TVEModelData)Data15_g251887;
					float In_Dummy16_g251888 = Out_Dummy15_g251887;
					float3 In_PositionWS16_g251888 = Out_PositionWS15_g251887;
					float3 In_PositionWO16_g251888 = Out_PositionWO15_g251887;
					float3 In_PivotWS16_g251888 = Out_PivotWS15_g251887;
					float3 In_PivotWO16_g251888 = Out_PivotWO15_g251887;
					float3 In_NormalWS16_g251888 = Out_NormalWS15_g251887;
					float3 In_TangentWS16_g251888 = Out_TangentWS15_g251887;
					float3 In_BitangentWS16_g251888 = Out_BitangentWS15_g251887;
					float3 In_TriplanarWeights16_g251888 = Out_TriplanarWeights15_g251887;
					float3 In_ViewDirWS16_g251888 = Out_ViewDirWS15_g251887;
					float4 In_CoordsData16_g251888 = Out_CoordsData15_g251887;
					float4 In_VertexData16_g251888 = Out_VertexData15_g251887;
					float4 vertexToFrag1901_g251885 = IN.ase_texcoord7;
					float4 In_Interpolator16_g251888 = vertexToFrag1901_g251885;
					BuildModelFragData( Data16_g251888 , In_Dummy16_g251888 , In_PositionWS16_g251888 , In_PositionWO16_g251888 , In_PivotWS16_g251888 , In_PivotWO16_g251888 , In_NormalWS16_g251888 , In_TangentWS16_g251888 , In_BitangentWS16_g251888 , In_TriplanarWeights16_g251888 , In_ViewDirWS16_g251888 , In_CoordsData16_g251888 , In_VertexData16_g251888 , In_Interpolator16_g251888 );
					TVEModelData Data15_g251890 =(TVEModelData)Data16_g251888;
					float Out_Dummy15_g251890 = 0.0;
					float3 Out_PositionWS15_g251890 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251890 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251890 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251890 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251890 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251890 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251890 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251890 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251890 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251890 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251890 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251890 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251890 , Out_Dummy15_g251890 , Out_PositionWS15_g251890 , Out_PositionWO15_g251890 , Out_PivotWS15_g251890 , Out_PivotWO15_g251890 , Out_NormalWS15_g251890 , Out_TangentWS15_g251890 , Out_BitangentWS15_g251890 , Out_TriplanarWeights15_g251890 , Out_ViewDirWS15_g251890 , Out_CoordsData15_g251890 , Out_VertexData15_g251890 , Out_Interpolator15_g251890 );
					float4 Model_CoordsData324_g251889 = Out_CoordsData15_g251890;
					float4 MeshCoords444_g251911 = Model_CoordsData324_g251889;
					float2 UV0444_g251911 = float2( 0,0 );
					float2 UV3444_g251911 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251911 , MeshCoords444_g251911 , UV0444_g251911 , UV3444_g251911 );
					float4 appendResult430_g251911 = (float4(UV0444_g251911 , UV3444_g251911));
					float4 In_MaskA431_g251911 = appendResult430_g251911;
					float localComputeWorldCoords315_g251911 = ( 0.0 );
					float4 Coords315_g251911 = Local_Coords180_g251889;
					float3 Model_PositionWO222_g251889 = Out_PositionWO15_g251890;
					float3 PositionWS315_g251911 = Model_PositionWO222_g251889;
					float2 ZY315_g251911 = float2( 0,0 );
					float2 XZ315_g251911 = float2( 0,0 );
					float2 XY315_g251911 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251911 , PositionWS315_g251911 , ZY315_g251911 , XZ315_g251911 , XY315_g251911 );
					float2 ZY402_g251911 = ZY315_g251911;
					float2 XZ403_g251911 = XZ315_g251911;
					float4 appendResult432_g251911 = (float4(ZY402_g251911 , XZ403_g251911));
					float4 In_MaskB431_g251911 = appendResult432_g251911;
					float2 XY404_g251911 = XY315_g251911;
					float localComputeStochasticCoords409_g251911 = ( 0.0 );
					float2 UV409_g251911 = ZY402_g251911;
					float2 UV1409_g251911 = float2( 0,0 );
					float2 UV2409_g251911 = float2( 0,0 );
					float2 UV3409_g251911 = float2( 0,0 );
					float3 Weights409_g251911 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251911 , UV1409_g251911 , UV2409_g251911 , UV3409_g251911 , Weights409_g251911 );
					float4 appendResult433_g251911 = (float4(XY404_g251911 , UV1409_g251911));
					float4 In_MaskC431_g251911 = appendResult433_g251911;
					float4 appendResult434_g251911 = (float4(UV2409_g251911 , UV3409_g251911));
					float4 In_MaskD431_g251911 = appendResult434_g251911;
					float localComputeStochasticCoords422_g251911 = ( 0.0 );
					float2 UV422_g251911 = XZ403_g251911;
					float2 UV1422_g251911 = float2( 0,0 );
					float2 UV2422_g251911 = float2( 0,0 );
					float2 UV3422_g251911 = float2( 0,0 );
					float3 Weights422_g251911 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251911 , UV1422_g251911 , UV2422_g251911 , UV3422_g251911 , Weights422_g251911 );
					float4 appendResult435_g251911 = (float4(UV1422_g251911 , UV2422_g251911));
					float4 In_MaskE431_g251911 = appendResult435_g251911;
					float localComputeStochasticCoords423_g251911 = ( 0.0 );
					float2 UV423_g251911 = XY404_g251911;
					float2 UV1423_g251911 = float2( 0,0 );
					float2 UV2423_g251911 = float2( 0,0 );
					float2 UV3423_g251911 = float2( 0,0 );
					float3 Weights423_g251911 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251911 , UV1423_g251911 , UV2423_g251911 , UV3423_g251911 , Weights423_g251911 );
					float4 appendResult436_g251911 = (float4(UV3422_g251911 , UV1423_g251911));
					float4 In_MaskF431_g251911 = appendResult436_g251911;
					float4 appendResult437_g251911 = (float4(UV2423_g251911 , UV3423_g251911));
					float4 In_MaskG431_g251911 = appendResult437_g251911;
					float4 In_MaskH431_g251911 = float4( Weights409_g251911 , 0.0 );
					float4 In_MaskI431_g251911 = float4( Weights422_g251911 , 0.0 );
					float4 In_MaskJ431_g251911 = float4( Weights423_g251911 , 0.0 );
					half3 Model_NormalWS226_g251889 = Out_NormalWS15_g251890;
					float3 temp_output_449_0_g251911 = Model_NormalWS226_g251889;
					float4 In_MaskK431_g251911 = float4( temp_output_449_0_g251911 , 0.0 );
					half3 Model_TangentWS366_g251889 = Out_TangentWS15_g251890;
					float3 temp_output_450_0_g251911 = Model_TangentWS366_g251889;
					float4 In_MaskL431_g251911 = float4( temp_output_450_0_g251911 , 0.0 );
					half3 Model_BitangentWS367_g251889 = Out_BitangentWS15_g251890;
					float3 temp_output_451_0_g251911 = Model_BitangentWS367_g251889;
					float4 In_MaskM431_g251911 = float4( temp_output_451_0_g251911 , 0.0 );
					half3 Model_TriplanarWeights368_g251889 = Out_TriplanarWeights15_g251890;
					float3 temp_output_445_0_g251911 = Model_TriplanarWeights368_g251889;
					float4 In_MaskN431_g251911 = float4( temp_output_445_0_g251911 , 0.0 );
					BuildTextureData( Data431_g251911 , In_MaskA431_g251911 , In_MaskB431_g251911 , In_MaskC431_g251911 , In_MaskD431_g251911 , In_MaskE431_g251911 , In_MaskF431_g251911 , In_MaskG431_g251911 , In_MaskH431_g251911 , In_MaskI431_g251911 , In_MaskJ431_g251911 , In_MaskK431_g251911 , In_MaskL431_g251911 , In_MaskM431_g251911 , In_MaskN431_g251911 );
					TVEMasksData Data456_g251912 =(TVEMasksData)Data431_g251911;
					float4 Out_MaskA456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251912 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251912 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251912 , Out_MaskA456_g251912 , Out_MaskB456_g251912 , Out_MaskC456_g251912 , Out_MaskD456_g251912 , Out_MaskE456_g251912 , Out_MaskF456_g251912 , Out_MaskG456_g251912 , Out_MaskH456_g251912 , Out_MaskI456_g251912 , Out_MaskJ456_g251912 , Out_MaskK456_g251912 , Out_MaskL456_g251912 , Out_MaskM456_g251912 , Out_MaskN456_g251912 );
					half2 UV276_g251912 = (Out_MaskA456_g251912).xy;
					float temp_output_504_0_g251912 = 0.0;
					half Bias276_g251912 = temp_output_504_0_g251912;
					half2 Normal276_g251912 = float2( 0,0 );
					half4 localSampleCoord276_g251912 = SampleCoord( Texture276_g251912 , Sampler276_g251912 , UV276_g251912 , Bias276_g251912 , Normal276_g251912 );
					float4 temp_output_407_277_g251889 = localSampleCoord276_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251912) = _MainAlbedoTex;
					SamplerState Sampler502_g251912 = staticSwitch36_g251894;
					half2 UV502_g251912 = (Out_MaskA456_g251912).zw;
					half Bias502_g251912 = temp_output_504_0_g251912;
					half2 Normal502_g251912 = float2( 0,0 );
					half4 localSampleCoord502_g251912 = SampleCoord( Texture502_g251912 , Sampler502_g251912 , UV502_g251912 , Bias502_g251912 , Normal502_g251912 );
					float4 temp_output_407_278_g251889 = localSampleCoord502_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251912) = _MainAlbedoTex;
					SamplerState Sampler496_g251912 = staticSwitch36_g251894;
					float2 temp_output_463_0_g251912 = (Out_MaskB456_g251912).zw;
					half2 XZ496_g251912 = temp_output_463_0_g251912;
					half Bias496_g251912 = temp_output_504_0_g251912;
					half3 NormalWS512_g251912 = (Out_MaskK456_g251912).xyz;
					half3 NormalWS496_g251912 = NormalWS512_g251912;
					half3 Normal496_g251912 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251912 = SamplePlanar2D( Texture496_g251912 , Sampler496_g251912 , XZ496_g251912 , Bias496_g251912 , NormalWS496_g251912 , Normal496_g251912 );
					float4 temp_output_407_0_g251889 = localSamplePlanar2D496_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251912) = _MainAlbedoTex;
					SamplerState Sampler490_g251912 = staticSwitch36_g251894;
					float2 temp_output_462_0_g251912 = (Out_MaskB456_g251912).xy;
					half2 ZY490_g251912 = temp_output_462_0_g251912;
					half2 XZ490_g251912 = temp_output_463_0_g251912;
					float2 temp_output_464_0_g251912 = (Out_MaskC456_g251912).xy;
					half2 XY490_g251912 = temp_output_464_0_g251912;
					half Bias490_g251912 = temp_output_504_0_g251912;
					half3 Triplanar522_g251912 = (Out_MaskN456_g251912).xyz;
					half3 Triplanar490_g251912 = Triplanar522_g251912;
					half3 NormalWS490_g251912 = NormalWS512_g251912;
					half3 Normal490_g251912 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251912 = SamplePlanar3D( Texture490_g251912 , Sampler490_g251912 , ZY490_g251912 , XZ490_g251912 , XY490_g251912 , Bias490_g251912 , Triplanar490_g251912 , NormalWS490_g251912 , Normal490_g251912 );
					float4 temp_output_407_201_g251889 = localSamplePlanar3D490_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251912) = _MainAlbedoTex;
					SamplerState Sampler498_g251912 = staticSwitch36_g251894;
					half2 XZ498_g251912 = temp_output_463_0_g251912;
					float2 temp_output_473_0_g251912 = (Out_MaskE456_g251912).xy;
					half2 XZ_1498_g251912 = temp_output_473_0_g251912;
					float2 temp_output_474_0_g251912 = (Out_MaskE456_g251912).zw;
					half2 XZ_2498_g251912 = temp_output_474_0_g251912;
					float2 temp_output_475_0_g251912 = (Out_MaskF456_g251912).xy;
					half2 XZ_3498_g251912 = temp_output_475_0_g251912;
					float temp_output_510_0_g251912 = exp2( temp_output_504_0_g251912 );
					half Bias498_g251912 = temp_output_510_0_g251912;
					float3 temp_output_480_0_g251912 = (Out_MaskI456_g251912).xyz;
					half3 Weights_2498_g251912 = temp_output_480_0_g251912;
					half3 NormalWS498_g251912 = NormalWS512_g251912;
					half3 Normal498_g251912 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251912 = SampleStochastic2D( Texture498_g251912 , Sampler498_g251912 , XZ498_g251912 , XZ_1498_g251912 , XZ_2498_g251912 , XZ_3498_g251912 , Bias498_g251912 , Weights_2498_g251912 , NormalWS498_g251912 , Normal498_g251912 );
					float4 temp_output_407_202_g251889 = localSampleStochastic2D498_g251912;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251912) = _MainAlbedoTex;
					SamplerState Sampler500_g251912 = staticSwitch36_g251894;
					half2 ZY500_g251912 = temp_output_462_0_g251912;
					half2 ZY_1500_g251912 = (Out_MaskC456_g251912).zw;
					half2 ZY_2500_g251912 = (Out_MaskD456_g251912).xy;
					half2 ZY_3500_g251912 = (Out_MaskD456_g251912).zw;
					half2 XZ500_g251912 = temp_output_463_0_g251912;
					half2 XZ_1500_g251912 = temp_output_473_0_g251912;
					half2 XZ_2500_g251912 = temp_output_474_0_g251912;
					half2 XZ_3500_g251912 = temp_output_475_0_g251912;
					half2 XY500_g251912 = temp_output_464_0_g251912;
					half2 XY_1500_g251912 = (Out_MaskF456_g251912).zw;
					half2 XY_2500_g251912 = (Out_MaskG456_g251912).xy;
					half2 XY_3500_g251912 = (Out_MaskG456_g251912).zw;
					half Bias500_g251912 = temp_output_510_0_g251912;
					half3 Weights_1500_g251912 = (Out_MaskH456_g251912).xyz;
					half3 Weights_2500_g251912 = temp_output_480_0_g251912;
					half3 Weights_3500_g251912 = (Out_MaskJ456_g251912).xyz;
					half3 Triplanar500_g251912 = Triplanar522_g251912;
					half3 NormalWS500_g251912 = NormalWS512_g251912;
					half3 Normal500_g251912 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251912 = SampleStochastic3D( Texture500_g251912 , Sampler500_g251912 , ZY500_g251912 , ZY_1500_g251912 , ZY_2500_g251912 , ZY_3500_g251912 , XZ500_g251912 , XZ_1500_g251912 , XZ_2500_g251912 , XZ_3500_g251912 , XY500_g251912 , XY_1500_g251912 , XY_2500_g251912 , XY_3500_g251912 , Bias500_g251912 , Weights_1500_g251912 , Weights_2500_g251912 , Weights_3500_g251912 , Triplanar500_g251912 , NormalWS500_g251912 , Normal500_g251912 );
					float4 temp_output_407_203_g251889 = localSampleStochastic3D500_g251912;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251889 = temp_output_407_277_g251889;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251889 = temp_output_407_278_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251889 = temp_output_407_0_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251889 = temp_output_407_201_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251889 = temp_output_407_202_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251889 = temp_output_407_203_g251889;
					#else
					float4 staticSwitch184_g251889 = temp_output_407_277_g251889;
					#endif
					half4 Local_AlbedoSample185_g251889 = staticSwitch184_g251889;
					float3 lerpResult53_g251889 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251889).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251889 = lerpResult53_g251889;
					float temp_output_17_0_g251909 = _MainMultiWriteMode;
					float Option91_g251909 = temp_output_17_0_g251909;
					float4 Model_VertexData418_g251889 = Out_VertexData15_g251890;
					float4 temp_output_84_0_g251909 = Model_VertexData418_g251889;
					float4 ChannelA91_g251909 = temp_output_84_0_g251909;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251897) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251896 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251896 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251897 = staticSwitch38_g251896;
					float localBreakTextureData456_g251897 = ( 0.0 );
					TVEMasksData Data456_g251897 =(TVEMasksData)Data431_g251911;
					float4 Out_MaskA456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251897 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251897 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251897 , Out_MaskA456_g251897 , Out_MaskB456_g251897 , Out_MaskC456_g251897 , Out_MaskD456_g251897 , Out_MaskE456_g251897 , Out_MaskF456_g251897 , Out_MaskG456_g251897 , Out_MaskH456_g251897 , Out_MaskI456_g251897 , Out_MaskJ456_g251897 , Out_MaskK456_g251897 , Out_MaskL456_g251897 , Out_MaskM456_g251897 , Out_MaskN456_g251897 );
					half2 UV276_g251897 = (Out_MaskA456_g251897).xy;
					float temp_output_504_0_g251897 = 0.0;
					half Bias276_g251897 = temp_output_504_0_g251897;
					half2 Normal276_g251897 = float2( 0,0 );
					half4 localSampleCoord276_g251897 = SampleCoord( Texture276_g251897 , Sampler276_g251897 , UV276_g251897 , Bias276_g251897 , Normal276_g251897 );
					float4 temp_output_405_277_g251889 = localSampleCoord276_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251897) = _MainShaderTex;
					SamplerState Sampler502_g251897 = staticSwitch38_g251896;
					half2 UV502_g251897 = (Out_MaskA456_g251897).zw;
					half Bias502_g251897 = temp_output_504_0_g251897;
					half2 Normal502_g251897 = float2( 0,0 );
					half4 localSampleCoord502_g251897 = SampleCoord( Texture502_g251897 , Sampler502_g251897 , UV502_g251897 , Bias502_g251897 , Normal502_g251897 );
					float4 temp_output_405_278_g251889 = localSampleCoord502_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251897) = _MainShaderTex;
					SamplerState Sampler496_g251897 = staticSwitch38_g251896;
					float2 temp_output_463_0_g251897 = (Out_MaskB456_g251897).zw;
					half2 XZ496_g251897 = temp_output_463_0_g251897;
					half Bias496_g251897 = temp_output_504_0_g251897;
					half3 NormalWS512_g251897 = (Out_MaskK456_g251897).xyz;
					half3 NormalWS496_g251897 = NormalWS512_g251897;
					half3 Normal496_g251897 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251897 = SamplePlanar2D( Texture496_g251897 , Sampler496_g251897 , XZ496_g251897 , Bias496_g251897 , NormalWS496_g251897 , Normal496_g251897 );
					float4 temp_output_405_0_g251889 = localSamplePlanar2D496_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251897) = _MainShaderTex;
					SamplerState Sampler490_g251897 = staticSwitch38_g251896;
					float2 temp_output_462_0_g251897 = (Out_MaskB456_g251897).xy;
					half2 ZY490_g251897 = temp_output_462_0_g251897;
					half2 XZ490_g251897 = temp_output_463_0_g251897;
					float2 temp_output_464_0_g251897 = (Out_MaskC456_g251897).xy;
					half2 XY490_g251897 = temp_output_464_0_g251897;
					half Bias490_g251897 = temp_output_504_0_g251897;
					half3 Triplanar522_g251897 = (Out_MaskN456_g251897).xyz;
					half3 Triplanar490_g251897 = Triplanar522_g251897;
					half3 NormalWS490_g251897 = NormalWS512_g251897;
					half3 Normal490_g251897 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251897 = SamplePlanar3D( Texture490_g251897 , Sampler490_g251897 , ZY490_g251897 , XZ490_g251897 , XY490_g251897 , Bias490_g251897 , Triplanar490_g251897 , NormalWS490_g251897 , Normal490_g251897 );
					float4 temp_output_405_201_g251889 = localSamplePlanar3D490_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251897) = _MainShaderTex;
					SamplerState Sampler498_g251897 = staticSwitch38_g251896;
					half2 XZ498_g251897 = temp_output_463_0_g251897;
					float2 temp_output_473_0_g251897 = (Out_MaskE456_g251897).xy;
					half2 XZ_1498_g251897 = temp_output_473_0_g251897;
					float2 temp_output_474_0_g251897 = (Out_MaskE456_g251897).zw;
					half2 XZ_2498_g251897 = temp_output_474_0_g251897;
					float2 temp_output_475_0_g251897 = (Out_MaskF456_g251897).xy;
					half2 XZ_3498_g251897 = temp_output_475_0_g251897;
					float temp_output_510_0_g251897 = exp2( temp_output_504_0_g251897 );
					half Bias498_g251897 = temp_output_510_0_g251897;
					float3 temp_output_480_0_g251897 = (Out_MaskI456_g251897).xyz;
					half3 Weights_2498_g251897 = temp_output_480_0_g251897;
					half3 NormalWS498_g251897 = NormalWS512_g251897;
					half3 Normal498_g251897 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251897 = SampleStochastic2D( Texture498_g251897 , Sampler498_g251897 , XZ498_g251897 , XZ_1498_g251897 , XZ_2498_g251897 , XZ_3498_g251897 , Bias498_g251897 , Weights_2498_g251897 , NormalWS498_g251897 , Normal498_g251897 );
					float4 temp_output_405_202_g251889 = localSampleStochastic2D498_g251897;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251897) = _MainShaderTex;
					SamplerState Sampler500_g251897 = staticSwitch38_g251896;
					half2 ZY500_g251897 = temp_output_462_0_g251897;
					half2 ZY_1500_g251897 = (Out_MaskC456_g251897).zw;
					half2 ZY_2500_g251897 = (Out_MaskD456_g251897).xy;
					half2 ZY_3500_g251897 = (Out_MaskD456_g251897).zw;
					half2 XZ500_g251897 = temp_output_463_0_g251897;
					half2 XZ_1500_g251897 = temp_output_473_0_g251897;
					half2 XZ_2500_g251897 = temp_output_474_0_g251897;
					half2 XZ_3500_g251897 = temp_output_475_0_g251897;
					half2 XY500_g251897 = temp_output_464_0_g251897;
					half2 XY_1500_g251897 = (Out_MaskF456_g251897).zw;
					half2 XY_2500_g251897 = (Out_MaskG456_g251897).xy;
					half2 XY_3500_g251897 = (Out_MaskG456_g251897).zw;
					half Bias500_g251897 = temp_output_510_0_g251897;
					half3 Weights_1500_g251897 = (Out_MaskH456_g251897).xyz;
					half3 Weights_2500_g251897 = temp_output_480_0_g251897;
					half3 Weights_3500_g251897 = (Out_MaskJ456_g251897).xyz;
					half3 Triplanar500_g251897 = Triplanar522_g251897;
					half3 NormalWS500_g251897 = NormalWS512_g251897;
					half3 Normal500_g251897 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251897 = SampleStochastic3D( Texture500_g251897 , Sampler500_g251897 , ZY500_g251897 , ZY_1500_g251897 , ZY_2500_g251897 , ZY_3500_g251897 , XZ500_g251897 , XZ_1500_g251897 , XZ_2500_g251897 , XZ_3500_g251897 , XY500_g251897 , XY_1500_g251897 , XY_2500_g251897 , XY_3500_g251897 , Bias500_g251897 , Weights_1500_g251897 , Weights_2500_g251897 , Weights_3500_g251897 , Triplanar500_g251897 , NormalWS500_g251897 , Normal500_g251897 );
					float4 temp_output_405_203_g251889 = localSampleStochastic3D500_g251897;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251889 = temp_output_405_277_g251889;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251889 = temp_output_405_278_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251889 = temp_output_405_0_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251889 = temp_output_405_201_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251889 = temp_output_405_202_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251889 = temp_output_405_203_g251889;
					#else
					float4 staticSwitch198_g251889 = temp_output_405_277_g251889;
					#endif
					half4 Local_ShaderSample199_g251889 = staticSwitch198_g251889;
					float2 appendResult428_g251889 = (float2((Local_AlbedoSample185_g251889).w , (Local_ShaderSample199_g251889).z));
					float2 temp_output_85_0_g251909 = appendResult428_g251889;
					float4 ChannelB91_g251909 = float4( temp_output_85_0_g251909, 0.0 , 0.0 );
					float localSwitchChannel691_g251909 = SwitchChannel6( Option91_g251909 , ChannelA91_g251909 , ChannelB91_g251909 );
					float clampResult17_g251907 = clamp( localSwitchChannel691_g251909 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251908 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251908 = ( clampResult17_g251907 - temp_output_7_0_g251908 );
					half Local_MultiMask78_g251889 = saturate( ( temp_output_9_0_g251908 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251889 = lerp( 1.0 , Local_MultiMask78_g251889 , _MainColorMode);
					float4 lerpResult62_g251889 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251889);
					half3 Local_ColorRGB93_g251889 = (lerpResult62_g251889).rgb;
					half3 Local_Albedo139_g251889 = ( Local_AlbedoRGB107_g251889 * Local_ColorRGB93_g251889 );
					float3 temp_output_4_0_g251891 = Local_Albedo139_g251889;
					float3 In_Albedo3_g251891 = temp_output_4_0_g251891;
					float3 temp_output_44_0_g251891 = Local_Albedo139_g251889;
					float3 In_AlbedoBase3_g251891 = temp_output_44_0_g251891;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251918) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251895 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251895 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251918 = staticSwitch37_g251895;
					float localBreakTextureData456_g251918 = ( 0.0 );
					TVEMasksData Data456_g251918 =(TVEMasksData)Data431_g251911;
					float4 Out_MaskA456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251918 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251918 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251918 , Out_MaskA456_g251918 , Out_MaskB456_g251918 , Out_MaskC456_g251918 , Out_MaskD456_g251918 , Out_MaskE456_g251918 , Out_MaskF456_g251918 , Out_MaskG456_g251918 , Out_MaskH456_g251918 , Out_MaskI456_g251918 , Out_MaskJ456_g251918 , Out_MaskK456_g251918 , Out_MaskL456_g251918 , Out_MaskM456_g251918 , Out_MaskN456_g251918 );
					half2 UV276_g251918 = (Out_MaskA456_g251918).xy;
					float temp_output_504_0_g251918 = 0.0;
					half Bias276_g251918 = temp_output_504_0_g251918;
					half2 Normal276_g251918 = float2( 0,0 );
					half4 localSampleCoord276_g251918 = SampleCoord( Texture276_g251918 , Sampler276_g251918 , UV276_g251918 , Bias276_g251918 , Normal276_g251918 );
					float2 temp_output_406_394_g251889 = Normal276_g251918;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251918) = _MainNormalTex;
					SamplerState Sampler502_g251918 = staticSwitch37_g251895;
					half2 UV502_g251918 = (Out_MaskA456_g251918).zw;
					half Bias502_g251918 = temp_output_504_0_g251918;
					half2 Normal502_g251918 = float2( 0,0 );
					half4 localSampleCoord502_g251918 = SampleCoord( Texture502_g251918 , Sampler502_g251918 , UV502_g251918 , Bias502_g251918 , Normal502_g251918 );
					float2 temp_output_406_397_g251889 = Normal502_g251918;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251918) = _MainNormalTex;
					SamplerState Sampler496_g251918 = staticSwitch37_g251895;
					float2 temp_output_463_0_g251918 = (Out_MaskB456_g251918).zw;
					half2 XZ496_g251918 = temp_output_463_0_g251918;
					half Bias496_g251918 = temp_output_504_0_g251918;
					half3 NormalWS512_g251918 = (Out_MaskK456_g251918).xyz;
					half3 NormalWS496_g251918 = NormalWS512_g251918;
					half3 Normal496_g251918 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251918 = SamplePlanar2D( Texture496_g251918 , Sampler496_g251918 , XZ496_g251918 , Bias496_g251918 , NormalWS496_g251918 , Normal496_g251918 );
					float3 temp_output_35_0_g251921 = Normal496_g251918;
					half3 TangentWS519_g251918 = (Out_MaskL456_g251918).xyz;
					float dotResult84_g251921 = dot( temp_output_35_0_g251921 , TangentWS519_g251918 );
					half3 BitangentWS521_g251918 = (Out_MaskM456_g251918).xyz;
					float dotResult85_g251921 = dot( temp_output_35_0_g251921 , BitangentWS521_g251918 );
					float2 appendResult87_g251921 = (float2(dotResult84_g251921 , dotResult85_g251921));
					float2 temp_output_406_375_g251889 = appendResult87_g251921;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251918) = _MainNormalTex;
					SamplerState Sampler490_g251918 = staticSwitch37_g251895;
					float2 temp_output_462_0_g251918 = (Out_MaskB456_g251918).xy;
					half2 ZY490_g251918 = temp_output_462_0_g251918;
					half2 XZ490_g251918 = temp_output_463_0_g251918;
					float2 temp_output_464_0_g251918 = (Out_MaskC456_g251918).xy;
					half2 XY490_g251918 = temp_output_464_0_g251918;
					half Bias490_g251918 = temp_output_504_0_g251918;
					half3 Triplanar522_g251918 = (Out_MaskN456_g251918).xyz;
					half3 Triplanar490_g251918 = Triplanar522_g251918;
					half3 NormalWS490_g251918 = NormalWS512_g251918;
					half3 Normal490_g251918 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251918 = SamplePlanar3D( Texture490_g251918 , Sampler490_g251918 , ZY490_g251918 , XZ490_g251918 , XY490_g251918 , Bias490_g251918 , Triplanar490_g251918 , NormalWS490_g251918 , Normal490_g251918 );
					float3 temp_output_35_0_g251922 = Normal490_g251918;
					float dotResult84_g251922 = dot( temp_output_35_0_g251922 , TangentWS519_g251918 );
					float dotResult85_g251922 = dot( temp_output_35_0_g251922 , BitangentWS521_g251918 );
					float2 appendResult87_g251922 = (float2(dotResult84_g251922 , dotResult85_g251922));
					float2 temp_output_406_353_g251889 = appendResult87_g251922;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251918) = _MainNormalTex;
					SamplerState Sampler498_g251918 = staticSwitch37_g251895;
					half2 XZ498_g251918 = temp_output_463_0_g251918;
					float2 temp_output_473_0_g251918 = (Out_MaskE456_g251918).xy;
					half2 XZ_1498_g251918 = temp_output_473_0_g251918;
					float2 temp_output_474_0_g251918 = (Out_MaskE456_g251918).zw;
					half2 XZ_2498_g251918 = temp_output_474_0_g251918;
					float2 temp_output_475_0_g251918 = (Out_MaskF456_g251918).xy;
					half2 XZ_3498_g251918 = temp_output_475_0_g251918;
					float temp_output_510_0_g251918 = exp2( temp_output_504_0_g251918 );
					half Bias498_g251918 = temp_output_510_0_g251918;
					float3 temp_output_480_0_g251918 = (Out_MaskI456_g251918).xyz;
					half3 Weights_2498_g251918 = temp_output_480_0_g251918;
					half3 NormalWS498_g251918 = NormalWS512_g251918;
					half3 Normal498_g251918 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251918 = SampleStochastic2D( Texture498_g251918 , Sampler498_g251918 , XZ498_g251918 , XZ_1498_g251918 , XZ_2498_g251918 , XZ_3498_g251918 , Bias498_g251918 , Weights_2498_g251918 , NormalWS498_g251918 , Normal498_g251918 );
					float3 temp_output_35_0_g251923 = Normal498_g251918;
					float dotResult84_g251923 = dot( temp_output_35_0_g251923 , TangentWS519_g251918 );
					float dotResult85_g251923 = dot( temp_output_35_0_g251923 , BitangentWS521_g251918 );
					float2 appendResult87_g251923 = (float2(dotResult84_g251923 , dotResult85_g251923));
					float2 temp_output_406_391_g251889 = appendResult87_g251923;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251918) = _MainNormalTex;
					SamplerState Sampler500_g251918 = staticSwitch37_g251895;
					half2 ZY500_g251918 = temp_output_462_0_g251918;
					half2 ZY_1500_g251918 = (Out_MaskC456_g251918).zw;
					half2 ZY_2500_g251918 = (Out_MaskD456_g251918).xy;
					half2 ZY_3500_g251918 = (Out_MaskD456_g251918).zw;
					half2 XZ500_g251918 = temp_output_463_0_g251918;
					half2 XZ_1500_g251918 = temp_output_473_0_g251918;
					half2 XZ_2500_g251918 = temp_output_474_0_g251918;
					half2 XZ_3500_g251918 = temp_output_475_0_g251918;
					half2 XY500_g251918 = temp_output_464_0_g251918;
					half2 XY_1500_g251918 = (Out_MaskF456_g251918).zw;
					half2 XY_2500_g251918 = (Out_MaskG456_g251918).xy;
					half2 XY_3500_g251918 = (Out_MaskG456_g251918).zw;
					half Bias500_g251918 = temp_output_510_0_g251918;
					half3 Weights_1500_g251918 = (Out_MaskH456_g251918).xyz;
					half3 Weights_2500_g251918 = temp_output_480_0_g251918;
					half3 Weights_3500_g251918 = (Out_MaskJ456_g251918).xyz;
					half3 Triplanar500_g251918 = Triplanar522_g251918;
					half3 NormalWS500_g251918 = NormalWS512_g251918;
					half3 Normal500_g251918 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251918 = SampleStochastic3D( Texture500_g251918 , Sampler500_g251918 , ZY500_g251918 , ZY_1500_g251918 , ZY_2500_g251918 , ZY_3500_g251918 , XZ500_g251918 , XZ_1500_g251918 , XZ_2500_g251918 , XZ_3500_g251918 , XY500_g251918 , XY_1500_g251918 , XY_2500_g251918 , XY_3500_g251918 , Bias500_g251918 , Weights_1500_g251918 , Weights_2500_g251918 , Weights_3500_g251918 , Triplanar500_g251918 , NormalWS500_g251918 , Normal500_g251918 );
					float3 temp_output_35_0_g251919 = Normal500_g251918;
					float dotResult84_g251919 = dot( temp_output_35_0_g251919 , TangentWS519_g251918 );
					float dotResult85_g251919 = dot( temp_output_35_0_g251919 , BitangentWS521_g251918 );
					float2 appendResult87_g251919 = (float2(dotResult84_g251919 , dotResult85_g251919));
					float2 temp_output_406_390_g251889 = appendResult87_g251919;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251889 = temp_output_406_394_g251889;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251889 = temp_output_406_397_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251889 = temp_output_406_375_g251889;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251889 = temp_output_406_353_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251889 = temp_output_406_391_g251889;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251889 = temp_output_406_390_g251889;
					#else
					float2 staticSwitch193_g251889 = temp_output_406_394_g251889;
					#endif
					half2 Local_NormaSample191_g251889 = staticSwitch193_g251889;
					half2 Local_NormalTS108_g251889 = ( Local_NormaSample191_g251889 * _MainNormalValue );
					float2 In_NormalTS3_g251891 = Local_NormalTS108_g251889;
					float2 break80_g251910 = Local_NormalTS108_g251889;
					float3 temp_output_77_0_g251910 = Model_TangentWS366_g251889;
					float3 temp_output_78_0_g251910 = Model_BitangentWS367_g251889;
					float3 temp_output_76_0_g251910 = Model_NormalWS226_g251889;
					half3 Local_NormalWS250_g251889 = ( ( break80_g251910.x * temp_output_77_0_g251910 ) + ( break80_g251910.y * temp_output_78_0_g251910 ) + temp_output_76_0_g251910 );
					float3 In_NormalWS3_g251891 = Local_NormalWS250_g251889;
					float temp_output_209_0_g251889 = (Local_ShaderSample199_g251889).y;
					float temp_output_7_0_g251903 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251903 = ( temp_output_209_0_g251889 - temp_output_7_0_g251903 );
					float lerpResult23_g251889 = lerp( 1.0 , saturate( ( temp_output_9_0_g251903 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251889 = lerpResult23_g251889;
					float temp_output_213_0_g251889 = (Local_ShaderSample199_g251889).w;
					float temp_output_7_0_g251906 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251906 = ( temp_output_213_0_g251889 - temp_output_7_0_g251906 );
					half Local_Smoothness317_g251889 = ( saturate( ( temp_output_9_0_g251906 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251889 = (float4(( (Local_ShaderSample199_g251889).x * _MainMetallicValue ) , Local_Occlusion313_g251889 , (Local_ShaderSample199_g251889).z , Local_Smoothness317_g251889));
					half4 Local_Masks109_g251889 = appendResult73_g251889;
					float4 In_Shader3_g251891 = Local_Masks109_g251889;
					float4 In_Feature3_g251891 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251891 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251891 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251924 = Local_Albedo139_g251889;
					float dotResult20_g251924 = dot( temp_output_3_0_g251924 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251889 = dotResult20_g251924;
					float temp_output_12_0_g251891 = Local_Grayscale110_g251889;
					float In_Grayscale3_g251891 = temp_output_12_0_g251891;
					float temp_output_3_0_g251925 = Local_Grayscale110_g251889;
					float clampResult27_g251925 = clamp( saturate( ( temp_output_3_0_g251925 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251889 = clampResult27_g251925;
					float temp_output_16_0_g251891 = Local_Luminosity145_g251889;
					float In_Luminosity3_g251891 = temp_output_16_0_g251891;
					float In_MultiMask3_g251891 = Local_MultiMask78_g251889;
					float temp_output_187_0_g251889 = (Local_AlbedoSample185_g251889).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251889 = ( temp_output_187_0_g251889 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251889 = temp_output_187_0_g251889;
					#endif
					half Local_AlphaClip111_g251889 = staticSwitch236_g251889;
					float In_AlphaClip3_g251891 = Local_AlphaClip111_g251889;
					half Local_AlphaFade246_g251889 = (lerpResult62_g251889).a;
					float In_AlphaFade3_g251891 = Local_AlphaFade246_g251889;
					float3 temp_cast_31 = (1.0).xxx;
					float3 In_Translucency3_g251891 = temp_cast_31;
					float In_Transmission3_g251891 = 1.0;
					float In_Thickness3_g251891 = 0.0;
					float In_Diffusion3_g251891 = 0.0;
					float In_Depth3_g251891 = 0.0;
					BuildVisualData( Data3_g251891 , In_Dummy3_g251891 , In_Albedo3_g251891 , In_AlbedoBase3_g251891 , In_NormalTS3_g251891 , In_NormalWS3_g251891 , In_Shader3_g251891 , In_Feature3_g251891 , In_Season3_g251891 , In_Emissive3_g251891 , In_Grayscale3_g251891 , In_Luminosity3_g251891 , In_MultiMask3_g251891 , In_AlphaClip3_g251891 , In_AlphaFade3_g251891 , In_Translucency3_g251891 , In_Transmission3_g251891 , In_Thickness3_g251891 , In_Diffusion3_g251891 , In_Depth3_g251891 );
					TVEVisualData Data4_g251949 =(TVEVisualData)Data3_g251891;
					float Out_Dummy4_g251949 = 0.0;
					float3 Out_Albedo4_g251949 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251949 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251949 = float2( 0,0 );
					float3 Out_NormalWS4_g251949 = float3( 0,0,0 );
					float4 Out_Shader4_g251949 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251949 = float4( 0,0,0,0 );
					float4 Out_Season4_g251949 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251949 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251949 = 0.0;
					float Out_Grayscale4_g251949 = 0.0;
					float Out_Luminosity4_g251949 = 0.0;
					float Out_AlphaClip4_g251949 = 0.0;
					float Out_AlphaFade4_g251949 = 0.0;
					float3 Out_Translucency4_g251949 = float3( 0,0,0 );
					float Out_Transmission4_g251949 = 0.0;
					float Out_Thickness4_g251949 = 0.0;
					float Out_Diffusion4_g251949 = 0.0;
					float Out_Depth4_g251949 = 0.0;
					BreakVisualData( Data4_g251949 , Out_Dummy4_g251949 , Out_Albedo4_g251949 , Out_AlbedoBase4_g251949 , Out_NormalTS4_g251949 , Out_NormalWS4_g251949 , Out_Shader4_g251949 , Out_Feature4_g251949 , Out_Season4_g251949 , Out_Emissive4_g251949 , Out_MultiMask4_g251949 , Out_Grayscale4_g251949 , Out_Luminosity4_g251949 , Out_AlphaClip4_g251949 , Out_AlphaFade4_g251949 , Out_Translucency4_g251949 , Out_Transmission4_g251949 , Out_Thickness4_g251949 , Out_Diffusion4_g251949 , Out_Depth4_g251949 );
					half4 Visual_Shader531_g251928 = Out_Shader4_g251949;
					float temp_output_1079_0_g251928 = (Visual_Shader531_g251928).z;
					float temp_output_7_0_g251983 = _SecondBaseRemap.x;
					float temp_output_9_0_g251983 = ( temp_output_1079_0_g251928 - temp_output_7_0_g251983 );
					float lerpResult1081_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251983 * _SecondBaseRemap.z ) ) , _SecondBaseValue);
					half Blend_BaseMask1077_g251928 = lerpResult1081_g251928;
					half Visual_Luminosity1041_g251928 = Out_Luminosity4_g251949;
					float temp_output_7_0_g251985 = _SecondLumaRemap.x;
					float temp_output_9_0_g251985 = ( Visual_Luminosity1041_g251928 - temp_output_7_0_g251985 );
					float lerpResult1036_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251985 * _SecondLumaRemap.z ) ) , _SecondLumaValue);
					half Blend_LumaMask1033_g251928 = lerpResult1036_g251928;
					half3 Visual_NormalWS951_g251928 = Out_NormalWS4_g251949;
					float temp_output_847_0_g251928 = saturate( (Visual_NormalWS951_g251928).y );
					float temp_output_7_0_g251984 = _SecondProjRemap.x;
					float temp_output_9_0_g251984 = ( temp_output_847_0_g251928 - temp_output_7_0_g251984 );
					float lerpResult996_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251984 * _SecondProjRemap.z ) ) , _SecondProjValue);
					half Blend_ProjMask434_g251928 = lerpResult996_g251928;
					float temp_output_17_0_g251994 = _SecondMeshMode;
					float Option70_g251994 = temp_output_17_0_g251994;
					half4 Model_VertexData964_g251928 = Out_VertexData15_g251931;
					float4 temp_output_3_0_g251994 = Model_VertexData964_g251928;
					float4 Channel70_g251994 = temp_output_3_0_g251994;
					float localSwitchChannel470_g251994 = SwitchChannel4( Option70_g251994 , Channel70_g251994 );
					float temp_output_1227_0_g251928 = localSwitchChannel470_g251994;
					float temp_output_7_0_g251982 = _SecondMeshRemap.x;
					float temp_output_9_0_g251982 = ( temp_output_1227_0_g251928 - temp_output_7_0_g251982 );
					float lerpResult1017_g251928 = lerp( 1.0 , saturate( ( temp_output_9_0_g251982 * _SecondMeshRemap.z ) ) , _SecondMeshValue);
					half Blend_VertMask918_g251928 = lerpResult1017_g251928;
					float temp_output_64_0_g252004 = ( Blend_TexMask429_g251928 * Blend_BaseMask1077_g251928 * Blend_LumaMask1033_g251928 * Blend_ProjMask434_g251928 * Blend_VertMask918_g251928 );
					half Blend_GlobalMask972_g251928 = 1.0;
					float temp_output_92_0_g252004 = ( Feature_Intensity1204_g251928 * Blend_GlobalMask972_g251928 );
					half Multiply93_g252004 = ( temp_output_64_0_g252004 * temp_output_92_0_g252004 );
					half Subtract93_g252004 = saturate( ( temp_output_92_0_g252004 - ( 1.0 - temp_output_64_0_g252004 ) ) );
					half Option93_g252004 = _SecondBlendMath;
					half localSwitchBlendMask93_g252004 = SwitchBlendMask( Multiply93_g252004 , Subtract93_g252004 , Option93_g252004 );
					float temp_output_7_0_g252003 = _SecondBlendRemap.x;
					float temp_output_9_0_g252003 = ( localSwitchBlendMask93_g252004 - temp_output_7_0_g252003 );
					half Blend_Mask412_g251928 = ( saturate( ( temp_output_9_0_g252003 * _SecondBlendRemap.z ) ) * _SecondBlendIntensityValue );
					float4 appendResult1126_g251928 = (float4(Blend_Mask412_g251928 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_32 = (0.0).xxxx;
					float4 temp_cast_33 = (0.0).xxxx;
					float4 ifLocalVar18_g251947 = 0;
					if( Feature_Intensity1204_g251928 <= 0.0 )
					ifLocalVar18_g251947 = temp_cast_33;
					else
					ifLocalVar18_g251947 = appendResult1126_g251928;
					float4 In_MaskB3_g251944 = ifLocalVar18_g251947;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 In_MaskC3_g251944 = temp_cast_34;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskD3_g251944 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskE3_g251944 = temp_cast_36;
					float4 temp_cast_37 = (0.0).xxxx;
					float4 In_MaskF3_g251944 = temp_cast_37;
					float4 temp_cast_38 = (0.0).xxxx;
					float4 In_MaskG3_g251944 = temp_cast_38;
					float4 temp_cast_39 = (0.0).xxxx;
					float4 In_MaskH3_g251944 = temp_cast_39;
					float4 temp_cast_40 = (0.0).xxxx;
					float4 In_MaskI3_g251944 = temp_cast_40;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 In_MaskJ3_g251944 = temp_cast_41;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskK3_g251944 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskL3_g251944 = temp_cast_43;
					{
					Data3_g251944.MaskA = In_MaskA3_g251944;
					Data3_g251944.MaskB = In_MaskB3_g251944;
					Data3_g251944.MaskC = In_MaskC3_g251944;
					Data3_g251944.MaskD = In_MaskD3_g251944;
					Data3_g251944.MaskE = In_MaskE3_g251944;
					Data3_g251944.MaskF = In_MaskF3_g251944;
					Data3_g251944.MaskG = In_MaskG3_g251944;
					Data3_g251944.MaskH = In_MaskH3_g251944;
					Data3_g251944.MaskI = In_MaskI3_g251944;
					Data3_g251944.MaskJ= In_MaskJ3_g251944;
					Data3_g251944.MaskK= In_MaskK3_g251944;
					Data3_g251944.MaskL = In_MaskL3_g251944;
					}
					TVEMasksData DataA25_g252082 = Data3_g251944;
					float localBuildMasksData3_g252021 = ( 0.0 );
					TVEMasksData Data3_g252021 = (TVEMasksData)0;
					half Feature_Intensity1204_g252005 = _SecondIntensityValue;
					float ifLocalVar18_g252022 = 0;
					if( Feature_Intensity1204_g252005 <= 0.0 )
					ifLocalVar18_g252022 = 0.0;
					else
					ifLocalVar18_g252022 = 1.0;
					half Feature_Element1203_g252005 = _SecondCoatMode;
					float ifLocalVar18_g252023 = 0;
					if( Feature_Element1203_g252005 <= 0.0 )
					ifLocalVar18_g252023 = 0.0;
					else
					ifLocalVar18_g252023 = 1.0;
					float4 appendResult1090_g252005 = (float4(ifLocalVar18_g252022 , 0.0 , 0.0 , ifLocalVar18_g252023));
					float4 In_MaskA3_g252021 = appendResult1090_g252005;
					float temp_output_17_0_g252058 = _SecondMaskMode;
					float Option70_g252058 = temp_output_17_0_g252058;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252039) = _SecondMaskTex;
					SamplerState Sampler276_g252039 = sampler_Linear_Repeat;
					float localBreakTextureData456_g252039 = ( 0.0 );
					float localBuildTextureData431_g252053 = ( 0.0 );
					TVEMasksData Data431_g252053 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252053 = ( 0.0 );
					float4 temp_output_6_0_g252010 = _second_mask_coord_value;
					float4 temp_output_7_0_g252010 = ( _SecondMaskSampleMode + _SecondMaskCoordMode + _SecondMaskCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252010 = ( temp_output_6_0_g252010 + temp_output_7_0_g252010 );
					#else
					float4 staticSwitch14_g252010 = temp_output_6_0_g252010;
					#endif
					half4 Local_MaskCoordValue813_g252005 = staticSwitch14_g252010;
					float4 Coords444_g252053 = Local_MaskCoordValue813_g252005;
					TVEModelData Data15_g252008 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g252008 = 0.0;
					float3 Out_PositionWS15_g252008 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252008 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252008 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252008 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252008 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252008 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252008 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252008 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252008 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252008 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252008 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252008 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252008 , Out_Dummy15_g252008 , Out_PositionWS15_g252008 , Out_PositionWO15_g252008 , Out_PivotWS15_g252008 , Out_PivotWO15_g252008 , Out_NormalWS15_g252008 , Out_TangentWS15_g252008 , Out_BitangentWS15_g252008 , Out_TriplanarWeights15_g252008 , Out_ViewDirWS15_g252008 , Out_CoordsData15_g252008 , Out_VertexData15_g252008 , Out_Interpolator15_g252008 );
					float4 Model_CoordsData1099_g252005 = Out_CoordsData15_g252008;
					float4 MeshCoords444_g252053 = Model_CoordsData1099_g252005;
					float2 UV0444_g252053 = float2( 0,0 );
					float2 UV3444_g252053 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252053 , MeshCoords444_g252053 , UV0444_g252053 , UV3444_g252053 );
					float4 appendResult430_g252053 = (float4(UV0444_g252053 , UV3444_g252053));
					float4 In_MaskA431_g252053 = appendResult430_g252053;
					float localComputeWorldCoords315_g252053 = ( 0.0 );
					float4 Coords315_g252053 = Local_MaskCoordValue813_g252005;
					float3 Model_PositionWO636_g252005 = Out_PositionWO15_g252008;
					float3 PositionWS315_g252053 = Model_PositionWO636_g252005;
					float2 ZY315_g252053 = float2( 0,0 );
					float2 XZ315_g252053 = float2( 0,0 );
					float2 XY315_g252053 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252053 , PositionWS315_g252053 , ZY315_g252053 , XZ315_g252053 , XY315_g252053 );
					float2 ZY402_g252053 = ZY315_g252053;
					float2 XZ403_g252053 = XZ315_g252053;
					float4 appendResult432_g252053 = (float4(ZY402_g252053 , XZ403_g252053));
					float4 In_MaskB431_g252053 = appendResult432_g252053;
					float2 XY404_g252053 = XY315_g252053;
					float localComputeStochasticCoords409_g252053 = ( 0.0 );
					float2 UV409_g252053 = ZY402_g252053;
					float2 UV1409_g252053 = float2( 0,0 );
					float2 UV2409_g252053 = float2( 0,0 );
					float2 UV3409_g252053 = float2( 0,0 );
					float3 Weights409_g252053 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252053 , UV1409_g252053 , UV2409_g252053 , UV3409_g252053 , Weights409_g252053 );
					float4 appendResult433_g252053 = (float4(XY404_g252053 , UV1409_g252053));
					float4 In_MaskC431_g252053 = appendResult433_g252053;
					float4 appendResult434_g252053 = (float4(UV2409_g252053 , UV3409_g252053));
					float4 In_MaskD431_g252053 = appendResult434_g252053;
					float localComputeStochasticCoords422_g252053 = ( 0.0 );
					float2 UV422_g252053 = XZ403_g252053;
					float2 UV1422_g252053 = float2( 0,0 );
					float2 UV2422_g252053 = float2( 0,0 );
					float2 UV3422_g252053 = float2( 0,0 );
					float3 Weights422_g252053 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252053 , UV1422_g252053 , UV2422_g252053 , UV3422_g252053 , Weights422_g252053 );
					float4 appendResult435_g252053 = (float4(UV1422_g252053 , UV2422_g252053));
					float4 In_MaskE431_g252053 = appendResult435_g252053;
					float localComputeStochasticCoords423_g252053 = ( 0.0 );
					float2 UV423_g252053 = XY404_g252053;
					float2 UV1423_g252053 = float2( 0,0 );
					float2 UV2423_g252053 = float2( 0,0 );
					float2 UV3423_g252053 = float2( 0,0 );
					float3 Weights423_g252053 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252053 , UV1423_g252053 , UV2423_g252053 , UV3423_g252053 , Weights423_g252053 );
					float4 appendResult436_g252053 = (float4(UV3422_g252053 , UV1423_g252053));
					float4 In_MaskF431_g252053 = appendResult436_g252053;
					float4 appendResult437_g252053 = (float4(UV2423_g252053 , UV3423_g252053));
					float4 In_MaskG431_g252053 = appendResult437_g252053;
					float4 In_MaskH431_g252053 = float4( Weights409_g252053 , 0.0 );
					float4 In_MaskI431_g252053 = float4( Weights422_g252053 , 0.0 );
					float4 In_MaskJ431_g252053 = float4( Weights423_g252053 , 0.0 );
					half3 Model_NormalWS869_g252005 = Out_NormalWS15_g252008;
					float3 temp_output_449_0_g252053 = Model_NormalWS869_g252005;
					float4 In_MaskK431_g252053 = float4( temp_output_449_0_g252053 , 0.0 );
					half3 Model_TangentWS1215_g252005 = Out_TangentWS15_g252008;
					float3 temp_output_450_0_g252053 = Model_TangentWS1215_g252005;
					float4 In_MaskL431_g252053 = float4( temp_output_450_0_g252053 , 0.0 );
					half3 Model_BitangentWS1216_g252005 = Out_BitangentWS15_g252008;
					float3 temp_output_451_0_g252053 = Model_BitangentWS1216_g252005;
					float4 In_MaskM431_g252053 = float4( temp_output_451_0_g252053 , 0.0 );
					half3 Model_TriplanarWeights1217_g252005 = Out_TriplanarWeights15_g252008;
					float3 temp_output_445_0_g252053 = Model_TriplanarWeights1217_g252005;
					float4 In_MaskN431_g252053 = float4( temp_output_445_0_g252053 , 0.0 );
					BuildTextureData( Data431_g252053 , In_MaskA431_g252053 , In_MaskB431_g252053 , In_MaskC431_g252053 , In_MaskD431_g252053 , In_MaskE431_g252053 , In_MaskF431_g252053 , In_MaskG431_g252053 , In_MaskH431_g252053 , In_MaskI431_g252053 , In_MaskJ431_g252053 , In_MaskK431_g252053 , In_MaskL431_g252053 , In_MaskM431_g252053 , In_MaskN431_g252053 );
					TVEMasksData Data456_g252039 =(TVEMasksData)Data431_g252053;
					float4 Out_MaskA456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252039 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252039 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252039 , Out_MaskA456_g252039 , Out_MaskB456_g252039 , Out_MaskC456_g252039 , Out_MaskD456_g252039 , Out_MaskE456_g252039 , Out_MaskF456_g252039 , Out_MaskG456_g252039 , Out_MaskH456_g252039 , Out_MaskI456_g252039 , Out_MaskJ456_g252039 , Out_MaskK456_g252039 , Out_MaskL456_g252039 , Out_MaskM456_g252039 , Out_MaskN456_g252039 );
					half2 UV276_g252039 = (Out_MaskA456_g252039).xy;
					float temp_output_504_0_g252039 = 0.0;
					half Bias276_g252039 = temp_output_504_0_g252039;
					half2 Normal276_g252039 = float2( 0,0 );
					half4 localSampleCoord276_g252039 = SampleCoord( Texture276_g252039 , Sampler276_g252039 , UV276_g252039 , Bias276_g252039 , Normal276_g252039 );
					float4 temp_output_868_277_g252005 = localSampleCoord276_g252039;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252039) = _SecondMaskTex;
					SamplerState Sampler502_g252039 = sampler_Linear_Repeat;
					half2 UV502_g252039 = (Out_MaskA456_g252039).zw;
					half Bias502_g252039 = temp_output_504_0_g252039;
					half2 Normal502_g252039 = float2( 0,0 );
					half4 localSampleCoord502_g252039 = SampleCoord( Texture502_g252039 , Sampler502_g252039 , UV502_g252039 , Bias502_g252039 , Normal502_g252039 );
					float4 temp_output_868_278_g252005 = localSampleCoord502_g252039;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252039) = _SecondMaskTex;
					SamplerState Sampler496_g252039 = sampler_Linear_Repeat;
					float2 temp_output_463_0_g252039 = (Out_MaskB456_g252039).zw;
					half2 XZ496_g252039 = temp_output_463_0_g252039;
					half Bias496_g252039 = temp_output_504_0_g252039;
					half3 NormalWS512_g252039 = (Out_MaskK456_g252039).xyz;
					half3 NormalWS496_g252039 = NormalWS512_g252039;
					half3 Normal496_g252039 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252039 = SamplePlanar2D( Texture496_g252039 , Sampler496_g252039 , XZ496_g252039 , Bias496_g252039 , NormalWS496_g252039 , Normal496_g252039 );
					float4 temp_output_868_0_g252005 = localSamplePlanar2D496_g252039;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252039) = _SecondMaskTex;
					SamplerState Sampler490_g252039 = sampler_Linear_Repeat;
					float2 temp_output_462_0_g252039 = (Out_MaskB456_g252039).xy;
					half2 ZY490_g252039 = temp_output_462_0_g252039;
					half2 XZ490_g252039 = temp_output_463_0_g252039;
					float2 temp_output_464_0_g252039 = (Out_MaskC456_g252039).xy;
					half2 XY490_g252039 = temp_output_464_0_g252039;
					half Bias490_g252039 = temp_output_504_0_g252039;
					half3 Triplanar522_g252039 = (Out_MaskN456_g252039).xyz;
					half3 Triplanar490_g252039 = Triplanar522_g252039;
					half3 NormalWS490_g252039 = NormalWS512_g252039;
					half3 Normal490_g252039 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252039 = SamplePlanar3D( Texture490_g252039 , Sampler490_g252039 , ZY490_g252039 , XZ490_g252039 , XY490_g252039 , Bias490_g252039 , Triplanar490_g252039 , NormalWS490_g252039 , Normal490_g252039 );
					float4 temp_output_868_201_g252005 = localSamplePlanar3D490_g252039;
					#if defined( TVE_SECOND_MASK_SAMPLE_MAIN_UV )
					float4 staticSwitch817_g252005 = temp_output_868_277_g252005;
					#elif defined( TVE_SECOND_MASK_SAMPLE_EXTRA_UV )
					float4 staticSwitch817_g252005 = temp_output_868_278_g252005;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_2D )
					float4 staticSwitch817_g252005 = temp_output_868_0_g252005;
					#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_3D )
					float4 staticSwitch817_g252005 = temp_output_868_201_g252005;
					#else
					float4 staticSwitch817_g252005 = temp_output_868_277_g252005;
					#endif
					half4 Local_MaskSample861_g252005 = staticSwitch817_g252005;
					float4 temp_output_3_0_g252058 = Local_MaskSample861_g252005;
					float4 Channel70_g252058 = temp_output_3_0_g252058;
					float localSwitchChannel470_g252058 = SwitchChannel4( Option70_g252058 , Channel70_g252058 );
					float temp_output_1226_0_g252005 = localSwitchChannel470_g252058;
					float temp_output_7_0_g252063 = _SecondMaskRemap.x;
					float temp_output_9_0_g252063 = ( temp_output_1226_0_g252005 - temp_output_7_0_g252063 );
					float lerpResult1015_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252063 * _SecondMaskRemap.z ) ) , _SecondMaskValue);
					#ifdef TVE_SECOND_MASK
					float staticSwitch1088_g252005 = lerpResult1015_g252005;
					#else
					float staticSwitch1088_g252005 = 1.0;
					#endif
					half Blend_TexMask429_g252005 = staticSwitch1088_g252005;
					float localBreakVisualData4_g252026 = ( 0.0 );
					TVEVisualData Data4_g252026 =(TVEVisualData)Data3_g251891;
					float Out_Dummy4_g252026 = 0.0;
					float3 Out_Albedo4_g252026 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252026 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252026 = float2( 0,0 );
					float3 Out_NormalWS4_g252026 = float3( 0,0,0 );
					float4 Out_Shader4_g252026 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252026 = float4( 0,0,0,0 );
					float4 Out_Season4_g252026 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252026 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252026 = 0.0;
					float Out_Grayscale4_g252026 = 0.0;
					float Out_Luminosity4_g252026 = 0.0;
					float Out_AlphaClip4_g252026 = 0.0;
					float Out_AlphaFade4_g252026 = 0.0;
					float3 Out_Translucency4_g252026 = float3( 0,0,0 );
					float Out_Transmission4_g252026 = 0.0;
					float Out_Thickness4_g252026 = 0.0;
					float Out_Diffusion4_g252026 = 0.0;
					float Out_Depth4_g252026 = 0.0;
					BreakVisualData( Data4_g252026 , Out_Dummy4_g252026 , Out_Albedo4_g252026 , Out_AlbedoBase4_g252026 , Out_NormalTS4_g252026 , Out_NormalWS4_g252026 , Out_Shader4_g252026 , Out_Feature4_g252026 , Out_Season4_g252026 , Out_Emissive4_g252026 , Out_MultiMask4_g252026 , Out_Grayscale4_g252026 , Out_Luminosity4_g252026 , Out_AlphaClip4_g252026 , Out_AlphaFade4_g252026 , Out_Translucency4_g252026 , Out_Transmission4_g252026 , Out_Thickness4_g252026 , Out_Diffusion4_g252026 , Out_Depth4_g252026 );
					half4 Visual_Shader531_g252005 = Out_Shader4_g252026;
					float temp_output_1079_0_g252005 = (Visual_Shader531_g252005).z;
					float temp_output_7_0_g252060 = _SecondBaseRemap.x;
					float temp_output_9_0_g252060 = ( temp_output_1079_0_g252005 - temp_output_7_0_g252060 );
					float lerpResult1081_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252060 * _SecondBaseRemap.z ) ) , _SecondBaseValue);
					half Blend_BaseMask1077_g252005 = lerpResult1081_g252005;
					half Visual_Luminosity1041_g252005 = Out_Luminosity4_g252026;
					float temp_output_7_0_g252062 = _SecondLumaRemap.x;
					float temp_output_9_0_g252062 = ( Visual_Luminosity1041_g252005 - temp_output_7_0_g252062 );
					float lerpResult1036_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252062 * _SecondLumaRemap.z ) ) , _SecondLumaValue);
					half Blend_LumaMask1033_g252005 = lerpResult1036_g252005;
					half3 Visual_NormalWS951_g252005 = Out_NormalWS4_g252026;
					float temp_output_847_0_g252005 = saturate( (Visual_NormalWS951_g252005).y );
					float temp_output_7_0_g252061 = _SecondProjRemap.x;
					float temp_output_9_0_g252061 = ( temp_output_847_0_g252005 - temp_output_7_0_g252061 );
					float lerpResult996_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252061 * _SecondProjRemap.z ) ) , _SecondProjValue);
					half Blend_ProjMask434_g252005 = lerpResult996_g252005;
					float temp_output_17_0_g252071 = _SecondMeshMode;
					float Option70_g252071 = temp_output_17_0_g252071;
					half4 Model_VertexData964_g252005 = Out_VertexData15_g252008;
					float4 temp_output_3_0_g252071 = Model_VertexData964_g252005;
					float4 Channel70_g252071 = temp_output_3_0_g252071;
					float localSwitchChannel470_g252071 = SwitchChannel4( Option70_g252071 , Channel70_g252071 );
					float temp_output_1227_0_g252005 = localSwitchChannel470_g252071;
					float temp_output_7_0_g252059 = _SecondMeshRemap.x;
					float temp_output_9_0_g252059 = ( temp_output_1227_0_g252005 - temp_output_7_0_g252059 );
					float lerpResult1017_g252005 = lerp( 1.0 , saturate( ( temp_output_9_0_g252059 * _SecondMeshRemap.z ) ) , _SecondMeshValue);
					half Blend_VertMask918_g252005 = lerpResult1017_g252005;
					float temp_output_64_0_g252081 = ( Blend_TexMask429_g252005 * Blend_BaseMask1077_g252005 * Blend_LumaMask1033_g252005 * Blend_ProjMask434_g252005 * Blend_VertMask918_g252005 );
					float temp_output_1256_0_g252005 = (TVE_CoatParams).x;
					float localBuildGlobalData204_g235664 = ( 0.0 );
					TVEGlobalData Data204_g235664 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g235664 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g235664 = Dummy211_g235664;
					float4 temp_output_203_0_g235683 = TVE_CoatBaseCoord;
					TVEModelData Data15_g235754 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g235754 = 0.0;
					float3 Out_PositionWS15_g235754 = float3( 0,0,0 );
					float3 Out_PositionWO15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWS15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWO15_g235754 = float3( 0,0,0 );
					float3 Out_NormalWS15_g235754 = float3( 0,0,0 );
					float3 Out_TangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g235754 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g235754 = float3( 0,0,0 );
					float4 Out_CoordsData15_g235754 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g235754 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g235754 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g235754 , Out_Dummy15_g235754 , Out_PositionWS15_g235754 , Out_PositionWO15_g235754 , Out_PivotWS15_g235754 , Out_PivotWO15_g235754 , Out_NormalWS15_g235754 , Out_TangentWS15_g235754 , Out_BitangentWS15_g235754 , Out_TriplanarWeights15_g235754 , Out_ViewDirWS15_g235754 , Out_CoordsData15_g235754 , Out_VertexData15_g235754 , Out_Interpolator15_g235754 );
					float3 Model_PositionWS497_g235664 = Out_PositionWS15_g235754;
					float2 Model_PositionWS_XZ143_g235664 = (Model_PositionWS497_g235664).xz;
					float3 Model_PivotWS498_g235664 = Out_PivotWS15_g235754;
					float2 Model_PivotWS_XZ145_g235664 = (Model_PivotWS498_g235664).xz;
					float2 lerpResult300_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g235683 = lerpResult300_g235664;
					float temp_output_82_0_g235681 = _GlobalCoatLayerValue;
					float temp_output_82_0_g235683 = temp_output_82_0_g235681;
					float4 tex2DArrayNode83_g235683 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235683).zw + ( (temp_output_203_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683) );
					float4 appendResult210_g235683 = (float4(tex2DArrayNode83_g235683.rgb , tex2DArrayNode83_g235683.a));
					float4 temp_output_204_0_g235683 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g235683 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235683).zw + ( (temp_output_204_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683) );
					float4 appendResult212_g235683 = (float4(tex2DArrayNode122_g235683.rgb , tex2DArrayNode122_g235683.a));
					float4 TVE_RenderNearPositionR628_g235664 = TVE_RenderNearPositionR;
					float temp_output_507_0_g235664 = saturate( ( distance( Model_PositionWS497_g235664 , (TVE_RenderNearPositionR628_g235664).xyz ) / (TVE_RenderNearPositionR628_g235664).w ) );
					float temp_output_7_0_g235753 = 1.0;
					float temp_output_9_0_g235753 = ( temp_output_507_0_g235664 - temp_output_7_0_g235753 );
					half TVE_RenderNearFadeValue635_g235664 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g235664 = saturate( ( temp_output_9_0_g235753 / ( ( TVE_RenderNearFadeValue635_g235664 - temp_output_7_0_g235753 ) + 0.0001 ) ) );
					float4 lerpResult131_g235683 = lerp( appendResult210_g235683 , appendResult212_g235683 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235681 = lerpResult131_g235683;
					float4 lerpResult168_g235681 = lerp( TVE_CoatParams , temp_output_159_109_g235681 , TVE_CoatLayers[(int)temp_output_82_0_g235681]);
					float4 temp_output_589_109_g235664 = lerpResult168_g235681;
					half4 Coat_Texture302_g235664 = temp_output_589_109_g235664;
					float4 In_CoatTexture204_g235664 = Coat_Texture302_g235664;
					half4 Draw_Texture656_g235664 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g235664 = Draw_Texture656_g235664;
					float4 temp_output_203_0_g235708 = TVE_PaintBaseCoord;
					float2 lerpResult85_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g235708 = lerpResult85_g235664;
					float temp_output_82_0_g235705 = _GlobalPaintLayerValue;
					float temp_output_82_0_g235708 = temp_output_82_0_g235705;
					float4 tex2DArrayNode83_g235708 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235708).zw + ( (temp_output_203_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708) );
					float4 appendResult210_g235708 = (float4(tex2DArrayNode83_g235708.rgb , tex2DArrayNode83_g235708.a));
					float4 temp_output_204_0_g235708 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g235708 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235708).zw + ( (temp_output_204_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708) );
					float4 appendResult212_g235708 = (float4(tex2DArrayNode122_g235708.rgb , tex2DArrayNode122_g235708.a));
					float4 lerpResult131_g235708 = lerp( appendResult210_g235708 , appendResult212_g235708 , Global_TexBlend509_g235664);
					float4 temp_output_171_109_g235705 = lerpResult131_g235708;
					float4 lerpResult174_g235705 = lerp( TVE_PaintParams , temp_output_171_109_g235705 , TVE_PaintLayers[(int)temp_output_82_0_g235705]);
					float4 temp_output_595_109_g235664 = lerpResult174_g235705;
					half4 Paint_Texture71_g235664 = temp_output_595_109_g235664;
					float4 In_PaintTexture204_g235664 = Paint_Texture71_g235664;
					float4 temp_output_203_0_g235691 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g235691 = lerpResult104_g235664;
					float temp_output_132_0_g235689 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g235691 = temp_output_132_0_g235689;
					float4 tex2DArrayNode83_g235691 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235691).zw + ( (temp_output_203_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691) );
					float4 appendResult210_g235691 = (float4(tex2DArrayNode83_g235691.rgb , tex2DArrayNode83_g235691.a));
					float4 temp_output_204_0_g235691 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g235691 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235691).zw + ( (temp_output_204_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691) );
					float4 appendResult212_g235691 = (float4(tex2DArrayNode122_g235691.rgb , tex2DArrayNode122_g235691.a));
					float4 lerpResult131_g235691 = lerp( appendResult210_g235691 , appendResult212_g235691 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235689 = lerpResult131_g235691;
					float4 lerpResult145_g235689 = lerp( TVE_AtmoParams , temp_output_137_109_g235689 , TVE_AtmoLayers[(int)temp_output_132_0_g235689]);
					float4 temp_output_590_110_g235664 = lerpResult145_g235689;
					half4 Atmo_Texture80_g235664 = temp_output_590_110_g235664;
					float4 In_AtmoTexture204_g235664 = Atmo_Texture80_g235664;
					float4 temp_output_203_0_g235759 = TVE_EffexBaseCoord;
					float2 lerpResult414_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g235759 = lerpResult414_g235664;
					float temp_output_132_0_g235757 = _GlobalEffexLayerValue;
					float temp_output_82_0_g235759 = temp_output_132_0_g235757;
					float4 tex2DArrayNode83_g235759 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235759).zw + ( (temp_output_203_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759) );
					float4 appendResult210_g235759 = (float4(tex2DArrayNode83_g235759.rgb , tex2DArrayNode83_g235759.a));
					float4 temp_output_204_0_g235759 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g235759 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235759).zw + ( (temp_output_204_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759) );
					float4 appendResult212_g235759 = (float4(tex2DArrayNode122_g235759.rgb , tex2DArrayNode122_g235759.a));
					float4 lerpResult131_g235759 = lerp( appendResult210_g235759 , appendResult212_g235759 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235757 = lerpResult131_g235759;
					float4 lerpResult145_g235757 = lerp( TVE_EffexParams , temp_output_137_109_g235757 , TVE_EffexLayers[(int)temp_output_132_0_g235757]);
					float4 temp_output_731_110_g235664 = lerpResult145_g235757;
					half4 Effex_Texture420_g235664 = temp_output_731_110_g235664;
					float4 In_EffexTexture204_g235664 = Effex_Texture420_g235664;
					float4 temp_output_203_0_g235739 = TVE_GlowBaseCoord;
					float2 lerpResult247_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g235739 = lerpResult247_g235664;
					float temp_output_82_0_g235737 = _GlobalGlowLayerValue;
					float temp_output_82_0_g235739 = temp_output_82_0_g235737;
					float4 tex2DArrayNode83_g235739 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235739).zw + ( (temp_output_203_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739) );
					float4 appendResult210_g235739 = (float4(tex2DArrayNode83_g235739.rgb , tex2DArrayNode83_g235739.a));
					float4 temp_output_204_0_g235739 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g235739 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235739).zw + ( (temp_output_204_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739) );
					float4 appendResult212_g235739 = (float4(tex2DArrayNode122_g235739.rgb , tex2DArrayNode122_g235739.a));
					float4 lerpResult131_g235739 = lerp( appendResult210_g235739 , appendResult212_g235739 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235737 = lerpResult131_g235739;
					float4 lerpResult167_g235737 = lerp( TVE_GlowParams , temp_output_159_109_g235737 , TVE_GlowLayers[(int)temp_output_82_0_g235737]);
					float4 temp_output_593_109_g235664 = lerpResult167_g235737;
					half4 Glow_Texture248_g235664 = temp_output_593_109_g235664;
					float4 In_GlowTexture204_g235664 = Glow_Texture248_g235664;
					float4 temp_output_203_0_g235675 = TVE_FormBaseCoord;
					float2 lerpResult168_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g235675 = lerpResult168_g235664;
					float temp_output_130_0_g235673 = _GlobalFormLayerValue;
					float temp_output_82_0_g235675 = temp_output_130_0_g235673;
					float4 tex2DArrayNode83_g235675 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235675).zw + ( (temp_output_203_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675) );
					float4 appendResult210_g235675 = (float4(tex2DArrayNode83_g235675.rgb , tex2DArrayNode83_g235675.a));
					float4 temp_output_204_0_g235675 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g235675 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235675).zw + ( (temp_output_204_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675) );
					float4 appendResult212_g235675 = (float4(tex2DArrayNode122_g235675.rgb , tex2DArrayNode122_g235675.a));
					float4 lerpResult131_g235675 = lerp( appendResult210_g235675 , appendResult212_g235675 , Global_TexBlend509_g235664);
					float4 temp_output_135_109_g235673 = lerpResult131_g235675;
					float4 lerpResult143_g235673 = lerp( TVE_FormParams , temp_output_135_109_g235673 , TVE_FormLayers[(int)temp_output_130_0_g235673]);
					float4 temp_output_592_0_g235664 = lerpResult143_g235673;
					float4 Form_Texture112_g235664 = temp_output_592_0_g235664;
					float4 In_FormTexture204_g235664 = Form_Texture112_g235664;
					float4 In_LandTexture204_g235664 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g235723 = TVE_VertxBaseCoord;
					float2 lerpResult681_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g235723 = lerpResult681_g235664;
					float temp_output_136_0_g235721 = _GlobalVertxLayerValue;
					float temp_output_82_0_g235723 = temp_output_136_0_g235721;
					float4 tex2DArrayNode83_g235723 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235723).zw + ( (temp_output_203_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723) );
					float4 appendResult210_g235723 = (float4(tex2DArrayNode83_g235723.rgb , tex2DArrayNode83_g235723.a));
					float4 temp_output_204_0_g235723 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g235723 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235723).zw + ( (temp_output_204_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723) );
					float4 appendResult212_g235723 = (float4(tex2DArrayNode122_g235723.rgb , tex2DArrayNode122_g235723.a));
					float4 lerpResult131_g235723 = lerp( appendResult210_g235723 , appendResult212_g235723 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235721 = lerpResult131_g235723;
					float4 lerpResult149_g235721 = lerp( TVE_VertxParams , temp_output_141_109_g235721 , TVE_VertxLayers[(int)temp_output_136_0_g235721]);
					float4 temp_output_695_0_g235664 = lerpResult149_g235721;
					half4 Vertx_Texture693_g235664 = temp_output_695_0_g235664;
					float4 In_VertxTexture204_g235664 = Vertx_Texture693_g235664;
					float4 temp_output_203_0_g235699 = TVE_FlowBaseCoord;
					float2 lerpResult400_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g235699 = lerpResult400_g235664;
					float temp_output_136_0_g235697 = _GlobalFlowLayerValue;
					float temp_output_82_0_g235699 = temp_output_136_0_g235697;
					float4 tex2DArrayNode83_g235699 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235699).zw + ( (temp_output_203_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699) );
					float4 appendResult210_g235699 = (float4(tex2DArrayNode83_g235699.rgb , tex2DArrayNode83_g235699.a));
					float4 temp_output_204_0_g235699 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g235699 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235699).zw + ( (temp_output_204_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699) );
					float4 appendResult212_g235699 = (float4(tex2DArrayNode122_g235699.rgb , tex2DArrayNode122_g235699.a));
					float4 lerpResult131_g235699 = lerp( appendResult210_g235699 , appendResult212_g235699 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235697 = lerpResult131_g235699;
					float4 lerpResult149_g235697 = lerp( TVE_FlowParams , temp_output_141_109_g235697 , TVE_FlowLayers[(int)temp_output_136_0_g235697]);
					float4 temp_output_594_0_g235664 = lerpResult149_g235697;
					half4 Flow_Texture405_g235664 = temp_output_594_0_g235664;
					float4 In_FlowTexture204_g235664 = Flow_Texture405_g235664;
					half4 User_Texture677_g235664 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g235664 = User_Texture677_g235664;
					BuildGlobalData( Data204_g235664 , In_Dummy204_g235664 , In_CoatTexture204_g235664 , In_DrawTexture204_g235664 , In_PaintTexture204_g235664 , In_AtmoTexture204_g235664 , In_EffexTexture204_g235664 , In_GlowTexture204_g235664 , In_FormTexture204_g235664 , In_LandTexture204_g235664 , In_VertxTexture204_g235664 , In_FlowTexture204_g235664 , In_UserTexture204_g235664 );
					TVEGlobalData Data15_g252006 =(TVEGlobalData)Data204_g235664;
					float Out_Dummy15_g252006 = 0.0;
					float4 Out_CoatTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252006 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252006 = float4( 0,0,0,0 );
					BreakData( Data15_g252006 , Out_Dummy15_g252006 , Out_CoatTexture15_g252006 , Out_DrawTexture15_g252006 , Out_PaintTexture15_g252006 , Out_AtmoTexture15_g252006 , Out_EffexTexture15_g252006 , Out_GlowTexture15_g252006 , Out_FormTexture15_g252006 , Out_LandTexture15_g252006 , Out_VertxTexture15_g252006 , Out_FlowTexture15_g252006 , Out_UserTexture15_g252006 );
					half4 Global_CoatTexture1255_g252005 = Out_CoatTexture15_g252006;
					float temp_output_6_0_g252064 = (Global_CoatTexture1255_g252005).x;
					float temp_output_7_0_g252064 = _SecondCoatMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g252064 = ( temp_output_6_0_g252064 + temp_output_7_0_g252064 );
					#else
					float staticSwitch14_g252064 = temp_output_6_0_g252064;
					#endif
					float temp_output_1044_0_g252005 = staticSwitch14_g252064;
					#ifdef TVE_SECOND_COAT
					float staticSwitch971_g252005 = temp_output_1044_0_g252005;
					#else
					float staticSwitch971_g252005 = temp_output_1256_0_g252005;
					#endif
					float lerpResult1013_g252005 = lerp( 1.0 , staticSwitch971_g252005 , ( _SecondCoatValue * TVE_IsEnabled ));
					half Blend_GlobalMask972_g252005 = lerpResult1013_g252005;
					float temp_output_92_0_g252081 = ( Feature_Intensity1204_g252005 * Blend_GlobalMask972_g252005 );
					half Multiply93_g252081 = ( temp_output_64_0_g252081 * temp_output_92_0_g252081 );
					half Subtract93_g252081 = saturate( ( temp_output_92_0_g252081 - ( 1.0 - temp_output_64_0_g252081 ) ) );
					half Option93_g252081 = _SecondBlendMath;
					half localSwitchBlendMask93_g252081 = SwitchBlendMask( Multiply93_g252081 , Subtract93_g252081 , Option93_g252081 );
					float temp_output_7_0_g252080 = _SecondBlendRemap.x;
					float temp_output_9_0_g252080 = ( localSwitchBlendMask93_g252081 - temp_output_7_0_g252080 );
					half Blend_Mask412_g252005 = ( saturate( ( temp_output_9_0_g252080 * _SecondBlendRemap.z ) ) * _SecondBlendIntensityValue );
					float4 appendResult1126_g252005 = (float4(Blend_Mask412_g252005 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_59 = (0.0).xxxx;
					float4 temp_cast_60 = (0.0).xxxx;
					float4 ifLocalVar18_g252024 = 0;
					if( Feature_Intensity1204_g252005 <= 0.0 )
					ifLocalVar18_g252024 = temp_cast_60;
					else
					ifLocalVar18_g252024 = appendResult1126_g252005;
					float4 In_MaskB3_g252021 = ifLocalVar18_g252024;
					float4 temp_cast_61 = (0.0).xxxx;
					float4 In_MaskC3_g252021 = temp_cast_61;
					float4 temp_cast_62 = (0.0).xxxx;
					float4 In_MaskD3_g252021 = temp_cast_62;
					float4 temp_cast_63 = (0.0).xxxx;
					float4 In_MaskE3_g252021 = temp_cast_63;
					float4 temp_cast_64 = (0.0).xxxx;
					float4 In_MaskF3_g252021 = temp_cast_64;
					float4 temp_cast_65 = (0.0).xxxx;
					float4 In_MaskG3_g252021 = temp_cast_65;
					float4 temp_cast_66 = (0.0).xxxx;
					float4 In_MaskH3_g252021 = temp_cast_66;
					float4 temp_cast_67 = (0.0).xxxx;
					float4 In_MaskI3_g252021 = temp_cast_67;
					float4 temp_cast_68 = (0.0).xxxx;
					float4 In_MaskJ3_g252021 = temp_cast_68;
					float4 temp_cast_69 = (0.0).xxxx;
					float4 In_MaskK3_g252021 = temp_cast_69;
					float4 temp_cast_70 = (0.0).xxxx;
					float4 In_MaskL3_g252021 = temp_cast_70;
					{
					Data3_g252021.MaskA = In_MaskA3_g252021;
					Data3_g252021.MaskB = In_MaskB3_g252021;
					Data3_g252021.MaskC = In_MaskC3_g252021;
					Data3_g252021.MaskD = In_MaskD3_g252021;
					Data3_g252021.MaskE = In_MaskE3_g252021;
					Data3_g252021.MaskF = In_MaskF3_g252021;
					Data3_g252021.MaskG = In_MaskG3_g252021;
					Data3_g252021.MaskH = In_MaskH3_g252021;
					Data3_g252021.MaskI = In_MaskI3_g252021;
					Data3_g252021.MaskJ= In_MaskJ3_g252021;
					Data3_g252021.MaskK= In_MaskK3_g252021;
					Data3_g252021.MaskL = In_MaskL3_g252021;
					}
					TVEMasksData DataB25_g252082 = Data3_g252021;
					float Alpha25_g252082 = TVE_DEBUG_Global;
					{
					if (Alpha25_g252082 < 0.5 )
					{
					Data25_g252082 = DataA25_g252082;
					}
					else
					{
					Data25_g252082 = DataB25_g252082;
					}
					}
					TVEMasksData Data4_g252083 = Data25_g252082;
					float4 Out_MaskA4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g252083 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g252083 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g252083 = Data4_g252083.MaskA;
					Out_MaskB4_g252083 = Data4_g252083.MaskB;
					Out_MaskC4_g252083 = Data4_g252083.MaskC;
					Out_MaskD4_g252083 = Data4_g252083.MaskD;
					Out_MaskE4_g252083 = Data4_g252083.MaskE;
					Out_MaskF4_g252083 = Data4_g252083.MaskF;
					Out_MaskG4_g252083 = Data4_g252083.MaskG;
					Out_MaskH4_g252083 = Data4_g252083.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g252083;
					float3 lerpResult2568 = lerp( color107_g252084 , color106_g252084 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g252088 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g252088 = lerpResult2568;
					float3 ifLocalVar40_g252089 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g252089 = (Out_MaskB4_g252083).xxx;
					float3 color107_g252086 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252086 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g252086 , color106_g252086 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g252090 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g252090 = lerpResult2607;
					half IsTerranShader2496 = _IsTerrainShader;
					float3 lerpResult2660 = lerp( ( ifLocalVar40_g252088 + ifLocalVar40_g252089 + ifLocalVar40_g252090 ) , float3( 0,0,0 ) , IsTerranShader2496);
					half3 Final_Debug2399 = lerpResult2660;
					float temp_output_7_0_g252099 = TVE_DEBUG_Min;
					float3 temp_cast_71 = (temp_output_7_0_g252099).xxx;
					float3 temp_output_9_0_g252099 = ( Final_Debug2399 - temp_cast_71 );
					float lerpResult76_g252092 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g252092 = lerpResult76_g252092;
					float3 lerpResult72_g252092 = lerp( (lerpResult73_g252093).rgb , saturate( ( temp_output_9_0_g252099 / ( ( TVE_DEBUG_Max - temp_output_7_0_g252099 ) + 0.0001 ) ) ) , Filter152_g252092);
					float dotResult61_g252092 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g252092 = ( 1.0 - saturate( dotResult61_g252092 ) );
					float Shading_Fresnel59_g252092 = (( 1.0 - ( temp_output_65_0_g252092 * temp_output_65_0_g252092 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g252092 = IN.ase_texcoord8;
					float depthLinearEye57_g252092 = LinearEyeDepth( ase_positionCS57_g252092.z / ase_positionCS57_g252092.w );
					float temp_output_69_0_g252092 = saturate(  (0.0 + ( depthLinearEye57_g252092 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g252092 = (( temp_output_69_0_g252092 * temp_output_69_0_g252092 )*0.5 + 0.5);
					float lerpResult84_g252092 = lerp( 1.0 , Shading_Fresnel59_g252092 , ( Shading_Distance58_g252092 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g252097 = ( 0.0 );
					TVEVisualData Data4_g252097 =(TVEVisualData)Data3_g251891;
					float Out_Dummy4_g252097 = 0.0;
					float3 Out_Albedo4_g252097 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252097 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252097 = float2( 0,0 );
					float3 Out_NormalWS4_g252097 = float3( 0,0,0 );
					float4 Out_Shader4_g252097 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252097 = float4( 0,0,0,0 );
					float4 Out_Season4_g252097 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252097 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252097 = 0.0;
					float Out_Grayscale4_g252097 = 0.0;
					float Out_Luminosity4_g252097 = 0.0;
					float Out_AlphaClip4_g252097 = 0.0;
					float Out_AlphaFade4_g252097 = 0.0;
					float3 Out_Translucency4_g252097 = float3( 0,0,0 );
					float Out_Transmission4_g252097 = 0.0;
					float Out_Thickness4_g252097 = 0.0;
					float Out_Diffusion4_g252097 = 0.0;
					float Out_Depth4_g252097 = 0.0;
					BreakVisualData( Data4_g252097 , Out_Dummy4_g252097 , Out_Albedo4_g252097 , Out_AlbedoBase4_g252097 , Out_NormalTS4_g252097 , Out_NormalWS4_g252097 , Out_Shader4_g252097 , Out_Feature4_g252097 , Out_Season4_g252097 , Out_Emissive4_g252097 , Out_MultiMask4_g252097 , Out_Grayscale4_g252097 , Out_Luminosity4_g252097 , Out_AlphaClip4_g252097 , Out_AlphaFade4_g252097 , Out_Translucency4_g252097 , Out_Transmission4_g252097 , Out_Thickness4_g252097 , Out_Diffusion4_g252097 , Out_Depth4_g252097 );
					float Alpha109_g252092 = Out_AlphaClip4_g252097;
					float lerpResult91_g252092 = lerp( 1.0 , Alpha109_g252092 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g252092 = lerp( 1.0 , lerpResult91_g252092 , Filter152_g252092);
					clip( lerpResult154_g252092 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2682_114;
					half Occlusion = 1;

					#if defined(ASE_LIGHTING_SIMPLE)
						o.Specular = Specular.x;
						o.Gloss = Smoothness;
					#else
						#if defined(_SPECULAR_SETUP)
							o.Specular = Specular;
						#else
							o.Metallic = Metallic;
						#endif
						o.Occlusion = Occlusion;
						o.Smoothness = Smoothness;
					#endif

					o.Emission = ( lerpResult72_g252092 * lerpResult84_g252092 );
					o.Alpha = 1;

					half3 BakedGI = 0;

					#if defined( ASE_DEPTH_WRITE_ON )
						IN.pos.z = IN.pos.z;
					#endif

					#if ( ASE_FRAGMENT_NORMAL == 0 )
						o.Normal = normalize( o.Normal.x * TangentWS + o.Normal.y * BitangentWS + o.Normal.z * NormalWS );
					#elif ( ASE_FRAGMENT_NORMAL == 1 )
						o.Normal = UnityObjectToWorldNormal( o.Normal );
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						// @diogo: already in world-space; do nothing
					#endif

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifndef USING_DIRECTIONAL_LIGHT
						half3 lightDir = normalize( UnityWorldSpaceLightDir( PositionWS ) );
					#else
						half3 lightDir = _WorldSpaceLightPos0.xyz;
					#endif

					UnityGI gi;
					UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
					gi.indirect.diffuse = 0;
					gi.indirect.specular = 0;
					gi.light.color = 0;
					gi.light.dir = half3( 0, 1, 0 );

					UnityGIInput giInput;
					UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
					giInput.light = gi.light;
					giInput.worldPos = PositionWS;
					giInput.worldViewDir = ViewDirWS;
					giInput.atten = 1;

					#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
						giInput.lightmapUV = IN.ambientOrLightmapUV;
					#else
						giInput.lightmapUV = 0.0;
					#endif

					// #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					// 	giInput.ambient = IN.ambientOrLightmapUV.rgb;
					// #else
					// 	giInput.ambient.rgb = 0.0;
					// #endif

					#if UNITY_SHOULD_SAMPLE_SH
						#ifdef UNITY_COLORSPACE_GAMMA
							giInput.ambient.rgb = GammaToLinearSpace (IN.ambientOrLightmapUV.rgb);
						#endif
							giInput.ambient.rgb += SHEvalLinearL2 (half4(o.Normal, 1.0));
					#else
						giInput.ambient.rgb = 0.0;
					#endif

					giInput.probeHDR[0] = unity_SpecCube0_HDR;
					giInput.probeHDR[1] = unity_SpecCube1_HDR;
					#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
						giInput.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif
					#ifdef UNITY_SPECCUBE_BOX_PROJECTION
						giInput.boxMax[0] = unity_SpecCube0_BoxMax;
						giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
						giInput.boxMax[1] = unity_SpecCube1_BoxMax;
						giInput.boxMin[1] = unity_SpecCube1_BoxMin;
						giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							LightingBlinnPhong_GI(o, giInput, gi);
						#else
							LightingLambert_GI(o, giInput, gi);
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							LightingStandardSpecular_GI(o, giInput, gi);
						#else
							LightingStandard_GI(o, giInput, gi);
						#endif
					#endif

					#ifdef ASE_BAKEDGI
						gi.indirect.diffuse = BakedGI;
					#endif

					#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
						gi.indirect.diffuse = 0;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							outEmission = LightingBlinnPhong_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#else
							outEmission = LightingLambert_Deferred( o, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							outEmission = LightingStandardSpecular_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#else
							outEmission = LightingStandard_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#endif
					#endif

					#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
						outShadowMask = UnityGetRawBakedOcclusions( IN.ambientOrLightmapUV.xy, float3( 0, 0, 0 ) );
					#endif
					#ifndef UNITY_HDR_ON
						outEmission.rgb = exp2(-outEmission.rgb);
					#endif
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19912
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2

				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				int _ObjectId;
				int _PassValue;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform half _ObjectCoordMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_EffexParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexBaseTex);
				uniform float4 TVE_EffexBaseCoord;
				uniform half _GlobalEffexPivotValue;
				uniform half _GlobalEffexLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexNearTex);
				uniform float4 TVE_EffexNearCoord;
				uniform float TVE_EffexLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_VertxParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxBaseTex);
				uniform float4 TVE_VertxBaseCoord;
				uniform half _GlobalVertxPivotValue;
				uniform half _GlobalVertxLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxNearTex);
				uniform float4 TVE_VertxNearCoord;
				uniform float TVE_VertxLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half4 In_TangentOS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.TangentOS = In_TangentOS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				void BuildVertexData( inout TVEVertexData Data, half In_Dummy, float3 In_PositionOS, half3 In_NormalOS, half4 In_TangentOS, half4 In_TransformData, half4 In_RotationData, float4 In_Interpolator )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.NormalOS = In_NormalOS;
					Data.TangentOS = In_TangentOS;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.Interpolator = In_Interpolator;
					return;
				}
				
				void BreakVertexData( inout TVEVertexData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_NormalOS, out half4 Out_TangentOS, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_NormalOS = Data.NormalOS;
					Out_TangentOS = Data.TangentOS;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				half3 ComputeTriplanarMasks( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatTexture, half4 In_DrawTexture, half4 In_PaintTexture, half4 In_AtmoTexture, half4 In_EffexTexture, half4 In_GlowTexture, float4 In_FormTexture, float4 In_LandTexture, float4 In_VertxTexture, float4 In_FlowTexture, half4 In_UserTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatTexture = In_CoatTexture;
					Data.DrawTexture = In_DrawTexture;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoTexture = In_AtmoTexture;
					Data.EffexTexture = In_EffexTexture;
					Data.GlowTexture = In_GlowTexture;
					Data.FormTexture = In_FormTexture;
					Data.LandTexture = In_LandTexture;
					Data.VertxTexture = In_VertxTexture;
					Data.FlowTexture = In_FlowTexture;
					Data.UserTexture = In_UserTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatTexture, out half4 Out_DrawTexture, out half4 Out_PaintTexture, out half4 Out_AtmoTexture, out half4 Out_EffexTexture, out half4 Out_GlowTexture, out float4 Out_FormTexture, out float4 Out_LandTexture, out half4 Out_VertxTexture, out half4 Out_FlowTexture, out half4 Out_UserTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatTexture = Data.CoatTexture;
					Out_DrawTexture = Data.DrawTexture;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_EffexTexture= Data.EffexTexture;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormTexture = Data.FormTexture;
					Out_LandTexture = Data.LandTexture;
					Out_VertxTexture = Data.VertxTexture;
					Out_FlowTexture = Data.FlowTexture;
					Out_UserTexture = Data.UserTexture;
					return;
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251664 =(TVEVertexData)0;
					float In_Dummy16_g251664 = 0.0;
					TVEVertexData Data16_g251659 =(TVEVertexData)0;
					float In_Dummy16_g251659 = 0.0;
					TVEModelData Data16_g235783 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#else
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#endif
					half Dummy207_g235765 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g235765 );
					float temp_output_14_0_g235783 = Dummy207_g235765;
					float In_Dummy16_g235783 = temp_output_14_0_g235783;
					float3 PositionOS131_g235765 = v.vertex.xyz;
					float3 temp_output_4_0_g235783 = PositionOS131_g235765;
					float3 In_PositionOS16_g235783 = temp_output_4_0_g235783;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g235765 = ase_positionWS;
					float3 vertexToFrag73_g235765 = temp_output_104_7_g235765;
					float3 PositionWS122_g235765 = vertexToFrag73_g235765;
					float3 In_PositionWS16_g235783 = PositionWS122_g235765;
					float4x4 break19_g235768 = unity_ObjectToWorld;
					float3 appendResult20_g235768 = (float3(break19_g235768[ 0 ][ 3 ] , break19_g235768[ 1 ][ 3 ] , break19_g235768[ 2 ][ 3 ]));
					float3 temp_output_340_7_g235765 = appendResult20_g235768;
					float4x4 break19_g235770 = unity_ObjectToWorld;
					float3 appendResult20_g235770 = (float3(break19_g235770[ 0 ][ 3 ] , break19_g235770[ 1 ][ 3 ] , break19_g235770[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g235766 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g235765 = PositionOS131_g235765;
					float3 appendResult234_g235765 = (float3(break233_g235765.x , 0.0 , break233_g235765.z));
					float3 break413_g235765 = PositionOS131_g235765;
					float3 appendResult414_g235765 = (float3(break413_g235765.x , break413_g235765.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g235772 = appendResult414_g235765;
					#else
					float3 staticSwitch65_g235772 = appendResult234_g235765;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g235765 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g235765 = appendResult60_g235766;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g235765 = staticSwitch65_g235772;
					#else
					float3 staticSwitch229_g235765 = _Vector0;
					#endif
					float3 PivotOS149_g235765 = staticSwitch229_g235765;
					float3 temp_output_122_0_g235770 = PivotOS149_g235765;
					float3 PivotsOnlyWS105_g235770 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g235770 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g235765 = ( appendResult20_g235770 + PivotsOnlyWS105_g235770 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#else
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#endif
					float3 vertexToFrag76_g235765 = staticSwitch236_g235765;
					float3 PivotWS121_g235765 = vertexToFrag76_g235765;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g235765 = ( PositionWS122_g235765 - PivotWS121_g235765 );
					#else
					float3 staticSwitch204_g235765 = PositionWS122_g235765;
					#endif
					float3 PositionWO132_g235765 = ( staticSwitch204_g235765 - TVE_WorldOrigin );
					float3 In_PositionWO16_g235783 = PositionWO132_g235765;
					float3 In_PivotOS16_g235783 = PivotOS149_g235765;
					float3 In_PivotWS16_g235783 = PivotWS121_g235765;
					float3 PivotWO133_g235765 = ( PivotWS121_g235765 - TVE_WorldOrigin );
					float3 In_PivotWO16_g235783 = PivotWO133_g235765;
					half3 NormalOS134_g235765 = v.normal;
					float3 temp_output_21_0_g235783 = NormalOS134_g235765;
					float3 In_NormalOS16_g235783 = temp_output_21_0_g235783;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g235765 = normalizedWorldNormal;
					float3 In_NormalWS16_g235783 = NormalWS95_g235765;
					half4 TangentlOS153_g235765 = v.tangent;
					float4 temp_output_6_0_g235783 = TangentlOS153_g235765;
					float4 In_TangentOS16_g235783 = temp_output_6_0_g235783;
					float3 normalizeResult296_g235765 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g235765 ) );
					half3 ViewDirWS169_g235765 = normalizeResult296_g235765;
					float3 In_ViewDirWS16_g235783 = ViewDirWS169_g235765;
					float4 appendResult397_g235765 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g235765 = appendResult397_g235765;
					float4 In_CoordsData16_g235783 = CoordsData398_g235765;
					half4 VertexMasks171_g235765 = v.ase_color;
					float4 In_VertexData16_g235783 = VertexMasks171_g235765;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235777 = (PositionOS131_g235765).z;
					#else
					float staticSwitch65_g235777 = (PositionOS131_g235765).y;
					#endif
					half Object_HeightValue267_g235765 = _ObjectHeightValue;
					half Bounds_HeightMask274_g235765 = saturate( ( staticSwitch65_g235777 / Object_HeightValue267_g235765 ) );
					half3 Position387_g235765 = PositionOS131_g235765;
					half Height387_g235765 = Object_HeightValue267_g235765;
					half Object_RadiusValue268_g235765 = _ObjectRadiusValue;
					half Radius387_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskYUp387_g235765 = CapsuleMaskYUp( Position387_g235765 , Height387_g235765 , Radius387_g235765 );
					half3 Position408_g235765 = PositionOS131_g235765;
					half Height408_g235765 = Object_HeightValue267_g235765;
					half Radius408_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskZUp408_g235765 = CapsuleMaskZUp( Position408_g235765 , Height408_g235765 , Radius408_g235765 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235782 = saturate( localCapsuleMaskZUp408_g235765 );
					#else
					float staticSwitch65_g235782 = saturate( localCapsuleMaskYUp387_g235765 );
					#endif
					half Bounds_SphereMask282_g235765 = staticSwitch65_g235782;
					float4 appendResult253_g235765 = (float4(Bounds_HeightMask274_g235765 , Bounds_SphereMask282_g235765 , 1.0 , 1.0));
					half4 MasksData254_g235765 = appendResult253_g235765;
					float4 In_MasksData16_g235783 = MasksData254_g235765;
					float temp_output_17_0_g235776 = _ObjectPhaseMode;
					float Option70_g235776 = temp_output_17_0_g235776;
					float4 temp_output_3_0_g235776 = v.ase_color;
					float4 Channel70_g235776 = temp_output_3_0_g235776;
					float localSwitchChannel470_g235776 = SwitchChannel4( Option70_g235776 , Channel70_g235776 );
					half Phase_Value372_g235765 = localSwitchChannel470_g235776;
					float3 break319_g235765 = PivotWO133_g235765;
					half Pivot_Position322_g235765 = ( break319_g235765.x + break319_g235765.z );
					half Phase_Position357_g235765 = ( Phase_Value372_g235765 + Pivot_Position322_g235765 );
					float temp_output_248_0_g235765 = frac( Phase_Position357_g235765 );
					float4 appendResult177_g235765 = (float4((frac( ( Phase_Position357_g235765 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g235765));
					half4 Phase_Data176_g235765 = appendResult177_g235765;
					float4 In_PhaseData16_g235783 = Phase_Data176_g235765;
					BuildModelVertData( Data16_g235783 , In_Dummy16_g235783 , In_PositionOS16_g235783 , In_PositionWS16_g235783 , In_PositionWO16_g235783 , In_PivotOS16_g235783 , In_PivotWS16_g235783 , In_PivotWO16_g235783 , In_NormalOS16_g235783 , In_NormalWS16_g235783 , In_TangentOS16_g235783 , In_ViewDirWS16_g235783 , In_CoordsData16_g235783 , In_VertexData16_g235783 , In_MasksData16_g235783 , In_PhaseData16_g235783 );
					TVEModelData Data15_g251660 =(TVEModelData)Data16_g235783;
					float Out_Dummy15_g251660 = 0.0;
					float3 Out_PositionOS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251660 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251660 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251660 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251660 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251660 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251660 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251660 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251660 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251660 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251660 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251660 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251660 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251660 , Out_Dummy15_g251660 , Out_PositionOS15_g251660 , Out_PositionWS15_g251660 , Out_PositionWO15_g251660 , Out_PositionRawOS15_g251660 , Out_PivotOS15_g251660 , Out_PivotWS15_g251660 , Out_PivotWO15_g251660 , Out_NormalOS15_g251660 , Out_NormalWS15_g251660 , Out_NormalRawOS15_g251660 , Out_TangentOS15_g251660 , Out_TangentWS15_g251660 , Out_BitangentWS15_g251660 , Out_ViewDirWS15_g251660 , Out_CoordsData15_g251660 , Out_VertexData15_g251660 , Out_MasksData15_g251660 , Out_PhaseData15_g251660 , Out_TransformData15_g251660 , Out_RotationData15_g251660 , Out_Interpolator15_g251660 );
					float3 In_PositionOS16_g251659 = Out_PositionOS15_g251660;
					float3 In_NormalOS16_g251659 = Out_NormalOS15_g251660;
					float4 In_TangentOS16_g251659 = Out_TangentOS15_g251660;
					float4 In_TransformData16_g251659 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251659 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251659 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251659 , In_Dummy16_g251659 , In_PositionOS16_g251659 , In_NormalOS16_g251659 , In_TangentOS16_g251659 , In_TransformData16_g251659 , In_RotationData16_g251659 , In_Interpolator16_g251659 );
					TVEVertexData Data15_g251662 =(TVEVertexData)Data16_g251659;
					float Out_Dummy15_g251662 = 0.0;
					float3 Out_PositionOS15_g251662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251662 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251662 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251662 , Out_Dummy15_g251662 , Out_PositionOS15_g251662 , Out_NormalOS15_g251662 , Out_TangentOS15_g251662 , Out_TransformData15_g251662 , Out_RotationData15_g251662 , Out_Interpolator15_g251662 );
					TVEModelData Data15_g251663 =(TVEModelData)Data15_g251660;
					float Out_Dummy15_g251663 = 0.0;
					float3 Out_PositionOS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251663 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251663 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251663 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251663 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251663 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251663 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251663 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251663 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251663 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251663 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251663 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251663 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251663 , Out_Dummy15_g251663 , Out_PositionOS15_g251663 , Out_PositionWS15_g251663 , Out_PositionWO15_g251663 , Out_PositionRawOS15_g251663 , Out_PivotOS15_g251663 , Out_PivotWS15_g251663 , Out_PivotWO15_g251663 , Out_NormalOS15_g251663 , Out_NormalWS15_g251663 , Out_NormalRawOS15_g251663 , Out_TangentOS15_g251663 , Out_TangentWS15_g251663 , Out_BitangentWS15_g251663 , Out_ViewDirWS15_g251663 , Out_CoordsData15_g251663 , Out_VertexData15_g251663 , Out_MasksData15_g251663 , Out_PhaseData15_g251663 , Out_TransformData15_g251663 , Out_RotationData15_g251663 , Out_Interpolator15_g251663 );
					float3 In_PositionOS16_g251664 = ( Out_PositionOS15_g251662 - Out_PivotOS15_g251663 );
					float3 In_NormalOS16_g251664 = Out_NormalOS15_g251663;
					float4 In_TangentOS16_g251664 = Out_TangentOS15_g251663;
					float4 In_TransformData16_g251664 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251664 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251664 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251664 , In_Dummy16_g251664 , In_PositionOS16_g251664 , In_NormalOS16_g251664 , In_TangentOS16_g251664 , In_TransformData16_g251664 , In_RotationData16_g251664 , In_Interpolator16_g251664 );
					TVEVertexData Data15_g251673 =(TVEVertexData)Data16_g251664;
					float Out_Dummy15_g251673 = 0.0;
					float3 Out_PositionOS15_g251673 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251673 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251673 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251673 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251673 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251673 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251673 , Out_Dummy15_g251673 , Out_PositionOS15_g251673 , Out_NormalOS15_g251673 , Out_TangentOS15_g251673 , Out_TransformData15_g251673 , Out_RotationData15_g251673 , Out_Interpolator15_g251673 );
					TVEVertexData Data16_g251674 =(TVEVertexData)Data15_g251673;
					half Dummy317_g251665 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251674 = Dummy317_g251665;
					float3 In_PositionOS16_g251674 = Out_PositionOS15_g251673;
					float3 In_NormalOS16_g251674 = Out_NormalOS15_g251673;
					float4 In_TangentOS16_g251674 = Out_TangentOS15_g251673;
					half4 Model_TransformData356_g251665 = Out_TransformData15_g251673;
					float localBuildGlobalData204_g235664 = ( 0.0 );
					TVEGlobalData Data204_g235664 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g235664 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g235664 = Dummy211_g235664;
					float4 temp_output_203_0_g235683 = TVE_CoatBaseCoord;
					TVEModelData Data16_g235773 =(TVEModelData)0;
					float In_Dummy16_g235773 = 0.0;
					float3 In_PositionWS16_g235773 = PositionWS122_g235765;
					float3 In_PositionWO16_g235773 = PositionWO132_g235765;
					float3 In_PivotWS16_g235773 = PivotWS121_g235765;
					float3 In_PivotWO16_g235773 = PivotWO133_g235765;
					float3 In_NormalWS16_g235773 = NormalWS95_g235765;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g235765 = ase_tangentWS;
					float3 In_TangentWS16_g235773 = TangentWS136_g235765;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g235765 = ase_bitangentWS;
					float3 In_BitangentWS16_g235773 = BiangentWS421_g235765;
					half3 NormalWS427_g235765 = NormalWS95_g235765;
					half3 localComputeTriplanarMasks427_g235765 = ComputeTriplanarMasks( NormalWS427_g235765 );
					half3 TriplanarWeights429_g235765 = localComputeTriplanarMasks427_g235765;
					float3 In_TriplanarWeights16_g235773 = TriplanarWeights429_g235765;
					float3 In_ViewDirWS16_g235773 = ViewDirWS169_g235765;
					float4 In_CoordsData16_g235773 = CoordsData398_g235765;
					float4 In_VertexData16_g235773 = VertexMasks171_g235765;
					float4 In_Interpolator16_g235773 = Phase_Data176_g235765;
					BuildModelFragData( Data16_g235773 , In_Dummy16_g235773 , In_PositionWS16_g235773 , In_PositionWO16_g235773 , In_PivotWS16_g235773 , In_PivotWO16_g235773 , In_NormalWS16_g235773 , In_TangentWS16_g235773 , In_BitangentWS16_g235773 , In_TriplanarWeights16_g235773 , In_ViewDirWS16_g235773 , In_CoordsData16_g235773 , In_VertexData16_g235773 , In_Interpolator16_g235773 );
					TVEModelData Data15_g235754 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g235754 = 0.0;
					float3 Out_PositionWS15_g235754 = float3( 0,0,0 );
					float3 Out_PositionWO15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWS15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWO15_g235754 = float3( 0,0,0 );
					float3 Out_NormalWS15_g235754 = float3( 0,0,0 );
					float3 Out_TangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g235754 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g235754 = float3( 0,0,0 );
					float4 Out_CoordsData15_g235754 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g235754 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g235754 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g235754 , Out_Dummy15_g235754 , Out_PositionWS15_g235754 , Out_PositionWO15_g235754 , Out_PivotWS15_g235754 , Out_PivotWO15_g235754 , Out_NormalWS15_g235754 , Out_TangentWS15_g235754 , Out_BitangentWS15_g235754 , Out_TriplanarWeights15_g235754 , Out_ViewDirWS15_g235754 , Out_CoordsData15_g235754 , Out_VertexData15_g235754 , Out_Interpolator15_g235754 );
					float3 Model_PositionWS497_g235664 = Out_PositionWS15_g235754;
					float2 Model_PositionWS_XZ143_g235664 = (Model_PositionWS497_g235664).xz;
					float3 Model_PivotWS498_g235664 = Out_PivotWS15_g235754;
					float2 Model_PivotWS_XZ145_g235664 = (Model_PivotWS498_g235664).xz;
					float2 lerpResult300_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g235683 = lerpResult300_g235664;
					float temp_output_82_0_g235681 = _GlobalCoatLayerValue;
					float temp_output_82_0_g235683 = temp_output_82_0_g235681;
					float4 tex2DArrayNode83_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235683).zw + ( (temp_output_203_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult210_g235683 = (float4(tex2DArrayNode83_g235683.rgb , tex2DArrayNode83_g235683.a));
					float4 temp_output_204_0_g235683 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235683).zw + ( (temp_output_204_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult212_g235683 = (float4(tex2DArrayNode122_g235683.rgb , tex2DArrayNode122_g235683.a));
					float4 TVE_RenderNearPositionR628_g235664 = TVE_RenderNearPositionR;
					float temp_output_507_0_g235664 = saturate( ( distance( Model_PositionWS497_g235664 , (TVE_RenderNearPositionR628_g235664).xyz ) / (TVE_RenderNearPositionR628_g235664).w ) );
					float temp_output_7_0_g235753 = 1.0;
					float temp_output_9_0_g235753 = ( temp_output_507_0_g235664 - temp_output_7_0_g235753 );
					half TVE_RenderNearFadeValue635_g235664 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g235664 = saturate( ( temp_output_9_0_g235753 / ( ( TVE_RenderNearFadeValue635_g235664 - temp_output_7_0_g235753 ) + 0.0001 ) ) );
					float4 lerpResult131_g235683 = lerp( appendResult210_g235683 , appendResult212_g235683 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235681 = lerpResult131_g235683;
					float4 lerpResult168_g235681 = lerp( TVE_CoatParams , temp_output_159_109_g235681 , TVE_CoatLayers[(int)temp_output_82_0_g235681]);
					float4 temp_output_589_109_g235664 = lerpResult168_g235681;
					half4 Coat_Texture302_g235664 = temp_output_589_109_g235664;
					float4 In_CoatTexture204_g235664 = Coat_Texture302_g235664;
					half4 Draw_Texture656_g235664 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g235664 = Draw_Texture656_g235664;
					float4 temp_output_203_0_g235708 = TVE_PaintBaseCoord;
					float2 lerpResult85_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g235708 = lerpResult85_g235664;
					float temp_output_82_0_g235705 = _GlobalPaintLayerValue;
					float temp_output_82_0_g235708 = temp_output_82_0_g235705;
					float4 tex2DArrayNode83_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235708).zw + ( (temp_output_203_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult210_g235708 = (float4(tex2DArrayNode83_g235708.rgb , tex2DArrayNode83_g235708.a));
					float4 temp_output_204_0_g235708 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235708).zw + ( (temp_output_204_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult212_g235708 = (float4(tex2DArrayNode122_g235708.rgb , tex2DArrayNode122_g235708.a));
					float4 lerpResult131_g235708 = lerp( appendResult210_g235708 , appendResult212_g235708 , Global_TexBlend509_g235664);
					float4 temp_output_171_109_g235705 = lerpResult131_g235708;
					float4 lerpResult174_g235705 = lerp( TVE_PaintParams , temp_output_171_109_g235705 , TVE_PaintLayers[(int)temp_output_82_0_g235705]);
					float4 temp_output_595_109_g235664 = lerpResult174_g235705;
					half4 Paint_Texture71_g235664 = temp_output_595_109_g235664;
					float4 In_PaintTexture204_g235664 = Paint_Texture71_g235664;
					float4 temp_output_203_0_g235691 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g235691 = lerpResult104_g235664;
					float temp_output_132_0_g235689 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g235691 = temp_output_132_0_g235689;
					float4 tex2DArrayNode83_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235691).zw + ( (temp_output_203_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult210_g235691 = (float4(tex2DArrayNode83_g235691.rgb , tex2DArrayNode83_g235691.a));
					float4 temp_output_204_0_g235691 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235691).zw + ( (temp_output_204_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult212_g235691 = (float4(tex2DArrayNode122_g235691.rgb , tex2DArrayNode122_g235691.a));
					float4 lerpResult131_g235691 = lerp( appendResult210_g235691 , appendResult212_g235691 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235689 = lerpResult131_g235691;
					float4 lerpResult145_g235689 = lerp( TVE_AtmoParams , temp_output_137_109_g235689 , TVE_AtmoLayers[(int)temp_output_132_0_g235689]);
					float4 temp_output_590_110_g235664 = lerpResult145_g235689;
					half4 Atmo_Texture80_g235664 = temp_output_590_110_g235664;
					float4 In_AtmoTexture204_g235664 = Atmo_Texture80_g235664;
					float4 temp_output_203_0_g235759 = TVE_EffexBaseCoord;
					float2 lerpResult414_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g235759 = lerpResult414_g235664;
					float temp_output_132_0_g235757 = _GlobalEffexLayerValue;
					float temp_output_82_0_g235759 = temp_output_132_0_g235757;
					float4 tex2DArrayNode83_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235759).zw + ( (temp_output_203_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult210_g235759 = (float4(tex2DArrayNode83_g235759.rgb , tex2DArrayNode83_g235759.a));
					float4 temp_output_204_0_g235759 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235759).zw + ( (temp_output_204_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult212_g235759 = (float4(tex2DArrayNode122_g235759.rgb , tex2DArrayNode122_g235759.a));
					float4 lerpResult131_g235759 = lerp( appendResult210_g235759 , appendResult212_g235759 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235757 = lerpResult131_g235759;
					float4 lerpResult145_g235757 = lerp( TVE_EffexParams , temp_output_137_109_g235757 , TVE_EffexLayers[(int)temp_output_132_0_g235757]);
					float4 temp_output_731_110_g235664 = lerpResult145_g235757;
					half4 Effex_Texture420_g235664 = temp_output_731_110_g235664;
					float4 In_EffexTexture204_g235664 = Effex_Texture420_g235664;
					float4 temp_output_203_0_g235739 = TVE_GlowBaseCoord;
					float2 lerpResult247_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g235739 = lerpResult247_g235664;
					float temp_output_82_0_g235737 = _GlobalGlowLayerValue;
					float temp_output_82_0_g235739 = temp_output_82_0_g235737;
					float4 tex2DArrayNode83_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235739).zw + ( (temp_output_203_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult210_g235739 = (float4(tex2DArrayNode83_g235739.rgb , tex2DArrayNode83_g235739.a));
					float4 temp_output_204_0_g235739 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235739).zw + ( (temp_output_204_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult212_g235739 = (float4(tex2DArrayNode122_g235739.rgb , tex2DArrayNode122_g235739.a));
					float4 lerpResult131_g235739 = lerp( appendResult210_g235739 , appendResult212_g235739 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235737 = lerpResult131_g235739;
					float4 lerpResult167_g235737 = lerp( TVE_GlowParams , temp_output_159_109_g235737 , TVE_GlowLayers[(int)temp_output_82_0_g235737]);
					float4 temp_output_593_109_g235664 = lerpResult167_g235737;
					half4 Glow_Texture248_g235664 = temp_output_593_109_g235664;
					float4 In_GlowTexture204_g235664 = Glow_Texture248_g235664;
					float4 temp_output_203_0_g235675 = TVE_FormBaseCoord;
					float2 lerpResult168_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g235675 = lerpResult168_g235664;
					float temp_output_130_0_g235673 = _GlobalFormLayerValue;
					float temp_output_82_0_g235675 = temp_output_130_0_g235673;
					float4 tex2DArrayNode83_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235675).zw + ( (temp_output_203_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult210_g235675 = (float4(tex2DArrayNode83_g235675.rgb , tex2DArrayNode83_g235675.a));
					float4 temp_output_204_0_g235675 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235675).zw + ( (temp_output_204_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult212_g235675 = (float4(tex2DArrayNode122_g235675.rgb , tex2DArrayNode122_g235675.a));
					float4 lerpResult131_g235675 = lerp( appendResult210_g235675 , appendResult212_g235675 , Global_TexBlend509_g235664);
					float4 temp_output_135_109_g235673 = lerpResult131_g235675;
					float4 lerpResult143_g235673 = lerp( TVE_FormParams , temp_output_135_109_g235673 , TVE_FormLayers[(int)temp_output_130_0_g235673]);
					float4 temp_output_592_0_g235664 = lerpResult143_g235673;
					float4 Form_Texture112_g235664 = temp_output_592_0_g235664;
					float4 In_FormTexture204_g235664 = Form_Texture112_g235664;
					float4 In_LandTexture204_g235664 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g235723 = TVE_VertxBaseCoord;
					float2 lerpResult681_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g235723 = lerpResult681_g235664;
					float temp_output_136_0_g235721 = _GlobalVertxLayerValue;
					float temp_output_82_0_g235723 = temp_output_136_0_g235721;
					float4 tex2DArrayNode83_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235723).zw + ( (temp_output_203_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult210_g235723 = (float4(tex2DArrayNode83_g235723.rgb , tex2DArrayNode83_g235723.a));
					float4 temp_output_204_0_g235723 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235723).zw + ( (temp_output_204_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult212_g235723 = (float4(tex2DArrayNode122_g235723.rgb , tex2DArrayNode122_g235723.a));
					float4 lerpResult131_g235723 = lerp( appendResult210_g235723 , appendResult212_g235723 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235721 = lerpResult131_g235723;
					float4 lerpResult149_g235721 = lerp( TVE_VertxParams , temp_output_141_109_g235721 , TVE_VertxLayers[(int)temp_output_136_0_g235721]);
					float4 temp_output_695_0_g235664 = lerpResult149_g235721;
					half4 Vertx_Texture693_g235664 = temp_output_695_0_g235664;
					float4 In_VertxTexture204_g235664 = Vertx_Texture693_g235664;
					float4 temp_output_203_0_g235699 = TVE_FlowBaseCoord;
					float2 lerpResult400_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g235699 = lerpResult400_g235664;
					float temp_output_136_0_g235697 = _GlobalFlowLayerValue;
					float temp_output_82_0_g235699 = temp_output_136_0_g235697;
					float4 tex2DArrayNode83_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235699).zw + ( (temp_output_203_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult210_g235699 = (float4(tex2DArrayNode83_g235699.rgb , tex2DArrayNode83_g235699.a));
					float4 temp_output_204_0_g235699 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235699).zw + ( (temp_output_204_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult212_g235699 = (float4(tex2DArrayNode122_g235699.rgb , tex2DArrayNode122_g235699.a));
					float4 lerpResult131_g235699 = lerp( appendResult210_g235699 , appendResult212_g235699 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235697 = lerpResult131_g235699;
					float4 lerpResult149_g235697 = lerp( TVE_FlowParams , temp_output_141_109_g235697 , TVE_FlowLayers[(int)temp_output_136_0_g235697]);
					float4 temp_output_594_0_g235664 = lerpResult149_g235697;
					half4 Flow_Texture405_g235664 = temp_output_594_0_g235664;
					float4 In_FlowTexture204_g235664 = Flow_Texture405_g235664;
					half4 User_Texture677_g235664 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g235664 = User_Texture677_g235664;
					BuildGlobalData( Data204_g235664 , In_Dummy204_g235664 , In_CoatTexture204_g235664 , In_DrawTexture204_g235664 , In_PaintTexture204_g235664 , In_AtmoTexture204_g235664 , In_EffexTexture204_g235664 , In_GlowTexture204_g235664 , In_FormTexture204_g235664 , In_LandTexture204_g235664 , In_VertxTexture204_g235664 , In_FlowTexture204_g235664 , In_UserTexture204_g235664 );
					TVEGlobalData Data15_g251675 =(TVEGlobalData)Data204_g235664;
					float Out_Dummy15_g251675 = 0.0;
					float4 Out_CoatTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251675 = float4( 0,0,0,0 );
					BreakData( Data15_g251675 , Out_Dummy15_g251675 , Out_CoatTexture15_g251675 , Out_DrawTexture15_g251675 , Out_PaintTexture15_g251675 , Out_AtmoTexture15_g251675 , Out_EffexTexture15_g251675 , Out_GlowTexture15_g251675 , Out_FormTexture15_g251675 , Out_LandTexture15_g251675 , Out_VertxTexture15_g251675 , Out_FlowTexture15_g251675 , Out_UserTexture15_g251675 );
					float4 Global_FormTexture351_g251665 = Out_FormTexture15_g251675;
					TVEModelData Data15_g251672 =(TVEModelData)Data15_g251663;
					float Out_Dummy15_g251672 = 0.0;
					float3 Out_PositionOS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251672 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251672 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251672 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251672 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251672 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251672 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251672 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251672 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251672 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251672 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251672 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251672 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251672 , Out_Dummy15_g251672 , Out_PositionOS15_g251672 , Out_PositionWS15_g251672 , Out_PositionWO15_g251672 , Out_PositionRawOS15_g251672 , Out_PivotOS15_g251672 , Out_PivotWS15_g251672 , Out_PivotWO15_g251672 , Out_NormalOS15_g251672 , Out_NormalWS15_g251672 , Out_NormalRawOS15_g251672 , Out_TangentOS15_g251672 , Out_TangentWS15_g251672 , Out_BitangentWS15_g251672 , Out_ViewDirWS15_g251672 , Out_CoordsData15_g251672 , Out_VertexData15_g251672 , Out_MasksData15_g251672 , Out_PhaseData15_g251672 , Out_TransformData15_g251672 , Out_RotationData15_g251672 , Out_Interpolator15_g251672 );
					float3 Model_PivotWO353_g251665 = Out_PivotWO15_g251672;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251671 = _ConformMeshMode;
					float Option70_g251671 = temp_output_17_0_g251671;
					half4 Model_VertexData357_g251665 = Out_VertexData15_g251672;
					float4 temp_output_3_0_g251671 = Model_VertexData357_g251665;
					float4 Channel70_g251671 = temp_output_3_0_g251671;
					float localSwitchChannel470_g251671 = SwitchChannel4( Option70_g251671 , Channel70_g251671 );
					float temp_output_390_0_g251665 = localSwitchChannel470_g251671;
					float temp_output_7_0_g251668 = _ConformMeshRemap.x;
					float temp_output_9_0_g251668 = ( temp_output_390_0_g251665 - temp_output_7_0_g251668 );
					float lerpResult374_g251665 = lerp( 1.0 , saturate( ( temp_output_9_0_g251668 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251665 = lerpResult374_g251665;
					float temp_output_328_0_g251665 = ( Blend_VertMask379_g251665 * TVE_IsEnabled );
					half Conform_Mask366_g251665 = temp_output_328_0_g251665;
					float temp_output_322_0_g251665 = ( ( ( ( (Global_FormTexture351_g251665).z - ( (Model_PivotWO353_g251665).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251665 ) );
					float3 appendResult329_g251665 = (float3(0.0 , temp_output_322_0_g251665 , 0.0));
					float3 appendResult387_g251665 = (float3(0.0 , 0.0 , temp_output_322_0_g251665));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251669 = appendResult387_g251665;
					#else
					float3 staticSwitch65_g251669 = appendResult329_g251665;
					#endif
					float3 Blanket_Conform368_g251665 = staticSwitch65_g251669;
					float4 appendResult312_g251665 = (float4(Blanket_Conform368_g251665 , 0.0));
					float4 temp_output_310_0_g251665 = ( Model_TransformData356_g251665 + appendResult312_g251665 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251665 = temp_output_310_0_g251665;
					#else
					float4 staticSwitch364_g251665 = Model_TransformData356_g251665;
					#endif
					half4 Final_TransformData365_g251665 = staticSwitch364_g251665;
					float4 In_TransformData16_g251674 = Final_TransformData365_g251665;
					float4 In_RotationData16_g251674 = Out_RotationData15_g251673;
					float4 In_Interpolator16_g251674 = Out_Interpolator15_g251673;
					BuildVertexData( Data16_g251674 , In_Dummy16_g251674 , In_PositionOS16_g251674 , In_NormalOS16_g251674 , In_TangentOS16_g251674 , In_TransformData16_g251674 , In_RotationData16_g251674 , In_Interpolator16_g251674 );
					TVEVertexData Data15_g251685 =(TVEVertexData)Data16_g251674;
					float Out_Dummy15_g251685 = 0.0;
					float3 Out_PositionOS15_g251685 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251685 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251685 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251685 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251685 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251685 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251685 , Out_Dummy15_g251685 , Out_PositionOS15_g251685 , Out_NormalOS15_g251685 , Out_TangentOS15_g251685 , Out_TransformData15_g251685 , Out_RotationData15_g251685 , Out_Interpolator15_g251685 );
					TVEVertexData Data16_g251686 =(TVEVertexData)Data15_g251685;
					float In_Dummy16_g251686 = 0.0;
					float3 Vertex_PositionOS147_g251676 = Out_PositionOS15_g251685;
					half3 VertexPos40_g251680 = Vertex_PositionOS147_g251676;
					float4 temp_output_1615_33_g251676 = Out_RotationData15_g251685;
					half4 Vertex_RotationData1569_g251676 = temp_output_1615_33_g251676;
					float2 break1582_g251676 = (Vertex_RotationData1569_g251676).xy;
					half Angle44_g251680 = break1582_g251676.y;
					half CosAngle89_g251680 = cos( Angle44_g251680 );
					half SinAngle93_g251680 = sin( Angle44_g251680 );
					float3 appendResult95_g251680 = (float3((VertexPos40_g251680).x , ( ( (VertexPos40_g251680).y * CosAngle89_g251680 ) - ( (VertexPos40_g251680).z * SinAngle93_g251680 ) ) , ( ( (VertexPos40_g251680).y * SinAngle93_g251680 ) + ( (VertexPos40_g251680).z * CosAngle89_g251680 ) )));
					half3 VertexPos40_g251681 = appendResult95_g251680;
					half Angle44_g251681 = -break1582_g251676.x;
					half CosAngle94_g251681 = cos( Angle44_g251681 );
					half SinAngle95_g251681 = sin( Angle44_g251681 );
					float3 appendResult98_g251681 = (float3(( ( (VertexPos40_g251681).x * CosAngle94_g251681 ) - ( (VertexPos40_g251681).y * SinAngle95_g251681 ) ) , ( ( (VertexPos40_g251681).x * SinAngle95_g251681 ) + ( (VertexPos40_g251681).y * CosAngle94_g251681 ) ) , (VertexPos40_g251681).z));
					half3 VertexPos40_g251679 = Vertex_PositionOS147_g251676;
					half Angle44_g251679 = break1582_g251676.y;
					half CosAngle89_g251679 = cos( Angle44_g251679 );
					half SinAngle93_g251679 = sin( Angle44_g251679 );
					float3 appendResult95_g251679 = (float3((VertexPos40_g251679).x , ( ( (VertexPos40_g251679).y * CosAngle89_g251679 ) - ( (VertexPos40_g251679).z * SinAngle93_g251679 ) ) , ( ( (VertexPos40_g251679).y * SinAngle93_g251679 ) + ( (VertexPos40_g251679).z * CosAngle89_g251679 ) )));
					half3 VertexPos40_g251684 = appendResult95_g251679;
					half Angle44_g251684 = break1582_g251676.x;
					half CosAngle91_g251684 = cos( Angle44_g251684 );
					half SinAngle92_g251684 = sin( Angle44_g251684 );
					float3 appendResult93_g251684 = (float3(( ( (VertexPos40_g251684).x * CosAngle91_g251684 ) + ( (VertexPos40_g251684).z * SinAngle92_g251684 ) ) , (VertexPos40_g251684).y , ( ( -(VertexPos40_g251684).x * SinAngle92_g251684 ) + ( (VertexPos40_g251684).z * CosAngle91_g251684 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251682 = appendResult93_g251684;
					#else
					float3 staticSwitch65_g251682 = appendResult98_g251681;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251677 = staticSwitch65_g251682;
					#else
					float3 staticSwitch65_g251677 = Vertex_PositionOS147_g251676;
					#endif
					float3 temp_output_1608_0_g251676 = staticSwitch65_g251677;
					half3 VertexPos40_g251683 = temp_output_1608_0_g251676;
					half Angle44_g251683 = (Vertex_RotationData1569_g251676).z;
					half CosAngle91_g251683 = cos( Angle44_g251683 );
					half SinAngle92_g251683 = sin( Angle44_g251683 );
					float3 appendResult93_g251683 = (float3(( ( (VertexPos40_g251683).x * CosAngle91_g251683 ) + ( (VertexPos40_g251683).z * SinAngle92_g251683 ) ) , (VertexPos40_g251683).y , ( ( -(VertexPos40_g251683).x * SinAngle92_g251683 ) + ( (VertexPos40_g251683).z * CosAngle91_g251683 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251678 = appendResult93_g251683;
					#else
					float3 staticSwitch65_g251678 = temp_output_1608_0_g251676;
					#endif
					float4 temp_output_1615_31_g251676 = Out_TransformData15_g251685;
					half4 Vertex_TransformData1568_g251676 = temp_output_1615_31_g251676;
					half3 Final_PositionOS178_g251676 = ( ( staticSwitch65_g251678 * (Vertex_TransformData1568_g251676).w ) + (Vertex_TransformData1568_g251676).xyz );
					float3 In_PositionOS16_g251686 = Final_PositionOS178_g251676;
					float3 In_NormalOS16_g251686 = Out_NormalOS15_g251685;
					float4 In_TangentOS16_g251686 = Out_TangentOS15_g251685;
					float4 In_TransformData16_g251686 = temp_output_1615_31_g251676;
					float4 In_RotationData16_g251686 = temp_output_1615_33_g251676;
					float4 In_Interpolator16_g251686 = Out_Interpolator15_g251685;
					BuildVertexData( Data16_g251686 , In_Dummy16_g251686 , In_PositionOS16_g251686 , In_NormalOS16_g251686 , In_TangentOS16_g251686 , In_TransformData16_g251686 , In_RotationData16_g251686 , In_Interpolator16_g251686 );
					TVEVertexData Data15_g251689 =(TVEVertexData)Data16_g251686;
					float Out_Dummy15_g251689 = 0.0;
					float3 Out_PositionOS15_g251689 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251689 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251689 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251689 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251689 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251689 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251689 , Out_Dummy15_g251689 , Out_PositionOS15_g251689 , Out_NormalOS15_g251689 , Out_TangentOS15_g251689 , Out_TransformData15_g251689 , Out_RotationData15_g251689 , Out_Interpolator15_g251689 );
					TVEVertexData Data16_g251690 =(TVEVertexData)Data15_g251689;
					float In_Dummy16_g251690 = 0.0;
					TVEModelData Data15_g251688 =(TVEModelData)Data15_g251672;
					float Out_Dummy15_g251688 = 0.0;
					float3 Out_PositionOS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251688 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251688 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251688 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251688 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251688 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251688 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251688 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251688 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251688 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251688 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251688 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251688 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251688 , Out_Dummy15_g251688 , Out_PositionOS15_g251688 , Out_PositionWS15_g251688 , Out_PositionWO15_g251688 , Out_PositionRawOS15_g251688 , Out_PivotOS15_g251688 , Out_PivotWS15_g251688 , Out_PivotWO15_g251688 , Out_NormalOS15_g251688 , Out_NormalWS15_g251688 , Out_NormalRawOS15_g251688 , Out_TangentOS15_g251688 , Out_TangentWS15_g251688 , Out_BitangentWS15_g251688 , Out_ViewDirWS15_g251688 , Out_CoordsData15_g251688 , Out_VertexData15_g251688 , Out_MasksData15_g251688 , Out_PhaseData15_g251688 , Out_TransformData15_g251688 , Out_RotationData15_g251688 , Out_Interpolator15_g251688 );
					float3 In_PositionOS16_g251690 = ( Out_PositionOS15_g251689 + Out_PivotOS15_g251688 );
					float3 In_NormalOS16_g251690 = Out_NormalOS15_g251689;
					float4 In_TangentOS16_g251690 = Out_TangentOS15_g251689;
					float4 In_TransformData16_g251690 = Out_TransformData15_g251689;
					float4 In_RotationData16_g251690 = Out_RotationData15_g251689;
					float4 In_Interpolator16_g251690 = Out_Interpolator15_g251689;
					BuildVertexData( Data16_g251690 , In_Dummy16_g251690 , In_PositionOS16_g251690 , In_NormalOS16_g251690 , In_TangentOS16_g251690 , In_TransformData16_g251690 , In_RotationData16_g251690 , In_Interpolator16_g251690 );
					TVEVertexData Data15_g252100 =(TVEVertexData)Data16_g251690;
					float Out_Dummy15_g252100 = 0.0;
					float3 Out_PositionOS15_g252100 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252100 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252100 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252100 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252100 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252100 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252100 , Out_Dummy15_g252100 , Out_PositionOS15_g252100 , Out_NormalOS15_g252100 , Out_TangentOS15_g252100 , Out_TransformData15_g252100 , Out_RotationData15_g252100 , Out_Interpolator15_g252100 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252100;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half3 normal : NORMAL;
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

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
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
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
					o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					return float4( _ObjectId, _PassValue, 1.0, 1.0 );
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19912
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2

				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				float4 _SelectionID;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform half _ObjectCoordMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_EffexParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexBaseTex);
				uniform float4 TVE_EffexBaseCoord;
				uniform half _GlobalEffexPivotValue;
				uniform half _GlobalEffexLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_EffexNearTex);
				uniform float4 TVE_EffexNearCoord;
				uniform float TVE_EffexLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_VertxParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxBaseTex);
				uniform float4 TVE_VertxBaseCoord;
				uniform half _GlobalVertxPivotValue;
				uniform half _GlobalVertxLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertxNearTex);
				uniform float4 TVE_VertxNearCoord;
				uniform float TVE_VertxLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half4 In_TangentOS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.TangentOS = In_TangentOS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				void BuildVertexData( inout TVEVertexData Data, half In_Dummy, float3 In_PositionOS, half3 In_NormalOS, half4 In_TangentOS, half4 In_TransformData, half4 In_RotationData, float4 In_Interpolator )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.NormalOS = In_NormalOS;
					Data.TangentOS = In_TangentOS;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.Interpolator = In_Interpolator;
					return;
				}
				
				void BreakVertexData( inout TVEVertexData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_NormalOS, out half4 Out_TangentOS, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_Interpolator )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_NormalOS = Data.NormalOS;
					Out_TangentOS = Data.TangentOS;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_Interpolator = Data.Interpolator;
					return;
				}
				
				half3 ComputeTriplanarMasks( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatTexture, half4 In_DrawTexture, half4 In_PaintTexture, half4 In_AtmoTexture, half4 In_EffexTexture, half4 In_GlowTexture, float4 In_FormTexture, float4 In_LandTexture, float4 In_VertxTexture, float4 In_FlowTexture, half4 In_UserTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatTexture = In_CoatTexture;
					Data.DrawTexture = In_DrawTexture;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoTexture = In_AtmoTexture;
					Data.EffexTexture = In_EffexTexture;
					Data.GlowTexture = In_GlowTexture;
					Data.FormTexture = In_FormTexture;
					Data.LandTexture = In_LandTexture;
					Data.VertxTexture = In_VertxTexture;
					Data.FlowTexture = In_FlowTexture;
					Data.UserTexture = In_UserTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatTexture, out half4 Out_DrawTexture, out half4 Out_PaintTexture, out half4 Out_AtmoTexture, out half4 Out_EffexTexture, out half4 Out_GlowTexture, out float4 Out_FormTexture, out float4 Out_LandTexture, out half4 Out_VertxTexture, out half4 Out_FlowTexture, out half4 Out_UserTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatTexture = Data.CoatTexture;
					Out_DrawTexture = Data.DrawTexture;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_EffexTexture= Data.EffexTexture;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormTexture = Data.FormTexture;
					Out_LandTexture = Data.LandTexture;
					Out_VertxTexture = Data.VertxTexture;
					Out_FlowTexture = Data.FlowTexture;
					Out_UserTexture = Data.UserTexture;
					return;
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251664 =(TVEVertexData)0;
					float In_Dummy16_g251664 = 0.0;
					TVEVertexData Data16_g251659 =(TVEVertexData)0;
					float In_Dummy16_g251659 = 0.0;
					TVEModelData Data16_g235783 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#else
					float staticSwitch343_g235765 = _ObjectCoordMode;
					#endif
					half Dummy207_g235765 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g235765 );
					float temp_output_14_0_g235783 = Dummy207_g235765;
					float In_Dummy16_g235783 = temp_output_14_0_g235783;
					float3 PositionOS131_g235765 = v.vertex.xyz;
					float3 temp_output_4_0_g235783 = PositionOS131_g235765;
					float3 In_PositionOS16_g235783 = temp_output_4_0_g235783;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g235765 = ase_positionWS;
					float3 vertexToFrag73_g235765 = temp_output_104_7_g235765;
					float3 PositionWS122_g235765 = vertexToFrag73_g235765;
					float3 In_PositionWS16_g235783 = PositionWS122_g235765;
					float4x4 break19_g235768 = unity_ObjectToWorld;
					float3 appendResult20_g235768 = (float3(break19_g235768[ 0 ][ 3 ] , break19_g235768[ 1 ][ 3 ] , break19_g235768[ 2 ][ 3 ]));
					float3 temp_output_340_7_g235765 = appendResult20_g235768;
					float4x4 break19_g235770 = unity_ObjectToWorld;
					float3 appendResult20_g235770 = (float3(break19_g235770[ 0 ][ 3 ] , break19_g235770[ 1 ][ 3 ] , break19_g235770[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g235766 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g235765 = PositionOS131_g235765;
					float3 appendResult234_g235765 = (float3(break233_g235765.x , 0.0 , break233_g235765.z));
					float3 break413_g235765 = PositionOS131_g235765;
					float3 appendResult414_g235765 = (float3(break413_g235765.x , break413_g235765.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g235772 = appendResult414_g235765;
					#else
					float3 staticSwitch65_g235772 = appendResult234_g235765;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g235765 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g235765 = appendResult60_g235766;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g235765 = staticSwitch65_g235772;
					#else
					float3 staticSwitch229_g235765 = _Vector0;
					#endif
					float3 PivotOS149_g235765 = staticSwitch229_g235765;
					float3 temp_output_122_0_g235770 = PivotOS149_g235765;
					float3 PivotsOnlyWS105_g235770 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g235770 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g235765 = ( appendResult20_g235770 + PivotsOnlyWS105_g235770 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g235765 = temp_output_341_7_g235765;
					#else
					float3 staticSwitch236_g235765 = temp_output_340_7_g235765;
					#endif
					float3 vertexToFrag76_g235765 = staticSwitch236_g235765;
					float3 PivotWS121_g235765 = vertexToFrag76_g235765;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g235765 = ( PositionWS122_g235765 - PivotWS121_g235765 );
					#else
					float3 staticSwitch204_g235765 = PositionWS122_g235765;
					#endif
					float3 PositionWO132_g235765 = ( staticSwitch204_g235765 - TVE_WorldOrigin );
					float3 In_PositionWO16_g235783 = PositionWO132_g235765;
					float3 In_PivotOS16_g235783 = PivotOS149_g235765;
					float3 In_PivotWS16_g235783 = PivotWS121_g235765;
					float3 PivotWO133_g235765 = ( PivotWS121_g235765 - TVE_WorldOrigin );
					float3 In_PivotWO16_g235783 = PivotWO133_g235765;
					half3 NormalOS134_g235765 = v.normal;
					float3 temp_output_21_0_g235783 = NormalOS134_g235765;
					float3 In_NormalOS16_g235783 = temp_output_21_0_g235783;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g235765 = normalizedWorldNormal;
					float3 In_NormalWS16_g235783 = NormalWS95_g235765;
					half4 TangentlOS153_g235765 = v.tangent;
					float4 temp_output_6_0_g235783 = TangentlOS153_g235765;
					float4 In_TangentOS16_g235783 = temp_output_6_0_g235783;
					float3 normalizeResult296_g235765 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g235765 ) );
					half3 ViewDirWS169_g235765 = normalizeResult296_g235765;
					float3 In_ViewDirWS16_g235783 = ViewDirWS169_g235765;
					float4 appendResult397_g235765 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g235765 = appendResult397_g235765;
					float4 In_CoordsData16_g235783 = CoordsData398_g235765;
					half4 VertexMasks171_g235765 = v.ase_color;
					float4 In_VertexData16_g235783 = VertexMasks171_g235765;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235777 = (PositionOS131_g235765).z;
					#else
					float staticSwitch65_g235777 = (PositionOS131_g235765).y;
					#endif
					half Object_HeightValue267_g235765 = _ObjectHeightValue;
					half Bounds_HeightMask274_g235765 = saturate( ( staticSwitch65_g235777 / Object_HeightValue267_g235765 ) );
					half3 Position387_g235765 = PositionOS131_g235765;
					half Height387_g235765 = Object_HeightValue267_g235765;
					half Object_RadiusValue268_g235765 = _ObjectRadiusValue;
					half Radius387_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskYUp387_g235765 = CapsuleMaskYUp( Position387_g235765 , Height387_g235765 , Radius387_g235765 );
					half3 Position408_g235765 = PositionOS131_g235765;
					half Height408_g235765 = Object_HeightValue267_g235765;
					half Radius408_g235765 = Object_RadiusValue268_g235765;
					half localCapsuleMaskZUp408_g235765 = CapsuleMaskZUp( Position408_g235765 , Height408_g235765 , Radius408_g235765 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g235782 = saturate( localCapsuleMaskZUp408_g235765 );
					#else
					float staticSwitch65_g235782 = saturate( localCapsuleMaskYUp387_g235765 );
					#endif
					half Bounds_SphereMask282_g235765 = staticSwitch65_g235782;
					float4 appendResult253_g235765 = (float4(Bounds_HeightMask274_g235765 , Bounds_SphereMask282_g235765 , 1.0 , 1.0));
					half4 MasksData254_g235765 = appendResult253_g235765;
					float4 In_MasksData16_g235783 = MasksData254_g235765;
					float temp_output_17_0_g235776 = _ObjectPhaseMode;
					float Option70_g235776 = temp_output_17_0_g235776;
					float4 temp_output_3_0_g235776 = v.ase_color;
					float4 Channel70_g235776 = temp_output_3_0_g235776;
					float localSwitchChannel470_g235776 = SwitchChannel4( Option70_g235776 , Channel70_g235776 );
					half Phase_Value372_g235765 = localSwitchChannel470_g235776;
					float3 break319_g235765 = PivotWO133_g235765;
					half Pivot_Position322_g235765 = ( break319_g235765.x + break319_g235765.z );
					half Phase_Position357_g235765 = ( Phase_Value372_g235765 + Pivot_Position322_g235765 );
					float temp_output_248_0_g235765 = frac( Phase_Position357_g235765 );
					float4 appendResult177_g235765 = (float4((frac( ( Phase_Position357_g235765 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g235765));
					half4 Phase_Data176_g235765 = appendResult177_g235765;
					float4 In_PhaseData16_g235783 = Phase_Data176_g235765;
					BuildModelVertData( Data16_g235783 , In_Dummy16_g235783 , In_PositionOS16_g235783 , In_PositionWS16_g235783 , In_PositionWO16_g235783 , In_PivotOS16_g235783 , In_PivotWS16_g235783 , In_PivotWO16_g235783 , In_NormalOS16_g235783 , In_NormalWS16_g235783 , In_TangentOS16_g235783 , In_ViewDirWS16_g235783 , In_CoordsData16_g235783 , In_VertexData16_g235783 , In_MasksData16_g235783 , In_PhaseData16_g235783 );
					TVEModelData Data15_g251660 =(TVEModelData)Data16_g235783;
					float Out_Dummy15_g251660 = 0.0;
					float3 Out_PositionOS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251660 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251660 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251660 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251660 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251660 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251660 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251660 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251660 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251660 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251660 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251660 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251660 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251660 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251660 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251660 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251660 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251660 , Out_Dummy15_g251660 , Out_PositionOS15_g251660 , Out_PositionWS15_g251660 , Out_PositionWO15_g251660 , Out_PositionRawOS15_g251660 , Out_PivotOS15_g251660 , Out_PivotWS15_g251660 , Out_PivotWO15_g251660 , Out_NormalOS15_g251660 , Out_NormalWS15_g251660 , Out_NormalRawOS15_g251660 , Out_TangentOS15_g251660 , Out_TangentWS15_g251660 , Out_BitangentWS15_g251660 , Out_ViewDirWS15_g251660 , Out_CoordsData15_g251660 , Out_VertexData15_g251660 , Out_MasksData15_g251660 , Out_PhaseData15_g251660 , Out_TransformData15_g251660 , Out_RotationData15_g251660 , Out_Interpolator15_g251660 );
					float3 In_PositionOS16_g251659 = Out_PositionOS15_g251660;
					float3 In_NormalOS16_g251659 = Out_NormalOS15_g251660;
					float4 In_TangentOS16_g251659 = Out_TangentOS15_g251660;
					float4 In_TransformData16_g251659 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251659 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251659 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251659 , In_Dummy16_g251659 , In_PositionOS16_g251659 , In_NormalOS16_g251659 , In_TangentOS16_g251659 , In_TransformData16_g251659 , In_RotationData16_g251659 , In_Interpolator16_g251659 );
					TVEVertexData Data15_g251662 =(TVEVertexData)Data16_g251659;
					float Out_Dummy15_g251662 = 0.0;
					float3 Out_PositionOS15_g251662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251662 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251662 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251662 , Out_Dummy15_g251662 , Out_PositionOS15_g251662 , Out_NormalOS15_g251662 , Out_TangentOS15_g251662 , Out_TransformData15_g251662 , Out_RotationData15_g251662 , Out_Interpolator15_g251662 );
					TVEModelData Data15_g251663 =(TVEModelData)Data15_g251660;
					float Out_Dummy15_g251663 = 0.0;
					float3 Out_PositionOS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251663 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251663 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251663 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251663 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251663 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251663 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251663 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251663 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251663 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251663 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251663 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251663 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251663 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251663 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251663 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251663 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251663 , Out_Dummy15_g251663 , Out_PositionOS15_g251663 , Out_PositionWS15_g251663 , Out_PositionWO15_g251663 , Out_PositionRawOS15_g251663 , Out_PivotOS15_g251663 , Out_PivotWS15_g251663 , Out_PivotWO15_g251663 , Out_NormalOS15_g251663 , Out_NormalWS15_g251663 , Out_NormalRawOS15_g251663 , Out_TangentOS15_g251663 , Out_TangentWS15_g251663 , Out_BitangentWS15_g251663 , Out_ViewDirWS15_g251663 , Out_CoordsData15_g251663 , Out_VertexData15_g251663 , Out_MasksData15_g251663 , Out_PhaseData15_g251663 , Out_TransformData15_g251663 , Out_RotationData15_g251663 , Out_Interpolator15_g251663 );
					float3 In_PositionOS16_g251664 = ( Out_PositionOS15_g251662 - Out_PivotOS15_g251663 );
					float3 In_NormalOS16_g251664 = Out_NormalOS15_g251663;
					float4 In_TangentOS16_g251664 = Out_TangentOS15_g251663;
					float4 In_TransformData16_g251664 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251664 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251664 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251664 , In_Dummy16_g251664 , In_PositionOS16_g251664 , In_NormalOS16_g251664 , In_TangentOS16_g251664 , In_TransformData16_g251664 , In_RotationData16_g251664 , In_Interpolator16_g251664 );
					TVEVertexData Data15_g251673 =(TVEVertexData)Data16_g251664;
					float Out_Dummy15_g251673 = 0.0;
					float3 Out_PositionOS15_g251673 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251673 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251673 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251673 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251673 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251673 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251673 , Out_Dummy15_g251673 , Out_PositionOS15_g251673 , Out_NormalOS15_g251673 , Out_TangentOS15_g251673 , Out_TransformData15_g251673 , Out_RotationData15_g251673 , Out_Interpolator15_g251673 );
					TVEVertexData Data16_g251674 =(TVEVertexData)Data15_g251673;
					half Dummy317_g251665 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251674 = Dummy317_g251665;
					float3 In_PositionOS16_g251674 = Out_PositionOS15_g251673;
					float3 In_NormalOS16_g251674 = Out_NormalOS15_g251673;
					float4 In_TangentOS16_g251674 = Out_TangentOS15_g251673;
					half4 Model_TransformData356_g251665 = Out_TransformData15_g251673;
					float localBuildGlobalData204_g235664 = ( 0.0 );
					TVEGlobalData Data204_g235664 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g235664 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g235664 = Dummy211_g235664;
					float4 temp_output_203_0_g235683 = TVE_CoatBaseCoord;
					TVEModelData Data16_g235773 =(TVEModelData)0;
					float In_Dummy16_g235773 = 0.0;
					float3 In_PositionWS16_g235773 = PositionWS122_g235765;
					float3 In_PositionWO16_g235773 = PositionWO132_g235765;
					float3 In_PivotWS16_g235773 = PivotWS121_g235765;
					float3 In_PivotWO16_g235773 = PivotWO133_g235765;
					float3 In_NormalWS16_g235773 = NormalWS95_g235765;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g235765 = ase_tangentWS;
					float3 In_TangentWS16_g235773 = TangentWS136_g235765;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g235765 = ase_bitangentWS;
					float3 In_BitangentWS16_g235773 = BiangentWS421_g235765;
					half3 NormalWS427_g235765 = NormalWS95_g235765;
					half3 localComputeTriplanarMasks427_g235765 = ComputeTriplanarMasks( NormalWS427_g235765 );
					half3 TriplanarWeights429_g235765 = localComputeTriplanarMasks427_g235765;
					float3 In_TriplanarWeights16_g235773 = TriplanarWeights429_g235765;
					float3 In_ViewDirWS16_g235773 = ViewDirWS169_g235765;
					float4 In_CoordsData16_g235773 = CoordsData398_g235765;
					float4 In_VertexData16_g235773 = VertexMasks171_g235765;
					float4 In_Interpolator16_g235773 = Phase_Data176_g235765;
					BuildModelFragData( Data16_g235773 , In_Dummy16_g235773 , In_PositionWS16_g235773 , In_PositionWO16_g235773 , In_PivotWS16_g235773 , In_PivotWO16_g235773 , In_NormalWS16_g235773 , In_TangentWS16_g235773 , In_BitangentWS16_g235773 , In_TriplanarWeights16_g235773 , In_ViewDirWS16_g235773 , In_CoordsData16_g235773 , In_VertexData16_g235773 , In_Interpolator16_g235773 );
					TVEModelData Data15_g235754 =(TVEModelData)Data16_g235773;
					float Out_Dummy15_g235754 = 0.0;
					float3 Out_PositionWS15_g235754 = float3( 0,0,0 );
					float3 Out_PositionWO15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWS15_g235754 = float3( 0,0,0 );
					float3 Out_PivotWO15_g235754 = float3( 0,0,0 );
					float3 Out_NormalWS15_g235754 = float3( 0,0,0 );
					float3 Out_TangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g235754 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g235754 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g235754 = float3( 0,0,0 );
					float4 Out_CoordsData15_g235754 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g235754 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g235754 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g235754 , Out_Dummy15_g235754 , Out_PositionWS15_g235754 , Out_PositionWO15_g235754 , Out_PivotWS15_g235754 , Out_PivotWO15_g235754 , Out_NormalWS15_g235754 , Out_TangentWS15_g235754 , Out_BitangentWS15_g235754 , Out_TriplanarWeights15_g235754 , Out_ViewDirWS15_g235754 , Out_CoordsData15_g235754 , Out_VertexData15_g235754 , Out_Interpolator15_g235754 );
					float3 Model_PositionWS497_g235664 = Out_PositionWS15_g235754;
					float2 Model_PositionWS_XZ143_g235664 = (Model_PositionWS497_g235664).xz;
					float3 Model_PivotWS498_g235664 = Out_PivotWS15_g235754;
					float2 Model_PivotWS_XZ145_g235664 = (Model_PivotWS498_g235664).xz;
					float2 lerpResult300_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g235683 = lerpResult300_g235664;
					float temp_output_82_0_g235681 = _GlobalCoatLayerValue;
					float temp_output_82_0_g235683 = temp_output_82_0_g235681;
					float4 tex2DArrayNode83_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235683).zw + ( (temp_output_203_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult210_g235683 = (float4(tex2DArrayNode83_g235683.rgb , tex2DArrayNode83_g235683.a));
					float4 temp_output_204_0_g235683 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g235683 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235683).zw + ( (temp_output_204_0_g235683).xy * temp_output_81_0_g235683 ) ),temp_output_82_0_g235683), 0.0 );
					float4 appendResult212_g235683 = (float4(tex2DArrayNode122_g235683.rgb , tex2DArrayNode122_g235683.a));
					float4 TVE_RenderNearPositionR628_g235664 = TVE_RenderNearPositionR;
					float temp_output_507_0_g235664 = saturate( ( distance( Model_PositionWS497_g235664 , (TVE_RenderNearPositionR628_g235664).xyz ) / (TVE_RenderNearPositionR628_g235664).w ) );
					float temp_output_7_0_g235753 = 1.0;
					float temp_output_9_0_g235753 = ( temp_output_507_0_g235664 - temp_output_7_0_g235753 );
					half TVE_RenderNearFadeValue635_g235664 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g235664 = saturate( ( temp_output_9_0_g235753 / ( ( TVE_RenderNearFadeValue635_g235664 - temp_output_7_0_g235753 ) + 0.0001 ) ) );
					float4 lerpResult131_g235683 = lerp( appendResult210_g235683 , appendResult212_g235683 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235681 = lerpResult131_g235683;
					float4 lerpResult168_g235681 = lerp( TVE_CoatParams , temp_output_159_109_g235681 , TVE_CoatLayers[(int)temp_output_82_0_g235681]);
					float4 temp_output_589_109_g235664 = lerpResult168_g235681;
					half4 Coat_Texture302_g235664 = temp_output_589_109_g235664;
					float4 In_CoatTexture204_g235664 = Coat_Texture302_g235664;
					half4 Draw_Texture656_g235664 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g235664 = Draw_Texture656_g235664;
					float4 temp_output_203_0_g235708 = TVE_PaintBaseCoord;
					float2 lerpResult85_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g235708 = lerpResult85_g235664;
					float temp_output_82_0_g235705 = _GlobalPaintLayerValue;
					float temp_output_82_0_g235708 = temp_output_82_0_g235705;
					float4 tex2DArrayNode83_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235708).zw + ( (temp_output_203_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult210_g235708 = (float4(tex2DArrayNode83_g235708.rgb , tex2DArrayNode83_g235708.a));
					float4 temp_output_204_0_g235708 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g235708 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235708).zw + ( (temp_output_204_0_g235708).xy * temp_output_81_0_g235708 ) ),temp_output_82_0_g235708), 0.0 );
					float4 appendResult212_g235708 = (float4(tex2DArrayNode122_g235708.rgb , tex2DArrayNode122_g235708.a));
					float4 lerpResult131_g235708 = lerp( appendResult210_g235708 , appendResult212_g235708 , Global_TexBlend509_g235664);
					float4 temp_output_171_109_g235705 = lerpResult131_g235708;
					float4 lerpResult174_g235705 = lerp( TVE_PaintParams , temp_output_171_109_g235705 , TVE_PaintLayers[(int)temp_output_82_0_g235705]);
					float4 temp_output_595_109_g235664 = lerpResult174_g235705;
					half4 Paint_Texture71_g235664 = temp_output_595_109_g235664;
					float4 In_PaintTexture204_g235664 = Paint_Texture71_g235664;
					float4 temp_output_203_0_g235691 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g235691 = lerpResult104_g235664;
					float temp_output_132_0_g235689 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g235691 = temp_output_132_0_g235689;
					float4 tex2DArrayNode83_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235691).zw + ( (temp_output_203_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult210_g235691 = (float4(tex2DArrayNode83_g235691.rgb , tex2DArrayNode83_g235691.a));
					float4 temp_output_204_0_g235691 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g235691 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235691).zw + ( (temp_output_204_0_g235691).xy * temp_output_81_0_g235691 ) ),temp_output_82_0_g235691), 0.0 );
					float4 appendResult212_g235691 = (float4(tex2DArrayNode122_g235691.rgb , tex2DArrayNode122_g235691.a));
					float4 lerpResult131_g235691 = lerp( appendResult210_g235691 , appendResult212_g235691 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235689 = lerpResult131_g235691;
					float4 lerpResult145_g235689 = lerp( TVE_AtmoParams , temp_output_137_109_g235689 , TVE_AtmoLayers[(int)temp_output_132_0_g235689]);
					float4 temp_output_590_110_g235664 = lerpResult145_g235689;
					half4 Atmo_Texture80_g235664 = temp_output_590_110_g235664;
					float4 In_AtmoTexture204_g235664 = Atmo_Texture80_g235664;
					float4 temp_output_203_0_g235759 = TVE_EffexBaseCoord;
					float2 lerpResult414_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g235759 = lerpResult414_g235664;
					float temp_output_132_0_g235757 = _GlobalEffexLayerValue;
					float temp_output_82_0_g235759 = temp_output_132_0_g235757;
					float4 tex2DArrayNode83_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235759).zw + ( (temp_output_203_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult210_g235759 = (float4(tex2DArrayNode83_g235759.rgb , tex2DArrayNode83_g235759.a));
					float4 temp_output_204_0_g235759 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g235759 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235759).zw + ( (temp_output_204_0_g235759).xy * temp_output_81_0_g235759 ) ),temp_output_82_0_g235759), 0.0 );
					float4 appendResult212_g235759 = (float4(tex2DArrayNode122_g235759.rgb , tex2DArrayNode122_g235759.a));
					float4 lerpResult131_g235759 = lerp( appendResult210_g235759 , appendResult212_g235759 , Global_TexBlend509_g235664);
					float4 temp_output_137_109_g235757 = lerpResult131_g235759;
					float4 lerpResult145_g235757 = lerp( TVE_EffexParams , temp_output_137_109_g235757 , TVE_EffexLayers[(int)temp_output_132_0_g235757]);
					float4 temp_output_731_110_g235664 = lerpResult145_g235757;
					half4 Effex_Texture420_g235664 = temp_output_731_110_g235664;
					float4 In_EffexTexture204_g235664 = Effex_Texture420_g235664;
					float4 temp_output_203_0_g235739 = TVE_GlowBaseCoord;
					float2 lerpResult247_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g235739 = lerpResult247_g235664;
					float temp_output_82_0_g235737 = _GlobalGlowLayerValue;
					float temp_output_82_0_g235739 = temp_output_82_0_g235737;
					float4 tex2DArrayNode83_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235739).zw + ( (temp_output_203_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult210_g235739 = (float4(tex2DArrayNode83_g235739.rgb , tex2DArrayNode83_g235739.a));
					float4 temp_output_204_0_g235739 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g235739 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235739).zw + ( (temp_output_204_0_g235739).xy * temp_output_81_0_g235739 ) ),temp_output_82_0_g235739), 0.0 );
					float4 appendResult212_g235739 = (float4(tex2DArrayNode122_g235739.rgb , tex2DArrayNode122_g235739.a));
					float4 lerpResult131_g235739 = lerp( appendResult210_g235739 , appendResult212_g235739 , Global_TexBlend509_g235664);
					float4 temp_output_159_109_g235737 = lerpResult131_g235739;
					float4 lerpResult167_g235737 = lerp( TVE_GlowParams , temp_output_159_109_g235737 , TVE_GlowLayers[(int)temp_output_82_0_g235737]);
					float4 temp_output_593_109_g235664 = lerpResult167_g235737;
					half4 Glow_Texture248_g235664 = temp_output_593_109_g235664;
					float4 In_GlowTexture204_g235664 = Glow_Texture248_g235664;
					float4 temp_output_203_0_g235675 = TVE_FormBaseCoord;
					float2 lerpResult168_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g235675 = lerpResult168_g235664;
					float temp_output_130_0_g235673 = _GlobalFormLayerValue;
					float temp_output_82_0_g235675 = temp_output_130_0_g235673;
					float4 tex2DArrayNode83_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235675).zw + ( (temp_output_203_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult210_g235675 = (float4(tex2DArrayNode83_g235675.rgb , tex2DArrayNode83_g235675.a));
					float4 temp_output_204_0_g235675 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g235675 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235675).zw + ( (temp_output_204_0_g235675).xy * temp_output_81_0_g235675 ) ),temp_output_82_0_g235675), 0.0 );
					float4 appendResult212_g235675 = (float4(tex2DArrayNode122_g235675.rgb , tex2DArrayNode122_g235675.a));
					float4 lerpResult131_g235675 = lerp( appendResult210_g235675 , appendResult212_g235675 , Global_TexBlend509_g235664);
					float4 temp_output_135_109_g235673 = lerpResult131_g235675;
					float4 lerpResult143_g235673 = lerp( TVE_FormParams , temp_output_135_109_g235673 , TVE_FormLayers[(int)temp_output_130_0_g235673]);
					float4 temp_output_592_0_g235664 = lerpResult143_g235673;
					float4 Form_Texture112_g235664 = temp_output_592_0_g235664;
					float4 In_FormTexture204_g235664 = Form_Texture112_g235664;
					float4 In_LandTexture204_g235664 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g235723 = TVE_VertxBaseCoord;
					float2 lerpResult681_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g235723 = lerpResult681_g235664;
					float temp_output_136_0_g235721 = _GlobalVertxLayerValue;
					float temp_output_82_0_g235723 = temp_output_136_0_g235721;
					float4 tex2DArrayNode83_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235723).zw + ( (temp_output_203_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult210_g235723 = (float4(tex2DArrayNode83_g235723.rgb , tex2DArrayNode83_g235723.a));
					float4 temp_output_204_0_g235723 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g235723 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235723).zw + ( (temp_output_204_0_g235723).xy * temp_output_81_0_g235723 ) ),temp_output_82_0_g235723), 0.0 );
					float4 appendResult212_g235723 = (float4(tex2DArrayNode122_g235723.rgb , tex2DArrayNode122_g235723.a));
					float4 lerpResult131_g235723 = lerp( appendResult210_g235723 , appendResult212_g235723 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235721 = lerpResult131_g235723;
					float4 lerpResult149_g235721 = lerp( TVE_VertxParams , temp_output_141_109_g235721 , TVE_VertxLayers[(int)temp_output_136_0_g235721]);
					float4 temp_output_695_0_g235664 = lerpResult149_g235721;
					half4 Vertx_Texture693_g235664 = temp_output_695_0_g235664;
					float4 In_VertxTexture204_g235664 = Vertx_Texture693_g235664;
					float4 temp_output_203_0_g235699 = TVE_FlowBaseCoord;
					float2 lerpResult400_g235664 = lerp( Model_PositionWS_XZ143_g235664 , Model_PivotWS_XZ145_g235664 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g235699 = lerpResult400_g235664;
					float temp_output_136_0_g235697 = _GlobalFlowLayerValue;
					float temp_output_82_0_g235699 = temp_output_136_0_g235697;
					float4 tex2DArrayNode83_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g235699).zw + ( (temp_output_203_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult210_g235699 = (float4(tex2DArrayNode83_g235699.rgb , tex2DArrayNode83_g235699.a));
					float4 temp_output_204_0_g235699 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g235699 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g235699).zw + ( (temp_output_204_0_g235699).xy * temp_output_81_0_g235699 ) ),temp_output_82_0_g235699), 0.0 );
					float4 appendResult212_g235699 = (float4(tex2DArrayNode122_g235699.rgb , tex2DArrayNode122_g235699.a));
					float4 lerpResult131_g235699 = lerp( appendResult210_g235699 , appendResult212_g235699 , Global_TexBlend509_g235664);
					float4 temp_output_141_109_g235697 = lerpResult131_g235699;
					float4 lerpResult149_g235697 = lerp( TVE_FlowParams , temp_output_141_109_g235697 , TVE_FlowLayers[(int)temp_output_136_0_g235697]);
					float4 temp_output_594_0_g235664 = lerpResult149_g235697;
					half4 Flow_Texture405_g235664 = temp_output_594_0_g235664;
					float4 In_FlowTexture204_g235664 = Flow_Texture405_g235664;
					half4 User_Texture677_g235664 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g235664 = User_Texture677_g235664;
					BuildGlobalData( Data204_g235664 , In_Dummy204_g235664 , In_CoatTexture204_g235664 , In_DrawTexture204_g235664 , In_PaintTexture204_g235664 , In_AtmoTexture204_g235664 , In_EffexTexture204_g235664 , In_GlowTexture204_g235664 , In_FormTexture204_g235664 , In_LandTexture204_g235664 , In_VertxTexture204_g235664 , In_FlowTexture204_g235664 , In_UserTexture204_g235664 );
					TVEGlobalData Data15_g251675 =(TVEGlobalData)Data204_g235664;
					float Out_Dummy15_g251675 = 0.0;
					float4 Out_CoatTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251675 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251675 = float4( 0,0,0,0 );
					BreakData( Data15_g251675 , Out_Dummy15_g251675 , Out_CoatTexture15_g251675 , Out_DrawTexture15_g251675 , Out_PaintTexture15_g251675 , Out_AtmoTexture15_g251675 , Out_EffexTexture15_g251675 , Out_GlowTexture15_g251675 , Out_FormTexture15_g251675 , Out_LandTexture15_g251675 , Out_VertxTexture15_g251675 , Out_FlowTexture15_g251675 , Out_UserTexture15_g251675 );
					float4 Global_FormTexture351_g251665 = Out_FormTexture15_g251675;
					TVEModelData Data15_g251672 =(TVEModelData)Data15_g251663;
					float Out_Dummy15_g251672 = 0.0;
					float3 Out_PositionOS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251672 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251672 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251672 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251672 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251672 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251672 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251672 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251672 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251672 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251672 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251672 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251672 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251672 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251672 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251672 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251672 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251672 , Out_Dummy15_g251672 , Out_PositionOS15_g251672 , Out_PositionWS15_g251672 , Out_PositionWO15_g251672 , Out_PositionRawOS15_g251672 , Out_PivotOS15_g251672 , Out_PivotWS15_g251672 , Out_PivotWO15_g251672 , Out_NormalOS15_g251672 , Out_NormalWS15_g251672 , Out_NormalRawOS15_g251672 , Out_TangentOS15_g251672 , Out_TangentWS15_g251672 , Out_BitangentWS15_g251672 , Out_ViewDirWS15_g251672 , Out_CoordsData15_g251672 , Out_VertexData15_g251672 , Out_MasksData15_g251672 , Out_PhaseData15_g251672 , Out_TransformData15_g251672 , Out_RotationData15_g251672 , Out_Interpolator15_g251672 );
					float3 Model_PivotWO353_g251665 = Out_PivotWO15_g251672;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251671 = _ConformMeshMode;
					float Option70_g251671 = temp_output_17_0_g251671;
					half4 Model_VertexData357_g251665 = Out_VertexData15_g251672;
					float4 temp_output_3_0_g251671 = Model_VertexData357_g251665;
					float4 Channel70_g251671 = temp_output_3_0_g251671;
					float localSwitchChannel470_g251671 = SwitchChannel4( Option70_g251671 , Channel70_g251671 );
					float temp_output_390_0_g251665 = localSwitchChannel470_g251671;
					float temp_output_7_0_g251668 = _ConformMeshRemap.x;
					float temp_output_9_0_g251668 = ( temp_output_390_0_g251665 - temp_output_7_0_g251668 );
					float lerpResult374_g251665 = lerp( 1.0 , saturate( ( temp_output_9_0_g251668 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251665 = lerpResult374_g251665;
					float temp_output_328_0_g251665 = ( Blend_VertMask379_g251665 * TVE_IsEnabled );
					half Conform_Mask366_g251665 = temp_output_328_0_g251665;
					float temp_output_322_0_g251665 = ( ( ( ( (Global_FormTexture351_g251665).z - ( (Model_PivotWO353_g251665).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251665 ) );
					float3 appendResult329_g251665 = (float3(0.0 , temp_output_322_0_g251665 , 0.0));
					float3 appendResult387_g251665 = (float3(0.0 , 0.0 , temp_output_322_0_g251665));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251669 = appendResult387_g251665;
					#else
					float3 staticSwitch65_g251669 = appendResult329_g251665;
					#endif
					float3 Blanket_Conform368_g251665 = staticSwitch65_g251669;
					float4 appendResult312_g251665 = (float4(Blanket_Conform368_g251665 , 0.0));
					float4 temp_output_310_0_g251665 = ( Model_TransformData356_g251665 + appendResult312_g251665 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251665 = temp_output_310_0_g251665;
					#else
					float4 staticSwitch364_g251665 = Model_TransformData356_g251665;
					#endif
					half4 Final_TransformData365_g251665 = staticSwitch364_g251665;
					float4 In_TransformData16_g251674 = Final_TransformData365_g251665;
					float4 In_RotationData16_g251674 = Out_RotationData15_g251673;
					float4 In_Interpolator16_g251674 = Out_Interpolator15_g251673;
					BuildVertexData( Data16_g251674 , In_Dummy16_g251674 , In_PositionOS16_g251674 , In_NormalOS16_g251674 , In_TangentOS16_g251674 , In_TransformData16_g251674 , In_RotationData16_g251674 , In_Interpolator16_g251674 );
					TVEVertexData Data15_g251685 =(TVEVertexData)Data16_g251674;
					float Out_Dummy15_g251685 = 0.0;
					float3 Out_PositionOS15_g251685 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251685 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251685 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251685 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251685 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251685 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251685 , Out_Dummy15_g251685 , Out_PositionOS15_g251685 , Out_NormalOS15_g251685 , Out_TangentOS15_g251685 , Out_TransformData15_g251685 , Out_RotationData15_g251685 , Out_Interpolator15_g251685 );
					TVEVertexData Data16_g251686 =(TVEVertexData)Data15_g251685;
					float In_Dummy16_g251686 = 0.0;
					float3 Vertex_PositionOS147_g251676 = Out_PositionOS15_g251685;
					half3 VertexPos40_g251680 = Vertex_PositionOS147_g251676;
					float4 temp_output_1615_33_g251676 = Out_RotationData15_g251685;
					half4 Vertex_RotationData1569_g251676 = temp_output_1615_33_g251676;
					float2 break1582_g251676 = (Vertex_RotationData1569_g251676).xy;
					half Angle44_g251680 = break1582_g251676.y;
					half CosAngle89_g251680 = cos( Angle44_g251680 );
					half SinAngle93_g251680 = sin( Angle44_g251680 );
					float3 appendResult95_g251680 = (float3((VertexPos40_g251680).x , ( ( (VertexPos40_g251680).y * CosAngle89_g251680 ) - ( (VertexPos40_g251680).z * SinAngle93_g251680 ) ) , ( ( (VertexPos40_g251680).y * SinAngle93_g251680 ) + ( (VertexPos40_g251680).z * CosAngle89_g251680 ) )));
					half3 VertexPos40_g251681 = appendResult95_g251680;
					half Angle44_g251681 = -break1582_g251676.x;
					half CosAngle94_g251681 = cos( Angle44_g251681 );
					half SinAngle95_g251681 = sin( Angle44_g251681 );
					float3 appendResult98_g251681 = (float3(( ( (VertexPos40_g251681).x * CosAngle94_g251681 ) - ( (VertexPos40_g251681).y * SinAngle95_g251681 ) ) , ( ( (VertexPos40_g251681).x * SinAngle95_g251681 ) + ( (VertexPos40_g251681).y * CosAngle94_g251681 ) ) , (VertexPos40_g251681).z));
					half3 VertexPos40_g251679 = Vertex_PositionOS147_g251676;
					half Angle44_g251679 = break1582_g251676.y;
					half CosAngle89_g251679 = cos( Angle44_g251679 );
					half SinAngle93_g251679 = sin( Angle44_g251679 );
					float3 appendResult95_g251679 = (float3((VertexPos40_g251679).x , ( ( (VertexPos40_g251679).y * CosAngle89_g251679 ) - ( (VertexPos40_g251679).z * SinAngle93_g251679 ) ) , ( ( (VertexPos40_g251679).y * SinAngle93_g251679 ) + ( (VertexPos40_g251679).z * CosAngle89_g251679 ) )));
					half3 VertexPos40_g251684 = appendResult95_g251679;
					half Angle44_g251684 = break1582_g251676.x;
					half CosAngle91_g251684 = cos( Angle44_g251684 );
					half SinAngle92_g251684 = sin( Angle44_g251684 );
					float3 appendResult93_g251684 = (float3(( ( (VertexPos40_g251684).x * CosAngle91_g251684 ) + ( (VertexPos40_g251684).z * SinAngle92_g251684 ) ) , (VertexPos40_g251684).y , ( ( -(VertexPos40_g251684).x * SinAngle92_g251684 ) + ( (VertexPos40_g251684).z * CosAngle91_g251684 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251682 = appendResult93_g251684;
					#else
					float3 staticSwitch65_g251682 = appendResult98_g251681;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251677 = staticSwitch65_g251682;
					#else
					float3 staticSwitch65_g251677 = Vertex_PositionOS147_g251676;
					#endif
					float3 temp_output_1608_0_g251676 = staticSwitch65_g251677;
					half3 VertexPos40_g251683 = temp_output_1608_0_g251676;
					half Angle44_g251683 = (Vertex_RotationData1569_g251676).z;
					half CosAngle91_g251683 = cos( Angle44_g251683 );
					half SinAngle92_g251683 = sin( Angle44_g251683 );
					float3 appendResult93_g251683 = (float3(( ( (VertexPos40_g251683).x * CosAngle91_g251683 ) + ( (VertexPos40_g251683).z * SinAngle92_g251683 ) ) , (VertexPos40_g251683).y , ( ( -(VertexPos40_g251683).x * SinAngle92_g251683 ) + ( (VertexPos40_g251683).z * CosAngle91_g251683 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251678 = appendResult93_g251683;
					#else
					float3 staticSwitch65_g251678 = temp_output_1608_0_g251676;
					#endif
					float4 temp_output_1615_31_g251676 = Out_TransformData15_g251685;
					half4 Vertex_TransformData1568_g251676 = temp_output_1615_31_g251676;
					half3 Final_PositionOS178_g251676 = ( ( staticSwitch65_g251678 * (Vertex_TransformData1568_g251676).w ) + (Vertex_TransformData1568_g251676).xyz );
					float3 In_PositionOS16_g251686 = Final_PositionOS178_g251676;
					float3 In_NormalOS16_g251686 = Out_NormalOS15_g251685;
					float4 In_TangentOS16_g251686 = Out_TangentOS15_g251685;
					float4 In_TransformData16_g251686 = temp_output_1615_31_g251676;
					float4 In_RotationData16_g251686 = temp_output_1615_33_g251676;
					float4 In_Interpolator16_g251686 = Out_Interpolator15_g251685;
					BuildVertexData( Data16_g251686 , In_Dummy16_g251686 , In_PositionOS16_g251686 , In_NormalOS16_g251686 , In_TangentOS16_g251686 , In_TransformData16_g251686 , In_RotationData16_g251686 , In_Interpolator16_g251686 );
					TVEVertexData Data15_g251689 =(TVEVertexData)Data16_g251686;
					float Out_Dummy15_g251689 = 0.0;
					float3 Out_PositionOS15_g251689 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251689 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251689 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251689 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251689 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251689 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251689 , Out_Dummy15_g251689 , Out_PositionOS15_g251689 , Out_NormalOS15_g251689 , Out_TangentOS15_g251689 , Out_TransformData15_g251689 , Out_RotationData15_g251689 , Out_Interpolator15_g251689 );
					TVEVertexData Data16_g251690 =(TVEVertexData)Data15_g251689;
					float In_Dummy16_g251690 = 0.0;
					TVEModelData Data15_g251688 =(TVEModelData)Data15_g251672;
					float Out_Dummy15_g251688 = 0.0;
					float3 Out_PositionOS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251688 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251688 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251688 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251688 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251688 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251688 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251688 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251688 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251688 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251688 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251688 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251688 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251688 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251688 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251688 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251688 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251688 , Out_Dummy15_g251688 , Out_PositionOS15_g251688 , Out_PositionWS15_g251688 , Out_PositionWO15_g251688 , Out_PositionRawOS15_g251688 , Out_PivotOS15_g251688 , Out_PivotWS15_g251688 , Out_PivotWO15_g251688 , Out_NormalOS15_g251688 , Out_NormalWS15_g251688 , Out_NormalRawOS15_g251688 , Out_TangentOS15_g251688 , Out_TangentWS15_g251688 , Out_BitangentWS15_g251688 , Out_ViewDirWS15_g251688 , Out_CoordsData15_g251688 , Out_VertexData15_g251688 , Out_MasksData15_g251688 , Out_PhaseData15_g251688 , Out_TransformData15_g251688 , Out_RotationData15_g251688 , Out_Interpolator15_g251688 );
					float3 In_PositionOS16_g251690 = ( Out_PositionOS15_g251689 + Out_PivotOS15_g251688 );
					float3 In_NormalOS16_g251690 = Out_NormalOS15_g251689;
					float4 In_TangentOS16_g251690 = Out_TangentOS15_g251689;
					float4 In_TransformData16_g251690 = Out_TransformData15_g251689;
					float4 In_RotationData16_g251690 = Out_RotationData15_g251689;
					float4 In_Interpolator16_g251690 = Out_Interpolator15_g251689;
					BuildVertexData( Data16_g251690 , In_Dummy16_g251690 , In_PositionOS16_g251690 , In_NormalOS16_g251690 , In_TangentOS16_g251690 , In_TransformData16_g251690 , In_RotationData16_g251690 , In_Interpolator16_g251690 );
					TVEVertexData Data15_g252100 =(TVEVertexData)Data16_g251690;
					float Out_Dummy15_g252100 = 0.0;
					float3 Out_PositionOS15_g252100 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252100 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252100 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252100 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252100 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252100 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252100 , Out_Dummy15_g252100 , Out_PositionOS15_g252100 , Out_NormalOS15_g252100 , Out_TangentOS15_g252100 , Out_TransformData15_g252100 , Out_RotationData15_g252100 , Out_Interpolator15_g252100 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252100;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half3 normal : NORMAL;
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

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
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
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
					o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					return _SelectionID;
				}
			ENDCG
		}
		
	}
	
	
	Fallback Off
}
/*ASEBEGIN
Version=19912
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-6976,-4928],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6528,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2375,"pos":[-6272,-4992],"params":["Inherit","False","Block Global","86","","235664","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2372,"pos":[-7296,-4992],"params":["Inherit","False","Block Model","72","","235765","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-5952,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-6976,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2690,"pos":[-5504,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2691,"pos":[-5504,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2689,"pos":[-5248,-4992],"params":["Inherit","False","Block Vertex","-1","","251658","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2665,"pos":[-4864,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","251661","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2667,"pos":[-4480,-4992],"params":["Inherit","False","Block Blanket Conform","165","","251665","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2668,"pos":[-4096,-4992],"params":["Inherit","False","Block Transform","-1","","251676","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2669,"pos":[-3712,-4992],"params":["Inherit","False","Block Pivots Add","-1","","251687","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2670,"pos":[-3392,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2692,"pos":[-2944,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2693,"pos":[-2944,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2695,"pos":[-2944,-4992],"params":["Inherit","False","2670","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2694,"pos":[-2688,-4992],"params":["Inherit","False","Block Visual","-1","","251885","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2380,"pos":[-2304,-4992],"params":["Inherit","False","Block Main","179","","251889","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2454,"pos":[-1984,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2600,"pos":[-896,-4992],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2507,"pos":[-896,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2508,"pos":[-896,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2662,"pos":[-640,-4992],"params":["Inherit","False","Block Layer","7","","251928","5f6a6b9e0b5515744bf8e48a9ccead1b","44,986,1,1104,1,1105,1,1107,1,1162,0,1109,1,1110,1,1111,1,1112,1,1115,1,1172,1,748,1,1070,1,1066,1,1258,1,1124,1,1198,0,1195,0,1199,0,1196,0,1200,0,1197,0,1165,0,1167,0,1168,0,1173,0,1174,0,1171,0,1166,0,1170,0,1169,0,1048,0,1045,1,1207,0,1175,0,1053,1,1177,0,1201,0,1202,0,1086,1,1035,1,1055,1,1136,1,1051,1","3","585","OBJECT","0,0,0,0","False","633","OBJECT","0,0,0,0","False","974","OBJECT","0,0,0,0","False","4","OBJECT","552","OBJECT","1259","OBJECT","1260","OBJECT","1098"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2663,"pos":[-640,-4832],"params":["Inherit","False","Block Layer","7","","252005","5f6a6b9e0b5515744bf8e48a9ccead1b","44,986,1,1104,1,1105,1,1107,1,1162,0,1109,1,1110,1,1111,1,1112,1,1115,1,1172,1,748,1,1070,1,1066,1,1258,1,1124,1,1198,0,1195,0,1199,0,1196,0,1200,0,1197,0,1165,0,1167,0,1168,0,1173,0,1174,0,1171,0,1166,0,1170,0,1169,0,1048,1,1045,1,1207,0,1175,0,1053,1,1177,0,1201,0,1202,0,1086,1,1035,1,1055,1,1136,1,1051,1","3","585","OBJECT","0,0,0,0","False","633","OBJECT","0,0,0,0","False","974","OBJECT","0,0,0,0","False","4","OBJECT","552","OBJECT","1259","OBJECT","1260","OBJECT","1098"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2620,"pos":[-576,-4672],"params":["Half","False","Global","TVE_DEBUG_Global","TVE_DEBUG_Global","4","0","Create","True","0","5","Vertex Colors","100","Texture Coords","200","Vertex Postion","300","Vertex Normals","301","Vertex Tangents","302","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2619,"pos":[-256,-4992],"params":["Inherit","False","If Masks Data","-1","","252082","8077f199aa3992c4b8c999410c1ede62","1,32,0","8","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","28","OBJECT","0","False","27","OBJECT","0","False","30","OBJECT","0","False","31","OBJECT","0","False","29","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2509,"pos":[0,-4992],"params":["Inherit","False","Break Masks Data","-1","","252083","23311522ecc97b54e8b77d849401069d","0","1","6","OBJECT","0","False","8","FLOAT4","14","FLOAT4","0","FLOAT4","23","FLOAT4","5","FLOAT4","24","FLOAT4","25","FLOAT4","26","FLOAT4","27"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2567,"pos":[768,-4864],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2646,"pos":[768,-4992],"params":["Inherit","False","Tool Debug Active","67","","252084","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2608,"pos":[768,-4336],"params":["Inherit","False","FLOAT","3","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2649,"pos":[768,-4464],"params":["Inherit","False","Tool Debug Active","67","","252086","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2490,"pos":[-7296,-5248],"params":["Inherit","False","Property","_IsTerrainShader","_IsTerrainShader","85","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2568,"pos":[1024,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2607,"pos":[1024,-4464],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2610,"pos":[768,-4736],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2496,"pos":[-7040,-5248],"params":["Half","False","IsTerranShader","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[1408,-4992],"params":["Inherit","False","Tool Debug Index","-1","","252088","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2611,"pos":[1408,-4736],"params":["Inherit","False","Tool Debug Index","-1","","252089","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2609,"pos":[1408,-4464],"params":["Inherit","False","Tool Debug Index","-1","","252090","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[1792,-4992],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2661,"pos":[1792,-4736],"params":["Inherit","False","2496","IsTerranShader","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2660,"pos":[2048,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[2368,-4992],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[3072,-4992],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2563,"pos":[3072,-4928],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2555,"pos":[3072,-4864],"params":["Inherit","False","2670","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3712,-5120],"params":["Inherit","False","Base Compile","-1","","252091","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2682,"pos":[3328,-4992],"params":["Inherit","False","Tool Debug Color","0","","252092","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2674,"pos":[3712,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2675,"pos":[3712,-4992],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Layer","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=True=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","639089505898812634","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","639089504250145863","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","639089504111867997","Receive Shadows","0","639089504104215593","Receive Specular","0","639089504120453115","GPU Instancing","1","0","LOD CrossFade","0","639089504127911031","Built-in Fog","0","639089504133148878","Ambient Light","0","639089504138429359","Meta Pass","0","639089504142386391","Add Pass","0","639089504147017246","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","1","639089504198152963","Vertex Position","0","639089504210233922","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2676,"pos":[3328,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2677,"pos":[3328,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2678,"pos":[3328,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2679,"pos":[3328,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2680,"pos":[3328,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2681,"pos":[3712,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2373,0,2372,314]}
{"wire":[2375,206,2374,0]}
{"wire":[2505,0,2375,151]}
{"wire":[2377,0,2372,128]}
{"wire":[2689,1894,2690,0]}
{"wire":[2689,1896,2691,0]}
{"wire":[2665,224,2689,128]}
{"wire":[2665,146,2689,1895]}
{"wire":[2665,231,2689,1897]}
{"wire":[2667,146,2665,128]}
{"wire":[2667,397,2665,229]}
{"wire":[2667,186,2665,232]}
{"wire":[2668,146,2667,128]}
{"wire":[2668,1620,2667,398]}
{"wire":[2668,1619,2667,399]}
{"wire":[2669,146,2668,128]}
{"wire":[2669,225,2668,1617]}
{"wire":[2669,227,2668,1618]}
{"wire":[2670,0,2669,128]}
{"wire":[2694,1904,2695,0]}
{"wire":[2694,1894,2693,0]}
{"wire":[2694,1896,2692,0]}
{"wire":[2380,430,2694,1900]}
{"wire":[2380,225,2694,1895]}
{"wire":[2380,414,2694,1897]}
{"wire":[2454,0,2380,106]}
{"wire":[2662,585,2600,0]}
{"wire":[2662,633,2508,0]}
{"wire":[2662,974,2507,0]}
{"wire":[2663,585,2600,0]}
{"wire":[2663,633,2508,0]}
{"wire":[2663,974,2507,0]}
{"wire":[2619,3,2662,1098]}
{"wire":[2619,17,2663,1098]}
{"wire":[2619,19,2620,0]}
{"wire":[2509,6,2619,0]}
{"wire":[2567,0,2509,14]}
{"wire":[2608,0,2509,14]}
{"wire":[2568,0,2646,108]}
{"wire":[2568,1,2646,0]}
{"wire":[2568,2,2567,0]}
{"wire":[2607,0,2649,108]}
{"wire":[2607,1,2649,0]}
{"wire":[2607,2,2608,0]}
{"wire":[2610,0,2509,0]}
{"wire":[2496,0,2490,0]}
{"wire":[2594,39,2568,0]}
{"wire":[2611,39,2610,0]}
{"wire":[2609,39,2607,0]}
{"wire":[2550,0,2594,0]}
{"wire":[2550,1,2611,0]}
{"wire":[2550,2,2609,0]}
{"wire":[2660,0,2550,0]}
{"wire":[2660,2,2661,0]}
{"wire":[2399,0,2660,0]}
{"wire":[1774,0,1771,0]}
{"wire":[1774,1,1772,0]}
{"wire":[1774,3,1803,0]}
{"wire":[1803,0,1800,0]}
{"wire":[1843,0,1804,0]}
{"wire":[1800,0,1843,0]}
{"wire":[2682,80,2400,0]}
{"wire":[2682,106,2563,0]}
{"wire":[2682,107,2555,0]}
{"wire":[2675,0,2682,114]}
{"wire":[2675,3,2682,114]}
{"wire":[2675,5,2682,114]}
{"wire":[2675,2,2682,0]}
{"wire":[2675,15,2682,113]}
ASEEND*/
//CHKSM=5DA646AC5AE52C326DA01F0D973CB049DDB0C9B2