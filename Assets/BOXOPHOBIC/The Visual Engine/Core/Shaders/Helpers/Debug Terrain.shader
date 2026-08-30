// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Terrain"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_TerrainIntensityValue( "Terrain Intensity", Range( 0, 1 ) ) = 0
		[HideInInspector] _TerrainAlbedoTex( "_TerrainAlbedoTex", 2D ) = "white" {}
		[HideInInspector] _TerrainNormalTex( "_TerrainNormalTex", 2D ) = "linearGrey" {}
		[HideInInspector] _TerrainShaderTex( "_TerrainShaderTex", 2D ) = "white" {}
		[HideInInspector] _TerrainFeatureTex( "_TerrainFeatureTex", 2D ) = "white" {}
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode1( "Terrain 01 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode2( "Terrain 02 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode3( "Terrain 03 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode4( "Terrain 04 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode5( "Terrain 05 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode6( "Terrain 06 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode7( "Terrain 07 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode8( "Terrain 08 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode9( "Terrain 09 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode10( "Terrain 10 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode11( "Terrain 11 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode12( "Terrain 12 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode13( "Terrain 13 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode14( "Terrain 14 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode15( "Terrain 15 Sampling", Float ) = 0
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochasitc Triplanar,3)] _TerrainSampleMode16( "Terrain 16 Sampling", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _TerrainMaskTex( "Terrain Mask", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3)][Space(10)] _TerrainMaskSampleMode( "Mask Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _TerrainMaskCoordMode( "Mask UV Mode", Float ) = 0
		[StyledVector(9)] _TerrainMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_TerrainMaskValue( "Terrain TexR Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _TerrainMaskRemap( "Terrain TexR Mask", Vector ) = ( 0, 1, 0, 0 )
		_TerrainBaseValue( "Terrain Base Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _TerrainBaseRemap( "Terrain Base Mask", Vector ) = ( 1, 0, 0, 1 )
		_TerrainProjValue( "Terrain ProjY Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _TerrainProjRemap( "Terrain ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_TerrainFormValue( "Terrain Form Mask", Range( 0, 16 ) ) = 1
		[Enum(Multiply,0,Additive,1,Multiply And Additive,2)] _TerrainFormMath( "Terrain Form Mask", Float ) = 2
		[StyledRemapSlider] _TerrainBlendRemap( "Terrain Blend Mask", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _terrain_mask_coord_value( "_terrain_mask_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Y Up,0,Z Up,1)] _ObjectCoordMode( "Object Coord Mode", Float ) = 0
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
		_IsShaderType( "_IsShaderType", Float ) = 0
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
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
		[StyledCategory(Conform Settings, true, Use the Conform feature to project the vertices to the terrain or mesh surfaces__ similar to how decals work__ but for 3D objects. The most common usage is with big patches of grass__ groups of rocks or QUOplanarQUO ground covers which would not work properly on curved surfaces. Please note__ the projection only works from top down view and the effect it is only visual OPAcollider is not affectedCPAEXC, _ConformIntensityValue, FF0000, 0, 10)] _ConformCategory( "[ Conform Category ]", Float ) = 0
		[StyledMessage(Info, The Conform position features require elements to work. Use Form Surface or Form Height elements for conforming  the objects to terrain surfaces. Please note__ the conform effect is only visual and it does not affect the object collider and bounds., 0, 10)] _ConformInfo( "_ConformInfo", Float ) = 0
		_ConformIntensityValue( "Conform Intensity", Range( 0, 1 ) ) = 0
		[Enum(Freeform Object Position,0,Lock Position With Conform,1)] _ConformMode( "Conform Mode", Float ) = 1
		_ConformOffsetValue( "Conform Offset", Float ) = 0
		[Space(10)] _ConformMeshValue( "Conform Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ConformMeshMode( "Conform Mesh Mask", Float ) = 3
		[StyledRemapSlider] _ConformMeshRemap( "Conform Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _ConformEnd( "[ Conform End ]", Float ) = 1


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
		

		

		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="False" }

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
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_TERRAIN_MASK_SAMPLE_MAIN_UV TVE_TERRAIN_MASK_SAMPLE_EXTRA_UV TVE_TERRAIN_MASK_SAMPLE_PLANAR_2D TVE_TERRAIN_MASK_SAMPLE_PLANAR_3D
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				#if defined (TVE_TERRAIN_HOLES) //Terrain Holes
					#define TVE_ALPHA_CLIP //Terrain Holes
				#endif //Terrain Holes
				  
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

				uniform half _TerrainSampleMode6;
				uniform half _TerrainSampleMode7;
				uniform half _TerrainSampleMode8;
				uniform half _TerrainSampleMode5;
				uniform half _TerrainSampleMode10;
				uniform half _TerrainSampleMode11;
				uniform half _TerrainSampleMode12;
				uniform half _TerrainSampleMode9;
				uniform half _TerrainSampleMode14;
				uniform half _TerrainSampleMode15;
				uniform half _TerrainSampleMode16;
				uniform half _TerrainSampleMode13;
				uniform half _TerrainSampleMode2;
				uniform half _TerrainSampleMode3;
				uniform half _TerrainSampleMode4;
				uniform half _TerrainSampleMode1;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainFeatureTex);
				SamplerState sampler_TerrainFeatureTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainShaderTex);
				SamplerState sampler_TerrainShaderTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainNormalTex);
				SamplerState sampler_TerrainNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainAlbedoTex);
				SamplerState sampler_TerrainAlbedoTex;
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
				uniform float _IsShaderType;
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
				uniform half _TerrainIntensityValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainMaskTex);
				uniform half4 _terrain_mask_coord_value;
				uniform half _TerrainMaskSampleMode;
				uniform half _TerrainMaskCoordMode;
				uniform half4 _TerrainMaskCoordValue;
				uniform half4 _TerrainMaskRemap;
				uniform half _TerrainMaskValue;
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
				uniform half4 _TerrainBaseRemap;
				uniform half _TerrainBaseValue;
				uniform half4 _TerrainProjRemap;
				uniform half _TerrainProjValue;
				uniform float _TerrainFormValue;
				uniform half _TerrainFormMath;
				uniform half4 _TerrainBlendRemap;
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
				
				float SwitchFormMask( float Multiply, float Additive, float MulAdd, half Option )
				{
					switch (Option) {
						default:
					                case 0:
							return Multiply;
						case 1:
							return Additive;
						case 2:
							return MulAdd;
					}
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251977 =(TVEVertexData)0;
					float In_Dummy16_g251977 = 0.0;
					TVEVertexData Data16_g251972 =(TVEVertexData)0;
					float In_Dummy16_g251972 = 0.0;
					float localIfModelDataByShader26_g251465 = ( 0.0 );
					TVEModelData Data26_g251465 = (TVEModelData)0;
					TVEModelData Data16_g241434 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#endif
					half Dummy207_g241416 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241416 );
					float temp_output_14_0_g241434 = Dummy207_g241416;
					float In_Dummy16_g241434 = temp_output_14_0_g241434;
					float3 PositionOS131_g241416 = v.vertex.xyz;
					float3 temp_output_4_0_g241434 = PositionOS131_g241416;
					float3 In_PositionOS16_g241434 = temp_output_4_0_g241434;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241416 = ase_positionWS;
					float3 vertexToFrag73_g241416 = temp_output_104_7_g241416;
					float3 PositionWS122_g241416 = vertexToFrag73_g241416;
					float3 In_PositionWS16_g241434 = PositionWS122_g241416;
					float4x4 break19_g241419 = unity_ObjectToWorld;
					float3 appendResult20_g241419 = (float3(break19_g241419[ 0 ][ 3 ] , break19_g241419[ 1 ][ 3 ] , break19_g241419[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241416 = appendResult20_g241419;
					float4x4 break19_g241421 = unity_ObjectToWorld;
					float3 appendResult20_g241421 = (float3(break19_g241421[ 0 ][ 3 ] , break19_g241421[ 1 ][ 3 ] , break19_g241421[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241417 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241416 = PositionOS131_g241416;
					float3 appendResult234_g241416 = (float3(break233_g241416.x , 0.0 , break233_g241416.z));
					float3 break413_g241416 = PositionOS131_g241416;
					float3 appendResult414_g241416 = (float3(break413_g241416.x , break413_g241416.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241423 = appendResult414_g241416;
					#else
					float3 staticSwitch65_g241423 = appendResult234_g241416;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241416 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241416 = appendResult60_g241417;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241416 = staticSwitch65_g241423;
					#else
					float3 staticSwitch229_g241416 = _Vector0;
					#endif
					float3 PivotOS149_g241416 = staticSwitch229_g241416;
					float3 temp_output_122_0_g241421 = PivotOS149_g241416;
					float3 PivotsOnlyWS105_g241421 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241421 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241416 = ( appendResult20_g241421 + PivotsOnlyWS105_g241421 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#else
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#endif
					float3 vertexToFrag76_g241416 = staticSwitch236_g241416;
					float3 PivotWS121_g241416 = vertexToFrag76_g241416;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241416 = ( PositionWS122_g241416 - PivotWS121_g241416 );
					#else
					float3 staticSwitch204_g241416 = PositionWS122_g241416;
					#endif
					float3 PositionWO132_g241416 = ( staticSwitch204_g241416 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241434 = PositionWO132_g241416;
					float3 In_PivotOS16_g241434 = PivotOS149_g241416;
					float3 In_PivotWS16_g241434 = PivotWS121_g241416;
					float3 PivotWO133_g241416 = ( PivotWS121_g241416 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241434 = PivotWO133_g241416;
					half3 NormalOS134_g241416 = v.normal;
					float3 temp_output_21_0_g241434 = NormalOS134_g241416;
					float3 In_NormalOS16_g241434 = temp_output_21_0_g241434;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241416 = normalizedWorldNormal;
					float3 In_NormalWS16_g241434 = NormalWS95_g241416;
					half4 TangentlOS153_g241416 = v.tangent;
					float4 temp_output_6_0_g241434 = TangentlOS153_g241416;
					float4 In_TangentOS16_g241434 = temp_output_6_0_g241434;
					float3 normalizeResult296_g241416 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241416 ) );
					half3 ViewDirWS169_g241416 = normalizeResult296_g241416;
					float3 In_ViewDirWS16_g241434 = ViewDirWS169_g241416;
					float4 appendResult397_g241416 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241416 = appendResult397_g241416;
					float4 In_CoordsData16_g241434 = CoordsData398_g241416;
					half4 VertexMasks171_g241416 = v.ase_color;
					float4 In_VertexData16_g241434 = VertexMasks171_g241416;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241428 = (PositionOS131_g241416).z;
					#else
					float staticSwitch65_g241428 = (PositionOS131_g241416).y;
					#endif
					half Object_HeightValue267_g241416 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241416 = saturate( ( staticSwitch65_g241428 / Object_HeightValue267_g241416 ) );
					half3 Position387_g241416 = PositionOS131_g241416;
					half Height387_g241416 = Object_HeightValue267_g241416;
					half Object_RadiusValue268_g241416 = _ObjectRadiusValue;
					half Radius387_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskYUp387_g241416 = CapsuleMaskYUp( Position387_g241416 , Height387_g241416 , Radius387_g241416 );
					half3 Position408_g241416 = PositionOS131_g241416;
					half Height408_g241416 = Object_HeightValue267_g241416;
					half Radius408_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskZUp408_g241416 = CapsuleMaskZUp( Position408_g241416 , Height408_g241416 , Radius408_g241416 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241433 = saturate( localCapsuleMaskZUp408_g241416 );
					#else
					float staticSwitch65_g241433 = saturate( localCapsuleMaskYUp387_g241416 );
					#endif
					half Bounds_SphereMask282_g241416 = staticSwitch65_g241433;
					float4 appendResult253_g241416 = (float4(Bounds_HeightMask274_g241416 , Bounds_SphereMask282_g241416 , 1.0 , 1.0));
					half4 MasksData254_g241416 = appendResult253_g241416;
					float4 In_MasksData16_g241434 = MasksData254_g241416;
					float temp_output_17_0_g241427 = _ObjectPhaseMode;
					float Option70_g241427 = temp_output_17_0_g241427;
					float4 temp_output_3_0_g241427 = v.ase_color;
					float4 Channel70_g241427 = temp_output_3_0_g241427;
					float localSwitchChannel470_g241427 = SwitchChannel4( Option70_g241427 , Channel70_g241427 );
					half Phase_Value372_g241416 = localSwitchChannel470_g241427;
					float3 break319_g241416 = PivotWO133_g241416;
					half Pivot_Position322_g241416 = ( break319_g241416.x + break319_g241416.z );
					half Phase_Position357_g241416 = ( Phase_Value372_g241416 + Pivot_Position322_g241416 );
					float temp_output_248_0_g241416 = frac( Phase_Position357_g241416 );
					float4 appendResult177_g241416 = (float4((frac( ( Phase_Position357_g241416 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241416));
					half4 Phase_Data176_g241416 = appendResult177_g241416;
					float4 In_PhaseData16_g241434 = Phase_Data176_g241416;
					BuildModelVertData( Data16_g241434 , In_Dummy16_g241434 , In_PositionOS16_g241434 , In_PositionWS16_g241434 , In_PositionWO16_g241434 , In_PivotOS16_g241434 , In_PivotWS16_g241434 , In_PivotWO16_g241434 , In_NormalOS16_g241434 , In_NormalWS16_g241434 , In_TangentOS16_g241434 , In_ViewDirWS16_g241434 , In_CoordsData16_g241434 , In_VertexData16_g241434 , In_MasksData16_g241434 , In_PhaseData16_g241434 );
					TVEModelData DataDefault26_g251465 = Data16_g241434;
					TVEModelData DataGeneral26_g251465 = Data16_g241434;
					TVEModelData DataBlanket26_g251465 = Data16_g241434;
					TVEModelData DataImpostor26_g251465 = Data16_g241434;
					TVEModelData Data16_g241414 =(TVEModelData)0;
					half Dummy207_g241396 = 0.0;
					float temp_output_14_0_g241414 = Dummy207_g241396;
					float In_Dummy16_g241414 = temp_output_14_0_g241414;
					float3 PositionOS131_g241396 = v.vertex.xyz;
					float3 temp_output_4_0_g241414 = PositionOS131_g241396;
					float3 In_PositionOS16_g241414 = temp_output_4_0_g241414;
					float3 temp_output_104_7_g241396 = ase_positionWS;
					float3 PositionWS122_g241396 = temp_output_104_7_g241396;
					float3 In_PositionWS16_g241414 = PositionWS122_g241396;
					float4x4 break19_g241399 = unity_ObjectToWorld;
					float3 appendResult20_g241399 = (float3(break19_g241399[ 0 ][ 3 ] , break19_g241399[ 1 ][ 3 ] , break19_g241399[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241396 = appendResult20_g241399;
					float3 PivotWS121_g241396 = temp_output_340_7_g241396;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241396 = ( PositionWS122_g241396 - PivotWS121_g241396 );
					#else
					float3 staticSwitch204_g241396 = PositionWS122_g241396;
					#endif
					float3 PositionWO132_g241396 = ( staticSwitch204_g241396 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241414 = PositionWO132_g241396;
					float3 PivotOS149_g241396 = _Vector0;
					float3 In_PivotOS16_g241414 = PivotOS149_g241396;
					float3 In_PivotWS16_g241414 = PivotWS121_g241396;
					float3 PivotWO133_g241396 = ( PivotWS121_g241396 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241414 = PivotWO133_g241396;
					half3 NormalOS134_g241396 = v.normal;
					float3 temp_output_21_0_g241414 = NormalOS134_g241396;
					float3 In_NormalOS16_g241414 = temp_output_21_0_g241414;
					half3 NormalWS95_g241396 = normalizedWorldNormal;
					float3 In_NormalWS16_g241414 = NormalWS95_g241396;
					float4 appendResult462_g241396 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241396 = appendResult462_g241396;
					float4 temp_output_6_0_g241414 = TangentlOS153_g241396;
					float4 In_TangentOS16_g241414 = temp_output_6_0_g241414;
					float3 normalizeResult296_g241396 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241396 ) );
					half3 ViewDirWS169_g241396 = normalizeResult296_g241396;
					float3 In_ViewDirWS16_g241414 = ViewDirWS169_g241396;
					float4 appendResult397_g241396 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241396 = appendResult397_g241396;
					float4 In_CoordsData16_g241414 = CoordsData398_g241396;
					half4 VertexMasks171_g241396 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241414 = VertexMasks171_g241396;
					half4 MasksData254_g241396 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241414 = MasksData254_g241396;
					half4 Phase_Data176_g241396 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241414 = Phase_Data176_g241396;
					BuildModelVertData( Data16_g241414 , In_Dummy16_g241414 , In_PositionOS16_g241414 , In_PositionWS16_g241414 , In_PositionWO16_g241414 , In_PivotOS16_g241414 , In_PivotWS16_g241414 , In_PivotWO16_g241414 , In_NormalOS16_g241414 , In_NormalWS16_g241414 , In_TangentOS16_g241414 , In_ViewDirWS16_g241414 , In_CoordsData16_g241414 , In_VertexData16_g241414 , In_MasksData16_g241414 , In_PhaseData16_g241414 );
					TVEModelData DataTerrain26_g251465 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251465 = IsShaderType2672;
					{
					if (Type26_g251465 == 0 )
					{
					Data26_g251465 = DataDefault26_g251465;
					}
					else if (Type26_g251465 == 1 )
					{
					Data26_g251465 = DataGeneral26_g251465;
					}
					else if (Type26_g251465 == 2 )
					{
					Data26_g251465 = DataBlanket26_g251465;
					}
					else if (Type26_g251465 == 3 )
					{
					Data26_g251465 = DataImpostor26_g251465;
					}
					else if (Type26_g251465 == 4 )
					{
					Data26_g251465 = DataTerrain26_g251465;
					}
					}
					TVEModelData Data15_g251973 =(TVEModelData)Data26_g251465;
					float Out_Dummy15_g251973 = 0.0;
					float3 Out_PositionOS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251973 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251973 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251973 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251973 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251973 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251973 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251973 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251973 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251973 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251973 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251973 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251973 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251973 , Out_Dummy15_g251973 , Out_PositionOS15_g251973 , Out_PositionWS15_g251973 , Out_PositionWO15_g251973 , Out_PositionRawOS15_g251973 , Out_PivotOS15_g251973 , Out_PivotWS15_g251973 , Out_PivotWO15_g251973 , Out_NormalOS15_g251973 , Out_NormalWS15_g251973 , Out_NormalRawOS15_g251973 , Out_TangentOS15_g251973 , Out_TangentWS15_g251973 , Out_BitangentWS15_g251973 , Out_ViewDirWS15_g251973 , Out_CoordsData15_g251973 , Out_VertexData15_g251973 , Out_MasksData15_g251973 , Out_PhaseData15_g251973 , Out_TransformData15_g251973 , Out_RotationData15_g251973 , Out_Interpolator15_g251973 );
					float3 In_PositionOS16_g251972 = Out_PositionOS15_g251973;
					float3 In_NormalOS16_g251972 = Out_NormalOS15_g251973;
					float4 In_TangentOS16_g251972 = Out_TangentOS15_g251973;
					float4 In_TransformData16_g251972 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251972 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251972 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251972 , In_Dummy16_g251972 , In_PositionOS16_g251972 , In_NormalOS16_g251972 , In_TangentOS16_g251972 , In_TransformData16_g251972 , In_RotationData16_g251972 , In_Interpolator16_g251972 );
					TVEVertexData Data15_g251975 =(TVEVertexData)Data16_g251972;
					float Out_Dummy15_g251975 = 0.0;
					float3 Out_PositionOS15_g251975 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251975 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251975 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251975 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251975 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251975 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251975 , Out_Dummy15_g251975 , Out_PositionOS15_g251975 , Out_NormalOS15_g251975 , Out_TangentOS15_g251975 , Out_TransformData15_g251975 , Out_RotationData15_g251975 , Out_Interpolator15_g251975 );
					TVEModelData Data15_g251976 =(TVEModelData)Data15_g251973;
					float Out_Dummy15_g251976 = 0.0;
					float3 Out_PositionOS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251976 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251976 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251976 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251976 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251976 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251976 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251976 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251976 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251976 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251976 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251976 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251976 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251976 , Out_Dummy15_g251976 , Out_PositionOS15_g251976 , Out_PositionWS15_g251976 , Out_PositionWO15_g251976 , Out_PositionRawOS15_g251976 , Out_PivotOS15_g251976 , Out_PivotWS15_g251976 , Out_PivotWO15_g251976 , Out_NormalOS15_g251976 , Out_NormalWS15_g251976 , Out_NormalRawOS15_g251976 , Out_TangentOS15_g251976 , Out_TangentWS15_g251976 , Out_BitangentWS15_g251976 , Out_ViewDirWS15_g251976 , Out_CoordsData15_g251976 , Out_VertexData15_g251976 , Out_MasksData15_g251976 , Out_PhaseData15_g251976 , Out_TransformData15_g251976 , Out_RotationData15_g251976 , Out_Interpolator15_g251976 );
					float3 In_PositionOS16_g251977 = ( Out_PositionOS15_g251975 - Out_PivotOS15_g251976 );
					float3 In_NormalOS16_g251977 = Out_NormalOS15_g251976;
					float4 In_TangentOS16_g251977 = Out_TangentOS15_g251976;
					float4 In_TransformData16_g251977 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251977 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251977 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251977 , In_Dummy16_g251977 , In_PositionOS16_g251977 , In_NormalOS16_g251977 , In_TangentOS16_g251977 , In_TransformData16_g251977 , In_RotationData16_g251977 , In_Interpolator16_g251977 );
					TVEVertexData Data15_g251986 =(TVEVertexData)Data16_g251977;
					float Out_Dummy15_g251986 = 0.0;
					float3 Out_PositionOS15_g251986 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251986 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251986 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251986 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251986 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251986 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251986 , Out_Dummy15_g251986 , Out_PositionOS15_g251986 , Out_NormalOS15_g251986 , Out_TangentOS15_g251986 , Out_TransformData15_g251986 , Out_RotationData15_g251986 , Out_Interpolator15_g251986 );
					TVEVertexData Data16_g251987 =(TVEVertexData)Data15_g251986;
					half Dummy317_g251978 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251987 = Dummy317_g251978;
					float3 In_PositionOS16_g251987 = Out_PositionOS15_g251986;
					float3 In_NormalOS16_g251987 = Out_NormalOS15_g251986;
					float4 In_TangentOS16_g251987 = Out_TangentOS15_g251986;
					half4 Model_TransformData356_g251978 = Out_TransformData15_g251986;
					float localBuildGlobalData204_g251364 = ( 0.0 );
					TVEGlobalData Data204_g251364 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251364 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251364 = Dummy211_g251364;
					float4 temp_output_203_0_g251383 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241424 =(TVEModelData)0;
					float In_Dummy16_g241424 = 0.0;
					float3 In_PositionWS16_g241424 = PositionWS122_g241416;
					float3 In_PositionWO16_g241424 = PositionWO132_g241416;
					float3 In_PivotWS16_g241424 = PivotWS121_g241416;
					float3 In_PivotWO16_g241424 = PivotWO133_g241416;
					float3 In_NormalWS16_g241424 = NormalWS95_g241416;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241416 = ase_tangentWS;
					float3 In_TangentWS16_g241424 = TangentWS136_g241416;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241416 = ase_bitangentWS;
					float3 In_BitangentWS16_g241424 = BiangentWS421_g241416;
					half3 NormalWS427_g241416 = NormalWS95_g241416;
					half3 localComputeTriplanarMasks427_g241416 = ComputeTriplanarMasks( NormalWS427_g241416 );
					half3 TriplanarWeights429_g241416 = localComputeTriplanarMasks427_g241416;
					float3 In_TriplanarWeights16_g241424 = TriplanarWeights429_g241416;
					float3 In_ViewDirWS16_g241424 = ViewDirWS169_g241416;
					float4 In_CoordsData16_g241424 = CoordsData398_g241416;
					float4 In_VertexData16_g241424 = VertexMasks171_g241416;
					float4 In_Interpolator16_g241424 = Phase_Data176_g241416;
					BuildModelFragData( Data16_g241424 , In_Dummy16_g241424 , In_PositionWS16_g241424 , In_PositionWO16_g241424 , In_PivotWS16_g241424 , In_PivotWO16_g241424 , In_NormalWS16_g241424 , In_TangentWS16_g241424 , In_BitangentWS16_g241424 , In_TriplanarWeights16_g241424 , In_ViewDirWS16_g241424 , In_CoordsData16_g241424 , In_VertexData16_g241424 , In_Interpolator16_g241424 );
					TVEModelData DataDefault26_g241395 = Data16_g241424;
					TVEModelData DataGeneral26_g241395 = Data16_g241424;
					TVEModelData DataBlanket26_g241395 = Data16_g241424;
					TVEModelData DataImpostor26_g241395 = Data16_g241424;
					TVEModelData Data16_g241404 =(TVEModelData)0;
					float In_Dummy16_g241404 = 0.0;
					float3 In_PositionWS16_g241404 = PositionWS122_g241396;
					float3 In_PositionWO16_g241404 = PositionWO132_g241396;
					float3 In_PivotWS16_g241404 = PivotWS121_g241396;
					float3 In_PivotWO16_g241404 = PivotWO133_g241396;
					float3 In_NormalWS16_g241404 = NormalWS95_g241396;
					half3 TangentWS136_g241396 = ase_tangentWS;
					float3 In_TangentWS16_g241404 = TangentWS136_g241396;
					half3 BiangentWS421_g241396 = ase_bitangentWS;
					float3 In_BitangentWS16_g241404 = BiangentWS421_g241396;
					half3 NormalWS427_g241396 = NormalWS95_g241396;
					half3 localComputeTriplanarMasks427_g241396 = ComputeTriplanarMasks( NormalWS427_g241396 );
					half3 TriplanarWeights429_g241396 = localComputeTriplanarMasks427_g241396;
					float3 In_TriplanarWeights16_g241404 = TriplanarWeights429_g241396;
					float3 In_ViewDirWS16_g241404 = ViewDirWS169_g241396;
					float4 In_CoordsData16_g241404 = CoordsData398_g241396;
					float4 In_VertexData16_g241404 = VertexMasks171_g241396;
					float4 In_Interpolator16_g241404 = Phase_Data176_g241396;
					BuildModelFragData( Data16_g241404 , In_Dummy16_g241404 , In_PositionWS16_g241404 , In_PositionWO16_g241404 , In_PivotWS16_g241404 , In_PivotWO16_g241404 , In_NormalWS16_g241404 , In_TangentWS16_g241404 , In_BitangentWS16_g241404 , In_TriplanarWeights16_g241404 , In_ViewDirWS16_g241404 , In_CoordsData16_g241404 , In_VertexData16_g241404 , In_Interpolator16_g241404 );
					TVEModelData DataTerrain26_g241395 = Data16_g241404;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251454 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251454 = 0.0;
					float3 Out_PositionWS15_g251454 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251454 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251454 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251454 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251454 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251454 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251454 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251454 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251454 , Out_Dummy15_g251454 , Out_PositionWS15_g251454 , Out_PositionWO15_g251454 , Out_PivotWS15_g251454 , Out_PivotWO15_g251454 , Out_NormalWS15_g251454 , Out_TangentWS15_g251454 , Out_BitangentWS15_g251454 , Out_TriplanarWeights15_g251454 , Out_ViewDirWS15_g251454 , Out_CoordsData15_g251454 , Out_VertexData15_g251454 , Out_Interpolator15_g251454 );
					float3 Model_PositionWS497_g251364 = Out_PositionWS15_g251454;
					float2 Model_PositionWS_XZ143_g251364 = (Model_PositionWS497_g251364).xz;
					float3 Model_PivotWS498_g251364 = Out_PivotWS15_g251454;
					float2 Model_PivotWS_XZ145_g251364 = (Model_PivotWS498_g251364).xz;
					float2 lerpResult300_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251383 = lerpResult300_g251364;
					float temp_output_82_0_g251381 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251383 = temp_output_82_0_g251381;
					float4 tex2DArrayNode83_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251383).zw + ( (temp_output_203_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult210_g251383 = (float4(tex2DArrayNode83_g251383.rgb , tex2DArrayNode83_g251383.a));
					float4 temp_output_204_0_g251383 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251383).zw + ( (temp_output_204_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult212_g251383 = (float4(tex2DArrayNode122_g251383.rgb , tex2DArrayNode122_g251383.a));
					float4 TVE_RenderNearPositionR628_g251364 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251364 = saturate( ( distance( Model_PositionWS497_g251364 , (TVE_RenderNearPositionR628_g251364).xyz ) / (TVE_RenderNearPositionR628_g251364).w ) );
					float temp_output_7_0_g251453 = 1.0;
					float temp_output_9_0_g251453 = ( temp_output_507_0_g251364 - temp_output_7_0_g251453 );
					half TVE_RenderNearFadeValue635_g251364 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251364 = saturate( ( temp_output_9_0_g251453 / ( ( TVE_RenderNearFadeValue635_g251364 - temp_output_7_0_g251453 ) + 0.0001 ) ) );
					float4 lerpResult131_g251383 = lerp( appendResult210_g251383 , appendResult212_g251383 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251381 = lerpResult131_g251383;
					float4 lerpResult168_g251381 = lerp( TVE_CoatParams , temp_output_159_109_g251381 , TVE_CoatLayers[(int)temp_output_82_0_g251381]);
					float4 temp_output_589_109_g251364 = lerpResult168_g251381;
					half4 Coat_Texture302_g251364 = temp_output_589_109_g251364;
					float4 In_CoatTexture204_g251364 = Coat_Texture302_g251364;
					half4 Draw_Texture656_g251364 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251364 = Draw_Texture656_g251364;
					float4 temp_output_203_0_g251408 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251408 = lerpResult85_g251364;
					float temp_output_82_0_g251405 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251408 = temp_output_82_0_g251405;
					float4 tex2DArrayNode83_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251408).zw + ( (temp_output_203_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult210_g251408 = (float4(tex2DArrayNode83_g251408.rgb , tex2DArrayNode83_g251408.a));
					float4 temp_output_204_0_g251408 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251408).zw + ( (temp_output_204_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult212_g251408 = (float4(tex2DArrayNode122_g251408.rgb , tex2DArrayNode122_g251408.a));
					float4 lerpResult131_g251408 = lerp( appendResult210_g251408 , appendResult212_g251408 , Global_TexBlend509_g251364);
					float4 temp_output_171_109_g251405 = lerpResult131_g251408;
					float4 lerpResult174_g251405 = lerp( TVE_PaintParams , temp_output_171_109_g251405 , TVE_PaintLayers[(int)temp_output_82_0_g251405]);
					float4 temp_output_595_109_g251364 = lerpResult174_g251405;
					half4 Paint_Texture71_g251364 = temp_output_595_109_g251364;
					float4 In_PaintTexture204_g251364 = Paint_Texture71_g251364;
					float4 temp_output_203_0_g251391 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251391 = lerpResult104_g251364;
					float temp_output_132_0_g251389 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251391 = temp_output_132_0_g251389;
					float4 tex2DArrayNode83_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251391).zw + ( (temp_output_203_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult210_g251391 = (float4(tex2DArrayNode83_g251391.rgb , tex2DArrayNode83_g251391.a));
					float4 temp_output_204_0_g251391 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251391).zw + ( (temp_output_204_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult212_g251391 = (float4(tex2DArrayNode122_g251391.rgb , tex2DArrayNode122_g251391.a));
					float4 lerpResult131_g251391 = lerp( appendResult210_g251391 , appendResult212_g251391 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251389 = lerpResult131_g251391;
					float4 lerpResult145_g251389 = lerp( TVE_AtmoParams , temp_output_137_109_g251389 , TVE_AtmoLayers[(int)temp_output_132_0_g251389]);
					float4 temp_output_590_110_g251364 = lerpResult145_g251389;
					half4 Atmo_Texture80_g251364 = temp_output_590_110_g251364;
					float4 In_AtmoTexture204_g251364 = Atmo_Texture80_g251364;
					float4 temp_output_203_0_g251459 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251459 = lerpResult414_g251364;
					float temp_output_132_0_g251457 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251459 = temp_output_132_0_g251457;
					float4 tex2DArrayNode83_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251459).zw + ( (temp_output_203_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult210_g251459 = (float4(tex2DArrayNode83_g251459.rgb , tex2DArrayNode83_g251459.a));
					float4 temp_output_204_0_g251459 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251459).zw + ( (temp_output_204_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult212_g251459 = (float4(tex2DArrayNode122_g251459.rgb , tex2DArrayNode122_g251459.a));
					float4 lerpResult131_g251459 = lerp( appendResult210_g251459 , appendResult212_g251459 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251457 = lerpResult131_g251459;
					float4 lerpResult145_g251457 = lerp( TVE_EffexParams , temp_output_137_109_g251457 , TVE_EffexLayers[(int)temp_output_132_0_g251457]);
					float4 temp_output_731_110_g251364 = lerpResult145_g251457;
					half4 Effex_Texture420_g251364 = temp_output_731_110_g251364;
					float4 In_EffexTexture204_g251364 = Effex_Texture420_g251364;
					float4 temp_output_203_0_g251439 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251439 = lerpResult247_g251364;
					float temp_output_82_0_g251437 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251439 = temp_output_82_0_g251437;
					float4 tex2DArrayNode83_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251439).zw + ( (temp_output_203_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult210_g251439 = (float4(tex2DArrayNode83_g251439.rgb , tex2DArrayNode83_g251439.a));
					float4 temp_output_204_0_g251439 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251439).zw + ( (temp_output_204_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult212_g251439 = (float4(tex2DArrayNode122_g251439.rgb , tex2DArrayNode122_g251439.a));
					float4 lerpResult131_g251439 = lerp( appendResult210_g251439 , appendResult212_g251439 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251437 = lerpResult131_g251439;
					float4 lerpResult167_g251437 = lerp( TVE_GlowParams , temp_output_159_109_g251437 , TVE_GlowLayers[(int)temp_output_82_0_g251437]);
					float4 temp_output_593_109_g251364 = lerpResult167_g251437;
					half4 Glow_Texture248_g251364 = temp_output_593_109_g251364;
					float4 In_GlowTexture204_g251364 = Glow_Texture248_g251364;
					float4 temp_output_203_0_g251375 = TVE_FormBaseCoord;
					float2 lerpResult168_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251375 = lerpResult168_g251364;
					float temp_output_130_0_g251373 = _GlobalFormLayerValue;
					float temp_output_82_0_g251375 = temp_output_130_0_g251373;
					float4 tex2DArrayNode83_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251375).zw + ( (temp_output_203_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult210_g251375 = (float4(tex2DArrayNode83_g251375.rgb , tex2DArrayNode83_g251375.a));
					float4 temp_output_204_0_g251375 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251375).zw + ( (temp_output_204_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult212_g251375 = (float4(tex2DArrayNode122_g251375.rgb , tex2DArrayNode122_g251375.a));
					float4 lerpResult131_g251375 = lerp( appendResult210_g251375 , appendResult212_g251375 , Global_TexBlend509_g251364);
					float4 temp_output_135_109_g251373 = lerpResult131_g251375;
					float4 lerpResult143_g251373 = lerp( TVE_FormParams , temp_output_135_109_g251373 , TVE_FormLayers[(int)temp_output_130_0_g251373]);
					float4 temp_output_592_0_g251364 = lerpResult143_g251373;
					float4 Form_Texture112_g251364 = temp_output_592_0_g251364;
					float4 In_FormTexture204_g251364 = Form_Texture112_g251364;
					float4 In_LandTexture204_g251364 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251423 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251423 = lerpResult681_g251364;
					float temp_output_136_0_g251421 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251423 = temp_output_136_0_g251421;
					float4 tex2DArrayNode83_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251423).zw + ( (temp_output_203_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult210_g251423 = (float4(tex2DArrayNode83_g251423.rgb , tex2DArrayNode83_g251423.a));
					float4 temp_output_204_0_g251423 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251423).zw + ( (temp_output_204_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult212_g251423 = (float4(tex2DArrayNode122_g251423.rgb , tex2DArrayNode122_g251423.a));
					float4 lerpResult131_g251423 = lerp( appendResult210_g251423 , appendResult212_g251423 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251421 = lerpResult131_g251423;
					float4 lerpResult149_g251421 = lerp( TVE_VertxParams , temp_output_141_109_g251421 , TVE_VertxLayers[(int)temp_output_136_0_g251421]);
					float4 temp_output_695_0_g251364 = lerpResult149_g251421;
					half4 Vertx_Texture693_g251364 = temp_output_695_0_g251364;
					float4 In_VertxTexture204_g251364 = Vertx_Texture693_g251364;
					float4 temp_output_203_0_g251399 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251399 = lerpResult400_g251364;
					float temp_output_136_0_g251397 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251399 = temp_output_136_0_g251397;
					float4 tex2DArrayNode83_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251399).zw + ( (temp_output_203_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult210_g251399 = (float4(tex2DArrayNode83_g251399.rgb , tex2DArrayNode83_g251399.a));
					float4 temp_output_204_0_g251399 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251399).zw + ( (temp_output_204_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult212_g251399 = (float4(tex2DArrayNode122_g251399.rgb , tex2DArrayNode122_g251399.a));
					float4 lerpResult131_g251399 = lerp( appendResult210_g251399 , appendResult212_g251399 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251397 = lerpResult131_g251399;
					float4 lerpResult149_g251397 = lerp( TVE_FlowParams , temp_output_141_109_g251397 , TVE_FlowLayers[(int)temp_output_136_0_g251397]);
					float4 temp_output_594_0_g251364 = lerpResult149_g251397;
					half4 Flow_Texture405_g251364 = temp_output_594_0_g251364;
					float4 In_FlowTexture204_g251364 = Flow_Texture405_g251364;
					half4 User_Texture677_g251364 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251364 = User_Texture677_g251364;
					BuildGlobalData( Data204_g251364 , In_Dummy204_g251364 , In_CoatTexture204_g251364 , In_DrawTexture204_g251364 , In_PaintTexture204_g251364 , In_AtmoTexture204_g251364 , In_EffexTexture204_g251364 , In_GlowTexture204_g251364 , In_FormTexture204_g251364 , In_LandTexture204_g251364 , In_VertxTexture204_g251364 , In_FlowTexture204_g251364 , In_UserTexture204_g251364 );
					TVEGlobalData Data15_g251988 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251988 = 0.0;
					float4 Out_CoatTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251988 = float4( 0,0,0,0 );
					BreakData( Data15_g251988 , Out_Dummy15_g251988 , Out_CoatTexture15_g251988 , Out_DrawTexture15_g251988 , Out_PaintTexture15_g251988 , Out_AtmoTexture15_g251988 , Out_EffexTexture15_g251988 , Out_GlowTexture15_g251988 , Out_FormTexture15_g251988 , Out_LandTexture15_g251988 , Out_VertxTexture15_g251988 , Out_FlowTexture15_g251988 , Out_UserTexture15_g251988 );
					float4 Global_FormTexture351_g251978 = Out_FormTexture15_g251988;
					TVEModelData Data15_g251985 =(TVEModelData)Data15_g251976;
					float Out_Dummy15_g251985 = 0.0;
					float3 Out_PositionOS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251985 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251985 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251985 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251985 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251985 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251985 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251985 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251985 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251985 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251985 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251985 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251985 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251985 , Out_Dummy15_g251985 , Out_PositionOS15_g251985 , Out_PositionWS15_g251985 , Out_PositionWO15_g251985 , Out_PositionRawOS15_g251985 , Out_PivotOS15_g251985 , Out_PivotWS15_g251985 , Out_PivotWO15_g251985 , Out_NormalOS15_g251985 , Out_NormalWS15_g251985 , Out_NormalRawOS15_g251985 , Out_TangentOS15_g251985 , Out_TangentWS15_g251985 , Out_BitangentWS15_g251985 , Out_ViewDirWS15_g251985 , Out_CoordsData15_g251985 , Out_VertexData15_g251985 , Out_MasksData15_g251985 , Out_PhaseData15_g251985 , Out_TransformData15_g251985 , Out_RotationData15_g251985 , Out_Interpolator15_g251985 );
					float3 Model_PivotWO353_g251978 = Out_PivotWO15_g251985;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251984 = _ConformMeshMode;
					float Option70_g251984 = temp_output_17_0_g251984;
					half4 Model_VertexData357_g251978 = Out_VertexData15_g251985;
					float4 temp_output_3_0_g251984 = Model_VertexData357_g251978;
					float4 Channel70_g251984 = temp_output_3_0_g251984;
					float localSwitchChannel470_g251984 = SwitchChannel4( Option70_g251984 , Channel70_g251984 );
					float temp_output_390_0_g251978 = localSwitchChannel470_g251984;
					float temp_output_7_0_g251981 = _ConformMeshRemap.x;
					float temp_output_9_0_g251981 = ( temp_output_390_0_g251978 - temp_output_7_0_g251981 );
					float lerpResult374_g251978 = lerp( 1.0 , saturate( ( temp_output_9_0_g251981 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251978 = lerpResult374_g251978;
					float temp_output_328_0_g251978 = ( Blend_VertMask379_g251978 * TVE_IsEnabled );
					half Conform_Mask366_g251978 = temp_output_328_0_g251978;
					float temp_output_322_0_g251978 = ( ( ( ( (Global_FormTexture351_g251978).z - ( (Model_PivotWO353_g251978).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251978 ) );
					float3 appendResult329_g251978 = (float3(0.0 , temp_output_322_0_g251978 , 0.0));
					float3 appendResult387_g251978 = (float3(0.0 , 0.0 , temp_output_322_0_g251978));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251982 = appendResult387_g251978;
					#else
					float3 staticSwitch65_g251982 = appendResult329_g251978;
					#endif
					float3 Blanket_Conform368_g251978 = staticSwitch65_g251982;
					float4 appendResult312_g251978 = (float4(Blanket_Conform368_g251978 , 0.0));
					float4 temp_output_310_0_g251978 = ( Model_TransformData356_g251978 + appendResult312_g251978 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251978 = temp_output_310_0_g251978;
					#else
					float4 staticSwitch364_g251978 = Model_TransformData356_g251978;
					#endif
					half4 Final_TransformData365_g251978 = staticSwitch364_g251978;
					float4 In_TransformData16_g251987 = Final_TransformData365_g251978;
					float4 In_RotationData16_g251987 = Out_RotationData15_g251986;
					float4 In_Interpolator16_g251987 = Out_Interpolator15_g251986;
					BuildVertexData( Data16_g251987 , In_Dummy16_g251987 , In_PositionOS16_g251987 , In_NormalOS16_g251987 , In_TangentOS16_g251987 , In_TransformData16_g251987 , In_RotationData16_g251987 , In_Interpolator16_g251987 );
					TVEVertexData Data15_g251998 =(TVEVertexData)Data16_g251987;
					float Out_Dummy15_g251998 = 0.0;
					float3 Out_PositionOS15_g251998 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251998 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251998 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251998 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251998 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251998 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251998 , Out_Dummy15_g251998 , Out_PositionOS15_g251998 , Out_NormalOS15_g251998 , Out_TangentOS15_g251998 , Out_TransformData15_g251998 , Out_RotationData15_g251998 , Out_Interpolator15_g251998 );
					TVEVertexData Data16_g251999 =(TVEVertexData)Data15_g251998;
					float In_Dummy16_g251999 = 0.0;
					float3 Vertex_PositionOS147_g251989 = Out_PositionOS15_g251998;
					half3 VertexPos40_g251993 = Vertex_PositionOS147_g251989;
					float4 temp_output_1615_33_g251989 = Out_RotationData15_g251998;
					half4 Vertex_RotationData1569_g251989 = temp_output_1615_33_g251989;
					float2 break1582_g251989 = (Vertex_RotationData1569_g251989).xy;
					half Angle44_g251993 = break1582_g251989.y;
					half CosAngle89_g251993 = cos( Angle44_g251993 );
					half SinAngle93_g251993 = sin( Angle44_g251993 );
					float3 appendResult95_g251993 = (float3((VertexPos40_g251993).x , ( ( (VertexPos40_g251993).y * CosAngle89_g251993 ) - ( (VertexPos40_g251993).z * SinAngle93_g251993 ) ) , ( ( (VertexPos40_g251993).y * SinAngle93_g251993 ) + ( (VertexPos40_g251993).z * CosAngle89_g251993 ) )));
					half3 VertexPos40_g251994 = appendResult95_g251993;
					half Angle44_g251994 = -break1582_g251989.x;
					half CosAngle94_g251994 = cos( Angle44_g251994 );
					half SinAngle95_g251994 = sin( Angle44_g251994 );
					float3 appendResult98_g251994 = (float3(( ( (VertexPos40_g251994).x * CosAngle94_g251994 ) - ( (VertexPos40_g251994).y * SinAngle95_g251994 ) ) , ( ( (VertexPos40_g251994).x * SinAngle95_g251994 ) + ( (VertexPos40_g251994).y * CosAngle94_g251994 ) ) , (VertexPos40_g251994).z));
					half3 VertexPos40_g251992 = Vertex_PositionOS147_g251989;
					half Angle44_g251992 = break1582_g251989.y;
					half CosAngle89_g251992 = cos( Angle44_g251992 );
					half SinAngle93_g251992 = sin( Angle44_g251992 );
					float3 appendResult95_g251992 = (float3((VertexPos40_g251992).x , ( ( (VertexPos40_g251992).y * CosAngle89_g251992 ) - ( (VertexPos40_g251992).z * SinAngle93_g251992 ) ) , ( ( (VertexPos40_g251992).y * SinAngle93_g251992 ) + ( (VertexPos40_g251992).z * CosAngle89_g251992 ) )));
					half3 VertexPos40_g251997 = appendResult95_g251992;
					half Angle44_g251997 = break1582_g251989.x;
					half CosAngle91_g251997 = cos( Angle44_g251997 );
					half SinAngle92_g251997 = sin( Angle44_g251997 );
					float3 appendResult93_g251997 = (float3(( ( (VertexPos40_g251997).x * CosAngle91_g251997 ) + ( (VertexPos40_g251997).z * SinAngle92_g251997 ) ) , (VertexPos40_g251997).y , ( ( -(VertexPos40_g251997).x * SinAngle92_g251997 ) + ( (VertexPos40_g251997).z * CosAngle91_g251997 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251995 = appendResult93_g251997;
					#else
					float3 staticSwitch65_g251995 = appendResult98_g251994;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251990 = staticSwitch65_g251995;
					#else
					float3 staticSwitch65_g251990 = Vertex_PositionOS147_g251989;
					#endif
					float3 temp_output_1608_0_g251989 = staticSwitch65_g251990;
					half3 VertexPos40_g251996 = temp_output_1608_0_g251989;
					half Angle44_g251996 = (Vertex_RotationData1569_g251989).z;
					half CosAngle91_g251996 = cos( Angle44_g251996 );
					half SinAngle92_g251996 = sin( Angle44_g251996 );
					float3 appendResult93_g251996 = (float3(( ( (VertexPos40_g251996).x * CosAngle91_g251996 ) + ( (VertexPos40_g251996).z * SinAngle92_g251996 ) ) , (VertexPos40_g251996).y , ( ( -(VertexPos40_g251996).x * SinAngle92_g251996 ) + ( (VertexPos40_g251996).z * CosAngle91_g251996 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251991 = appendResult93_g251996;
					#else
					float3 staticSwitch65_g251991 = temp_output_1608_0_g251989;
					#endif
					float4 temp_output_1615_31_g251989 = Out_TransformData15_g251998;
					half4 Vertex_TransformData1568_g251989 = temp_output_1615_31_g251989;
					half3 Final_PositionOS178_g251989 = ( ( staticSwitch65_g251991 * (Vertex_TransformData1568_g251989).w ) + (Vertex_TransformData1568_g251989).xyz );
					float3 In_PositionOS16_g251999 = Final_PositionOS178_g251989;
					float3 In_NormalOS16_g251999 = Out_NormalOS15_g251998;
					float4 In_TangentOS16_g251999 = Out_TangentOS15_g251998;
					float4 In_TransformData16_g251999 = temp_output_1615_31_g251989;
					float4 In_RotationData16_g251999 = temp_output_1615_33_g251989;
					float4 In_Interpolator16_g251999 = Out_Interpolator15_g251998;
					BuildVertexData( Data16_g251999 , In_Dummy16_g251999 , In_PositionOS16_g251999 , In_NormalOS16_g251999 , In_TangentOS16_g251999 , In_TransformData16_g251999 , In_RotationData16_g251999 , In_Interpolator16_g251999 );
					TVEVertexData Data15_g252002 =(TVEVertexData)Data16_g251999;
					float Out_Dummy15_g252002 = 0.0;
					float3 Out_PositionOS15_g252002 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252002 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252002 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252002 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252002 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252002 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252002 , Out_Dummy15_g252002 , Out_PositionOS15_g252002 , Out_NormalOS15_g252002 , Out_TangentOS15_g252002 , Out_TransformData15_g252002 , Out_RotationData15_g252002 , Out_Interpolator15_g252002 );
					TVEVertexData Data16_g252003 =(TVEVertexData)Data15_g252002;
					float In_Dummy16_g252003 = 0.0;
					TVEModelData Data15_g252001 =(TVEModelData)Data15_g251985;
					float Out_Dummy15_g252001 = 0.0;
					float3 Out_PositionOS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252001 , Out_Dummy15_g252001 , Out_PositionOS15_g252001 , Out_PositionWS15_g252001 , Out_PositionWO15_g252001 , Out_PositionRawOS15_g252001 , Out_PivotOS15_g252001 , Out_PivotWS15_g252001 , Out_PivotWO15_g252001 , Out_NormalOS15_g252001 , Out_NormalWS15_g252001 , Out_NormalRawOS15_g252001 , Out_TangentOS15_g252001 , Out_TangentWS15_g252001 , Out_BitangentWS15_g252001 , Out_ViewDirWS15_g252001 , Out_CoordsData15_g252001 , Out_VertexData15_g252001 , Out_MasksData15_g252001 , Out_PhaseData15_g252001 , Out_TransformData15_g252001 , Out_RotationData15_g252001 , Out_Interpolator15_g252001 );
					float3 In_PositionOS16_g252003 = ( Out_PositionOS15_g252002 + Out_PivotOS15_g252001 );
					float3 In_NormalOS16_g252003 = Out_NormalOS15_g252002;
					float4 In_TangentOS16_g252003 = Out_TangentOS15_g252002;
					float4 In_TransformData16_g252003 = Out_TransformData15_g252002;
					float4 In_RotationData16_g252003 = Out_RotationData15_g252002;
					float4 In_Interpolator16_g252003 = Out_Interpolator15_g252002;
					BuildVertexData( Data16_g252003 , In_Dummy16_g252003 , In_PositionOS16_g252003 , In_NormalOS16_g252003 , In_TangentOS16_g252003 , In_TransformData16_g252003 , In_RotationData16_g252003 , In_Interpolator16_g252003 );
					TVEVertexData Data15_g254769 =(TVEVertexData)Data16_g252003;
					float Out_Dummy15_g254769 = 0.0;
					float3 Out_PositionOS15_g254769 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254769 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254769 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254769 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254769 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254769 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254769 , Out_Dummy15_g254769 , Out_PositionOS15_g254769 , Out_NormalOS15_g254769 , Out_TangentOS15_g254769 , Out_TransformData15_g254769 , Out_RotationData15_g254769 , Out_Interpolator15_g254769 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g241416;
					o.ase_texcoord7.xyz = vertexToFrag76_g241416;
					TVEVertexData Data1902_g254247 = Data16_g252003;
					float4 Out_Interpolator1902_g254247 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g254247 = Data1902_g254247.Interpolator;
					}
					float4 vertexToFrag1901_g254247 = Out_Interpolator1902_g254247;
					o.ase_texcoord9 = vertexToFrag1901_g254247;
					float3 vertexPos57_g254761 = v.vertex.xyz;
					float4 ase_positionCS57_g254761 = UnityObjectToClipPos( vertexPos57_g254761 );
					o.ase_texcoord10 = ase_positionCS57_g254761;
					
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
					float3 vertexValue = Out_PositionOS15_g254769;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254769;
					v.tangent = Out_TangentOS15_g254769;

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

					float temp_output_2664_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2664_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2664_114).xxx;
					
					float3 color130_g254761 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g254761 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g254763 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g254762 = ( temp_cast_4 * ( 0.5 + appendResult128_g254763 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g254762 = (float4(ddx( FinalUV13_g254762 ) , ddy( FinalUV13_g254762 )));
					float4 UVDerivatives17_g254762 = appendResult16_g254762;
					float4 break28_g254762 = UVDerivatives17_g254762;
					float2 appendResult19_g254762 = (float2(break28_g254762.x , break28_g254762.z));
					float2 appendResult20_g254762 = (float2(break28_g254762.x , break28_g254762.z));
					float dotResult24_g254762 = dot( appendResult19_g254762 , appendResult20_g254762 );
					float2 appendResult21_g254762 = (float2(break28_g254762.y , break28_g254762.w));
					float2 appendResult22_g254762 = (float2(break28_g254762.y , break28_g254762.w));
					float dotResult23_g254762 = dot( appendResult21_g254762 , appendResult22_g254762 );
					float2 appendResult25_g254762 = (float2(dotResult24_g254762 , dotResult23_g254762));
					float2 derivativesLength29_g254762 = sqrt( appendResult25_g254762 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g254762 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g254762 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g254762 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g254762 = clampResult57_g254762;
					float2 break55_g254762 = derivativesLength29_g254762;
					float4 lerpResult73_g254762 = lerp( float4( color130_g254761 , 0.0 ) , float4( color81_g254761 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g254762.x * break71_g254762.y * sqrt( saturate( ( 1.1 - max( break55_g254762.x, break55_g254762.y ) ) ) ) ) ) ));
					float3 color107_g254756 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254756 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g254755 = ( 0.0 );
					float localBuildMasksData3_g254309 = ( 0.0 );
					TVEMasksData Data3_g254309 = (TVEMasksData)0;
					half Feature_Intensity1266_g254290 = _TerrainIntensityValue;
					float ifLocalVar18_g254307 = 0;
					if( Feature_Intensity1266_g254290 <= 0.0 )
					ifLocalVar18_g254307 = 0.0;
					else
					ifLocalVar18_g254307 = 1.0;
					float4 appendResult1267_g254290 = (float4(ifLocalVar18_g254307 , 0.0 , 0.0 , 0.0));
					float4 In_MaskA3_g254309 = appendResult1267_g254290;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254313) = _TerrainMaskTex;
					SamplerState Sampler276_g254313 = sampler_Linear_Repeat;
					float localBreakTextureData456_g254313 = ( 0.0 );
					float localBuildTextureData431_g254304 = ( 0.0 );
					TVEMasksData Data431_g254304 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g254304 = ( 0.0 );
					float4 temp_output_6_0_g254291 = _terrain_mask_coord_value;
					float4 temp_output_7_0_g254291 = ( _TerrainMaskSampleMode + _TerrainMaskCoordMode + _TerrainMaskCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g254291 = ( temp_output_6_0_g254291 + temp_output_7_0_g254291 );
					#else
					float4 staticSwitch14_g254291 = temp_output_6_0_g254291;
					#endif
					half4 Local_MaskCoords813_g254290 = staticSwitch14_g254291;
					float4 Coords444_g254304 = Local_MaskCoords813_g254290;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241424 =(TVEModelData)0;
					float In_Dummy16_g241424 = 0.0;
					float3 vertexToFrag73_g241416 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g241416 = vertexToFrag73_g241416;
					float3 In_PositionWS16_g241424 = PositionWS122_g241416;
					float3 vertexToFrag76_g241416 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g241416 = vertexToFrag76_g241416;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241416 = ( PositionWS122_g241416 - PivotWS121_g241416 );
					#else
					float3 staticSwitch204_g241416 = PositionWS122_g241416;
					#endif
					float3 PositionWO132_g241416 = ( staticSwitch204_g241416 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241424 = PositionWO132_g241416;
					float3 In_PivotWS16_g241424 = PivotWS121_g241416;
					float3 PivotWO133_g241416 = ( PivotWS121_g241416 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241424 = PivotWO133_g241416;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241416 = normalizedWorldNormal;
					float3 In_NormalWS16_g241424 = NormalWS95_g241416;
					half3 TangentWS136_g241416 = TangentWS;
					float3 In_TangentWS16_g241424 = TangentWS136_g241416;
					half3 BiangentWS421_g241416 = BitangentWS;
					float3 In_BitangentWS16_g241424 = BiangentWS421_g241416;
					half3 NormalWS427_g241416 = NormalWS95_g241416;
					half3 localComputeTriplanarMasks427_g241416 = ComputeTriplanarMasks( NormalWS427_g241416 );
					half3 TriplanarWeights429_g241416 = localComputeTriplanarMasks427_g241416;
					float3 In_TriplanarWeights16_g241424 = TriplanarWeights429_g241416;
					float3 normalizeResult296_g241416 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241416 ) );
					half3 ViewDirWS169_g241416 = normalizeResult296_g241416;
					float3 In_ViewDirWS16_g241424 = ViewDirWS169_g241416;
					float4 appendResult397_g241416 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g241416 = appendResult397_g241416;
					float4 In_CoordsData16_g241424 = CoordsData398_g241416;
					half4 VertexMasks171_g241416 = IN.ase_color;
					float4 In_VertexData16_g241424 = VertexMasks171_g241416;
					float temp_output_17_0_g241427 = _ObjectPhaseMode;
					float Option70_g241427 = temp_output_17_0_g241427;
					float4 temp_output_3_0_g241427 = IN.ase_color;
					float4 Channel70_g241427 = temp_output_3_0_g241427;
					float localSwitchChannel470_g241427 = SwitchChannel4( Option70_g241427 , Channel70_g241427 );
					half Phase_Value372_g241416 = localSwitchChannel470_g241427;
					float3 break319_g241416 = PivotWO133_g241416;
					half Pivot_Position322_g241416 = ( break319_g241416.x + break319_g241416.z );
					half Phase_Position357_g241416 = ( Phase_Value372_g241416 + Pivot_Position322_g241416 );
					float temp_output_248_0_g241416 = frac( Phase_Position357_g241416 );
					float4 appendResult177_g241416 = (float4((frac( ( Phase_Position357_g241416 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241416));
					half4 Phase_Data176_g241416 = appendResult177_g241416;
					float4 In_Interpolator16_g241424 = Phase_Data176_g241416;
					BuildModelFragData( Data16_g241424 , In_Dummy16_g241424 , In_PositionWS16_g241424 , In_PositionWO16_g241424 , In_PivotWS16_g241424 , In_PivotWO16_g241424 , In_NormalWS16_g241424 , In_TangentWS16_g241424 , In_BitangentWS16_g241424 , In_TriplanarWeights16_g241424 , In_ViewDirWS16_g241424 , In_CoordsData16_g241424 , In_VertexData16_g241424 , In_Interpolator16_g241424 );
					TVEModelData DataDefault26_g241395 = Data16_g241424;
					TVEModelData DataGeneral26_g241395 = Data16_g241424;
					TVEModelData DataBlanket26_g241395 = Data16_g241424;
					TVEModelData DataImpostor26_g241395 = Data16_g241424;
					TVEModelData Data16_g241404 =(TVEModelData)0;
					float In_Dummy16_g241404 = 0.0;
					float3 temp_output_104_7_g241396 = PositionWS;
					float3 PositionWS122_g241396 = temp_output_104_7_g241396;
					float3 In_PositionWS16_g241404 = PositionWS122_g241396;
					float4x4 break19_g241399 = unity_ObjectToWorld;
					float3 appendResult20_g241399 = (float3(break19_g241399[ 0 ][ 3 ] , break19_g241399[ 1 ][ 3 ] , break19_g241399[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241396 = appendResult20_g241399;
					float3 PivotWS121_g241396 = temp_output_340_7_g241396;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241396 = ( PositionWS122_g241396 - PivotWS121_g241396 );
					#else
					float3 staticSwitch204_g241396 = PositionWS122_g241396;
					#endif
					float3 PositionWO132_g241396 = ( staticSwitch204_g241396 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241404 = PositionWO132_g241396;
					float3 In_PivotWS16_g241404 = PivotWS121_g241396;
					float3 PivotWO133_g241396 = ( PivotWS121_g241396 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241404 = PivotWO133_g241396;
					half3 NormalWS95_g241396 = normalizedWorldNormal;
					float3 In_NormalWS16_g241404 = NormalWS95_g241396;
					half3 TangentWS136_g241396 = TangentWS;
					float3 In_TangentWS16_g241404 = TangentWS136_g241396;
					half3 BiangentWS421_g241396 = BitangentWS;
					float3 In_BitangentWS16_g241404 = BiangentWS421_g241396;
					half3 NormalWS427_g241396 = NormalWS95_g241396;
					half3 localComputeTriplanarMasks427_g241396 = ComputeTriplanarMasks( NormalWS427_g241396 );
					half3 TriplanarWeights429_g241396 = localComputeTriplanarMasks427_g241396;
					float3 In_TriplanarWeights16_g241404 = TriplanarWeights429_g241396;
					float3 normalizeResult296_g241396 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241396 ) );
					half3 ViewDirWS169_g241396 = normalizeResult296_g241396;
					float3 In_ViewDirWS16_g241404 = ViewDirWS169_g241396;
					float4 appendResult397_g241396 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g241396 = appendResult397_g241396;
					float4 In_CoordsData16_g241404 = CoordsData398_g241396;
					half4 VertexMasks171_g241396 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241404 = VertexMasks171_g241396;
					half4 Phase_Data176_g241396 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g241404 = Phase_Data176_g241396;
					BuildModelFragData( Data16_g241404 , In_Dummy16_g241404 , In_PositionWS16_g241404 , In_PositionWO16_g241404 , In_PivotWS16_g241404 , In_PivotWO16_g241404 , In_NormalWS16_g241404 , In_TangentWS16_g241404 , In_BitangentWS16_g241404 , In_TriplanarWeights16_g241404 , In_ViewDirWS16_g241404 , In_CoordsData16_g241404 , In_VertexData16_g241404 , In_Interpolator16_g241404 );
					TVEModelData DataTerrain26_g241395 = Data16_g241404;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g254725 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g254725 = 0.0;
					float3 Out_PositionWS15_g254725 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254725 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254725 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254725 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254725 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254725 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254725 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254725 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254725 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254725 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254725 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254725 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254725 , Out_Dummy15_g254725 , Out_PositionWS15_g254725 , Out_PositionWO15_g254725 , Out_PivotWS15_g254725 , Out_PivotWO15_g254725 , Out_NormalWS15_g254725 , Out_TangentWS15_g254725 , Out_BitangentWS15_g254725 , Out_TriplanarWeights15_g254725 , Out_ViewDirWS15_g254725 , Out_CoordsData15_g254725 , Out_VertexData15_g254725 , Out_Interpolator15_g254725 );
					float4 Model_CoordsData1199_g254290 = Out_CoordsData15_g254725;
					float4 MeshCoords444_g254304 = Model_CoordsData1199_g254290;
					float2 UV0444_g254304 = float2( 0,0 );
					float2 UV3444_g254304 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g254304 , MeshCoords444_g254304 , UV0444_g254304 , UV3444_g254304 );
					float4 appendResult430_g254304 = (float4(UV0444_g254304 , UV3444_g254304));
					float4 In_MaskA431_g254304 = appendResult430_g254304;
					float localComputeWorldCoords315_g254304 = ( 0.0 );
					float4 Coords315_g254304 = Local_MaskCoords813_g254290;
					float3 Model_PositionWO636_g254290 = Out_PositionWO15_g254725;
					float3 PositionWS315_g254304 = Model_PositionWO636_g254290;
					float2 ZY315_g254304 = float2( 0,0 );
					float2 XZ315_g254304 = float2( 0,0 );
					float2 XY315_g254304 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g254304 , PositionWS315_g254304 , ZY315_g254304 , XZ315_g254304 , XY315_g254304 );
					float2 ZY402_g254304 = ZY315_g254304;
					float2 XZ403_g254304 = XZ315_g254304;
					float4 appendResult432_g254304 = (float4(ZY402_g254304 , XZ403_g254304));
					float4 In_MaskB431_g254304 = appendResult432_g254304;
					float2 XY404_g254304 = XY315_g254304;
					float localComputeStochasticCoords409_g254304 = ( 0.0 );
					float2 UV409_g254304 = ZY402_g254304;
					float2 UV1409_g254304 = float2( 0,0 );
					float2 UV2409_g254304 = float2( 0,0 );
					float2 UV3409_g254304 = float2( 0,0 );
					float3 Weights409_g254304 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g254304 , UV1409_g254304 , UV2409_g254304 , UV3409_g254304 , Weights409_g254304 );
					float4 appendResult433_g254304 = (float4(XY404_g254304 , UV1409_g254304));
					float4 In_MaskC431_g254304 = appendResult433_g254304;
					float4 appendResult434_g254304 = (float4(UV2409_g254304 , UV3409_g254304));
					float4 In_MaskD431_g254304 = appendResult434_g254304;
					float localComputeStochasticCoords422_g254304 = ( 0.0 );
					float2 UV422_g254304 = XZ403_g254304;
					float2 UV1422_g254304 = float2( 0,0 );
					float2 UV2422_g254304 = float2( 0,0 );
					float2 UV3422_g254304 = float2( 0,0 );
					float3 Weights422_g254304 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g254304 , UV1422_g254304 , UV2422_g254304 , UV3422_g254304 , Weights422_g254304 );
					float4 appendResult435_g254304 = (float4(UV1422_g254304 , UV2422_g254304));
					float4 In_MaskE431_g254304 = appendResult435_g254304;
					float localComputeStochasticCoords423_g254304 = ( 0.0 );
					float2 UV423_g254304 = XY404_g254304;
					float2 UV1423_g254304 = float2( 0,0 );
					float2 UV2423_g254304 = float2( 0,0 );
					float2 UV3423_g254304 = float2( 0,0 );
					float3 Weights423_g254304 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g254304 , UV1423_g254304 , UV2423_g254304 , UV3423_g254304 , Weights423_g254304 );
					float4 appendResult436_g254304 = (float4(UV3422_g254304 , UV1423_g254304));
					float4 In_MaskF431_g254304 = appendResult436_g254304;
					float4 appendResult437_g254304 = (float4(UV2423_g254304 , UV3423_g254304));
					float4 In_MaskG431_g254304 = appendResult437_g254304;
					float4 In_MaskH431_g254304 = float4( Weights409_g254304 , 0.0 );
					float4 In_MaskI431_g254304 = float4( Weights422_g254304 , 0.0 );
					float4 In_MaskJ431_g254304 = float4( Weights423_g254304 , 0.0 );
					half3 Model_NormalWS869_g254290 = Out_NormalWS15_g254725;
					float3 temp_output_449_0_g254304 = Model_NormalWS869_g254290;
					float4 In_MaskK431_g254304 = float4( temp_output_449_0_g254304 , 0.0 );
					half3 Model_TangentWS1294_g254290 = Out_TangentWS15_g254725;
					float3 temp_output_450_0_g254304 = Model_TangentWS1294_g254290;
					float4 In_MaskL431_g254304 = float4( temp_output_450_0_g254304 , 0.0 );
					half3 Model_BitangentWS1295_g254290 = Out_BitangentWS15_g254725;
					float3 temp_output_451_0_g254304 = Model_BitangentWS1295_g254290;
					float4 In_MaskM431_g254304 = float4( temp_output_451_0_g254304 , 0.0 );
					half3 Model_TriplanarWeights1296_g254290 = Out_TriplanarWeights15_g254725;
					float3 temp_output_445_0_g254304 = Model_TriplanarWeights1296_g254290;
					float4 In_MaskN431_g254304 = float4( temp_output_445_0_g254304 , 0.0 );
					BuildTextureData( Data431_g254304 , In_MaskA431_g254304 , In_MaskB431_g254304 , In_MaskC431_g254304 , In_MaskD431_g254304 , In_MaskE431_g254304 , In_MaskF431_g254304 , In_MaskG431_g254304 , In_MaskH431_g254304 , In_MaskI431_g254304 , In_MaskJ431_g254304 , In_MaskK431_g254304 , In_MaskL431_g254304 , In_MaskM431_g254304 , In_MaskN431_g254304 );
					TVEMasksData Data456_g254313 =(TVEMasksData)Data431_g254304;
					float4 Out_MaskA456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254313 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254313 , Out_MaskA456_g254313 , Out_MaskB456_g254313 , Out_MaskC456_g254313 , Out_MaskD456_g254313 , Out_MaskE456_g254313 , Out_MaskF456_g254313 , Out_MaskG456_g254313 , Out_MaskH456_g254313 , Out_MaskI456_g254313 , Out_MaskJ456_g254313 , Out_MaskK456_g254313 , Out_MaskL456_g254313 , Out_MaskM456_g254313 , Out_MaskN456_g254313 );
					half2 UV276_g254313 = (Out_MaskA456_g254313).xy;
					float temp_output_504_0_g254313 = 0.0;
					half Bias276_g254313 = temp_output_504_0_g254313;
					half2 Normal276_g254313 = float2( 0,0 );
					half4 localSampleCoord276_g254313 = SampleCoord( Texture276_g254313 , Sampler276_g254313 , UV276_g254313 , Bias276_g254313 , Normal276_g254313 );
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254313) = _TerrainMaskTex;
					SamplerState Sampler502_g254313 = sampler_Linear_Repeat;
					half2 UV502_g254313 = (Out_MaskA456_g254313).zw;
					half Bias502_g254313 = temp_output_504_0_g254313;
					half2 Normal502_g254313 = float2( 0,0 );
					half4 localSampleCoord502_g254313 = SampleCoord( Texture502_g254313 , Sampler502_g254313 , UV502_g254313 , Bias502_g254313 , Normal502_g254313 );
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254313) = _TerrainMaskTex;
					SamplerState Sampler496_g254313 = sampler_Linear_Repeat;
					float2 temp_output_463_0_g254313 = (Out_MaskB456_g254313).zw;
					half2 XZ496_g254313 = temp_output_463_0_g254313;
					half Bias496_g254313 = temp_output_504_0_g254313;
					half3 NormalWS512_g254313 = (Out_MaskK456_g254313).xyz;
					half3 NormalWS496_g254313 = NormalWS512_g254313;
					half3 Normal496_g254313 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254313 = SamplePlanar2D( Texture496_g254313 , Sampler496_g254313 , XZ496_g254313 , Bias496_g254313 , NormalWS496_g254313 , Normal496_g254313 );
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254313) = _TerrainMaskTex;
					SamplerState Sampler490_g254313 = sampler_Linear_Repeat;
					float2 temp_output_462_0_g254313 = (Out_MaskB456_g254313).xy;
					half2 ZY490_g254313 = temp_output_462_0_g254313;
					half2 XZ490_g254313 = temp_output_463_0_g254313;
					float2 temp_output_464_0_g254313 = (Out_MaskC456_g254313).xy;
					half2 XY490_g254313 = temp_output_464_0_g254313;
					half Bias490_g254313 = temp_output_504_0_g254313;
					half3 Triplanar522_g254313 = (Out_MaskN456_g254313).xyz;
					half3 Triplanar490_g254313 = Triplanar522_g254313;
					half3 NormalWS490_g254313 = NormalWS512_g254313;
					half3 Normal490_g254313 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254313 = SamplePlanar3D( Texture490_g254313 , Sampler490_g254313 , ZY490_g254313 , XZ490_g254313 , XY490_g254313 , Bias490_g254313 , Triplanar490_g254313 , NormalWS490_g254313 , Normal490_g254313 );
					#if defined( TVE_TERRAIN_MASK_SAMPLE_MAIN_UV )
					float4 staticSwitch817_g254290 = localSampleCoord276_g254313;
					#elif defined( TVE_TERRAIN_MASK_SAMPLE_EXTRA_UV )
					float4 staticSwitch817_g254290 = localSampleCoord502_g254313;
					#elif defined( TVE_TERRAIN_MASK_SAMPLE_PLANAR_2D )
					float4 staticSwitch817_g254290 = localSamplePlanar2D496_g254313;
					#elif defined( TVE_TERRAIN_MASK_SAMPLE_PLANAR_3D )
					float4 staticSwitch817_g254290 = localSamplePlanar3D490_g254313;
					#else
					float4 staticSwitch817_g254290 = localSampleCoord276_g254313;
					#endif
					half4 Local_MaskTex861_g254290 = staticSwitch817_g254290;
					float temp_output_887_0_g254290 = (Local_MaskTex861_g254290).x;
					float temp_output_7_0_g254295 = _TerrainMaskRemap.x;
					float temp_output_9_0_g254295 = ( temp_output_887_0_g254290 - temp_output_7_0_g254295 );
					float lerpResult1108_g254290 = lerp( 1.0 , saturate( ( temp_output_9_0_g254295 * _TerrainMaskRemap.z ) ) , _TerrainMaskValue);
					half Detail_TexMask429_g254290 = lerpResult1108_g254290;
					float localBreakVisualData4_g254299 = ( 0.0 );
					float localBuildVisualData3_g254253 = ( 0.0 );
					float localBuildVisualData3_g254248 = ( 0.0 );
					TVEVisualData Data3_g254248 =(TVEVisualData)0;
					float temp_output_14_0_g254248 = 0.0;
					float In_Dummy3_g254248 = temp_output_14_0_g254248;
					float3 temp_cast_18 = (0.5).xxx;
					float3 temp_output_4_0_g254248 = temp_cast_18;
					float3 In_Albedo3_g254248 = temp_output_4_0_g254248;
					float3 temp_cast_19 = (0.5).xxx;
					float3 temp_output_44_0_g254248 = temp_cast_19;
					float3 In_AlbedoBase3_g254248 = temp_output_44_0_g254248;
					float2 temp_cast_20 = (0.0).xx;
					float2 In_NormalTS3_g254248 = temp_cast_20;
					float3 temp_cast_21 = (0.5).xxx;
					float3 In_NormalWS3_g254248 = temp_cast_21;
					float4 In_Shader3_g254248 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g254248 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g254248 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g254248 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g254248 = 0.5;
					float In_Grayscale3_g254248 = temp_output_12_0_g254248;
					float temp_output_16_0_g254248 = 1.0;
					float In_Luminosity3_g254248 = temp_output_16_0_g254248;
					float In_MultiMask3_g254248 = 1.0;
					float In_AlphaClip3_g254248 = 1.0;
					float In_AlphaFade3_g254248 = 1.0;
					float3 temp_cast_22 = (1.0).xxx;
					float3 In_Translucency3_g254248 = temp_cast_22;
					float In_Transmission3_g254248 = 1.0;
					float In_Thickness3_g254248 = 0.0;
					float In_Diffusion3_g254248 = 0.0;
					float In_Depth3_g254248 = 0.0;
					BuildVisualData( Data3_g254248 , In_Dummy3_g254248 , In_Albedo3_g254248 , In_AlbedoBase3_g254248 , In_NormalTS3_g254248 , In_NormalWS3_g254248 , In_Shader3_g254248 , In_Feature3_g254248 , In_Season3_g254248 , In_Emissive3_g254248 , In_Grayscale3_g254248 , In_Luminosity3_g254248 , In_MultiMask3_g254248 , In_AlphaClip3_g254248 , In_AlphaFade3_g254248 , In_Translucency3_g254248 , In_Transmission3_g254248 , In_Thickness3_g254248 , In_Diffusion3_g254248 , In_Depth3_g254248 );
					TVEVisualData Data3_g254253 =(TVEVisualData)Data3_g254248;
					half Dummy130_g254251 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g254253 = Dummy130_g254251;
					float In_Dummy3_g254253 = temp_output_14_0_g254253;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254274) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g254256 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g254274 = staticSwitch36_g254256;
					float localBreakTextureData456_g254274 = ( 0.0 );
					float localBuildTextureData431_g254273 = ( 0.0 );
					TVEMasksData Data431_g254273 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g254273 = ( 0.0 );
					float4 temp_output_6_0_g254289 = _main_coord_value;
					float4 temp_output_7_0_g254289 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g254289 = ( temp_output_6_0_g254289 + temp_output_7_0_g254289 );
					#else
					float4 staticSwitch14_g254289 = temp_output_6_0_g254289;
					#endif
					half4 Local_Coords180_g254251 = staticSwitch14_g254289;
					float4 Coords444_g254273 = Local_Coords180_g254251;
					TVEModelData Data15_g254249 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g254249 = 0.0;
					float3 Out_PositionWS15_g254249 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254249 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254249 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254249 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254249 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254249 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254249 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254249 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254249 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254249 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254249 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254249 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254249 , Out_Dummy15_g254249 , Out_PositionWS15_g254249 , Out_PositionWO15_g254249 , Out_PivotWS15_g254249 , Out_PivotWO15_g254249 , Out_NormalWS15_g254249 , Out_TangentWS15_g254249 , Out_BitangentWS15_g254249 , Out_TriplanarWeights15_g254249 , Out_ViewDirWS15_g254249 , Out_CoordsData15_g254249 , Out_VertexData15_g254249 , Out_Interpolator15_g254249 );
					TVEModelData Data16_g254250 =(TVEModelData)Data15_g254249;
					float In_Dummy16_g254250 = Out_Dummy15_g254249;
					float3 In_PositionWS16_g254250 = Out_PositionWS15_g254249;
					float3 In_PositionWO16_g254250 = Out_PositionWO15_g254249;
					float3 In_PivotWS16_g254250 = Out_PivotWS15_g254249;
					float3 In_PivotWO16_g254250 = Out_PivotWO15_g254249;
					float3 In_NormalWS16_g254250 = Out_NormalWS15_g254249;
					float3 In_TangentWS16_g254250 = Out_TangentWS15_g254249;
					float3 In_BitangentWS16_g254250 = Out_BitangentWS15_g254249;
					float3 In_TriplanarWeights16_g254250 = Out_TriplanarWeights15_g254249;
					float3 In_ViewDirWS16_g254250 = Out_ViewDirWS15_g254249;
					float4 In_CoordsData16_g254250 = Out_CoordsData15_g254249;
					float4 In_VertexData16_g254250 = Out_VertexData15_g254249;
					float4 vertexToFrag1901_g254247 = IN.ase_texcoord9;
					float4 In_Interpolator16_g254250 = vertexToFrag1901_g254247;
					BuildModelFragData( Data16_g254250 , In_Dummy16_g254250 , In_PositionWS16_g254250 , In_PositionWO16_g254250 , In_PivotWS16_g254250 , In_PivotWO16_g254250 , In_NormalWS16_g254250 , In_TangentWS16_g254250 , In_BitangentWS16_g254250 , In_TriplanarWeights16_g254250 , In_ViewDirWS16_g254250 , In_CoordsData16_g254250 , In_VertexData16_g254250 , In_Interpolator16_g254250 );
					TVEModelData Data15_g254252 =(TVEModelData)Data16_g254250;
					float Out_Dummy15_g254252 = 0.0;
					float3 Out_PositionWS15_g254252 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254252 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254252 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254252 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254252 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254252 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254252 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254252 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254252 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254252 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254252 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254252 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254252 , Out_Dummy15_g254252 , Out_PositionWS15_g254252 , Out_PositionWO15_g254252 , Out_PivotWS15_g254252 , Out_PivotWO15_g254252 , Out_NormalWS15_g254252 , Out_TangentWS15_g254252 , Out_BitangentWS15_g254252 , Out_TriplanarWeights15_g254252 , Out_ViewDirWS15_g254252 , Out_CoordsData15_g254252 , Out_VertexData15_g254252 , Out_Interpolator15_g254252 );
					float4 Model_CoordsData324_g254251 = Out_CoordsData15_g254252;
					float4 MeshCoords444_g254273 = Model_CoordsData324_g254251;
					float2 UV0444_g254273 = float2( 0,0 );
					float2 UV3444_g254273 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g254273 , MeshCoords444_g254273 , UV0444_g254273 , UV3444_g254273 );
					float4 appendResult430_g254273 = (float4(UV0444_g254273 , UV3444_g254273));
					float4 In_MaskA431_g254273 = appendResult430_g254273;
					float localComputeWorldCoords315_g254273 = ( 0.0 );
					float4 Coords315_g254273 = Local_Coords180_g254251;
					float3 Model_PositionWO222_g254251 = Out_PositionWO15_g254252;
					float3 PositionWS315_g254273 = Model_PositionWO222_g254251;
					float2 ZY315_g254273 = float2( 0,0 );
					float2 XZ315_g254273 = float2( 0,0 );
					float2 XY315_g254273 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g254273 , PositionWS315_g254273 , ZY315_g254273 , XZ315_g254273 , XY315_g254273 );
					float2 ZY402_g254273 = ZY315_g254273;
					float2 XZ403_g254273 = XZ315_g254273;
					float4 appendResult432_g254273 = (float4(ZY402_g254273 , XZ403_g254273));
					float4 In_MaskB431_g254273 = appendResult432_g254273;
					float2 XY404_g254273 = XY315_g254273;
					float localComputeStochasticCoords409_g254273 = ( 0.0 );
					float2 UV409_g254273 = ZY402_g254273;
					float2 UV1409_g254273 = float2( 0,0 );
					float2 UV2409_g254273 = float2( 0,0 );
					float2 UV3409_g254273 = float2( 0,0 );
					float3 Weights409_g254273 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g254273 , UV1409_g254273 , UV2409_g254273 , UV3409_g254273 , Weights409_g254273 );
					float4 appendResult433_g254273 = (float4(XY404_g254273 , UV1409_g254273));
					float4 In_MaskC431_g254273 = appendResult433_g254273;
					float4 appendResult434_g254273 = (float4(UV2409_g254273 , UV3409_g254273));
					float4 In_MaskD431_g254273 = appendResult434_g254273;
					float localComputeStochasticCoords422_g254273 = ( 0.0 );
					float2 UV422_g254273 = XZ403_g254273;
					float2 UV1422_g254273 = float2( 0,0 );
					float2 UV2422_g254273 = float2( 0,0 );
					float2 UV3422_g254273 = float2( 0,0 );
					float3 Weights422_g254273 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g254273 , UV1422_g254273 , UV2422_g254273 , UV3422_g254273 , Weights422_g254273 );
					float4 appendResult435_g254273 = (float4(UV1422_g254273 , UV2422_g254273));
					float4 In_MaskE431_g254273 = appendResult435_g254273;
					float localComputeStochasticCoords423_g254273 = ( 0.0 );
					float2 UV423_g254273 = XY404_g254273;
					float2 UV1423_g254273 = float2( 0,0 );
					float2 UV2423_g254273 = float2( 0,0 );
					float2 UV3423_g254273 = float2( 0,0 );
					float3 Weights423_g254273 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g254273 , UV1423_g254273 , UV2423_g254273 , UV3423_g254273 , Weights423_g254273 );
					float4 appendResult436_g254273 = (float4(UV3422_g254273 , UV1423_g254273));
					float4 In_MaskF431_g254273 = appendResult436_g254273;
					float4 appendResult437_g254273 = (float4(UV2423_g254273 , UV3423_g254273));
					float4 In_MaskG431_g254273 = appendResult437_g254273;
					float4 In_MaskH431_g254273 = float4( Weights409_g254273 , 0.0 );
					float4 In_MaskI431_g254273 = float4( Weights422_g254273 , 0.0 );
					float4 In_MaskJ431_g254273 = float4( Weights423_g254273 , 0.0 );
					half3 Model_NormalWS226_g254251 = Out_NormalWS15_g254252;
					float3 temp_output_449_0_g254273 = Model_NormalWS226_g254251;
					float4 In_MaskK431_g254273 = float4( temp_output_449_0_g254273 , 0.0 );
					half3 Model_TangentWS366_g254251 = Out_TangentWS15_g254252;
					float3 temp_output_450_0_g254273 = Model_TangentWS366_g254251;
					float4 In_MaskL431_g254273 = float4( temp_output_450_0_g254273 , 0.0 );
					half3 Model_BitangentWS367_g254251 = Out_BitangentWS15_g254252;
					float3 temp_output_451_0_g254273 = Model_BitangentWS367_g254251;
					float4 In_MaskM431_g254273 = float4( temp_output_451_0_g254273 , 0.0 );
					half3 Model_TriplanarWeights368_g254251 = Out_TriplanarWeights15_g254252;
					float3 temp_output_445_0_g254273 = Model_TriplanarWeights368_g254251;
					float4 In_MaskN431_g254273 = float4( temp_output_445_0_g254273 , 0.0 );
					BuildTextureData( Data431_g254273 , In_MaskA431_g254273 , In_MaskB431_g254273 , In_MaskC431_g254273 , In_MaskD431_g254273 , In_MaskE431_g254273 , In_MaskF431_g254273 , In_MaskG431_g254273 , In_MaskH431_g254273 , In_MaskI431_g254273 , In_MaskJ431_g254273 , In_MaskK431_g254273 , In_MaskL431_g254273 , In_MaskM431_g254273 , In_MaskN431_g254273 );
					TVEMasksData Data456_g254274 =(TVEMasksData)Data431_g254273;
					float4 Out_MaskA456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254274 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254274 , Out_MaskA456_g254274 , Out_MaskB456_g254274 , Out_MaskC456_g254274 , Out_MaskD456_g254274 , Out_MaskE456_g254274 , Out_MaskF456_g254274 , Out_MaskG456_g254274 , Out_MaskH456_g254274 , Out_MaskI456_g254274 , Out_MaskJ456_g254274 , Out_MaskK456_g254274 , Out_MaskL456_g254274 , Out_MaskM456_g254274 , Out_MaskN456_g254274 );
					half2 UV276_g254274 = (Out_MaskA456_g254274).xy;
					float temp_output_504_0_g254274 = 0.0;
					half Bias276_g254274 = temp_output_504_0_g254274;
					half2 Normal276_g254274 = float2( 0,0 );
					half4 localSampleCoord276_g254274 = SampleCoord( Texture276_g254274 , Sampler276_g254274 , UV276_g254274 , Bias276_g254274 , Normal276_g254274 );
					float4 temp_output_407_277_g254251 = localSampleCoord276_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254274) = _MainAlbedoTex;
					SamplerState Sampler502_g254274 = staticSwitch36_g254256;
					half2 UV502_g254274 = (Out_MaskA456_g254274).zw;
					half Bias502_g254274 = temp_output_504_0_g254274;
					half2 Normal502_g254274 = float2( 0,0 );
					half4 localSampleCoord502_g254274 = SampleCoord( Texture502_g254274 , Sampler502_g254274 , UV502_g254274 , Bias502_g254274 , Normal502_g254274 );
					float4 temp_output_407_278_g254251 = localSampleCoord502_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254274) = _MainAlbedoTex;
					SamplerState Sampler496_g254274 = staticSwitch36_g254256;
					float2 temp_output_463_0_g254274 = (Out_MaskB456_g254274).zw;
					half2 XZ496_g254274 = temp_output_463_0_g254274;
					half Bias496_g254274 = temp_output_504_0_g254274;
					half3 NormalWS512_g254274 = (Out_MaskK456_g254274).xyz;
					half3 NormalWS496_g254274 = NormalWS512_g254274;
					half3 Normal496_g254274 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254274 = SamplePlanar2D( Texture496_g254274 , Sampler496_g254274 , XZ496_g254274 , Bias496_g254274 , NormalWS496_g254274 , Normal496_g254274 );
					float4 temp_output_407_0_g254251 = localSamplePlanar2D496_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254274) = _MainAlbedoTex;
					SamplerState Sampler490_g254274 = staticSwitch36_g254256;
					float2 temp_output_462_0_g254274 = (Out_MaskB456_g254274).xy;
					half2 ZY490_g254274 = temp_output_462_0_g254274;
					half2 XZ490_g254274 = temp_output_463_0_g254274;
					float2 temp_output_464_0_g254274 = (Out_MaskC456_g254274).xy;
					half2 XY490_g254274 = temp_output_464_0_g254274;
					half Bias490_g254274 = temp_output_504_0_g254274;
					half3 Triplanar522_g254274 = (Out_MaskN456_g254274).xyz;
					half3 Triplanar490_g254274 = Triplanar522_g254274;
					half3 NormalWS490_g254274 = NormalWS512_g254274;
					half3 Normal490_g254274 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254274 = SamplePlanar3D( Texture490_g254274 , Sampler490_g254274 , ZY490_g254274 , XZ490_g254274 , XY490_g254274 , Bias490_g254274 , Triplanar490_g254274 , NormalWS490_g254274 , Normal490_g254274 );
					float4 temp_output_407_201_g254251 = localSamplePlanar3D490_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g254274) = _MainAlbedoTex;
					SamplerState Sampler498_g254274 = staticSwitch36_g254256;
					half2 XZ498_g254274 = temp_output_463_0_g254274;
					float2 temp_output_473_0_g254274 = (Out_MaskE456_g254274).xy;
					half2 XZ_1498_g254274 = temp_output_473_0_g254274;
					float2 temp_output_474_0_g254274 = (Out_MaskE456_g254274).zw;
					half2 XZ_2498_g254274 = temp_output_474_0_g254274;
					float2 temp_output_475_0_g254274 = (Out_MaskF456_g254274).xy;
					half2 XZ_3498_g254274 = temp_output_475_0_g254274;
					float temp_output_510_0_g254274 = exp2( temp_output_504_0_g254274 );
					half Bias498_g254274 = temp_output_510_0_g254274;
					float3 temp_output_480_0_g254274 = (Out_MaskI456_g254274).xyz;
					half3 Weights_2498_g254274 = temp_output_480_0_g254274;
					half3 NormalWS498_g254274 = NormalWS512_g254274;
					half3 Normal498_g254274 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g254274 = SampleStochastic2D( Texture498_g254274 , Sampler498_g254274 , XZ498_g254274 , XZ_1498_g254274 , XZ_2498_g254274 , XZ_3498_g254274 , Bias498_g254274 , Weights_2498_g254274 , NormalWS498_g254274 , Normal498_g254274 );
					float4 temp_output_407_202_g254251 = localSampleStochastic2D498_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g254274) = _MainAlbedoTex;
					SamplerState Sampler500_g254274 = staticSwitch36_g254256;
					half2 ZY500_g254274 = temp_output_462_0_g254274;
					half2 ZY_1500_g254274 = (Out_MaskC456_g254274).zw;
					half2 ZY_2500_g254274 = (Out_MaskD456_g254274).xy;
					half2 ZY_3500_g254274 = (Out_MaskD456_g254274).zw;
					half2 XZ500_g254274 = temp_output_463_0_g254274;
					half2 XZ_1500_g254274 = temp_output_473_0_g254274;
					half2 XZ_2500_g254274 = temp_output_474_0_g254274;
					half2 XZ_3500_g254274 = temp_output_475_0_g254274;
					half2 XY500_g254274 = temp_output_464_0_g254274;
					half2 XY_1500_g254274 = (Out_MaskF456_g254274).zw;
					half2 XY_2500_g254274 = (Out_MaskG456_g254274).xy;
					half2 XY_3500_g254274 = (Out_MaskG456_g254274).zw;
					half Bias500_g254274 = temp_output_510_0_g254274;
					half3 Weights_1500_g254274 = (Out_MaskH456_g254274).xyz;
					half3 Weights_2500_g254274 = temp_output_480_0_g254274;
					half3 Weights_3500_g254274 = (Out_MaskJ456_g254274).xyz;
					half3 Triplanar500_g254274 = Triplanar522_g254274;
					half3 NormalWS500_g254274 = NormalWS512_g254274;
					half3 Normal500_g254274 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g254274 = SampleStochastic3D( Texture500_g254274 , Sampler500_g254274 , ZY500_g254274 , ZY_1500_g254274 , ZY_2500_g254274 , ZY_3500_g254274 , XZ500_g254274 , XZ_1500_g254274 , XZ_2500_g254274 , XZ_3500_g254274 , XY500_g254274 , XY_1500_g254274 , XY_2500_g254274 , XY_3500_g254274 , Bias500_g254274 , Weights_1500_g254274 , Weights_2500_g254274 , Weights_3500_g254274 , Triplanar500_g254274 , NormalWS500_g254274 , Normal500_g254274 );
					float4 temp_output_407_203_g254251 = localSampleStochastic3D500_g254274;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g254251 = temp_output_407_277_g254251;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g254251 = temp_output_407_278_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g254251 = temp_output_407_0_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g254251 = temp_output_407_201_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g254251 = temp_output_407_202_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g254251 = temp_output_407_203_g254251;
					#else
					float4 staticSwitch184_g254251 = temp_output_407_277_g254251;
					#endif
					half4 Local_AlbedoSample185_g254251 = staticSwitch184_g254251;
					float3 lerpResult53_g254251 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g254251).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g254251 = lerpResult53_g254251;
					float temp_output_17_0_g254271 = _MainMultiWriteMode;
					float Option91_g254271 = temp_output_17_0_g254271;
					float4 Model_VertexData418_g254251 = Out_VertexData15_g254252;
					float4 temp_output_84_0_g254271 = Model_VertexData418_g254251;
					float4 ChannelA91_g254271 = temp_output_84_0_g254271;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254259) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g254258 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g254259 = staticSwitch38_g254258;
					float localBreakTextureData456_g254259 = ( 0.0 );
					TVEMasksData Data456_g254259 =(TVEMasksData)Data431_g254273;
					float4 Out_MaskA456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254259 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254259 , Out_MaskA456_g254259 , Out_MaskB456_g254259 , Out_MaskC456_g254259 , Out_MaskD456_g254259 , Out_MaskE456_g254259 , Out_MaskF456_g254259 , Out_MaskG456_g254259 , Out_MaskH456_g254259 , Out_MaskI456_g254259 , Out_MaskJ456_g254259 , Out_MaskK456_g254259 , Out_MaskL456_g254259 , Out_MaskM456_g254259 , Out_MaskN456_g254259 );
					half2 UV276_g254259 = (Out_MaskA456_g254259).xy;
					float temp_output_504_0_g254259 = 0.0;
					half Bias276_g254259 = temp_output_504_0_g254259;
					half2 Normal276_g254259 = float2( 0,0 );
					half4 localSampleCoord276_g254259 = SampleCoord( Texture276_g254259 , Sampler276_g254259 , UV276_g254259 , Bias276_g254259 , Normal276_g254259 );
					float4 temp_output_405_277_g254251 = localSampleCoord276_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254259) = _MainShaderTex;
					SamplerState Sampler502_g254259 = staticSwitch38_g254258;
					half2 UV502_g254259 = (Out_MaskA456_g254259).zw;
					half Bias502_g254259 = temp_output_504_0_g254259;
					half2 Normal502_g254259 = float2( 0,0 );
					half4 localSampleCoord502_g254259 = SampleCoord( Texture502_g254259 , Sampler502_g254259 , UV502_g254259 , Bias502_g254259 , Normal502_g254259 );
					float4 temp_output_405_278_g254251 = localSampleCoord502_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254259) = _MainShaderTex;
					SamplerState Sampler496_g254259 = staticSwitch38_g254258;
					float2 temp_output_463_0_g254259 = (Out_MaskB456_g254259).zw;
					half2 XZ496_g254259 = temp_output_463_0_g254259;
					half Bias496_g254259 = temp_output_504_0_g254259;
					half3 NormalWS512_g254259 = (Out_MaskK456_g254259).xyz;
					half3 NormalWS496_g254259 = NormalWS512_g254259;
					half3 Normal496_g254259 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254259 = SamplePlanar2D( Texture496_g254259 , Sampler496_g254259 , XZ496_g254259 , Bias496_g254259 , NormalWS496_g254259 , Normal496_g254259 );
					float4 temp_output_405_0_g254251 = localSamplePlanar2D496_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254259) = _MainShaderTex;
					SamplerState Sampler490_g254259 = staticSwitch38_g254258;
					float2 temp_output_462_0_g254259 = (Out_MaskB456_g254259).xy;
					half2 ZY490_g254259 = temp_output_462_0_g254259;
					half2 XZ490_g254259 = temp_output_463_0_g254259;
					float2 temp_output_464_0_g254259 = (Out_MaskC456_g254259).xy;
					half2 XY490_g254259 = temp_output_464_0_g254259;
					half Bias490_g254259 = temp_output_504_0_g254259;
					half3 Triplanar522_g254259 = (Out_MaskN456_g254259).xyz;
					half3 Triplanar490_g254259 = Triplanar522_g254259;
					half3 NormalWS490_g254259 = NormalWS512_g254259;
					half3 Normal490_g254259 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254259 = SamplePlanar3D( Texture490_g254259 , Sampler490_g254259 , ZY490_g254259 , XZ490_g254259 , XY490_g254259 , Bias490_g254259 , Triplanar490_g254259 , NormalWS490_g254259 , Normal490_g254259 );
					float4 temp_output_405_201_g254251 = localSamplePlanar3D490_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g254259) = _MainShaderTex;
					SamplerState Sampler498_g254259 = staticSwitch38_g254258;
					half2 XZ498_g254259 = temp_output_463_0_g254259;
					float2 temp_output_473_0_g254259 = (Out_MaskE456_g254259).xy;
					half2 XZ_1498_g254259 = temp_output_473_0_g254259;
					float2 temp_output_474_0_g254259 = (Out_MaskE456_g254259).zw;
					half2 XZ_2498_g254259 = temp_output_474_0_g254259;
					float2 temp_output_475_0_g254259 = (Out_MaskF456_g254259).xy;
					half2 XZ_3498_g254259 = temp_output_475_0_g254259;
					float temp_output_510_0_g254259 = exp2( temp_output_504_0_g254259 );
					half Bias498_g254259 = temp_output_510_0_g254259;
					float3 temp_output_480_0_g254259 = (Out_MaskI456_g254259).xyz;
					half3 Weights_2498_g254259 = temp_output_480_0_g254259;
					half3 NormalWS498_g254259 = NormalWS512_g254259;
					half3 Normal498_g254259 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g254259 = SampleStochastic2D( Texture498_g254259 , Sampler498_g254259 , XZ498_g254259 , XZ_1498_g254259 , XZ_2498_g254259 , XZ_3498_g254259 , Bias498_g254259 , Weights_2498_g254259 , NormalWS498_g254259 , Normal498_g254259 );
					float4 temp_output_405_202_g254251 = localSampleStochastic2D498_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g254259) = _MainShaderTex;
					SamplerState Sampler500_g254259 = staticSwitch38_g254258;
					half2 ZY500_g254259 = temp_output_462_0_g254259;
					half2 ZY_1500_g254259 = (Out_MaskC456_g254259).zw;
					half2 ZY_2500_g254259 = (Out_MaskD456_g254259).xy;
					half2 ZY_3500_g254259 = (Out_MaskD456_g254259).zw;
					half2 XZ500_g254259 = temp_output_463_0_g254259;
					half2 XZ_1500_g254259 = temp_output_473_0_g254259;
					half2 XZ_2500_g254259 = temp_output_474_0_g254259;
					half2 XZ_3500_g254259 = temp_output_475_0_g254259;
					half2 XY500_g254259 = temp_output_464_0_g254259;
					half2 XY_1500_g254259 = (Out_MaskF456_g254259).zw;
					half2 XY_2500_g254259 = (Out_MaskG456_g254259).xy;
					half2 XY_3500_g254259 = (Out_MaskG456_g254259).zw;
					half Bias500_g254259 = temp_output_510_0_g254259;
					half3 Weights_1500_g254259 = (Out_MaskH456_g254259).xyz;
					half3 Weights_2500_g254259 = temp_output_480_0_g254259;
					half3 Weights_3500_g254259 = (Out_MaskJ456_g254259).xyz;
					half3 Triplanar500_g254259 = Triplanar522_g254259;
					half3 NormalWS500_g254259 = NormalWS512_g254259;
					half3 Normal500_g254259 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g254259 = SampleStochastic3D( Texture500_g254259 , Sampler500_g254259 , ZY500_g254259 , ZY_1500_g254259 , ZY_2500_g254259 , ZY_3500_g254259 , XZ500_g254259 , XZ_1500_g254259 , XZ_2500_g254259 , XZ_3500_g254259 , XY500_g254259 , XY_1500_g254259 , XY_2500_g254259 , XY_3500_g254259 , Bias500_g254259 , Weights_1500_g254259 , Weights_2500_g254259 , Weights_3500_g254259 , Triplanar500_g254259 , NormalWS500_g254259 , Normal500_g254259 );
					float4 temp_output_405_203_g254251 = localSampleStochastic3D500_g254259;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g254251 = temp_output_405_277_g254251;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g254251 = temp_output_405_278_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g254251 = temp_output_405_0_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g254251 = temp_output_405_201_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g254251 = temp_output_405_202_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g254251 = temp_output_405_203_g254251;
					#else
					float4 staticSwitch198_g254251 = temp_output_405_277_g254251;
					#endif
					half4 Local_ShaderSample199_g254251 = staticSwitch198_g254251;
					float2 appendResult428_g254251 = (float2((Local_AlbedoSample185_g254251).w , (Local_ShaderSample199_g254251).z));
					float2 temp_output_85_0_g254271 = appendResult428_g254251;
					float4 ChannelB91_g254271 = float4( temp_output_85_0_g254271, 0.0 , 0.0 );
					float localSwitchChannel691_g254271 = SwitchChannel6( Option91_g254271 , ChannelA91_g254271 , ChannelB91_g254271 );
					float clampResult17_g254269 = clamp( localSwitchChannel691_g254271 , 0.0001 , 0.9999 );
					float temp_output_7_0_g254270 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g254270 = ( clampResult17_g254269 - temp_output_7_0_g254270 );
					half Local_MultiMask78_g254251 = saturate( ( temp_output_9_0_g254270 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g254251 = lerp( 1.0 , Local_MultiMask78_g254251 , _MainColorMode);
					float4 lerpResult62_g254251 = lerp( _MainColorTwo , _MainColor , lerpResult58_g254251);
					half3 Local_ColorRGB93_g254251 = (lerpResult62_g254251).rgb;
					half3 Local_Albedo139_g254251 = ( Local_AlbedoRGB107_g254251 * Local_ColorRGB93_g254251 );
					float3 temp_output_4_0_g254253 = Local_Albedo139_g254251;
					float3 In_Albedo3_g254253 = temp_output_4_0_g254253;
					float3 temp_output_44_0_g254253 = Local_Albedo139_g254251;
					float3 In_AlbedoBase3_g254253 = temp_output_44_0_g254253;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254280) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g254257 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g254280 = staticSwitch37_g254257;
					float localBreakTextureData456_g254280 = ( 0.0 );
					TVEMasksData Data456_g254280 =(TVEMasksData)Data431_g254273;
					float4 Out_MaskA456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254280 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254280 , Out_MaskA456_g254280 , Out_MaskB456_g254280 , Out_MaskC456_g254280 , Out_MaskD456_g254280 , Out_MaskE456_g254280 , Out_MaskF456_g254280 , Out_MaskG456_g254280 , Out_MaskH456_g254280 , Out_MaskI456_g254280 , Out_MaskJ456_g254280 , Out_MaskK456_g254280 , Out_MaskL456_g254280 , Out_MaskM456_g254280 , Out_MaskN456_g254280 );
					half2 UV276_g254280 = (Out_MaskA456_g254280).xy;
					float temp_output_504_0_g254280 = 0.0;
					half Bias276_g254280 = temp_output_504_0_g254280;
					half2 Normal276_g254280 = float2( 0,0 );
					half4 localSampleCoord276_g254280 = SampleCoord( Texture276_g254280 , Sampler276_g254280 , UV276_g254280 , Bias276_g254280 , Normal276_g254280 );
					float2 temp_output_406_394_g254251 = Normal276_g254280;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254280) = _MainNormalTex;
					SamplerState Sampler502_g254280 = staticSwitch37_g254257;
					half2 UV502_g254280 = (Out_MaskA456_g254280).zw;
					half Bias502_g254280 = temp_output_504_0_g254280;
					half2 Normal502_g254280 = float2( 0,0 );
					half4 localSampleCoord502_g254280 = SampleCoord( Texture502_g254280 , Sampler502_g254280 , UV502_g254280 , Bias502_g254280 , Normal502_g254280 );
					float2 temp_output_406_397_g254251 = Normal502_g254280;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254280) = _MainNormalTex;
					SamplerState Sampler496_g254280 = staticSwitch37_g254257;
					float2 temp_output_463_0_g254280 = (Out_MaskB456_g254280).zw;
					half2 XZ496_g254280 = temp_output_463_0_g254280;
					half Bias496_g254280 = temp_output_504_0_g254280;
					half3 NormalWS512_g254280 = (Out_MaskK456_g254280).xyz;
					half3 NormalWS496_g254280 = NormalWS512_g254280;
					half3 Normal496_g254280 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254280 = SamplePlanar2D( Texture496_g254280 , Sampler496_g254280 , XZ496_g254280 , Bias496_g254280 , NormalWS496_g254280 , Normal496_g254280 );
					float3 temp_output_35_0_g254283 = Normal496_g254280;
					half3 TangentWS519_g254280 = (Out_MaskL456_g254280).xyz;
					float dotResult84_g254283 = dot( temp_output_35_0_g254283 , TangentWS519_g254280 );
					half3 BitangentWS521_g254280 = (Out_MaskM456_g254280).xyz;
					float dotResult85_g254283 = dot( temp_output_35_0_g254283 , BitangentWS521_g254280 );
					float2 appendResult87_g254283 = (float2(dotResult84_g254283 , dotResult85_g254283));
					float2 temp_output_406_375_g254251 = appendResult87_g254283;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254280) = _MainNormalTex;
					SamplerState Sampler490_g254280 = staticSwitch37_g254257;
					float2 temp_output_462_0_g254280 = (Out_MaskB456_g254280).xy;
					half2 ZY490_g254280 = temp_output_462_0_g254280;
					half2 XZ490_g254280 = temp_output_463_0_g254280;
					float2 temp_output_464_0_g254280 = (Out_MaskC456_g254280).xy;
					half2 XY490_g254280 = temp_output_464_0_g254280;
					half Bias490_g254280 = temp_output_504_0_g254280;
					half3 Triplanar522_g254280 = (Out_MaskN456_g254280).xyz;
					half3 Triplanar490_g254280 = Triplanar522_g254280;
					half3 NormalWS490_g254280 = NormalWS512_g254280;
					half3 Normal490_g254280 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254280 = SamplePlanar3D( Texture490_g254280 , Sampler490_g254280 , ZY490_g254280 , XZ490_g254280 , XY490_g254280 , Bias490_g254280 , Triplanar490_g254280 , NormalWS490_g254280 , Normal490_g254280 );
					float3 temp_output_35_0_g254284 = Normal490_g254280;
					float dotResult84_g254284 = dot( temp_output_35_0_g254284 , TangentWS519_g254280 );
					float dotResult85_g254284 = dot( temp_output_35_0_g254284 , BitangentWS521_g254280 );
					float2 appendResult87_g254284 = (float2(dotResult84_g254284 , dotResult85_g254284));
					float2 temp_output_406_353_g254251 = appendResult87_g254284;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g254280) = _MainNormalTex;
					SamplerState Sampler498_g254280 = staticSwitch37_g254257;
					half2 XZ498_g254280 = temp_output_463_0_g254280;
					float2 temp_output_473_0_g254280 = (Out_MaskE456_g254280).xy;
					half2 XZ_1498_g254280 = temp_output_473_0_g254280;
					float2 temp_output_474_0_g254280 = (Out_MaskE456_g254280).zw;
					half2 XZ_2498_g254280 = temp_output_474_0_g254280;
					float2 temp_output_475_0_g254280 = (Out_MaskF456_g254280).xy;
					half2 XZ_3498_g254280 = temp_output_475_0_g254280;
					float temp_output_510_0_g254280 = exp2( temp_output_504_0_g254280 );
					half Bias498_g254280 = temp_output_510_0_g254280;
					float3 temp_output_480_0_g254280 = (Out_MaskI456_g254280).xyz;
					half3 Weights_2498_g254280 = temp_output_480_0_g254280;
					half3 NormalWS498_g254280 = NormalWS512_g254280;
					half3 Normal498_g254280 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g254280 = SampleStochastic2D( Texture498_g254280 , Sampler498_g254280 , XZ498_g254280 , XZ_1498_g254280 , XZ_2498_g254280 , XZ_3498_g254280 , Bias498_g254280 , Weights_2498_g254280 , NormalWS498_g254280 , Normal498_g254280 );
					float3 temp_output_35_0_g254285 = Normal498_g254280;
					float dotResult84_g254285 = dot( temp_output_35_0_g254285 , TangentWS519_g254280 );
					float dotResult85_g254285 = dot( temp_output_35_0_g254285 , BitangentWS521_g254280 );
					float2 appendResult87_g254285 = (float2(dotResult84_g254285 , dotResult85_g254285));
					float2 temp_output_406_391_g254251 = appendResult87_g254285;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g254280) = _MainNormalTex;
					SamplerState Sampler500_g254280 = staticSwitch37_g254257;
					half2 ZY500_g254280 = temp_output_462_0_g254280;
					half2 ZY_1500_g254280 = (Out_MaskC456_g254280).zw;
					half2 ZY_2500_g254280 = (Out_MaskD456_g254280).xy;
					half2 ZY_3500_g254280 = (Out_MaskD456_g254280).zw;
					half2 XZ500_g254280 = temp_output_463_0_g254280;
					half2 XZ_1500_g254280 = temp_output_473_0_g254280;
					half2 XZ_2500_g254280 = temp_output_474_0_g254280;
					half2 XZ_3500_g254280 = temp_output_475_0_g254280;
					half2 XY500_g254280 = temp_output_464_0_g254280;
					half2 XY_1500_g254280 = (Out_MaskF456_g254280).zw;
					half2 XY_2500_g254280 = (Out_MaskG456_g254280).xy;
					half2 XY_3500_g254280 = (Out_MaskG456_g254280).zw;
					half Bias500_g254280 = temp_output_510_0_g254280;
					half3 Weights_1500_g254280 = (Out_MaskH456_g254280).xyz;
					half3 Weights_2500_g254280 = temp_output_480_0_g254280;
					half3 Weights_3500_g254280 = (Out_MaskJ456_g254280).xyz;
					half3 Triplanar500_g254280 = Triplanar522_g254280;
					half3 NormalWS500_g254280 = NormalWS512_g254280;
					half3 Normal500_g254280 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g254280 = SampleStochastic3D( Texture500_g254280 , Sampler500_g254280 , ZY500_g254280 , ZY_1500_g254280 , ZY_2500_g254280 , ZY_3500_g254280 , XZ500_g254280 , XZ_1500_g254280 , XZ_2500_g254280 , XZ_3500_g254280 , XY500_g254280 , XY_1500_g254280 , XY_2500_g254280 , XY_3500_g254280 , Bias500_g254280 , Weights_1500_g254280 , Weights_2500_g254280 , Weights_3500_g254280 , Triplanar500_g254280 , NormalWS500_g254280 , Normal500_g254280 );
					float3 temp_output_35_0_g254281 = Normal500_g254280;
					float dotResult84_g254281 = dot( temp_output_35_0_g254281 , TangentWS519_g254280 );
					float dotResult85_g254281 = dot( temp_output_35_0_g254281 , BitangentWS521_g254280 );
					float2 appendResult87_g254281 = (float2(dotResult84_g254281 , dotResult85_g254281));
					float2 temp_output_406_390_g254251 = appendResult87_g254281;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g254251 = temp_output_406_394_g254251;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g254251 = temp_output_406_397_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g254251 = temp_output_406_375_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g254251 = temp_output_406_353_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g254251 = temp_output_406_391_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g254251 = temp_output_406_390_g254251;
					#else
					float2 staticSwitch193_g254251 = temp_output_406_394_g254251;
					#endif
					half2 Local_NormaSample191_g254251 = staticSwitch193_g254251;
					half2 Local_NormalTS108_g254251 = ( Local_NormaSample191_g254251 * _MainNormalValue );
					float2 In_NormalTS3_g254253 = Local_NormalTS108_g254251;
					float2 break80_g254272 = Local_NormalTS108_g254251;
					float3 temp_output_77_0_g254272 = Model_TangentWS366_g254251;
					float3 temp_output_78_0_g254272 = Model_BitangentWS367_g254251;
					float3 temp_output_76_0_g254272 = Model_NormalWS226_g254251;
					half3 Local_NormalWS250_g254251 = ( ( break80_g254272.x * temp_output_77_0_g254272 ) + ( break80_g254272.y * temp_output_78_0_g254272 ) + temp_output_76_0_g254272 );
					float3 In_NormalWS3_g254253 = Local_NormalWS250_g254251;
					float temp_output_209_0_g254251 = (Local_ShaderSample199_g254251).y;
					float temp_output_7_0_g254265 = _MainOcclusionRemap.x;
					float temp_output_9_0_g254265 = ( temp_output_209_0_g254251 - temp_output_7_0_g254265 );
					float lerpResult23_g254251 = lerp( 1.0 , saturate( ( temp_output_9_0_g254265 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g254251 = lerpResult23_g254251;
					float temp_output_213_0_g254251 = (Local_ShaderSample199_g254251).w;
					float temp_output_7_0_g254268 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g254268 = ( temp_output_213_0_g254251 - temp_output_7_0_g254268 );
					half Local_Smoothness317_g254251 = ( saturate( ( temp_output_9_0_g254268 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g254251 = (float4(( (Local_ShaderSample199_g254251).x * _MainMetallicValue ) , Local_Occlusion313_g254251 , (Local_ShaderSample199_g254251).z , Local_Smoothness317_g254251));
					half4 Local_Masks109_g254251 = appendResult73_g254251;
					float4 In_Shader3_g254253 = Local_Masks109_g254251;
					float4 In_Feature3_g254253 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g254253 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g254253 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g254286 = Local_Albedo139_g254251;
					float dotResult20_g254286 = dot( temp_output_3_0_g254286 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g254251 = dotResult20_g254286;
					float temp_output_12_0_g254253 = Local_Grayscale110_g254251;
					float In_Grayscale3_g254253 = temp_output_12_0_g254253;
					float temp_output_3_0_g254287 = Local_Grayscale110_g254251;
					float clampResult27_g254287 = clamp( saturate( ( temp_output_3_0_g254287 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g254251 = clampResult27_g254287;
					float temp_output_16_0_g254253 = Local_Luminosity145_g254251;
					float In_Luminosity3_g254253 = temp_output_16_0_g254253;
					float In_MultiMask3_g254253 = Local_MultiMask78_g254251;
					float temp_output_187_0_g254251 = (Local_AlbedoSample185_g254251).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g254251 = ( temp_output_187_0_g254251 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g254251 = temp_output_187_0_g254251;
					#endif
					half Local_AlphaClip111_g254251 = staticSwitch236_g254251;
					float In_AlphaClip3_g254253 = Local_AlphaClip111_g254251;
					half Local_AlphaFade246_g254251 = (lerpResult62_g254251).a;
					float In_AlphaFade3_g254253 = Local_AlphaFade246_g254251;
					float3 temp_cast_31 = (1.0).xxx;
					float3 In_Translucency3_g254253 = temp_cast_31;
					float In_Transmission3_g254253 = 1.0;
					float In_Thickness3_g254253 = 0.0;
					float In_Diffusion3_g254253 = 0.0;
					float In_Depth3_g254253 = 0.0;
					BuildVisualData( Data3_g254253 , In_Dummy3_g254253 , In_Albedo3_g254253 , In_AlbedoBase3_g254253 , In_NormalTS3_g254253 , In_NormalWS3_g254253 , In_Shader3_g254253 , In_Feature3_g254253 , In_Season3_g254253 , In_Emissive3_g254253 , In_Grayscale3_g254253 , In_Luminosity3_g254253 , In_MultiMask3_g254253 , In_AlphaClip3_g254253 , In_AlphaFade3_g254253 , In_Translucency3_g254253 , In_Transmission3_g254253 , In_Thickness3_g254253 , In_Diffusion3_g254253 , In_Depth3_g254253 );
					TVEVisualData Data4_g254299 =(TVEVisualData)Data3_g254253;
					float Out_Dummy4_g254299 = 0.0;
					float3 Out_Albedo4_g254299 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254299 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254299 = float2( 0,0 );
					float3 Out_NormalWS4_g254299 = float3( 0,0,0 );
					float4 Out_Shader4_g254299 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254299 = float4( 0,0,0,0 );
					float4 Out_Season4_g254299 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254299 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254299 = 0.0;
					float Out_Grayscale4_g254299 = 0.0;
					float Out_Luminosity4_g254299 = 0.0;
					float Out_AlphaClip4_g254299 = 0.0;
					float Out_AlphaFade4_g254299 = 0.0;
					float3 Out_Translucency4_g254299 = float3( 0,0,0 );
					float Out_Transmission4_g254299 = 0.0;
					float Out_Thickness4_g254299 = 0.0;
					float Out_Diffusion4_g254299 = 0.0;
					float Out_Depth4_g254299 = 0.0;
					BreakVisualData( Data4_g254299 , Out_Dummy4_g254299 , Out_Albedo4_g254299 , Out_AlbedoBase4_g254299 , Out_NormalTS4_g254299 , Out_NormalWS4_g254299 , Out_Shader4_g254299 , Out_Feature4_g254299 , Out_Season4_g254299 , Out_Emissive4_g254299 , Out_MultiMask4_g254299 , Out_Grayscale4_g254299 , Out_Luminosity4_g254299 , Out_AlphaClip4_g254299 , Out_AlphaFade4_g254299 , Out_Translucency4_g254299 , Out_Transmission4_g254299 , Out_Thickness4_g254299 , Out_Diffusion4_g254299 , Out_Depth4_g254299 );
					half4 Visual_Shader531_g254290 = Out_Shader4_g254299;
					float temp_output_1331_0_g254290 = (Visual_Shader531_g254290).z;
					float temp_output_7_0_g254305 = _TerrainBaseRemap.x;
					float temp_output_9_0_g254305 = ( temp_output_1331_0_g254290 - temp_output_7_0_g254305 );
					float lerpResult1259_g254290 = lerp( 1.0 , saturate( ( temp_output_9_0_g254305 * _TerrainBaseRemap.z ) ) , _TerrainBaseValue);
					half Blend_BaseMask1043_g254290 = lerpResult1259_g254290;
					half3 Visual_NormalWS953_g254290 = Out_NormalWS4_g254299;
					float temp_output_903_0_g254290 = saturate( (Visual_NormalWS953_g254290).y );
					float temp_output_7_0_g254303 = _TerrainProjRemap.x;
					float temp_output_9_0_g254303 = ( temp_output_903_0_g254290 - temp_output_7_0_g254303 );
					float lerpResult1106_g254290 = lerp( 1.0 , saturate( ( temp_output_9_0_g254303 * _TerrainProjRemap.z ) ) , _TerrainProjValue);
					half Blend_ProjMask912_g254290 = lerpResult1106_g254290;
					half Blend_UserMask1165_g254290 = 1.0;
					half Blend_VertMask913_g254290 = 1.0;
					float localBuildGlobalData204_g251364 = ( 0.0 );
					TVEGlobalData Data204_g251364 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251364 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251364 = Dummy211_g251364;
					float4 temp_output_203_0_g251383 = TVE_CoatBaseCoord;
					TVEModelData Data15_g251454 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251454 = 0.0;
					float3 Out_PositionWS15_g251454 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251454 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251454 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251454 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251454 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251454 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251454 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251454 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251454 , Out_Dummy15_g251454 , Out_PositionWS15_g251454 , Out_PositionWO15_g251454 , Out_PivotWS15_g251454 , Out_PivotWO15_g251454 , Out_NormalWS15_g251454 , Out_TangentWS15_g251454 , Out_BitangentWS15_g251454 , Out_TriplanarWeights15_g251454 , Out_ViewDirWS15_g251454 , Out_CoordsData15_g251454 , Out_VertexData15_g251454 , Out_Interpolator15_g251454 );
					float3 Model_PositionWS497_g251364 = Out_PositionWS15_g251454;
					float2 Model_PositionWS_XZ143_g251364 = (Model_PositionWS497_g251364).xz;
					float3 Model_PivotWS498_g251364 = Out_PivotWS15_g251454;
					float2 Model_PivotWS_XZ145_g251364 = (Model_PivotWS498_g251364).xz;
					float2 lerpResult300_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251383 = lerpResult300_g251364;
					float temp_output_82_0_g251381 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251383 = temp_output_82_0_g251381;
					float4 tex2DArrayNode83_g251383 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251383).zw + ( (temp_output_203_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383) );
					float4 appendResult210_g251383 = (float4(tex2DArrayNode83_g251383.rgb , tex2DArrayNode83_g251383.a));
					float4 temp_output_204_0_g251383 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251383 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251383).zw + ( (temp_output_204_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383) );
					float4 appendResult212_g251383 = (float4(tex2DArrayNode122_g251383.rgb , tex2DArrayNode122_g251383.a));
					float4 TVE_RenderNearPositionR628_g251364 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251364 = saturate( ( distance( Model_PositionWS497_g251364 , (TVE_RenderNearPositionR628_g251364).xyz ) / (TVE_RenderNearPositionR628_g251364).w ) );
					float temp_output_7_0_g251453 = 1.0;
					float temp_output_9_0_g251453 = ( temp_output_507_0_g251364 - temp_output_7_0_g251453 );
					half TVE_RenderNearFadeValue635_g251364 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251364 = saturate( ( temp_output_9_0_g251453 / ( ( TVE_RenderNearFadeValue635_g251364 - temp_output_7_0_g251453 ) + 0.0001 ) ) );
					float4 lerpResult131_g251383 = lerp( appendResult210_g251383 , appendResult212_g251383 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251381 = lerpResult131_g251383;
					float4 lerpResult168_g251381 = lerp( TVE_CoatParams , temp_output_159_109_g251381 , TVE_CoatLayers[(int)temp_output_82_0_g251381]);
					float4 temp_output_589_109_g251364 = lerpResult168_g251381;
					half4 Coat_Texture302_g251364 = temp_output_589_109_g251364;
					float4 In_CoatTexture204_g251364 = Coat_Texture302_g251364;
					half4 Draw_Texture656_g251364 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251364 = Draw_Texture656_g251364;
					float4 temp_output_203_0_g251408 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251408 = lerpResult85_g251364;
					float temp_output_82_0_g251405 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251408 = temp_output_82_0_g251405;
					float4 tex2DArrayNode83_g251408 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251408).zw + ( (temp_output_203_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408) );
					float4 appendResult210_g251408 = (float4(tex2DArrayNode83_g251408.rgb , tex2DArrayNode83_g251408.a));
					float4 temp_output_204_0_g251408 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251408 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251408).zw + ( (temp_output_204_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408) );
					float4 appendResult212_g251408 = (float4(tex2DArrayNode122_g251408.rgb , tex2DArrayNode122_g251408.a));
					float4 lerpResult131_g251408 = lerp( appendResult210_g251408 , appendResult212_g251408 , Global_TexBlend509_g251364);
					float4 temp_output_171_109_g251405 = lerpResult131_g251408;
					float4 lerpResult174_g251405 = lerp( TVE_PaintParams , temp_output_171_109_g251405 , TVE_PaintLayers[(int)temp_output_82_0_g251405]);
					float4 temp_output_595_109_g251364 = lerpResult174_g251405;
					half4 Paint_Texture71_g251364 = temp_output_595_109_g251364;
					float4 In_PaintTexture204_g251364 = Paint_Texture71_g251364;
					float4 temp_output_203_0_g251391 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251391 = lerpResult104_g251364;
					float temp_output_132_0_g251389 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251391 = temp_output_132_0_g251389;
					float4 tex2DArrayNode83_g251391 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251391).zw + ( (temp_output_203_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391) );
					float4 appendResult210_g251391 = (float4(tex2DArrayNode83_g251391.rgb , tex2DArrayNode83_g251391.a));
					float4 temp_output_204_0_g251391 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251391 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251391).zw + ( (temp_output_204_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391) );
					float4 appendResult212_g251391 = (float4(tex2DArrayNode122_g251391.rgb , tex2DArrayNode122_g251391.a));
					float4 lerpResult131_g251391 = lerp( appendResult210_g251391 , appendResult212_g251391 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251389 = lerpResult131_g251391;
					float4 lerpResult145_g251389 = lerp( TVE_AtmoParams , temp_output_137_109_g251389 , TVE_AtmoLayers[(int)temp_output_132_0_g251389]);
					float4 temp_output_590_110_g251364 = lerpResult145_g251389;
					half4 Atmo_Texture80_g251364 = temp_output_590_110_g251364;
					float4 In_AtmoTexture204_g251364 = Atmo_Texture80_g251364;
					float4 temp_output_203_0_g251459 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251459 = lerpResult414_g251364;
					float temp_output_132_0_g251457 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251459 = temp_output_132_0_g251457;
					float4 tex2DArrayNode83_g251459 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251459).zw + ( (temp_output_203_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459) );
					float4 appendResult210_g251459 = (float4(tex2DArrayNode83_g251459.rgb , tex2DArrayNode83_g251459.a));
					float4 temp_output_204_0_g251459 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251459 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251459).zw + ( (temp_output_204_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459) );
					float4 appendResult212_g251459 = (float4(tex2DArrayNode122_g251459.rgb , tex2DArrayNode122_g251459.a));
					float4 lerpResult131_g251459 = lerp( appendResult210_g251459 , appendResult212_g251459 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251457 = lerpResult131_g251459;
					float4 lerpResult145_g251457 = lerp( TVE_EffexParams , temp_output_137_109_g251457 , TVE_EffexLayers[(int)temp_output_132_0_g251457]);
					float4 temp_output_731_110_g251364 = lerpResult145_g251457;
					half4 Effex_Texture420_g251364 = temp_output_731_110_g251364;
					float4 In_EffexTexture204_g251364 = Effex_Texture420_g251364;
					float4 temp_output_203_0_g251439 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251439 = lerpResult247_g251364;
					float temp_output_82_0_g251437 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251439 = temp_output_82_0_g251437;
					float4 tex2DArrayNode83_g251439 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251439).zw + ( (temp_output_203_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439) );
					float4 appendResult210_g251439 = (float4(tex2DArrayNode83_g251439.rgb , tex2DArrayNode83_g251439.a));
					float4 temp_output_204_0_g251439 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251439 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251439).zw + ( (temp_output_204_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439) );
					float4 appendResult212_g251439 = (float4(tex2DArrayNode122_g251439.rgb , tex2DArrayNode122_g251439.a));
					float4 lerpResult131_g251439 = lerp( appendResult210_g251439 , appendResult212_g251439 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251437 = lerpResult131_g251439;
					float4 lerpResult167_g251437 = lerp( TVE_GlowParams , temp_output_159_109_g251437 , TVE_GlowLayers[(int)temp_output_82_0_g251437]);
					float4 temp_output_593_109_g251364 = lerpResult167_g251437;
					half4 Glow_Texture248_g251364 = temp_output_593_109_g251364;
					float4 In_GlowTexture204_g251364 = Glow_Texture248_g251364;
					float4 temp_output_203_0_g251375 = TVE_FormBaseCoord;
					float2 lerpResult168_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251375 = lerpResult168_g251364;
					float temp_output_130_0_g251373 = _GlobalFormLayerValue;
					float temp_output_82_0_g251375 = temp_output_130_0_g251373;
					float4 tex2DArrayNode83_g251375 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251375).zw + ( (temp_output_203_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375) );
					float4 appendResult210_g251375 = (float4(tex2DArrayNode83_g251375.rgb , tex2DArrayNode83_g251375.a));
					float4 temp_output_204_0_g251375 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251375 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251375).zw + ( (temp_output_204_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375) );
					float4 appendResult212_g251375 = (float4(tex2DArrayNode122_g251375.rgb , tex2DArrayNode122_g251375.a));
					float4 lerpResult131_g251375 = lerp( appendResult210_g251375 , appendResult212_g251375 , Global_TexBlend509_g251364);
					float4 temp_output_135_109_g251373 = lerpResult131_g251375;
					float4 lerpResult143_g251373 = lerp( TVE_FormParams , temp_output_135_109_g251373 , TVE_FormLayers[(int)temp_output_130_0_g251373]);
					float4 temp_output_592_0_g251364 = lerpResult143_g251373;
					float4 Form_Texture112_g251364 = temp_output_592_0_g251364;
					float4 In_FormTexture204_g251364 = Form_Texture112_g251364;
					float4 In_LandTexture204_g251364 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251423 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251423 = lerpResult681_g251364;
					float temp_output_136_0_g251421 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251423 = temp_output_136_0_g251421;
					float4 tex2DArrayNode83_g251423 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251423).zw + ( (temp_output_203_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423) );
					float4 appendResult210_g251423 = (float4(tex2DArrayNode83_g251423.rgb , tex2DArrayNode83_g251423.a));
					float4 temp_output_204_0_g251423 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251423 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251423).zw + ( (temp_output_204_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423) );
					float4 appendResult212_g251423 = (float4(tex2DArrayNode122_g251423.rgb , tex2DArrayNode122_g251423.a));
					float4 lerpResult131_g251423 = lerp( appendResult210_g251423 , appendResult212_g251423 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251421 = lerpResult131_g251423;
					float4 lerpResult149_g251421 = lerp( TVE_VertxParams , temp_output_141_109_g251421 , TVE_VertxLayers[(int)temp_output_136_0_g251421]);
					float4 temp_output_695_0_g251364 = lerpResult149_g251421;
					half4 Vertx_Texture693_g251364 = temp_output_695_0_g251364;
					float4 In_VertxTexture204_g251364 = Vertx_Texture693_g251364;
					float4 temp_output_203_0_g251399 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251399 = lerpResult400_g251364;
					float temp_output_136_0_g251397 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251399 = temp_output_136_0_g251397;
					float4 tex2DArrayNode83_g251399 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251399).zw + ( (temp_output_203_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399) );
					float4 appendResult210_g251399 = (float4(tex2DArrayNode83_g251399.rgb , tex2DArrayNode83_g251399.a));
					float4 temp_output_204_0_g251399 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251399 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251399).zw + ( (temp_output_204_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399) );
					float4 appendResult212_g251399 = (float4(tex2DArrayNode122_g251399.rgb , tex2DArrayNode122_g251399.a));
					float4 lerpResult131_g251399 = lerp( appendResult210_g251399 , appendResult212_g251399 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251397 = lerpResult131_g251399;
					float4 lerpResult149_g251397 = lerp( TVE_FlowParams , temp_output_141_109_g251397 , TVE_FlowLayers[(int)temp_output_136_0_g251397]);
					float4 temp_output_594_0_g251364 = lerpResult149_g251397;
					half4 Flow_Texture405_g251364 = temp_output_594_0_g251364;
					float4 In_FlowTexture204_g251364 = Flow_Texture405_g251364;
					half4 User_Texture677_g251364 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251364 = User_Texture677_g251364;
					BuildGlobalData( Data204_g251364 , In_Dummy204_g251364 , In_CoatTexture204_g251364 , In_DrawTexture204_g251364 , In_PaintTexture204_g251364 , In_AtmoTexture204_g251364 , In_EffexTexture204_g251364 , In_GlowTexture204_g251364 , In_FormTexture204_g251364 , In_LandTexture204_g251364 , In_VertxTexture204_g251364 , In_FlowTexture204_g251364 , In_UserTexture204_g251364 );
					TVEGlobalData Data15_g254312 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g254312 = 0.0;
					float4 Out_CoatTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g254312 = float4( 0,0,0,0 );
					BreakData( Data15_g254312 , Out_Dummy15_g254312 , Out_CoatTexture15_g254312 , Out_DrawTexture15_g254312 , Out_PaintTexture15_g254312 , Out_AtmoTexture15_g254312 , Out_EffexTexture15_g254312 , Out_GlowTexture15_g254312 , Out_FormTexture15_g254312 , Out_LandTexture15_g254312 , Out_VertxTexture15_g254312 , Out_FlowTexture15_g254312 , Out_UserTexture15_g254312 );
					half4 Global_FormParams1018_g254290 = Out_FormTexture15_g254312;
					float temp_output_7_0_g254726 = -_TerrainFormValue;
					float temp_output_9_0_g254726 = ( ( ( (Global_FormParams1018_g254290).z - PositionWS.y ) - 0.01 ) - temp_output_7_0_g254726 );
					float temp_output_1322_0_g254290 = saturate( ( temp_output_9_0_g254726 / ( ( 0.0 - temp_output_7_0_g254726 ) + 0.0001 ) ) );
					float temp_output_64_0_g254753 = temp_output_1322_0_g254290;
					float Multiply89_g254753 = temp_output_64_0_g254753;
					float Additive89_g254753 = 1.0;
					float temp_output_78_0_g254753 = ( temp_output_64_0_g254753 * 0.5 );
					float MulAdd89_g254753 = temp_output_78_0_g254753;
					float temp_output_67_0_g254753 = _TerrainFormMath;
					float Option89_g254753 = temp_output_67_0_g254753;
					float localSwitchFormMask89_g254753 = SwitchFormMask( Multiply89_g254753 , Additive89_g254753 , MulAdd89_g254753 , Option89_g254753 );
					half Blend_FormMask_Mul1132_g254290 = localSwitchFormMask89_g254753;
					float Multiply88_g254753 = 0.0;
					float Additive88_g254753 = temp_output_64_0_g254753;
					float MulAdd88_g254753 = temp_output_78_0_g254753;
					float Option88_g254753 = temp_output_67_0_g254753;
					float localSwitchFormMask88_g254753 = SwitchFormMask( Multiply88_g254753 , Additive88_g254753 , MulAdd88_g254753 , Option88_g254753 );
					half Blend_FormMask_Add1131_g254290 = localSwitchFormMask88_g254753;
					float temp_output_7_0_g254752 = _TerrainBlendRemap.x;
					float temp_output_9_0_g254752 = ( saturate( ( ( Detail_TexMask429_g254290 * Blend_BaseMask1043_g254290 * Blend_ProjMask912_g254290 * Blend_UserMask1165_g254290 * Blend_VertMask913_g254290 * Blend_FormMask_Mul1132_g254290 * Feature_Intensity1266_g254290 ) + Blend_FormMask_Add1131_g254290 ) ) - temp_output_7_0_g254752 );
					half Blend_Mask412_g254290 = saturate( ( temp_output_9_0_g254752 * _TerrainBlendRemap.z ) );
					float4 appendResult1270_g254290 = (float4(Blend_Mask412_g254290 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_40 = (0.0).xxxx;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 ifLocalVar18_g254308 = 0;
					if( Feature_Intensity1266_g254290 <= 0.0 )
					ifLocalVar18_g254308 = temp_cast_41;
					else
					ifLocalVar18_g254308 = appendResult1270_g254290;
					float4 In_MaskB3_g254309 = ifLocalVar18_g254308;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskC3_g254309 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskD3_g254309 = temp_cast_43;
					float4 temp_cast_44 = (0.0).xxxx;
					float4 In_MaskE3_g254309 = temp_cast_44;
					float4 temp_cast_45 = (0.0).xxxx;
					float4 In_MaskF3_g254309 = temp_cast_45;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 In_MaskG3_g254309 = temp_cast_46;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskH3_g254309 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskI3_g254309 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskJ3_g254309 = temp_cast_49;
					float4 temp_cast_50 = (0.0).xxxx;
					float4 In_MaskK3_g254309 = temp_cast_50;
					float4 temp_cast_51 = (0.0).xxxx;
					float4 In_MaskL3_g254309 = temp_cast_51;
					{
					Data3_g254309.MaskA = In_MaskA3_g254309;
					Data3_g254309.MaskB = In_MaskB3_g254309;
					Data3_g254309.MaskC = In_MaskC3_g254309;
					Data3_g254309.MaskD = In_MaskD3_g254309;
					Data3_g254309.MaskE = In_MaskE3_g254309;
					Data3_g254309.MaskF = In_MaskF3_g254309;
					Data3_g254309.MaskG = In_MaskG3_g254309;
					Data3_g254309.MaskH = In_MaskH3_g254309;
					Data3_g254309.MaskI = In_MaskI3_g254309;
					Data3_g254309.MaskJ= In_MaskJ3_g254309;
					Data3_g254309.MaskK= In_MaskK3_g254309;
					Data3_g254309.MaskL = In_MaskL3_g254309;
					}
					TVEMasksData Data4_g254755 = Data3_g254309;
					float4 Out_MaskA4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g254755 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g254755 = Data4_g254755.MaskA;
					Out_MaskB4_g254755 = Data4_g254755.MaskB;
					Out_MaskC4_g254755 = Data4_g254755.MaskC;
					Out_MaskD4_g254755 = Data4_g254755.MaskD;
					Out_MaskE4_g254755 = Data4_g254755.MaskE;
					Out_MaskF4_g254755 = Data4_g254755.MaskF;
					Out_MaskG4_g254755 = Data4_g254755.MaskG;
					Out_MaskH4_g254755 = Data4_g254755.MaskH;
					}
					float3 lerpResult2568 = lerp( color107_g254756 , color106_g254756 , (Out_MaskA4_g254755).x);
					float3 ifLocalVar40_g254758 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g254758 = lerpResult2568;
					float ifLocalVar40_g254759 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g254759 = (Out_MaskB4_g254755).x;
					half3 Final_Debug2399 = ( ifLocalVar40_g254758 + ifLocalVar40_g254759 );
					float temp_output_7_0_g254768 = TVE_DEBUG_Min;
					float3 temp_cast_52 = (temp_output_7_0_g254768).xxx;
					float3 temp_output_9_0_g254768 = ( Final_Debug2399 - temp_cast_52 );
					float lerpResult76_g254761 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g254761 = lerpResult76_g254761;
					float3 lerpResult72_g254761 = lerp( (lerpResult73_g254762).rgb , saturate( ( temp_output_9_0_g254768 / ( ( TVE_DEBUG_Max - temp_output_7_0_g254768 ) + 0.0001 ) ) ) , Filter152_g254761);
					float dotResult61_g254761 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g254761 = ( 1.0 - saturate( dotResult61_g254761 ) );
					float Shading_Fresnel59_g254761 = (( 1.0 - ( temp_output_65_0_g254761 * temp_output_65_0_g254761 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g254761 = IN.ase_texcoord10;
					float depthLinearEye57_g254761 = LinearEyeDepth( ase_positionCS57_g254761.z / ase_positionCS57_g254761.w );
					float temp_output_69_0_g254761 = saturate(  (0.0 + ( depthLinearEye57_g254761 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g254761 = (( temp_output_69_0_g254761 * temp_output_69_0_g254761 )*0.5 + 0.5);
					float lerpResult84_g254761 = lerp( 1.0 , Shading_Fresnel59_g254761 , ( Shading_Distance58_g254761 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g254766 = ( 0.0 );
					TVEVisualData Data4_g254766 =(TVEVisualData)Data3_g254253;
					float Out_Dummy4_g254766 = 0.0;
					float3 Out_Albedo4_g254766 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254766 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254766 = float2( 0,0 );
					float3 Out_NormalWS4_g254766 = float3( 0,0,0 );
					float4 Out_Shader4_g254766 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254766 = float4( 0,0,0,0 );
					float4 Out_Season4_g254766 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254766 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254766 = 0.0;
					float Out_Grayscale4_g254766 = 0.0;
					float Out_Luminosity4_g254766 = 0.0;
					float Out_AlphaClip4_g254766 = 0.0;
					float Out_AlphaFade4_g254766 = 0.0;
					float3 Out_Translucency4_g254766 = float3( 0,0,0 );
					float Out_Transmission4_g254766 = 0.0;
					float Out_Thickness4_g254766 = 0.0;
					float Out_Diffusion4_g254766 = 0.0;
					float Out_Depth4_g254766 = 0.0;
					BreakVisualData( Data4_g254766 , Out_Dummy4_g254766 , Out_Albedo4_g254766 , Out_AlbedoBase4_g254766 , Out_NormalTS4_g254766 , Out_NormalWS4_g254766 , Out_Shader4_g254766 , Out_Feature4_g254766 , Out_Season4_g254766 , Out_Emissive4_g254766 , Out_MultiMask4_g254766 , Out_Grayscale4_g254766 , Out_Luminosity4_g254766 , Out_AlphaClip4_g254766 , Out_AlphaFade4_g254766 , Out_Translucency4_g254766 , Out_Transmission4_g254766 , Out_Thickness4_g254766 , Out_Diffusion4_g254766 , Out_Depth4_g254766 );
					float Alpha109_g254761 = Out_AlphaClip4_g254766;
					float lerpResult91_g254761 = lerp( 1.0 , Alpha109_g254761 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g254761 = lerp( 1.0 , lerpResult91_g254761 , Filter152_g254761);
					clip( lerpResult154_g254761 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2664_114;
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

					o.Emission = ( lerpResult72_g254761 * lerpResult84_g254761 );
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
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_TERRAIN_MASK_SAMPLE_MAIN_UV TVE_TERRAIN_MASK_SAMPLE_EXTRA_UV TVE_TERRAIN_MASK_SAMPLE_PLANAR_2D TVE_TERRAIN_MASK_SAMPLE_PLANAR_3D
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				#if defined (TVE_TERRAIN_HOLES) //Terrain Holes
					#define TVE_ALPHA_CLIP //Terrain Holes
				#endif //Terrain Holes
				  
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

				uniform half _TerrainSampleMode6;
				uniform half _TerrainSampleMode7;
				uniform half _TerrainSampleMode8;
				uniform half _TerrainSampleMode5;
				uniform half _TerrainSampleMode10;
				uniform half _TerrainSampleMode11;
				uniform half _TerrainSampleMode12;
				uniform half _TerrainSampleMode9;
				uniform half _TerrainSampleMode14;
				uniform half _TerrainSampleMode15;
				uniform half _TerrainSampleMode16;
				uniform half _TerrainSampleMode13;
				uniform half _TerrainSampleMode2;
				uniform half _TerrainSampleMode3;
				uniform half _TerrainSampleMode4;
				uniform half _TerrainSampleMode1;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainFeatureTex);
				SamplerState sampler_TerrainFeatureTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainShaderTex);
				SamplerState sampler_TerrainShaderTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainNormalTex);
				SamplerState sampler_TerrainNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainAlbedoTex);
				SamplerState sampler_TerrainAlbedoTex;
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
				uniform float _IsShaderType;
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
				uniform half _TerrainIntensityValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainMaskTex);
				uniform half4 _terrain_mask_coord_value;
				uniform half _TerrainMaskSampleMode;
				uniform half _TerrainMaskCoordMode;
				uniform half4 _TerrainMaskCoordValue;
				uniform half4 _TerrainMaskRemap;
				uniform half _TerrainMaskValue;
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
				uniform half4 _TerrainBaseRemap;
				uniform half _TerrainBaseValue;
				uniform half4 _TerrainProjRemap;
				uniform half _TerrainProjValue;
				uniform float _TerrainFormValue;
				uniform half _TerrainFormMath;
				uniform half4 _TerrainBlendRemap;
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
				
				float SwitchFormMask( float Multiply, float Additive, float MulAdd, half Option )
				{
					switch (Option) {
						default:
					                case 0:
							return Multiply;
						case 1:
							return Additive;
						case 2:
							return MulAdd;
					}
				}
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251977 =(TVEVertexData)0;
					float In_Dummy16_g251977 = 0.0;
					TVEVertexData Data16_g251972 =(TVEVertexData)0;
					float In_Dummy16_g251972 = 0.0;
					float localIfModelDataByShader26_g251465 = ( 0.0 );
					TVEModelData Data26_g251465 = (TVEModelData)0;
					TVEModelData Data16_g241434 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#endif
					half Dummy207_g241416 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241416 );
					float temp_output_14_0_g241434 = Dummy207_g241416;
					float In_Dummy16_g241434 = temp_output_14_0_g241434;
					float3 PositionOS131_g241416 = v.vertex.xyz;
					float3 temp_output_4_0_g241434 = PositionOS131_g241416;
					float3 In_PositionOS16_g241434 = temp_output_4_0_g241434;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241416 = ase_positionWS;
					float3 vertexToFrag73_g241416 = temp_output_104_7_g241416;
					float3 PositionWS122_g241416 = vertexToFrag73_g241416;
					float3 In_PositionWS16_g241434 = PositionWS122_g241416;
					float4x4 break19_g241419 = unity_ObjectToWorld;
					float3 appendResult20_g241419 = (float3(break19_g241419[ 0 ][ 3 ] , break19_g241419[ 1 ][ 3 ] , break19_g241419[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241416 = appendResult20_g241419;
					float4x4 break19_g241421 = unity_ObjectToWorld;
					float3 appendResult20_g241421 = (float3(break19_g241421[ 0 ][ 3 ] , break19_g241421[ 1 ][ 3 ] , break19_g241421[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241417 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241416 = PositionOS131_g241416;
					float3 appendResult234_g241416 = (float3(break233_g241416.x , 0.0 , break233_g241416.z));
					float3 break413_g241416 = PositionOS131_g241416;
					float3 appendResult414_g241416 = (float3(break413_g241416.x , break413_g241416.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241423 = appendResult414_g241416;
					#else
					float3 staticSwitch65_g241423 = appendResult234_g241416;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241416 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241416 = appendResult60_g241417;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241416 = staticSwitch65_g241423;
					#else
					float3 staticSwitch229_g241416 = _Vector0;
					#endif
					float3 PivotOS149_g241416 = staticSwitch229_g241416;
					float3 temp_output_122_0_g241421 = PivotOS149_g241416;
					float3 PivotsOnlyWS105_g241421 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241421 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241416 = ( appendResult20_g241421 + PivotsOnlyWS105_g241421 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#else
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#endif
					float3 vertexToFrag76_g241416 = staticSwitch236_g241416;
					float3 PivotWS121_g241416 = vertexToFrag76_g241416;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241416 = ( PositionWS122_g241416 - PivotWS121_g241416 );
					#else
					float3 staticSwitch204_g241416 = PositionWS122_g241416;
					#endif
					float3 PositionWO132_g241416 = ( staticSwitch204_g241416 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241434 = PositionWO132_g241416;
					float3 In_PivotOS16_g241434 = PivotOS149_g241416;
					float3 In_PivotWS16_g241434 = PivotWS121_g241416;
					float3 PivotWO133_g241416 = ( PivotWS121_g241416 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241434 = PivotWO133_g241416;
					half3 NormalOS134_g241416 = v.normal;
					float3 temp_output_21_0_g241434 = NormalOS134_g241416;
					float3 In_NormalOS16_g241434 = temp_output_21_0_g241434;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241416 = normalizedWorldNormal;
					float3 In_NormalWS16_g241434 = NormalWS95_g241416;
					half4 TangentlOS153_g241416 = v.tangent;
					float4 temp_output_6_0_g241434 = TangentlOS153_g241416;
					float4 In_TangentOS16_g241434 = temp_output_6_0_g241434;
					float3 normalizeResult296_g241416 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241416 ) );
					half3 ViewDirWS169_g241416 = normalizeResult296_g241416;
					float3 In_ViewDirWS16_g241434 = ViewDirWS169_g241416;
					float4 appendResult397_g241416 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241416 = appendResult397_g241416;
					float4 In_CoordsData16_g241434 = CoordsData398_g241416;
					half4 VertexMasks171_g241416 = v.ase_color;
					float4 In_VertexData16_g241434 = VertexMasks171_g241416;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241428 = (PositionOS131_g241416).z;
					#else
					float staticSwitch65_g241428 = (PositionOS131_g241416).y;
					#endif
					half Object_HeightValue267_g241416 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241416 = saturate( ( staticSwitch65_g241428 / Object_HeightValue267_g241416 ) );
					half3 Position387_g241416 = PositionOS131_g241416;
					half Height387_g241416 = Object_HeightValue267_g241416;
					half Object_RadiusValue268_g241416 = _ObjectRadiusValue;
					half Radius387_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskYUp387_g241416 = CapsuleMaskYUp( Position387_g241416 , Height387_g241416 , Radius387_g241416 );
					half3 Position408_g241416 = PositionOS131_g241416;
					half Height408_g241416 = Object_HeightValue267_g241416;
					half Radius408_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskZUp408_g241416 = CapsuleMaskZUp( Position408_g241416 , Height408_g241416 , Radius408_g241416 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241433 = saturate( localCapsuleMaskZUp408_g241416 );
					#else
					float staticSwitch65_g241433 = saturate( localCapsuleMaskYUp387_g241416 );
					#endif
					half Bounds_SphereMask282_g241416 = staticSwitch65_g241433;
					float4 appendResult253_g241416 = (float4(Bounds_HeightMask274_g241416 , Bounds_SphereMask282_g241416 , 1.0 , 1.0));
					half4 MasksData254_g241416 = appendResult253_g241416;
					float4 In_MasksData16_g241434 = MasksData254_g241416;
					float temp_output_17_0_g241427 = _ObjectPhaseMode;
					float Option70_g241427 = temp_output_17_0_g241427;
					float4 temp_output_3_0_g241427 = v.ase_color;
					float4 Channel70_g241427 = temp_output_3_0_g241427;
					float localSwitchChannel470_g241427 = SwitchChannel4( Option70_g241427 , Channel70_g241427 );
					half Phase_Value372_g241416 = localSwitchChannel470_g241427;
					float3 break319_g241416 = PivotWO133_g241416;
					half Pivot_Position322_g241416 = ( break319_g241416.x + break319_g241416.z );
					half Phase_Position357_g241416 = ( Phase_Value372_g241416 + Pivot_Position322_g241416 );
					float temp_output_248_0_g241416 = frac( Phase_Position357_g241416 );
					float4 appendResult177_g241416 = (float4((frac( ( Phase_Position357_g241416 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241416));
					half4 Phase_Data176_g241416 = appendResult177_g241416;
					float4 In_PhaseData16_g241434 = Phase_Data176_g241416;
					BuildModelVertData( Data16_g241434 , In_Dummy16_g241434 , In_PositionOS16_g241434 , In_PositionWS16_g241434 , In_PositionWO16_g241434 , In_PivotOS16_g241434 , In_PivotWS16_g241434 , In_PivotWO16_g241434 , In_NormalOS16_g241434 , In_NormalWS16_g241434 , In_TangentOS16_g241434 , In_ViewDirWS16_g241434 , In_CoordsData16_g241434 , In_VertexData16_g241434 , In_MasksData16_g241434 , In_PhaseData16_g241434 );
					TVEModelData DataDefault26_g251465 = Data16_g241434;
					TVEModelData DataGeneral26_g251465 = Data16_g241434;
					TVEModelData DataBlanket26_g251465 = Data16_g241434;
					TVEModelData DataImpostor26_g251465 = Data16_g241434;
					TVEModelData Data16_g241414 =(TVEModelData)0;
					half Dummy207_g241396 = 0.0;
					float temp_output_14_0_g241414 = Dummy207_g241396;
					float In_Dummy16_g241414 = temp_output_14_0_g241414;
					float3 PositionOS131_g241396 = v.vertex.xyz;
					float3 temp_output_4_0_g241414 = PositionOS131_g241396;
					float3 In_PositionOS16_g241414 = temp_output_4_0_g241414;
					float3 temp_output_104_7_g241396 = ase_positionWS;
					float3 PositionWS122_g241396 = temp_output_104_7_g241396;
					float3 In_PositionWS16_g241414 = PositionWS122_g241396;
					float4x4 break19_g241399 = unity_ObjectToWorld;
					float3 appendResult20_g241399 = (float3(break19_g241399[ 0 ][ 3 ] , break19_g241399[ 1 ][ 3 ] , break19_g241399[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241396 = appendResult20_g241399;
					float3 PivotWS121_g241396 = temp_output_340_7_g241396;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241396 = ( PositionWS122_g241396 - PivotWS121_g241396 );
					#else
					float3 staticSwitch204_g241396 = PositionWS122_g241396;
					#endif
					float3 PositionWO132_g241396 = ( staticSwitch204_g241396 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241414 = PositionWO132_g241396;
					float3 PivotOS149_g241396 = _Vector0;
					float3 In_PivotOS16_g241414 = PivotOS149_g241396;
					float3 In_PivotWS16_g241414 = PivotWS121_g241396;
					float3 PivotWO133_g241396 = ( PivotWS121_g241396 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241414 = PivotWO133_g241396;
					half3 NormalOS134_g241396 = v.normal;
					float3 temp_output_21_0_g241414 = NormalOS134_g241396;
					float3 In_NormalOS16_g241414 = temp_output_21_0_g241414;
					half3 NormalWS95_g241396 = normalizedWorldNormal;
					float3 In_NormalWS16_g241414 = NormalWS95_g241396;
					float4 appendResult462_g241396 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241396 = appendResult462_g241396;
					float4 temp_output_6_0_g241414 = TangentlOS153_g241396;
					float4 In_TangentOS16_g241414 = temp_output_6_0_g241414;
					float3 normalizeResult296_g241396 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241396 ) );
					half3 ViewDirWS169_g241396 = normalizeResult296_g241396;
					float3 In_ViewDirWS16_g241414 = ViewDirWS169_g241396;
					float4 appendResult397_g241396 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241396 = appendResult397_g241396;
					float4 In_CoordsData16_g241414 = CoordsData398_g241396;
					half4 VertexMasks171_g241396 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241414 = VertexMasks171_g241396;
					half4 MasksData254_g241396 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241414 = MasksData254_g241396;
					half4 Phase_Data176_g241396 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241414 = Phase_Data176_g241396;
					BuildModelVertData( Data16_g241414 , In_Dummy16_g241414 , In_PositionOS16_g241414 , In_PositionWS16_g241414 , In_PositionWO16_g241414 , In_PivotOS16_g241414 , In_PivotWS16_g241414 , In_PivotWO16_g241414 , In_NormalOS16_g241414 , In_NormalWS16_g241414 , In_TangentOS16_g241414 , In_ViewDirWS16_g241414 , In_CoordsData16_g241414 , In_VertexData16_g241414 , In_MasksData16_g241414 , In_PhaseData16_g241414 );
					TVEModelData DataTerrain26_g251465 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251465 = IsShaderType2672;
					{
					if (Type26_g251465 == 0 )
					{
					Data26_g251465 = DataDefault26_g251465;
					}
					else if (Type26_g251465 == 1 )
					{
					Data26_g251465 = DataGeneral26_g251465;
					}
					else if (Type26_g251465 == 2 )
					{
					Data26_g251465 = DataBlanket26_g251465;
					}
					else if (Type26_g251465 == 3 )
					{
					Data26_g251465 = DataImpostor26_g251465;
					}
					else if (Type26_g251465 == 4 )
					{
					Data26_g251465 = DataTerrain26_g251465;
					}
					}
					TVEModelData Data15_g251973 =(TVEModelData)Data26_g251465;
					float Out_Dummy15_g251973 = 0.0;
					float3 Out_PositionOS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251973 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251973 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251973 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251973 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251973 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251973 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251973 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251973 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251973 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251973 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251973 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251973 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251973 , Out_Dummy15_g251973 , Out_PositionOS15_g251973 , Out_PositionWS15_g251973 , Out_PositionWO15_g251973 , Out_PositionRawOS15_g251973 , Out_PivotOS15_g251973 , Out_PivotWS15_g251973 , Out_PivotWO15_g251973 , Out_NormalOS15_g251973 , Out_NormalWS15_g251973 , Out_NormalRawOS15_g251973 , Out_TangentOS15_g251973 , Out_TangentWS15_g251973 , Out_BitangentWS15_g251973 , Out_ViewDirWS15_g251973 , Out_CoordsData15_g251973 , Out_VertexData15_g251973 , Out_MasksData15_g251973 , Out_PhaseData15_g251973 , Out_TransformData15_g251973 , Out_RotationData15_g251973 , Out_Interpolator15_g251973 );
					float3 In_PositionOS16_g251972 = Out_PositionOS15_g251973;
					float3 In_NormalOS16_g251972 = Out_NormalOS15_g251973;
					float4 In_TangentOS16_g251972 = Out_TangentOS15_g251973;
					float4 In_TransformData16_g251972 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251972 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251972 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251972 , In_Dummy16_g251972 , In_PositionOS16_g251972 , In_NormalOS16_g251972 , In_TangentOS16_g251972 , In_TransformData16_g251972 , In_RotationData16_g251972 , In_Interpolator16_g251972 );
					TVEVertexData Data15_g251975 =(TVEVertexData)Data16_g251972;
					float Out_Dummy15_g251975 = 0.0;
					float3 Out_PositionOS15_g251975 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251975 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251975 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251975 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251975 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251975 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251975 , Out_Dummy15_g251975 , Out_PositionOS15_g251975 , Out_NormalOS15_g251975 , Out_TangentOS15_g251975 , Out_TransformData15_g251975 , Out_RotationData15_g251975 , Out_Interpolator15_g251975 );
					TVEModelData Data15_g251976 =(TVEModelData)Data15_g251973;
					float Out_Dummy15_g251976 = 0.0;
					float3 Out_PositionOS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251976 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251976 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251976 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251976 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251976 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251976 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251976 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251976 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251976 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251976 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251976 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251976 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251976 , Out_Dummy15_g251976 , Out_PositionOS15_g251976 , Out_PositionWS15_g251976 , Out_PositionWO15_g251976 , Out_PositionRawOS15_g251976 , Out_PivotOS15_g251976 , Out_PivotWS15_g251976 , Out_PivotWO15_g251976 , Out_NormalOS15_g251976 , Out_NormalWS15_g251976 , Out_NormalRawOS15_g251976 , Out_TangentOS15_g251976 , Out_TangentWS15_g251976 , Out_BitangentWS15_g251976 , Out_ViewDirWS15_g251976 , Out_CoordsData15_g251976 , Out_VertexData15_g251976 , Out_MasksData15_g251976 , Out_PhaseData15_g251976 , Out_TransformData15_g251976 , Out_RotationData15_g251976 , Out_Interpolator15_g251976 );
					float3 In_PositionOS16_g251977 = ( Out_PositionOS15_g251975 - Out_PivotOS15_g251976 );
					float3 In_NormalOS16_g251977 = Out_NormalOS15_g251976;
					float4 In_TangentOS16_g251977 = Out_TangentOS15_g251976;
					float4 In_TransformData16_g251977 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251977 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251977 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251977 , In_Dummy16_g251977 , In_PositionOS16_g251977 , In_NormalOS16_g251977 , In_TangentOS16_g251977 , In_TransformData16_g251977 , In_RotationData16_g251977 , In_Interpolator16_g251977 );
					TVEVertexData Data15_g251986 =(TVEVertexData)Data16_g251977;
					float Out_Dummy15_g251986 = 0.0;
					float3 Out_PositionOS15_g251986 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251986 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251986 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251986 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251986 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251986 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251986 , Out_Dummy15_g251986 , Out_PositionOS15_g251986 , Out_NormalOS15_g251986 , Out_TangentOS15_g251986 , Out_TransformData15_g251986 , Out_RotationData15_g251986 , Out_Interpolator15_g251986 );
					TVEVertexData Data16_g251987 =(TVEVertexData)Data15_g251986;
					half Dummy317_g251978 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251987 = Dummy317_g251978;
					float3 In_PositionOS16_g251987 = Out_PositionOS15_g251986;
					float3 In_NormalOS16_g251987 = Out_NormalOS15_g251986;
					float4 In_TangentOS16_g251987 = Out_TangentOS15_g251986;
					half4 Model_TransformData356_g251978 = Out_TransformData15_g251986;
					float localBuildGlobalData204_g251364 = ( 0.0 );
					TVEGlobalData Data204_g251364 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251364 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251364 = Dummy211_g251364;
					float4 temp_output_203_0_g251383 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241424 =(TVEModelData)0;
					float In_Dummy16_g241424 = 0.0;
					float3 In_PositionWS16_g241424 = PositionWS122_g241416;
					float3 In_PositionWO16_g241424 = PositionWO132_g241416;
					float3 In_PivotWS16_g241424 = PivotWS121_g241416;
					float3 In_PivotWO16_g241424 = PivotWO133_g241416;
					float3 In_NormalWS16_g241424 = NormalWS95_g241416;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241416 = ase_tangentWS;
					float3 In_TangentWS16_g241424 = TangentWS136_g241416;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241416 = ase_bitangentWS;
					float3 In_BitangentWS16_g241424 = BiangentWS421_g241416;
					half3 NormalWS427_g241416 = NormalWS95_g241416;
					half3 localComputeTriplanarMasks427_g241416 = ComputeTriplanarMasks( NormalWS427_g241416 );
					half3 TriplanarWeights429_g241416 = localComputeTriplanarMasks427_g241416;
					float3 In_TriplanarWeights16_g241424 = TriplanarWeights429_g241416;
					float3 In_ViewDirWS16_g241424 = ViewDirWS169_g241416;
					float4 In_CoordsData16_g241424 = CoordsData398_g241416;
					float4 In_VertexData16_g241424 = VertexMasks171_g241416;
					float4 In_Interpolator16_g241424 = Phase_Data176_g241416;
					BuildModelFragData( Data16_g241424 , In_Dummy16_g241424 , In_PositionWS16_g241424 , In_PositionWO16_g241424 , In_PivotWS16_g241424 , In_PivotWO16_g241424 , In_NormalWS16_g241424 , In_TangentWS16_g241424 , In_BitangentWS16_g241424 , In_TriplanarWeights16_g241424 , In_ViewDirWS16_g241424 , In_CoordsData16_g241424 , In_VertexData16_g241424 , In_Interpolator16_g241424 );
					TVEModelData DataDefault26_g241395 = Data16_g241424;
					TVEModelData DataGeneral26_g241395 = Data16_g241424;
					TVEModelData DataBlanket26_g241395 = Data16_g241424;
					TVEModelData DataImpostor26_g241395 = Data16_g241424;
					TVEModelData Data16_g241404 =(TVEModelData)0;
					float In_Dummy16_g241404 = 0.0;
					float3 In_PositionWS16_g241404 = PositionWS122_g241396;
					float3 In_PositionWO16_g241404 = PositionWO132_g241396;
					float3 In_PivotWS16_g241404 = PivotWS121_g241396;
					float3 In_PivotWO16_g241404 = PivotWO133_g241396;
					float3 In_NormalWS16_g241404 = NormalWS95_g241396;
					half3 TangentWS136_g241396 = ase_tangentWS;
					float3 In_TangentWS16_g241404 = TangentWS136_g241396;
					half3 BiangentWS421_g241396 = ase_bitangentWS;
					float3 In_BitangentWS16_g241404 = BiangentWS421_g241396;
					half3 NormalWS427_g241396 = NormalWS95_g241396;
					half3 localComputeTriplanarMasks427_g241396 = ComputeTriplanarMasks( NormalWS427_g241396 );
					half3 TriplanarWeights429_g241396 = localComputeTriplanarMasks427_g241396;
					float3 In_TriplanarWeights16_g241404 = TriplanarWeights429_g241396;
					float3 In_ViewDirWS16_g241404 = ViewDirWS169_g241396;
					float4 In_CoordsData16_g241404 = CoordsData398_g241396;
					float4 In_VertexData16_g241404 = VertexMasks171_g241396;
					float4 In_Interpolator16_g241404 = Phase_Data176_g241396;
					BuildModelFragData( Data16_g241404 , In_Dummy16_g241404 , In_PositionWS16_g241404 , In_PositionWO16_g241404 , In_PivotWS16_g241404 , In_PivotWO16_g241404 , In_NormalWS16_g241404 , In_TangentWS16_g241404 , In_BitangentWS16_g241404 , In_TriplanarWeights16_g241404 , In_ViewDirWS16_g241404 , In_CoordsData16_g241404 , In_VertexData16_g241404 , In_Interpolator16_g241404 );
					TVEModelData DataTerrain26_g241395 = Data16_g241404;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251454 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251454 = 0.0;
					float3 Out_PositionWS15_g251454 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251454 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251454 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251454 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251454 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251454 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251454 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251454 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251454 , Out_Dummy15_g251454 , Out_PositionWS15_g251454 , Out_PositionWO15_g251454 , Out_PivotWS15_g251454 , Out_PivotWO15_g251454 , Out_NormalWS15_g251454 , Out_TangentWS15_g251454 , Out_BitangentWS15_g251454 , Out_TriplanarWeights15_g251454 , Out_ViewDirWS15_g251454 , Out_CoordsData15_g251454 , Out_VertexData15_g251454 , Out_Interpolator15_g251454 );
					float3 Model_PositionWS497_g251364 = Out_PositionWS15_g251454;
					float2 Model_PositionWS_XZ143_g251364 = (Model_PositionWS497_g251364).xz;
					float3 Model_PivotWS498_g251364 = Out_PivotWS15_g251454;
					float2 Model_PivotWS_XZ145_g251364 = (Model_PivotWS498_g251364).xz;
					float2 lerpResult300_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251383 = lerpResult300_g251364;
					float temp_output_82_0_g251381 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251383 = temp_output_82_0_g251381;
					float4 tex2DArrayNode83_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251383).zw + ( (temp_output_203_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult210_g251383 = (float4(tex2DArrayNode83_g251383.rgb , tex2DArrayNode83_g251383.a));
					float4 temp_output_204_0_g251383 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251383).zw + ( (temp_output_204_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult212_g251383 = (float4(tex2DArrayNode122_g251383.rgb , tex2DArrayNode122_g251383.a));
					float4 TVE_RenderNearPositionR628_g251364 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251364 = saturate( ( distance( Model_PositionWS497_g251364 , (TVE_RenderNearPositionR628_g251364).xyz ) / (TVE_RenderNearPositionR628_g251364).w ) );
					float temp_output_7_0_g251453 = 1.0;
					float temp_output_9_0_g251453 = ( temp_output_507_0_g251364 - temp_output_7_0_g251453 );
					half TVE_RenderNearFadeValue635_g251364 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251364 = saturate( ( temp_output_9_0_g251453 / ( ( TVE_RenderNearFadeValue635_g251364 - temp_output_7_0_g251453 ) + 0.0001 ) ) );
					float4 lerpResult131_g251383 = lerp( appendResult210_g251383 , appendResult212_g251383 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251381 = lerpResult131_g251383;
					float4 lerpResult168_g251381 = lerp( TVE_CoatParams , temp_output_159_109_g251381 , TVE_CoatLayers[(int)temp_output_82_0_g251381]);
					float4 temp_output_589_109_g251364 = lerpResult168_g251381;
					half4 Coat_Texture302_g251364 = temp_output_589_109_g251364;
					float4 In_CoatTexture204_g251364 = Coat_Texture302_g251364;
					half4 Draw_Texture656_g251364 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251364 = Draw_Texture656_g251364;
					float4 temp_output_203_0_g251408 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251408 = lerpResult85_g251364;
					float temp_output_82_0_g251405 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251408 = temp_output_82_0_g251405;
					float4 tex2DArrayNode83_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251408).zw + ( (temp_output_203_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult210_g251408 = (float4(tex2DArrayNode83_g251408.rgb , tex2DArrayNode83_g251408.a));
					float4 temp_output_204_0_g251408 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251408).zw + ( (temp_output_204_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult212_g251408 = (float4(tex2DArrayNode122_g251408.rgb , tex2DArrayNode122_g251408.a));
					float4 lerpResult131_g251408 = lerp( appendResult210_g251408 , appendResult212_g251408 , Global_TexBlend509_g251364);
					float4 temp_output_171_109_g251405 = lerpResult131_g251408;
					float4 lerpResult174_g251405 = lerp( TVE_PaintParams , temp_output_171_109_g251405 , TVE_PaintLayers[(int)temp_output_82_0_g251405]);
					float4 temp_output_595_109_g251364 = lerpResult174_g251405;
					half4 Paint_Texture71_g251364 = temp_output_595_109_g251364;
					float4 In_PaintTexture204_g251364 = Paint_Texture71_g251364;
					float4 temp_output_203_0_g251391 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251391 = lerpResult104_g251364;
					float temp_output_132_0_g251389 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251391 = temp_output_132_0_g251389;
					float4 tex2DArrayNode83_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251391).zw + ( (temp_output_203_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult210_g251391 = (float4(tex2DArrayNode83_g251391.rgb , tex2DArrayNode83_g251391.a));
					float4 temp_output_204_0_g251391 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251391).zw + ( (temp_output_204_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult212_g251391 = (float4(tex2DArrayNode122_g251391.rgb , tex2DArrayNode122_g251391.a));
					float4 lerpResult131_g251391 = lerp( appendResult210_g251391 , appendResult212_g251391 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251389 = lerpResult131_g251391;
					float4 lerpResult145_g251389 = lerp( TVE_AtmoParams , temp_output_137_109_g251389 , TVE_AtmoLayers[(int)temp_output_132_0_g251389]);
					float4 temp_output_590_110_g251364 = lerpResult145_g251389;
					half4 Atmo_Texture80_g251364 = temp_output_590_110_g251364;
					float4 In_AtmoTexture204_g251364 = Atmo_Texture80_g251364;
					float4 temp_output_203_0_g251459 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251459 = lerpResult414_g251364;
					float temp_output_132_0_g251457 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251459 = temp_output_132_0_g251457;
					float4 tex2DArrayNode83_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251459).zw + ( (temp_output_203_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult210_g251459 = (float4(tex2DArrayNode83_g251459.rgb , tex2DArrayNode83_g251459.a));
					float4 temp_output_204_0_g251459 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251459).zw + ( (temp_output_204_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult212_g251459 = (float4(tex2DArrayNode122_g251459.rgb , tex2DArrayNode122_g251459.a));
					float4 lerpResult131_g251459 = lerp( appendResult210_g251459 , appendResult212_g251459 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251457 = lerpResult131_g251459;
					float4 lerpResult145_g251457 = lerp( TVE_EffexParams , temp_output_137_109_g251457 , TVE_EffexLayers[(int)temp_output_132_0_g251457]);
					float4 temp_output_731_110_g251364 = lerpResult145_g251457;
					half4 Effex_Texture420_g251364 = temp_output_731_110_g251364;
					float4 In_EffexTexture204_g251364 = Effex_Texture420_g251364;
					float4 temp_output_203_0_g251439 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251439 = lerpResult247_g251364;
					float temp_output_82_0_g251437 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251439 = temp_output_82_0_g251437;
					float4 tex2DArrayNode83_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251439).zw + ( (temp_output_203_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult210_g251439 = (float4(tex2DArrayNode83_g251439.rgb , tex2DArrayNode83_g251439.a));
					float4 temp_output_204_0_g251439 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251439).zw + ( (temp_output_204_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult212_g251439 = (float4(tex2DArrayNode122_g251439.rgb , tex2DArrayNode122_g251439.a));
					float4 lerpResult131_g251439 = lerp( appendResult210_g251439 , appendResult212_g251439 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251437 = lerpResult131_g251439;
					float4 lerpResult167_g251437 = lerp( TVE_GlowParams , temp_output_159_109_g251437 , TVE_GlowLayers[(int)temp_output_82_0_g251437]);
					float4 temp_output_593_109_g251364 = lerpResult167_g251437;
					half4 Glow_Texture248_g251364 = temp_output_593_109_g251364;
					float4 In_GlowTexture204_g251364 = Glow_Texture248_g251364;
					float4 temp_output_203_0_g251375 = TVE_FormBaseCoord;
					float2 lerpResult168_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251375 = lerpResult168_g251364;
					float temp_output_130_0_g251373 = _GlobalFormLayerValue;
					float temp_output_82_0_g251375 = temp_output_130_0_g251373;
					float4 tex2DArrayNode83_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251375).zw + ( (temp_output_203_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult210_g251375 = (float4(tex2DArrayNode83_g251375.rgb , tex2DArrayNode83_g251375.a));
					float4 temp_output_204_0_g251375 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251375).zw + ( (temp_output_204_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult212_g251375 = (float4(tex2DArrayNode122_g251375.rgb , tex2DArrayNode122_g251375.a));
					float4 lerpResult131_g251375 = lerp( appendResult210_g251375 , appendResult212_g251375 , Global_TexBlend509_g251364);
					float4 temp_output_135_109_g251373 = lerpResult131_g251375;
					float4 lerpResult143_g251373 = lerp( TVE_FormParams , temp_output_135_109_g251373 , TVE_FormLayers[(int)temp_output_130_0_g251373]);
					float4 temp_output_592_0_g251364 = lerpResult143_g251373;
					float4 Form_Texture112_g251364 = temp_output_592_0_g251364;
					float4 In_FormTexture204_g251364 = Form_Texture112_g251364;
					float4 In_LandTexture204_g251364 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251423 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251423 = lerpResult681_g251364;
					float temp_output_136_0_g251421 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251423 = temp_output_136_0_g251421;
					float4 tex2DArrayNode83_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251423).zw + ( (temp_output_203_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult210_g251423 = (float4(tex2DArrayNode83_g251423.rgb , tex2DArrayNode83_g251423.a));
					float4 temp_output_204_0_g251423 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251423).zw + ( (temp_output_204_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult212_g251423 = (float4(tex2DArrayNode122_g251423.rgb , tex2DArrayNode122_g251423.a));
					float4 lerpResult131_g251423 = lerp( appendResult210_g251423 , appendResult212_g251423 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251421 = lerpResult131_g251423;
					float4 lerpResult149_g251421 = lerp( TVE_VertxParams , temp_output_141_109_g251421 , TVE_VertxLayers[(int)temp_output_136_0_g251421]);
					float4 temp_output_695_0_g251364 = lerpResult149_g251421;
					half4 Vertx_Texture693_g251364 = temp_output_695_0_g251364;
					float4 In_VertxTexture204_g251364 = Vertx_Texture693_g251364;
					float4 temp_output_203_0_g251399 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251399 = lerpResult400_g251364;
					float temp_output_136_0_g251397 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251399 = temp_output_136_0_g251397;
					float4 tex2DArrayNode83_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251399).zw + ( (temp_output_203_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult210_g251399 = (float4(tex2DArrayNode83_g251399.rgb , tex2DArrayNode83_g251399.a));
					float4 temp_output_204_0_g251399 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251399).zw + ( (temp_output_204_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult212_g251399 = (float4(tex2DArrayNode122_g251399.rgb , tex2DArrayNode122_g251399.a));
					float4 lerpResult131_g251399 = lerp( appendResult210_g251399 , appendResult212_g251399 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251397 = lerpResult131_g251399;
					float4 lerpResult149_g251397 = lerp( TVE_FlowParams , temp_output_141_109_g251397 , TVE_FlowLayers[(int)temp_output_136_0_g251397]);
					float4 temp_output_594_0_g251364 = lerpResult149_g251397;
					half4 Flow_Texture405_g251364 = temp_output_594_0_g251364;
					float4 In_FlowTexture204_g251364 = Flow_Texture405_g251364;
					half4 User_Texture677_g251364 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251364 = User_Texture677_g251364;
					BuildGlobalData( Data204_g251364 , In_Dummy204_g251364 , In_CoatTexture204_g251364 , In_DrawTexture204_g251364 , In_PaintTexture204_g251364 , In_AtmoTexture204_g251364 , In_EffexTexture204_g251364 , In_GlowTexture204_g251364 , In_FormTexture204_g251364 , In_LandTexture204_g251364 , In_VertxTexture204_g251364 , In_FlowTexture204_g251364 , In_UserTexture204_g251364 );
					TVEGlobalData Data15_g251988 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251988 = 0.0;
					float4 Out_CoatTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251988 = float4( 0,0,0,0 );
					BreakData( Data15_g251988 , Out_Dummy15_g251988 , Out_CoatTexture15_g251988 , Out_DrawTexture15_g251988 , Out_PaintTexture15_g251988 , Out_AtmoTexture15_g251988 , Out_EffexTexture15_g251988 , Out_GlowTexture15_g251988 , Out_FormTexture15_g251988 , Out_LandTexture15_g251988 , Out_VertxTexture15_g251988 , Out_FlowTexture15_g251988 , Out_UserTexture15_g251988 );
					float4 Global_FormTexture351_g251978 = Out_FormTexture15_g251988;
					TVEModelData Data15_g251985 =(TVEModelData)Data15_g251976;
					float Out_Dummy15_g251985 = 0.0;
					float3 Out_PositionOS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251985 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251985 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251985 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251985 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251985 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251985 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251985 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251985 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251985 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251985 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251985 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251985 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251985 , Out_Dummy15_g251985 , Out_PositionOS15_g251985 , Out_PositionWS15_g251985 , Out_PositionWO15_g251985 , Out_PositionRawOS15_g251985 , Out_PivotOS15_g251985 , Out_PivotWS15_g251985 , Out_PivotWO15_g251985 , Out_NormalOS15_g251985 , Out_NormalWS15_g251985 , Out_NormalRawOS15_g251985 , Out_TangentOS15_g251985 , Out_TangentWS15_g251985 , Out_BitangentWS15_g251985 , Out_ViewDirWS15_g251985 , Out_CoordsData15_g251985 , Out_VertexData15_g251985 , Out_MasksData15_g251985 , Out_PhaseData15_g251985 , Out_TransformData15_g251985 , Out_RotationData15_g251985 , Out_Interpolator15_g251985 );
					float3 Model_PivotWO353_g251978 = Out_PivotWO15_g251985;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251984 = _ConformMeshMode;
					float Option70_g251984 = temp_output_17_0_g251984;
					half4 Model_VertexData357_g251978 = Out_VertexData15_g251985;
					float4 temp_output_3_0_g251984 = Model_VertexData357_g251978;
					float4 Channel70_g251984 = temp_output_3_0_g251984;
					float localSwitchChannel470_g251984 = SwitchChannel4( Option70_g251984 , Channel70_g251984 );
					float temp_output_390_0_g251978 = localSwitchChannel470_g251984;
					float temp_output_7_0_g251981 = _ConformMeshRemap.x;
					float temp_output_9_0_g251981 = ( temp_output_390_0_g251978 - temp_output_7_0_g251981 );
					float lerpResult374_g251978 = lerp( 1.0 , saturate( ( temp_output_9_0_g251981 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251978 = lerpResult374_g251978;
					float temp_output_328_0_g251978 = ( Blend_VertMask379_g251978 * TVE_IsEnabled );
					half Conform_Mask366_g251978 = temp_output_328_0_g251978;
					float temp_output_322_0_g251978 = ( ( ( ( (Global_FormTexture351_g251978).z - ( (Model_PivotWO353_g251978).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251978 ) );
					float3 appendResult329_g251978 = (float3(0.0 , temp_output_322_0_g251978 , 0.0));
					float3 appendResult387_g251978 = (float3(0.0 , 0.0 , temp_output_322_0_g251978));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251982 = appendResult387_g251978;
					#else
					float3 staticSwitch65_g251982 = appendResult329_g251978;
					#endif
					float3 Blanket_Conform368_g251978 = staticSwitch65_g251982;
					float4 appendResult312_g251978 = (float4(Blanket_Conform368_g251978 , 0.0));
					float4 temp_output_310_0_g251978 = ( Model_TransformData356_g251978 + appendResult312_g251978 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251978 = temp_output_310_0_g251978;
					#else
					float4 staticSwitch364_g251978 = Model_TransformData356_g251978;
					#endif
					half4 Final_TransformData365_g251978 = staticSwitch364_g251978;
					float4 In_TransformData16_g251987 = Final_TransformData365_g251978;
					float4 In_RotationData16_g251987 = Out_RotationData15_g251986;
					float4 In_Interpolator16_g251987 = Out_Interpolator15_g251986;
					BuildVertexData( Data16_g251987 , In_Dummy16_g251987 , In_PositionOS16_g251987 , In_NormalOS16_g251987 , In_TangentOS16_g251987 , In_TransformData16_g251987 , In_RotationData16_g251987 , In_Interpolator16_g251987 );
					TVEVertexData Data15_g251998 =(TVEVertexData)Data16_g251987;
					float Out_Dummy15_g251998 = 0.0;
					float3 Out_PositionOS15_g251998 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251998 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251998 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251998 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251998 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251998 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251998 , Out_Dummy15_g251998 , Out_PositionOS15_g251998 , Out_NormalOS15_g251998 , Out_TangentOS15_g251998 , Out_TransformData15_g251998 , Out_RotationData15_g251998 , Out_Interpolator15_g251998 );
					TVEVertexData Data16_g251999 =(TVEVertexData)Data15_g251998;
					float In_Dummy16_g251999 = 0.0;
					float3 Vertex_PositionOS147_g251989 = Out_PositionOS15_g251998;
					half3 VertexPos40_g251993 = Vertex_PositionOS147_g251989;
					float4 temp_output_1615_33_g251989 = Out_RotationData15_g251998;
					half4 Vertex_RotationData1569_g251989 = temp_output_1615_33_g251989;
					float2 break1582_g251989 = (Vertex_RotationData1569_g251989).xy;
					half Angle44_g251993 = break1582_g251989.y;
					half CosAngle89_g251993 = cos( Angle44_g251993 );
					half SinAngle93_g251993 = sin( Angle44_g251993 );
					float3 appendResult95_g251993 = (float3((VertexPos40_g251993).x , ( ( (VertexPos40_g251993).y * CosAngle89_g251993 ) - ( (VertexPos40_g251993).z * SinAngle93_g251993 ) ) , ( ( (VertexPos40_g251993).y * SinAngle93_g251993 ) + ( (VertexPos40_g251993).z * CosAngle89_g251993 ) )));
					half3 VertexPos40_g251994 = appendResult95_g251993;
					half Angle44_g251994 = -break1582_g251989.x;
					half CosAngle94_g251994 = cos( Angle44_g251994 );
					half SinAngle95_g251994 = sin( Angle44_g251994 );
					float3 appendResult98_g251994 = (float3(( ( (VertexPos40_g251994).x * CosAngle94_g251994 ) - ( (VertexPos40_g251994).y * SinAngle95_g251994 ) ) , ( ( (VertexPos40_g251994).x * SinAngle95_g251994 ) + ( (VertexPos40_g251994).y * CosAngle94_g251994 ) ) , (VertexPos40_g251994).z));
					half3 VertexPos40_g251992 = Vertex_PositionOS147_g251989;
					half Angle44_g251992 = break1582_g251989.y;
					half CosAngle89_g251992 = cos( Angle44_g251992 );
					half SinAngle93_g251992 = sin( Angle44_g251992 );
					float3 appendResult95_g251992 = (float3((VertexPos40_g251992).x , ( ( (VertexPos40_g251992).y * CosAngle89_g251992 ) - ( (VertexPos40_g251992).z * SinAngle93_g251992 ) ) , ( ( (VertexPos40_g251992).y * SinAngle93_g251992 ) + ( (VertexPos40_g251992).z * CosAngle89_g251992 ) )));
					half3 VertexPos40_g251997 = appendResult95_g251992;
					half Angle44_g251997 = break1582_g251989.x;
					half CosAngle91_g251997 = cos( Angle44_g251997 );
					half SinAngle92_g251997 = sin( Angle44_g251997 );
					float3 appendResult93_g251997 = (float3(( ( (VertexPos40_g251997).x * CosAngle91_g251997 ) + ( (VertexPos40_g251997).z * SinAngle92_g251997 ) ) , (VertexPos40_g251997).y , ( ( -(VertexPos40_g251997).x * SinAngle92_g251997 ) + ( (VertexPos40_g251997).z * CosAngle91_g251997 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251995 = appendResult93_g251997;
					#else
					float3 staticSwitch65_g251995 = appendResult98_g251994;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251990 = staticSwitch65_g251995;
					#else
					float3 staticSwitch65_g251990 = Vertex_PositionOS147_g251989;
					#endif
					float3 temp_output_1608_0_g251989 = staticSwitch65_g251990;
					half3 VertexPos40_g251996 = temp_output_1608_0_g251989;
					half Angle44_g251996 = (Vertex_RotationData1569_g251989).z;
					half CosAngle91_g251996 = cos( Angle44_g251996 );
					half SinAngle92_g251996 = sin( Angle44_g251996 );
					float3 appendResult93_g251996 = (float3(( ( (VertexPos40_g251996).x * CosAngle91_g251996 ) + ( (VertexPos40_g251996).z * SinAngle92_g251996 ) ) , (VertexPos40_g251996).y , ( ( -(VertexPos40_g251996).x * SinAngle92_g251996 ) + ( (VertexPos40_g251996).z * CosAngle91_g251996 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251991 = appendResult93_g251996;
					#else
					float3 staticSwitch65_g251991 = temp_output_1608_0_g251989;
					#endif
					float4 temp_output_1615_31_g251989 = Out_TransformData15_g251998;
					half4 Vertex_TransformData1568_g251989 = temp_output_1615_31_g251989;
					half3 Final_PositionOS178_g251989 = ( ( staticSwitch65_g251991 * (Vertex_TransformData1568_g251989).w ) + (Vertex_TransformData1568_g251989).xyz );
					float3 In_PositionOS16_g251999 = Final_PositionOS178_g251989;
					float3 In_NormalOS16_g251999 = Out_NormalOS15_g251998;
					float4 In_TangentOS16_g251999 = Out_TangentOS15_g251998;
					float4 In_TransformData16_g251999 = temp_output_1615_31_g251989;
					float4 In_RotationData16_g251999 = temp_output_1615_33_g251989;
					float4 In_Interpolator16_g251999 = Out_Interpolator15_g251998;
					BuildVertexData( Data16_g251999 , In_Dummy16_g251999 , In_PositionOS16_g251999 , In_NormalOS16_g251999 , In_TangentOS16_g251999 , In_TransformData16_g251999 , In_RotationData16_g251999 , In_Interpolator16_g251999 );
					TVEVertexData Data15_g252002 =(TVEVertexData)Data16_g251999;
					float Out_Dummy15_g252002 = 0.0;
					float3 Out_PositionOS15_g252002 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252002 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252002 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252002 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252002 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252002 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252002 , Out_Dummy15_g252002 , Out_PositionOS15_g252002 , Out_NormalOS15_g252002 , Out_TangentOS15_g252002 , Out_TransformData15_g252002 , Out_RotationData15_g252002 , Out_Interpolator15_g252002 );
					TVEVertexData Data16_g252003 =(TVEVertexData)Data15_g252002;
					float In_Dummy16_g252003 = 0.0;
					TVEModelData Data15_g252001 =(TVEModelData)Data15_g251985;
					float Out_Dummy15_g252001 = 0.0;
					float3 Out_PositionOS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252001 , Out_Dummy15_g252001 , Out_PositionOS15_g252001 , Out_PositionWS15_g252001 , Out_PositionWO15_g252001 , Out_PositionRawOS15_g252001 , Out_PivotOS15_g252001 , Out_PivotWS15_g252001 , Out_PivotWO15_g252001 , Out_NormalOS15_g252001 , Out_NormalWS15_g252001 , Out_NormalRawOS15_g252001 , Out_TangentOS15_g252001 , Out_TangentWS15_g252001 , Out_BitangentWS15_g252001 , Out_ViewDirWS15_g252001 , Out_CoordsData15_g252001 , Out_VertexData15_g252001 , Out_MasksData15_g252001 , Out_PhaseData15_g252001 , Out_TransformData15_g252001 , Out_RotationData15_g252001 , Out_Interpolator15_g252001 );
					float3 In_PositionOS16_g252003 = ( Out_PositionOS15_g252002 + Out_PivotOS15_g252001 );
					float3 In_NormalOS16_g252003 = Out_NormalOS15_g252002;
					float4 In_TangentOS16_g252003 = Out_TangentOS15_g252002;
					float4 In_TransformData16_g252003 = Out_TransformData15_g252002;
					float4 In_RotationData16_g252003 = Out_RotationData15_g252002;
					float4 In_Interpolator16_g252003 = Out_Interpolator15_g252002;
					BuildVertexData( Data16_g252003 , In_Dummy16_g252003 , In_PositionOS16_g252003 , In_NormalOS16_g252003 , In_TangentOS16_g252003 , In_TransformData16_g252003 , In_RotationData16_g252003 , In_Interpolator16_g252003 );
					TVEVertexData Data15_g254769 =(TVEVertexData)Data16_g252003;
					float Out_Dummy15_g254769 = 0.0;
					float3 Out_PositionOS15_g254769 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254769 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254769 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254769 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254769 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254769 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254769 , Out_Dummy15_g254769 , Out_PositionOS15_g254769 , Out_NormalOS15_g254769 , Out_TangentOS15_g254769 , Out_TransformData15_g254769 , Out_RotationData15_g254769 , Out_Interpolator15_g254769 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g241416;
					o.ase_texcoord5.xyz = vertexToFrag76_g241416;
					TVEVertexData Data1902_g254247 = Data16_g252003;
					float4 Out_Interpolator1902_g254247 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g254247 = Data1902_g254247.Interpolator;
					}
					float4 vertexToFrag1901_g254247 = Out_Interpolator1902_g254247;
					o.ase_texcoord7 = vertexToFrag1901_g254247;
					float3 vertexPos57_g254761 = v.vertex.xyz;
					float4 ase_positionCS57_g254761 = UnityObjectToClipPos( vertexPos57_g254761 );
					o.ase_texcoord8 = ase_positionCS57_g254761;
					
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
					float3 vertexValue = Out_PositionOS15_g254769;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254769;
					v.tangent = Out_TangentOS15_g254769;

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

					float temp_output_2664_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2664_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2664_114).xxx;
					
					float3 color130_g254761 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g254761 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g254763 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g254762 = ( temp_cast_4 * ( 0.5 + appendResult128_g254763 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g254762 = (float4(ddx( FinalUV13_g254762 ) , ddy( FinalUV13_g254762 )));
					float4 UVDerivatives17_g254762 = appendResult16_g254762;
					float4 break28_g254762 = UVDerivatives17_g254762;
					float2 appendResult19_g254762 = (float2(break28_g254762.x , break28_g254762.z));
					float2 appendResult20_g254762 = (float2(break28_g254762.x , break28_g254762.z));
					float dotResult24_g254762 = dot( appendResult19_g254762 , appendResult20_g254762 );
					float2 appendResult21_g254762 = (float2(break28_g254762.y , break28_g254762.w));
					float2 appendResult22_g254762 = (float2(break28_g254762.y , break28_g254762.w));
					float dotResult23_g254762 = dot( appendResult21_g254762 , appendResult22_g254762 );
					float2 appendResult25_g254762 = (float2(dotResult24_g254762 , dotResult23_g254762));
					float2 derivativesLength29_g254762 = sqrt( appendResult25_g254762 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g254762 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g254762 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g254762 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g254762 = clampResult57_g254762;
					float2 break55_g254762 = derivativesLength29_g254762;
					float4 lerpResult73_g254762 = lerp( float4( color130_g254761 , 0.0 ) , float4( color81_g254761 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g254762.x * break71_g254762.y * sqrt( saturate( ( 1.1 - max( break55_g254762.x, break55_g254762.y ) ) ) ) ) ) ));
					float3 color107_g254756 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254756 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g254755 = ( 0.0 );
					float localBuildMasksData3_g254309 = ( 0.0 );
					TVEMasksData Data3_g254309 = (TVEMasksData)0;
					half Feature_Intensity1266_g254290 = _TerrainIntensityValue;
					float ifLocalVar18_g254307 = 0;
					if( Feature_Intensity1266_g254290 <= 0.0 )
					ifLocalVar18_g254307 = 0.0;
					else
					ifLocalVar18_g254307 = 1.0;
					float4 appendResult1267_g254290 = (float4(ifLocalVar18_g254307 , 0.0 , 0.0 , 0.0));
					float4 In_MaskA3_g254309 = appendResult1267_g254290;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254313) = _TerrainMaskTex;
					SamplerState Sampler276_g254313 = sampler_Linear_Repeat;
					float localBreakTextureData456_g254313 = ( 0.0 );
					float localBuildTextureData431_g254304 = ( 0.0 );
					TVEMasksData Data431_g254304 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g254304 = ( 0.0 );
					float4 temp_output_6_0_g254291 = _terrain_mask_coord_value;
					float4 temp_output_7_0_g254291 = ( _TerrainMaskSampleMode + _TerrainMaskCoordMode + _TerrainMaskCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g254291 = ( temp_output_6_0_g254291 + temp_output_7_0_g254291 );
					#else
					float4 staticSwitch14_g254291 = temp_output_6_0_g254291;
					#endif
					half4 Local_MaskCoords813_g254290 = staticSwitch14_g254291;
					float4 Coords444_g254304 = Local_MaskCoords813_g254290;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241424 =(TVEModelData)0;
					float In_Dummy16_g241424 = 0.0;
					float3 vertexToFrag73_g241416 = IN.ase_texcoord4.xyz;
					float3 PositionWS122_g241416 = vertexToFrag73_g241416;
					float3 In_PositionWS16_g241424 = PositionWS122_g241416;
					float3 vertexToFrag76_g241416 = IN.ase_texcoord5.xyz;
					float3 PivotWS121_g241416 = vertexToFrag76_g241416;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241416 = ( PositionWS122_g241416 - PivotWS121_g241416 );
					#else
					float3 staticSwitch204_g241416 = PositionWS122_g241416;
					#endif
					float3 PositionWO132_g241416 = ( staticSwitch204_g241416 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241424 = PositionWO132_g241416;
					float3 In_PivotWS16_g241424 = PivotWS121_g241416;
					float3 PivotWO133_g241416 = ( PivotWS121_g241416 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241424 = PivotWO133_g241416;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241416 = normalizedWorldNormal;
					float3 In_NormalWS16_g241424 = NormalWS95_g241416;
					half3 TangentWS136_g241416 = TangentWS;
					float3 In_TangentWS16_g241424 = TangentWS136_g241416;
					half3 BiangentWS421_g241416 = BitangentWS;
					float3 In_BitangentWS16_g241424 = BiangentWS421_g241416;
					half3 NormalWS427_g241416 = NormalWS95_g241416;
					half3 localComputeTriplanarMasks427_g241416 = ComputeTriplanarMasks( NormalWS427_g241416 );
					half3 TriplanarWeights429_g241416 = localComputeTriplanarMasks427_g241416;
					float3 In_TriplanarWeights16_g241424 = TriplanarWeights429_g241416;
					float3 normalizeResult296_g241416 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241416 ) );
					half3 ViewDirWS169_g241416 = normalizeResult296_g241416;
					float3 In_ViewDirWS16_g241424 = ViewDirWS169_g241416;
					float4 appendResult397_g241416 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g241416 = appendResult397_g241416;
					float4 In_CoordsData16_g241424 = CoordsData398_g241416;
					half4 VertexMasks171_g241416 = IN.ase_color;
					float4 In_VertexData16_g241424 = VertexMasks171_g241416;
					float temp_output_17_0_g241427 = _ObjectPhaseMode;
					float Option70_g241427 = temp_output_17_0_g241427;
					float4 temp_output_3_0_g241427 = IN.ase_color;
					float4 Channel70_g241427 = temp_output_3_0_g241427;
					float localSwitchChannel470_g241427 = SwitchChannel4( Option70_g241427 , Channel70_g241427 );
					half Phase_Value372_g241416 = localSwitchChannel470_g241427;
					float3 break319_g241416 = PivotWO133_g241416;
					half Pivot_Position322_g241416 = ( break319_g241416.x + break319_g241416.z );
					half Phase_Position357_g241416 = ( Phase_Value372_g241416 + Pivot_Position322_g241416 );
					float temp_output_248_0_g241416 = frac( Phase_Position357_g241416 );
					float4 appendResult177_g241416 = (float4((frac( ( Phase_Position357_g241416 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241416));
					half4 Phase_Data176_g241416 = appendResult177_g241416;
					float4 In_Interpolator16_g241424 = Phase_Data176_g241416;
					BuildModelFragData( Data16_g241424 , In_Dummy16_g241424 , In_PositionWS16_g241424 , In_PositionWO16_g241424 , In_PivotWS16_g241424 , In_PivotWO16_g241424 , In_NormalWS16_g241424 , In_TangentWS16_g241424 , In_BitangentWS16_g241424 , In_TriplanarWeights16_g241424 , In_ViewDirWS16_g241424 , In_CoordsData16_g241424 , In_VertexData16_g241424 , In_Interpolator16_g241424 );
					TVEModelData DataDefault26_g241395 = Data16_g241424;
					TVEModelData DataGeneral26_g241395 = Data16_g241424;
					TVEModelData DataBlanket26_g241395 = Data16_g241424;
					TVEModelData DataImpostor26_g241395 = Data16_g241424;
					TVEModelData Data16_g241404 =(TVEModelData)0;
					float In_Dummy16_g241404 = 0.0;
					float3 temp_output_104_7_g241396 = PositionWS;
					float3 PositionWS122_g241396 = temp_output_104_7_g241396;
					float3 In_PositionWS16_g241404 = PositionWS122_g241396;
					float4x4 break19_g241399 = unity_ObjectToWorld;
					float3 appendResult20_g241399 = (float3(break19_g241399[ 0 ][ 3 ] , break19_g241399[ 1 ][ 3 ] , break19_g241399[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241396 = appendResult20_g241399;
					float3 PivotWS121_g241396 = temp_output_340_7_g241396;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241396 = ( PositionWS122_g241396 - PivotWS121_g241396 );
					#else
					float3 staticSwitch204_g241396 = PositionWS122_g241396;
					#endif
					float3 PositionWO132_g241396 = ( staticSwitch204_g241396 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241404 = PositionWO132_g241396;
					float3 In_PivotWS16_g241404 = PivotWS121_g241396;
					float3 PivotWO133_g241396 = ( PivotWS121_g241396 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241404 = PivotWO133_g241396;
					half3 NormalWS95_g241396 = normalizedWorldNormal;
					float3 In_NormalWS16_g241404 = NormalWS95_g241396;
					half3 TangentWS136_g241396 = TangentWS;
					float3 In_TangentWS16_g241404 = TangentWS136_g241396;
					half3 BiangentWS421_g241396 = BitangentWS;
					float3 In_BitangentWS16_g241404 = BiangentWS421_g241396;
					half3 NormalWS427_g241396 = NormalWS95_g241396;
					half3 localComputeTriplanarMasks427_g241396 = ComputeTriplanarMasks( NormalWS427_g241396 );
					half3 TriplanarWeights429_g241396 = localComputeTriplanarMasks427_g241396;
					float3 In_TriplanarWeights16_g241404 = TriplanarWeights429_g241396;
					float3 normalizeResult296_g241396 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241396 ) );
					half3 ViewDirWS169_g241396 = normalizeResult296_g241396;
					float3 In_ViewDirWS16_g241404 = ViewDirWS169_g241396;
					float4 appendResult397_g241396 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g241396 = appendResult397_g241396;
					float4 In_CoordsData16_g241404 = CoordsData398_g241396;
					half4 VertexMasks171_g241396 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241404 = VertexMasks171_g241396;
					half4 Phase_Data176_g241396 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g241404 = Phase_Data176_g241396;
					BuildModelFragData( Data16_g241404 , In_Dummy16_g241404 , In_PositionWS16_g241404 , In_PositionWO16_g241404 , In_PivotWS16_g241404 , In_PivotWO16_g241404 , In_NormalWS16_g241404 , In_TangentWS16_g241404 , In_BitangentWS16_g241404 , In_TriplanarWeights16_g241404 , In_ViewDirWS16_g241404 , In_CoordsData16_g241404 , In_VertexData16_g241404 , In_Interpolator16_g241404 );
					TVEModelData DataTerrain26_g241395 = Data16_g241404;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g254725 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g254725 = 0.0;
					float3 Out_PositionWS15_g254725 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254725 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254725 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254725 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254725 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254725 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254725 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254725 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254725 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254725 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254725 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254725 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254725 , Out_Dummy15_g254725 , Out_PositionWS15_g254725 , Out_PositionWO15_g254725 , Out_PivotWS15_g254725 , Out_PivotWO15_g254725 , Out_NormalWS15_g254725 , Out_TangentWS15_g254725 , Out_BitangentWS15_g254725 , Out_TriplanarWeights15_g254725 , Out_ViewDirWS15_g254725 , Out_CoordsData15_g254725 , Out_VertexData15_g254725 , Out_Interpolator15_g254725 );
					float4 Model_CoordsData1199_g254290 = Out_CoordsData15_g254725;
					float4 MeshCoords444_g254304 = Model_CoordsData1199_g254290;
					float2 UV0444_g254304 = float2( 0,0 );
					float2 UV3444_g254304 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g254304 , MeshCoords444_g254304 , UV0444_g254304 , UV3444_g254304 );
					float4 appendResult430_g254304 = (float4(UV0444_g254304 , UV3444_g254304));
					float4 In_MaskA431_g254304 = appendResult430_g254304;
					float localComputeWorldCoords315_g254304 = ( 0.0 );
					float4 Coords315_g254304 = Local_MaskCoords813_g254290;
					float3 Model_PositionWO636_g254290 = Out_PositionWO15_g254725;
					float3 PositionWS315_g254304 = Model_PositionWO636_g254290;
					float2 ZY315_g254304 = float2( 0,0 );
					float2 XZ315_g254304 = float2( 0,0 );
					float2 XY315_g254304 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g254304 , PositionWS315_g254304 , ZY315_g254304 , XZ315_g254304 , XY315_g254304 );
					float2 ZY402_g254304 = ZY315_g254304;
					float2 XZ403_g254304 = XZ315_g254304;
					float4 appendResult432_g254304 = (float4(ZY402_g254304 , XZ403_g254304));
					float4 In_MaskB431_g254304 = appendResult432_g254304;
					float2 XY404_g254304 = XY315_g254304;
					float localComputeStochasticCoords409_g254304 = ( 0.0 );
					float2 UV409_g254304 = ZY402_g254304;
					float2 UV1409_g254304 = float2( 0,0 );
					float2 UV2409_g254304 = float2( 0,0 );
					float2 UV3409_g254304 = float2( 0,0 );
					float3 Weights409_g254304 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g254304 , UV1409_g254304 , UV2409_g254304 , UV3409_g254304 , Weights409_g254304 );
					float4 appendResult433_g254304 = (float4(XY404_g254304 , UV1409_g254304));
					float4 In_MaskC431_g254304 = appendResult433_g254304;
					float4 appendResult434_g254304 = (float4(UV2409_g254304 , UV3409_g254304));
					float4 In_MaskD431_g254304 = appendResult434_g254304;
					float localComputeStochasticCoords422_g254304 = ( 0.0 );
					float2 UV422_g254304 = XZ403_g254304;
					float2 UV1422_g254304 = float2( 0,0 );
					float2 UV2422_g254304 = float2( 0,0 );
					float2 UV3422_g254304 = float2( 0,0 );
					float3 Weights422_g254304 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g254304 , UV1422_g254304 , UV2422_g254304 , UV3422_g254304 , Weights422_g254304 );
					float4 appendResult435_g254304 = (float4(UV1422_g254304 , UV2422_g254304));
					float4 In_MaskE431_g254304 = appendResult435_g254304;
					float localComputeStochasticCoords423_g254304 = ( 0.0 );
					float2 UV423_g254304 = XY404_g254304;
					float2 UV1423_g254304 = float2( 0,0 );
					float2 UV2423_g254304 = float2( 0,0 );
					float2 UV3423_g254304 = float2( 0,0 );
					float3 Weights423_g254304 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g254304 , UV1423_g254304 , UV2423_g254304 , UV3423_g254304 , Weights423_g254304 );
					float4 appendResult436_g254304 = (float4(UV3422_g254304 , UV1423_g254304));
					float4 In_MaskF431_g254304 = appendResult436_g254304;
					float4 appendResult437_g254304 = (float4(UV2423_g254304 , UV3423_g254304));
					float4 In_MaskG431_g254304 = appendResult437_g254304;
					float4 In_MaskH431_g254304 = float4( Weights409_g254304 , 0.0 );
					float4 In_MaskI431_g254304 = float4( Weights422_g254304 , 0.0 );
					float4 In_MaskJ431_g254304 = float4( Weights423_g254304 , 0.0 );
					half3 Model_NormalWS869_g254290 = Out_NormalWS15_g254725;
					float3 temp_output_449_0_g254304 = Model_NormalWS869_g254290;
					float4 In_MaskK431_g254304 = float4( temp_output_449_0_g254304 , 0.0 );
					half3 Model_TangentWS1294_g254290 = Out_TangentWS15_g254725;
					float3 temp_output_450_0_g254304 = Model_TangentWS1294_g254290;
					float4 In_MaskL431_g254304 = float4( temp_output_450_0_g254304 , 0.0 );
					half3 Model_BitangentWS1295_g254290 = Out_BitangentWS15_g254725;
					float3 temp_output_451_0_g254304 = Model_BitangentWS1295_g254290;
					float4 In_MaskM431_g254304 = float4( temp_output_451_0_g254304 , 0.0 );
					half3 Model_TriplanarWeights1296_g254290 = Out_TriplanarWeights15_g254725;
					float3 temp_output_445_0_g254304 = Model_TriplanarWeights1296_g254290;
					float4 In_MaskN431_g254304 = float4( temp_output_445_0_g254304 , 0.0 );
					BuildTextureData( Data431_g254304 , In_MaskA431_g254304 , In_MaskB431_g254304 , In_MaskC431_g254304 , In_MaskD431_g254304 , In_MaskE431_g254304 , In_MaskF431_g254304 , In_MaskG431_g254304 , In_MaskH431_g254304 , In_MaskI431_g254304 , In_MaskJ431_g254304 , In_MaskK431_g254304 , In_MaskL431_g254304 , In_MaskM431_g254304 , In_MaskN431_g254304 );
					TVEMasksData Data456_g254313 =(TVEMasksData)Data431_g254304;
					float4 Out_MaskA456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254313 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254313 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254313 , Out_MaskA456_g254313 , Out_MaskB456_g254313 , Out_MaskC456_g254313 , Out_MaskD456_g254313 , Out_MaskE456_g254313 , Out_MaskF456_g254313 , Out_MaskG456_g254313 , Out_MaskH456_g254313 , Out_MaskI456_g254313 , Out_MaskJ456_g254313 , Out_MaskK456_g254313 , Out_MaskL456_g254313 , Out_MaskM456_g254313 , Out_MaskN456_g254313 );
					half2 UV276_g254313 = (Out_MaskA456_g254313).xy;
					float temp_output_504_0_g254313 = 0.0;
					half Bias276_g254313 = temp_output_504_0_g254313;
					half2 Normal276_g254313 = float2( 0,0 );
					half4 localSampleCoord276_g254313 = SampleCoord( Texture276_g254313 , Sampler276_g254313 , UV276_g254313 , Bias276_g254313 , Normal276_g254313 );
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254313) = _TerrainMaskTex;
					SamplerState Sampler502_g254313 = sampler_Linear_Repeat;
					half2 UV502_g254313 = (Out_MaskA456_g254313).zw;
					half Bias502_g254313 = temp_output_504_0_g254313;
					half2 Normal502_g254313 = float2( 0,0 );
					half4 localSampleCoord502_g254313 = SampleCoord( Texture502_g254313 , Sampler502_g254313 , UV502_g254313 , Bias502_g254313 , Normal502_g254313 );
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254313) = _TerrainMaskTex;
					SamplerState Sampler496_g254313 = sampler_Linear_Repeat;
					float2 temp_output_463_0_g254313 = (Out_MaskB456_g254313).zw;
					half2 XZ496_g254313 = temp_output_463_0_g254313;
					half Bias496_g254313 = temp_output_504_0_g254313;
					half3 NormalWS512_g254313 = (Out_MaskK456_g254313).xyz;
					half3 NormalWS496_g254313 = NormalWS512_g254313;
					half3 Normal496_g254313 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254313 = SamplePlanar2D( Texture496_g254313 , Sampler496_g254313 , XZ496_g254313 , Bias496_g254313 , NormalWS496_g254313 , Normal496_g254313 );
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254313) = _TerrainMaskTex;
					SamplerState Sampler490_g254313 = sampler_Linear_Repeat;
					float2 temp_output_462_0_g254313 = (Out_MaskB456_g254313).xy;
					half2 ZY490_g254313 = temp_output_462_0_g254313;
					half2 XZ490_g254313 = temp_output_463_0_g254313;
					float2 temp_output_464_0_g254313 = (Out_MaskC456_g254313).xy;
					half2 XY490_g254313 = temp_output_464_0_g254313;
					half Bias490_g254313 = temp_output_504_0_g254313;
					half3 Triplanar522_g254313 = (Out_MaskN456_g254313).xyz;
					half3 Triplanar490_g254313 = Triplanar522_g254313;
					half3 NormalWS490_g254313 = NormalWS512_g254313;
					half3 Normal490_g254313 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254313 = SamplePlanar3D( Texture490_g254313 , Sampler490_g254313 , ZY490_g254313 , XZ490_g254313 , XY490_g254313 , Bias490_g254313 , Triplanar490_g254313 , NormalWS490_g254313 , Normal490_g254313 );
					#if defined( TVE_TERRAIN_MASK_SAMPLE_MAIN_UV )
					float4 staticSwitch817_g254290 = localSampleCoord276_g254313;
					#elif defined( TVE_TERRAIN_MASK_SAMPLE_EXTRA_UV )
					float4 staticSwitch817_g254290 = localSampleCoord502_g254313;
					#elif defined( TVE_TERRAIN_MASK_SAMPLE_PLANAR_2D )
					float4 staticSwitch817_g254290 = localSamplePlanar2D496_g254313;
					#elif defined( TVE_TERRAIN_MASK_SAMPLE_PLANAR_3D )
					float4 staticSwitch817_g254290 = localSamplePlanar3D490_g254313;
					#else
					float4 staticSwitch817_g254290 = localSampleCoord276_g254313;
					#endif
					half4 Local_MaskTex861_g254290 = staticSwitch817_g254290;
					float temp_output_887_0_g254290 = (Local_MaskTex861_g254290).x;
					float temp_output_7_0_g254295 = _TerrainMaskRemap.x;
					float temp_output_9_0_g254295 = ( temp_output_887_0_g254290 - temp_output_7_0_g254295 );
					float lerpResult1108_g254290 = lerp( 1.0 , saturate( ( temp_output_9_0_g254295 * _TerrainMaskRemap.z ) ) , _TerrainMaskValue);
					half Detail_TexMask429_g254290 = lerpResult1108_g254290;
					float localBreakVisualData4_g254299 = ( 0.0 );
					float localBuildVisualData3_g254253 = ( 0.0 );
					float localBuildVisualData3_g254248 = ( 0.0 );
					TVEVisualData Data3_g254248 =(TVEVisualData)0;
					float temp_output_14_0_g254248 = 0.0;
					float In_Dummy3_g254248 = temp_output_14_0_g254248;
					float3 temp_cast_18 = (0.5).xxx;
					float3 temp_output_4_0_g254248 = temp_cast_18;
					float3 In_Albedo3_g254248 = temp_output_4_0_g254248;
					float3 temp_cast_19 = (0.5).xxx;
					float3 temp_output_44_0_g254248 = temp_cast_19;
					float3 In_AlbedoBase3_g254248 = temp_output_44_0_g254248;
					float2 temp_cast_20 = (0.0).xx;
					float2 In_NormalTS3_g254248 = temp_cast_20;
					float3 temp_cast_21 = (0.5).xxx;
					float3 In_NormalWS3_g254248 = temp_cast_21;
					float4 In_Shader3_g254248 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g254248 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g254248 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g254248 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g254248 = 0.5;
					float In_Grayscale3_g254248 = temp_output_12_0_g254248;
					float temp_output_16_0_g254248 = 1.0;
					float In_Luminosity3_g254248 = temp_output_16_0_g254248;
					float In_MultiMask3_g254248 = 1.0;
					float In_AlphaClip3_g254248 = 1.0;
					float In_AlphaFade3_g254248 = 1.0;
					float3 temp_cast_22 = (1.0).xxx;
					float3 In_Translucency3_g254248 = temp_cast_22;
					float In_Transmission3_g254248 = 1.0;
					float In_Thickness3_g254248 = 0.0;
					float In_Diffusion3_g254248 = 0.0;
					float In_Depth3_g254248 = 0.0;
					BuildVisualData( Data3_g254248 , In_Dummy3_g254248 , In_Albedo3_g254248 , In_AlbedoBase3_g254248 , In_NormalTS3_g254248 , In_NormalWS3_g254248 , In_Shader3_g254248 , In_Feature3_g254248 , In_Season3_g254248 , In_Emissive3_g254248 , In_Grayscale3_g254248 , In_Luminosity3_g254248 , In_MultiMask3_g254248 , In_AlphaClip3_g254248 , In_AlphaFade3_g254248 , In_Translucency3_g254248 , In_Transmission3_g254248 , In_Thickness3_g254248 , In_Diffusion3_g254248 , In_Depth3_g254248 );
					TVEVisualData Data3_g254253 =(TVEVisualData)Data3_g254248;
					half Dummy130_g254251 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g254253 = Dummy130_g254251;
					float In_Dummy3_g254253 = temp_output_14_0_g254253;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254274) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g254256 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g254256 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g254274 = staticSwitch36_g254256;
					float localBreakTextureData456_g254274 = ( 0.0 );
					float localBuildTextureData431_g254273 = ( 0.0 );
					TVEMasksData Data431_g254273 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g254273 = ( 0.0 );
					float4 temp_output_6_0_g254289 = _main_coord_value;
					float4 temp_output_7_0_g254289 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g254289 = ( temp_output_6_0_g254289 + temp_output_7_0_g254289 );
					#else
					float4 staticSwitch14_g254289 = temp_output_6_0_g254289;
					#endif
					half4 Local_Coords180_g254251 = staticSwitch14_g254289;
					float4 Coords444_g254273 = Local_Coords180_g254251;
					TVEModelData Data15_g254249 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g254249 = 0.0;
					float3 Out_PositionWS15_g254249 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254249 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254249 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254249 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254249 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254249 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254249 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254249 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254249 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254249 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254249 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254249 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254249 , Out_Dummy15_g254249 , Out_PositionWS15_g254249 , Out_PositionWO15_g254249 , Out_PivotWS15_g254249 , Out_PivotWO15_g254249 , Out_NormalWS15_g254249 , Out_TangentWS15_g254249 , Out_BitangentWS15_g254249 , Out_TriplanarWeights15_g254249 , Out_ViewDirWS15_g254249 , Out_CoordsData15_g254249 , Out_VertexData15_g254249 , Out_Interpolator15_g254249 );
					TVEModelData Data16_g254250 =(TVEModelData)Data15_g254249;
					float In_Dummy16_g254250 = Out_Dummy15_g254249;
					float3 In_PositionWS16_g254250 = Out_PositionWS15_g254249;
					float3 In_PositionWO16_g254250 = Out_PositionWO15_g254249;
					float3 In_PivotWS16_g254250 = Out_PivotWS15_g254249;
					float3 In_PivotWO16_g254250 = Out_PivotWO15_g254249;
					float3 In_NormalWS16_g254250 = Out_NormalWS15_g254249;
					float3 In_TangentWS16_g254250 = Out_TangentWS15_g254249;
					float3 In_BitangentWS16_g254250 = Out_BitangentWS15_g254249;
					float3 In_TriplanarWeights16_g254250 = Out_TriplanarWeights15_g254249;
					float3 In_ViewDirWS16_g254250 = Out_ViewDirWS15_g254249;
					float4 In_CoordsData16_g254250 = Out_CoordsData15_g254249;
					float4 In_VertexData16_g254250 = Out_VertexData15_g254249;
					float4 vertexToFrag1901_g254247 = IN.ase_texcoord7;
					float4 In_Interpolator16_g254250 = vertexToFrag1901_g254247;
					BuildModelFragData( Data16_g254250 , In_Dummy16_g254250 , In_PositionWS16_g254250 , In_PositionWO16_g254250 , In_PivotWS16_g254250 , In_PivotWO16_g254250 , In_NormalWS16_g254250 , In_TangentWS16_g254250 , In_BitangentWS16_g254250 , In_TriplanarWeights16_g254250 , In_ViewDirWS16_g254250 , In_CoordsData16_g254250 , In_VertexData16_g254250 , In_Interpolator16_g254250 );
					TVEModelData Data15_g254252 =(TVEModelData)Data16_g254250;
					float Out_Dummy15_g254252 = 0.0;
					float3 Out_PositionWS15_g254252 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254252 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254252 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254252 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254252 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254252 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254252 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254252 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254252 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254252 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254252 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254252 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254252 , Out_Dummy15_g254252 , Out_PositionWS15_g254252 , Out_PositionWO15_g254252 , Out_PivotWS15_g254252 , Out_PivotWO15_g254252 , Out_NormalWS15_g254252 , Out_TangentWS15_g254252 , Out_BitangentWS15_g254252 , Out_TriplanarWeights15_g254252 , Out_ViewDirWS15_g254252 , Out_CoordsData15_g254252 , Out_VertexData15_g254252 , Out_Interpolator15_g254252 );
					float4 Model_CoordsData324_g254251 = Out_CoordsData15_g254252;
					float4 MeshCoords444_g254273 = Model_CoordsData324_g254251;
					float2 UV0444_g254273 = float2( 0,0 );
					float2 UV3444_g254273 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g254273 , MeshCoords444_g254273 , UV0444_g254273 , UV3444_g254273 );
					float4 appendResult430_g254273 = (float4(UV0444_g254273 , UV3444_g254273));
					float4 In_MaskA431_g254273 = appendResult430_g254273;
					float localComputeWorldCoords315_g254273 = ( 0.0 );
					float4 Coords315_g254273 = Local_Coords180_g254251;
					float3 Model_PositionWO222_g254251 = Out_PositionWO15_g254252;
					float3 PositionWS315_g254273 = Model_PositionWO222_g254251;
					float2 ZY315_g254273 = float2( 0,0 );
					float2 XZ315_g254273 = float2( 0,0 );
					float2 XY315_g254273 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g254273 , PositionWS315_g254273 , ZY315_g254273 , XZ315_g254273 , XY315_g254273 );
					float2 ZY402_g254273 = ZY315_g254273;
					float2 XZ403_g254273 = XZ315_g254273;
					float4 appendResult432_g254273 = (float4(ZY402_g254273 , XZ403_g254273));
					float4 In_MaskB431_g254273 = appendResult432_g254273;
					float2 XY404_g254273 = XY315_g254273;
					float localComputeStochasticCoords409_g254273 = ( 0.0 );
					float2 UV409_g254273 = ZY402_g254273;
					float2 UV1409_g254273 = float2( 0,0 );
					float2 UV2409_g254273 = float2( 0,0 );
					float2 UV3409_g254273 = float2( 0,0 );
					float3 Weights409_g254273 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g254273 , UV1409_g254273 , UV2409_g254273 , UV3409_g254273 , Weights409_g254273 );
					float4 appendResult433_g254273 = (float4(XY404_g254273 , UV1409_g254273));
					float4 In_MaskC431_g254273 = appendResult433_g254273;
					float4 appendResult434_g254273 = (float4(UV2409_g254273 , UV3409_g254273));
					float4 In_MaskD431_g254273 = appendResult434_g254273;
					float localComputeStochasticCoords422_g254273 = ( 0.0 );
					float2 UV422_g254273 = XZ403_g254273;
					float2 UV1422_g254273 = float2( 0,0 );
					float2 UV2422_g254273 = float2( 0,0 );
					float2 UV3422_g254273 = float2( 0,0 );
					float3 Weights422_g254273 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g254273 , UV1422_g254273 , UV2422_g254273 , UV3422_g254273 , Weights422_g254273 );
					float4 appendResult435_g254273 = (float4(UV1422_g254273 , UV2422_g254273));
					float4 In_MaskE431_g254273 = appendResult435_g254273;
					float localComputeStochasticCoords423_g254273 = ( 0.0 );
					float2 UV423_g254273 = XY404_g254273;
					float2 UV1423_g254273 = float2( 0,0 );
					float2 UV2423_g254273 = float2( 0,0 );
					float2 UV3423_g254273 = float2( 0,0 );
					float3 Weights423_g254273 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g254273 , UV1423_g254273 , UV2423_g254273 , UV3423_g254273 , Weights423_g254273 );
					float4 appendResult436_g254273 = (float4(UV3422_g254273 , UV1423_g254273));
					float4 In_MaskF431_g254273 = appendResult436_g254273;
					float4 appendResult437_g254273 = (float4(UV2423_g254273 , UV3423_g254273));
					float4 In_MaskG431_g254273 = appendResult437_g254273;
					float4 In_MaskH431_g254273 = float4( Weights409_g254273 , 0.0 );
					float4 In_MaskI431_g254273 = float4( Weights422_g254273 , 0.0 );
					float4 In_MaskJ431_g254273 = float4( Weights423_g254273 , 0.0 );
					half3 Model_NormalWS226_g254251 = Out_NormalWS15_g254252;
					float3 temp_output_449_0_g254273 = Model_NormalWS226_g254251;
					float4 In_MaskK431_g254273 = float4( temp_output_449_0_g254273 , 0.0 );
					half3 Model_TangentWS366_g254251 = Out_TangentWS15_g254252;
					float3 temp_output_450_0_g254273 = Model_TangentWS366_g254251;
					float4 In_MaskL431_g254273 = float4( temp_output_450_0_g254273 , 0.0 );
					half3 Model_BitangentWS367_g254251 = Out_BitangentWS15_g254252;
					float3 temp_output_451_0_g254273 = Model_BitangentWS367_g254251;
					float4 In_MaskM431_g254273 = float4( temp_output_451_0_g254273 , 0.0 );
					half3 Model_TriplanarWeights368_g254251 = Out_TriplanarWeights15_g254252;
					float3 temp_output_445_0_g254273 = Model_TriplanarWeights368_g254251;
					float4 In_MaskN431_g254273 = float4( temp_output_445_0_g254273 , 0.0 );
					BuildTextureData( Data431_g254273 , In_MaskA431_g254273 , In_MaskB431_g254273 , In_MaskC431_g254273 , In_MaskD431_g254273 , In_MaskE431_g254273 , In_MaskF431_g254273 , In_MaskG431_g254273 , In_MaskH431_g254273 , In_MaskI431_g254273 , In_MaskJ431_g254273 , In_MaskK431_g254273 , In_MaskL431_g254273 , In_MaskM431_g254273 , In_MaskN431_g254273 );
					TVEMasksData Data456_g254274 =(TVEMasksData)Data431_g254273;
					float4 Out_MaskA456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254274 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254274 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254274 , Out_MaskA456_g254274 , Out_MaskB456_g254274 , Out_MaskC456_g254274 , Out_MaskD456_g254274 , Out_MaskE456_g254274 , Out_MaskF456_g254274 , Out_MaskG456_g254274 , Out_MaskH456_g254274 , Out_MaskI456_g254274 , Out_MaskJ456_g254274 , Out_MaskK456_g254274 , Out_MaskL456_g254274 , Out_MaskM456_g254274 , Out_MaskN456_g254274 );
					half2 UV276_g254274 = (Out_MaskA456_g254274).xy;
					float temp_output_504_0_g254274 = 0.0;
					half Bias276_g254274 = temp_output_504_0_g254274;
					half2 Normal276_g254274 = float2( 0,0 );
					half4 localSampleCoord276_g254274 = SampleCoord( Texture276_g254274 , Sampler276_g254274 , UV276_g254274 , Bias276_g254274 , Normal276_g254274 );
					float4 temp_output_407_277_g254251 = localSampleCoord276_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254274) = _MainAlbedoTex;
					SamplerState Sampler502_g254274 = staticSwitch36_g254256;
					half2 UV502_g254274 = (Out_MaskA456_g254274).zw;
					half Bias502_g254274 = temp_output_504_0_g254274;
					half2 Normal502_g254274 = float2( 0,0 );
					half4 localSampleCoord502_g254274 = SampleCoord( Texture502_g254274 , Sampler502_g254274 , UV502_g254274 , Bias502_g254274 , Normal502_g254274 );
					float4 temp_output_407_278_g254251 = localSampleCoord502_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254274) = _MainAlbedoTex;
					SamplerState Sampler496_g254274 = staticSwitch36_g254256;
					float2 temp_output_463_0_g254274 = (Out_MaskB456_g254274).zw;
					half2 XZ496_g254274 = temp_output_463_0_g254274;
					half Bias496_g254274 = temp_output_504_0_g254274;
					half3 NormalWS512_g254274 = (Out_MaskK456_g254274).xyz;
					half3 NormalWS496_g254274 = NormalWS512_g254274;
					half3 Normal496_g254274 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254274 = SamplePlanar2D( Texture496_g254274 , Sampler496_g254274 , XZ496_g254274 , Bias496_g254274 , NormalWS496_g254274 , Normal496_g254274 );
					float4 temp_output_407_0_g254251 = localSamplePlanar2D496_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254274) = _MainAlbedoTex;
					SamplerState Sampler490_g254274 = staticSwitch36_g254256;
					float2 temp_output_462_0_g254274 = (Out_MaskB456_g254274).xy;
					half2 ZY490_g254274 = temp_output_462_0_g254274;
					half2 XZ490_g254274 = temp_output_463_0_g254274;
					float2 temp_output_464_0_g254274 = (Out_MaskC456_g254274).xy;
					half2 XY490_g254274 = temp_output_464_0_g254274;
					half Bias490_g254274 = temp_output_504_0_g254274;
					half3 Triplanar522_g254274 = (Out_MaskN456_g254274).xyz;
					half3 Triplanar490_g254274 = Triplanar522_g254274;
					half3 NormalWS490_g254274 = NormalWS512_g254274;
					half3 Normal490_g254274 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254274 = SamplePlanar3D( Texture490_g254274 , Sampler490_g254274 , ZY490_g254274 , XZ490_g254274 , XY490_g254274 , Bias490_g254274 , Triplanar490_g254274 , NormalWS490_g254274 , Normal490_g254274 );
					float4 temp_output_407_201_g254251 = localSamplePlanar3D490_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g254274) = _MainAlbedoTex;
					SamplerState Sampler498_g254274 = staticSwitch36_g254256;
					half2 XZ498_g254274 = temp_output_463_0_g254274;
					float2 temp_output_473_0_g254274 = (Out_MaskE456_g254274).xy;
					half2 XZ_1498_g254274 = temp_output_473_0_g254274;
					float2 temp_output_474_0_g254274 = (Out_MaskE456_g254274).zw;
					half2 XZ_2498_g254274 = temp_output_474_0_g254274;
					float2 temp_output_475_0_g254274 = (Out_MaskF456_g254274).xy;
					half2 XZ_3498_g254274 = temp_output_475_0_g254274;
					float temp_output_510_0_g254274 = exp2( temp_output_504_0_g254274 );
					half Bias498_g254274 = temp_output_510_0_g254274;
					float3 temp_output_480_0_g254274 = (Out_MaskI456_g254274).xyz;
					half3 Weights_2498_g254274 = temp_output_480_0_g254274;
					half3 NormalWS498_g254274 = NormalWS512_g254274;
					half3 Normal498_g254274 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g254274 = SampleStochastic2D( Texture498_g254274 , Sampler498_g254274 , XZ498_g254274 , XZ_1498_g254274 , XZ_2498_g254274 , XZ_3498_g254274 , Bias498_g254274 , Weights_2498_g254274 , NormalWS498_g254274 , Normal498_g254274 );
					float4 temp_output_407_202_g254251 = localSampleStochastic2D498_g254274;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g254274) = _MainAlbedoTex;
					SamplerState Sampler500_g254274 = staticSwitch36_g254256;
					half2 ZY500_g254274 = temp_output_462_0_g254274;
					half2 ZY_1500_g254274 = (Out_MaskC456_g254274).zw;
					half2 ZY_2500_g254274 = (Out_MaskD456_g254274).xy;
					half2 ZY_3500_g254274 = (Out_MaskD456_g254274).zw;
					half2 XZ500_g254274 = temp_output_463_0_g254274;
					half2 XZ_1500_g254274 = temp_output_473_0_g254274;
					half2 XZ_2500_g254274 = temp_output_474_0_g254274;
					half2 XZ_3500_g254274 = temp_output_475_0_g254274;
					half2 XY500_g254274 = temp_output_464_0_g254274;
					half2 XY_1500_g254274 = (Out_MaskF456_g254274).zw;
					half2 XY_2500_g254274 = (Out_MaskG456_g254274).xy;
					half2 XY_3500_g254274 = (Out_MaskG456_g254274).zw;
					half Bias500_g254274 = temp_output_510_0_g254274;
					half3 Weights_1500_g254274 = (Out_MaskH456_g254274).xyz;
					half3 Weights_2500_g254274 = temp_output_480_0_g254274;
					half3 Weights_3500_g254274 = (Out_MaskJ456_g254274).xyz;
					half3 Triplanar500_g254274 = Triplanar522_g254274;
					half3 NormalWS500_g254274 = NormalWS512_g254274;
					half3 Normal500_g254274 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g254274 = SampleStochastic3D( Texture500_g254274 , Sampler500_g254274 , ZY500_g254274 , ZY_1500_g254274 , ZY_2500_g254274 , ZY_3500_g254274 , XZ500_g254274 , XZ_1500_g254274 , XZ_2500_g254274 , XZ_3500_g254274 , XY500_g254274 , XY_1500_g254274 , XY_2500_g254274 , XY_3500_g254274 , Bias500_g254274 , Weights_1500_g254274 , Weights_2500_g254274 , Weights_3500_g254274 , Triplanar500_g254274 , NormalWS500_g254274 , Normal500_g254274 );
					float4 temp_output_407_203_g254251 = localSampleStochastic3D500_g254274;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g254251 = temp_output_407_277_g254251;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g254251 = temp_output_407_278_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g254251 = temp_output_407_0_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g254251 = temp_output_407_201_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g254251 = temp_output_407_202_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g254251 = temp_output_407_203_g254251;
					#else
					float4 staticSwitch184_g254251 = temp_output_407_277_g254251;
					#endif
					half4 Local_AlbedoSample185_g254251 = staticSwitch184_g254251;
					float3 lerpResult53_g254251 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g254251).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g254251 = lerpResult53_g254251;
					float temp_output_17_0_g254271 = _MainMultiWriteMode;
					float Option91_g254271 = temp_output_17_0_g254271;
					float4 Model_VertexData418_g254251 = Out_VertexData15_g254252;
					float4 temp_output_84_0_g254271 = Model_VertexData418_g254251;
					float4 ChannelA91_g254271 = temp_output_84_0_g254271;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254259) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g254258 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g254258 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g254259 = staticSwitch38_g254258;
					float localBreakTextureData456_g254259 = ( 0.0 );
					TVEMasksData Data456_g254259 =(TVEMasksData)Data431_g254273;
					float4 Out_MaskA456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254259 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254259 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254259 , Out_MaskA456_g254259 , Out_MaskB456_g254259 , Out_MaskC456_g254259 , Out_MaskD456_g254259 , Out_MaskE456_g254259 , Out_MaskF456_g254259 , Out_MaskG456_g254259 , Out_MaskH456_g254259 , Out_MaskI456_g254259 , Out_MaskJ456_g254259 , Out_MaskK456_g254259 , Out_MaskL456_g254259 , Out_MaskM456_g254259 , Out_MaskN456_g254259 );
					half2 UV276_g254259 = (Out_MaskA456_g254259).xy;
					float temp_output_504_0_g254259 = 0.0;
					half Bias276_g254259 = temp_output_504_0_g254259;
					half2 Normal276_g254259 = float2( 0,0 );
					half4 localSampleCoord276_g254259 = SampleCoord( Texture276_g254259 , Sampler276_g254259 , UV276_g254259 , Bias276_g254259 , Normal276_g254259 );
					float4 temp_output_405_277_g254251 = localSampleCoord276_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254259) = _MainShaderTex;
					SamplerState Sampler502_g254259 = staticSwitch38_g254258;
					half2 UV502_g254259 = (Out_MaskA456_g254259).zw;
					half Bias502_g254259 = temp_output_504_0_g254259;
					half2 Normal502_g254259 = float2( 0,0 );
					half4 localSampleCoord502_g254259 = SampleCoord( Texture502_g254259 , Sampler502_g254259 , UV502_g254259 , Bias502_g254259 , Normal502_g254259 );
					float4 temp_output_405_278_g254251 = localSampleCoord502_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254259) = _MainShaderTex;
					SamplerState Sampler496_g254259 = staticSwitch38_g254258;
					float2 temp_output_463_0_g254259 = (Out_MaskB456_g254259).zw;
					half2 XZ496_g254259 = temp_output_463_0_g254259;
					half Bias496_g254259 = temp_output_504_0_g254259;
					half3 NormalWS512_g254259 = (Out_MaskK456_g254259).xyz;
					half3 NormalWS496_g254259 = NormalWS512_g254259;
					half3 Normal496_g254259 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254259 = SamplePlanar2D( Texture496_g254259 , Sampler496_g254259 , XZ496_g254259 , Bias496_g254259 , NormalWS496_g254259 , Normal496_g254259 );
					float4 temp_output_405_0_g254251 = localSamplePlanar2D496_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254259) = _MainShaderTex;
					SamplerState Sampler490_g254259 = staticSwitch38_g254258;
					float2 temp_output_462_0_g254259 = (Out_MaskB456_g254259).xy;
					half2 ZY490_g254259 = temp_output_462_0_g254259;
					half2 XZ490_g254259 = temp_output_463_0_g254259;
					float2 temp_output_464_0_g254259 = (Out_MaskC456_g254259).xy;
					half2 XY490_g254259 = temp_output_464_0_g254259;
					half Bias490_g254259 = temp_output_504_0_g254259;
					half3 Triplanar522_g254259 = (Out_MaskN456_g254259).xyz;
					half3 Triplanar490_g254259 = Triplanar522_g254259;
					half3 NormalWS490_g254259 = NormalWS512_g254259;
					half3 Normal490_g254259 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254259 = SamplePlanar3D( Texture490_g254259 , Sampler490_g254259 , ZY490_g254259 , XZ490_g254259 , XY490_g254259 , Bias490_g254259 , Triplanar490_g254259 , NormalWS490_g254259 , Normal490_g254259 );
					float4 temp_output_405_201_g254251 = localSamplePlanar3D490_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g254259) = _MainShaderTex;
					SamplerState Sampler498_g254259 = staticSwitch38_g254258;
					half2 XZ498_g254259 = temp_output_463_0_g254259;
					float2 temp_output_473_0_g254259 = (Out_MaskE456_g254259).xy;
					half2 XZ_1498_g254259 = temp_output_473_0_g254259;
					float2 temp_output_474_0_g254259 = (Out_MaskE456_g254259).zw;
					half2 XZ_2498_g254259 = temp_output_474_0_g254259;
					float2 temp_output_475_0_g254259 = (Out_MaskF456_g254259).xy;
					half2 XZ_3498_g254259 = temp_output_475_0_g254259;
					float temp_output_510_0_g254259 = exp2( temp_output_504_0_g254259 );
					half Bias498_g254259 = temp_output_510_0_g254259;
					float3 temp_output_480_0_g254259 = (Out_MaskI456_g254259).xyz;
					half3 Weights_2498_g254259 = temp_output_480_0_g254259;
					half3 NormalWS498_g254259 = NormalWS512_g254259;
					half3 Normal498_g254259 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g254259 = SampleStochastic2D( Texture498_g254259 , Sampler498_g254259 , XZ498_g254259 , XZ_1498_g254259 , XZ_2498_g254259 , XZ_3498_g254259 , Bias498_g254259 , Weights_2498_g254259 , NormalWS498_g254259 , Normal498_g254259 );
					float4 temp_output_405_202_g254251 = localSampleStochastic2D498_g254259;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g254259) = _MainShaderTex;
					SamplerState Sampler500_g254259 = staticSwitch38_g254258;
					half2 ZY500_g254259 = temp_output_462_0_g254259;
					half2 ZY_1500_g254259 = (Out_MaskC456_g254259).zw;
					half2 ZY_2500_g254259 = (Out_MaskD456_g254259).xy;
					half2 ZY_3500_g254259 = (Out_MaskD456_g254259).zw;
					half2 XZ500_g254259 = temp_output_463_0_g254259;
					half2 XZ_1500_g254259 = temp_output_473_0_g254259;
					half2 XZ_2500_g254259 = temp_output_474_0_g254259;
					half2 XZ_3500_g254259 = temp_output_475_0_g254259;
					half2 XY500_g254259 = temp_output_464_0_g254259;
					half2 XY_1500_g254259 = (Out_MaskF456_g254259).zw;
					half2 XY_2500_g254259 = (Out_MaskG456_g254259).xy;
					half2 XY_3500_g254259 = (Out_MaskG456_g254259).zw;
					half Bias500_g254259 = temp_output_510_0_g254259;
					half3 Weights_1500_g254259 = (Out_MaskH456_g254259).xyz;
					half3 Weights_2500_g254259 = temp_output_480_0_g254259;
					half3 Weights_3500_g254259 = (Out_MaskJ456_g254259).xyz;
					half3 Triplanar500_g254259 = Triplanar522_g254259;
					half3 NormalWS500_g254259 = NormalWS512_g254259;
					half3 Normal500_g254259 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g254259 = SampleStochastic3D( Texture500_g254259 , Sampler500_g254259 , ZY500_g254259 , ZY_1500_g254259 , ZY_2500_g254259 , ZY_3500_g254259 , XZ500_g254259 , XZ_1500_g254259 , XZ_2500_g254259 , XZ_3500_g254259 , XY500_g254259 , XY_1500_g254259 , XY_2500_g254259 , XY_3500_g254259 , Bias500_g254259 , Weights_1500_g254259 , Weights_2500_g254259 , Weights_3500_g254259 , Triplanar500_g254259 , NormalWS500_g254259 , Normal500_g254259 );
					float4 temp_output_405_203_g254251 = localSampleStochastic3D500_g254259;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g254251 = temp_output_405_277_g254251;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g254251 = temp_output_405_278_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g254251 = temp_output_405_0_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g254251 = temp_output_405_201_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g254251 = temp_output_405_202_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g254251 = temp_output_405_203_g254251;
					#else
					float4 staticSwitch198_g254251 = temp_output_405_277_g254251;
					#endif
					half4 Local_ShaderSample199_g254251 = staticSwitch198_g254251;
					float2 appendResult428_g254251 = (float2((Local_AlbedoSample185_g254251).w , (Local_ShaderSample199_g254251).z));
					float2 temp_output_85_0_g254271 = appendResult428_g254251;
					float4 ChannelB91_g254271 = float4( temp_output_85_0_g254271, 0.0 , 0.0 );
					float localSwitchChannel691_g254271 = SwitchChannel6( Option91_g254271 , ChannelA91_g254271 , ChannelB91_g254271 );
					float clampResult17_g254269 = clamp( localSwitchChannel691_g254271 , 0.0001 , 0.9999 );
					float temp_output_7_0_g254270 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g254270 = ( clampResult17_g254269 - temp_output_7_0_g254270 );
					half Local_MultiMask78_g254251 = saturate( ( temp_output_9_0_g254270 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g254251 = lerp( 1.0 , Local_MultiMask78_g254251 , _MainColorMode);
					float4 lerpResult62_g254251 = lerp( _MainColorTwo , _MainColor , lerpResult58_g254251);
					half3 Local_ColorRGB93_g254251 = (lerpResult62_g254251).rgb;
					half3 Local_Albedo139_g254251 = ( Local_AlbedoRGB107_g254251 * Local_ColorRGB93_g254251 );
					float3 temp_output_4_0_g254253 = Local_Albedo139_g254251;
					float3 In_Albedo3_g254253 = temp_output_4_0_g254253;
					float3 temp_output_44_0_g254253 = Local_Albedo139_g254251;
					float3 In_AlbedoBase3_g254253 = temp_output_44_0_g254253;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g254280) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g254257 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g254257 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g254280 = staticSwitch37_g254257;
					float localBreakTextureData456_g254280 = ( 0.0 );
					TVEMasksData Data456_g254280 =(TVEMasksData)Data431_g254273;
					float4 Out_MaskA456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g254280 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g254280 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g254280 , Out_MaskA456_g254280 , Out_MaskB456_g254280 , Out_MaskC456_g254280 , Out_MaskD456_g254280 , Out_MaskE456_g254280 , Out_MaskF456_g254280 , Out_MaskG456_g254280 , Out_MaskH456_g254280 , Out_MaskI456_g254280 , Out_MaskJ456_g254280 , Out_MaskK456_g254280 , Out_MaskL456_g254280 , Out_MaskM456_g254280 , Out_MaskN456_g254280 );
					half2 UV276_g254280 = (Out_MaskA456_g254280).xy;
					float temp_output_504_0_g254280 = 0.0;
					half Bias276_g254280 = temp_output_504_0_g254280;
					half2 Normal276_g254280 = float2( 0,0 );
					half4 localSampleCoord276_g254280 = SampleCoord( Texture276_g254280 , Sampler276_g254280 , UV276_g254280 , Bias276_g254280 , Normal276_g254280 );
					float2 temp_output_406_394_g254251 = Normal276_g254280;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g254280) = _MainNormalTex;
					SamplerState Sampler502_g254280 = staticSwitch37_g254257;
					half2 UV502_g254280 = (Out_MaskA456_g254280).zw;
					half Bias502_g254280 = temp_output_504_0_g254280;
					half2 Normal502_g254280 = float2( 0,0 );
					half4 localSampleCoord502_g254280 = SampleCoord( Texture502_g254280 , Sampler502_g254280 , UV502_g254280 , Bias502_g254280 , Normal502_g254280 );
					float2 temp_output_406_397_g254251 = Normal502_g254280;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g254280) = _MainNormalTex;
					SamplerState Sampler496_g254280 = staticSwitch37_g254257;
					float2 temp_output_463_0_g254280 = (Out_MaskB456_g254280).zw;
					half2 XZ496_g254280 = temp_output_463_0_g254280;
					half Bias496_g254280 = temp_output_504_0_g254280;
					half3 NormalWS512_g254280 = (Out_MaskK456_g254280).xyz;
					half3 NormalWS496_g254280 = NormalWS512_g254280;
					half3 Normal496_g254280 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g254280 = SamplePlanar2D( Texture496_g254280 , Sampler496_g254280 , XZ496_g254280 , Bias496_g254280 , NormalWS496_g254280 , Normal496_g254280 );
					float3 temp_output_35_0_g254283 = Normal496_g254280;
					half3 TangentWS519_g254280 = (Out_MaskL456_g254280).xyz;
					float dotResult84_g254283 = dot( temp_output_35_0_g254283 , TangentWS519_g254280 );
					half3 BitangentWS521_g254280 = (Out_MaskM456_g254280).xyz;
					float dotResult85_g254283 = dot( temp_output_35_0_g254283 , BitangentWS521_g254280 );
					float2 appendResult87_g254283 = (float2(dotResult84_g254283 , dotResult85_g254283));
					float2 temp_output_406_375_g254251 = appendResult87_g254283;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g254280) = _MainNormalTex;
					SamplerState Sampler490_g254280 = staticSwitch37_g254257;
					float2 temp_output_462_0_g254280 = (Out_MaskB456_g254280).xy;
					half2 ZY490_g254280 = temp_output_462_0_g254280;
					half2 XZ490_g254280 = temp_output_463_0_g254280;
					float2 temp_output_464_0_g254280 = (Out_MaskC456_g254280).xy;
					half2 XY490_g254280 = temp_output_464_0_g254280;
					half Bias490_g254280 = temp_output_504_0_g254280;
					half3 Triplanar522_g254280 = (Out_MaskN456_g254280).xyz;
					half3 Triplanar490_g254280 = Triplanar522_g254280;
					half3 NormalWS490_g254280 = NormalWS512_g254280;
					half3 Normal490_g254280 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g254280 = SamplePlanar3D( Texture490_g254280 , Sampler490_g254280 , ZY490_g254280 , XZ490_g254280 , XY490_g254280 , Bias490_g254280 , Triplanar490_g254280 , NormalWS490_g254280 , Normal490_g254280 );
					float3 temp_output_35_0_g254284 = Normal490_g254280;
					float dotResult84_g254284 = dot( temp_output_35_0_g254284 , TangentWS519_g254280 );
					float dotResult85_g254284 = dot( temp_output_35_0_g254284 , BitangentWS521_g254280 );
					float2 appendResult87_g254284 = (float2(dotResult84_g254284 , dotResult85_g254284));
					float2 temp_output_406_353_g254251 = appendResult87_g254284;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g254280) = _MainNormalTex;
					SamplerState Sampler498_g254280 = staticSwitch37_g254257;
					half2 XZ498_g254280 = temp_output_463_0_g254280;
					float2 temp_output_473_0_g254280 = (Out_MaskE456_g254280).xy;
					half2 XZ_1498_g254280 = temp_output_473_0_g254280;
					float2 temp_output_474_0_g254280 = (Out_MaskE456_g254280).zw;
					half2 XZ_2498_g254280 = temp_output_474_0_g254280;
					float2 temp_output_475_0_g254280 = (Out_MaskF456_g254280).xy;
					half2 XZ_3498_g254280 = temp_output_475_0_g254280;
					float temp_output_510_0_g254280 = exp2( temp_output_504_0_g254280 );
					half Bias498_g254280 = temp_output_510_0_g254280;
					float3 temp_output_480_0_g254280 = (Out_MaskI456_g254280).xyz;
					half3 Weights_2498_g254280 = temp_output_480_0_g254280;
					half3 NormalWS498_g254280 = NormalWS512_g254280;
					half3 Normal498_g254280 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g254280 = SampleStochastic2D( Texture498_g254280 , Sampler498_g254280 , XZ498_g254280 , XZ_1498_g254280 , XZ_2498_g254280 , XZ_3498_g254280 , Bias498_g254280 , Weights_2498_g254280 , NormalWS498_g254280 , Normal498_g254280 );
					float3 temp_output_35_0_g254285 = Normal498_g254280;
					float dotResult84_g254285 = dot( temp_output_35_0_g254285 , TangentWS519_g254280 );
					float dotResult85_g254285 = dot( temp_output_35_0_g254285 , BitangentWS521_g254280 );
					float2 appendResult87_g254285 = (float2(dotResult84_g254285 , dotResult85_g254285));
					float2 temp_output_406_391_g254251 = appendResult87_g254285;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g254280) = _MainNormalTex;
					SamplerState Sampler500_g254280 = staticSwitch37_g254257;
					half2 ZY500_g254280 = temp_output_462_0_g254280;
					half2 ZY_1500_g254280 = (Out_MaskC456_g254280).zw;
					half2 ZY_2500_g254280 = (Out_MaskD456_g254280).xy;
					half2 ZY_3500_g254280 = (Out_MaskD456_g254280).zw;
					half2 XZ500_g254280 = temp_output_463_0_g254280;
					half2 XZ_1500_g254280 = temp_output_473_0_g254280;
					half2 XZ_2500_g254280 = temp_output_474_0_g254280;
					half2 XZ_3500_g254280 = temp_output_475_0_g254280;
					half2 XY500_g254280 = temp_output_464_0_g254280;
					half2 XY_1500_g254280 = (Out_MaskF456_g254280).zw;
					half2 XY_2500_g254280 = (Out_MaskG456_g254280).xy;
					half2 XY_3500_g254280 = (Out_MaskG456_g254280).zw;
					half Bias500_g254280 = temp_output_510_0_g254280;
					half3 Weights_1500_g254280 = (Out_MaskH456_g254280).xyz;
					half3 Weights_2500_g254280 = temp_output_480_0_g254280;
					half3 Weights_3500_g254280 = (Out_MaskJ456_g254280).xyz;
					half3 Triplanar500_g254280 = Triplanar522_g254280;
					half3 NormalWS500_g254280 = NormalWS512_g254280;
					half3 Normal500_g254280 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g254280 = SampleStochastic3D( Texture500_g254280 , Sampler500_g254280 , ZY500_g254280 , ZY_1500_g254280 , ZY_2500_g254280 , ZY_3500_g254280 , XZ500_g254280 , XZ_1500_g254280 , XZ_2500_g254280 , XZ_3500_g254280 , XY500_g254280 , XY_1500_g254280 , XY_2500_g254280 , XY_3500_g254280 , Bias500_g254280 , Weights_1500_g254280 , Weights_2500_g254280 , Weights_3500_g254280 , Triplanar500_g254280 , NormalWS500_g254280 , Normal500_g254280 );
					float3 temp_output_35_0_g254281 = Normal500_g254280;
					float dotResult84_g254281 = dot( temp_output_35_0_g254281 , TangentWS519_g254280 );
					float dotResult85_g254281 = dot( temp_output_35_0_g254281 , BitangentWS521_g254280 );
					float2 appendResult87_g254281 = (float2(dotResult84_g254281 , dotResult85_g254281));
					float2 temp_output_406_390_g254251 = appendResult87_g254281;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g254251 = temp_output_406_394_g254251;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g254251 = temp_output_406_397_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g254251 = temp_output_406_375_g254251;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g254251 = temp_output_406_353_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g254251 = temp_output_406_391_g254251;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g254251 = temp_output_406_390_g254251;
					#else
					float2 staticSwitch193_g254251 = temp_output_406_394_g254251;
					#endif
					half2 Local_NormaSample191_g254251 = staticSwitch193_g254251;
					half2 Local_NormalTS108_g254251 = ( Local_NormaSample191_g254251 * _MainNormalValue );
					float2 In_NormalTS3_g254253 = Local_NormalTS108_g254251;
					float2 break80_g254272 = Local_NormalTS108_g254251;
					float3 temp_output_77_0_g254272 = Model_TangentWS366_g254251;
					float3 temp_output_78_0_g254272 = Model_BitangentWS367_g254251;
					float3 temp_output_76_0_g254272 = Model_NormalWS226_g254251;
					half3 Local_NormalWS250_g254251 = ( ( break80_g254272.x * temp_output_77_0_g254272 ) + ( break80_g254272.y * temp_output_78_0_g254272 ) + temp_output_76_0_g254272 );
					float3 In_NormalWS3_g254253 = Local_NormalWS250_g254251;
					float temp_output_209_0_g254251 = (Local_ShaderSample199_g254251).y;
					float temp_output_7_0_g254265 = _MainOcclusionRemap.x;
					float temp_output_9_0_g254265 = ( temp_output_209_0_g254251 - temp_output_7_0_g254265 );
					float lerpResult23_g254251 = lerp( 1.0 , saturate( ( temp_output_9_0_g254265 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g254251 = lerpResult23_g254251;
					float temp_output_213_0_g254251 = (Local_ShaderSample199_g254251).w;
					float temp_output_7_0_g254268 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g254268 = ( temp_output_213_0_g254251 - temp_output_7_0_g254268 );
					half Local_Smoothness317_g254251 = ( saturate( ( temp_output_9_0_g254268 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g254251 = (float4(( (Local_ShaderSample199_g254251).x * _MainMetallicValue ) , Local_Occlusion313_g254251 , (Local_ShaderSample199_g254251).z , Local_Smoothness317_g254251));
					half4 Local_Masks109_g254251 = appendResult73_g254251;
					float4 In_Shader3_g254253 = Local_Masks109_g254251;
					float4 In_Feature3_g254253 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g254253 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g254253 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g254286 = Local_Albedo139_g254251;
					float dotResult20_g254286 = dot( temp_output_3_0_g254286 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g254251 = dotResult20_g254286;
					float temp_output_12_0_g254253 = Local_Grayscale110_g254251;
					float In_Grayscale3_g254253 = temp_output_12_0_g254253;
					float temp_output_3_0_g254287 = Local_Grayscale110_g254251;
					float clampResult27_g254287 = clamp( saturate( ( temp_output_3_0_g254287 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g254251 = clampResult27_g254287;
					float temp_output_16_0_g254253 = Local_Luminosity145_g254251;
					float In_Luminosity3_g254253 = temp_output_16_0_g254253;
					float In_MultiMask3_g254253 = Local_MultiMask78_g254251;
					float temp_output_187_0_g254251 = (Local_AlbedoSample185_g254251).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g254251 = ( temp_output_187_0_g254251 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g254251 = temp_output_187_0_g254251;
					#endif
					half Local_AlphaClip111_g254251 = staticSwitch236_g254251;
					float In_AlphaClip3_g254253 = Local_AlphaClip111_g254251;
					half Local_AlphaFade246_g254251 = (lerpResult62_g254251).a;
					float In_AlphaFade3_g254253 = Local_AlphaFade246_g254251;
					float3 temp_cast_31 = (1.0).xxx;
					float3 In_Translucency3_g254253 = temp_cast_31;
					float In_Transmission3_g254253 = 1.0;
					float In_Thickness3_g254253 = 0.0;
					float In_Diffusion3_g254253 = 0.0;
					float In_Depth3_g254253 = 0.0;
					BuildVisualData( Data3_g254253 , In_Dummy3_g254253 , In_Albedo3_g254253 , In_AlbedoBase3_g254253 , In_NormalTS3_g254253 , In_NormalWS3_g254253 , In_Shader3_g254253 , In_Feature3_g254253 , In_Season3_g254253 , In_Emissive3_g254253 , In_Grayscale3_g254253 , In_Luminosity3_g254253 , In_MultiMask3_g254253 , In_AlphaClip3_g254253 , In_AlphaFade3_g254253 , In_Translucency3_g254253 , In_Transmission3_g254253 , In_Thickness3_g254253 , In_Diffusion3_g254253 , In_Depth3_g254253 );
					TVEVisualData Data4_g254299 =(TVEVisualData)Data3_g254253;
					float Out_Dummy4_g254299 = 0.0;
					float3 Out_Albedo4_g254299 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254299 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254299 = float2( 0,0 );
					float3 Out_NormalWS4_g254299 = float3( 0,0,0 );
					float4 Out_Shader4_g254299 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254299 = float4( 0,0,0,0 );
					float4 Out_Season4_g254299 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254299 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254299 = 0.0;
					float Out_Grayscale4_g254299 = 0.0;
					float Out_Luminosity4_g254299 = 0.0;
					float Out_AlphaClip4_g254299 = 0.0;
					float Out_AlphaFade4_g254299 = 0.0;
					float3 Out_Translucency4_g254299 = float3( 0,0,0 );
					float Out_Transmission4_g254299 = 0.0;
					float Out_Thickness4_g254299 = 0.0;
					float Out_Diffusion4_g254299 = 0.0;
					float Out_Depth4_g254299 = 0.0;
					BreakVisualData( Data4_g254299 , Out_Dummy4_g254299 , Out_Albedo4_g254299 , Out_AlbedoBase4_g254299 , Out_NormalTS4_g254299 , Out_NormalWS4_g254299 , Out_Shader4_g254299 , Out_Feature4_g254299 , Out_Season4_g254299 , Out_Emissive4_g254299 , Out_MultiMask4_g254299 , Out_Grayscale4_g254299 , Out_Luminosity4_g254299 , Out_AlphaClip4_g254299 , Out_AlphaFade4_g254299 , Out_Translucency4_g254299 , Out_Transmission4_g254299 , Out_Thickness4_g254299 , Out_Diffusion4_g254299 , Out_Depth4_g254299 );
					half4 Visual_Shader531_g254290 = Out_Shader4_g254299;
					float temp_output_1331_0_g254290 = (Visual_Shader531_g254290).z;
					float temp_output_7_0_g254305 = _TerrainBaseRemap.x;
					float temp_output_9_0_g254305 = ( temp_output_1331_0_g254290 - temp_output_7_0_g254305 );
					float lerpResult1259_g254290 = lerp( 1.0 , saturate( ( temp_output_9_0_g254305 * _TerrainBaseRemap.z ) ) , _TerrainBaseValue);
					half Blend_BaseMask1043_g254290 = lerpResult1259_g254290;
					half3 Visual_NormalWS953_g254290 = Out_NormalWS4_g254299;
					float temp_output_903_0_g254290 = saturate( (Visual_NormalWS953_g254290).y );
					float temp_output_7_0_g254303 = _TerrainProjRemap.x;
					float temp_output_9_0_g254303 = ( temp_output_903_0_g254290 - temp_output_7_0_g254303 );
					float lerpResult1106_g254290 = lerp( 1.0 , saturate( ( temp_output_9_0_g254303 * _TerrainProjRemap.z ) ) , _TerrainProjValue);
					half Blend_ProjMask912_g254290 = lerpResult1106_g254290;
					half Blend_UserMask1165_g254290 = 1.0;
					half Blend_VertMask913_g254290 = 1.0;
					float localBuildGlobalData204_g251364 = ( 0.0 );
					TVEGlobalData Data204_g251364 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251364 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251364 = Dummy211_g251364;
					float4 temp_output_203_0_g251383 = TVE_CoatBaseCoord;
					TVEModelData Data15_g251454 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251454 = 0.0;
					float3 Out_PositionWS15_g251454 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251454 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251454 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251454 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251454 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251454 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251454 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251454 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251454 , Out_Dummy15_g251454 , Out_PositionWS15_g251454 , Out_PositionWO15_g251454 , Out_PivotWS15_g251454 , Out_PivotWO15_g251454 , Out_NormalWS15_g251454 , Out_TangentWS15_g251454 , Out_BitangentWS15_g251454 , Out_TriplanarWeights15_g251454 , Out_ViewDirWS15_g251454 , Out_CoordsData15_g251454 , Out_VertexData15_g251454 , Out_Interpolator15_g251454 );
					float3 Model_PositionWS497_g251364 = Out_PositionWS15_g251454;
					float2 Model_PositionWS_XZ143_g251364 = (Model_PositionWS497_g251364).xz;
					float3 Model_PivotWS498_g251364 = Out_PivotWS15_g251454;
					float2 Model_PivotWS_XZ145_g251364 = (Model_PivotWS498_g251364).xz;
					float2 lerpResult300_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251383 = lerpResult300_g251364;
					float temp_output_82_0_g251381 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251383 = temp_output_82_0_g251381;
					float4 tex2DArrayNode83_g251383 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251383).zw + ( (temp_output_203_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383) );
					float4 appendResult210_g251383 = (float4(tex2DArrayNode83_g251383.rgb , tex2DArrayNode83_g251383.a));
					float4 temp_output_204_0_g251383 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251383 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251383).zw + ( (temp_output_204_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383) );
					float4 appendResult212_g251383 = (float4(tex2DArrayNode122_g251383.rgb , tex2DArrayNode122_g251383.a));
					float4 TVE_RenderNearPositionR628_g251364 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251364 = saturate( ( distance( Model_PositionWS497_g251364 , (TVE_RenderNearPositionR628_g251364).xyz ) / (TVE_RenderNearPositionR628_g251364).w ) );
					float temp_output_7_0_g251453 = 1.0;
					float temp_output_9_0_g251453 = ( temp_output_507_0_g251364 - temp_output_7_0_g251453 );
					half TVE_RenderNearFadeValue635_g251364 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251364 = saturate( ( temp_output_9_0_g251453 / ( ( TVE_RenderNearFadeValue635_g251364 - temp_output_7_0_g251453 ) + 0.0001 ) ) );
					float4 lerpResult131_g251383 = lerp( appendResult210_g251383 , appendResult212_g251383 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251381 = lerpResult131_g251383;
					float4 lerpResult168_g251381 = lerp( TVE_CoatParams , temp_output_159_109_g251381 , TVE_CoatLayers[(int)temp_output_82_0_g251381]);
					float4 temp_output_589_109_g251364 = lerpResult168_g251381;
					half4 Coat_Texture302_g251364 = temp_output_589_109_g251364;
					float4 In_CoatTexture204_g251364 = Coat_Texture302_g251364;
					half4 Draw_Texture656_g251364 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251364 = Draw_Texture656_g251364;
					float4 temp_output_203_0_g251408 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251408 = lerpResult85_g251364;
					float temp_output_82_0_g251405 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251408 = temp_output_82_0_g251405;
					float4 tex2DArrayNode83_g251408 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251408).zw + ( (temp_output_203_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408) );
					float4 appendResult210_g251408 = (float4(tex2DArrayNode83_g251408.rgb , tex2DArrayNode83_g251408.a));
					float4 temp_output_204_0_g251408 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251408 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251408).zw + ( (temp_output_204_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408) );
					float4 appendResult212_g251408 = (float4(tex2DArrayNode122_g251408.rgb , tex2DArrayNode122_g251408.a));
					float4 lerpResult131_g251408 = lerp( appendResult210_g251408 , appendResult212_g251408 , Global_TexBlend509_g251364);
					float4 temp_output_171_109_g251405 = lerpResult131_g251408;
					float4 lerpResult174_g251405 = lerp( TVE_PaintParams , temp_output_171_109_g251405 , TVE_PaintLayers[(int)temp_output_82_0_g251405]);
					float4 temp_output_595_109_g251364 = lerpResult174_g251405;
					half4 Paint_Texture71_g251364 = temp_output_595_109_g251364;
					float4 In_PaintTexture204_g251364 = Paint_Texture71_g251364;
					float4 temp_output_203_0_g251391 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251391 = lerpResult104_g251364;
					float temp_output_132_0_g251389 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251391 = temp_output_132_0_g251389;
					float4 tex2DArrayNode83_g251391 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251391).zw + ( (temp_output_203_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391) );
					float4 appendResult210_g251391 = (float4(tex2DArrayNode83_g251391.rgb , tex2DArrayNode83_g251391.a));
					float4 temp_output_204_0_g251391 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251391 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251391).zw + ( (temp_output_204_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391) );
					float4 appendResult212_g251391 = (float4(tex2DArrayNode122_g251391.rgb , tex2DArrayNode122_g251391.a));
					float4 lerpResult131_g251391 = lerp( appendResult210_g251391 , appendResult212_g251391 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251389 = lerpResult131_g251391;
					float4 lerpResult145_g251389 = lerp( TVE_AtmoParams , temp_output_137_109_g251389 , TVE_AtmoLayers[(int)temp_output_132_0_g251389]);
					float4 temp_output_590_110_g251364 = lerpResult145_g251389;
					half4 Atmo_Texture80_g251364 = temp_output_590_110_g251364;
					float4 In_AtmoTexture204_g251364 = Atmo_Texture80_g251364;
					float4 temp_output_203_0_g251459 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251459 = lerpResult414_g251364;
					float temp_output_132_0_g251457 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251459 = temp_output_132_0_g251457;
					float4 tex2DArrayNode83_g251459 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251459).zw + ( (temp_output_203_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459) );
					float4 appendResult210_g251459 = (float4(tex2DArrayNode83_g251459.rgb , tex2DArrayNode83_g251459.a));
					float4 temp_output_204_0_g251459 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251459 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251459).zw + ( (temp_output_204_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459) );
					float4 appendResult212_g251459 = (float4(tex2DArrayNode122_g251459.rgb , tex2DArrayNode122_g251459.a));
					float4 lerpResult131_g251459 = lerp( appendResult210_g251459 , appendResult212_g251459 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251457 = lerpResult131_g251459;
					float4 lerpResult145_g251457 = lerp( TVE_EffexParams , temp_output_137_109_g251457 , TVE_EffexLayers[(int)temp_output_132_0_g251457]);
					float4 temp_output_731_110_g251364 = lerpResult145_g251457;
					half4 Effex_Texture420_g251364 = temp_output_731_110_g251364;
					float4 In_EffexTexture204_g251364 = Effex_Texture420_g251364;
					float4 temp_output_203_0_g251439 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251439 = lerpResult247_g251364;
					float temp_output_82_0_g251437 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251439 = temp_output_82_0_g251437;
					float4 tex2DArrayNode83_g251439 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251439).zw + ( (temp_output_203_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439) );
					float4 appendResult210_g251439 = (float4(tex2DArrayNode83_g251439.rgb , tex2DArrayNode83_g251439.a));
					float4 temp_output_204_0_g251439 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251439 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251439).zw + ( (temp_output_204_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439) );
					float4 appendResult212_g251439 = (float4(tex2DArrayNode122_g251439.rgb , tex2DArrayNode122_g251439.a));
					float4 lerpResult131_g251439 = lerp( appendResult210_g251439 , appendResult212_g251439 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251437 = lerpResult131_g251439;
					float4 lerpResult167_g251437 = lerp( TVE_GlowParams , temp_output_159_109_g251437 , TVE_GlowLayers[(int)temp_output_82_0_g251437]);
					float4 temp_output_593_109_g251364 = lerpResult167_g251437;
					half4 Glow_Texture248_g251364 = temp_output_593_109_g251364;
					float4 In_GlowTexture204_g251364 = Glow_Texture248_g251364;
					float4 temp_output_203_0_g251375 = TVE_FormBaseCoord;
					float2 lerpResult168_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251375 = lerpResult168_g251364;
					float temp_output_130_0_g251373 = _GlobalFormLayerValue;
					float temp_output_82_0_g251375 = temp_output_130_0_g251373;
					float4 tex2DArrayNode83_g251375 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251375).zw + ( (temp_output_203_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375) );
					float4 appendResult210_g251375 = (float4(tex2DArrayNode83_g251375.rgb , tex2DArrayNode83_g251375.a));
					float4 temp_output_204_0_g251375 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251375 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251375).zw + ( (temp_output_204_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375) );
					float4 appendResult212_g251375 = (float4(tex2DArrayNode122_g251375.rgb , tex2DArrayNode122_g251375.a));
					float4 lerpResult131_g251375 = lerp( appendResult210_g251375 , appendResult212_g251375 , Global_TexBlend509_g251364);
					float4 temp_output_135_109_g251373 = lerpResult131_g251375;
					float4 lerpResult143_g251373 = lerp( TVE_FormParams , temp_output_135_109_g251373 , TVE_FormLayers[(int)temp_output_130_0_g251373]);
					float4 temp_output_592_0_g251364 = lerpResult143_g251373;
					float4 Form_Texture112_g251364 = temp_output_592_0_g251364;
					float4 In_FormTexture204_g251364 = Form_Texture112_g251364;
					float4 In_LandTexture204_g251364 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251423 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251423 = lerpResult681_g251364;
					float temp_output_136_0_g251421 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251423 = temp_output_136_0_g251421;
					float4 tex2DArrayNode83_g251423 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251423).zw + ( (temp_output_203_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423) );
					float4 appendResult210_g251423 = (float4(tex2DArrayNode83_g251423.rgb , tex2DArrayNode83_g251423.a));
					float4 temp_output_204_0_g251423 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251423 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251423).zw + ( (temp_output_204_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423) );
					float4 appendResult212_g251423 = (float4(tex2DArrayNode122_g251423.rgb , tex2DArrayNode122_g251423.a));
					float4 lerpResult131_g251423 = lerp( appendResult210_g251423 , appendResult212_g251423 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251421 = lerpResult131_g251423;
					float4 lerpResult149_g251421 = lerp( TVE_VertxParams , temp_output_141_109_g251421 , TVE_VertxLayers[(int)temp_output_136_0_g251421]);
					float4 temp_output_695_0_g251364 = lerpResult149_g251421;
					half4 Vertx_Texture693_g251364 = temp_output_695_0_g251364;
					float4 In_VertxTexture204_g251364 = Vertx_Texture693_g251364;
					float4 temp_output_203_0_g251399 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251399 = lerpResult400_g251364;
					float temp_output_136_0_g251397 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251399 = temp_output_136_0_g251397;
					float4 tex2DArrayNode83_g251399 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251399).zw + ( (temp_output_203_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399) );
					float4 appendResult210_g251399 = (float4(tex2DArrayNode83_g251399.rgb , tex2DArrayNode83_g251399.a));
					float4 temp_output_204_0_g251399 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251399 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251399).zw + ( (temp_output_204_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399) );
					float4 appendResult212_g251399 = (float4(tex2DArrayNode122_g251399.rgb , tex2DArrayNode122_g251399.a));
					float4 lerpResult131_g251399 = lerp( appendResult210_g251399 , appendResult212_g251399 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251397 = lerpResult131_g251399;
					float4 lerpResult149_g251397 = lerp( TVE_FlowParams , temp_output_141_109_g251397 , TVE_FlowLayers[(int)temp_output_136_0_g251397]);
					float4 temp_output_594_0_g251364 = lerpResult149_g251397;
					half4 Flow_Texture405_g251364 = temp_output_594_0_g251364;
					float4 In_FlowTexture204_g251364 = Flow_Texture405_g251364;
					half4 User_Texture677_g251364 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251364 = User_Texture677_g251364;
					BuildGlobalData( Data204_g251364 , In_Dummy204_g251364 , In_CoatTexture204_g251364 , In_DrawTexture204_g251364 , In_PaintTexture204_g251364 , In_AtmoTexture204_g251364 , In_EffexTexture204_g251364 , In_GlowTexture204_g251364 , In_FormTexture204_g251364 , In_LandTexture204_g251364 , In_VertxTexture204_g251364 , In_FlowTexture204_g251364 , In_UserTexture204_g251364 );
					TVEGlobalData Data15_g254312 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g254312 = 0.0;
					float4 Out_CoatTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g254312 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g254312 = float4( 0,0,0,0 );
					BreakData( Data15_g254312 , Out_Dummy15_g254312 , Out_CoatTexture15_g254312 , Out_DrawTexture15_g254312 , Out_PaintTexture15_g254312 , Out_AtmoTexture15_g254312 , Out_EffexTexture15_g254312 , Out_GlowTexture15_g254312 , Out_FormTexture15_g254312 , Out_LandTexture15_g254312 , Out_VertxTexture15_g254312 , Out_FlowTexture15_g254312 , Out_UserTexture15_g254312 );
					half4 Global_FormParams1018_g254290 = Out_FormTexture15_g254312;
					float temp_output_7_0_g254726 = -_TerrainFormValue;
					float temp_output_9_0_g254726 = ( ( ( (Global_FormParams1018_g254290).z - PositionWS.y ) - 0.01 ) - temp_output_7_0_g254726 );
					float temp_output_1322_0_g254290 = saturate( ( temp_output_9_0_g254726 / ( ( 0.0 - temp_output_7_0_g254726 ) + 0.0001 ) ) );
					float temp_output_64_0_g254753 = temp_output_1322_0_g254290;
					float Multiply89_g254753 = temp_output_64_0_g254753;
					float Additive89_g254753 = 1.0;
					float temp_output_78_0_g254753 = ( temp_output_64_0_g254753 * 0.5 );
					float MulAdd89_g254753 = temp_output_78_0_g254753;
					float temp_output_67_0_g254753 = _TerrainFormMath;
					float Option89_g254753 = temp_output_67_0_g254753;
					float localSwitchFormMask89_g254753 = SwitchFormMask( Multiply89_g254753 , Additive89_g254753 , MulAdd89_g254753 , Option89_g254753 );
					half Blend_FormMask_Mul1132_g254290 = localSwitchFormMask89_g254753;
					float Multiply88_g254753 = 0.0;
					float Additive88_g254753 = temp_output_64_0_g254753;
					float MulAdd88_g254753 = temp_output_78_0_g254753;
					float Option88_g254753 = temp_output_67_0_g254753;
					float localSwitchFormMask88_g254753 = SwitchFormMask( Multiply88_g254753 , Additive88_g254753 , MulAdd88_g254753 , Option88_g254753 );
					half Blend_FormMask_Add1131_g254290 = localSwitchFormMask88_g254753;
					float temp_output_7_0_g254752 = _TerrainBlendRemap.x;
					float temp_output_9_0_g254752 = ( saturate( ( ( Detail_TexMask429_g254290 * Blend_BaseMask1043_g254290 * Blend_ProjMask912_g254290 * Blend_UserMask1165_g254290 * Blend_VertMask913_g254290 * Blend_FormMask_Mul1132_g254290 * Feature_Intensity1266_g254290 ) + Blend_FormMask_Add1131_g254290 ) ) - temp_output_7_0_g254752 );
					half Blend_Mask412_g254290 = saturate( ( temp_output_9_0_g254752 * _TerrainBlendRemap.z ) );
					float4 appendResult1270_g254290 = (float4(Blend_Mask412_g254290 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_40 = (0.0).xxxx;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 ifLocalVar18_g254308 = 0;
					if( Feature_Intensity1266_g254290 <= 0.0 )
					ifLocalVar18_g254308 = temp_cast_41;
					else
					ifLocalVar18_g254308 = appendResult1270_g254290;
					float4 In_MaskB3_g254309 = ifLocalVar18_g254308;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskC3_g254309 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskD3_g254309 = temp_cast_43;
					float4 temp_cast_44 = (0.0).xxxx;
					float4 In_MaskE3_g254309 = temp_cast_44;
					float4 temp_cast_45 = (0.0).xxxx;
					float4 In_MaskF3_g254309 = temp_cast_45;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 In_MaskG3_g254309 = temp_cast_46;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskH3_g254309 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskI3_g254309 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskJ3_g254309 = temp_cast_49;
					float4 temp_cast_50 = (0.0).xxxx;
					float4 In_MaskK3_g254309 = temp_cast_50;
					float4 temp_cast_51 = (0.0).xxxx;
					float4 In_MaskL3_g254309 = temp_cast_51;
					{
					Data3_g254309.MaskA = In_MaskA3_g254309;
					Data3_g254309.MaskB = In_MaskB3_g254309;
					Data3_g254309.MaskC = In_MaskC3_g254309;
					Data3_g254309.MaskD = In_MaskD3_g254309;
					Data3_g254309.MaskE = In_MaskE3_g254309;
					Data3_g254309.MaskF = In_MaskF3_g254309;
					Data3_g254309.MaskG = In_MaskG3_g254309;
					Data3_g254309.MaskH = In_MaskH3_g254309;
					Data3_g254309.MaskI = In_MaskI3_g254309;
					Data3_g254309.MaskJ= In_MaskJ3_g254309;
					Data3_g254309.MaskK= In_MaskK3_g254309;
					Data3_g254309.MaskL = In_MaskL3_g254309;
					}
					TVEMasksData Data4_g254755 = Data3_g254309;
					float4 Out_MaskA4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g254755 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g254755 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g254755 = Data4_g254755.MaskA;
					Out_MaskB4_g254755 = Data4_g254755.MaskB;
					Out_MaskC4_g254755 = Data4_g254755.MaskC;
					Out_MaskD4_g254755 = Data4_g254755.MaskD;
					Out_MaskE4_g254755 = Data4_g254755.MaskE;
					Out_MaskF4_g254755 = Data4_g254755.MaskF;
					Out_MaskG4_g254755 = Data4_g254755.MaskG;
					Out_MaskH4_g254755 = Data4_g254755.MaskH;
					}
					float3 lerpResult2568 = lerp( color107_g254756 , color106_g254756 , (Out_MaskA4_g254755).x);
					float3 ifLocalVar40_g254758 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g254758 = lerpResult2568;
					float ifLocalVar40_g254759 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g254759 = (Out_MaskB4_g254755).x;
					half3 Final_Debug2399 = ( ifLocalVar40_g254758 + ifLocalVar40_g254759 );
					float temp_output_7_0_g254768 = TVE_DEBUG_Min;
					float3 temp_cast_52 = (temp_output_7_0_g254768).xxx;
					float3 temp_output_9_0_g254768 = ( Final_Debug2399 - temp_cast_52 );
					float lerpResult76_g254761 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g254761 = lerpResult76_g254761;
					float3 lerpResult72_g254761 = lerp( (lerpResult73_g254762).rgb , saturate( ( temp_output_9_0_g254768 / ( ( TVE_DEBUG_Max - temp_output_7_0_g254768 ) + 0.0001 ) ) ) , Filter152_g254761);
					float dotResult61_g254761 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g254761 = ( 1.0 - saturate( dotResult61_g254761 ) );
					float Shading_Fresnel59_g254761 = (( 1.0 - ( temp_output_65_0_g254761 * temp_output_65_0_g254761 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g254761 = IN.ase_texcoord8;
					float depthLinearEye57_g254761 = LinearEyeDepth( ase_positionCS57_g254761.z / ase_positionCS57_g254761.w );
					float temp_output_69_0_g254761 = saturate(  (0.0 + ( depthLinearEye57_g254761 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g254761 = (( temp_output_69_0_g254761 * temp_output_69_0_g254761 )*0.5 + 0.5);
					float lerpResult84_g254761 = lerp( 1.0 , Shading_Fresnel59_g254761 , ( Shading_Distance58_g254761 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g254766 = ( 0.0 );
					TVEVisualData Data4_g254766 =(TVEVisualData)Data3_g254253;
					float Out_Dummy4_g254766 = 0.0;
					float3 Out_Albedo4_g254766 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254766 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254766 = float2( 0,0 );
					float3 Out_NormalWS4_g254766 = float3( 0,0,0 );
					float4 Out_Shader4_g254766 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254766 = float4( 0,0,0,0 );
					float4 Out_Season4_g254766 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254766 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254766 = 0.0;
					float Out_Grayscale4_g254766 = 0.0;
					float Out_Luminosity4_g254766 = 0.0;
					float Out_AlphaClip4_g254766 = 0.0;
					float Out_AlphaFade4_g254766 = 0.0;
					float3 Out_Translucency4_g254766 = float3( 0,0,0 );
					float Out_Transmission4_g254766 = 0.0;
					float Out_Thickness4_g254766 = 0.0;
					float Out_Diffusion4_g254766 = 0.0;
					float Out_Depth4_g254766 = 0.0;
					BreakVisualData( Data4_g254766 , Out_Dummy4_g254766 , Out_Albedo4_g254766 , Out_AlbedoBase4_g254766 , Out_NormalTS4_g254766 , Out_NormalWS4_g254766 , Out_Shader4_g254766 , Out_Feature4_g254766 , Out_Season4_g254766 , Out_Emissive4_g254766 , Out_MultiMask4_g254766 , Out_Grayscale4_g254766 , Out_Luminosity4_g254766 , Out_AlphaClip4_g254766 , Out_AlphaFade4_g254766 , Out_Translucency4_g254766 , Out_Transmission4_g254766 , Out_Thickness4_g254766 , Out_Diffusion4_g254766 , Out_Depth4_g254766 );
					float Alpha109_g254761 = Out_AlphaClip4_g254766;
					float lerpResult91_g254761 = lerp( 1.0 , Alpha109_g254761 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g254761 = lerp( 1.0 , lerpResult91_g254761 , Filter152_g254761);
					clip( lerpResult154_g254761 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2664_114;
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

					o.Emission = ( lerpResult72_g254761 * lerpResult84_g254761 );
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
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
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
				#if defined (TVE_TERRAIN_HOLES) //Terrain Holes
					#define TVE_ALPHA_CLIP //Terrain Holes
				#endif //Terrain Holes
				  
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

				uniform half _TerrainSampleMode6;
				uniform half _TerrainSampleMode7;
				uniform half _TerrainSampleMode8;
				uniform half _TerrainSampleMode5;
				uniform half _TerrainSampleMode10;
				uniform half _TerrainSampleMode11;
				uniform half _TerrainSampleMode12;
				uniform half _TerrainSampleMode9;
				uniform half _TerrainSampleMode14;
				uniform half _TerrainSampleMode15;
				uniform half _TerrainSampleMode16;
				uniform half _TerrainSampleMode13;
				uniform half _TerrainSampleMode2;
				uniform half _TerrainSampleMode3;
				uniform half _TerrainSampleMode4;
				uniform half _TerrainSampleMode1;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainFeatureTex);
				SamplerState sampler_TerrainFeatureTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainShaderTex);
				SamplerState sampler_TerrainShaderTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainNormalTex);
				SamplerState sampler_TerrainNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainAlbedoTex);
				SamplerState sampler_TerrainAlbedoTex;
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
				uniform float _IsShaderType;
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

					TVEVertexData Data16_g251977 =(TVEVertexData)0;
					float In_Dummy16_g251977 = 0.0;
					TVEVertexData Data16_g251972 =(TVEVertexData)0;
					float In_Dummy16_g251972 = 0.0;
					float localIfModelDataByShader26_g251465 = ( 0.0 );
					TVEModelData Data26_g251465 = (TVEModelData)0;
					TVEModelData Data16_g241434 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#endif
					half Dummy207_g241416 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241416 );
					float temp_output_14_0_g241434 = Dummy207_g241416;
					float In_Dummy16_g241434 = temp_output_14_0_g241434;
					float3 PositionOS131_g241416 = v.vertex.xyz;
					float3 temp_output_4_0_g241434 = PositionOS131_g241416;
					float3 In_PositionOS16_g241434 = temp_output_4_0_g241434;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241416 = ase_positionWS;
					float3 vertexToFrag73_g241416 = temp_output_104_7_g241416;
					float3 PositionWS122_g241416 = vertexToFrag73_g241416;
					float3 In_PositionWS16_g241434 = PositionWS122_g241416;
					float4x4 break19_g241419 = unity_ObjectToWorld;
					float3 appendResult20_g241419 = (float3(break19_g241419[ 0 ][ 3 ] , break19_g241419[ 1 ][ 3 ] , break19_g241419[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241416 = appendResult20_g241419;
					float4x4 break19_g241421 = unity_ObjectToWorld;
					float3 appendResult20_g241421 = (float3(break19_g241421[ 0 ][ 3 ] , break19_g241421[ 1 ][ 3 ] , break19_g241421[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241417 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241416 = PositionOS131_g241416;
					float3 appendResult234_g241416 = (float3(break233_g241416.x , 0.0 , break233_g241416.z));
					float3 break413_g241416 = PositionOS131_g241416;
					float3 appendResult414_g241416 = (float3(break413_g241416.x , break413_g241416.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241423 = appendResult414_g241416;
					#else
					float3 staticSwitch65_g241423 = appendResult234_g241416;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241416 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241416 = appendResult60_g241417;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241416 = staticSwitch65_g241423;
					#else
					float3 staticSwitch229_g241416 = _Vector0;
					#endif
					float3 PivotOS149_g241416 = staticSwitch229_g241416;
					float3 temp_output_122_0_g241421 = PivotOS149_g241416;
					float3 PivotsOnlyWS105_g241421 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241421 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241416 = ( appendResult20_g241421 + PivotsOnlyWS105_g241421 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#else
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#endif
					float3 vertexToFrag76_g241416 = staticSwitch236_g241416;
					float3 PivotWS121_g241416 = vertexToFrag76_g241416;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241416 = ( PositionWS122_g241416 - PivotWS121_g241416 );
					#else
					float3 staticSwitch204_g241416 = PositionWS122_g241416;
					#endif
					float3 PositionWO132_g241416 = ( staticSwitch204_g241416 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241434 = PositionWO132_g241416;
					float3 In_PivotOS16_g241434 = PivotOS149_g241416;
					float3 In_PivotWS16_g241434 = PivotWS121_g241416;
					float3 PivotWO133_g241416 = ( PivotWS121_g241416 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241434 = PivotWO133_g241416;
					half3 NormalOS134_g241416 = v.normal;
					float3 temp_output_21_0_g241434 = NormalOS134_g241416;
					float3 In_NormalOS16_g241434 = temp_output_21_0_g241434;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241416 = normalizedWorldNormal;
					float3 In_NormalWS16_g241434 = NormalWS95_g241416;
					half4 TangentlOS153_g241416 = v.tangent;
					float4 temp_output_6_0_g241434 = TangentlOS153_g241416;
					float4 In_TangentOS16_g241434 = temp_output_6_0_g241434;
					float3 normalizeResult296_g241416 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241416 ) );
					half3 ViewDirWS169_g241416 = normalizeResult296_g241416;
					float3 In_ViewDirWS16_g241434 = ViewDirWS169_g241416;
					float4 appendResult397_g241416 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241416 = appendResult397_g241416;
					float4 In_CoordsData16_g241434 = CoordsData398_g241416;
					half4 VertexMasks171_g241416 = v.ase_color;
					float4 In_VertexData16_g241434 = VertexMasks171_g241416;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241428 = (PositionOS131_g241416).z;
					#else
					float staticSwitch65_g241428 = (PositionOS131_g241416).y;
					#endif
					half Object_HeightValue267_g241416 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241416 = saturate( ( staticSwitch65_g241428 / Object_HeightValue267_g241416 ) );
					half3 Position387_g241416 = PositionOS131_g241416;
					half Height387_g241416 = Object_HeightValue267_g241416;
					half Object_RadiusValue268_g241416 = _ObjectRadiusValue;
					half Radius387_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskYUp387_g241416 = CapsuleMaskYUp( Position387_g241416 , Height387_g241416 , Radius387_g241416 );
					half3 Position408_g241416 = PositionOS131_g241416;
					half Height408_g241416 = Object_HeightValue267_g241416;
					half Radius408_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskZUp408_g241416 = CapsuleMaskZUp( Position408_g241416 , Height408_g241416 , Radius408_g241416 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241433 = saturate( localCapsuleMaskZUp408_g241416 );
					#else
					float staticSwitch65_g241433 = saturate( localCapsuleMaskYUp387_g241416 );
					#endif
					half Bounds_SphereMask282_g241416 = staticSwitch65_g241433;
					float4 appendResult253_g241416 = (float4(Bounds_HeightMask274_g241416 , Bounds_SphereMask282_g241416 , 1.0 , 1.0));
					half4 MasksData254_g241416 = appendResult253_g241416;
					float4 In_MasksData16_g241434 = MasksData254_g241416;
					float temp_output_17_0_g241427 = _ObjectPhaseMode;
					float Option70_g241427 = temp_output_17_0_g241427;
					float4 temp_output_3_0_g241427 = v.ase_color;
					float4 Channel70_g241427 = temp_output_3_0_g241427;
					float localSwitchChannel470_g241427 = SwitchChannel4( Option70_g241427 , Channel70_g241427 );
					half Phase_Value372_g241416 = localSwitchChannel470_g241427;
					float3 break319_g241416 = PivotWO133_g241416;
					half Pivot_Position322_g241416 = ( break319_g241416.x + break319_g241416.z );
					half Phase_Position357_g241416 = ( Phase_Value372_g241416 + Pivot_Position322_g241416 );
					float temp_output_248_0_g241416 = frac( Phase_Position357_g241416 );
					float4 appendResult177_g241416 = (float4((frac( ( Phase_Position357_g241416 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241416));
					half4 Phase_Data176_g241416 = appendResult177_g241416;
					float4 In_PhaseData16_g241434 = Phase_Data176_g241416;
					BuildModelVertData( Data16_g241434 , In_Dummy16_g241434 , In_PositionOS16_g241434 , In_PositionWS16_g241434 , In_PositionWO16_g241434 , In_PivotOS16_g241434 , In_PivotWS16_g241434 , In_PivotWO16_g241434 , In_NormalOS16_g241434 , In_NormalWS16_g241434 , In_TangentOS16_g241434 , In_ViewDirWS16_g241434 , In_CoordsData16_g241434 , In_VertexData16_g241434 , In_MasksData16_g241434 , In_PhaseData16_g241434 );
					TVEModelData DataDefault26_g251465 = Data16_g241434;
					TVEModelData DataGeneral26_g251465 = Data16_g241434;
					TVEModelData DataBlanket26_g251465 = Data16_g241434;
					TVEModelData DataImpostor26_g251465 = Data16_g241434;
					TVEModelData Data16_g241414 =(TVEModelData)0;
					half Dummy207_g241396 = 0.0;
					float temp_output_14_0_g241414 = Dummy207_g241396;
					float In_Dummy16_g241414 = temp_output_14_0_g241414;
					float3 PositionOS131_g241396 = v.vertex.xyz;
					float3 temp_output_4_0_g241414 = PositionOS131_g241396;
					float3 In_PositionOS16_g241414 = temp_output_4_0_g241414;
					float3 temp_output_104_7_g241396 = ase_positionWS;
					float3 PositionWS122_g241396 = temp_output_104_7_g241396;
					float3 In_PositionWS16_g241414 = PositionWS122_g241396;
					float4x4 break19_g241399 = unity_ObjectToWorld;
					float3 appendResult20_g241399 = (float3(break19_g241399[ 0 ][ 3 ] , break19_g241399[ 1 ][ 3 ] , break19_g241399[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241396 = appendResult20_g241399;
					float3 PivotWS121_g241396 = temp_output_340_7_g241396;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241396 = ( PositionWS122_g241396 - PivotWS121_g241396 );
					#else
					float3 staticSwitch204_g241396 = PositionWS122_g241396;
					#endif
					float3 PositionWO132_g241396 = ( staticSwitch204_g241396 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241414 = PositionWO132_g241396;
					float3 PivotOS149_g241396 = _Vector0;
					float3 In_PivotOS16_g241414 = PivotOS149_g241396;
					float3 In_PivotWS16_g241414 = PivotWS121_g241396;
					float3 PivotWO133_g241396 = ( PivotWS121_g241396 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241414 = PivotWO133_g241396;
					half3 NormalOS134_g241396 = v.normal;
					float3 temp_output_21_0_g241414 = NormalOS134_g241396;
					float3 In_NormalOS16_g241414 = temp_output_21_0_g241414;
					half3 NormalWS95_g241396 = normalizedWorldNormal;
					float3 In_NormalWS16_g241414 = NormalWS95_g241396;
					float4 appendResult462_g241396 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241396 = appendResult462_g241396;
					float4 temp_output_6_0_g241414 = TangentlOS153_g241396;
					float4 In_TangentOS16_g241414 = temp_output_6_0_g241414;
					float3 normalizeResult296_g241396 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241396 ) );
					half3 ViewDirWS169_g241396 = normalizeResult296_g241396;
					float3 In_ViewDirWS16_g241414 = ViewDirWS169_g241396;
					float4 appendResult397_g241396 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241396 = appendResult397_g241396;
					float4 In_CoordsData16_g241414 = CoordsData398_g241396;
					half4 VertexMasks171_g241396 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241414 = VertexMasks171_g241396;
					half4 MasksData254_g241396 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241414 = MasksData254_g241396;
					half4 Phase_Data176_g241396 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241414 = Phase_Data176_g241396;
					BuildModelVertData( Data16_g241414 , In_Dummy16_g241414 , In_PositionOS16_g241414 , In_PositionWS16_g241414 , In_PositionWO16_g241414 , In_PivotOS16_g241414 , In_PivotWS16_g241414 , In_PivotWO16_g241414 , In_NormalOS16_g241414 , In_NormalWS16_g241414 , In_TangentOS16_g241414 , In_ViewDirWS16_g241414 , In_CoordsData16_g241414 , In_VertexData16_g241414 , In_MasksData16_g241414 , In_PhaseData16_g241414 );
					TVEModelData DataTerrain26_g251465 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251465 = IsShaderType2672;
					{
					if (Type26_g251465 == 0 )
					{
					Data26_g251465 = DataDefault26_g251465;
					}
					else if (Type26_g251465 == 1 )
					{
					Data26_g251465 = DataGeneral26_g251465;
					}
					else if (Type26_g251465 == 2 )
					{
					Data26_g251465 = DataBlanket26_g251465;
					}
					else if (Type26_g251465 == 3 )
					{
					Data26_g251465 = DataImpostor26_g251465;
					}
					else if (Type26_g251465 == 4 )
					{
					Data26_g251465 = DataTerrain26_g251465;
					}
					}
					TVEModelData Data15_g251973 =(TVEModelData)Data26_g251465;
					float Out_Dummy15_g251973 = 0.0;
					float3 Out_PositionOS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251973 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251973 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251973 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251973 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251973 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251973 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251973 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251973 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251973 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251973 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251973 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251973 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251973 , Out_Dummy15_g251973 , Out_PositionOS15_g251973 , Out_PositionWS15_g251973 , Out_PositionWO15_g251973 , Out_PositionRawOS15_g251973 , Out_PivotOS15_g251973 , Out_PivotWS15_g251973 , Out_PivotWO15_g251973 , Out_NormalOS15_g251973 , Out_NormalWS15_g251973 , Out_NormalRawOS15_g251973 , Out_TangentOS15_g251973 , Out_TangentWS15_g251973 , Out_BitangentWS15_g251973 , Out_ViewDirWS15_g251973 , Out_CoordsData15_g251973 , Out_VertexData15_g251973 , Out_MasksData15_g251973 , Out_PhaseData15_g251973 , Out_TransformData15_g251973 , Out_RotationData15_g251973 , Out_Interpolator15_g251973 );
					float3 In_PositionOS16_g251972 = Out_PositionOS15_g251973;
					float3 In_NormalOS16_g251972 = Out_NormalOS15_g251973;
					float4 In_TangentOS16_g251972 = Out_TangentOS15_g251973;
					float4 In_TransformData16_g251972 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251972 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251972 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251972 , In_Dummy16_g251972 , In_PositionOS16_g251972 , In_NormalOS16_g251972 , In_TangentOS16_g251972 , In_TransformData16_g251972 , In_RotationData16_g251972 , In_Interpolator16_g251972 );
					TVEVertexData Data15_g251975 =(TVEVertexData)Data16_g251972;
					float Out_Dummy15_g251975 = 0.0;
					float3 Out_PositionOS15_g251975 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251975 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251975 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251975 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251975 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251975 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251975 , Out_Dummy15_g251975 , Out_PositionOS15_g251975 , Out_NormalOS15_g251975 , Out_TangentOS15_g251975 , Out_TransformData15_g251975 , Out_RotationData15_g251975 , Out_Interpolator15_g251975 );
					TVEModelData Data15_g251976 =(TVEModelData)Data15_g251973;
					float Out_Dummy15_g251976 = 0.0;
					float3 Out_PositionOS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251976 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251976 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251976 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251976 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251976 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251976 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251976 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251976 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251976 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251976 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251976 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251976 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251976 , Out_Dummy15_g251976 , Out_PositionOS15_g251976 , Out_PositionWS15_g251976 , Out_PositionWO15_g251976 , Out_PositionRawOS15_g251976 , Out_PivotOS15_g251976 , Out_PivotWS15_g251976 , Out_PivotWO15_g251976 , Out_NormalOS15_g251976 , Out_NormalWS15_g251976 , Out_NormalRawOS15_g251976 , Out_TangentOS15_g251976 , Out_TangentWS15_g251976 , Out_BitangentWS15_g251976 , Out_ViewDirWS15_g251976 , Out_CoordsData15_g251976 , Out_VertexData15_g251976 , Out_MasksData15_g251976 , Out_PhaseData15_g251976 , Out_TransformData15_g251976 , Out_RotationData15_g251976 , Out_Interpolator15_g251976 );
					float3 In_PositionOS16_g251977 = ( Out_PositionOS15_g251975 - Out_PivotOS15_g251976 );
					float3 In_NormalOS16_g251977 = Out_NormalOS15_g251976;
					float4 In_TangentOS16_g251977 = Out_TangentOS15_g251976;
					float4 In_TransformData16_g251977 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251977 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251977 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251977 , In_Dummy16_g251977 , In_PositionOS16_g251977 , In_NormalOS16_g251977 , In_TangentOS16_g251977 , In_TransformData16_g251977 , In_RotationData16_g251977 , In_Interpolator16_g251977 );
					TVEVertexData Data15_g251986 =(TVEVertexData)Data16_g251977;
					float Out_Dummy15_g251986 = 0.0;
					float3 Out_PositionOS15_g251986 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251986 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251986 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251986 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251986 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251986 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251986 , Out_Dummy15_g251986 , Out_PositionOS15_g251986 , Out_NormalOS15_g251986 , Out_TangentOS15_g251986 , Out_TransformData15_g251986 , Out_RotationData15_g251986 , Out_Interpolator15_g251986 );
					TVEVertexData Data16_g251987 =(TVEVertexData)Data15_g251986;
					half Dummy317_g251978 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251987 = Dummy317_g251978;
					float3 In_PositionOS16_g251987 = Out_PositionOS15_g251986;
					float3 In_NormalOS16_g251987 = Out_NormalOS15_g251986;
					float4 In_TangentOS16_g251987 = Out_TangentOS15_g251986;
					half4 Model_TransformData356_g251978 = Out_TransformData15_g251986;
					float localBuildGlobalData204_g251364 = ( 0.0 );
					TVEGlobalData Data204_g251364 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251364 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251364 = Dummy211_g251364;
					float4 temp_output_203_0_g251383 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241424 =(TVEModelData)0;
					float In_Dummy16_g241424 = 0.0;
					float3 In_PositionWS16_g241424 = PositionWS122_g241416;
					float3 In_PositionWO16_g241424 = PositionWO132_g241416;
					float3 In_PivotWS16_g241424 = PivotWS121_g241416;
					float3 In_PivotWO16_g241424 = PivotWO133_g241416;
					float3 In_NormalWS16_g241424 = NormalWS95_g241416;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241416 = ase_tangentWS;
					float3 In_TangentWS16_g241424 = TangentWS136_g241416;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241416 = ase_bitangentWS;
					float3 In_BitangentWS16_g241424 = BiangentWS421_g241416;
					half3 NormalWS427_g241416 = NormalWS95_g241416;
					half3 localComputeTriplanarMasks427_g241416 = ComputeTriplanarMasks( NormalWS427_g241416 );
					half3 TriplanarWeights429_g241416 = localComputeTriplanarMasks427_g241416;
					float3 In_TriplanarWeights16_g241424 = TriplanarWeights429_g241416;
					float3 In_ViewDirWS16_g241424 = ViewDirWS169_g241416;
					float4 In_CoordsData16_g241424 = CoordsData398_g241416;
					float4 In_VertexData16_g241424 = VertexMasks171_g241416;
					float4 In_Interpolator16_g241424 = Phase_Data176_g241416;
					BuildModelFragData( Data16_g241424 , In_Dummy16_g241424 , In_PositionWS16_g241424 , In_PositionWO16_g241424 , In_PivotWS16_g241424 , In_PivotWO16_g241424 , In_NormalWS16_g241424 , In_TangentWS16_g241424 , In_BitangentWS16_g241424 , In_TriplanarWeights16_g241424 , In_ViewDirWS16_g241424 , In_CoordsData16_g241424 , In_VertexData16_g241424 , In_Interpolator16_g241424 );
					TVEModelData DataDefault26_g241395 = Data16_g241424;
					TVEModelData DataGeneral26_g241395 = Data16_g241424;
					TVEModelData DataBlanket26_g241395 = Data16_g241424;
					TVEModelData DataImpostor26_g241395 = Data16_g241424;
					TVEModelData Data16_g241404 =(TVEModelData)0;
					float In_Dummy16_g241404 = 0.0;
					float3 In_PositionWS16_g241404 = PositionWS122_g241396;
					float3 In_PositionWO16_g241404 = PositionWO132_g241396;
					float3 In_PivotWS16_g241404 = PivotWS121_g241396;
					float3 In_PivotWO16_g241404 = PivotWO133_g241396;
					float3 In_NormalWS16_g241404 = NormalWS95_g241396;
					half3 TangentWS136_g241396 = ase_tangentWS;
					float3 In_TangentWS16_g241404 = TangentWS136_g241396;
					half3 BiangentWS421_g241396 = ase_bitangentWS;
					float3 In_BitangentWS16_g241404 = BiangentWS421_g241396;
					half3 NormalWS427_g241396 = NormalWS95_g241396;
					half3 localComputeTriplanarMasks427_g241396 = ComputeTriplanarMasks( NormalWS427_g241396 );
					half3 TriplanarWeights429_g241396 = localComputeTriplanarMasks427_g241396;
					float3 In_TriplanarWeights16_g241404 = TriplanarWeights429_g241396;
					float3 In_ViewDirWS16_g241404 = ViewDirWS169_g241396;
					float4 In_CoordsData16_g241404 = CoordsData398_g241396;
					float4 In_VertexData16_g241404 = VertexMasks171_g241396;
					float4 In_Interpolator16_g241404 = Phase_Data176_g241396;
					BuildModelFragData( Data16_g241404 , In_Dummy16_g241404 , In_PositionWS16_g241404 , In_PositionWO16_g241404 , In_PivotWS16_g241404 , In_PivotWO16_g241404 , In_NormalWS16_g241404 , In_TangentWS16_g241404 , In_BitangentWS16_g241404 , In_TriplanarWeights16_g241404 , In_ViewDirWS16_g241404 , In_CoordsData16_g241404 , In_VertexData16_g241404 , In_Interpolator16_g241404 );
					TVEModelData DataTerrain26_g241395 = Data16_g241404;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251454 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251454 = 0.0;
					float3 Out_PositionWS15_g251454 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251454 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251454 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251454 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251454 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251454 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251454 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251454 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251454 , Out_Dummy15_g251454 , Out_PositionWS15_g251454 , Out_PositionWO15_g251454 , Out_PivotWS15_g251454 , Out_PivotWO15_g251454 , Out_NormalWS15_g251454 , Out_TangentWS15_g251454 , Out_BitangentWS15_g251454 , Out_TriplanarWeights15_g251454 , Out_ViewDirWS15_g251454 , Out_CoordsData15_g251454 , Out_VertexData15_g251454 , Out_Interpolator15_g251454 );
					float3 Model_PositionWS497_g251364 = Out_PositionWS15_g251454;
					float2 Model_PositionWS_XZ143_g251364 = (Model_PositionWS497_g251364).xz;
					float3 Model_PivotWS498_g251364 = Out_PivotWS15_g251454;
					float2 Model_PivotWS_XZ145_g251364 = (Model_PivotWS498_g251364).xz;
					float2 lerpResult300_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251383 = lerpResult300_g251364;
					float temp_output_82_0_g251381 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251383 = temp_output_82_0_g251381;
					float4 tex2DArrayNode83_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251383).zw + ( (temp_output_203_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult210_g251383 = (float4(tex2DArrayNode83_g251383.rgb , tex2DArrayNode83_g251383.a));
					float4 temp_output_204_0_g251383 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251383).zw + ( (temp_output_204_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult212_g251383 = (float4(tex2DArrayNode122_g251383.rgb , tex2DArrayNode122_g251383.a));
					float4 TVE_RenderNearPositionR628_g251364 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251364 = saturate( ( distance( Model_PositionWS497_g251364 , (TVE_RenderNearPositionR628_g251364).xyz ) / (TVE_RenderNearPositionR628_g251364).w ) );
					float temp_output_7_0_g251453 = 1.0;
					float temp_output_9_0_g251453 = ( temp_output_507_0_g251364 - temp_output_7_0_g251453 );
					half TVE_RenderNearFadeValue635_g251364 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251364 = saturate( ( temp_output_9_0_g251453 / ( ( TVE_RenderNearFadeValue635_g251364 - temp_output_7_0_g251453 ) + 0.0001 ) ) );
					float4 lerpResult131_g251383 = lerp( appendResult210_g251383 , appendResult212_g251383 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251381 = lerpResult131_g251383;
					float4 lerpResult168_g251381 = lerp( TVE_CoatParams , temp_output_159_109_g251381 , TVE_CoatLayers[(int)temp_output_82_0_g251381]);
					float4 temp_output_589_109_g251364 = lerpResult168_g251381;
					half4 Coat_Texture302_g251364 = temp_output_589_109_g251364;
					float4 In_CoatTexture204_g251364 = Coat_Texture302_g251364;
					half4 Draw_Texture656_g251364 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251364 = Draw_Texture656_g251364;
					float4 temp_output_203_0_g251408 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251408 = lerpResult85_g251364;
					float temp_output_82_0_g251405 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251408 = temp_output_82_0_g251405;
					float4 tex2DArrayNode83_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251408).zw + ( (temp_output_203_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult210_g251408 = (float4(tex2DArrayNode83_g251408.rgb , tex2DArrayNode83_g251408.a));
					float4 temp_output_204_0_g251408 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251408).zw + ( (temp_output_204_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult212_g251408 = (float4(tex2DArrayNode122_g251408.rgb , tex2DArrayNode122_g251408.a));
					float4 lerpResult131_g251408 = lerp( appendResult210_g251408 , appendResult212_g251408 , Global_TexBlend509_g251364);
					float4 temp_output_171_109_g251405 = lerpResult131_g251408;
					float4 lerpResult174_g251405 = lerp( TVE_PaintParams , temp_output_171_109_g251405 , TVE_PaintLayers[(int)temp_output_82_0_g251405]);
					float4 temp_output_595_109_g251364 = lerpResult174_g251405;
					half4 Paint_Texture71_g251364 = temp_output_595_109_g251364;
					float4 In_PaintTexture204_g251364 = Paint_Texture71_g251364;
					float4 temp_output_203_0_g251391 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251391 = lerpResult104_g251364;
					float temp_output_132_0_g251389 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251391 = temp_output_132_0_g251389;
					float4 tex2DArrayNode83_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251391).zw + ( (temp_output_203_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult210_g251391 = (float4(tex2DArrayNode83_g251391.rgb , tex2DArrayNode83_g251391.a));
					float4 temp_output_204_0_g251391 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251391).zw + ( (temp_output_204_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult212_g251391 = (float4(tex2DArrayNode122_g251391.rgb , tex2DArrayNode122_g251391.a));
					float4 lerpResult131_g251391 = lerp( appendResult210_g251391 , appendResult212_g251391 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251389 = lerpResult131_g251391;
					float4 lerpResult145_g251389 = lerp( TVE_AtmoParams , temp_output_137_109_g251389 , TVE_AtmoLayers[(int)temp_output_132_0_g251389]);
					float4 temp_output_590_110_g251364 = lerpResult145_g251389;
					half4 Atmo_Texture80_g251364 = temp_output_590_110_g251364;
					float4 In_AtmoTexture204_g251364 = Atmo_Texture80_g251364;
					float4 temp_output_203_0_g251459 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251459 = lerpResult414_g251364;
					float temp_output_132_0_g251457 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251459 = temp_output_132_0_g251457;
					float4 tex2DArrayNode83_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251459).zw + ( (temp_output_203_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult210_g251459 = (float4(tex2DArrayNode83_g251459.rgb , tex2DArrayNode83_g251459.a));
					float4 temp_output_204_0_g251459 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251459).zw + ( (temp_output_204_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult212_g251459 = (float4(tex2DArrayNode122_g251459.rgb , tex2DArrayNode122_g251459.a));
					float4 lerpResult131_g251459 = lerp( appendResult210_g251459 , appendResult212_g251459 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251457 = lerpResult131_g251459;
					float4 lerpResult145_g251457 = lerp( TVE_EffexParams , temp_output_137_109_g251457 , TVE_EffexLayers[(int)temp_output_132_0_g251457]);
					float4 temp_output_731_110_g251364 = lerpResult145_g251457;
					half4 Effex_Texture420_g251364 = temp_output_731_110_g251364;
					float4 In_EffexTexture204_g251364 = Effex_Texture420_g251364;
					float4 temp_output_203_0_g251439 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251439 = lerpResult247_g251364;
					float temp_output_82_0_g251437 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251439 = temp_output_82_0_g251437;
					float4 tex2DArrayNode83_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251439).zw + ( (temp_output_203_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult210_g251439 = (float4(tex2DArrayNode83_g251439.rgb , tex2DArrayNode83_g251439.a));
					float4 temp_output_204_0_g251439 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251439).zw + ( (temp_output_204_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult212_g251439 = (float4(tex2DArrayNode122_g251439.rgb , tex2DArrayNode122_g251439.a));
					float4 lerpResult131_g251439 = lerp( appendResult210_g251439 , appendResult212_g251439 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251437 = lerpResult131_g251439;
					float4 lerpResult167_g251437 = lerp( TVE_GlowParams , temp_output_159_109_g251437 , TVE_GlowLayers[(int)temp_output_82_0_g251437]);
					float4 temp_output_593_109_g251364 = lerpResult167_g251437;
					half4 Glow_Texture248_g251364 = temp_output_593_109_g251364;
					float4 In_GlowTexture204_g251364 = Glow_Texture248_g251364;
					float4 temp_output_203_0_g251375 = TVE_FormBaseCoord;
					float2 lerpResult168_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251375 = lerpResult168_g251364;
					float temp_output_130_0_g251373 = _GlobalFormLayerValue;
					float temp_output_82_0_g251375 = temp_output_130_0_g251373;
					float4 tex2DArrayNode83_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251375).zw + ( (temp_output_203_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult210_g251375 = (float4(tex2DArrayNode83_g251375.rgb , tex2DArrayNode83_g251375.a));
					float4 temp_output_204_0_g251375 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251375).zw + ( (temp_output_204_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult212_g251375 = (float4(tex2DArrayNode122_g251375.rgb , tex2DArrayNode122_g251375.a));
					float4 lerpResult131_g251375 = lerp( appendResult210_g251375 , appendResult212_g251375 , Global_TexBlend509_g251364);
					float4 temp_output_135_109_g251373 = lerpResult131_g251375;
					float4 lerpResult143_g251373 = lerp( TVE_FormParams , temp_output_135_109_g251373 , TVE_FormLayers[(int)temp_output_130_0_g251373]);
					float4 temp_output_592_0_g251364 = lerpResult143_g251373;
					float4 Form_Texture112_g251364 = temp_output_592_0_g251364;
					float4 In_FormTexture204_g251364 = Form_Texture112_g251364;
					float4 In_LandTexture204_g251364 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251423 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251423 = lerpResult681_g251364;
					float temp_output_136_0_g251421 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251423 = temp_output_136_0_g251421;
					float4 tex2DArrayNode83_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251423).zw + ( (temp_output_203_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult210_g251423 = (float4(tex2DArrayNode83_g251423.rgb , tex2DArrayNode83_g251423.a));
					float4 temp_output_204_0_g251423 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251423).zw + ( (temp_output_204_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult212_g251423 = (float4(tex2DArrayNode122_g251423.rgb , tex2DArrayNode122_g251423.a));
					float4 lerpResult131_g251423 = lerp( appendResult210_g251423 , appendResult212_g251423 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251421 = lerpResult131_g251423;
					float4 lerpResult149_g251421 = lerp( TVE_VertxParams , temp_output_141_109_g251421 , TVE_VertxLayers[(int)temp_output_136_0_g251421]);
					float4 temp_output_695_0_g251364 = lerpResult149_g251421;
					half4 Vertx_Texture693_g251364 = temp_output_695_0_g251364;
					float4 In_VertxTexture204_g251364 = Vertx_Texture693_g251364;
					float4 temp_output_203_0_g251399 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251399 = lerpResult400_g251364;
					float temp_output_136_0_g251397 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251399 = temp_output_136_0_g251397;
					float4 tex2DArrayNode83_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251399).zw + ( (temp_output_203_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult210_g251399 = (float4(tex2DArrayNode83_g251399.rgb , tex2DArrayNode83_g251399.a));
					float4 temp_output_204_0_g251399 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251399).zw + ( (temp_output_204_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult212_g251399 = (float4(tex2DArrayNode122_g251399.rgb , tex2DArrayNode122_g251399.a));
					float4 lerpResult131_g251399 = lerp( appendResult210_g251399 , appendResult212_g251399 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251397 = lerpResult131_g251399;
					float4 lerpResult149_g251397 = lerp( TVE_FlowParams , temp_output_141_109_g251397 , TVE_FlowLayers[(int)temp_output_136_0_g251397]);
					float4 temp_output_594_0_g251364 = lerpResult149_g251397;
					half4 Flow_Texture405_g251364 = temp_output_594_0_g251364;
					float4 In_FlowTexture204_g251364 = Flow_Texture405_g251364;
					half4 User_Texture677_g251364 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251364 = User_Texture677_g251364;
					BuildGlobalData( Data204_g251364 , In_Dummy204_g251364 , In_CoatTexture204_g251364 , In_DrawTexture204_g251364 , In_PaintTexture204_g251364 , In_AtmoTexture204_g251364 , In_EffexTexture204_g251364 , In_GlowTexture204_g251364 , In_FormTexture204_g251364 , In_LandTexture204_g251364 , In_VertxTexture204_g251364 , In_FlowTexture204_g251364 , In_UserTexture204_g251364 );
					TVEGlobalData Data15_g251988 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251988 = 0.0;
					float4 Out_CoatTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251988 = float4( 0,0,0,0 );
					BreakData( Data15_g251988 , Out_Dummy15_g251988 , Out_CoatTexture15_g251988 , Out_DrawTexture15_g251988 , Out_PaintTexture15_g251988 , Out_AtmoTexture15_g251988 , Out_EffexTexture15_g251988 , Out_GlowTexture15_g251988 , Out_FormTexture15_g251988 , Out_LandTexture15_g251988 , Out_VertxTexture15_g251988 , Out_FlowTexture15_g251988 , Out_UserTexture15_g251988 );
					float4 Global_FormTexture351_g251978 = Out_FormTexture15_g251988;
					TVEModelData Data15_g251985 =(TVEModelData)Data15_g251976;
					float Out_Dummy15_g251985 = 0.0;
					float3 Out_PositionOS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251985 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251985 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251985 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251985 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251985 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251985 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251985 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251985 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251985 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251985 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251985 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251985 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251985 , Out_Dummy15_g251985 , Out_PositionOS15_g251985 , Out_PositionWS15_g251985 , Out_PositionWO15_g251985 , Out_PositionRawOS15_g251985 , Out_PivotOS15_g251985 , Out_PivotWS15_g251985 , Out_PivotWO15_g251985 , Out_NormalOS15_g251985 , Out_NormalWS15_g251985 , Out_NormalRawOS15_g251985 , Out_TangentOS15_g251985 , Out_TangentWS15_g251985 , Out_BitangentWS15_g251985 , Out_ViewDirWS15_g251985 , Out_CoordsData15_g251985 , Out_VertexData15_g251985 , Out_MasksData15_g251985 , Out_PhaseData15_g251985 , Out_TransformData15_g251985 , Out_RotationData15_g251985 , Out_Interpolator15_g251985 );
					float3 Model_PivotWO353_g251978 = Out_PivotWO15_g251985;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251984 = _ConformMeshMode;
					float Option70_g251984 = temp_output_17_0_g251984;
					half4 Model_VertexData357_g251978 = Out_VertexData15_g251985;
					float4 temp_output_3_0_g251984 = Model_VertexData357_g251978;
					float4 Channel70_g251984 = temp_output_3_0_g251984;
					float localSwitchChannel470_g251984 = SwitchChannel4( Option70_g251984 , Channel70_g251984 );
					float temp_output_390_0_g251978 = localSwitchChannel470_g251984;
					float temp_output_7_0_g251981 = _ConformMeshRemap.x;
					float temp_output_9_0_g251981 = ( temp_output_390_0_g251978 - temp_output_7_0_g251981 );
					float lerpResult374_g251978 = lerp( 1.0 , saturate( ( temp_output_9_0_g251981 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251978 = lerpResult374_g251978;
					float temp_output_328_0_g251978 = ( Blend_VertMask379_g251978 * TVE_IsEnabled );
					half Conform_Mask366_g251978 = temp_output_328_0_g251978;
					float temp_output_322_0_g251978 = ( ( ( ( (Global_FormTexture351_g251978).z - ( (Model_PivotWO353_g251978).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251978 ) );
					float3 appendResult329_g251978 = (float3(0.0 , temp_output_322_0_g251978 , 0.0));
					float3 appendResult387_g251978 = (float3(0.0 , 0.0 , temp_output_322_0_g251978));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251982 = appendResult387_g251978;
					#else
					float3 staticSwitch65_g251982 = appendResult329_g251978;
					#endif
					float3 Blanket_Conform368_g251978 = staticSwitch65_g251982;
					float4 appendResult312_g251978 = (float4(Blanket_Conform368_g251978 , 0.0));
					float4 temp_output_310_0_g251978 = ( Model_TransformData356_g251978 + appendResult312_g251978 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251978 = temp_output_310_0_g251978;
					#else
					float4 staticSwitch364_g251978 = Model_TransformData356_g251978;
					#endif
					half4 Final_TransformData365_g251978 = staticSwitch364_g251978;
					float4 In_TransformData16_g251987 = Final_TransformData365_g251978;
					float4 In_RotationData16_g251987 = Out_RotationData15_g251986;
					float4 In_Interpolator16_g251987 = Out_Interpolator15_g251986;
					BuildVertexData( Data16_g251987 , In_Dummy16_g251987 , In_PositionOS16_g251987 , In_NormalOS16_g251987 , In_TangentOS16_g251987 , In_TransformData16_g251987 , In_RotationData16_g251987 , In_Interpolator16_g251987 );
					TVEVertexData Data15_g251998 =(TVEVertexData)Data16_g251987;
					float Out_Dummy15_g251998 = 0.0;
					float3 Out_PositionOS15_g251998 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251998 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251998 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251998 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251998 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251998 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251998 , Out_Dummy15_g251998 , Out_PositionOS15_g251998 , Out_NormalOS15_g251998 , Out_TangentOS15_g251998 , Out_TransformData15_g251998 , Out_RotationData15_g251998 , Out_Interpolator15_g251998 );
					TVEVertexData Data16_g251999 =(TVEVertexData)Data15_g251998;
					float In_Dummy16_g251999 = 0.0;
					float3 Vertex_PositionOS147_g251989 = Out_PositionOS15_g251998;
					half3 VertexPos40_g251993 = Vertex_PositionOS147_g251989;
					float4 temp_output_1615_33_g251989 = Out_RotationData15_g251998;
					half4 Vertex_RotationData1569_g251989 = temp_output_1615_33_g251989;
					float2 break1582_g251989 = (Vertex_RotationData1569_g251989).xy;
					half Angle44_g251993 = break1582_g251989.y;
					half CosAngle89_g251993 = cos( Angle44_g251993 );
					half SinAngle93_g251993 = sin( Angle44_g251993 );
					float3 appendResult95_g251993 = (float3((VertexPos40_g251993).x , ( ( (VertexPos40_g251993).y * CosAngle89_g251993 ) - ( (VertexPos40_g251993).z * SinAngle93_g251993 ) ) , ( ( (VertexPos40_g251993).y * SinAngle93_g251993 ) + ( (VertexPos40_g251993).z * CosAngle89_g251993 ) )));
					half3 VertexPos40_g251994 = appendResult95_g251993;
					half Angle44_g251994 = -break1582_g251989.x;
					half CosAngle94_g251994 = cos( Angle44_g251994 );
					half SinAngle95_g251994 = sin( Angle44_g251994 );
					float3 appendResult98_g251994 = (float3(( ( (VertexPos40_g251994).x * CosAngle94_g251994 ) - ( (VertexPos40_g251994).y * SinAngle95_g251994 ) ) , ( ( (VertexPos40_g251994).x * SinAngle95_g251994 ) + ( (VertexPos40_g251994).y * CosAngle94_g251994 ) ) , (VertexPos40_g251994).z));
					half3 VertexPos40_g251992 = Vertex_PositionOS147_g251989;
					half Angle44_g251992 = break1582_g251989.y;
					half CosAngle89_g251992 = cos( Angle44_g251992 );
					half SinAngle93_g251992 = sin( Angle44_g251992 );
					float3 appendResult95_g251992 = (float3((VertexPos40_g251992).x , ( ( (VertexPos40_g251992).y * CosAngle89_g251992 ) - ( (VertexPos40_g251992).z * SinAngle93_g251992 ) ) , ( ( (VertexPos40_g251992).y * SinAngle93_g251992 ) + ( (VertexPos40_g251992).z * CosAngle89_g251992 ) )));
					half3 VertexPos40_g251997 = appendResult95_g251992;
					half Angle44_g251997 = break1582_g251989.x;
					half CosAngle91_g251997 = cos( Angle44_g251997 );
					half SinAngle92_g251997 = sin( Angle44_g251997 );
					float3 appendResult93_g251997 = (float3(( ( (VertexPos40_g251997).x * CosAngle91_g251997 ) + ( (VertexPos40_g251997).z * SinAngle92_g251997 ) ) , (VertexPos40_g251997).y , ( ( -(VertexPos40_g251997).x * SinAngle92_g251997 ) + ( (VertexPos40_g251997).z * CosAngle91_g251997 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251995 = appendResult93_g251997;
					#else
					float3 staticSwitch65_g251995 = appendResult98_g251994;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251990 = staticSwitch65_g251995;
					#else
					float3 staticSwitch65_g251990 = Vertex_PositionOS147_g251989;
					#endif
					float3 temp_output_1608_0_g251989 = staticSwitch65_g251990;
					half3 VertexPos40_g251996 = temp_output_1608_0_g251989;
					half Angle44_g251996 = (Vertex_RotationData1569_g251989).z;
					half CosAngle91_g251996 = cos( Angle44_g251996 );
					half SinAngle92_g251996 = sin( Angle44_g251996 );
					float3 appendResult93_g251996 = (float3(( ( (VertexPos40_g251996).x * CosAngle91_g251996 ) + ( (VertexPos40_g251996).z * SinAngle92_g251996 ) ) , (VertexPos40_g251996).y , ( ( -(VertexPos40_g251996).x * SinAngle92_g251996 ) + ( (VertexPos40_g251996).z * CosAngle91_g251996 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251991 = appendResult93_g251996;
					#else
					float3 staticSwitch65_g251991 = temp_output_1608_0_g251989;
					#endif
					float4 temp_output_1615_31_g251989 = Out_TransformData15_g251998;
					half4 Vertex_TransformData1568_g251989 = temp_output_1615_31_g251989;
					half3 Final_PositionOS178_g251989 = ( ( staticSwitch65_g251991 * (Vertex_TransformData1568_g251989).w ) + (Vertex_TransformData1568_g251989).xyz );
					float3 In_PositionOS16_g251999 = Final_PositionOS178_g251989;
					float3 In_NormalOS16_g251999 = Out_NormalOS15_g251998;
					float4 In_TangentOS16_g251999 = Out_TangentOS15_g251998;
					float4 In_TransformData16_g251999 = temp_output_1615_31_g251989;
					float4 In_RotationData16_g251999 = temp_output_1615_33_g251989;
					float4 In_Interpolator16_g251999 = Out_Interpolator15_g251998;
					BuildVertexData( Data16_g251999 , In_Dummy16_g251999 , In_PositionOS16_g251999 , In_NormalOS16_g251999 , In_TangentOS16_g251999 , In_TransformData16_g251999 , In_RotationData16_g251999 , In_Interpolator16_g251999 );
					TVEVertexData Data15_g252002 =(TVEVertexData)Data16_g251999;
					float Out_Dummy15_g252002 = 0.0;
					float3 Out_PositionOS15_g252002 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252002 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252002 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252002 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252002 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252002 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252002 , Out_Dummy15_g252002 , Out_PositionOS15_g252002 , Out_NormalOS15_g252002 , Out_TangentOS15_g252002 , Out_TransformData15_g252002 , Out_RotationData15_g252002 , Out_Interpolator15_g252002 );
					TVEVertexData Data16_g252003 =(TVEVertexData)Data15_g252002;
					float In_Dummy16_g252003 = 0.0;
					TVEModelData Data15_g252001 =(TVEModelData)Data15_g251985;
					float Out_Dummy15_g252001 = 0.0;
					float3 Out_PositionOS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252001 , Out_Dummy15_g252001 , Out_PositionOS15_g252001 , Out_PositionWS15_g252001 , Out_PositionWO15_g252001 , Out_PositionRawOS15_g252001 , Out_PivotOS15_g252001 , Out_PivotWS15_g252001 , Out_PivotWO15_g252001 , Out_NormalOS15_g252001 , Out_NormalWS15_g252001 , Out_NormalRawOS15_g252001 , Out_TangentOS15_g252001 , Out_TangentWS15_g252001 , Out_BitangentWS15_g252001 , Out_ViewDirWS15_g252001 , Out_CoordsData15_g252001 , Out_VertexData15_g252001 , Out_MasksData15_g252001 , Out_PhaseData15_g252001 , Out_TransformData15_g252001 , Out_RotationData15_g252001 , Out_Interpolator15_g252001 );
					float3 In_PositionOS16_g252003 = ( Out_PositionOS15_g252002 + Out_PivotOS15_g252001 );
					float3 In_NormalOS16_g252003 = Out_NormalOS15_g252002;
					float4 In_TangentOS16_g252003 = Out_TangentOS15_g252002;
					float4 In_TransformData16_g252003 = Out_TransformData15_g252002;
					float4 In_RotationData16_g252003 = Out_RotationData15_g252002;
					float4 In_Interpolator16_g252003 = Out_Interpolator15_g252002;
					BuildVertexData( Data16_g252003 , In_Dummy16_g252003 , In_PositionOS16_g252003 , In_NormalOS16_g252003 , In_TangentOS16_g252003 , In_TransformData16_g252003 , In_RotationData16_g252003 , In_Interpolator16_g252003 );
					TVEVertexData Data15_g254769 =(TVEVertexData)Data16_g252003;
					float Out_Dummy15_g254769 = 0.0;
					float3 Out_PositionOS15_g254769 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254769 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254769 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254769 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254769 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254769 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254769 , Out_Dummy15_g254769 , Out_PositionOS15_g254769 , Out_NormalOS15_g254769 , Out_TangentOS15_g254769 , Out_TransformData15_g254769 , Out_RotationData15_g254769 , Out_Interpolator15_g254769 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g254769;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254769;
					v.tangent = Out_TangentOS15_g254769;

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
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
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
				#if defined (TVE_TERRAIN_HOLES) //Terrain Holes
					#define TVE_ALPHA_CLIP //Terrain Holes
				#endif //Terrain Holes
				  
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

				uniform half _TerrainSampleMode6;
				uniform half _TerrainSampleMode7;
				uniform half _TerrainSampleMode8;
				uniform half _TerrainSampleMode5;
				uniform half _TerrainSampleMode10;
				uniform half _TerrainSampleMode11;
				uniform half _TerrainSampleMode12;
				uniform half _TerrainSampleMode9;
				uniform half _TerrainSampleMode14;
				uniform half _TerrainSampleMode15;
				uniform half _TerrainSampleMode16;
				uniform half _TerrainSampleMode13;
				uniform half _TerrainSampleMode2;
				uniform half _TerrainSampleMode3;
				uniform half _TerrainSampleMode4;
				uniform half _TerrainSampleMode1;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainFeatureTex);
				SamplerState sampler_TerrainFeatureTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainShaderTex);
				SamplerState sampler_TerrainShaderTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainNormalTex);
				SamplerState sampler_TerrainNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_TerrainAlbedoTex);
				SamplerState sampler_TerrainAlbedoTex;
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
				uniform float _IsShaderType;
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

					TVEVertexData Data16_g251977 =(TVEVertexData)0;
					float In_Dummy16_g251977 = 0.0;
					TVEVertexData Data16_g251972 =(TVEVertexData)0;
					float In_Dummy16_g251972 = 0.0;
					float localIfModelDataByShader26_g251465 = ( 0.0 );
					TVEModelData Data26_g251465 = (TVEModelData)0;
					TVEModelData Data16_g241434 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241416 = _ObjectCoordMode;
					#endif
					half Dummy207_g241416 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241416 );
					float temp_output_14_0_g241434 = Dummy207_g241416;
					float In_Dummy16_g241434 = temp_output_14_0_g241434;
					float3 PositionOS131_g241416 = v.vertex.xyz;
					float3 temp_output_4_0_g241434 = PositionOS131_g241416;
					float3 In_PositionOS16_g241434 = temp_output_4_0_g241434;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241416 = ase_positionWS;
					float3 vertexToFrag73_g241416 = temp_output_104_7_g241416;
					float3 PositionWS122_g241416 = vertexToFrag73_g241416;
					float3 In_PositionWS16_g241434 = PositionWS122_g241416;
					float4x4 break19_g241419 = unity_ObjectToWorld;
					float3 appendResult20_g241419 = (float3(break19_g241419[ 0 ][ 3 ] , break19_g241419[ 1 ][ 3 ] , break19_g241419[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241416 = appendResult20_g241419;
					float4x4 break19_g241421 = unity_ObjectToWorld;
					float3 appendResult20_g241421 = (float3(break19_g241421[ 0 ][ 3 ] , break19_g241421[ 1 ][ 3 ] , break19_g241421[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241417 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241416 = PositionOS131_g241416;
					float3 appendResult234_g241416 = (float3(break233_g241416.x , 0.0 , break233_g241416.z));
					float3 break413_g241416 = PositionOS131_g241416;
					float3 appendResult414_g241416 = (float3(break413_g241416.x , break413_g241416.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241423 = appendResult414_g241416;
					#else
					float3 staticSwitch65_g241423 = appendResult234_g241416;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241416 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241416 = appendResult60_g241417;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241416 = staticSwitch65_g241423;
					#else
					float3 staticSwitch229_g241416 = _Vector0;
					#endif
					float3 PivotOS149_g241416 = staticSwitch229_g241416;
					float3 temp_output_122_0_g241421 = PivotOS149_g241416;
					float3 PivotsOnlyWS105_g241421 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241421 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241416 = ( appendResult20_g241421 + PivotsOnlyWS105_g241421 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241416 = temp_output_341_7_g241416;
					#else
					float3 staticSwitch236_g241416 = temp_output_340_7_g241416;
					#endif
					float3 vertexToFrag76_g241416 = staticSwitch236_g241416;
					float3 PivotWS121_g241416 = vertexToFrag76_g241416;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241416 = ( PositionWS122_g241416 - PivotWS121_g241416 );
					#else
					float3 staticSwitch204_g241416 = PositionWS122_g241416;
					#endif
					float3 PositionWO132_g241416 = ( staticSwitch204_g241416 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241434 = PositionWO132_g241416;
					float3 In_PivotOS16_g241434 = PivotOS149_g241416;
					float3 In_PivotWS16_g241434 = PivotWS121_g241416;
					float3 PivotWO133_g241416 = ( PivotWS121_g241416 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241434 = PivotWO133_g241416;
					half3 NormalOS134_g241416 = v.normal;
					float3 temp_output_21_0_g241434 = NormalOS134_g241416;
					float3 In_NormalOS16_g241434 = temp_output_21_0_g241434;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241416 = normalizedWorldNormal;
					float3 In_NormalWS16_g241434 = NormalWS95_g241416;
					half4 TangentlOS153_g241416 = v.tangent;
					float4 temp_output_6_0_g241434 = TangentlOS153_g241416;
					float4 In_TangentOS16_g241434 = temp_output_6_0_g241434;
					float3 normalizeResult296_g241416 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241416 ) );
					half3 ViewDirWS169_g241416 = normalizeResult296_g241416;
					float3 In_ViewDirWS16_g241434 = ViewDirWS169_g241416;
					float4 appendResult397_g241416 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241416 = appendResult397_g241416;
					float4 In_CoordsData16_g241434 = CoordsData398_g241416;
					half4 VertexMasks171_g241416 = v.ase_color;
					float4 In_VertexData16_g241434 = VertexMasks171_g241416;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241428 = (PositionOS131_g241416).z;
					#else
					float staticSwitch65_g241428 = (PositionOS131_g241416).y;
					#endif
					half Object_HeightValue267_g241416 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241416 = saturate( ( staticSwitch65_g241428 / Object_HeightValue267_g241416 ) );
					half3 Position387_g241416 = PositionOS131_g241416;
					half Height387_g241416 = Object_HeightValue267_g241416;
					half Object_RadiusValue268_g241416 = _ObjectRadiusValue;
					half Radius387_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskYUp387_g241416 = CapsuleMaskYUp( Position387_g241416 , Height387_g241416 , Radius387_g241416 );
					half3 Position408_g241416 = PositionOS131_g241416;
					half Height408_g241416 = Object_HeightValue267_g241416;
					half Radius408_g241416 = Object_RadiusValue268_g241416;
					half localCapsuleMaskZUp408_g241416 = CapsuleMaskZUp( Position408_g241416 , Height408_g241416 , Radius408_g241416 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241433 = saturate( localCapsuleMaskZUp408_g241416 );
					#else
					float staticSwitch65_g241433 = saturate( localCapsuleMaskYUp387_g241416 );
					#endif
					half Bounds_SphereMask282_g241416 = staticSwitch65_g241433;
					float4 appendResult253_g241416 = (float4(Bounds_HeightMask274_g241416 , Bounds_SphereMask282_g241416 , 1.0 , 1.0));
					half4 MasksData254_g241416 = appendResult253_g241416;
					float4 In_MasksData16_g241434 = MasksData254_g241416;
					float temp_output_17_0_g241427 = _ObjectPhaseMode;
					float Option70_g241427 = temp_output_17_0_g241427;
					float4 temp_output_3_0_g241427 = v.ase_color;
					float4 Channel70_g241427 = temp_output_3_0_g241427;
					float localSwitchChannel470_g241427 = SwitchChannel4( Option70_g241427 , Channel70_g241427 );
					half Phase_Value372_g241416 = localSwitchChannel470_g241427;
					float3 break319_g241416 = PivotWO133_g241416;
					half Pivot_Position322_g241416 = ( break319_g241416.x + break319_g241416.z );
					half Phase_Position357_g241416 = ( Phase_Value372_g241416 + Pivot_Position322_g241416 );
					float temp_output_248_0_g241416 = frac( Phase_Position357_g241416 );
					float4 appendResult177_g241416 = (float4((frac( ( Phase_Position357_g241416 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241416));
					half4 Phase_Data176_g241416 = appendResult177_g241416;
					float4 In_PhaseData16_g241434 = Phase_Data176_g241416;
					BuildModelVertData( Data16_g241434 , In_Dummy16_g241434 , In_PositionOS16_g241434 , In_PositionWS16_g241434 , In_PositionWO16_g241434 , In_PivotOS16_g241434 , In_PivotWS16_g241434 , In_PivotWO16_g241434 , In_NormalOS16_g241434 , In_NormalWS16_g241434 , In_TangentOS16_g241434 , In_ViewDirWS16_g241434 , In_CoordsData16_g241434 , In_VertexData16_g241434 , In_MasksData16_g241434 , In_PhaseData16_g241434 );
					TVEModelData DataDefault26_g251465 = Data16_g241434;
					TVEModelData DataGeneral26_g251465 = Data16_g241434;
					TVEModelData DataBlanket26_g251465 = Data16_g241434;
					TVEModelData DataImpostor26_g251465 = Data16_g241434;
					TVEModelData Data16_g241414 =(TVEModelData)0;
					half Dummy207_g241396 = 0.0;
					float temp_output_14_0_g241414 = Dummy207_g241396;
					float In_Dummy16_g241414 = temp_output_14_0_g241414;
					float3 PositionOS131_g241396 = v.vertex.xyz;
					float3 temp_output_4_0_g241414 = PositionOS131_g241396;
					float3 In_PositionOS16_g241414 = temp_output_4_0_g241414;
					float3 temp_output_104_7_g241396 = ase_positionWS;
					float3 PositionWS122_g241396 = temp_output_104_7_g241396;
					float3 In_PositionWS16_g241414 = PositionWS122_g241396;
					float4x4 break19_g241399 = unity_ObjectToWorld;
					float3 appendResult20_g241399 = (float3(break19_g241399[ 0 ][ 3 ] , break19_g241399[ 1 ][ 3 ] , break19_g241399[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241396 = appendResult20_g241399;
					float3 PivotWS121_g241396 = temp_output_340_7_g241396;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241396 = ( PositionWS122_g241396 - PivotWS121_g241396 );
					#else
					float3 staticSwitch204_g241396 = PositionWS122_g241396;
					#endif
					float3 PositionWO132_g241396 = ( staticSwitch204_g241396 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241414 = PositionWO132_g241396;
					float3 PivotOS149_g241396 = _Vector0;
					float3 In_PivotOS16_g241414 = PivotOS149_g241396;
					float3 In_PivotWS16_g241414 = PivotWS121_g241396;
					float3 PivotWO133_g241396 = ( PivotWS121_g241396 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241414 = PivotWO133_g241396;
					half3 NormalOS134_g241396 = v.normal;
					float3 temp_output_21_0_g241414 = NormalOS134_g241396;
					float3 In_NormalOS16_g241414 = temp_output_21_0_g241414;
					half3 NormalWS95_g241396 = normalizedWorldNormal;
					float3 In_NormalWS16_g241414 = NormalWS95_g241396;
					float4 appendResult462_g241396 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241396 = appendResult462_g241396;
					float4 temp_output_6_0_g241414 = TangentlOS153_g241396;
					float4 In_TangentOS16_g241414 = temp_output_6_0_g241414;
					float3 normalizeResult296_g241396 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241396 ) );
					half3 ViewDirWS169_g241396 = normalizeResult296_g241396;
					float3 In_ViewDirWS16_g241414 = ViewDirWS169_g241396;
					float4 appendResult397_g241396 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241396 = appendResult397_g241396;
					float4 In_CoordsData16_g241414 = CoordsData398_g241396;
					half4 VertexMasks171_g241396 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241414 = VertexMasks171_g241396;
					half4 MasksData254_g241396 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241414 = MasksData254_g241396;
					half4 Phase_Data176_g241396 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241414 = Phase_Data176_g241396;
					BuildModelVertData( Data16_g241414 , In_Dummy16_g241414 , In_PositionOS16_g241414 , In_PositionWS16_g241414 , In_PositionWO16_g241414 , In_PivotOS16_g241414 , In_PivotWS16_g241414 , In_PivotWO16_g241414 , In_NormalOS16_g241414 , In_NormalWS16_g241414 , In_TangentOS16_g241414 , In_ViewDirWS16_g241414 , In_CoordsData16_g241414 , In_VertexData16_g241414 , In_MasksData16_g241414 , In_PhaseData16_g241414 );
					TVEModelData DataTerrain26_g251465 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251465 = IsShaderType2672;
					{
					if (Type26_g251465 == 0 )
					{
					Data26_g251465 = DataDefault26_g251465;
					}
					else if (Type26_g251465 == 1 )
					{
					Data26_g251465 = DataGeneral26_g251465;
					}
					else if (Type26_g251465 == 2 )
					{
					Data26_g251465 = DataBlanket26_g251465;
					}
					else if (Type26_g251465 == 3 )
					{
					Data26_g251465 = DataImpostor26_g251465;
					}
					else if (Type26_g251465 == 4 )
					{
					Data26_g251465 = DataTerrain26_g251465;
					}
					}
					TVEModelData Data15_g251973 =(TVEModelData)Data26_g251465;
					float Out_Dummy15_g251973 = 0.0;
					float3 Out_PositionOS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251973 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251973 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251973 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251973 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251973 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251973 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251973 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251973 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251973 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251973 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251973 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251973 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251973 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251973 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251973 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251973 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251973 , Out_Dummy15_g251973 , Out_PositionOS15_g251973 , Out_PositionWS15_g251973 , Out_PositionWO15_g251973 , Out_PositionRawOS15_g251973 , Out_PivotOS15_g251973 , Out_PivotWS15_g251973 , Out_PivotWO15_g251973 , Out_NormalOS15_g251973 , Out_NormalWS15_g251973 , Out_NormalRawOS15_g251973 , Out_TangentOS15_g251973 , Out_TangentWS15_g251973 , Out_BitangentWS15_g251973 , Out_ViewDirWS15_g251973 , Out_CoordsData15_g251973 , Out_VertexData15_g251973 , Out_MasksData15_g251973 , Out_PhaseData15_g251973 , Out_TransformData15_g251973 , Out_RotationData15_g251973 , Out_Interpolator15_g251973 );
					float3 In_PositionOS16_g251972 = Out_PositionOS15_g251973;
					float3 In_NormalOS16_g251972 = Out_NormalOS15_g251973;
					float4 In_TangentOS16_g251972 = Out_TangentOS15_g251973;
					float4 In_TransformData16_g251972 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251972 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251972 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251972 , In_Dummy16_g251972 , In_PositionOS16_g251972 , In_NormalOS16_g251972 , In_TangentOS16_g251972 , In_TransformData16_g251972 , In_RotationData16_g251972 , In_Interpolator16_g251972 );
					TVEVertexData Data15_g251975 =(TVEVertexData)Data16_g251972;
					float Out_Dummy15_g251975 = 0.0;
					float3 Out_PositionOS15_g251975 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251975 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251975 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251975 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251975 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251975 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251975 , Out_Dummy15_g251975 , Out_PositionOS15_g251975 , Out_NormalOS15_g251975 , Out_TangentOS15_g251975 , Out_TransformData15_g251975 , Out_RotationData15_g251975 , Out_Interpolator15_g251975 );
					TVEModelData Data15_g251976 =(TVEModelData)Data15_g251973;
					float Out_Dummy15_g251976 = 0.0;
					float3 Out_PositionOS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251976 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251976 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251976 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251976 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251976 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251976 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251976 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251976 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251976 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251976 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251976 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251976 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251976 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251976 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251976 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251976 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251976 , Out_Dummy15_g251976 , Out_PositionOS15_g251976 , Out_PositionWS15_g251976 , Out_PositionWO15_g251976 , Out_PositionRawOS15_g251976 , Out_PivotOS15_g251976 , Out_PivotWS15_g251976 , Out_PivotWO15_g251976 , Out_NormalOS15_g251976 , Out_NormalWS15_g251976 , Out_NormalRawOS15_g251976 , Out_TangentOS15_g251976 , Out_TangentWS15_g251976 , Out_BitangentWS15_g251976 , Out_ViewDirWS15_g251976 , Out_CoordsData15_g251976 , Out_VertexData15_g251976 , Out_MasksData15_g251976 , Out_PhaseData15_g251976 , Out_TransformData15_g251976 , Out_RotationData15_g251976 , Out_Interpolator15_g251976 );
					float3 In_PositionOS16_g251977 = ( Out_PositionOS15_g251975 - Out_PivotOS15_g251976 );
					float3 In_NormalOS16_g251977 = Out_NormalOS15_g251976;
					float4 In_TangentOS16_g251977 = Out_TangentOS15_g251976;
					float4 In_TransformData16_g251977 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251977 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251977 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251977 , In_Dummy16_g251977 , In_PositionOS16_g251977 , In_NormalOS16_g251977 , In_TangentOS16_g251977 , In_TransformData16_g251977 , In_RotationData16_g251977 , In_Interpolator16_g251977 );
					TVEVertexData Data15_g251986 =(TVEVertexData)Data16_g251977;
					float Out_Dummy15_g251986 = 0.0;
					float3 Out_PositionOS15_g251986 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251986 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251986 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251986 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251986 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251986 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251986 , Out_Dummy15_g251986 , Out_PositionOS15_g251986 , Out_NormalOS15_g251986 , Out_TangentOS15_g251986 , Out_TransformData15_g251986 , Out_RotationData15_g251986 , Out_Interpolator15_g251986 );
					TVEVertexData Data16_g251987 =(TVEVertexData)Data15_g251986;
					half Dummy317_g251978 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251987 = Dummy317_g251978;
					float3 In_PositionOS16_g251987 = Out_PositionOS15_g251986;
					float3 In_NormalOS16_g251987 = Out_NormalOS15_g251986;
					float4 In_TangentOS16_g251987 = Out_TangentOS15_g251986;
					half4 Model_TransformData356_g251978 = Out_TransformData15_g251986;
					float localBuildGlobalData204_g251364 = ( 0.0 );
					TVEGlobalData Data204_g251364 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251364 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251364 = Dummy211_g251364;
					float4 temp_output_203_0_g251383 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241424 =(TVEModelData)0;
					float In_Dummy16_g241424 = 0.0;
					float3 In_PositionWS16_g241424 = PositionWS122_g241416;
					float3 In_PositionWO16_g241424 = PositionWO132_g241416;
					float3 In_PivotWS16_g241424 = PivotWS121_g241416;
					float3 In_PivotWO16_g241424 = PivotWO133_g241416;
					float3 In_NormalWS16_g241424 = NormalWS95_g241416;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241416 = ase_tangentWS;
					float3 In_TangentWS16_g241424 = TangentWS136_g241416;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241416 = ase_bitangentWS;
					float3 In_BitangentWS16_g241424 = BiangentWS421_g241416;
					half3 NormalWS427_g241416 = NormalWS95_g241416;
					half3 localComputeTriplanarMasks427_g241416 = ComputeTriplanarMasks( NormalWS427_g241416 );
					half3 TriplanarWeights429_g241416 = localComputeTriplanarMasks427_g241416;
					float3 In_TriplanarWeights16_g241424 = TriplanarWeights429_g241416;
					float3 In_ViewDirWS16_g241424 = ViewDirWS169_g241416;
					float4 In_CoordsData16_g241424 = CoordsData398_g241416;
					float4 In_VertexData16_g241424 = VertexMasks171_g241416;
					float4 In_Interpolator16_g241424 = Phase_Data176_g241416;
					BuildModelFragData( Data16_g241424 , In_Dummy16_g241424 , In_PositionWS16_g241424 , In_PositionWO16_g241424 , In_PivotWS16_g241424 , In_PivotWO16_g241424 , In_NormalWS16_g241424 , In_TangentWS16_g241424 , In_BitangentWS16_g241424 , In_TriplanarWeights16_g241424 , In_ViewDirWS16_g241424 , In_CoordsData16_g241424 , In_VertexData16_g241424 , In_Interpolator16_g241424 );
					TVEModelData DataDefault26_g241395 = Data16_g241424;
					TVEModelData DataGeneral26_g241395 = Data16_g241424;
					TVEModelData DataBlanket26_g241395 = Data16_g241424;
					TVEModelData DataImpostor26_g241395 = Data16_g241424;
					TVEModelData Data16_g241404 =(TVEModelData)0;
					float In_Dummy16_g241404 = 0.0;
					float3 In_PositionWS16_g241404 = PositionWS122_g241396;
					float3 In_PositionWO16_g241404 = PositionWO132_g241396;
					float3 In_PivotWS16_g241404 = PivotWS121_g241396;
					float3 In_PivotWO16_g241404 = PivotWO133_g241396;
					float3 In_NormalWS16_g241404 = NormalWS95_g241396;
					half3 TangentWS136_g241396 = ase_tangentWS;
					float3 In_TangentWS16_g241404 = TangentWS136_g241396;
					half3 BiangentWS421_g241396 = ase_bitangentWS;
					float3 In_BitangentWS16_g241404 = BiangentWS421_g241396;
					half3 NormalWS427_g241396 = NormalWS95_g241396;
					half3 localComputeTriplanarMasks427_g241396 = ComputeTriplanarMasks( NormalWS427_g241396 );
					half3 TriplanarWeights429_g241396 = localComputeTriplanarMasks427_g241396;
					float3 In_TriplanarWeights16_g241404 = TriplanarWeights429_g241396;
					float3 In_ViewDirWS16_g241404 = ViewDirWS169_g241396;
					float4 In_CoordsData16_g241404 = CoordsData398_g241396;
					float4 In_VertexData16_g241404 = VertexMasks171_g241396;
					float4 In_Interpolator16_g241404 = Phase_Data176_g241396;
					BuildModelFragData( Data16_g241404 , In_Dummy16_g241404 , In_PositionWS16_g241404 , In_PositionWO16_g241404 , In_PivotWS16_g241404 , In_PivotWO16_g241404 , In_NormalWS16_g241404 , In_TangentWS16_g241404 , In_BitangentWS16_g241404 , In_TriplanarWeights16_g241404 , In_ViewDirWS16_g241404 , In_CoordsData16_g241404 , In_VertexData16_g241404 , In_Interpolator16_g241404 );
					TVEModelData DataTerrain26_g241395 = Data16_g241404;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251454 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251454 = 0.0;
					float3 Out_PositionWS15_g251454 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251454 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251454 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251454 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251454 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251454 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251454 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251454 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251454 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251454 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251454 , Out_Dummy15_g251454 , Out_PositionWS15_g251454 , Out_PositionWO15_g251454 , Out_PivotWS15_g251454 , Out_PivotWO15_g251454 , Out_NormalWS15_g251454 , Out_TangentWS15_g251454 , Out_BitangentWS15_g251454 , Out_TriplanarWeights15_g251454 , Out_ViewDirWS15_g251454 , Out_CoordsData15_g251454 , Out_VertexData15_g251454 , Out_Interpolator15_g251454 );
					float3 Model_PositionWS497_g251364 = Out_PositionWS15_g251454;
					float2 Model_PositionWS_XZ143_g251364 = (Model_PositionWS497_g251364).xz;
					float3 Model_PivotWS498_g251364 = Out_PivotWS15_g251454;
					float2 Model_PivotWS_XZ145_g251364 = (Model_PivotWS498_g251364).xz;
					float2 lerpResult300_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251383 = lerpResult300_g251364;
					float temp_output_82_0_g251381 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251383 = temp_output_82_0_g251381;
					float4 tex2DArrayNode83_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251383).zw + ( (temp_output_203_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult210_g251383 = (float4(tex2DArrayNode83_g251383.rgb , tex2DArrayNode83_g251383.a));
					float4 temp_output_204_0_g251383 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251383 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251383).zw + ( (temp_output_204_0_g251383).xy * temp_output_81_0_g251383 ) ),temp_output_82_0_g251383), 0.0 );
					float4 appendResult212_g251383 = (float4(tex2DArrayNode122_g251383.rgb , tex2DArrayNode122_g251383.a));
					float4 TVE_RenderNearPositionR628_g251364 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251364 = saturate( ( distance( Model_PositionWS497_g251364 , (TVE_RenderNearPositionR628_g251364).xyz ) / (TVE_RenderNearPositionR628_g251364).w ) );
					float temp_output_7_0_g251453 = 1.0;
					float temp_output_9_0_g251453 = ( temp_output_507_0_g251364 - temp_output_7_0_g251453 );
					half TVE_RenderNearFadeValue635_g251364 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251364 = saturate( ( temp_output_9_0_g251453 / ( ( TVE_RenderNearFadeValue635_g251364 - temp_output_7_0_g251453 ) + 0.0001 ) ) );
					float4 lerpResult131_g251383 = lerp( appendResult210_g251383 , appendResult212_g251383 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251381 = lerpResult131_g251383;
					float4 lerpResult168_g251381 = lerp( TVE_CoatParams , temp_output_159_109_g251381 , TVE_CoatLayers[(int)temp_output_82_0_g251381]);
					float4 temp_output_589_109_g251364 = lerpResult168_g251381;
					half4 Coat_Texture302_g251364 = temp_output_589_109_g251364;
					float4 In_CoatTexture204_g251364 = Coat_Texture302_g251364;
					half4 Draw_Texture656_g251364 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251364 = Draw_Texture656_g251364;
					float4 temp_output_203_0_g251408 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251408 = lerpResult85_g251364;
					float temp_output_82_0_g251405 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251408 = temp_output_82_0_g251405;
					float4 tex2DArrayNode83_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251408).zw + ( (temp_output_203_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult210_g251408 = (float4(tex2DArrayNode83_g251408.rgb , tex2DArrayNode83_g251408.a));
					float4 temp_output_204_0_g251408 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251408 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251408).zw + ( (temp_output_204_0_g251408).xy * temp_output_81_0_g251408 ) ),temp_output_82_0_g251408), 0.0 );
					float4 appendResult212_g251408 = (float4(tex2DArrayNode122_g251408.rgb , tex2DArrayNode122_g251408.a));
					float4 lerpResult131_g251408 = lerp( appendResult210_g251408 , appendResult212_g251408 , Global_TexBlend509_g251364);
					float4 temp_output_171_109_g251405 = lerpResult131_g251408;
					float4 lerpResult174_g251405 = lerp( TVE_PaintParams , temp_output_171_109_g251405 , TVE_PaintLayers[(int)temp_output_82_0_g251405]);
					float4 temp_output_595_109_g251364 = lerpResult174_g251405;
					half4 Paint_Texture71_g251364 = temp_output_595_109_g251364;
					float4 In_PaintTexture204_g251364 = Paint_Texture71_g251364;
					float4 temp_output_203_0_g251391 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251391 = lerpResult104_g251364;
					float temp_output_132_0_g251389 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251391 = temp_output_132_0_g251389;
					float4 tex2DArrayNode83_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251391).zw + ( (temp_output_203_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult210_g251391 = (float4(tex2DArrayNode83_g251391.rgb , tex2DArrayNode83_g251391.a));
					float4 temp_output_204_0_g251391 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251391 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251391).zw + ( (temp_output_204_0_g251391).xy * temp_output_81_0_g251391 ) ),temp_output_82_0_g251391), 0.0 );
					float4 appendResult212_g251391 = (float4(tex2DArrayNode122_g251391.rgb , tex2DArrayNode122_g251391.a));
					float4 lerpResult131_g251391 = lerp( appendResult210_g251391 , appendResult212_g251391 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251389 = lerpResult131_g251391;
					float4 lerpResult145_g251389 = lerp( TVE_AtmoParams , temp_output_137_109_g251389 , TVE_AtmoLayers[(int)temp_output_132_0_g251389]);
					float4 temp_output_590_110_g251364 = lerpResult145_g251389;
					half4 Atmo_Texture80_g251364 = temp_output_590_110_g251364;
					float4 In_AtmoTexture204_g251364 = Atmo_Texture80_g251364;
					float4 temp_output_203_0_g251459 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251459 = lerpResult414_g251364;
					float temp_output_132_0_g251457 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251459 = temp_output_132_0_g251457;
					float4 tex2DArrayNode83_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251459).zw + ( (temp_output_203_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult210_g251459 = (float4(tex2DArrayNode83_g251459.rgb , tex2DArrayNode83_g251459.a));
					float4 temp_output_204_0_g251459 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251459 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251459).zw + ( (temp_output_204_0_g251459).xy * temp_output_81_0_g251459 ) ),temp_output_82_0_g251459), 0.0 );
					float4 appendResult212_g251459 = (float4(tex2DArrayNode122_g251459.rgb , tex2DArrayNode122_g251459.a));
					float4 lerpResult131_g251459 = lerp( appendResult210_g251459 , appendResult212_g251459 , Global_TexBlend509_g251364);
					float4 temp_output_137_109_g251457 = lerpResult131_g251459;
					float4 lerpResult145_g251457 = lerp( TVE_EffexParams , temp_output_137_109_g251457 , TVE_EffexLayers[(int)temp_output_132_0_g251457]);
					float4 temp_output_731_110_g251364 = lerpResult145_g251457;
					half4 Effex_Texture420_g251364 = temp_output_731_110_g251364;
					float4 In_EffexTexture204_g251364 = Effex_Texture420_g251364;
					float4 temp_output_203_0_g251439 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251439 = lerpResult247_g251364;
					float temp_output_82_0_g251437 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251439 = temp_output_82_0_g251437;
					float4 tex2DArrayNode83_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251439).zw + ( (temp_output_203_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult210_g251439 = (float4(tex2DArrayNode83_g251439.rgb , tex2DArrayNode83_g251439.a));
					float4 temp_output_204_0_g251439 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251439 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251439).zw + ( (temp_output_204_0_g251439).xy * temp_output_81_0_g251439 ) ),temp_output_82_0_g251439), 0.0 );
					float4 appendResult212_g251439 = (float4(tex2DArrayNode122_g251439.rgb , tex2DArrayNode122_g251439.a));
					float4 lerpResult131_g251439 = lerp( appendResult210_g251439 , appendResult212_g251439 , Global_TexBlend509_g251364);
					float4 temp_output_159_109_g251437 = lerpResult131_g251439;
					float4 lerpResult167_g251437 = lerp( TVE_GlowParams , temp_output_159_109_g251437 , TVE_GlowLayers[(int)temp_output_82_0_g251437]);
					float4 temp_output_593_109_g251364 = lerpResult167_g251437;
					half4 Glow_Texture248_g251364 = temp_output_593_109_g251364;
					float4 In_GlowTexture204_g251364 = Glow_Texture248_g251364;
					float4 temp_output_203_0_g251375 = TVE_FormBaseCoord;
					float2 lerpResult168_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251375 = lerpResult168_g251364;
					float temp_output_130_0_g251373 = _GlobalFormLayerValue;
					float temp_output_82_0_g251375 = temp_output_130_0_g251373;
					float4 tex2DArrayNode83_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251375).zw + ( (temp_output_203_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult210_g251375 = (float4(tex2DArrayNode83_g251375.rgb , tex2DArrayNode83_g251375.a));
					float4 temp_output_204_0_g251375 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251375 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251375).zw + ( (temp_output_204_0_g251375).xy * temp_output_81_0_g251375 ) ),temp_output_82_0_g251375), 0.0 );
					float4 appendResult212_g251375 = (float4(tex2DArrayNode122_g251375.rgb , tex2DArrayNode122_g251375.a));
					float4 lerpResult131_g251375 = lerp( appendResult210_g251375 , appendResult212_g251375 , Global_TexBlend509_g251364);
					float4 temp_output_135_109_g251373 = lerpResult131_g251375;
					float4 lerpResult143_g251373 = lerp( TVE_FormParams , temp_output_135_109_g251373 , TVE_FormLayers[(int)temp_output_130_0_g251373]);
					float4 temp_output_592_0_g251364 = lerpResult143_g251373;
					float4 Form_Texture112_g251364 = temp_output_592_0_g251364;
					float4 In_FormTexture204_g251364 = Form_Texture112_g251364;
					float4 In_LandTexture204_g251364 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251423 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251423 = lerpResult681_g251364;
					float temp_output_136_0_g251421 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251423 = temp_output_136_0_g251421;
					float4 tex2DArrayNode83_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251423).zw + ( (temp_output_203_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult210_g251423 = (float4(tex2DArrayNode83_g251423.rgb , tex2DArrayNode83_g251423.a));
					float4 temp_output_204_0_g251423 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251423 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251423).zw + ( (temp_output_204_0_g251423).xy * temp_output_81_0_g251423 ) ),temp_output_82_0_g251423), 0.0 );
					float4 appendResult212_g251423 = (float4(tex2DArrayNode122_g251423.rgb , tex2DArrayNode122_g251423.a));
					float4 lerpResult131_g251423 = lerp( appendResult210_g251423 , appendResult212_g251423 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251421 = lerpResult131_g251423;
					float4 lerpResult149_g251421 = lerp( TVE_VertxParams , temp_output_141_109_g251421 , TVE_VertxLayers[(int)temp_output_136_0_g251421]);
					float4 temp_output_695_0_g251364 = lerpResult149_g251421;
					half4 Vertx_Texture693_g251364 = temp_output_695_0_g251364;
					float4 In_VertxTexture204_g251364 = Vertx_Texture693_g251364;
					float4 temp_output_203_0_g251399 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251364 = lerp( Model_PositionWS_XZ143_g251364 , Model_PivotWS_XZ145_g251364 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251399 = lerpResult400_g251364;
					float temp_output_136_0_g251397 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251399 = temp_output_136_0_g251397;
					float4 tex2DArrayNode83_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251399).zw + ( (temp_output_203_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult210_g251399 = (float4(tex2DArrayNode83_g251399.rgb , tex2DArrayNode83_g251399.a));
					float4 temp_output_204_0_g251399 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251399 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251399).zw + ( (temp_output_204_0_g251399).xy * temp_output_81_0_g251399 ) ),temp_output_82_0_g251399), 0.0 );
					float4 appendResult212_g251399 = (float4(tex2DArrayNode122_g251399.rgb , tex2DArrayNode122_g251399.a));
					float4 lerpResult131_g251399 = lerp( appendResult210_g251399 , appendResult212_g251399 , Global_TexBlend509_g251364);
					float4 temp_output_141_109_g251397 = lerpResult131_g251399;
					float4 lerpResult149_g251397 = lerp( TVE_FlowParams , temp_output_141_109_g251397 , TVE_FlowLayers[(int)temp_output_136_0_g251397]);
					float4 temp_output_594_0_g251364 = lerpResult149_g251397;
					half4 Flow_Texture405_g251364 = temp_output_594_0_g251364;
					float4 In_FlowTexture204_g251364 = Flow_Texture405_g251364;
					half4 User_Texture677_g251364 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251364 = User_Texture677_g251364;
					BuildGlobalData( Data204_g251364 , In_Dummy204_g251364 , In_CoatTexture204_g251364 , In_DrawTexture204_g251364 , In_PaintTexture204_g251364 , In_AtmoTexture204_g251364 , In_EffexTexture204_g251364 , In_GlowTexture204_g251364 , In_FormTexture204_g251364 , In_LandTexture204_g251364 , In_VertxTexture204_g251364 , In_FlowTexture204_g251364 , In_UserTexture204_g251364 );
					TVEGlobalData Data15_g251988 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251988 = 0.0;
					float4 Out_CoatTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251988 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251988 = float4( 0,0,0,0 );
					BreakData( Data15_g251988 , Out_Dummy15_g251988 , Out_CoatTexture15_g251988 , Out_DrawTexture15_g251988 , Out_PaintTexture15_g251988 , Out_AtmoTexture15_g251988 , Out_EffexTexture15_g251988 , Out_GlowTexture15_g251988 , Out_FormTexture15_g251988 , Out_LandTexture15_g251988 , Out_VertxTexture15_g251988 , Out_FlowTexture15_g251988 , Out_UserTexture15_g251988 );
					float4 Global_FormTexture351_g251978 = Out_FormTexture15_g251988;
					TVEModelData Data15_g251985 =(TVEModelData)Data15_g251976;
					float Out_Dummy15_g251985 = 0.0;
					float3 Out_PositionOS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251985 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251985 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251985 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251985 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251985 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251985 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251985 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251985 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251985 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251985 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251985 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251985 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251985 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251985 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251985 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251985 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251985 , Out_Dummy15_g251985 , Out_PositionOS15_g251985 , Out_PositionWS15_g251985 , Out_PositionWO15_g251985 , Out_PositionRawOS15_g251985 , Out_PivotOS15_g251985 , Out_PivotWS15_g251985 , Out_PivotWO15_g251985 , Out_NormalOS15_g251985 , Out_NormalWS15_g251985 , Out_NormalRawOS15_g251985 , Out_TangentOS15_g251985 , Out_TangentWS15_g251985 , Out_BitangentWS15_g251985 , Out_ViewDirWS15_g251985 , Out_CoordsData15_g251985 , Out_VertexData15_g251985 , Out_MasksData15_g251985 , Out_PhaseData15_g251985 , Out_TransformData15_g251985 , Out_RotationData15_g251985 , Out_Interpolator15_g251985 );
					float3 Model_PivotWO353_g251978 = Out_PivotWO15_g251985;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251984 = _ConformMeshMode;
					float Option70_g251984 = temp_output_17_0_g251984;
					half4 Model_VertexData357_g251978 = Out_VertexData15_g251985;
					float4 temp_output_3_0_g251984 = Model_VertexData357_g251978;
					float4 Channel70_g251984 = temp_output_3_0_g251984;
					float localSwitchChannel470_g251984 = SwitchChannel4( Option70_g251984 , Channel70_g251984 );
					float temp_output_390_0_g251978 = localSwitchChannel470_g251984;
					float temp_output_7_0_g251981 = _ConformMeshRemap.x;
					float temp_output_9_0_g251981 = ( temp_output_390_0_g251978 - temp_output_7_0_g251981 );
					float lerpResult374_g251978 = lerp( 1.0 , saturate( ( temp_output_9_0_g251981 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251978 = lerpResult374_g251978;
					float temp_output_328_0_g251978 = ( Blend_VertMask379_g251978 * TVE_IsEnabled );
					half Conform_Mask366_g251978 = temp_output_328_0_g251978;
					float temp_output_322_0_g251978 = ( ( ( ( (Global_FormTexture351_g251978).z - ( (Model_PivotWO353_g251978).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251978 ) );
					float3 appendResult329_g251978 = (float3(0.0 , temp_output_322_0_g251978 , 0.0));
					float3 appendResult387_g251978 = (float3(0.0 , 0.0 , temp_output_322_0_g251978));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251982 = appendResult387_g251978;
					#else
					float3 staticSwitch65_g251982 = appendResult329_g251978;
					#endif
					float3 Blanket_Conform368_g251978 = staticSwitch65_g251982;
					float4 appendResult312_g251978 = (float4(Blanket_Conform368_g251978 , 0.0));
					float4 temp_output_310_0_g251978 = ( Model_TransformData356_g251978 + appendResult312_g251978 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251978 = temp_output_310_0_g251978;
					#else
					float4 staticSwitch364_g251978 = Model_TransformData356_g251978;
					#endif
					half4 Final_TransformData365_g251978 = staticSwitch364_g251978;
					float4 In_TransformData16_g251987 = Final_TransformData365_g251978;
					float4 In_RotationData16_g251987 = Out_RotationData15_g251986;
					float4 In_Interpolator16_g251987 = Out_Interpolator15_g251986;
					BuildVertexData( Data16_g251987 , In_Dummy16_g251987 , In_PositionOS16_g251987 , In_NormalOS16_g251987 , In_TangentOS16_g251987 , In_TransformData16_g251987 , In_RotationData16_g251987 , In_Interpolator16_g251987 );
					TVEVertexData Data15_g251998 =(TVEVertexData)Data16_g251987;
					float Out_Dummy15_g251998 = 0.0;
					float3 Out_PositionOS15_g251998 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251998 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251998 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251998 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251998 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251998 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251998 , Out_Dummy15_g251998 , Out_PositionOS15_g251998 , Out_NormalOS15_g251998 , Out_TangentOS15_g251998 , Out_TransformData15_g251998 , Out_RotationData15_g251998 , Out_Interpolator15_g251998 );
					TVEVertexData Data16_g251999 =(TVEVertexData)Data15_g251998;
					float In_Dummy16_g251999 = 0.0;
					float3 Vertex_PositionOS147_g251989 = Out_PositionOS15_g251998;
					half3 VertexPos40_g251993 = Vertex_PositionOS147_g251989;
					float4 temp_output_1615_33_g251989 = Out_RotationData15_g251998;
					half4 Vertex_RotationData1569_g251989 = temp_output_1615_33_g251989;
					float2 break1582_g251989 = (Vertex_RotationData1569_g251989).xy;
					half Angle44_g251993 = break1582_g251989.y;
					half CosAngle89_g251993 = cos( Angle44_g251993 );
					half SinAngle93_g251993 = sin( Angle44_g251993 );
					float3 appendResult95_g251993 = (float3((VertexPos40_g251993).x , ( ( (VertexPos40_g251993).y * CosAngle89_g251993 ) - ( (VertexPos40_g251993).z * SinAngle93_g251993 ) ) , ( ( (VertexPos40_g251993).y * SinAngle93_g251993 ) + ( (VertexPos40_g251993).z * CosAngle89_g251993 ) )));
					half3 VertexPos40_g251994 = appendResult95_g251993;
					half Angle44_g251994 = -break1582_g251989.x;
					half CosAngle94_g251994 = cos( Angle44_g251994 );
					half SinAngle95_g251994 = sin( Angle44_g251994 );
					float3 appendResult98_g251994 = (float3(( ( (VertexPos40_g251994).x * CosAngle94_g251994 ) - ( (VertexPos40_g251994).y * SinAngle95_g251994 ) ) , ( ( (VertexPos40_g251994).x * SinAngle95_g251994 ) + ( (VertexPos40_g251994).y * CosAngle94_g251994 ) ) , (VertexPos40_g251994).z));
					half3 VertexPos40_g251992 = Vertex_PositionOS147_g251989;
					half Angle44_g251992 = break1582_g251989.y;
					half CosAngle89_g251992 = cos( Angle44_g251992 );
					half SinAngle93_g251992 = sin( Angle44_g251992 );
					float3 appendResult95_g251992 = (float3((VertexPos40_g251992).x , ( ( (VertexPos40_g251992).y * CosAngle89_g251992 ) - ( (VertexPos40_g251992).z * SinAngle93_g251992 ) ) , ( ( (VertexPos40_g251992).y * SinAngle93_g251992 ) + ( (VertexPos40_g251992).z * CosAngle89_g251992 ) )));
					half3 VertexPos40_g251997 = appendResult95_g251992;
					half Angle44_g251997 = break1582_g251989.x;
					half CosAngle91_g251997 = cos( Angle44_g251997 );
					half SinAngle92_g251997 = sin( Angle44_g251997 );
					float3 appendResult93_g251997 = (float3(( ( (VertexPos40_g251997).x * CosAngle91_g251997 ) + ( (VertexPos40_g251997).z * SinAngle92_g251997 ) ) , (VertexPos40_g251997).y , ( ( -(VertexPos40_g251997).x * SinAngle92_g251997 ) + ( (VertexPos40_g251997).z * CosAngle91_g251997 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251995 = appendResult93_g251997;
					#else
					float3 staticSwitch65_g251995 = appendResult98_g251994;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251990 = staticSwitch65_g251995;
					#else
					float3 staticSwitch65_g251990 = Vertex_PositionOS147_g251989;
					#endif
					float3 temp_output_1608_0_g251989 = staticSwitch65_g251990;
					half3 VertexPos40_g251996 = temp_output_1608_0_g251989;
					half Angle44_g251996 = (Vertex_RotationData1569_g251989).z;
					half CosAngle91_g251996 = cos( Angle44_g251996 );
					half SinAngle92_g251996 = sin( Angle44_g251996 );
					float3 appendResult93_g251996 = (float3(( ( (VertexPos40_g251996).x * CosAngle91_g251996 ) + ( (VertexPos40_g251996).z * SinAngle92_g251996 ) ) , (VertexPos40_g251996).y , ( ( -(VertexPos40_g251996).x * SinAngle92_g251996 ) + ( (VertexPos40_g251996).z * CosAngle91_g251996 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251991 = appendResult93_g251996;
					#else
					float3 staticSwitch65_g251991 = temp_output_1608_0_g251989;
					#endif
					float4 temp_output_1615_31_g251989 = Out_TransformData15_g251998;
					half4 Vertex_TransformData1568_g251989 = temp_output_1615_31_g251989;
					half3 Final_PositionOS178_g251989 = ( ( staticSwitch65_g251991 * (Vertex_TransformData1568_g251989).w ) + (Vertex_TransformData1568_g251989).xyz );
					float3 In_PositionOS16_g251999 = Final_PositionOS178_g251989;
					float3 In_NormalOS16_g251999 = Out_NormalOS15_g251998;
					float4 In_TangentOS16_g251999 = Out_TangentOS15_g251998;
					float4 In_TransformData16_g251999 = temp_output_1615_31_g251989;
					float4 In_RotationData16_g251999 = temp_output_1615_33_g251989;
					float4 In_Interpolator16_g251999 = Out_Interpolator15_g251998;
					BuildVertexData( Data16_g251999 , In_Dummy16_g251999 , In_PositionOS16_g251999 , In_NormalOS16_g251999 , In_TangentOS16_g251999 , In_TransformData16_g251999 , In_RotationData16_g251999 , In_Interpolator16_g251999 );
					TVEVertexData Data15_g252002 =(TVEVertexData)Data16_g251999;
					float Out_Dummy15_g252002 = 0.0;
					float3 Out_PositionOS15_g252002 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252002 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252002 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252002 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252002 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252002 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252002 , Out_Dummy15_g252002 , Out_PositionOS15_g252002 , Out_NormalOS15_g252002 , Out_TangentOS15_g252002 , Out_TransformData15_g252002 , Out_RotationData15_g252002 , Out_Interpolator15_g252002 );
					TVEVertexData Data16_g252003 =(TVEVertexData)Data15_g252002;
					float In_Dummy16_g252003 = 0.0;
					TVEModelData Data15_g252001 =(TVEModelData)Data15_g251985;
					float Out_Dummy15_g252001 = 0.0;
					float3 Out_PositionOS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252001 , Out_Dummy15_g252001 , Out_PositionOS15_g252001 , Out_PositionWS15_g252001 , Out_PositionWO15_g252001 , Out_PositionRawOS15_g252001 , Out_PivotOS15_g252001 , Out_PivotWS15_g252001 , Out_PivotWO15_g252001 , Out_NormalOS15_g252001 , Out_NormalWS15_g252001 , Out_NormalRawOS15_g252001 , Out_TangentOS15_g252001 , Out_TangentWS15_g252001 , Out_BitangentWS15_g252001 , Out_ViewDirWS15_g252001 , Out_CoordsData15_g252001 , Out_VertexData15_g252001 , Out_MasksData15_g252001 , Out_PhaseData15_g252001 , Out_TransformData15_g252001 , Out_RotationData15_g252001 , Out_Interpolator15_g252001 );
					float3 In_PositionOS16_g252003 = ( Out_PositionOS15_g252002 + Out_PivotOS15_g252001 );
					float3 In_NormalOS16_g252003 = Out_NormalOS15_g252002;
					float4 In_TangentOS16_g252003 = Out_TangentOS15_g252002;
					float4 In_TransformData16_g252003 = Out_TransformData15_g252002;
					float4 In_RotationData16_g252003 = Out_RotationData15_g252002;
					float4 In_Interpolator16_g252003 = Out_Interpolator15_g252002;
					BuildVertexData( Data16_g252003 , In_Dummy16_g252003 , In_PositionOS16_g252003 , In_NormalOS16_g252003 , In_TangentOS16_g252003 , In_TransformData16_g252003 , In_RotationData16_g252003 , In_Interpolator16_g252003 );
					TVEVertexData Data15_g254769 =(TVEVertexData)Data16_g252003;
					float Out_Dummy15_g254769 = 0.0;
					float3 Out_PositionOS15_g254769 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254769 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254769 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254769 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254769 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254769 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254769 , Out_Dummy15_g254769 , Out_PositionOS15_g254769 , Out_NormalOS15_g254769 , Out_TangentOS15_g254769 , Out_TransformData15_g254769 , Out_RotationData15_g254769 , Out_Interpolator15_g254769 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g254769;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254769;
					v.tangent = Out_TangentOS15_g254769;

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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2666,"pos":[-7936,-5376],"params":["Inherit","False","Property","_IsShaderType","_IsShaderType","248","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2670,"pos":[-7552,-4736],"params":["Inherit","False","If Model Data","-1","","241395","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2672,"pos":[-7744,-5376],"params":["Half","False","IsShaderType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-7232,-4736],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2667,"pos":[-7936,-4864],"params":["Inherit","False","Block Model","235","","241396","7ad7765e793a6714babedee0033c36e9","19,463,0,289,0,240,0,437,0,291,0,431,0,404,0,290,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6784,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2669,"pos":[-7936,-4992],"params":["Inherit","False","Block Model","235","","241416","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2668,"pos":[-7936,-4608],"params":["Inherit","False","2672","IsShaderType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2375,"pos":[-6528,-4992],"params":["Inherit","False","Block Global","254","","251364","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2671,"pos":[-7552,-4992],"params":["Inherit","False","If Model Data","-1","","251465","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-6208,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-7232,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2683,"pos":[-5760,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2684,"pos":[-5760,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2682,"pos":[-5504,-4992],"params":["Inherit","False","Block Vertex","-1","","251971","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2657,"pos":[-5120,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","251974","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2659,"pos":[-4736,-4992],"params":["Inherit","False","Block Blanket Conform","359","","251978","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2665,"pos":[-4352,-4992],"params":["Inherit","False","Block Transform","-1","","251989","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2660,"pos":[-3968,-4992],"params":["Inherit","False","Block Pivots Add","-1","","252000","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2661,"pos":[-3648,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2685,"pos":[-3200,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2686,"pos":[-3200,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2688,"pos":[-3200,-4992],"params":["Inherit","False","2661","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2687,"pos":[-2944,-4992],"params":["Inherit","False","Block Visual","-1","","254247","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2380,"pos":[-2560,-4992],"params":["Inherit","False","Block Main","333","","254251","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2454,"pos":[-2240,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2600,"pos":[-1536,-4992],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2507,"pos":[-1536,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2508,"pos":[-1536,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2677,"pos":[-1280,-4992],"params":["Inherit","False","Block Blanket Terrain","7","","254290","f786a155dcaafdd43a82f5635cc418c6","9,1161,1,1152,1,1158,1,1329,1,1160,1,1210,1,1156,0,1084,1,1166,0","4","585","OBJECT","0,0,0,0","False","633","OBJECT","0,0,0,0","False","971","OBJECT","0,0,0,0","False","1164","FLOAT","1","False","4","OBJECT","552","OBJECT","1283","OBJECT","1284","OBJECT","1256"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2509,"pos":[-640,-4992],"params":["Inherit","False","Break Masks Data","-1","","254755","23311522ecc97b54e8b77d849401069d","0","1","6","OBJECT","0","False","8","FLOAT4","14","FLOAT4","0","FLOAT4","23","FLOAT4","5","FLOAT4","24","FLOAT4","25","FLOAT4","26","FLOAT4","27"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2567,"pos":[128,-4864],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2646,"pos":[128,-4992],"params":["Inherit","False","Tool Debug Active","249","","254756","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2568,"pos":[384,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2569,"pos":[128,-4736],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[768,-4992],"params":["Inherit","False","Tool Debug Index","-1","","254758","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2592,"pos":[768,-4736],"params":["Inherit","False","Tool Debug Index","-1","","254759","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT","0","False","36","FLOAT","2","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[1152,-4992],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[1472,-4992],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[2432,-4992],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2563,"pos":[2432,-4928],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2555,"pos":[2432,-4864],"params":["Inherit","False","2661","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3072,-5120],"params":["Inherit","False","Base Compile","-1","","254760","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2664,"pos":[2688,-4992],"params":["Inherit","False","Tool Debug Color","0","","254761","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[2688,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[3072,-4992],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Terrain","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2673,"pos":[2688,-4932],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2674,"pos":[3072,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2670,33,2669,314]}
{"wire":[2670,27,2669,314]}
{"wire":[2670,28,2669,314]}
{"wire":[2670,29,2669,314]}
{"wire":[2670,30,2667,314]}
{"wire":[2670,31,2668,0]}
{"wire":[2672,0,2666,0]}
{"wire":[2373,0,2670,0]}
{"wire":[2375,206,2374,0]}
{"wire":[2671,33,2669,128]}
{"wire":[2671,27,2669,128]}
{"wire":[2671,28,2669,128]}
{"wire":[2671,29,2669,128]}
{"wire":[2671,30,2667,128]}
{"wire":[2671,31,2668,0]}
{"wire":[2505,0,2375,151]}
{"wire":[2377,0,2671,0]}
{"wire":[2682,1894,2683,0]}
{"wire":[2682,1896,2684,0]}
{"wire":[2657,224,2682,128]}
{"wire":[2657,146,2682,1895]}
{"wire":[2657,231,2682,1897]}
{"wire":[2659,146,2657,128]}
{"wire":[2659,397,2657,229]}
{"wire":[2659,186,2657,232]}
{"wire":[2665,146,2659,128]}
{"wire":[2665,1620,2659,398]}
{"wire":[2665,1619,2659,399]}
{"wire":[2660,146,2665,128]}
{"wire":[2660,225,2665,1617]}
{"wire":[2660,227,2665,1618]}
{"wire":[2661,0,2660,128]}
{"wire":[2687,1904,2688,0]}
{"wire":[2687,1894,2686,0]}
{"wire":[2687,1896,2685,0]}
{"wire":[2380,430,2687,1900]}
{"wire":[2380,225,2687,1895]}
{"wire":[2380,414,2687,1897]}
{"wire":[2454,0,2380,106]}
{"wire":[2677,585,2600,0]}
{"wire":[2677,633,2508,0]}
{"wire":[2677,971,2507,0]}
{"wire":[2509,6,2677,1256]}
{"wire":[2567,0,2509,14]}
{"wire":[2568,0,2646,108]}
{"wire":[2568,1,2646,0]}
{"wire":[2568,2,2567,0]}
{"wire":[2569,0,2509,0]}
{"wire":[2594,39,2568,0]}
{"wire":[2592,39,2569,0]}
{"wire":[2550,0,2594,0]}
{"wire":[2550,1,2592,0]}
{"wire":[2399,0,2550,0]}
{"wire":[1774,0,1771,0]}
{"wire":[1774,1,1772,0]}
{"wire":[1774,3,1803,0]}
{"wire":[1803,0,1800,0]}
{"wire":[1843,0,1804,0]}
{"wire":[1800,0,1843,0]}
{"wire":[2664,80,2400,0]}
{"wire":[2664,106,2563,0]}
{"wire":[2664,107,2555,0]}
{"wire":[2354,0,2664,114]}
{"wire":[2354,3,2664,114]}
{"wire":[2354,5,2664,114]}
{"wire":[2354,2,2664,0]}
{"wire":[2354,15,2664,113]}
{"wire":[2354,16,2664,148]}
{"wire":[2354,17,2664,149]}
ASEEND*/
//CHKSM=85C8F712C0A0266D7C7CFE0DCA6F504DD8E92A92