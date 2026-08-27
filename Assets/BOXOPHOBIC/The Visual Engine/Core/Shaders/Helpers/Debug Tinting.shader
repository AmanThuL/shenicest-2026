// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Tinting"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_TintingIntensityValue( "Tinting Intensity", Range( 0, 1 ) ) = 0
		_TintingPaintValue( "Tinting Paint Mask", Range( 0, 1 ) ) = 1
		[Enum(Global Data Only,0,Use Paint Elements,1)] _TintingPaintMode( "Tinting Paint Mask", Float ) = 1
		_TintingMultiValue( "Tinting Multi Mask", Range( 0, 1 ) ) = 1
		_TintingLumaValue( "Tinting Luma Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _TintingLumaRemap( "Tinting Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_TintingMeshValue( "Tinting Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _TintingMeshMode( "Tinting Mesh Mask", Float ) = 3
		[StyledRemapSlider] _TintingMeshRemap( "Tinting Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Multiply,0,Buildup,1)] _TintingBlendMath( "Tinting Blend Mask", Float ) = 1
		[StyledRemapSlider] _TintingBlendRemap( "Tinting Blend Mask", Vector ) = ( 0, 0.1, 0, 0 )
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Y Up,0,Z Up,1)] _ObjectCoordMode( "Object Coord Mode", Float ) = 0
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
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
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		[StyledCategory(Conform Settings, true, Use the Conform feature to project the vertices to the terrain or mesh surfaces__ similar to how decals work__ but for 3D objects. The most common usage is with big patches of grass__ groups of rocks or QUOplanarQUO ground covers which would not work properly on curved surfaces. Please note__ the projection only works from top down view and the effect it is only visual OPAcollider is not affectedCPAEXC, _ConformIntensityValue, FF0000, 0, 10)] _ConformCategory( "[ Conform Category ]", Float ) = 0
		[StyledMessage(Info, The Conform position features require elements to work. Use Form Surface or Form Height elements for conforming  the objects to terrain surfaces. Please note__ the conform effect is only visual and it does not affect the object collider and bounds., 0, 10)] _ConformInfo( "_ConformInfo", Float ) = 0
		_ConformIntensityValue( "Conform Intensity", Range( 0, 1 ) ) = 0
		[Enum(Freeform Object Position,0,Lock Position With Conform,1)] _ConformMode( "Conform Mode", Float ) = 1
		_ConformOffsetValue( "Conform Offset", Float ) = 0
		[Space(10)] _ConformMeshValue( "Conform Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ConformMeshMode( "Conform Mesh Mask", Float ) = 3
		[StyledRemapSlider] _ConformMeshRemap( "Conform Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _ConformEnd( "[ Conform End ]", Float ) = 1
		_IsTerrainShader( "_IsTerrainShader", Float ) = 0
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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_TINTING_PAINT
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
				uniform half _TintingIntensityValue;
				uniform half _TintingPaintMode;
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
				uniform half _TintingMultiValue;
				uniform half4 _TintingLumaRemap;
				uniform half _TintingLumaValue;
				uniform half _TintingMeshMode;
				uniform half4 _TintingMeshRemap;
				uniform half _TintingMeshValue;
				uniform half _TintingPaintValue;
				uniform half _TintingBlendMath;
				uniform half4 _TintingBlendRemap;
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

					TVEVertexData Data16_g252031 =(TVEVertexData)0;
					float In_Dummy16_g252031 = 0.0;
					TVEVertexData Data16_g252026 =(TVEVertexData)0;
					float In_Dummy16_g252026 = 0.0;
					TVEModelData Data16_g251777 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#endif
					half Dummy207_g251759 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251759 );
					float temp_output_14_0_g251777 = Dummy207_g251759;
					float In_Dummy16_g251777 = temp_output_14_0_g251777;
					float3 PositionOS131_g251759 = v.vertex.xyz;
					float3 temp_output_4_0_g251777 = PositionOS131_g251759;
					float3 In_PositionOS16_g251777 = temp_output_4_0_g251777;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251759 = ase_positionWS;
					float3 vertexToFrag73_g251759 = temp_output_104_7_g251759;
					float3 PositionWS122_g251759 = vertexToFrag73_g251759;
					float3 In_PositionWS16_g251777 = PositionWS122_g251759;
					float4x4 break19_g251762 = unity_ObjectToWorld;
					float3 appendResult20_g251762 = (float3(break19_g251762[ 0 ][ 3 ] , break19_g251762[ 1 ][ 3 ] , break19_g251762[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251759 = appendResult20_g251762;
					float4x4 break19_g251764 = unity_ObjectToWorld;
					float3 appendResult20_g251764 = (float3(break19_g251764[ 0 ][ 3 ] , break19_g251764[ 1 ][ 3 ] , break19_g251764[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251760 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251759 = PositionOS131_g251759;
					float3 appendResult234_g251759 = (float3(break233_g251759.x , 0.0 , break233_g251759.z));
					float3 break413_g251759 = PositionOS131_g251759;
					float3 appendResult414_g251759 = (float3(break413_g251759.x , break413_g251759.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251766 = appendResult414_g251759;
					#else
					float3 staticSwitch65_g251766 = appendResult234_g251759;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251759 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251759 = appendResult60_g251760;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251759 = staticSwitch65_g251766;
					#else
					float3 staticSwitch229_g251759 = _Vector0;
					#endif
					float3 PivotOS149_g251759 = staticSwitch229_g251759;
					float3 temp_output_122_0_g251764 = PivotOS149_g251759;
					float3 PivotsOnlyWS105_g251764 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251764 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251759 = ( appendResult20_g251764 + PivotsOnlyWS105_g251764 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#else
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#endif
					float3 vertexToFrag76_g251759 = staticSwitch236_g251759;
					float3 PivotWS121_g251759 = vertexToFrag76_g251759;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251759 = ( PositionWS122_g251759 - PivotWS121_g251759 );
					#else
					float3 staticSwitch204_g251759 = PositionWS122_g251759;
					#endif
					float3 PositionWO132_g251759 = ( staticSwitch204_g251759 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251777 = PositionWO132_g251759;
					float3 In_PivotOS16_g251777 = PivotOS149_g251759;
					float3 In_PivotWS16_g251777 = PivotWS121_g251759;
					float3 PivotWO133_g251759 = ( PivotWS121_g251759 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251777 = PivotWO133_g251759;
					half3 NormalOS134_g251759 = v.normal;
					float3 temp_output_21_0_g251777 = NormalOS134_g251759;
					float3 In_NormalOS16_g251777 = temp_output_21_0_g251777;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251759 = normalizedWorldNormal;
					float3 In_NormalWS16_g251777 = NormalWS95_g251759;
					half4 TangentlOS153_g251759 = v.tangent;
					float4 temp_output_6_0_g251777 = TangentlOS153_g251759;
					float4 In_TangentOS16_g251777 = temp_output_6_0_g251777;
					float3 normalizeResult296_g251759 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251759 ) );
					half3 ViewDirWS169_g251759 = normalizeResult296_g251759;
					float3 In_ViewDirWS16_g251777 = ViewDirWS169_g251759;
					float4 appendResult397_g251759 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251759 = appendResult397_g251759;
					float4 In_CoordsData16_g251777 = CoordsData398_g251759;
					half4 VertexMasks171_g251759 = v.ase_color;
					float4 In_VertexData16_g251777 = VertexMasks171_g251759;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251771 = (PositionOS131_g251759).z;
					#else
					float staticSwitch65_g251771 = (PositionOS131_g251759).y;
					#endif
					half Object_HeightValue267_g251759 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251759 = saturate( ( staticSwitch65_g251771 / Object_HeightValue267_g251759 ) );
					half3 Position387_g251759 = PositionOS131_g251759;
					half Height387_g251759 = Object_HeightValue267_g251759;
					half Object_RadiusValue268_g251759 = _ObjectRadiusValue;
					half Radius387_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskYUp387_g251759 = CapsuleMaskYUp( Position387_g251759 , Height387_g251759 , Radius387_g251759 );
					half3 Position408_g251759 = PositionOS131_g251759;
					half Height408_g251759 = Object_HeightValue267_g251759;
					half Radius408_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskZUp408_g251759 = CapsuleMaskZUp( Position408_g251759 , Height408_g251759 , Radius408_g251759 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251776 = saturate( localCapsuleMaskZUp408_g251759 );
					#else
					float staticSwitch65_g251776 = saturate( localCapsuleMaskYUp387_g251759 );
					#endif
					half Bounds_SphereMask282_g251759 = staticSwitch65_g251776;
					float4 appendResult253_g251759 = (float4(Bounds_HeightMask274_g251759 , Bounds_SphereMask282_g251759 , 1.0 , 1.0));
					half4 MasksData254_g251759 = appendResult253_g251759;
					float4 In_MasksData16_g251777 = MasksData254_g251759;
					float temp_output_17_0_g251770 = _ObjectPhaseMode;
					float Option70_g251770 = temp_output_17_0_g251770;
					float4 temp_output_3_0_g251770 = v.ase_color;
					float4 Channel70_g251770 = temp_output_3_0_g251770;
					float localSwitchChannel470_g251770 = SwitchChannel4( Option70_g251770 , Channel70_g251770 );
					half Phase_Value372_g251759 = localSwitchChannel470_g251770;
					float3 break319_g251759 = PivotWO133_g251759;
					half Pivot_Position322_g251759 = ( break319_g251759.x + break319_g251759.z );
					half Phase_Position357_g251759 = ( Phase_Value372_g251759 + Pivot_Position322_g251759 );
					float temp_output_248_0_g251759 = frac( Phase_Position357_g251759 );
					float4 appendResult177_g251759 = (float4((frac( ( Phase_Position357_g251759 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251759));
					half4 Phase_Data176_g251759 = appendResult177_g251759;
					float4 In_PhaseData16_g251777 = Phase_Data176_g251759;
					BuildModelVertData( Data16_g251777 , In_Dummy16_g251777 , In_PositionOS16_g251777 , In_PositionWS16_g251777 , In_PositionWO16_g251777 , In_PivotOS16_g251777 , In_PivotWS16_g251777 , In_PivotWO16_g251777 , In_NormalOS16_g251777 , In_NormalWS16_g251777 , In_TangentOS16_g251777 , In_ViewDirWS16_g251777 , In_CoordsData16_g251777 , In_VertexData16_g251777 , In_MasksData16_g251777 , In_PhaseData16_g251777 );
					TVEModelData Data15_g252027 =(TVEModelData)Data16_g251777;
					float Out_Dummy15_g252027 = 0.0;
					float3 Out_PositionOS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252027 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252027 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252027 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252027 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252027 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252027 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252027 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252027 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252027 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252027 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252027 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252027 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252027 , Out_Dummy15_g252027 , Out_PositionOS15_g252027 , Out_PositionWS15_g252027 , Out_PositionWO15_g252027 , Out_PositionRawOS15_g252027 , Out_PivotOS15_g252027 , Out_PivotWS15_g252027 , Out_PivotWO15_g252027 , Out_NormalOS15_g252027 , Out_NormalWS15_g252027 , Out_NormalRawOS15_g252027 , Out_TangentOS15_g252027 , Out_TangentWS15_g252027 , Out_BitangentWS15_g252027 , Out_ViewDirWS15_g252027 , Out_CoordsData15_g252027 , Out_VertexData15_g252027 , Out_MasksData15_g252027 , Out_PhaseData15_g252027 , Out_TransformData15_g252027 , Out_RotationData15_g252027 , Out_Interpolator15_g252027 );
					float3 In_PositionOS16_g252026 = Out_PositionOS15_g252027;
					float3 In_NormalOS16_g252026 = Out_NormalOS15_g252027;
					float4 In_TangentOS16_g252026 = Out_TangentOS15_g252027;
					float4 In_TransformData16_g252026 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252026 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252026 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252026 , In_Dummy16_g252026 , In_PositionOS16_g252026 , In_NormalOS16_g252026 , In_TangentOS16_g252026 , In_TransformData16_g252026 , In_RotationData16_g252026 , In_Interpolator16_g252026 );
					TVEVertexData Data15_g252029 =(TVEVertexData)Data16_g252026;
					float Out_Dummy15_g252029 = 0.0;
					float3 Out_PositionOS15_g252029 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252029 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252029 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252029 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252029 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252029 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252029 , Out_Dummy15_g252029 , Out_PositionOS15_g252029 , Out_NormalOS15_g252029 , Out_TangentOS15_g252029 , Out_TransformData15_g252029 , Out_RotationData15_g252029 , Out_Interpolator15_g252029 );
					TVEModelData Data15_g252030 =(TVEModelData)Data15_g252027;
					float Out_Dummy15_g252030 = 0.0;
					float3 Out_PositionOS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252030 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252030 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252030 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252030 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252030 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252030 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252030 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252030 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252030 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252030 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252030 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252030 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252030 , Out_Dummy15_g252030 , Out_PositionOS15_g252030 , Out_PositionWS15_g252030 , Out_PositionWO15_g252030 , Out_PositionRawOS15_g252030 , Out_PivotOS15_g252030 , Out_PivotWS15_g252030 , Out_PivotWO15_g252030 , Out_NormalOS15_g252030 , Out_NormalWS15_g252030 , Out_NormalRawOS15_g252030 , Out_TangentOS15_g252030 , Out_TangentWS15_g252030 , Out_BitangentWS15_g252030 , Out_ViewDirWS15_g252030 , Out_CoordsData15_g252030 , Out_VertexData15_g252030 , Out_MasksData15_g252030 , Out_PhaseData15_g252030 , Out_TransformData15_g252030 , Out_RotationData15_g252030 , Out_Interpolator15_g252030 );
					float3 In_PositionOS16_g252031 = ( Out_PositionOS15_g252029 - Out_PivotOS15_g252030 );
					float3 In_NormalOS16_g252031 = Out_NormalOS15_g252030;
					float4 In_TangentOS16_g252031 = Out_TangentOS15_g252030;
					float4 In_TransformData16_g252031 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252031 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252031 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252031 , In_Dummy16_g252031 , In_PositionOS16_g252031 , In_NormalOS16_g252031 , In_TangentOS16_g252031 , In_TransformData16_g252031 , In_RotationData16_g252031 , In_Interpolator16_g252031 );
					TVEVertexData Data15_g252040 =(TVEVertexData)Data16_g252031;
					float Out_Dummy15_g252040 = 0.0;
					float3 Out_PositionOS15_g252040 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252040 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252040 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252040 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252040 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252040 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252040 , Out_Dummy15_g252040 , Out_PositionOS15_g252040 , Out_NormalOS15_g252040 , Out_TangentOS15_g252040 , Out_TransformData15_g252040 , Out_RotationData15_g252040 , Out_Interpolator15_g252040 );
					TVEVertexData Data16_g252041 =(TVEVertexData)Data15_g252040;
					half Dummy317_g252032 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g252041 = Dummy317_g252032;
					float3 In_PositionOS16_g252041 = Out_PositionOS15_g252040;
					float3 In_NormalOS16_g252041 = Out_NormalOS15_g252040;
					float4 In_TangentOS16_g252041 = Out_TangentOS15_g252040;
					half4 Model_TransformData356_g252032 = Out_TransformData15_g252040;
					float localBuildGlobalData204_g251779 = ( 0.0 );
					TVEGlobalData Data204_g251779 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251779 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251779 = Dummy211_g251779;
					float4 temp_output_203_0_g251798 = TVE_CoatBaseCoord;
					TVEModelData Data16_g251767 =(TVEModelData)0;
					float In_Dummy16_g251767 = 0.0;
					float3 In_PositionWS16_g251767 = PositionWS122_g251759;
					float3 In_PositionWO16_g251767 = PositionWO132_g251759;
					float3 In_PivotWS16_g251767 = PivotWS121_g251759;
					float3 In_PivotWO16_g251767 = PivotWO133_g251759;
					float3 In_NormalWS16_g251767 = NormalWS95_g251759;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251759 = ase_tangentWS;
					float3 In_TangentWS16_g251767 = TangentWS136_g251759;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251759 = ase_bitangentWS;
					float3 In_BitangentWS16_g251767 = BiangentWS421_g251759;
					half3 NormalWS427_g251759 = NormalWS95_g251759;
					half3 localComputeTriplanarMasks427_g251759 = ComputeTriplanarMasks( NormalWS427_g251759 );
					half3 TriplanarWeights429_g251759 = localComputeTriplanarMasks427_g251759;
					float3 In_TriplanarWeights16_g251767 = TriplanarWeights429_g251759;
					float3 In_ViewDirWS16_g251767 = ViewDirWS169_g251759;
					float4 In_CoordsData16_g251767 = CoordsData398_g251759;
					float4 In_VertexData16_g251767 = VertexMasks171_g251759;
					float4 In_Interpolator16_g251767 = Phase_Data176_g251759;
					BuildModelFragData( Data16_g251767 , In_Dummy16_g251767 , In_PositionWS16_g251767 , In_PositionWO16_g251767 , In_PivotWS16_g251767 , In_PivotWO16_g251767 , In_NormalWS16_g251767 , In_TangentWS16_g251767 , In_BitangentWS16_g251767 , In_TriplanarWeights16_g251767 , In_ViewDirWS16_g251767 , In_CoordsData16_g251767 , In_VertexData16_g251767 , In_Interpolator16_g251767 );
					TVEModelData Data15_g251869 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g251869 = 0.0;
					float3 Out_PositionWS15_g251869 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251869 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251869 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251869 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251869 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251869 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251869 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251869 , Out_Dummy15_g251869 , Out_PositionWS15_g251869 , Out_PositionWO15_g251869 , Out_PivotWS15_g251869 , Out_PivotWO15_g251869 , Out_NormalWS15_g251869 , Out_TangentWS15_g251869 , Out_BitangentWS15_g251869 , Out_TriplanarWeights15_g251869 , Out_ViewDirWS15_g251869 , Out_CoordsData15_g251869 , Out_VertexData15_g251869 , Out_Interpolator15_g251869 );
					float3 Model_PositionWS497_g251779 = Out_PositionWS15_g251869;
					float2 Model_PositionWS_XZ143_g251779 = (Model_PositionWS497_g251779).xz;
					float3 Model_PivotWS498_g251779 = Out_PivotWS15_g251869;
					float2 Model_PivotWS_XZ145_g251779 = (Model_PivotWS498_g251779).xz;
					float2 lerpResult300_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251798 = lerpResult300_g251779;
					float temp_output_82_0_g251796 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251798 = temp_output_82_0_g251796;
					float4 tex2DArrayNode83_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251798).zw + ( (temp_output_203_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult210_g251798 = (float4(tex2DArrayNode83_g251798.rgb , tex2DArrayNode83_g251798.a));
					float4 temp_output_204_0_g251798 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251798).zw + ( (temp_output_204_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult212_g251798 = (float4(tex2DArrayNode122_g251798.rgb , tex2DArrayNode122_g251798.a));
					float4 TVE_RenderNearPositionR628_g251779 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251779 = saturate( ( distance( Model_PositionWS497_g251779 , (TVE_RenderNearPositionR628_g251779).xyz ) / (TVE_RenderNearPositionR628_g251779).w ) );
					float temp_output_7_0_g251868 = 1.0;
					float temp_output_9_0_g251868 = ( temp_output_507_0_g251779 - temp_output_7_0_g251868 );
					half TVE_RenderNearFadeValue635_g251779 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251779 = saturate( ( temp_output_9_0_g251868 / ( ( TVE_RenderNearFadeValue635_g251779 - temp_output_7_0_g251868 ) + 0.0001 ) ) );
					float4 lerpResult131_g251798 = lerp( appendResult210_g251798 , appendResult212_g251798 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251796 = lerpResult131_g251798;
					float4 lerpResult168_g251796 = lerp( TVE_CoatParams , temp_output_159_109_g251796 , TVE_CoatLayers[(int)temp_output_82_0_g251796]);
					float4 temp_output_589_109_g251779 = lerpResult168_g251796;
					half4 Coat_Texture302_g251779 = temp_output_589_109_g251779;
					float4 In_CoatTexture204_g251779 = Coat_Texture302_g251779;
					half4 Draw_Texture656_g251779 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251779 = Draw_Texture656_g251779;
					float4 temp_output_203_0_g251823 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251823 = lerpResult85_g251779;
					float temp_output_82_0_g251820 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251823 = temp_output_82_0_g251820;
					float4 tex2DArrayNode83_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251823).zw + ( (temp_output_203_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult210_g251823 = (float4(tex2DArrayNode83_g251823.rgb , tex2DArrayNode83_g251823.a));
					float4 temp_output_204_0_g251823 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251823).zw + ( (temp_output_204_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult212_g251823 = (float4(tex2DArrayNode122_g251823.rgb , tex2DArrayNode122_g251823.a));
					float4 lerpResult131_g251823 = lerp( appendResult210_g251823 , appendResult212_g251823 , Global_TexBlend509_g251779);
					float4 temp_output_171_109_g251820 = lerpResult131_g251823;
					float4 lerpResult174_g251820 = lerp( TVE_PaintParams , temp_output_171_109_g251820 , TVE_PaintLayers[(int)temp_output_82_0_g251820]);
					float4 temp_output_595_109_g251779 = lerpResult174_g251820;
					half4 Paint_Texture71_g251779 = temp_output_595_109_g251779;
					float4 In_PaintTexture204_g251779 = Paint_Texture71_g251779;
					float4 temp_output_203_0_g251806 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251806 = lerpResult104_g251779;
					float temp_output_132_0_g251804 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251806 = temp_output_132_0_g251804;
					float4 tex2DArrayNode83_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251806).zw + ( (temp_output_203_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult210_g251806 = (float4(tex2DArrayNode83_g251806.rgb , tex2DArrayNode83_g251806.a));
					float4 temp_output_204_0_g251806 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251806).zw + ( (temp_output_204_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult212_g251806 = (float4(tex2DArrayNode122_g251806.rgb , tex2DArrayNode122_g251806.a));
					float4 lerpResult131_g251806 = lerp( appendResult210_g251806 , appendResult212_g251806 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251804 = lerpResult131_g251806;
					float4 lerpResult145_g251804 = lerp( TVE_AtmoParams , temp_output_137_109_g251804 , TVE_AtmoLayers[(int)temp_output_132_0_g251804]);
					float4 temp_output_590_110_g251779 = lerpResult145_g251804;
					half4 Atmo_Texture80_g251779 = temp_output_590_110_g251779;
					float4 In_AtmoTexture204_g251779 = Atmo_Texture80_g251779;
					float4 temp_output_203_0_g251874 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251874 = lerpResult414_g251779;
					float temp_output_132_0_g251872 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251874 = temp_output_132_0_g251872;
					float4 tex2DArrayNode83_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251874).zw + ( (temp_output_203_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult210_g251874 = (float4(tex2DArrayNode83_g251874.rgb , tex2DArrayNode83_g251874.a));
					float4 temp_output_204_0_g251874 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251874).zw + ( (temp_output_204_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult212_g251874 = (float4(tex2DArrayNode122_g251874.rgb , tex2DArrayNode122_g251874.a));
					float4 lerpResult131_g251874 = lerp( appendResult210_g251874 , appendResult212_g251874 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251872 = lerpResult131_g251874;
					float4 lerpResult145_g251872 = lerp( TVE_EffexParams , temp_output_137_109_g251872 , TVE_EffexLayers[(int)temp_output_132_0_g251872]);
					float4 temp_output_731_110_g251779 = lerpResult145_g251872;
					half4 Effex_Texture420_g251779 = temp_output_731_110_g251779;
					float4 In_EffexTexture204_g251779 = Effex_Texture420_g251779;
					float4 temp_output_203_0_g251854 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251854 = lerpResult247_g251779;
					float temp_output_82_0_g251852 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251854 = temp_output_82_0_g251852;
					float4 tex2DArrayNode83_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251854).zw + ( (temp_output_203_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult210_g251854 = (float4(tex2DArrayNode83_g251854.rgb , tex2DArrayNode83_g251854.a));
					float4 temp_output_204_0_g251854 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251854).zw + ( (temp_output_204_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult212_g251854 = (float4(tex2DArrayNode122_g251854.rgb , tex2DArrayNode122_g251854.a));
					float4 lerpResult131_g251854 = lerp( appendResult210_g251854 , appendResult212_g251854 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251852 = lerpResult131_g251854;
					float4 lerpResult167_g251852 = lerp( TVE_GlowParams , temp_output_159_109_g251852 , TVE_GlowLayers[(int)temp_output_82_0_g251852]);
					float4 temp_output_593_109_g251779 = lerpResult167_g251852;
					half4 Glow_Texture248_g251779 = temp_output_593_109_g251779;
					float4 In_GlowTexture204_g251779 = Glow_Texture248_g251779;
					float4 temp_output_203_0_g251790 = TVE_FormBaseCoord;
					float2 lerpResult168_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251790 = lerpResult168_g251779;
					float temp_output_130_0_g251788 = _GlobalFormLayerValue;
					float temp_output_82_0_g251790 = temp_output_130_0_g251788;
					float4 tex2DArrayNode83_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251790).zw + ( (temp_output_203_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult210_g251790 = (float4(tex2DArrayNode83_g251790.rgb , tex2DArrayNode83_g251790.a));
					float4 temp_output_204_0_g251790 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251790).zw + ( (temp_output_204_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult212_g251790 = (float4(tex2DArrayNode122_g251790.rgb , tex2DArrayNode122_g251790.a));
					float4 lerpResult131_g251790 = lerp( appendResult210_g251790 , appendResult212_g251790 , Global_TexBlend509_g251779);
					float4 temp_output_135_109_g251788 = lerpResult131_g251790;
					float4 lerpResult143_g251788 = lerp( TVE_FormParams , temp_output_135_109_g251788 , TVE_FormLayers[(int)temp_output_130_0_g251788]);
					float4 temp_output_592_0_g251779 = lerpResult143_g251788;
					float4 Form_Texture112_g251779 = temp_output_592_0_g251779;
					float4 In_FormTexture204_g251779 = Form_Texture112_g251779;
					float4 In_LandTexture204_g251779 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251838 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251838 = lerpResult681_g251779;
					float temp_output_136_0_g251836 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251838 = temp_output_136_0_g251836;
					float4 tex2DArrayNode83_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251838).zw + ( (temp_output_203_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult210_g251838 = (float4(tex2DArrayNode83_g251838.rgb , tex2DArrayNode83_g251838.a));
					float4 temp_output_204_0_g251838 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251838).zw + ( (temp_output_204_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult212_g251838 = (float4(tex2DArrayNode122_g251838.rgb , tex2DArrayNode122_g251838.a));
					float4 lerpResult131_g251838 = lerp( appendResult210_g251838 , appendResult212_g251838 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251836 = lerpResult131_g251838;
					float4 lerpResult149_g251836 = lerp( TVE_VertxParams , temp_output_141_109_g251836 , TVE_VertxLayers[(int)temp_output_136_0_g251836]);
					float4 temp_output_695_0_g251779 = lerpResult149_g251836;
					half4 Vertx_Texture693_g251779 = temp_output_695_0_g251779;
					float4 In_VertxTexture204_g251779 = Vertx_Texture693_g251779;
					float4 temp_output_203_0_g251814 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251814 = lerpResult400_g251779;
					float temp_output_136_0_g251812 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251814 = temp_output_136_0_g251812;
					float4 tex2DArrayNode83_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251814).zw + ( (temp_output_203_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult210_g251814 = (float4(tex2DArrayNode83_g251814.rgb , tex2DArrayNode83_g251814.a));
					float4 temp_output_204_0_g251814 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251814).zw + ( (temp_output_204_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult212_g251814 = (float4(tex2DArrayNode122_g251814.rgb , tex2DArrayNode122_g251814.a));
					float4 lerpResult131_g251814 = lerp( appendResult210_g251814 , appendResult212_g251814 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251812 = lerpResult131_g251814;
					float4 lerpResult149_g251812 = lerp( TVE_FlowParams , temp_output_141_109_g251812 , TVE_FlowLayers[(int)temp_output_136_0_g251812]);
					float4 temp_output_594_0_g251779 = lerpResult149_g251812;
					half4 Flow_Texture405_g251779 = temp_output_594_0_g251779;
					float4 In_FlowTexture204_g251779 = Flow_Texture405_g251779;
					half4 User_Texture677_g251779 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251779 = User_Texture677_g251779;
					BuildGlobalData( Data204_g251779 , In_Dummy204_g251779 , In_CoatTexture204_g251779 , In_DrawTexture204_g251779 , In_PaintTexture204_g251779 , In_AtmoTexture204_g251779 , In_EffexTexture204_g251779 , In_GlowTexture204_g251779 , In_FormTexture204_g251779 , In_LandTexture204_g251779 , In_VertxTexture204_g251779 , In_FlowTexture204_g251779 , In_UserTexture204_g251779 );
					TVEGlobalData Data15_g252042 =(TVEGlobalData)Data204_g251779;
					float Out_Dummy15_g252042 = 0.0;
					float4 Out_CoatTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252042 = float4( 0,0,0,0 );
					BreakData( Data15_g252042 , Out_Dummy15_g252042 , Out_CoatTexture15_g252042 , Out_DrawTexture15_g252042 , Out_PaintTexture15_g252042 , Out_AtmoTexture15_g252042 , Out_EffexTexture15_g252042 , Out_GlowTexture15_g252042 , Out_FormTexture15_g252042 , Out_LandTexture15_g252042 , Out_VertxTexture15_g252042 , Out_FlowTexture15_g252042 , Out_UserTexture15_g252042 );
					float4 Global_FormTexture351_g252032 = Out_FormTexture15_g252042;
					TVEModelData Data15_g252039 =(TVEModelData)Data15_g252030;
					float Out_Dummy15_g252039 = 0.0;
					float3 Out_PositionOS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252039 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252039 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252039 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252039 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252039 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252039 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252039 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252039 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252039 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252039 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252039 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252039 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252039 , Out_Dummy15_g252039 , Out_PositionOS15_g252039 , Out_PositionWS15_g252039 , Out_PositionWO15_g252039 , Out_PositionRawOS15_g252039 , Out_PivotOS15_g252039 , Out_PivotWS15_g252039 , Out_PivotWO15_g252039 , Out_NormalOS15_g252039 , Out_NormalWS15_g252039 , Out_NormalRawOS15_g252039 , Out_TangentOS15_g252039 , Out_TangentWS15_g252039 , Out_BitangentWS15_g252039 , Out_ViewDirWS15_g252039 , Out_CoordsData15_g252039 , Out_VertexData15_g252039 , Out_MasksData15_g252039 , Out_PhaseData15_g252039 , Out_TransformData15_g252039 , Out_RotationData15_g252039 , Out_Interpolator15_g252039 );
					float3 Model_PivotWO353_g252032 = Out_PivotWO15_g252039;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g252038 = _ConformMeshMode;
					float Option70_g252038 = temp_output_17_0_g252038;
					half4 Model_VertexData357_g252032 = Out_VertexData15_g252039;
					float4 temp_output_3_0_g252038 = Model_VertexData357_g252032;
					float4 Channel70_g252038 = temp_output_3_0_g252038;
					float localSwitchChannel470_g252038 = SwitchChannel4( Option70_g252038 , Channel70_g252038 );
					float temp_output_390_0_g252032 = localSwitchChannel470_g252038;
					float temp_output_7_0_g252035 = _ConformMeshRemap.x;
					float temp_output_9_0_g252035 = ( temp_output_390_0_g252032 - temp_output_7_0_g252035 );
					float lerpResult374_g252032 = lerp( 1.0 , saturate( ( temp_output_9_0_g252035 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g252032 = lerpResult374_g252032;
					float temp_output_328_0_g252032 = ( Blend_VertMask379_g252032 * TVE_IsEnabled );
					half Conform_Mask366_g252032 = temp_output_328_0_g252032;
					float temp_output_322_0_g252032 = ( ( ( ( (Global_FormTexture351_g252032).z - ( (Model_PivotWO353_g252032).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g252032 ) );
					float3 appendResult329_g252032 = (float3(0.0 , temp_output_322_0_g252032 , 0.0));
					float3 appendResult387_g252032 = (float3(0.0 , 0.0 , temp_output_322_0_g252032));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252036 = appendResult387_g252032;
					#else
					float3 staticSwitch65_g252036 = appendResult329_g252032;
					#endif
					float3 Blanket_Conform368_g252032 = staticSwitch65_g252036;
					float4 appendResult312_g252032 = (float4(Blanket_Conform368_g252032 , 0.0));
					float4 temp_output_310_0_g252032 = ( Model_TransformData356_g252032 + appendResult312_g252032 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g252032 = temp_output_310_0_g252032;
					#else
					float4 staticSwitch364_g252032 = Model_TransformData356_g252032;
					#endif
					half4 Final_TransformData365_g252032 = staticSwitch364_g252032;
					float4 In_TransformData16_g252041 = Final_TransformData365_g252032;
					float4 In_RotationData16_g252041 = Out_RotationData15_g252040;
					float4 In_Interpolator16_g252041 = Out_Interpolator15_g252040;
					BuildVertexData( Data16_g252041 , In_Dummy16_g252041 , In_PositionOS16_g252041 , In_NormalOS16_g252041 , In_TangentOS16_g252041 , In_TransformData16_g252041 , In_RotationData16_g252041 , In_Interpolator16_g252041 );
					TVEVertexData Data15_g252052 =(TVEVertexData)Data16_g252041;
					float Out_Dummy15_g252052 = 0.0;
					float3 Out_PositionOS15_g252052 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252052 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252052 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252052 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252052 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252052 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252052 , Out_Dummy15_g252052 , Out_PositionOS15_g252052 , Out_NormalOS15_g252052 , Out_TangentOS15_g252052 , Out_TransformData15_g252052 , Out_RotationData15_g252052 , Out_Interpolator15_g252052 );
					TVEVertexData Data16_g252053 =(TVEVertexData)Data15_g252052;
					float In_Dummy16_g252053 = 0.0;
					float3 Vertex_PositionOS147_g252043 = Out_PositionOS15_g252052;
					half3 VertexPos40_g252047 = Vertex_PositionOS147_g252043;
					float4 temp_output_1615_33_g252043 = Out_RotationData15_g252052;
					half4 Vertex_RotationData1569_g252043 = temp_output_1615_33_g252043;
					float2 break1582_g252043 = (Vertex_RotationData1569_g252043).xy;
					half Angle44_g252047 = break1582_g252043.y;
					half CosAngle89_g252047 = cos( Angle44_g252047 );
					half SinAngle93_g252047 = sin( Angle44_g252047 );
					float3 appendResult95_g252047 = (float3((VertexPos40_g252047).x , ( ( (VertexPos40_g252047).y * CosAngle89_g252047 ) - ( (VertexPos40_g252047).z * SinAngle93_g252047 ) ) , ( ( (VertexPos40_g252047).y * SinAngle93_g252047 ) + ( (VertexPos40_g252047).z * CosAngle89_g252047 ) )));
					half3 VertexPos40_g252048 = appendResult95_g252047;
					half Angle44_g252048 = -break1582_g252043.x;
					half CosAngle94_g252048 = cos( Angle44_g252048 );
					half SinAngle95_g252048 = sin( Angle44_g252048 );
					float3 appendResult98_g252048 = (float3(( ( (VertexPos40_g252048).x * CosAngle94_g252048 ) - ( (VertexPos40_g252048).y * SinAngle95_g252048 ) ) , ( ( (VertexPos40_g252048).x * SinAngle95_g252048 ) + ( (VertexPos40_g252048).y * CosAngle94_g252048 ) ) , (VertexPos40_g252048).z));
					half3 VertexPos40_g252046 = Vertex_PositionOS147_g252043;
					half Angle44_g252046 = break1582_g252043.y;
					half CosAngle89_g252046 = cos( Angle44_g252046 );
					half SinAngle93_g252046 = sin( Angle44_g252046 );
					float3 appendResult95_g252046 = (float3((VertexPos40_g252046).x , ( ( (VertexPos40_g252046).y * CosAngle89_g252046 ) - ( (VertexPos40_g252046).z * SinAngle93_g252046 ) ) , ( ( (VertexPos40_g252046).y * SinAngle93_g252046 ) + ( (VertexPos40_g252046).z * CosAngle89_g252046 ) )));
					half3 VertexPos40_g252051 = appendResult95_g252046;
					half Angle44_g252051 = break1582_g252043.x;
					half CosAngle91_g252051 = cos( Angle44_g252051 );
					half SinAngle92_g252051 = sin( Angle44_g252051 );
					float3 appendResult93_g252051 = (float3(( ( (VertexPos40_g252051).x * CosAngle91_g252051 ) + ( (VertexPos40_g252051).z * SinAngle92_g252051 ) ) , (VertexPos40_g252051).y , ( ( -(VertexPos40_g252051).x * SinAngle92_g252051 ) + ( (VertexPos40_g252051).z * CosAngle91_g252051 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252049 = appendResult93_g252051;
					#else
					float3 staticSwitch65_g252049 = appendResult98_g252048;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g252044 = staticSwitch65_g252049;
					#else
					float3 staticSwitch65_g252044 = Vertex_PositionOS147_g252043;
					#endif
					float3 temp_output_1608_0_g252043 = staticSwitch65_g252044;
					half3 VertexPos40_g252050 = temp_output_1608_0_g252043;
					half Angle44_g252050 = (Vertex_RotationData1569_g252043).z;
					half CosAngle91_g252050 = cos( Angle44_g252050 );
					half SinAngle92_g252050 = sin( Angle44_g252050 );
					float3 appendResult93_g252050 = (float3(( ( (VertexPos40_g252050).x * CosAngle91_g252050 ) + ( (VertexPos40_g252050).z * SinAngle92_g252050 ) ) , (VertexPos40_g252050).y , ( ( -(VertexPos40_g252050).x * SinAngle92_g252050 ) + ( (VertexPos40_g252050).z * CosAngle91_g252050 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g252045 = appendResult93_g252050;
					#else
					float3 staticSwitch65_g252045 = temp_output_1608_0_g252043;
					#endif
					float4 temp_output_1615_31_g252043 = Out_TransformData15_g252052;
					half4 Vertex_TransformData1568_g252043 = temp_output_1615_31_g252043;
					half3 Final_PositionOS178_g252043 = ( ( staticSwitch65_g252045 * (Vertex_TransformData1568_g252043).w ) + (Vertex_TransformData1568_g252043).xyz );
					float3 In_PositionOS16_g252053 = Final_PositionOS178_g252043;
					float3 In_NormalOS16_g252053 = Out_NormalOS15_g252052;
					float4 In_TangentOS16_g252053 = Out_TangentOS15_g252052;
					float4 In_TransformData16_g252053 = temp_output_1615_31_g252043;
					float4 In_RotationData16_g252053 = temp_output_1615_33_g252043;
					float4 In_Interpolator16_g252053 = Out_Interpolator15_g252052;
					BuildVertexData( Data16_g252053 , In_Dummy16_g252053 , In_PositionOS16_g252053 , In_NormalOS16_g252053 , In_TangentOS16_g252053 , In_TransformData16_g252053 , In_RotationData16_g252053 , In_Interpolator16_g252053 );
					TVEVertexData Data15_g252056 =(TVEVertexData)Data16_g252053;
					float Out_Dummy15_g252056 = 0.0;
					float3 Out_PositionOS15_g252056 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252056 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252056 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252056 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252056 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252056 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252056 , Out_Dummy15_g252056 , Out_PositionOS15_g252056 , Out_NormalOS15_g252056 , Out_TangentOS15_g252056 , Out_TransformData15_g252056 , Out_RotationData15_g252056 , Out_Interpolator15_g252056 );
					TVEVertexData Data16_g252057 =(TVEVertexData)Data15_g252056;
					float In_Dummy16_g252057 = 0.0;
					TVEModelData Data15_g252055 =(TVEModelData)Data15_g252039;
					float Out_Dummy15_g252055 = 0.0;
					float3 Out_PositionOS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252055 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252055 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252055 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252055 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252055 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252055 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252055 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252055 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252055 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252055 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252055 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252055 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252055 , Out_Dummy15_g252055 , Out_PositionOS15_g252055 , Out_PositionWS15_g252055 , Out_PositionWO15_g252055 , Out_PositionRawOS15_g252055 , Out_PivotOS15_g252055 , Out_PivotWS15_g252055 , Out_PivotWO15_g252055 , Out_NormalOS15_g252055 , Out_NormalWS15_g252055 , Out_NormalRawOS15_g252055 , Out_TangentOS15_g252055 , Out_TangentWS15_g252055 , Out_BitangentWS15_g252055 , Out_ViewDirWS15_g252055 , Out_CoordsData15_g252055 , Out_VertexData15_g252055 , Out_MasksData15_g252055 , Out_PhaseData15_g252055 , Out_TransformData15_g252055 , Out_RotationData15_g252055 , Out_Interpolator15_g252055 );
					float3 In_PositionOS16_g252057 = ( Out_PositionOS15_g252056 + Out_PivotOS15_g252055 );
					float3 In_NormalOS16_g252057 = Out_NormalOS15_g252056;
					float4 In_TangentOS16_g252057 = Out_TangentOS15_g252056;
					float4 In_TransformData16_g252057 = Out_TransformData15_g252056;
					float4 In_RotationData16_g252057 = Out_RotationData15_g252056;
					float4 In_Interpolator16_g252057 = Out_Interpolator15_g252056;
					BuildVertexData( Data16_g252057 , In_Dummy16_g252057 , In_PositionOS16_g252057 , In_NormalOS16_g252057 , In_TangentOS16_g252057 , In_TransformData16_g252057 , In_RotationData16_g252057 , In_Interpolator16_g252057 );
					TVEVertexData Data15_g252574 =(TVEVertexData)Data16_g252057;
					float Out_Dummy15_g252574 = 0.0;
					float3 Out_PositionOS15_g252574 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252574 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252574 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252574 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252574 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252574 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252574 , Out_Dummy15_g252574 , Out_PositionOS15_g252574 , Out_NormalOS15_g252574 , Out_TangentOS15_g252574 , Out_TransformData15_g252574 , Out_RotationData15_g252574 , Out_Interpolator15_g252574 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g251759;
					o.ase_texcoord7.xyz = vertexToFrag76_g251759;
					TVEVertexData Data1902_g252254 = Data16_g252057;
					float4 Out_Interpolator1902_g252254 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g252254 = Data1902_g252254.Interpolator;
					}
					float4 vertexToFrag1901_g252254 = Out_Interpolator1902_g252254;
					o.ase_texcoord9 = vertexToFrag1901_g252254;
					float3 vertexPos57_g252566 = v.vertex.xyz;
					float4 ase_positionCS57_g252566 = UnityObjectToClipPos( vertexPos57_g252566 );
					o.ase_texcoord10 = ase_positionCS57_g252566;
					
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
					float3 vertexValue = Out_PositionOS15_g252574;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g252574;
					v.tangent = Out_TangentOS15_g252574;

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

					float temp_output_2672_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2672_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2672_114).xxx;
					
					float3 color130_g252566 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g252566 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g252568 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g252567 = ( temp_cast_4 * ( 0.5 + appendResult128_g252568 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g252567 = (float4(ddx( FinalUV13_g252567 ) , ddy( FinalUV13_g252567 )));
					float4 UVDerivatives17_g252567 = appendResult16_g252567;
					float4 break28_g252567 = UVDerivatives17_g252567;
					float2 appendResult19_g252567 = (float2(break28_g252567.x , break28_g252567.z));
					float2 appendResult20_g252567 = (float2(break28_g252567.x , break28_g252567.z));
					float dotResult24_g252567 = dot( appendResult19_g252567 , appendResult20_g252567 );
					float2 appendResult21_g252567 = (float2(break28_g252567.y , break28_g252567.w));
					float2 appendResult22_g252567 = (float2(break28_g252567.y , break28_g252567.w));
					float dotResult23_g252567 = dot( appendResult21_g252567 , appendResult22_g252567 );
					float2 appendResult25_g252567 = (float2(dotResult24_g252567 , dotResult23_g252567));
					float2 derivativesLength29_g252567 = sqrt( appendResult25_g252567 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g252567 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g252567 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g252567 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g252567 = clampResult57_g252567;
					float2 break55_g252567 = derivativesLength29_g252567;
					float4 lerpResult73_g252567 = lerp( float4( color130_g252566 , 0.0 ) , float4( color81_g252566 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g252567.x * break71_g252567.y * sqrt( saturate( ( 1.1 - max( break55_g252567.x, break55_g252567.y ) ) ) ) ) ) ));
					float3 color107_g252558 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252558 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g252557 = ( 0.0 );
					float localIfMasksData25_g252556 = ( 0.0 );
					TVEMasksData Data25_g252556 = (TVEMasksData)0;
					float localBuildMasksData3_g252499 = ( 0.0 );
					TVEMasksData Data3_g252499 = (TVEMasksData)0;
					half Feature_Intensity508_g252472 = _TintingIntensityValue;
					float ifLocalVar18_g252500 = 0;
					if( Feature_Intensity508_g252472 <= 0.0 )
					ifLocalVar18_g252500 = 0.0;
					else
					ifLocalVar18_g252500 = 1.0;
					half Feature_Element505_g252472 = _TintingPaintMode;
					float ifLocalVar18_g252501 = 0;
					if( Feature_Element505_g252472 <= 0.0 )
					ifLocalVar18_g252501 = 0.0;
					else
					ifLocalVar18_g252501 = 1.0;
					float4 appendResult517_g252472 = (float4(ifLocalVar18_g252500 , 0.0 , 0.0 , ifLocalVar18_g252501));
					float4 In_MaskA3_g252499 = appendResult517_g252472;
					half Blend_TexMask385_g252472 = 1.0;
					float localBreakVisualData4_g252496 = ( 0.0 );
					float localBuildVisualData3_g252260 = ( 0.0 );
					float localBuildVisualData3_g252255 = ( 0.0 );
					TVEVisualData Data3_g252255 =(TVEVisualData)0;
					float temp_output_14_0_g252255 = 0.0;
					float In_Dummy3_g252255 = temp_output_14_0_g252255;
					float3 temp_cast_9 = (0.5).xxx;
					float3 temp_output_4_0_g252255 = temp_cast_9;
					float3 In_Albedo3_g252255 = temp_output_4_0_g252255;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_44_0_g252255 = temp_cast_10;
					float3 In_AlbedoBase3_g252255 = temp_output_44_0_g252255;
					float2 temp_cast_11 = (0.0).xx;
					float2 In_NormalTS3_g252255 = temp_cast_11;
					float3 temp_cast_12 = (0.5).xxx;
					float3 In_NormalWS3_g252255 = temp_cast_12;
					float4 In_Shader3_g252255 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g252255 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252255 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252255 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g252255 = 0.5;
					float In_Grayscale3_g252255 = temp_output_12_0_g252255;
					float temp_output_16_0_g252255 = 1.0;
					float In_Luminosity3_g252255 = temp_output_16_0_g252255;
					float In_MultiMask3_g252255 = 1.0;
					float In_AlphaClip3_g252255 = 1.0;
					float In_AlphaFade3_g252255 = 1.0;
					float3 temp_cast_13 = (1.0).xxx;
					float3 In_Translucency3_g252255 = temp_cast_13;
					float In_Transmission3_g252255 = 1.0;
					float In_Thickness3_g252255 = 0.0;
					float In_Diffusion3_g252255 = 0.0;
					float In_Depth3_g252255 = 0.0;
					BuildVisualData( Data3_g252255 , In_Dummy3_g252255 , In_Albedo3_g252255 , In_AlbedoBase3_g252255 , In_NormalTS3_g252255 , In_NormalWS3_g252255 , In_Shader3_g252255 , In_Feature3_g252255 , In_Season3_g252255 , In_Emissive3_g252255 , In_Grayscale3_g252255 , In_Luminosity3_g252255 , In_MultiMask3_g252255 , In_AlphaClip3_g252255 , In_AlphaFade3_g252255 , In_Translucency3_g252255 , In_Transmission3_g252255 , In_Thickness3_g252255 , In_Diffusion3_g252255 , In_Depth3_g252255 );
					TVEVisualData Data3_g252260 =(TVEVisualData)Data3_g252255;
					half Dummy130_g252258 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g252260 = Dummy130_g252258;
					float In_Dummy3_g252260 = temp_output_14_0_g252260;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252281) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g252263 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g252281 = staticSwitch36_g252263;
					float localBreakTextureData456_g252281 = ( 0.0 );
					float localBuildTextureData431_g252280 = ( 0.0 );
					TVEMasksData Data431_g252280 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252280 = ( 0.0 );
					float4 temp_output_6_0_g252296 = _main_coord_value;
					float4 temp_output_7_0_g252296 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252296 = ( temp_output_6_0_g252296 + temp_output_7_0_g252296 );
					#else
					float4 staticSwitch14_g252296 = temp_output_6_0_g252296;
					#endif
					half4 Local_Coords180_g252258 = staticSwitch14_g252296;
					float4 Coords444_g252280 = Local_Coords180_g252258;
					TVEModelData Data16_g251767 =(TVEModelData)0;
					float In_Dummy16_g251767 = 0.0;
					float3 vertexToFrag73_g251759 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g251759 = vertexToFrag73_g251759;
					float3 In_PositionWS16_g251767 = PositionWS122_g251759;
					float3 vertexToFrag76_g251759 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g251759 = vertexToFrag76_g251759;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251759 = ( PositionWS122_g251759 - PivotWS121_g251759 );
					#else
					float3 staticSwitch204_g251759 = PositionWS122_g251759;
					#endif
					float3 PositionWO132_g251759 = ( staticSwitch204_g251759 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251767 = PositionWO132_g251759;
					float3 In_PivotWS16_g251767 = PivotWS121_g251759;
					float3 PivotWO133_g251759 = ( PivotWS121_g251759 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251767 = PivotWO133_g251759;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g251759 = normalizedWorldNormal;
					float3 In_NormalWS16_g251767 = NormalWS95_g251759;
					half3 TangentWS136_g251759 = TangentWS;
					float3 In_TangentWS16_g251767 = TangentWS136_g251759;
					half3 BiangentWS421_g251759 = BitangentWS;
					float3 In_BitangentWS16_g251767 = BiangentWS421_g251759;
					half3 NormalWS427_g251759 = NormalWS95_g251759;
					half3 localComputeTriplanarMasks427_g251759 = ComputeTriplanarMasks( NormalWS427_g251759 );
					half3 TriplanarWeights429_g251759 = localComputeTriplanarMasks427_g251759;
					float3 In_TriplanarWeights16_g251767 = TriplanarWeights429_g251759;
					float3 normalizeResult296_g251759 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251759 ) );
					half3 ViewDirWS169_g251759 = normalizeResult296_g251759;
					float3 In_ViewDirWS16_g251767 = ViewDirWS169_g251759;
					float4 appendResult397_g251759 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g251759 = appendResult397_g251759;
					float4 In_CoordsData16_g251767 = CoordsData398_g251759;
					half4 VertexMasks171_g251759 = IN.ase_color;
					float4 In_VertexData16_g251767 = VertexMasks171_g251759;
					float temp_output_17_0_g251770 = _ObjectPhaseMode;
					float Option70_g251770 = temp_output_17_0_g251770;
					float4 temp_output_3_0_g251770 = IN.ase_color;
					float4 Channel70_g251770 = temp_output_3_0_g251770;
					float localSwitchChannel470_g251770 = SwitchChannel4( Option70_g251770 , Channel70_g251770 );
					half Phase_Value372_g251759 = localSwitchChannel470_g251770;
					float3 break319_g251759 = PivotWO133_g251759;
					half Pivot_Position322_g251759 = ( break319_g251759.x + break319_g251759.z );
					half Phase_Position357_g251759 = ( Phase_Value372_g251759 + Pivot_Position322_g251759 );
					float temp_output_248_0_g251759 = frac( Phase_Position357_g251759 );
					float4 appendResult177_g251759 = (float4((frac( ( Phase_Position357_g251759 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251759));
					half4 Phase_Data176_g251759 = appendResult177_g251759;
					float4 In_Interpolator16_g251767 = Phase_Data176_g251759;
					BuildModelFragData( Data16_g251767 , In_Dummy16_g251767 , In_PositionWS16_g251767 , In_PositionWO16_g251767 , In_PivotWS16_g251767 , In_PivotWO16_g251767 , In_NormalWS16_g251767 , In_TangentWS16_g251767 , In_BitangentWS16_g251767 , In_TriplanarWeights16_g251767 , In_ViewDirWS16_g251767 , In_CoordsData16_g251767 , In_VertexData16_g251767 , In_Interpolator16_g251767 );
					TVEModelData Data15_g252256 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g252256 = 0.0;
					float3 Out_PositionWS15_g252256 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252256 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252256 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252256 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252256 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252256 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252256 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252256 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252256 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252256 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252256 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252256 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252256 , Out_Dummy15_g252256 , Out_PositionWS15_g252256 , Out_PositionWO15_g252256 , Out_PivotWS15_g252256 , Out_PivotWO15_g252256 , Out_NormalWS15_g252256 , Out_TangentWS15_g252256 , Out_BitangentWS15_g252256 , Out_TriplanarWeights15_g252256 , Out_ViewDirWS15_g252256 , Out_CoordsData15_g252256 , Out_VertexData15_g252256 , Out_Interpolator15_g252256 );
					TVEModelData Data16_g252257 =(TVEModelData)Data15_g252256;
					float In_Dummy16_g252257 = Out_Dummy15_g252256;
					float3 In_PositionWS16_g252257 = Out_PositionWS15_g252256;
					float3 In_PositionWO16_g252257 = Out_PositionWO15_g252256;
					float3 In_PivotWS16_g252257 = Out_PivotWS15_g252256;
					float3 In_PivotWO16_g252257 = Out_PivotWO15_g252256;
					float3 In_NormalWS16_g252257 = Out_NormalWS15_g252256;
					float3 In_TangentWS16_g252257 = Out_TangentWS15_g252256;
					float3 In_BitangentWS16_g252257 = Out_BitangentWS15_g252256;
					float3 In_TriplanarWeights16_g252257 = Out_TriplanarWeights15_g252256;
					float3 In_ViewDirWS16_g252257 = Out_ViewDirWS15_g252256;
					float4 In_CoordsData16_g252257 = Out_CoordsData15_g252256;
					float4 In_VertexData16_g252257 = Out_VertexData15_g252256;
					float4 vertexToFrag1901_g252254 = IN.ase_texcoord9;
					float4 In_Interpolator16_g252257 = vertexToFrag1901_g252254;
					BuildModelFragData( Data16_g252257 , In_Dummy16_g252257 , In_PositionWS16_g252257 , In_PositionWO16_g252257 , In_PivotWS16_g252257 , In_PivotWO16_g252257 , In_NormalWS16_g252257 , In_TangentWS16_g252257 , In_BitangentWS16_g252257 , In_TriplanarWeights16_g252257 , In_ViewDirWS16_g252257 , In_CoordsData16_g252257 , In_VertexData16_g252257 , In_Interpolator16_g252257 );
					TVEModelData Data15_g252259 =(TVEModelData)Data16_g252257;
					float Out_Dummy15_g252259 = 0.0;
					float3 Out_PositionWS15_g252259 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252259 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252259 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252259 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252259 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252259 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252259 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252259 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252259 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252259 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252259 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252259 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252259 , Out_Dummy15_g252259 , Out_PositionWS15_g252259 , Out_PositionWO15_g252259 , Out_PivotWS15_g252259 , Out_PivotWO15_g252259 , Out_NormalWS15_g252259 , Out_TangentWS15_g252259 , Out_BitangentWS15_g252259 , Out_TriplanarWeights15_g252259 , Out_ViewDirWS15_g252259 , Out_CoordsData15_g252259 , Out_VertexData15_g252259 , Out_Interpolator15_g252259 );
					float4 Model_CoordsData324_g252258 = Out_CoordsData15_g252259;
					float4 MeshCoords444_g252280 = Model_CoordsData324_g252258;
					float2 UV0444_g252280 = float2( 0,0 );
					float2 UV3444_g252280 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252280 , MeshCoords444_g252280 , UV0444_g252280 , UV3444_g252280 );
					float4 appendResult430_g252280 = (float4(UV0444_g252280 , UV3444_g252280));
					float4 In_MaskA431_g252280 = appendResult430_g252280;
					float localComputeWorldCoords315_g252280 = ( 0.0 );
					float4 Coords315_g252280 = Local_Coords180_g252258;
					float3 Model_PositionWO222_g252258 = Out_PositionWO15_g252259;
					float3 PositionWS315_g252280 = Model_PositionWO222_g252258;
					float2 ZY315_g252280 = float2( 0,0 );
					float2 XZ315_g252280 = float2( 0,0 );
					float2 XY315_g252280 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252280 , PositionWS315_g252280 , ZY315_g252280 , XZ315_g252280 , XY315_g252280 );
					float2 ZY402_g252280 = ZY315_g252280;
					float2 XZ403_g252280 = XZ315_g252280;
					float4 appendResult432_g252280 = (float4(ZY402_g252280 , XZ403_g252280));
					float4 In_MaskB431_g252280 = appendResult432_g252280;
					float2 XY404_g252280 = XY315_g252280;
					float localComputeStochasticCoords409_g252280 = ( 0.0 );
					float2 UV409_g252280 = ZY402_g252280;
					float2 UV1409_g252280 = float2( 0,0 );
					float2 UV2409_g252280 = float2( 0,0 );
					float2 UV3409_g252280 = float2( 0,0 );
					float3 Weights409_g252280 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252280 , UV1409_g252280 , UV2409_g252280 , UV3409_g252280 , Weights409_g252280 );
					float4 appendResult433_g252280 = (float4(XY404_g252280 , UV1409_g252280));
					float4 In_MaskC431_g252280 = appendResult433_g252280;
					float4 appendResult434_g252280 = (float4(UV2409_g252280 , UV3409_g252280));
					float4 In_MaskD431_g252280 = appendResult434_g252280;
					float localComputeStochasticCoords422_g252280 = ( 0.0 );
					float2 UV422_g252280 = XZ403_g252280;
					float2 UV1422_g252280 = float2( 0,0 );
					float2 UV2422_g252280 = float2( 0,0 );
					float2 UV3422_g252280 = float2( 0,0 );
					float3 Weights422_g252280 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252280 , UV1422_g252280 , UV2422_g252280 , UV3422_g252280 , Weights422_g252280 );
					float4 appendResult435_g252280 = (float4(UV1422_g252280 , UV2422_g252280));
					float4 In_MaskE431_g252280 = appendResult435_g252280;
					float localComputeStochasticCoords423_g252280 = ( 0.0 );
					float2 UV423_g252280 = XY404_g252280;
					float2 UV1423_g252280 = float2( 0,0 );
					float2 UV2423_g252280 = float2( 0,0 );
					float2 UV3423_g252280 = float2( 0,0 );
					float3 Weights423_g252280 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252280 , UV1423_g252280 , UV2423_g252280 , UV3423_g252280 , Weights423_g252280 );
					float4 appendResult436_g252280 = (float4(UV3422_g252280 , UV1423_g252280));
					float4 In_MaskF431_g252280 = appendResult436_g252280;
					float4 appendResult437_g252280 = (float4(UV2423_g252280 , UV3423_g252280));
					float4 In_MaskG431_g252280 = appendResult437_g252280;
					float4 In_MaskH431_g252280 = float4( Weights409_g252280 , 0.0 );
					float4 In_MaskI431_g252280 = float4( Weights422_g252280 , 0.0 );
					float4 In_MaskJ431_g252280 = float4( Weights423_g252280 , 0.0 );
					half3 Model_NormalWS226_g252258 = Out_NormalWS15_g252259;
					float3 temp_output_449_0_g252280 = Model_NormalWS226_g252258;
					float4 In_MaskK431_g252280 = float4( temp_output_449_0_g252280 , 0.0 );
					half3 Model_TangentWS366_g252258 = Out_TangentWS15_g252259;
					float3 temp_output_450_0_g252280 = Model_TangentWS366_g252258;
					float4 In_MaskL431_g252280 = float4( temp_output_450_0_g252280 , 0.0 );
					half3 Model_BitangentWS367_g252258 = Out_BitangentWS15_g252259;
					float3 temp_output_451_0_g252280 = Model_BitangentWS367_g252258;
					float4 In_MaskM431_g252280 = float4( temp_output_451_0_g252280 , 0.0 );
					half3 Model_TriplanarWeights368_g252258 = Out_TriplanarWeights15_g252259;
					float3 temp_output_445_0_g252280 = Model_TriplanarWeights368_g252258;
					float4 In_MaskN431_g252280 = float4( temp_output_445_0_g252280 , 0.0 );
					BuildTextureData( Data431_g252280 , In_MaskA431_g252280 , In_MaskB431_g252280 , In_MaskC431_g252280 , In_MaskD431_g252280 , In_MaskE431_g252280 , In_MaskF431_g252280 , In_MaskG431_g252280 , In_MaskH431_g252280 , In_MaskI431_g252280 , In_MaskJ431_g252280 , In_MaskK431_g252280 , In_MaskL431_g252280 , In_MaskM431_g252280 , In_MaskN431_g252280 );
					TVEMasksData Data456_g252281 =(TVEMasksData)Data431_g252280;
					float4 Out_MaskA456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252281 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252281 , Out_MaskA456_g252281 , Out_MaskB456_g252281 , Out_MaskC456_g252281 , Out_MaskD456_g252281 , Out_MaskE456_g252281 , Out_MaskF456_g252281 , Out_MaskG456_g252281 , Out_MaskH456_g252281 , Out_MaskI456_g252281 , Out_MaskJ456_g252281 , Out_MaskK456_g252281 , Out_MaskL456_g252281 , Out_MaskM456_g252281 , Out_MaskN456_g252281 );
					half2 UV276_g252281 = (Out_MaskA456_g252281).xy;
					float temp_output_504_0_g252281 = 0.0;
					half Bias276_g252281 = temp_output_504_0_g252281;
					half2 Normal276_g252281 = float2( 0,0 );
					half4 localSampleCoord276_g252281 = SampleCoord( Texture276_g252281 , Sampler276_g252281 , UV276_g252281 , Bias276_g252281 , Normal276_g252281 );
					float4 temp_output_407_277_g252258 = localSampleCoord276_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252281) = _MainAlbedoTex;
					SamplerState Sampler502_g252281 = staticSwitch36_g252263;
					half2 UV502_g252281 = (Out_MaskA456_g252281).zw;
					half Bias502_g252281 = temp_output_504_0_g252281;
					half2 Normal502_g252281 = float2( 0,0 );
					half4 localSampleCoord502_g252281 = SampleCoord( Texture502_g252281 , Sampler502_g252281 , UV502_g252281 , Bias502_g252281 , Normal502_g252281 );
					float4 temp_output_407_278_g252258 = localSampleCoord502_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252281) = _MainAlbedoTex;
					SamplerState Sampler496_g252281 = staticSwitch36_g252263;
					float2 temp_output_463_0_g252281 = (Out_MaskB456_g252281).zw;
					half2 XZ496_g252281 = temp_output_463_0_g252281;
					half Bias496_g252281 = temp_output_504_0_g252281;
					half3 NormalWS512_g252281 = (Out_MaskK456_g252281).xyz;
					half3 NormalWS496_g252281 = NormalWS512_g252281;
					half3 Normal496_g252281 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252281 = SamplePlanar2D( Texture496_g252281 , Sampler496_g252281 , XZ496_g252281 , Bias496_g252281 , NormalWS496_g252281 , Normal496_g252281 );
					float4 temp_output_407_0_g252258 = localSamplePlanar2D496_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252281) = _MainAlbedoTex;
					SamplerState Sampler490_g252281 = staticSwitch36_g252263;
					float2 temp_output_462_0_g252281 = (Out_MaskB456_g252281).xy;
					half2 ZY490_g252281 = temp_output_462_0_g252281;
					half2 XZ490_g252281 = temp_output_463_0_g252281;
					float2 temp_output_464_0_g252281 = (Out_MaskC456_g252281).xy;
					half2 XY490_g252281 = temp_output_464_0_g252281;
					half Bias490_g252281 = temp_output_504_0_g252281;
					half3 Triplanar522_g252281 = (Out_MaskN456_g252281).xyz;
					half3 Triplanar490_g252281 = Triplanar522_g252281;
					half3 NormalWS490_g252281 = NormalWS512_g252281;
					half3 Normal490_g252281 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252281 = SamplePlanar3D( Texture490_g252281 , Sampler490_g252281 , ZY490_g252281 , XZ490_g252281 , XY490_g252281 , Bias490_g252281 , Triplanar490_g252281 , NormalWS490_g252281 , Normal490_g252281 );
					float4 temp_output_407_201_g252258 = localSamplePlanar3D490_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252281) = _MainAlbedoTex;
					SamplerState Sampler498_g252281 = staticSwitch36_g252263;
					half2 XZ498_g252281 = temp_output_463_0_g252281;
					float2 temp_output_473_0_g252281 = (Out_MaskE456_g252281).xy;
					half2 XZ_1498_g252281 = temp_output_473_0_g252281;
					float2 temp_output_474_0_g252281 = (Out_MaskE456_g252281).zw;
					half2 XZ_2498_g252281 = temp_output_474_0_g252281;
					float2 temp_output_475_0_g252281 = (Out_MaskF456_g252281).xy;
					half2 XZ_3498_g252281 = temp_output_475_0_g252281;
					float temp_output_510_0_g252281 = exp2( temp_output_504_0_g252281 );
					half Bias498_g252281 = temp_output_510_0_g252281;
					float3 temp_output_480_0_g252281 = (Out_MaskI456_g252281).xyz;
					half3 Weights_2498_g252281 = temp_output_480_0_g252281;
					half3 NormalWS498_g252281 = NormalWS512_g252281;
					half3 Normal498_g252281 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252281 = SampleStochastic2D( Texture498_g252281 , Sampler498_g252281 , XZ498_g252281 , XZ_1498_g252281 , XZ_2498_g252281 , XZ_3498_g252281 , Bias498_g252281 , Weights_2498_g252281 , NormalWS498_g252281 , Normal498_g252281 );
					float4 temp_output_407_202_g252258 = localSampleStochastic2D498_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252281) = _MainAlbedoTex;
					SamplerState Sampler500_g252281 = staticSwitch36_g252263;
					half2 ZY500_g252281 = temp_output_462_0_g252281;
					half2 ZY_1500_g252281 = (Out_MaskC456_g252281).zw;
					half2 ZY_2500_g252281 = (Out_MaskD456_g252281).xy;
					half2 ZY_3500_g252281 = (Out_MaskD456_g252281).zw;
					half2 XZ500_g252281 = temp_output_463_0_g252281;
					half2 XZ_1500_g252281 = temp_output_473_0_g252281;
					half2 XZ_2500_g252281 = temp_output_474_0_g252281;
					half2 XZ_3500_g252281 = temp_output_475_0_g252281;
					half2 XY500_g252281 = temp_output_464_0_g252281;
					half2 XY_1500_g252281 = (Out_MaskF456_g252281).zw;
					half2 XY_2500_g252281 = (Out_MaskG456_g252281).xy;
					half2 XY_3500_g252281 = (Out_MaskG456_g252281).zw;
					half Bias500_g252281 = temp_output_510_0_g252281;
					half3 Weights_1500_g252281 = (Out_MaskH456_g252281).xyz;
					half3 Weights_2500_g252281 = temp_output_480_0_g252281;
					half3 Weights_3500_g252281 = (Out_MaskJ456_g252281).xyz;
					half3 Triplanar500_g252281 = Triplanar522_g252281;
					half3 NormalWS500_g252281 = NormalWS512_g252281;
					half3 Normal500_g252281 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252281 = SampleStochastic3D( Texture500_g252281 , Sampler500_g252281 , ZY500_g252281 , ZY_1500_g252281 , ZY_2500_g252281 , ZY_3500_g252281 , XZ500_g252281 , XZ_1500_g252281 , XZ_2500_g252281 , XZ_3500_g252281 , XY500_g252281 , XY_1500_g252281 , XY_2500_g252281 , XY_3500_g252281 , Bias500_g252281 , Weights_1500_g252281 , Weights_2500_g252281 , Weights_3500_g252281 , Triplanar500_g252281 , NormalWS500_g252281 , Normal500_g252281 );
					float4 temp_output_407_203_g252258 = localSampleStochastic3D500_g252281;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g252258 = temp_output_407_277_g252258;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g252258 = temp_output_407_278_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g252258 = temp_output_407_0_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g252258 = temp_output_407_201_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g252258 = temp_output_407_202_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g252258 = temp_output_407_203_g252258;
					#else
					float4 staticSwitch184_g252258 = temp_output_407_277_g252258;
					#endif
					half4 Local_AlbedoSample185_g252258 = staticSwitch184_g252258;
					float3 lerpResult53_g252258 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g252258).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g252258 = lerpResult53_g252258;
					float temp_output_17_0_g252278 = _MainMultiWriteMode;
					float Option91_g252278 = temp_output_17_0_g252278;
					float4 Model_VertexData418_g252258 = Out_VertexData15_g252259;
					float4 temp_output_84_0_g252278 = Model_VertexData418_g252258;
					float4 ChannelA91_g252278 = temp_output_84_0_g252278;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252266) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g252265 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252266 = staticSwitch38_g252265;
					float localBreakTextureData456_g252266 = ( 0.0 );
					TVEMasksData Data456_g252266 =(TVEMasksData)Data431_g252280;
					float4 Out_MaskA456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252266 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252266 , Out_MaskA456_g252266 , Out_MaskB456_g252266 , Out_MaskC456_g252266 , Out_MaskD456_g252266 , Out_MaskE456_g252266 , Out_MaskF456_g252266 , Out_MaskG456_g252266 , Out_MaskH456_g252266 , Out_MaskI456_g252266 , Out_MaskJ456_g252266 , Out_MaskK456_g252266 , Out_MaskL456_g252266 , Out_MaskM456_g252266 , Out_MaskN456_g252266 );
					half2 UV276_g252266 = (Out_MaskA456_g252266).xy;
					float temp_output_504_0_g252266 = 0.0;
					half Bias276_g252266 = temp_output_504_0_g252266;
					half2 Normal276_g252266 = float2( 0,0 );
					half4 localSampleCoord276_g252266 = SampleCoord( Texture276_g252266 , Sampler276_g252266 , UV276_g252266 , Bias276_g252266 , Normal276_g252266 );
					float4 temp_output_405_277_g252258 = localSampleCoord276_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252266) = _MainShaderTex;
					SamplerState Sampler502_g252266 = staticSwitch38_g252265;
					half2 UV502_g252266 = (Out_MaskA456_g252266).zw;
					half Bias502_g252266 = temp_output_504_0_g252266;
					half2 Normal502_g252266 = float2( 0,0 );
					half4 localSampleCoord502_g252266 = SampleCoord( Texture502_g252266 , Sampler502_g252266 , UV502_g252266 , Bias502_g252266 , Normal502_g252266 );
					float4 temp_output_405_278_g252258 = localSampleCoord502_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252266) = _MainShaderTex;
					SamplerState Sampler496_g252266 = staticSwitch38_g252265;
					float2 temp_output_463_0_g252266 = (Out_MaskB456_g252266).zw;
					half2 XZ496_g252266 = temp_output_463_0_g252266;
					half Bias496_g252266 = temp_output_504_0_g252266;
					half3 NormalWS512_g252266 = (Out_MaskK456_g252266).xyz;
					half3 NormalWS496_g252266 = NormalWS512_g252266;
					half3 Normal496_g252266 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252266 = SamplePlanar2D( Texture496_g252266 , Sampler496_g252266 , XZ496_g252266 , Bias496_g252266 , NormalWS496_g252266 , Normal496_g252266 );
					float4 temp_output_405_0_g252258 = localSamplePlanar2D496_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252266) = _MainShaderTex;
					SamplerState Sampler490_g252266 = staticSwitch38_g252265;
					float2 temp_output_462_0_g252266 = (Out_MaskB456_g252266).xy;
					half2 ZY490_g252266 = temp_output_462_0_g252266;
					half2 XZ490_g252266 = temp_output_463_0_g252266;
					float2 temp_output_464_0_g252266 = (Out_MaskC456_g252266).xy;
					half2 XY490_g252266 = temp_output_464_0_g252266;
					half Bias490_g252266 = temp_output_504_0_g252266;
					half3 Triplanar522_g252266 = (Out_MaskN456_g252266).xyz;
					half3 Triplanar490_g252266 = Triplanar522_g252266;
					half3 NormalWS490_g252266 = NormalWS512_g252266;
					half3 Normal490_g252266 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252266 = SamplePlanar3D( Texture490_g252266 , Sampler490_g252266 , ZY490_g252266 , XZ490_g252266 , XY490_g252266 , Bias490_g252266 , Triplanar490_g252266 , NormalWS490_g252266 , Normal490_g252266 );
					float4 temp_output_405_201_g252258 = localSamplePlanar3D490_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252266) = _MainShaderTex;
					SamplerState Sampler498_g252266 = staticSwitch38_g252265;
					half2 XZ498_g252266 = temp_output_463_0_g252266;
					float2 temp_output_473_0_g252266 = (Out_MaskE456_g252266).xy;
					half2 XZ_1498_g252266 = temp_output_473_0_g252266;
					float2 temp_output_474_0_g252266 = (Out_MaskE456_g252266).zw;
					half2 XZ_2498_g252266 = temp_output_474_0_g252266;
					float2 temp_output_475_0_g252266 = (Out_MaskF456_g252266).xy;
					half2 XZ_3498_g252266 = temp_output_475_0_g252266;
					float temp_output_510_0_g252266 = exp2( temp_output_504_0_g252266 );
					half Bias498_g252266 = temp_output_510_0_g252266;
					float3 temp_output_480_0_g252266 = (Out_MaskI456_g252266).xyz;
					half3 Weights_2498_g252266 = temp_output_480_0_g252266;
					half3 NormalWS498_g252266 = NormalWS512_g252266;
					half3 Normal498_g252266 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252266 = SampleStochastic2D( Texture498_g252266 , Sampler498_g252266 , XZ498_g252266 , XZ_1498_g252266 , XZ_2498_g252266 , XZ_3498_g252266 , Bias498_g252266 , Weights_2498_g252266 , NormalWS498_g252266 , Normal498_g252266 );
					float4 temp_output_405_202_g252258 = localSampleStochastic2D498_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252266) = _MainShaderTex;
					SamplerState Sampler500_g252266 = staticSwitch38_g252265;
					half2 ZY500_g252266 = temp_output_462_0_g252266;
					half2 ZY_1500_g252266 = (Out_MaskC456_g252266).zw;
					half2 ZY_2500_g252266 = (Out_MaskD456_g252266).xy;
					half2 ZY_3500_g252266 = (Out_MaskD456_g252266).zw;
					half2 XZ500_g252266 = temp_output_463_0_g252266;
					half2 XZ_1500_g252266 = temp_output_473_0_g252266;
					half2 XZ_2500_g252266 = temp_output_474_0_g252266;
					half2 XZ_3500_g252266 = temp_output_475_0_g252266;
					half2 XY500_g252266 = temp_output_464_0_g252266;
					half2 XY_1500_g252266 = (Out_MaskF456_g252266).zw;
					half2 XY_2500_g252266 = (Out_MaskG456_g252266).xy;
					half2 XY_3500_g252266 = (Out_MaskG456_g252266).zw;
					half Bias500_g252266 = temp_output_510_0_g252266;
					half3 Weights_1500_g252266 = (Out_MaskH456_g252266).xyz;
					half3 Weights_2500_g252266 = temp_output_480_0_g252266;
					half3 Weights_3500_g252266 = (Out_MaskJ456_g252266).xyz;
					half3 Triplanar500_g252266 = Triplanar522_g252266;
					half3 NormalWS500_g252266 = NormalWS512_g252266;
					half3 Normal500_g252266 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252266 = SampleStochastic3D( Texture500_g252266 , Sampler500_g252266 , ZY500_g252266 , ZY_1500_g252266 , ZY_2500_g252266 , ZY_3500_g252266 , XZ500_g252266 , XZ_1500_g252266 , XZ_2500_g252266 , XZ_3500_g252266 , XY500_g252266 , XY_1500_g252266 , XY_2500_g252266 , XY_3500_g252266 , Bias500_g252266 , Weights_1500_g252266 , Weights_2500_g252266 , Weights_3500_g252266 , Triplanar500_g252266 , NormalWS500_g252266 , Normal500_g252266 );
					float4 temp_output_405_203_g252258 = localSampleStochastic3D500_g252266;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g252258 = temp_output_405_277_g252258;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g252258 = temp_output_405_278_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g252258 = temp_output_405_0_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g252258 = temp_output_405_201_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g252258 = temp_output_405_202_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g252258 = temp_output_405_203_g252258;
					#else
					float4 staticSwitch198_g252258 = temp_output_405_277_g252258;
					#endif
					half4 Local_ShaderSample199_g252258 = staticSwitch198_g252258;
					float2 appendResult428_g252258 = (float2((Local_AlbedoSample185_g252258).w , (Local_ShaderSample199_g252258).z));
					float2 temp_output_85_0_g252278 = appendResult428_g252258;
					float4 ChannelB91_g252278 = float4( temp_output_85_0_g252278, 0.0 , 0.0 );
					float localSwitchChannel691_g252278 = SwitchChannel6( Option91_g252278 , ChannelA91_g252278 , ChannelB91_g252278 );
					float clampResult17_g252276 = clamp( localSwitchChannel691_g252278 , 0.0001 , 0.9999 );
					float temp_output_7_0_g252277 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g252277 = ( clampResult17_g252276 - temp_output_7_0_g252277 );
					half Local_MultiMask78_g252258 = saturate( ( temp_output_9_0_g252277 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g252258 = lerp( 1.0 , Local_MultiMask78_g252258 , _MainColorMode);
					float4 lerpResult62_g252258 = lerp( _MainColorTwo , _MainColor , lerpResult58_g252258);
					half3 Local_ColorRGB93_g252258 = (lerpResult62_g252258).rgb;
					half3 Local_Albedo139_g252258 = ( Local_AlbedoRGB107_g252258 * Local_ColorRGB93_g252258 );
					float3 temp_output_4_0_g252260 = Local_Albedo139_g252258;
					float3 In_Albedo3_g252260 = temp_output_4_0_g252260;
					float3 temp_output_44_0_g252260 = Local_Albedo139_g252258;
					float3 In_AlbedoBase3_g252260 = temp_output_44_0_g252260;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252287) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g252264 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252287 = staticSwitch37_g252264;
					float localBreakTextureData456_g252287 = ( 0.0 );
					TVEMasksData Data456_g252287 =(TVEMasksData)Data431_g252280;
					float4 Out_MaskA456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252287 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252287 , Out_MaskA456_g252287 , Out_MaskB456_g252287 , Out_MaskC456_g252287 , Out_MaskD456_g252287 , Out_MaskE456_g252287 , Out_MaskF456_g252287 , Out_MaskG456_g252287 , Out_MaskH456_g252287 , Out_MaskI456_g252287 , Out_MaskJ456_g252287 , Out_MaskK456_g252287 , Out_MaskL456_g252287 , Out_MaskM456_g252287 , Out_MaskN456_g252287 );
					half2 UV276_g252287 = (Out_MaskA456_g252287).xy;
					float temp_output_504_0_g252287 = 0.0;
					half Bias276_g252287 = temp_output_504_0_g252287;
					half2 Normal276_g252287 = float2( 0,0 );
					half4 localSampleCoord276_g252287 = SampleCoord( Texture276_g252287 , Sampler276_g252287 , UV276_g252287 , Bias276_g252287 , Normal276_g252287 );
					float2 temp_output_406_394_g252258 = Normal276_g252287;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252287) = _MainNormalTex;
					SamplerState Sampler502_g252287 = staticSwitch37_g252264;
					half2 UV502_g252287 = (Out_MaskA456_g252287).zw;
					half Bias502_g252287 = temp_output_504_0_g252287;
					half2 Normal502_g252287 = float2( 0,0 );
					half4 localSampleCoord502_g252287 = SampleCoord( Texture502_g252287 , Sampler502_g252287 , UV502_g252287 , Bias502_g252287 , Normal502_g252287 );
					float2 temp_output_406_397_g252258 = Normal502_g252287;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252287) = _MainNormalTex;
					SamplerState Sampler496_g252287 = staticSwitch37_g252264;
					float2 temp_output_463_0_g252287 = (Out_MaskB456_g252287).zw;
					half2 XZ496_g252287 = temp_output_463_0_g252287;
					half Bias496_g252287 = temp_output_504_0_g252287;
					half3 NormalWS512_g252287 = (Out_MaskK456_g252287).xyz;
					half3 NormalWS496_g252287 = NormalWS512_g252287;
					half3 Normal496_g252287 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252287 = SamplePlanar2D( Texture496_g252287 , Sampler496_g252287 , XZ496_g252287 , Bias496_g252287 , NormalWS496_g252287 , Normal496_g252287 );
					float3 temp_output_35_0_g252290 = Normal496_g252287;
					half3 TangentWS519_g252287 = (Out_MaskL456_g252287).xyz;
					float dotResult84_g252290 = dot( temp_output_35_0_g252290 , TangentWS519_g252287 );
					half3 BitangentWS521_g252287 = (Out_MaskM456_g252287).xyz;
					float dotResult85_g252290 = dot( temp_output_35_0_g252290 , BitangentWS521_g252287 );
					float2 appendResult87_g252290 = (float2(dotResult84_g252290 , dotResult85_g252290));
					float2 temp_output_406_375_g252258 = appendResult87_g252290;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252287) = _MainNormalTex;
					SamplerState Sampler490_g252287 = staticSwitch37_g252264;
					float2 temp_output_462_0_g252287 = (Out_MaskB456_g252287).xy;
					half2 ZY490_g252287 = temp_output_462_0_g252287;
					half2 XZ490_g252287 = temp_output_463_0_g252287;
					float2 temp_output_464_0_g252287 = (Out_MaskC456_g252287).xy;
					half2 XY490_g252287 = temp_output_464_0_g252287;
					half Bias490_g252287 = temp_output_504_0_g252287;
					half3 Triplanar522_g252287 = (Out_MaskN456_g252287).xyz;
					half3 Triplanar490_g252287 = Triplanar522_g252287;
					half3 NormalWS490_g252287 = NormalWS512_g252287;
					half3 Normal490_g252287 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252287 = SamplePlanar3D( Texture490_g252287 , Sampler490_g252287 , ZY490_g252287 , XZ490_g252287 , XY490_g252287 , Bias490_g252287 , Triplanar490_g252287 , NormalWS490_g252287 , Normal490_g252287 );
					float3 temp_output_35_0_g252291 = Normal490_g252287;
					float dotResult84_g252291 = dot( temp_output_35_0_g252291 , TangentWS519_g252287 );
					float dotResult85_g252291 = dot( temp_output_35_0_g252291 , BitangentWS521_g252287 );
					float2 appendResult87_g252291 = (float2(dotResult84_g252291 , dotResult85_g252291));
					float2 temp_output_406_353_g252258 = appendResult87_g252291;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252287) = _MainNormalTex;
					SamplerState Sampler498_g252287 = staticSwitch37_g252264;
					half2 XZ498_g252287 = temp_output_463_0_g252287;
					float2 temp_output_473_0_g252287 = (Out_MaskE456_g252287).xy;
					half2 XZ_1498_g252287 = temp_output_473_0_g252287;
					float2 temp_output_474_0_g252287 = (Out_MaskE456_g252287).zw;
					half2 XZ_2498_g252287 = temp_output_474_0_g252287;
					float2 temp_output_475_0_g252287 = (Out_MaskF456_g252287).xy;
					half2 XZ_3498_g252287 = temp_output_475_0_g252287;
					float temp_output_510_0_g252287 = exp2( temp_output_504_0_g252287 );
					half Bias498_g252287 = temp_output_510_0_g252287;
					float3 temp_output_480_0_g252287 = (Out_MaskI456_g252287).xyz;
					half3 Weights_2498_g252287 = temp_output_480_0_g252287;
					half3 NormalWS498_g252287 = NormalWS512_g252287;
					half3 Normal498_g252287 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252287 = SampleStochastic2D( Texture498_g252287 , Sampler498_g252287 , XZ498_g252287 , XZ_1498_g252287 , XZ_2498_g252287 , XZ_3498_g252287 , Bias498_g252287 , Weights_2498_g252287 , NormalWS498_g252287 , Normal498_g252287 );
					float3 temp_output_35_0_g252292 = Normal498_g252287;
					float dotResult84_g252292 = dot( temp_output_35_0_g252292 , TangentWS519_g252287 );
					float dotResult85_g252292 = dot( temp_output_35_0_g252292 , BitangentWS521_g252287 );
					float2 appendResult87_g252292 = (float2(dotResult84_g252292 , dotResult85_g252292));
					float2 temp_output_406_391_g252258 = appendResult87_g252292;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252287) = _MainNormalTex;
					SamplerState Sampler500_g252287 = staticSwitch37_g252264;
					half2 ZY500_g252287 = temp_output_462_0_g252287;
					half2 ZY_1500_g252287 = (Out_MaskC456_g252287).zw;
					half2 ZY_2500_g252287 = (Out_MaskD456_g252287).xy;
					half2 ZY_3500_g252287 = (Out_MaskD456_g252287).zw;
					half2 XZ500_g252287 = temp_output_463_0_g252287;
					half2 XZ_1500_g252287 = temp_output_473_0_g252287;
					half2 XZ_2500_g252287 = temp_output_474_0_g252287;
					half2 XZ_3500_g252287 = temp_output_475_0_g252287;
					half2 XY500_g252287 = temp_output_464_0_g252287;
					half2 XY_1500_g252287 = (Out_MaskF456_g252287).zw;
					half2 XY_2500_g252287 = (Out_MaskG456_g252287).xy;
					half2 XY_3500_g252287 = (Out_MaskG456_g252287).zw;
					half Bias500_g252287 = temp_output_510_0_g252287;
					half3 Weights_1500_g252287 = (Out_MaskH456_g252287).xyz;
					half3 Weights_2500_g252287 = temp_output_480_0_g252287;
					half3 Weights_3500_g252287 = (Out_MaskJ456_g252287).xyz;
					half3 Triplanar500_g252287 = Triplanar522_g252287;
					half3 NormalWS500_g252287 = NormalWS512_g252287;
					half3 Normal500_g252287 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252287 = SampleStochastic3D( Texture500_g252287 , Sampler500_g252287 , ZY500_g252287 , ZY_1500_g252287 , ZY_2500_g252287 , ZY_3500_g252287 , XZ500_g252287 , XZ_1500_g252287 , XZ_2500_g252287 , XZ_3500_g252287 , XY500_g252287 , XY_1500_g252287 , XY_2500_g252287 , XY_3500_g252287 , Bias500_g252287 , Weights_1500_g252287 , Weights_2500_g252287 , Weights_3500_g252287 , Triplanar500_g252287 , NormalWS500_g252287 , Normal500_g252287 );
					float3 temp_output_35_0_g252288 = Normal500_g252287;
					float dotResult84_g252288 = dot( temp_output_35_0_g252288 , TangentWS519_g252287 );
					float dotResult85_g252288 = dot( temp_output_35_0_g252288 , BitangentWS521_g252287 );
					float2 appendResult87_g252288 = (float2(dotResult84_g252288 , dotResult85_g252288));
					float2 temp_output_406_390_g252258 = appendResult87_g252288;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g252258 = temp_output_406_394_g252258;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g252258 = temp_output_406_397_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g252258 = temp_output_406_375_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g252258 = temp_output_406_353_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g252258 = temp_output_406_391_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g252258 = temp_output_406_390_g252258;
					#else
					float2 staticSwitch193_g252258 = temp_output_406_394_g252258;
					#endif
					half2 Local_NormaSample191_g252258 = staticSwitch193_g252258;
					half2 Local_NormalTS108_g252258 = ( Local_NormaSample191_g252258 * _MainNormalValue );
					float2 In_NormalTS3_g252260 = Local_NormalTS108_g252258;
					float2 break80_g252279 = Local_NormalTS108_g252258;
					float3 temp_output_77_0_g252279 = Model_TangentWS366_g252258;
					float3 temp_output_78_0_g252279 = Model_BitangentWS367_g252258;
					float3 temp_output_76_0_g252279 = Model_NormalWS226_g252258;
					half3 Local_NormalWS250_g252258 = ( ( break80_g252279.x * temp_output_77_0_g252279 ) + ( break80_g252279.y * temp_output_78_0_g252279 ) + temp_output_76_0_g252279 );
					float3 In_NormalWS3_g252260 = Local_NormalWS250_g252258;
					float temp_output_209_0_g252258 = (Local_ShaderSample199_g252258).y;
					float temp_output_7_0_g252272 = _MainOcclusionRemap.x;
					float temp_output_9_0_g252272 = ( temp_output_209_0_g252258 - temp_output_7_0_g252272 );
					float lerpResult23_g252258 = lerp( 1.0 , saturate( ( temp_output_9_0_g252272 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g252258 = lerpResult23_g252258;
					float temp_output_213_0_g252258 = (Local_ShaderSample199_g252258).w;
					float temp_output_7_0_g252275 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g252275 = ( temp_output_213_0_g252258 - temp_output_7_0_g252275 );
					half Local_Smoothness317_g252258 = ( saturate( ( temp_output_9_0_g252275 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g252258 = (float4(( (Local_ShaderSample199_g252258).x * _MainMetallicValue ) , Local_Occlusion313_g252258 , (Local_ShaderSample199_g252258).z , Local_Smoothness317_g252258));
					half4 Local_Masks109_g252258 = appendResult73_g252258;
					float4 In_Shader3_g252260 = Local_Masks109_g252258;
					float4 In_Feature3_g252260 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252260 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252260 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g252293 = Local_Albedo139_g252258;
					float dotResult20_g252293 = dot( temp_output_3_0_g252293 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g252258 = dotResult20_g252293;
					float temp_output_12_0_g252260 = Local_Grayscale110_g252258;
					float In_Grayscale3_g252260 = temp_output_12_0_g252260;
					float temp_output_3_0_g252294 = Local_Grayscale110_g252258;
					float clampResult27_g252294 = clamp( saturate( ( temp_output_3_0_g252294 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g252258 = clampResult27_g252294;
					float temp_output_16_0_g252260 = Local_Luminosity145_g252258;
					float In_Luminosity3_g252260 = temp_output_16_0_g252260;
					float In_MultiMask3_g252260 = Local_MultiMask78_g252258;
					float temp_output_187_0_g252258 = (Local_AlbedoSample185_g252258).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g252258 = ( temp_output_187_0_g252258 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g252258 = temp_output_187_0_g252258;
					#endif
					half Local_AlphaClip111_g252258 = staticSwitch236_g252258;
					float In_AlphaClip3_g252260 = Local_AlphaClip111_g252258;
					half Local_AlphaFade246_g252258 = (lerpResult62_g252258).a;
					float In_AlphaFade3_g252260 = Local_AlphaFade246_g252258;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g252260 = temp_cast_24;
					float In_Transmission3_g252260 = 1.0;
					float In_Thickness3_g252260 = 0.0;
					float In_Diffusion3_g252260 = 0.0;
					float In_Depth3_g252260 = 0.0;
					BuildVisualData( Data3_g252260 , In_Dummy3_g252260 , In_Albedo3_g252260 , In_AlbedoBase3_g252260 , In_NormalTS3_g252260 , In_NormalWS3_g252260 , In_Shader3_g252260 , In_Feature3_g252260 , In_Season3_g252260 , In_Emissive3_g252260 , In_Grayscale3_g252260 , In_Luminosity3_g252260 , In_MultiMask3_g252260 , In_AlphaClip3_g252260 , In_AlphaFade3_g252260 , In_Translucency3_g252260 , In_Transmission3_g252260 , In_Thickness3_g252260 , In_Diffusion3_g252260 , In_Depth3_g252260 );
					TVEVisualData Data4_g252496 =(TVEVisualData)Data3_g252260;
					float Out_Dummy4_g252496 = 0.0;
					float3 Out_Albedo4_g252496 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252496 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252496 = float2( 0,0 );
					float3 Out_NormalWS4_g252496 = float3( 0,0,0 );
					float4 Out_Shader4_g252496 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252496 = float4( 0,0,0,0 );
					float4 Out_Season4_g252496 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252496 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252496 = 0.0;
					float Out_Grayscale4_g252496 = 0.0;
					float Out_Luminosity4_g252496 = 0.0;
					float Out_AlphaClip4_g252496 = 0.0;
					float Out_AlphaFade4_g252496 = 0.0;
					float3 Out_Translucency4_g252496 = float3( 0,0,0 );
					float Out_Transmission4_g252496 = 0.0;
					float Out_Thickness4_g252496 = 0.0;
					float Out_Diffusion4_g252496 = 0.0;
					float Out_Depth4_g252496 = 0.0;
					BreakVisualData( Data4_g252496 , Out_Dummy4_g252496 , Out_Albedo4_g252496 , Out_AlbedoBase4_g252496 , Out_NormalTS4_g252496 , Out_NormalWS4_g252496 , Out_Shader4_g252496 , Out_Feature4_g252496 , Out_Season4_g252496 , Out_Emissive4_g252496 , Out_MultiMask4_g252496 , Out_Grayscale4_g252496 , Out_Luminosity4_g252496 , Out_AlphaClip4_g252496 , Out_AlphaFade4_g252496 , Out_Translucency4_g252496 , Out_Transmission4_g252496 , Out_Thickness4_g252496 , Out_Diffusion4_g252496 , Out_Depth4_g252496 );
					float temp_output_200_11_g252472 = Out_MultiMask4_g252496;
					half Visual_MultiMask181_g252472 = temp_output_200_11_g252472;
					float lerpResult147_g252472 = lerp( 1.0 , Visual_MultiMask181_g252472 , _TintingMultiValue);
					half Blend_MutiMask121_g252472 = lerpResult147_g252472;
					float temp_output_200_15_g252472 = Out_Luminosity4_g252496;
					half Visual_Luminosity257_g252472 = temp_output_200_15_g252472;
					float temp_output_7_0_g252481 = _TintingLumaRemap.x;
					float temp_output_9_0_g252481 = ( Visual_Luminosity257_g252472 - temp_output_7_0_g252481 );
					float lerpResult228_g252472 = lerp( 1.0 , saturate( ( temp_output_9_0_g252481 * _TintingLumaRemap.z ) ) , _TintingLumaValue);
					half Blend_LumaMask153_g252472 = lerpResult228_g252472;
					half Blend_NoiseMask213_g252472 = 1.0;
					half Blend_UserMask345_g252472 = 1.0;
					float temp_output_17_0_g252493 = _TintingMeshMode;
					float Option70_g252493 = temp_output_17_0_g252493;
					TVEModelData Data15_g252497 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g252497 = 0.0;
					float3 Out_PositionWS15_g252497 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252497 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252497 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252497 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252497 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252497 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252497 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252497 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252497 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252497 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252497 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252497 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252497 , Out_Dummy15_g252497 , Out_PositionWS15_g252497 , Out_PositionWO15_g252497 , Out_PivotWS15_g252497 , Out_PivotWO15_g252497 , Out_NormalWS15_g252497 , Out_TangentWS15_g252497 , Out_BitangentWS15_g252497 , Out_TriplanarWeights15_g252497 , Out_ViewDirWS15_g252497 , Out_CoordsData15_g252497 , Out_VertexData15_g252497 , Out_Interpolator15_g252497 );
					half4 Model_VertexData307_g252472 = Out_VertexData15_g252497;
					float4 temp_output_3_0_g252493 = Model_VertexData307_g252472;
					float4 Channel70_g252493 = temp_output_3_0_g252493;
					float localSwitchChannel470_g252493 = SwitchChannel4( Option70_g252493 , Channel70_g252493 );
					float temp_output_521_0_g252472 = localSwitchChannel470_g252493;
					float temp_output_7_0_g252482 = _TintingMeshRemap.x;
					float temp_output_9_0_g252482 = ( temp_output_521_0_g252472 - temp_output_7_0_g252482 );
					float lerpResult370_g252472 = lerp( 1.0 , saturate( ( temp_output_9_0_g252482 * _TintingMeshRemap.z ) ) , _TintingMeshValue);
					half Blend_VertMask309_g252472 = lerpResult370_g252472;
					float temp_output_64_0_g252510 = ( Blend_TexMask385_g252472 * Blend_MutiMask121_g252472 * Blend_LumaMask153_g252472 * Blend_NoiseMask213_g252472 * Blend_UserMask345_g252472 * Blend_VertMask309_g252472 );
					float4 temp_output_533_109_g252472 = TVE_PaintParams;
					float localBuildGlobalData204_g251779 = ( 0.0 );
					TVEGlobalData Data204_g251779 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251779 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251779 = Dummy211_g251779;
					float4 temp_output_203_0_g251798 = TVE_CoatBaseCoord;
					TVEModelData Data15_g251869 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g251869 = 0.0;
					float3 Out_PositionWS15_g251869 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251869 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251869 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251869 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251869 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251869 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251869 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251869 , Out_Dummy15_g251869 , Out_PositionWS15_g251869 , Out_PositionWO15_g251869 , Out_PivotWS15_g251869 , Out_PivotWO15_g251869 , Out_NormalWS15_g251869 , Out_TangentWS15_g251869 , Out_BitangentWS15_g251869 , Out_TriplanarWeights15_g251869 , Out_ViewDirWS15_g251869 , Out_CoordsData15_g251869 , Out_VertexData15_g251869 , Out_Interpolator15_g251869 );
					float3 Model_PositionWS497_g251779 = Out_PositionWS15_g251869;
					float2 Model_PositionWS_XZ143_g251779 = (Model_PositionWS497_g251779).xz;
					float3 Model_PivotWS498_g251779 = Out_PivotWS15_g251869;
					float2 Model_PivotWS_XZ145_g251779 = (Model_PivotWS498_g251779).xz;
					float2 lerpResult300_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251798 = lerpResult300_g251779;
					float temp_output_82_0_g251796 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251798 = temp_output_82_0_g251796;
					float4 tex2DArrayNode83_g251798 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251798).zw + ( (temp_output_203_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798) );
					float4 appendResult210_g251798 = (float4(tex2DArrayNode83_g251798.rgb , tex2DArrayNode83_g251798.a));
					float4 temp_output_204_0_g251798 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251798 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251798).zw + ( (temp_output_204_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798) );
					float4 appendResult212_g251798 = (float4(tex2DArrayNode122_g251798.rgb , tex2DArrayNode122_g251798.a));
					float4 TVE_RenderNearPositionR628_g251779 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251779 = saturate( ( distance( Model_PositionWS497_g251779 , (TVE_RenderNearPositionR628_g251779).xyz ) / (TVE_RenderNearPositionR628_g251779).w ) );
					float temp_output_7_0_g251868 = 1.0;
					float temp_output_9_0_g251868 = ( temp_output_507_0_g251779 - temp_output_7_0_g251868 );
					half TVE_RenderNearFadeValue635_g251779 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251779 = saturate( ( temp_output_9_0_g251868 / ( ( TVE_RenderNearFadeValue635_g251779 - temp_output_7_0_g251868 ) + 0.0001 ) ) );
					float4 lerpResult131_g251798 = lerp( appendResult210_g251798 , appendResult212_g251798 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251796 = lerpResult131_g251798;
					float4 lerpResult168_g251796 = lerp( TVE_CoatParams , temp_output_159_109_g251796 , TVE_CoatLayers[(int)temp_output_82_0_g251796]);
					float4 temp_output_589_109_g251779 = lerpResult168_g251796;
					half4 Coat_Texture302_g251779 = temp_output_589_109_g251779;
					float4 In_CoatTexture204_g251779 = Coat_Texture302_g251779;
					half4 Draw_Texture656_g251779 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251779 = Draw_Texture656_g251779;
					float4 temp_output_203_0_g251823 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251823 = lerpResult85_g251779;
					float temp_output_82_0_g251820 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251823 = temp_output_82_0_g251820;
					float4 tex2DArrayNode83_g251823 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251823).zw + ( (temp_output_203_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823) );
					float4 appendResult210_g251823 = (float4(tex2DArrayNode83_g251823.rgb , tex2DArrayNode83_g251823.a));
					float4 temp_output_204_0_g251823 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251823 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251823).zw + ( (temp_output_204_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823) );
					float4 appendResult212_g251823 = (float4(tex2DArrayNode122_g251823.rgb , tex2DArrayNode122_g251823.a));
					float4 lerpResult131_g251823 = lerp( appendResult210_g251823 , appendResult212_g251823 , Global_TexBlend509_g251779);
					float4 temp_output_171_109_g251820 = lerpResult131_g251823;
					float4 lerpResult174_g251820 = lerp( TVE_PaintParams , temp_output_171_109_g251820 , TVE_PaintLayers[(int)temp_output_82_0_g251820]);
					float4 temp_output_595_109_g251779 = lerpResult174_g251820;
					half4 Paint_Texture71_g251779 = temp_output_595_109_g251779;
					float4 In_PaintTexture204_g251779 = Paint_Texture71_g251779;
					float4 temp_output_203_0_g251806 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251806 = lerpResult104_g251779;
					float temp_output_132_0_g251804 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251806 = temp_output_132_0_g251804;
					float4 tex2DArrayNode83_g251806 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251806).zw + ( (temp_output_203_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806) );
					float4 appendResult210_g251806 = (float4(tex2DArrayNode83_g251806.rgb , tex2DArrayNode83_g251806.a));
					float4 temp_output_204_0_g251806 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251806 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251806).zw + ( (temp_output_204_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806) );
					float4 appendResult212_g251806 = (float4(tex2DArrayNode122_g251806.rgb , tex2DArrayNode122_g251806.a));
					float4 lerpResult131_g251806 = lerp( appendResult210_g251806 , appendResult212_g251806 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251804 = lerpResult131_g251806;
					float4 lerpResult145_g251804 = lerp( TVE_AtmoParams , temp_output_137_109_g251804 , TVE_AtmoLayers[(int)temp_output_132_0_g251804]);
					float4 temp_output_590_110_g251779 = lerpResult145_g251804;
					half4 Atmo_Texture80_g251779 = temp_output_590_110_g251779;
					float4 In_AtmoTexture204_g251779 = Atmo_Texture80_g251779;
					float4 temp_output_203_0_g251874 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251874 = lerpResult414_g251779;
					float temp_output_132_0_g251872 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251874 = temp_output_132_0_g251872;
					float4 tex2DArrayNode83_g251874 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251874).zw + ( (temp_output_203_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874) );
					float4 appendResult210_g251874 = (float4(tex2DArrayNode83_g251874.rgb , tex2DArrayNode83_g251874.a));
					float4 temp_output_204_0_g251874 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251874 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251874).zw + ( (temp_output_204_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874) );
					float4 appendResult212_g251874 = (float4(tex2DArrayNode122_g251874.rgb , tex2DArrayNode122_g251874.a));
					float4 lerpResult131_g251874 = lerp( appendResult210_g251874 , appendResult212_g251874 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251872 = lerpResult131_g251874;
					float4 lerpResult145_g251872 = lerp( TVE_EffexParams , temp_output_137_109_g251872 , TVE_EffexLayers[(int)temp_output_132_0_g251872]);
					float4 temp_output_731_110_g251779 = lerpResult145_g251872;
					half4 Effex_Texture420_g251779 = temp_output_731_110_g251779;
					float4 In_EffexTexture204_g251779 = Effex_Texture420_g251779;
					float4 temp_output_203_0_g251854 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251854 = lerpResult247_g251779;
					float temp_output_82_0_g251852 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251854 = temp_output_82_0_g251852;
					float4 tex2DArrayNode83_g251854 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251854).zw + ( (temp_output_203_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854) );
					float4 appendResult210_g251854 = (float4(tex2DArrayNode83_g251854.rgb , tex2DArrayNode83_g251854.a));
					float4 temp_output_204_0_g251854 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251854 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251854).zw + ( (temp_output_204_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854) );
					float4 appendResult212_g251854 = (float4(tex2DArrayNode122_g251854.rgb , tex2DArrayNode122_g251854.a));
					float4 lerpResult131_g251854 = lerp( appendResult210_g251854 , appendResult212_g251854 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251852 = lerpResult131_g251854;
					float4 lerpResult167_g251852 = lerp( TVE_GlowParams , temp_output_159_109_g251852 , TVE_GlowLayers[(int)temp_output_82_0_g251852]);
					float4 temp_output_593_109_g251779 = lerpResult167_g251852;
					half4 Glow_Texture248_g251779 = temp_output_593_109_g251779;
					float4 In_GlowTexture204_g251779 = Glow_Texture248_g251779;
					float4 temp_output_203_0_g251790 = TVE_FormBaseCoord;
					float2 lerpResult168_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251790 = lerpResult168_g251779;
					float temp_output_130_0_g251788 = _GlobalFormLayerValue;
					float temp_output_82_0_g251790 = temp_output_130_0_g251788;
					float4 tex2DArrayNode83_g251790 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251790).zw + ( (temp_output_203_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790) );
					float4 appendResult210_g251790 = (float4(tex2DArrayNode83_g251790.rgb , tex2DArrayNode83_g251790.a));
					float4 temp_output_204_0_g251790 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251790 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251790).zw + ( (temp_output_204_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790) );
					float4 appendResult212_g251790 = (float4(tex2DArrayNode122_g251790.rgb , tex2DArrayNode122_g251790.a));
					float4 lerpResult131_g251790 = lerp( appendResult210_g251790 , appendResult212_g251790 , Global_TexBlend509_g251779);
					float4 temp_output_135_109_g251788 = lerpResult131_g251790;
					float4 lerpResult143_g251788 = lerp( TVE_FormParams , temp_output_135_109_g251788 , TVE_FormLayers[(int)temp_output_130_0_g251788]);
					float4 temp_output_592_0_g251779 = lerpResult143_g251788;
					float4 Form_Texture112_g251779 = temp_output_592_0_g251779;
					float4 In_FormTexture204_g251779 = Form_Texture112_g251779;
					float4 In_LandTexture204_g251779 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251838 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251838 = lerpResult681_g251779;
					float temp_output_136_0_g251836 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251838 = temp_output_136_0_g251836;
					float4 tex2DArrayNode83_g251838 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251838).zw + ( (temp_output_203_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838) );
					float4 appendResult210_g251838 = (float4(tex2DArrayNode83_g251838.rgb , tex2DArrayNode83_g251838.a));
					float4 temp_output_204_0_g251838 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251838 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251838).zw + ( (temp_output_204_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838) );
					float4 appendResult212_g251838 = (float4(tex2DArrayNode122_g251838.rgb , tex2DArrayNode122_g251838.a));
					float4 lerpResult131_g251838 = lerp( appendResult210_g251838 , appendResult212_g251838 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251836 = lerpResult131_g251838;
					float4 lerpResult149_g251836 = lerp( TVE_VertxParams , temp_output_141_109_g251836 , TVE_VertxLayers[(int)temp_output_136_0_g251836]);
					float4 temp_output_695_0_g251779 = lerpResult149_g251836;
					half4 Vertx_Texture693_g251779 = temp_output_695_0_g251779;
					float4 In_VertxTexture204_g251779 = Vertx_Texture693_g251779;
					float4 temp_output_203_0_g251814 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251814 = lerpResult400_g251779;
					float temp_output_136_0_g251812 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251814 = temp_output_136_0_g251812;
					float4 tex2DArrayNode83_g251814 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251814).zw + ( (temp_output_203_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814) );
					float4 appendResult210_g251814 = (float4(tex2DArrayNode83_g251814.rgb , tex2DArrayNode83_g251814.a));
					float4 temp_output_204_0_g251814 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251814 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251814).zw + ( (temp_output_204_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814) );
					float4 appendResult212_g251814 = (float4(tex2DArrayNode122_g251814.rgb , tex2DArrayNode122_g251814.a));
					float4 lerpResult131_g251814 = lerp( appendResult210_g251814 , appendResult212_g251814 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251812 = lerpResult131_g251814;
					float4 lerpResult149_g251812 = lerp( TVE_FlowParams , temp_output_141_109_g251812 , TVE_FlowLayers[(int)temp_output_136_0_g251812]);
					float4 temp_output_594_0_g251779 = lerpResult149_g251812;
					half4 Flow_Texture405_g251779 = temp_output_594_0_g251779;
					float4 In_FlowTexture204_g251779 = Flow_Texture405_g251779;
					half4 User_Texture677_g251779 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251779 = User_Texture677_g251779;
					BuildGlobalData( Data204_g251779 , In_Dummy204_g251779 , In_CoatTexture204_g251779 , In_DrawTexture204_g251779 , In_PaintTexture204_g251779 , In_AtmoTexture204_g251779 , In_EffexTexture204_g251779 , In_GlowTexture204_g251779 , In_FormTexture204_g251779 , In_LandTexture204_g251779 , In_VertxTexture204_g251779 , In_FlowTexture204_g251779 , In_UserTexture204_g251779 );
					TVEGlobalData Data15_g252495 =(TVEGlobalData)Data204_g251779;
					float Out_Dummy15_g252495 = 0.0;
					float4 Out_CoatTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252495 = float4( 0,0,0,0 );
					BreakData( Data15_g252495 , Out_Dummy15_g252495 , Out_CoatTexture15_g252495 , Out_DrawTexture15_g252495 , Out_PaintTexture15_g252495 , Out_AtmoTexture15_g252495 , Out_EffexTexture15_g252495 , Out_GlowTexture15_g252495 , Out_FormTexture15_g252495 , Out_LandTexture15_g252495 , Out_VertxTexture15_g252495 , Out_FlowTexture15_g252495 , Out_UserTexture15_g252495 );
					half4 Global_PaintTexture209_g252472 = Out_PaintTexture15_g252495;
					float4 temp_output_6_0_g252484 = Global_PaintTexture209_g252472;
					float temp_output_7_0_g252484 = _TintingPaintMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252484 = ( temp_output_6_0_g252484 + temp_output_7_0_g252484 );
					#else
					float4 staticSwitch14_g252484 = temp_output_6_0_g252484;
					#endif
					float4 temp_output_332_0_g252472 = staticSwitch14_g252484;
					#ifdef TVE_TINTING_PAINT
					float4 staticSwitch283_g252472 = temp_output_332_0_g252472;
					#else
					float4 staticSwitch283_g252472 = temp_output_533_109_g252472;
					#endif
					float lerpResult464_g252472 = lerp( 1.0 , (staticSwitch283_g252472).w , _TintingPaintValue);
					half Blend_GlobalValue285_g252472 = lerpResult464_g252472;
					float temp_output_92_0_g252510 = ( Feature_Intensity508_g252472 * Blend_GlobalValue285_g252472 );
					half Multiply93_g252510 = ( temp_output_64_0_g252510 * temp_output_92_0_g252510 );
					half Subtract93_g252510 = saturate( ( temp_output_92_0_g252510 - ( 1.0 - temp_output_64_0_g252510 ) ) );
					half Option93_g252510 = _TintingBlendMath;
					half localSwitchBlendMask93_g252510 = SwitchBlendMask( Multiply93_g252510 , Subtract93_g252510 , Option93_g252510 );
					float temp_output_7_0_g252511 = _TintingBlendRemap.x;
					float temp_output_9_0_g252511 = ( localSwitchBlendMask93_g252510 - temp_output_7_0_g252511 );
					half Blend_Mask242_g252472 = ( saturate( ( temp_output_9_0_g252511 * _TintingBlendRemap.z ) ) * TVE_IsEnabled );
					float4 appendResult513_g252472 = (float4(Blend_Mask242_g252472 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_33 = (0.0).xxxx;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 ifLocalVar18_g252513 = 0;
					if( Feature_Intensity508_g252472 <= 0.0 )
					ifLocalVar18_g252513 = temp_cast_34;
					else
					ifLocalVar18_g252513 = appendResult513_g252472;
					float4 In_MaskB3_g252499 = ifLocalVar18_g252513;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskC3_g252499 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskD3_g252499 = temp_cast_36;
					float4 temp_cast_37 = (0.0).xxxx;
					float4 In_MaskE3_g252499 = temp_cast_37;
					float4 temp_cast_38 = (0.0).xxxx;
					float4 In_MaskF3_g252499 = temp_cast_38;
					float4 temp_cast_39 = (0.0).xxxx;
					float4 In_MaskG3_g252499 = temp_cast_39;
					float4 temp_cast_40 = (0.0).xxxx;
					float4 In_MaskH3_g252499 = temp_cast_40;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 In_MaskI3_g252499 = temp_cast_41;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskJ3_g252499 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskK3_g252499 = temp_cast_43;
					float4 temp_cast_44 = (0.0).xxxx;
					float4 In_MaskL3_g252499 = temp_cast_44;
					{
					Data3_g252499.MaskA = In_MaskA3_g252499;
					Data3_g252499.MaskB = In_MaskB3_g252499;
					Data3_g252499.MaskC = In_MaskC3_g252499;
					Data3_g252499.MaskD = In_MaskD3_g252499;
					Data3_g252499.MaskE = In_MaskE3_g252499;
					Data3_g252499.MaskF = In_MaskF3_g252499;
					Data3_g252499.MaskG = In_MaskG3_g252499;
					Data3_g252499.MaskH = In_MaskH3_g252499;
					Data3_g252499.MaskI = In_MaskI3_g252499;
					Data3_g252499.MaskJ= In_MaskJ3_g252499;
					Data3_g252499.MaskK= In_MaskK3_g252499;
					Data3_g252499.MaskL = In_MaskL3_g252499;
					}
					TVEMasksData DataA25_g252556 = Data3_g252499;
					float localBuildMasksData3_g252541 = ( 0.0 );
					TVEMasksData Data3_g252541 = (TVEMasksData)0;
					half Feature_Intensity508_g252514 = _TintingIntensityValue;
					float ifLocalVar18_g252542 = 0;
					if( Feature_Intensity508_g252514 <= 0.0 )
					ifLocalVar18_g252542 = 0.0;
					else
					ifLocalVar18_g252542 = 1.0;
					half Feature_Element505_g252514 = _TintingPaintMode;
					float ifLocalVar18_g252543 = 0;
					if( Feature_Element505_g252514 <= 0.0 )
					ifLocalVar18_g252543 = 0.0;
					else
					ifLocalVar18_g252543 = 1.0;
					float4 appendResult517_g252514 = (float4(ifLocalVar18_g252542 , 0.0 , 0.0 , ifLocalVar18_g252543));
					float4 In_MaskA3_g252541 = appendResult517_g252514;
					half Blend_TexMask385_g252514 = 1.0;
					float localBreakVisualData4_g252538 = ( 0.0 );
					TVEVisualData Data4_g252538 =(TVEVisualData)Data3_g252260;
					float Out_Dummy4_g252538 = 0.0;
					float3 Out_Albedo4_g252538 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252538 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252538 = float2( 0,0 );
					float3 Out_NormalWS4_g252538 = float3( 0,0,0 );
					float4 Out_Shader4_g252538 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252538 = float4( 0,0,0,0 );
					float4 Out_Season4_g252538 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252538 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252538 = 0.0;
					float Out_Grayscale4_g252538 = 0.0;
					float Out_Luminosity4_g252538 = 0.0;
					float Out_AlphaClip4_g252538 = 0.0;
					float Out_AlphaFade4_g252538 = 0.0;
					float3 Out_Translucency4_g252538 = float3( 0,0,0 );
					float Out_Transmission4_g252538 = 0.0;
					float Out_Thickness4_g252538 = 0.0;
					float Out_Diffusion4_g252538 = 0.0;
					float Out_Depth4_g252538 = 0.0;
					BreakVisualData( Data4_g252538 , Out_Dummy4_g252538 , Out_Albedo4_g252538 , Out_AlbedoBase4_g252538 , Out_NormalTS4_g252538 , Out_NormalWS4_g252538 , Out_Shader4_g252538 , Out_Feature4_g252538 , Out_Season4_g252538 , Out_Emissive4_g252538 , Out_MultiMask4_g252538 , Out_Grayscale4_g252538 , Out_Luminosity4_g252538 , Out_AlphaClip4_g252538 , Out_AlphaFade4_g252538 , Out_Translucency4_g252538 , Out_Transmission4_g252538 , Out_Thickness4_g252538 , Out_Diffusion4_g252538 , Out_Depth4_g252538 );
					float temp_output_200_11_g252514 = Out_MultiMask4_g252538;
					half Visual_MultiMask181_g252514 = temp_output_200_11_g252514;
					float lerpResult147_g252514 = lerp( 1.0 , Visual_MultiMask181_g252514 , _TintingMultiValue);
					half Blend_MutiMask121_g252514 = lerpResult147_g252514;
					float temp_output_200_15_g252514 = Out_Luminosity4_g252538;
					half Visual_Luminosity257_g252514 = temp_output_200_15_g252514;
					float temp_output_7_0_g252523 = _TintingLumaRemap.x;
					float temp_output_9_0_g252523 = ( Visual_Luminosity257_g252514 - temp_output_7_0_g252523 );
					float lerpResult228_g252514 = lerp( 1.0 , saturate( ( temp_output_9_0_g252523 * _TintingLumaRemap.z ) ) , _TintingLumaValue);
					half Blend_LumaMask153_g252514 = lerpResult228_g252514;
					half Blend_NoiseMask213_g252514 = 1.0;
					half Blend_UserMask345_g252514 = 1.0;
					float temp_output_17_0_g252535 = _TintingMeshMode;
					float Option70_g252535 = temp_output_17_0_g252535;
					TVEModelData Data15_g252539 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g252539 = 0.0;
					float3 Out_PositionWS15_g252539 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252539 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252539 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252539 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252539 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252539 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252539 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252539 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252539 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252539 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252539 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252539 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252539 , Out_Dummy15_g252539 , Out_PositionWS15_g252539 , Out_PositionWO15_g252539 , Out_PivotWS15_g252539 , Out_PivotWO15_g252539 , Out_NormalWS15_g252539 , Out_TangentWS15_g252539 , Out_BitangentWS15_g252539 , Out_TriplanarWeights15_g252539 , Out_ViewDirWS15_g252539 , Out_CoordsData15_g252539 , Out_VertexData15_g252539 , Out_Interpolator15_g252539 );
					half4 Model_VertexData307_g252514 = Out_VertexData15_g252539;
					float4 temp_output_3_0_g252535 = Model_VertexData307_g252514;
					float4 Channel70_g252535 = temp_output_3_0_g252535;
					float localSwitchChannel470_g252535 = SwitchChannel4( Option70_g252535 , Channel70_g252535 );
					float temp_output_521_0_g252514 = localSwitchChannel470_g252535;
					float temp_output_7_0_g252524 = _TintingMeshRemap.x;
					float temp_output_9_0_g252524 = ( temp_output_521_0_g252514 - temp_output_7_0_g252524 );
					float lerpResult370_g252514 = lerp( 1.0 , saturate( ( temp_output_9_0_g252524 * _TintingMeshRemap.z ) ) , _TintingMeshValue);
					half Blend_VertMask309_g252514 = lerpResult370_g252514;
					float temp_output_64_0_g252552 = ( Blend_TexMask385_g252514 * Blend_MutiMask121_g252514 * Blend_LumaMask153_g252514 * Blend_NoiseMask213_g252514 * Blend_UserMask345_g252514 * Blend_VertMask309_g252514 );
					half Blend_GlobalValue285_g252514 = 1.0;
					float temp_output_92_0_g252552 = ( Feature_Intensity508_g252514 * Blend_GlobalValue285_g252514 );
					half Multiply93_g252552 = ( temp_output_64_0_g252552 * temp_output_92_0_g252552 );
					half Subtract93_g252552 = saturate( ( temp_output_92_0_g252552 - ( 1.0 - temp_output_64_0_g252552 ) ) );
					half Option93_g252552 = _TintingBlendMath;
					half localSwitchBlendMask93_g252552 = SwitchBlendMask( Multiply93_g252552 , Subtract93_g252552 , Option93_g252552 );
					float temp_output_7_0_g252553 = _TintingBlendRemap.x;
					float temp_output_9_0_g252553 = ( localSwitchBlendMask93_g252552 - temp_output_7_0_g252553 );
					half Blend_Mask242_g252514 = ( saturate( ( temp_output_9_0_g252553 * _TintingBlendRemap.z ) ) * TVE_IsEnabled );
					float4 appendResult513_g252514 = (float4(Blend_Mask242_g252514 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_45 = (0.0).xxxx;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 ifLocalVar18_g252555 = 0;
					if( Feature_Intensity508_g252514 <= 0.0 )
					ifLocalVar18_g252555 = temp_cast_46;
					else
					ifLocalVar18_g252555 = appendResult513_g252514;
					float4 In_MaskB3_g252541 = ifLocalVar18_g252555;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskC3_g252541 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskD3_g252541 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskE3_g252541 = temp_cast_49;
					float4 temp_cast_50 = (0.0).xxxx;
					float4 In_MaskF3_g252541 = temp_cast_50;
					float4 temp_cast_51 = (0.0).xxxx;
					float4 In_MaskG3_g252541 = temp_cast_51;
					float4 temp_cast_52 = (0.0).xxxx;
					float4 In_MaskH3_g252541 = temp_cast_52;
					float4 temp_cast_53 = (0.0).xxxx;
					float4 In_MaskI3_g252541 = temp_cast_53;
					float4 temp_cast_54 = (0.0).xxxx;
					float4 In_MaskJ3_g252541 = temp_cast_54;
					float4 temp_cast_55 = (0.0).xxxx;
					float4 In_MaskK3_g252541 = temp_cast_55;
					float4 temp_cast_56 = (0.0).xxxx;
					float4 In_MaskL3_g252541 = temp_cast_56;
					{
					Data3_g252541.MaskA = In_MaskA3_g252541;
					Data3_g252541.MaskB = In_MaskB3_g252541;
					Data3_g252541.MaskC = In_MaskC3_g252541;
					Data3_g252541.MaskD = In_MaskD3_g252541;
					Data3_g252541.MaskE = In_MaskE3_g252541;
					Data3_g252541.MaskF = In_MaskF3_g252541;
					Data3_g252541.MaskG = In_MaskG3_g252541;
					Data3_g252541.MaskH = In_MaskH3_g252541;
					Data3_g252541.MaskI = In_MaskI3_g252541;
					Data3_g252541.MaskJ= In_MaskJ3_g252541;
					Data3_g252541.MaskK= In_MaskK3_g252541;
					Data3_g252541.MaskL = In_MaskL3_g252541;
					}
					TVEMasksData DataB25_g252556 = Data3_g252541;
					float Alpha25_g252556 = TVE_DEBUG_Global;
					{
					if (Alpha25_g252556 < 0.5 )
					{
					Data25_g252556 = DataA25_g252556;
					}
					else
					{
					Data25_g252556 = DataB25_g252556;
					}
					}
					TVEMasksData Data4_g252557 = Data25_g252556;
					float4 Out_MaskA4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g252557 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g252557 = Data4_g252557.MaskA;
					Out_MaskB4_g252557 = Data4_g252557.MaskB;
					Out_MaskC4_g252557 = Data4_g252557.MaskC;
					Out_MaskD4_g252557 = Data4_g252557.MaskD;
					Out_MaskE4_g252557 = Data4_g252557.MaskE;
					Out_MaskF4_g252557 = Data4_g252557.MaskF;
					Out_MaskG4_g252557 = Data4_g252557.MaskG;
					Out_MaskH4_g252557 = Data4_g252557.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g252557;
					float3 lerpResult2568 = lerp( color107_g252558 , color106_g252558 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g252562 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g252562 = lerpResult2568;
					float3 ifLocalVar40_g252563 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g252563 = (Out_MaskB4_g252557).xxx;
					float3 color107_g252560 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252560 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g252560 , color106_g252560 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g252564 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g252564 = lerpResult2607;
					half IsTerranShader2496 = _IsTerrainShader;
					float3 lerpResult2660 = lerp( ( ifLocalVar40_g252562 + ifLocalVar40_g252563 + ifLocalVar40_g252564 ) , float3( 0,0,0 ) , IsTerranShader2496);
					half3 Final_Debug2399 = lerpResult2660;
					float temp_output_7_0_g252573 = TVE_DEBUG_Min;
					float3 temp_cast_57 = (temp_output_7_0_g252573).xxx;
					float3 temp_output_9_0_g252573 = ( Final_Debug2399 - temp_cast_57 );
					float lerpResult76_g252566 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g252566 = lerpResult76_g252566;
					float3 lerpResult72_g252566 = lerp( (lerpResult73_g252567).rgb , saturate( ( temp_output_9_0_g252573 / ( ( TVE_DEBUG_Max - temp_output_7_0_g252573 ) + 0.0001 ) ) ) , Filter152_g252566);
					float dotResult61_g252566 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g252566 = ( 1.0 - saturate( dotResult61_g252566 ) );
					float Shading_Fresnel59_g252566 = (( 1.0 - ( temp_output_65_0_g252566 * temp_output_65_0_g252566 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g252566 = IN.ase_texcoord10;
					float depthLinearEye57_g252566 = LinearEyeDepth( ase_positionCS57_g252566.z / ase_positionCS57_g252566.w );
					float temp_output_69_0_g252566 = saturate(  (0.0 + ( depthLinearEye57_g252566 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g252566 = (( temp_output_69_0_g252566 * temp_output_69_0_g252566 )*0.5 + 0.5);
					float lerpResult84_g252566 = lerp( 1.0 , Shading_Fresnel59_g252566 , ( Shading_Distance58_g252566 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g252571 = ( 0.0 );
					TVEVisualData Data4_g252571 =(TVEVisualData)Data3_g252260;
					float Out_Dummy4_g252571 = 0.0;
					float3 Out_Albedo4_g252571 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252571 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252571 = float2( 0,0 );
					float3 Out_NormalWS4_g252571 = float3( 0,0,0 );
					float4 Out_Shader4_g252571 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252571 = float4( 0,0,0,0 );
					float4 Out_Season4_g252571 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252571 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252571 = 0.0;
					float Out_Grayscale4_g252571 = 0.0;
					float Out_Luminosity4_g252571 = 0.0;
					float Out_AlphaClip4_g252571 = 0.0;
					float Out_AlphaFade4_g252571 = 0.0;
					float3 Out_Translucency4_g252571 = float3( 0,0,0 );
					float Out_Transmission4_g252571 = 0.0;
					float Out_Thickness4_g252571 = 0.0;
					float Out_Diffusion4_g252571 = 0.0;
					float Out_Depth4_g252571 = 0.0;
					BreakVisualData( Data4_g252571 , Out_Dummy4_g252571 , Out_Albedo4_g252571 , Out_AlbedoBase4_g252571 , Out_NormalTS4_g252571 , Out_NormalWS4_g252571 , Out_Shader4_g252571 , Out_Feature4_g252571 , Out_Season4_g252571 , Out_Emissive4_g252571 , Out_MultiMask4_g252571 , Out_Grayscale4_g252571 , Out_Luminosity4_g252571 , Out_AlphaClip4_g252571 , Out_AlphaFade4_g252571 , Out_Translucency4_g252571 , Out_Transmission4_g252571 , Out_Thickness4_g252571 , Out_Diffusion4_g252571 , Out_Depth4_g252571 );
					float Alpha109_g252566 = Out_AlphaClip4_g252571;
					float lerpResult91_g252566 = lerp( 1.0 , Alpha109_g252566 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g252566 = lerp( 1.0 , lerpResult91_g252566 , Filter152_g252566);
					clip( lerpResult154_g252566 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2672_114;
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

					o.Emission = ( lerpResult72_g252566 * lerpResult84_g252566 );
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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_TINTING_PAINT
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
				uniform half _TintingIntensityValue;
				uniform half _TintingPaintMode;
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
				uniform half _TintingMultiValue;
				uniform half4 _TintingLumaRemap;
				uniform half _TintingLumaValue;
				uniform half _TintingMeshMode;
				uniform half4 _TintingMeshRemap;
				uniform half _TintingMeshValue;
				uniform half _TintingPaintValue;
				uniform half _TintingBlendMath;
				uniform half4 _TintingBlendRemap;
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

					TVEVertexData Data16_g252031 =(TVEVertexData)0;
					float In_Dummy16_g252031 = 0.0;
					TVEVertexData Data16_g252026 =(TVEVertexData)0;
					float In_Dummy16_g252026 = 0.0;
					TVEModelData Data16_g251777 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#endif
					half Dummy207_g251759 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251759 );
					float temp_output_14_0_g251777 = Dummy207_g251759;
					float In_Dummy16_g251777 = temp_output_14_0_g251777;
					float3 PositionOS131_g251759 = v.vertex.xyz;
					float3 temp_output_4_0_g251777 = PositionOS131_g251759;
					float3 In_PositionOS16_g251777 = temp_output_4_0_g251777;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251759 = ase_positionWS;
					float3 vertexToFrag73_g251759 = temp_output_104_7_g251759;
					float3 PositionWS122_g251759 = vertexToFrag73_g251759;
					float3 In_PositionWS16_g251777 = PositionWS122_g251759;
					float4x4 break19_g251762 = unity_ObjectToWorld;
					float3 appendResult20_g251762 = (float3(break19_g251762[ 0 ][ 3 ] , break19_g251762[ 1 ][ 3 ] , break19_g251762[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251759 = appendResult20_g251762;
					float4x4 break19_g251764 = unity_ObjectToWorld;
					float3 appendResult20_g251764 = (float3(break19_g251764[ 0 ][ 3 ] , break19_g251764[ 1 ][ 3 ] , break19_g251764[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251760 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251759 = PositionOS131_g251759;
					float3 appendResult234_g251759 = (float3(break233_g251759.x , 0.0 , break233_g251759.z));
					float3 break413_g251759 = PositionOS131_g251759;
					float3 appendResult414_g251759 = (float3(break413_g251759.x , break413_g251759.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251766 = appendResult414_g251759;
					#else
					float3 staticSwitch65_g251766 = appendResult234_g251759;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251759 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251759 = appendResult60_g251760;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251759 = staticSwitch65_g251766;
					#else
					float3 staticSwitch229_g251759 = _Vector0;
					#endif
					float3 PivotOS149_g251759 = staticSwitch229_g251759;
					float3 temp_output_122_0_g251764 = PivotOS149_g251759;
					float3 PivotsOnlyWS105_g251764 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251764 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251759 = ( appendResult20_g251764 + PivotsOnlyWS105_g251764 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#else
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#endif
					float3 vertexToFrag76_g251759 = staticSwitch236_g251759;
					float3 PivotWS121_g251759 = vertexToFrag76_g251759;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251759 = ( PositionWS122_g251759 - PivotWS121_g251759 );
					#else
					float3 staticSwitch204_g251759 = PositionWS122_g251759;
					#endif
					float3 PositionWO132_g251759 = ( staticSwitch204_g251759 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251777 = PositionWO132_g251759;
					float3 In_PivotOS16_g251777 = PivotOS149_g251759;
					float3 In_PivotWS16_g251777 = PivotWS121_g251759;
					float3 PivotWO133_g251759 = ( PivotWS121_g251759 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251777 = PivotWO133_g251759;
					half3 NormalOS134_g251759 = v.normal;
					float3 temp_output_21_0_g251777 = NormalOS134_g251759;
					float3 In_NormalOS16_g251777 = temp_output_21_0_g251777;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251759 = normalizedWorldNormal;
					float3 In_NormalWS16_g251777 = NormalWS95_g251759;
					half4 TangentlOS153_g251759 = v.tangent;
					float4 temp_output_6_0_g251777 = TangentlOS153_g251759;
					float4 In_TangentOS16_g251777 = temp_output_6_0_g251777;
					float3 normalizeResult296_g251759 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251759 ) );
					half3 ViewDirWS169_g251759 = normalizeResult296_g251759;
					float3 In_ViewDirWS16_g251777 = ViewDirWS169_g251759;
					float4 appendResult397_g251759 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251759 = appendResult397_g251759;
					float4 In_CoordsData16_g251777 = CoordsData398_g251759;
					half4 VertexMasks171_g251759 = v.ase_color;
					float4 In_VertexData16_g251777 = VertexMasks171_g251759;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251771 = (PositionOS131_g251759).z;
					#else
					float staticSwitch65_g251771 = (PositionOS131_g251759).y;
					#endif
					half Object_HeightValue267_g251759 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251759 = saturate( ( staticSwitch65_g251771 / Object_HeightValue267_g251759 ) );
					half3 Position387_g251759 = PositionOS131_g251759;
					half Height387_g251759 = Object_HeightValue267_g251759;
					half Object_RadiusValue268_g251759 = _ObjectRadiusValue;
					half Radius387_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskYUp387_g251759 = CapsuleMaskYUp( Position387_g251759 , Height387_g251759 , Radius387_g251759 );
					half3 Position408_g251759 = PositionOS131_g251759;
					half Height408_g251759 = Object_HeightValue267_g251759;
					half Radius408_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskZUp408_g251759 = CapsuleMaskZUp( Position408_g251759 , Height408_g251759 , Radius408_g251759 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251776 = saturate( localCapsuleMaskZUp408_g251759 );
					#else
					float staticSwitch65_g251776 = saturate( localCapsuleMaskYUp387_g251759 );
					#endif
					half Bounds_SphereMask282_g251759 = staticSwitch65_g251776;
					float4 appendResult253_g251759 = (float4(Bounds_HeightMask274_g251759 , Bounds_SphereMask282_g251759 , 1.0 , 1.0));
					half4 MasksData254_g251759 = appendResult253_g251759;
					float4 In_MasksData16_g251777 = MasksData254_g251759;
					float temp_output_17_0_g251770 = _ObjectPhaseMode;
					float Option70_g251770 = temp_output_17_0_g251770;
					float4 temp_output_3_0_g251770 = v.ase_color;
					float4 Channel70_g251770 = temp_output_3_0_g251770;
					float localSwitchChannel470_g251770 = SwitchChannel4( Option70_g251770 , Channel70_g251770 );
					half Phase_Value372_g251759 = localSwitchChannel470_g251770;
					float3 break319_g251759 = PivotWO133_g251759;
					half Pivot_Position322_g251759 = ( break319_g251759.x + break319_g251759.z );
					half Phase_Position357_g251759 = ( Phase_Value372_g251759 + Pivot_Position322_g251759 );
					float temp_output_248_0_g251759 = frac( Phase_Position357_g251759 );
					float4 appendResult177_g251759 = (float4((frac( ( Phase_Position357_g251759 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251759));
					half4 Phase_Data176_g251759 = appendResult177_g251759;
					float4 In_PhaseData16_g251777 = Phase_Data176_g251759;
					BuildModelVertData( Data16_g251777 , In_Dummy16_g251777 , In_PositionOS16_g251777 , In_PositionWS16_g251777 , In_PositionWO16_g251777 , In_PivotOS16_g251777 , In_PivotWS16_g251777 , In_PivotWO16_g251777 , In_NormalOS16_g251777 , In_NormalWS16_g251777 , In_TangentOS16_g251777 , In_ViewDirWS16_g251777 , In_CoordsData16_g251777 , In_VertexData16_g251777 , In_MasksData16_g251777 , In_PhaseData16_g251777 );
					TVEModelData Data15_g252027 =(TVEModelData)Data16_g251777;
					float Out_Dummy15_g252027 = 0.0;
					float3 Out_PositionOS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252027 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252027 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252027 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252027 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252027 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252027 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252027 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252027 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252027 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252027 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252027 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252027 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252027 , Out_Dummy15_g252027 , Out_PositionOS15_g252027 , Out_PositionWS15_g252027 , Out_PositionWO15_g252027 , Out_PositionRawOS15_g252027 , Out_PivotOS15_g252027 , Out_PivotWS15_g252027 , Out_PivotWO15_g252027 , Out_NormalOS15_g252027 , Out_NormalWS15_g252027 , Out_NormalRawOS15_g252027 , Out_TangentOS15_g252027 , Out_TangentWS15_g252027 , Out_BitangentWS15_g252027 , Out_ViewDirWS15_g252027 , Out_CoordsData15_g252027 , Out_VertexData15_g252027 , Out_MasksData15_g252027 , Out_PhaseData15_g252027 , Out_TransformData15_g252027 , Out_RotationData15_g252027 , Out_Interpolator15_g252027 );
					float3 In_PositionOS16_g252026 = Out_PositionOS15_g252027;
					float3 In_NormalOS16_g252026 = Out_NormalOS15_g252027;
					float4 In_TangentOS16_g252026 = Out_TangentOS15_g252027;
					float4 In_TransformData16_g252026 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252026 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252026 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252026 , In_Dummy16_g252026 , In_PositionOS16_g252026 , In_NormalOS16_g252026 , In_TangentOS16_g252026 , In_TransformData16_g252026 , In_RotationData16_g252026 , In_Interpolator16_g252026 );
					TVEVertexData Data15_g252029 =(TVEVertexData)Data16_g252026;
					float Out_Dummy15_g252029 = 0.0;
					float3 Out_PositionOS15_g252029 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252029 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252029 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252029 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252029 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252029 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252029 , Out_Dummy15_g252029 , Out_PositionOS15_g252029 , Out_NormalOS15_g252029 , Out_TangentOS15_g252029 , Out_TransformData15_g252029 , Out_RotationData15_g252029 , Out_Interpolator15_g252029 );
					TVEModelData Data15_g252030 =(TVEModelData)Data15_g252027;
					float Out_Dummy15_g252030 = 0.0;
					float3 Out_PositionOS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252030 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252030 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252030 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252030 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252030 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252030 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252030 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252030 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252030 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252030 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252030 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252030 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252030 , Out_Dummy15_g252030 , Out_PositionOS15_g252030 , Out_PositionWS15_g252030 , Out_PositionWO15_g252030 , Out_PositionRawOS15_g252030 , Out_PivotOS15_g252030 , Out_PivotWS15_g252030 , Out_PivotWO15_g252030 , Out_NormalOS15_g252030 , Out_NormalWS15_g252030 , Out_NormalRawOS15_g252030 , Out_TangentOS15_g252030 , Out_TangentWS15_g252030 , Out_BitangentWS15_g252030 , Out_ViewDirWS15_g252030 , Out_CoordsData15_g252030 , Out_VertexData15_g252030 , Out_MasksData15_g252030 , Out_PhaseData15_g252030 , Out_TransformData15_g252030 , Out_RotationData15_g252030 , Out_Interpolator15_g252030 );
					float3 In_PositionOS16_g252031 = ( Out_PositionOS15_g252029 - Out_PivotOS15_g252030 );
					float3 In_NormalOS16_g252031 = Out_NormalOS15_g252030;
					float4 In_TangentOS16_g252031 = Out_TangentOS15_g252030;
					float4 In_TransformData16_g252031 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252031 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252031 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252031 , In_Dummy16_g252031 , In_PositionOS16_g252031 , In_NormalOS16_g252031 , In_TangentOS16_g252031 , In_TransformData16_g252031 , In_RotationData16_g252031 , In_Interpolator16_g252031 );
					TVEVertexData Data15_g252040 =(TVEVertexData)Data16_g252031;
					float Out_Dummy15_g252040 = 0.0;
					float3 Out_PositionOS15_g252040 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252040 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252040 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252040 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252040 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252040 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252040 , Out_Dummy15_g252040 , Out_PositionOS15_g252040 , Out_NormalOS15_g252040 , Out_TangentOS15_g252040 , Out_TransformData15_g252040 , Out_RotationData15_g252040 , Out_Interpolator15_g252040 );
					TVEVertexData Data16_g252041 =(TVEVertexData)Data15_g252040;
					half Dummy317_g252032 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g252041 = Dummy317_g252032;
					float3 In_PositionOS16_g252041 = Out_PositionOS15_g252040;
					float3 In_NormalOS16_g252041 = Out_NormalOS15_g252040;
					float4 In_TangentOS16_g252041 = Out_TangentOS15_g252040;
					half4 Model_TransformData356_g252032 = Out_TransformData15_g252040;
					float localBuildGlobalData204_g251779 = ( 0.0 );
					TVEGlobalData Data204_g251779 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251779 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251779 = Dummy211_g251779;
					float4 temp_output_203_0_g251798 = TVE_CoatBaseCoord;
					TVEModelData Data16_g251767 =(TVEModelData)0;
					float In_Dummy16_g251767 = 0.0;
					float3 In_PositionWS16_g251767 = PositionWS122_g251759;
					float3 In_PositionWO16_g251767 = PositionWO132_g251759;
					float3 In_PivotWS16_g251767 = PivotWS121_g251759;
					float3 In_PivotWO16_g251767 = PivotWO133_g251759;
					float3 In_NormalWS16_g251767 = NormalWS95_g251759;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251759 = ase_tangentWS;
					float3 In_TangentWS16_g251767 = TangentWS136_g251759;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251759 = ase_bitangentWS;
					float3 In_BitangentWS16_g251767 = BiangentWS421_g251759;
					half3 NormalWS427_g251759 = NormalWS95_g251759;
					half3 localComputeTriplanarMasks427_g251759 = ComputeTriplanarMasks( NormalWS427_g251759 );
					half3 TriplanarWeights429_g251759 = localComputeTriplanarMasks427_g251759;
					float3 In_TriplanarWeights16_g251767 = TriplanarWeights429_g251759;
					float3 In_ViewDirWS16_g251767 = ViewDirWS169_g251759;
					float4 In_CoordsData16_g251767 = CoordsData398_g251759;
					float4 In_VertexData16_g251767 = VertexMasks171_g251759;
					float4 In_Interpolator16_g251767 = Phase_Data176_g251759;
					BuildModelFragData( Data16_g251767 , In_Dummy16_g251767 , In_PositionWS16_g251767 , In_PositionWO16_g251767 , In_PivotWS16_g251767 , In_PivotWO16_g251767 , In_NormalWS16_g251767 , In_TangentWS16_g251767 , In_BitangentWS16_g251767 , In_TriplanarWeights16_g251767 , In_ViewDirWS16_g251767 , In_CoordsData16_g251767 , In_VertexData16_g251767 , In_Interpolator16_g251767 );
					TVEModelData Data15_g251869 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g251869 = 0.0;
					float3 Out_PositionWS15_g251869 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251869 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251869 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251869 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251869 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251869 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251869 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251869 , Out_Dummy15_g251869 , Out_PositionWS15_g251869 , Out_PositionWO15_g251869 , Out_PivotWS15_g251869 , Out_PivotWO15_g251869 , Out_NormalWS15_g251869 , Out_TangentWS15_g251869 , Out_BitangentWS15_g251869 , Out_TriplanarWeights15_g251869 , Out_ViewDirWS15_g251869 , Out_CoordsData15_g251869 , Out_VertexData15_g251869 , Out_Interpolator15_g251869 );
					float3 Model_PositionWS497_g251779 = Out_PositionWS15_g251869;
					float2 Model_PositionWS_XZ143_g251779 = (Model_PositionWS497_g251779).xz;
					float3 Model_PivotWS498_g251779 = Out_PivotWS15_g251869;
					float2 Model_PivotWS_XZ145_g251779 = (Model_PivotWS498_g251779).xz;
					float2 lerpResult300_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251798 = lerpResult300_g251779;
					float temp_output_82_0_g251796 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251798 = temp_output_82_0_g251796;
					float4 tex2DArrayNode83_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251798).zw + ( (temp_output_203_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult210_g251798 = (float4(tex2DArrayNode83_g251798.rgb , tex2DArrayNode83_g251798.a));
					float4 temp_output_204_0_g251798 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251798).zw + ( (temp_output_204_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult212_g251798 = (float4(tex2DArrayNode122_g251798.rgb , tex2DArrayNode122_g251798.a));
					float4 TVE_RenderNearPositionR628_g251779 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251779 = saturate( ( distance( Model_PositionWS497_g251779 , (TVE_RenderNearPositionR628_g251779).xyz ) / (TVE_RenderNearPositionR628_g251779).w ) );
					float temp_output_7_0_g251868 = 1.0;
					float temp_output_9_0_g251868 = ( temp_output_507_0_g251779 - temp_output_7_0_g251868 );
					half TVE_RenderNearFadeValue635_g251779 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251779 = saturate( ( temp_output_9_0_g251868 / ( ( TVE_RenderNearFadeValue635_g251779 - temp_output_7_0_g251868 ) + 0.0001 ) ) );
					float4 lerpResult131_g251798 = lerp( appendResult210_g251798 , appendResult212_g251798 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251796 = lerpResult131_g251798;
					float4 lerpResult168_g251796 = lerp( TVE_CoatParams , temp_output_159_109_g251796 , TVE_CoatLayers[(int)temp_output_82_0_g251796]);
					float4 temp_output_589_109_g251779 = lerpResult168_g251796;
					half4 Coat_Texture302_g251779 = temp_output_589_109_g251779;
					float4 In_CoatTexture204_g251779 = Coat_Texture302_g251779;
					half4 Draw_Texture656_g251779 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251779 = Draw_Texture656_g251779;
					float4 temp_output_203_0_g251823 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251823 = lerpResult85_g251779;
					float temp_output_82_0_g251820 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251823 = temp_output_82_0_g251820;
					float4 tex2DArrayNode83_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251823).zw + ( (temp_output_203_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult210_g251823 = (float4(tex2DArrayNode83_g251823.rgb , tex2DArrayNode83_g251823.a));
					float4 temp_output_204_0_g251823 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251823).zw + ( (temp_output_204_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult212_g251823 = (float4(tex2DArrayNode122_g251823.rgb , tex2DArrayNode122_g251823.a));
					float4 lerpResult131_g251823 = lerp( appendResult210_g251823 , appendResult212_g251823 , Global_TexBlend509_g251779);
					float4 temp_output_171_109_g251820 = lerpResult131_g251823;
					float4 lerpResult174_g251820 = lerp( TVE_PaintParams , temp_output_171_109_g251820 , TVE_PaintLayers[(int)temp_output_82_0_g251820]);
					float4 temp_output_595_109_g251779 = lerpResult174_g251820;
					half4 Paint_Texture71_g251779 = temp_output_595_109_g251779;
					float4 In_PaintTexture204_g251779 = Paint_Texture71_g251779;
					float4 temp_output_203_0_g251806 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251806 = lerpResult104_g251779;
					float temp_output_132_0_g251804 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251806 = temp_output_132_0_g251804;
					float4 tex2DArrayNode83_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251806).zw + ( (temp_output_203_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult210_g251806 = (float4(tex2DArrayNode83_g251806.rgb , tex2DArrayNode83_g251806.a));
					float4 temp_output_204_0_g251806 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251806).zw + ( (temp_output_204_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult212_g251806 = (float4(tex2DArrayNode122_g251806.rgb , tex2DArrayNode122_g251806.a));
					float4 lerpResult131_g251806 = lerp( appendResult210_g251806 , appendResult212_g251806 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251804 = lerpResult131_g251806;
					float4 lerpResult145_g251804 = lerp( TVE_AtmoParams , temp_output_137_109_g251804 , TVE_AtmoLayers[(int)temp_output_132_0_g251804]);
					float4 temp_output_590_110_g251779 = lerpResult145_g251804;
					half4 Atmo_Texture80_g251779 = temp_output_590_110_g251779;
					float4 In_AtmoTexture204_g251779 = Atmo_Texture80_g251779;
					float4 temp_output_203_0_g251874 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251874 = lerpResult414_g251779;
					float temp_output_132_0_g251872 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251874 = temp_output_132_0_g251872;
					float4 tex2DArrayNode83_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251874).zw + ( (temp_output_203_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult210_g251874 = (float4(tex2DArrayNode83_g251874.rgb , tex2DArrayNode83_g251874.a));
					float4 temp_output_204_0_g251874 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251874).zw + ( (temp_output_204_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult212_g251874 = (float4(tex2DArrayNode122_g251874.rgb , tex2DArrayNode122_g251874.a));
					float4 lerpResult131_g251874 = lerp( appendResult210_g251874 , appendResult212_g251874 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251872 = lerpResult131_g251874;
					float4 lerpResult145_g251872 = lerp( TVE_EffexParams , temp_output_137_109_g251872 , TVE_EffexLayers[(int)temp_output_132_0_g251872]);
					float4 temp_output_731_110_g251779 = lerpResult145_g251872;
					half4 Effex_Texture420_g251779 = temp_output_731_110_g251779;
					float4 In_EffexTexture204_g251779 = Effex_Texture420_g251779;
					float4 temp_output_203_0_g251854 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251854 = lerpResult247_g251779;
					float temp_output_82_0_g251852 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251854 = temp_output_82_0_g251852;
					float4 tex2DArrayNode83_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251854).zw + ( (temp_output_203_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult210_g251854 = (float4(tex2DArrayNode83_g251854.rgb , tex2DArrayNode83_g251854.a));
					float4 temp_output_204_0_g251854 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251854).zw + ( (temp_output_204_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult212_g251854 = (float4(tex2DArrayNode122_g251854.rgb , tex2DArrayNode122_g251854.a));
					float4 lerpResult131_g251854 = lerp( appendResult210_g251854 , appendResult212_g251854 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251852 = lerpResult131_g251854;
					float4 lerpResult167_g251852 = lerp( TVE_GlowParams , temp_output_159_109_g251852 , TVE_GlowLayers[(int)temp_output_82_0_g251852]);
					float4 temp_output_593_109_g251779 = lerpResult167_g251852;
					half4 Glow_Texture248_g251779 = temp_output_593_109_g251779;
					float4 In_GlowTexture204_g251779 = Glow_Texture248_g251779;
					float4 temp_output_203_0_g251790 = TVE_FormBaseCoord;
					float2 lerpResult168_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251790 = lerpResult168_g251779;
					float temp_output_130_0_g251788 = _GlobalFormLayerValue;
					float temp_output_82_0_g251790 = temp_output_130_0_g251788;
					float4 tex2DArrayNode83_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251790).zw + ( (temp_output_203_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult210_g251790 = (float4(tex2DArrayNode83_g251790.rgb , tex2DArrayNode83_g251790.a));
					float4 temp_output_204_0_g251790 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251790).zw + ( (temp_output_204_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult212_g251790 = (float4(tex2DArrayNode122_g251790.rgb , tex2DArrayNode122_g251790.a));
					float4 lerpResult131_g251790 = lerp( appendResult210_g251790 , appendResult212_g251790 , Global_TexBlend509_g251779);
					float4 temp_output_135_109_g251788 = lerpResult131_g251790;
					float4 lerpResult143_g251788 = lerp( TVE_FormParams , temp_output_135_109_g251788 , TVE_FormLayers[(int)temp_output_130_0_g251788]);
					float4 temp_output_592_0_g251779 = lerpResult143_g251788;
					float4 Form_Texture112_g251779 = temp_output_592_0_g251779;
					float4 In_FormTexture204_g251779 = Form_Texture112_g251779;
					float4 In_LandTexture204_g251779 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251838 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251838 = lerpResult681_g251779;
					float temp_output_136_0_g251836 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251838 = temp_output_136_0_g251836;
					float4 tex2DArrayNode83_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251838).zw + ( (temp_output_203_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult210_g251838 = (float4(tex2DArrayNode83_g251838.rgb , tex2DArrayNode83_g251838.a));
					float4 temp_output_204_0_g251838 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251838).zw + ( (temp_output_204_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult212_g251838 = (float4(tex2DArrayNode122_g251838.rgb , tex2DArrayNode122_g251838.a));
					float4 lerpResult131_g251838 = lerp( appendResult210_g251838 , appendResult212_g251838 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251836 = lerpResult131_g251838;
					float4 lerpResult149_g251836 = lerp( TVE_VertxParams , temp_output_141_109_g251836 , TVE_VertxLayers[(int)temp_output_136_0_g251836]);
					float4 temp_output_695_0_g251779 = lerpResult149_g251836;
					half4 Vertx_Texture693_g251779 = temp_output_695_0_g251779;
					float4 In_VertxTexture204_g251779 = Vertx_Texture693_g251779;
					float4 temp_output_203_0_g251814 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251814 = lerpResult400_g251779;
					float temp_output_136_0_g251812 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251814 = temp_output_136_0_g251812;
					float4 tex2DArrayNode83_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251814).zw + ( (temp_output_203_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult210_g251814 = (float4(tex2DArrayNode83_g251814.rgb , tex2DArrayNode83_g251814.a));
					float4 temp_output_204_0_g251814 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251814).zw + ( (temp_output_204_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult212_g251814 = (float4(tex2DArrayNode122_g251814.rgb , tex2DArrayNode122_g251814.a));
					float4 lerpResult131_g251814 = lerp( appendResult210_g251814 , appendResult212_g251814 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251812 = lerpResult131_g251814;
					float4 lerpResult149_g251812 = lerp( TVE_FlowParams , temp_output_141_109_g251812 , TVE_FlowLayers[(int)temp_output_136_0_g251812]);
					float4 temp_output_594_0_g251779 = lerpResult149_g251812;
					half4 Flow_Texture405_g251779 = temp_output_594_0_g251779;
					float4 In_FlowTexture204_g251779 = Flow_Texture405_g251779;
					half4 User_Texture677_g251779 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251779 = User_Texture677_g251779;
					BuildGlobalData( Data204_g251779 , In_Dummy204_g251779 , In_CoatTexture204_g251779 , In_DrawTexture204_g251779 , In_PaintTexture204_g251779 , In_AtmoTexture204_g251779 , In_EffexTexture204_g251779 , In_GlowTexture204_g251779 , In_FormTexture204_g251779 , In_LandTexture204_g251779 , In_VertxTexture204_g251779 , In_FlowTexture204_g251779 , In_UserTexture204_g251779 );
					TVEGlobalData Data15_g252042 =(TVEGlobalData)Data204_g251779;
					float Out_Dummy15_g252042 = 0.0;
					float4 Out_CoatTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252042 = float4( 0,0,0,0 );
					BreakData( Data15_g252042 , Out_Dummy15_g252042 , Out_CoatTexture15_g252042 , Out_DrawTexture15_g252042 , Out_PaintTexture15_g252042 , Out_AtmoTexture15_g252042 , Out_EffexTexture15_g252042 , Out_GlowTexture15_g252042 , Out_FormTexture15_g252042 , Out_LandTexture15_g252042 , Out_VertxTexture15_g252042 , Out_FlowTexture15_g252042 , Out_UserTexture15_g252042 );
					float4 Global_FormTexture351_g252032 = Out_FormTexture15_g252042;
					TVEModelData Data15_g252039 =(TVEModelData)Data15_g252030;
					float Out_Dummy15_g252039 = 0.0;
					float3 Out_PositionOS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252039 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252039 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252039 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252039 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252039 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252039 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252039 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252039 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252039 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252039 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252039 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252039 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252039 , Out_Dummy15_g252039 , Out_PositionOS15_g252039 , Out_PositionWS15_g252039 , Out_PositionWO15_g252039 , Out_PositionRawOS15_g252039 , Out_PivotOS15_g252039 , Out_PivotWS15_g252039 , Out_PivotWO15_g252039 , Out_NormalOS15_g252039 , Out_NormalWS15_g252039 , Out_NormalRawOS15_g252039 , Out_TangentOS15_g252039 , Out_TangentWS15_g252039 , Out_BitangentWS15_g252039 , Out_ViewDirWS15_g252039 , Out_CoordsData15_g252039 , Out_VertexData15_g252039 , Out_MasksData15_g252039 , Out_PhaseData15_g252039 , Out_TransformData15_g252039 , Out_RotationData15_g252039 , Out_Interpolator15_g252039 );
					float3 Model_PivotWO353_g252032 = Out_PivotWO15_g252039;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g252038 = _ConformMeshMode;
					float Option70_g252038 = temp_output_17_0_g252038;
					half4 Model_VertexData357_g252032 = Out_VertexData15_g252039;
					float4 temp_output_3_0_g252038 = Model_VertexData357_g252032;
					float4 Channel70_g252038 = temp_output_3_0_g252038;
					float localSwitchChannel470_g252038 = SwitchChannel4( Option70_g252038 , Channel70_g252038 );
					float temp_output_390_0_g252032 = localSwitchChannel470_g252038;
					float temp_output_7_0_g252035 = _ConformMeshRemap.x;
					float temp_output_9_0_g252035 = ( temp_output_390_0_g252032 - temp_output_7_0_g252035 );
					float lerpResult374_g252032 = lerp( 1.0 , saturate( ( temp_output_9_0_g252035 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g252032 = lerpResult374_g252032;
					float temp_output_328_0_g252032 = ( Blend_VertMask379_g252032 * TVE_IsEnabled );
					half Conform_Mask366_g252032 = temp_output_328_0_g252032;
					float temp_output_322_0_g252032 = ( ( ( ( (Global_FormTexture351_g252032).z - ( (Model_PivotWO353_g252032).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g252032 ) );
					float3 appendResult329_g252032 = (float3(0.0 , temp_output_322_0_g252032 , 0.0));
					float3 appendResult387_g252032 = (float3(0.0 , 0.0 , temp_output_322_0_g252032));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252036 = appendResult387_g252032;
					#else
					float3 staticSwitch65_g252036 = appendResult329_g252032;
					#endif
					float3 Blanket_Conform368_g252032 = staticSwitch65_g252036;
					float4 appendResult312_g252032 = (float4(Blanket_Conform368_g252032 , 0.0));
					float4 temp_output_310_0_g252032 = ( Model_TransformData356_g252032 + appendResult312_g252032 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g252032 = temp_output_310_0_g252032;
					#else
					float4 staticSwitch364_g252032 = Model_TransformData356_g252032;
					#endif
					half4 Final_TransformData365_g252032 = staticSwitch364_g252032;
					float4 In_TransformData16_g252041 = Final_TransformData365_g252032;
					float4 In_RotationData16_g252041 = Out_RotationData15_g252040;
					float4 In_Interpolator16_g252041 = Out_Interpolator15_g252040;
					BuildVertexData( Data16_g252041 , In_Dummy16_g252041 , In_PositionOS16_g252041 , In_NormalOS16_g252041 , In_TangentOS16_g252041 , In_TransformData16_g252041 , In_RotationData16_g252041 , In_Interpolator16_g252041 );
					TVEVertexData Data15_g252052 =(TVEVertexData)Data16_g252041;
					float Out_Dummy15_g252052 = 0.0;
					float3 Out_PositionOS15_g252052 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252052 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252052 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252052 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252052 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252052 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252052 , Out_Dummy15_g252052 , Out_PositionOS15_g252052 , Out_NormalOS15_g252052 , Out_TangentOS15_g252052 , Out_TransformData15_g252052 , Out_RotationData15_g252052 , Out_Interpolator15_g252052 );
					TVEVertexData Data16_g252053 =(TVEVertexData)Data15_g252052;
					float In_Dummy16_g252053 = 0.0;
					float3 Vertex_PositionOS147_g252043 = Out_PositionOS15_g252052;
					half3 VertexPos40_g252047 = Vertex_PositionOS147_g252043;
					float4 temp_output_1615_33_g252043 = Out_RotationData15_g252052;
					half4 Vertex_RotationData1569_g252043 = temp_output_1615_33_g252043;
					float2 break1582_g252043 = (Vertex_RotationData1569_g252043).xy;
					half Angle44_g252047 = break1582_g252043.y;
					half CosAngle89_g252047 = cos( Angle44_g252047 );
					half SinAngle93_g252047 = sin( Angle44_g252047 );
					float3 appendResult95_g252047 = (float3((VertexPos40_g252047).x , ( ( (VertexPos40_g252047).y * CosAngle89_g252047 ) - ( (VertexPos40_g252047).z * SinAngle93_g252047 ) ) , ( ( (VertexPos40_g252047).y * SinAngle93_g252047 ) + ( (VertexPos40_g252047).z * CosAngle89_g252047 ) )));
					half3 VertexPos40_g252048 = appendResult95_g252047;
					half Angle44_g252048 = -break1582_g252043.x;
					half CosAngle94_g252048 = cos( Angle44_g252048 );
					half SinAngle95_g252048 = sin( Angle44_g252048 );
					float3 appendResult98_g252048 = (float3(( ( (VertexPos40_g252048).x * CosAngle94_g252048 ) - ( (VertexPos40_g252048).y * SinAngle95_g252048 ) ) , ( ( (VertexPos40_g252048).x * SinAngle95_g252048 ) + ( (VertexPos40_g252048).y * CosAngle94_g252048 ) ) , (VertexPos40_g252048).z));
					half3 VertexPos40_g252046 = Vertex_PositionOS147_g252043;
					half Angle44_g252046 = break1582_g252043.y;
					half CosAngle89_g252046 = cos( Angle44_g252046 );
					half SinAngle93_g252046 = sin( Angle44_g252046 );
					float3 appendResult95_g252046 = (float3((VertexPos40_g252046).x , ( ( (VertexPos40_g252046).y * CosAngle89_g252046 ) - ( (VertexPos40_g252046).z * SinAngle93_g252046 ) ) , ( ( (VertexPos40_g252046).y * SinAngle93_g252046 ) + ( (VertexPos40_g252046).z * CosAngle89_g252046 ) )));
					half3 VertexPos40_g252051 = appendResult95_g252046;
					half Angle44_g252051 = break1582_g252043.x;
					half CosAngle91_g252051 = cos( Angle44_g252051 );
					half SinAngle92_g252051 = sin( Angle44_g252051 );
					float3 appendResult93_g252051 = (float3(( ( (VertexPos40_g252051).x * CosAngle91_g252051 ) + ( (VertexPos40_g252051).z * SinAngle92_g252051 ) ) , (VertexPos40_g252051).y , ( ( -(VertexPos40_g252051).x * SinAngle92_g252051 ) + ( (VertexPos40_g252051).z * CosAngle91_g252051 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252049 = appendResult93_g252051;
					#else
					float3 staticSwitch65_g252049 = appendResult98_g252048;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g252044 = staticSwitch65_g252049;
					#else
					float3 staticSwitch65_g252044 = Vertex_PositionOS147_g252043;
					#endif
					float3 temp_output_1608_0_g252043 = staticSwitch65_g252044;
					half3 VertexPos40_g252050 = temp_output_1608_0_g252043;
					half Angle44_g252050 = (Vertex_RotationData1569_g252043).z;
					half CosAngle91_g252050 = cos( Angle44_g252050 );
					half SinAngle92_g252050 = sin( Angle44_g252050 );
					float3 appendResult93_g252050 = (float3(( ( (VertexPos40_g252050).x * CosAngle91_g252050 ) + ( (VertexPos40_g252050).z * SinAngle92_g252050 ) ) , (VertexPos40_g252050).y , ( ( -(VertexPos40_g252050).x * SinAngle92_g252050 ) + ( (VertexPos40_g252050).z * CosAngle91_g252050 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g252045 = appendResult93_g252050;
					#else
					float3 staticSwitch65_g252045 = temp_output_1608_0_g252043;
					#endif
					float4 temp_output_1615_31_g252043 = Out_TransformData15_g252052;
					half4 Vertex_TransformData1568_g252043 = temp_output_1615_31_g252043;
					half3 Final_PositionOS178_g252043 = ( ( staticSwitch65_g252045 * (Vertex_TransformData1568_g252043).w ) + (Vertex_TransformData1568_g252043).xyz );
					float3 In_PositionOS16_g252053 = Final_PositionOS178_g252043;
					float3 In_NormalOS16_g252053 = Out_NormalOS15_g252052;
					float4 In_TangentOS16_g252053 = Out_TangentOS15_g252052;
					float4 In_TransformData16_g252053 = temp_output_1615_31_g252043;
					float4 In_RotationData16_g252053 = temp_output_1615_33_g252043;
					float4 In_Interpolator16_g252053 = Out_Interpolator15_g252052;
					BuildVertexData( Data16_g252053 , In_Dummy16_g252053 , In_PositionOS16_g252053 , In_NormalOS16_g252053 , In_TangentOS16_g252053 , In_TransformData16_g252053 , In_RotationData16_g252053 , In_Interpolator16_g252053 );
					TVEVertexData Data15_g252056 =(TVEVertexData)Data16_g252053;
					float Out_Dummy15_g252056 = 0.0;
					float3 Out_PositionOS15_g252056 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252056 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252056 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252056 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252056 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252056 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252056 , Out_Dummy15_g252056 , Out_PositionOS15_g252056 , Out_NormalOS15_g252056 , Out_TangentOS15_g252056 , Out_TransformData15_g252056 , Out_RotationData15_g252056 , Out_Interpolator15_g252056 );
					TVEVertexData Data16_g252057 =(TVEVertexData)Data15_g252056;
					float In_Dummy16_g252057 = 0.0;
					TVEModelData Data15_g252055 =(TVEModelData)Data15_g252039;
					float Out_Dummy15_g252055 = 0.0;
					float3 Out_PositionOS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252055 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252055 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252055 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252055 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252055 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252055 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252055 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252055 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252055 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252055 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252055 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252055 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252055 , Out_Dummy15_g252055 , Out_PositionOS15_g252055 , Out_PositionWS15_g252055 , Out_PositionWO15_g252055 , Out_PositionRawOS15_g252055 , Out_PivotOS15_g252055 , Out_PivotWS15_g252055 , Out_PivotWO15_g252055 , Out_NormalOS15_g252055 , Out_NormalWS15_g252055 , Out_NormalRawOS15_g252055 , Out_TangentOS15_g252055 , Out_TangentWS15_g252055 , Out_BitangentWS15_g252055 , Out_ViewDirWS15_g252055 , Out_CoordsData15_g252055 , Out_VertexData15_g252055 , Out_MasksData15_g252055 , Out_PhaseData15_g252055 , Out_TransformData15_g252055 , Out_RotationData15_g252055 , Out_Interpolator15_g252055 );
					float3 In_PositionOS16_g252057 = ( Out_PositionOS15_g252056 + Out_PivotOS15_g252055 );
					float3 In_NormalOS16_g252057 = Out_NormalOS15_g252056;
					float4 In_TangentOS16_g252057 = Out_TangentOS15_g252056;
					float4 In_TransformData16_g252057 = Out_TransformData15_g252056;
					float4 In_RotationData16_g252057 = Out_RotationData15_g252056;
					float4 In_Interpolator16_g252057 = Out_Interpolator15_g252056;
					BuildVertexData( Data16_g252057 , In_Dummy16_g252057 , In_PositionOS16_g252057 , In_NormalOS16_g252057 , In_TangentOS16_g252057 , In_TransformData16_g252057 , In_RotationData16_g252057 , In_Interpolator16_g252057 );
					TVEVertexData Data15_g252574 =(TVEVertexData)Data16_g252057;
					float Out_Dummy15_g252574 = 0.0;
					float3 Out_PositionOS15_g252574 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252574 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252574 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252574 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252574 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252574 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252574 , Out_Dummy15_g252574 , Out_PositionOS15_g252574 , Out_NormalOS15_g252574 , Out_TangentOS15_g252574 , Out_TransformData15_g252574 , Out_RotationData15_g252574 , Out_Interpolator15_g252574 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g251759;
					o.ase_texcoord5.xyz = vertexToFrag76_g251759;
					TVEVertexData Data1902_g252254 = Data16_g252057;
					float4 Out_Interpolator1902_g252254 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g252254 = Data1902_g252254.Interpolator;
					}
					float4 vertexToFrag1901_g252254 = Out_Interpolator1902_g252254;
					o.ase_texcoord7 = vertexToFrag1901_g252254;
					float3 vertexPos57_g252566 = v.vertex.xyz;
					float4 ase_positionCS57_g252566 = UnityObjectToClipPos( vertexPos57_g252566 );
					o.ase_texcoord8 = ase_positionCS57_g252566;
					
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
					float3 vertexValue = Out_PositionOS15_g252574;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g252574;
					v.tangent = Out_TangentOS15_g252574;

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

					float temp_output_2672_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2672_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2672_114).xxx;
					
					float3 color130_g252566 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g252566 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g252568 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g252567 = ( temp_cast_4 * ( 0.5 + appendResult128_g252568 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g252567 = (float4(ddx( FinalUV13_g252567 ) , ddy( FinalUV13_g252567 )));
					float4 UVDerivatives17_g252567 = appendResult16_g252567;
					float4 break28_g252567 = UVDerivatives17_g252567;
					float2 appendResult19_g252567 = (float2(break28_g252567.x , break28_g252567.z));
					float2 appendResult20_g252567 = (float2(break28_g252567.x , break28_g252567.z));
					float dotResult24_g252567 = dot( appendResult19_g252567 , appendResult20_g252567 );
					float2 appendResult21_g252567 = (float2(break28_g252567.y , break28_g252567.w));
					float2 appendResult22_g252567 = (float2(break28_g252567.y , break28_g252567.w));
					float dotResult23_g252567 = dot( appendResult21_g252567 , appendResult22_g252567 );
					float2 appendResult25_g252567 = (float2(dotResult24_g252567 , dotResult23_g252567));
					float2 derivativesLength29_g252567 = sqrt( appendResult25_g252567 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g252567 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g252567 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g252567 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g252567 = clampResult57_g252567;
					float2 break55_g252567 = derivativesLength29_g252567;
					float4 lerpResult73_g252567 = lerp( float4( color130_g252566 , 0.0 ) , float4( color81_g252566 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g252567.x * break71_g252567.y * sqrt( saturate( ( 1.1 - max( break55_g252567.x, break55_g252567.y ) ) ) ) ) ) ));
					float3 color107_g252558 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252558 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g252557 = ( 0.0 );
					float localIfMasksData25_g252556 = ( 0.0 );
					TVEMasksData Data25_g252556 = (TVEMasksData)0;
					float localBuildMasksData3_g252499 = ( 0.0 );
					TVEMasksData Data3_g252499 = (TVEMasksData)0;
					half Feature_Intensity508_g252472 = _TintingIntensityValue;
					float ifLocalVar18_g252500 = 0;
					if( Feature_Intensity508_g252472 <= 0.0 )
					ifLocalVar18_g252500 = 0.0;
					else
					ifLocalVar18_g252500 = 1.0;
					half Feature_Element505_g252472 = _TintingPaintMode;
					float ifLocalVar18_g252501 = 0;
					if( Feature_Element505_g252472 <= 0.0 )
					ifLocalVar18_g252501 = 0.0;
					else
					ifLocalVar18_g252501 = 1.0;
					float4 appendResult517_g252472 = (float4(ifLocalVar18_g252500 , 0.0 , 0.0 , ifLocalVar18_g252501));
					float4 In_MaskA3_g252499 = appendResult517_g252472;
					half Blend_TexMask385_g252472 = 1.0;
					float localBreakVisualData4_g252496 = ( 0.0 );
					float localBuildVisualData3_g252260 = ( 0.0 );
					float localBuildVisualData3_g252255 = ( 0.0 );
					TVEVisualData Data3_g252255 =(TVEVisualData)0;
					float temp_output_14_0_g252255 = 0.0;
					float In_Dummy3_g252255 = temp_output_14_0_g252255;
					float3 temp_cast_9 = (0.5).xxx;
					float3 temp_output_4_0_g252255 = temp_cast_9;
					float3 In_Albedo3_g252255 = temp_output_4_0_g252255;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_44_0_g252255 = temp_cast_10;
					float3 In_AlbedoBase3_g252255 = temp_output_44_0_g252255;
					float2 temp_cast_11 = (0.0).xx;
					float2 In_NormalTS3_g252255 = temp_cast_11;
					float3 temp_cast_12 = (0.5).xxx;
					float3 In_NormalWS3_g252255 = temp_cast_12;
					float4 In_Shader3_g252255 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g252255 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252255 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252255 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g252255 = 0.5;
					float In_Grayscale3_g252255 = temp_output_12_0_g252255;
					float temp_output_16_0_g252255 = 1.0;
					float In_Luminosity3_g252255 = temp_output_16_0_g252255;
					float In_MultiMask3_g252255 = 1.0;
					float In_AlphaClip3_g252255 = 1.0;
					float In_AlphaFade3_g252255 = 1.0;
					float3 temp_cast_13 = (1.0).xxx;
					float3 In_Translucency3_g252255 = temp_cast_13;
					float In_Transmission3_g252255 = 1.0;
					float In_Thickness3_g252255 = 0.0;
					float In_Diffusion3_g252255 = 0.0;
					float In_Depth3_g252255 = 0.0;
					BuildVisualData( Data3_g252255 , In_Dummy3_g252255 , In_Albedo3_g252255 , In_AlbedoBase3_g252255 , In_NormalTS3_g252255 , In_NormalWS3_g252255 , In_Shader3_g252255 , In_Feature3_g252255 , In_Season3_g252255 , In_Emissive3_g252255 , In_Grayscale3_g252255 , In_Luminosity3_g252255 , In_MultiMask3_g252255 , In_AlphaClip3_g252255 , In_AlphaFade3_g252255 , In_Translucency3_g252255 , In_Transmission3_g252255 , In_Thickness3_g252255 , In_Diffusion3_g252255 , In_Depth3_g252255 );
					TVEVisualData Data3_g252260 =(TVEVisualData)Data3_g252255;
					half Dummy130_g252258 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g252260 = Dummy130_g252258;
					float In_Dummy3_g252260 = temp_output_14_0_g252260;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252281) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g252263 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g252263 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g252281 = staticSwitch36_g252263;
					float localBreakTextureData456_g252281 = ( 0.0 );
					float localBuildTextureData431_g252280 = ( 0.0 );
					TVEMasksData Data431_g252280 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252280 = ( 0.0 );
					float4 temp_output_6_0_g252296 = _main_coord_value;
					float4 temp_output_7_0_g252296 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252296 = ( temp_output_6_0_g252296 + temp_output_7_0_g252296 );
					#else
					float4 staticSwitch14_g252296 = temp_output_6_0_g252296;
					#endif
					half4 Local_Coords180_g252258 = staticSwitch14_g252296;
					float4 Coords444_g252280 = Local_Coords180_g252258;
					TVEModelData Data16_g251767 =(TVEModelData)0;
					float In_Dummy16_g251767 = 0.0;
					float3 vertexToFrag73_g251759 = IN.ase_texcoord4.xyz;
					float3 PositionWS122_g251759 = vertexToFrag73_g251759;
					float3 In_PositionWS16_g251767 = PositionWS122_g251759;
					float3 vertexToFrag76_g251759 = IN.ase_texcoord5.xyz;
					float3 PivotWS121_g251759 = vertexToFrag76_g251759;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251759 = ( PositionWS122_g251759 - PivotWS121_g251759 );
					#else
					float3 staticSwitch204_g251759 = PositionWS122_g251759;
					#endif
					float3 PositionWO132_g251759 = ( staticSwitch204_g251759 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251767 = PositionWO132_g251759;
					float3 In_PivotWS16_g251767 = PivotWS121_g251759;
					float3 PivotWO133_g251759 = ( PivotWS121_g251759 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251767 = PivotWO133_g251759;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g251759 = normalizedWorldNormal;
					float3 In_NormalWS16_g251767 = NormalWS95_g251759;
					half3 TangentWS136_g251759 = TangentWS;
					float3 In_TangentWS16_g251767 = TangentWS136_g251759;
					half3 BiangentWS421_g251759 = BitangentWS;
					float3 In_BitangentWS16_g251767 = BiangentWS421_g251759;
					half3 NormalWS427_g251759 = NormalWS95_g251759;
					half3 localComputeTriplanarMasks427_g251759 = ComputeTriplanarMasks( NormalWS427_g251759 );
					half3 TriplanarWeights429_g251759 = localComputeTriplanarMasks427_g251759;
					float3 In_TriplanarWeights16_g251767 = TriplanarWeights429_g251759;
					float3 normalizeResult296_g251759 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251759 ) );
					half3 ViewDirWS169_g251759 = normalizeResult296_g251759;
					float3 In_ViewDirWS16_g251767 = ViewDirWS169_g251759;
					float4 appendResult397_g251759 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g251759 = appendResult397_g251759;
					float4 In_CoordsData16_g251767 = CoordsData398_g251759;
					half4 VertexMasks171_g251759 = IN.ase_color;
					float4 In_VertexData16_g251767 = VertexMasks171_g251759;
					float temp_output_17_0_g251770 = _ObjectPhaseMode;
					float Option70_g251770 = temp_output_17_0_g251770;
					float4 temp_output_3_0_g251770 = IN.ase_color;
					float4 Channel70_g251770 = temp_output_3_0_g251770;
					float localSwitchChannel470_g251770 = SwitchChannel4( Option70_g251770 , Channel70_g251770 );
					half Phase_Value372_g251759 = localSwitchChannel470_g251770;
					float3 break319_g251759 = PivotWO133_g251759;
					half Pivot_Position322_g251759 = ( break319_g251759.x + break319_g251759.z );
					half Phase_Position357_g251759 = ( Phase_Value372_g251759 + Pivot_Position322_g251759 );
					float temp_output_248_0_g251759 = frac( Phase_Position357_g251759 );
					float4 appendResult177_g251759 = (float4((frac( ( Phase_Position357_g251759 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251759));
					half4 Phase_Data176_g251759 = appendResult177_g251759;
					float4 In_Interpolator16_g251767 = Phase_Data176_g251759;
					BuildModelFragData( Data16_g251767 , In_Dummy16_g251767 , In_PositionWS16_g251767 , In_PositionWO16_g251767 , In_PivotWS16_g251767 , In_PivotWO16_g251767 , In_NormalWS16_g251767 , In_TangentWS16_g251767 , In_BitangentWS16_g251767 , In_TriplanarWeights16_g251767 , In_ViewDirWS16_g251767 , In_CoordsData16_g251767 , In_VertexData16_g251767 , In_Interpolator16_g251767 );
					TVEModelData Data15_g252256 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g252256 = 0.0;
					float3 Out_PositionWS15_g252256 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252256 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252256 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252256 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252256 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252256 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252256 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252256 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252256 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252256 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252256 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252256 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252256 , Out_Dummy15_g252256 , Out_PositionWS15_g252256 , Out_PositionWO15_g252256 , Out_PivotWS15_g252256 , Out_PivotWO15_g252256 , Out_NormalWS15_g252256 , Out_TangentWS15_g252256 , Out_BitangentWS15_g252256 , Out_TriplanarWeights15_g252256 , Out_ViewDirWS15_g252256 , Out_CoordsData15_g252256 , Out_VertexData15_g252256 , Out_Interpolator15_g252256 );
					TVEModelData Data16_g252257 =(TVEModelData)Data15_g252256;
					float In_Dummy16_g252257 = Out_Dummy15_g252256;
					float3 In_PositionWS16_g252257 = Out_PositionWS15_g252256;
					float3 In_PositionWO16_g252257 = Out_PositionWO15_g252256;
					float3 In_PivotWS16_g252257 = Out_PivotWS15_g252256;
					float3 In_PivotWO16_g252257 = Out_PivotWO15_g252256;
					float3 In_NormalWS16_g252257 = Out_NormalWS15_g252256;
					float3 In_TangentWS16_g252257 = Out_TangentWS15_g252256;
					float3 In_BitangentWS16_g252257 = Out_BitangentWS15_g252256;
					float3 In_TriplanarWeights16_g252257 = Out_TriplanarWeights15_g252256;
					float3 In_ViewDirWS16_g252257 = Out_ViewDirWS15_g252256;
					float4 In_CoordsData16_g252257 = Out_CoordsData15_g252256;
					float4 In_VertexData16_g252257 = Out_VertexData15_g252256;
					float4 vertexToFrag1901_g252254 = IN.ase_texcoord7;
					float4 In_Interpolator16_g252257 = vertexToFrag1901_g252254;
					BuildModelFragData( Data16_g252257 , In_Dummy16_g252257 , In_PositionWS16_g252257 , In_PositionWO16_g252257 , In_PivotWS16_g252257 , In_PivotWO16_g252257 , In_NormalWS16_g252257 , In_TangentWS16_g252257 , In_BitangentWS16_g252257 , In_TriplanarWeights16_g252257 , In_ViewDirWS16_g252257 , In_CoordsData16_g252257 , In_VertexData16_g252257 , In_Interpolator16_g252257 );
					TVEModelData Data15_g252259 =(TVEModelData)Data16_g252257;
					float Out_Dummy15_g252259 = 0.0;
					float3 Out_PositionWS15_g252259 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252259 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252259 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252259 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252259 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252259 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252259 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252259 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252259 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252259 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252259 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252259 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252259 , Out_Dummy15_g252259 , Out_PositionWS15_g252259 , Out_PositionWO15_g252259 , Out_PivotWS15_g252259 , Out_PivotWO15_g252259 , Out_NormalWS15_g252259 , Out_TangentWS15_g252259 , Out_BitangentWS15_g252259 , Out_TriplanarWeights15_g252259 , Out_ViewDirWS15_g252259 , Out_CoordsData15_g252259 , Out_VertexData15_g252259 , Out_Interpolator15_g252259 );
					float4 Model_CoordsData324_g252258 = Out_CoordsData15_g252259;
					float4 MeshCoords444_g252280 = Model_CoordsData324_g252258;
					float2 UV0444_g252280 = float2( 0,0 );
					float2 UV3444_g252280 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252280 , MeshCoords444_g252280 , UV0444_g252280 , UV3444_g252280 );
					float4 appendResult430_g252280 = (float4(UV0444_g252280 , UV3444_g252280));
					float4 In_MaskA431_g252280 = appendResult430_g252280;
					float localComputeWorldCoords315_g252280 = ( 0.0 );
					float4 Coords315_g252280 = Local_Coords180_g252258;
					float3 Model_PositionWO222_g252258 = Out_PositionWO15_g252259;
					float3 PositionWS315_g252280 = Model_PositionWO222_g252258;
					float2 ZY315_g252280 = float2( 0,0 );
					float2 XZ315_g252280 = float2( 0,0 );
					float2 XY315_g252280 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252280 , PositionWS315_g252280 , ZY315_g252280 , XZ315_g252280 , XY315_g252280 );
					float2 ZY402_g252280 = ZY315_g252280;
					float2 XZ403_g252280 = XZ315_g252280;
					float4 appendResult432_g252280 = (float4(ZY402_g252280 , XZ403_g252280));
					float4 In_MaskB431_g252280 = appendResult432_g252280;
					float2 XY404_g252280 = XY315_g252280;
					float localComputeStochasticCoords409_g252280 = ( 0.0 );
					float2 UV409_g252280 = ZY402_g252280;
					float2 UV1409_g252280 = float2( 0,0 );
					float2 UV2409_g252280 = float2( 0,0 );
					float2 UV3409_g252280 = float2( 0,0 );
					float3 Weights409_g252280 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252280 , UV1409_g252280 , UV2409_g252280 , UV3409_g252280 , Weights409_g252280 );
					float4 appendResult433_g252280 = (float4(XY404_g252280 , UV1409_g252280));
					float4 In_MaskC431_g252280 = appendResult433_g252280;
					float4 appendResult434_g252280 = (float4(UV2409_g252280 , UV3409_g252280));
					float4 In_MaskD431_g252280 = appendResult434_g252280;
					float localComputeStochasticCoords422_g252280 = ( 0.0 );
					float2 UV422_g252280 = XZ403_g252280;
					float2 UV1422_g252280 = float2( 0,0 );
					float2 UV2422_g252280 = float2( 0,0 );
					float2 UV3422_g252280 = float2( 0,0 );
					float3 Weights422_g252280 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252280 , UV1422_g252280 , UV2422_g252280 , UV3422_g252280 , Weights422_g252280 );
					float4 appendResult435_g252280 = (float4(UV1422_g252280 , UV2422_g252280));
					float4 In_MaskE431_g252280 = appendResult435_g252280;
					float localComputeStochasticCoords423_g252280 = ( 0.0 );
					float2 UV423_g252280 = XY404_g252280;
					float2 UV1423_g252280 = float2( 0,0 );
					float2 UV2423_g252280 = float2( 0,0 );
					float2 UV3423_g252280 = float2( 0,0 );
					float3 Weights423_g252280 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252280 , UV1423_g252280 , UV2423_g252280 , UV3423_g252280 , Weights423_g252280 );
					float4 appendResult436_g252280 = (float4(UV3422_g252280 , UV1423_g252280));
					float4 In_MaskF431_g252280 = appendResult436_g252280;
					float4 appendResult437_g252280 = (float4(UV2423_g252280 , UV3423_g252280));
					float4 In_MaskG431_g252280 = appendResult437_g252280;
					float4 In_MaskH431_g252280 = float4( Weights409_g252280 , 0.0 );
					float4 In_MaskI431_g252280 = float4( Weights422_g252280 , 0.0 );
					float4 In_MaskJ431_g252280 = float4( Weights423_g252280 , 0.0 );
					half3 Model_NormalWS226_g252258 = Out_NormalWS15_g252259;
					float3 temp_output_449_0_g252280 = Model_NormalWS226_g252258;
					float4 In_MaskK431_g252280 = float4( temp_output_449_0_g252280 , 0.0 );
					half3 Model_TangentWS366_g252258 = Out_TangentWS15_g252259;
					float3 temp_output_450_0_g252280 = Model_TangentWS366_g252258;
					float4 In_MaskL431_g252280 = float4( temp_output_450_0_g252280 , 0.0 );
					half3 Model_BitangentWS367_g252258 = Out_BitangentWS15_g252259;
					float3 temp_output_451_0_g252280 = Model_BitangentWS367_g252258;
					float4 In_MaskM431_g252280 = float4( temp_output_451_0_g252280 , 0.0 );
					half3 Model_TriplanarWeights368_g252258 = Out_TriplanarWeights15_g252259;
					float3 temp_output_445_0_g252280 = Model_TriplanarWeights368_g252258;
					float4 In_MaskN431_g252280 = float4( temp_output_445_0_g252280 , 0.0 );
					BuildTextureData( Data431_g252280 , In_MaskA431_g252280 , In_MaskB431_g252280 , In_MaskC431_g252280 , In_MaskD431_g252280 , In_MaskE431_g252280 , In_MaskF431_g252280 , In_MaskG431_g252280 , In_MaskH431_g252280 , In_MaskI431_g252280 , In_MaskJ431_g252280 , In_MaskK431_g252280 , In_MaskL431_g252280 , In_MaskM431_g252280 , In_MaskN431_g252280 );
					TVEMasksData Data456_g252281 =(TVEMasksData)Data431_g252280;
					float4 Out_MaskA456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252281 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252281 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252281 , Out_MaskA456_g252281 , Out_MaskB456_g252281 , Out_MaskC456_g252281 , Out_MaskD456_g252281 , Out_MaskE456_g252281 , Out_MaskF456_g252281 , Out_MaskG456_g252281 , Out_MaskH456_g252281 , Out_MaskI456_g252281 , Out_MaskJ456_g252281 , Out_MaskK456_g252281 , Out_MaskL456_g252281 , Out_MaskM456_g252281 , Out_MaskN456_g252281 );
					half2 UV276_g252281 = (Out_MaskA456_g252281).xy;
					float temp_output_504_0_g252281 = 0.0;
					half Bias276_g252281 = temp_output_504_0_g252281;
					half2 Normal276_g252281 = float2( 0,0 );
					half4 localSampleCoord276_g252281 = SampleCoord( Texture276_g252281 , Sampler276_g252281 , UV276_g252281 , Bias276_g252281 , Normal276_g252281 );
					float4 temp_output_407_277_g252258 = localSampleCoord276_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252281) = _MainAlbedoTex;
					SamplerState Sampler502_g252281 = staticSwitch36_g252263;
					half2 UV502_g252281 = (Out_MaskA456_g252281).zw;
					half Bias502_g252281 = temp_output_504_0_g252281;
					half2 Normal502_g252281 = float2( 0,0 );
					half4 localSampleCoord502_g252281 = SampleCoord( Texture502_g252281 , Sampler502_g252281 , UV502_g252281 , Bias502_g252281 , Normal502_g252281 );
					float4 temp_output_407_278_g252258 = localSampleCoord502_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252281) = _MainAlbedoTex;
					SamplerState Sampler496_g252281 = staticSwitch36_g252263;
					float2 temp_output_463_0_g252281 = (Out_MaskB456_g252281).zw;
					half2 XZ496_g252281 = temp_output_463_0_g252281;
					half Bias496_g252281 = temp_output_504_0_g252281;
					half3 NormalWS512_g252281 = (Out_MaskK456_g252281).xyz;
					half3 NormalWS496_g252281 = NormalWS512_g252281;
					half3 Normal496_g252281 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252281 = SamplePlanar2D( Texture496_g252281 , Sampler496_g252281 , XZ496_g252281 , Bias496_g252281 , NormalWS496_g252281 , Normal496_g252281 );
					float4 temp_output_407_0_g252258 = localSamplePlanar2D496_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252281) = _MainAlbedoTex;
					SamplerState Sampler490_g252281 = staticSwitch36_g252263;
					float2 temp_output_462_0_g252281 = (Out_MaskB456_g252281).xy;
					half2 ZY490_g252281 = temp_output_462_0_g252281;
					half2 XZ490_g252281 = temp_output_463_0_g252281;
					float2 temp_output_464_0_g252281 = (Out_MaskC456_g252281).xy;
					half2 XY490_g252281 = temp_output_464_0_g252281;
					half Bias490_g252281 = temp_output_504_0_g252281;
					half3 Triplanar522_g252281 = (Out_MaskN456_g252281).xyz;
					half3 Triplanar490_g252281 = Triplanar522_g252281;
					half3 NormalWS490_g252281 = NormalWS512_g252281;
					half3 Normal490_g252281 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252281 = SamplePlanar3D( Texture490_g252281 , Sampler490_g252281 , ZY490_g252281 , XZ490_g252281 , XY490_g252281 , Bias490_g252281 , Triplanar490_g252281 , NormalWS490_g252281 , Normal490_g252281 );
					float4 temp_output_407_201_g252258 = localSamplePlanar3D490_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252281) = _MainAlbedoTex;
					SamplerState Sampler498_g252281 = staticSwitch36_g252263;
					half2 XZ498_g252281 = temp_output_463_0_g252281;
					float2 temp_output_473_0_g252281 = (Out_MaskE456_g252281).xy;
					half2 XZ_1498_g252281 = temp_output_473_0_g252281;
					float2 temp_output_474_0_g252281 = (Out_MaskE456_g252281).zw;
					half2 XZ_2498_g252281 = temp_output_474_0_g252281;
					float2 temp_output_475_0_g252281 = (Out_MaskF456_g252281).xy;
					half2 XZ_3498_g252281 = temp_output_475_0_g252281;
					float temp_output_510_0_g252281 = exp2( temp_output_504_0_g252281 );
					half Bias498_g252281 = temp_output_510_0_g252281;
					float3 temp_output_480_0_g252281 = (Out_MaskI456_g252281).xyz;
					half3 Weights_2498_g252281 = temp_output_480_0_g252281;
					half3 NormalWS498_g252281 = NormalWS512_g252281;
					half3 Normal498_g252281 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252281 = SampleStochastic2D( Texture498_g252281 , Sampler498_g252281 , XZ498_g252281 , XZ_1498_g252281 , XZ_2498_g252281 , XZ_3498_g252281 , Bias498_g252281 , Weights_2498_g252281 , NormalWS498_g252281 , Normal498_g252281 );
					float4 temp_output_407_202_g252258 = localSampleStochastic2D498_g252281;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252281) = _MainAlbedoTex;
					SamplerState Sampler500_g252281 = staticSwitch36_g252263;
					half2 ZY500_g252281 = temp_output_462_0_g252281;
					half2 ZY_1500_g252281 = (Out_MaskC456_g252281).zw;
					half2 ZY_2500_g252281 = (Out_MaskD456_g252281).xy;
					half2 ZY_3500_g252281 = (Out_MaskD456_g252281).zw;
					half2 XZ500_g252281 = temp_output_463_0_g252281;
					half2 XZ_1500_g252281 = temp_output_473_0_g252281;
					half2 XZ_2500_g252281 = temp_output_474_0_g252281;
					half2 XZ_3500_g252281 = temp_output_475_0_g252281;
					half2 XY500_g252281 = temp_output_464_0_g252281;
					half2 XY_1500_g252281 = (Out_MaskF456_g252281).zw;
					half2 XY_2500_g252281 = (Out_MaskG456_g252281).xy;
					half2 XY_3500_g252281 = (Out_MaskG456_g252281).zw;
					half Bias500_g252281 = temp_output_510_0_g252281;
					half3 Weights_1500_g252281 = (Out_MaskH456_g252281).xyz;
					half3 Weights_2500_g252281 = temp_output_480_0_g252281;
					half3 Weights_3500_g252281 = (Out_MaskJ456_g252281).xyz;
					half3 Triplanar500_g252281 = Triplanar522_g252281;
					half3 NormalWS500_g252281 = NormalWS512_g252281;
					half3 Normal500_g252281 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252281 = SampleStochastic3D( Texture500_g252281 , Sampler500_g252281 , ZY500_g252281 , ZY_1500_g252281 , ZY_2500_g252281 , ZY_3500_g252281 , XZ500_g252281 , XZ_1500_g252281 , XZ_2500_g252281 , XZ_3500_g252281 , XY500_g252281 , XY_1500_g252281 , XY_2500_g252281 , XY_3500_g252281 , Bias500_g252281 , Weights_1500_g252281 , Weights_2500_g252281 , Weights_3500_g252281 , Triplanar500_g252281 , NormalWS500_g252281 , Normal500_g252281 );
					float4 temp_output_407_203_g252258 = localSampleStochastic3D500_g252281;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g252258 = temp_output_407_277_g252258;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g252258 = temp_output_407_278_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g252258 = temp_output_407_0_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g252258 = temp_output_407_201_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g252258 = temp_output_407_202_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g252258 = temp_output_407_203_g252258;
					#else
					float4 staticSwitch184_g252258 = temp_output_407_277_g252258;
					#endif
					half4 Local_AlbedoSample185_g252258 = staticSwitch184_g252258;
					float3 lerpResult53_g252258 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g252258).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g252258 = lerpResult53_g252258;
					float temp_output_17_0_g252278 = _MainMultiWriteMode;
					float Option91_g252278 = temp_output_17_0_g252278;
					float4 Model_VertexData418_g252258 = Out_VertexData15_g252259;
					float4 temp_output_84_0_g252278 = Model_VertexData418_g252258;
					float4 ChannelA91_g252278 = temp_output_84_0_g252278;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252266) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g252265 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g252265 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252266 = staticSwitch38_g252265;
					float localBreakTextureData456_g252266 = ( 0.0 );
					TVEMasksData Data456_g252266 =(TVEMasksData)Data431_g252280;
					float4 Out_MaskA456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252266 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252266 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252266 , Out_MaskA456_g252266 , Out_MaskB456_g252266 , Out_MaskC456_g252266 , Out_MaskD456_g252266 , Out_MaskE456_g252266 , Out_MaskF456_g252266 , Out_MaskG456_g252266 , Out_MaskH456_g252266 , Out_MaskI456_g252266 , Out_MaskJ456_g252266 , Out_MaskK456_g252266 , Out_MaskL456_g252266 , Out_MaskM456_g252266 , Out_MaskN456_g252266 );
					half2 UV276_g252266 = (Out_MaskA456_g252266).xy;
					float temp_output_504_0_g252266 = 0.0;
					half Bias276_g252266 = temp_output_504_0_g252266;
					half2 Normal276_g252266 = float2( 0,0 );
					half4 localSampleCoord276_g252266 = SampleCoord( Texture276_g252266 , Sampler276_g252266 , UV276_g252266 , Bias276_g252266 , Normal276_g252266 );
					float4 temp_output_405_277_g252258 = localSampleCoord276_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252266) = _MainShaderTex;
					SamplerState Sampler502_g252266 = staticSwitch38_g252265;
					half2 UV502_g252266 = (Out_MaskA456_g252266).zw;
					half Bias502_g252266 = temp_output_504_0_g252266;
					half2 Normal502_g252266 = float2( 0,0 );
					half4 localSampleCoord502_g252266 = SampleCoord( Texture502_g252266 , Sampler502_g252266 , UV502_g252266 , Bias502_g252266 , Normal502_g252266 );
					float4 temp_output_405_278_g252258 = localSampleCoord502_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252266) = _MainShaderTex;
					SamplerState Sampler496_g252266 = staticSwitch38_g252265;
					float2 temp_output_463_0_g252266 = (Out_MaskB456_g252266).zw;
					half2 XZ496_g252266 = temp_output_463_0_g252266;
					half Bias496_g252266 = temp_output_504_0_g252266;
					half3 NormalWS512_g252266 = (Out_MaskK456_g252266).xyz;
					half3 NormalWS496_g252266 = NormalWS512_g252266;
					half3 Normal496_g252266 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252266 = SamplePlanar2D( Texture496_g252266 , Sampler496_g252266 , XZ496_g252266 , Bias496_g252266 , NormalWS496_g252266 , Normal496_g252266 );
					float4 temp_output_405_0_g252258 = localSamplePlanar2D496_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252266) = _MainShaderTex;
					SamplerState Sampler490_g252266 = staticSwitch38_g252265;
					float2 temp_output_462_0_g252266 = (Out_MaskB456_g252266).xy;
					half2 ZY490_g252266 = temp_output_462_0_g252266;
					half2 XZ490_g252266 = temp_output_463_0_g252266;
					float2 temp_output_464_0_g252266 = (Out_MaskC456_g252266).xy;
					half2 XY490_g252266 = temp_output_464_0_g252266;
					half Bias490_g252266 = temp_output_504_0_g252266;
					half3 Triplanar522_g252266 = (Out_MaskN456_g252266).xyz;
					half3 Triplanar490_g252266 = Triplanar522_g252266;
					half3 NormalWS490_g252266 = NormalWS512_g252266;
					half3 Normal490_g252266 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252266 = SamplePlanar3D( Texture490_g252266 , Sampler490_g252266 , ZY490_g252266 , XZ490_g252266 , XY490_g252266 , Bias490_g252266 , Triplanar490_g252266 , NormalWS490_g252266 , Normal490_g252266 );
					float4 temp_output_405_201_g252258 = localSamplePlanar3D490_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252266) = _MainShaderTex;
					SamplerState Sampler498_g252266 = staticSwitch38_g252265;
					half2 XZ498_g252266 = temp_output_463_0_g252266;
					float2 temp_output_473_0_g252266 = (Out_MaskE456_g252266).xy;
					half2 XZ_1498_g252266 = temp_output_473_0_g252266;
					float2 temp_output_474_0_g252266 = (Out_MaskE456_g252266).zw;
					half2 XZ_2498_g252266 = temp_output_474_0_g252266;
					float2 temp_output_475_0_g252266 = (Out_MaskF456_g252266).xy;
					half2 XZ_3498_g252266 = temp_output_475_0_g252266;
					float temp_output_510_0_g252266 = exp2( temp_output_504_0_g252266 );
					half Bias498_g252266 = temp_output_510_0_g252266;
					float3 temp_output_480_0_g252266 = (Out_MaskI456_g252266).xyz;
					half3 Weights_2498_g252266 = temp_output_480_0_g252266;
					half3 NormalWS498_g252266 = NormalWS512_g252266;
					half3 Normal498_g252266 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252266 = SampleStochastic2D( Texture498_g252266 , Sampler498_g252266 , XZ498_g252266 , XZ_1498_g252266 , XZ_2498_g252266 , XZ_3498_g252266 , Bias498_g252266 , Weights_2498_g252266 , NormalWS498_g252266 , Normal498_g252266 );
					float4 temp_output_405_202_g252258 = localSampleStochastic2D498_g252266;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252266) = _MainShaderTex;
					SamplerState Sampler500_g252266 = staticSwitch38_g252265;
					half2 ZY500_g252266 = temp_output_462_0_g252266;
					half2 ZY_1500_g252266 = (Out_MaskC456_g252266).zw;
					half2 ZY_2500_g252266 = (Out_MaskD456_g252266).xy;
					half2 ZY_3500_g252266 = (Out_MaskD456_g252266).zw;
					half2 XZ500_g252266 = temp_output_463_0_g252266;
					half2 XZ_1500_g252266 = temp_output_473_0_g252266;
					half2 XZ_2500_g252266 = temp_output_474_0_g252266;
					half2 XZ_3500_g252266 = temp_output_475_0_g252266;
					half2 XY500_g252266 = temp_output_464_0_g252266;
					half2 XY_1500_g252266 = (Out_MaskF456_g252266).zw;
					half2 XY_2500_g252266 = (Out_MaskG456_g252266).xy;
					half2 XY_3500_g252266 = (Out_MaskG456_g252266).zw;
					half Bias500_g252266 = temp_output_510_0_g252266;
					half3 Weights_1500_g252266 = (Out_MaskH456_g252266).xyz;
					half3 Weights_2500_g252266 = temp_output_480_0_g252266;
					half3 Weights_3500_g252266 = (Out_MaskJ456_g252266).xyz;
					half3 Triplanar500_g252266 = Triplanar522_g252266;
					half3 NormalWS500_g252266 = NormalWS512_g252266;
					half3 Normal500_g252266 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252266 = SampleStochastic3D( Texture500_g252266 , Sampler500_g252266 , ZY500_g252266 , ZY_1500_g252266 , ZY_2500_g252266 , ZY_3500_g252266 , XZ500_g252266 , XZ_1500_g252266 , XZ_2500_g252266 , XZ_3500_g252266 , XY500_g252266 , XY_1500_g252266 , XY_2500_g252266 , XY_3500_g252266 , Bias500_g252266 , Weights_1500_g252266 , Weights_2500_g252266 , Weights_3500_g252266 , Triplanar500_g252266 , NormalWS500_g252266 , Normal500_g252266 );
					float4 temp_output_405_203_g252258 = localSampleStochastic3D500_g252266;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g252258 = temp_output_405_277_g252258;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g252258 = temp_output_405_278_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g252258 = temp_output_405_0_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g252258 = temp_output_405_201_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g252258 = temp_output_405_202_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g252258 = temp_output_405_203_g252258;
					#else
					float4 staticSwitch198_g252258 = temp_output_405_277_g252258;
					#endif
					half4 Local_ShaderSample199_g252258 = staticSwitch198_g252258;
					float2 appendResult428_g252258 = (float2((Local_AlbedoSample185_g252258).w , (Local_ShaderSample199_g252258).z));
					float2 temp_output_85_0_g252278 = appendResult428_g252258;
					float4 ChannelB91_g252278 = float4( temp_output_85_0_g252278, 0.0 , 0.0 );
					float localSwitchChannel691_g252278 = SwitchChannel6( Option91_g252278 , ChannelA91_g252278 , ChannelB91_g252278 );
					float clampResult17_g252276 = clamp( localSwitchChannel691_g252278 , 0.0001 , 0.9999 );
					float temp_output_7_0_g252277 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g252277 = ( clampResult17_g252276 - temp_output_7_0_g252277 );
					half Local_MultiMask78_g252258 = saturate( ( temp_output_9_0_g252277 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g252258 = lerp( 1.0 , Local_MultiMask78_g252258 , _MainColorMode);
					float4 lerpResult62_g252258 = lerp( _MainColorTwo , _MainColor , lerpResult58_g252258);
					half3 Local_ColorRGB93_g252258 = (lerpResult62_g252258).rgb;
					half3 Local_Albedo139_g252258 = ( Local_AlbedoRGB107_g252258 * Local_ColorRGB93_g252258 );
					float3 temp_output_4_0_g252260 = Local_Albedo139_g252258;
					float3 In_Albedo3_g252260 = temp_output_4_0_g252260;
					float3 temp_output_44_0_g252260 = Local_Albedo139_g252258;
					float3 In_AlbedoBase3_g252260 = temp_output_44_0_g252260;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252287) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g252264 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g252264 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252287 = staticSwitch37_g252264;
					float localBreakTextureData456_g252287 = ( 0.0 );
					TVEMasksData Data456_g252287 =(TVEMasksData)Data431_g252280;
					float4 Out_MaskA456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252287 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252287 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252287 , Out_MaskA456_g252287 , Out_MaskB456_g252287 , Out_MaskC456_g252287 , Out_MaskD456_g252287 , Out_MaskE456_g252287 , Out_MaskF456_g252287 , Out_MaskG456_g252287 , Out_MaskH456_g252287 , Out_MaskI456_g252287 , Out_MaskJ456_g252287 , Out_MaskK456_g252287 , Out_MaskL456_g252287 , Out_MaskM456_g252287 , Out_MaskN456_g252287 );
					half2 UV276_g252287 = (Out_MaskA456_g252287).xy;
					float temp_output_504_0_g252287 = 0.0;
					half Bias276_g252287 = temp_output_504_0_g252287;
					half2 Normal276_g252287 = float2( 0,0 );
					half4 localSampleCoord276_g252287 = SampleCoord( Texture276_g252287 , Sampler276_g252287 , UV276_g252287 , Bias276_g252287 , Normal276_g252287 );
					float2 temp_output_406_394_g252258 = Normal276_g252287;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252287) = _MainNormalTex;
					SamplerState Sampler502_g252287 = staticSwitch37_g252264;
					half2 UV502_g252287 = (Out_MaskA456_g252287).zw;
					half Bias502_g252287 = temp_output_504_0_g252287;
					half2 Normal502_g252287 = float2( 0,0 );
					half4 localSampleCoord502_g252287 = SampleCoord( Texture502_g252287 , Sampler502_g252287 , UV502_g252287 , Bias502_g252287 , Normal502_g252287 );
					float2 temp_output_406_397_g252258 = Normal502_g252287;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252287) = _MainNormalTex;
					SamplerState Sampler496_g252287 = staticSwitch37_g252264;
					float2 temp_output_463_0_g252287 = (Out_MaskB456_g252287).zw;
					half2 XZ496_g252287 = temp_output_463_0_g252287;
					half Bias496_g252287 = temp_output_504_0_g252287;
					half3 NormalWS512_g252287 = (Out_MaskK456_g252287).xyz;
					half3 NormalWS496_g252287 = NormalWS512_g252287;
					half3 Normal496_g252287 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252287 = SamplePlanar2D( Texture496_g252287 , Sampler496_g252287 , XZ496_g252287 , Bias496_g252287 , NormalWS496_g252287 , Normal496_g252287 );
					float3 temp_output_35_0_g252290 = Normal496_g252287;
					half3 TangentWS519_g252287 = (Out_MaskL456_g252287).xyz;
					float dotResult84_g252290 = dot( temp_output_35_0_g252290 , TangentWS519_g252287 );
					half3 BitangentWS521_g252287 = (Out_MaskM456_g252287).xyz;
					float dotResult85_g252290 = dot( temp_output_35_0_g252290 , BitangentWS521_g252287 );
					float2 appendResult87_g252290 = (float2(dotResult84_g252290 , dotResult85_g252290));
					float2 temp_output_406_375_g252258 = appendResult87_g252290;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252287) = _MainNormalTex;
					SamplerState Sampler490_g252287 = staticSwitch37_g252264;
					float2 temp_output_462_0_g252287 = (Out_MaskB456_g252287).xy;
					half2 ZY490_g252287 = temp_output_462_0_g252287;
					half2 XZ490_g252287 = temp_output_463_0_g252287;
					float2 temp_output_464_0_g252287 = (Out_MaskC456_g252287).xy;
					half2 XY490_g252287 = temp_output_464_0_g252287;
					half Bias490_g252287 = temp_output_504_0_g252287;
					half3 Triplanar522_g252287 = (Out_MaskN456_g252287).xyz;
					half3 Triplanar490_g252287 = Triplanar522_g252287;
					half3 NormalWS490_g252287 = NormalWS512_g252287;
					half3 Normal490_g252287 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252287 = SamplePlanar3D( Texture490_g252287 , Sampler490_g252287 , ZY490_g252287 , XZ490_g252287 , XY490_g252287 , Bias490_g252287 , Triplanar490_g252287 , NormalWS490_g252287 , Normal490_g252287 );
					float3 temp_output_35_0_g252291 = Normal490_g252287;
					float dotResult84_g252291 = dot( temp_output_35_0_g252291 , TangentWS519_g252287 );
					float dotResult85_g252291 = dot( temp_output_35_0_g252291 , BitangentWS521_g252287 );
					float2 appendResult87_g252291 = (float2(dotResult84_g252291 , dotResult85_g252291));
					float2 temp_output_406_353_g252258 = appendResult87_g252291;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252287) = _MainNormalTex;
					SamplerState Sampler498_g252287 = staticSwitch37_g252264;
					half2 XZ498_g252287 = temp_output_463_0_g252287;
					float2 temp_output_473_0_g252287 = (Out_MaskE456_g252287).xy;
					half2 XZ_1498_g252287 = temp_output_473_0_g252287;
					float2 temp_output_474_0_g252287 = (Out_MaskE456_g252287).zw;
					half2 XZ_2498_g252287 = temp_output_474_0_g252287;
					float2 temp_output_475_0_g252287 = (Out_MaskF456_g252287).xy;
					half2 XZ_3498_g252287 = temp_output_475_0_g252287;
					float temp_output_510_0_g252287 = exp2( temp_output_504_0_g252287 );
					half Bias498_g252287 = temp_output_510_0_g252287;
					float3 temp_output_480_0_g252287 = (Out_MaskI456_g252287).xyz;
					half3 Weights_2498_g252287 = temp_output_480_0_g252287;
					half3 NormalWS498_g252287 = NormalWS512_g252287;
					half3 Normal498_g252287 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252287 = SampleStochastic2D( Texture498_g252287 , Sampler498_g252287 , XZ498_g252287 , XZ_1498_g252287 , XZ_2498_g252287 , XZ_3498_g252287 , Bias498_g252287 , Weights_2498_g252287 , NormalWS498_g252287 , Normal498_g252287 );
					float3 temp_output_35_0_g252292 = Normal498_g252287;
					float dotResult84_g252292 = dot( temp_output_35_0_g252292 , TangentWS519_g252287 );
					float dotResult85_g252292 = dot( temp_output_35_0_g252292 , BitangentWS521_g252287 );
					float2 appendResult87_g252292 = (float2(dotResult84_g252292 , dotResult85_g252292));
					float2 temp_output_406_391_g252258 = appendResult87_g252292;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252287) = _MainNormalTex;
					SamplerState Sampler500_g252287 = staticSwitch37_g252264;
					half2 ZY500_g252287 = temp_output_462_0_g252287;
					half2 ZY_1500_g252287 = (Out_MaskC456_g252287).zw;
					half2 ZY_2500_g252287 = (Out_MaskD456_g252287).xy;
					half2 ZY_3500_g252287 = (Out_MaskD456_g252287).zw;
					half2 XZ500_g252287 = temp_output_463_0_g252287;
					half2 XZ_1500_g252287 = temp_output_473_0_g252287;
					half2 XZ_2500_g252287 = temp_output_474_0_g252287;
					half2 XZ_3500_g252287 = temp_output_475_0_g252287;
					half2 XY500_g252287 = temp_output_464_0_g252287;
					half2 XY_1500_g252287 = (Out_MaskF456_g252287).zw;
					half2 XY_2500_g252287 = (Out_MaskG456_g252287).xy;
					half2 XY_3500_g252287 = (Out_MaskG456_g252287).zw;
					half Bias500_g252287 = temp_output_510_0_g252287;
					half3 Weights_1500_g252287 = (Out_MaskH456_g252287).xyz;
					half3 Weights_2500_g252287 = temp_output_480_0_g252287;
					half3 Weights_3500_g252287 = (Out_MaskJ456_g252287).xyz;
					half3 Triplanar500_g252287 = Triplanar522_g252287;
					half3 NormalWS500_g252287 = NormalWS512_g252287;
					half3 Normal500_g252287 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252287 = SampleStochastic3D( Texture500_g252287 , Sampler500_g252287 , ZY500_g252287 , ZY_1500_g252287 , ZY_2500_g252287 , ZY_3500_g252287 , XZ500_g252287 , XZ_1500_g252287 , XZ_2500_g252287 , XZ_3500_g252287 , XY500_g252287 , XY_1500_g252287 , XY_2500_g252287 , XY_3500_g252287 , Bias500_g252287 , Weights_1500_g252287 , Weights_2500_g252287 , Weights_3500_g252287 , Triplanar500_g252287 , NormalWS500_g252287 , Normal500_g252287 );
					float3 temp_output_35_0_g252288 = Normal500_g252287;
					float dotResult84_g252288 = dot( temp_output_35_0_g252288 , TangentWS519_g252287 );
					float dotResult85_g252288 = dot( temp_output_35_0_g252288 , BitangentWS521_g252287 );
					float2 appendResult87_g252288 = (float2(dotResult84_g252288 , dotResult85_g252288));
					float2 temp_output_406_390_g252258 = appendResult87_g252288;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g252258 = temp_output_406_394_g252258;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g252258 = temp_output_406_397_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g252258 = temp_output_406_375_g252258;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g252258 = temp_output_406_353_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g252258 = temp_output_406_391_g252258;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g252258 = temp_output_406_390_g252258;
					#else
					float2 staticSwitch193_g252258 = temp_output_406_394_g252258;
					#endif
					half2 Local_NormaSample191_g252258 = staticSwitch193_g252258;
					half2 Local_NormalTS108_g252258 = ( Local_NormaSample191_g252258 * _MainNormalValue );
					float2 In_NormalTS3_g252260 = Local_NormalTS108_g252258;
					float2 break80_g252279 = Local_NormalTS108_g252258;
					float3 temp_output_77_0_g252279 = Model_TangentWS366_g252258;
					float3 temp_output_78_0_g252279 = Model_BitangentWS367_g252258;
					float3 temp_output_76_0_g252279 = Model_NormalWS226_g252258;
					half3 Local_NormalWS250_g252258 = ( ( break80_g252279.x * temp_output_77_0_g252279 ) + ( break80_g252279.y * temp_output_78_0_g252279 ) + temp_output_76_0_g252279 );
					float3 In_NormalWS3_g252260 = Local_NormalWS250_g252258;
					float temp_output_209_0_g252258 = (Local_ShaderSample199_g252258).y;
					float temp_output_7_0_g252272 = _MainOcclusionRemap.x;
					float temp_output_9_0_g252272 = ( temp_output_209_0_g252258 - temp_output_7_0_g252272 );
					float lerpResult23_g252258 = lerp( 1.0 , saturate( ( temp_output_9_0_g252272 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g252258 = lerpResult23_g252258;
					float temp_output_213_0_g252258 = (Local_ShaderSample199_g252258).w;
					float temp_output_7_0_g252275 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g252275 = ( temp_output_213_0_g252258 - temp_output_7_0_g252275 );
					half Local_Smoothness317_g252258 = ( saturate( ( temp_output_9_0_g252275 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g252258 = (float4(( (Local_ShaderSample199_g252258).x * _MainMetallicValue ) , Local_Occlusion313_g252258 , (Local_ShaderSample199_g252258).z , Local_Smoothness317_g252258));
					half4 Local_Masks109_g252258 = appendResult73_g252258;
					float4 In_Shader3_g252260 = Local_Masks109_g252258;
					float4 In_Feature3_g252260 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252260 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252260 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g252293 = Local_Albedo139_g252258;
					float dotResult20_g252293 = dot( temp_output_3_0_g252293 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g252258 = dotResult20_g252293;
					float temp_output_12_0_g252260 = Local_Grayscale110_g252258;
					float In_Grayscale3_g252260 = temp_output_12_0_g252260;
					float temp_output_3_0_g252294 = Local_Grayscale110_g252258;
					float clampResult27_g252294 = clamp( saturate( ( temp_output_3_0_g252294 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g252258 = clampResult27_g252294;
					float temp_output_16_0_g252260 = Local_Luminosity145_g252258;
					float In_Luminosity3_g252260 = temp_output_16_0_g252260;
					float In_MultiMask3_g252260 = Local_MultiMask78_g252258;
					float temp_output_187_0_g252258 = (Local_AlbedoSample185_g252258).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g252258 = ( temp_output_187_0_g252258 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g252258 = temp_output_187_0_g252258;
					#endif
					half Local_AlphaClip111_g252258 = staticSwitch236_g252258;
					float In_AlphaClip3_g252260 = Local_AlphaClip111_g252258;
					half Local_AlphaFade246_g252258 = (lerpResult62_g252258).a;
					float In_AlphaFade3_g252260 = Local_AlphaFade246_g252258;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g252260 = temp_cast_24;
					float In_Transmission3_g252260 = 1.0;
					float In_Thickness3_g252260 = 0.0;
					float In_Diffusion3_g252260 = 0.0;
					float In_Depth3_g252260 = 0.0;
					BuildVisualData( Data3_g252260 , In_Dummy3_g252260 , In_Albedo3_g252260 , In_AlbedoBase3_g252260 , In_NormalTS3_g252260 , In_NormalWS3_g252260 , In_Shader3_g252260 , In_Feature3_g252260 , In_Season3_g252260 , In_Emissive3_g252260 , In_Grayscale3_g252260 , In_Luminosity3_g252260 , In_MultiMask3_g252260 , In_AlphaClip3_g252260 , In_AlphaFade3_g252260 , In_Translucency3_g252260 , In_Transmission3_g252260 , In_Thickness3_g252260 , In_Diffusion3_g252260 , In_Depth3_g252260 );
					TVEVisualData Data4_g252496 =(TVEVisualData)Data3_g252260;
					float Out_Dummy4_g252496 = 0.0;
					float3 Out_Albedo4_g252496 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252496 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252496 = float2( 0,0 );
					float3 Out_NormalWS4_g252496 = float3( 0,0,0 );
					float4 Out_Shader4_g252496 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252496 = float4( 0,0,0,0 );
					float4 Out_Season4_g252496 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252496 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252496 = 0.0;
					float Out_Grayscale4_g252496 = 0.0;
					float Out_Luminosity4_g252496 = 0.0;
					float Out_AlphaClip4_g252496 = 0.0;
					float Out_AlphaFade4_g252496 = 0.0;
					float3 Out_Translucency4_g252496 = float3( 0,0,0 );
					float Out_Transmission4_g252496 = 0.0;
					float Out_Thickness4_g252496 = 0.0;
					float Out_Diffusion4_g252496 = 0.0;
					float Out_Depth4_g252496 = 0.0;
					BreakVisualData( Data4_g252496 , Out_Dummy4_g252496 , Out_Albedo4_g252496 , Out_AlbedoBase4_g252496 , Out_NormalTS4_g252496 , Out_NormalWS4_g252496 , Out_Shader4_g252496 , Out_Feature4_g252496 , Out_Season4_g252496 , Out_Emissive4_g252496 , Out_MultiMask4_g252496 , Out_Grayscale4_g252496 , Out_Luminosity4_g252496 , Out_AlphaClip4_g252496 , Out_AlphaFade4_g252496 , Out_Translucency4_g252496 , Out_Transmission4_g252496 , Out_Thickness4_g252496 , Out_Diffusion4_g252496 , Out_Depth4_g252496 );
					float temp_output_200_11_g252472 = Out_MultiMask4_g252496;
					half Visual_MultiMask181_g252472 = temp_output_200_11_g252472;
					float lerpResult147_g252472 = lerp( 1.0 , Visual_MultiMask181_g252472 , _TintingMultiValue);
					half Blend_MutiMask121_g252472 = lerpResult147_g252472;
					float temp_output_200_15_g252472 = Out_Luminosity4_g252496;
					half Visual_Luminosity257_g252472 = temp_output_200_15_g252472;
					float temp_output_7_0_g252481 = _TintingLumaRemap.x;
					float temp_output_9_0_g252481 = ( Visual_Luminosity257_g252472 - temp_output_7_0_g252481 );
					float lerpResult228_g252472 = lerp( 1.0 , saturate( ( temp_output_9_0_g252481 * _TintingLumaRemap.z ) ) , _TintingLumaValue);
					half Blend_LumaMask153_g252472 = lerpResult228_g252472;
					half Blend_NoiseMask213_g252472 = 1.0;
					half Blend_UserMask345_g252472 = 1.0;
					float temp_output_17_0_g252493 = _TintingMeshMode;
					float Option70_g252493 = temp_output_17_0_g252493;
					TVEModelData Data15_g252497 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g252497 = 0.0;
					float3 Out_PositionWS15_g252497 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252497 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252497 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252497 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252497 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252497 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252497 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252497 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252497 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252497 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252497 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252497 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252497 , Out_Dummy15_g252497 , Out_PositionWS15_g252497 , Out_PositionWO15_g252497 , Out_PivotWS15_g252497 , Out_PivotWO15_g252497 , Out_NormalWS15_g252497 , Out_TangentWS15_g252497 , Out_BitangentWS15_g252497 , Out_TriplanarWeights15_g252497 , Out_ViewDirWS15_g252497 , Out_CoordsData15_g252497 , Out_VertexData15_g252497 , Out_Interpolator15_g252497 );
					half4 Model_VertexData307_g252472 = Out_VertexData15_g252497;
					float4 temp_output_3_0_g252493 = Model_VertexData307_g252472;
					float4 Channel70_g252493 = temp_output_3_0_g252493;
					float localSwitchChannel470_g252493 = SwitchChannel4( Option70_g252493 , Channel70_g252493 );
					float temp_output_521_0_g252472 = localSwitchChannel470_g252493;
					float temp_output_7_0_g252482 = _TintingMeshRemap.x;
					float temp_output_9_0_g252482 = ( temp_output_521_0_g252472 - temp_output_7_0_g252482 );
					float lerpResult370_g252472 = lerp( 1.0 , saturate( ( temp_output_9_0_g252482 * _TintingMeshRemap.z ) ) , _TintingMeshValue);
					half Blend_VertMask309_g252472 = lerpResult370_g252472;
					float temp_output_64_0_g252510 = ( Blend_TexMask385_g252472 * Blend_MutiMask121_g252472 * Blend_LumaMask153_g252472 * Blend_NoiseMask213_g252472 * Blend_UserMask345_g252472 * Blend_VertMask309_g252472 );
					float4 temp_output_533_109_g252472 = TVE_PaintParams;
					float localBuildGlobalData204_g251779 = ( 0.0 );
					TVEGlobalData Data204_g251779 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251779 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251779 = Dummy211_g251779;
					float4 temp_output_203_0_g251798 = TVE_CoatBaseCoord;
					TVEModelData Data15_g251869 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g251869 = 0.0;
					float3 Out_PositionWS15_g251869 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251869 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251869 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251869 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251869 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251869 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251869 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251869 , Out_Dummy15_g251869 , Out_PositionWS15_g251869 , Out_PositionWO15_g251869 , Out_PivotWS15_g251869 , Out_PivotWO15_g251869 , Out_NormalWS15_g251869 , Out_TangentWS15_g251869 , Out_BitangentWS15_g251869 , Out_TriplanarWeights15_g251869 , Out_ViewDirWS15_g251869 , Out_CoordsData15_g251869 , Out_VertexData15_g251869 , Out_Interpolator15_g251869 );
					float3 Model_PositionWS497_g251779 = Out_PositionWS15_g251869;
					float2 Model_PositionWS_XZ143_g251779 = (Model_PositionWS497_g251779).xz;
					float3 Model_PivotWS498_g251779 = Out_PivotWS15_g251869;
					float2 Model_PivotWS_XZ145_g251779 = (Model_PivotWS498_g251779).xz;
					float2 lerpResult300_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251798 = lerpResult300_g251779;
					float temp_output_82_0_g251796 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251798 = temp_output_82_0_g251796;
					float4 tex2DArrayNode83_g251798 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251798).zw + ( (temp_output_203_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798) );
					float4 appendResult210_g251798 = (float4(tex2DArrayNode83_g251798.rgb , tex2DArrayNode83_g251798.a));
					float4 temp_output_204_0_g251798 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251798 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251798).zw + ( (temp_output_204_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798) );
					float4 appendResult212_g251798 = (float4(tex2DArrayNode122_g251798.rgb , tex2DArrayNode122_g251798.a));
					float4 TVE_RenderNearPositionR628_g251779 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251779 = saturate( ( distance( Model_PositionWS497_g251779 , (TVE_RenderNearPositionR628_g251779).xyz ) / (TVE_RenderNearPositionR628_g251779).w ) );
					float temp_output_7_0_g251868 = 1.0;
					float temp_output_9_0_g251868 = ( temp_output_507_0_g251779 - temp_output_7_0_g251868 );
					half TVE_RenderNearFadeValue635_g251779 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251779 = saturate( ( temp_output_9_0_g251868 / ( ( TVE_RenderNearFadeValue635_g251779 - temp_output_7_0_g251868 ) + 0.0001 ) ) );
					float4 lerpResult131_g251798 = lerp( appendResult210_g251798 , appendResult212_g251798 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251796 = lerpResult131_g251798;
					float4 lerpResult168_g251796 = lerp( TVE_CoatParams , temp_output_159_109_g251796 , TVE_CoatLayers[(int)temp_output_82_0_g251796]);
					float4 temp_output_589_109_g251779 = lerpResult168_g251796;
					half4 Coat_Texture302_g251779 = temp_output_589_109_g251779;
					float4 In_CoatTexture204_g251779 = Coat_Texture302_g251779;
					half4 Draw_Texture656_g251779 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251779 = Draw_Texture656_g251779;
					float4 temp_output_203_0_g251823 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251823 = lerpResult85_g251779;
					float temp_output_82_0_g251820 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251823 = temp_output_82_0_g251820;
					float4 tex2DArrayNode83_g251823 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251823).zw + ( (temp_output_203_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823) );
					float4 appendResult210_g251823 = (float4(tex2DArrayNode83_g251823.rgb , tex2DArrayNode83_g251823.a));
					float4 temp_output_204_0_g251823 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251823 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251823).zw + ( (temp_output_204_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823) );
					float4 appendResult212_g251823 = (float4(tex2DArrayNode122_g251823.rgb , tex2DArrayNode122_g251823.a));
					float4 lerpResult131_g251823 = lerp( appendResult210_g251823 , appendResult212_g251823 , Global_TexBlend509_g251779);
					float4 temp_output_171_109_g251820 = lerpResult131_g251823;
					float4 lerpResult174_g251820 = lerp( TVE_PaintParams , temp_output_171_109_g251820 , TVE_PaintLayers[(int)temp_output_82_0_g251820]);
					float4 temp_output_595_109_g251779 = lerpResult174_g251820;
					half4 Paint_Texture71_g251779 = temp_output_595_109_g251779;
					float4 In_PaintTexture204_g251779 = Paint_Texture71_g251779;
					float4 temp_output_203_0_g251806 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251806 = lerpResult104_g251779;
					float temp_output_132_0_g251804 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251806 = temp_output_132_0_g251804;
					float4 tex2DArrayNode83_g251806 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251806).zw + ( (temp_output_203_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806) );
					float4 appendResult210_g251806 = (float4(tex2DArrayNode83_g251806.rgb , tex2DArrayNode83_g251806.a));
					float4 temp_output_204_0_g251806 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251806 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251806).zw + ( (temp_output_204_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806) );
					float4 appendResult212_g251806 = (float4(tex2DArrayNode122_g251806.rgb , tex2DArrayNode122_g251806.a));
					float4 lerpResult131_g251806 = lerp( appendResult210_g251806 , appendResult212_g251806 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251804 = lerpResult131_g251806;
					float4 lerpResult145_g251804 = lerp( TVE_AtmoParams , temp_output_137_109_g251804 , TVE_AtmoLayers[(int)temp_output_132_0_g251804]);
					float4 temp_output_590_110_g251779 = lerpResult145_g251804;
					half4 Atmo_Texture80_g251779 = temp_output_590_110_g251779;
					float4 In_AtmoTexture204_g251779 = Atmo_Texture80_g251779;
					float4 temp_output_203_0_g251874 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251874 = lerpResult414_g251779;
					float temp_output_132_0_g251872 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251874 = temp_output_132_0_g251872;
					float4 tex2DArrayNode83_g251874 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251874).zw + ( (temp_output_203_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874) );
					float4 appendResult210_g251874 = (float4(tex2DArrayNode83_g251874.rgb , tex2DArrayNode83_g251874.a));
					float4 temp_output_204_0_g251874 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251874 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251874).zw + ( (temp_output_204_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874) );
					float4 appendResult212_g251874 = (float4(tex2DArrayNode122_g251874.rgb , tex2DArrayNode122_g251874.a));
					float4 lerpResult131_g251874 = lerp( appendResult210_g251874 , appendResult212_g251874 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251872 = lerpResult131_g251874;
					float4 lerpResult145_g251872 = lerp( TVE_EffexParams , temp_output_137_109_g251872 , TVE_EffexLayers[(int)temp_output_132_0_g251872]);
					float4 temp_output_731_110_g251779 = lerpResult145_g251872;
					half4 Effex_Texture420_g251779 = temp_output_731_110_g251779;
					float4 In_EffexTexture204_g251779 = Effex_Texture420_g251779;
					float4 temp_output_203_0_g251854 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251854 = lerpResult247_g251779;
					float temp_output_82_0_g251852 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251854 = temp_output_82_0_g251852;
					float4 tex2DArrayNode83_g251854 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251854).zw + ( (temp_output_203_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854) );
					float4 appendResult210_g251854 = (float4(tex2DArrayNode83_g251854.rgb , tex2DArrayNode83_g251854.a));
					float4 temp_output_204_0_g251854 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251854 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251854).zw + ( (temp_output_204_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854) );
					float4 appendResult212_g251854 = (float4(tex2DArrayNode122_g251854.rgb , tex2DArrayNode122_g251854.a));
					float4 lerpResult131_g251854 = lerp( appendResult210_g251854 , appendResult212_g251854 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251852 = lerpResult131_g251854;
					float4 lerpResult167_g251852 = lerp( TVE_GlowParams , temp_output_159_109_g251852 , TVE_GlowLayers[(int)temp_output_82_0_g251852]);
					float4 temp_output_593_109_g251779 = lerpResult167_g251852;
					half4 Glow_Texture248_g251779 = temp_output_593_109_g251779;
					float4 In_GlowTexture204_g251779 = Glow_Texture248_g251779;
					float4 temp_output_203_0_g251790 = TVE_FormBaseCoord;
					float2 lerpResult168_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251790 = lerpResult168_g251779;
					float temp_output_130_0_g251788 = _GlobalFormLayerValue;
					float temp_output_82_0_g251790 = temp_output_130_0_g251788;
					float4 tex2DArrayNode83_g251790 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251790).zw + ( (temp_output_203_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790) );
					float4 appendResult210_g251790 = (float4(tex2DArrayNode83_g251790.rgb , tex2DArrayNode83_g251790.a));
					float4 temp_output_204_0_g251790 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251790 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251790).zw + ( (temp_output_204_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790) );
					float4 appendResult212_g251790 = (float4(tex2DArrayNode122_g251790.rgb , tex2DArrayNode122_g251790.a));
					float4 lerpResult131_g251790 = lerp( appendResult210_g251790 , appendResult212_g251790 , Global_TexBlend509_g251779);
					float4 temp_output_135_109_g251788 = lerpResult131_g251790;
					float4 lerpResult143_g251788 = lerp( TVE_FormParams , temp_output_135_109_g251788 , TVE_FormLayers[(int)temp_output_130_0_g251788]);
					float4 temp_output_592_0_g251779 = lerpResult143_g251788;
					float4 Form_Texture112_g251779 = temp_output_592_0_g251779;
					float4 In_FormTexture204_g251779 = Form_Texture112_g251779;
					float4 In_LandTexture204_g251779 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251838 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251838 = lerpResult681_g251779;
					float temp_output_136_0_g251836 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251838 = temp_output_136_0_g251836;
					float4 tex2DArrayNode83_g251838 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251838).zw + ( (temp_output_203_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838) );
					float4 appendResult210_g251838 = (float4(tex2DArrayNode83_g251838.rgb , tex2DArrayNode83_g251838.a));
					float4 temp_output_204_0_g251838 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251838 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251838).zw + ( (temp_output_204_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838) );
					float4 appendResult212_g251838 = (float4(tex2DArrayNode122_g251838.rgb , tex2DArrayNode122_g251838.a));
					float4 lerpResult131_g251838 = lerp( appendResult210_g251838 , appendResult212_g251838 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251836 = lerpResult131_g251838;
					float4 lerpResult149_g251836 = lerp( TVE_VertxParams , temp_output_141_109_g251836 , TVE_VertxLayers[(int)temp_output_136_0_g251836]);
					float4 temp_output_695_0_g251779 = lerpResult149_g251836;
					half4 Vertx_Texture693_g251779 = temp_output_695_0_g251779;
					float4 In_VertxTexture204_g251779 = Vertx_Texture693_g251779;
					float4 temp_output_203_0_g251814 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251814 = lerpResult400_g251779;
					float temp_output_136_0_g251812 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251814 = temp_output_136_0_g251812;
					float4 tex2DArrayNode83_g251814 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251814).zw + ( (temp_output_203_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814) );
					float4 appendResult210_g251814 = (float4(tex2DArrayNode83_g251814.rgb , tex2DArrayNode83_g251814.a));
					float4 temp_output_204_0_g251814 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251814 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251814).zw + ( (temp_output_204_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814) );
					float4 appendResult212_g251814 = (float4(tex2DArrayNode122_g251814.rgb , tex2DArrayNode122_g251814.a));
					float4 lerpResult131_g251814 = lerp( appendResult210_g251814 , appendResult212_g251814 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251812 = lerpResult131_g251814;
					float4 lerpResult149_g251812 = lerp( TVE_FlowParams , temp_output_141_109_g251812 , TVE_FlowLayers[(int)temp_output_136_0_g251812]);
					float4 temp_output_594_0_g251779 = lerpResult149_g251812;
					half4 Flow_Texture405_g251779 = temp_output_594_0_g251779;
					float4 In_FlowTexture204_g251779 = Flow_Texture405_g251779;
					half4 User_Texture677_g251779 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251779 = User_Texture677_g251779;
					BuildGlobalData( Data204_g251779 , In_Dummy204_g251779 , In_CoatTexture204_g251779 , In_DrawTexture204_g251779 , In_PaintTexture204_g251779 , In_AtmoTexture204_g251779 , In_EffexTexture204_g251779 , In_GlowTexture204_g251779 , In_FormTexture204_g251779 , In_LandTexture204_g251779 , In_VertxTexture204_g251779 , In_FlowTexture204_g251779 , In_UserTexture204_g251779 );
					TVEGlobalData Data15_g252495 =(TVEGlobalData)Data204_g251779;
					float Out_Dummy15_g252495 = 0.0;
					float4 Out_CoatTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252495 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252495 = float4( 0,0,0,0 );
					BreakData( Data15_g252495 , Out_Dummy15_g252495 , Out_CoatTexture15_g252495 , Out_DrawTexture15_g252495 , Out_PaintTexture15_g252495 , Out_AtmoTexture15_g252495 , Out_EffexTexture15_g252495 , Out_GlowTexture15_g252495 , Out_FormTexture15_g252495 , Out_LandTexture15_g252495 , Out_VertxTexture15_g252495 , Out_FlowTexture15_g252495 , Out_UserTexture15_g252495 );
					half4 Global_PaintTexture209_g252472 = Out_PaintTexture15_g252495;
					float4 temp_output_6_0_g252484 = Global_PaintTexture209_g252472;
					float temp_output_7_0_g252484 = _TintingPaintMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252484 = ( temp_output_6_0_g252484 + temp_output_7_0_g252484 );
					#else
					float4 staticSwitch14_g252484 = temp_output_6_0_g252484;
					#endif
					float4 temp_output_332_0_g252472 = staticSwitch14_g252484;
					#ifdef TVE_TINTING_PAINT
					float4 staticSwitch283_g252472 = temp_output_332_0_g252472;
					#else
					float4 staticSwitch283_g252472 = temp_output_533_109_g252472;
					#endif
					float lerpResult464_g252472 = lerp( 1.0 , (staticSwitch283_g252472).w , _TintingPaintValue);
					half Blend_GlobalValue285_g252472 = lerpResult464_g252472;
					float temp_output_92_0_g252510 = ( Feature_Intensity508_g252472 * Blend_GlobalValue285_g252472 );
					half Multiply93_g252510 = ( temp_output_64_0_g252510 * temp_output_92_0_g252510 );
					half Subtract93_g252510 = saturate( ( temp_output_92_0_g252510 - ( 1.0 - temp_output_64_0_g252510 ) ) );
					half Option93_g252510 = _TintingBlendMath;
					half localSwitchBlendMask93_g252510 = SwitchBlendMask( Multiply93_g252510 , Subtract93_g252510 , Option93_g252510 );
					float temp_output_7_0_g252511 = _TintingBlendRemap.x;
					float temp_output_9_0_g252511 = ( localSwitchBlendMask93_g252510 - temp_output_7_0_g252511 );
					half Blend_Mask242_g252472 = ( saturate( ( temp_output_9_0_g252511 * _TintingBlendRemap.z ) ) * TVE_IsEnabled );
					float4 appendResult513_g252472 = (float4(Blend_Mask242_g252472 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_33 = (0.0).xxxx;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 ifLocalVar18_g252513 = 0;
					if( Feature_Intensity508_g252472 <= 0.0 )
					ifLocalVar18_g252513 = temp_cast_34;
					else
					ifLocalVar18_g252513 = appendResult513_g252472;
					float4 In_MaskB3_g252499 = ifLocalVar18_g252513;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskC3_g252499 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskD3_g252499 = temp_cast_36;
					float4 temp_cast_37 = (0.0).xxxx;
					float4 In_MaskE3_g252499 = temp_cast_37;
					float4 temp_cast_38 = (0.0).xxxx;
					float4 In_MaskF3_g252499 = temp_cast_38;
					float4 temp_cast_39 = (0.0).xxxx;
					float4 In_MaskG3_g252499 = temp_cast_39;
					float4 temp_cast_40 = (0.0).xxxx;
					float4 In_MaskH3_g252499 = temp_cast_40;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 In_MaskI3_g252499 = temp_cast_41;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskJ3_g252499 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskK3_g252499 = temp_cast_43;
					float4 temp_cast_44 = (0.0).xxxx;
					float4 In_MaskL3_g252499 = temp_cast_44;
					{
					Data3_g252499.MaskA = In_MaskA3_g252499;
					Data3_g252499.MaskB = In_MaskB3_g252499;
					Data3_g252499.MaskC = In_MaskC3_g252499;
					Data3_g252499.MaskD = In_MaskD3_g252499;
					Data3_g252499.MaskE = In_MaskE3_g252499;
					Data3_g252499.MaskF = In_MaskF3_g252499;
					Data3_g252499.MaskG = In_MaskG3_g252499;
					Data3_g252499.MaskH = In_MaskH3_g252499;
					Data3_g252499.MaskI = In_MaskI3_g252499;
					Data3_g252499.MaskJ= In_MaskJ3_g252499;
					Data3_g252499.MaskK= In_MaskK3_g252499;
					Data3_g252499.MaskL = In_MaskL3_g252499;
					}
					TVEMasksData DataA25_g252556 = Data3_g252499;
					float localBuildMasksData3_g252541 = ( 0.0 );
					TVEMasksData Data3_g252541 = (TVEMasksData)0;
					half Feature_Intensity508_g252514 = _TintingIntensityValue;
					float ifLocalVar18_g252542 = 0;
					if( Feature_Intensity508_g252514 <= 0.0 )
					ifLocalVar18_g252542 = 0.0;
					else
					ifLocalVar18_g252542 = 1.0;
					half Feature_Element505_g252514 = _TintingPaintMode;
					float ifLocalVar18_g252543 = 0;
					if( Feature_Element505_g252514 <= 0.0 )
					ifLocalVar18_g252543 = 0.0;
					else
					ifLocalVar18_g252543 = 1.0;
					float4 appendResult517_g252514 = (float4(ifLocalVar18_g252542 , 0.0 , 0.0 , ifLocalVar18_g252543));
					float4 In_MaskA3_g252541 = appendResult517_g252514;
					half Blend_TexMask385_g252514 = 1.0;
					float localBreakVisualData4_g252538 = ( 0.0 );
					TVEVisualData Data4_g252538 =(TVEVisualData)Data3_g252260;
					float Out_Dummy4_g252538 = 0.0;
					float3 Out_Albedo4_g252538 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252538 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252538 = float2( 0,0 );
					float3 Out_NormalWS4_g252538 = float3( 0,0,0 );
					float4 Out_Shader4_g252538 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252538 = float4( 0,0,0,0 );
					float4 Out_Season4_g252538 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252538 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252538 = 0.0;
					float Out_Grayscale4_g252538 = 0.0;
					float Out_Luminosity4_g252538 = 0.0;
					float Out_AlphaClip4_g252538 = 0.0;
					float Out_AlphaFade4_g252538 = 0.0;
					float3 Out_Translucency4_g252538 = float3( 0,0,0 );
					float Out_Transmission4_g252538 = 0.0;
					float Out_Thickness4_g252538 = 0.0;
					float Out_Diffusion4_g252538 = 0.0;
					float Out_Depth4_g252538 = 0.0;
					BreakVisualData( Data4_g252538 , Out_Dummy4_g252538 , Out_Albedo4_g252538 , Out_AlbedoBase4_g252538 , Out_NormalTS4_g252538 , Out_NormalWS4_g252538 , Out_Shader4_g252538 , Out_Feature4_g252538 , Out_Season4_g252538 , Out_Emissive4_g252538 , Out_MultiMask4_g252538 , Out_Grayscale4_g252538 , Out_Luminosity4_g252538 , Out_AlphaClip4_g252538 , Out_AlphaFade4_g252538 , Out_Translucency4_g252538 , Out_Transmission4_g252538 , Out_Thickness4_g252538 , Out_Diffusion4_g252538 , Out_Depth4_g252538 );
					float temp_output_200_11_g252514 = Out_MultiMask4_g252538;
					half Visual_MultiMask181_g252514 = temp_output_200_11_g252514;
					float lerpResult147_g252514 = lerp( 1.0 , Visual_MultiMask181_g252514 , _TintingMultiValue);
					half Blend_MutiMask121_g252514 = lerpResult147_g252514;
					float temp_output_200_15_g252514 = Out_Luminosity4_g252538;
					half Visual_Luminosity257_g252514 = temp_output_200_15_g252514;
					float temp_output_7_0_g252523 = _TintingLumaRemap.x;
					float temp_output_9_0_g252523 = ( Visual_Luminosity257_g252514 - temp_output_7_0_g252523 );
					float lerpResult228_g252514 = lerp( 1.0 , saturate( ( temp_output_9_0_g252523 * _TintingLumaRemap.z ) ) , _TintingLumaValue);
					half Blend_LumaMask153_g252514 = lerpResult228_g252514;
					half Blend_NoiseMask213_g252514 = 1.0;
					half Blend_UserMask345_g252514 = 1.0;
					float temp_output_17_0_g252535 = _TintingMeshMode;
					float Option70_g252535 = temp_output_17_0_g252535;
					TVEModelData Data15_g252539 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g252539 = 0.0;
					float3 Out_PositionWS15_g252539 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252539 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252539 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252539 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252539 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252539 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252539 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252539 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252539 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252539 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252539 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252539 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252539 , Out_Dummy15_g252539 , Out_PositionWS15_g252539 , Out_PositionWO15_g252539 , Out_PivotWS15_g252539 , Out_PivotWO15_g252539 , Out_NormalWS15_g252539 , Out_TangentWS15_g252539 , Out_BitangentWS15_g252539 , Out_TriplanarWeights15_g252539 , Out_ViewDirWS15_g252539 , Out_CoordsData15_g252539 , Out_VertexData15_g252539 , Out_Interpolator15_g252539 );
					half4 Model_VertexData307_g252514 = Out_VertexData15_g252539;
					float4 temp_output_3_0_g252535 = Model_VertexData307_g252514;
					float4 Channel70_g252535 = temp_output_3_0_g252535;
					float localSwitchChannel470_g252535 = SwitchChannel4( Option70_g252535 , Channel70_g252535 );
					float temp_output_521_0_g252514 = localSwitchChannel470_g252535;
					float temp_output_7_0_g252524 = _TintingMeshRemap.x;
					float temp_output_9_0_g252524 = ( temp_output_521_0_g252514 - temp_output_7_0_g252524 );
					float lerpResult370_g252514 = lerp( 1.0 , saturate( ( temp_output_9_0_g252524 * _TintingMeshRemap.z ) ) , _TintingMeshValue);
					half Blend_VertMask309_g252514 = lerpResult370_g252514;
					float temp_output_64_0_g252552 = ( Blend_TexMask385_g252514 * Blend_MutiMask121_g252514 * Blend_LumaMask153_g252514 * Blend_NoiseMask213_g252514 * Blend_UserMask345_g252514 * Blend_VertMask309_g252514 );
					half Blend_GlobalValue285_g252514 = 1.0;
					float temp_output_92_0_g252552 = ( Feature_Intensity508_g252514 * Blend_GlobalValue285_g252514 );
					half Multiply93_g252552 = ( temp_output_64_0_g252552 * temp_output_92_0_g252552 );
					half Subtract93_g252552 = saturate( ( temp_output_92_0_g252552 - ( 1.0 - temp_output_64_0_g252552 ) ) );
					half Option93_g252552 = _TintingBlendMath;
					half localSwitchBlendMask93_g252552 = SwitchBlendMask( Multiply93_g252552 , Subtract93_g252552 , Option93_g252552 );
					float temp_output_7_0_g252553 = _TintingBlendRemap.x;
					float temp_output_9_0_g252553 = ( localSwitchBlendMask93_g252552 - temp_output_7_0_g252553 );
					half Blend_Mask242_g252514 = ( saturate( ( temp_output_9_0_g252553 * _TintingBlendRemap.z ) ) * TVE_IsEnabled );
					float4 appendResult513_g252514 = (float4(Blend_Mask242_g252514 , 0.0 , 0.0 , 0.0));
					float4 temp_cast_45 = (0.0).xxxx;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 ifLocalVar18_g252555 = 0;
					if( Feature_Intensity508_g252514 <= 0.0 )
					ifLocalVar18_g252555 = temp_cast_46;
					else
					ifLocalVar18_g252555 = appendResult513_g252514;
					float4 In_MaskB3_g252541 = ifLocalVar18_g252555;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskC3_g252541 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskD3_g252541 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskE3_g252541 = temp_cast_49;
					float4 temp_cast_50 = (0.0).xxxx;
					float4 In_MaskF3_g252541 = temp_cast_50;
					float4 temp_cast_51 = (0.0).xxxx;
					float4 In_MaskG3_g252541 = temp_cast_51;
					float4 temp_cast_52 = (0.0).xxxx;
					float4 In_MaskH3_g252541 = temp_cast_52;
					float4 temp_cast_53 = (0.0).xxxx;
					float4 In_MaskI3_g252541 = temp_cast_53;
					float4 temp_cast_54 = (0.0).xxxx;
					float4 In_MaskJ3_g252541 = temp_cast_54;
					float4 temp_cast_55 = (0.0).xxxx;
					float4 In_MaskK3_g252541 = temp_cast_55;
					float4 temp_cast_56 = (0.0).xxxx;
					float4 In_MaskL3_g252541 = temp_cast_56;
					{
					Data3_g252541.MaskA = In_MaskA3_g252541;
					Data3_g252541.MaskB = In_MaskB3_g252541;
					Data3_g252541.MaskC = In_MaskC3_g252541;
					Data3_g252541.MaskD = In_MaskD3_g252541;
					Data3_g252541.MaskE = In_MaskE3_g252541;
					Data3_g252541.MaskF = In_MaskF3_g252541;
					Data3_g252541.MaskG = In_MaskG3_g252541;
					Data3_g252541.MaskH = In_MaskH3_g252541;
					Data3_g252541.MaskI = In_MaskI3_g252541;
					Data3_g252541.MaskJ= In_MaskJ3_g252541;
					Data3_g252541.MaskK= In_MaskK3_g252541;
					Data3_g252541.MaskL = In_MaskL3_g252541;
					}
					TVEMasksData DataB25_g252556 = Data3_g252541;
					float Alpha25_g252556 = TVE_DEBUG_Global;
					{
					if (Alpha25_g252556 < 0.5 )
					{
					Data25_g252556 = DataA25_g252556;
					}
					else
					{
					Data25_g252556 = DataB25_g252556;
					}
					}
					TVEMasksData Data4_g252557 = Data25_g252556;
					float4 Out_MaskA4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g252557 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g252557 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g252557 = Data4_g252557.MaskA;
					Out_MaskB4_g252557 = Data4_g252557.MaskB;
					Out_MaskC4_g252557 = Data4_g252557.MaskC;
					Out_MaskD4_g252557 = Data4_g252557.MaskD;
					Out_MaskE4_g252557 = Data4_g252557.MaskE;
					Out_MaskF4_g252557 = Data4_g252557.MaskF;
					Out_MaskG4_g252557 = Data4_g252557.MaskG;
					Out_MaskH4_g252557 = Data4_g252557.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g252557;
					float3 lerpResult2568 = lerp( color107_g252558 , color106_g252558 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g252562 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g252562 = lerpResult2568;
					float3 ifLocalVar40_g252563 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g252563 = (Out_MaskB4_g252557).xxx;
					float3 color107_g252560 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g252560 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g252560 , color106_g252560 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g252564 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g252564 = lerpResult2607;
					half IsTerranShader2496 = _IsTerrainShader;
					float3 lerpResult2660 = lerp( ( ifLocalVar40_g252562 + ifLocalVar40_g252563 + ifLocalVar40_g252564 ) , float3( 0,0,0 ) , IsTerranShader2496);
					half3 Final_Debug2399 = lerpResult2660;
					float temp_output_7_0_g252573 = TVE_DEBUG_Min;
					float3 temp_cast_57 = (temp_output_7_0_g252573).xxx;
					float3 temp_output_9_0_g252573 = ( Final_Debug2399 - temp_cast_57 );
					float lerpResult76_g252566 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g252566 = lerpResult76_g252566;
					float3 lerpResult72_g252566 = lerp( (lerpResult73_g252567).rgb , saturate( ( temp_output_9_0_g252573 / ( ( TVE_DEBUG_Max - temp_output_7_0_g252573 ) + 0.0001 ) ) ) , Filter152_g252566);
					float dotResult61_g252566 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g252566 = ( 1.0 - saturate( dotResult61_g252566 ) );
					float Shading_Fresnel59_g252566 = (( 1.0 - ( temp_output_65_0_g252566 * temp_output_65_0_g252566 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g252566 = IN.ase_texcoord8;
					float depthLinearEye57_g252566 = LinearEyeDepth( ase_positionCS57_g252566.z / ase_positionCS57_g252566.w );
					float temp_output_69_0_g252566 = saturate(  (0.0 + ( depthLinearEye57_g252566 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g252566 = (( temp_output_69_0_g252566 * temp_output_69_0_g252566 )*0.5 + 0.5);
					float lerpResult84_g252566 = lerp( 1.0 , Shading_Fresnel59_g252566 , ( Shading_Distance58_g252566 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g252571 = ( 0.0 );
					TVEVisualData Data4_g252571 =(TVEVisualData)Data3_g252260;
					float Out_Dummy4_g252571 = 0.0;
					float3 Out_Albedo4_g252571 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252571 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252571 = float2( 0,0 );
					float3 Out_NormalWS4_g252571 = float3( 0,0,0 );
					float4 Out_Shader4_g252571 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252571 = float4( 0,0,0,0 );
					float4 Out_Season4_g252571 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252571 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252571 = 0.0;
					float Out_Grayscale4_g252571 = 0.0;
					float Out_Luminosity4_g252571 = 0.0;
					float Out_AlphaClip4_g252571 = 0.0;
					float Out_AlphaFade4_g252571 = 0.0;
					float3 Out_Translucency4_g252571 = float3( 0,0,0 );
					float Out_Transmission4_g252571 = 0.0;
					float Out_Thickness4_g252571 = 0.0;
					float Out_Diffusion4_g252571 = 0.0;
					float Out_Depth4_g252571 = 0.0;
					BreakVisualData( Data4_g252571 , Out_Dummy4_g252571 , Out_Albedo4_g252571 , Out_AlbedoBase4_g252571 , Out_NormalTS4_g252571 , Out_NormalWS4_g252571 , Out_Shader4_g252571 , Out_Feature4_g252571 , Out_Season4_g252571 , Out_Emissive4_g252571 , Out_MultiMask4_g252571 , Out_Grayscale4_g252571 , Out_Luminosity4_g252571 , Out_AlphaClip4_g252571 , Out_AlphaFade4_g252571 , Out_Translucency4_g252571 , Out_Transmission4_g252571 , Out_Thickness4_g252571 , Out_Diffusion4_g252571 , Out_Depth4_g252571 );
					float Alpha109_g252566 = Out_AlphaClip4_g252571;
					float lerpResult91_g252566 = lerp( 1.0 , Alpha109_g252566 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g252566 = lerp( 1.0 , lerpResult91_g252566 , Filter152_g252566);
					clip( lerpResult154_g252566 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2672_114;
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

					o.Emission = ( lerpResult72_g252566 * lerpResult84_g252566 );
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

					TVEVertexData Data16_g252031 =(TVEVertexData)0;
					float In_Dummy16_g252031 = 0.0;
					TVEVertexData Data16_g252026 =(TVEVertexData)0;
					float In_Dummy16_g252026 = 0.0;
					TVEModelData Data16_g251777 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#endif
					half Dummy207_g251759 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251759 );
					float temp_output_14_0_g251777 = Dummy207_g251759;
					float In_Dummy16_g251777 = temp_output_14_0_g251777;
					float3 PositionOS131_g251759 = v.vertex.xyz;
					float3 temp_output_4_0_g251777 = PositionOS131_g251759;
					float3 In_PositionOS16_g251777 = temp_output_4_0_g251777;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251759 = ase_positionWS;
					float3 vertexToFrag73_g251759 = temp_output_104_7_g251759;
					float3 PositionWS122_g251759 = vertexToFrag73_g251759;
					float3 In_PositionWS16_g251777 = PositionWS122_g251759;
					float4x4 break19_g251762 = unity_ObjectToWorld;
					float3 appendResult20_g251762 = (float3(break19_g251762[ 0 ][ 3 ] , break19_g251762[ 1 ][ 3 ] , break19_g251762[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251759 = appendResult20_g251762;
					float4x4 break19_g251764 = unity_ObjectToWorld;
					float3 appendResult20_g251764 = (float3(break19_g251764[ 0 ][ 3 ] , break19_g251764[ 1 ][ 3 ] , break19_g251764[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251760 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251759 = PositionOS131_g251759;
					float3 appendResult234_g251759 = (float3(break233_g251759.x , 0.0 , break233_g251759.z));
					float3 break413_g251759 = PositionOS131_g251759;
					float3 appendResult414_g251759 = (float3(break413_g251759.x , break413_g251759.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251766 = appendResult414_g251759;
					#else
					float3 staticSwitch65_g251766 = appendResult234_g251759;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251759 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251759 = appendResult60_g251760;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251759 = staticSwitch65_g251766;
					#else
					float3 staticSwitch229_g251759 = _Vector0;
					#endif
					float3 PivotOS149_g251759 = staticSwitch229_g251759;
					float3 temp_output_122_0_g251764 = PivotOS149_g251759;
					float3 PivotsOnlyWS105_g251764 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251764 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251759 = ( appendResult20_g251764 + PivotsOnlyWS105_g251764 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#else
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#endif
					float3 vertexToFrag76_g251759 = staticSwitch236_g251759;
					float3 PivotWS121_g251759 = vertexToFrag76_g251759;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251759 = ( PositionWS122_g251759 - PivotWS121_g251759 );
					#else
					float3 staticSwitch204_g251759 = PositionWS122_g251759;
					#endif
					float3 PositionWO132_g251759 = ( staticSwitch204_g251759 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251777 = PositionWO132_g251759;
					float3 In_PivotOS16_g251777 = PivotOS149_g251759;
					float3 In_PivotWS16_g251777 = PivotWS121_g251759;
					float3 PivotWO133_g251759 = ( PivotWS121_g251759 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251777 = PivotWO133_g251759;
					half3 NormalOS134_g251759 = v.normal;
					float3 temp_output_21_0_g251777 = NormalOS134_g251759;
					float3 In_NormalOS16_g251777 = temp_output_21_0_g251777;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251759 = normalizedWorldNormal;
					float3 In_NormalWS16_g251777 = NormalWS95_g251759;
					half4 TangentlOS153_g251759 = v.tangent;
					float4 temp_output_6_0_g251777 = TangentlOS153_g251759;
					float4 In_TangentOS16_g251777 = temp_output_6_0_g251777;
					float3 normalizeResult296_g251759 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251759 ) );
					half3 ViewDirWS169_g251759 = normalizeResult296_g251759;
					float3 In_ViewDirWS16_g251777 = ViewDirWS169_g251759;
					float4 appendResult397_g251759 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251759 = appendResult397_g251759;
					float4 In_CoordsData16_g251777 = CoordsData398_g251759;
					half4 VertexMasks171_g251759 = v.ase_color;
					float4 In_VertexData16_g251777 = VertexMasks171_g251759;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251771 = (PositionOS131_g251759).z;
					#else
					float staticSwitch65_g251771 = (PositionOS131_g251759).y;
					#endif
					half Object_HeightValue267_g251759 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251759 = saturate( ( staticSwitch65_g251771 / Object_HeightValue267_g251759 ) );
					half3 Position387_g251759 = PositionOS131_g251759;
					half Height387_g251759 = Object_HeightValue267_g251759;
					half Object_RadiusValue268_g251759 = _ObjectRadiusValue;
					half Radius387_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskYUp387_g251759 = CapsuleMaskYUp( Position387_g251759 , Height387_g251759 , Radius387_g251759 );
					half3 Position408_g251759 = PositionOS131_g251759;
					half Height408_g251759 = Object_HeightValue267_g251759;
					half Radius408_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskZUp408_g251759 = CapsuleMaskZUp( Position408_g251759 , Height408_g251759 , Radius408_g251759 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251776 = saturate( localCapsuleMaskZUp408_g251759 );
					#else
					float staticSwitch65_g251776 = saturate( localCapsuleMaskYUp387_g251759 );
					#endif
					half Bounds_SphereMask282_g251759 = staticSwitch65_g251776;
					float4 appendResult253_g251759 = (float4(Bounds_HeightMask274_g251759 , Bounds_SphereMask282_g251759 , 1.0 , 1.0));
					half4 MasksData254_g251759 = appendResult253_g251759;
					float4 In_MasksData16_g251777 = MasksData254_g251759;
					float temp_output_17_0_g251770 = _ObjectPhaseMode;
					float Option70_g251770 = temp_output_17_0_g251770;
					float4 temp_output_3_0_g251770 = v.ase_color;
					float4 Channel70_g251770 = temp_output_3_0_g251770;
					float localSwitchChannel470_g251770 = SwitchChannel4( Option70_g251770 , Channel70_g251770 );
					half Phase_Value372_g251759 = localSwitchChannel470_g251770;
					float3 break319_g251759 = PivotWO133_g251759;
					half Pivot_Position322_g251759 = ( break319_g251759.x + break319_g251759.z );
					half Phase_Position357_g251759 = ( Phase_Value372_g251759 + Pivot_Position322_g251759 );
					float temp_output_248_0_g251759 = frac( Phase_Position357_g251759 );
					float4 appendResult177_g251759 = (float4((frac( ( Phase_Position357_g251759 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251759));
					half4 Phase_Data176_g251759 = appendResult177_g251759;
					float4 In_PhaseData16_g251777 = Phase_Data176_g251759;
					BuildModelVertData( Data16_g251777 , In_Dummy16_g251777 , In_PositionOS16_g251777 , In_PositionWS16_g251777 , In_PositionWO16_g251777 , In_PivotOS16_g251777 , In_PivotWS16_g251777 , In_PivotWO16_g251777 , In_NormalOS16_g251777 , In_NormalWS16_g251777 , In_TangentOS16_g251777 , In_ViewDirWS16_g251777 , In_CoordsData16_g251777 , In_VertexData16_g251777 , In_MasksData16_g251777 , In_PhaseData16_g251777 );
					TVEModelData Data15_g252027 =(TVEModelData)Data16_g251777;
					float Out_Dummy15_g252027 = 0.0;
					float3 Out_PositionOS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252027 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252027 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252027 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252027 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252027 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252027 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252027 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252027 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252027 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252027 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252027 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252027 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252027 , Out_Dummy15_g252027 , Out_PositionOS15_g252027 , Out_PositionWS15_g252027 , Out_PositionWO15_g252027 , Out_PositionRawOS15_g252027 , Out_PivotOS15_g252027 , Out_PivotWS15_g252027 , Out_PivotWO15_g252027 , Out_NormalOS15_g252027 , Out_NormalWS15_g252027 , Out_NormalRawOS15_g252027 , Out_TangentOS15_g252027 , Out_TangentWS15_g252027 , Out_BitangentWS15_g252027 , Out_ViewDirWS15_g252027 , Out_CoordsData15_g252027 , Out_VertexData15_g252027 , Out_MasksData15_g252027 , Out_PhaseData15_g252027 , Out_TransformData15_g252027 , Out_RotationData15_g252027 , Out_Interpolator15_g252027 );
					float3 In_PositionOS16_g252026 = Out_PositionOS15_g252027;
					float3 In_NormalOS16_g252026 = Out_NormalOS15_g252027;
					float4 In_TangentOS16_g252026 = Out_TangentOS15_g252027;
					float4 In_TransformData16_g252026 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252026 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252026 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252026 , In_Dummy16_g252026 , In_PositionOS16_g252026 , In_NormalOS16_g252026 , In_TangentOS16_g252026 , In_TransformData16_g252026 , In_RotationData16_g252026 , In_Interpolator16_g252026 );
					TVEVertexData Data15_g252029 =(TVEVertexData)Data16_g252026;
					float Out_Dummy15_g252029 = 0.0;
					float3 Out_PositionOS15_g252029 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252029 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252029 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252029 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252029 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252029 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252029 , Out_Dummy15_g252029 , Out_PositionOS15_g252029 , Out_NormalOS15_g252029 , Out_TangentOS15_g252029 , Out_TransformData15_g252029 , Out_RotationData15_g252029 , Out_Interpolator15_g252029 );
					TVEModelData Data15_g252030 =(TVEModelData)Data15_g252027;
					float Out_Dummy15_g252030 = 0.0;
					float3 Out_PositionOS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252030 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252030 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252030 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252030 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252030 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252030 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252030 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252030 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252030 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252030 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252030 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252030 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252030 , Out_Dummy15_g252030 , Out_PositionOS15_g252030 , Out_PositionWS15_g252030 , Out_PositionWO15_g252030 , Out_PositionRawOS15_g252030 , Out_PivotOS15_g252030 , Out_PivotWS15_g252030 , Out_PivotWO15_g252030 , Out_NormalOS15_g252030 , Out_NormalWS15_g252030 , Out_NormalRawOS15_g252030 , Out_TangentOS15_g252030 , Out_TangentWS15_g252030 , Out_BitangentWS15_g252030 , Out_ViewDirWS15_g252030 , Out_CoordsData15_g252030 , Out_VertexData15_g252030 , Out_MasksData15_g252030 , Out_PhaseData15_g252030 , Out_TransformData15_g252030 , Out_RotationData15_g252030 , Out_Interpolator15_g252030 );
					float3 In_PositionOS16_g252031 = ( Out_PositionOS15_g252029 - Out_PivotOS15_g252030 );
					float3 In_NormalOS16_g252031 = Out_NormalOS15_g252030;
					float4 In_TangentOS16_g252031 = Out_TangentOS15_g252030;
					float4 In_TransformData16_g252031 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252031 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252031 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252031 , In_Dummy16_g252031 , In_PositionOS16_g252031 , In_NormalOS16_g252031 , In_TangentOS16_g252031 , In_TransformData16_g252031 , In_RotationData16_g252031 , In_Interpolator16_g252031 );
					TVEVertexData Data15_g252040 =(TVEVertexData)Data16_g252031;
					float Out_Dummy15_g252040 = 0.0;
					float3 Out_PositionOS15_g252040 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252040 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252040 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252040 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252040 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252040 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252040 , Out_Dummy15_g252040 , Out_PositionOS15_g252040 , Out_NormalOS15_g252040 , Out_TangentOS15_g252040 , Out_TransformData15_g252040 , Out_RotationData15_g252040 , Out_Interpolator15_g252040 );
					TVEVertexData Data16_g252041 =(TVEVertexData)Data15_g252040;
					half Dummy317_g252032 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g252041 = Dummy317_g252032;
					float3 In_PositionOS16_g252041 = Out_PositionOS15_g252040;
					float3 In_NormalOS16_g252041 = Out_NormalOS15_g252040;
					float4 In_TangentOS16_g252041 = Out_TangentOS15_g252040;
					half4 Model_TransformData356_g252032 = Out_TransformData15_g252040;
					float localBuildGlobalData204_g251779 = ( 0.0 );
					TVEGlobalData Data204_g251779 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251779 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251779 = Dummy211_g251779;
					float4 temp_output_203_0_g251798 = TVE_CoatBaseCoord;
					TVEModelData Data16_g251767 =(TVEModelData)0;
					float In_Dummy16_g251767 = 0.0;
					float3 In_PositionWS16_g251767 = PositionWS122_g251759;
					float3 In_PositionWO16_g251767 = PositionWO132_g251759;
					float3 In_PivotWS16_g251767 = PivotWS121_g251759;
					float3 In_PivotWO16_g251767 = PivotWO133_g251759;
					float3 In_NormalWS16_g251767 = NormalWS95_g251759;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251759 = ase_tangentWS;
					float3 In_TangentWS16_g251767 = TangentWS136_g251759;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251759 = ase_bitangentWS;
					float3 In_BitangentWS16_g251767 = BiangentWS421_g251759;
					half3 NormalWS427_g251759 = NormalWS95_g251759;
					half3 localComputeTriplanarMasks427_g251759 = ComputeTriplanarMasks( NormalWS427_g251759 );
					half3 TriplanarWeights429_g251759 = localComputeTriplanarMasks427_g251759;
					float3 In_TriplanarWeights16_g251767 = TriplanarWeights429_g251759;
					float3 In_ViewDirWS16_g251767 = ViewDirWS169_g251759;
					float4 In_CoordsData16_g251767 = CoordsData398_g251759;
					float4 In_VertexData16_g251767 = VertexMasks171_g251759;
					float4 In_Interpolator16_g251767 = Phase_Data176_g251759;
					BuildModelFragData( Data16_g251767 , In_Dummy16_g251767 , In_PositionWS16_g251767 , In_PositionWO16_g251767 , In_PivotWS16_g251767 , In_PivotWO16_g251767 , In_NormalWS16_g251767 , In_TangentWS16_g251767 , In_BitangentWS16_g251767 , In_TriplanarWeights16_g251767 , In_ViewDirWS16_g251767 , In_CoordsData16_g251767 , In_VertexData16_g251767 , In_Interpolator16_g251767 );
					TVEModelData Data15_g251869 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g251869 = 0.0;
					float3 Out_PositionWS15_g251869 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251869 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251869 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251869 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251869 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251869 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251869 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251869 , Out_Dummy15_g251869 , Out_PositionWS15_g251869 , Out_PositionWO15_g251869 , Out_PivotWS15_g251869 , Out_PivotWO15_g251869 , Out_NormalWS15_g251869 , Out_TangentWS15_g251869 , Out_BitangentWS15_g251869 , Out_TriplanarWeights15_g251869 , Out_ViewDirWS15_g251869 , Out_CoordsData15_g251869 , Out_VertexData15_g251869 , Out_Interpolator15_g251869 );
					float3 Model_PositionWS497_g251779 = Out_PositionWS15_g251869;
					float2 Model_PositionWS_XZ143_g251779 = (Model_PositionWS497_g251779).xz;
					float3 Model_PivotWS498_g251779 = Out_PivotWS15_g251869;
					float2 Model_PivotWS_XZ145_g251779 = (Model_PivotWS498_g251779).xz;
					float2 lerpResult300_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251798 = lerpResult300_g251779;
					float temp_output_82_0_g251796 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251798 = temp_output_82_0_g251796;
					float4 tex2DArrayNode83_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251798).zw + ( (temp_output_203_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult210_g251798 = (float4(tex2DArrayNode83_g251798.rgb , tex2DArrayNode83_g251798.a));
					float4 temp_output_204_0_g251798 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251798).zw + ( (temp_output_204_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult212_g251798 = (float4(tex2DArrayNode122_g251798.rgb , tex2DArrayNode122_g251798.a));
					float4 TVE_RenderNearPositionR628_g251779 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251779 = saturate( ( distance( Model_PositionWS497_g251779 , (TVE_RenderNearPositionR628_g251779).xyz ) / (TVE_RenderNearPositionR628_g251779).w ) );
					float temp_output_7_0_g251868 = 1.0;
					float temp_output_9_0_g251868 = ( temp_output_507_0_g251779 - temp_output_7_0_g251868 );
					half TVE_RenderNearFadeValue635_g251779 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251779 = saturate( ( temp_output_9_0_g251868 / ( ( TVE_RenderNearFadeValue635_g251779 - temp_output_7_0_g251868 ) + 0.0001 ) ) );
					float4 lerpResult131_g251798 = lerp( appendResult210_g251798 , appendResult212_g251798 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251796 = lerpResult131_g251798;
					float4 lerpResult168_g251796 = lerp( TVE_CoatParams , temp_output_159_109_g251796 , TVE_CoatLayers[(int)temp_output_82_0_g251796]);
					float4 temp_output_589_109_g251779 = lerpResult168_g251796;
					half4 Coat_Texture302_g251779 = temp_output_589_109_g251779;
					float4 In_CoatTexture204_g251779 = Coat_Texture302_g251779;
					half4 Draw_Texture656_g251779 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251779 = Draw_Texture656_g251779;
					float4 temp_output_203_0_g251823 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251823 = lerpResult85_g251779;
					float temp_output_82_0_g251820 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251823 = temp_output_82_0_g251820;
					float4 tex2DArrayNode83_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251823).zw + ( (temp_output_203_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult210_g251823 = (float4(tex2DArrayNode83_g251823.rgb , tex2DArrayNode83_g251823.a));
					float4 temp_output_204_0_g251823 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251823).zw + ( (temp_output_204_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult212_g251823 = (float4(tex2DArrayNode122_g251823.rgb , tex2DArrayNode122_g251823.a));
					float4 lerpResult131_g251823 = lerp( appendResult210_g251823 , appendResult212_g251823 , Global_TexBlend509_g251779);
					float4 temp_output_171_109_g251820 = lerpResult131_g251823;
					float4 lerpResult174_g251820 = lerp( TVE_PaintParams , temp_output_171_109_g251820 , TVE_PaintLayers[(int)temp_output_82_0_g251820]);
					float4 temp_output_595_109_g251779 = lerpResult174_g251820;
					half4 Paint_Texture71_g251779 = temp_output_595_109_g251779;
					float4 In_PaintTexture204_g251779 = Paint_Texture71_g251779;
					float4 temp_output_203_0_g251806 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251806 = lerpResult104_g251779;
					float temp_output_132_0_g251804 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251806 = temp_output_132_0_g251804;
					float4 tex2DArrayNode83_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251806).zw + ( (temp_output_203_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult210_g251806 = (float4(tex2DArrayNode83_g251806.rgb , tex2DArrayNode83_g251806.a));
					float4 temp_output_204_0_g251806 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251806).zw + ( (temp_output_204_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult212_g251806 = (float4(tex2DArrayNode122_g251806.rgb , tex2DArrayNode122_g251806.a));
					float4 lerpResult131_g251806 = lerp( appendResult210_g251806 , appendResult212_g251806 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251804 = lerpResult131_g251806;
					float4 lerpResult145_g251804 = lerp( TVE_AtmoParams , temp_output_137_109_g251804 , TVE_AtmoLayers[(int)temp_output_132_0_g251804]);
					float4 temp_output_590_110_g251779 = lerpResult145_g251804;
					half4 Atmo_Texture80_g251779 = temp_output_590_110_g251779;
					float4 In_AtmoTexture204_g251779 = Atmo_Texture80_g251779;
					float4 temp_output_203_0_g251874 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251874 = lerpResult414_g251779;
					float temp_output_132_0_g251872 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251874 = temp_output_132_0_g251872;
					float4 tex2DArrayNode83_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251874).zw + ( (temp_output_203_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult210_g251874 = (float4(tex2DArrayNode83_g251874.rgb , tex2DArrayNode83_g251874.a));
					float4 temp_output_204_0_g251874 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251874).zw + ( (temp_output_204_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult212_g251874 = (float4(tex2DArrayNode122_g251874.rgb , tex2DArrayNode122_g251874.a));
					float4 lerpResult131_g251874 = lerp( appendResult210_g251874 , appendResult212_g251874 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251872 = lerpResult131_g251874;
					float4 lerpResult145_g251872 = lerp( TVE_EffexParams , temp_output_137_109_g251872 , TVE_EffexLayers[(int)temp_output_132_0_g251872]);
					float4 temp_output_731_110_g251779 = lerpResult145_g251872;
					half4 Effex_Texture420_g251779 = temp_output_731_110_g251779;
					float4 In_EffexTexture204_g251779 = Effex_Texture420_g251779;
					float4 temp_output_203_0_g251854 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251854 = lerpResult247_g251779;
					float temp_output_82_0_g251852 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251854 = temp_output_82_0_g251852;
					float4 tex2DArrayNode83_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251854).zw + ( (temp_output_203_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult210_g251854 = (float4(tex2DArrayNode83_g251854.rgb , tex2DArrayNode83_g251854.a));
					float4 temp_output_204_0_g251854 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251854).zw + ( (temp_output_204_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult212_g251854 = (float4(tex2DArrayNode122_g251854.rgb , tex2DArrayNode122_g251854.a));
					float4 lerpResult131_g251854 = lerp( appendResult210_g251854 , appendResult212_g251854 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251852 = lerpResult131_g251854;
					float4 lerpResult167_g251852 = lerp( TVE_GlowParams , temp_output_159_109_g251852 , TVE_GlowLayers[(int)temp_output_82_0_g251852]);
					float4 temp_output_593_109_g251779 = lerpResult167_g251852;
					half4 Glow_Texture248_g251779 = temp_output_593_109_g251779;
					float4 In_GlowTexture204_g251779 = Glow_Texture248_g251779;
					float4 temp_output_203_0_g251790 = TVE_FormBaseCoord;
					float2 lerpResult168_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251790 = lerpResult168_g251779;
					float temp_output_130_0_g251788 = _GlobalFormLayerValue;
					float temp_output_82_0_g251790 = temp_output_130_0_g251788;
					float4 tex2DArrayNode83_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251790).zw + ( (temp_output_203_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult210_g251790 = (float4(tex2DArrayNode83_g251790.rgb , tex2DArrayNode83_g251790.a));
					float4 temp_output_204_0_g251790 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251790).zw + ( (temp_output_204_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult212_g251790 = (float4(tex2DArrayNode122_g251790.rgb , tex2DArrayNode122_g251790.a));
					float4 lerpResult131_g251790 = lerp( appendResult210_g251790 , appendResult212_g251790 , Global_TexBlend509_g251779);
					float4 temp_output_135_109_g251788 = lerpResult131_g251790;
					float4 lerpResult143_g251788 = lerp( TVE_FormParams , temp_output_135_109_g251788 , TVE_FormLayers[(int)temp_output_130_0_g251788]);
					float4 temp_output_592_0_g251779 = lerpResult143_g251788;
					float4 Form_Texture112_g251779 = temp_output_592_0_g251779;
					float4 In_FormTexture204_g251779 = Form_Texture112_g251779;
					float4 In_LandTexture204_g251779 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251838 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251838 = lerpResult681_g251779;
					float temp_output_136_0_g251836 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251838 = temp_output_136_0_g251836;
					float4 tex2DArrayNode83_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251838).zw + ( (temp_output_203_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult210_g251838 = (float4(tex2DArrayNode83_g251838.rgb , tex2DArrayNode83_g251838.a));
					float4 temp_output_204_0_g251838 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251838).zw + ( (temp_output_204_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult212_g251838 = (float4(tex2DArrayNode122_g251838.rgb , tex2DArrayNode122_g251838.a));
					float4 lerpResult131_g251838 = lerp( appendResult210_g251838 , appendResult212_g251838 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251836 = lerpResult131_g251838;
					float4 lerpResult149_g251836 = lerp( TVE_VertxParams , temp_output_141_109_g251836 , TVE_VertxLayers[(int)temp_output_136_0_g251836]);
					float4 temp_output_695_0_g251779 = lerpResult149_g251836;
					half4 Vertx_Texture693_g251779 = temp_output_695_0_g251779;
					float4 In_VertxTexture204_g251779 = Vertx_Texture693_g251779;
					float4 temp_output_203_0_g251814 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251814 = lerpResult400_g251779;
					float temp_output_136_0_g251812 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251814 = temp_output_136_0_g251812;
					float4 tex2DArrayNode83_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251814).zw + ( (temp_output_203_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult210_g251814 = (float4(tex2DArrayNode83_g251814.rgb , tex2DArrayNode83_g251814.a));
					float4 temp_output_204_0_g251814 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251814).zw + ( (temp_output_204_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult212_g251814 = (float4(tex2DArrayNode122_g251814.rgb , tex2DArrayNode122_g251814.a));
					float4 lerpResult131_g251814 = lerp( appendResult210_g251814 , appendResult212_g251814 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251812 = lerpResult131_g251814;
					float4 lerpResult149_g251812 = lerp( TVE_FlowParams , temp_output_141_109_g251812 , TVE_FlowLayers[(int)temp_output_136_0_g251812]);
					float4 temp_output_594_0_g251779 = lerpResult149_g251812;
					half4 Flow_Texture405_g251779 = temp_output_594_0_g251779;
					float4 In_FlowTexture204_g251779 = Flow_Texture405_g251779;
					half4 User_Texture677_g251779 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251779 = User_Texture677_g251779;
					BuildGlobalData( Data204_g251779 , In_Dummy204_g251779 , In_CoatTexture204_g251779 , In_DrawTexture204_g251779 , In_PaintTexture204_g251779 , In_AtmoTexture204_g251779 , In_EffexTexture204_g251779 , In_GlowTexture204_g251779 , In_FormTexture204_g251779 , In_LandTexture204_g251779 , In_VertxTexture204_g251779 , In_FlowTexture204_g251779 , In_UserTexture204_g251779 );
					TVEGlobalData Data15_g252042 =(TVEGlobalData)Data204_g251779;
					float Out_Dummy15_g252042 = 0.0;
					float4 Out_CoatTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252042 = float4( 0,0,0,0 );
					BreakData( Data15_g252042 , Out_Dummy15_g252042 , Out_CoatTexture15_g252042 , Out_DrawTexture15_g252042 , Out_PaintTexture15_g252042 , Out_AtmoTexture15_g252042 , Out_EffexTexture15_g252042 , Out_GlowTexture15_g252042 , Out_FormTexture15_g252042 , Out_LandTexture15_g252042 , Out_VertxTexture15_g252042 , Out_FlowTexture15_g252042 , Out_UserTexture15_g252042 );
					float4 Global_FormTexture351_g252032 = Out_FormTexture15_g252042;
					TVEModelData Data15_g252039 =(TVEModelData)Data15_g252030;
					float Out_Dummy15_g252039 = 0.0;
					float3 Out_PositionOS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252039 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252039 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252039 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252039 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252039 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252039 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252039 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252039 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252039 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252039 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252039 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252039 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252039 , Out_Dummy15_g252039 , Out_PositionOS15_g252039 , Out_PositionWS15_g252039 , Out_PositionWO15_g252039 , Out_PositionRawOS15_g252039 , Out_PivotOS15_g252039 , Out_PivotWS15_g252039 , Out_PivotWO15_g252039 , Out_NormalOS15_g252039 , Out_NormalWS15_g252039 , Out_NormalRawOS15_g252039 , Out_TangentOS15_g252039 , Out_TangentWS15_g252039 , Out_BitangentWS15_g252039 , Out_ViewDirWS15_g252039 , Out_CoordsData15_g252039 , Out_VertexData15_g252039 , Out_MasksData15_g252039 , Out_PhaseData15_g252039 , Out_TransformData15_g252039 , Out_RotationData15_g252039 , Out_Interpolator15_g252039 );
					float3 Model_PivotWO353_g252032 = Out_PivotWO15_g252039;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g252038 = _ConformMeshMode;
					float Option70_g252038 = temp_output_17_0_g252038;
					half4 Model_VertexData357_g252032 = Out_VertexData15_g252039;
					float4 temp_output_3_0_g252038 = Model_VertexData357_g252032;
					float4 Channel70_g252038 = temp_output_3_0_g252038;
					float localSwitchChannel470_g252038 = SwitchChannel4( Option70_g252038 , Channel70_g252038 );
					float temp_output_390_0_g252032 = localSwitchChannel470_g252038;
					float temp_output_7_0_g252035 = _ConformMeshRemap.x;
					float temp_output_9_0_g252035 = ( temp_output_390_0_g252032 - temp_output_7_0_g252035 );
					float lerpResult374_g252032 = lerp( 1.0 , saturate( ( temp_output_9_0_g252035 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g252032 = lerpResult374_g252032;
					float temp_output_328_0_g252032 = ( Blend_VertMask379_g252032 * TVE_IsEnabled );
					half Conform_Mask366_g252032 = temp_output_328_0_g252032;
					float temp_output_322_0_g252032 = ( ( ( ( (Global_FormTexture351_g252032).z - ( (Model_PivotWO353_g252032).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g252032 ) );
					float3 appendResult329_g252032 = (float3(0.0 , temp_output_322_0_g252032 , 0.0));
					float3 appendResult387_g252032 = (float3(0.0 , 0.0 , temp_output_322_0_g252032));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252036 = appendResult387_g252032;
					#else
					float3 staticSwitch65_g252036 = appendResult329_g252032;
					#endif
					float3 Blanket_Conform368_g252032 = staticSwitch65_g252036;
					float4 appendResult312_g252032 = (float4(Blanket_Conform368_g252032 , 0.0));
					float4 temp_output_310_0_g252032 = ( Model_TransformData356_g252032 + appendResult312_g252032 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g252032 = temp_output_310_0_g252032;
					#else
					float4 staticSwitch364_g252032 = Model_TransformData356_g252032;
					#endif
					half4 Final_TransformData365_g252032 = staticSwitch364_g252032;
					float4 In_TransformData16_g252041 = Final_TransformData365_g252032;
					float4 In_RotationData16_g252041 = Out_RotationData15_g252040;
					float4 In_Interpolator16_g252041 = Out_Interpolator15_g252040;
					BuildVertexData( Data16_g252041 , In_Dummy16_g252041 , In_PositionOS16_g252041 , In_NormalOS16_g252041 , In_TangentOS16_g252041 , In_TransformData16_g252041 , In_RotationData16_g252041 , In_Interpolator16_g252041 );
					TVEVertexData Data15_g252052 =(TVEVertexData)Data16_g252041;
					float Out_Dummy15_g252052 = 0.0;
					float3 Out_PositionOS15_g252052 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252052 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252052 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252052 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252052 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252052 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252052 , Out_Dummy15_g252052 , Out_PositionOS15_g252052 , Out_NormalOS15_g252052 , Out_TangentOS15_g252052 , Out_TransformData15_g252052 , Out_RotationData15_g252052 , Out_Interpolator15_g252052 );
					TVEVertexData Data16_g252053 =(TVEVertexData)Data15_g252052;
					float In_Dummy16_g252053 = 0.0;
					float3 Vertex_PositionOS147_g252043 = Out_PositionOS15_g252052;
					half3 VertexPos40_g252047 = Vertex_PositionOS147_g252043;
					float4 temp_output_1615_33_g252043 = Out_RotationData15_g252052;
					half4 Vertex_RotationData1569_g252043 = temp_output_1615_33_g252043;
					float2 break1582_g252043 = (Vertex_RotationData1569_g252043).xy;
					half Angle44_g252047 = break1582_g252043.y;
					half CosAngle89_g252047 = cos( Angle44_g252047 );
					half SinAngle93_g252047 = sin( Angle44_g252047 );
					float3 appendResult95_g252047 = (float3((VertexPos40_g252047).x , ( ( (VertexPos40_g252047).y * CosAngle89_g252047 ) - ( (VertexPos40_g252047).z * SinAngle93_g252047 ) ) , ( ( (VertexPos40_g252047).y * SinAngle93_g252047 ) + ( (VertexPos40_g252047).z * CosAngle89_g252047 ) )));
					half3 VertexPos40_g252048 = appendResult95_g252047;
					half Angle44_g252048 = -break1582_g252043.x;
					half CosAngle94_g252048 = cos( Angle44_g252048 );
					half SinAngle95_g252048 = sin( Angle44_g252048 );
					float3 appendResult98_g252048 = (float3(( ( (VertexPos40_g252048).x * CosAngle94_g252048 ) - ( (VertexPos40_g252048).y * SinAngle95_g252048 ) ) , ( ( (VertexPos40_g252048).x * SinAngle95_g252048 ) + ( (VertexPos40_g252048).y * CosAngle94_g252048 ) ) , (VertexPos40_g252048).z));
					half3 VertexPos40_g252046 = Vertex_PositionOS147_g252043;
					half Angle44_g252046 = break1582_g252043.y;
					half CosAngle89_g252046 = cos( Angle44_g252046 );
					half SinAngle93_g252046 = sin( Angle44_g252046 );
					float3 appendResult95_g252046 = (float3((VertexPos40_g252046).x , ( ( (VertexPos40_g252046).y * CosAngle89_g252046 ) - ( (VertexPos40_g252046).z * SinAngle93_g252046 ) ) , ( ( (VertexPos40_g252046).y * SinAngle93_g252046 ) + ( (VertexPos40_g252046).z * CosAngle89_g252046 ) )));
					half3 VertexPos40_g252051 = appendResult95_g252046;
					half Angle44_g252051 = break1582_g252043.x;
					half CosAngle91_g252051 = cos( Angle44_g252051 );
					half SinAngle92_g252051 = sin( Angle44_g252051 );
					float3 appendResult93_g252051 = (float3(( ( (VertexPos40_g252051).x * CosAngle91_g252051 ) + ( (VertexPos40_g252051).z * SinAngle92_g252051 ) ) , (VertexPos40_g252051).y , ( ( -(VertexPos40_g252051).x * SinAngle92_g252051 ) + ( (VertexPos40_g252051).z * CosAngle91_g252051 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252049 = appendResult93_g252051;
					#else
					float3 staticSwitch65_g252049 = appendResult98_g252048;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g252044 = staticSwitch65_g252049;
					#else
					float3 staticSwitch65_g252044 = Vertex_PositionOS147_g252043;
					#endif
					float3 temp_output_1608_0_g252043 = staticSwitch65_g252044;
					half3 VertexPos40_g252050 = temp_output_1608_0_g252043;
					half Angle44_g252050 = (Vertex_RotationData1569_g252043).z;
					half CosAngle91_g252050 = cos( Angle44_g252050 );
					half SinAngle92_g252050 = sin( Angle44_g252050 );
					float3 appendResult93_g252050 = (float3(( ( (VertexPos40_g252050).x * CosAngle91_g252050 ) + ( (VertexPos40_g252050).z * SinAngle92_g252050 ) ) , (VertexPos40_g252050).y , ( ( -(VertexPos40_g252050).x * SinAngle92_g252050 ) + ( (VertexPos40_g252050).z * CosAngle91_g252050 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g252045 = appendResult93_g252050;
					#else
					float3 staticSwitch65_g252045 = temp_output_1608_0_g252043;
					#endif
					float4 temp_output_1615_31_g252043 = Out_TransformData15_g252052;
					half4 Vertex_TransformData1568_g252043 = temp_output_1615_31_g252043;
					half3 Final_PositionOS178_g252043 = ( ( staticSwitch65_g252045 * (Vertex_TransformData1568_g252043).w ) + (Vertex_TransformData1568_g252043).xyz );
					float3 In_PositionOS16_g252053 = Final_PositionOS178_g252043;
					float3 In_NormalOS16_g252053 = Out_NormalOS15_g252052;
					float4 In_TangentOS16_g252053 = Out_TangentOS15_g252052;
					float4 In_TransformData16_g252053 = temp_output_1615_31_g252043;
					float4 In_RotationData16_g252053 = temp_output_1615_33_g252043;
					float4 In_Interpolator16_g252053 = Out_Interpolator15_g252052;
					BuildVertexData( Data16_g252053 , In_Dummy16_g252053 , In_PositionOS16_g252053 , In_NormalOS16_g252053 , In_TangentOS16_g252053 , In_TransformData16_g252053 , In_RotationData16_g252053 , In_Interpolator16_g252053 );
					TVEVertexData Data15_g252056 =(TVEVertexData)Data16_g252053;
					float Out_Dummy15_g252056 = 0.0;
					float3 Out_PositionOS15_g252056 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252056 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252056 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252056 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252056 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252056 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252056 , Out_Dummy15_g252056 , Out_PositionOS15_g252056 , Out_NormalOS15_g252056 , Out_TangentOS15_g252056 , Out_TransformData15_g252056 , Out_RotationData15_g252056 , Out_Interpolator15_g252056 );
					TVEVertexData Data16_g252057 =(TVEVertexData)Data15_g252056;
					float In_Dummy16_g252057 = 0.0;
					TVEModelData Data15_g252055 =(TVEModelData)Data15_g252039;
					float Out_Dummy15_g252055 = 0.0;
					float3 Out_PositionOS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252055 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252055 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252055 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252055 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252055 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252055 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252055 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252055 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252055 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252055 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252055 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252055 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252055 , Out_Dummy15_g252055 , Out_PositionOS15_g252055 , Out_PositionWS15_g252055 , Out_PositionWO15_g252055 , Out_PositionRawOS15_g252055 , Out_PivotOS15_g252055 , Out_PivotWS15_g252055 , Out_PivotWO15_g252055 , Out_NormalOS15_g252055 , Out_NormalWS15_g252055 , Out_NormalRawOS15_g252055 , Out_TangentOS15_g252055 , Out_TangentWS15_g252055 , Out_BitangentWS15_g252055 , Out_ViewDirWS15_g252055 , Out_CoordsData15_g252055 , Out_VertexData15_g252055 , Out_MasksData15_g252055 , Out_PhaseData15_g252055 , Out_TransformData15_g252055 , Out_RotationData15_g252055 , Out_Interpolator15_g252055 );
					float3 In_PositionOS16_g252057 = ( Out_PositionOS15_g252056 + Out_PivotOS15_g252055 );
					float3 In_NormalOS16_g252057 = Out_NormalOS15_g252056;
					float4 In_TangentOS16_g252057 = Out_TangentOS15_g252056;
					float4 In_TransformData16_g252057 = Out_TransformData15_g252056;
					float4 In_RotationData16_g252057 = Out_RotationData15_g252056;
					float4 In_Interpolator16_g252057 = Out_Interpolator15_g252056;
					BuildVertexData( Data16_g252057 , In_Dummy16_g252057 , In_PositionOS16_g252057 , In_NormalOS16_g252057 , In_TangentOS16_g252057 , In_TransformData16_g252057 , In_RotationData16_g252057 , In_Interpolator16_g252057 );
					TVEVertexData Data15_g252574 =(TVEVertexData)Data16_g252057;
					float Out_Dummy15_g252574 = 0.0;
					float3 Out_PositionOS15_g252574 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252574 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252574 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252574 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252574 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252574 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252574 , Out_Dummy15_g252574 , Out_PositionOS15_g252574 , Out_NormalOS15_g252574 , Out_TangentOS15_g252574 , Out_TransformData15_g252574 , Out_RotationData15_g252574 , Out_Interpolator15_g252574 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252574;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g252574;
					v.tangent = Out_TangentOS15_g252574;

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

					TVEVertexData Data16_g252031 =(TVEVertexData)0;
					float In_Dummy16_g252031 = 0.0;
					TVEVertexData Data16_g252026 =(TVEVertexData)0;
					float In_Dummy16_g252026 = 0.0;
					TVEModelData Data16_g251777 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251759 = _ObjectCoordMode;
					#endif
					half Dummy207_g251759 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251759 );
					float temp_output_14_0_g251777 = Dummy207_g251759;
					float In_Dummy16_g251777 = temp_output_14_0_g251777;
					float3 PositionOS131_g251759 = v.vertex.xyz;
					float3 temp_output_4_0_g251777 = PositionOS131_g251759;
					float3 In_PositionOS16_g251777 = temp_output_4_0_g251777;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251759 = ase_positionWS;
					float3 vertexToFrag73_g251759 = temp_output_104_7_g251759;
					float3 PositionWS122_g251759 = vertexToFrag73_g251759;
					float3 In_PositionWS16_g251777 = PositionWS122_g251759;
					float4x4 break19_g251762 = unity_ObjectToWorld;
					float3 appendResult20_g251762 = (float3(break19_g251762[ 0 ][ 3 ] , break19_g251762[ 1 ][ 3 ] , break19_g251762[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251759 = appendResult20_g251762;
					float4x4 break19_g251764 = unity_ObjectToWorld;
					float3 appendResult20_g251764 = (float3(break19_g251764[ 0 ][ 3 ] , break19_g251764[ 1 ][ 3 ] , break19_g251764[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251760 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251759 = PositionOS131_g251759;
					float3 appendResult234_g251759 = (float3(break233_g251759.x , 0.0 , break233_g251759.z));
					float3 break413_g251759 = PositionOS131_g251759;
					float3 appendResult414_g251759 = (float3(break413_g251759.x , break413_g251759.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251766 = appendResult414_g251759;
					#else
					float3 staticSwitch65_g251766 = appendResult234_g251759;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251759 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251759 = appendResult60_g251760;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251759 = staticSwitch65_g251766;
					#else
					float3 staticSwitch229_g251759 = _Vector0;
					#endif
					float3 PivotOS149_g251759 = staticSwitch229_g251759;
					float3 temp_output_122_0_g251764 = PivotOS149_g251759;
					float3 PivotsOnlyWS105_g251764 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251764 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251759 = ( appendResult20_g251764 + PivotsOnlyWS105_g251764 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251759 = temp_output_341_7_g251759;
					#else
					float3 staticSwitch236_g251759 = temp_output_340_7_g251759;
					#endif
					float3 vertexToFrag76_g251759 = staticSwitch236_g251759;
					float3 PivotWS121_g251759 = vertexToFrag76_g251759;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251759 = ( PositionWS122_g251759 - PivotWS121_g251759 );
					#else
					float3 staticSwitch204_g251759 = PositionWS122_g251759;
					#endif
					float3 PositionWO132_g251759 = ( staticSwitch204_g251759 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251777 = PositionWO132_g251759;
					float3 In_PivotOS16_g251777 = PivotOS149_g251759;
					float3 In_PivotWS16_g251777 = PivotWS121_g251759;
					float3 PivotWO133_g251759 = ( PivotWS121_g251759 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251777 = PivotWO133_g251759;
					half3 NormalOS134_g251759 = v.normal;
					float3 temp_output_21_0_g251777 = NormalOS134_g251759;
					float3 In_NormalOS16_g251777 = temp_output_21_0_g251777;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251759 = normalizedWorldNormal;
					float3 In_NormalWS16_g251777 = NormalWS95_g251759;
					half4 TangentlOS153_g251759 = v.tangent;
					float4 temp_output_6_0_g251777 = TangentlOS153_g251759;
					float4 In_TangentOS16_g251777 = temp_output_6_0_g251777;
					float3 normalizeResult296_g251759 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251759 ) );
					half3 ViewDirWS169_g251759 = normalizeResult296_g251759;
					float3 In_ViewDirWS16_g251777 = ViewDirWS169_g251759;
					float4 appendResult397_g251759 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251759 = appendResult397_g251759;
					float4 In_CoordsData16_g251777 = CoordsData398_g251759;
					half4 VertexMasks171_g251759 = v.ase_color;
					float4 In_VertexData16_g251777 = VertexMasks171_g251759;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251771 = (PositionOS131_g251759).z;
					#else
					float staticSwitch65_g251771 = (PositionOS131_g251759).y;
					#endif
					half Object_HeightValue267_g251759 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251759 = saturate( ( staticSwitch65_g251771 / Object_HeightValue267_g251759 ) );
					half3 Position387_g251759 = PositionOS131_g251759;
					half Height387_g251759 = Object_HeightValue267_g251759;
					half Object_RadiusValue268_g251759 = _ObjectRadiusValue;
					half Radius387_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskYUp387_g251759 = CapsuleMaskYUp( Position387_g251759 , Height387_g251759 , Radius387_g251759 );
					half3 Position408_g251759 = PositionOS131_g251759;
					half Height408_g251759 = Object_HeightValue267_g251759;
					half Radius408_g251759 = Object_RadiusValue268_g251759;
					half localCapsuleMaskZUp408_g251759 = CapsuleMaskZUp( Position408_g251759 , Height408_g251759 , Radius408_g251759 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251776 = saturate( localCapsuleMaskZUp408_g251759 );
					#else
					float staticSwitch65_g251776 = saturate( localCapsuleMaskYUp387_g251759 );
					#endif
					half Bounds_SphereMask282_g251759 = staticSwitch65_g251776;
					float4 appendResult253_g251759 = (float4(Bounds_HeightMask274_g251759 , Bounds_SphereMask282_g251759 , 1.0 , 1.0));
					half4 MasksData254_g251759 = appendResult253_g251759;
					float4 In_MasksData16_g251777 = MasksData254_g251759;
					float temp_output_17_0_g251770 = _ObjectPhaseMode;
					float Option70_g251770 = temp_output_17_0_g251770;
					float4 temp_output_3_0_g251770 = v.ase_color;
					float4 Channel70_g251770 = temp_output_3_0_g251770;
					float localSwitchChannel470_g251770 = SwitchChannel4( Option70_g251770 , Channel70_g251770 );
					half Phase_Value372_g251759 = localSwitchChannel470_g251770;
					float3 break319_g251759 = PivotWO133_g251759;
					half Pivot_Position322_g251759 = ( break319_g251759.x + break319_g251759.z );
					half Phase_Position357_g251759 = ( Phase_Value372_g251759 + Pivot_Position322_g251759 );
					float temp_output_248_0_g251759 = frac( Phase_Position357_g251759 );
					float4 appendResult177_g251759 = (float4((frac( ( Phase_Position357_g251759 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251759));
					half4 Phase_Data176_g251759 = appendResult177_g251759;
					float4 In_PhaseData16_g251777 = Phase_Data176_g251759;
					BuildModelVertData( Data16_g251777 , In_Dummy16_g251777 , In_PositionOS16_g251777 , In_PositionWS16_g251777 , In_PositionWO16_g251777 , In_PivotOS16_g251777 , In_PivotWS16_g251777 , In_PivotWO16_g251777 , In_NormalOS16_g251777 , In_NormalWS16_g251777 , In_TangentOS16_g251777 , In_ViewDirWS16_g251777 , In_CoordsData16_g251777 , In_VertexData16_g251777 , In_MasksData16_g251777 , In_PhaseData16_g251777 );
					TVEModelData Data15_g252027 =(TVEModelData)Data16_g251777;
					float Out_Dummy15_g252027 = 0.0;
					float3 Out_PositionOS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252027 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252027 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252027 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252027 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252027 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252027 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252027 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252027 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252027 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252027 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252027 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252027 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252027 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252027 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252027 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252027 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252027 , Out_Dummy15_g252027 , Out_PositionOS15_g252027 , Out_PositionWS15_g252027 , Out_PositionWO15_g252027 , Out_PositionRawOS15_g252027 , Out_PivotOS15_g252027 , Out_PivotWS15_g252027 , Out_PivotWO15_g252027 , Out_NormalOS15_g252027 , Out_NormalWS15_g252027 , Out_NormalRawOS15_g252027 , Out_TangentOS15_g252027 , Out_TangentWS15_g252027 , Out_BitangentWS15_g252027 , Out_ViewDirWS15_g252027 , Out_CoordsData15_g252027 , Out_VertexData15_g252027 , Out_MasksData15_g252027 , Out_PhaseData15_g252027 , Out_TransformData15_g252027 , Out_RotationData15_g252027 , Out_Interpolator15_g252027 );
					float3 In_PositionOS16_g252026 = Out_PositionOS15_g252027;
					float3 In_NormalOS16_g252026 = Out_NormalOS15_g252027;
					float4 In_TangentOS16_g252026 = Out_TangentOS15_g252027;
					float4 In_TransformData16_g252026 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252026 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252026 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252026 , In_Dummy16_g252026 , In_PositionOS16_g252026 , In_NormalOS16_g252026 , In_TangentOS16_g252026 , In_TransformData16_g252026 , In_RotationData16_g252026 , In_Interpolator16_g252026 );
					TVEVertexData Data15_g252029 =(TVEVertexData)Data16_g252026;
					float Out_Dummy15_g252029 = 0.0;
					float3 Out_PositionOS15_g252029 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252029 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252029 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252029 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252029 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252029 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252029 , Out_Dummy15_g252029 , Out_PositionOS15_g252029 , Out_NormalOS15_g252029 , Out_TangentOS15_g252029 , Out_TransformData15_g252029 , Out_RotationData15_g252029 , Out_Interpolator15_g252029 );
					TVEModelData Data15_g252030 =(TVEModelData)Data15_g252027;
					float Out_Dummy15_g252030 = 0.0;
					float3 Out_PositionOS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252030 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252030 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252030 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252030 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252030 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252030 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252030 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252030 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252030 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252030 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252030 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252030 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252030 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252030 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252030 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252030 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252030 , Out_Dummy15_g252030 , Out_PositionOS15_g252030 , Out_PositionWS15_g252030 , Out_PositionWO15_g252030 , Out_PositionRawOS15_g252030 , Out_PivotOS15_g252030 , Out_PivotWS15_g252030 , Out_PivotWO15_g252030 , Out_NormalOS15_g252030 , Out_NormalWS15_g252030 , Out_NormalRawOS15_g252030 , Out_TangentOS15_g252030 , Out_TangentWS15_g252030 , Out_BitangentWS15_g252030 , Out_ViewDirWS15_g252030 , Out_CoordsData15_g252030 , Out_VertexData15_g252030 , Out_MasksData15_g252030 , Out_PhaseData15_g252030 , Out_TransformData15_g252030 , Out_RotationData15_g252030 , Out_Interpolator15_g252030 );
					float3 In_PositionOS16_g252031 = ( Out_PositionOS15_g252029 - Out_PivotOS15_g252030 );
					float3 In_NormalOS16_g252031 = Out_NormalOS15_g252030;
					float4 In_TangentOS16_g252031 = Out_TangentOS15_g252030;
					float4 In_TransformData16_g252031 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g252031 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g252031 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g252031 , In_Dummy16_g252031 , In_PositionOS16_g252031 , In_NormalOS16_g252031 , In_TangentOS16_g252031 , In_TransformData16_g252031 , In_RotationData16_g252031 , In_Interpolator16_g252031 );
					TVEVertexData Data15_g252040 =(TVEVertexData)Data16_g252031;
					float Out_Dummy15_g252040 = 0.0;
					float3 Out_PositionOS15_g252040 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252040 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252040 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252040 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252040 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252040 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252040 , Out_Dummy15_g252040 , Out_PositionOS15_g252040 , Out_NormalOS15_g252040 , Out_TangentOS15_g252040 , Out_TransformData15_g252040 , Out_RotationData15_g252040 , Out_Interpolator15_g252040 );
					TVEVertexData Data16_g252041 =(TVEVertexData)Data15_g252040;
					half Dummy317_g252032 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g252041 = Dummy317_g252032;
					float3 In_PositionOS16_g252041 = Out_PositionOS15_g252040;
					float3 In_NormalOS16_g252041 = Out_NormalOS15_g252040;
					float4 In_TangentOS16_g252041 = Out_TangentOS15_g252040;
					half4 Model_TransformData356_g252032 = Out_TransformData15_g252040;
					float localBuildGlobalData204_g251779 = ( 0.0 );
					TVEGlobalData Data204_g251779 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251779 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251779 = Dummy211_g251779;
					float4 temp_output_203_0_g251798 = TVE_CoatBaseCoord;
					TVEModelData Data16_g251767 =(TVEModelData)0;
					float In_Dummy16_g251767 = 0.0;
					float3 In_PositionWS16_g251767 = PositionWS122_g251759;
					float3 In_PositionWO16_g251767 = PositionWO132_g251759;
					float3 In_PivotWS16_g251767 = PivotWS121_g251759;
					float3 In_PivotWO16_g251767 = PivotWO133_g251759;
					float3 In_NormalWS16_g251767 = NormalWS95_g251759;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251759 = ase_tangentWS;
					float3 In_TangentWS16_g251767 = TangentWS136_g251759;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251759 = ase_bitangentWS;
					float3 In_BitangentWS16_g251767 = BiangentWS421_g251759;
					half3 NormalWS427_g251759 = NormalWS95_g251759;
					half3 localComputeTriplanarMasks427_g251759 = ComputeTriplanarMasks( NormalWS427_g251759 );
					half3 TriplanarWeights429_g251759 = localComputeTriplanarMasks427_g251759;
					float3 In_TriplanarWeights16_g251767 = TriplanarWeights429_g251759;
					float3 In_ViewDirWS16_g251767 = ViewDirWS169_g251759;
					float4 In_CoordsData16_g251767 = CoordsData398_g251759;
					float4 In_VertexData16_g251767 = VertexMasks171_g251759;
					float4 In_Interpolator16_g251767 = Phase_Data176_g251759;
					BuildModelFragData( Data16_g251767 , In_Dummy16_g251767 , In_PositionWS16_g251767 , In_PositionWO16_g251767 , In_PivotWS16_g251767 , In_PivotWO16_g251767 , In_NormalWS16_g251767 , In_TangentWS16_g251767 , In_BitangentWS16_g251767 , In_TriplanarWeights16_g251767 , In_ViewDirWS16_g251767 , In_CoordsData16_g251767 , In_VertexData16_g251767 , In_Interpolator16_g251767 );
					TVEModelData Data15_g251869 =(TVEModelData)Data16_g251767;
					float Out_Dummy15_g251869 = 0.0;
					float3 Out_PositionWS15_g251869 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251869 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251869 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251869 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251869 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251869 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251869 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251869 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251869 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251869 , Out_Dummy15_g251869 , Out_PositionWS15_g251869 , Out_PositionWO15_g251869 , Out_PivotWS15_g251869 , Out_PivotWO15_g251869 , Out_NormalWS15_g251869 , Out_TangentWS15_g251869 , Out_BitangentWS15_g251869 , Out_TriplanarWeights15_g251869 , Out_ViewDirWS15_g251869 , Out_CoordsData15_g251869 , Out_VertexData15_g251869 , Out_Interpolator15_g251869 );
					float3 Model_PositionWS497_g251779 = Out_PositionWS15_g251869;
					float2 Model_PositionWS_XZ143_g251779 = (Model_PositionWS497_g251779).xz;
					float3 Model_PivotWS498_g251779 = Out_PivotWS15_g251869;
					float2 Model_PivotWS_XZ145_g251779 = (Model_PivotWS498_g251779).xz;
					float2 lerpResult300_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251798 = lerpResult300_g251779;
					float temp_output_82_0_g251796 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251798 = temp_output_82_0_g251796;
					float4 tex2DArrayNode83_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251798).zw + ( (temp_output_203_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult210_g251798 = (float4(tex2DArrayNode83_g251798.rgb , tex2DArrayNode83_g251798.a));
					float4 temp_output_204_0_g251798 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251798 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251798).zw + ( (temp_output_204_0_g251798).xy * temp_output_81_0_g251798 ) ),temp_output_82_0_g251798), 0.0 );
					float4 appendResult212_g251798 = (float4(tex2DArrayNode122_g251798.rgb , tex2DArrayNode122_g251798.a));
					float4 TVE_RenderNearPositionR628_g251779 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251779 = saturate( ( distance( Model_PositionWS497_g251779 , (TVE_RenderNearPositionR628_g251779).xyz ) / (TVE_RenderNearPositionR628_g251779).w ) );
					float temp_output_7_0_g251868 = 1.0;
					float temp_output_9_0_g251868 = ( temp_output_507_0_g251779 - temp_output_7_0_g251868 );
					half TVE_RenderNearFadeValue635_g251779 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251779 = saturate( ( temp_output_9_0_g251868 / ( ( TVE_RenderNearFadeValue635_g251779 - temp_output_7_0_g251868 ) + 0.0001 ) ) );
					float4 lerpResult131_g251798 = lerp( appendResult210_g251798 , appendResult212_g251798 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251796 = lerpResult131_g251798;
					float4 lerpResult168_g251796 = lerp( TVE_CoatParams , temp_output_159_109_g251796 , TVE_CoatLayers[(int)temp_output_82_0_g251796]);
					float4 temp_output_589_109_g251779 = lerpResult168_g251796;
					half4 Coat_Texture302_g251779 = temp_output_589_109_g251779;
					float4 In_CoatTexture204_g251779 = Coat_Texture302_g251779;
					half4 Draw_Texture656_g251779 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251779 = Draw_Texture656_g251779;
					float4 temp_output_203_0_g251823 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251823 = lerpResult85_g251779;
					float temp_output_82_0_g251820 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251823 = temp_output_82_0_g251820;
					float4 tex2DArrayNode83_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251823).zw + ( (temp_output_203_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult210_g251823 = (float4(tex2DArrayNode83_g251823.rgb , tex2DArrayNode83_g251823.a));
					float4 temp_output_204_0_g251823 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251823 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251823).zw + ( (temp_output_204_0_g251823).xy * temp_output_81_0_g251823 ) ),temp_output_82_0_g251823), 0.0 );
					float4 appendResult212_g251823 = (float4(tex2DArrayNode122_g251823.rgb , tex2DArrayNode122_g251823.a));
					float4 lerpResult131_g251823 = lerp( appendResult210_g251823 , appendResult212_g251823 , Global_TexBlend509_g251779);
					float4 temp_output_171_109_g251820 = lerpResult131_g251823;
					float4 lerpResult174_g251820 = lerp( TVE_PaintParams , temp_output_171_109_g251820 , TVE_PaintLayers[(int)temp_output_82_0_g251820]);
					float4 temp_output_595_109_g251779 = lerpResult174_g251820;
					half4 Paint_Texture71_g251779 = temp_output_595_109_g251779;
					float4 In_PaintTexture204_g251779 = Paint_Texture71_g251779;
					float4 temp_output_203_0_g251806 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251806 = lerpResult104_g251779;
					float temp_output_132_0_g251804 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251806 = temp_output_132_0_g251804;
					float4 tex2DArrayNode83_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251806).zw + ( (temp_output_203_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult210_g251806 = (float4(tex2DArrayNode83_g251806.rgb , tex2DArrayNode83_g251806.a));
					float4 temp_output_204_0_g251806 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251806 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251806).zw + ( (temp_output_204_0_g251806).xy * temp_output_81_0_g251806 ) ),temp_output_82_0_g251806), 0.0 );
					float4 appendResult212_g251806 = (float4(tex2DArrayNode122_g251806.rgb , tex2DArrayNode122_g251806.a));
					float4 lerpResult131_g251806 = lerp( appendResult210_g251806 , appendResult212_g251806 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251804 = lerpResult131_g251806;
					float4 lerpResult145_g251804 = lerp( TVE_AtmoParams , temp_output_137_109_g251804 , TVE_AtmoLayers[(int)temp_output_132_0_g251804]);
					float4 temp_output_590_110_g251779 = lerpResult145_g251804;
					half4 Atmo_Texture80_g251779 = temp_output_590_110_g251779;
					float4 In_AtmoTexture204_g251779 = Atmo_Texture80_g251779;
					float4 temp_output_203_0_g251874 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251874 = lerpResult414_g251779;
					float temp_output_132_0_g251872 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251874 = temp_output_132_0_g251872;
					float4 tex2DArrayNode83_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251874).zw + ( (temp_output_203_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult210_g251874 = (float4(tex2DArrayNode83_g251874.rgb , tex2DArrayNode83_g251874.a));
					float4 temp_output_204_0_g251874 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251874 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251874).zw + ( (temp_output_204_0_g251874).xy * temp_output_81_0_g251874 ) ),temp_output_82_0_g251874), 0.0 );
					float4 appendResult212_g251874 = (float4(tex2DArrayNode122_g251874.rgb , tex2DArrayNode122_g251874.a));
					float4 lerpResult131_g251874 = lerp( appendResult210_g251874 , appendResult212_g251874 , Global_TexBlend509_g251779);
					float4 temp_output_137_109_g251872 = lerpResult131_g251874;
					float4 lerpResult145_g251872 = lerp( TVE_EffexParams , temp_output_137_109_g251872 , TVE_EffexLayers[(int)temp_output_132_0_g251872]);
					float4 temp_output_731_110_g251779 = lerpResult145_g251872;
					half4 Effex_Texture420_g251779 = temp_output_731_110_g251779;
					float4 In_EffexTexture204_g251779 = Effex_Texture420_g251779;
					float4 temp_output_203_0_g251854 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251854 = lerpResult247_g251779;
					float temp_output_82_0_g251852 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251854 = temp_output_82_0_g251852;
					float4 tex2DArrayNode83_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251854).zw + ( (temp_output_203_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult210_g251854 = (float4(tex2DArrayNode83_g251854.rgb , tex2DArrayNode83_g251854.a));
					float4 temp_output_204_0_g251854 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251854 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251854).zw + ( (temp_output_204_0_g251854).xy * temp_output_81_0_g251854 ) ),temp_output_82_0_g251854), 0.0 );
					float4 appendResult212_g251854 = (float4(tex2DArrayNode122_g251854.rgb , tex2DArrayNode122_g251854.a));
					float4 lerpResult131_g251854 = lerp( appendResult210_g251854 , appendResult212_g251854 , Global_TexBlend509_g251779);
					float4 temp_output_159_109_g251852 = lerpResult131_g251854;
					float4 lerpResult167_g251852 = lerp( TVE_GlowParams , temp_output_159_109_g251852 , TVE_GlowLayers[(int)temp_output_82_0_g251852]);
					float4 temp_output_593_109_g251779 = lerpResult167_g251852;
					half4 Glow_Texture248_g251779 = temp_output_593_109_g251779;
					float4 In_GlowTexture204_g251779 = Glow_Texture248_g251779;
					float4 temp_output_203_0_g251790 = TVE_FormBaseCoord;
					float2 lerpResult168_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251790 = lerpResult168_g251779;
					float temp_output_130_0_g251788 = _GlobalFormLayerValue;
					float temp_output_82_0_g251790 = temp_output_130_0_g251788;
					float4 tex2DArrayNode83_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251790).zw + ( (temp_output_203_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult210_g251790 = (float4(tex2DArrayNode83_g251790.rgb , tex2DArrayNode83_g251790.a));
					float4 temp_output_204_0_g251790 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251790 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251790).zw + ( (temp_output_204_0_g251790).xy * temp_output_81_0_g251790 ) ),temp_output_82_0_g251790), 0.0 );
					float4 appendResult212_g251790 = (float4(tex2DArrayNode122_g251790.rgb , tex2DArrayNode122_g251790.a));
					float4 lerpResult131_g251790 = lerp( appendResult210_g251790 , appendResult212_g251790 , Global_TexBlend509_g251779);
					float4 temp_output_135_109_g251788 = lerpResult131_g251790;
					float4 lerpResult143_g251788 = lerp( TVE_FormParams , temp_output_135_109_g251788 , TVE_FormLayers[(int)temp_output_130_0_g251788]);
					float4 temp_output_592_0_g251779 = lerpResult143_g251788;
					float4 Form_Texture112_g251779 = temp_output_592_0_g251779;
					float4 In_FormTexture204_g251779 = Form_Texture112_g251779;
					float4 In_LandTexture204_g251779 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251838 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251838 = lerpResult681_g251779;
					float temp_output_136_0_g251836 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251838 = temp_output_136_0_g251836;
					float4 tex2DArrayNode83_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251838).zw + ( (temp_output_203_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult210_g251838 = (float4(tex2DArrayNode83_g251838.rgb , tex2DArrayNode83_g251838.a));
					float4 temp_output_204_0_g251838 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251838 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251838).zw + ( (temp_output_204_0_g251838).xy * temp_output_81_0_g251838 ) ),temp_output_82_0_g251838), 0.0 );
					float4 appendResult212_g251838 = (float4(tex2DArrayNode122_g251838.rgb , tex2DArrayNode122_g251838.a));
					float4 lerpResult131_g251838 = lerp( appendResult210_g251838 , appendResult212_g251838 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251836 = lerpResult131_g251838;
					float4 lerpResult149_g251836 = lerp( TVE_VertxParams , temp_output_141_109_g251836 , TVE_VertxLayers[(int)temp_output_136_0_g251836]);
					float4 temp_output_695_0_g251779 = lerpResult149_g251836;
					half4 Vertx_Texture693_g251779 = temp_output_695_0_g251779;
					float4 In_VertxTexture204_g251779 = Vertx_Texture693_g251779;
					float4 temp_output_203_0_g251814 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251779 = lerp( Model_PositionWS_XZ143_g251779 , Model_PivotWS_XZ145_g251779 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251814 = lerpResult400_g251779;
					float temp_output_136_0_g251812 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251814 = temp_output_136_0_g251812;
					float4 tex2DArrayNode83_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251814).zw + ( (temp_output_203_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult210_g251814 = (float4(tex2DArrayNode83_g251814.rgb , tex2DArrayNode83_g251814.a));
					float4 temp_output_204_0_g251814 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251814 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251814).zw + ( (temp_output_204_0_g251814).xy * temp_output_81_0_g251814 ) ),temp_output_82_0_g251814), 0.0 );
					float4 appendResult212_g251814 = (float4(tex2DArrayNode122_g251814.rgb , tex2DArrayNode122_g251814.a));
					float4 lerpResult131_g251814 = lerp( appendResult210_g251814 , appendResult212_g251814 , Global_TexBlend509_g251779);
					float4 temp_output_141_109_g251812 = lerpResult131_g251814;
					float4 lerpResult149_g251812 = lerp( TVE_FlowParams , temp_output_141_109_g251812 , TVE_FlowLayers[(int)temp_output_136_0_g251812]);
					float4 temp_output_594_0_g251779 = lerpResult149_g251812;
					half4 Flow_Texture405_g251779 = temp_output_594_0_g251779;
					float4 In_FlowTexture204_g251779 = Flow_Texture405_g251779;
					half4 User_Texture677_g251779 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251779 = User_Texture677_g251779;
					BuildGlobalData( Data204_g251779 , In_Dummy204_g251779 , In_CoatTexture204_g251779 , In_DrawTexture204_g251779 , In_PaintTexture204_g251779 , In_AtmoTexture204_g251779 , In_EffexTexture204_g251779 , In_GlowTexture204_g251779 , In_FormTexture204_g251779 , In_LandTexture204_g251779 , In_VertxTexture204_g251779 , In_FlowTexture204_g251779 , In_UserTexture204_g251779 );
					TVEGlobalData Data15_g252042 =(TVEGlobalData)Data204_g251779;
					float Out_Dummy15_g252042 = 0.0;
					float4 Out_CoatTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252042 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252042 = float4( 0,0,0,0 );
					BreakData( Data15_g252042 , Out_Dummy15_g252042 , Out_CoatTexture15_g252042 , Out_DrawTexture15_g252042 , Out_PaintTexture15_g252042 , Out_AtmoTexture15_g252042 , Out_EffexTexture15_g252042 , Out_GlowTexture15_g252042 , Out_FormTexture15_g252042 , Out_LandTexture15_g252042 , Out_VertxTexture15_g252042 , Out_FlowTexture15_g252042 , Out_UserTexture15_g252042 );
					float4 Global_FormTexture351_g252032 = Out_FormTexture15_g252042;
					TVEModelData Data15_g252039 =(TVEModelData)Data15_g252030;
					float Out_Dummy15_g252039 = 0.0;
					float3 Out_PositionOS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252039 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252039 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252039 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252039 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252039 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252039 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252039 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252039 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252039 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252039 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252039 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252039 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252039 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252039 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252039 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252039 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252039 , Out_Dummy15_g252039 , Out_PositionOS15_g252039 , Out_PositionWS15_g252039 , Out_PositionWO15_g252039 , Out_PositionRawOS15_g252039 , Out_PivotOS15_g252039 , Out_PivotWS15_g252039 , Out_PivotWO15_g252039 , Out_NormalOS15_g252039 , Out_NormalWS15_g252039 , Out_NormalRawOS15_g252039 , Out_TangentOS15_g252039 , Out_TangentWS15_g252039 , Out_BitangentWS15_g252039 , Out_ViewDirWS15_g252039 , Out_CoordsData15_g252039 , Out_VertexData15_g252039 , Out_MasksData15_g252039 , Out_PhaseData15_g252039 , Out_TransformData15_g252039 , Out_RotationData15_g252039 , Out_Interpolator15_g252039 );
					float3 Model_PivotWO353_g252032 = Out_PivotWO15_g252039;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g252038 = _ConformMeshMode;
					float Option70_g252038 = temp_output_17_0_g252038;
					half4 Model_VertexData357_g252032 = Out_VertexData15_g252039;
					float4 temp_output_3_0_g252038 = Model_VertexData357_g252032;
					float4 Channel70_g252038 = temp_output_3_0_g252038;
					float localSwitchChannel470_g252038 = SwitchChannel4( Option70_g252038 , Channel70_g252038 );
					float temp_output_390_0_g252032 = localSwitchChannel470_g252038;
					float temp_output_7_0_g252035 = _ConformMeshRemap.x;
					float temp_output_9_0_g252035 = ( temp_output_390_0_g252032 - temp_output_7_0_g252035 );
					float lerpResult374_g252032 = lerp( 1.0 , saturate( ( temp_output_9_0_g252035 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g252032 = lerpResult374_g252032;
					float temp_output_328_0_g252032 = ( Blend_VertMask379_g252032 * TVE_IsEnabled );
					half Conform_Mask366_g252032 = temp_output_328_0_g252032;
					float temp_output_322_0_g252032 = ( ( ( ( (Global_FormTexture351_g252032).z - ( (Model_PivotWO353_g252032).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g252032 ) );
					float3 appendResult329_g252032 = (float3(0.0 , temp_output_322_0_g252032 , 0.0));
					float3 appendResult387_g252032 = (float3(0.0 , 0.0 , temp_output_322_0_g252032));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252036 = appendResult387_g252032;
					#else
					float3 staticSwitch65_g252036 = appendResult329_g252032;
					#endif
					float3 Blanket_Conform368_g252032 = staticSwitch65_g252036;
					float4 appendResult312_g252032 = (float4(Blanket_Conform368_g252032 , 0.0));
					float4 temp_output_310_0_g252032 = ( Model_TransformData356_g252032 + appendResult312_g252032 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g252032 = temp_output_310_0_g252032;
					#else
					float4 staticSwitch364_g252032 = Model_TransformData356_g252032;
					#endif
					half4 Final_TransformData365_g252032 = staticSwitch364_g252032;
					float4 In_TransformData16_g252041 = Final_TransformData365_g252032;
					float4 In_RotationData16_g252041 = Out_RotationData15_g252040;
					float4 In_Interpolator16_g252041 = Out_Interpolator15_g252040;
					BuildVertexData( Data16_g252041 , In_Dummy16_g252041 , In_PositionOS16_g252041 , In_NormalOS16_g252041 , In_TangentOS16_g252041 , In_TransformData16_g252041 , In_RotationData16_g252041 , In_Interpolator16_g252041 );
					TVEVertexData Data15_g252052 =(TVEVertexData)Data16_g252041;
					float Out_Dummy15_g252052 = 0.0;
					float3 Out_PositionOS15_g252052 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252052 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252052 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252052 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252052 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252052 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252052 , Out_Dummy15_g252052 , Out_PositionOS15_g252052 , Out_NormalOS15_g252052 , Out_TangentOS15_g252052 , Out_TransformData15_g252052 , Out_RotationData15_g252052 , Out_Interpolator15_g252052 );
					TVEVertexData Data16_g252053 =(TVEVertexData)Data15_g252052;
					float In_Dummy16_g252053 = 0.0;
					float3 Vertex_PositionOS147_g252043 = Out_PositionOS15_g252052;
					half3 VertexPos40_g252047 = Vertex_PositionOS147_g252043;
					float4 temp_output_1615_33_g252043 = Out_RotationData15_g252052;
					half4 Vertex_RotationData1569_g252043 = temp_output_1615_33_g252043;
					float2 break1582_g252043 = (Vertex_RotationData1569_g252043).xy;
					half Angle44_g252047 = break1582_g252043.y;
					half CosAngle89_g252047 = cos( Angle44_g252047 );
					half SinAngle93_g252047 = sin( Angle44_g252047 );
					float3 appendResult95_g252047 = (float3((VertexPos40_g252047).x , ( ( (VertexPos40_g252047).y * CosAngle89_g252047 ) - ( (VertexPos40_g252047).z * SinAngle93_g252047 ) ) , ( ( (VertexPos40_g252047).y * SinAngle93_g252047 ) + ( (VertexPos40_g252047).z * CosAngle89_g252047 ) )));
					half3 VertexPos40_g252048 = appendResult95_g252047;
					half Angle44_g252048 = -break1582_g252043.x;
					half CosAngle94_g252048 = cos( Angle44_g252048 );
					half SinAngle95_g252048 = sin( Angle44_g252048 );
					float3 appendResult98_g252048 = (float3(( ( (VertexPos40_g252048).x * CosAngle94_g252048 ) - ( (VertexPos40_g252048).y * SinAngle95_g252048 ) ) , ( ( (VertexPos40_g252048).x * SinAngle95_g252048 ) + ( (VertexPos40_g252048).y * CosAngle94_g252048 ) ) , (VertexPos40_g252048).z));
					half3 VertexPos40_g252046 = Vertex_PositionOS147_g252043;
					half Angle44_g252046 = break1582_g252043.y;
					half CosAngle89_g252046 = cos( Angle44_g252046 );
					half SinAngle93_g252046 = sin( Angle44_g252046 );
					float3 appendResult95_g252046 = (float3((VertexPos40_g252046).x , ( ( (VertexPos40_g252046).y * CosAngle89_g252046 ) - ( (VertexPos40_g252046).z * SinAngle93_g252046 ) ) , ( ( (VertexPos40_g252046).y * SinAngle93_g252046 ) + ( (VertexPos40_g252046).z * CosAngle89_g252046 ) )));
					half3 VertexPos40_g252051 = appendResult95_g252046;
					half Angle44_g252051 = break1582_g252043.x;
					half CosAngle91_g252051 = cos( Angle44_g252051 );
					half SinAngle92_g252051 = sin( Angle44_g252051 );
					float3 appendResult93_g252051 = (float3(( ( (VertexPos40_g252051).x * CosAngle91_g252051 ) + ( (VertexPos40_g252051).z * SinAngle92_g252051 ) ) , (VertexPos40_g252051).y , ( ( -(VertexPos40_g252051).x * SinAngle92_g252051 ) + ( (VertexPos40_g252051).z * CosAngle91_g252051 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g252049 = appendResult93_g252051;
					#else
					float3 staticSwitch65_g252049 = appendResult98_g252048;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g252044 = staticSwitch65_g252049;
					#else
					float3 staticSwitch65_g252044 = Vertex_PositionOS147_g252043;
					#endif
					float3 temp_output_1608_0_g252043 = staticSwitch65_g252044;
					half3 VertexPos40_g252050 = temp_output_1608_0_g252043;
					half Angle44_g252050 = (Vertex_RotationData1569_g252043).z;
					half CosAngle91_g252050 = cos( Angle44_g252050 );
					half SinAngle92_g252050 = sin( Angle44_g252050 );
					float3 appendResult93_g252050 = (float3(( ( (VertexPos40_g252050).x * CosAngle91_g252050 ) + ( (VertexPos40_g252050).z * SinAngle92_g252050 ) ) , (VertexPos40_g252050).y , ( ( -(VertexPos40_g252050).x * SinAngle92_g252050 ) + ( (VertexPos40_g252050).z * CosAngle91_g252050 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g252045 = appendResult93_g252050;
					#else
					float3 staticSwitch65_g252045 = temp_output_1608_0_g252043;
					#endif
					float4 temp_output_1615_31_g252043 = Out_TransformData15_g252052;
					half4 Vertex_TransformData1568_g252043 = temp_output_1615_31_g252043;
					half3 Final_PositionOS178_g252043 = ( ( staticSwitch65_g252045 * (Vertex_TransformData1568_g252043).w ) + (Vertex_TransformData1568_g252043).xyz );
					float3 In_PositionOS16_g252053 = Final_PositionOS178_g252043;
					float3 In_NormalOS16_g252053 = Out_NormalOS15_g252052;
					float4 In_TangentOS16_g252053 = Out_TangentOS15_g252052;
					float4 In_TransformData16_g252053 = temp_output_1615_31_g252043;
					float4 In_RotationData16_g252053 = temp_output_1615_33_g252043;
					float4 In_Interpolator16_g252053 = Out_Interpolator15_g252052;
					BuildVertexData( Data16_g252053 , In_Dummy16_g252053 , In_PositionOS16_g252053 , In_NormalOS16_g252053 , In_TangentOS16_g252053 , In_TransformData16_g252053 , In_RotationData16_g252053 , In_Interpolator16_g252053 );
					TVEVertexData Data15_g252056 =(TVEVertexData)Data16_g252053;
					float Out_Dummy15_g252056 = 0.0;
					float3 Out_PositionOS15_g252056 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252056 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252056 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252056 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252056 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252056 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252056 , Out_Dummy15_g252056 , Out_PositionOS15_g252056 , Out_NormalOS15_g252056 , Out_TangentOS15_g252056 , Out_TransformData15_g252056 , Out_RotationData15_g252056 , Out_Interpolator15_g252056 );
					TVEVertexData Data16_g252057 =(TVEVertexData)Data15_g252056;
					float In_Dummy16_g252057 = 0.0;
					TVEModelData Data15_g252055 =(TVEModelData)Data15_g252039;
					float Out_Dummy15_g252055 = 0.0;
					float3 Out_PositionOS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252055 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252055 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252055 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252055 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252055 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252055 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252055 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252055 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252055 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252055 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252055 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252055 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252055 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252055 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252055 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252055 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252055 , Out_Dummy15_g252055 , Out_PositionOS15_g252055 , Out_PositionWS15_g252055 , Out_PositionWO15_g252055 , Out_PositionRawOS15_g252055 , Out_PivotOS15_g252055 , Out_PivotWS15_g252055 , Out_PivotWO15_g252055 , Out_NormalOS15_g252055 , Out_NormalWS15_g252055 , Out_NormalRawOS15_g252055 , Out_TangentOS15_g252055 , Out_TangentWS15_g252055 , Out_BitangentWS15_g252055 , Out_ViewDirWS15_g252055 , Out_CoordsData15_g252055 , Out_VertexData15_g252055 , Out_MasksData15_g252055 , Out_PhaseData15_g252055 , Out_TransformData15_g252055 , Out_RotationData15_g252055 , Out_Interpolator15_g252055 );
					float3 In_PositionOS16_g252057 = ( Out_PositionOS15_g252056 + Out_PivotOS15_g252055 );
					float3 In_NormalOS16_g252057 = Out_NormalOS15_g252056;
					float4 In_TangentOS16_g252057 = Out_TangentOS15_g252056;
					float4 In_TransformData16_g252057 = Out_TransformData15_g252056;
					float4 In_RotationData16_g252057 = Out_RotationData15_g252056;
					float4 In_Interpolator16_g252057 = Out_Interpolator15_g252056;
					BuildVertexData( Data16_g252057 , In_Dummy16_g252057 , In_PositionOS16_g252057 , In_NormalOS16_g252057 , In_TangentOS16_g252057 , In_TransformData16_g252057 , In_RotationData16_g252057 , In_Interpolator16_g252057 );
					TVEVertexData Data15_g252574 =(TVEVertexData)Data16_g252057;
					float Out_Dummy15_g252574 = 0.0;
					float3 Out_PositionOS15_g252574 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252574 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252574 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252574 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252574 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252574 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252574 , Out_Dummy15_g252574 , Out_PositionOS15_g252574 , Out_NormalOS15_g252574 , Out_TangentOS15_g252574 , Out_TransformData15_g252574 , Out_RotationData15_g252574 , Out_Interpolator15_g252574 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252574;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g252574;
					v.tangent = Out_TangentOS15_g252574;

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
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2696,"pos":[-6976,-5056],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2697,"pos":[-6528,-5120],"params":["Inherit","False","2696","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2698,"pos":[-7296,-5120],"params":["Inherit","False","Block Model","42","","251759","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2699,"pos":[-6272,-5120],"params":["Inherit","False","Block Global","55","","251779","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2702,"pos":[-5952,-5120],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2700,"pos":[-6976,-5120],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2717,"pos":[-5504,-5120],"params":["Inherit","False","2700","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2718,"pos":[-5504,-5056],"params":["Inherit","False","2702","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2716,"pos":[-5248,-5120],"params":["Inherit","False","Block Vertex","-1","","252025","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2706,"pos":[-4864,-5120],"params":["Inherit","False","Block Pivots Sub","-1","","252028","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2707,"pos":[-4480,-5120],"params":["Inherit","False","Block Blanket Conform","139","","252032","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2708,"pos":[-4096,-5120],"params":["Inherit","False","Block Transform","-1","","252043","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2709,"pos":[-3712,-5120],"params":["Inherit","False","Block Pivots Add","-1","","252054","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2710,"pos":[-3392,-5120],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2719,"pos":[-2944,-4992],"params":["Inherit","False","2702","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2720,"pos":[-2944,-5056],"params":["Inherit","False","2696","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2722,"pos":[-2944,-5120],"params":["Inherit","False","2710","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2721,"pos":[-2688,-5120],"params":["Inherit","False","Block Visual","-1","","252254","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2714,"pos":[-2304,-5120],"params":["Inherit","False","Block Main","154","","252258","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2715,"pos":[-1984,-5120],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2600,"pos":[-896,-5120],"params":["Inherit","False","2715","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2508,"pos":[-896,-5056],"params":["Inherit","False","2696","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2507,"pos":[-896,-4992],"params":["Inherit","False","2702","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2620,"pos":[-576,-4800],"params":["Half","False","Global","TVE_DEBUG_Global","TVE_DEBUG_Global","4","0","Create","True","0","5","Vertex Colors","100","Texture Coords","200","Vertex Postion","300","Vertex Normals","301","Vertex Tangents","302","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2723,"pos":[-640,-5120],"params":["Inherit","False","Block Tinting","7","","252472","9f39e156ea8d89e4997ea2a1e194137e","13,352,1,503,0,414,1,416,1,407,1,502,0,507,0,400,0,334,1,336,1,339,1,355,0,344,0","4","198","OBJECT","0,0,0,0","False","223","OBJECT","0,0,0,0","False","207","OBJECT","0,0,0,0","False","346","FLOAT","1","False","4","OBJECT","204","OBJECT","527","OBJECT","529","OBJECT","472"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2724,"pos":[-640,-4960],"params":["Inherit","False","Block Tinting","7","","252514","9f39e156ea8d89e4997ea2a1e194137e","13,352,1,503,0,414,0,416,0,407,0,502,0,507,0,400,0,334,1,336,1,339,1,355,0,344,0","4","198","OBJECT","0,0,0,0","False","223","OBJECT","0,0,0,0","False","207","OBJECT","0,0,0,0","False","346","FLOAT","1","False","4","OBJECT","204","OBJECT","527","OBJECT","529","OBJECT","472"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2619,"pos":[-256,-5120],"params":["Inherit","False","If Masks Data","-1","","252556","8077f199aa3992c4b8c999410c1ede62","1,32,0","8","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","28","OBJECT","0","False","27","OBJECT","0","False","30","OBJECT","0","False","31","OBJECT","0","False","29","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2509,"pos":[0,-5120],"params":["Inherit","False","Break Masks Data","-1","","252557","23311522ecc97b54e8b77d849401069d","0","1","6","OBJECT","0","False","8","FLOAT4","14","FLOAT4","0","FLOAT4","23","FLOAT4","5","FLOAT4","24","FLOAT4","25","FLOAT4","26","FLOAT4","27"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2567,"pos":[768,-4992],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2646,"pos":[768,-5120],"params":["Inherit","False","Tool Debug Active","134","","252558","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2608,"pos":[768,-4464],"params":["Inherit","False","FLOAT","3","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2649,"pos":[768,-4592],"params":["Inherit","False","Tool Debug Active","134","","252560","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2490,"pos":[-7296,-5248],"params":["Inherit","False","Property","_IsTerrainShader","_IsTerrainShader","153","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2568,"pos":[1024,-5120],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2607,"pos":[1024,-4592],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2610,"pos":[768,-4864],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2496,"pos":[-7040,-5248],"params":["Half","False","IsTerranShader","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[1408,-5120],"params":["Inherit","False","Tool Debug Index","-1","","252562","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2611,"pos":[1408,-4864],"params":["Inherit","False","Tool Debug Index","-1","","252563","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2609,"pos":[1408,-4592],"params":["Inherit","False","Tool Debug Index","-1","","252564","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[1792,-5120],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2661,"pos":[1792,-4864],"params":["Inherit","False","2496","IsTerranShader","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2660,"pos":[2048,-5120],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[2368,-5120],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[3072,-5120],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2563,"pos":[3072,-5056],"params":["Inherit","False","2715","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2555,"pos":[3072,-4992],"params":["Inherit","False","2710","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3712,-5248],"params":["Inherit","False","Base Compile","-1","","252565","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2672,"pos":[3328,-5120],"params":["Inherit","False","Tool Debug Color","0","","252566","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[3328,-5120],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[3712,-5120],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Tinting","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2674,"pos":[3328,-4932],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2675,"pos":[3712,-5120],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2696,0,2698,314]}
{"wire":[2699,206,2697,0]}
{"wire":[2702,0,2699,151]}
{"wire":[2700,0,2698,128]}
{"wire":[2716,1894,2717,0]}
{"wire":[2716,1896,2718,0]}
{"wire":[2706,224,2716,128]}
{"wire":[2706,146,2716,1895]}
{"wire":[2706,231,2716,1897]}
{"wire":[2707,146,2706,128]}
{"wire":[2707,397,2706,229]}
{"wire":[2707,186,2706,232]}
{"wire":[2708,146,2707,128]}
{"wire":[2708,1620,2707,398]}
{"wire":[2708,1619,2707,399]}
{"wire":[2709,146,2708,128]}
{"wire":[2709,225,2708,1617]}
{"wire":[2709,227,2708,1618]}
{"wire":[2710,0,2709,128]}
{"wire":[2721,1904,2722,0]}
{"wire":[2721,1894,2720,0]}
{"wire":[2721,1896,2719,0]}
{"wire":[2714,430,2721,1900]}
{"wire":[2714,225,2721,1895]}
{"wire":[2714,414,2721,1897]}
{"wire":[2715,0,2714,106]}
{"wire":[2723,198,2600,0]}
{"wire":[2723,223,2508,0]}
{"wire":[2723,207,2507,0]}
{"wire":[2724,198,2600,0]}
{"wire":[2724,223,2508,0]}
{"wire":[2724,207,2507,0]}
{"wire":[2619,3,2723,472]}
{"wire":[2619,17,2724,472]}
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
{"wire":[2672,80,2400,0]}
{"wire":[2672,106,2563,0]}
{"wire":[2672,107,2555,0]}
{"wire":[2354,0,2672,114]}
{"wire":[2354,3,2672,114]}
{"wire":[2354,5,2672,114]}
{"wire":[2354,2,2672,0]}
{"wire":[2354,15,2672,113]}
{"wire":[2354,16,2672,148]}
{"wire":[2354,17,2672,149]}
ASEEND*/
//CHKSM=2B2137E4F9D473405BB3EAA035A0A885484C3B80