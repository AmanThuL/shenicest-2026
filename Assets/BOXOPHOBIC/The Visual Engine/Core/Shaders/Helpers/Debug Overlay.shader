// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Overlay"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_OverlayIntensityValue( "Overlay Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,On,1)] _OverlayTextureMode( "Overlay Maps", Float ) = 0
		[Space(10)] _OverlayGlitterIntensityValue( "Overlay Glitter Intensity", Range( 0, 1 ) ) = 0
		_OverlayAtmoValue( "Overlay Atmo Mask", Range( 0, 1 ) ) = 1
		[Enum(Global Data Only,0,Use Atmo Elements,1)] _OverlayAtmoMode( "Overlay Atmo Mask", Float ) = 1
		_OverlayLumaValue( "Overlay Luma Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _OverlayLumaRemap( "Overlay Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_OverlayBaseValue( "Overlay Base Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _OverlayBaseRemap( "Overlay Base Mask", Vector ) = ( 1, 0, 0, 1 )
		_OverlayProjValue( "Overlay ProjY Mask", Range( 0, 1 ) ) = 0.5
		[StyledRemapSlider] _OverlayProjRemap( "Overlay ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_OverlayMeshValue( "Overlay Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _OverlayMeshMode( "Overlay Mesh Mask", Float ) = 1
		[StyledRemapSlider] _OverlayMeshRemap( "Overlay Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Multiply,0,Buildup,1)] _OverlayBlendMath( "Overlay Blend Mask", Float ) = 1
		[StyledRemapSlider] _OverlayBlendRemap( "Overlay Blend Mask", Vector ) = ( 0, 0.1, 0, 0 )
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
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_OVERLAY_ATMO
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
				uniform half _OverlayIntensityValue;
				uniform half _OverlayTextureMode;
				uniform half _OverlayGlitterIntensityValue;
				uniform half _OverlayAtmoMode;
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
				uniform half4 _OverlayLumaRemap;
				uniform half _OverlayLumaValue;
				uniform half4 _OverlayBaseRemap;
				uniform half _OverlayBaseValue;
				uniform half4 _OverlayProjRemap;
				uniform half _OverlayProjValue;
				uniform half _OverlayMeshMode;
				uniform half4 _OverlayMeshRemap;
				uniform half _OverlayMeshValue;
				uniform half _OverlayBlendMath;
				uniform half4 _OverlayBlendRemap;
				uniform half _OverlayAtmoValue;
				uniform half TVE_DEBUG_Global;
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

					TVEVertexData Data16_g251752 =(TVEVertexData)0;
					float In_Dummy16_g251752 = 0.0;
					TVEVertexData Data16_g251747 =(TVEVertexData)0;
					float In_Dummy16_g251747 = 0.0;
					float localIfModelDataByShader26_g251547 = ( 0.0 );
					TVEModelData Data26_g251547 = (TVEModelData)0;
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
					TVEModelData DataDefault26_g251547 = Data16_g241434;
					TVEModelData DataGeneral26_g251547 = Data16_g241434;
					TVEModelData DataBlanket26_g251547 = Data16_g241434;
					TVEModelData DataImpostor26_g251547 = Data16_g241434;
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
					TVEModelData DataTerrain26_g251547 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251547 = IsShaderType2672;
					{
					if (Type26_g251547 == 0 )
					{
					Data26_g251547 = DataDefault26_g251547;
					}
					else if (Type26_g251547 == 1 )
					{
					Data26_g251547 = DataGeneral26_g251547;
					}
					else if (Type26_g251547 == 2 )
					{
					Data26_g251547 = DataBlanket26_g251547;
					}
					else if (Type26_g251547 == 3 )
					{
					Data26_g251547 = DataImpostor26_g251547;
					}
					else if (Type26_g251547 == 4 )
					{
					Data26_g251547 = DataTerrain26_g251547;
					}
					}
					TVEModelData Data15_g251748 =(TVEModelData)Data26_g251547;
					float Out_Dummy15_g251748 = 0.0;
					float3 Out_PositionOS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251748 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251748 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251748 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251748 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251748 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251748 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251748 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251748 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251748 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251748 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251748 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251748 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251748 , Out_Dummy15_g251748 , Out_PositionOS15_g251748 , Out_PositionWS15_g251748 , Out_PositionWO15_g251748 , Out_PositionRawOS15_g251748 , Out_PivotOS15_g251748 , Out_PivotWS15_g251748 , Out_PivotWO15_g251748 , Out_NormalOS15_g251748 , Out_NormalWS15_g251748 , Out_NormalRawOS15_g251748 , Out_TangentOS15_g251748 , Out_TangentWS15_g251748 , Out_BitangentWS15_g251748 , Out_ViewDirWS15_g251748 , Out_CoordsData15_g251748 , Out_VertexData15_g251748 , Out_MasksData15_g251748 , Out_PhaseData15_g251748 , Out_TransformData15_g251748 , Out_RotationData15_g251748 , Out_Interpolator15_g251748 );
					float3 In_PositionOS16_g251747 = Out_PositionOS15_g251748;
					float3 In_NormalOS16_g251747 = Out_NormalOS15_g251748;
					float4 In_TangentOS16_g251747 = Out_TangentOS15_g251748;
					float4 In_TransformData16_g251747 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251747 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251747 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251747 , In_Dummy16_g251747 , In_PositionOS16_g251747 , In_NormalOS16_g251747 , In_TangentOS16_g251747 , In_TransformData16_g251747 , In_RotationData16_g251747 , In_Interpolator16_g251747 );
					TVEVertexData Data15_g251750 =(TVEVertexData)Data16_g251747;
					float Out_Dummy15_g251750 = 0.0;
					float3 Out_PositionOS15_g251750 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251750 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251750 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251750 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251750 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251750 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251750 , Out_Dummy15_g251750 , Out_PositionOS15_g251750 , Out_NormalOS15_g251750 , Out_TangentOS15_g251750 , Out_TransformData15_g251750 , Out_RotationData15_g251750 , Out_Interpolator15_g251750 );
					TVEModelData Data15_g251751 =(TVEModelData)Data15_g251748;
					float Out_Dummy15_g251751 = 0.0;
					float3 Out_PositionOS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251751 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251751 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251751 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251751 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251751 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251751 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251751 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251751 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251751 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251751 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251751 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251751 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251751 , Out_Dummy15_g251751 , Out_PositionOS15_g251751 , Out_PositionWS15_g251751 , Out_PositionWO15_g251751 , Out_PositionRawOS15_g251751 , Out_PivotOS15_g251751 , Out_PivotWS15_g251751 , Out_PivotWO15_g251751 , Out_NormalOS15_g251751 , Out_NormalWS15_g251751 , Out_NormalRawOS15_g251751 , Out_TangentOS15_g251751 , Out_TangentWS15_g251751 , Out_BitangentWS15_g251751 , Out_ViewDirWS15_g251751 , Out_CoordsData15_g251751 , Out_VertexData15_g251751 , Out_MasksData15_g251751 , Out_PhaseData15_g251751 , Out_TransformData15_g251751 , Out_RotationData15_g251751 , Out_Interpolator15_g251751 );
					float3 In_PositionOS16_g251752 = ( Out_PositionOS15_g251750 - Out_PivotOS15_g251751 );
					float3 In_NormalOS16_g251752 = Out_NormalOS15_g251751;
					float4 In_TangentOS16_g251752 = Out_TangentOS15_g251751;
					float4 In_TransformData16_g251752 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251752 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251752 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251752 , In_Dummy16_g251752 , In_PositionOS16_g251752 , In_NormalOS16_g251752 , In_TangentOS16_g251752 , In_TransformData16_g251752 , In_RotationData16_g251752 , In_Interpolator16_g251752 );
					TVEVertexData Data15_g251761 =(TVEVertexData)Data16_g251752;
					float Out_Dummy15_g251761 = 0.0;
					float3 Out_PositionOS15_g251761 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251761 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251761 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251761 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251761 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251761 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251761 , Out_Dummy15_g251761 , Out_PositionOS15_g251761 , Out_NormalOS15_g251761 , Out_TangentOS15_g251761 , Out_TransformData15_g251761 , Out_RotationData15_g251761 , Out_Interpolator15_g251761 );
					TVEVertexData Data16_g251762 =(TVEVertexData)Data15_g251761;
					half Dummy317_g251753 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251762 = Dummy317_g251753;
					float3 In_PositionOS16_g251762 = Out_PositionOS15_g251761;
					float3 In_NormalOS16_g251762 = Out_NormalOS15_g251761;
					float4 In_TangentOS16_g251762 = Out_TangentOS15_g251761;
					half4 Model_TransformData356_g251753 = Out_TransformData15_g251761;
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
					TVEGlobalData Data15_g251763 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251763 = 0.0;
					float4 Out_CoatTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251763 = float4( 0,0,0,0 );
					BreakData( Data15_g251763 , Out_Dummy15_g251763 , Out_CoatTexture15_g251763 , Out_DrawTexture15_g251763 , Out_PaintTexture15_g251763 , Out_AtmoTexture15_g251763 , Out_EffexTexture15_g251763 , Out_GlowTexture15_g251763 , Out_FormTexture15_g251763 , Out_LandTexture15_g251763 , Out_VertxTexture15_g251763 , Out_FlowTexture15_g251763 , Out_UserTexture15_g251763 );
					float4 Global_FormTexture351_g251753 = Out_FormTexture15_g251763;
					TVEModelData Data15_g251760 =(TVEModelData)Data15_g251751;
					float Out_Dummy15_g251760 = 0.0;
					float3 Out_PositionOS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251760 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251760 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251760 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251760 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251760 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251760 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251760 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251760 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251760 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251760 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251760 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251760 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251760 , Out_Dummy15_g251760 , Out_PositionOS15_g251760 , Out_PositionWS15_g251760 , Out_PositionWO15_g251760 , Out_PositionRawOS15_g251760 , Out_PivotOS15_g251760 , Out_PivotWS15_g251760 , Out_PivotWO15_g251760 , Out_NormalOS15_g251760 , Out_NormalWS15_g251760 , Out_NormalRawOS15_g251760 , Out_TangentOS15_g251760 , Out_TangentWS15_g251760 , Out_BitangentWS15_g251760 , Out_ViewDirWS15_g251760 , Out_CoordsData15_g251760 , Out_VertexData15_g251760 , Out_MasksData15_g251760 , Out_PhaseData15_g251760 , Out_TransformData15_g251760 , Out_RotationData15_g251760 , Out_Interpolator15_g251760 );
					float3 Model_PivotWO353_g251753 = Out_PivotWO15_g251760;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251759 = _ConformMeshMode;
					float Option70_g251759 = temp_output_17_0_g251759;
					half4 Model_VertexData357_g251753 = Out_VertexData15_g251760;
					float4 temp_output_3_0_g251759 = Model_VertexData357_g251753;
					float4 Channel70_g251759 = temp_output_3_0_g251759;
					float localSwitchChannel470_g251759 = SwitchChannel4( Option70_g251759 , Channel70_g251759 );
					float temp_output_390_0_g251753 = localSwitchChannel470_g251759;
					float temp_output_7_0_g251756 = _ConformMeshRemap.x;
					float temp_output_9_0_g251756 = ( temp_output_390_0_g251753 - temp_output_7_0_g251756 );
					float lerpResult374_g251753 = lerp( 1.0 , saturate( ( temp_output_9_0_g251756 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251753 = lerpResult374_g251753;
					float temp_output_328_0_g251753 = ( Blend_VertMask379_g251753 * TVE_IsEnabled );
					half Conform_Mask366_g251753 = temp_output_328_0_g251753;
					float temp_output_322_0_g251753 = ( ( ( ( (Global_FormTexture351_g251753).z - ( (Model_PivotWO353_g251753).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251753 ) );
					float3 appendResult329_g251753 = (float3(0.0 , temp_output_322_0_g251753 , 0.0));
					float3 appendResult387_g251753 = (float3(0.0 , 0.0 , temp_output_322_0_g251753));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251757 = appendResult387_g251753;
					#else
					float3 staticSwitch65_g251757 = appendResult329_g251753;
					#endif
					float3 Blanket_Conform368_g251753 = staticSwitch65_g251757;
					float4 appendResult312_g251753 = (float4(Blanket_Conform368_g251753 , 0.0));
					float4 temp_output_310_0_g251753 = ( Model_TransformData356_g251753 + appendResult312_g251753 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251753 = temp_output_310_0_g251753;
					#else
					float4 staticSwitch364_g251753 = Model_TransformData356_g251753;
					#endif
					half4 Final_TransformData365_g251753 = staticSwitch364_g251753;
					float4 In_TransformData16_g251762 = Final_TransformData365_g251753;
					float4 In_RotationData16_g251762 = Out_RotationData15_g251761;
					float4 In_Interpolator16_g251762 = Out_Interpolator15_g251761;
					BuildVertexData( Data16_g251762 , In_Dummy16_g251762 , In_PositionOS16_g251762 , In_NormalOS16_g251762 , In_TangentOS16_g251762 , In_TransformData16_g251762 , In_RotationData16_g251762 , In_Interpolator16_g251762 );
					TVEVertexData Data15_g251773 =(TVEVertexData)Data16_g251762;
					float Out_Dummy15_g251773 = 0.0;
					float3 Out_PositionOS15_g251773 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251773 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251773 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251773 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251773 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251773 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251773 , Out_Dummy15_g251773 , Out_PositionOS15_g251773 , Out_NormalOS15_g251773 , Out_TangentOS15_g251773 , Out_TransformData15_g251773 , Out_RotationData15_g251773 , Out_Interpolator15_g251773 );
					TVEVertexData Data16_g251774 =(TVEVertexData)Data15_g251773;
					float In_Dummy16_g251774 = 0.0;
					float3 Vertex_PositionOS147_g251764 = Out_PositionOS15_g251773;
					half3 VertexPos40_g251768 = Vertex_PositionOS147_g251764;
					float4 temp_output_1615_33_g251764 = Out_RotationData15_g251773;
					half4 Vertex_RotationData1569_g251764 = temp_output_1615_33_g251764;
					float2 break1582_g251764 = (Vertex_RotationData1569_g251764).xy;
					half Angle44_g251768 = break1582_g251764.y;
					half CosAngle89_g251768 = cos( Angle44_g251768 );
					half SinAngle93_g251768 = sin( Angle44_g251768 );
					float3 appendResult95_g251768 = (float3((VertexPos40_g251768).x , ( ( (VertexPos40_g251768).y * CosAngle89_g251768 ) - ( (VertexPos40_g251768).z * SinAngle93_g251768 ) ) , ( ( (VertexPos40_g251768).y * SinAngle93_g251768 ) + ( (VertexPos40_g251768).z * CosAngle89_g251768 ) )));
					half3 VertexPos40_g251769 = appendResult95_g251768;
					half Angle44_g251769 = -break1582_g251764.x;
					half CosAngle94_g251769 = cos( Angle44_g251769 );
					half SinAngle95_g251769 = sin( Angle44_g251769 );
					float3 appendResult98_g251769 = (float3(( ( (VertexPos40_g251769).x * CosAngle94_g251769 ) - ( (VertexPos40_g251769).y * SinAngle95_g251769 ) ) , ( ( (VertexPos40_g251769).x * SinAngle95_g251769 ) + ( (VertexPos40_g251769).y * CosAngle94_g251769 ) ) , (VertexPos40_g251769).z));
					half3 VertexPos40_g251767 = Vertex_PositionOS147_g251764;
					half Angle44_g251767 = break1582_g251764.y;
					half CosAngle89_g251767 = cos( Angle44_g251767 );
					half SinAngle93_g251767 = sin( Angle44_g251767 );
					float3 appendResult95_g251767 = (float3((VertexPos40_g251767).x , ( ( (VertexPos40_g251767).y * CosAngle89_g251767 ) - ( (VertexPos40_g251767).z * SinAngle93_g251767 ) ) , ( ( (VertexPos40_g251767).y * SinAngle93_g251767 ) + ( (VertexPos40_g251767).z * CosAngle89_g251767 ) )));
					half3 VertexPos40_g251772 = appendResult95_g251767;
					half Angle44_g251772 = break1582_g251764.x;
					half CosAngle91_g251772 = cos( Angle44_g251772 );
					half SinAngle92_g251772 = sin( Angle44_g251772 );
					float3 appendResult93_g251772 = (float3(( ( (VertexPos40_g251772).x * CosAngle91_g251772 ) + ( (VertexPos40_g251772).z * SinAngle92_g251772 ) ) , (VertexPos40_g251772).y , ( ( -(VertexPos40_g251772).x * SinAngle92_g251772 ) + ( (VertexPos40_g251772).z * CosAngle91_g251772 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251770 = appendResult93_g251772;
					#else
					float3 staticSwitch65_g251770 = appendResult98_g251769;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251765 = staticSwitch65_g251770;
					#else
					float3 staticSwitch65_g251765 = Vertex_PositionOS147_g251764;
					#endif
					float3 temp_output_1608_0_g251764 = staticSwitch65_g251765;
					half3 VertexPos40_g251771 = temp_output_1608_0_g251764;
					half Angle44_g251771 = (Vertex_RotationData1569_g251764).z;
					half CosAngle91_g251771 = cos( Angle44_g251771 );
					half SinAngle92_g251771 = sin( Angle44_g251771 );
					float3 appendResult93_g251771 = (float3(( ( (VertexPos40_g251771).x * CosAngle91_g251771 ) + ( (VertexPos40_g251771).z * SinAngle92_g251771 ) ) , (VertexPos40_g251771).y , ( ( -(VertexPos40_g251771).x * SinAngle92_g251771 ) + ( (VertexPos40_g251771).z * CosAngle91_g251771 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251766 = appendResult93_g251771;
					#else
					float3 staticSwitch65_g251766 = temp_output_1608_0_g251764;
					#endif
					float4 temp_output_1615_31_g251764 = Out_TransformData15_g251773;
					half4 Vertex_TransformData1568_g251764 = temp_output_1615_31_g251764;
					half3 Final_PositionOS178_g251764 = ( ( staticSwitch65_g251766 * (Vertex_TransformData1568_g251764).w ) + (Vertex_TransformData1568_g251764).xyz );
					float3 In_PositionOS16_g251774 = Final_PositionOS178_g251764;
					float3 In_NormalOS16_g251774 = Out_NormalOS15_g251773;
					float4 In_TangentOS16_g251774 = Out_TangentOS15_g251773;
					float4 In_TransformData16_g251774 = temp_output_1615_31_g251764;
					float4 In_RotationData16_g251774 = temp_output_1615_33_g251764;
					float4 In_Interpolator16_g251774 = Out_Interpolator15_g251773;
					BuildVertexData( Data16_g251774 , In_Dummy16_g251774 , In_PositionOS16_g251774 , In_NormalOS16_g251774 , In_TangentOS16_g251774 , In_TransformData16_g251774 , In_RotationData16_g251774 , In_Interpolator16_g251774 );
					TVEVertexData Data15_g251777 =(TVEVertexData)Data16_g251774;
					float Out_Dummy15_g251777 = 0.0;
					float3 Out_PositionOS15_g251777 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251777 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251777 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251777 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251777 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251777 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251777 , Out_Dummy15_g251777 , Out_PositionOS15_g251777 , Out_NormalOS15_g251777 , Out_TangentOS15_g251777 , Out_TransformData15_g251777 , Out_RotationData15_g251777 , Out_Interpolator15_g251777 );
					TVEVertexData Data16_g251778 =(TVEVertexData)Data15_g251777;
					float In_Dummy16_g251778 = 0.0;
					TVEModelData Data15_g251776 =(TVEModelData)Data15_g251760;
					float Out_Dummy15_g251776 = 0.0;
					float3 Out_PositionOS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251776 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251776 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251776 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251776 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251776 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251776 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251776 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251776 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251776 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251776 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251776 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251776 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251776 , Out_Dummy15_g251776 , Out_PositionOS15_g251776 , Out_PositionWS15_g251776 , Out_PositionWO15_g251776 , Out_PositionRawOS15_g251776 , Out_PivotOS15_g251776 , Out_PivotWS15_g251776 , Out_PivotWO15_g251776 , Out_NormalOS15_g251776 , Out_NormalWS15_g251776 , Out_NormalRawOS15_g251776 , Out_TangentOS15_g251776 , Out_TangentWS15_g251776 , Out_BitangentWS15_g251776 , Out_ViewDirWS15_g251776 , Out_CoordsData15_g251776 , Out_VertexData15_g251776 , Out_MasksData15_g251776 , Out_PhaseData15_g251776 , Out_TransformData15_g251776 , Out_RotationData15_g251776 , Out_Interpolator15_g251776 );
					float3 In_PositionOS16_g251778 = ( Out_PositionOS15_g251777 + Out_PivotOS15_g251776 );
					float3 In_NormalOS16_g251778 = Out_NormalOS15_g251777;
					float4 In_TangentOS16_g251778 = Out_TangentOS15_g251777;
					float4 In_TransformData16_g251778 = Out_TransformData15_g251777;
					float4 In_RotationData16_g251778 = Out_RotationData15_g251777;
					float4 In_Interpolator16_g251778 = Out_Interpolator15_g251777;
					BuildVertexData( Data16_g251778 , In_Dummy16_g251778 , In_PositionOS16_g251778 , In_NormalOS16_g251778 , In_TangentOS16_g251778 , In_TransformData16_g251778 , In_RotationData16_g251778 , In_Interpolator16_g251778 );
					TVEVertexData Data15_g254374 =(TVEVertexData)Data16_g251778;
					float Out_Dummy15_g254374 = 0.0;
					float3 Out_PositionOS15_g254374 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254374 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254374 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254374 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254374 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254374 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254374 , Out_Dummy15_g254374 , Out_PositionOS15_g254374 , Out_NormalOS15_g254374 , Out_TangentOS15_g254374 , Out_TransformData15_g254374 , Out_RotationData15_g254374 , Out_Interpolator15_g254374 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g241416;
					o.ase_texcoord7.xyz = vertexToFrag76_g241416;
					TVEVertexData Data1902_g252029 = Data16_g251778;
					float4 Out_Interpolator1902_g252029 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g252029 = Data1902_g252029.Interpolator;
					}
					float4 vertexToFrag1901_g252029 = Out_Interpolator1902_g252029;
					o.ase_texcoord9 = vertexToFrag1901_g252029;
					float3 vertexPos57_g254366 = v.vertex.xyz;
					float4 ase_positionCS57_g254366 = UnityObjectToClipPos( vertexPos57_g254366 );
					o.ase_texcoord10 = ase_positionCS57_g254366;
					
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
					float3 vertexValue = Out_PositionOS15_g254374;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254374;
					v.tangent = Out_TangentOS15_g254374;

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
					
					float3 color130_g254366 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g254366 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g254368 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g254367 = ( temp_cast_4 * ( 0.5 + appendResult128_g254368 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g254367 = (float4(ddx( FinalUV13_g254367 ) , ddy( FinalUV13_g254367 )));
					float4 UVDerivatives17_g254367 = appendResult16_g254367;
					float4 break28_g254367 = UVDerivatives17_g254367;
					float2 appendResult19_g254367 = (float2(break28_g254367.x , break28_g254367.z));
					float2 appendResult20_g254367 = (float2(break28_g254367.x , break28_g254367.z));
					float dotResult24_g254367 = dot( appendResult19_g254367 , appendResult20_g254367 );
					float2 appendResult21_g254367 = (float2(break28_g254367.y , break28_g254367.w));
					float2 appendResult22_g254367 = (float2(break28_g254367.y , break28_g254367.w));
					float dotResult23_g254367 = dot( appendResult21_g254367 , appendResult22_g254367 );
					float2 appendResult25_g254367 = (float2(dotResult24_g254367 , dotResult23_g254367));
					float2 derivativesLength29_g254367 = sqrt( appendResult25_g254367 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g254367 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g254367 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g254367 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g254367 = clampResult57_g254367;
					float2 break55_g254367 = derivativesLength29_g254367;
					float4 lerpResult73_g254367 = lerp( float4( color130_g254366 , 0.0 ) , float4( color81_g254366 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g254367.x * break71_g254367.y * sqrt( saturate( ( 1.1 - max( break55_g254367.x, break55_g254367.y ) ) ) ) ) ) ));
					float3 color107_g254352 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254352 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g254351 = ( 0.0 );
					float localIfMasksData25_g254350 = ( 0.0 );
					TVEMasksData Data25_g254350 = (TVEMasksData)0;
					float localBuildMasksData3_g252127 = ( 0.0 );
					TVEMasksData Data3_g252127 = (TVEMasksData)0;
					half Feature_Intensity1107_g252072 = _OverlayIntensityValue;
					float ifLocalVar18_g252123 = 0;
					if( Feature_Intensity1107_g252072 <= 0.0 )
					ifLocalVar18_g252123 = 0.0;
					else
					ifLocalVar18_g252123 = 1.0;
					half Feature_Maps1112_g252072 = _OverlayTextureMode;
					float ifLocalVar18_g252124 = 0;
					if( Feature_Maps1112_g252072 <= 0.0 )
					ifLocalVar18_g252124 = 0.0;
					else
					ifLocalVar18_g252124 = 1.0;
					half Feature_Glitter1108_g252072 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g252125 = 0;
					if( Feature_Glitter1108_g252072 <= 0.0 )
					ifLocalVar18_g252125 = 0.0;
					else
					ifLocalVar18_g252125 = 1.0;
					half Feature_Element1085_g252072 = _OverlayAtmoMode;
					float ifLocalVar18_g252122 = 0;
					if( Feature_Element1085_g252072 <= 0.0 )
					ifLocalVar18_g252122 = 0.0;
					else
					ifLocalVar18_g252122 = 1.0;
					float4 appendResult1117_g252072 = (float4(ifLocalVar18_g252123 , ifLocalVar18_g252124 , ifLocalVar18_g252125 , ifLocalVar18_g252122));
					float4 In_MaskA3_g252127 = appendResult1117_g252072;
					half Blend_TexMask908_g252072 = 1.0;
					float localBreakVisualData4_g252146 = ( 0.0 );
					float localBuildVisualData3_g252035 = ( 0.0 );
					float localBuildVisualData3_g252030 = ( 0.0 );
					TVEVisualData Data3_g252030 =(TVEVisualData)0;
					float temp_output_14_0_g252030 = 0.0;
					float In_Dummy3_g252030 = temp_output_14_0_g252030;
					float3 temp_cast_9 = (0.5).xxx;
					float3 temp_output_4_0_g252030 = temp_cast_9;
					float3 In_Albedo3_g252030 = temp_output_4_0_g252030;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_44_0_g252030 = temp_cast_10;
					float3 In_AlbedoBase3_g252030 = temp_output_44_0_g252030;
					float2 temp_cast_11 = (0.0).xx;
					float2 In_NormalTS3_g252030 = temp_cast_11;
					float3 temp_cast_12 = (0.5).xxx;
					float3 In_NormalWS3_g252030 = temp_cast_12;
					float4 In_Shader3_g252030 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g252030 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252030 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252030 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g252030 = 0.5;
					float In_Grayscale3_g252030 = temp_output_12_0_g252030;
					float temp_output_16_0_g252030 = 1.0;
					float In_Luminosity3_g252030 = temp_output_16_0_g252030;
					float In_MultiMask3_g252030 = 1.0;
					float In_AlphaClip3_g252030 = 1.0;
					float In_AlphaFade3_g252030 = 1.0;
					float3 temp_cast_13 = (1.0).xxx;
					float3 In_Translucency3_g252030 = temp_cast_13;
					float In_Transmission3_g252030 = 1.0;
					float In_Thickness3_g252030 = 0.0;
					float In_Diffusion3_g252030 = 0.0;
					float In_Depth3_g252030 = 0.0;
					BuildVisualData( Data3_g252030 , In_Dummy3_g252030 , In_Albedo3_g252030 , In_AlbedoBase3_g252030 , In_NormalTS3_g252030 , In_NormalWS3_g252030 , In_Shader3_g252030 , In_Feature3_g252030 , In_Season3_g252030 , In_Emissive3_g252030 , In_Grayscale3_g252030 , In_Luminosity3_g252030 , In_MultiMask3_g252030 , In_AlphaClip3_g252030 , In_AlphaFade3_g252030 , In_Translucency3_g252030 , In_Transmission3_g252030 , In_Thickness3_g252030 , In_Diffusion3_g252030 , In_Depth3_g252030 );
					TVEVisualData Data3_g252035 =(TVEVisualData)Data3_g252030;
					half Dummy130_g252033 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g252035 = Dummy130_g252033;
					float In_Dummy3_g252035 = temp_output_14_0_g252035;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252056) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g252038 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g252056 = staticSwitch36_g252038;
					float localBreakTextureData456_g252056 = ( 0.0 );
					float localBuildTextureData431_g252055 = ( 0.0 );
					TVEMasksData Data431_g252055 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252055 = ( 0.0 );
					float4 temp_output_6_0_g252071 = _main_coord_value;
					float4 temp_output_7_0_g252071 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252071 = ( temp_output_6_0_g252071 + temp_output_7_0_g252071 );
					#else
					float4 staticSwitch14_g252071 = temp_output_6_0_g252071;
					#endif
					half4 Local_Coords180_g252033 = staticSwitch14_g252071;
					float4 Coords444_g252055 = Local_Coords180_g252033;
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
					TVEModelData Data15_g252031 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g252031 = 0.0;
					float3 Out_PositionWS15_g252031 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252031 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252031 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252031 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252031 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252031 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252031 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252031 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252031 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252031 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252031 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252031 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252031 , Out_Dummy15_g252031 , Out_PositionWS15_g252031 , Out_PositionWO15_g252031 , Out_PivotWS15_g252031 , Out_PivotWO15_g252031 , Out_NormalWS15_g252031 , Out_TangentWS15_g252031 , Out_BitangentWS15_g252031 , Out_TriplanarWeights15_g252031 , Out_ViewDirWS15_g252031 , Out_CoordsData15_g252031 , Out_VertexData15_g252031 , Out_Interpolator15_g252031 );
					TVEModelData Data16_g252032 =(TVEModelData)Data15_g252031;
					float In_Dummy16_g252032 = Out_Dummy15_g252031;
					float3 In_PositionWS16_g252032 = Out_PositionWS15_g252031;
					float3 In_PositionWO16_g252032 = Out_PositionWO15_g252031;
					float3 In_PivotWS16_g252032 = Out_PivotWS15_g252031;
					float3 In_PivotWO16_g252032 = Out_PivotWO15_g252031;
					float3 In_NormalWS16_g252032 = Out_NormalWS15_g252031;
					float3 In_TangentWS16_g252032 = Out_TangentWS15_g252031;
					float3 In_BitangentWS16_g252032 = Out_BitangentWS15_g252031;
					float3 In_TriplanarWeights16_g252032 = Out_TriplanarWeights15_g252031;
					float3 In_ViewDirWS16_g252032 = Out_ViewDirWS15_g252031;
					float4 In_CoordsData16_g252032 = Out_CoordsData15_g252031;
					float4 In_VertexData16_g252032 = Out_VertexData15_g252031;
					float4 vertexToFrag1901_g252029 = IN.ase_texcoord9;
					float4 In_Interpolator16_g252032 = vertexToFrag1901_g252029;
					BuildModelFragData( Data16_g252032 , In_Dummy16_g252032 , In_PositionWS16_g252032 , In_PositionWO16_g252032 , In_PivotWS16_g252032 , In_PivotWO16_g252032 , In_NormalWS16_g252032 , In_TangentWS16_g252032 , In_BitangentWS16_g252032 , In_TriplanarWeights16_g252032 , In_ViewDirWS16_g252032 , In_CoordsData16_g252032 , In_VertexData16_g252032 , In_Interpolator16_g252032 );
					TVEModelData Data15_g252034 =(TVEModelData)Data16_g252032;
					float Out_Dummy15_g252034 = 0.0;
					float3 Out_PositionWS15_g252034 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252034 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252034 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252034 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252034 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252034 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252034 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252034 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252034 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252034 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252034 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252034 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252034 , Out_Dummy15_g252034 , Out_PositionWS15_g252034 , Out_PositionWO15_g252034 , Out_PivotWS15_g252034 , Out_PivotWO15_g252034 , Out_NormalWS15_g252034 , Out_TangentWS15_g252034 , Out_BitangentWS15_g252034 , Out_TriplanarWeights15_g252034 , Out_ViewDirWS15_g252034 , Out_CoordsData15_g252034 , Out_VertexData15_g252034 , Out_Interpolator15_g252034 );
					float4 Model_CoordsData324_g252033 = Out_CoordsData15_g252034;
					float4 MeshCoords444_g252055 = Model_CoordsData324_g252033;
					float2 UV0444_g252055 = float2( 0,0 );
					float2 UV3444_g252055 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252055 , MeshCoords444_g252055 , UV0444_g252055 , UV3444_g252055 );
					float4 appendResult430_g252055 = (float4(UV0444_g252055 , UV3444_g252055));
					float4 In_MaskA431_g252055 = appendResult430_g252055;
					float localComputeWorldCoords315_g252055 = ( 0.0 );
					float4 Coords315_g252055 = Local_Coords180_g252033;
					float3 Model_PositionWO222_g252033 = Out_PositionWO15_g252034;
					float3 PositionWS315_g252055 = Model_PositionWO222_g252033;
					float2 ZY315_g252055 = float2( 0,0 );
					float2 XZ315_g252055 = float2( 0,0 );
					float2 XY315_g252055 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252055 , PositionWS315_g252055 , ZY315_g252055 , XZ315_g252055 , XY315_g252055 );
					float2 ZY402_g252055 = ZY315_g252055;
					float2 XZ403_g252055 = XZ315_g252055;
					float4 appendResult432_g252055 = (float4(ZY402_g252055 , XZ403_g252055));
					float4 In_MaskB431_g252055 = appendResult432_g252055;
					float2 XY404_g252055 = XY315_g252055;
					float localComputeStochasticCoords409_g252055 = ( 0.0 );
					float2 UV409_g252055 = ZY402_g252055;
					float2 UV1409_g252055 = float2( 0,0 );
					float2 UV2409_g252055 = float2( 0,0 );
					float2 UV3409_g252055 = float2( 0,0 );
					float3 Weights409_g252055 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252055 , UV1409_g252055 , UV2409_g252055 , UV3409_g252055 , Weights409_g252055 );
					float4 appendResult433_g252055 = (float4(XY404_g252055 , UV1409_g252055));
					float4 In_MaskC431_g252055 = appendResult433_g252055;
					float4 appendResult434_g252055 = (float4(UV2409_g252055 , UV3409_g252055));
					float4 In_MaskD431_g252055 = appendResult434_g252055;
					float localComputeStochasticCoords422_g252055 = ( 0.0 );
					float2 UV422_g252055 = XZ403_g252055;
					float2 UV1422_g252055 = float2( 0,0 );
					float2 UV2422_g252055 = float2( 0,0 );
					float2 UV3422_g252055 = float2( 0,0 );
					float3 Weights422_g252055 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252055 , UV1422_g252055 , UV2422_g252055 , UV3422_g252055 , Weights422_g252055 );
					float4 appendResult435_g252055 = (float4(UV1422_g252055 , UV2422_g252055));
					float4 In_MaskE431_g252055 = appendResult435_g252055;
					float localComputeStochasticCoords423_g252055 = ( 0.0 );
					float2 UV423_g252055 = XY404_g252055;
					float2 UV1423_g252055 = float2( 0,0 );
					float2 UV2423_g252055 = float2( 0,0 );
					float2 UV3423_g252055 = float2( 0,0 );
					float3 Weights423_g252055 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252055 , UV1423_g252055 , UV2423_g252055 , UV3423_g252055 , Weights423_g252055 );
					float4 appendResult436_g252055 = (float4(UV3422_g252055 , UV1423_g252055));
					float4 In_MaskF431_g252055 = appendResult436_g252055;
					float4 appendResult437_g252055 = (float4(UV2423_g252055 , UV3423_g252055));
					float4 In_MaskG431_g252055 = appendResult437_g252055;
					float4 In_MaskH431_g252055 = float4( Weights409_g252055 , 0.0 );
					float4 In_MaskI431_g252055 = float4( Weights422_g252055 , 0.0 );
					float4 In_MaskJ431_g252055 = float4( Weights423_g252055 , 0.0 );
					half3 Model_NormalWS226_g252033 = Out_NormalWS15_g252034;
					float3 temp_output_449_0_g252055 = Model_NormalWS226_g252033;
					float4 In_MaskK431_g252055 = float4( temp_output_449_0_g252055 , 0.0 );
					half3 Model_TangentWS366_g252033 = Out_TangentWS15_g252034;
					float3 temp_output_450_0_g252055 = Model_TangentWS366_g252033;
					float4 In_MaskL431_g252055 = float4( temp_output_450_0_g252055 , 0.0 );
					half3 Model_BitangentWS367_g252033 = Out_BitangentWS15_g252034;
					float3 temp_output_451_0_g252055 = Model_BitangentWS367_g252033;
					float4 In_MaskM431_g252055 = float4( temp_output_451_0_g252055 , 0.0 );
					half3 Model_TriplanarWeights368_g252033 = Out_TriplanarWeights15_g252034;
					float3 temp_output_445_0_g252055 = Model_TriplanarWeights368_g252033;
					float4 In_MaskN431_g252055 = float4( temp_output_445_0_g252055 , 0.0 );
					BuildTextureData( Data431_g252055 , In_MaskA431_g252055 , In_MaskB431_g252055 , In_MaskC431_g252055 , In_MaskD431_g252055 , In_MaskE431_g252055 , In_MaskF431_g252055 , In_MaskG431_g252055 , In_MaskH431_g252055 , In_MaskI431_g252055 , In_MaskJ431_g252055 , In_MaskK431_g252055 , In_MaskL431_g252055 , In_MaskM431_g252055 , In_MaskN431_g252055 );
					TVEMasksData Data456_g252056 =(TVEMasksData)Data431_g252055;
					float4 Out_MaskA456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252056 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252056 , Out_MaskA456_g252056 , Out_MaskB456_g252056 , Out_MaskC456_g252056 , Out_MaskD456_g252056 , Out_MaskE456_g252056 , Out_MaskF456_g252056 , Out_MaskG456_g252056 , Out_MaskH456_g252056 , Out_MaskI456_g252056 , Out_MaskJ456_g252056 , Out_MaskK456_g252056 , Out_MaskL456_g252056 , Out_MaskM456_g252056 , Out_MaskN456_g252056 );
					half2 UV276_g252056 = (Out_MaskA456_g252056).xy;
					float temp_output_504_0_g252056 = 0.0;
					half Bias276_g252056 = temp_output_504_0_g252056;
					half2 Normal276_g252056 = float2( 0,0 );
					half4 localSampleCoord276_g252056 = SampleCoord( Texture276_g252056 , Sampler276_g252056 , UV276_g252056 , Bias276_g252056 , Normal276_g252056 );
					float4 temp_output_407_277_g252033 = localSampleCoord276_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252056) = _MainAlbedoTex;
					SamplerState Sampler502_g252056 = staticSwitch36_g252038;
					half2 UV502_g252056 = (Out_MaskA456_g252056).zw;
					half Bias502_g252056 = temp_output_504_0_g252056;
					half2 Normal502_g252056 = float2( 0,0 );
					half4 localSampleCoord502_g252056 = SampleCoord( Texture502_g252056 , Sampler502_g252056 , UV502_g252056 , Bias502_g252056 , Normal502_g252056 );
					float4 temp_output_407_278_g252033 = localSampleCoord502_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252056) = _MainAlbedoTex;
					SamplerState Sampler496_g252056 = staticSwitch36_g252038;
					float2 temp_output_463_0_g252056 = (Out_MaskB456_g252056).zw;
					half2 XZ496_g252056 = temp_output_463_0_g252056;
					half Bias496_g252056 = temp_output_504_0_g252056;
					half3 NormalWS512_g252056 = (Out_MaskK456_g252056).xyz;
					half3 NormalWS496_g252056 = NormalWS512_g252056;
					half3 Normal496_g252056 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252056 = SamplePlanar2D( Texture496_g252056 , Sampler496_g252056 , XZ496_g252056 , Bias496_g252056 , NormalWS496_g252056 , Normal496_g252056 );
					float4 temp_output_407_0_g252033 = localSamplePlanar2D496_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252056) = _MainAlbedoTex;
					SamplerState Sampler490_g252056 = staticSwitch36_g252038;
					float2 temp_output_462_0_g252056 = (Out_MaskB456_g252056).xy;
					half2 ZY490_g252056 = temp_output_462_0_g252056;
					half2 XZ490_g252056 = temp_output_463_0_g252056;
					float2 temp_output_464_0_g252056 = (Out_MaskC456_g252056).xy;
					half2 XY490_g252056 = temp_output_464_0_g252056;
					half Bias490_g252056 = temp_output_504_0_g252056;
					half3 Triplanar522_g252056 = (Out_MaskN456_g252056).xyz;
					half3 Triplanar490_g252056 = Triplanar522_g252056;
					half3 NormalWS490_g252056 = NormalWS512_g252056;
					half3 Normal490_g252056 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252056 = SamplePlanar3D( Texture490_g252056 , Sampler490_g252056 , ZY490_g252056 , XZ490_g252056 , XY490_g252056 , Bias490_g252056 , Triplanar490_g252056 , NormalWS490_g252056 , Normal490_g252056 );
					float4 temp_output_407_201_g252033 = localSamplePlanar3D490_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252056) = _MainAlbedoTex;
					SamplerState Sampler498_g252056 = staticSwitch36_g252038;
					half2 XZ498_g252056 = temp_output_463_0_g252056;
					float2 temp_output_473_0_g252056 = (Out_MaskE456_g252056).xy;
					half2 XZ_1498_g252056 = temp_output_473_0_g252056;
					float2 temp_output_474_0_g252056 = (Out_MaskE456_g252056).zw;
					half2 XZ_2498_g252056 = temp_output_474_0_g252056;
					float2 temp_output_475_0_g252056 = (Out_MaskF456_g252056).xy;
					half2 XZ_3498_g252056 = temp_output_475_0_g252056;
					float temp_output_510_0_g252056 = exp2( temp_output_504_0_g252056 );
					half Bias498_g252056 = temp_output_510_0_g252056;
					float3 temp_output_480_0_g252056 = (Out_MaskI456_g252056).xyz;
					half3 Weights_2498_g252056 = temp_output_480_0_g252056;
					half3 NormalWS498_g252056 = NormalWS512_g252056;
					half3 Normal498_g252056 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252056 = SampleStochastic2D( Texture498_g252056 , Sampler498_g252056 , XZ498_g252056 , XZ_1498_g252056 , XZ_2498_g252056 , XZ_3498_g252056 , Bias498_g252056 , Weights_2498_g252056 , NormalWS498_g252056 , Normal498_g252056 );
					float4 temp_output_407_202_g252033 = localSampleStochastic2D498_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252056) = _MainAlbedoTex;
					SamplerState Sampler500_g252056 = staticSwitch36_g252038;
					half2 ZY500_g252056 = temp_output_462_0_g252056;
					half2 ZY_1500_g252056 = (Out_MaskC456_g252056).zw;
					half2 ZY_2500_g252056 = (Out_MaskD456_g252056).xy;
					half2 ZY_3500_g252056 = (Out_MaskD456_g252056).zw;
					half2 XZ500_g252056 = temp_output_463_0_g252056;
					half2 XZ_1500_g252056 = temp_output_473_0_g252056;
					half2 XZ_2500_g252056 = temp_output_474_0_g252056;
					half2 XZ_3500_g252056 = temp_output_475_0_g252056;
					half2 XY500_g252056 = temp_output_464_0_g252056;
					half2 XY_1500_g252056 = (Out_MaskF456_g252056).zw;
					half2 XY_2500_g252056 = (Out_MaskG456_g252056).xy;
					half2 XY_3500_g252056 = (Out_MaskG456_g252056).zw;
					half Bias500_g252056 = temp_output_510_0_g252056;
					half3 Weights_1500_g252056 = (Out_MaskH456_g252056).xyz;
					half3 Weights_2500_g252056 = temp_output_480_0_g252056;
					half3 Weights_3500_g252056 = (Out_MaskJ456_g252056).xyz;
					half3 Triplanar500_g252056 = Triplanar522_g252056;
					half3 NormalWS500_g252056 = NormalWS512_g252056;
					half3 Normal500_g252056 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252056 = SampleStochastic3D( Texture500_g252056 , Sampler500_g252056 , ZY500_g252056 , ZY_1500_g252056 , ZY_2500_g252056 , ZY_3500_g252056 , XZ500_g252056 , XZ_1500_g252056 , XZ_2500_g252056 , XZ_3500_g252056 , XY500_g252056 , XY_1500_g252056 , XY_2500_g252056 , XY_3500_g252056 , Bias500_g252056 , Weights_1500_g252056 , Weights_2500_g252056 , Weights_3500_g252056 , Triplanar500_g252056 , NormalWS500_g252056 , Normal500_g252056 );
					float4 temp_output_407_203_g252033 = localSampleStochastic3D500_g252056;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g252033 = temp_output_407_277_g252033;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g252033 = temp_output_407_278_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g252033 = temp_output_407_0_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g252033 = temp_output_407_201_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g252033 = temp_output_407_202_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g252033 = temp_output_407_203_g252033;
					#else
					float4 staticSwitch184_g252033 = temp_output_407_277_g252033;
					#endif
					half4 Local_AlbedoSample185_g252033 = staticSwitch184_g252033;
					float3 lerpResult53_g252033 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g252033).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g252033 = lerpResult53_g252033;
					float temp_output_17_0_g252053 = _MainMultiWriteMode;
					float Option91_g252053 = temp_output_17_0_g252053;
					float4 Model_VertexData418_g252033 = Out_VertexData15_g252034;
					float4 temp_output_84_0_g252053 = Model_VertexData418_g252033;
					float4 ChannelA91_g252053 = temp_output_84_0_g252053;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252041) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g252040 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252041 = staticSwitch38_g252040;
					float localBreakTextureData456_g252041 = ( 0.0 );
					TVEMasksData Data456_g252041 =(TVEMasksData)Data431_g252055;
					float4 Out_MaskA456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252041 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252041 , Out_MaskA456_g252041 , Out_MaskB456_g252041 , Out_MaskC456_g252041 , Out_MaskD456_g252041 , Out_MaskE456_g252041 , Out_MaskF456_g252041 , Out_MaskG456_g252041 , Out_MaskH456_g252041 , Out_MaskI456_g252041 , Out_MaskJ456_g252041 , Out_MaskK456_g252041 , Out_MaskL456_g252041 , Out_MaskM456_g252041 , Out_MaskN456_g252041 );
					half2 UV276_g252041 = (Out_MaskA456_g252041).xy;
					float temp_output_504_0_g252041 = 0.0;
					half Bias276_g252041 = temp_output_504_0_g252041;
					half2 Normal276_g252041 = float2( 0,0 );
					half4 localSampleCoord276_g252041 = SampleCoord( Texture276_g252041 , Sampler276_g252041 , UV276_g252041 , Bias276_g252041 , Normal276_g252041 );
					float4 temp_output_405_277_g252033 = localSampleCoord276_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252041) = _MainShaderTex;
					SamplerState Sampler502_g252041 = staticSwitch38_g252040;
					half2 UV502_g252041 = (Out_MaskA456_g252041).zw;
					half Bias502_g252041 = temp_output_504_0_g252041;
					half2 Normal502_g252041 = float2( 0,0 );
					half4 localSampleCoord502_g252041 = SampleCoord( Texture502_g252041 , Sampler502_g252041 , UV502_g252041 , Bias502_g252041 , Normal502_g252041 );
					float4 temp_output_405_278_g252033 = localSampleCoord502_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252041) = _MainShaderTex;
					SamplerState Sampler496_g252041 = staticSwitch38_g252040;
					float2 temp_output_463_0_g252041 = (Out_MaskB456_g252041).zw;
					half2 XZ496_g252041 = temp_output_463_0_g252041;
					half Bias496_g252041 = temp_output_504_0_g252041;
					half3 NormalWS512_g252041 = (Out_MaskK456_g252041).xyz;
					half3 NormalWS496_g252041 = NormalWS512_g252041;
					half3 Normal496_g252041 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252041 = SamplePlanar2D( Texture496_g252041 , Sampler496_g252041 , XZ496_g252041 , Bias496_g252041 , NormalWS496_g252041 , Normal496_g252041 );
					float4 temp_output_405_0_g252033 = localSamplePlanar2D496_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252041) = _MainShaderTex;
					SamplerState Sampler490_g252041 = staticSwitch38_g252040;
					float2 temp_output_462_0_g252041 = (Out_MaskB456_g252041).xy;
					half2 ZY490_g252041 = temp_output_462_0_g252041;
					half2 XZ490_g252041 = temp_output_463_0_g252041;
					float2 temp_output_464_0_g252041 = (Out_MaskC456_g252041).xy;
					half2 XY490_g252041 = temp_output_464_0_g252041;
					half Bias490_g252041 = temp_output_504_0_g252041;
					half3 Triplanar522_g252041 = (Out_MaskN456_g252041).xyz;
					half3 Triplanar490_g252041 = Triplanar522_g252041;
					half3 NormalWS490_g252041 = NormalWS512_g252041;
					half3 Normal490_g252041 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252041 = SamplePlanar3D( Texture490_g252041 , Sampler490_g252041 , ZY490_g252041 , XZ490_g252041 , XY490_g252041 , Bias490_g252041 , Triplanar490_g252041 , NormalWS490_g252041 , Normal490_g252041 );
					float4 temp_output_405_201_g252033 = localSamplePlanar3D490_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252041) = _MainShaderTex;
					SamplerState Sampler498_g252041 = staticSwitch38_g252040;
					half2 XZ498_g252041 = temp_output_463_0_g252041;
					float2 temp_output_473_0_g252041 = (Out_MaskE456_g252041).xy;
					half2 XZ_1498_g252041 = temp_output_473_0_g252041;
					float2 temp_output_474_0_g252041 = (Out_MaskE456_g252041).zw;
					half2 XZ_2498_g252041 = temp_output_474_0_g252041;
					float2 temp_output_475_0_g252041 = (Out_MaskF456_g252041).xy;
					half2 XZ_3498_g252041 = temp_output_475_0_g252041;
					float temp_output_510_0_g252041 = exp2( temp_output_504_0_g252041 );
					half Bias498_g252041 = temp_output_510_0_g252041;
					float3 temp_output_480_0_g252041 = (Out_MaskI456_g252041).xyz;
					half3 Weights_2498_g252041 = temp_output_480_0_g252041;
					half3 NormalWS498_g252041 = NormalWS512_g252041;
					half3 Normal498_g252041 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252041 = SampleStochastic2D( Texture498_g252041 , Sampler498_g252041 , XZ498_g252041 , XZ_1498_g252041 , XZ_2498_g252041 , XZ_3498_g252041 , Bias498_g252041 , Weights_2498_g252041 , NormalWS498_g252041 , Normal498_g252041 );
					float4 temp_output_405_202_g252033 = localSampleStochastic2D498_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252041) = _MainShaderTex;
					SamplerState Sampler500_g252041 = staticSwitch38_g252040;
					half2 ZY500_g252041 = temp_output_462_0_g252041;
					half2 ZY_1500_g252041 = (Out_MaskC456_g252041).zw;
					half2 ZY_2500_g252041 = (Out_MaskD456_g252041).xy;
					half2 ZY_3500_g252041 = (Out_MaskD456_g252041).zw;
					half2 XZ500_g252041 = temp_output_463_0_g252041;
					half2 XZ_1500_g252041 = temp_output_473_0_g252041;
					half2 XZ_2500_g252041 = temp_output_474_0_g252041;
					half2 XZ_3500_g252041 = temp_output_475_0_g252041;
					half2 XY500_g252041 = temp_output_464_0_g252041;
					half2 XY_1500_g252041 = (Out_MaskF456_g252041).zw;
					half2 XY_2500_g252041 = (Out_MaskG456_g252041).xy;
					half2 XY_3500_g252041 = (Out_MaskG456_g252041).zw;
					half Bias500_g252041 = temp_output_510_0_g252041;
					half3 Weights_1500_g252041 = (Out_MaskH456_g252041).xyz;
					half3 Weights_2500_g252041 = temp_output_480_0_g252041;
					half3 Weights_3500_g252041 = (Out_MaskJ456_g252041).xyz;
					half3 Triplanar500_g252041 = Triplanar522_g252041;
					half3 NormalWS500_g252041 = NormalWS512_g252041;
					half3 Normal500_g252041 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252041 = SampleStochastic3D( Texture500_g252041 , Sampler500_g252041 , ZY500_g252041 , ZY_1500_g252041 , ZY_2500_g252041 , ZY_3500_g252041 , XZ500_g252041 , XZ_1500_g252041 , XZ_2500_g252041 , XZ_3500_g252041 , XY500_g252041 , XY_1500_g252041 , XY_2500_g252041 , XY_3500_g252041 , Bias500_g252041 , Weights_1500_g252041 , Weights_2500_g252041 , Weights_3500_g252041 , Triplanar500_g252041 , NormalWS500_g252041 , Normal500_g252041 );
					float4 temp_output_405_203_g252033 = localSampleStochastic3D500_g252041;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g252033 = temp_output_405_277_g252033;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g252033 = temp_output_405_278_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g252033 = temp_output_405_0_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g252033 = temp_output_405_201_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g252033 = temp_output_405_202_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g252033 = temp_output_405_203_g252033;
					#else
					float4 staticSwitch198_g252033 = temp_output_405_277_g252033;
					#endif
					half4 Local_ShaderSample199_g252033 = staticSwitch198_g252033;
					float2 appendResult428_g252033 = (float2((Local_AlbedoSample185_g252033).w , (Local_ShaderSample199_g252033).z));
					float2 temp_output_85_0_g252053 = appendResult428_g252033;
					float4 ChannelB91_g252053 = float4( temp_output_85_0_g252053, 0.0 , 0.0 );
					float localSwitchChannel691_g252053 = SwitchChannel6( Option91_g252053 , ChannelA91_g252053 , ChannelB91_g252053 );
					float clampResult17_g252051 = clamp( localSwitchChannel691_g252053 , 0.0001 , 0.9999 );
					float temp_output_7_0_g252052 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g252052 = ( clampResult17_g252051 - temp_output_7_0_g252052 );
					half Local_MultiMask78_g252033 = saturate( ( temp_output_9_0_g252052 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g252033 = lerp( 1.0 , Local_MultiMask78_g252033 , _MainColorMode);
					float4 lerpResult62_g252033 = lerp( _MainColorTwo , _MainColor , lerpResult58_g252033);
					half3 Local_ColorRGB93_g252033 = (lerpResult62_g252033).rgb;
					half3 Local_Albedo139_g252033 = ( Local_AlbedoRGB107_g252033 * Local_ColorRGB93_g252033 );
					float3 temp_output_4_0_g252035 = Local_Albedo139_g252033;
					float3 In_Albedo3_g252035 = temp_output_4_0_g252035;
					float3 temp_output_44_0_g252035 = Local_Albedo139_g252033;
					float3 In_AlbedoBase3_g252035 = temp_output_44_0_g252035;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252062) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g252039 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252062 = staticSwitch37_g252039;
					float localBreakTextureData456_g252062 = ( 0.0 );
					TVEMasksData Data456_g252062 =(TVEMasksData)Data431_g252055;
					float4 Out_MaskA456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252062 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252062 , Out_MaskA456_g252062 , Out_MaskB456_g252062 , Out_MaskC456_g252062 , Out_MaskD456_g252062 , Out_MaskE456_g252062 , Out_MaskF456_g252062 , Out_MaskG456_g252062 , Out_MaskH456_g252062 , Out_MaskI456_g252062 , Out_MaskJ456_g252062 , Out_MaskK456_g252062 , Out_MaskL456_g252062 , Out_MaskM456_g252062 , Out_MaskN456_g252062 );
					half2 UV276_g252062 = (Out_MaskA456_g252062).xy;
					float temp_output_504_0_g252062 = 0.0;
					half Bias276_g252062 = temp_output_504_0_g252062;
					half2 Normal276_g252062 = float2( 0,0 );
					half4 localSampleCoord276_g252062 = SampleCoord( Texture276_g252062 , Sampler276_g252062 , UV276_g252062 , Bias276_g252062 , Normal276_g252062 );
					float2 temp_output_406_394_g252033 = Normal276_g252062;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252062) = _MainNormalTex;
					SamplerState Sampler502_g252062 = staticSwitch37_g252039;
					half2 UV502_g252062 = (Out_MaskA456_g252062).zw;
					half Bias502_g252062 = temp_output_504_0_g252062;
					half2 Normal502_g252062 = float2( 0,0 );
					half4 localSampleCoord502_g252062 = SampleCoord( Texture502_g252062 , Sampler502_g252062 , UV502_g252062 , Bias502_g252062 , Normal502_g252062 );
					float2 temp_output_406_397_g252033 = Normal502_g252062;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252062) = _MainNormalTex;
					SamplerState Sampler496_g252062 = staticSwitch37_g252039;
					float2 temp_output_463_0_g252062 = (Out_MaskB456_g252062).zw;
					half2 XZ496_g252062 = temp_output_463_0_g252062;
					half Bias496_g252062 = temp_output_504_0_g252062;
					half3 NormalWS512_g252062 = (Out_MaskK456_g252062).xyz;
					half3 NormalWS496_g252062 = NormalWS512_g252062;
					half3 Normal496_g252062 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252062 = SamplePlanar2D( Texture496_g252062 , Sampler496_g252062 , XZ496_g252062 , Bias496_g252062 , NormalWS496_g252062 , Normal496_g252062 );
					float3 temp_output_35_0_g252065 = Normal496_g252062;
					half3 TangentWS519_g252062 = (Out_MaskL456_g252062).xyz;
					float dotResult84_g252065 = dot( temp_output_35_0_g252065 , TangentWS519_g252062 );
					half3 BitangentWS521_g252062 = (Out_MaskM456_g252062).xyz;
					float dotResult85_g252065 = dot( temp_output_35_0_g252065 , BitangentWS521_g252062 );
					float2 appendResult87_g252065 = (float2(dotResult84_g252065 , dotResult85_g252065));
					float2 temp_output_406_375_g252033 = appendResult87_g252065;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252062) = _MainNormalTex;
					SamplerState Sampler490_g252062 = staticSwitch37_g252039;
					float2 temp_output_462_0_g252062 = (Out_MaskB456_g252062).xy;
					half2 ZY490_g252062 = temp_output_462_0_g252062;
					half2 XZ490_g252062 = temp_output_463_0_g252062;
					float2 temp_output_464_0_g252062 = (Out_MaskC456_g252062).xy;
					half2 XY490_g252062 = temp_output_464_0_g252062;
					half Bias490_g252062 = temp_output_504_0_g252062;
					half3 Triplanar522_g252062 = (Out_MaskN456_g252062).xyz;
					half3 Triplanar490_g252062 = Triplanar522_g252062;
					half3 NormalWS490_g252062 = NormalWS512_g252062;
					half3 Normal490_g252062 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252062 = SamplePlanar3D( Texture490_g252062 , Sampler490_g252062 , ZY490_g252062 , XZ490_g252062 , XY490_g252062 , Bias490_g252062 , Triplanar490_g252062 , NormalWS490_g252062 , Normal490_g252062 );
					float3 temp_output_35_0_g252066 = Normal490_g252062;
					float dotResult84_g252066 = dot( temp_output_35_0_g252066 , TangentWS519_g252062 );
					float dotResult85_g252066 = dot( temp_output_35_0_g252066 , BitangentWS521_g252062 );
					float2 appendResult87_g252066 = (float2(dotResult84_g252066 , dotResult85_g252066));
					float2 temp_output_406_353_g252033 = appendResult87_g252066;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252062) = _MainNormalTex;
					SamplerState Sampler498_g252062 = staticSwitch37_g252039;
					half2 XZ498_g252062 = temp_output_463_0_g252062;
					float2 temp_output_473_0_g252062 = (Out_MaskE456_g252062).xy;
					half2 XZ_1498_g252062 = temp_output_473_0_g252062;
					float2 temp_output_474_0_g252062 = (Out_MaskE456_g252062).zw;
					half2 XZ_2498_g252062 = temp_output_474_0_g252062;
					float2 temp_output_475_0_g252062 = (Out_MaskF456_g252062).xy;
					half2 XZ_3498_g252062 = temp_output_475_0_g252062;
					float temp_output_510_0_g252062 = exp2( temp_output_504_0_g252062 );
					half Bias498_g252062 = temp_output_510_0_g252062;
					float3 temp_output_480_0_g252062 = (Out_MaskI456_g252062).xyz;
					half3 Weights_2498_g252062 = temp_output_480_0_g252062;
					half3 NormalWS498_g252062 = NormalWS512_g252062;
					half3 Normal498_g252062 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252062 = SampleStochastic2D( Texture498_g252062 , Sampler498_g252062 , XZ498_g252062 , XZ_1498_g252062 , XZ_2498_g252062 , XZ_3498_g252062 , Bias498_g252062 , Weights_2498_g252062 , NormalWS498_g252062 , Normal498_g252062 );
					float3 temp_output_35_0_g252067 = Normal498_g252062;
					float dotResult84_g252067 = dot( temp_output_35_0_g252067 , TangentWS519_g252062 );
					float dotResult85_g252067 = dot( temp_output_35_0_g252067 , BitangentWS521_g252062 );
					float2 appendResult87_g252067 = (float2(dotResult84_g252067 , dotResult85_g252067));
					float2 temp_output_406_391_g252033 = appendResult87_g252067;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252062) = _MainNormalTex;
					SamplerState Sampler500_g252062 = staticSwitch37_g252039;
					half2 ZY500_g252062 = temp_output_462_0_g252062;
					half2 ZY_1500_g252062 = (Out_MaskC456_g252062).zw;
					half2 ZY_2500_g252062 = (Out_MaskD456_g252062).xy;
					half2 ZY_3500_g252062 = (Out_MaskD456_g252062).zw;
					half2 XZ500_g252062 = temp_output_463_0_g252062;
					half2 XZ_1500_g252062 = temp_output_473_0_g252062;
					half2 XZ_2500_g252062 = temp_output_474_0_g252062;
					half2 XZ_3500_g252062 = temp_output_475_0_g252062;
					half2 XY500_g252062 = temp_output_464_0_g252062;
					half2 XY_1500_g252062 = (Out_MaskF456_g252062).zw;
					half2 XY_2500_g252062 = (Out_MaskG456_g252062).xy;
					half2 XY_3500_g252062 = (Out_MaskG456_g252062).zw;
					half Bias500_g252062 = temp_output_510_0_g252062;
					half3 Weights_1500_g252062 = (Out_MaskH456_g252062).xyz;
					half3 Weights_2500_g252062 = temp_output_480_0_g252062;
					half3 Weights_3500_g252062 = (Out_MaskJ456_g252062).xyz;
					half3 Triplanar500_g252062 = Triplanar522_g252062;
					half3 NormalWS500_g252062 = NormalWS512_g252062;
					half3 Normal500_g252062 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252062 = SampleStochastic3D( Texture500_g252062 , Sampler500_g252062 , ZY500_g252062 , ZY_1500_g252062 , ZY_2500_g252062 , ZY_3500_g252062 , XZ500_g252062 , XZ_1500_g252062 , XZ_2500_g252062 , XZ_3500_g252062 , XY500_g252062 , XY_1500_g252062 , XY_2500_g252062 , XY_3500_g252062 , Bias500_g252062 , Weights_1500_g252062 , Weights_2500_g252062 , Weights_3500_g252062 , Triplanar500_g252062 , NormalWS500_g252062 , Normal500_g252062 );
					float3 temp_output_35_0_g252063 = Normal500_g252062;
					float dotResult84_g252063 = dot( temp_output_35_0_g252063 , TangentWS519_g252062 );
					float dotResult85_g252063 = dot( temp_output_35_0_g252063 , BitangentWS521_g252062 );
					float2 appendResult87_g252063 = (float2(dotResult84_g252063 , dotResult85_g252063));
					float2 temp_output_406_390_g252033 = appendResult87_g252063;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g252033 = temp_output_406_394_g252033;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g252033 = temp_output_406_397_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g252033 = temp_output_406_375_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g252033 = temp_output_406_353_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g252033 = temp_output_406_391_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g252033 = temp_output_406_390_g252033;
					#else
					float2 staticSwitch193_g252033 = temp_output_406_394_g252033;
					#endif
					half2 Local_NormaSample191_g252033 = staticSwitch193_g252033;
					half2 Local_NormalTS108_g252033 = ( Local_NormaSample191_g252033 * _MainNormalValue );
					float2 In_NormalTS3_g252035 = Local_NormalTS108_g252033;
					float2 break80_g252054 = Local_NormalTS108_g252033;
					float3 temp_output_77_0_g252054 = Model_TangentWS366_g252033;
					float3 temp_output_78_0_g252054 = Model_BitangentWS367_g252033;
					float3 temp_output_76_0_g252054 = Model_NormalWS226_g252033;
					half3 Local_NormalWS250_g252033 = ( ( break80_g252054.x * temp_output_77_0_g252054 ) + ( break80_g252054.y * temp_output_78_0_g252054 ) + temp_output_76_0_g252054 );
					float3 In_NormalWS3_g252035 = Local_NormalWS250_g252033;
					float temp_output_209_0_g252033 = (Local_ShaderSample199_g252033).y;
					float temp_output_7_0_g252047 = _MainOcclusionRemap.x;
					float temp_output_9_0_g252047 = ( temp_output_209_0_g252033 - temp_output_7_0_g252047 );
					float lerpResult23_g252033 = lerp( 1.0 , saturate( ( temp_output_9_0_g252047 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g252033 = lerpResult23_g252033;
					float temp_output_213_0_g252033 = (Local_ShaderSample199_g252033).w;
					float temp_output_7_0_g252050 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g252050 = ( temp_output_213_0_g252033 - temp_output_7_0_g252050 );
					half Local_Smoothness317_g252033 = ( saturate( ( temp_output_9_0_g252050 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g252033 = (float4(( (Local_ShaderSample199_g252033).x * _MainMetallicValue ) , Local_Occlusion313_g252033 , (Local_ShaderSample199_g252033).z , Local_Smoothness317_g252033));
					half4 Local_Masks109_g252033 = appendResult73_g252033;
					float4 In_Shader3_g252035 = Local_Masks109_g252033;
					float4 In_Feature3_g252035 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252035 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252035 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g252068 = Local_Albedo139_g252033;
					float dotResult20_g252068 = dot( temp_output_3_0_g252068 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g252033 = dotResult20_g252068;
					float temp_output_12_0_g252035 = Local_Grayscale110_g252033;
					float In_Grayscale3_g252035 = temp_output_12_0_g252035;
					float temp_output_3_0_g252069 = Local_Grayscale110_g252033;
					float clampResult27_g252069 = clamp( saturate( ( temp_output_3_0_g252069 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g252033 = clampResult27_g252069;
					float temp_output_16_0_g252035 = Local_Luminosity145_g252033;
					float In_Luminosity3_g252035 = temp_output_16_0_g252035;
					float In_MultiMask3_g252035 = Local_MultiMask78_g252033;
					float temp_output_187_0_g252033 = (Local_AlbedoSample185_g252033).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g252033 = ( temp_output_187_0_g252033 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g252033 = temp_output_187_0_g252033;
					#endif
					half Local_AlphaClip111_g252033 = staticSwitch236_g252033;
					float In_AlphaClip3_g252035 = Local_AlphaClip111_g252033;
					half Local_AlphaFade246_g252033 = (lerpResult62_g252033).a;
					float In_AlphaFade3_g252035 = Local_AlphaFade246_g252033;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g252035 = temp_cast_24;
					float In_Transmission3_g252035 = 1.0;
					float In_Thickness3_g252035 = 0.0;
					float In_Diffusion3_g252035 = 0.0;
					float In_Depth3_g252035 = 0.0;
					BuildVisualData( Data3_g252035 , In_Dummy3_g252035 , In_Albedo3_g252035 , In_AlbedoBase3_g252035 , In_NormalTS3_g252035 , In_NormalWS3_g252035 , In_Shader3_g252035 , In_Feature3_g252035 , In_Season3_g252035 , In_Emissive3_g252035 , In_Grayscale3_g252035 , In_Luminosity3_g252035 , In_MultiMask3_g252035 , In_AlphaClip3_g252035 , In_AlphaFade3_g252035 , In_Translucency3_g252035 , In_Transmission3_g252035 , In_Thickness3_g252035 , In_Diffusion3_g252035 , In_Depth3_g252035 );
					TVEVisualData Data4_g252146 =(TVEVisualData)Data3_g252035;
					float Out_Dummy4_g252146 = 0.0;
					float3 Out_Albedo4_g252146 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252146 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252146 = float2( 0,0 );
					float3 Out_NormalWS4_g252146 = float3( 0,0,0 );
					float4 Out_Shader4_g252146 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252146 = float4( 0,0,0,0 );
					float4 Out_Season4_g252146 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252146 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252146 = 0.0;
					float Out_Grayscale4_g252146 = 0.0;
					float Out_Luminosity4_g252146 = 0.0;
					float Out_AlphaClip4_g252146 = 0.0;
					float Out_AlphaFade4_g252146 = 0.0;
					float3 Out_Translucency4_g252146 = float3( 0,0,0 );
					float Out_Transmission4_g252146 = 0.0;
					float Out_Thickness4_g252146 = 0.0;
					float Out_Diffusion4_g252146 = 0.0;
					float Out_Depth4_g252146 = 0.0;
					BreakVisualData( Data4_g252146 , Out_Dummy4_g252146 , Out_Albedo4_g252146 , Out_AlbedoBase4_g252146 , Out_NormalTS4_g252146 , Out_NormalWS4_g252146 , Out_Shader4_g252146 , Out_Feature4_g252146 , Out_Season4_g252146 , Out_Emissive4_g252146 , Out_MultiMask4_g252146 , Out_Grayscale4_g252146 , Out_Luminosity4_g252146 , Out_AlphaClip4_g252146 , Out_AlphaFade4_g252146 , Out_Translucency4_g252146 , Out_Transmission4_g252146 , Out_Thickness4_g252146 , Out_Diffusion4_g252146 , Out_Depth4_g252146 );
					float temp_output_739_15_g252072 = Out_Luminosity4_g252146;
					half Visual_Luminosity654_g252072 = temp_output_739_15_g252072;
					float temp_output_7_0_g252077 = _OverlayLumaRemap.x;
					float temp_output_9_0_g252077 = ( Visual_Luminosity654_g252072 - temp_output_7_0_g252077 );
					float lerpResult587_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g252077 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g252072 = lerpResult587_g252072;
					half4 Visual_Shader536_g252072 = Out_Shader4_g252146;
					float temp_output_7_0_g254255 = _OverlayBaseRemap.x;
					float temp_output_9_0_g254255 = ( (Visual_Shader536_g252072).z - temp_output_7_0_g254255 );
					float lerpResult1193_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g254255 * _OverlayBaseRemap.z ) ) , _OverlayBaseValue);
					half Blend_BaseMask1196_g252072 = lerpResult1193_g252072;
					float3 temp_output_739_21_g252072 = Out_NormalWS4_g252146;
					half3 Visual_NormalWS749_g252072 = temp_output_739_21_g252072;
					float temp_output_505_0_g252072 = saturate( (Visual_NormalWS749_g252072).y );
					float temp_output_7_0_g252142 = _OverlayProjRemap.x;
					float temp_output_9_0_g252142 = ( temp_output_505_0_g252072 - temp_output_7_0_g252142 );
					float lerpResult842_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g252142 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g252072 = lerpResult842_g252072;
					half Blend_NoiseMask427_g252072 = 1.0;
					half Blend_UserMask646_g252072 = 1.0;
					float temp_output_17_0_g252144 = _OverlayMeshMode;
					float Option70_g252144 = temp_output_17_0_g252144;
					TVEModelData Data15_g252121 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g252121 = 0.0;
					float3 Out_PositionWS15_g252121 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252121 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252121 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252121 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252121 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252121 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252121 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252121 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252121 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252121 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252121 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252121 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252121 , Out_Dummy15_g252121 , Out_PositionWS15_g252121 , Out_PositionWO15_g252121 , Out_PivotWS15_g252121 , Out_PivotWO15_g252121 , Out_NormalWS15_g252121 , Out_TangentWS15_g252121 , Out_BitangentWS15_g252121 , Out_TriplanarWeights15_g252121 , Out_ViewDirWS15_g252121 , Out_CoordsData15_g252121 , Out_VertexData15_g252121 , Out_Interpolator15_g252121 );
					half4 Model_VertexData791_g252072 = Out_VertexData15_g252121;
					float4 temp_output_3_0_g252144 = Model_VertexData791_g252072;
					float4 Channel70_g252144 = temp_output_3_0_g252144;
					float localSwitchChannel470_g252144 = SwitchChannel4( Option70_g252144 , Channel70_g252144 );
					float temp_output_1142_0_g252072 = localSwitchChannel470_g252144;
					float temp_output_7_0_g252140 = _OverlayMeshRemap.x;
					float temp_output_9_0_g252140 = ( temp_output_1142_0_g252072 - temp_output_7_0_g252140 );
					float lerpResult881_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g252140 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g252072 = lerpResult881_g252072;
					half Blend_FormMask_Mul958_g252072 = 1.0;
					half Blend_FormMask_Add957_g252072 = 0.0;
					float temp_output_64_0_g254252 = saturate( ( ( Blend_TexMask908_g252072 * Blend_LumaMask438_g252072 * Blend_BaseMask1196_g252072 * Blend_ProjMask457_g252072 * Blend_NoiseMask427_g252072 * Blend_UserMask646_g252072 * Blend_VertMask801_g252072 * Blend_FormMask_Mul958_g252072 ) + Blend_FormMask_Add957_g252072 ) );
					half Blend_GlobalMask429_g252072 = 1.0;
					float temp_output_92_0_g254252 = ( Feature_Intensity1107_g252072 * Blend_GlobalMask429_g252072 );
					half Multiply93_g254252 = ( temp_output_64_0_g254252 * temp_output_92_0_g254252 );
					half Subtract93_g254252 = saturate( ( temp_output_92_0_g254252 - ( 1.0 - temp_output_64_0_g254252 ) ) );
					half Option93_g254252 = _OverlayBlendMath;
					half localSwitchBlendMask93_g254252 = SwitchBlendMask( Multiply93_g254252 , Subtract93_g254252 , Option93_g254252 );
					float temp_output_7_0_g254251 = _OverlayBlendRemap.x;
					float temp_output_9_0_g254251 = ( localSwitchBlendMask93_g254252 - temp_output_7_0_g254251 );
					half Blend_Mask494_g252072 = saturate( ( temp_output_9_0_g254251 * _OverlayBlendRemap.z ) );
					float4 appendResult993_g252072 = (float4(Blend_Mask494_g252072 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_25 = (0.0).xxxx;
					float4 temp_cast_26 = (0.0).xxxx;
					float4 ifLocalVar18_g252126 = 0;
					if( Feature_Intensity1107_g252072 <= 0.0 )
					ifLocalVar18_g252126 = temp_cast_26;
					else
					ifLocalVar18_g252126 = appendResult993_g252072;
					float4 In_MaskB3_g252127 = ifLocalVar18_g252126;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 In_MaskC3_g252127 = temp_cast_27;
					float4 temp_cast_28 = (0.0).xxxx;
					float4 In_MaskD3_g252127 = temp_cast_28;
					float4 temp_cast_29 = (0.0).xxxx;
					float4 In_MaskE3_g252127 = temp_cast_29;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 In_MaskF3_g252127 = temp_cast_30;
					float4 temp_cast_31 = (0.0).xxxx;
					float4 In_MaskG3_g252127 = temp_cast_31;
					float4 temp_cast_32 = (0.0).xxxx;
					float4 In_MaskH3_g252127 = temp_cast_32;
					float4 temp_cast_33 = (0.0).xxxx;
					float4 In_MaskI3_g252127 = temp_cast_33;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 In_MaskJ3_g252127 = temp_cast_34;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskK3_g252127 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskL3_g252127 = temp_cast_36;
					{
					Data3_g252127.MaskA = In_MaskA3_g252127;
					Data3_g252127.MaskB = In_MaskB3_g252127;
					Data3_g252127.MaskC = In_MaskC3_g252127;
					Data3_g252127.MaskD = In_MaskD3_g252127;
					Data3_g252127.MaskE = In_MaskE3_g252127;
					Data3_g252127.MaskF = In_MaskF3_g252127;
					Data3_g252127.MaskG = In_MaskG3_g252127;
					Data3_g252127.MaskH = In_MaskH3_g252127;
					Data3_g252127.MaskI = In_MaskI3_g252127;
					Data3_g252127.MaskJ= In_MaskJ3_g252127;
					Data3_g252127.MaskK= In_MaskK3_g252127;
					Data3_g252127.MaskL = In_MaskL3_g252127;
					}
					TVEMasksData DataA25_g254350 = Data3_g252127;
					float localBuildMasksData3_g254311 = ( 0.0 );
					TVEMasksData Data3_g254311 = (TVEMasksData)0;
					half Feature_Intensity1107_g254256 = _OverlayIntensityValue;
					float ifLocalVar18_g254307 = 0;
					if( Feature_Intensity1107_g254256 <= 0.0 )
					ifLocalVar18_g254307 = 0.0;
					else
					ifLocalVar18_g254307 = 1.0;
					half Feature_Maps1112_g254256 = _OverlayTextureMode;
					float ifLocalVar18_g254308 = 0;
					if( Feature_Maps1112_g254256 <= 0.0 )
					ifLocalVar18_g254308 = 0.0;
					else
					ifLocalVar18_g254308 = 1.0;
					half Feature_Glitter1108_g254256 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g254309 = 0;
					if( Feature_Glitter1108_g254256 <= 0.0 )
					ifLocalVar18_g254309 = 0.0;
					else
					ifLocalVar18_g254309 = 1.0;
					half Feature_Element1085_g254256 = _OverlayAtmoMode;
					float ifLocalVar18_g254306 = 0;
					if( Feature_Element1085_g254256 <= 0.0 )
					ifLocalVar18_g254306 = 0.0;
					else
					ifLocalVar18_g254306 = 1.0;
					float4 appendResult1117_g254256 = (float4(ifLocalVar18_g254307 , ifLocalVar18_g254308 , ifLocalVar18_g254309 , ifLocalVar18_g254306));
					float4 In_MaskA3_g254311 = appendResult1117_g254256;
					half Blend_TexMask908_g254256 = 1.0;
					float localBreakVisualData4_g254330 = ( 0.0 );
					TVEVisualData Data4_g254330 =(TVEVisualData)Data3_g252035;
					float Out_Dummy4_g254330 = 0.0;
					float3 Out_Albedo4_g254330 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254330 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254330 = float2( 0,0 );
					float3 Out_NormalWS4_g254330 = float3( 0,0,0 );
					float4 Out_Shader4_g254330 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254330 = float4( 0,0,0,0 );
					float4 Out_Season4_g254330 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254330 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254330 = 0.0;
					float Out_Grayscale4_g254330 = 0.0;
					float Out_Luminosity4_g254330 = 0.0;
					float Out_AlphaClip4_g254330 = 0.0;
					float Out_AlphaFade4_g254330 = 0.0;
					float3 Out_Translucency4_g254330 = float3( 0,0,0 );
					float Out_Transmission4_g254330 = 0.0;
					float Out_Thickness4_g254330 = 0.0;
					float Out_Diffusion4_g254330 = 0.0;
					float Out_Depth4_g254330 = 0.0;
					BreakVisualData( Data4_g254330 , Out_Dummy4_g254330 , Out_Albedo4_g254330 , Out_AlbedoBase4_g254330 , Out_NormalTS4_g254330 , Out_NormalWS4_g254330 , Out_Shader4_g254330 , Out_Feature4_g254330 , Out_Season4_g254330 , Out_Emissive4_g254330 , Out_MultiMask4_g254330 , Out_Grayscale4_g254330 , Out_Luminosity4_g254330 , Out_AlphaClip4_g254330 , Out_AlphaFade4_g254330 , Out_Translucency4_g254330 , Out_Transmission4_g254330 , Out_Thickness4_g254330 , Out_Diffusion4_g254330 , Out_Depth4_g254330 );
					float temp_output_739_15_g254256 = Out_Luminosity4_g254330;
					half Visual_Luminosity654_g254256 = temp_output_739_15_g254256;
					float temp_output_7_0_g254261 = _OverlayLumaRemap.x;
					float temp_output_9_0_g254261 = ( Visual_Luminosity654_g254256 - temp_output_7_0_g254261 );
					float lerpResult587_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254261 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g254256 = lerpResult587_g254256;
					half4 Visual_Shader536_g254256 = Out_Shader4_g254330;
					float temp_output_7_0_g254349 = _OverlayBaseRemap.x;
					float temp_output_9_0_g254349 = ( (Visual_Shader536_g254256).z - temp_output_7_0_g254349 );
					float lerpResult1193_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254349 * _OverlayBaseRemap.z ) ) , _OverlayBaseValue);
					half Blend_BaseMask1196_g254256 = lerpResult1193_g254256;
					float3 temp_output_739_21_g254256 = Out_NormalWS4_g254330;
					half3 Visual_NormalWS749_g254256 = temp_output_739_21_g254256;
					float temp_output_505_0_g254256 = saturate( (Visual_NormalWS749_g254256).y );
					float temp_output_7_0_g254326 = _OverlayProjRemap.x;
					float temp_output_9_0_g254326 = ( temp_output_505_0_g254256 - temp_output_7_0_g254326 );
					float lerpResult842_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254326 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g254256 = lerpResult842_g254256;
					half Blend_NoiseMask427_g254256 = 1.0;
					half Blend_UserMask646_g254256 = 1.0;
					float temp_output_17_0_g254328 = _OverlayMeshMode;
					float Option70_g254328 = temp_output_17_0_g254328;
					TVEModelData Data15_g254305 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g254305 = 0.0;
					float3 Out_PositionWS15_g254305 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254305 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254305 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254305 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254305 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254305 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254305 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254305 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254305 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254305 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254305 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254305 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254305 , Out_Dummy15_g254305 , Out_PositionWS15_g254305 , Out_PositionWO15_g254305 , Out_PivotWS15_g254305 , Out_PivotWO15_g254305 , Out_NormalWS15_g254305 , Out_TangentWS15_g254305 , Out_BitangentWS15_g254305 , Out_TriplanarWeights15_g254305 , Out_ViewDirWS15_g254305 , Out_CoordsData15_g254305 , Out_VertexData15_g254305 , Out_Interpolator15_g254305 );
					half4 Model_VertexData791_g254256 = Out_VertexData15_g254305;
					float4 temp_output_3_0_g254328 = Model_VertexData791_g254256;
					float4 Channel70_g254328 = temp_output_3_0_g254328;
					float localSwitchChannel470_g254328 = SwitchChannel4( Option70_g254328 , Channel70_g254328 );
					float temp_output_1142_0_g254256 = localSwitchChannel470_g254328;
					float temp_output_7_0_g254324 = _OverlayMeshRemap.x;
					float temp_output_9_0_g254324 = ( temp_output_1142_0_g254256 - temp_output_7_0_g254324 );
					float lerpResult881_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254324 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g254256 = lerpResult881_g254256;
					half Blend_FormMask_Mul958_g254256 = 1.0;
					half Blend_FormMask_Add957_g254256 = 0.0;
					float temp_output_64_0_g254346 = saturate( ( ( Blend_TexMask908_g254256 * Blend_LumaMask438_g254256 * Blend_BaseMask1196_g254256 * Blend_ProjMask457_g254256 * Blend_NoiseMask427_g254256 * Blend_UserMask646_g254256 * Blend_VertMask801_g254256 * Blend_FormMask_Mul958_g254256 ) + Blend_FormMask_Add957_g254256 ) );
					float temp_output_1146_0_g254256 = (TVE_AtmoParams).y;
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
					TVEGlobalData Data15_g254257 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g254257 = 0.0;
					float4 Out_CoatTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g254257 = float4( 0,0,0,0 );
					BreakData( Data15_g254257 , Out_Dummy15_g254257 , Out_CoatTexture15_g254257 , Out_DrawTexture15_g254257 , Out_PaintTexture15_g254257 , Out_AtmoTexture15_g254257 , Out_EffexTexture15_g254257 , Out_GlowTexture15_g254257 , Out_FormTexture15_g254257 , Out_LandTexture15_g254257 , Out_VertxTexture15_g254257 , Out_FlowTexture15_g254257 , Out_UserTexture15_g254257 );
					half4 Global_AtmoTexture516_g254256 = Out_AtmoTexture15_g254257;
					float temp_output_6_0_g254279 = (Global_AtmoTexture516_g254256).y;
					float temp_output_7_0_g254279 = _OverlayAtmoMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g254279 = ( temp_output_6_0_g254279 + temp_output_7_0_g254279 );
					#else
					float staticSwitch14_g254279 = temp_output_6_0_g254279;
					#endif
					float temp_output_939_0_g254256 = staticSwitch14_g254279;
					#ifdef TVE_OVERLAY_ATMO
					float staticSwitch705_g254256 = temp_output_939_0_g254256;
					#else
					float staticSwitch705_g254256 = temp_output_1146_0_g254256;
					#endif
					float lerpResult937_g254256 = lerp( 1.0 , ( staticSwitch705_g254256 * TVE_IsEnabled ) , _OverlayAtmoValue);
					half Blend_GlobalMask429_g254256 = lerpResult937_g254256;
					float temp_output_92_0_g254346 = ( Feature_Intensity1107_g254256 * Blend_GlobalMask429_g254256 );
					half Multiply93_g254346 = ( temp_output_64_0_g254346 * temp_output_92_0_g254346 );
					half Subtract93_g254346 = saturate( ( temp_output_92_0_g254346 - ( 1.0 - temp_output_64_0_g254346 ) ) );
					half Option93_g254346 = _OverlayBlendMath;
					half localSwitchBlendMask93_g254346 = SwitchBlendMask( Multiply93_g254346 , Subtract93_g254346 , Option93_g254346 );
					float temp_output_7_0_g254345 = _OverlayBlendRemap.x;
					float temp_output_9_0_g254345 = ( localSwitchBlendMask93_g254346 - temp_output_7_0_g254345 );
					half Blend_Mask494_g254256 = saturate( ( temp_output_9_0_g254345 * _OverlayBlendRemap.z ) );
					float4 appendResult993_g254256 = (float4(Blend_Mask494_g254256 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_45 = (0.0).xxxx;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 ifLocalVar18_g254310 = 0;
					if( Feature_Intensity1107_g254256 <= 0.0 )
					ifLocalVar18_g254310 = temp_cast_46;
					else
					ifLocalVar18_g254310 = appendResult993_g254256;
					float4 In_MaskB3_g254311 = ifLocalVar18_g254310;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskC3_g254311 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskD3_g254311 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskE3_g254311 = temp_cast_49;
					float4 temp_cast_50 = (0.0).xxxx;
					float4 In_MaskF3_g254311 = temp_cast_50;
					float4 temp_cast_51 = (0.0).xxxx;
					float4 In_MaskG3_g254311 = temp_cast_51;
					float4 temp_cast_52 = (0.0).xxxx;
					float4 In_MaskH3_g254311 = temp_cast_52;
					float4 temp_cast_53 = (0.0).xxxx;
					float4 In_MaskI3_g254311 = temp_cast_53;
					float4 temp_cast_54 = (0.0).xxxx;
					float4 In_MaskJ3_g254311 = temp_cast_54;
					float4 temp_cast_55 = (0.0).xxxx;
					float4 In_MaskK3_g254311 = temp_cast_55;
					float4 temp_cast_56 = (0.0).xxxx;
					float4 In_MaskL3_g254311 = temp_cast_56;
					{
					Data3_g254311.MaskA = In_MaskA3_g254311;
					Data3_g254311.MaskB = In_MaskB3_g254311;
					Data3_g254311.MaskC = In_MaskC3_g254311;
					Data3_g254311.MaskD = In_MaskD3_g254311;
					Data3_g254311.MaskE = In_MaskE3_g254311;
					Data3_g254311.MaskF = In_MaskF3_g254311;
					Data3_g254311.MaskG = In_MaskG3_g254311;
					Data3_g254311.MaskH = In_MaskH3_g254311;
					Data3_g254311.MaskI = In_MaskI3_g254311;
					Data3_g254311.MaskJ= In_MaskJ3_g254311;
					Data3_g254311.MaskK= In_MaskK3_g254311;
					Data3_g254311.MaskL = In_MaskL3_g254311;
					}
					TVEMasksData DataB25_g254350 = Data3_g254311;
					float Alpha25_g254350 = TVE_DEBUG_Global;
					{
					if (Alpha25_g254350 < 0.5 )
					{
					Data25_g254350 = DataA25_g254350;
					}
					else
					{
					Data25_g254350 = DataB25_g254350;
					}
					}
					TVEMasksData Data4_g254351 = Data25_g254350;
					float4 Out_MaskA4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g254351 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g254351 = Data4_g254351.MaskA;
					Out_MaskB4_g254351 = Data4_g254351.MaskB;
					Out_MaskC4_g254351 = Data4_g254351.MaskC;
					Out_MaskD4_g254351 = Data4_g254351.MaskD;
					Out_MaskE4_g254351 = Data4_g254351.MaskE;
					Out_MaskF4_g254351 = Data4_g254351.MaskF;
					Out_MaskG4_g254351 = Data4_g254351.MaskG;
					Out_MaskH4_g254351 = Data4_g254351.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g254351;
					float3 lerpResult2568 = lerp( color107_g254352 , color106_g254352 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g254360 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g254360 = lerpResult2568;
					float3 color107_g254354 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254354 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g254354 , color106_g254354 , (temp_output_2509_14).y);
					float3 ifLocalVar40_g254361 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g254361 = lerpResult2571;
					float3 color107_g254356 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254356 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2603 = lerp( color107_g254356 , color106_g254356 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g254362 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g254362 = lerpResult2603;
					float3 ifLocalVar40_g254364 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g254364 = (Out_MaskB4_g254351).xxx;
					float3 color107_g254358 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254358 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g254358 , color106_g254358 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g254363 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g254363 = lerpResult2607;
					half3 Final_Debug2399 = ( ifLocalVar40_g254360 + ifLocalVar40_g254361 + ifLocalVar40_g254362 + ifLocalVar40_g254364 + ifLocalVar40_g254363 );
					float temp_output_7_0_g254373 = TVE_DEBUG_Min;
					float3 temp_cast_57 = (temp_output_7_0_g254373).xxx;
					float3 temp_output_9_0_g254373 = ( Final_Debug2399 - temp_cast_57 );
					float lerpResult76_g254366 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g254366 = lerpResult76_g254366;
					float3 lerpResult72_g254366 = lerp( (lerpResult73_g254367).rgb , saturate( ( temp_output_9_0_g254373 / ( ( TVE_DEBUG_Max - temp_output_7_0_g254373 ) + 0.0001 ) ) ) , Filter152_g254366);
					float dotResult61_g254366 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g254366 = ( 1.0 - saturate( dotResult61_g254366 ) );
					float Shading_Fresnel59_g254366 = (( 1.0 - ( temp_output_65_0_g254366 * temp_output_65_0_g254366 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g254366 = IN.ase_texcoord10;
					float depthLinearEye57_g254366 = LinearEyeDepth( ase_positionCS57_g254366.z / ase_positionCS57_g254366.w );
					float temp_output_69_0_g254366 = saturate(  (0.0 + ( depthLinearEye57_g254366 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g254366 = (( temp_output_69_0_g254366 * temp_output_69_0_g254366 )*0.5 + 0.5);
					float lerpResult84_g254366 = lerp( 1.0 , Shading_Fresnel59_g254366 , ( Shading_Distance58_g254366 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g254371 = ( 0.0 );
					TVEVisualData Data4_g254371 =(TVEVisualData)Data3_g252035;
					float Out_Dummy4_g254371 = 0.0;
					float3 Out_Albedo4_g254371 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254371 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254371 = float2( 0,0 );
					float3 Out_NormalWS4_g254371 = float3( 0,0,0 );
					float4 Out_Shader4_g254371 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254371 = float4( 0,0,0,0 );
					float4 Out_Season4_g254371 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254371 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254371 = 0.0;
					float Out_Grayscale4_g254371 = 0.0;
					float Out_Luminosity4_g254371 = 0.0;
					float Out_AlphaClip4_g254371 = 0.0;
					float Out_AlphaFade4_g254371 = 0.0;
					float3 Out_Translucency4_g254371 = float3( 0,0,0 );
					float Out_Transmission4_g254371 = 0.0;
					float Out_Thickness4_g254371 = 0.0;
					float Out_Diffusion4_g254371 = 0.0;
					float Out_Depth4_g254371 = 0.0;
					BreakVisualData( Data4_g254371 , Out_Dummy4_g254371 , Out_Albedo4_g254371 , Out_AlbedoBase4_g254371 , Out_NormalTS4_g254371 , Out_NormalWS4_g254371 , Out_Shader4_g254371 , Out_Feature4_g254371 , Out_Season4_g254371 , Out_Emissive4_g254371 , Out_MultiMask4_g254371 , Out_Grayscale4_g254371 , Out_Luminosity4_g254371 , Out_AlphaClip4_g254371 , Out_AlphaFade4_g254371 , Out_Translucency4_g254371 , Out_Transmission4_g254371 , Out_Thickness4_g254371 , Out_Diffusion4_g254371 , Out_Depth4_g254371 );
					float Alpha109_g254366 = Out_AlphaClip4_g254371;
					float lerpResult91_g254366 = lerp( 1.0 , Alpha109_g254366 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g254366 = lerp( 1.0 , lerpResult91_g254366 , Filter152_g254366);
					clip( lerpResult154_g254366 );
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

					o.Emission = ( lerpResult72_g254366 * lerpResult84_g254366 );
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
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_OVERLAY_ATMO
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
				uniform half _OverlayIntensityValue;
				uniform half _OverlayTextureMode;
				uniform half _OverlayGlitterIntensityValue;
				uniform half _OverlayAtmoMode;
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
				uniform half4 _OverlayLumaRemap;
				uniform half _OverlayLumaValue;
				uniform half4 _OverlayBaseRemap;
				uniform half _OverlayBaseValue;
				uniform half4 _OverlayProjRemap;
				uniform half _OverlayProjValue;
				uniform half _OverlayMeshMode;
				uniform half4 _OverlayMeshRemap;
				uniform half _OverlayMeshValue;
				uniform half _OverlayBlendMath;
				uniform half4 _OverlayBlendRemap;
				uniform half _OverlayAtmoValue;
				uniform half TVE_DEBUG_Global;
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

					TVEVertexData Data16_g251752 =(TVEVertexData)0;
					float In_Dummy16_g251752 = 0.0;
					TVEVertexData Data16_g251747 =(TVEVertexData)0;
					float In_Dummy16_g251747 = 0.0;
					float localIfModelDataByShader26_g251547 = ( 0.0 );
					TVEModelData Data26_g251547 = (TVEModelData)0;
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
					TVEModelData DataDefault26_g251547 = Data16_g241434;
					TVEModelData DataGeneral26_g251547 = Data16_g241434;
					TVEModelData DataBlanket26_g251547 = Data16_g241434;
					TVEModelData DataImpostor26_g251547 = Data16_g241434;
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
					TVEModelData DataTerrain26_g251547 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251547 = IsShaderType2672;
					{
					if (Type26_g251547 == 0 )
					{
					Data26_g251547 = DataDefault26_g251547;
					}
					else if (Type26_g251547 == 1 )
					{
					Data26_g251547 = DataGeneral26_g251547;
					}
					else if (Type26_g251547 == 2 )
					{
					Data26_g251547 = DataBlanket26_g251547;
					}
					else if (Type26_g251547 == 3 )
					{
					Data26_g251547 = DataImpostor26_g251547;
					}
					else if (Type26_g251547 == 4 )
					{
					Data26_g251547 = DataTerrain26_g251547;
					}
					}
					TVEModelData Data15_g251748 =(TVEModelData)Data26_g251547;
					float Out_Dummy15_g251748 = 0.0;
					float3 Out_PositionOS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251748 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251748 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251748 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251748 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251748 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251748 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251748 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251748 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251748 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251748 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251748 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251748 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251748 , Out_Dummy15_g251748 , Out_PositionOS15_g251748 , Out_PositionWS15_g251748 , Out_PositionWO15_g251748 , Out_PositionRawOS15_g251748 , Out_PivotOS15_g251748 , Out_PivotWS15_g251748 , Out_PivotWO15_g251748 , Out_NormalOS15_g251748 , Out_NormalWS15_g251748 , Out_NormalRawOS15_g251748 , Out_TangentOS15_g251748 , Out_TangentWS15_g251748 , Out_BitangentWS15_g251748 , Out_ViewDirWS15_g251748 , Out_CoordsData15_g251748 , Out_VertexData15_g251748 , Out_MasksData15_g251748 , Out_PhaseData15_g251748 , Out_TransformData15_g251748 , Out_RotationData15_g251748 , Out_Interpolator15_g251748 );
					float3 In_PositionOS16_g251747 = Out_PositionOS15_g251748;
					float3 In_NormalOS16_g251747 = Out_NormalOS15_g251748;
					float4 In_TangentOS16_g251747 = Out_TangentOS15_g251748;
					float4 In_TransformData16_g251747 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251747 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251747 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251747 , In_Dummy16_g251747 , In_PositionOS16_g251747 , In_NormalOS16_g251747 , In_TangentOS16_g251747 , In_TransformData16_g251747 , In_RotationData16_g251747 , In_Interpolator16_g251747 );
					TVEVertexData Data15_g251750 =(TVEVertexData)Data16_g251747;
					float Out_Dummy15_g251750 = 0.0;
					float3 Out_PositionOS15_g251750 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251750 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251750 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251750 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251750 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251750 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251750 , Out_Dummy15_g251750 , Out_PositionOS15_g251750 , Out_NormalOS15_g251750 , Out_TangentOS15_g251750 , Out_TransformData15_g251750 , Out_RotationData15_g251750 , Out_Interpolator15_g251750 );
					TVEModelData Data15_g251751 =(TVEModelData)Data15_g251748;
					float Out_Dummy15_g251751 = 0.0;
					float3 Out_PositionOS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251751 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251751 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251751 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251751 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251751 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251751 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251751 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251751 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251751 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251751 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251751 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251751 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251751 , Out_Dummy15_g251751 , Out_PositionOS15_g251751 , Out_PositionWS15_g251751 , Out_PositionWO15_g251751 , Out_PositionRawOS15_g251751 , Out_PivotOS15_g251751 , Out_PivotWS15_g251751 , Out_PivotWO15_g251751 , Out_NormalOS15_g251751 , Out_NormalWS15_g251751 , Out_NormalRawOS15_g251751 , Out_TangentOS15_g251751 , Out_TangentWS15_g251751 , Out_BitangentWS15_g251751 , Out_ViewDirWS15_g251751 , Out_CoordsData15_g251751 , Out_VertexData15_g251751 , Out_MasksData15_g251751 , Out_PhaseData15_g251751 , Out_TransformData15_g251751 , Out_RotationData15_g251751 , Out_Interpolator15_g251751 );
					float3 In_PositionOS16_g251752 = ( Out_PositionOS15_g251750 - Out_PivotOS15_g251751 );
					float3 In_NormalOS16_g251752 = Out_NormalOS15_g251751;
					float4 In_TangentOS16_g251752 = Out_TangentOS15_g251751;
					float4 In_TransformData16_g251752 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251752 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251752 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251752 , In_Dummy16_g251752 , In_PositionOS16_g251752 , In_NormalOS16_g251752 , In_TangentOS16_g251752 , In_TransformData16_g251752 , In_RotationData16_g251752 , In_Interpolator16_g251752 );
					TVEVertexData Data15_g251761 =(TVEVertexData)Data16_g251752;
					float Out_Dummy15_g251761 = 0.0;
					float3 Out_PositionOS15_g251761 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251761 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251761 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251761 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251761 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251761 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251761 , Out_Dummy15_g251761 , Out_PositionOS15_g251761 , Out_NormalOS15_g251761 , Out_TangentOS15_g251761 , Out_TransformData15_g251761 , Out_RotationData15_g251761 , Out_Interpolator15_g251761 );
					TVEVertexData Data16_g251762 =(TVEVertexData)Data15_g251761;
					half Dummy317_g251753 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251762 = Dummy317_g251753;
					float3 In_PositionOS16_g251762 = Out_PositionOS15_g251761;
					float3 In_NormalOS16_g251762 = Out_NormalOS15_g251761;
					float4 In_TangentOS16_g251762 = Out_TangentOS15_g251761;
					half4 Model_TransformData356_g251753 = Out_TransformData15_g251761;
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
					TVEGlobalData Data15_g251763 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251763 = 0.0;
					float4 Out_CoatTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251763 = float4( 0,0,0,0 );
					BreakData( Data15_g251763 , Out_Dummy15_g251763 , Out_CoatTexture15_g251763 , Out_DrawTexture15_g251763 , Out_PaintTexture15_g251763 , Out_AtmoTexture15_g251763 , Out_EffexTexture15_g251763 , Out_GlowTexture15_g251763 , Out_FormTexture15_g251763 , Out_LandTexture15_g251763 , Out_VertxTexture15_g251763 , Out_FlowTexture15_g251763 , Out_UserTexture15_g251763 );
					float4 Global_FormTexture351_g251753 = Out_FormTexture15_g251763;
					TVEModelData Data15_g251760 =(TVEModelData)Data15_g251751;
					float Out_Dummy15_g251760 = 0.0;
					float3 Out_PositionOS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251760 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251760 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251760 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251760 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251760 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251760 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251760 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251760 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251760 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251760 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251760 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251760 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251760 , Out_Dummy15_g251760 , Out_PositionOS15_g251760 , Out_PositionWS15_g251760 , Out_PositionWO15_g251760 , Out_PositionRawOS15_g251760 , Out_PivotOS15_g251760 , Out_PivotWS15_g251760 , Out_PivotWO15_g251760 , Out_NormalOS15_g251760 , Out_NormalWS15_g251760 , Out_NormalRawOS15_g251760 , Out_TangentOS15_g251760 , Out_TangentWS15_g251760 , Out_BitangentWS15_g251760 , Out_ViewDirWS15_g251760 , Out_CoordsData15_g251760 , Out_VertexData15_g251760 , Out_MasksData15_g251760 , Out_PhaseData15_g251760 , Out_TransformData15_g251760 , Out_RotationData15_g251760 , Out_Interpolator15_g251760 );
					float3 Model_PivotWO353_g251753 = Out_PivotWO15_g251760;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251759 = _ConformMeshMode;
					float Option70_g251759 = temp_output_17_0_g251759;
					half4 Model_VertexData357_g251753 = Out_VertexData15_g251760;
					float4 temp_output_3_0_g251759 = Model_VertexData357_g251753;
					float4 Channel70_g251759 = temp_output_3_0_g251759;
					float localSwitchChannel470_g251759 = SwitchChannel4( Option70_g251759 , Channel70_g251759 );
					float temp_output_390_0_g251753 = localSwitchChannel470_g251759;
					float temp_output_7_0_g251756 = _ConformMeshRemap.x;
					float temp_output_9_0_g251756 = ( temp_output_390_0_g251753 - temp_output_7_0_g251756 );
					float lerpResult374_g251753 = lerp( 1.0 , saturate( ( temp_output_9_0_g251756 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251753 = lerpResult374_g251753;
					float temp_output_328_0_g251753 = ( Blend_VertMask379_g251753 * TVE_IsEnabled );
					half Conform_Mask366_g251753 = temp_output_328_0_g251753;
					float temp_output_322_0_g251753 = ( ( ( ( (Global_FormTexture351_g251753).z - ( (Model_PivotWO353_g251753).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251753 ) );
					float3 appendResult329_g251753 = (float3(0.0 , temp_output_322_0_g251753 , 0.0));
					float3 appendResult387_g251753 = (float3(0.0 , 0.0 , temp_output_322_0_g251753));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251757 = appendResult387_g251753;
					#else
					float3 staticSwitch65_g251757 = appendResult329_g251753;
					#endif
					float3 Blanket_Conform368_g251753 = staticSwitch65_g251757;
					float4 appendResult312_g251753 = (float4(Blanket_Conform368_g251753 , 0.0));
					float4 temp_output_310_0_g251753 = ( Model_TransformData356_g251753 + appendResult312_g251753 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251753 = temp_output_310_0_g251753;
					#else
					float4 staticSwitch364_g251753 = Model_TransformData356_g251753;
					#endif
					half4 Final_TransformData365_g251753 = staticSwitch364_g251753;
					float4 In_TransformData16_g251762 = Final_TransformData365_g251753;
					float4 In_RotationData16_g251762 = Out_RotationData15_g251761;
					float4 In_Interpolator16_g251762 = Out_Interpolator15_g251761;
					BuildVertexData( Data16_g251762 , In_Dummy16_g251762 , In_PositionOS16_g251762 , In_NormalOS16_g251762 , In_TangentOS16_g251762 , In_TransformData16_g251762 , In_RotationData16_g251762 , In_Interpolator16_g251762 );
					TVEVertexData Data15_g251773 =(TVEVertexData)Data16_g251762;
					float Out_Dummy15_g251773 = 0.0;
					float3 Out_PositionOS15_g251773 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251773 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251773 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251773 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251773 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251773 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251773 , Out_Dummy15_g251773 , Out_PositionOS15_g251773 , Out_NormalOS15_g251773 , Out_TangentOS15_g251773 , Out_TransformData15_g251773 , Out_RotationData15_g251773 , Out_Interpolator15_g251773 );
					TVEVertexData Data16_g251774 =(TVEVertexData)Data15_g251773;
					float In_Dummy16_g251774 = 0.0;
					float3 Vertex_PositionOS147_g251764 = Out_PositionOS15_g251773;
					half3 VertexPos40_g251768 = Vertex_PositionOS147_g251764;
					float4 temp_output_1615_33_g251764 = Out_RotationData15_g251773;
					half4 Vertex_RotationData1569_g251764 = temp_output_1615_33_g251764;
					float2 break1582_g251764 = (Vertex_RotationData1569_g251764).xy;
					half Angle44_g251768 = break1582_g251764.y;
					half CosAngle89_g251768 = cos( Angle44_g251768 );
					half SinAngle93_g251768 = sin( Angle44_g251768 );
					float3 appendResult95_g251768 = (float3((VertexPos40_g251768).x , ( ( (VertexPos40_g251768).y * CosAngle89_g251768 ) - ( (VertexPos40_g251768).z * SinAngle93_g251768 ) ) , ( ( (VertexPos40_g251768).y * SinAngle93_g251768 ) + ( (VertexPos40_g251768).z * CosAngle89_g251768 ) )));
					half3 VertexPos40_g251769 = appendResult95_g251768;
					half Angle44_g251769 = -break1582_g251764.x;
					half CosAngle94_g251769 = cos( Angle44_g251769 );
					half SinAngle95_g251769 = sin( Angle44_g251769 );
					float3 appendResult98_g251769 = (float3(( ( (VertexPos40_g251769).x * CosAngle94_g251769 ) - ( (VertexPos40_g251769).y * SinAngle95_g251769 ) ) , ( ( (VertexPos40_g251769).x * SinAngle95_g251769 ) + ( (VertexPos40_g251769).y * CosAngle94_g251769 ) ) , (VertexPos40_g251769).z));
					half3 VertexPos40_g251767 = Vertex_PositionOS147_g251764;
					half Angle44_g251767 = break1582_g251764.y;
					half CosAngle89_g251767 = cos( Angle44_g251767 );
					half SinAngle93_g251767 = sin( Angle44_g251767 );
					float3 appendResult95_g251767 = (float3((VertexPos40_g251767).x , ( ( (VertexPos40_g251767).y * CosAngle89_g251767 ) - ( (VertexPos40_g251767).z * SinAngle93_g251767 ) ) , ( ( (VertexPos40_g251767).y * SinAngle93_g251767 ) + ( (VertexPos40_g251767).z * CosAngle89_g251767 ) )));
					half3 VertexPos40_g251772 = appendResult95_g251767;
					half Angle44_g251772 = break1582_g251764.x;
					half CosAngle91_g251772 = cos( Angle44_g251772 );
					half SinAngle92_g251772 = sin( Angle44_g251772 );
					float3 appendResult93_g251772 = (float3(( ( (VertexPos40_g251772).x * CosAngle91_g251772 ) + ( (VertexPos40_g251772).z * SinAngle92_g251772 ) ) , (VertexPos40_g251772).y , ( ( -(VertexPos40_g251772).x * SinAngle92_g251772 ) + ( (VertexPos40_g251772).z * CosAngle91_g251772 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251770 = appendResult93_g251772;
					#else
					float3 staticSwitch65_g251770 = appendResult98_g251769;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251765 = staticSwitch65_g251770;
					#else
					float3 staticSwitch65_g251765 = Vertex_PositionOS147_g251764;
					#endif
					float3 temp_output_1608_0_g251764 = staticSwitch65_g251765;
					half3 VertexPos40_g251771 = temp_output_1608_0_g251764;
					half Angle44_g251771 = (Vertex_RotationData1569_g251764).z;
					half CosAngle91_g251771 = cos( Angle44_g251771 );
					half SinAngle92_g251771 = sin( Angle44_g251771 );
					float3 appendResult93_g251771 = (float3(( ( (VertexPos40_g251771).x * CosAngle91_g251771 ) + ( (VertexPos40_g251771).z * SinAngle92_g251771 ) ) , (VertexPos40_g251771).y , ( ( -(VertexPos40_g251771).x * SinAngle92_g251771 ) + ( (VertexPos40_g251771).z * CosAngle91_g251771 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251766 = appendResult93_g251771;
					#else
					float3 staticSwitch65_g251766 = temp_output_1608_0_g251764;
					#endif
					float4 temp_output_1615_31_g251764 = Out_TransformData15_g251773;
					half4 Vertex_TransformData1568_g251764 = temp_output_1615_31_g251764;
					half3 Final_PositionOS178_g251764 = ( ( staticSwitch65_g251766 * (Vertex_TransformData1568_g251764).w ) + (Vertex_TransformData1568_g251764).xyz );
					float3 In_PositionOS16_g251774 = Final_PositionOS178_g251764;
					float3 In_NormalOS16_g251774 = Out_NormalOS15_g251773;
					float4 In_TangentOS16_g251774 = Out_TangentOS15_g251773;
					float4 In_TransformData16_g251774 = temp_output_1615_31_g251764;
					float4 In_RotationData16_g251774 = temp_output_1615_33_g251764;
					float4 In_Interpolator16_g251774 = Out_Interpolator15_g251773;
					BuildVertexData( Data16_g251774 , In_Dummy16_g251774 , In_PositionOS16_g251774 , In_NormalOS16_g251774 , In_TangentOS16_g251774 , In_TransformData16_g251774 , In_RotationData16_g251774 , In_Interpolator16_g251774 );
					TVEVertexData Data15_g251777 =(TVEVertexData)Data16_g251774;
					float Out_Dummy15_g251777 = 0.0;
					float3 Out_PositionOS15_g251777 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251777 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251777 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251777 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251777 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251777 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251777 , Out_Dummy15_g251777 , Out_PositionOS15_g251777 , Out_NormalOS15_g251777 , Out_TangentOS15_g251777 , Out_TransformData15_g251777 , Out_RotationData15_g251777 , Out_Interpolator15_g251777 );
					TVEVertexData Data16_g251778 =(TVEVertexData)Data15_g251777;
					float In_Dummy16_g251778 = 0.0;
					TVEModelData Data15_g251776 =(TVEModelData)Data15_g251760;
					float Out_Dummy15_g251776 = 0.0;
					float3 Out_PositionOS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251776 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251776 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251776 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251776 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251776 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251776 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251776 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251776 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251776 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251776 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251776 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251776 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251776 , Out_Dummy15_g251776 , Out_PositionOS15_g251776 , Out_PositionWS15_g251776 , Out_PositionWO15_g251776 , Out_PositionRawOS15_g251776 , Out_PivotOS15_g251776 , Out_PivotWS15_g251776 , Out_PivotWO15_g251776 , Out_NormalOS15_g251776 , Out_NormalWS15_g251776 , Out_NormalRawOS15_g251776 , Out_TangentOS15_g251776 , Out_TangentWS15_g251776 , Out_BitangentWS15_g251776 , Out_ViewDirWS15_g251776 , Out_CoordsData15_g251776 , Out_VertexData15_g251776 , Out_MasksData15_g251776 , Out_PhaseData15_g251776 , Out_TransformData15_g251776 , Out_RotationData15_g251776 , Out_Interpolator15_g251776 );
					float3 In_PositionOS16_g251778 = ( Out_PositionOS15_g251777 + Out_PivotOS15_g251776 );
					float3 In_NormalOS16_g251778 = Out_NormalOS15_g251777;
					float4 In_TangentOS16_g251778 = Out_TangentOS15_g251777;
					float4 In_TransformData16_g251778 = Out_TransformData15_g251777;
					float4 In_RotationData16_g251778 = Out_RotationData15_g251777;
					float4 In_Interpolator16_g251778 = Out_Interpolator15_g251777;
					BuildVertexData( Data16_g251778 , In_Dummy16_g251778 , In_PositionOS16_g251778 , In_NormalOS16_g251778 , In_TangentOS16_g251778 , In_TransformData16_g251778 , In_RotationData16_g251778 , In_Interpolator16_g251778 );
					TVEVertexData Data15_g254374 =(TVEVertexData)Data16_g251778;
					float Out_Dummy15_g254374 = 0.0;
					float3 Out_PositionOS15_g254374 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254374 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254374 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254374 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254374 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254374 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254374 , Out_Dummy15_g254374 , Out_PositionOS15_g254374 , Out_NormalOS15_g254374 , Out_TangentOS15_g254374 , Out_TransformData15_g254374 , Out_RotationData15_g254374 , Out_Interpolator15_g254374 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g241416;
					o.ase_texcoord5.xyz = vertexToFrag76_g241416;
					TVEVertexData Data1902_g252029 = Data16_g251778;
					float4 Out_Interpolator1902_g252029 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g252029 = Data1902_g252029.Interpolator;
					}
					float4 vertexToFrag1901_g252029 = Out_Interpolator1902_g252029;
					o.ase_texcoord7 = vertexToFrag1901_g252029;
					float3 vertexPos57_g254366 = v.vertex.xyz;
					float4 ase_positionCS57_g254366 = UnityObjectToClipPos( vertexPos57_g254366 );
					o.ase_texcoord8 = ase_positionCS57_g254366;
					
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
					float3 vertexValue = Out_PositionOS15_g254374;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254374;
					v.tangent = Out_TangentOS15_g254374;

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
					
					float3 color130_g254366 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g254366 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g254368 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g254367 = ( temp_cast_4 * ( 0.5 + appendResult128_g254368 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g254367 = (float4(ddx( FinalUV13_g254367 ) , ddy( FinalUV13_g254367 )));
					float4 UVDerivatives17_g254367 = appendResult16_g254367;
					float4 break28_g254367 = UVDerivatives17_g254367;
					float2 appendResult19_g254367 = (float2(break28_g254367.x , break28_g254367.z));
					float2 appendResult20_g254367 = (float2(break28_g254367.x , break28_g254367.z));
					float dotResult24_g254367 = dot( appendResult19_g254367 , appendResult20_g254367 );
					float2 appendResult21_g254367 = (float2(break28_g254367.y , break28_g254367.w));
					float2 appendResult22_g254367 = (float2(break28_g254367.y , break28_g254367.w));
					float dotResult23_g254367 = dot( appendResult21_g254367 , appendResult22_g254367 );
					float2 appendResult25_g254367 = (float2(dotResult24_g254367 , dotResult23_g254367));
					float2 derivativesLength29_g254367 = sqrt( appendResult25_g254367 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g254367 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g254367 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g254367 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g254367 = clampResult57_g254367;
					float2 break55_g254367 = derivativesLength29_g254367;
					float4 lerpResult73_g254367 = lerp( float4( color130_g254366 , 0.0 ) , float4( color81_g254366 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g254367.x * break71_g254367.y * sqrt( saturate( ( 1.1 - max( break55_g254367.x, break55_g254367.y ) ) ) ) ) ) ));
					float3 color107_g254352 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254352 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g254351 = ( 0.0 );
					float localIfMasksData25_g254350 = ( 0.0 );
					TVEMasksData Data25_g254350 = (TVEMasksData)0;
					float localBuildMasksData3_g252127 = ( 0.0 );
					TVEMasksData Data3_g252127 = (TVEMasksData)0;
					half Feature_Intensity1107_g252072 = _OverlayIntensityValue;
					float ifLocalVar18_g252123 = 0;
					if( Feature_Intensity1107_g252072 <= 0.0 )
					ifLocalVar18_g252123 = 0.0;
					else
					ifLocalVar18_g252123 = 1.0;
					half Feature_Maps1112_g252072 = _OverlayTextureMode;
					float ifLocalVar18_g252124 = 0;
					if( Feature_Maps1112_g252072 <= 0.0 )
					ifLocalVar18_g252124 = 0.0;
					else
					ifLocalVar18_g252124 = 1.0;
					half Feature_Glitter1108_g252072 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g252125 = 0;
					if( Feature_Glitter1108_g252072 <= 0.0 )
					ifLocalVar18_g252125 = 0.0;
					else
					ifLocalVar18_g252125 = 1.0;
					half Feature_Element1085_g252072 = _OverlayAtmoMode;
					float ifLocalVar18_g252122 = 0;
					if( Feature_Element1085_g252072 <= 0.0 )
					ifLocalVar18_g252122 = 0.0;
					else
					ifLocalVar18_g252122 = 1.0;
					float4 appendResult1117_g252072 = (float4(ifLocalVar18_g252123 , ifLocalVar18_g252124 , ifLocalVar18_g252125 , ifLocalVar18_g252122));
					float4 In_MaskA3_g252127 = appendResult1117_g252072;
					half Blend_TexMask908_g252072 = 1.0;
					float localBreakVisualData4_g252146 = ( 0.0 );
					float localBuildVisualData3_g252035 = ( 0.0 );
					float localBuildVisualData3_g252030 = ( 0.0 );
					TVEVisualData Data3_g252030 =(TVEVisualData)0;
					float temp_output_14_0_g252030 = 0.0;
					float In_Dummy3_g252030 = temp_output_14_0_g252030;
					float3 temp_cast_9 = (0.5).xxx;
					float3 temp_output_4_0_g252030 = temp_cast_9;
					float3 In_Albedo3_g252030 = temp_output_4_0_g252030;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_44_0_g252030 = temp_cast_10;
					float3 In_AlbedoBase3_g252030 = temp_output_44_0_g252030;
					float2 temp_cast_11 = (0.0).xx;
					float2 In_NormalTS3_g252030 = temp_cast_11;
					float3 temp_cast_12 = (0.5).xxx;
					float3 In_NormalWS3_g252030 = temp_cast_12;
					float4 In_Shader3_g252030 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g252030 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252030 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252030 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g252030 = 0.5;
					float In_Grayscale3_g252030 = temp_output_12_0_g252030;
					float temp_output_16_0_g252030 = 1.0;
					float In_Luminosity3_g252030 = temp_output_16_0_g252030;
					float In_MultiMask3_g252030 = 1.0;
					float In_AlphaClip3_g252030 = 1.0;
					float In_AlphaFade3_g252030 = 1.0;
					float3 temp_cast_13 = (1.0).xxx;
					float3 In_Translucency3_g252030 = temp_cast_13;
					float In_Transmission3_g252030 = 1.0;
					float In_Thickness3_g252030 = 0.0;
					float In_Diffusion3_g252030 = 0.0;
					float In_Depth3_g252030 = 0.0;
					BuildVisualData( Data3_g252030 , In_Dummy3_g252030 , In_Albedo3_g252030 , In_AlbedoBase3_g252030 , In_NormalTS3_g252030 , In_NormalWS3_g252030 , In_Shader3_g252030 , In_Feature3_g252030 , In_Season3_g252030 , In_Emissive3_g252030 , In_Grayscale3_g252030 , In_Luminosity3_g252030 , In_MultiMask3_g252030 , In_AlphaClip3_g252030 , In_AlphaFade3_g252030 , In_Translucency3_g252030 , In_Transmission3_g252030 , In_Thickness3_g252030 , In_Diffusion3_g252030 , In_Depth3_g252030 );
					TVEVisualData Data3_g252035 =(TVEVisualData)Data3_g252030;
					half Dummy130_g252033 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g252035 = Dummy130_g252033;
					float In_Dummy3_g252035 = temp_output_14_0_g252035;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252056) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g252038 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g252038 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g252056 = staticSwitch36_g252038;
					float localBreakTextureData456_g252056 = ( 0.0 );
					float localBuildTextureData431_g252055 = ( 0.0 );
					TVEMasksData Data431_g252055 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252055 = ( 0.0 );
					float4 temp_output_6_0_g252071 = _main_coord_value;
					float4 temp_output_7_0_g252071 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252071 = ( temp_output_6_0_g252071 + temp_output_7_0_g252071 );
					#else
					float4 staticSwitch14_g252071 = temp_output_6_0_g252071;
					#endif
					half4 Local_Coords180_g252033 = staticSwitch14_g252071;
					float4 Coords444_g252055 = Local_Coords180_g252033;
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
					TVEModelData Data15_g252031 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g252031 = 0.0;
					float3 Out_PositionWS15_g252031 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252031 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252031 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252031 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252031 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252031 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252031 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252031 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252031 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252031 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252031 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252031 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252031 , Out_Dummy15_g252031 , Out_PositionWS15_g252031 , Out_PositionWO15_g252031 , Out_PivotWS15_g252031 , Out_PivotWO15_g252031 , Out_NormalWS15_g252031 , Out_TangentWS15_g252031 , Out_BitangentWS15_g252031 , Out_TriplanarWeights15_g252031 , Out_ViewDirWS15_g252031 , Out_CoordsData15_g252031 , Out_VertexData15_g252031 , Out_Interpolator15_g252031 );
					TVEModelData Data16_g252032 =(TVEModelData)Data15_g252031;
					float In_Dummy16_g252032 = Out_Dummy15_g252031;
					float3 In_PositionWS16_g252032 = Out_PositionWS15_g252031;
					float3 In_PositionWO16_g252032 = Out_PositionWO15_g252031;
					float3 In_PivotWS16_g252032 = Out_PivotWS15_g252031;
					float3 In_PivotWO16_g252032 = Out_PivotWO15_g252031;
					float3 In_NormalWS16_g252032 = Out_NormalWS15_g252031;
					float3 In_TangentWS16_g252032 = Out_TangentWS15_g252031;
					float3 In_BitangentWS16_g252032 = Out_BitangentWS15_g252031;
					float3 In_TriplanarWeights16_g252032 = Out_TriplanarWeights15_g252031;
					float3 In_ViewDirWS16_g252032 = Out_ViewDirWS15_g252031;
					float4 In_CoordsData16_g252032 = Out_CoordsData15_g252031;
					float4 In_VertexData16_g252032 = Out_VertexData15_g252031;
					float4 vertexToFrag1901_g252029 = IN.ase_texcoord7;
					float4 In_Interpolator16_g252032 = vertexToFrag1901_g252029;
					BuildModelFragData( Data16_g252032 , In_Dummy16_g252032 , In_PositionWS16_g252032 , In_PositionWO16_g252032 , In_PivotWS16_g252032 , In_PivotWO16_g252032 , In_NormalWS16_g252032 , In_TangentWS16_g252032 , In_BitangentWS16_g252032 , In_TriplanarWeights16_g252032 , In_ViewDirWS16_g252032 , In_CoordsData16_g252032 , In_VertexData16_g252032 , In_Interpolator16_g252032 );
					TVEModelData Data15_g252034 =(TVEModelData)Data16_g252032;
					float Out_Dummy15_g252034 = 0.0;
					float3 Out_PositionWS15_g252034 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252034 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252034 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252034 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252034 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252034 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252034 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252034 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252034 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252034 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252034 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252034 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252034 , Out_Dummy15_g252034 , Out_PositionWS15_g252034 , Out_PositionWO15_g252034 , Out_PivotWS15_g252034 , Out_PivotWO15_g252034 , Out_NormalWS15_g252034 , Out_TangentWS15_g252034 , Out_BitangentWS15_g252034 , Out_TriplanarWeights15_g252034 , Out_ViewDirWS15_g252034 , Out_CoordsData15_g252034 , Out_VertexData15_g252034 , Out_Interpolator15_g252034 );
					float4 Model_CoordsData324_g252033 = Out_CoordsData15_g252034;
					float4 MeshCoords444_g252055 = Model_CoordsData324_g252033;
					float2 UV0444_g252055 = float2( 0,0 );
					float2 UV3444_g252055 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252055 , MeshCoords444_g252055 , UV0444_g252055 , UV3444_g252055 );
					float4 appendResult430_g252055 = (float4(UV0444_g252055 , UV3444_g252055));
					float4 In_MaskA431_g252055 = appendResult430_g252055;
					float localComputeWorldCoords315_g252055 = ( 0.0 );
					float4 Coords315_g252055 = Local_Coords180_g252033;
					float3 Model_PositionWO222_g252033 = Out_PositionWO15_g252034;
					float3 PositionWS315_g252055 = Model_PositionWO222_g252033;
					float2 ZY315_g252055 = float2( 0,0 );
					float2 XZ315_g252055 = float2( 0,0 );
					float2 XY315_g252055 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252055 , PositionWS315_g252055 , ZY315_g252055 , XZ315_g252055 , XY315_g252055 );
					float2 ZY402_g252055 = ZY315_g252055;
					float2 XZ403_g252055 = XZ315_g252055;
					float4 appendResult432_g252055 = (float4(ZY402_g252055 , XZ403_g252055));
					float4 In_MaskB431_g252055 = appendResult432_g252055;
					float2 XY404_g252055 = XY315_g252055;
					float localComputeStochasticCoords409_g252055 = ( 0.0 );
					float2 UV409_g252055 = ZY402_g252055;
					float2 UV1409_g252055 = float2( 0,0 );
					float2 UV2409_g252055 = float2( 0,0 );
					float2 UV3409_g252055 = float2( 0,0 );
					float3 Weights409_g252055 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252055 , UV1409_g252055 , UV2409_g252055 , UV3409_g252055 , Weights409_g252055 );
					float4 appendResult433_g252055 = (float4(XY404_g252055 , UV1409_g252055));
					float4 In_MaskC431_g252055 = appendResult433_g252055;
					float4 appendResult434_g252055 = (float4(UV2409_g252055 , UV3409_g252055));
					float4 In_MaskD431_g252055 = appendResult434_g252055;
					float localComputeStochasticCoords422_g252055 = ( 0.0 );
					float2 UV422_g252055 = XZ403_g252055;
					float2 UV1422_g252055 = float2( 0,0 );
					float2 UV2422_g252055 = float2( 0,0 );
					float2 UV3422_g252055 = float2( 0,0 );
					float3 Weights422_g252055 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252055 , UV1422_g252055 , UV2422_g252055 , UV3422_g252055 , Weights422_g252055 );
					float4 appendResult435_g252055 = (float4(UV1422_g252055 , UV2422_g252055));
					float4 In_MaskE431_g252055 = appendResult435_g252055;
					float localComputeStochasticCoords423_g252055 = ( 0.0 );
					float2 UV423_g252055 = XY404_g252055;
					float2 UV1423_g252055 = float2( 0,0 );
					float2 UV2423_g252055 = float2( 0,0 );
					float2 UV3423_g252055 = float2( 0,0 );
					float3 Weights423_g252055 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252055 , UV1423_g252055 , UV2423_g252055 , UV3423_g252055 , Weights423_g252055 );
					float4 appendResult436_g252055 = (float4(UV3422_g252055 , UV1423_g252055));
					float4 In_MaskF431_g252055 = appendResult436_g252055;
					float4 appendResult437_g252055 = (float4(UV2423_g252055 , UV3423_g252055));
					float4 In_MaskG431_g252055 = appendResult437_g252055;
					float4 In_MaskH431_g252055 = float4( Weights409_g252055 , 0.0 );
					float4 In_MaskI431_g252055 = float4( Weights422_g252055 , 0.0 );
					float4 In_MaskJ431_g252055 = float4( Weights423_g252055 , 0.0 );
					half3 Model_NormalWS226_g252033 = Out_NormalWS15_g252034;
					float3 temp_output_449_0_g252055 = Model_NormalWS226_g252033;
					float4 In_MaskK431_g252055 = float4( temp_output_449_0_g252055 , 0.0 );
					half3 Model_TangentWS366_g252033 = Out_TangentWS15_g252034;
					float3 temp_output_450_0_g252055 = Model_TangentWS366_g252033;
					float4 In_MaskL431_g252055 = float4( temp_output_450_0_g252055 , 0.0 );
					half3 Model_BitangentWS367_g252033 = Out_BitangentWS15_g252034;
					float3 temp_output_451_0_g252055 = Model_BitangentWS367_g252033;
					float4 In_MaskM431_g252055 = float4( temp_output_451_0_g252055 , 0.0 );
					half3 Model_TriplanarWeights368_g252033 = Out_TriplanarWeights15_g252034;
					float3 temp_output_445_0_g252055 = Model_TriplanarWeights368_g252033;
					float4 In_MaskN431_g252055 = float4( temp_output_445_0_g252055 , 0.0 );
					BuildTextureData( Data431_g252055 , In_MaskA431_g252055 , In_MaskB431_g252055 , In_MaskC431_g252055 , In_MaskD431_g252055 , In_MaskE431_g252055 , In_MaskF431_g252055 , In_MaskG431_g252055 , In_MaskH431_g252055 , In_MaskI431_g252055 , In_MaskJ431_g252055 , In_MaskK431_g252055 , In_MaskL431_g252055 , In_MaskM431_g252055 , In_MaskN431_g252055 );
					TVEMasksData Data456_g252056 =(TVEMasksData)Data431_g252055;
					float4 Out_MaskA456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252056 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252056 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252056 , Out_MaskA456_g252056 , Out_MaskB456_g252056 , Out_MaskC456_g252056 , Out_MaskD456_g252056 , Out_MaskE456_g252056 , Out_MaskF456_g252056 , Out_MaskG456_g252056 , Out_MaskH456_g252056 , Out_MaskI456_g252056 , Out_MaskJ456_g252056 , Out_MaskK456_g252056 , Out_MaskL456_g252056 , Out_MaskM456_g252056 , Out_MaskN456_g252056 );
					half2 UV276_g252056 = (Out_MaskA456_g252056).xy;
					float temp_output_504_0_g252056 = 0.0;
					half Bias276_g252056 = temp_output_504_0_g252056;
					half2 Normal276_g252056 = float2( 0,0 );
					half4 localSampleCoord276_g252056 = SampleCoord( Texture276_g252056 , Sampler276_g252056 , UV276_g252056 , Bias276_g252056 , Normal276_g252056 );
					float4 temp_output_407_277_g252033 = localSampleCoord276_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252056) = _MainAlbedoTex;
					SamplerState Sampler502_g252056 = staticSwitch36_g252038;
					half2 UV502_g252056 = (Out_MaskA456_g252056).zw;
					half Bias502_g252056 = temp_output_504_0_g252056;
					half2 Normal502_g252056 = float2( 0,0 );
					half4 localSampleCoord502_g252056 = SampleCoord( Texture502_g252056 , Sampler502_g252056 , UV502_g252056 , Bias502_g252056 , Normal502_g252056 );
					float4 temp_output_407_278_g252033 = localSampleCoord502_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252056) = _MainAlbedoTex;
					SamplerState Sampler496_g252056 = staticSwitch36_g252038;
					float2 temp_output_463_0_g252056 = (Out_MaskB456_g252056).zw;
					half2 XZ496_g252056 = temp_output_463_0_g252056;
					half Bias496_g252056 = temp_output_504_0_g252056;
					half3 NormalWS512_g252056 = (Out_MaskK456_g252056).xyz;
					half3 NormalWS496_g252056 = NormalWS512_g252056;
					half3 Normal496_g252056 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252056 = SamplePlanar2D( Texture496_g252056 , Sampler496_g252056 , XZ496_g252056 , Bias496_g252056 , NormalWS496_g252056 , Normal496_g252056 );
					float4 temp_output_407_0_g252033 = localSamplePlanar2D496_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252056) = _MainAlbedoTex;
					SamplerState Sampler490_g252056 = staticSwitch36_g252038;
					float2 temp_output_462_0_g252056 = (Out_MaskB456_g252056).xy;
					half2 ZY490_g252056 = temp_output_462_0_g252056;
					half2 XZ490_g252056 = temp_output_463_0_g252056;
					float2 temp_output_464_0_g252056 = (Out_MaskC456_g252056).xy;
					half2 XY490_g252056 = temp_output_464_0_g252056;
					half Bias490_g252056 = temp_output_504_0_g252056;
					half3 Triplanar522_g252056 = (Out_MaskN456_g252056).xyz;
					half3 Triplanar490_g252056 = Triplanar522_g252056;
					half3 NormalWS490_g252056 = NormalWS512_g252056;
					half3 Normal490_g252056 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252056 = SamplePlanar3D( Texture490_g252056 , Sampler490_g252056 , ZY490_g252056 , XZ490_g252056 , XY490_g252056 , Bias490_g252056 , Triplanar490_g252056 , NormalWS490_g252056 , Normal490_g252056 );
					float4 temp_output_407_201_g252033 = localSamplePlanar3D490_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252056) = _MainAlbedoTex;
					SamplerState Sampler498_g252056 = staticSwitch36_g252038;
					half2 XZ498_g252056 = temp_output_463_0_g252056;
					float2 temp_output_473_0_g252056 = (Out_MaskE456_g252056).xy;
					half2 XZ_1498_g252056 = temp_output_473_0_g252056;
					float2 temp_output_474_0_g252056 = (Out_MaskE456_g252056).zw;
					half2 XZ_2498_g252056 = temp_output_474_0_g252056;
					float2 temp_output_475_0_g252056 = (Out_MaskF456_g252056).xy;
					half2 XZ_3498_g252056 = temp_output_475_0_g252056;
					float temp_output_510_0_g252056 = exp2( temp_output_504_0_g252056 );
					half Bias498_g252056 = temp_output_510_0_g252056;
					float3 temp_output_480_0_g252056 = (Out_MaskI456_g252056).xyz;
					half3 Weights_2498_g252056 = temp_output_480_0_g252056;
					half3 NormalWS498_g252056 = NormalWS512_g252056;
					half3 Normal498_g252056 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252056 = SampleStochastic2D( Texture498_g252056 , Sampler498_g252056 , XZ498_g252056 , XZ_1498_g252056 , XZ_2498_g252056 , XZ_3498_g252056 , Bias498_g252056 , Weights_2498_g252056 , NormalWS498_g252056 , Normal498_g252056 );
					float4 temp_output_407_202_g252033 = localSampleStochastic2D498_g252056;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252056) = _MainAlbedoTex;
					SamplerState Sampler500_g252056 = staticSwitch36_g252038;
					half2 ZY500_g252056 = temp_output_462_0_g252056;
					half2 ZY_1500_g252056 = (Out_MaskC456_g252056).zw;
					half2 ZY_2500_g252056 = (Out_MaskD456_g252056).xy;
					half2 ZY_3500_g252056 = (Out_MaskD456_g252056).zw;
					half2 XZ500_g252056 = temp_output_463_0_g252056;
					half2 XZ_1500_g252056 = temp_output_473_0_g252056;
					half2 XZ_2500_g252056 = temp_output_474_0_g252056;
					half2 XZ_3500_g252056 = temp_output_475_0_g252056;
					half2 XY500_g252056 = temp_output_464_0_g252056;
					half2 XY_1500_g252056 = (Out_MaskF456_g252056).zw;
					half2 XY_2500_g252056 = (Out_MaskG456_g252056).xy;
					half2 XY_3500_g252056 = (Out_MaskG456_g252056).zw;
					half Bias500_g252056 = temp_output_510_0_g252056;
					half3 Weights_1500_g252056 = (Out_MaskH456_g252056).xyz;
					half3 Weights_2500_g252056 = temp_output_480_0_g252056;
					half3 Weights_3500_g252056 = (Out_MaskJ456_g252056).xyz;
					half3 Triplanar500_g252056 = Triplanar522_g252056;
					half3 NormalWS500_g252056 = NormalWS512_g252056;
					half3 Normal500_g252056 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252056 = SampleStochastic3D( Texture500_g252056 , Sampler500_g252056 , ZY500_g252056 , ZY_1500_g252056 , ZY_2500_g252056 , ZY_3500_g252056 , XZ500_g252056 , XZ_1500_g252056 , XZ_2500_g252056 , XZ_3500_g252056 , XY500_g252056 , XY_1500_g252056 , XY_2500_g252056 , XY_3500_g252056 , Bias500_g252056 , Weights_1500_g252056 , Weights_2500_g252056 , Weights_3500_g252056 , Triplanar500_g252056 , NormalWS500_g252056 , Normal500_g252056 );
					float4 temp_output_407_203_g252033 = localSampleStochastic3D500_g252056;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g252033 = temp_output_407_277_g252033;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g252033 = temp_output_407_278_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g252033 = temp_output_407_0_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g252033 = temp_output_407_201_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g252033 = temp_output_407_202_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g252033 = temp_output_407_203_g252033;
					#else
					float4 staticSwitch184_g252033 = temp_output_407_277_g252033;
					#endif
					half4 Local_AlbedoSample185_g252033 = staticSwitch184_g252033;
					float3 lerpResult53_g252033 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g252033).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g252033 = lerpResult53_g252033;
					float temp_output_17_0_g252053 = _MainMultiWriteMode;
					float Option91_g252053 = temp_output_17_0_g252053;
					float4 Model_VertexData418_g252033 = Out_VertexData15_g252034;
					float4 temp_output_84_0_g252053 = Model_VertexData418_g252033;
					float4 ChannelA91_g252053 = temp_output_84_0_g252053;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252041) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g252040 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g252040 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252041 = staticSwitch38_g252040;
					float localBreakTextureData456_g252041 = ( 0.0 );
					TVEMasksData Data456_g252041 =(TVEMasksData)Data431_g252055;
					float4 Out_MaskA456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252041 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252041 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252041 , Out_MaskA456_g252041 , Out_MaskB456_g252041 , Out_MaskC456_g252041 , Out_MaskD456_g252041 , Out_MaskE456_g252041 , Out_MaskF456_g252041 , Out_MaskG456_g252041 , Out_MaskH456_g252041 , Out_MaskI456_g252041 , Out_MaskJ456_g252041 , Out_MaskK456_g252041 , Out_MaskL456_g252041 , Out_MaskM456_g252041 , Out_MaskN456_g252041 );
					half2 UV276_g252041 = (Out_MaskA456_g252041).xy;
					float temp_output_504_0_g252041 = 0.0;
					half Bias276_g252041 = temp_output_504_0_g252041;
					half2 Normal276_g252041 = float2( 0,0 );
					half4 localSampleCoord276_g252041 = SampleCoord( Texture276_g252041 , Sampler276_g252041 , UV276_g252041 , Bias276_g252041 , Normal276_g252041 );
					float4 temp_output_405_277_g252033 = localSampleCoord276_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252041) = _MainShaderTex;
					SamplerState Sampler502_g252041 = staticSwitch38_g252040;
					half2 UV502_g252041 = (Out_MaskA456_g252041).zw;
					half Bias502_g252041 = temp_output_504_0_g252041;
					half2 Normal502_g252041 = float2( 0,0 );
					half4 localSampleCoord502_g252041 = SampleCoord( Texture502_g252041 , Sampler502_g252041 , UV502_g252041 , Bias502_g252041 , Normal502_g252041 );
					float4 temp_output_405_278_g252033 = localSampleCoord502_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252041) = _MainShaderTex;
					SamplerState Sampler496_g252041 = staticSwitch38_g252040;
					float2 temp_output_463_0_g252041 = (Out_MaskB456_g252041).zw;
					half2 XZ496_g252041 = temp_output_463_0_g252041;
					half Bias496_g252041 = temp_output_504_0_g252041;
					half3 NormalWS512_g252041 = (Out_MaskK456_g252041).xyz;
					half3 NormalWS496_g252041 = NormalWS512_g252041;
					half3 Normal496_g252041 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252041 = SamplePlanar2D( Texture496_g252041 , Sampler496_g252041 , XZ496_g252041 , Bias496_g252041 , NormalWS496_g252041 , Normal496_g252041 );
					float4 temp_output_405_0_g252033 = localSamplePlanar2D496_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252041) = _MainShaderTex;
					SamplerState Sampler490_g252041 = staticSwitch38_g252040;
					float2 temp_output_462_0_g252041 = (Out_MaskB456_g252041).xy;
					half2 ZY490_g252041 = temp_output_462_0_g252041;
					half2 XZ490_g252041 = temp_output_463_0_g252041;
					float2 temp_output_464_0_g252041 = (Out_MaskC456_g252041).xy;
					half2 XY490_g252041 = temp_output_464_0_g252041;
					half Bias490_g252041 = temp_output_504_0_g252041;
					half3 Triplanar522_g252041 = (Out_MaskN456_g252041).xyz;
					half3 Triplanar490_g252041 = Triplanar522_g252041;
					half3 NormalWS490_g252041 = NormalWS512_g252041;
					half3 Normal490_g252041 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252041 = SamplePlanar3D( Texture490_g252041 , Sampler490_g252041 , ZY490_g252041 , XZ490_g252041 , XY490_g252041 , Bias490_g252041 , Triplanar490_g252041 , NormalWS490_g252041 , Normal490_g252041 );
					float4 temp_output_405_201_g252033 = localSamplePlanar3D490_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252041) = _MainShaderTex;
					SamplerState Sampler498_g252041 = staticSwitch38_g252040;
					half2 XZ498_g252041 = temp_output_463_0_g252041;
					float2 temp_output_473_0_g252041 = (Out_MaskE456_g252041).xy;
					half2 XZ_1498_g252041 = temp_output_473_0_g252041;
					float2 temp_output_474_0_g252041 = (Out_MaskE456_g252041).zw;
					half2 XZ_2498_g252041 = temp_output_474_0_g252041;
					float2 temp_output_475_0_g252041 = (Out_MaskF456_g252041).xy;
					half2 XZ_3498_g252041 = temp_output_475_0_g252041;
					float temp_output_510_0_g252041 = exp2( temp_output_504_0_g252041 );
					half Bias498_g252041 = temp_output_510_0_g252041;
					float3 temp_output_480_0_g252041 = (Out_MaskI456_g252041).xyz;
					half3 Weights_2498_g252041 = temp_output_480_0_g252041;
					half3 NormalWS498_g252041 = NormalWS512_g252041;
					half3 Normal498_g252041 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252041 = SampleStochastic2D( Texture498_g252041 , Sampler498_g252041 , XZ498_g252041 , XZ_1498_g252041 , XZ_2498_g252041 , XZ_3498_g252041 , Bias498_g252041 , Weights_2498_g252041 , NormalWS498_g252041 , Normal498_g252041 );
					float4 temp_output_405_202_g252033 = localSampleStochastic2D498_g252041;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252041) = _MainShaderTex;
					SamplerState Sampler500_g252041 = staticSwitch38_g252040;
					half2 ZY500_g252041 = temp_output_462_0_g252041;
					half2 ZY_1500_g252041 = (Out_MaskC456_g252041).zw;
					half2 ZY_2500_g252041 = (Out_MaskD456_g252041).xy;
					half2 ZY_3500_g252041 = (Out_MaskD456_g252041).zw;
					half2 XZ500_g252041 = temp_output_463_0_g252041;
					half2 XZ_1500_g252041 = temp_output_473_0_g252041;
					half2 XZ_2500_g252041 = temp_output_474_0_g252041;
					half2 XZ_3500_g252041 = temp_output_475_0_g252041;
					half2 XY500_g252041 = temp_output_464_0_g252041;
					half2 XY_1500_g252041 = (Out_MaskF456_g252041).zw;
					half2 XY_2500_g252041 = (Out_MaskG456_g252041).xy;
					half2 XY_3500_g252041 = (Out_MaskG456_g252041).zw;
					half Bias500_g252041 = temp_output_510_0_g252041;
					half3 Weights_1500_g252041 = (Out_MaskH456_g252041).xyz;
					half3 Weights_2500_g252041 = temp_output_480_0_g252041;
					half3 Weights_3500_g252041 = (Out_MaskJ456_g252041).xyz;
					half3 Triplanar500_g252041 = Triplanar522_g252041;
					half3 NormalWS500_g252041 = NormalWS512_g252041;
					half3 Normal500_g252041 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252041 = SampleStochastic3D( Texture500_g252041 , Sampler500_g252041 , ZY500_g252041 , ZY_1500_g252041 , ZY_2500_g252041 , ZY_3500_g252041 , XZ500_g252041 , XZ_1500_g252041 , XZ_2500_g252041 , XZ_3500_g252041 , XY500_g252041 , XY_1500_g252041 , XY_2500_g252041 , XY_3500_g252041 , Bias500_g252041 , Weights_1500_g252041 , Weights_2500_g252041 , Weights_3500_g252041 , Triplanar500_g252041 , NormalWS500_g252041 , Normal500_g252041 );
					float4 temp_output_405_203_g252033 = localSampleStochastic3D500_g252041;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g252033 = temp_output_405_277_g252033;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g252033 = temp_output_405_278_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g252033 = temp_output_405_0_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g252033 = temp_output_405_201_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g252033 = temp_output_405_202_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g252033 = temp_output_405_203_g252033;
					#else
					float4 staticSwitch198_g252033 = temp_output_405_277_g252033;
					#endif
					half4 Local_ShaderSample199_g252033 = staticSwitch198_g252033;
					float2 appendResult428_g252033 = (float2((Local_AlbedoSample185_g252033).w , (Local_ShaderSample199_g252033).z));
					float2 temp_output_85_0_g252053 = appendResult428_g252033;
					float4 ChannelB91_g252053 = float4( temp_output_85_0_g252053, 0.0 , 0.0 );
					float localSwitchChannel691_g252053 = SwitchChannel6( Option91_g252053 , ChannelA91_g252053 , ChannelB91_g252053 );
					float clampResult17_g252051 = clamp( localSwitchChannel691_g252053 , 0.0001 , 0.9999 );
					float temp_output_7_0_g252052 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g252052 = ( clampResult17_g252051 - temp_output_7_0_g252052 );
					half Local_MultiMask78_g252033 = saturate( ( temp_output_9_0_g252052 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g252033 = lerp( 1.0 , Local_MultiMask78_g252033 , _MainColorMode);
					float4 lerpResult62_g252033 = lerp( _MainColorTwo , _MainColor , lerpResult58_g252033);
					half3 Local_ColorRGB93_g252033 = (lerpResult62_g252033).rgb;
					half3 Local_Albedo139_g252033 = ( Local_AlbedoRGB107_g252033 * Local_ColorRGB93_g252033 );
					float3 temp_output_4_0_g252035 = Local_Albedo139_g252033;
					float3 In_Albedo3_g252035 = temp_output_4_0_g252035;
					float3 temp_output_44_0_g252035 = Local_Albedo139_g252033;
					float3 In_AlbedoBase3_g252035 = temp_output_44_0_g252035;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252062) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g252039 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g252039 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252062 = staticSwitch37_g252039;
					float localBreakTextureData456_g252062 = ( 0.0 );
					TVEMasksData Data456_g252062 =(TVEMasksData)Data431_g252055;
					float4 Out_MaskA456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252062 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252062 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252062 , Out_MaskA456_g252062 , Out_MaskB456_g252062 , Out_MaskC456_g252062 , Out_MaskD456_g252062 , Out_MaskE456_g252062 , Out_MaskF456_g252062 , Out_MaskG456_g252062 , Out_MaskH456_g252062 , Out_MaskI456_g252062 , Out_MaskJ456_g252062 , Out_MaskK456_g252062 , Out_MaskL456_g252062 , Out_MaskM456_g252062 , Out_MaskN456_g252062 );
					half2 UV276_g252062 = (Out_MaskA456_g252062).xy;
					float temp_output_504_0_g252062 = 0.0;
					half Bias276_g252062 = temp_output_504_0_g252062;
					half2 Normal276_g252062 = float2( 0,0 );
					half4 localSampleCoord276_g252062 = SampleCoord( Texture276_g252062 , Sampler276_g252062 , UV276_g252062 , Bias276_g252062 , Normal276_g252062 );
					float2 temp_output_406_394_g252033 = Normal276_g252062;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252062) = _MainNormalTex;
					SamplerState Sampler502_g252062 = staticSwitch37_g252039;
					half2 UV502_g252062 = (Out_MaskA456_g252062).zw;
					half Bias502_g252062 = temp_output_504_0_g252062;
					half2 Normal502_g252062 = float2( 0,0 );
					half4 localSampleCoord502_g252062 = SampleCoord( Texture502_g252062 , Sampler502_g252062 , UV502_g252062 , Bias502_g252062 , Normal502_g252062 );
					float2 temp_output_406_397_g252033 = Normal502_g252062;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252062) = _MainNormalTex;
					SamplerState Sampler496_g252062 = staticSwitch37_g252039;
					float2 temp_output_463_0_g252062 = (Out_MaskB456_g252062).zw;
					half2 XZ496_g252062 = temp_output_463_0_g252062;
					half Bias496_g252062 = temp_output_504_0_g252062;
					half3 NormalWS512_g252062 = (Out_MaskK456_g252062).xyz;
					half3 NormalWS496_g252062 = NormalWS512_g252062;
					half3 Normal496_g252062 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252062 = SamplePlanar2D( Texture496_g252062 , Sampler496_g252062 , XZ496_g252062 , Bias496_g252062 , NormalWS496_g252062 , Normal496_g252062 );
					float3 temp_output_35_0_g252065 = Normal496_g252062;
					half3 TangentWS519_g252062 = (Out_MaskL456_g252062).xyz;
					float dotResult84_g252065 = dot( temp_output_35_0_g252065 , TangentWS519_g252062 );
					half3 BitangentWS521_g252062 = (Out_MaskM456_g252062).xyz;
					float dotResult85_g252065 = dot( temp_output_35_0_g252065 , BitangentWS521_g252062 );
					float2 appendResult87_g252065 = (float2(dotResult84_g252065 , dotResult85_g252065));
					float2 temp_output_406_375_g252033 = appendResult87_g252065;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252062) = _MainNormalTex;
					SamplerState Sampler490_g252062 = staticSwitch37_g252039;
					float2 temp_output_462_0_g252062 = (Out_MaskB456_g252062).xy;
					half2 ZY490_g252062 = temp_output_462_0_g252062;
					half2 XZ490_g252062 = temp_output_463_0_g252062;
					float2 temp_output_464_0_g252062 = (Out_MaskC456_g252062).xy;
					half2 XY490_g252062 = temp_output_464_0_g252062;
					half Bias490_g252062 = temp_output_504_0_g252062;
					half3 Triplanar522_g252062 = (Out_MaskN456_g252062).xyz;
					half3 Triplanar490_g252062 = Triplanar522_g252062;
					half3 NormalWS490_g252062 = NormalWS512_g252062;
					half3 Normal490_g252062 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252062 = SamplePlanar3D( Texture490_g252062 , Sampler490_g252062 , ZY490_g252062 , XZ490_g252062 , XY490_g252062 , Bias490_g252062 , Triplanar490_g252062 , NormalWS490_g252062 , Normal490_g252062 );
					float3 temp_output_35_0_g252066 = Normal490_g252062;
					float dotResult84_g252066 = dot( temp_output_35_0_g252066 , TangentWS519_g252062 );
					float dotResult85_g252066 = dot( temp_output_35_0_g252066 , BitangentWS521_g252062 );
					float2 appendResult87_g252066 = (float2(dotResult84_g252066 , dotResult85_g252066));
					float2 temp_output_406_353_g252033 = appendResult87_g252066;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252062) = _MainNormalTex;
					SamplerState Sampler498_g252062 = staticSwitch37_g252039;
					half2 XZ498_g252062 = temp_output_463_0_g252062;
					float2 temp_output_473_0_g252062 = (Out_MaskE456_g252062).xy;
					half2 XZ_1498_g252062 = temp_output_473_0_g252062;
					float2 temp_output_474_0_g252062 = (Out_MaskE456_g252062).zw;
					half2 XZ_2498_g252062 = temp_output_474_0_g252062;
					float2 temp_output_475_0_g252062 = (Out_MaskF456_g252062).xy;
					half2 XZ_3498_g252062 = temp_output_475_0_g252062;
					float temp_output_510_0_g252062 = exp2( temp_output_504_0_g252062 );
					half Bias498_g252062 = temp_output_510_0_g252062;
					float3 temp_output_480_0_g252062 = (Out_MaskI456_g252062).xyz;
					half3 Weights_2498_g252062 = temp_output_480_0_g252062;
					half3 NormalWS498_g252062 = NormalWS512_g252062;
					half3 Normal498_g252062 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252062 = SampleStochastic2D( Texture498_g252062 , Sampler498_g252062 , XZ498_g252062 , XZ_1498_g252062 , XZ_2498_g252062 , XZ_3498_g252062 , Bias498_g252062 , Weights_2498_g252062 , NormalWS498_g252062 , Normal498_g252062 );
					float3 temp_output_35_0_g252067 = Normal498_g252062;
					float dotResult84_g252067 = dot( temp_output_35_0_g252067 , TangentWS519_g252062 );
					float dotResult85_g252067 = dot( temp_output_35_0_g252067 , BitangentWS521_g252062 );
					float2 appendResult87_g252067 = (float2(dotResult84_g252067 , dotResult85_g252067));
					float2 temp_output_406_391_g252033 = appendResult87_g252067;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252062) = _MainNormalTex;
					SamplerState Sampler500_g252062 = staticSwitch37_g252039;
					half2 ZY500_g252062 = temp_output_462_0_g252062;
					half2 ZY_1500_g252062 = (Out_MaskC456_g252062).zw;
					half2 ZY_2500_g252062 = (Out_MaskD456_g252062).xy;
					half2 ZY_3500_g252062 = (Out_MaskD456_g252062).zw;
					half2 XZ500_g252062 = temp_output_463_0_g252062;
					half2 XZ_1500_g252062 = temp_output_473_0_g252062;
					half2 XZ_2500_g252062 = temp_output_474_0_g252062;
					half2 XZ_3500_g252062 = temp_output_475_0_g252062;
					half2 XY500_g252062 = temp_output_464_0_g252062;
					half2 XY_1500_g252062 = (Out_MaskF456_g252062).zw;
					half2 XY_2500_g252062 = (Out_MaskG456_g252062).xy;
					half2 XY_3500_g252062 = (Out_MaskG456_g252062).zw;
					half Bias500_g252062 = temp_output_510_0_g252062;
					half3 Weights_1500_g252062 = (Out_MaskH456_g252062).xyz;
					half3 Weights_2500_g252062 = temp_output_480_0_g252062;
					half3 Weights_3500_g252062 = (Out_MaskJ456_g252062).xyz;
					half3 Triplanar500_g252062 = Triplanar522_g252062;
					half3 NormalWS500_g252062 = NormalWS512_g252062;
					half3 Normal500_g252062 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252062 = SampleStochastic3D( Texture500_g252062 , Sampler500_g252062 , ZY500_g252062 , ZY_1500_g252062 , ZY_2500_g252062 , ZY_3500_g252062 , XZ500_g252062 , XZ_1500_g252062 , XZ_2500_g252062 , XZ_3500_g252062 , XY500_g252062 , XY_1500_g252062 , XY_2500_g252062 , XY_3500_g252062 , Bias500_g252062 , Weights_1500_g252062 , Weights_2500_g252062 , Weights_3500_g252062 , Triplanar500_g252062 , NormalWS500_g252062 , Normal500_g252062 );
					float3 temp_output_35_0_g252063 = Normal500_g252062;
					float dotResult84_g252063 = dot( temp_output_35_0_g252063 , TangentWS519_g252062 );
					float dotResult85_g252063 = dot( temp_output_35_0_g252063 , BitangentWS521_g252062 );
					float2 appendResult87_g252063 = (float2(dotResult84_g252063 , dotResult85_g252063));
					float2 temp_output_406_390_g252033 = appendResult87_g252063;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g252033 = temp_output_406_394_g252033;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g252033 = temp_output_406_397_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g252033 = temp_output_406_375_g252033;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g252033 = temp_output_406_353_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g252033 = temp_output_406_391_g252033;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g252033 = temp_output_406_390_g252033;
					#else
					float2 staticSwitch193_g252033 = temp_output_406_394_g252033;
					#endif
					half2 Local_NormaSample191_g252033 = staticSwitch193_g252033;
					half2 Local_NormalTS108_g252033 = ( Local_NormaSample191_g252033 * _MainNormalValue );
					float2 In_NormalTS3_g252035 = Local_NormalTS108_g252033;
					float2 break80_g252054 = Local_NormalTS108_g252033;
					float3 temp_output_77_0_g252054 = Model_TangentWS366_g252033;
					float3 temp_output_78_0_g252054 = Model_BitangentWS367_g252033;
					float3 temp_output_76_0_g252054 = Model_NormalWS226_g252033;
					half3 Local_NormalWS250_g252033 = ( ( break80_g252054.x * temp_output_77_0_g252054 ) + ( break80_g252054.y * temp_output_78_0_g252054 ) + temp_output_76_0_g252054 );
					float3 In_NormalWS3_g252035 = Local_NormalWS250_g252033;
					float temp_output_209_0_g252033 = (Local_ShaderSample199_g252033).y;
					float temp_output_7_0_g252047 = _MainOcclusionRemap.x;
					float temp_output_9_0_g252047 = ( temp_output_209_0_g252033 - temp_output_7_0_g252047 );
					float lerpResult23_g252033 = lerp( 1.0 , saturate( ( temp_output_9_0_g252047 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g252033 = lerpResult23_g252033;
					float temp_output_213_0_g252033 = (Local_ShaderSample199_g252033).w;
					float temp_output_7_0_g252050 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g252050 = ( temp_output_213_0_g252033 - temp_output_7_0_g252050 );
					half Local_Smoothness317_g252033 = ( saturate( ( temp_output_9_0_g252050 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g252033 = (float4(( (Local_ShaderSample199_g252033).x * _MainMetallicValue ) , Local_Occlusion313_g252033 , (Local_ShaderSample199_g252033).z , Local_Smoothness317_g252033));
					half4 Local_Masks109_g252033 = appendResult73_g252033;
					float4 In_Shader3_g252035 = Local_Masks109_g252033;
					float4 In_Feature3_g252035 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252035 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252035 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g252068 = Local_Albedo139_g252033;
					float dotResult20_g252068 = dot( temp_output_3_0_g252068 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g252033 = dotResult20_g252068;
					float temp_output_12_0_g252035 = Local_Grayscale110_g252033;
					float In_Grayscale3_g252035 = temp_output_12_0_g252035;
					float temp_output_3_0_g252069 = Local_Grayscale110_g252033;
					float clampResult27_g252069 = clamp( saturate( ( temp_output_3_0_g252069 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g252033 = clampResult27_g252069;
					float temp_output_16_0_g252035 = Local_Luminosity145_g252033;
					float In_Luminosity3_g252035 = temp_output_16_0_g252035;
					float In_MultiMask3_g252035 = Local_MultiMask78_g252033;
					float temp_output_187_0_g252033 = (Local_AlbedoSample185_g252033).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g252033 = ( temp_output_187_0_g252033 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g252033 = temp_output_187_0_g252033;
					#endif
					half Local_AlphaClip111_g252033 = staticSwitch236_g252033;
					float In_AlphaClip3_g252035 = Local_AlphaClip111_g252033;
					half Local_AlphaFade246_g252033 = (lerpResult62_g252033).a;
					float In_AlphaFade3_g252035 = Local_AlphaFade246_g252033;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g252035 = temp_cast_24;
					float In_Transmission3_g252035 = 1.0;
					float In_Thickness3_g252035 = 0.0;
					float In_Diffusion3_g252035 = 0.0;
					float In_Depth3_g252035 = 0.0;
					BuildVisualData( Data3_g252035 , In_Dummy3_g252035 , In_Albedo3_g252035 , In_AlbedoBase3_g252035 , In_NormalTS3_g252035 , In_NormalWS3_g252035 , In_Shader3_g252035 , In_Feature3_g252035 , In_Season3_g252035 , In_Emissive3_g252035 , In_Grayscale3_g252035 , In_Luminosity3_g252035 , In_MultiMask3_g252035 , In_AlphaClip3_g252035 , In_AlphaFade3_g252035 , In_Translucency3_g252035 , In_Transmission3_g252035 , In_Thickness3_g252035 , In_Diffusion3_g252035 , In_Depth3_g252035 );
					TVEVisualData Data4_g252146 =(TVEVisualData)Data3_g252035;
					float Out_Dummy4_g252146 = 0.0;
					float3 Out_Albedo4_g252146 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252146 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252146 = float2( 0,0 );
					float3 Out_NormalWS4_g252146 = float3( 0,0,0 );
					float4 Out_Shader4_g252146 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252146 = float4( 0,0,0,0 );
					float4 Out_Season4_g252146 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252146 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252146 = 0.0;
					float Out_Grayscale4_g252146 = 0.0;
					float Out_Luminosity4_g252146 = 0.0;
					float Out_AlphaClip4_g252146 = 0.0;
					float Out_AlphaFade4_g252146 = 0.0;
					float3 Out_Translucency4_g252146 = float3( 0,0,0 );
					float Out_Transmission4_g252146 = 0.0;
					float Out_Thickness4_g252146 = 0.0;
					float Out_Diffusion4_g252146 = 0.0;
					float Out_Depth4_g252146 = 0.0;
					BreakVisualData( Data4_g252146 , Out_Dummy4_g252146 , Out_Albedo4_g252146 , Out_AlbedoBase4_g252146 , Out_NormalTS4_g252146 , Out_NormalWS4_g252146 , Out_Shader4_g252146 , Out_Feature4_g252146 , Out_Season4_g252146 , Out_Emissive4_g252146 , Out_MultiMask4_g252146 , Out_Grayscale4_g252146 , Out_Luminosity4_g252146 , Out_AlphaClip4_g252146 , Out_AlphaFade4_g252146 , Out_Translucency4_g252146 , Out_Transmission4_g252146 , Out_Thickness4_g252146 , Out_Diffusion4_g252146 , Out_Depth4_g252146 );
					float temp_output_739_15_g252072 = Out_Luminosity4_g252146;
					half Visual_Luminosity654_g252072 = temp_output_739_15_g252072;
					float temp_output_7_0_g252077 = _OverlayLumaRemap.x;
					float temp_output_9_0_g252077 = ( Visual_Luminosity654_g252072 - temp_output_7_0_g252077 );
					float lerpResult587_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g252077 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g252072 = lerpResult587_g252072;
					half4 Visual_Shader536_g252072 = Out_Shader4_g252146;
					float temp_output_7_0_g254255 = _OverlayBaseRemap.x;
					float temp_output_9_0_g254255 = ( (Visual_Shader536_g252072).z - temp_output_7_0_g254255 );
					float lerpResult1193_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g254255 * _OverlayBaseRemap.z ) ) , _OverlayBaseValue);
					half Blend_BaseMask1196_g252072 = lerpResult1193_g252072;
					float3 temp_output_739_21_g252072 = Out_NormalWS4_g252146;
					half3 Visual_NormalWS749_g252072 = temp_output_739_21_g252072;
					float temp_output_505_0_g252072 = saturate( (Visual_NormalWS749_g252072).y );
					float temp_output_7_0_g252142 = _OverlayProjRemap.x;
					float temp_output_9_0_g252142 = ( temp_output_505_0_g252072 - temp_output_7_0_g252142 );
					float lerpResult842_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g252142 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g252072 = lerpResult842_g252072;
					half Blend_NoiseMask427_g252072 = 1.0;
					half Blend_UserMask646_g252072 = 1.0;
					float temp_output_17_0_g252144 = _OverlayMeshMode;
					float Option70_g252144 = temp_output_17_0_g252144;
					TVEModelData Data15_g252121 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g252121 = 0.0;
					float3 Out_PositionWS15_g252121 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252121 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252121 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252121 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252121 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252121 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252121 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252121 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252121 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252121 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252121 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252121 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252121 , Out_Dummy15_g252121 , Out_PositionWS15_g252121 , Out_PositionWO15_g252121 , Out_PivotWS15_g252121 , Out_PivotWO15_g252121 , Out_NormalWS15_g252121 , Out_TangentWS15_g252121 , Out_BitangentWS15_g252121 , Out_TriplanarWeights15_g252121 , Out_ViewDirWS15_g252121 , Out_CoordsData15_g252121 , Out_VertexData15_g252121 , Out_Interpolator15_g252121 );
					half4 Model_VertexData791_g252072 = Out_VertexData15_g252121;
					float4 temp_output_3_0_g252144 = Model_VertexData791_g252072;
					float4 Channel70_g252144 = temp_output_3_0_g252144;
					float localSwitchChannel470_g252144 = SwitchChannel4( Option70_g252144 , Channel70_g252144 );
					float temp_output_1142_0_g252072 = localSwitchChannel470_g252144;
					float temp_output_7_0_g252140 = _OverlayMeshRemap.x;
					float temp_output_9_0_g252140 = ( temp_output_1142_0_g252072 - temp_output_7_0_g252140 );
					float lerpResult881_g252072 = lerp( 1.0 , saturate( ( temp_output_9_0_g252140 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g252072 = lerpResult881_g252072;
					half Blend_FormMask_Mul958_g252072 = 1.0;
					half Blend_FormMask_Add957_g252072 = 0.0;
					float temp_output_64_0_g254252 = saturate( ( ( Blend_TexMask908_g252072 * Blend_LumaMask438_g252072 * Blend_BaseMask1196_g252072 * Blend_ProjMask457_g252072 * Blend_NoiseMask427_g252072 * Blend_UserMask646_g252072 * Blend_VertMask801_g252072 * Blend_FormMask_Mul958_g252072 ) + Blend_FormMask_Add957_g252072 ) );
					half Blend_GlobalMask429_g252072 = 1.0;
					float temp_output_92_0_g254252 = ( Feature_Intensity1107_g252072 * Blend_GlobalMask429_g252072 );
					half Multiply93_g254252 = ( temp_output_64_0_g254252 * temp_output_92_0_g254252 );
					half Subtract93_g254252 = saturate( ( temp_output_92_0_g254252 - ( 1.0 - temp_output_64_0_g254252 ) ) );
					half Option93_g254252 = _OverlayBlendMath;
					half localSwitchBlendMask93_g254252 = SwitchBlendMask( Multiply93_g254252 , Subtract93_g254252 , Option93_g254252 );
					float temp_output_7_0_g254251 = _OverlayBlendRemap.x;
					float temp_output_9_0_g254251 = ( localSwitchBlendMask93_g254252 - temp_output_7_0_g254251 );
					half Blend_Mask494_g252072 = saturate( ( temp_output_9_0_g254251 * _OverlayBlendRemap.z ) );
					float4 appendResult993_g252072 = (float4(Blend_Mask494_g252072 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_25 = (0.0).xxxx;
					float4 temp_cast_26 = (0.0).xxxx;
					float4 ifLocalVar18_g252126 = 0;
					if( Feature_Intensity1107_g252072 <= 0.0 )
					ifLocalVar18_g252126 = temp_cast_26;
					else
					ifLocalVar18_g252126 = appendResult993_g252072;
					float4 In_MaskB3_g252127 = ifLocalVar18_g252126;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 In_MaskC3_g252127 = temp_cast_27;
					float4 temp_cast_28 = (0.0).xxxx;
					float4 In_MaskD3_g252127 = temp_cast_28;
					float4 temp_cast_29 = (0.0).xxxx;
					float4 In_MaskE3_g252127 = temp_cast_29;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 In_MaskF3_g252127 = temp_cast_30;
					float4 temp_cast_31 = (0.0).xxxx;
					float4 In_MaskG3_g252127 = temp_cast_31;
					float4 temp_cast_32 = (0.0).xxxx;
					float4 In_MaskH3_g252127 = temp_cast_32;
					float4 temp_cast_33 = (0.0).xxxx;
					float4 In_MaskI3_g252127 = temp_cast_33;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 In_MaskJ3_g252127 = temp_cast_34;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskK3_g252127 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskL3_g252127 = temp_cast_36;
					{
					Data3_g252127.MaskA = In_MaskA3_g252127;
					Data3_g252127.MaskB = In_MaskB3_g252127;
					Data3_g252127.MaskC = In_MaskC3_g252127;
					Data3_g252127.MaskD = In_MaskD3_g252127;
					Data3_g252127.MaskE = In_MaskE3_g252127;
					Data3_g252127.MaskF = In_MaskF3_g252127;
					Data3_g252127.MaskG = In_MaskG3_g252127;
					Data3_g252127.MaskH = In_MaskH3_g252127;
					Data3_g252127.MaskI = In_MaskI3_g252127;
					Data3_g252127.MaskJ= In_MaskJ3_g252127;
					Data3_g252127.MaskK= In_MaskK3_g252127;
					Data3_g252127.MaskL = In_MaskL3_g252127;
					}
					TVEMasksData DataA25_g254350 = Data3_g252127;
					float localBuildMasksData3_g254311 = ( 0.0 );
					TVEMasksData Data3_g254311 = (TVEMasksData)0;
					half Feature_Intensity1107_g254256 = _OverlayIntensityValue;
					float ifLocalVar18_g254307 = 0;
					if( Feature_Intensity1107_g254256 <= 0.0 )
					ifLocalVar18_g254307 = 0.0;
					else
					ifLocalVar18_g254307 = 1.0;
					half Feature_Maps1112_g254256 = _OverlayTextureMode;
					float ifLocalVar18_g254308 = 0;
					if( Feature_Maps1112_g254256 <= 0.0 )
					ifLocalVar18_g254308 = 0.0;
					else
					ifLocalVar18_g254308 = 1.0;
					half Feature_Glitter1108_g254256 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g254309 = 0;
					if( Feature_Glitter1108_g254256 <= 0.0 )
					ifLocalVar18_g254309 = 0.0;
					else
					ifLocalVar18_g254309 = 1.0;
					half Feature_Element1085_g254256 = _OverlayAtmoMode;
					float ifLocalVar18_g254306 = 0;
					if( Feature_Element1085_g254256 <= 0.0 )
					ifLocalVar18_g254306 = 0.0;
					else
					ifLocalVar18_g254306 = 1.0;
					float4 appendResult1117_g254256 = (float4(ifLocalVar18_g254307 , ifLocalVar18_g254308 , ifLocalVar18_g254309 , ifLocalVar18_g254306));
					float4 In_MaskA3_g254311 = appendResult1117_g254256;
					half Blend_TexMask908_g254256 = 1.0;
					float localBreakVisualData4_g254330 = ( 0.0 );
					TVEVisualData Data4_g254330 =(TVEVisualData)Data3_g252035;
					float Out_Dummy4_g254330 = 0.0;
					float3 Out_Albedo4_g254330 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254330 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254330 = float2( 0,0 );
					float3 Out_NormalWS4_g254330 = float3( 0,0,0 );
					float4 Out_Shader4_g254330 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254330 = float4( 0,0,0,0 );
					float4 Out_Season4_g254330 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254330 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254330 = 0.0;
					float Out_Grayscale4_g254330 = 0.0;
					float Out_Luminosity4_g254330 = 0.0;
					float Out_AlphaClip4_g254330 = 0.0;
					float Out_AlphaFade4_g254330 = 0.0;
					float3 Out_Translucency4_g254330 = float3( 0,0,0 );
					float Out_Transmission4_g254330 = 0.0;
					float Out_Thickness4_g254330 = 0.0;
					float Out_Diffusion4_g254330 = 0.0;
					float Out_Depth4_g254330 = 0.0;
					BreakVisualData( Data4_g254330 , Out_Dummy4_g254330 , Out_Albedo4_g254330 , Out_AlbedoBase4_g254330 , Out_NormalTS4_g254330 , Out_NormalWS4_g254330 , Out_Shader4_g254330 , Out_Feature4_g254330 , Out_Season4_g254330 , Out_Emissive4_g254330 , Out_MultiMask4_g254330 , Out_Grayscale4_g254330 , Out_Luminosity4_g254330 , Out_AlphaClip4_g254330 , Out_AlphaFade4_g254330 , Out_Translucency4_g254330 , Out_Transmission4_g254330 , Out_Thickness4_g254330 , Out_Diffusion4_g254330 , Out_Depth4_g254330 );
					float temp_output_739_15_g254256 = Out_Luminosity4_g254330;
					half Visual_Luminosity654_g254256 = temp_output_739_15_g254256;
					float temp_output_7_0_g254261 = _OverlayLumaRemap.x;
					float temp_output_9_0_g254261 = ( Visual_Luminosity654_g254256 - temp_output_7_0_g254261 );
					float lerpResult587_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254261 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g254256 = lerpResult587_g254256;
					half4 Visual_Shader536_g254256 = Out_Shader4_g254330;
					float temp_output_7_0_g254349 = _OverlayBaseRemap.x;
					float temp_output_9_0_g254349 = ( (Visual_Shader536_g254256).z - temp_output_7_0_g254349 );
					float lerpResult1193_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254349 * _OverlayBaseRemap.z ) ) , _OverlayBaseValue);
					half Blend_BaseMask1196_g254256 = lerpResult1193_g254256;
					float3 temp_output_739_21_g254256 = Out_NormalWS4_g254330;
					half3 Visual_NormalWS749_g254256 = temp_output_739_21_g254256;
					float temp_output_505_0_g254256 = saturate( (Visual_NormalWS749_g254256).y );
					float temp_output_7_0_g254326 = _OverlayProjRemap.x;
					float temp_output_9_0_g254326 = ( temp_output_505_0_g254256 - temp_output_7_0_g254326 );
					float lerpResult842_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254326 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g254256 = lerpResult842_g254256;
					half Blend_NoiseMask427_g254256 = 1.0;
					half Blend_UserMask646_g254256 = 1.0;
					float temp_output_17_0_g254328 = _OverlayMeshMode;
					float Option70_g254328 = temp_output_17_0_g254328;
					TVEModelData Data15_g254305 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g254305 = 0.0;
					float3 Out_PositionWS15_g254305 = float3( 0,0,0 );
					float3 Out_PositionWO15_g254305 = float3( 0,0,0 );
					float3 Out_PivotWS15_g254305 = float3( 0,0,0 );
					float3 Out_PivotWO15_g254305 = float3( 0,0,0 );
					float3 Out_NormalWS15_g254305 = float3( 0,0,0 );
					float3 Out_TangentWS15_g254305 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g254305 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g254305 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g254305 = float3( 0,0,0 );
					float4 Out_CoordsData15_g254305 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g254305 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254305 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g254305 , Out_Dummy15_g254305 , Out_PositionWS15_g254305 , Out_PositionWO15_g254305 , Out_PivotWS15_g254305 , Out_PivotWO15_g254305 , Out_NormalWS15_g254305 , Out_TangentWS15_g254305 , Out_BitangentWS15_g254305 , Out_TriplanarWeights15_g254305 , Out_ViewDirWS15_g254305 , Out_CoordsData15_g254305 , Out_VertexData15_g254305 , Out_Interpolator15_g254305 );
					half4 Model_VertexData791_g254256 = Out_VertexData15_g254305;
					float4 temp_output_3_0_g254328 = Model_VertexData791_g254256;
					float4 Channel70_g254328 = temp_output_3_0_g254328;
					float localSwitchChannel470_g254328 = SwitchChannel4( Option70_g254328 , Channel70_g254328 );
					float temp_output_1142_0_g254256 = localSwitchChannel470_g254328;
					float temp_output_7_0_g254324 = _OverlayMeshRemap.x;
					float temp_output_9_0_g254324 = ( temp_output_1142_0_g254256 - temp_output_7_0_g254324 );
					float lerpResult881_g254256 = lerp( 1.0 , saturate( ( temp_output_9_0_g254324 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g254256 = lerpResult881_g254256;
					half Blend_FormMask_Mul958_g254256 = 1.0;
					half Blend_FormMask_Add957_g254256 = 0.0;
					float temp_output_64_0_g254346 = saturate( ( ( Blend_TexMask908_g254256 * Blend_LumaMask438_g254256 * Blend_BaseMask1196_g254256 * Blend_ProjMask457_g254256 * Blend_NoiseMask427_g254256 * Blend_UserMask646_g254256 * Blend_VertMask801_g254256 * Blend_FormMask_Mul958_g254256 ) + Blend_FormMask_Add957_g254256 ) );
					float temp_output_1146_0_g254256 = (TVE_AtmoParams).y;
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
					TVEGlobalData Data15_g254257 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g254257 = 0.0;
					float4 Out_CoatTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g254257 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g254257 = float4( 0,0,0,0 );
					BreakData( Data15_g254257 , Out_Dummy15_g254257 , Out_CoatTexture15_g254257 , Out_DrawTexture15_g254257 , Out_PaintTexture15_g254257 , Out_AtmoTexture15_g254257 , Out_EffexTexture15_g254257 , Out_GlowTexture15_g254257 , Out_FormTexture15_g254257 , Out_LandTexture15_g254257 , Out_VertxTexture15_g254257 , Out_FlowTexture15_g254257 , Out_UserTexture15_g254257 );
					half4 Global_AtmoTexture516_g254256 = Out_AtmoTexture15_g254257;
					float temp_output_6_0_g254279 = (Global_AtmoTexture516_g254256).y;
					float temp_output_7_0_g254279 = _OverlayAtmoMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g254279 = ( temp_output_6_0_g254279 + temp_output_7_0_g254279 );
					#else
					float staticSwitch14_g254279 = temp_output_6_0_g254279;
					#endif
					float temp_output_939_0_g254256 = staticSwitch14_g254279;
					#ifdef TVE_OVERLAY_ATMO
					float staticSwitch705_g254256 = temp_output_939_0_g254256;
					#else
					float staticSwitch705_g254256 = temp_output_1146_0_g254256;
					#endif
					float lerpResult937_g254256 = lerp( 1.0 , ( staticSwitch705_g254256 * TVE_IsEnabled ) , _OverlayAtmoValue);
					half Blend_GlobalMask429_g254256 = lerpResult937_g254256;
					float temp_output_92_0_g254346 = ( Feature_Intensity1107_g254256 * Blend_GlobalMask429_g254256 );
					half Multiply93_g254346 = ( temp_output_64_0_g254346 * temp_output_92_0_g254346 );
					half Subtract93_g254346 = saturate( ( temp_output_92_0_g254346 - ( 1.0 - temp_output_64_0_g254346 ) ) );
					half Option93_g254346 = _OverlayBlendMath;
					half localSwitchBlendMask93_g254346 = SwitchBlendMask( Multiply93_g254346 , Subtract93_g254346 , Option93_g254346 );
					float temp_output_7_0_g254345 = _OverlayBlendRemap.x;
					float temp_output_9_0_g254345 = ( localSwitchBlendMask93_g254346 - temp_output_7_0_g254345 );
					half Blend_Mask494_g254256 = saturate( ( temp_output_9_0_g254345 * _OverlayBlendRemap.z ) );
					float4 appendResult993_g254256 = (float4(Blend_Mask494_g254256 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_45 = (0.0).xxxx;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 ifLocalVar18_g254310 = 0;
					if( Feature_Intensity1107_g254256 <= 0.0 )
					ifLocalVar18_g254310 = temp_cast_46;
					else
					ifLocalVar18_g254310 = appendResult993_g254256;
					float4 In_MaskB3_g254311 = ifLocalVar18_g254310;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskC3_g254311 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskD3_g254311 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskE3_g254311 = temp_cast_49;
					float4 temp_cast_50 = (0.0).xxxx;
					float4 In_MaskF3_g254311 = temp_cast_50;
					float4 temp_cast_51 = (0.0).xxxx;
					float4 In_MaskG3_g254311 = temp_cast_51;
					float4 temp_cast_52 = (0.0).xxxx;
					float4 In_MaskH3_g254311 = temp_cast_52;
					float4 temp_cast_53 = (0.0).xxxx;
					float4 In_MaskI3_g254311 = temp_cast_53;
					float4 temp_cast_54 = (0.0).xxxx;
					float4 In_MaskJ3_g254311 = temp_cast_54;
					float4 temp_cast_55 = (0.0).xxxx;
					float4 In_MaskK3_g254311 = temp_cast_55;
					float4 temp_cast_56 = (0.0).xxxx;
					float4 In_MaskL3_g254311 = temp_cast_56;
					{
					Data3_g254311.MaskA = In_MaskA3_g254311;
					Data3_g254311.MaskB = In_MaskB3_g254311;
					Data3_g254311.MaskC = In_MaskC3_g254311;
					Data3_g254311.MaskD = In_MaskD3_g254311;
					Data3_g254311.MaskE = In_MaskE3_g254311;
					Data3_g254311.MaskF = In_MaskF3_g254311;
					Data3_g254311.MaskG = In_MaskG3_g254311;
					Data3_g254311.MaskH = In_MaskH3_g254311;
					Data3_g254311.MaskI = In_MaskI3_g254311;
					Data3_g254311.MaskJ= In_MaskJ3_g254311;
					Data3_g254311.MaskK= In_MaskK3_g254311;
					Data3_g254311.MaskL = In_MaskL3_g254311;
					}
					TVEMasksData DataB25_g254350 = Data3_g254311;
					float Alpha25_g254350 = TVE_DEBUG_Global;
					{
					if (Alpha25_g254350 < 0.5 )
					{
					Data25_g254350 = DataA25_g254350;
					}
					else
					{
					Data25_g254350 = DataB25_g254350;
					}
					}
					TVEMasksData Data4_g254351 = Data25_g254350;
					float4 Out_MaskA4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g254351 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g254351 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g254351 = Data4_g254351.MaskA;
					Out_MaskB4_g254351 = Data4_g254351.MaskB;
					Out_MaskC4_g254351 = Data4_g254351.MaskC;
					Out_MaskD4_g254351 = Data4_g254351.MaskD;
					Out_MaskE4_g254351 = Data4_g254351.MaskE;
					Out_MaskF4_g254351 = Data4_g254351.MaskF;
					Out_MaskG4_g254351 = Data4_g254351.MaskG;
					Out_MaskH4_g254351 = Data4_g254351.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g254351;
					float3 lerpResult2568 = lerp( color107_g254352 , color106_g254352 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g254360 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g254360 = lerpResult2568;
					float3 color107_g254354 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254354 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g254354 , color106_g254354 , (temp_output_2509_14).y);
					float3 ifLocalVar40_g254361 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g254361 = lerpResult2571;
					float3 color107_g254356 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254356 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2603 = lerp( color107_g254356 , color106_g254356 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g254362 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g254362 = lerpResult2603;
					float3 ifLocalVar40_g254364 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g254364 = (Out_MaskB4_g254351).xxx;
					float3 color107_g254358 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g254358 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g254358 , color106_g254358 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g254363 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g254363 = lerpResult2607;
					half3 Final_Debug2399 = ( ifLocalVar40_g254360 + ifLocalVar40_g254361 + ifLocalVar40_g254362 + ifLocalVar40_g254364 + ifLocalVar40_g254363 );
					float temp_output_7_0_g254373 = TVE_DEBUG_Min;
					float3 temp_cast_57 = (temp_output_7_0_g254373).xxx;
					float3 temp_output_9_0_g254373 = ( Final_Debug2399 - temp_cast_57 );
					float lerpResult76_g254366 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g254366 = lerpResult76_g254366;
					float3 lerpResult72_g254366 = lerp( (lerpResult73_g254367).rgb , saturate( ( temp_output_9_0_g254373 / ( ( TVE_DEBUG_Max - temp_output_7_0_g254373 ) + 0.0001 ) ) ) , Filter152_g254366);
					float dotResult61_g254366 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g254366 = ( 1.0 - saturate( dotResult61_g254366 ) );
					float Shading_Fresnel59_g254366 = (( 1.0 - ( temp_output_65_0_g254366 * temp_output_65_0_g254366 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g254366 = IN.ase_texcoord8;
					float depthLinearEye57_g254366 = LinearEyeDepth( ase_positionCS57_g254366.z / ase_positionCS57_g254366.w );
					float temp_output_69_0_g254366 = saturate(  (0.0 + ( depthLinearEye57_g254366 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g254366 = (( temp_output_69_0_g254366 * temp_output_69_0_g254366 )*0.5 + 0.5);
					float lerpResult84_g254366 = lerp( 1.0 , Shading_Fresnel59_g254366 , ( Shading_Distance58_g254366 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g254371 = ( 0.0 );
					TVEVisualData Data4_g254371 =(TVEVisualData)Data3_g252035;
					float Out_Dummy4_g254371 = 0.0;
					float3 Out_Albedo4_g254371 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g254371 = float3( 0,0,0 );
					float2 Out_NormalTS4_g254371 = float2( 0,0 );
					float3 Out_NormalWS4_g254371 = float3( 0,0,0 );
					float4 Out_Shader4_g254371 = float4( 0,0,0,0 );
					float4 Out_Feature4_g254371 = float4( 0,0,0,0 );
					float4 Out_Season4_g254371 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g254371 = float4( 0,0,0,0 );
					float Out_MultiMask4_g254371 = 0.0;
					float Out_Grayscale4_g254371 = 0.0;
					float Out_Luminosity4_g254371 = 0.0;
					float Out_AlphaClip4_g254371 = 0.0;
					float Out_AlphaFade4_g254371 = 0.0;
					float3 Out_Translucency4_g254371 = float3( 0,0,0 );
					float Out_Transmission4_g254371 = 0.0;
					float Out_Thickness4_g254371 = 0.0;
					float Out_Diffusion4_g254371 = 0.0;
					float Out_Depth4_g254371 = 0.0;
					BreakVisualData( Data4_g254371 , Out_Dummy4_g254371 , Out_Albedo4_g254371 , Out_AlbedoBase4_g254371 , Out_NormalTS4_g254371 , Out_NormalWS4_g254371 , Out_Shader4_g254371 , Out_Feature4_g254371 , Out_Season4_g254371 , Out_Emissive4_g254371 , Out_MultiMask4_g254371 , Out_Grayscale4_g254371 , Out_Luminosity4_g254371 , Out_AlphaClip4_g254371 , Out_AlphaFade4_g254371 , Out_Translucency4_g254371 , Out_Transmission4_g254371 , Out_Thickness4_g254371 , Out_Diffusion4_g254371 , Out_Depth4_g254371 );
					float Alpha109_g254366 = Out_AlphaClip4_g254371;
					float lerpResult91_g254366 = lerp( 1.0 , Alpha109_g254366 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g254366 = lerp( 1.0 , lerpResult91_g254366 , Filter152_g254366);
					clip( lerpResult154_g254366 );
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

					o.Emission = ( lerpResult72_g254366 * lerpResult84_g254366 );
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

					TVEVertexData Data16_g251752 =(TVEVertexData)0;
					float In_Dummy16_g251752 = 0.0;
					TVEVertexData Data16_g251747 =(TVEVertexData)0;
					float In_Dummy16_g251747 = 0.0;
					float localIfModelDataByShader26_g251547 = ( 0.0 );
					TVEModelData Data26_g251547 = (TVEModelData)0;
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
					TVEModelData DataDefault26_g251547 = Data16_g241434;
					TVEModelData DataGeneral26_g251547 = Data16_g241434;
					TVEModelData DataBlanket26_g251547 = Data16_g241434;
					TVEModelData DataImpostor26_g251547 = Data16_g241434;
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
					TVEModelData DataTerrain26_g251547 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251547 = IsShaderType2672;
					{
					if (Type26_g251547 == 0 )
					{
					Data26_g251547 = DataDefault26_g251547;
					}
					else if (Type26_g251547 == 1 )
					{
					Data26_g251547 = DataGeneral26_g251547;
					}
					else if (Type26_g251547 == 2 )
					{
					Data26_g251547 = DataBlanket26_g251547;
					}
					else if (Type26_g251547 == 3 )
					{
					Data26_g251547 = DataImpostor26_g251547;
					}
					else if (Type26_g251547 == 4 )
					{
					Data26_g251547 = DataTerrain26_g251547;
					}
					}
					TVEModelData Data15_g251748 =(TVEModelData)Data26_g251547;
					float Out_Dummy15_g251748 = 0.0;
					float3 Out_PositionOS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251748 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251748 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251748 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251748 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251748 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251748 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251748 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251748 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251748 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251748 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251748 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251748 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251748 , Out_Dummy15_g251748 , Out_PositionOS15_g251748 , Out_PositionWS15_g251748 , Out_PositionWO15_g251748 , Out_PositionRawOS15_g251748 , Out_PivotOS15_g251748 , Out_PivotWS15_g251748 , Out_PivotWO15_g251748 , Out_NormalOS15_g251748 , Out_NormalWS15_g251748 , Out_NormalRawOS15_g251748 , Out_TangentOS15_g251748 , Out_TangentWS15_g251748 , Out_BitangentWS15_g251748 , Out_ViewDirWS15_g251748 , Out_CoordsData15_g251748 , Out_VertexData15_g251748 , Out_MasksData15_g251748 , Out_PhaseData15_g251748 , Out_TransformData15_g251748 , Out_RotationData15_g251748 , Out_Interpolator15_g251748 );
					float3 In_PositionOS16_g251747 = Out_PositionOS15_g251748;
					float3 In_NormalOS16_g251747 = Out_NormalOS15_g251748;
					float4 In_TangentOS16_g251747 = Out_TangentOS15_g251748;
					float4 In_TransformData16_g251747 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251747 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251747 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251747 , In_Dummy16_g251747 , In_PositionOS16_g251747 , In_NormalOS16_g251747 , In_TangentOS16_g251747 , In_TransformData16_g251747 , In_RotationData16_g251747 , In_Interpolator16_g251747 );
					TVEVertexData Data15_g251750 =(TVEVertexData)Data16_g251747;
					float Out_Dummy15_g251750 = 0.0;
					float3 Out_PositionOS15_g251750 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251750 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251750 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251750 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251750 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251750 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251750 , Out_Dummy15_g251750 , Out_PositionOS15_g251750 , Out_NormalOS15_g251750 , Out_TangentOS15_g251750 , Out_TransformData15_g251750 , Out_RotationData15_g251750 , Out_Interpolator15_g251750 );
					TVEModelData Data15_g251751 =(TVEModelData)Data15_g251748;
					float Out_Dummy15_g251751 = 0.0;
					float3 Out_PositionOS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251751 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251751 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251751 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251751 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251751 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251751 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251751 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251751 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251751 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251751 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251751 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251751 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251751 , Out_Dummy15_g251751 , Out_PositionOS15_g251751 , Out_PositionWS15_g251751 , Out_PositionWO15_g251751 , Out_PositionRawOS15_g251751 , Out_PivotOS15_g251751 , Out_PivotWS15_g251751 , Out_PivotWO15_g251751 , Out_NormalOS15_g251751 , Out_NormalWS15_g251751 , Out_NormalRawOS15_g251751 , Out_TangentOS15_g251751 , Out_TangentWS15_g251751 , Out_BitangentWS15_g251751 , Out_ViewDirWS15_g251751 , Out_CoordsData15_g251751 , Out_VertexData15_g251751 , Out_MasksData15_g251751 , Out_PhaseData15_g251751 , Out_TransformData15_g251751 , Out_RotationData15_g251751 , Out_Interpolator15_g251751 );
					float3 In_PositionOS16_g251752 = ( Out_PositionOS15_g251750 - Out_PivotOS15_g251751 );
					float3 In_NormalOS16_g251752 = Out_NormalOS15_g251751;
					float4 In_TangentOS16_g251752 = Out_TangentOS15_g251751;
					float4 In_TransformData16_g251752 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251752 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251752 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251752 , In_Dummy16_g251752 , In_PositionOS16_g251752 , In_NormalOS16_g251752 , In_TangentOS16_g251752 , In_TransformData16_g251752 , In_RotationData16_g251752 , In_Interpolator16_g251752 );
					TVEVertexData Data15_g251761 =(TVEVertexData)Data16_g251752;
					float Out_Dummy15_g251761 = 0.0;
					float3 Out_PositionOS15_g251761 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251761 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251761 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251761 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251761 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251761 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251761 , Out_Dummy15_g251761 , Out_PositionOS15_g251761 , Out_NormalOS15_g251761 , Out_TangentOS15_g251761 , Out_TransformData15_g251761 , Out_RotationData15_g251761 , Out_Interpolator15_g251761 );
					TVEVertexData Data16_g251762 =(TVEVertexData)Data15_g251761;
					half Dummy317_g251753 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251762 = Dummy317_g251753;
					float3 In_PositionOS16_g251762 = Out_PositionOS15_g251761;
					float3 In_NormalOS16_g251762 = Out_NormalOS15_g251761;
					float4 In_TangentOS16_g251762 = Out_TangentOS15_g251761;
					half4 Model_TransformData356_g251753 = Out_TransformData15_g251761;
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
					TVEGlobalData Data15_g251763 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251763 = 0.0;
					float4 Out_CoatTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251763 = float4( 0,0,0,0 );
					BreakData( Data15_g251763 , Out_Dummy15_g251763 , Out_CoatTexture15_g251763 , Out_DrawTexture15_g251763 , Out_PaintTexture15_g251763 , Out_AtmoTexture15_g251763 , Out_EffexTexture15_g251763 , Out_GlowTexture15_g251763 , Out_FormTexture15_g251763 , Out_LandTexture15_g251763 , Out_VertxTexture15_g251763 , Out_FlowTexture15_g251763 , Out_UserTexture15_g251763 );
					float4 Global_FormTexture351_g251753 = Out_FormTexture15_g251763;
					TVEModelData Data15_g251760 =(TVEModelData)Data15_g251751;
					float Out_Dummy15_g251760 = 0.0;
					float3 Out_PositionOS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251760 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251760 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251760 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251760 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251760 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251760 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251760 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251760 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251760 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251760 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251760 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251760 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251760 , Out_Dummy15_g251760 , Out_PositionOS15_g251760 , Out_PositionWS15_g251760 , Out_PositionWO15_g251760 , Out_PositionRawOS15_g251760 , Out_PivotOS15_g251760 , Out_PivotWS15_g251760 , Out_PivotWO15_g251760 , Out_NormalOS15_g251760 , Out_NormalWS15_g251760 , Out_NormalRawOS15_g251760 , Out_TangentOS15_g251760 , Out_TangentWS15_g251760 , Out_BitangentWS15_g251760 , Out_ViewDirWS15_g251760 , Out_CoordsData15_g251760 , Out_VertexData15_g251760 , Out_MasksData15_g251760 , Out_PhaseData15_g251760 , Out_TransformData15_g251760 , Out_RotationData15_g251760 , Out_Interpolator15_g251760 );
					float3 Model_PivotWO353_g251753 = Out_PivotWO15_g251760;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251759 = _ConformMeshMode;
					float Option70_g251759 = temp_output_17_0_g251759;
					half4 Model_VertexData357_g251753 = Out_VertexData15_g251760;
					float4 temp_output_3_0_g251759 = Model_VertexData357_g251753;
					float4 Channel70_g251759 = temp_output_3_0_g251759;
					float localSwitchChannel470_g251759 = SwitchChannel4( Option70_g251759 , Channel70_g251759 );
					float temp_output_390_0_g251753 = localSwitchChannel470_g251759;
					float temp_output_7_0_g251756 = _ConformMeshRemap.x;
					float temp_output_9_0_g251756 = ( temp_output_390_0_g251753 - temp_output_7_0_g251756 );
					float lerpResult374_g251753 = lerp( 1.0 , saturate( ( temp_output_9_0_g251756 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251753 = lerpResult374_g251753;
					float temp_output_328_0_g251753 = ( Blend_VertMask379_g251753 * TVE_IsEnabled );
					half Conform_Mask366_g251753 = temp_output_328_0_g251753;
					float temp_output_322_0_g251753 = ( ( ( ( (Global_FormTexture351_g251753).z - ( (Model_PivotWO353_g251753).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251753 ) );
					float3 appendResult329_g251753 = (float3(0.0 , temp_output_322_0_g251753 , 0.0));
					float3 appendResult387_g251753 = (float3(0.0 , 0.0 , temp_output_322_0_g251753));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251757 = appendResult387_g251753;
					#else
					float3 staticSwitch65_g251757 = appendResult329_g251753;
					#endif
					float3 Blanket_Conform368_g251753 = staticSwitch65_g251757;
					float4 appendResult312_g251753 = (float4(Blanket_Conform368_g251753 , 0.0));
					float4 temp_output_310_0_g251753 = ( Model_TransformData356_g251753 + appendResult312_g251753 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251753 = temp_output_310_0_g251753;
					#else
					float4 staticSwitch364_g251753 = Model_TransformData356_g251753;
					#endif
					half4 Final_TransformData365_g251753 = staticSwitch364_g251753;
					float4 In_TransformData16_g251762 = Final_TransformData365_g251753;
					float4 In_RotationData16_g251762 = Out_RotationData15_g251761;
					float4 In_Interpolator16_g251762 = Out_Interpolator15_g251761;
					BuildVertexData( Data16_g251762 , In_Dummy16_g251762 , In_PositionOS16_g251762 , In_NormalOS16_g251762 , In_TangentOS16_g251762 , In_TransformData16_g251762 , In_RotationData16_g251762 , In_Interpolator16_g251762 );
					TVEVertexData Data15_g251773 =(TVEVertexData)Data16_g251762;
					float Out_Dummy15_g251773 = 0.0;
					float3 Out_PositionOS15_g251773 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251773 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251773 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251773 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251773 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251773 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251773 , Out_Dummy15_g251773 , Out_PositionOS15_g251773 , Out_NormalOS15_g251773 , Out_TangentOS15_g251773 , Out_TransformData15_g251773 , Out_RotationData15_g251773 , Out_Interpolator15_g251773 );
					TVEVertexData Data16_g251774 =(TVEVertexData)Data15_g251773;
					float In_Dummy16_g251774 = 0.0;
					float3 Vertex_PositionOS147_g251764 = Out_PositionOS15_g251773;
					half3 VertexPos40_g251768 = Vertex_PositionOS147_g251764;
					float4 temp_output_1615_33_g251764 = Out_RotationData15_g251773;
					half4 Vertex_RotationData1569_g251764 = temp_output_1615_33_g251764;
					float2 break1582_g251764 = (Vertex_RotationData1569_g251764).xy;
					half Angle44_g251768 = break1582_g251764.y;
					half CosAngle89_g251768 = cos( Angle44_g251768 );
					half SinAngle93_g251768 = sin( Angle44_g251768 );
					float3 appendResult95_g251768 = (float3((VertexPos40_g251768).x , ( ( (VertexPos40_g251768).y * CosAngle89_g251768 ) - ( (VertexPos40_g251768).z * SinAngle93_g251768 ) ) , ( ( (VertexPos40_g251768).y * SinAngle93_g251768 ) + ( (VertexPos40_g251768).z * CosAngle89_g251768 ) )));
					half3 VertexPos40_g251769 = appendResult95_g251768;
					half Angle44_g251769 = -break1582_g251764.x;
					half CosAngle94_g251769 = cos( Angle44_g251769 );
					half SinAngle95_g251769 = sin( Angle44_g251769 );
					float3 appendResult98_g251769 = (float3(( ( (VertexPos40_g251769).x * CosAngle94_g251769 ) - ( (VertexPos40_g251769).y * SinAngle95_g251769 ) ) , ( ( (VertexPos40_g251769).x * SinAngle95_g251769 ) + ( (VertexPos40_g251769).y * CosAngle94_g251769 ) ) , (VertexPos40_g251769).z));
					half3 VertexPos40_g251767 = Vertex_PositionOS147_g251764;
					half Angle44_g251767 = break1582_g251764.y;
					half CosAngle89_g251767 = cos( Angle44_g251767 );
					half SinAngle93_g251767 = sin( Angle44_g251767 );
					float3 appendResult95_g251767 = (float3((VertexPos40_g251767).x , ( ( (VertexPos40_g251767).y * CosAngle89_g251767 ) - ( (VertexPos40_g251767).z * SinAngle93_g251767 ) ) , ( ( (VertexPos40_g251767).y * SinAngle93_g251767 ) + ( (VertexPos40_g251767).z * CosAngle89_g251767 ) )));
					half3 VertexPos40_g251772 = appendResult95_g251767;
					half Angle44_g251772 = break1582_g251764.x;
					half CosAngle91_g251772 = cos( Angle44_g251772 );
					half SinAngle92_g251772 = sin( Angle44_g251772 );
					float3 appendResult93_g251772 = (float3(( ( (VertexPos40_g251772).x * CosAngle91_g251772 ) + ( (VertexPos40_g251772).z * SinAngle92_g251772 ) ) , (VertexPos40_g251772).y , ( ( -(VertexPos40_g251772).x * SinAngle92_g251772 ) + ( (VertexPos40_g251772).z * CosAngle91_g251772 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251770 = appendResult93_g251772;
					#else
					float3 staticSwitch65_g251770 = appendResult98_g251769;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251765 = staticSwitch65_g251770;
					#else
					float3 staticSwitch65_g251765 = Vertex_PositionOS147_g251764;
					#endif
					float3 temp_output_1608_0_g251764 = staticSwitch65_g251765;
					half3 VertexPos40_g251771 = temp_output_1608_0_g251764;
					half Angle44_g251771 = (Vertex_RotationData1569_g251764).z;
					half CosAngle91_g251771 = cos( Angle44_g251771 );
					half SinAngle92_g251771 = sin( Angle44_g251771 );
					float3 appendResult93_g251771 = (float3(( ( (VertexPos40_g251771).x * CosAngle91_g251771 ) + ( (VertexPos40_g251771).z * SinAngle92_g251771 ) ) , (VertexPos40_g251771).y , ( ( -(VertexPos40_g251771).x * SinAngle92_g251771 ) + ( (VertexPos40_g251771).z * CosAngle91_g251771 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251766 = appendResult93_g251771;
					#else
					float3 staticSwitch65_g251766 = temp_output_1608_0_g251764;
					#endif
					float4 temp_output_1615_31_g251764 = Out_TransformData15_g251773;
					half4 Vertex_TransformData1568_g251764 = temp_output_1615_31_g251764;
					half3 Final_PositionOS178_g251764 = ( ( staticSwitch65_g251766 * (Vertex_TransformData1568_g251764).w ) + (Vertex_TransformData1568_g251764).xyz );
					float3 In_PositionOS16_g251774 = Final_PositionOS178_g251764;
					float3 In_NormalOS16_g251774 = Out_NormalOS15_g251773;
					float4 In_TangentOS16_g251774 = Out_TangentOS15_g251773;
					float4 In_TransformData16_g251774 = temp_output_1615_31_g251764;
					float4 In_RotationData16_g251774 = temp_output_1615_33_g251764;
					float4 In_Interpolator16_g251774 = Out_Interpolator15_g251773;
					BuildVertexData( Data16_g251774 , In_Dummy16_g251774 , In_PositionOS16_g251774 , In_NormalOS16_g251774 , In_TangentOS16_g251774 , In_TransformData16_g251774 , In_RotationData16_g251774 , In_Interpolator16_g251774 );
					TVEVertexData Data15_g251777 =(TVEVertexData)Data16_g251774;
					float Out_Dummy15_g251777 = 0.0;
					float3 Out_PositionOS15_g251777 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251777 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251777 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251777 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251777 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251777 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251777 , Out_Dummy15_g251777 , Out_PositionOS15_g251777 , Out_NormalOS15_g251777 , Out_TangentOS15_g251777 , Out_TransformData15_g251777 , Out_RotationData15_g251777 , Out_Interpolator15_g251777 );
					TVEVertexData Data16_g251778 =(TVEVertexData)Data15_g251777;
					float In_Dummy16_g251778 = 0.0;
					TVEModelData Data15_g251776 =(TVEModelData)Data15_g251760;
					float Out_Dummy15_g251776 = 0.0;
					float3 Out_PositionOS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251776 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251776 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251776 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251776 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251776 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251776 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251776 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251776 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251776 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251776 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251776 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251776 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251776 , Out_Dummy15_g251776 , Out_PositionOS15_g251776 , Out_PositionWS15_g251776 , Out_PositionWO15_g251776 , Out_PositionRawOS15_g251776 , Out_PivotOS15_g251776 , Out_PivotWS15_g251776 , Out_PivotWO15_g251776 , Out_NormalOS15_g251776 , Out_NormalWS15_g251776 , Out_NormalRawOS15_g251776 , Out_TangentOS15_g251776 , Out_TangentWS15_g251776 , Out_BitangentWS15_g251776 , Out_ViewDirWS15_g251776 , Out_CoordsData15_g251776 , Out_VertexData15_g251776 , Out_MasksData15_g251776 , Out_PhaseData15_g251776 , Out_TransformData15_g251776 , Out_RotationData15_g251776 , Out_Interpolator15_g251776 );
					float3 In_PositionOS16_g251778 = ( Out_PositionOS15_g251777 + Out_PivotOS15_g251776 );
					float3 In_NormalOS16_g251778 = Out_NormalOS15_g251777;
					float4 In_TangentOS16_g251778 = Out_TangentOS15_g251777;
					float4 In_TransformData16_g251778 = Out_TransformData15_g251777;
					float4 In_RotationData16_g251778 = Out_RotationData15_g251777;
					float4 In_Interpolator16_g251778 = Out_Interpolator15_g251777;
					BuildVertexData( Data16_g251778 , In_Dummy16_g251778 , In_PositionOS16_g251778 , In_NormalOS16_g251778 , In_TangentOS16_g251778 , In_TransformData16_g251778 , In_RotationData16_g251778 , In_Interpolator16_g251778 );
					TVEVertexData Data15_g254374 =(TVEVertexData)Data16_g251778;
					float Out_Dummy15_g254374 = 0.0;
					float3 Out_PositionOS15_g254374 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254374 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254374 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254374 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254374 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254374 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254374 , Out_Dummy15_g254374 , Out_PositionOS15_g254374 , Out_NormalOS15_g254374 , Out_TangentOS15_g254374 , Out_TransformData15_g254374 , Out_RotationData15_g254374 , Out_Interpolator15_g254374 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g254374;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254374;
					v.tangent = Out_TangentOS15_g254374;

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

					TVEVertexData Data16_g251752 =(TVEVertexData)0;
					float In_Dummy16_g251752 = 0.0;
					TVEVertexData Data16_g251747 =(TVEVertexData)0;
					float In_Dummy16_g251747 = 0.0;
					float localIfModelDataByShader26_g251547 = ( 0.0 );
					TVEModelData Data26_g251547 = (TVEModelData)0;
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
					TVEModelData DataDefault26_g251547 = Data16_g241434;
					TVEModelData DataGeneral26_g251547 = Data16_g241434;
					TVEModelData DataBlanket26_g251547 = Data16_g241434;
					TVEModelData DataImpostor26_g251547 = Data16_g241434;
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
					TVEModelData DataTerrain26_g251547 = Data16_g241414;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251547 = IsShaderType2672;
					{
					if (Type26_g251547 == 0 )
					{
					Data26_g251547 = DataDefault26_g251547;
					}
					else if (Type26_g251547 == 1 )
					{
					Data26_g251547 = DataGeneral26_g251547;
					}
					else if (Type26_g251547 == 2 )
					{
					Data26_g251547 = DataBlanket26_g251547;
					}
					else if (Type26_g251547 == 3 )
					{
					Data26_g251547 = DataImpostor26_g251547;
					}
					else if (Type26_g251547 == 4 )
					{
					Data26_g251547 = DataTerrain26_g251547;
					}
					}
					TVEModelData Data15_g251748 =(TVEModelData)Data26_g251547;
					float Out_Dummy15_g251748 = 0.0;
					float3 Out_PositionOS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251748 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251748 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251748 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251748 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251748 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251748 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251748 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251748 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251748 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251748 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251748 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251748 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251748 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251748 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251748 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251748 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251748 , Out_Dummy15_g251748 , Out_PositionOS15_g251748 , Out_PositionWS15_g251748 , Out_PositionWO15_g251748 , Out_PositionRawOS15_g251748 , Out_PivotOS15_g251748 , Out_PivotWS15_g251748 , Out_PivotWO15_g251748 , Out_NormalOS15_g251748 , Out_NormalWS15_g251748 , Out_NormalRawOS15_g251748 , Out_TangentOS15_g251748 , Out_TangentWS15_g251748 , Out_BitangentWS15_g251748 , Out_ViewDirWS15_g251748 , Out_CoordsData15_g251748 , Out_VertexData15_g251748 , Out_MasksData15_g251748 , Out_PhaseData15_g251748 , Out_TransformData15_g251748 , Out_RotationData15_g251748 , Out_Interpolator15_g251748 );
					float3 In_PositionOS16_g251747 = Out_PositionOS15_g251748;
					float3 In_NormalOS16_g251747 = Out_NormalOS15_g251748;
					float4 In_TangentOS16_g251747 = Out_TangentOS15_g251748;
					float4 In_TransformData16_g251747 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251747 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251747 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251747 , In_Dummy16_g251747 , In_PositionOS16_g251747 , In_NormalOS16_g251747 , In_TangentOS16_g251747 , In_TransformData16_g251747 , In_RotationData16_g251747 , In_Interpolator16_g251747 );
					TVEVertexData Data15_g251750 =(TVEVertexData)Data16_g251747;
					float Out_Dummy15_g251750 = 0.0;
					float3 Out_PositionOS15_g251750 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251750 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251750 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251750 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251750 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251750 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251750 , Out_Dummy15_g251750 , Out_PositionOS15_g251750 , Out_NormalOS15_g251750 , Out_TangentOS15_g251750 , Out_TransformData15_g251750 , Out_RotationData15_g251750 , Out_Interpolator15_g251750 );
					TVEModelData Data15_g251751 =(TVEModelData)Data15_g251748;
					float Out_Dummy15_g251751 = 0.0;
					float3 Out_PositionOS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251751 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251751 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251751 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251751 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251751 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251751 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251751 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251751 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251751 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251751 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251751 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251751 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251751 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251751 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251751 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251751 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251751 , Out_Dummy15_g251751 , Out_PositionOS15_g251751 , Out_PositionWS15_g251751 , Out_PositionWO15_g251751 , Out_PositionRawOS15_g251751 , Out_PivotOS15_g251751 , Out_PivotWS15_g251751 , Out_PivotWO15_g251751 , Out_NormalOS15_g251751 , Out_NormalWS15_g251751 , Out_NormalRawOS15_g251751 , Out_TangentOS15_g251751 , Out_TangentWS15_g251751 , Out_BitangentWS15_g251751 , Out_ViewDirWS15_g251751 , Out_CoordsData15_g251751 , Out_VertexData15_g251751 , Out_MasksData15_g251751 , Out_PhaseData15_g251751 , Out_TransformData15_g251751 , Out_RotationData15_g251751 , Out_Interpolator15_g251751 );
					float3 In_PositionOS16_g251752 = ( Out_PositionOS15_g251750 - Out_PivotOS15_g251751 );
					float3 In_NormalOS16_g251752 = Out_NormalOS15_g251751;
					float4 In_TangentOS16_g251752 = Out_TangentOS15_g251751;
					float4 In_TransformData16_g251752 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251752 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251752 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251752 , In_Dummy16_g251752 , In_PositionOS16_g251752 , In_NormalOS16_g251752 , In_TangentOS16_g251752 , In_TransformData16_g251752 , In_RotationData16_g251752 , In_Interpolator16_g251752 );
					TVEVertexData Data15_g251761 =(TVEVertexData)Data16_g251752;
					float Out_Dummy15_g251761 = 0.0;
					float3 Out_PositionOS15_g251761 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251761 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251761 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251761 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251761 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251761 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251761 , Out_Dummy15_g251761 , Out_PositionOS15_g251761 , Out_NormalOS15_g251761 , Out_TangentOS15_g251761 , Out_TransformData15_g251761 , Out_RotationData15_g251761 , Out_Interpolator15_g251761 );
					TVEVertexData Data16_g251762 =(TVEVertexData)Data15_g251761;
					half Dummy317_g251753 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251762 = Dummy317_g251753;
					float3 In_PositionOS16_g251762 = Out_PositionOS15_g251761;
					float3 In_NormalOS16_g251762 = Out_NormalOS15_g251761;
					float4 In_TangentOS16_g251762 = Out_TangentOS15_g251761;
					half4 Model_TransformData356_g251753 = Out_TransformData15_g251761;
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
					TVEGlobalData Data15_g251763 =(TVEGlobalData)Data204_g251364;
					float Out_Dummy15_g251763 = 0.0;
					float4 Out_CoatTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251763 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251763 = float4( 0,0,0,0 );
					BreakData( Data15_g251763 , Out_Dummy15_g251763 , Out_CoatTexture15_g251763 , Out_DrawTexture15_g251763 , Out_PaintTexture15_g251763 , Out_AtmoTexture15_g251763 , Out_EffexTexture15_g251763 , Out_GlowTexture15_g251763 , Out_FormTexture15_g251763 , Out_LandTexture15_g251763 , Out_VertxTexture15_g251763 , Out_FlowTexture15_g251763 , Out_UserTexture15_g251763 );
					float4 Global_FormTexture351_g251753 = Out_FormTexture15_g251763;
					TVEModelData Data15_g251760 =(TVEModelData)Data15_g251751;
					float Out_Dummy15_g251760 = 0.0;
					float3 Out_PositionOS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251760 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251760 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251760 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251760 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251760 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251760 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251760 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251760 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251760 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251760 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251760 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251760 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251760 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251760 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251760 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251760 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251760 , Out_Dummy15_g251760 , Out_PositionOS15_g251760 , Out_PositionWS15_g251760 , Out_PositionWO15_g251760 , Out_PositionRawOS15_g251760 , Out_PivotOS15_g251760 , Out_PivotWS15_g251760 , Out_PivotWO15_g251760 , Out_NormalOS15_g251760 , Out_NormalWS15_g251760 , Out_NormalRawOS15_g251760 , Out_TangentOS15_g251760 , Out_TangentWS15_g251760 , Out_BitangentWS15_g251760 , Out_ViewDirWS15_g251760 , Out_CoordsData15_g251760 , Out_VertexData15_g251760 , Out_MasksData15_g251760 , Out_PhaseData15_g251760 , Out_TransformData15_g251760 , Out_RotationData15_g251760 , Out_Interpolator15_g251760 );
					float3 Model_PivotWO353_g251753 = Out_PivotWO15_g251760;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251759 = _ConformMeshMode;
					float Option70_g251759 = temp_output_17_0_g251759;
					half4 Model_VertexData357_g251753 = Out_VertexData15_g251760;
					float4 temp_output_3_0_g251759 = Model_VertexData357_g251753;
					float4 Channel70_g251759 = temp_output_3_0_g251759;
					float localSwitchChannel470_g251759 = SwitchChannel4( Option70_g251759 , Channel70_g251759 );
					float temp_output_390_0_g251753 = localSwitchChannel470_g251759;
					float temp_output_7_0_g251756 = _ConformMeshRemap.x;
					float temp_output_9_0_g251756 = ( temp_output_390_0_g251753 - temp_output_7_0_g251756 );
					float lerpResult374_g251753 = lerp( 1.0 , saturate( ( temp_output_9_0_g251756 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251753 = lerpResult374_g251753;
					float temp_output_328_0_g251753 = ( Blend_VertMask379_g251753 * TVE_IsEnabled );
					half Conform_Mask366_g251753 = temp_output_328_0_g251753;
					float temp_output_322_0_g251753 = ( ( ( ( (Global_FormTexture351_g251753).z - ( (Model_PivotWO353_g251753).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251753 ) );
					float3 appendResult329_g251753 = (float3(0.0 , temp_output_322_0_g251753 , 0.0));
					float3 appendResult387_g251753 = (float3(0.0 , 0.0 , temp_output_322_0_g251753));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251757 = appendResult387_g251753;
					#else
					float3 staticSwitch65_g251757 = appendResult329_g251753;
					#endif
					float3 Blanket_Conform368_g251753 = staticSwitch65_g251757;
					float4 appendResult312_g251753 = (float4(Blanket_Conform368_g251753 , 0.0));
					float4 temp_output_310_0_g251753 = ( Model_TransformData356_g251753 + appendResult312_g251753 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251753 = temp_output_310_0_g251753;
					#else
					float4 staticSwitch364_g251753 = Model_TransformData356_g251753;
					#endif
					half4 Final_TransformData365_g251753 = staticSwitch364_g251753;
					float4 In_TransformData16_g251762 = Final_TransformData365_g251753;
					float4 In_RotationData16_g251762 = Out_RotationData15_g251761;
					float4 In_Interpolator16_g251762 = Out_Interpolator15_g251761;
					BuildVertexData( Data16_g251762 , In_Dummy16_g251762 , In_PositionOS16_g251762 , In_NormalOS16_g251762 , In_TangentOS16_g251762 , In_TransformData16_g251762 , In_RotationData16_g251762 , In_Interpolator16_g251762 );
					TVEVertexData Data15_g251773 =(TVEVertexData)Data16_g251762;
					float Out_Dummy15_g251773 = 0.0;
					float3 Out_PositionOS15_g251773 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251773 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251773 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251773 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251773 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251773 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251773 , Out_Dummy15_g251773 , Out_PositionOS15_g251773 , Out_NormalOS15_g251773 , Out_TangentOS15_g251773 , Out_TransformData15_g251773 , Out_RotationData15_g251773 , Out_Interpolator15_g251773 );
					TVEVertexData Data16_g251774 =(TVEVertexData)Data15_g251773;
					float In_Dummy16_g251774 = 0.0;
					float3 Vertex_PositionOS147_g251764 = Out_PositionOS15_g251773;
					half3 VertexPos40_g251768 = Vertex_PositionOS147_g251764;
					float4 temp_output_1615_33_g251764 = Out_RotationData15_g251773;
					half4 Vertex_RotationData1569_g251764 = temp_output_1615_33_g251764;
					float2 break1582_g251764 = (Vertex_RotationData1569_g251764).xy;
					half Angle44_g251768 = break1582_g251764.y;
					half CosAngle89_g251768 = cos( Angle44_g251768 );
					half SinAngle93_g251768 = sin( Angle44_g251768 );
					float3 appendResult95_g251768 = (float3((VertexPos40_g251768).x , ( ( (VertexPos40_g251768).y * CosAngle89_g251768 ) - ( (VertexPos40_g251768).z * SinAngle93_g251768 ) ) , ( ( (VertexPos40_g251768).y * SinAngle93_g251768 ) + ( (VertexPos40_g251768).z * CosAngle89_g251768 ) )));
					half3 VertexPos40_g251769 = appendResult95_g251768;
					half Angle44_g251769 = -break1582_g251764.x;
					half CosAngle94_g251769 = cos( Angle44_g251769 );
					half SinAngle95_g251769 = sin( Angle44_g251769 );
					float3 appendResult98_g251769 = (float3(( ( (VertexPos40_g251769).x * CosAngle94_g251769 ) - ( (VertexPos40_g251769).y * SinAngle95_g251769 ) ) , ( ( (VertexPos40_g251769).x * SinAngle95_g251769 ) + ( (VertexPos40_g251769).y * CosAngle94_g251769 ) ) , (VertexPos40_g251769).z));
					half3 VertexPos40_g251767 = Vertex_PositionOS147_g251764;
					half Angle44_g251767 = break1582_g251764.y;
					half CosAngle89_g251767 = cos( Angle44_g251767 );
					half SinAngle93_g251767 = sin( Angle44_g251767 );
					float3 appendResult95_g251767 = (float3((VertexPos40_g251767).x , ( ( (VertexPos40_g251767).y * CosAngle89_g251767 ) - ( (VertexPos40_g251767).z * SinAngle93_g251767 ) ) , ( ( (VertexPos40_g251767).y * SinAngle93_g251767 ) + ( (VertexPos40_g251767).z * CosAngle89_g251767 ) )));
					half3 VertexPos40_g251772 = appendResult95_g251767;
					half Angle44_g251772 = break1582_g251764.x;
					half CosAngle91_g251772 = cos( Angle44_g251772 );
					half SinAngle92_g251772 = sin( Angle44_g251772 );
					float3 appendResult93_g251772 = (float3(( ( (VertexPos40_g251772).x * CosAngle91_g251772 ) + ( (VertexPos40_g251772).z * SinAngle92_g251772 ) ) , (VertexPos40_g251772).y , ( ( -(VertexPos40_g251772).x * SinAngle92_g251772 ) + ( (VertexPos40_g251772).z * CosAngle91_g251772 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251770 = appendResult93_g251772;
					#else
					float3 staticSwitch65_g251770 = appendResult98_g251769;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251765 = staticSwitch65_g251770;
					#else
					float3 staticSwitch65_g251765 = Vertex_PositionOS147_g251764;
					#endif
					float3 temp_output_1608_0_g251764 = staticSwitch65_g251765;
					half3 VertexPos40_g251771 = temp_output_1608_0_g251764;
					half Angle44_g251771 = (Vertex_RotationData1569_g251764).z;
					half CosAngle91_g251771 = cos( Angle44_g251771 );
					half SinAngle92_g251771 = sin( Angle44_g251771 );
					float3 appendResult93_g251771 = (float3(( ( (VertexPos40_g251771).x * CosAngle91_g251771 ) + ( (VertexPos40_g251771).z * SinAngle92_g251771 ) ) , (VertexPos40_g251771).y , ( ( -(VertexPos40_g251771).x * SinAngle92_g251771 ) + ( (VertexPos40_g251771).z * CosAngle91_g251771 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251766 = appendResult93_g251771;
					#else
					float3 staticSwitch65_g251766 = temp_output_1608_0_g251764;
					#endif
					float4 temp_output_1615_31_g251764 = Out_TransformData15_g251773;
					half4 Vertex_TransformData1568_g251764 = temp_output_1615_31_g251764;
					half3 Final_PositionOS178_g251764 = ( ( staticSwitch65_g251766 * (Vertex_TransformData1568_g251764).w ) + (Vertex_TransformData1568_g251764).xyz );
					float3 In_PositionOS16_g251774 = Final_PositionOS178_g251764;
					float3 In_NormalOS16_g251774 = Out_NormalOS15_g251773;
					float4 In_TangentOS16_g251774 = Out_TangentOS15_g251773;
					float4 In_TransformData16_g251774 = temp_output_1615_31_g251764;
					float4 In_RotationData16_g251774 = temp_output_1615_33_g251764;
					float4 In_Interpolator16_g251774 = Out_Interpolator15_g251773;
					BuildVertexData( Data16_g251774 , In_Dummy16_g251774 , In_PositionOS16_g251774 , In_NormalOS16_g251774 , In_TangentOS16_g251774 , In_TransformData16_g251774 , In_RotationData16_g251774 , In_Interpolator16_g251774 );
					TVEVertexData Data15_g251777 =(TVEVertexData)Data16_g251774;
					float Out_Dummy15_g251777 = 0.0;
					float3 Out_PositionOS15_g251777 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251777 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251777 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251777 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251777 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251777 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251777 , Out_Dummy15_g251777 , Out_PositionOS15_g251777 , Out_NormalOS15_g251777 , Out_TangentOS15_g251777 , Out_TransformData15_g251777 , Out_RotationData15_g251777 , Out_Interpolator15_g251777 );
					TVEVertexData Data16_g251778 =(TVEVertexData)Data15_g251777;
					float In_Dummy16_g251778 = 0.0;
					TVEModelData Data15_g251776 =(TVEModelData)Data15_g251760;
					float Out_Dummy15_g251776 = 0.0;
					float3 Out_PositionOS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251776 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251776 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251776 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251776 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251776 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251776 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251776 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251776 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251776 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251776 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251776 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251776 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251776 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251776 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251776 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251776 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251776 , Out_Dummy15_g251776 , Out_PositionOS15_g251776 , Out_PositionWS15_g251776 , Out_PositionWO15_g251776 , Out_PositionRawOS15_g251776 , Out_PivotOS15_g251776 , Out_PivotWS15_g251776 , Out_PivotWO15_g251776 , Out_NormalOS15_g251776 , Out_NormalWS15_g251776 , Out_NormalRawOS15_g251776 , Out_TangentOS15_g251776 , Out_TangentWS15_g251776 , Out_BitangentWS15_g251776 , Out_ViewDirWS15_g251776 , Out_CoordsData15_g251776 , Out_VertexData15_g251776 , Out_MasksData15_g251776 , Out_PhaseData15_g251776 , Out_TransformData15_g251776 , Out_RotationData15_g251776 , Out_Interpolator15_g251776 );
					float3 In_PositionOS16_g251778 = ( Out_PositionOS15_g251777 + Out_PivotOS15_g251776 );
					float3 In_NormalOS16_g251778 = Out_NormalOS15_g251777;
					float4 In_TangentOS16_g251778 = Out_TangentOS15_g251777;
					float4 In_TransformData16_g251778 = Out_TransformData15_g251777;
					float4 In_RotationData16_g251778 = Out_RotationData15_g251777;
					float4 In_Interpolator16_g251778 = Out_Interpolator15_g251777;
					BuildVertexData( Data16_g251778 , In_Dummy16_g251778 , In_PositionOS16_g251778 , In_NormalOS16_g251778 , In_TangentOS16_g251778 , In_TransformData16_g251778 , In_RotationData16_g251778 , In_Interpolator16_g251778 );
					TVEVertexData Data15_g254374 =(TVEVertexData)Data16_g251778;
					float Out_Dummy15_g254374 = 0.0;
					float3 Out_PositionOS15_g254374 = float3( 0,0,0 );
					float3 Out_NormalOS15_g254374 = float3( 0,0,0 );
					float4 Out_TangentOS15_g254374 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g254374 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g254374 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g254374 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g254374 , Out_Dummy15_g254374 , Out_PositionOS15_g254374 , Out_NormalOS15_g254374 , Out_TangentOS15_g254374 , Out_TransformData15_g254374 , Out_RotationData15_g254374 , Out_Interpolator15_g254374 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g254374;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g254374;
					v.tangent = Out_TangentOS15_g254374;

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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2666,"pos":[-7936,-5376],"params":["Inherit","False","Property","_IsShaderType","_IsShaderType","83","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2670,"pos":[-7552,-4736],"params":["Inherit","False","If Model Data","-1","","241395","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2672,"pos":[-7744,-5376],"params":["Half","False","IsShaderType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-7232,-4736],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2667,"pos":[-7936,-4864],"params":["Inherit","False","Block Model","70","","241396","7ad7765e793a6714babedee0033c36e9","19,463,0,289,0,240,0,437,0,291,0,431,0,404,0,290,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6784,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2669,"pos":[-7936,-4992],"params":["Inherit","False","Block Model","70","","241416","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2668,"pos":[-7936,-4608],"params":["Inherit","False","2672","IsShaderType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2375,"pos":[-6528,-4992],"params":["Inherit","False","Block Global","89","","251364","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2671,"pos":[-7552,-4992],"params":["Inherit","False","If Model Data","-1","","251547","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-6208,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-7232,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2680,"pos":[-5760,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2681,"pos":[-5760,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2679,"pos":[-5504,-4992],"params":["Inherit","False","Block Vertex","-1","","251746","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2657,"pos":[-5120,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","251749","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2659,"pos":[-4736,-4992],"params":["Inherit","False","Block Blanket Conform","194","","251753","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2665,"pos":[-4352,-4992],"params":["Inherit","False","Block Transform","-1","","251764","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2660,"pos":[-3968,-4992],"params":["Inherit","False","Block Pivots Add","-1","","251775","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2661,"pos":[-3648,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2682,"pos":[-3200,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2683,"pos":[-3200,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2685,"pos":[-3200,-4992],"params":["Inherit","False","2661","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2684,"pos":[-2944,-4992],"params":["Inherit","False","Block Visual","-1","","252029","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2380,"pos":[-2560,-4992],"params":["Inherit","False","Block Main","168","","252033","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2454,"pos":[-2240,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2600,"pos":[-1536,-4992],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2507,"pos":[-1536,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2508,"pos":[-1536,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2654,"pos":[-1280,-4992],"params":["Inherit","False","Block Overlay","7","","252072","8ae9c8285a7817844a51243251284d21","39,813,1,991,1,987,1,1061,1,992,1,819,1,821,1,1111,0,1114,0,1064,0,1066,0,1078,0,1065,0,1079,0,1067,0,1105,1,1104,0,1182,1,1101,0,1097,0,1100,0,1102,0,1103,0,942,0,940,0,1090,0,1089,0,944,0,1228,1,826,1,828,1,823,1,1013,1,1018,0,1010,0,1034,0,1033,0,844,0,447,0","4","572","OBJECT","0,0,0,0","False","596","OBJECT","0,0,0,0","False","600","OBJECT","0,0,0,0","False","445","FLOAT","1","False","4","OBJECT","566","OBJECT","1184","OBJECT","1185","OBJECT","973"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2620,"pos":[-1216,-4672],"params":["Half","False","Global","TVE_DEBUG_Global","TVE_DEBUG_Global","4","0","Create","True","0","5","Vertex Colors","100","Texture Coords","200","Vertex Postion","300","Vertex Normals","301","Vertex Tangents","302","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2655,"pos":[-1280,-4832],"params":["Inherit","False","Block Overlay","7","","254256","8ae9c8285a7817844a51243251284d21","39,813,1,991,1,987,1,1061,1,992,1,819,1,821,1,1111,0,1114,0,1064,0,1066,0,1078,0,1065,0,1079,0,1067,0,1105,1,1104,0,1182,1,1101,0,1097,0,1100,0,1102,0,1103,0,942,1,940,1,1090,0,1089,0,944,0,1228,1,826,1,828,1,823,1,1013,1,1018,0,1010,0,1034,0,1033,0,844,0,447,0","4","572","OBJECT","0,0,0,0","False","596","OBJECT","0,0,0,0","False","600","OBJECT","0,0,0,0","False","445","FLOAT","1","False","4","OBJECT","566","OBJECT","1184","OBJECT","1185","OBJECT","973"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2619,"pos":[-896,-4992],"params":["Inherit","False","If Masks Data","-1","","254350","8077f199aa3992c4b8c999410c1ede62","1,32,0","8","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","28","OBJECT","0","False","27","OBJECT","0","False","30","OBJECT","0","False","31","OBJECT","0","False","29","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2509,"pos":[-640,-4992],"params":["Inherit","False","Break Masks Data","-1","","254351","23311522ecc97b54e8b77d849401069d","0","1","6","OBJECT","0","False","8","FLOAT4","14","FLOAT4","0","FLOAT4","23","FLOAT4","5","FLOAT4","24","FLOAT4","25","FLOAT4","26","FLOAT4","27"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2567,"pos":[128,-4864],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2569,"pos":[128,-4608],"params":["Inherit","False","FLOAT","1","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2608,"pos":[128,-3696],"params":["Inherit","False","FLOAT","3","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2604,"pos":[128,-4352],"params":["Inherit","False","FLOAT","2","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2646,"pos":[128,-4992],"params":["Inherit","False","Tool Debug Active","84","","254352","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2647,"pos":[128,-4736],"params":["Inherit","False","Tool Debug Active","84","","254354","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2648,"pos":[128,-4480],"params":["Inherit","False","Tool Debug Active","84","","254356","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2649,"pos":[128,-3824],"params":["Inherit","False","Tool Debug Active","84","","254358","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2568,"pos":[384,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2571,"pos":[384,-4736],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2603,"pos":[384,-4480],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2607,"pos":[384,-3824],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2610,"pos":[128,-4096],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[768,-4992],"params":["Inherit","False","Tool Debug Index","-1","","254360","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2592,"pos":[768,-4736],"params":["Inherit","False","Tool Debug Index","-1","","254361","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","1","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2605,"pos":[768,-4480],"params":["Inherit","False","Tool Debug Index","-1","","254362","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2609,"pos":[768,-3824],"params":["Inherit","False","Tool Debug Index","-1","","254363","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","6","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2611,"pos":[768,-4096],"params":["Inherit","False","Tool Debug Index","-1","","254364","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[1152,-4992],"params":["Inherit","False","5","5","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3072,-5120],"params":["Inherit","False","Base Compile","-1","","254365","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2664,"pos":[2688,-4992],"params":["Inherit","False","Tool Debug Color","0","","254366","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[2688,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[3072,-4992],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Overlay","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2673,"pos":[2688,-4932],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2674,"pos":[3072,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
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
{"wire":[2679,1894,2680,0]}
{"wire":[2679,1896,2681,0]}
{"wire":[2657,224,2679,128]}
{"wire":[2657,146,2679,1895]}
{"wire":[2657,231,2679,1897]}
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
{"wire":[2684,1904,2685,0]}
{"wire":[2684,1894,2683,0]}
{"wire":[2684,1896,2682,0]}
{"wire":[2380,430,2684,1900]}
{"wire":[2380,225,2684,1895]}
{"wire":[2380,414,2684,1897]}
{"wire":[2454,0,2380,106]}
{"wire":[2654,572,2600,0]}
{"wire":[2654,596,2508,0]}
{"wire":[2654,600,2507,0]}
{"wire":[2655,572,2600,0]}
{"wire":[2655,596,2508,0]}
{"wire":[2655,600,2507,0]}
{"wire":[2619,3,2654,973]}
{"wire":[2619,17,2655,973]}
{"wire":[2619,19,2620,0]}
{"wire":[2509,6,2619,0]}
{"wire":[2567,0,2509,14]}
{"wire":[2569,0,2509,14]}
{"wire":[2608,0,2509,14]}
{"wire":[2604,0,2509,14]}
{"wire":[2568,0,2646,108]}
{"wire":[2568,1,2646,0]}
{"wire":[2568,2,2567,0]}
{"wire":[2571,0,2647,108]}
{"wire":[2571,1,2647,0]}
{"wire":[2571,2,2569,0]}
{"wire":[2603,0,2648,108]}
{"wire":[2603,1,2648,0]}
{"wire":[2603,2,2604,0]}
{"wire":[2607,0,2649,108]}
{"wire":[2607,1,2649,0]}
{"wire":[2607,2,2608,0]}
{"wire":[2610,0,2509,0]}
{"wire":[2594,39,2568,0]}
{"wire":[2592,39,2571,0]}
{"wire":[2605,39,2603,0]}
{"wire":[2609,39,2607,0]}
{"wire":[2611,39,2610,0]}
{"wire":[2550,0,2594,0]}
{"wire":[2550,1,2592,0]}
{"wire":[2550,2,2605,0]}
{"wire":[2550,3,2611,0]}
{"wire":[2550,4,2609,0]}
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
//CHKSM=52FDFC71A6CDE64F6AF5CF559E81212886CC7687